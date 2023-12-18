Return-Path: <stable+bounces-7728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25C8175F8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98476281A87
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5297205B;
	Mon, 18 Dec 2023 15:40:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B49883
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2346525a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914041; x=1703518841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg7gZJGNq23ePCsrdU/XbaU0b84IQRjffYlpSy3tJWc=;
        b=JvobSm17HfxCu24fFIfCfaFXRuI/LzeMaqtrPLDOzkaQwG8cfA2k1obPAIbk+XD/3b
         KsyEjBgzlqsFwlkXzysuZcCCI3sIDizwKjJ2S4jfzz333e+uqwcVWQIncF1GteU8F0zG
         9wHG9O953JVHuwXDQQQPLlyLHCFk8HIUMAa+gdGHlZACRUEfu38eAPaph6swVSXuezMj
         L7tyenB76LCS2ypWxsG18fDDtIgJqLi8DI1dMNwatLSlssT+32dPjD1RfOmrqIZEuryw
         ObV0wgtCO6O68lDGbqRySfSFEUz0kwRF4gRDj9RuKdsWTTxtJyHgMhFfx/mokpAb9fBs
         /13A==
X-Gm-Message-State: AOJu0YzgfXrfdyU1+PQoeyuKrDVnnw48EBAGj9zgN9qDTrtWjvuA0wqB
	F0kxGP9DWFP5BV+YyPs6nd7UD/MNzmE=
X-Google-Smtp-Source: AGHT+IHwvKDKGNC8qj58weq4wL+a+A7eQIAWVFwEuyq/KhskRW5N8elnQriQpGJkOgxcjZgtuPelQg==
X-Received: by 2002:a17:90a:db96:b0:28b:9ece:36c0 with SMTP id h22-20020a17090adb9600b0028b9ece36c0mr660659pjv.59.1702914041548;
        Mon, 18 Dec 2023 07:40:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 100/154] ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
Date: Tue, 19 Dec 2023 00:34:00 +0900
Message-Id: <20231218153454.8090-101-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 25933573ef48f3586f559c2cac6c436c62dcf63f ]

Dan reported the following error message:

fs/smb/server/smbacl.c:1296 smb_check_perm_dacl()
    error: 'posix_acls' dereferencing possible ERR_PTR()
fs/smb/server/vfs.c:1323 ksmbd_vfs_make_xattr_posix_acl()
    error: 'posix_acls' dereferencing possible ERR_PTR()
fs/smb/server/vfs.c:1830 ksmbd_vfs_inherit_posix_acl()
    error: 'acls' dereferencing possible ERR_PTR()

__get_acl() returns a mix of error pointers and NULL. This change it
with IS_ERR_OR_NULL().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smbacl.c | 4 ++--
 fs/ksmbd/vfs.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 253e8133520a..34db75af8c62 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1311,7 +1311,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1335,7 +1335,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index a48d53c4587c..97e723956fe8 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1323,7 +1323,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 		return NULL;
 
 	posix_acls = get_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1831,7 +1831,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		return -EOPNOTSUPP;
 
 	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 
-- 
2.25.1


