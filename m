Return-Path: <stable+bounces-83792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5699C984
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0A11C223D2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D51A071C;
	Mon, 14 Oct 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wM6hp7Rt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC051684B4
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906899; cv=none; b=c9KahkRoAMgSirkQPqg4OrhR9NkCDsb0UOmdYMhieMaOCg8JNQSfziQe+fuq5vQGY3r1np11NRmP4I0MHO6Su81LngNZt2KCVnu3Tn8c7+AQ+N4crtiwrGrE1I2pXtJq+8NrTnCTo/SfR9JUJKdbG15R0tQQxr2MAGFHcH9qyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906899; c=relaxed/simple;
	bh=EfUe5/zyWHjLEn8KhMZScPnS8MQQw7ZZlAeFEr6svU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iYoLBCSL1OOpMt9P2MvvWveycdRNZQS44q73ZYTrZvG1GA2wE4NczOJntjbeyfjboMEQ5ThieLXyZGRL0ft9lwdKqHjCDmOjyRAXnOZImt6/0eyQGJyVlJeY+n2D3FmHVk49wJwmlHGgEBzBY4vTcRaPktELN4DfPDf1P1ERGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wM6hp7Rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F14C4CEC3;
	Mon, 14 Oct 2024 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906899;
	bh=EfUe5/zyWHjLEn8KhMZScPnS8MQQw7ZZlAeFEr6svU4=;
	h=Subject:To:Cc:From:Date:From;
	b=wM6hp7RtPxLQQmpANvZSdEWOok000cOOqkRmM+cAILpLxPDZThoHJOkmh+VQGauzF
	 U2V+cTv2CoJq6hj123tKuXiuMruqzqirj8oSPaD6Qyd/G4I5TidxS6LpdFYi+Hljsf
	 9mj9g8DGarmvdezYcrSh/p8Wir34rguk8ZWMbn8A=
Subject: FAILED: patch "[PATCH] btrfs: split remaining space to discard in chunks" failed to apply to 6.1-stable tree
To: luca.stefani.ge1@gmail.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:54:56 +0200
Message-ID: <2024101454-pouncing-unrobed-994a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a99fcb0158978ed332009449b484e5f3ca2d7df4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101454-pouncing-unrobed-994a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a99fcb015897 ("btrfs: split remaining space to discard in chunks")
29e70be261d9 ("btrfs: use SECTOR_SHIFT to convert physical offset to LBA")
b7d463a1d125 ("btrfs: store a pointer to the original btrfs_bio in struct compressed_bio")
690834e47cf7 ("btrfs: pass a btrfs_bio to btrfs_submit_compressed_read")
7edb9a3e7200 ("btrfs: move zero filling of compressed read bios into common code")
32586c5bca72 ("btrfs: factor out a btrfs_free_compressed_pages helper")
10e924bc320a ("btrfs: factor out a btrfs_add_compressed_bio_pages helper")
d7294e4deeb9 ("btrfs: use the bbio file offset in add_ra_bio_pages")
e7aff33e3161 ("btrfs: use the bbio file offset in btrfs_submit_compressed_read")
798c9fc74d03 ("btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read")
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
35a8d7da3ca8 ("btrfs: remove now spurious bio submission helpers")
285599b6fe15 ("btrfs: remove the fs_info argument to btrfs_submit_bio")
48253076c3a9 ("btrfs: open code submit_encoded_read_bio")
30493ff49f81 ("btrfs: remove stripe boundary calculation for compressed I/O")
2380220e1e13 ("btrfs: remove stripe boundary calculation for buffered I/O")
67d669825090 ("btrfs: pass the iomap bio to btrfs_submit_bio")
852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
69ccf3f4244a ("btrfs: handle recording of zoned writes in the storage layer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a99fcb0158978ed332009449b484e5f3ca2d7df4 Mon Sep 17 00:00:00 2001
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Tue, 17 Sep 2024 22:33:04 +0200
Subject: [PATCH] btrfs: split remaining space to discard in chunks

Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
mostly empty although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a large delay.

Split the space left to discard based on BTRFS_MAX_DISCARD_CHUNK_SIZE in
preparation of introduction of cancellation points to trim. The value
of the chunk size is arbitrary, it can be higher or derived from actual
device capabilities but we can't easily read that using
bio_discard_limit().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..ad70548d1f72 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1300,13 +1300,24 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		bytes_left = end - start;
 	}
 
-	if (bytes_left) {
+	while (bytes_left) {
+		u64 bytes_to_discard = min(BTRFS_MAX_DISCARD_CHUNK_SIZE, bytes_left);
+
 		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
+					   bytes_to_discard >> SECTOR_SHIFT,
 					   GFP_NOFS);
-		if (!ret)
-			*discarded_bytes += bytes_left;
+
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				break;
+			continue;
+		}
+
+		start += bytes_to_discard;
+		bytes_left -= bytes_to_discard;
+		*discarded_bytes += bytes_to_discard;
 	}
+
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 03d2d60afe0c..4481575dd70f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -30,6 +30,12 @@ struct btrfs_zoned_device_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
+/*
+ * Arbitratry maximum size of one discard request to limit potentially long time
+ * spent in blkdev_issue_discard().
+ */
+#define BTRFS_MAX_DISCARD_CHUNK_SIZE	(SZ_1G)
+
 extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN		SZ_64K


