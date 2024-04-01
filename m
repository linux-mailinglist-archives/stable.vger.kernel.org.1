Return-Path: <stable+bounces-35040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F9894210
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BE3B2217D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42065481C6;
	Mon,  1 Apr 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drV+2Bpg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4B1C0DE7;
	Mon,  1 Apr 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990143; cv=none; b=UDP+1mZNMFwscWYurdimK21K908cs97xYMkXv5J2j4LguDu1Wm1nLsVc2Wfx+gjGM/cRLmTVG/WN8sEfRn/pzNtG47hrwPW/iLflZmjUDhVm4oQDbGkMKLoZnZhBBBU1dCN+MSttUQ5jaZfRInTa9PIErEE2EzZDI8eIuz2uR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990143; c=relaxed/simple;
	bh=wlRWm2MUCvdLABE/Xx3rP4jiBp2MGTuSZvoU/OSfCtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ7c+E/2Bi6+OqK98RW2XdSvSgwGAU+XOFHE5dMZA7ugDN6w8uh2/uBk2yT1axbVwTxGdDdi1OXiWS74IaKf5HuLLYHhoODhRR0gERrVSNy1e7sLTg5Bdd/2EQSHsdHeSjKlxqoJKbX2vMDXjzEDwNoKtrpWGb+HMFt3efcwaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drV+2Bpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59487C433C7;
	Mon,  1 Apr 2024 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990142;
	bh=wlRWm2MUCvdLABE/Xx3rP4jiBp2MGTuSZvoU/OSfCtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drV+2BpgVZViemNYuOtB6oMnlg7GDXLAvg5C4ID5/aWdBkkeGwYqw4tI0QFvCWzkH
	 Ee57i+hgMBMhBy9ag5VQMreTI3O1wrj03cGPoZhxQS7hOk5YO/wdmNX0jZkXs7/RQF
	 a5R/xpXX+HwyNPUB4RAufn76wMTZD394BBKoi+bE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: [PATCH 6.6 260/396] xfs: make rextslog computation consistent with mkfs
Date: Mon,  1 Apr 2024 17:45:09 +0200
Message-ID: <20240401152555.659128732@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <djwong@kernel.org>

commit a6a38f309afc4a7ede01242b603f36c433997780 upstream.

[backport: resolve merge conflicts due to refactoring rtbitmap/summary
macros and accessors]

There's a weird discrepancy in xfsprogs dating back to the creation of
the Linux port -- if there are zero rt extents, mkfs will set
sb_rextents and sb_rextslog both to zero:

	sbp->sb_rextslog =
		(uint8_t)(rtextents ?
			libxfs_highbit32((unsigned int)rtextents) : 0);

However, that's not the check that xfs_repair uses for nonzero rtblocks:

	if (sb->sb_rextslog !=
			libxfs_highbit32((unsigned int)sb->sb_rextents))

The difference here is that xfs_highbit32 returns -1 if its argument is
zero.  Unfortunately, this means that in the weird corner case of a
realtime volume shorter than 1 rt extent, xfs_repair will immediately
flag a freshly formatted filesystem as corrupt.  Because mkfs has been
writing ondisk artifacts like this for decades, we have to accept that
as "correct".  TBH, zero rextslog for zero rtextents makes more sense to
me anyway.

Regrettably, the superblock verifier checks created in commit copied
xfs_repair even though mkfs has been writing out such filesystems for
ages.  Fix the superblock verifier to accept what mkfs spits out; the
userspace version of this patch will have to fix xfs_repair as well.

Note that the new helper leaves the zeroday bug where the upper 32 bits
of sb_rextents is ripped off and fed to highbit32.  This leads to a
seriously undersized rt summary file, which immediately breaks mkfs:

$ hugedisk.sh foo /dev/sdc $(( 0x100000080 * 4096))B
$ /sbin/mkfs.xfs -f /dev/sda -m rmapbt=0,reflink=0 -r rtdev=/dev/mapper/foo
meta-data=/dev/sda               isize=512    agcount=4, agsize=1298176 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=0    bigtime=1 inobtcount=1 nrext64=1
data     =                       bsize=4096   blocks=5192704, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =/dev/mapper/foo        extsz=4096   blocks=4294967424, rtextents=4294967424
Discarding blocks...Done.
mkfs.xfs: Error initializing the realtime space [117 - Structure needs cleaning]

The next patch will drop support for rt volumes with fewer than 1 or
more than 2^32-1 rt extents, since they've clearly been broken forever.

Fixes: f8e566c0f5e1f ("xfs: validate the realtime geometry in xfs_validate_sb_common")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c |   13 +++++++++++++
 fs/xfs/libxfs/xfs_rtbitmap.h |    4 ++++
 fs/xfs/libxfs/xfs_sb.c       |    3 ++-
 fs/xfs/xfs_rtalloc.c         |    4 ++--
 4 files changed, 21 insertions(+), 3 deletions(-)

--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1130,3 +1130,16 @@ xfs_rtalloc_extent_is_free(
 	*is_free = matches;
 	return 0;
 }
+
+/*
+ * Compute the maximum level number of the realtime summary file, as defined by
+ * mkfs.  The use of highbit32 on a 64-bit quantity is a historic artifact that
+ * prohibits correct use of rt volumes with more than 2^32 extents.
+ */
+uint8_t
+xfs_compute_rextslog(
+	xfs_rtbxlen_t		rtextents)
+{
+	return rtextents ? xfs_highbit32(rtextents) : 0;
+}
+
--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -70,6 +70,9 @@ xfs_rtfree_extent(
 /* Same as above, but in units of rt blocks. */
 int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
 		xfs_filblks_t rtlen);
+
+uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
+
 #else /* CONFIG_XFS_RT */
 # define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
 # define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
@@ -77,6 +80,7 @@ int xfs_rtfree_blocks(struct xfs_trans *
 # define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
 # define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
 # define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
+# define xfs_compute_rextslog(rtx)			(0)
 #endif /* CONFIG_XFS_RT */
 
 #endif /* __XFS_RTBITMAP_H__ */
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Physical superblock buffer manipulations. Shared with libxfs in userspace.
@@ -509,7 +510,7 @@ xfs_validate_sb_common(
 				       NBBY * sbp->sb_blocksize);
 
 		if (sbp->sb_rextents != rexts ||
-		    sbp->sb_rextslog != xfs_highbit32(sbp->sb_rextents) ||
+		    sbp->sb_rextslog != xfs_compute_rextslog(rexts) ||
 		    sbp->sb_rbmblocks != rbmblocks) {
 			xfs_notice(mp,
 				"realtime geometry sanity check failed");
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -999,7 +999,7 @@ xfs_growfs_rt(
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
-	nrextslog = xfs_highbit32(nrextents);
+	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;
 	nrsumsize = (uint)sizeof(xfs_suminfo_t) * nrsumlevels * nrbmblocks;
 	nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
@@ -1061,7 +1061,7 @@ xfs_growfs_rt(
 		nsbp->sb_rextents = nsbp->sb_rblocks;
 		do_div(nsbp->sb_rextents, nsbp->sb_rextsize);
 		ASSERT(nsbp->sb_rextents != 0);
-		nsbp->sb_rextslog = xfs_highbit32(nsbp->sb_rextents);
+		nsbp->sb_rextslog = xfs_compute_rextslog(nsbp->sb_rextents);
 		nrsumlevels = nmp->m_rsumlevels = nsbp->sb_rextslog + 1;
 		nrsumsize =
 			(uint)sizeof(xfs_suminfo_t) * nrsumlevels *



