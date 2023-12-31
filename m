Return-Path: <stable+bounces-9051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC1820A04
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC3F1F2200E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B117C3;
	Sun, 31 Dec 2023 07:14:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B617C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2053f5e97b2so286672fac.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006884; x=1704611684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGxqxudiEeXUS5B0KpVw2Ip9rGqR31POE/SP7iz6X4o=;
        b=aoaFMCoJaSZE71FhdP4Mh8fguK4gionSiihAirEANbpPwjwRBBXSD+TAo8FBaWJ0AZ
         y0PsSNU92tZr/eJgc+tkPRWdaN8AOBjLDbFfbnLKT+ZZ5TyObqE8w/CJPy/Bo0Uf2Bl5
         AzeGina/bo9YZxSCSifhtRTJogOwfrNk3dE/idhh1/C4eWjb5qZD6BDZvGHCjEaG4usw
         oJuSYuQsrv2wBiebEaliMkK5naLqoHWpThnyW9dxPVzAQO+4o0Mxz8lJ9YYFxKyqnuJg
         nxAwZH4CHtuaf3z9bmTRx9GICz7Eo4CIjiU+XVo9otJWXV3N0R/NVY36LSoCqXpwzvwg
         FRuA==
X-Gm-Message-State: AOJu0Yw7hscAdEOEnhZOf7xsNx4sbKoV7Rk386XAhd0pX4ZXwV/W3INM
	U3LwwfqlNcYpoP2HSGfR0gY=
X-Google-Smtp-Source: AGHT+IGAS/cTiLLfOe7RJCQBdwelTgb/380skDAYtJacFL3tRP7BGIzf2/J9g9vDBbPcuUW0zvRzmw==
X-Received: by 2002:a05:6870:468d:b0:1fa:e74a:c7ad with SMTP id a13-20020a056870468d00b001fae74ac7admr18293543oap.28.1704006883729;
        Sat, 30 Dec 2023 23:14:43 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:43 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.1.y 17/73] fs: introduce lock_rename_child() helper
Date: Sun, 31 Dec 2023 16:12:36 +0900
Message-Id: <20231231071332.31724-18-linkinjeon@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 9bc37e04823b5280dd0f22b6680fc23fe81ca325 ]

Pass the dentry of a source file and the dentry of a destination directory
to lock parent inodes for rename. As soon as this function returns,
->d_parent of the source file dentry is stable and inodes are properly
locked for calling vfs-rename. This helper is needed for ksmbd server.
rename request of SMB protocol has to rename an opened file, no matter
which directory it's in.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c            | 68 ++++++++++++++++++++++++++++++++++++-------
 include/linux/namei.h |  1 +
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5e1c2ab2ae70..6daaf8456719 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2980,20 +2980,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
-/*
- * p1 and p2 should be directories on the same fs.
- */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		return NULL;
-	}
-
-	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
-
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -3012,8 +3002,64 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
+
+/*
+ * p1 and p2 should be directories on the same fs.
+ */
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		return NULL;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+	return lock_two_directories(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
+/*
+ * c1 and p2 should be on the same fs.
+ */
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		/*
+		 * hopefully won't need to touch ->s_vfs_rename_mutex at all.
+		 */
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		/*
+		 * now that p2 is locked, nobody can move in or out of it,
+		 * so the test below is safe.
+		 */
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		/*
+		 * c1 got moved out of p2 while we'd been taking locks;
+		 * unlock and fall back to slow case.
+		 */
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	/*
+	 * nobody can move out of any directories on this fs.
+	 */
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
+	/*
+	 * c1 got moved into p2 while we were taking locks;
+	 * we need p2 locked and ->s_vfs_rename_mutex unlocked,
+	 * for consistency with lock_rename().
+	 */
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(lock_rename_child);
+
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 00fee52df842..2b66021c740d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,6 +81,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(const struct path *path);
-- 
2.25.1


