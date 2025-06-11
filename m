Return-Path: <stable+bounces-152465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF7AD6093
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E46C7ACD90
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396D2BD586;
	Wed, 11 Jun 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGORpscj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085E235048
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675707; cv=none; b=HKtR5fSpi7b63iddTKxb05xpurQJrbsYtvDhYPKCJE1VpkjelyzI5JzEkZn1MASVtxDr6sgLXto1mhm8UQe2xLL9aEPD9mvzTvmgvHCh/dOZwaP1bT9OSJwfbGZxRnt5urSimOhOIqlJrNGsL+DEMAAgC1CvypmStVFSYCzdyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675707; c=relaxed/simple;
	bh=fEnqQJBoIMspiHc1+iYaC6/No+0b26zdA/A01NogzlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdK9r5GLtHnmFMtEssaLetsdQPl9YyW3OtwQFtRrs4yXJwdwq+xY20L6plRmNRe1LawD1tko54s0LwOMo729/z1qB7hxMOnAXZvXkWA+IRcaRP3O83lnhjh5uoBlYrZzj4YJ8J/L44c498VDyg2AmGjCJB4Fx+O2Grs1YmXIS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGORpscj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b440afa7so2794725ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675705; x=1750280505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irxgzmDMwFI/i01CgqOCDO3hWCgkpNmdZEJK8uZPb5I=;
        b=GGORpscjnS39W1YMgQEGoJrgu/DuxPXdK50rrXSEzHoKrnR5Gd6SbuiQi2yH74r5fS
         v5esOdZPF14OWglScHUrGZxVDa1xW9Zy33FHcRnh/UqjsoTDNGYMlbSL76BzLS7Lz65T
         lUv1ygf7FOxxuVPRHL/YpaAJyyTPnV9kgRMtZo0yEG85KvNl+nZIX4Y/T/UJ7GJo0wDt
         NbQe7YOIQ+YK/Cq8deJVr39MLRZcgYqE8KtGjeWMnDzWTbJzzweRQk1YsmfBtSf0jxDo
         LFSmSCqTAvQ6z9TdBUcEkXI73vh5llSGay5Mt6Fz3e7tEIXomLibDFOPCwRDNdqczT6c
         tGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675705; x=1750280505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irxgzmDMwFI/i01CgqOCDO3hWCgkpNmdZEJK8uZPb5I=;
        b=tFlzuyCtaiwP1ghcbZTjdrqUsQIiDF7QFUYrO5WKIFOVgin3/XbLiHyZ6cX1IAK3LM
         GDPLuwPrWBETHYGHkib2WUHzK1lxeXl4l0wpJWV3wn/G27EF9z3CRK/a1efEORIILkde
         vYeLx6TatumTfUs6SjDOA+Dw4NlFU0muMUCvt7SAsNPlTy4589StE01YfGGhT0my48Rn
         zyOqde6puOqkLkAe+7UFFHiTQTOaNsJHafJ8uUkFxSYDycYUbsdquYSxy/vMGJtUU2ez
         bWNuG/kvak4sWuMgXcIWGRHWyIAk7WKsSVF3JhFzkw5FULBfu8Dd92WmUHEu1n8C0F0T
         sKVg==
X-Gm-Message-State: AOJu0YwVhn2RVvj12I2eRbCgjEEewK/N4PQMSLN8bRcdMRQB8n4+8uLp
	6YNr7AFGnTuBHDc+cb1vup6ieQ/K7RalB9EIvs2fhdOSvDGQ7hPeHfK+BNxqU9+f
X-Gm-Gg: ASbGncvcnpLI3Dz8O/DVhTvH8PIWDUtU22LXKCz/NlKcPEJ6G1+JzupSfrXI1HPYSTE
	/Vdc7dB9+qZ2nOYFsbEfxe97g5O+fcqggQAwPmqDAfcbS2Ln3WzXYbwEc7ylmZC4nmq/uvkOCJQ
	/4fCUsi46d0MIRhhjVLGZj7YYFfGLXfig+rd1/1hxKjVcqkUDWlyYbREmtxuLzoEZoKHBmei3Jp
	wm4YBwrnxjgYED8t1jTRkZrdAe1XFVh/0Au7hTdVWbsppLbrEP6MRT280JTH+YxJoihLKzmuoxA
	xAuU5VF5np4gIiUyi93a+f+EPJx/pJElcRoMyLyGwNUlE8muw/b9TioFfpemg0vBZg5WIV4uCDA
	cvji1EbORkXY=
X-Google-Smtp-Source: AGHT+IGq8wOz44Y7oKvzKYohp/+55NoVy3HFWTVe8K/WeQ+tO+fumo3DtvzHTVp1v6u/1Z9ROXKTOw==
X-Received: by 2002:a17:903:1b10:b0:234:8f5d:e3b6 with SMTP id d9443c01a7336-23641aa2481mr57836115ad.3.1749675701345;
        Wed, 11 Jun 2025 14:01:41 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:40 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 08/23] xfs: fix an agbno overflow in __xfs_getfsmap_datadev
Date: Wed, 11 Jun 2025 14:01:12 -0700
Message-ID: <20250611210128.67687-9-leah.rumancik@gmail.com>
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

[ Upstream commit cfa2df68b7ceb49ac9eb2d295ab0c5974dbf17e7 ]

Dave Chinner reported that xfs/273 fails if the AG size happens to be an
exact power of two.  I traced this to an agbno integer overflow when the
current GETFSMAP call is a continuation of a previous GETFSMAP call, and
the last record returned was non-shareable space at the end of an AG.

__xfs_getfsmap_datadev sets up a data device query by converting the
incoming fmr_physical into an xfs_fsblock_t and cracking it into an agno
and agbno pair.  In the (failing) case of where fmr_blockcount of the
low key is nonzero and the record was for a non-shareable extent, it
will add fmr_blockcount to start_fsb and info->low.rm_startblock.

If the low key was actually the last record for that AG, then this
addition causes info->low.rm_startblock to point beyond EOAG.  When the
rmapbt range query starts, it'll return an empty set, and fsmap moves on
to the next AG.

Or so I thought.  Remember how we added to start_fsb?

If agsize < 1<<agblklog, start_fsb points to the same AG as the original
fmr_physical from the low key.  We run the rmapbt query, which returns
nothing, so getfsmap zeroes info->low and moves on to the next AG.

If agsize == 1<<agblklog, start_fsb now points to the next AG.  We run
the rmapbt query on the next AG with the excessively large
rm_startblock.  If this next AG is actually the last AG, we'll set
info->high to EOFS (which is now has a lower rm_startblock than
info->low), and the ranged btree query code will return -EINVAL.  If
it's not the last AG, we ignore all records for the intermediate AGs.

Oops.

Fix this by decoding start_fsb into agno and agbno only after making
adjustments to start_fsb.  This means that info->low.rm_startblock will
always be set to a valid agbno, and we always start the rmapbt iteration
in the correct AG.

While we're at it, fix the predicate for determining if an fsmap record
represents non-shareable space to include file data on pre-reflink
filesystems.

Reported-by: Dave Chinner <david@fromorbit.com>
Fixes: 63ef7a35912dd ("xfs: fix interval filtering in multi-step fsmap queries")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index d10f2c719220..956a5670e56c 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -563,10 +563,23 @@ xfs_getfsmap_rtdev_rtbitmap(
 	xfs_iunlock(mp->m_rbmip, XFS_ILOCK_SHARED);
 	return error;
 }
 #endif /* CONFIG_XFS_RT */
 
+static inline bool
+rmap_not_shareable(struct xfs_mount *mp, const struct xfs_rmap_irec *r)
+{
+	if (!xfs_has_reflink(mp))
+		return true;
+	if (XFS_RMAP_NON_INODE_OWNER(r->rm_owner))
+		return true;
+	if (r->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK |
+			   XFS_RMAP_UNWRITTEN))
+		return true;
+	return false;
+}
+
 /* Execute a getfsmap query against the regular data device. */
 STATIC int
 __xfs_getfsmap_datadev(
 	struct xfs_trans		*tp,
 	const struct xfs_fsmap		*keys,
@@ -596,35 +609,33 @@ __xfs_getfsmap_datadev(
 	/*
 	 * Convert the fsmap low/high keys to AG based keys.  Initialize
 	 * low to the fsmap low key and max out the high key to the end
 	 * of the AG.
 	 */
-	info->low.rm_startblock = XFS_FSB_TO_AGBNO(mp, start_fsb);
 	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
 	error = xfs_fsmap_owner_to_rmap(&info->low, &keys[0]);
 	if (error)
 		return error;
 	info->low.rm_blockcount = XFS_BB_TO_FSBT(mp, keys[0].fmr_length);
 	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
 
 	/* Adjust the low key if we are continuing from where we left off. */
 	if (info->low.rm_blockcount == 0) {
-		/* empty */
-	} else if (XFS_RMAP_NON_INODE_OWNER(info->low.rm_owner) ||
-		   (info->low.rm_flags & (XFS_RMAP_ATTR_FORK |
-					  XFS_RMAP_BMBT_BLOCK |
-					  XFS_RMAP_UNWRITTEN))) {
-		info->low.rm_startblock += info->low.rm_blockcount;
+		/* No previous record from which to continue */
+	} else if (rmap_not_shareable(mp, &info->low)) {
+		/* Last record seen was an unshareable extent */
 		info->low.rm_owner = 0;
 		info->low.rm_offset = 0;
 
 		start_fsb += info->low.rm_blockcount;
 		if (XFS_FSB_TO_DADDR(mp, start_fsb) >= eofs)
 			return 0;
 	} else {
+		/* Last record seen was a shareable file data extent */
 		info->low.rm_offset += info->low.rm_blockcount;
 	}
+	info->low.rm_startblock = XFS_FSB_TO_AGBNO(mp, start_fsb);
 
 	info->high.rm_startblock = -1U;
 	info->high.rm_owner = ULLONG_MAX;
 	info->high.rm_offset = ULLONG_MAX;
 	info->high.rm_blockcount = 0;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


