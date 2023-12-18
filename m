Return-Path: <stable+bounces-7692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02B68175CE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C091C24E1C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5845BF84;
	Mon, 18 Dec 2023 15:38:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6495BF87
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3110200a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913925; x=1703518725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09bPPLh6aQaOO6VHpdstRDB3C3njnuphX18BUXPVTW8=;
        b=kQ3zmTJkRZxA7dqxxJsEfoqIR5UJNsaGxDxUAi8+4qrqDauPbwjLZnp+4dPCyFahFl
         MBoPTmNKPYJ3PkcgG2P1AuWj44J3QVtDieOE6pUxw4v2cyrpHWpYy5BEMaelXx3W7qSj
         h1B19Qk4cjYXyxBBd2izMOOUfYoxoQGUbuTMKXFWHAA+GfqgGBS3xdYLz1g3kjIcuR3A
         fqXlFn98VIO4OQc2Pjl1v5/L6ERuYPuMFEm3Hrn8a+ZLCw0R7hHkYKI6XdIX2yyYCGJ+
         t7bJttOL0cxYvyHtZv9W9dwzOZ6H9FFZwGAVYcwF5vFgycXTPTxWq/M/vz6LMWRaI0rB
         rXdg==
X-Gm-Message-State: AOJu0YwS2N/xEnVkwxcXuIvQfYnWaDac/duQAOI6uy6ZEX0j51EBIFp6
	x9swkGoxrmXN9uWIQiixj9I=
X-Google-Smtp-Source: AGHT+IEtZtZeZrgL2+B9lr/hr/ioV7Xe2LMsNKoJiXRA66RZlqVt7LVsyToMJVdb5KcAm5vY0Rfy5Q==
X-Received: by 2002:a17:90a:6bc1:b0:28b:664a:807d with SMTP id w59-20020a17090a6bc100b0028b664a807dmr3942732pjj.25.1702913925449;
        Mon, 18 Dec 2023 07:38:45 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:45 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 063/154] ksmbd: validate share name from share config response
Date: Tue, 19 Dec 2023 00:33:23 +0900
Message-Id: <20231218153454.8090-64-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Atte Heikkilä <atteh.mailbox@gmail.com>

[ Upstream commit f5ba1cdaf5eb380e148183bda06d4844b457d095 ]

Share config response may contain the share name without casefolding as
it is known to the user space daemon. When it is present, casefold and
compare it to the share name the share config request was made with. If
they differ, we have a share config which is incompatible with the way
share config caching is done. This is the case when CONFIG_UNICODE is
not set, the share name contains non-ASCII characters, and those non-
ASCII characters do not match those in the share name known to user
space. In other words, when CONFIG_UNICODE is not set, UTF-8 share
names now work but are only case-insensitive in the ASCII range.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_netlink.h     |  3 ++-
 fs/ksmbd/mgmt/share_config.c | 22 +++++++++++++++++++---
 fs/ksmbd/mgmt/share_config.h |  4 +++-
 fs/ksmbd/mgmt/tree_connect.c |  4 ++--
 fs/ksmbd/misc.c              |  4 ++--
 fs/ksmbd/misc.h              |  1 +
 6 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index 17ad22808ee3..dd760c78af7b 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -164,7 +164,8 @@ struct ksmbd_share_config_response {
 	__u16	force_directory_mode;
 	__u16	force_uid;
 	__u16	force_gid;
-	__u32	reserved[128];		/* Reserved room */
+	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
+	__u32	reserved[112];		/* Reserved room */
 	__u32	veto_list_sz;
 	__s8	____payload[];
 };
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index 5d039704c23c..328a412259dc 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -16,6 +16,7 @@
 #include "user_config.h"
 #include "user_session.h"
 #include "../transport_ipc.h"
+#include "../misc.h"
 
 #define SHARE_HASH_BITS		3
 static DEFINE_HASHTABLE(shares_table, SHARE_HASH_BITS);
@@ -119,7 +120,8 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	return 0;
 }
 
-static struct ksmbd_share_config *share_config_request(const char *name)
+static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
+						       const char *name)
 {
 	struct ksmbd_share_config_response *resp;
 	struct ksmbd_share_config *share = NULL;
@@ -133,6 +135,19 @@ static struct ksmbd_share_config *share_config_request(const char *name)
 	if (resp->flags == KSMBD_SHARE_FLAG_INVALID)
 		goto out;
 
+	if (*resp->share_name) {
+		char *cf_resp_name;
+		bool equal;
+
+		cf_resp_name = ksmbd_casefold_sharename(um, resp->share_name);
+		if (IS_ERR(cf_resp_name))
+			goto out;
+		equal = !strcmp(cf_resp_name, name);
+		kfree(cf_resp_name);
+		if (!equal)
+			goto out;
+	}
+
 	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
 	if (!share)
 		goto out;
@@ -190,7 +205,8 @@ static struct ksmbd_share_config *share_config_request(const char *name)
 	return share;
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(const char *name)
+struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+						  const char *name)
 {
 	struct ksmbd_share_config *share;
 
@@ -202,7 +218,7 @@ struct ksmbd_share_config *ksmbd_share_config_get(const char *name)
 
 	if (share)
 		return share;
-	return share_config_request(name);
+	return share_config_request(um, name);
 }
 
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 7f7e89ecfe61..3fd338293942 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 #include <linux/hashtable.h>
 #include <linux/path.h>
+#include <linux/unicode.h>
 
 struct ksmbd_share_config {
 	char			*name;
@@ -74,7 +75,8 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 	__ksmbd_share_config_put(share);
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(const char *name);
+struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+						  const char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
 #endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index 867c0286b901..8ce17b3fb8da 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -26,7 +26,7 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	struct sockaddr *peer_addr;
 	int ret;
 
-	sc = ksmbd_share_config_get(share_name);
+	sc = ksmbd_share_config_get(conn->um, share_name);
 	if (!sc)
 		return status;
 
@@ -61,7 +61,7 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		struct ksmbd_share_config *new_sc;
 
 		ksmbd_share_config_del(sc);
-		new_sc = ksmbd_share_config_get(share_name);
+		new_sc = ksmbd_share_config_get(conn->um, share_name);
 		if (!new_sc) {
 			pr_err("Failed to update stale share config\n");
 			status.ret = -ESTALE;
diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 28459b1efaa8..9e8afaa686e3 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -227,7 +227,7 @@ void ksmbd_conv_path_to_windows(char *path)
 	strreplace(path, '/', '\\');
 }
 
-static char *casefold_sharename(struct unicode_map *um, const char *name)
+char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
 {
 	char *cf_name;
 	int cf_len;
@@ -273,7 +273,7 @@ char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename)
 		name = (pos + 1);
 
 	/* caller has to free the memory */
-	return casefold_sharename(um, name);
+	return ksmbd_casefold_sharename(um, name);
 }
 
 /**
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index cc72f4e6baf2..1facfcd21200 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -20,6 +20,7 @@ int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
 void ksmbd_conv_path_to_windows(char *path);
+char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name);
 char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name);
 
-- 
2.25.1


