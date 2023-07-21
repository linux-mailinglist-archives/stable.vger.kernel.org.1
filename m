Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D775D382
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGUTLd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGUTLb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDC1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC1361D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D348C433C7;
        Fri, 21 Jul 2023 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966688;
        bh=D8i/whZ5X/wkgA4MGyokuJcTESgqLsMZp3/RsLy1WeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bz5ZQ6cO4KXhwqL3mF6OMfjTEMHhEA+wCoIOWT6i8TcAckkeOW+UErlPx/O5GuCXp
         tE+5RugeHY9SIIaBMGucwhJSIrYwuZJ7ZdOlq1uQNtRzcl8j2mxUw7yLb6w/p8YYHt
         1sAERw62JpOmQRiiThAaToX1+YsgzKKn7jO0iJfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 432/532] erofs: decouple basic mount options from fs_context
Date:   Fri, 21 Jul 2023 18:05:36 +0200
Message-ID: <20230721160638.001440419@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit e62424651f43cb37e17ca26a7ee9ee42675f24bd ]

Previously, EROFS mount options are all in the basic types, so
erofs_fs_context can be directly copied with assignment. However,
when the multiple device feature is introduced, it's hard to handle
multiple device information like the other basic mount options.

Let's separate basic mount option usage from fs_context, thus
multiple device information can be handled gracefully then.

No logic changes.

Link: https://lore.kernel.org/r/20211007070224.12833-1-hsiangkao@linux.alibaba.com
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: 18bddc5b6703 ("erofs: fix fsdax unavailability for chunk-based regular files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/inode.c    |  2 +-
 fs/erofs/internal.h | 16 ++++++++-----
 fs/erofs/super.c    | 58 ++++++++++++++++++++++-----------------------
 fs/erofs/xattr.c    |  4 ++--
 fs/erofs/zdata.c    |  8 +++----
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0c293ff6697b5..3ff36514cff25 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -192,7 +192,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
-	if (test_opt(&sbi->ctx, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
 	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
 		inode->i_flags |= S_DAX;
 	if (!nblks)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index beadb06d8feb9..323e46d800e9e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
-struct erofs_fs_context {
+struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
@@ -60,6 +60,10 @@ struct erofs_fs_context {
 	unsigned int mount_opt;
 };
 
+struct erofs_fs_context {
+	struct erofs_mount_opts opt;
+};
+
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
@@ -69,6 +73,8 @@ struct erofs_sb_lz4_info {
 };
 
 struct erofs_sb_info {
+	struct erofs_mount_opts opt;	/* options */
+
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
@@ -108,8 +114,6 @@ struct erofs_sb_info {
 	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
-
-	struct erofs_fs_context ctx;	/* options */
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -121,9 +125,9 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 
-#define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
-#define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
-#define test_opt(ctx, option)	((ctx)->mount_opt & EROFS_MOUNT_##option)
+#define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
+#define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
+#define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11b88559f8bfa..25f6b8b37f287 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -340,15 +340,15 @@ static int erofs_read_superblock(struct super_block *sb)
 static void erofs_default_options(struct erofs_fs_context *ctx)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->max_sync_decompress_pages = 3;
-	ctx->readahead_sync_decompress = false;
+	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	ctx->opt.max_sync_decompress_pages = 3;
+	ctx->opt.readahead_sync_decompress = false;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(ctx, XATTR_USER);
+	set_opt(&ctx->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(ctx, POSIX_ACL);
+	set_opt(&ctx->opt, POSIX_ACL);
 #endif
 }
 
@@ -392,12 +392,12 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		set_opt(ctx, DAX_ALWAYS);
-		clear_opt(ctx, DAX_NEVER);
+		set_opt(&ctx->opt, DAX_ALWAYS);
+		clear_opt(&ctx->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(ctx, DAX_NEVER);
-		clear_opt(ctx, DAX_ALWAYS);
+		set_opt(&ctx->opt, DAX_NEVER);
+		clear_opt(&ctx->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -424,9 +424,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(ctx, XATTR_USER);
+			set_opt(&ctx->opt, XATTR_USER);
 		else
-			clear_opt(ctx, XATTR_USER);
+			clear_opt(&ctx->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -434,16 +434,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(ctx, POSIX_ACL);
+			set_opt(&ctx->opt, POSIX_ACL);
 		else
-			clear_opt(ctx, POSIX_ACL);
+			clear_opt(&ctx->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->cache_strategy = result.uint_32;
+		ctx->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -540,15 +540,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
+	sbi->opt = ctx->opt;
 	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
-	if (test_opt(ctx, DAX_ALWAYS) &&
+	if (test_opt(&sbi->opt, DAX_ALWAYS) &&
 	    !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev))) {
 		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
-		clear_opt(ctx, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -557,13 +558,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &erofs_sops;
 	sb->s_xattr = erofs_xattr_handlers;
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&sbi->opt, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
-
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
 #endif
@@ -607,12 +606,12 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&ctx->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
+	sbi->opt = ctx->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -640,7 +639,6 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	erofs_default_options(fc->fs_private);
 
 	fc->ops = &erofs_context_ops;
-
 	return 0;
 }
 
@@ -763,31 +761,31 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
-	struct erofs_fs_context *ctx = &sbi->ctx;
+	struct erofs_mount_opts *opt = &sbi->opt;
 
 #ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(ctx, XATTR_USER))
+	if (test_opt(opt, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
 	else
 		seq_puts(seq, ",nouser_xattr");
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(opt, POSIX_ACL))
 		seq_puts(seq, ",acl");
 	else
 		seq_puts(seq, ",noacl");
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP
-	if (ctx->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
+	if (opt->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
 		seq_puts(seq, ",cache_strategy=disabled");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
 		seq_puts(seq, ",cache_strategy=readahead");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
 		seq_puts(seq, ",cache_strategy=readaround");
 #endif
-	if (test_opt(ctx, DAX_ALWAYS))
+	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
-	if (test_opt(ctx, DAX_NEVER))
+	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
 	return 0;
 }
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 778f2c52295d1..01c581e93c5f8 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -429,7 +429,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
-	return test_opt(&EROFS_SB(dentry->d_sb)->ctx, XATTR_USER);
+	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
 }
 
 static bool erofs_xattr_trusted_list(struct dentry *dentry)
@@ -476,7 +476,7 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 
 	switch (handler->flags) {
 	case EROFS_XATTR_INDEX_USER:
-		if (!test_opt(&sbi->ctx, XATTR_USER))
+		if (!test_opt(&sbi->opt, XATTR_USER))
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3fd91a0efdbb7..c247b1bf57cc8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -695,7 +695,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
+	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
 		cache_strategy = TRYALLOC;
 	else
 		cache_strategy = DONTALLOC;
@@ -797,7 +797,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->ctx.readahead_sync_decompress = true;
+		sbi->opt.readahead_sync_decompress = true;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1412,8 +1412,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (sbi->ctx.readahead_sync_decompress &&
-			nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->opt.readahead_sync_decompress &&
+			nr_pages <= sbi->opt.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.39.2



