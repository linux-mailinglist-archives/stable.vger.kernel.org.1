Return-Path: <stable+bounces-172983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480FB35B39
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37951361D32
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E3312803;
	Tue, 26 Aug 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/bThEuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777833A01B;
	Tue, 26 Aug 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207070; cv=none; b=Qqdjy/pzo2A8g1IEE0E/8tT1IEeCgiV0cHbeFn0LRrZzXH2A58IO1htabjD0JfXw4ue9yd4fpUmP3Vsd6iIeV9BNKfYGJQh09wpfsVsOo2s18ll/az87oKoHr9GGqOEAJitolc3gzpp9lQ3M0+xTkanc9bsOAuQ9XXYDCIqZP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207070; c=relaxed/simple;
	bh=2l+gTs1Ue6mA6SiKYfoQs8kfRHWdjQae51tSYr/UUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjwUsi+xNMTduICS0jHEcYAxbn8MZ4yky4bbrbkdHzhF0bAdecXqMCKxdgppwPKObMCfKDBen+Xj0/UHyaJPnzhj6QeZAerXlMyOk0N1proXgGm07UJj/SfbXXCY1Mfbo84rT8oGby0kyRfsCmCYfCqQd7HQMr9cXe9Pn5NjGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/bThEuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00551C4CEF4;
	Tue, 26 Aug 2025 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207070;
	bh=2l+gTs1Ue6mA6SiKYfoQs8kfRHWdjQae51tSYr/UUOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v/bThEuPEg6U2UtpcK+drJYAyao0dq6xWadw+j2hWhO3uu4BGIY+ZpuiAuJr5xFVQ
	 aAi4WzCYLDnrRh5zq1QBTDsfhhfPIpRy8XA8loXK4s7RzP49Ewg/q++L/OjhKPRZbi
	 hfPPVGl4y7Ig287msSn5oqcKIUji2OETNbxuLKwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Disha Goel <disgoel@linux.ibm.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.16 039/457] ext4: fix fsmap end of range reporting with bigalloc
Date: Tue, 26 Aug 2025 13:05:23 +0200
Message-ID: <20250826110938.312812900@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

commit bae76c035bf0852844151e68098c9b7cd63ef238 upstream.

With bigalloc enabled, the logic to report last extent has a bug since
we try to use cluster units instead of block units. This can cause an
issue where extra incorrect entries might be returned back to the
user. This was flagged by generic/365 with 64k bs and -O bigalloc.

** Details of issue **

The issue was noticed on 5G 64k blocksize FS with -O bigalloc which has
only 1 bg.

$ xfs_io -c "fsmap -d" /mnt/scratch

  0: 253:48 [0..127]: static fs metadata 128   /* sb */
  1: 253:48 [128..255]: special 102:1 128   /* gdt */
  3: 253:48 [256..383]: special 102:3 128   /* block bitmap */
  4: 253:48 [384..2303]: unknown 1920       /* flex bg empty space */
  5: 253:48 [2304..2431]: special 102:4 128   /* inode bitmap */
  6: 253:48 [2432..4351]: unknown 1920      /* flex bg empty space */
  7: 253:48 [4352..6911]: inodes 2560
  8: 253:48 [6912..538623]: unknown 531712
  9: 253:48 [538624..10485759]: free space 9947136

The issue can be seen with:

$ xfs_io -c "fsmap -d 0 3" /mnt/scratch

  0: 253:48 [0..127]: static fs metadata 128
  1: 253:48 [384..2047]: unknown 1664

Only the first entry was expected to be returned but we get 2. This is
because:

ext4_getfsmap_datadev()
  first_cluster, last_cluster = 0
  ...
  info->gfi_last = true;
  ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1, 0, info);
    fsb = C2B(1) = 16
    fslen = 0
    ...
    /* Merge in any relevant extents from the meta_list */
    list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
      ...
      // since fsb = 16, considers all metadata which starts before 16 blockno
      iter 1: error = ext4_getfsmap_helper(sb, info, p);  // p = sb (0,1), nop
        info->gfi_next_fsblk = 1
      iter 2: error = ext4_getfsmap_helper(sb, info, p);  // p = gdt (1,2), nop
        info->gfi_next_fsblk = 2
      iter 3: error = ext4_getfsmap_helper(sb, info, p);  // p = blk bitmap (2,3), nop
        info->gfi_next_fsblk = 3
      iter 4: error = ext4_getfsmap_helper(sb, info, p);  // p = ino bitmap (18,19)
        if (rec_blk > info->gfi_next_fsblk) { // (18 > 3)
          // emits an extra entry ** BUG **
        }
    }

Fix this by directly calling ext4_getfsmap_datadev() with a dummy
record that has fmr_physical set to (end_fsb + 1) instead of
last_cluster + 1. By using the block instead of cluster we get the
correct behavior.

Replacing ext4_getfsmap_datadev_helper() with ext4_getfsmap_helper()
is okay since the gfi_lastfree and metadata checks in
ext4_getfsmap_datadev_helper() are anyways redundant when we only want
to emit the last allocated block of the range, as we have already
taken care of emitting metadata and any last free blocks.

Cc: stable@kernel.org
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Fixes: 4a622e4d477b ("ext4: fix FS_IOC_GETFSMAP handling")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Link: https://patch.msgid.link/e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/fsmap.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -526,6 +526,7 @@ static int ext4_getfsmap_datadev(struct
 	ext4_group_t end_ag;
 	ext4_grpblk_t first_cluster;
 	ext4_grpblk_t last_cluster;
+	struct ext4_fsmap irec;
 	int error = 0;
 
 	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -609,10 +610,18 @@ static int ext4_getfsmap_datadev(struct
 			goto err;
 	}
 
-	/* Report any gaps at the end of the bg */
+	/*
+	 * The dummy record below will cause ext4_getfsmap_helper() to report
+	 * any allocated blocks at the end of the range.
+	 */
+	irec.fmr_device = 0;
+	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_length = 0;
+	irec.fmr_owner = EXT4_FMR_OWN_FREE;
+	irec.fmr_flags = 0;
+
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
-					     0, info);
+	error = ext4_getfsmap_helper(sb, info, &irec);
 	if (error)
 		goto err;
 



