Return-Path: <stable+bounces-188308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D16DFBF500D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9120A4E583F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EDA27FB34;
	Tue, 21 Oct 2025 07:40:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520527AC5C
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032426; cv=none; b=SfxFvp+g9RXH/6HnRUsc9xh1OyVvyFgS2lLMUFMAiWynYWTJpgzjl+hAF+Ob3Qip+GoNkY3wUmmcFFvanda33hmVbqr/wv9FXMaRmGgtuHIFwcbnufim/c7oHhmABKc52h9uUuSoJlsAMHBOHch/AX0oWURYjAnvzZszrPV/cUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032426; c=relaxed/simple;
	bh=hDFLLUFIl7I8SmD3ylu2b+yIxSpOPkbQyD57i2coOSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXMj10KVd5XTnXjuH7LcyPJK5V3d2kqlwpNGV9iTu9hS+LDDIsJ+5CUA5/BprFyKj/VNWee30OrC+0Ij1YUMgpLabbzByBz5RVWdcPTXFChBnnoguQde3UflnXWCFu+FtdRCja2u0nvq1j2UvKj+ixaVP8bVsG2CSY2CYVwBBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f5d497692so6404035b3a.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032424; x=1761637224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMwdfVLCBVTGSseNpvdonvW48/JSjSZIcgV/ve0TF68=;
        b=VFIZwQnWbvTmpdPkmy3c+msy4wGtyI9JmIiWj6i+xB5Q0EFe2jOvhTCrQOLhkFZufs
         OK+04F4U+8X31GnMr7vauSu+ChnPChSZgxKJbsb5Lxvs5GYPmF3RAjLs0+oHNkNnb09O
         tSEEXBQ5HFi/pNTZ7ipFjg+ACSa6Ibq/tqHFoMW2B8jahNkuj2zWkcO+B4mXy3nWXOie
         ATF0Glp5Ym1YxaISg45esSzw514KgvKCS8+lZfOFTQjVXtP5T1nJRyxctuMBqKqyKWdw
         AVBEv6VvsoiNfNOGkDnxBF2e4IxmNZthndb51TvKJOD1j7v4eV1f5TnZ3oMobrJzt5Ub
         P7VA==
X-Forwarded-Encrypted: i=1; AJvYcCX25/Kq7C1NjuIFqclK1DGzPLuo9YBiZgbMAVXiyqSt3j/Y/8mN6xeJtLJM8Ev3cpp8Wvhv7UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6Ilh+7WFn7NNBIHwEskk4J/Ow71Ki+1/fxGRDclHEbThAitI
	rwgsRTZ/V0SaCHsqnsROEx20xXZollM49/Nq1pIg4Vf4GDxNexENnlid
X-Gm-Gg: ASbGncv/wIabLQ0XiS2fBRdQY+2dlaZf6slxL/kSIZiN262R6qSCGZ0SAPhZiKc5yiq
	57v2b/4bQe1bXNouus28tAglGE0nnO3cXd8iMiyjnF8MlJfDOMqx8RPaSFF8HcVNkTyT5C0VBpD
	8yk/837oay+VmMXa0aMOp+5vFJ3MnthfWoleBCGotJlKmXCOKYJi/y+OoX5ecW6mpaVmjNcGh0T
	NvzX/INTSM39ADNJw5Vi0c1Rmz3vE8iLyBKlFTVdN4c0KpUmNYHbiXvQd31RQUDOsV5IIM1T7BB
	cMaZJteVjkMbgUtNWdez4PSEXo4OZc5yKiQ0BbOwIJnOyqWlQ8eeKfA04bAR2+5i+sO4AlxLJOA
	VELtjMhp9aKvX9uVp4wSRRUOB7livlwAah3BlokLPdLslBZHVTPHx822b2bXBMOhjNu0JuDx8+a
	v8nA4EZBQyKsfcIg==
X-Google-Smtp-Source: AGHT+IFu5Uu2Dq8VOi1akxJAcj0j3VXE8ZoHgkwq0+xk0KZknTSzabHJNeYuc1mVOben2Hl1I1BbOA==
X-Received: by 2002:a05:6a00:3a05:b0:78f:6b8c:132 with SMTP id d2e1a72fcca58-7a220d22341mr19778799b3a.29.1761032423827;
        Tue, 21 Oct 2025 00:40:23 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39437sm10336311b3a.27.2025.10.21.00.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:40:23 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: hauke@hauke-m.de,
	smfrench@gmail.com,
	stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y] ksmbd: browse interfaces list on FSCTL_QUERY_INTERFACE_INFO IOCTL
Date: Tue, 21 Oct 2025 16:40:04 +0900
Message-Id: <20251021074004.6656-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021074004.6656-1-linkinjeon@kernel.org>
References: <20251021074004.6656-1-linkinjeon@kernel.org>
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
index d3c0b985eb8c..475de7289e22 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -107,8 +107,9 @@ struct ksmbd_startup_request {
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
index 2cb1b855a39e..3cdeda5d0c20 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -45,6 +45,7 @@ struct ksmbd_server_config {
 	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+	bool			bind_interfaces_only;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5cf14a910d5b..d2dca5d2f17c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -37,6 +37,7 @@
 #include "mgmt/user_session.h"
 #include "mgmt/ksmbd_ida.h"
 #include "ndr.h"
+#include "transport_tcp.h"
 
 static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 {
@@ -7423,6 +7424,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
 
+		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
+			continue;
+
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 3ca820d0b8d6..85837ba47d90 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -324,6 +324,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
+	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
 out:
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4ef032e737f3..f07b9e147fe2 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -544,30 +544,37 @@ static int create_socket(struct interface *iface)
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
@@ -577,19 +584,19 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
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
@@ -658,18 +665,6 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
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
index e338bebe322f..8c9aa624cfe3 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -7,6 +7,7 @@
 #define __KSMBD_TRANSPORT_TCP_H__
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
-- 
2.25.1


