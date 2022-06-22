
{{- define "imagePullSecret" }}
    {{ if eq .Values.license.installationType "SELF_HOSTED" }}
    {{- $imagePullSecret := .Values.registry.imagePullSecret | required ".Values.registry.imagePullSecret is required, please refer to your installation credentials in the console." -}}

    {{- printf "{\"auths\": {\"%s\": {\"username\": \"_json_key_base64\",\"password\": \"%s\",\"email\":\"%s\", \"auth\": \"%s\"}}}" .Values.registry.url $imagePullSecret ($imagePullSecret | b64dec | fromJson).client_email ((printf "_json_key_base64:%s" $imagePullSecret) | b64enc) | b64enc}}
    {{ end }}
{{- end }}

{{- define "bootstrapServers" }}
    {{- printf "%s.%s:%d" .Values.kafka.fullnameOverride .Values.namespace (.Values.kafka.service.ports.client | int) }}'
{{- end }}

{{ define "installationEnvironmentVariables" }}
            - name: STRM_INSTALLATION_TYPE
              value: {{.Values.license.installationType}}
            - name: STRM_API_HOST
              value: {{.Values.api.host}}
            - name: STRM_API_PORT
              value: "{{.Values.api.port }}"
            - name: STRM_AUTH_URL
              value: {{ .Values.api.authUrl }}
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
            # TODO probably not needed. Investigate and check deployments
            - name: STRM_INSTALLATION_ID
              valueFrom:
                secretKeyRef:
                  name: installation-credentials
                  key: STRM_INSTALLATION_ID
                  optional: false
{{ end }}

{{ define "selfHostedEnvironmentVariables" }}
            - name: STRM_IMAGE_PULL_SECRET_NAME
              value: "strmprivacy-docker-registry"
{{ end }}


