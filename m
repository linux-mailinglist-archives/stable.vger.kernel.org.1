Return-Path: <stable+bounces-106271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DE9FE3CF
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D6718828B6
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965141A0B0C;
	Mon, 30 Dec 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUyHuZ11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546019F406
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547997; cv=none; b=Fh540IgnCyDP+60jrEOMTehzCPR3adSBF6VbTQ7motzJP4C9qE/MtLH6M67oBPe6BkgFRcJihb/Q4XG4CELwZbCvob0lLSx4ytIjhkZ9xPqV7amSWDpl+Q4bl+UbEBgU3GxC4eaelCOyV/OlxaneApAClxguBznY9Ie8cKZQU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547997; c=relaxed/simple;
	bh=4YIQaH+kCSox5gAhF/tEaNTHDeFgERI5Jez7IzCv2Ek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I8FIv6V7n9iO1FboLwvZR4+fV2ZYO6F0TxV+eFiivXBCsWRD9Vqw6Az/PB/iZmotO7fb/MoZPCvdF/+N1LYTaMMfeXVak7JDVq82MxmRksP08mUH85GCUunbSXuzRssVkVeldnAL1hbLQNovub+T6p9cFQnpVZUqqBkd3DGUslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUyHuZ11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81289C4CED0;
	Mon, 30 Dec 2024 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547996;
	bh=4YIQaH+kCSox5gAhF/tEaNTHDeFgERI5Jez7IzCv2Ek=;
	h=Subject:To:Cc:From:Date:From;
	b=pUyHuZ11wfyVrzYdIEZ4Y4dzYVCCt1Rbft/zquosAQnCqBQLzTS6FOuqtYryzil9L
	 eCyT9LBpjZyi0ghWQVfT6mFVdJMVuOhA7RwNnLks+8zgzw2PTVeKSjDNS3CxkHGZ74
	 xzDbafWOzMTph/0i/KDHSIBD0nPQxyeXMh53oL78=
Subject: FAILED: patch "[PATCH] btrfs: fix use-after-free waiting for encoded read endios" failed to apply to 6.12-stable tree
To: johannes.thumshirn@wdc.com,dsterba@suse.com,fdmanana@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:39:54 +0100
Message-ID: <2024123053-neurosis-bounding-947c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d29662695ed7c015521e5fc9387df25aab192a2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123053-neurosis-bounding-947c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d29662695ed7c015521e5fc9387df25aab192a2e Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Nov 2024 18:16:49 +0100
Subject: [PATCH] btrfs: fix use-after-free waiting for encoded read endios

Fix a use-after-free in the I/O completion path for encoded reads by
using a completion instead of a wait_queue for synchronizing the
destruction of 'struct btrfs_encoded_read_private'.

Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 94c8809e8170..6baa0269a85b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9078,9 +9078,9 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	wait_queue_head_t wait;
+	struct completion done;
 	void *uring_ctx;
-	atomic_t pending;
+	refcount_t pending_refs;
 	blk_status_t status;
 };
 
@@ -9099,14 +9099,14 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (atomic_dec_and_test(&priv->pending)) {
+	if (refcount_dec_and_test(&priv->pending_refs)) {
 		int err = blk_status_to_errno(READ_ONCE(priv->status));
 
 		if (priv->uring_ctx) {
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			wake_up(&priv->wait);
+			complete(&priv->done);
 		}
 	}
 	bio_put(&bbio->bio);
@@ -9126,8 +9126,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	if (!priv)
 		return -ENOMEM;
 
-	init_waitqueue_head(&priv->wait);
-	atomic_set(&priv->pending, 1);
+	init_completion(&priv->done);
+	refcount_set(&priv->pending_refs, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
 
@@ -9140,7 +9140,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
 
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
-			atomic_inc(&priv->pending);
+			refcount_inc(&priv->pending_refs);
 			btrfs_submit_bbio(bbio, 0);
 
 			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
@@ -9155,11 +9155,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		disk_io_size -= bytes;
 	} while (disk_io_size);
 
-	atomic_inc(&priv->pending);
+	refcount_inc(&priv->pending_refs);
 	btrfs_submit_bbio(bbio, 0);
 
 	if (uring_ctx) {
-		if (atomic_dec_return(&priv->pending) == 0) {
+		if (refcount_dec_and_test(&priv->pending_refs)) {
 			ret = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(uring_ctx, ret);
 			kfree(priv);
@@ -9168,8 +9168,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 		return -EIOCBQUEUED;
 	} else {
-		if (atomic_dec_return(&priv->pending) != 0)
-			io_wait_event(priv->wait, !atomic_read(&priv->pending));
+		if (!refcount_dec_and_test(&priv->pending_refs))
+			wait_for_completion_io(&priv->done);
 		/* See btrfs_encoded_read_endio() for ordering. */
 		ret = blk_status_to_errno(READ_ONCE(priv->status));
 		kfree(priv);


