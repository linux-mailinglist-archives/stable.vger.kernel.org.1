Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93AD754E01
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGPJMy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGPJMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC4B3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A65860959
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C80C433C8;
        Sun, 16 Jul 2023 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498770;
        bh=OReWBXKeOA25EyXRR0/u01fCTTe+J2Q5H9pNN01I07s=;
        h=Subject:To:Cc:From:Date:From;
        b=faqR8o7vO9tjfwJIMhV6R4xJMprXnYZg8RiL9TT0JhutptbqpsppmrRXKCOwcp3Pe
         vPfmVFA1ITF+A46hUwh5aFFU03FsWqIkttWd7QnDNxdQaDM6icQO0NaEAfSaW/ZR+K
         XI34zgQQs+xdkzj5T2JFYizUaKKfsqO34Bghq5iw=
Subject: FAILED: patch "[PATCH] shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based" failed to apply to 4.19-stable tree
To:     roberto.sassu@huawei.com, akpm@linux-foundation.org,
        dhowells@redhat.com, hughd@google.com, stable@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:12:39 +0200
Message-ID: <2023071639-deeply-cuddly-0824@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 36ce9d76b0a93bae799e27e4f5ac35478c676592
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071639-deeply-cuddly-0824@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

36ce9d76b0a9 ("shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs")
d7167b149943 ("fs_parse: fold fs_parameter_desc/fs_parameter_spec")
96cafb9ccb15 ("fs_parser: remove fs_parameter_description name field")
cc3c0b533ab9 ("add prefix to fs_context->log")
c80c98f0dc5d ("ceph_parse_param(), ceph_parse_mon_ips(): switch to passing fc_log")
7f5d38141e30 ("new primitive: __fs_parse()")
2c3f3dc31556 ("switch rbd and libceph to p_log-based primitives")
3fbb8d5554a1 ("struct p_log, variants of warnf() et.al. taking that one instead")
9f09f649ca33 ("teach logfc() to handle prefices, give it saner calling conventions")
5eede625297f ("fold struct fs_parameter_enum into struct constant_table")
2710c957a8ef ("fs_parse: get rid of ->enums")
0f89589a8c6f ("Pass consistent param->type to fs_parse()")
f2aedb713c28 ("NFS: Add fs_context support.")
e38bb238ed8c ("NFS: Convert mount option parsing to use functionality from fs_parser.h")
e558100fda7e ("NFS: Do some tidying of the parsing code")
48be8a66cf98 ("NFS: Add a small buffer in nfs_fs_context to avoid string dup")
cbd071b5daa0 ("NFS: Deindent nfs_fs_context_parse_option()")
f8ee01e3e2c8 ("NFS: Split nfs_parse_mount_options()")
5eb005caf538 ("NFS: Rename struct nfs_parsed_mount_data to struct nfs_fs_context")
e0a626b12474 ("NFS: Constify mount argument match tables")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36ce9d76b0a93bae799e27e4f5ac35478c676592 Mon Sep 17 00:00:00 2001
From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 7 Jun 2023 18:15:23 +0200
Subject: [PATCH] shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based
 tmpfs

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

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 5ba580c78835..fef477c78107 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -278,7 +278,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void ramfs_kill_sb(struct super_block *sb)
+void ramfs_kill_sb(struct super_block *sb)
 {
 	kfree(sb->s_fs_info);
 	kill_litter_super(sb);
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index 917528d102c4..d506dc63dd47 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -7,6 +7,7 @@
 struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
 	 umode_t mode, dev_t dev);
 extern int ramfs_init_fs_context(struct fs_context *fc);
+extern void ramfs_kill_sb(struct super_block *sb);
 
 #ifdef CONFIG_MMU
 static inline int
diff --git a/mm/shmem.c b/mm/shmem.c
index 5e54ab5f61f2..c606ab89693a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4199,7 +4199,7 @@ static struct file_system_type shmem_fs_type = {
 	.name		= "tmpfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= ramfs_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 

