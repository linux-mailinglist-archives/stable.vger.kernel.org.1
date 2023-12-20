Return-Path: <stable+bounces-8127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BB81A4A9
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A83FB26FB2
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B548CFF;
	Wed, 20 Dec 2023 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Af1m6NzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533E482C2;
	Wed, 20 Dec 2023 16:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBA3C433C7;
	Wed, 20 Dec 2023 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088988;
	bh=0JbdnZINc4+R6tf8ZvZLpVtvneel5PnIxVYOSv2mzlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af1m6NzU+3ryTFBP0mJwKP7E1UHlq6pbDKefeJ4R9b9CSZwCLwL5Rfv2g3qKR31jN
	 7fEc7WsL9NvzPUeQ3rUdMyaDrfTywscIrEm8BTuVpToWJGl0bNhBRI2NpeblA1d0h6
	 oixPCMfYGkV3ucbEwokMvhFtmuoBiXbv/fWBIOoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 100/159] ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
Date: Wed, 20 Dec 2023 17:09:25 +0100
Message-ID: <20231220160936.021439240@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smbacl.c |    4 ++--
 fs/ksmbd/vfs.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1311,7 +1311,7 @@ int smb_check_perm_dacl(struct ksmbd_con
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1335,7 +1335,7 @@ int smb_check_perm_dacl(struct ksmbd_con
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1323,7 +1323,7 @@ static struct xattr_smb_acl *ksmbd_vfs_m
 		return NULL;
 
 	posix_acls = get_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1831,7 +1831,7 @@ int ksmbd_vfs_inherit_posix_acl(struct u
 		return -EOPNOTSUPP;
 
 	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 



