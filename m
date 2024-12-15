Return-Path: <stable+bounces-104247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A69F22A9
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039861886A15
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528113E03A;
	Sun, 15 Dec 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMHPsAqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7513D28F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252744; cv=none; b=PY15+WxhnKqRCY0sXOK9633ChBh/1w11nK5FwTGdXnl8Zz0W/yMXCBP9hOlX8eClFTzxgmpSHcCMWVIRnDClrInuUikCEJT/pGSXae71gLx0Ofkk4vLz51IIwp86WOaRCuekkSHWt1cV5MwQvwyMn9RX7WFA+30jVAbz2JWGSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252744; c=relaxed/simple;
	bh=+vRyCY6/SIrF+7NIRa4ZQwcfAYQ+65FoiP94z54+o7I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tX8mYon/VfDooRIpV8YdKgH+O3h83aFwoQzwhoXAOVa6HIUuMXJKJJmHqdSz3GZojD8K5cHZGEXZy3618CJD7qCnBOePRW0tzo+YrBl66wUBXViwi+bItj/196rREH6KmBlHeeeu9l0EZyhINEqgk+SvnJywMHHcYjNV81iLvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMHPsAqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473B2C4CECE;
	Sun, 15 Dec 2024 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252743;
	bh=+vRyCY6/SIrF+7NIRa4ZQwcfAYQ+65FoiP94z54+o7I=;
	h=Subject:To:Cc:From:Date:From;
	b=rMHPsAqnKcU2OZRr5ZMAzk2Sf00Ayc+NCUQbvY8T9gYLy7OtfMmCGvYPfi9uN+dCx
	 ruER7ME9vg1yqq9tjatKMpyI0tllaxc7+m9VBLC4YZTykaLsKl2FCrLj4cGlaoezqH
	 4p0kXzyI8HYW+d3DwSu1DcfGTTUL/9pnNptw3Q/s=
Subject: FAILED: patch "[PATCH] xfs: fix zero byte checking in the superblock scrubber" failed to apply to 6.12-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:52:20 +0100
Message-ID: <2024121520-distract-perish-f190@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c004a793e0ec34047c3bd423bcd8966f5fac88dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121520-distract-perish-f190@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c004a793e0ec34047c3bd423bcd8966f5fac88dc Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:42 -0800
Subject: [PATCH] xfs: fix zero byte checking in the superblock scrubber

The logic to check that the region past the end of the superblock is all
zeroes is wrong -- we don't want to check only the bytes past the end of
the maximally sized ondisk superblock structure as currently defined in
xfs_format.h; we want to check the bytes beyond the end of the ondisk as
defined by the feature bits.

Port the superblock size logic from xfs_repair and then put it to use in
xfs_scrub.

Cc: <stable@vger.kernel.org> # v4.15
Fixes: 21fb4cb1981ef7 ("xfs: scrub the secondary superblocks")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 88063d67cb5f..9f8c312dfd3c 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -59,6 +59,32 @@ xchk_superblock_xref(
 	/* scrub teardown will take care of sc->sa for us */
 }
 
+/*
+ * Calculate the ondisk superblock size in bytes given the feature set of the
+ * mounted filesystem (aka the primary sb).  This is subtlely different from
+ * the logic in xfs_repair, which computes the size of a secondary sb given the
+ * featureset listed in the secondary sb.
+ */
+STATIC size_t
+xchk_superblock_ondisk_size(
+	struct xfs_mount	*mp)
+{
+	if (xfs_has_metadir(mp))
+		return offsetofend(struct xfs_dsb, sb_pad);
+	if (xfs_has_metauuid(mp))
+		return offsetofend(struct xfs_dsb, sb_meta_uuid);
+	if (xfs_has_crc(mp))
+		return offsetofend(struct xfs_dsb, sb_lsn);
+	if (xfs_sb_version_hasmorebits(&mp->m_sb))
+		return offsetofend(struct xfs_dsb, sb_bad_features2);
+	if (xfs_has_logv2(mp))
+		return offsetofend(struct xfs_dsb, sb_logsunit);
+	if (xfs_has_sector(mp))
+		return offsetofend(struct xfs_dsb, sb_logsectsize);
+	/* only support dirv2 or more recent */
+	return offsetofend(struct xfs_dsb, sb_dirblklog);
+}
+
 /*
  * Scrub the filesystem superblock.
  *
@@ -75,6 +101,7 @@ xchk_superblock(
 	struct xfs_buf		*bp;
 	struct xfs_dsb		*sb;
 	struct xfs_perag	*pag;
+	size_t			sblen;
 	xfs_agnumber_t		agno;
 	uint32_t		v2_ok;
 	__be32			features_mask;
@@ -388,8 +415,8 @@ xchk_superblock(
 	}
 
 	/* Everything else must be zero. */
-	if (memchr_inv(sb + 1, 0,
-			BBTOB(bp->b_length) - sizeof(struct xfs_dsb)))
+	sblen = xchk_superblock_ondisk_size(mp);
+	if (memchr_inv((char *)sb + sblen, 0, BBTOB(bp->b_length) - sblen))
 		xchk_block_set_corrupt(sc, bp);
 
 	xchk_superblock_xref(sc, bp);


