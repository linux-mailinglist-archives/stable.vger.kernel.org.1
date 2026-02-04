Return-Path: <stable+bounces-213716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLPUHjpgg2mfmAMAu9opvQ
	(envelope-from <stable+bounces-213716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18318E7DF9
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B93B3058251
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5929AB1D;
	Wed,  4 Feb 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8XHsQnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72112BEFED;
	Wed,  4 Feb 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217268; cv=none; b=I68ONfiayHPT9+yvis9Waw7N/H2UScdzZr+Rz1YPpOv9UKTQDpHRL9/FaKIhmlC838tgcTZBN/yxcP3EcWa5NrgF7RfCn8BONbBYA1xZsEnj92cOLKYHLNY3fcCuN+av5ZJMggCm4l/NrbJSjFsp+nns6lxGUiM23pXJ0aIQm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217268; c=relaxed/simple;
	bh=KtAw6q3QLq/OYT80MH3/uDcZs0wyhsf1XiQ+lmN7MAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSSBaxYja4smHs9LZtrPPJFpGz5ntCjavtWK2EGmSvGENGRjdoJbHU5dTjSyXS7GJU65pzTviy0igB4Lqe9PtnWzPkiN34T0UWaAFuU/MpnImODZmw3vU2aIDKd/HEf/sLTnK47xUGbcE0B13NzWD/AWiW3bGmYgiLKXbhXpOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w8XHsQnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEC4C19423;
	Wed,  4 Feb 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217268;
	bh=KtAw6q3QLq/OYT80MH3/uDcZs0wyhsf1XiQ+lmN7MAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w8XHsQnfJKol70B+HNoDAtmICgn0eni9T37noZ/6PNf9FHgpL2Kj7hGqr1NOQsUGt
	 lvd5GciUZjtdhtmPj0XFXST6brMOiLKkrSuAE4/Qfad3F5BcZi44QknVheoSIz/rV+
	 WdFFOUAy9j2Lh/s5xys36p+fXJlbOE29QkzjYqUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 166/206] xfs: set max_agbno to allow sparse alloc of last full inode chunk
Date: Wed,  4 Feb 2026 15:39:57 +0100
Message-ID: <20260204143904.185503995@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213716-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 18318E7DF9
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_ialloc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -772,14 +772,15 @@ sparse_alloc:
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



