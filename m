Return-Path: <stable+bounces-105581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D264B9FAD2A
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D461885147
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54654192D6B;
	Mon, 23 Dec 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWFsOa9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203F18DF6D
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950019; cv=none; b=go30kKLVlizeoeN9MZu6trppugZwX4eWVVB2wfifkirzZLsI3qA336c5FJ5whnhAd+Tra0x90tSjyAzcZyTqDrOQTewbMR+0YPbNaipSpmxkV42Gz04RRyyXTeCpawdzAaUdqVYp3wi8tMkw3sI0tzMEFC3MO9H8Oz1P7gG8BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950019; c=relaxed/simple;
	bh=VirJEN7p1bC7982Wkm4TpbXStR/up1GkkuSzD8tJaeo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EVCUTyXGjYnlodk7M7EGnRRBjqdUYexEnMY3QRt4qz1DXo/BjrhBEf9U3EYwYH3n/0jKVp9doCAarWs15NHUkGNCAR+F7/gitqgeeIyzLXvYkhQeL7Q8fjmE7vF98jrC39/cqBObrxQYbHghdm78eguVNJ0LgDrVRkyPIOHYwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWFsOa9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346A6C4CED3;
	Mon, 23 Dec 2024 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734950018;
	bh=VirJEN7p1bC7982Wkm4TpbXStR/up1GkkuSzD8tJaeo=;
	h=Subject:To:Cc:From:Date:From;
	b=HWFsOa9Nka3C3JlzECM+9PARAC9WfLThMSDpZigLTvZdn+t0kkONXH8pfilxrwk7X
	 1ibGowiXlrlS08FtuJiOudN802BFfVwzUqVKWm4fJec5+oSQG/409rX8kmNnMPt/+P
	 tQgxg1nvZ8gTzaphEEv25006g0CqQsnXpkC0gDTw=
Subject: FAILED: patch "[PATCH] btrfs: split bios to the fs sector size boundary" failed to apply to 6.6-stable tree
To: hch@lst.de,dlemoal@kernel.org,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:33:36 +0100
Message-ID: <2024122335-devouring-gone-1855@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x be691b5e593f2cc8cef67bbc59c1fb91b74a86a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122335-devouring-gone-1855@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be691b5e593f2cc8cef67bbc59c1fb91b74a86a9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 4 Nov 2024 07:26:33 +0100
Subject: [PATCH] btrfs: split bios to the fs sector size boundary

Btrfs like other file systems can't really deal with I/O not aligned to
it's internal block size (which strangely is called sector size in
btrfs, for historical reasons), but the block layer split helper doesn't
even know about that.

Round down the split boundary so that all I/Os are aligned.

Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
CC: stable@vger.kernel.org # 6.12
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 011cc97be3b5..78f5606baacb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -649,8 +649,14 @@ static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
 	map_length = min(map_length, bbio->fs_info->max_zone_append_size);
 	sector_offset = bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
 					&nr_segs, map_length);
-	if (sector_offset)
-		return sector_offset << SECTOR_SHIFT;
+	if (sector_offset) {
+		/*
+		 * bio_split_rw_at() could split at a size smaller than our
+		 * sectorsize and thus cause unaligned I/Os.  Fix that by
+		 * always rounding down to the nearest boundary.
+		 */
+		return ALIGN_DOWN(sector_offset << SECTOR_SHIFT, bbio->fs_info->sectorsize);
+	}
 	return map_length;
 }
 


