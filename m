Return-Path: <stable+bounces-26304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725D870DF9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5EB288618
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7C200CD;
	Mon,  4 Mar 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gsmyHVMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAD8F58;
	Mon,  4 Mar 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588374; cv=none; b=c1U8hwHFMnOZCeXX1G14UYQM+VQAmshO2fuoK/6Mj/hBdaha+AGkWLHkIsoJaDnzzp8LEAzPbTqhFUtBUKt9gFkKMDlsi5Thq4cLVEQAXeBgh0yNmEThdY0tDeI3vY4a54OjhfPbwdsWfHFYYKgXZ9t4fq0kmSNHe9sECOAxxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588374; c=relaxed/simple;
	bh=iXqvVUEjGGeu2Jaz5SGsjGa2DDGyyAWe4MDfWTrytTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7/AwyI6M0Ks6MAuJDMl10VvQh7W1BrTdqRFCfz5cz3286glXukycqW9aUBhc4xOXaPugafSv7NO66VsoBZvWyqWhl0bHYpgv1XWql8x29Y5EcyJH5b8s5OICfx9oS2RgmAk8KP6+MSNbcsLLBsw2sGfIOCGJRz30AFT1Lx1rZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gsmyHVMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F77C433F1;
	Mon,  4 Mar 2024 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588374;
	bh=iXqvVUEjGGeu2Jaz5SGsjGa2DDGyyAWe4MDfWTrytTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsmyHVMXr+3KdRx9sJPWdU4A4zZkz3gVYKiCPjXj78173FlMrekBGqiTbMhZK9KsM
	 QVMqCWD0UtfRXJIDFpXIqXybmSmpmmGskNudesw/icGFc7Ne8Or8jBu9TE1ATT5j7P
	 wqE3Emid0K3mPsrTTXs0JlQaGLCo+jB6JHXv84B4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dorai Ashok S A <dash.btrfs@inix.me>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 083/143] btrfs: send: dont issue unnecessary zero writes for trailing hole
Date: Mon,  4 Mar 2024 21:23:23 +0000
Message-ID: <20240304211552.579492062@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 5897710b28cabab04ea6c7547f27b7989de646ae upstream.

If we have a sparse file with a trailing hole (from the last extent's end
to i_size) and then create an extent in the file that ends before the
file's i_size, then when doing an incremental send we will issue a write
full of zeroes for the range that starts immediately after the new extent
ends up to i_size. While this isn't incorrect because the file ends up
with exactly the same data, it unnecessarily results in using extra space
at the destination with one or more extents full of zeroes instead of
having a hole. In same cases this results in using megabytes or even
gigabytes of unnecessary space.

Example, reproducer:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdh
   MNT=/mnt/sdh

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   # Create 1G sparse file.
   xfs_io -f -c "truncate 1G" $MNT/foobar

   # Create base snapshot.
   btrfs subvolume snapshot -r $MNT $MNT/mysnap1

   # Create send stream (full send) for the base snapshot.
   btrfs send -f /tmp/1.snap $MNT/mysnap1

   # Now write one extent at the beginning of the file and one somewhere
   # in the middle, leaving a gap between the end of this second extent
   # and the file's size.
   xfs_io -c "pwrite -S 0xab 0 128K" \
          -c "pwrite -S 0xcd 512M 128K" \
          $MNT/foobar

   # Now create a second snapshot which is going to be used for an
   # incremental send operation.
   btrfs subvolume snapshot -r $MNT $MNT/mysnap2

   # Create send stream (incremental send) for the second snapshot.
   btrfs send -p $MNT/mysnap1 -f /tmp/2.snap $MNT/mysnap2

   # Now recreate the filesystem by receiving both send streams and
   # verify we get the same content that the original filesystem had
   # and file foobar has only two extents with a size of 128K each.
   umount $MNT
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   btrfs receive -f /tmp/1.snap $MNT
   btrfs receive -f /tmp/2.snap $MNT

   echo -e "\nFile fiemap in the second snapshot:"
   # Should have:
   #
   # 128K extent at file range [0, 128K[
   # hole at file range [128K, 512M[
   # 128K extent file range [512M, 512M + 128K[
   # hole at file range [512M + 128K, 1G[
   xfs_io -r -c "fiemap -v" $MNT/mysnap2/foobar

   # File should be using 256K of data (two 128K extents).
   echo -e "\nSpace used by the file: $(du -h $MNT/mysnap2/foobar | cut -f 1)"

   umount $MNT

Running the test, we can see with fiemap that we get an extent for the
range [512M, 1G[, while in the source filesystem we have an extent for
the range [512M, 512M + 128K[ and a hole for the rest of the file (the
range [512M + 128K, 1G[):

   $ ./test.sh
   (...)
   File fiemap in the second snapshot:
   /mnt/sdh/mysnap2/foobar:
    EXT: FILE-OFFSET        BLOCK-RANGE        TOTAL FLAGS
      0: [0..255]:          26624..26879         256   0x0
      1: [256..1048575]:    hole             1048320
      2: [1048576..2097151]: 2156544..3205119 1048576   0x1

   Space used by the file: 513M

This happens because once we finish processing an inode, at
finish_inode_if_needed(), we always issue a hole (write operations full
of zeros) if there's a gap between the end of the last processed extent
and the file's size, even if that range is already a hole in the parent
snapshot. Fix this by issuing the hole only if the range is not already
a hole.

After this change, running the test above, we get the expected layout:

   $ ./test.sh
   (...)
   File fiemap in the second snapshot:
   /mnt/sdh/mysnap2/foobar:
    EXT: FILE-OFFSET        BLOCK-RANGE      TOTAL FLAGS
      0: [0..255]:          26624..26879       256   0x0
      1: [256..1048575]:    hole             1048320
      2: [1048576..1048831]: 26880..27135       256   0x1
      3: [1048832..2097151]: hole             1048320

   Space used by the file: 256K

A test case for fstests will follow soon.

CC: stable@vger.kernel.org # 6.1+
Reported-by: Dorai Ashok S A <dash.btrfs@inix.me>
Link: https://lore.kernel.org/linux-btrfs/c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me/
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6705,11 +6705,20 @@ static int finish_inode_if_needed(struct
 				if (ret)
 					goto out;
 			}
-			if (sctx->cur_inode_last_extent <
-			    sctx->cur_inode_size) {
-				ret = send_hole(sctx, sctx->cur_inode_size);
-				if (ret)
+			if (sctx->cur_inode_last_extent < sctx->cur_inode_size) {
+				ret = range_is_hole_in_parent(sctx,
+						      sctx->cur_inode_last_extent,
+						      sctx->cur_inode_size);
+				if (ret < 0) {
 					goto out;
+				} else if (ret == 0) {
+					ret = send_hole(sctx, sctx->cur_inode_size);
+					if (ret < 0)
+						goto out;
+				} else {
+					/* Range is already a hole, skip. */
+					ret = 0;
+				}
 			}
 		}
 		if (need_truncate) {



