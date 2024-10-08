Return-Path: <stable+bounces-82575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FA994D6E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC13C281707
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14C1DE4CD;
	Tue,  8 Oct 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="najMpuBw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF891DFD1;
	Tue,  8 Oct 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392722; cv=none; b=oyJyA4FnY4oLn4ES6Q5XbwHFbhImoQUtzexBHnrD16O8hoSbMbJtmN0qPwMx2WCaBHTubOcixZ/doCgm5N4x4++1omIYv1k64JoE7VgIPHwj8alzhDkZC6XapheGzQ0wcU40zVAPDzs88AFY2ToAbW6fyqwbTn9lw8ezQ/naWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392722; c=relaxed/simple;
	bh=AkrBk0r0KPQtZGLrkEcpp4W+Q5NRx6y5QavxBUZlFnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aogLBbO+jv1YV/4qfocYwQiyKLyudPVj6C1ZjDMv3opzQ6NptPnHX+42xYIal1Km277+F193FUzngFjpiZEq7bXrltJu5osQPViHP/bTdJjUizX5tHrJOgrYj9Y8x/Q0cmfsyL6yL0l/5paSkuchBzFF+PyOpqjkHEzYiJkMEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=najMpuBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B60C4CEC7;
	Tue,  8 Oct 2024 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392722;
	bh=AkrBk0r0KPQtZGLrkEcpp4W+Q5NRx6y5QavxBUZlFnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=najMpuBwVmeH7XOmLCX2TcT9tZCDnkgrVBtx4UEBDtJx+QKOXrWTTqKgHK3FUcJc/
	 c13/oUvi6Vw6Wo8td1lpLhQbfHsBJA0zv9DAg2Hy7BNBitn/nbElCZ1aroyK36xKKx
	 avPDIth6MB88Gu2eFYPLrCfEdEcwKjd5RkvrR4gQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Millwood <thebenmachine@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.11 499/558] btrfs: send: fix invalid clone operation for file that got its size decreased
Date: Tue,  8 Oct 2024 14:08:49 +0200
Message-ID: <20241008115721.867657613@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit fa630df665aa9ddce3a96ce7b54e10a38e4d2a2b upstream.

During an incremental send we may end up sending an invalid clone
operation, for the last extent of a file which ends at an unaligned offset
that matches the final i_size of the file in the send snapshot, in case
the file had its initial size (the size in the parent snapshot) decreased
in the send snapshot. In this case the destination will fail to apply the
clone operation because its end offset is not sector size aligned and it
ends before the current size of the file.

Sending the truncate operation always happens when we finish processing an
inode, after we process all its extents (and xattrs, names, etc). So fix
this by ensuring the file has a valid size before we send a clone
operation for an unaligned extent that ends at the final i_size of the
file. The size we truncate to matches the start offset of the clone range
but it could be any value between that start offset and the final size of
the file since the clone operation will expand the i_size if the current
size is smaller than the end offset. The start offset of the range was
chosen because it's always sector size aligned and avoids a truncation
into the middle of a page, which results in dirtying the page due to
filling part of it with zeroes and then making the clone operation at the
receiver trigger IO.

The following test reproduces the issue:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  # Create a file with a size of 256K + 5 bytes, having two extents, one
  # with a size of 128K and another one with a size of 128K + 5 bytes.
  last_ext_size=$((128 * 1024 + 5))
  xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
         -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
         $MNT/foo

  # Another file which we will later clone foo into, but initially with
  # a larger size than foo.
  xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap1

  # Now resize bar and clone foo into it.
  xfs_io -c "truncate 0" \
         -c "reflink $MNT/foo" $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap2

  rm -f /tmp/send-full /tmp/send-inc
  btrfs send -f /tmp/send-full $MNT/snap1
  btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2

  umount $MNT
  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  btrfs receive -f /tmp/send-full $MNT
  btrfs receive -f /tmp/send-inc $MNT

  umount $MNT

Running it before this patch:

  $ ./test.sh
  (...)
  At subvol snap1
  At snapshot snap2
  ERROR: failed to clone extents to bar: Invalid argument

A test case for fstests will be sent soon.

Reported-by: Ben Millwood <thebenmachine@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if it ends at i_size")
CC: stable@vger.kernel.org # 6.11
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6189,8 +6189,29 @@ static int send_write_or_clone(struct se
 	if (ret < 0)
 		return ret;
 
-	if (clone_root->offset + num_bytes == info.size)
+	if (clone_root->offset + num_bytes == info.size) {
+		/*
+		 * The final size of our file matches the end offset, but it may
+		 * be that its current size is larger, so we have to truncate it
+		 * to any value between the start offset of the range and the
+		 * final i_size, otherwise the clone operation is invalid
+		 * because it's unaligned and it ends before the current EOF.
+		 * We do this truncate to the final i_size when we finish
+		 * processing the inode, but it's too late by then. And here we
+		 * truncate to the start offset of the range because it's always
+		 * sector size aligned while if it were the final i_size it
+		 * would result in dirtying part of a page, filling part of a
+		 * page with zeroes and then having the clone operation at the
+		 * receiver trigger IO and wait for it due to the dirty page.
+		 */
+		if (sctx->parent_root != NULL) {
+			ret = send_truncate(sctx, sctx->cur_ino,
+					    sctx->cur_inode_gen, offset);
+			if (ret < 0)
+				return ret;
+		}
 		goto clone_data;
+	}
 
 write_data:
 	ret = send_extent_data(sctx, path, offset, num_bytes);



