Return-Path: <stable+bounces-7681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB518175C3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749A0283DBD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CC5A84C;
	Mon, 18 Dec 2023 15:38:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2E5A87F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so2359356a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913892; x=1703518692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr0ABGSSbO6X5fyw/UOs6B/+XSDdwt91CsipgHlt5BY=;
        b=f3nBnXkt6c8WF6HAmnjReJjb+AZjiUS+TCS/fjYLBEY4cstW/kNzH64GWwbb27ta8G
         i0wapg/NSq58/d4OurEprgtIH3YNrt7usv4dq82UiWkFK+/1gxdMup9SKsNeSEa7z6JU
         6EvZzFmt0HkzqCnzHJbHfXLAy8Mg4+LJr0BJ9aTmBQ71Kw32TzEASoTVsMFH+mV4uXil
         /UBInbxE67v0HNSRjB71RJ5J6rEnrP8m5a+7i2a7sgbrbZ0350Q7QxBFHuJD40h5Wt11
         p4sKQNWOJO1NItH6rcTrmSemlUsYErEwJCy92WcftjXbu+MAeP6JeAxnPll7XcV/ivWH
         KyUA==
X-Gm-Message-State: AOJu0YxEASTnIordNQ70FoeL9N5PzvRfp8VIA1p1xldqMbdA2SSilcXa
	dKhuydVO4rJOfAtCqigOPcE=
X-Google-Smtp-Source: AGHT+IEC+MrkU9TYxq0ck+Del+Nxa5lGngVLFKH++lQpUPYQJnSI1i1ccuH9VELX51NAyGurtoQa2w==
X-Received: by 2002:a17:90a:470e:b0:28b:a508:d260 with SMTP id h14-20020a17090a470e00b0028ba508d260mr480745pjg.90.1702913892508;
        Mon, 18 Dec 2023 07:38:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 052/154] ksmbd: casefold utf-8 share names and fix ascii lowercase conversion
Date: Tue, 19 Dec 2023 00:33:12 +0900
Message-Id: <20231218153454.8090-53-linkinjeon@kernel.org>
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

[ Upstream commit 16b5f54e30c1ddec36bdf946a299b3254aace477 ]

strtolower() corrupts all UTF-8 share names that have a byte in the C0
(À ISO8859-1) to DE (Þ ISO8859-1) range, since the non-ASCII part of
ISO8859-1 is incompatible with UTF-8. Prevent this by checking that a
byte is in the ASCII range with isascii(), before the conversion to
lowercase with tolower(). Properly handle case-insensitivity of UTF-8
share names by casefolding them, but fallback to ASCII lowercase
conversion on failure or if CONFIG_UNICODE is not set. Refactor to move
the share name casefolding immediately after the share name extraction.
Also, make the associated constness corrections.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c        |  8 +++++++
 fs/ksmbd/connection.h        |  1 +
 fs/ksmbd/mgmt/share_config.c | 18 ++++-----------
 fs/ksmbd/mgmt/share_config.h |  2 +-
 fs/ksmbd/mgmt/tree_connect.c |  2 +-
 fs/ksmbd/mgmt/tree_connect.h |  2 +-
 fs/ksmbd/misc.c              | 44 +++++++++++++++++++++++++++++-------
 fs/ksmbd/misc.h              |  2 +-
 fs/ksmbd/smb2pdu.c           |  2 +-
 fs/ksmbd/unicode.h           |  3 ++-
 10 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index be1f8ffa4a78..14326323da79 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -60,6 +60,12 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
+	if (IS_ENABLED(CONFIG_UNICODE))
+		conn->um = utf8_load("12.1.0");
+	else
+		conn->um = ERR_PTR(-EOPNOTSUPP);
+	if (IS_ERR(conn->um))
+		conn->um = NULL;
 	atomic_set(&conn->req_running, 0);
 	atomic_set(&conn->r_count, 0);
 	conn->total_credits = 1;
@@ -361,6 +367,8 @@ int ksmbd_conn_handler_loop(void *p)
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
 
+	if (IS_ENABLED(CONFIG_UNICODE))
+		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
 	if (default_conn_ops.terminate_fn)
 		default_conn_ops.terminate_fn(conn);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index a8c367c481e8..8c99fdbd701f 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -46,6 +46,7 @@ struct ksmbd_conn {
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
+	struct unicode_map		*um;
 	struct list_head		conns_list;
 	/* smb session 1 per user */
 	struct xarray			sessions;
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index c9bca1c2c834..5d039704c23c 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -26,7 +26,7 @@ struct ksmbd_veto_pattern {
 	struct list_head	list;
 };
 
-static unsigned int share_name_hash(char *name)
+static unsigned int share_name_hash(const char *name)
 {
 	return jhash(name, strlen(name), 0);
 }
@@ -72,7 +72,7 @@ __get_share_config(struct ksmbd_share_config *share)
 	return share;
 }
 
-static struct ksmbd_share_config *__share_lookup(char *name)
+static struct ksmbd_share_config *__share_lookup(const char *name)
 {
 	struct ksmbd_share_config *share;
 	unsigned int key = share_name_hash(name);
@@ -119,7 +119,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	return 0;
 }
 
-static struct ksmbd_share_config *share_config_request(char *name)
+static struct ksmbd_share_config *share_config_request(const char *name)
 {
 	struct ksmbd_share_config_response *resp;
 	struct ksmbd_share_config *share = NULL;
@@ -190,20 +190,10 @@ static struct ksmbd_share_config *share_config_request(char *name)
 	return share;
 }
 
-static void strtolower(char *share_name)
-{
-	while (*share_name) {
-		*share_name = tolower(*share_name);
-		share_name++;
-	}
-}
-
-struct ksmbd_share_config *ksmbd_share_config_get(char *name)
+struct ksmbd_share_config *ksmbd_share_config_get(const char *name)
 {
 	struct ksmbd_share_config *share;
 
-	strtolower(name);
-
 	down_read(&shares_table_lock);
 	share = __share_lookup(name);
 	if (share)
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 902f2cb1963a..7f7e89ecfe61 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -74,7 +74,7 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 	__ksmbd_share_config_put(share);
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(char *name);
+struct ksmbd_share_config *ksmbd_share_config_get(const char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
 #endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index 97ab7987df6e..867c0286b901 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -17,7 +17,7 @@
 
 struct ksmbd_tree_conn_status
 ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			char *share_name)
+			const char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 71e50271dccf..0f97ddc1e39c 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -42,7 +42,7 @@ struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
 ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			char *share_name);
+			const char *share_name);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn);
diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 364a0a463dfc..28459b1efaa8 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/xattr.h>
 #include <linux/fs.h>
+#include <linux/unicode.h>
 
 #include "misc.h"
 #include "smb_common.h"
@@ -226,26 +227,53 @@ void ksmbd_conv_path_to_windows(char *path)
 	strreplace(path, '/', '\\');
 }
 
+static char *casefold_sharename(struct unicode_map *um, const char *name)
+{
+	char *cf_name;
+	int cf_len;
+
+	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, GFP_KERNEL);
+	if (!cf_name)
+		return ERR_PTR(-ENOMEM);
+
+	if (IS_ENABLED(CONFIG_UNICODE) && um) {
+		const struct qstr q_name = {.name = name, .len = strlen(name)};
+
+		cf_len = utf8_casefold(um, &q_name, cf_name,
+				       KSMBD_REQ_MAX_SHARE_NAME);
+		if (cf_len < 0)
+			goto out_ascii;
+
+		return cf_name;
+	}
+
+out_ascii:
+	cf_len = strscpy(cf_name, name, KSMBD_REQ_MAX_SHARE_NAME);
+	if (cf_len < 0) {
+		kfree(cf_name);
+		return ERR_PTR(-E2BIG);
+	}
+
+	for (; *cf_name; ++cf_name)
+		*cf_name = isascii(*cf_name) ? tolower(*cf_name) : *cf_name;
+	return cf_name - cf_len;
+}
+
 /**
  * ksmbd_extract_sharename() - get share name from tree connect request
  * @treename:	buffer containing tree name and share name
  *
  * Return:      share name on success, otherwise error
  */
-char *ksmbd_extract_sharename(char *treename)
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename)
 {
-	char *name = treename;
-	char *dst;
-	char *pos = strrchr(name, '\\');
+	const char *name = treename, *pos = strrchr(name, '\\');
 
 	if (pos)
 		name = (pos + 1);
 
 	/* caller has to free the memory */
-	dst = kstrdup(name, GFP_KERNEL);
-	if (!dst)
-		return ERR_PTR(-ENOMEM);
-	return dst;
+	return casefold_sharename(um, name);
 }
 
 /**
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index 5a0ae2f8e5e7..cc72f4e6baf2 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -20,7 +20,7 @@ int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
 void ksmbd_conv_path_to_windows(char *path);
-char *ksmbd_extract_sharename(char *treename);
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name);
 
 #define KSMBD_DIR_INFO_ALIGNMENT	8
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4a68cf9624f7..9aad3d7e0c95 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1924,7 +1924,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		goto out_err1;
 	}
 
-	name = ksmbd_extract_sharename(treename);
+	name = ksmbd_extract_sharename(conn->um, treename);
 	if (IS_ERR(name)) {
 		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
 		goto out_err1;
diff --git a/fs/ksmbd/unicode.h b/fs/ksmbd/unicode.h
index 5593024230ae..076f6034a789 100644
--- a/fs/ksmbd/unicode.h
+++ b/fs/ksmbd/unicode.h
@@ -24,6 +24,7 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/nls.h>
+#include <linux/unicode.h>
 
 #define  UNIUPR_NOLOWER		/* Example to not expand lower case tables */
 
@@ -69,7 +70,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 			     const struct nls_table *codepage);
 int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 		      const struct nls_table *cp, int mapchars);
-char *ksmbd_extract_sharename(char *treename);
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 #endif
 
 /*
-- 
2.25.1


