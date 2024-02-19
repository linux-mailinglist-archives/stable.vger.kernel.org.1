Return-Path: <stable+bounces-20680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07E85AAFD
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C3B21A62
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A69482CB;
	Mon, 19 Feb 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBM+ZE6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34520482D7
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367405; cv=none; b=UOSVNSeQbGBtfpIIpPSTERR/Q5X5XqXDT06KeVRT6xGCw+bWNzx+imd3jTBFhvTBzetTcfIEl/NjEZRL38O8tC2KP2tAVj1y1yR4C8HGd8sN89uVuNWWLzKiXrb6V+kAVQTlTY9mZ8ZgFRTmPRf8x8E9OFFpPUeZIR2dzFxLPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367405; c=relaxed/simple;
	bh=ID7QJxq/zsKjbMgNFuvugz146HUDkdOctqluS+VHFwY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hp3vDtsO8XM+0EyKMNlMxZiCw/ygU34Li3ytpWL3/HkL4kQgMtjqbfp2oRB+873Al/n3bzG9Pz7o4uU6nEgVElV+iqGN/Ms7eCd8hsxTDI/dPcR8iTO8jmK8ZDbEix9HUFSiUN64HDKpqVRU5H2TFjrrUreMLV8tkyO7X62HFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBM+ZE6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC96C433F1;
	Mon, 19 Feb 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708367405;
	bh=ID7QJxq/zsKjbMgNFuvugz146HUDkdOctqluS+VHFwY=;
	h=Subject:To:Cc:From:Date:From;
	b=PBM+ZE6HTXs1iSsS+DN0nBOm72JTSY0AFiv0qn0n7fSXOkxbDZ5SpGvFSoDqp/GHQ
	 1kfxiSPVQ0d+uUhPjAlPdYI1f/MqFoFL1uDwxjSAe6hwrMB3An3CtytQx+XOVUEP3E
	 PvvHjHhvAAoZcxy0CoTzs/GY0yN2sVp66luqzVDg=
Subject: FAILED: patch "[PATCH] nilfs2: fix potential bug in end_buffer_async_write" failed to apply to 4.19-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:29:50 +0100
Message-ID: <2024021950-voltage-culprit-3dd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5bc09b397cbf1221f8a8aacb1152650c9195b02b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021950-voltage-culprit-3dd5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5bc09b397cbf ("nilfs2: fix potential bug in end_buffer_async_write")
ff5710c3f3c2 ("nilfs2: convert nilfs_segctor_prepare_write to use folios")
3cd36212bf75 ("nilfs2: convert nilfs_segctor_complete_write to use folios")
50196f0081ca ("nilfs2: convert nilfs_abort_logs to use folios")
8f46eaf6fd84 ("nilfs2: add nilfs_end_folio_io()")
679bd7ebdd31 ("nilfs2: fix buffer corruption due to concurrent device reads")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5bc09b397cbf1221f8a8aacb1152650c9195b02b Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 4 Feb 2024 01:16:45 +0900
Subject: [PATCH] nilfs2: fix potential bug in end_buffer_async_write

According to a syzbot report, end_buffer_async_write(), which handles the
completion of block device writes, may detect abnormal condition of the
buffer async_write flag and cause a BUG_ON failure when using nilfs2.

Nilfs2 itself does not use end_buffer_async_write().  But, the async_write
flag is now used as a marker by commit 7f42ec394156 ("nilfs2: fix issue
with race condition of competition between segments for dirty blocks") as
a means of resolving double list insertion of dirty blocks in
nilfs_lookup_dirty_data_buffers() and nilfs_lookup_node_buffers() and the
resulting crash.

This modification is safe as long as it is used for file data and b-tree
node blocks where the page caches are independent.  However, it was
irrelevant and redundant to also introduce async_write for segment summary
and super root blocks that share buffers with the backing device.  This
led to the possibility that the BUG_ON check in end_buffer_async_write
would fail as described above, if independent writebacks of the backing
device occurred in parallel.

The use of async_write for segment summary buffers has already been
removed in a previous change.

Fix this issue by removing the manipulation of the async_write flag for
the remaining super root block buffer.

Link: https://lkml.kernel.org/r/20240203161645.4992-1-konishi.ryusuke@gmail.com
Fixes: 7f42ec394156 ("nilfs2: fix issue with race condition of competition between segments for dirty blocks")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000019a97c05fd42f8c8@google.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2590a0860eab..2bfb08052d39 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1703,7 +1703,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_folio != bd_folio) {
 					folio_lock(bd_folio);
@@ -1714,6 +1713,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_folio != fs_folio) {
 				nilfs_begin_folio_io(fs_folio);
 				fs_folio = bh->b_folio;
@@ -1800,7 +1800,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_folio != bd_folio) {
@@ -1809,6 +1808,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_folio != fs_folio) {
 				nilfs_end_folio_io(fs_folio, err);
 				fs_folio = bh->b_folio;
@@ -1896,8 +1896,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_folio != bd_folio) {
 					folio_end_writeback(bd_folio);
 					bd_folio = bh->b_folio;
@@ -1905,6 +1906,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_folio != fs_folio) {
 				nilfs_end_folio_io(fs_folio, 0);
 				fs_folio = bh->b_folio;


