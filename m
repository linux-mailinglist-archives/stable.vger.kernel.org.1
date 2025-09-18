Return-Path: <stable+bounces-174954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF44B365CE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39D78A5CC8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0E2BE653;
	Tue, 26 Aug 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHfdAmSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC528314A;
	Tue, 26 Aug 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215755; cv=none; b=mYYb3xEdlKcgpdUSnJktAEk541tk+O6y2kumH9uC9fgZvDGSAGk5ZJagSYmdAslLLwBhb3nmRNidpKeDrrqA9vpMRLc5zd1V9YIVpcXYCNp23edRZL3ZUMmVuBcijWs7Kn3Bi4cRU0yzx3FoE73fzDdHfOSuRGQyzKWH6e5GMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215755; c=relaxed/simple;
	bh=fvQYAQoj1hGAxEcbKf6J6XQGRsW0XHDBvPY/wL2HwGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo5vYYYSXZj+Z4BFS+DPm3dZKmfjNSvT/Y0Q1WJW9SNg4PmLg4xbz97tn+GKtgy6phZib1B3lFN9gdGSlowY+smKolHdAcO3aSSfnptJC7iijbhqhpT1jrJRONZMpC2rq4TsywLo0F+py7jVueB5r/qEs7pl/2skWNnX0tFfG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHfdAmSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A608AC4CEF1;
	Tue, 26 Aug 2025 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215755;
	bh=fvQYAQoj1hGAxEcbKf6J6XQGRsW0XHDBvPY/wL2HwGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHfdAmSBu7yaOPjPxIX2y8yxFvAm13FJ/ogTaaaHVG5xo8tavcCYyz5W1ZupSNUDI
	 J7isBMRe3dBE7UZE7dcbUTYF9glO+En+6oZ6DCIjA4hMAqqc3mCYLLw/sAaUIkZobh
	 1dOEswWMhEa6pOjG8Mpi9fvZT8RxQVVt4dB5rmwc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/644] xen/gntdev: remove struct gntdev_copy_batch from stack
Date: Tue, 26 Aug 2025 13:04:04 +0200
Message-ID: <20250826110950.275789044@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 70045cf6593cbf0740956ea9b7b4269142c6ee38 ]

When compiling the kernel with LLVM, the following warning was issued:

  drivers/xen/gntdev.c:991: warning: stack frame size (1160) exceeds
  limit (1024) in function 'gntdev_ioctl'

The main reason is struct gntdev_copy_batch which is located on the
stack and has a size of nearly 1kb.

For performance reasons it shouldn't by just dynamically allocated
instead, so allocate a new instance when needed and instead of freeing
it put it into a list of free structs anchored in struct gntdev_priv.

Fixes: a4cdb556cae0 ("xen/gntdev: add ioctl for grant copy")
Reported-by: Abinash Singh <abinashsinghlalotra@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250703073259.17356-1-jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-common.h |  4 +++
 drivers/xen/gntdev.c        | 71 ++++++++++++++++++++++++++-----------
 2 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
index 9c286b2a1900..ac8ce3179ba2 100644
--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -26,6 +26,10 @@ struct gntdev_priv {
 	/* lock protects maps and freeable_maps. */
 	struct mutex lock;
 
+	/* Free instances of struct gntdev_copy_batch. */
+	struct gntdev_copy_batch *batch;
+	struct mutex batch_lock;
+
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	/* Device for which DMA memory is allocated. */
 	struct device *dma_dev;
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 4d9a3050de6a..de8a36502aa2 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -56,6 +56,18 @@ MODULE_AUTHOR("Derek G. Murray <Derek.Murray@cl.cam.ac.uk>, "
 	      "Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_DESCRIPTION("User-space granted page access driver");
 
+#define GNTDEV_COPY_BATCH 16
+
+struct gntdev_copy_batch {
+	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
+	struct page *pages[GNTDEV_COPY_BATCH];
+	s16 __user *status[GNTDEV_COPY_BATCH];
+	unsigned int nr_ops;
+	unsigned int nr_pages;
+	bool writeable;
+	struct gntdev_copy_batch *next;
+};
+
 static unsigned int limit = 64*1024;
 module_param(limit, uint, 0644);
 MODULE_PARM_DESC(limit,
@@ -584,6 +596,8 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	INIT_LIST_HEAD(&priv->maps);
 	mutex_init(&priv->lock);
 
+	mutex_init(&priv->batch_lock);
+
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	priv->dmabuf_priv = gntdev_dmabuf_init(flip);
 	if (IS_ERR(priv->dmabuf_priv)) {
@@ -608,6 +622,7 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 {
 	struct gntdev_priv *priv = flip->private_data;
 	struct gntdev_grant_map *map;
+	struct gntdev_copy_batch *batch;
 
 	pr_debug("priv %p\n", priv);
 
@@ -620,6 +635,14 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 	}
 	mutex_unlock(&priv->lock);
 
+	mutex_lock(&priv->batch_lock);
+	while (priv->batch) {
+		batch = priv->batch;
+		priv->batch = batch->next;
+		kfree(batch);
+	}
+	mutex_unlock(&priv->batch_lock);
+
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
 	gntdev_dmabuf_fini(priv->dmabuf_priv);
 #endif
@@ -785,17 +808,6 @@ static long gntdev_ioctl_notify(struct gntdev_priv *priv, void __user *u)
 	return rc;
 }
 
-#define GNTDEV_COPY_BATCH 16
-
-struct gntdev_copy_batch {
-	struct gnttab_copy ops[GNTDEV_COPY_BATCH];
-	struct page *pages[GNTDEV_COPY_BATCH];
-	s16 __user *status[GNTDEV_COPY_BATCH];
-	unsigned int nr_ops;
-	unsigned int nr_pages;
-	bool writeable;
-};
-
 static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 				unsigned long *gfn)
 {
@@ -953,36 +965,53 @@ static int gntdev_grant_copy_seg(struct gntdev_copy_batch *batch,
 static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void __user *u)
 {
 	struct ioctl_gntdev_grant_copy copy;
-	struct gntdev_copy_batch batch;
+	struct gntdev_copy_batch *batch;
 	unsigned int i;
 	int ret = 0;
 
 	if (copy_from_user(&copy, u, sizeof(copy)))
 		return -EFAULT;
 
-	batch.nr_ops = 0;
-	batch.nr_pages = 0;
+	mutex_lock(&priv->batch_lock);
+	if (!priv->batch) {
+		batch = kmalloc(sizeof(*batch), GFP_KERNEL);
+	} else {
+		batch = priv->batch;
+		priv->batch = batch->next;
+	}
+	mutex_unlock(&priv->batch_lock);
+	if (!batch)
+		return -ENOMEM;
+
+	batch->nr_ops = 0;
+	batch->nr_pages = 0;
 
 	for (i = 0; i < copy.count; i++) {
 		struct gntdev_grant_copy_segment seg;
 
 		if (copy_from_user(&seg, &copy.segments[i], sizeof(seg))) {
 			ret = -EFAULT;
+			gntdev_put_pages(batch);
 			goto out;
 		}
 
-		ret = gntdev_grant_copy_seg(&batch, &seg, &copy.segments[i].status);
-		if (ret < 0)
+		ret = gntdev_grant_copy_seg(batch, &seg, &copy.segments[i].status);
+		if (ret < 0) {
+			gntdev_put_pages(batch);
 			goto out;
+		}
 
 		cond_resched();
 	}
-	if (batch.nr_ops)
-		ret = gntdev_copy(&batch);
-	return ret;
+	if (batch->nr_ops)
+		ret = gntdev_copy(batch);
+
+ out:
+	mutex_lock(&priv->batch_lock);
+	batch->next = priv->batch;
+	priv->batch = batch;
+	mutex_unlock(&priv->batch_lock);
 
-  out:
-	gntdev_put_pages(&batch);
 	return ret;
 }
 
-- 
2.39.5




