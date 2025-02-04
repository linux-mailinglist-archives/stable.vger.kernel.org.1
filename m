Return-Path: <stable+bounces-112157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5BA273F9
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766A5163F98
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFECF21517B;
	Tue,  4 Feb 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jWNIT1Gu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2F70839
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677659; cv=none; b=SSTsub8yZAMs4+neDkl7HKTUHcKqFs0YZZUaSEzn+Cl7bUGQchXzX9P9eKxDxm/l0p3qnrb4gEIyPmsMLnZ09ofUkQKpxJqvhzE1dpRwsrnetxHW3akXNlO7CrAfHdXBug2K7TWROgT4Lr+bd5oxJ6hhDH3pCPbC2YJ3PlgxxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677659; c=relaxed/simple;
	bh=UEwZ3cyHOpiaeIrTINp8LHE5QdcPpevkRaMfP/wwcwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SCh5hOUQsibbyeqoRZmJP8Y76FjJhDrn3+kCbTIEJPLvbb57U902NOL/JJOJ2IfZEvprGEnISekNdtFWnd4ymWrGATlTRsxxp/LD9Y3bXD2kgh2J33B1s9nS2onOKIRQV8Bz6J3yNnJTW1AC8F3zAtSnZ4HdnF3hb3d2E9oqFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jWNIT1Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72134C4CEE2;
	Tue,  4 Feb 2025 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677658;
	bh=UEwZ3cyHOpiaeIrTINp8LHE5QdcPpevkRaMfP/wwcwE=;
	h=Subject:To:Cc:From:Date:From;
	b=jWNIT1GuQp7TNgHV/7Kww+9lkQcqM0cUiFrfqLPMOemwsOkJXPtG+Tpl4kZCL2CzT
	 1NU9Q5jIpzukLN+Ffel29W4acHqfz7AGuuRdRDs48XLpkwAkHhB38oVnT78curXdsb
	 f8Jygbr1v+uK3tg43TBwp6RcriKHWU6afLdBzdys=
Subject: FAILED: patch "[PATCH] xfs: check for dead buffers in xfs_buf_find_insert" failed to apply to 6.1-stable tree
To: hch@lst.de,cem@kernel.org,dchinner@redhat.com,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:00:47 +0100
Message-ID: <2025020447-stinking-untying-4604@gregkh>
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
git cherry-pick -x 07eae0fa67ca4bbb199ad85645e0f9dfaef931cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020447-stinking-untying-4604@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


