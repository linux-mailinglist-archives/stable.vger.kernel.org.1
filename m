Return-Path: <stable+bounces-210646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLTONVE2cGl9XAAAu9opvQ
	(envelope-from <stable+bounces-210646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:13:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE54F932
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDC1CAA9D91
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256DF25524C;
	Wed, 21 Jan 2026 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0siBT/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0928312D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961611; cv=none; b=pqlCPltUHfg5PGrbwPm77n+wDncp2xjeqBLsu5Sm1VFxGwNlscm+Aab0fgCELo1goVYgfSUp98sl3wyrmPI1VoWuQjGmLMUWzTKlHUOCcFoLB80QLXZQeFuzsJR8VLb5Hmvx64FiBMuIsjgns1a4+7pKDsMbds/bpiS3zjHel0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961611; c=relaxed/simple;
	bh=B5A+cSVVIBrLRtxhgw5ITmlGcyNs90iDicXjPoi+yWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScQ2WK1YWVSAycxhmKfjpEw1DzXlDbe0oZZzHgtPD5t4MIp56ftpxkcoB7xRPPlI+K5OhxaIkS9bk3MDubcg9DLRbvBB0FzAvvD8Y20Lm5ErhaBuH153DE2p5g8hagbHuBfgVED78WLC27CGxV3j3n6JeeX1ODO5ji3WzL8urPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0siBT/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CFEC16AAE;
	Wed, 21 Jan 2026 02:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961611;
	bh=B5A+cSVVIBrLRtxhgw5ITmlGcyNs90iDicXjPoi+yWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0siBT/b2VmthTPuWZweSvw/RHfioSPFlRriDdy+/Ij7IcTOBuLxsODM9K7MaNarl
	 DwN6TRFSdojd23XGw1EIbS6yjmRMovC2qDnxf/qO2z277lU4tR8BTBPlOeB1Bi8W2M
	 yDuNyqOxI8SWVOeUNjQDypPkA3ae5lVu3/eeArT374tolp89qIheSVEl7tte+H5SbW
	 JAoItYzVWUM+RLi4j4inaPRX4DrxEfKh8wveVJzfE75usQh/l58t1IlU1BiM51KKlB
	 qTgeDH9l20TcqQOXVGQ+GCzkb2638WG/n0MG590+YIUa53gM3ndT9MlPTrg50hnoYp
	 bl9rBhdX6akvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: set max_agbno to allow sparse alloc of last full inode chunk
Date: Tue, 20 Jan 2026 21:13:29 -0500
Message-ID: <20260121021329.1126671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012007-legal-directly-ad82@gregkh>
References: <2026012007-legal-directly-ad82@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210646-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 18FE54F932
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
index b83e54c709069..fc6cf445123ea 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -791,14 +791,15 @@ xfs_ialloc_ag_alloc(
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
 
 		error = xfs_alloc_vextent_near_bno(&args,
 				XFS_AGB_TO_FSB(args.mp, pag->pag_agno,
-- 
2.51.0


