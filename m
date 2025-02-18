Return-Path: <stable+bounces-116763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842BEA39C52
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50174188D370
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA824503D;
	Tue, 18 Feb 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwKNBAWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADD244E82
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882170; cv=none; b=F3sY0G/Rv1MuXujbVfpRatd5BCIDfVNs3oHCw4M453FPMce0aa11Smv0gU83O0Zv3R1ILsgpn09aI/8byDV4pdLBMGdrmTAa9ZBj1KnzRGONe07A70Wr3uz5qwjCL7XBjHQ5UE0DFQzwWKz0TBZMN+SPG1N0BOQmSRTKLtxU5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882170; c=relaxed/simple;
	bh=UwTkEJddLTYLROMeqe4mFYuMmXV8B1dgdnOxBcRzK+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sf4mRknKcp+Fc0Nrqx9RKk9VZ9u9mD7C3fze2pwGy4DTSqN2FC4pV/NRJHJF2xRMDH9UfV2w0e58h/5nh+cN20JooRy0lXTI18v+Sj4eVpQNOh1lGXdvvkZg4IfbhPRg6El9rjEs0LucjXOQefY7JwHbAuIGvvVj/+fWGHZWyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwKNBAWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A42C4CEE6;
	Tue, 18 Feb 2025 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739882170;
	bh=UwTkEJddLTYLROMeqe4mFYuMmXV8B1dgdnOxBcRzK+g=;
	h=Subject:To:Cc:From:Date:From;
	b=EwKNBAWO9fgfjCHZG0JuF2YOhzwxCjy/+/Oi2ij9LSjSiV+Y5aDT0mjwYfbE2Yo5j
	 KwXm0cw/YkjZ1xjdXzrUhGNbQVzlXpI/RcJe4iYKftcAvz6bFYftgn2RBp0dV9/ddU
	 t7/xjVxr+vIXiONA1gso2HLS29M3Pdj2HNuz8wG0=
Subject: FAILED: patch "[PATCH] btrfs: fix hole expansion when writing at an offset beyond" failed to apply to 5.4-stable tree
To: fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 13:35:59 +0100
Message-ID: <2025021859-obligate-simile-7eaf@gregkh>
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
git cherry-pick -x da2dccd7451de62b175fb8f0808d644959e964c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021859-obligate-simile-7eaf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da2dccd7451de62b175fb8f0808d644959e964c7 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 5 Feb 2025 17:36:48 +0000
Subject: [PATCH] btrfs: fix hole expansion when writing at an offset beyond
 EOF

At btrfs_write_check() if our file's i_size is not sector size aligned and
we have a write that starts at an offset larger than the i_size that falls
within the same page of the i_size, then we end up not zeroing the file
range [i_size, write_offset).

The code is this:

    start_pos = round_down(pos, fs_info->sectorsize);
    oldsize = i_size_read(inode);
    if (start_pos > oldsize) {
        /* Expand hole size to cover write data, preventing empty gap */
        loff_t end_pos = round_up(pos + count, fs_info->sectorsize);

        ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
        if (ret)
            return ret;
    }

So if our file's i_size is 90269 bytes and a write at offset 90365 bytes
comes in, we get 'start_pos' set to 90112 bytes, which is less than the
i_size and therefore we don't zero out the range [90269, 90365) by
calling btrfs_cont_expand().

This is an old bug introduced in commit 9036c10208e1 ("Btrfs: update hole
handling v2"), from 2008, and the buggy code got moved around over the
years.

Fix this by discarding 'start_pos' and comparing against the write offset
('pos') without any alignment.

This bug was recently exposed by test case generic/363 which tests this
scenario by polluting ranges beyond EOF with an mmap write and than verify
that after a file increases we get zeroes for the range which is supposed
to be a hole and not what we wrote with the previous mmaped write.

We're only seeing this exposed now because generic/363 used to run only
on xfs until last Sunday's fstests update.

The test was failing like this:

   $ ./check generic/363
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #17 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   generic/363 0s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad)
       --- tests/generic/363.out	2025-02-05 15:31:14.013646509 +0000
       +++ /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad	2025-02-05 17:25:33.112630781 +0000
       @@ -1 +1,46 @@
        QA output created by 363
       +READ BAD DATA: offset = 0xdcad, size = 0xd921, fname = /home/fdmanana/btrfs-tests/dev/junk
       +OFFSET      GOOD    BAD     RANGE
       +0x1609d     0x0000  0x3104  0x0
       +operation# (mod 256) for the bad data may be 4
       +0x1609e     0x0000  0x0472  0x1
       +operation# (mod 256) for the bad data may be 4
       ...
       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/363.out /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad'  to see the entire diff)
   Ran: generic/363
   Failures: generic/363
   Failed 1 of 1 tests

Fixes: 9036c10208e1 ("Btrfs: update hole handling v2")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36f51c311bb1..ed3c0d6546c5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1039,7 +1039,6 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 	loff_t pos = iocb->ki_pos;
 	int ret;
 	loff_t oldsize;
-	loff_t start_pos;
 
 	/*
 	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow or
@@ -1066,9 +1065,8 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 		inode_inc_iversion(inode);
 	}
 
-	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
+	if (pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
 		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
 


