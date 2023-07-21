Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883475D47D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjGUTVo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGUTVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A42733
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADCA61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C422C433C8;
        Fri, 21 Jul 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967301;
        bh=Me+Lw4RWDsxDNQpA3eUNwL0Rz9p5c8R47szDbs2ilv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0M5DOd0gbL93F0EKc5spjzyTtL/GAVWO2TUzNlz7Ff+A8jISh8kSb/uL8oA1R792
         42t+2snz+ZYkiwxjS9XAIwo7msTORnc+92Zl18DTsoVPAPbfbXE6OiaHP7nQck2EcC
         PpxyXfWYHrpMTvmOxfsMP72qag3MT2fyBWP1JhxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.1 076/223] f2fs: fix deadlock in i_xattr_sem and inode page lock
Date:   Fri, 21 Jul 2023 18:05:29 +0200
Message-ID: <20230721160524.104265016@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 5eda1ad1aaffdfebdecf7a164e586060a210f74f upstream.

Thread #1:

[122554.641906][   T92]  f2fs_getxattr+0xd4/0x5fc
    -> waiting for f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);

[122554.641927][   T92]  __f2fs_get_acl+0x50/0x284
[122554.641948][   T92]  f2fs_init_acl+0x84/0x54c
[122554.641969][   T92]  f2fs_init_inode_metadata+0x460/0x5f0
[122554.641990][   T92]  f2fs_add_inline_entry+0x11c/0x350
    -> Locked dir->inode_page by f2fs_get_node_page()

[122554.642009][   T92]  f2fs_do_add_link+0x100/0x1e4
[122554.642025][   T92]  f2fs_create+0xf4/0x22c
[122554.642047][   T92]  vfs_create+0x130/0x1f4

Thread #2:

[123996.386358][   T92]  __get_node_page+0x8c/0x504
    -> waiting for dir->inode_page lock

[123996.386383][   T92]  read_all_xattrs+0x11c/0x1f4
[123996.386405][   T92]  __f2fs_setxattr+0xcc/0x528
[123996.386424][   T92]  f2fs_setxattr+0x158/0x1f4
    -> f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);

[123996.386443][   T92]  __f2fs_set_acl+0x328/0x430
[123996.386618][   T92]  f2fs_set_acl+0x38/0x50
[123996.386642][   T92]  posix_acl_chmod+0xc8/0x1c8
[123996.386669][   T92]  f2fs_setattr+0x5e0/0x6bc
[123996.386689][   T92]  notify_change+0x4d8/0x580
[123996.386717][   T92]  chmod_common+0xd8/0x184
[123996.386748][   T92]  do_fchmodat+0x60/0x124
[123996.386766][   T92]  __arm64_sys_fchmodat+0x28/0x3c

Cc: <stable@vger.kernel.org>
Fixes: 27161f13e3c3 "f2fs: avoid race in between read xattr & write xattr"
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/dir.c   |    9 ++++++++-
 fs/f2fs/xattr.c |    6 ++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -806,8 +806,15 @@ int f2fs_add_dentry(struct inode *dir, c
 {
 	int err = -EAGAIN;
 
-	if (f2fs_has_inline_dentry(dir))
+	if (f2fs_has_inline_dentry(dir)) {
+		/*
+		 * Should get i_xattr_sem to keep the lock order:
+		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
+		 */
+		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
 		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
+		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
+	}
 	if (err == -EAGAIN)
 		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
 
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -527,10 +527,12 @@ int f2fs_getxattr(struct inode *inode, i
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
 				&entry, &base_addr, &base_size, &is_inline);
-	f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
 


