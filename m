Return-Path: <stable+bounces-188307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A5BF500A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A68DF4E4198
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD127AC5C;
	Tue, 21 Oct 2025 07:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51F246762
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032418; cv=none; b=cacGRHYu9cC9TunvVEUClOb0z1Yufwgz/XHTVj/gk6TKmsBotn3CvDZ1PPdI7yGwNvjYafd1Pnc1X2QGO0dJh8YLOH5utN2tD7gHK5jnDvB5QlNOY63/5PoEdD56ux3ltKGePgaenPlLv4YnNjrxkOXQsv+HaFIfdqHmOYNUZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032418; c=relaxed/simple;
	bh=4CqdtsGolTOXynx0CAAkhBQzrRYUZch7cZf1KLo2AXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J2L0/G7eu28Bz7Bu6V0tjjosHh3dPeMXd1r9I3S9B5WrCbzMvFbG/LJnhEVnrojgORLvg2uR/GWbPdx32kyRqKzDXPzIa1TNahOVAqFDnCoL1vw9Y6XqXPLmxpAW3n8dUhcpFWJ1YRsAeKTalVAAOoADv5ZItJNxp/0el/a7X1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3841006b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032416; x=1761637216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dL/ay0QyEyKrbv2ev24Tw9dpU9iNwDDU0FqszZAymDo=;
        b=AQFJMh+1Om/gHfjgOjeK6l+KmxZ2K563uZPJTPlmjyfk06/sNU3cpshVuoqiD4Czxh
         JPdj4pXeEEc9J2CGxij4774D427xtt6O2A36HQCzrmSDJDcQq9EYMp7WrbyV++ueNNaD
         uoHLbCux+gOIoyZNKD9WQZ+hbljvdnrQI9fL6lRVHVVegAYzGJonHNrFXkWxAHKggmDe
         qnEb0YQTivV3cvz4nBtMagkcU7Je3c/TEIXiQR3IXvXov1KuK0O0bMcQtftXgP+abOdu
         iqSNFiN3v3XNxuJClN2aeTTM72pghww1L4VUqRAVp3jkyiq3KQd4XUSBFH9nrKcOV8oN
         Iblw==
X-Forwarded-Encrypted: i=1; AJvYcCVC5JUsOEtvDHSWA7GJuDKjYOdv6ow4SkjL79EzJ1GsglLCFHz6zVYmv2FXQS3PJm/2tKnj9TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlkM+nSjVwHzQLPpWWpI/Co6q6r/ghjqph1KpnDcJivwDGTZ9
	fwav1QhIt2LqFDipH1U9Zf5BvRXAhWjidvq98uF3nELadN2yTYNMwdGF
X-Gm-Gg: ASbGncso6efRWQFpZ+z6IA3qFVFBgkbaiX9HcOOH18+Wb4TB/AtF94nVPpFhK8xUNFD
	fLP/zQblBDuT5MnJyqhuKiNHygSSrH2kqp7WQTrZAY+WL6FiPK2cDvqDD1AoW0822gNLs2HrKD6
	PfzSdiHqfJsKuWSngJ/FCgMtLfAPbbZ0QfFNyhPw1nBAL94H7kmwQ5Dm7L3Qg4znpKmMywuNUIy
	XvgXghRTjwWPuSbYQBkvcol4mQYD+5TOZ+rXn8sQ9wsNsIz9NvLjkX6zftleqZDQXxV2Jh01yUd
	sv1ZxmmiykqOGolTydgdXZ0IhfhirK05Y4LVdzQc1fRWgwaNfeNVKmrCLZUqXBjT+ALXmAaByd9
	Qkb4dwejR7LV1d+3/ibPwzs+U4Mck4foK23rByoD8rlpBYgy7BtB+e7wsEw/lC3aOFeQM/TyAAp
	Mkg6XwDNegCU65Ug==
X-Google-Smtp-Source: AGHT+IHszGIYUr7rCuOajYHN+WFBZi04vrjVhRcUxId+ui8ibhbhlS1ajjYUliHjiPq3ThbLPgmV+A==
X-Received: by 2002:a05:6a20:9144:b0:334:7e45:e6b1 with SMTP id adf61e73a8af0-334a8546501mr21453049637.14.1761032416483;
        Tue, 21 Oct 2025 00:40:16 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39437sm10336311b3a.27.2025.10.21.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:40:15 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: hauke@hauke-m.de,
	smfrench@gmail.com,
	stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y] ksmbd: browse interfaces list on FSCTL_QUERY_INTERFACE_INFO IOCTL
Date: Tue, 21 Oct 2025 16:40:03 +0900
Message-Id: <20251021074004.6656-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit b2d99376c5d61eb60ffdb6c503e4b6c8f9712ddd ]

ksmbd.mount will give each interfaces list and bind_interfaces_only flags
to ksmbd server. Previously, the interfaces list was sent only
when bind_interfaces_only was enabled.
ksmbd server browse only interfaces list given from ksmbd.conf on
FSCTL_QUERY_INTERFACE_INFO IOCTL.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_netlink.h |  3 +-
 fs/smb/server/server.h        |  1 +
 fs/smb/server/smb2pdu.c       |  4 ++
 fs/smb/server/transport_ipc.c |  1 +
 fs/smb/server/transport_tcp.c | 69 ++++++++++++++++-------------------
 fs/smb/server/transport_tcp.h |  1 +
 6 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index c6c1844d4448..363501fc308a 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -108,8 +108,9 @@ struct ksmbd_startup_request {
 	__u32	smb2_max_credits;	/* MAX credits */
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
+	__s8	bind_interfaces_only;
 	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
-	__u32	reserved[125];		/* Reserved room */
+	__s8	reserved[499];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
 } __packed;
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index d0744498ceed..48bd203abb44 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -46,6 +46,7 @@ struct ksmbd_server_config {
 	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+	bool			bind_interfaces_only;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 93c31feab356..9a58c5a6f986 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -38,6 +38,7 @@
 #include "mgmt/user_session.h"
 #include "mgmt/ksmbd_ida.h"
 #include "ndr.h"
+#include "transport_tcp.h"
 
 static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 {
@@ -7790,6 +7791,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
 
+		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
+			continue;
+
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 80581a7bc1bc..354f7144c590 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -327,6 +327,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
+	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
 out:
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index c43a46511428..665d21d40e7a 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -551,30 +551,37 @@ static int create_socket(struct interface *iface)
 	return ret;
 }
 
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name)
+{
+	struct interface *iface;
+
+	list_for_each_entry(iface, &iface_list, entry)
+		if (!strcmp(iface->name, netdev_name))
+			return iface;
+	return NULL;
+}
+
 static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 			      void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct interface *iface;
-	int ret, found = 0;
+	int ret;
 
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name)) {
-				found = 1;
-				if (iface->state != IFACE_STATE_DOWN)
-					break;
-				ret = create_socket(iface);
-				if (ret)
-					return NOTIFY_OK;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_DOWN) {
+			ksmbd_debug(CONN, "netdev-up event: netdev(%s) is going up\n",
+					iface->name);
+			ret = create_socket(iface);
+			if (ret)
+				return NOTIFY_OK;
 		}
-		if (!found && bind_additional_ifaces) {
+		if (!iface && bind_additional_ifaces) {
 			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
 			if (!iface)
 				return NOTIFY_OK;
@@ -584,19 +591,19 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 		}
 		break;
 	case NETDEV_DOWN:
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name) &&
-			    iface->state == IFACE_STATE_CONFIGURED) {
-				tcp_stop_kthread(iface->ksmbd_kthread);
-				iface->ksmbd_kthread = NULL;
-				mutex_lock(&iface->sock_release_lock);
-				tcp_destroy_socket(iface->ksmbd_socket);
-				iface->ksmbd_socket = NULL;
-				mutex_unlock(&iface->sock_release_lock);
-
-				iface->state = IFACE_STATE_DOWN;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_CONFIGURED) {
+			ksmbd_debug(CONN, "netdev-down event: netdev(%s) is going down\n",
+					iface->name);
+			tcp_stop_kthread(iface->ksmbd_kthread);
+			iface->ksmbd_kthread = NULL;
+			mutex_lock(&iface->sock_release_lock);
+			tcp_destroy_socket(iface->ksmbd_socket);
+			iface->ksmbd_socket = NULL;
+			mutex_unlock(&iface->sock_release_lock);
+
+			iface->state = IFACE_STATE_DOWN;
+			break;
 		}
 		break;
 	}
@@ -665,18 +672,6 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 	int sz = 0;
 
 	if (!ifc_list_sz) {
-		struct net_device *netdev;
-
-		rtnl_lock();
-		for_each_netdev(&init_net, netdev) {
-			if (netif_is_bridge_port(netdev))
-				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
-				rtnl_unlock();
-				return -ENOMEM;
-			}
-		}
-		rtnl_unlock();
 		bind_additional_ifaces = 1;
 		return 0;
 	}
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index 5925ec5df475..bf6a3d71f7a0 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -8,6 +8,7 @@
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
 void ksmbd_free_transport(struct ksmbd_transport *kt);
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
-- 
2.25.1


