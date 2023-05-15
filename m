Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D170355A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbjEOQ6K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243268AbjEOQ6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B837AB4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A8462A37
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4687CC433D2;
        Mon, 15 May 2023 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169880;
        bh=s8wDbjqh+HXmZvxIEdG4/svUmEnO0uOhDV/tXEsLJiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVk0El68KnPXHS8zSU7CiT1q+OEeNMZkLcJ31+Ju/BSgNHuoGUBN50A2WSyd6PJRe
         3KkI41TsLooVmwAXW9e/Z1W4HCCld3ZBEaX15w86k025Fc5hQoeJ0AzvVusHkPnzvG
         5OBYGob7d+as0XqzvEleFouMSA8EuwFc30YuV9CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.3 183/246] f2fs: fix potential corruption when moving a directory
Date:   Mon, 15 May 2023 18:26:35 +0200
Message-Id: <20230515161728.116198116@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit d94772154e524b329a168678836745d2773a6e02 upstream.

F2FS has the same issue in ext4_rename causing crash revealed by
xfstests/generic/707.

See also commit 0813299c586b ("ext4: Fix possible corruption when moving a directory")

CC: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/namei.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -995,12 +995,20 @@ static int f2fs_rename(struct mnt_idmap
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1108,6 +1116,9 @@ static int f2fs_rename(struct mnt_idmap
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1122,6 +1133,9 @@ out_dir:
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	iput(whiteout);
 	return err;


