
{{- define "imagePullSecret" }}
    {{ if eq .Values.license.installationType "SELF_HOSTED" }}
    {{- $imagePullSecret := .Values.registry.imagePullSecret | required ".Values.registry.imagePullSecret is required, please refer to your installation credentials in the console." -}}
    {{- printf "{\"auths\": {\"%s\": {\"username\": \"_json_key_base64\",\"password\": \"%s\",\"email\":\"%s\", \"auth\": \"%s\"}}}" .Values.registry.url $imagePullSecret ($imagePullSecret | b64dec | fromJson).client_email ((printf "_json_key_base64:%s" $imagePullSecret) | b64enc) | b64enc}}
    {{ end }}
{{- end }}

{{- define "bootstrapServers" }}
    {{- printf "%s.%s:%d" .Values.kafka.fullnameOverride .Values.namespace (.Values.kafka.service.ports.client | int) }}'
{{- end }}

{{ define "kafkaSecurityEnvironmentVars" }}
            {{ if .Values.kafkaSecurityConfig.enabled }}
            - name: STRM_KAFKASEC_PROTOCOL
              value: {{ .Values.kafkaSecurityConfig.securityProtocol }}
            - name: STRM_KAFKASEC_TRUSTSTORE
              value: /var/truststore/client.truststore.jks
            - name: STRM_KAFKASEC_TRUSTSTORE_PW
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.kafkaSecurityConfig.sslTruststoreSecretName }}
                  key: truststore.password
            {{ end }}
{{ end }}

{{ define "installationEnvironmentVariables" }}
            # from template installationEnvironmentVariables
            - name: STRM_DEFAULT_SERVICE_ACCOUNT
              value: {{ .Values.serviceAccount }}
            - name: STRM_INSTALLATION_TYPE
              value: {{.Values.license.installationType}}
            - name: STRM_API_HOST
              value: {{.Values.api.host}}
            - name: STRM_API_PORT
              value: "{{.Values.api.port }}"
            - name: STRM_AUTH_URL
              value: "https://{{ .Values.api.authHost }}"
            - name: STRM_AUTH_CLIENT_ID
              valueFrom:
                secretKeyRef:
                  name: installation-credentials
                  key: STRM_AUTH_CLIENT_ID
                  optional: false
            - name: STRM_AUTH_CREDENTIALS_SECRET_NAME
              value: installation-credentials
            - name: STRM_AUTH_CLIENT_ID_KUBERNETES_SECRET_KEY
              value: STRM_AUTH_CLIENT_ID
            - name: STRM_AUTH_CLIENT_SECRET_KUBERNETES_SECRET_KEY
              value: STRM_AUTH_CLIENT_SECRET
            - name: STRM_AUTH_CLIENT_SECRET
              valueFrom:
                secretKeyRef:
                  name: installation-credentials
                  key: STRM_AUTH_CLIENT_SECRET
                  optional: false
            - name: STRM_INSTALLATION_ID
              valueFrom:
                secretKeyRef:
                  name: installation-credentials
                  key: STRM_INSTALLATION_ID
                  optional: false
{{ end }}

{{ define "selfHostedEnvironmentVariables" }}
            # from template selfHostedEnvironmentVariables
            - name: STRM_IMAGE_PULL_SECRET_NAME
              value: "strmprivacy-docker-registry"
{{ end }}

{{ define "kafkaAuthData" }}
  # from template kafkaAuthData
  "kafka.user": {{ .user | default "" | b64enc | quote }}
  "kafka.password": {{ .password | default "" | b64enc | quote }}
{{ end }}

{{ define "kafkaCredentialsEnvironmentVars" }}

            # from template kafkaCredentialsEnvironmentVars
            {{ if .component.configuration.kafkaAuth.password }}

            - name: STRM_KAFKASEC_USERNAME
              valueFrom:
                secretKeyRef:
                  name: {{ .component.name }}
                  key: kafka.user
            - name: STRM_KAFKASEC_PW
              valueFrom:
                secretKeyRef:
                  name: {{ .component.name }}
                  key: kafka.password
            {{ end }}
{{ end }}


{{ define "clientTruststoreVolume" }}
        {{ if .Values.kafkaSecurityConfig.enabled }}
        # from template client-truststore-volume
        - name: client-truststore
          secret:
            secretName: {{ .Values.kafkaSecurityConfig.sslTruststoreSecretName }}
            optional: false
        {{ end }}
{{ end }}

{{ define "clientTruststoreVolumeMount" }}
        {{ if .Values.kafkaSecurityConfig.enabled }}
            # from template client-truststore-volume-mount
            - mountPath: /var/truststore
              name: client-truststore
        {{ end }}
{{ end }}



{{ define "image" -}}
    {{ if eq .values.license.installationType "SELF_HOSTED" }}
    {{- printf "%s/%s/%s/%s:%s" .values.registry.url .values.registry.base.prefix .values.registry.base.path .component.image.name .component.image.version | quote }}
    {{ else if eq .values.license.installationType "AWS_MARKETPLACE" }}
    {{- printf "%s/%s:%s" .values.registry.awsMarketplaceUrl (regexReplaceAll ".+/(.+)$" .component.image.name "${1}") .component.image.version | quote }}
    {{ else if eq .values.license.installationType "AWS_MARKETPLACE_PAYG" }}
    {{- printf "%s/%s:%s" .values.registry.awsMarketplaceUrl (regexReplaceAll ".+/(.+)$" .component.image.name "${1}-payg") .component.image.version | quote }}
    {{ end }}
{{ end }}

{{- define "kafkaBootstrap" -}}
{{ $kafka := .Values.kafka}}
{{- $kafka.bootstrapServers |
          default (printf "%s.%s:%s" $kafka.fullnameOverride .Values.namespace $kafka.port) }}
{{end}}
