Return-Path: <stable+bounces-45476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC288CA822
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D23828295D
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7023FB88;
	Tue, 21 May 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XNoa+Nm6"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B395C12C;
	Tue, 21 May 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274248; cv=none; b=lijCCAbOLWTADfSvTUf/IjXTGPyocgZZjuuBGHcFLncJhMUA0bjv3reaavD2vORmGipOTI/MrTVRAneiB3iFIgJM6aSRH+VKqCzW6uweBVzSi/npcnkhdhu5yv6rL7pTIPQNTznLrfOFN1TDUHUV9nme4gP76Fa7rQV0kbHkjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274248; c=relaxed/simple;
	bh=+RS2tlJV9NIHwypsYhu5gNmqYQ7JRn/rDl765S731HM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRLY1ncxvwOia/LZ0HWo+xqfTzLxEA3EsXk/cUISVjC+s0Z36VuytwSFzCQQKBPNpFcfBp4SO1DjJJYds2vdUNE/dXGAnmX3C6OY3gOSedVpCLWmRyLd4CTiB1HYSfTGlRHc2w2o9NmzCJ17SUcoGeguNK1Hn9YkOChzVxdkvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XNoa+Nm6; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716274239; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bcLcSpygRskX8FbZ85z5VIkgvrvkWEO0qut+0yi1ja8=;
	b=XNoa+Nm6E4pOfZ+yFu+hXn8m5d9df6CDeIjIa7ln0cMEoDl85EStmgNEZm/mDlw76QN9Fg00LMm/W9SMcCRi6xz9Ka4FXJrSF7jGqyLJo23j2KnVLf32BCEYKdZ2QSi7M48KDQ8oONbXrXkqFKf4u2a17c3eEb8XqgW9huu41J0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W6wiTe1_1716274234;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6wiTe1_1716274234)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 14:50:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Baokun Li <libaokun1@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.8.y 1/2] erofs: get rid of erofs_fs_context
Date: Tue, 21 May 2024 14:50:31 +0800
Message-Id: <20240521065032.4192363-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

commit 07abe43a28b2c660f726d66f5470f7f114f9643a upstream.

Instead of allocating the erofs_sb_info in fill_super() allocate it during
erofs_init_fs_context() and ensure that erofs can always have the info
available during erofs_kill_sb(). After this erofs_fs_context is no longer
needed, replace ctx with sbi, no functional changes.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240419123611.947084-2-libaokun1@huawei.com
[ Gao Xiang: trivial conflict due to a warning message. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 116 ++++++++++++++++++++------------------------
 2 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 410f5af62354..c69174675caf 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -84,13 +84,6 @@ struct erofs_dev_context {
 	bool flatdev;
 };
 
-struct erofs_fs_context {
-	struct erofs_mount_opts opt;
-	struct erofs_dev_context *devs;
-	char *fsid;
-	char *domain_id;
-};
-
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 24788c230b49..8d7a3abb9c1b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -370,18 +370,18 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-static void erofs_default_options(struct erofs_fs_context *ctx)
+static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
+	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	sbi->opt.max_sync_decompress_pages = 3;
+	sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(&ctx->opt, XATTR_USER);
+	set_opt(&sbi->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(&ctx->opt, POSIX_ACL);
+	set_opt(&sbi->opt, POSIX_ACL);
 #endif
 }
 
@@ -426,17 +426,17 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
 #ifdef CONFIG_FS_DAX
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		set_opt(&ctx->opt, DAX_ALWAYS);
-		clear_opt(&ctx->opt, DAX_NEVER);
+		set_opt(&sbi->opt, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(&ctx->opt, DAX_NEVER);
-		clear_opt(&ctx->opt, DAX_ALWAYS);
+		set_opt(&sbi->opt, DAX_NEVER);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -451,7 +451,7 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
 	struct erofs_device_info *dif;
 	int opt, ret;
@@ -464,9 +464,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(&ctx->opt, XATTR_USER);
+			set_opt(&sbi->opt, XATTR_USER);
 		else
-			clear_opt(&ctx->opt, XATTR_USER);
+			clear_opt(&sbi->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -474,16 +474,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(&ctx->opt, POSIX_ACL);
+			set_opt(&sbi->opt, POSIX_ACL);
 		else
-			clear_opt(&ctx->opt, POSIX_ACL);
+			clear_opt(&sbi->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->opt.cache_strategy = result.uint_32;
+		sbi->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -505,27 +505,27 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			kfree(dif);
 			return -ENOMEM;
 		}
-		down_write(&ctx->devs->rwsem);
-		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
-		up_write(&ctx->devs->rwsem);
+		down_write(&sbi->devs->rwsem);
+		ret = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+		up_write(&sbi->devs->rwsem);
 		if (ret < 0) {
 			kfree(dif->path);
 			kfree(dif);
 			return ret;
 		}
-		++ctx->devs->extra_devices;
+		++sbi->devs->extra_devices;
 		break;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	case Opt_fsid:
-		kfree(ctx->fsid);
-		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->fsid)
+		kfree(sbi->fsid);
+		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
 	case Opt_domain_id:
-		kfree(ctx->domain_id);
-		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->domain_id)
+		kfree(sbi->domain_id);
+		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->domain_id)
 			return -ENOMEM;
 		break;
 #else
@@ -582,8 +582,7 @@ static const struct export_operations erofs_export_ops = {
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct erofs_sb_info *sbi;
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
@@ -591,19 +590,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &erofs_sops;
 
-	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
-
-	sb->s_fs_info = sbi;
-	sbi->opt = ctx->opt;
-	sbi->devs = ctx->devs;
-	ctx->devs = NULL;
-	sbi->fsid = ctx->fsid;
-	ctx->fsid = NULL;
-	sbi->domain_id = ctx->domain_id;
-	ctx->domain_id = NULL;
-
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
 		sb->s_blocksize = PAGE_SIZE;
@@ -707,9 +693,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -719,19 +705,19 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *new_sbi = fc->s_fs_info;
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (ctx->fsid || ctx->domain_id)
+	if (new_sbi->fsid || new_sbi->domain_id)
 		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
 
-	if (test_opt(&ctx->opt, POSIX_ACL))
+	if (test_opt(&new_sbi->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->opt = ctx->opt;
+	sbi->opt = new_sbi->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -762,12 +748,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 
 static void erofs_fc_free(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (!sbi)
+		return;
 
-	erofs_free_dev_context(ctx->devs);
-	kfree(ctx->fsid);
-	kfree(ctx->domain_id);
-	kfree(ctx);
+	erofs_free_dev_context(sbi->devs);
+	kfree(sbi->fsid);
+	kfree(sbi->domain_id);
+	kfree(sbi);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -779,21 +768,22 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx;
+	struct erofs_sb_info *sbi;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
 		return -ENOMEM;
-	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
-	if (!ctx->devs) {
-		kfree(ctx);
+
+	sbi->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
+	if (!sbi->devs) {
+		kfree(sbi);
 		return -ENOMEM;
 	}
-	fc->fs_private = ctx;
+	fc->s_fs_info = sbi;
 
-	idr_init(&ctx->devs->tree);
-	init_rwsem(&ctx->devs->rwsem);
-	erofs_default_options(ctx);
+	idr_init(&sbi->devs->tree);
+	init_rwsem(&sbi->devs->rwsem);
+	erofs_default_options(sbi);
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
-- 
2.39.3


