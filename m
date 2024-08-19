Return-Path: <stable+bounces-69531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF449567A1
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD108B22653
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BB157E93;
	Mon, 19 Aug 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rc2KWnKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315313B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061320; cv=none; b=FIVnbLMPWA4/hbCg+ZOYVOcTVsaO7BQoi9cohaRd2cptkecZUSa9SHmODHuQbvILKET2tZq7LeP7LRac+HSXeaUez5u0AOjEOrgggcnPf/0Lgj+ZzFuMa1EA2lxJQfWPgwCTXTkaBQ/xq9iUwJzLoMDGCFgs8Eb+2L3vud0oebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061320; c=relaxed/simple;
	bh=QjdDW2f6cEp5pV768y3/cBLV5pCcXtOhHF+2aXHo+jg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AdLqJiWiCVtLRyTEU9syaayV5aRYL6bYroiz/j7FI07cDFXOE2ePEoyrQ41kXHF+g5ab17ZGsa2h40074Vvkg06lI9w0puub+bVGXYoIjThedzuFKJAoNQE/YU54mKPPBTdKY65N9kXMIwfLPkdecY8Wk9NanO8j+x8Do+hh0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rc2KWnKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FBAC32782;
	Mon, 19 Aug 2024 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061319;
	bh=QjdDW2f6cEp5pV768y3/cBLV5pCcXtOhHF+2aXHo+jg=;
	h=Subject:To:Cc:From:Date:From;
	b=Rc2KWnKJS8bv0BcAeKvTnBEe5GJKqFPchI3MRChm9nacjK0Tx5UC1hlb0UkeQj1Ux
	 aKkgmE7OHypgkCTBoQ+h4IcEGaE7KiJxPySIwhrD/7+SJKJlE2zkrmZPxaNKXUNwCN
	 /0uL58T+wUlvgz+5Zqy3RJmEwHifzh/HvLxv1G3g=
Subject: FAILED: patch "[PATCH] btrfs: send: allow cloning non-aligned extent if it ends at" failed to apply to 5.15-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:55:13 +0200
Message-ID: <2024081913-cupped-curing-f315@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 46a6e10a1ab16cc71d4a3cab73e79aabadd6b8ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081913-cupped-curing-f315@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if it ends at i_size")
4e00422ee626 ("btrfs: replace sb::s_blocksize by fs_info::sectorsize")
3ea4dc5bf00c ("btrfs: send: send compressed extents with encoded writes")
6fe81a3a3ac8 ("btrfs: balance btree dirty pages and delayed items after clone and dedupe")
152555b39ceb ("btrfs: send: avoid trashing the page cache")
521b6803f22e ("btrfs: send: keep the current inode open while processing it")
1c6cbbbeeeca ("btrfs: remove inode_dio_wait() calls when starting reflink operations")
6b1f86f8e9c7 ("Merge tag 'folio-5.18b' of git://git.infradead.org/users/willy/pagecache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46a6e10a1ab16cc71d4a3cab73e79aabadd6b8ea Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 12 Aug 2024 14:18:06 +0100
Subject: [PATCH] btrfs: send: allow cloning non-aligned extent if it ends at
 i_size

If we a find that an extent is shared but its end offset is not sector
size aligned, then we don't clone it and issue write operations instead.
This is because the reflink (remap_file_range) operation does not allow
to clone unaligned ranges, except if the end offset of the range matches
the i_size of the source and destination files (and the start offset is
sector size aligned).

While this is not incorrect because send can only guarantee that a file
has the same data in the source and destination snapshots, it's not
optimal and generates confusion and surprising behaviour for users.

For example, running this test:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  # Use a file size not aligned to any possible sector size.
  file_size=$((1 * 1024 * 1024 + 5)) # 1MB + 5 bytes
  dd if=/dev/random of=$MNT/foo bs=$file_size count=1
  cp --reflink=always $MNT/foo $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap
  rm -f /tmp/send-test
  btrfs send -f /tmp/send-test $MNT/snap

  umount $MNT
  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  btrfs receive -vv -f /tmp/send-test $MNT

  xfs_io -r -c "fiemap -v" $MNT/snap/bar

  umount $MNT

Gives the following result:

  (...)
  mkfile o258-7-0
  rename o258-7-0 -> bar
  write bar - offset=0 length=49152
  write bar - offset=49152 length=49152
  write bar - offset=98304 length=49152
  write bar - offset=147456 length=49152
  write bar - offset=196608 length=49152
  write bar - offset=245760 length=49152
  write bar - offset=294912 length=49152
  write bar - offset=344064 length=49152
  write bar - offset=393216 length=49152
  write bar - offset=442368 length=49152
  write bar - offset=491520 length=49152
  write bar - offset=540672 length=49152
  write bar - offset=589824 length=49152
  write bar - offset=638976 length=49152
  write bar - offset=688128 length=49152
  write bar - offset=737280 length=49152
  write bar - offset=786432 length=49152
  write bar - offset=835584 length=49152
  write bar - offset=884736 length=49152
  write bar - offset=933888 length=49152
  write bar - offset=983040 length=49152
  write bar - offset=1032192 length=16389
  chown bar - uid=0, gid=0
  chmod bar - mode=0644
  utimes bar
  utimes
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=06d640da-9ca1-604c-b87c-3375175a8eb3, stransid=7
  /mnt/sdi/snap/bar:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..2055]:       26624..28679      2056   0x1

There's no clone operation to clone extents from the file foo into file
bar and fiemap confirms there's no shared flag (0x2000).

So update send_write_or_clone() so that it proceeds with cloning if the
source and destination ranges end at the i_size of the respective files.

After this changes the result of the test is:

  (...)
  mkfile o258-7-0
  rename o258-7-0 -> bar
  clone bar - source=foo source offset=0 offset=0 length=1048581
  chown bar - uid=0, gid=0
  chmod bar - mode=0644
  utimes bar
  utimes
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=582420f3-ea7d-564e-bbe5-ce440d622190, stransid=7
  /mnt/sdi/snap/bar:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..2055]:       26624..28679      2056 0x2001

A test case for fstests will also follow up soon.

Link: https://github.com/kdave/btrfs-progs/issues/572#issuecomment-2282841416
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..7fc692fc76e1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6157,25 +6157,51 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	u64 offset = key->offset;
 	u64 end;
 	u64 bs = sctx->send_root->fs_info->sectorsize;
+	struct btrfs_file_extent_item *ei;
+	u64 disk_byte;
+	u64 data_offset;
+	u64 num_bytes;
+	struct btrfs_inode_info info = { 0 };
 
 	end = min_t(u64, btrfs_file_extent_end(path), sctx->cur_inode_size);
 	if (offset >= end)
 		return 0;
 
-	if (clone_root && IS_ALIGNED(end, bs)) {
-		struct btrfs_file_extent_item *ei;
-		u64 disk_byte;
-		u64 data_offset;
+	num_bytes = end - offset;
 
-		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
-		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
-		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
-		ret = clone_range(sctx, path, clone_root, disk_byte,
-				  data_offset, offset, end - offset);
-	} else {
-		ret = send_extent_data(sctx, path, offset, end - offset);
-	}
+	if (!clone_root)
+		goto write_data;
+
+	if (IS_ALIGNED(end, bs))
+		goto clone_data;
+
+	/*
+	 * If the extent end is not aligned, we can clone if the extent ends at
+	 * the i_size of the inode and the clone range ends at the i_size of the
+	 * source inode, otherwise the clone operation fails with -EINVAL.
+	 */
+	if (end != sctx->cur_inode_size)
+		goto write_data;
+
+	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
+	if (ret < 0)
+		return ret;
+
+	if (clone_root->offset + num_bytes == info.size)
+		goto clone_data;
+
+write_data:
+	ret = send_extent_data(sctx, path, offset, num_bytes);
+	sctx->cur_inode_next_write_offset = end;
+	return ret;
+
+clone_data:
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
+	data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
+	ret = clone_range(sctx, path, clone_root, disk_byte, data_offset, offset,
+			  num_bytes);
 	sctx->cur_inode_next_write_offset = end;
 	return ret;
 }


