Return-Path: <stable+bounces-9061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE39820A0E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC654283142
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D017C2;
	Sun, 31 Dec 2023 07:15:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEF184C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204a16df055so3740904fac.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006918; x=1704611718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWrv+9PKpHBMMftbbUwAwdcHQDoLHm4RmJ9mv8Ng7Xs=;
        b=tCTaUgZw0D+rp7NEhax314u3I/UH1QAZ87bTLkCKzzuaK2cnsfotdmFBQzeKyGCAXU
         DlCMTJK9Dx44S4v3mXXNEjBUeApLBmzNpL6fxA6bZdUv+E/K663m6X5zW5mBKp7nrmQ2
         hZhEMmoj/7HcYEDpwHKqlO0etvHUrchRE625ljABs1DqSdJbKVFQT+jn3ogtI1BihHUP
         kLb8vwj5usbf1rYW9XCS4DJUsSP1harVzof537uxTBkunlDKQvJEr88yLoK2mjowvv56
         tPSGNrYYftH9/cI1Ao/MFDSxa6+0WPNSDJRgtSAgN6iX7mUlJh3m0CYWwodFSrtlu6J/
         OCHQ==
X-Gm-Message-State: AOJu0YzpWJfvJRjttPpCwng11o2f0AXvAn02CVM2p6U3hlVocE46l/8M
	RgiG8VRFjQS+maZ2ip4lBKg=
X-Google-Smtp-Source: AGHT+IEiHSOzfgrN66oZqLe7R4aUAH2UiJhqzHhj/MIbkEHArmA2k3M+eHgWasfP9j1te9s/f5TIcA==
X-Received: by 2002:a05:6870:9a1e:b0:203:daf3:ecc with SMTP id fo30-20020a0568709a1e00b00203daf30eccmr19115824oab.60.1704006918461;
        Sat, 30 Dec 2023 23:15:18 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Lu Hongfei <luhongfei@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 27/73] ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void
Date: Sun, 31 Dec 2023 16:12:46 +0900
Message-Id: <20231231071332.31724-28-linkinjeon@kernel.org>
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

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit ccb5889af97c03c67a83fcd649602034578c0d61 ]

The return value of ksmbd_vfs_query_maximal_access is meaningless,
it is better to modify it to void.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 4 +---
 fs/smb/server/vfs.c     | 6 +-----
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f35e06ae25b3..e8d2c6fc3f37 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2891,11 +2891,9 @@ int smb2_open(struct ksmbd_work *work)
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
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d0a85774a496..178bcd4d0b20 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -122,11 +122,9 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
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
@@ -143,8 +141,6 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 
 	if (!inode_permission(user_ns, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
-
-	return ret;
 }
 
 /**
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 0a4eb1e1a79a..3e3c92d22e3e 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -72,7 +72,7 @@ struct ksmbd_kstat {
 };
 
 int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+void ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
-- 
2.25.1


