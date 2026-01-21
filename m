Return-Path: <stable+bounces-210650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbjAj44cGmgXAAAu9opvQ
	(envelope-from <stable+bounces-210650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:21:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9BC4FAD6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0450924FFC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EE32252D;
	Wed, 21 Jan 2026 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teob2MD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8F324B16
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961996; cv=none; b=gm89zzh1znsEJdYEVvzl+p6F4Z6mHyJiM1YZtbJ74H4XzG4vPERawlWRsouoJmXvKtQDpQ77yAbZJBNAjSxsf8eYC1xw5hNESLoimxFxjVupuqlTOktnmgnnoFFIzaOAenr9kGgYIYas6pCRLUtKGuz2w5np43Q7sNbbUKBjq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961996; c=relaxed/simple;
	bh=pghthH5MoO8rh9X/ETRwSEQ3AASwTPOm4BJ3FD2Ki9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3dInKGJ2/KjSnc6XakdQbeg6nukiO9N11aO2BnhwDBpnl7YM7NTcjhhTXOo6fG2qnlZ/XJn0o70y3BkBOiMdNzfRGohBx3CTaz9lcI82TQkY5jIqHYCP4BbKGci9ybrynkhUFUsTp712d9wr7qMViqkkMiUQuJQZc+00l95ztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teob2MD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30037C16AAE;
	Wed, 21 Jan 2026 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961995;
	bh=pghthH5MoO8rh9X/ETRwSEQ3AASwTPOm4BJ3FD2Ki9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teob2MD7b5GOspBH10R2jOaKijtuyaZWyV2C/f6LLzRh3seLrfarY8xwOLqXkUo4e
	 HSv319f1f7zZFSQh1pqXarFBPgvEHNeZk637z0FlD0rf5zbtY48Bhae26Y84YfMQup
	 fnqQseeFZ/J53S1KzKRU3iWwm/wotmqxwzCnkDFzdX6Zj/qOk8maeRy2QvCdPDDSrW
	 Q1kyGggv2vGi2SyWOuv7boGqx/BwO1NUyBGqeBJMmgt31y3PPWWoKgEq9dvUh4PjUf
	 aaftBuuVgloW7son4UjemFvHOWcjPQ/v/eUdJGtXNMlSNQPFut3gJ1OamCnsq7SR53
	 IODo7zGbCO3hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: set max_agbno to allow sparse alloc of last full inode chunk
Date: Tue, 20 Jan 2026 21:19:53 -0500
Message-ID: <20260121021953.1128404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012008-retention-example-5f1c@gregkh>
References: <2026012008-retention-example-5f1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210650-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CC9BC4FAD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit c360004c0160dbe345870f59f24595519008926f ]

Sparse inode cluster allocation sets min/max agbno values to avoid
allocating an inode cluster that might map to an invalid inode
chunk. For example, we can't have an inode record mapped to agbno 0
or that extends past the end of a runt AG of misaligned size.

The initial calculation of max_agbno is unnecessarily conservative,
however. This has triggered a corner case allocation failure where a
small runt AG (i.e. 2063 blocks) is mostly full save for an extent
to the EOFS boundary: [2050,13]. max_agbno is set to 2048 in this
case, which happens to be the offset of the last possible valid
inode chunk in the AG. In practice, we should be able to allocate
the 4-block cluster at agbno 2052 to map to the parent inode record
at agbno 2048, but the max_agbno value precludes it.

Note that this can result in filesystem shutdown via dirty trans
cancel on stable kernels prior to commit 9eb775968b68 ("xfs: walk
all AGs if TRYLOCK passed to xfs_alloc_vextent_iterate_ags") because
the tail AG selection by the allocator sets t_highest_agno on the
transaction. If the inode allocator spins around and finds an inode
chunk with free inodes in an earlier AG, the subsequent dir name
creation path may still fail to allocate due to the AG restriction
and cancel.

To avoid this problem, update the max_agbno calculation to the agbno
prior to the last chunk aligned agbno in the AG. This is not
necessarily the last valid allocation target for a sparse chunk, but
since inode chunks (i.e. records) are chunk aligned and sparse
allocs are cluster sized/aligned, this allows the sb_spino_align
alignment restriction to take over and round down the max effective
agbno to within the last valid inode chunk in the AG.

Note that even though the allocator improvements in the
aforementioned commit seem to avoid this particular dirty trans
cancel situation, the max_agbno logic improvement still applies as
we should be able to allocate from an AG that has been appropriately
selected. The more important target for this patch however are
older/stable kernels prior to this allocator rework/improvement.

Cc: stable@vger.kernel.org # v4.2
Fixes: 56d1115c9bc7 ("xfs: allocate sparse inode chunks on full chunk allocation failure")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ xfs_ag_block_count(args.mp, pag_agno(pag)) => args.mp->m_sb.sb_agblocks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_ialloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index d1472cbd48ffe..4b2894c85ceaa 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -772,14 +772,15 @@ xfs_ialloc_ag_alloc(
 		 * invalid inode records, such as records that start at agbno 0
 		 * or extend beyond the AG.
 		 *
-		 * Set min agbno to the first aligned, non-zero agbno and max to
-		 * the last aligned agbno that is at least one full chunk from
-		 * the end of the AG.
+		 * Set min agbno to the first chunk aligned, non-zero agbno and
+		 * max to one less than the last chunk aligned agbno from the
+		 * end of the AG. We subtract 1 from max so that the cluster
+		 * allocation alignment takes over and allows allocation within
+		 * the last full inode chunk in the AG.
 		 */
 		args.min_agbno = args.mp->m_sb.sb_inoalignmt;
 		args.max_agbno = round_down(args.mp->m_sb.sb_agblocks,
-					    args.mp->m_sb.sb_inoalignmt) -
-				 igeo->ialloc_blks;
+					    args.mp->m_sb.sb_inoalignmt) - 1;
 
 		error = xfs_alloc_vextent(&args);
 		if (error)
-- 
2.51.0


