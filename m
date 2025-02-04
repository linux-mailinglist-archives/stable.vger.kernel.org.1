Return-Path: <stable+bounces-112156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B7A2740A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D763A911B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3D215073;
	Tue,  4 Feb 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JG1M02/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999F200BB9
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677651; cv=none; b=NaXGY4h2ZnJWdubpEQlRhyZlSppFeIqnp9LkfgRsMdqP14qqwWY2EYzwyVG1mDqwadn+Cm+OsaDfdM8dxcrkVZqwNycozm7RUgLb3uVo5NsN6FMEDqRMVTzWPI62kBj7nKcmYjqiLc7tqzQ6Lrf3YjjCg1/JEljoWKwx4V4YRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677651; c=relaxed/simple;
	bh=hNlWi0E1oFxCYpOSkjC5xq8gDEwvEdM2p+KrzDBFd24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hksqPN96AxPiHxFifakj9lbOW1oFlAx/zzzZFapOiU/UMrvndyvHa9DE4X09uDk4+Muj/k7dlCiBQNtSfVZ2Xo9zN4lSlp0g6lImkoY6P7a0EeBcVi92E+Kxf6cUNEQTZMZjanUB03PQQ3ZN228MpLeck49WpIqLVSvOXDG3UJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JG1M02/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CD5C4CEDF;
	Tue,  4 Feb 2025 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677650;
	bh=hNlWi0E1oFxCYpOSkjC5xq8gDEwvEdM2p+KrzDBFd24=;
	h=Subject:To:Cc:From:Date:From;
	b=JG1M02/CIDisY3S12HS86DjtMjYBh+XhLz4TuaNh2jQSBhv2AwXqO1lVkHgOGfs2W
	 GPMkFLKdOsPtrJETXoKPqhazEp37bnpfu70mFigyjZ8/sy2ii5mPC5BrVBB7gVSv6D
	 tMyR768uXfv7K5FNqe6kwOGVZ3Xx0m49mWfW0Lpg=
Subject: FAILED: patch "[PATCH] xfs: check for dead buffers in xfs_buf_find_insert" failed to apply to 6.6-stable tree
To: hch@lst.de,cem@kernel.org,dchinner@redhat.com,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:00:47 +0100
Message-ID: <2025020447-mastiff-cauterize-c488@gregkh>
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
git cherry-pick -x 07eae0fa67ca4bbb199ad85645e0f9dfaef931cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020447-mastiff-cauterize-c488@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07eae0fa67ca4bbb199ad85645e0f9dfaef931cd Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 16 Jan 2025 07:01:41 +0100
Subject: [PATCH] xfs: check for dead buffers in xfs_buf_find_insert

Commit 32dd4f9c506b ("xfs: remove a superflous hash lookup when inserting
new buffers") converted xfs_buf_find_insert to use
rhashtable_lookup_get_insert_fast and thus an operation that returns the
existing buffer when an insert would duplicate the hash key.  But this
code path misses the check for a buffer with a reference count of zero,
which could lead to reusing an about to be freed buffer.  Fix this by
using the same atomic_inc_not_zero pattern as xfs_buf_insert.

Fixes: 32dd4f9c506b ("xfs: remove a superflous hash lookup when inserting new buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: stable@vger.kernel.org # v6.0
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index d9636bff16ce..183428fbc607 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -655,9 +655,8 @@ xfs_buf_find_insert(
 		spin_unlock(&bch->bc_lock);
 		goto out_free_buf;
 	}
-	if (bp) {
+	if (bp && atomic_inc_not_zero(&bp->b_hold)) {
 		/* found an existing buffer */
-		atomic_inc(&bp->b_hold);
 		spin_unlock(&bch->bc_lock);
 		error = xfs_buf_find_lock(bp, flags);
 		if (error)


