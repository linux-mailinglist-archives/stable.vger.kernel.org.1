Return-Path: <stable+bounces-152455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC13AD6088
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE38170848
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EE1DF754;
	Wed, 11 Jun 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPczkoGv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE661F4CB7
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675696; cv=none; b=iit0gKWEWapqeCf4bZtUXcIIgDKGvebAItptNZxIJ++ARkOun6AIRCcQCH8g9RBSKQHWs2cmdjf7gOtIumH3CIcpztf13h9hMm5lKv2gIVeDKSxw2WEMDqnuspkqJIGBUPrl4cb/KgvpS4h+PmQ954eJ4Rp2/ImaaDWIT0z66as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675696; c=relaxed/simple;
	bh=VWBoaCxAmIMnz54CMQbxhSzBz1AWEstUXWLdCpea0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTzN+QcA8KlFeLDcFRl0RQV6eeBGo0RxquHYMinNpYEDXTisdVnC3poRoVG/s++0nc8vrS6RzRRyP26RWgQp5w3HshsEl8aj/KtbAAUJfGSlaWL2RrhufH7n8y3XL3/rVdvvGcAiqVlj0dNsjaDfVKawT7kYBkwKwz2P40h/Gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPczkoGv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23633a6ac50so3357435ad.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675694; x=1750280494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww0hw4Ccp0MvOStn5WuUvvxubcuTsLiTa/wGHZU77PQ=;
        b=XPczkoGvi2xh5/vAGC0ju2n1xdfpriNdFbIICUBWb/+XSIii9om+RAoaR4hkhyr3hX
         XFTpdU+TTqdwpCYVSPNXWURGUgwi3kQ4Fns2sVjO4BEU2OADmtCZIUehuGr92GOenIL7
         bCgZpBXk+50OOv9DLriFUOu5NKZ4ggwvcRuwfuJUR2kXfJxnBM0brCWNVtE2PAzlTQcH
         ZN7UNwiqKGRFDsv0hMYg3ewAghhVZWe9uperujBfsDXGKAmFjPFL7/qql+xs6J7GTk7c
         o5ORAUdwK3HdwcFr2kUN3ZBK4yD4G2Luz9rVc7HAK5HF2VK2KUrnBdYpYQdDJ8sp7O9d
         7zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675694; x=1750280494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww0hw4Ccp0MvOStn5WuUvvxubcuTsLiTa/wGHZU77PQ=;
        b=UpwfUNTlrxo0TcpJz7R2X8zbm00+cZtt2C4vb24hMOsI2pIqb0rA/cWKJq5lKgFf1O
         wnEEKNEIfc5Z/iC+nROgeXfjmG1vNqtSQNJg4EjQRc8ClbVsENb2weMpqQNW/oxpmOPY
         uonS4mYy9wG5UUO7ps4QM4mJY9H3MK1cZFNrnzxWK/BRao74VBbnrRUQc0jkLfE+vjbv
         e8rn39TKQ9m99hAZlqlIu+aDL4rFpcYLUKOv/hTzVKZzpePIQUHevPlwC7no3LMZMcxS
         oWLd2pV1lZ9uWw3t6N9LpX5+c+EhJ+jM3aX+JN5KTZZFgNNgIcBEA5dNkzY6P5ayqu+m
         KNmA==
X-Gm-Message-State: AOJu0Yx7V2cEdf61IstCjAQVZ5jj75+UFGCU1FTjHTU/v/l5tXOvK/Tr
	J+0SLEKc8UaXESNe9AO/onTnUY9D9vUC+hZVcfB1VUFVjAMuWFwXjsopvNWtSqPx
X-Gm-Gg: ASbGncvzOmtOFu3hSA5YwH5zSjWqnuigafUgU52Dxz4MoqKarMaUX/CLTbMHI4fQEzJ
	z7mgjaRmcAVr7FZ30coy0XYOIcxWq3O6NMbacKKr0S3494YDgd8lbj9M1OuQx5cOPWECLjJycgf
	vG0rU3tyzZWaya3uY1hfU2FEvaUNoEzGVTtbYYsCdowePH9OAOMI/RNn4uZocN/aOZNOBfV9xHK
	n+X3vbFvE4l96J4J78VzG8+qFuChLw2Gkt8e/A6tjU0Nv7lQa+OKx6ap7NtlegESlTwe/UhyyY4
	fEp9zaolRItUpXNcdKBjGmjyZmvSdweSF+0XOilP5rtUNw+qLbhahNV4UXYIvAx+6iO+D4+OB9K
	v1L/NN34QFgQ=
X-Google-Smtp-Source: AGHT+IEtEctNCpLfeND31gnztlK0L8ovT9L90Cf3j8wl5U2OeNKWJoY8NBJKGlvHnkEgm6/hPGgq8w==
X-Received: by 2002:a17:902:ecc1:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-23641b1994emr56830135ad.27.1749675693922;
        Wed, 11 Jun 2025 14:01:33 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:33 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 01/23] xfs: fix interval filtering in multi-step fsmap queries
Date: Wed, 11 Jun 2025 14:01:05 -0700
Message-ID: <20250611210128.67687-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 63ef7a35912dd743cabd65d5bb95891625c0dd46 ]

I noticed a bug in ranged GETFSMAP queries:

# xfs_io -c 'fsmap -vvvv' /opt
 EXT: DEV  BLOCK-RANGE           OWNER              FILE-OFFSET      AG AG-OFFSET           TOTAL
   0: 8:80 [0..7]:               static fs metadata                  0  (0..7)                  8
<snip>
   9: 8:80 [192..223]:           137                0..31            0  (192..223)             32
# xfs_io -c 'fsmap -vvvv -d 208 208' /opt
#

That's not right -- we asked what block maps block 208, and we should've
received a mapping for inode 137 offset 16.  Instead, we get nothing.

The root cause of this problem is a mis-interaction between the fsmap
code and how btree ranged queries work.  xfs_btree_query_range returns
any btree record that overlaps with the query interval, even if the
record starts before or ends after the interval.  Similarly, GETFSMAP is
supposed to return a recordset containing all records that overlap the
range queried.

However, it's possible that the recordset is larger than the buffer that
the caller provided to convey mappings to userspace.  In /that/ case,
userspace is supposed to copy the last record returned to fmh_keys[0]
and call GETFSMAP again.  In this case, we do not want to return
mappings that we have already supplied to the caller.  The call to
xfs_btree_query_range is the same, but now we ignore any records that
start before fmh_keys[0].

Unfortunately, we didn't implement the filtering predicate correctly.
The predicate should only be called when we're calling back for more
records.  Accomplish this by setting info->low.rm_blockcount to a
nonzero value and ensuring that it is cleared as necessary.  As a
result, we no longer want to adjust dkeys[0] in the main setup function
because that's confusing.

This patch doesn't touch the logdev/rtbitmap backends because they have
bigger problems that will be addressed by subsequent patches.

Found via xfs/556 with parent pointers enabled.

Fixes: e89c041338ed ("xfs: implement the GETFSMAP ioctl")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 67 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index a5b9754c62d1..2011f1bf7ce0 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -160,11 +160,18 @@ struct xfs_getfsmap_info {
 	struct xfs_buf		*agf_bp;	/* AGF, for refcount queries */
 	struct xfs_perag	*pag;		/* AG info, if applicable */
 	xfs_daddr_t		next_daddr;	/* next daddr we expect */
 	u64			missing_owner;	/* owner of holes */
 	u32			dev;		/* device id */
-	struct xfs_rmap_irec	low;		/* low rmap key */
+	/*
+	 * Low rmap key for the query.  If low.rm_blockcount is nonzero, this
+	 * is the second (or later) call to retrieve the recordset in pieces.
+	 * xfs_getfsmap_rec_before_start will compare all records retrieved
+	 * by the rmapbt query to filter out any records that start before
+	 * the last record.
+	 */
+	struct xfs_rmap_irec	low;
 	struct xfs_rmap_irec	high;		/* high rmap key */
 	bool			last;		/* last extent? */
 };
 
 /* Associate a device with a getfsmap handler. */
@@ -235,34 +242,45 @@ xfs_getfsmap_format(
 
 	rec = &info->fsmap_recs[info->head->fmh_entries++];
 	xfs_fsmap_from_internal(rec, xfm);
 }
 
+static inline bool
+xfs_getfsmap_rec_before_start(
+	struct xfs_getfsmap_info	*info,
+	const struct xfs_rmap_irec	*rec,
+	xfs_daddr_t			rec_daddr)
+{
+	if (info->low.rm_blockcount)
+		return xfs_rmap_compare(rec, &info->low) < 0;
+	return false;
+}
+
 /*
  * Format a reverse mapping for getfsmap, having translated rm_startblock
  * into the appropriate daddr units.
  */
 STATIC int
 xfs_getfsmap_helper(
 	struct xfs_trans		*tp,
 	struct xfs_getfsmap_info	*info,
 	const struct xfs_rmap_irec	*rec,
 	xfs_daddr_t			rec_daddr)
 {
 	struct xfs_fsmap		fmr;
 	struct xfs_mount		*mp = tp->t_mountp;
 	bool				shared;
 	int				error;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
 	/*
 	 * Filter out records that start before our startpoint, if the
 	 * caller requested that.
 	 */
-	if (xfs_rmap_compare(rec, &info->low) < 0) {
+	if (xfs_getfsmap_rec_before_start(info, rec, rec_daddr)) {
 		rec_daddr += XFS_FSB_TO_BB(mp, rec->rm_blockcount);
 		if (info->next_daddr < rec_daddr)
 			info->next_daddr = rec_daddr;
 		return 0;
 	}
@@ -604,13 +622,31 @@ __xfs_getfsmap_datadev(
 	info->low.rm_startblock = XFS_FSB_TO_AGBNO(mp, start_fsb);
 	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
 	error = xfs_fsmap_owner_to_rmap(&info->low, &keys[0]);
 	if (error)
 		return error;
-	info->low.rm_blockcount = 0;
+	info->low.rm_blockcount = XFS_BB_TO_FSBT(mp, keys[0].fmr_length);
 	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
 
+	/* Adjust the low key if we are continuing from where we left off. */
+	if (info->low.rm_blockcount == 0) {
+		/* empty */
+	} else if (XFS_RMAP_NON_INODE_OWNER(info->low.rm_owner) ||
+		   (info->low.rm_flags & (XFS_RMAP_ATTR_FORK |
+					  XFS_RMAP_BMBT_BLOCK |
+					  XFS_RMAP_UNWRITTEN))) {
+		info->low.rm_startblock += info->low.rm_blockcount;
+		info->low.rm_owner = 0;
+		info->low.rm_offset = 0;
+
+		start_fsb += info->low.rm_blockcount;
+		if (XFS_FSB_TO_DADDR(mp, start_fsb) >= eofs)
+			return 0;
+	} else {
+		info->low.rm_offset += info->low.rm_blockcount;
+	}
+
 	info->high.rm_startblock = -1U;
 	info->high.rm_owner = ULLONG_MAX;
 	info->high.rm_offset = ULLONG_MAX;
 	info->high.rm_blockcount = 0;
 	info->high.rm_flags = XFS_RMAP_KEY_FLAGS | XFS_RMAP_REC_FLAGS;
@@ -657,16 +693,12 @@ __xfs_getfsmap_datadev(
 
 		/*
 		 * Set the AG low key to the start of the AG prior to
 		 * moving on to the next AG.
 		 */
-		if (pag->pag_agno == start_ag) {
-			info->low.rm_startblock = 0;
-			info->low.rm_owner = 0;
-			info->low.rm_offset = 0;
-			info->low.rm_flags = 0;
-		}
+		if (pag->pag_agno == start_ag)
+			memset(&info->low, 0, sizeof(info->low));
 
 		/*
 		 * If this is the last AG, report any gap at the end of it
 		 * before we drop the reference to the perag when the loop
 		 * terminates.
@@ -899,25 +931,21 @@ xfs_getfsmap(
 	 *
 	 * If the low key mapping refers to file data, the same physical
 	 * blocks could be mapped to several other files/offsets.
 	 * According to rmapbt record ordering, the minimal next
 	 * possible record for the block range is the next starting
-	 * offset in the same inode. Therefore, bump the file offset to
-	 * continue the search appropriately.  For all other low key
-	 * mapping types (attr blocks, metadata), bump the physical
-	 * offset as there can be no other mapping for the same physical
-	 * block range.
+	 * offset in the same inode. Therefore, each fsmap backend bumps
+	 * the file offset to continue the search appropriately.  For
+	 * all other low key mapping types (attr blocks, metadata), each
+	 * fsmap backend bumps the physical offset as there can be no
+	 * other mapping for the same physical block range.
 	 */
 	dkeys[0] = head->fmh_keys[0];
 	if (dkeys[0].fmr_flags & (FMR_OF_SPECIAL_OWNER | FMR_OF_EXTENT_MAP)) {
-		dkeys[0].fmr_physical += dkeys[0].fmr_length;
-		dkeys[0].fmr_owner = 0;
 		if (dkeys[0].fmr_offset)
 			return -EINVAL;
-	} else
-		dkeys[0].fmr_offset += dkeys[0].fmr_length;
-	dkeys[0].fmr_length = 0;
+	}
 	memset(&dkeys[1], 0xFF, sizeof(struct xfs_fsmap));
 
 	if (!xfs_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
 		return -EINVAL;
 
@@ -958,10 +986,11 @@ xfs_getfsmap(
 			break;
 
 		info.dev = handlers[i].dev;
 		info.last = false;
 		info.pag = NULL;
+		info.low.rm_blockcount = 0;
 		error = handlers[i].fn(tp, dkeys, &info);
 		if (error)
 			break;
 		xfs_trans_cancel(tp);
 		tp = NULL;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


