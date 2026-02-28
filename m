Return-Path: <stable+bounces-220770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GvzL0FCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 958671C70F9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B6443162C30
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314E40853F;
	Sat, 28 Feb 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKbF6ZFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD4408538;
	Sat, 28 Feb 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300650; cv=none; b=r5nWcogva+i27X2ve1sKgDv7kVzwW5vZlOH986bEaKTVmPwZ2E7H2CruqUiQQe5cfxCSKlghuU2SEwiROokYJQlccNtfKh5fIOptnXQdfBPb8qbw0bPu9/73nMcqI9eJfSp/lQneY3fKo+adJigmSZ2Ez+apWDilk+vWh3+9U/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300650; c=relaxed/simple;
	bh=mdmC0ism8/cu3mnEHsqV2RhrhtLVd5ter06KAnbIgCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqyG9UzFSJTwn9rtTB3kEi0MwV5KDwR7Hyr8WXpcQjSSGdQTLtJuTUFvbBC+WgNEXiVseESttGD7cCN/u3OsKQlv2prX4vMEevcFpna8XYly8LLr6tUUsgFb+OcecoVg84dQyz2PcGlBbss4SU1RW2skgaQAuWFl+CgsrZEYrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKbF6ZFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD0EC19423;
	Sat, 28 Feb 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300650;
	bh=mdmC0ism8/cu3mnEHsqV2RhrhtLVd5ter06KAnbIgCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKbF6ZFgtS34rUsT+TIDk3KQhsMKa+dcoVSzrkQnKtNb3Qbl9B4X/2Vx4Sww6jM3a
	 vRLosUUdP3JDI7v9UFSvtr3X4Qlxn6j2pz4Xt0atQpScoCdmyn1YIl7DjZFmQxrD7K
	 /vMKtp+ZndaR0FdYQYPPGmgCxPpCUf0Bmh6RI7mQxbNKx5dMSj1vGIGzZqWwMcSLYp
	 jSM9eKFLzXMm/4AC8madT3thcBkOGsTot89AJbuEjkp1OzaazbyKufIa50x4bIBq/W
	 ztyiM/zVcO6cEn7RRzH8PwIEydOVza+saSc0R3aGgU5oxNAUbSUO23idEbcouwkOno
	 qPx55075ybY0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	r772577952@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 691/844] xfs: check for deleted cursors when revalidating two btrees
Date: Sat, 28 Feb 2026 12:30:04 -0500
Message-ID: <20260228173244.1509663-692-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 958671C70F9
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 55e03b8cbe2783ec9acfb88e8adb946ed504e117 ]

The free space and inode btree repair functions will rebuild both btrees
at the same time, after which it needs to evaluate both btrees to
confirm that the corruptions are gone.

However, Jiaming Zhang ran syzbot and produced a crash in the second
xchk_allocbt call.  His root-cause analysis is as follows (with minor
corrections):

 In xrep_revalidate_allocbt(), xchk_allocbt() is called twice (first
 for BNOBT, second for CNTBT). The cause of this issue is that the
 first call nullified the cursor required by the second call.

 Let's first enter xrep_revalidate_allocbt() via following call chain:

 xfs_file_ioctl() ->
 xfs_ioc_scrubv_metadata() ->
 xfs_scrub_metadata() ->
 `sc->ops->repair_eval(sc)` ->
 xrep_revalidate_allocbt()

 xchk_allocbt() is called twice in this function. In the first call:

 /* Note that sc->sm->sm_type is XFS_SCRUB_TYPE_BNOPT now */
 xchk_allocbt() ->
 xchk_btree() ->
 `bs->scrub_rec(bs, recp)` ->
 xchk_allocbt_rec() ->
 xchk_allocbt_xref() ->
 xchk_allocbt_xref_other()

 since sm_type is XFS_SCRUB_TYPE_BNOBT, pur is set to &sc->sa.cnt_cur.
 Kernel called xfs_alloc_get_rec() and returned -EFSCORRUPTED. Call
 chain:

 xfs_alloc_get_rec() ->
 xfs_btree_get_rec() ->
 xfs_btree_check_block() ->
 (XFS_IS_CORRUPT || XFS_TEST_ERROR), the former is false and the latter
 is true, return -EFSCORRUPTED. This should be caused by
 ioctl$XFS_IOC_ERROR_INJECTION I guess.

 Back to xchk_allocbt_xref_other(), after receiving -EFSCORRUPTED from
 xfs_alloc_get_rec(), kernel called xchk_should_check_xref(). In this
 function, *curpp (points to sc->sa.cnt_cur) is nullified.

 Back to xrep_revalidate_allocbt(), since sc->sa.cnt_cur has been
 nullified, it then triggered null-ptr-deref via xchk_allocbt() (second
 call) -> xchk_btree().

So.  The bnobt revalidation failed on a cross-reference attempt, so we
deleted the cntbt cursor, and then crashed when we tried to revalidate
the cntbt.  Therefore, check for a null cntbt cursor before that
revalidation, and mark the repair incomplete.  Also we can ignore the
second tree entirely if the first tree was rebuilt but is already
corrupt.

Apply the same fix to xrep_revalidate_iallocbt because it has the same
problem.

Cc: r772577952@gmail.com
Link: https://lore.kernel.org/linux-xfs/CANypQFYU5rRPkTy=iG5m1Lp4RWasSgrHXAh3p8YJojxV0X15dQ@mail.gmail.com/T/#m520c7835fad637eccf843c7936c200589427cc7e
Cc: <stable@vger.kernel.org> # v6.8
Fixes: dbfbf3bdf639a2 ("xfs: repair inode btrees")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/alloc_repair.c  | 15 +++++++++++++++
 fs/xfs/scrub/ialloc_repair.c | 20 +++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/alloc_repair.c b/fs/xfs/scrub/alloc_repair.c
index b6fe1f23819eb..35035d02a2316 100644
--- a/fs/xfs/scrub/alloc_repair.c
+++ b/fs/xfs/scrub/alloc_repair.c
@@ -923,7 +923,22 @@ xrep_revalidate_allocbt(
 	if (error)
 		goto out;
 
+	/*
+	 * If the bnobt is still corrupt, we've failed to repair the filesystem
+	 * and should just bail out.
+	 *
+	 * If the bnobt fails cross-examination with the cntbt, the scan will
+	 * free the cntbt cursor, so we need to mark the repair incomplete
+	 * and avoid walking off the end of the NULL cntbt cursor.
+	 */
+	if (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
+		goto out;
+
 	sc->sm->sm_type = XFS_SCRUB_TYPE_CNTBT;
+	if (!sc->sa.cnt_cur) {
+		xchk_set_incomplete(sc);
+		goto out;
+	}
 	error = xchk_allocbt(sc);
 out:
 	sc->sm->sm_type = old_type;
diff --git a/fs/xfs/scrub/ialloc_repair.c b/fs/xfs/scrub/ialloc_repair.c
index b1d00167d263f..f28459f58832f 100644
--- a/fs/xfs/scrub/ialloc_repair.c
+++ b/fs/xfs/scrub/ialloc_repair.c
@@ -863,10 +863,24 @@ xrep_revalidate_iallocbt(
 	if (error)
 		goto out;
 
-	if (xfs_has_finobt(sc->mp)) {
-		sc->sm->sm_type = XFS_SCRUB_TYPE_FINOBT;
-		error = xchk_iallocbt(sc);
+	/*
+	 * If the inobt is still corrupt, we've failed to repair the filesystem
+	 * and should just bail out.
+	 *
+	 * If the inobt fails cross-examination with the finobt, the scan will
+	 * free the finobt cursor, so we need to mark the repair incomplete
+	 * and avoid walking off the end of the NULL finobt cursor.
+	 */
+	if (!xfs_has_finobt(sc->mp) ||
+	    (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT))
+		goto out;
+
+	sc->sm->sm_type = XFS_SCRUB_TYPE_FINOBT;
+	if (!sc->sa.fino_cur) {
+		xchk_set_incomplete(sc);
+		goto out;
 	}
+	error = xchk_iallocbt(sc);
 
 out:
 	sc->sm->sm_type = old_type;
-- 
2.51.0


