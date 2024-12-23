Return-Path: <stable+bounces-105601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007419FADE0
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EBD1883E4A
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EB192D91;
	Mon, 23 Dec 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eH74fz1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68984259489
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954486; cv=none; b=ZNMPuIttSGjJutdhBVxsLNe+Vq6plrm21RUODFgFAmB+G5ODjf8g/SJALCvLLDo+vwAruWp2ys8jsqht6b8qrA4JYkRZeu6hooUK7NFj0j23aqZgkyrSLecTgJJ1Z++HoEjq7/DThLc2CKEA9kxq0N6m441326GLPr+rlrtLh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954486; c=relaxed/simple;
	bh=/o0h9bYSm5WrIXwbhUFyRgU/5aze8b/uMl7cH/0e7lQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CACsY2jOgXmE8v2Zi4F3YxN1l9TvTafNuqTFDliqAm3PW7S7dJvoxiea01mJYaDNYQU8724g34wO351+EXObBC2h36xNtb4PpztUILYzHdOf5VnUjDsg4VbFGpgn97q1rFWflnzMf+xNOCkqVo6ekmn4SOdlQFvANO+JS7cJeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eH74fz1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F7C4CED3;
	Mon, 23 Dec 2024 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734954486;
	bh=/o0h9bYSm5WrIXwbhUFyRgU/5aze8b/uMl7cH/0e7lQ=;
	h=Subject:To:Cc:From:Date:From;
	b=eH74fz1qp2nfV8AZClTXjpIBze+2HlwgCbC2+ZvWTy2udc8qvAEnOUHDqipOA/R/s
	 tnYfMKBwNJGZhHdw/khtCt7dQOBl59RDGXeIK2a/TPFULPkMsiX06AwDYw2aD2ju5q
	 HFLq6ODexmETaYV08TzTP3gUjOexxHTeLlyMOdlM=
Subject: FAILED: patch "[PATCH] btrfs: use bio_is_zone_append() in the completion handler" failed to apply to 6.12-stable tree
To: hch@lst.de,dlemoal@kernel.org,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:48:02 +0100
Message-ID: <2024122301-ouch-willfully-ae9c@gregkh>
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
git cherry-pick -x 6c3864e055486fadb5b97793b57688082e14b43b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122301-ouch-willfully-ae9c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c3864e055486fadb5b97793b57688082e14b43b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 4 Nov 2024 07:26:32 +0100
Subject: [PATCH] btrfs: use bio_is_zone_append() in the completion handler

Otherwise it won't catch bios turned into regular writes by the block
level zone write plugging. The additional test it adds is for emulated
zone append.

Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
CC: stable@vger.kernel.org # 6.12
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..011cc97be3b5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -355,7 +355,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+		if (bio_is_zone_append(bio) && !bio->bi_status)
 			btrfs_record_physical_zoned(bbio);
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	}
@@ -398,7 +398,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+	if (bio_is_zone_append(bio) && !bio->bi_status)
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	btrfs_bio_end_io(bbio, bbio->bio.bi_status);
@@ -412,7 +412,7 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	if (bio->bi_status) {
 		atomic_inc(&stripe->bioc->error);
 		btrfs_log_dev_io_error(bio, stripe->dev);
-	} else if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+	} else if (bio_is_zone_append(bio)) {
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 


