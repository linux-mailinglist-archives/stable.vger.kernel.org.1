Return-Path: <stable+bounces-152878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E69ADCFFA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6897418981E3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BC2EF65E;
	Tue, 17 Jun 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTpN8Fy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF672EF65D
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170553; cv=none; b=lWAO+sn58wFAAr3r1SvRdmeQ55VAp32LexJXLwv9st6yd9B3hHkKus+Ah6/SpvbWgKIKpAoP7OiDj76CF8acaRkvSa1o1VvV4bnJ3QKkEA08AWvrXu+KmSPvYv6kRHW40YqsEwiGeOwu0xWuo7jQm2H9Myk/A7eNs1Jjl5Mh67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170553; c=relaxed/simple;
	bh=V9fntNyVYUgJGKgF6S4szw6L88oUySMO66Fqe+rse44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kVhs3tfMowh5CQmT67yhfVX47S2+Sgxv24CPK8QxrtZS8+VncnJW1CBBijGyM4XtHlLYQlHd/Xw/eqtFSBlhBwvJIePFvHfzYZHyF0s05sE5llKRWEDobRx7HDhCbn5U6kSLR8+dGs4OP7Gy3Y8HUQET1ff8Ddymy9GJ0qrwqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTpN8Fy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F304C4CEE3;
	Tue, 17 Jun 2025 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170552;
	bh=V9fntNyVYUgJGKgF6S4szw6L88oUySMO66Fqe+rse44=;
	h=Subject:To:Cc:From:Date:From;
	b=eTpN8Fy0IMpoEHjpoHcHZCxogpJPnD/jHvK5yhV9j8svf6v9pC5u6cyw7p9sO2D56
	 XIgFHKcR2cxL09fAAhjLP98aTaGPk80QCoqGH5T1iAhWs1WfJgQwbSceggmx8ZtM1m
	 kXk1A0QO0ai6ocrmO/DO/hMl2nYXBgiFfp1OGjVM=
Subject: FAILED: patch "[PATCH] xfs: don't assume perags are initialised when trimming AGs" failed to apply to 6.6-stable tree
To: dchinner@redhat.com,bodonnel@redhat.com,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:29:09 +0200
Message-ID: <2025061709-overboard-duplicate-5035@gregkh>
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
git cherry-pick -x 23be716b1c4f3f3a6c00ee38d51a57ef7db9ef7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061709-overboard-duplicate-5035@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23be716b1c4f3f3a6c00ee38d51a57ef7db9ef7d Mon Sep 17 00:00:00 2001
From: Dave Chinner <dchinner@redhat.com>
Date: Thu, 1 May 2025 09:27:24 +1000
Subject: [PATCH] xfs: don't assume perags are initialised when trimming AGs

When running fstrim immediately after mounting a V4 filesystem,
the fstrim fails to trim all the free space in the filesystem. It
only trims the first extent in the by-size free space tree in each
AG and then returns. If a second fstrim is then run, it runs
correctly and the entire free space in the filesystem is iterated
and discarded correctly.

The problem lies in the setup of the trim cursor - it assumes that
pag->pagf_longest is valid without either reading the AGF first or
checking if xfs_perag_initialised_agf(pag) is true or not.

As a result, when a filesystem is mounted without reading the AGF
(e.g. a clean mount on a v4 filesystem) and the first operation is a
fstrim call, pag->pagf_longest is zero and so the free extent search
starts at the wrong end of the by-size btree and exits after
discarding the first record in the tree.

Fix this by deferring the initialisation of tcur->count to after
we have locked the AGF and guaranteed that the perag is properly
initialised. We trigger this on tcur->count == 0 after locking the
AGF, as this will only occur on the first call to
xfs_trim_gather_extents() for each AG. If we need to iterate,
tcur->count will be set to the length of the record we need to
restart at, so we can use this to ensure we only sample a valid
pag->pagf_longest value for the iteration.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Fixes: 89cfa899608f ("xfs: reduce AGF hold times during fstrim operations")
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index c1a306268ae4..94d0873bcd62 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -167,6 +167,14 @@ xfs_discard_extents(
 	return error;
 }
 
+/*
+ * Care must be taken setting up the trim cursor as the perags may not have been
+ * initialised when the cursor is initialised. e.g. a clean mount which hasn't
+ * read in AGFs and the first operation run on the mounted fs is a trim. This
+ * can result in perag fields that aren't initialised until
+ * xfs_trim_gather_extents() calls xfs_alloc_read_agf() to lock down the AG for
+ * the free space search.
+ */
 struct xfs_trim_cur {
 	xfs_agblock_t	start;
 	xfs_extlen_t	count;
@@ -204,6 +212,14 @@ xfs_trim_gather_extents(
 	if (error)
 		goto out_trans_cancel;
 
+	/*
+	 * First time through tcur->count will not have been initialised as
+	 * pag->pagf_longest is not guaranteed to be valid before we read
+	 * the AGF buffer above.
+	 */
+	if (!tcur->count)
+		tcur->count = pag->pagf_longest;
+
 	if (tcur->by_bno) {
 		/* sub-AG discard request always starts at tcur->start */
 		cur = xfs_bnobt_init_cursor(mp, tp, agbp, pag);
@@ -350,7 +366,6 @@ xfs_trim_perag_extents(
 {
 	struct xfs_trim_cur	tcur = {
 		.start		= start,
-		.count		= pag->pagf_longest,
 		.end		= end,
 		.minlen		= minlen,
 	};


