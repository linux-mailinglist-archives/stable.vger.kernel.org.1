Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED072B87D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjFLHPf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFLHPf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 03:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C65170C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 00:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD57161FA2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FF3C433D2;
        Mon, 12 Jun 2023 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686551540;
        bh=oaflcXifRJbEWSCU4dCs2Oh2Amzi4hx466w1SbOX5ZM=;
        h=Subject:To:Cc:From:Date:From;
        b=peDrleK3bm4Uv8f+HXELIWZG11BHI8z4w809RED5tEwpAZecVtAdGRA5YHAUBNUhN
         xOd5H25JVR/7bKVnIYIp5V+iYErvUgJUUHuoBh+RbImd18GjIyx2++1nKa59M1UQ1a
         Pav6SBCG9jlM3SOOHz7pApRY7PgagmI5h/+4VYI0=
Subject: FAILED: patch "[PATCH] ksmbd: fix posix_acls and acls dereferencing possible" failed to apply to 6.1-stable tree
To:     linkinjeon@kernel.org, dan.carpenter@linaro.org,
        stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 08:32:17 +0200
Message-ID: <2023061217-serve-hummus-0f0a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 25933573ef48f3586f559c2cac6c436c62dcf63f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061217-serve-hummus-0f0a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25933573ef48f3586f559c2cac6c436c62dcf63f Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 May 2023 21:42:34 +0900
Subject: [PATCH] ksmbd: fix posix_acls and acls dereferencing possible
 ERR_PTR()

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

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 6d6cfb6957a9..0a5862a61c77 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1290,7 +1290,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1314,7 +1314,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 6f302919e9f7..f9fb778247e7 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1321,7 +1321,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 		return NULL;
 
 	posix_acls = get_inode_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1830,7 +1830,7 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 		return -EOPNOTSUPP;
 
 	acls = get_inode_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 

