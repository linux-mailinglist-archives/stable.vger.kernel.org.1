Return-Path: <stable+bounces-7736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB23F817609
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94664281504
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0D7408D;
	Mon, 18 Dec 2023 15:41:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FC768F3
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b7a0d1665so518400a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914064; x=1703518864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUEnopKgI3883+cYbuqQ5WpKOvGtGGsZrbyir8YQZgo=;
        b=Aah0yLI5v5YC9N8Rp/2SFrVsRRyFcaoHo7OTwIW50t1f6fxlfY+nxjWEHuvXaog0bX
         vyLi3SKvsN9dpMJQXXu+mCuyr6oidyEKYnKyY3H1+Dd28i/Rx0nTljeRL7T/4ppw8KvA
         uvU7059fLhjPMOl6kNooRib0fqTOUFEemahPdCdtgclHSTwVmgp1IP9npNDM+Hl42PtE
         YC9I30djchcO0AeJVNWiosuuEx185qHrQE1WVbt2ifUGD8N1ZSNO0esZKAH89I9nuVFU
         uXnmgwEsvSg8y3Xkt131Amn0eFXKIhShuJ0/ASI2IR/9LkZM+IdKHEQNukyZ6NP8HBTW
         ohQg==
X-Gm-Message-State: AOJu0YzZpEQ/NlGIicO1iSSIxuJsv8Clk61rjs8eVhZ3DtPhgvmML1Uh
	+xufBKgbS55dstMwhrMJOUo=
X-Google-Smtp-Source: AGHT+IHFLqo+dslz7/gMgOugAa2F7uNSVFSuE5EGOeBm1juKvTFzVhrwzPh1W8bvmgukgygVltfKrg==
X-Received: by 2002:a17:90a:982:b0:28b:4cc4:307a with SMTP id 2-20020a17090a098200b0028b4cc4307amr881723pjo.73.1702914064388;
        Mon, 18 Dec 2023 07:41:04 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:03 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Lu Hongfei <luhongfei@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 107/154] ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void
Date: Tue, 19 Dec 2023 00:34:07 +0900
Message-Id: <20231218153454.8090-108-linkinjeon@kernel.org>
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

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit ccb5889af97c03c67a83fcd649602034578c0d61 ]

The return value of ksmbd_vfs_query_maximal_access is meaningless,
it is better to modify it to void.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 4 +---
 fs/ksmbd/vfs.c     | 6 +-----
 fs/ksmbd/vfs.h     | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d6c9092ff230..f31cc130f2c5 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2877,11 +2877,9 @@ int smb2_open(struct ksmbd_work *work)
 		if (!file_present) {
 			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
 		} else {
-			rc = ksmbd_vfs_query_maximal_access(user_ns,
+			ksmbd_vfs_query_maximal_access(user_ns,
 							    path.dentry,
 							    &daccess);
-			if (rc)
-				goto err_out;
 			already_permitted = true;
 		}
 		maximal_access = daccess;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 7d239d3f8dbd..540c14741194 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -121,11 +121,9 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	return -ENOENT;
 }
 
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+void ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -142,8 +140,6 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 
 	if (!inode_permission(user_ns, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
-
-	return ret;
 }
 
 /**
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index adaf511dace1..2e87136f9eba 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -111,7 +111,7 @@ struct ksmbd_kstat {
 };
 
 int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+void ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
-- 
2.25.1


