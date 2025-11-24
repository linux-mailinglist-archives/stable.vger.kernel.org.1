Return-Path: <stable+bounces-196703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A93C80C2A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54343AE0E8
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818C21B192;
	Mon, 24 Nov 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yD8aX+t/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AC219301
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990762; cv=none; b=ZxMVgB7E2BPyXFFHyw8OT3NF1NQX8o/7+m+SupAPyWA2RYV56Oe+P6pJrl7+HRUJdg9FMBZWncz9DWNN093LnI26DeuwYSFOBxioPrYZ0eaCf2aLpzIbI3zrEvHQMdxUF8aTC+QmdzKmGphQzoLwwP0XGpQu5OrTN/RFQwkZI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990762; c=relaxed/simple;
	bh=a4+qdjxUz0Rh8GT1+eXw/eyH/UmVIYWXpK03n4fNCzY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jIfT1YIbnPU0MH2sYxavBnP0ZPSq6yBOj6DKs9kXUu19KxWyiuq4h9uhtZ9n1hkdgWbp/deE5O38D8H7pc7FWokhCSec1l8Bt+a1kdPWxCJqlpRjW/U2cKGdjRSpWozC8LWJj/w+3TZgUZFIBAbTmltZwnAnpeVZV2wQtK9Bdvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yD8aX+t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50DC4CEF1;
	Mon, 24 Nov 2025 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990761;
	bh=a4+qdjxUz0Rh8GT1+eXw/eyH/UmVIYWXpK03n4fNCzY=;
	h=Subject:To:Cc:From:Date:From;
	b=yD8aX+t/kbLe/GFYvKRPA6Y+QjEF0XHlbbt1kEJEETATQuMjw5BoqZG5t9sSxRWdg
	 yD+Y0PtGhOr4vEceW9P9hM/W5CMYzMoZtviIyNyYketpU/QYyM04Dod7+rDSq1YHw+
	 9XHpHJcmSf0Ps7nPswf1LylK5omNFMMK3fzh6pqU=
Subject: FAILED: patch "[PATCH] xfs: fix out of bounds memory read error in symlink repair" failed to apply to 6.17-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:25:57 +0100
Message-ID: <2025112457-shining-trough-db05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 678e1cc2f482e0985a0613ab4a5bf89c497e5acc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112457-shining-trough-db05@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 678e1cc2f482e0985a0613ab4a5bf89c497e5acc Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Wed, 12 Nov 2025 08:35:18 -0800
Subject: [PATCH] xfs: fix out of bounds memory read error in symlink repair

xfs/286 produced this report on my test fleet:

 ==================================================================
 BUG: KFENCE: out-of-bounds read in memcpy_orig+0x54/0x110

 Out-of-bounds read at 0xffff88843fe9e038 (184B right of kfence-#184):
  memcpy_orig+0x54/0x110
  xrep_symlink_salvage_inline+0xb3/0xf0 [xfs]
  xrep_symlink_salvage+0x100/0x110 [xfs]
  xrep_symlink+0x2e/0x80 [xfs]
  xrep_attempt+0x61/0x1f0 [xfs]
  xfs_scrub_metadata+0x34f/0x5c0 [xfs]
  xfs_ioc_scrubv_metadata+0x387/0x560 [xfs]
  xfs_file_ioctl+0xe23/0x10e0 [xfs]
  __x64_sys_ioctl+0x76/0xc0
  do_syscall_64+0x4e/0x1e0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 kfence-#184: 0xffff88843fe9df80-0xffff88843fe9dfea, size=107, cache=kmalloc-128

 allocated by task 3470 on cpu 1 at 263329.131592s (192823.508886s ago):
  xfs_init_local_fork+0x79/0xe0 [xfs]
  xfs_iformat_local+0xa4/0x170 [xfs]
  xfs_iformat_data_fork+0x148/0x180 [xfs]
  xfs_inode_from_disk+0x2cd/0x480 [xfs]
  xfs_iget+0x450/0xd60 [xfs]
  xfs_bulkstat_one_int+0x6b/0x510 [xfs]
  xfs_bulkstat_iwalk+0x1e/0x30 [xfs]
  xfs_iwalk_ag_recs+0xdf/0x150 [xfs]
  xfs_iwalk_run_callbacks+0xb9/0x190 [xfs]
  xfs_iwalk_ag+0x1dc/0x2f0 [xfs]
  xfs_iwalk_args.constprop.0+0x6a/0x120 [xfs]
  xfs_iwalk+0xa4/0xd0 [xfs]
  xfs_bulkstat+0xfa/0x170 [xfs]
  xfs_ioc_fsbulkstat.isra.0+0x13a/0x230 [xfs]
  xfs_file_ioctl+0xbf2/0x10e0 [xfs]
  __x64_sys_ioctl+0x76/0xc0
  do_syscall_64+0x4e/0x1e0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 CPU: 1 UID: 0 PID: 1300113 Comm: xfs_scrub Not tainted 6.18.0-rc4-djwx #rc4 PREEMPT(lazy)  3d744dd94e92690f00a04398d2bd8631dcef1954
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
 ==================================================================

On further analysis, I realized that the second parameter to min() is
not correct.  xfs_ifork::if_bytes is the size of the xfs_ifork::if_data
buffer.  if_bytes can be smaller than the data fork size because:

(a) the forkoff code tries to keep the data area as large as possible
(b) for symbolic links, if_bytes is the ondisk file size + 1
(c) forkoff is always a multiple of 8.

Case in point: for a single-byte symlink target, forkoff will be
8 but the buffer will only be 2 bytes long.

In other words, the logic here is wrong and we walk off the end of the
incore buffer.  Fix that.

Cc: stable@vger.kernel.org # v6.10
Fixes: 2651923d8d8db0 ("xfs: online repair of symbolic links")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/symlink_repair.c b/fs/xfs/scrub/symlink_repair.c
index 5902398185a8..df629892462f 100644
--- a/fs/xfs/scrub/symlink_repair.c
+++ b/fs/xfs/scrub/symlink_repair.c
@@ -184,7 +184,7 @@ xrep_symlink_salvage_inline(
 	    sc->ip->i_disk_size == 1 && old_target[0] == '?')
 		return 0;
 
-	nr = min(XFS_SYMLINK_MAXLEN, xfs_inode_data_fork_size(ip));
+	nr = min(XFS_SYMLINK_MAXLEN, ifp->if_bytes);
 	memcpy(target_buf, ifp->if_data, nr);
 	return nr;
 }


