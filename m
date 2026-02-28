Return-Path: <stable+bounces-221084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCOsLVxIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8D1C7919
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8318357696F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A736D9EB;
	Sat, 28 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcbvcAyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DC301F0D;
	Sat, 28 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301428; cv=none; b=t5Lpy/jaWXY3aDpaRsUtI99oAvrC3/YB30JGuTNZwTniurFNX6V0gJ0XdSbi4CRQwweGDX/7F3LTloVo9lWY1qfUGG+7AgYiYDcPdivGqajZMYmrUmVGSWy9BQX1iPVwqvud5SdcdkSaTxnMc6WxSezAPQLKZ6WnfTOwykbZY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301428; c=relaxed/simple;
	bh=mdmC0ism8/cu3mnEHsqV2RhrhtLVd5ter06KAnbIgCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUWC/ormbuYr4qyf5GS9yXghEsfRWWoswzr8nvlqWEjuuGIqUI0rh8gUapG27QSbHxvDAy6ljsDHP8kO5HX0DwXJvB51qxZmi06Ot+WCQMbzFR9khHQF2pedlHx6txXcVy3s9RKzfiGlHFfkqslmAM3KQ7cQVi9Kbeu9lDDmkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcbvcAyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5FAC19425;
	Sat, 28 Feb 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301428;
	bh=mdmC0ism8/cu3mnEHsqV2RhrhtLVd5ter06KAnbIgCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcbvcAyCezS/sAen+talVocaqZVp5Z5nqyianMdmWagWpQNt+TMqpnQBMLxMTfCxy
	 UqCqoGYcCFOg49wbxg+ldBXuoaCvf2A9uNIfmehVdQnqoiS71ASKRRW7X6swEuabg0
	 GohqV+RbCCRxUuP7hJBV6MxNuxqyeDd/5llunUhyxHcYrJ5rzeW81b7MiL3Bwxo82q
	 m5GlGquJJiqJ5eK8iGDdZ8tn3E0vFI2af+WO/e3dehgbVeYAkPNekfx0eIKUXQZaIW
	 L73wIW1d9P/9WysFuG6uT/S2N+VyKujSRQckHQFozz5gjEQVNN235cxdL/MkpfIRzC
	 xxFh99dtoyNHQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	r772577952@gmail.com,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 618/752] xfs: check for deleted cursors when revalidating two btrees
Date: Sat, 28 Feb 2026 12:45:29 -0500
Message-ID: <20260228174750.1542406-618-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lst.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221084-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ED8D1C7919
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


