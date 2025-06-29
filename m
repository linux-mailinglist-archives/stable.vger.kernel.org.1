Return-Path: <stable+bounces-158839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A6AECC9A
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8787A3808
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64C1E8837;
	Sun, 29 Jun 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F59qwKQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0846FBF
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201066; cv=none; b=a7OY7IrXdDpbxh2SEnhSiMGvtV4aKf5Jj8qLC5/gsJ4tW8uNnreTVn8/2rgVIn3w+Xx2hYaGtzt787Lt2YAGPDcSNVoH8I7/KoVwT1IMYI/40pwNUpSWvN1NiGZJfM7CR4WIDb4QdB8auJOBPApYydU2rTNGNfqJziGCLhTwDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201066; c=relaxed/simple;
	bh=tLLgdJqjwQZlkTApEzE7FLSj8xVgyo/0BCzEW27tLsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OCSAs/U8HYvefvZKtKYf9g1Plgnv4/9UssZ8NDM1nz+NbU8Rp2XQ8DEhWyE/IgkZNiKZ667/iTFy5YoWb1i7wQ3w0Xwsex3Lit+Gy2W6Xva6jLZW/hC2kljGmGXB040uU0KwlU9zbmWP7+wNEagOkIbrH+8VxvVMZyD7elO/x18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F59qwKQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F29C4CEEB;
	Sun, 29 Jun 2025 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201065;
	bh=tLLgdJqjwQZlkTApEzE7FLSj8xVgyo/0BCzEW27tLsA=;
	h=Subject:To:Cc:From:Date:From;
	b=F59qwKQ21xB+u/OezFlUqSEGEh4e02GYsxIMk3FTZSRObNPElEW6mmUhPT+bwRLw1
	 NcQ+mhMrtgSYVQzwkeXwqy0EAJqP/jgBnvvgXp5Evz4O3xPsDCHG1jo9GzFqPBZLc0
	 g7gN7qhZJ4WcAWAcaVqUnNXOfXbTTslg8mbxZGCM=
Subject: FAILED: patch "[PATCH] io_uring/rsrc: fix folio unpinning" failed to apply to 6.12-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,david@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:41:50 +0200
Message-ID: <2025062950-football-lifting-1443@gregkh>
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
git cherry-pick -x 5afb4bf9fc62d828647647ec31745083637132e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062950-football-lifting-1443@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5afb4bf9fc62d828647647ec31745083637132e4 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 24 Jun 2025 14:40:33 +0100
Subject: [PATCH] io_uring/rsrc: fix folio unpinning

syzbot complains about an unmapping failure:

[  108.070381][   T14] kernel BUG at mm/gup.c:71!
[  108.070502][   T14] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[  108.123672][   T14] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20250221-8.fc42 02/21/2025
[  108.127458][   T14] Workqueue: iou_exit io_ring_exit_work
[  108.174205][   T14] Call trace:
[  108.175649][   T14]  sanity_check_pinned_pages+0x7cc/0x7d0 (P)
[  108.178138][   T14]  unpin_user_page+0x80/0x10c
[  108.180189][   T14]  io_release_ubuf+0x84/0xf8
[  108.182196][   T14]  io_free_rsrc_node+0x250/0x57c
[  108.184345][   T14]  io_rsrc_data_free+0x148/0x298
[  108.186493][   T14]  io_sqe_buffers_unregister+0x84/0xa0
[  108.188991][   T14]  io_ring_ctx_free+0x48/0x480
[  108.191057][   T14]  io_ring_exit_work+0x764/0x7d8
[  108.193207][   T14]  process_one_work+0x7e8/0x155c
[  108.195431][   T14]  worker_thread+0x958/0xed8
[  108.197561][   T14]  kthread+0x5fc/0x75c
[  108.199362][   T14]  ret_from_fork+0x10/0x20

We can pin a tail page of a folio, but then io_uring will try to unpin
the head page of the folio. While it should be fine in terms of keeping
the page actually alive, mm folks say it's wrong and triggers a debug
warning. Use unpin_user_folio() instead of unpin_user_page*.

Cc: stable@vger.kernel.org
Debugged-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+1d335893772467199ab6@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/683f1551.050a0220.55ceb.0017.GAE@google.com
Fixes: a8edbb424b139 ("io_uring/rsrc: enable multi-hugepage buffer coalescing")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/io-uring/a28b0f87339ac2acf14a645dad1e95bbcbf18acd.1750771718.git.asml.silence@gmail.com/
[axboe: adapt to current tree, massage commit message]
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d724602697e7..0c09e38784c9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -112,8 +112,11 @@ static void io_release_ubuf(void *priv)
 	struct io_mapped_ubuf *imu = priv;
 	unsigned int i;
 
-	for (i = 0; i < imu->nr_bvecs; i++)
-		unpin_user_page(imu->bvec[i].bv_page);
+	for (i = 0; i < imu->nr_bvecs; i++) {
+		struct folio *folio = page_folio(imu->bvec[i].bv_page);
+
+		unpin_user_folio(folio, 1);
+	}
 }
 
 static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx,
@@ -840,8 +843,10 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret) {
 		if (imu)
 			io_free_imu(ctx, imu);
-		if (pages)
-			unpin_user_pages(pages, nr_pages);
+		if (pages) {
+			for (i = 0; i < nr_pages; i++)
+				unpin_user_folio(page_folio(pages[i]), 1);
+		}
 		io_cache_free(&ctx->node_cache, node);
 		node = ERR_PTR(ret);
 	}


