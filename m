Return-Path: <stable+bounces-136941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D5A9F8BB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5A11A853FA
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9028DF18;
	Mon, 28 Apr 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EITLw+/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E320E332;
	Mon, 28 Apr 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865607; cv=none; b=q0JVlpPQ8GHy/i32J+kEZKju5Xa+oQMunwqNU8Nyi/Hur1SGKanRWgZCvzqom5nJL7yuwQHPkrj/zUSIn/+EKVTKAeqC4KkLLW9QPiCN4PMXh2r1R0SiarvOD+2Ex0tlwiekTmc86gNqV4opOxckO3Ua7UcHUCDznjxV94sCG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865607; c=relaxed/simple;
	bh=LfZSrK548ZvHx8aV+352hAqZezHxgfVZWZqBrM4EqFE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HF/S5RHa9+OAfgJZB6VXvlwFVyJ1Glpvtoj4deAikH93QsrpKJKSyhrFupmHR3IUW1psjaH7mr4y1iIJfuGgjHVk5hGLKSJ8wxRnq1YgbXc4GzgA7Mk0MZoK6oImaoRqgDdnl6GFvpDUtF3e2I6ySYt50CP8uap/A/PMhvFce9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EITLw+/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36445C4CEED;
	Mon, 28 Apr 2025 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865607;
	bh=LfZSrK548ZvHx8aV+352hAqZezHxgfVZWZqBrM4EqFE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EITLw+/iogMJtxUZ8jWOghXJBCaaiMYabpn8TdpsykqymFIPh75yUiSbvuaFhN4u0
	 OPKpaRIamb1UPb0z72HSSJj51EJPUTfz2miW+E6xH46IDwgJlF+4/XRUO52Y2IDz9a
	 qPU6RW0R4yW0VCPcaaovdFSqc/hMvghHYd2EkLPQNZXx0r/efWFsltBE3ezrWyzpNA
	 bFajD1tAkGRE2EAU9jeV8ZNw5XOpHbIPacYZMp4P8inTijhdQj/qtpU3hKCtDZMiVI
	 6WG3lLxRr+na5WrEoufwoVIhoYRYbjEWd09hINBL/Na3MdewAFDpAp0E0tr4eL+Nvy
	 hL3c+rdk+N0Sg==
Date: Mon, 28 Apr 2025 11:40:06 -0700
Subject: [PATCH 4/4] xfs: flush inodegc before swapon
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: cem@kernel.org, dchinner@redhat.com, hch@lst.de, stable@vger.kernel.org
Message-ID: <174586545460.480536.4621928282923794223.stgit@frogsfrogsfrogs>
In-Reply-To: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
References: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

Commit 2d873efd174bae9005776937d5ac6a96050266db upstream

Fix the brand new xfstest that tries to swapon on a recently unshared
file and use the chance to document the other bit of magic in this
function.

The big comment is taken from a mailinglist post by Dave Chinner.

Fixes: 5e672cd69f0a53 ("xfs: introduce xfs_inodegc_push()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_aops.c |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index d2c7be12f5666b..ba6b4a180e8081 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -19,6 +19,7 @@
 #include "xfs_reflink.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
+#include "xfs_icache.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -533,7 +534,39 @@ xfs_vm_swap_activate(
 	struct file			*swap_file,
 	sector_t			*span)
 {
-	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
+	struct xfs_inode		*ip = XFS_I(file_inode(swap_file));
+
+	/*
+	 * Swap file activation can race against concurrent shared extent
+	 * removal in files that have been cloned.  If this happens,
+	 * iomap_swapfile_iter() can fail because it encountered a shared
+	 * extent even though an operation is in progress to remove those
+	 * shared extents.
+	 *
+	 * This race becomes problematic when we defer extent removal
+	 * operations beyond the end of a syscall (i.e. use async background
+	 * processing algorithms).  Users think the extents are no longer
+	 * shared, but iomap_swapfile_iter() still sees them as shared
+	 * because the refcountbt entries for the extents being removed have
+	 * not yet been updated.  Hence the swapon call fails unexpectedly.
+	 *
+	 * The race condition is currently most obvious from the unlink()
+	 * operation as extent removal is deferred until after the last
+	 * reference to the inode goes away.  We then process the extent
+	 * removal asynchronously, hence triggers the "syscall completed but
+	 * work not done" condition mentioned above.  To close this race
+	 * window, we need to flush any pending inodegc operations to ensure
+	 * they have updated the refcountbt records before we try to map the
+	 * swapfile.
+	 */
+	xfs_inodegc_flush(ip->i_mount);
+
+	/*
+	 * Direct the swap code to the correct block device when this file
+	 * sits on the RT device.
+	 */
+	sis->bdev = xfs_inode_buftarg(ip)->bt_bdev;
+
 	return iomap_swapfile_activate(sis, swap_file, span,
 			&xfs_read_iomap_ops);
 }


