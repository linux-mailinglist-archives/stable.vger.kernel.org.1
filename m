Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235F72C24A
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjFLLEC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjFLLDg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED77EFD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B8C962537
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFF9C433A7;
        Mon, 12 Jun 2023 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567101;
        bh=UqgUigKOYHVyGe3NFBp8dYa/cj4+2b6e2/aKasUccf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwjSbPPphsKCpg00vXQIXsBJYUTJ2kjYW6zCyDcweNoJm2X1lCWEgrN831O8jSVOA
         vfCE7gGKbuRd1J6lnVrSYFkN3VVJ+3XmstmD8EtLqVBdKysUDG1thuHffkVtDrQR9z
         21yQpMH5cPHTbD872Lpw41thfqy9p+bTNzDyJmTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 151/160] ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
Date:   Mon, 12 Jun 2023 12:28:03 +0200
Message-ID: <20230612101721.986150790@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 25933573ef48f3586f559c2cac6c436c62dcf63f upstream.

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
@@ -1290,7 +1290,7 @@ int smb_check_perm_dacl(struct ksmbd_con
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1314,7 +1314,7 @@ int smb_check_perm_dacl(struct ksmbd_con
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1377,7 +1377,7 @@ static struct xattr_smb_acl *ksmbd_vfs_m
 		return NULL;
 
 	posix_acls = get_inode_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1886,7 +1886,7 @@ int ksmbd_vfs_inherit_posix_acl(struct m
 		return -EOPNOTSUPP;
 
 	acls = get_inode_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 


