Return-Path: <stable+bounces-9056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B4820A09
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DD51C208F1
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF117C3;
	Sun, 31 Dec 2023 07:15:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2F17F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbd38715f2so2226082b6e.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006900; x=1704611700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICF/ASfSZj2Yhq0RNUUZ0nPZb8GRvjtUlkfOeVzKdAc=;
        b=laUkJSuLMOIMdZqIDHIsU6eboqTikfQ3QQKJrRohIvACsWjNN4tnFGgSQ2SZvU/vjG
         p+cN2FIQiV+/hIPM6lXvVvgIS/4kz3Q4CX+Eb6ZNcnlGBZ2Vskb750KBn1KTWoOOUiDv
         kHeGYXzaSFb6bzccUTYOW8P3/0IhiBdRzrDQveJhUwT0QEytnJNwZ7S3ThhU5O/MeQhZ
         mPO3bhWVmtgFKSEyWja0c72nR53Vdwh+sJVEx7NGBj9RIOlGyApYXm0IlikS45SYVpc5
         XVUIW5xbn2u78ZWrvOEM9HuoQzPqb9GtArlzAMFc69MURiLXYnqlsaQfxyYE24jHBOK3
         xTPA==
X-Gm-Message-State: AOJu0YxDCon0x1eHsv8aL7bf0b7ywNnOMVJJCwIoS6NW4W3vhYi3Zinr
	VGx/3ECaWXjbBYLcTAaVGJw=
X-Google-Smtp-Source: AGHT+IGpFJO+Fro4oX/PbncRkYj4d+FPJn7dhk6ftTHR2B2oC1A2qXFqsmfvmS1ntEE8rlnhJGTiHg==
X-Received: by 2002:a05:6808:1a12:b0:3bb:c73d:1f84 with SMTP id bk18-20020a0568081a1200b003bbc73d1f84mr7667788oib.25.1704006900447;
        Sat, 30 Dec 2023 23:15:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 22/73] ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
Date: Sun, 31 Dec 2023 16:12:41 +0900
Message-Id: <20231231071332.31724-23-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/smbacl.c | 4 ++--
 fs/smb/server/vfs.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c24df86eb112..8c041e71cf15 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1313,7 +1313,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1337,7 +1337,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index ebcd5a312f10..6d171f2757f1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1322,7 +1322,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 		return NULL;
 
 	posix_acls = get_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1830,7 +1830,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		return -EOPNOTSUPP;
 
 	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 
-- 
2.25.1


