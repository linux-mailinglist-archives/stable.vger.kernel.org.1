Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FFA75D330
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGUTH6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGUTHz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C730F2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F17D61D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80188C433C7;
        Fri, 21 Jul 2023 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966470;
        bh=/gVGOLfFzmPMPO42Oa+oNIqgeoENlI8KRGqmiVKk4Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZ0wvHWYqWqDuP3EsMGxKpOERtBhlqpS6uXn/RDq1bscngTy2dHct6qg7GZbXrjUz
         wWaVwCSCHc0jrnwD5hy3T4sptFnxpMDeBn+5RDxjR2VhG9/lw7PqloUU8FbcPEKwyi
         p4jiW/uT1WO6SDTwWeZQqTXMw9byRStrbPePAQfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 356/532] shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs
Date:   Fri, 21 Jul 2023 18:04:20 +0200
Message-ID: <20230721160633.778387831@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 36ce9d76b0a93bae799e27e4f5ac35478c676592 upstream.

As the ramfs-based tmpfs uses ramfs_init_fs_context() for the
init_fs_context method, which allocates fc->s_fs_info, use ramfs_kill_sb()
to free it and avoid a memory leak.

Link: https://lkml.kernel.org/r/20230607161523.2876433-1-roberto.sassu@huaweicloud.com
Fixes: c3b1b1cbf002 ("ramfs: add support for "mode=" mount option")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ramfs/inode.c      |    2 +-
 include/linux/ramfs.h |    1 +
 mm/shmem.c            |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -274,7 +274,7 @@ int ramfs_init_fs_context(struct fs_cont
 	return 0;
 }
 
-static void ramfs_kill_sb(struct super_block *sb)
+void ramfs_kill_sb(struct super_block *sb)
 {
 	kfree(sb->s_fs_info);
 	kill_litter_super(sb);
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -7,6 +7,7 @@
 struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
 	 umode_t mode, dev_t dev);
 extern int ramfs_init_fs_context(struct fs_context *fc);
+extern void ramfs_kill_sb(struct super_block *sb);
 
 #ifdef CONFIG_MMU
 static inline int
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4043,7 +4043,7 @@ static struct file_system_type shmem_fs_
 	.name		= "tmpfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= ramfs_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 


