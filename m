Return-Path: <stable+bounces-114576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77783A2EED8
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81CC18850DC
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C723098C;
	Mon, 10 Feb 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFkwVTg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81E22FF20
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195505; cv=none; b=qwHTTalswwr2VpAdBTJyD4EnP734MWzI+NiNcE7ncsJzk3Fw7nGwD+hWcRdAwnDWGAQhVUu7cch0BNRjTNaNXlPOowrnRA46kXsfccLLk4P/03dNgkonqWeBlU9gb0FxKRqM5Ej+CEUTl2wCrR3gEyqc36rH7/K4djF19lOz8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195505; c=relaxed/simple;
	bh=EYKcPMKZfaIl2raYe81Dz5S64G18IqAgKm+AyiRPxNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dxu0wc2j5jjxVWYK6j9XuKE0fK0u46WAZrWUOTu8aTywdHZSjuZsqh2hrPNCY6L80AiChm2BlbZ9r7ljCzJBU4kpyvFqSoQHpzKY/6fMO2ruqof5zsyc94UTMTXb6QLk3hzXLFIqV5i9LuM9CCPr+Qj5DSMQX3/iXfU8a4TaBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFkwVTg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDB1C4CED1;
	Mon, 10 Feb 2025 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195505;
	bh=EYKcPMKZfaIl2raYe81Dz5S64G18IqAgKm+AyiRPxNQ=;
	h=Subject:To:Cc:From:Date:From;
	b=KFkwVTg3m93Ki+UfZ0iCHTklXzJGPZf8xCKWNVG0Qb4OQkPuOod/OSsaQ6wz0aAtR
	 SxiYaTtIvkL2sFNIRVMpxLfkA9eZJA6ZsGL4vyciTPSo7z1E9n+0INqY1zurHeHtS6
	 LIUAxSA1JDzu+Z/s8HiAHKWpYB5Pg5LBYGPJvzxM=
Subject: FAILED: patch "[PATCH] dm-crypt: don't update io->sector after" failed to apply to 5.4-stable tree
To: houtao1@huawei.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:51:37 +0100
Message-ID: <2025021037-walk-outmatch-5872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9fdbbdbbc92b1474a87b89f8b964892a63734492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021037-walk-outmatch-5872@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fdbbdbbc92b1474a87b89f8b964892a63734492 Mon Sep 17 00:00:00 2001
From: Hou Tao <houtao1@huawei.com>
Date: Mon, 20 Jan 2025 16:29:49 +0800
Subject: [PATCH] dm-crypt: don't update io->sector after
 kcryptd_crypt_write_io_submit()

The updates of io->sector are the leftovers when dm-crypt allocated
pages for partial write request. However, since commit cf2f1abfbd0db
("dm crypt: don't allocate pages for a partial request"), there is no
partial request anymore.

After the introduction of write request rb-tree, the updates of
io->sectors may interfere the insertion procedure, because ->sectors of
these write requests which have already been added in the rb-tree may be
changed during the insertion of new write request.

Fix it by removing these buggy updates of io->sectors. Considering these
updates only effect the write request rb-tree, the commit which
introduces the write request rb-tree is used as the fix tag.

Fixes: b3c5fd305249 ("dm crypt: sort writes")
Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8a4c24d4ee02..605859ef01b5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2090,7 +2090,6 @@ static void kcryptd_crypt_write_continue(struct work_struct *work)
 	struct crypt_config *cc = io->cc;
 	struct convert_context *ctx = &io->ctx;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	wait_for_completion(&ctx->restart);
@@ -2107,10 +2106,8 @@ static void kcryptd_crypt_write_continue(struct work_struct *work)
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 	crypt_dec_pending(io);
 }
@@ -2121,14 +2118,13 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	struct convert_context *ctx = &io->ctx;
 	struct bio *clone;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	/*
 	 * Prevent io from disappearing until this function completes.
 	 */
 	crypt_inc_pending(io);
-	crypt_convert_init(cc, ctx, NULL, io->base_bio, sector);
+	crypt_convert_init(cc, ctx, NULL, io->base_bio, io->sector);
 
 	clone = crypt_alloc_buffer(io, io->base_bio->bi_iter.bi_size);
 	if (unlikely(!clone)) {
@@ -2145,8 +2141,6 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 		io->ctx.iter_in = clone->bi_iter;
 	}
 
-	sector += bio_sectors(clone);
-
 	crypt_inc_pending(io);
 	r = crypt_convert(cc, ctx,
 			  test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags), true);
@@ -2170,10 +2164,8 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 dec:
 	crypt_dec_pending(io);


