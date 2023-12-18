Return-Path: <stable+bounces-7690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558748175CC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042AD283AE0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34F5BFA2;
	Mon, 18 Dec 2023 15:38:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262F5BF9B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c699b44dddso965937a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913919; x=1703518719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IVD+FeJ6zobL/o/1zIP7WOvxOjR5nqj8W0i+ASLS2w=;
        b=r9eRodK9h+n42VZrQdBNUftt66gnp+TysqHoHO1OiOZBWGa7ZXq6RUlWtTcOWyY5sW
         79CRovKjH0PhgZLxsbg93wLoeuygusaxObJ9DfZORo/+EXxUoIscS2HvhpeicimlT9Ps
         68ceZEhWGbPfrbY3Qy/4towiGbKsVTAeV+0CCql5jGXnQh6NLYWoU02ZUfZorHT9NnNs
         I8kJV1bjAq+2ZAMOkTaoP6QwVY5Do1dDPdnv7TytU6e3eyUe51MkS4Axe8zLJhShBAL/
         qEUh1tl6xbf1DyvHPRvXP/1l4ZE6MA1Uv/7h6S9etJPYXN8JA0nJ2d46stY300lvyAUi
         Lj3Q==
X-Gm-Message-State: AOJu0YySpHpZWogbQJyfIf1Dfmvrdh/oX2j+XdT4qATWqYqTgLONk79C
	w4zk/RAo1eSwTZczAE5kve8=
X-Google-Smtp-Source: AGHT+IE1Wmh7BZMqtitJLrsCU8Vj7osYDJFFNJ1N9Xjnu38B5hgP6w++lc+BZPn7taLtBAYzIymFRQ==
X-Received: by 2002:a17:90a:51e2:b0:286:a27a:f244 with SMTP id u89-20020a17090a51e200b00286a27af244mr6605161pjh.22.1702913919323;
        Mon, 18 Dec 2023 07:38:39 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:38 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 061/154] ksmbd: make utf-8 file name comparison work in __caseless_lookup()
Date: Tue, 19 Dec 2023 00:33:21 +0900
Message-Id: <20231218153454.8090-62-linkinjeon@kernel.org>
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

[ Upstream commit dbab80e2071ad8c702e50dab43326608a127d27b ]

Case-insensitive file name lookups with __caseless_lookup() use
strncasecmp() for file name comparison. strncasecmp() assumes an
ISO8859-1-compatible encoding, which is not the case here as UTF-8
is always used. As such, use of strncasecmp() here produces correct
results only if both strings use characters in the ASCII range only.
Fix this by using utf8_strncasecmp() if CONFIG_UNICODE is set. On
failure or if CONFIG_UNICODE is not set, fallback to strncasecmp().
Also, as we are adding an include for `linux/unicode.h', include it
in `fs/ksmbd/connection.h' as well since it should be explicit there.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.h |  1 +
 fs/ksmbd/vfs.c        | 20 +++++++++++++++++---
 fs/ksmbd/vfs.h        |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 8c99fdbd701f..0e3a848defaf 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -14,6 +14,7 @@
 #include <net/request_sock.h>
 #include <linux/kthread.h>
 #include <linux/nls.h>
+#include <linux/unicode.h>
 
 #include "smb_common.h"
 #include "ksmbd_work.h"
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 284aa87f3e5c..d7814397764c 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1144,12 +1144,23 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
 			     unsigned int d_type)
 {
 	struct ksmbd_readdir_data *buf;
+	int cmp = -EINVAL;
 
 	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
 
 	if (buf->used != namlen)
 		return 0;
-	if (!strncasecmp((char *)buf->private, name, namlen)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && buf->um) {
+		const struct qstr q_buf = {.name = buf->private,
+					   .len = buf->used};
+		const struct qstr q_name = {.name = name,
+					    .len = namlen};
+
+		cmp = utf8_strncasecmp(buf->um, &q_buf, &q_name);
+	}
+	if (cmp < 0)
+		cmp = strncasecmp((char *)buf->private, name, namlen);
+	if (!cmp) {
 		memcpy((char *)buf->private, name, namlen);
 		buf->dirent_count = 1;
 		return -EEXIST;
@@ -1165,7 +1176,8 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
  *
  * Return:	0 on success, otherwise error
  */
-static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t namelen)
+static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
+				   size_t namelen, struct unicode_map *um)
 {
 	int ret;
 	struct file *dfilp;
@@ -1175,6 +1187,7 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t na
 		.private	= name,
 		.used		= namelen,
 		.dirent_count	= 0,
+		.um		= um,
 	};
 
 	dfilp = dentry_open(dir, flags, current_cred());
@@ -1237,7 +1250,8 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 				break;
 
 			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
-						      filename_len);
+						      filename_len,
+						      work->conn->um);
 			path_put(&parent);
 			if (err)
 				goto out;
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 7dd054f86850..1f0cbd520f12 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -12,6 +12,7 @@
 #include <linux/namei.h>
 #include <uapi/linux/xattr.h>
 #include <linux/posix_acl.h>
+#include <linux/unicode.h>
 
 #include "smbacl.h"
 #include "xattr.h"
@@ -99,6 +100,7 @@ struct ksmbd_readdir_data {
 	unsigned int		used;
 	unsigned int		dirent_count;
 	unsigned int		file_attr;
+	struct unicode_map	*um;
 };
 
 /* ksmbd kstat wrapper to get valid create time when reading dir entry */
-- 
2.25.1


