Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D46FA422
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjEHJzp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHJzo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59E2ABE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6121A62236
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512A0C433EF;
        Mon,  8 May 2023 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539741;
        bh=RT7JMNLVIVZFoyk9MkqvppZ5D3T+QHCHLlgkN2MaAuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e519y8eObazYYWe6h6dTmXihkYynp46QKZ34ZclM6/LbkcHc56lsdBeHt20mCKjKB
         bLkotVdVgKZtOn9aERPRhCbLlRzTutGsIZyXMZeastksW2u7l/+ULPHSSOI8R/jiaP
         tiQs/3KK3UOW0qAAqY0Wdmggw3F56UAt1X+Yu9/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6.1 105/611] ubifs: Fix memory leak in do_rename
Date:   Mon,  8 May 2023 11:39:07 +0200
Message-Id: <20230508094425.660421548@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Mårten Lindahl <marten.lindahl@axis.com>

commit 3a36d20e012903f45714df2731261fdefac900cb upstream.

If renaming a file in an encrypted directory, function
fscrypt_setup_filename allocates memory for a file name. This name is
never used, and before returning to the caller the memory for it is not
freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'rename' that renames a
file in an encrypted directory:

  unreferenced object 0xffff888101502840 (size 32):
    comm "rename", pid 9404, jiffies 4302582475 (age 435.735s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      do_rename
      ubifs_rename
      vfs_rename
      do_renameat2

To fix this we can remove the call to fscrypt_setup_filename as it's not
needed.

Fixes: 278d9a243635f26 ("ubifs: Rename whiteout atomically")
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ubifs/dir.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -358,7 +358,6 @@ static struct inode *create_whiteout(str
 	umode_t mode = S_IFCHR | WHITEOUT_MODE;
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct fscrypt_name nm;
 
 	/*
 	 * Create an inode('nlink = 1') for whiteout without updating journal,
@@ -369,10 +368,6 @@ static struct inode *create_whiteout(str
 	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
 		dentry, mode, dir->i_ino);
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
-	if (err)
-		return ERR_PTR(err);
-
 	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -395,7 +390,6 @@ out_inode:
 	make_bad_inode(inode);
 	iput(inode);
 out_free:
-	fscrypt_free_filename(&nm);
 	ubifs_err(c, "cannot create whiteout file, error %d", err);
 	return ERR_PTR(err);
 }


