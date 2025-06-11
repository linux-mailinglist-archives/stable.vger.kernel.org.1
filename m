Return-Path: <stable+bounces-152476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C52AD609C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1953117AF1F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40C235048;
	Wed, 11 Jun 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9xodekz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213C2BD586
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675718; cv=none; b=Z8YQGnJHSw2xGeXxzkAIeHUgvLYgd9HViOvllA8pZGQMCA3YO6LgSKMF3ZYghG/jiHuwB3j7+O59+qbDbF1/YKDrT2NVnvz9I4gF67AQpE4f6bKTDyMEJXmAvbpp30No1hj41V5Q+kgR+aXAMA0e4uncb6naVUs9vH6SpH9jC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675718; c=relaxed/simple;
	bh=HRlVbQHVKUonur6/rDbdcdj5RQwrMnl8Jz2TPwmQjNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ0cYHjxS0kjthAMgEzugOcC5YyN6yQ7QGx0QHmzI/5/q0jA8zchXZhZ0rlf+DyUrpZ0l7HTE6Z3DjYaL2sPjxUbKBOG4BUcJUrzVB1yyVsWnKYsOtmZqRnUTelkFpuR6kHWgCRajfD5KR1dwRa7MLe6zRoD635T60p0jgAV+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9xodekz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c33677183so2583375ad.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675716; x=1750280516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNgT6mCogBaun03aqM7D4rRQ0pA3FbmuNH6YmGuxHKs=;
        b=h9xodekz55apcvtTA+pcBFaU4cBSN/lHpngFw27UZBexdNt+fJ9prLFK5oL7Cha3XV
         Offx/QQhGdgm1GTk2pnJbJVNNNOPq0UE/c/DuBV0sjlb/271Y/7J3DUoDbAXhGBzhAtq
         aXSMq9dphctHKMIMSMEm79DKUF+ilcn4O791RNk0p8hzr5++C3Zf74j9sP0D9+LmuIr0
         n8S133MItJVsZrlaTh8NWfTv1INOE3F9J/1ZeR3bNLnTN/kJprT++syN51OBNp85/Qyo
         qGgxKNfeeV7sAXp71HJu3SVecahjSl3qH0gf7LSacAByp5R1OWWsFvRiYhb4LhofYLoS
         2Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675716; x=1750280516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNgT6mCogBaun03aqM7D4rRQ0pA3FbmuNH6YmGuxHKs=;
        b=r7bawsSGlFzR6t/rUbNNCMeuhB80fjIvBvifZmxAEHxkJSydbu1/l0d7JhDpuzwcyB
         bjFNB3bN+psM5r6osEpcA1E7gMIgoZCn0R1+2TM/+cpBaze6OGajN0jwOeUVHwWdMylE
         9M35W+bOlEpowydL1xMXb8SE+7oTMhi2rrX7nAjjZkLz++Cw2SMP4qdwC50ki0NdmUhZ
         olifVpMWjG6aE1soaD0j897RYTc86o/dZI39UX00HTqK5ueiwldRBfVvfJT3m3+krR6S
         Hn2Ks6tsHcCb5r6eF87bLslf1HjZ1C7IhaqwYj0XPS+9BKLU5Hl7wSozW5wqAvHQduPv
         de1Q==
X-Gm-Message-State: AOJu0Yzb4LsRcjXLjdN+fyZcJjMHXlfdDMBt4BRMBHpIPx70g0Uxjwmu
	mrj1PSyffw8zbSzpm9hHwOILvs0EQTu1/wpBJIFowkhwz38IXI1ERHznhaOCjYk5
X-Gm-Gg: ASbGncuhJ+PPQK6nX6bTzj6hOwL/KLckXGXBnMT9YLVnlSAP1AcACtYqI0YhDfXPBNU
	yP2x3bC3ty9DH3V2RFMdnaCxZPwEN4jCnjuimPHCIdR3hsNCK1U67Vrqnj6bSnMUDcq7Cugo61s
	MBy9YvkrS/8qKB5fMUgWOubkBWEtinJGvLeNhOZpvtgjQehp3QymY94OJB2b/Xe0SbDD2/ixo6f
	Ue/RWJClOBgcQKwAFo8ppRYL32EqFoHQDodSp4zr5kdAOlLckEOgN1MdOjtNHbenjjZcIb44g/4
	D961vifo9xGYZG9FKpjjdXVmJGJgJcvPKAAsXyRMXCd2DS8KSQT82keZcy4KXtejAPfY7H5n9fw
	0QEuBDEzlxFo=
X-Google-Smtp-Source: AGHT+IHbpUhEa9TVPUU3+fAHAmwOMDV9WTzF9fz+wyK1vq9GcNI6sPypMQS10881aLt9i/hyVh81Ww==
X-Received: by 2002:a17:902:d50c:b0:234:9068:ed99 with SMTP id d9443c01a7336-2364ca8552bmr13898475ad.24.1749675716252;
        Wed, 11 Jun 2025 14:01:56 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:55 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 22/23] xfs: take m_growlock when running growfsrt
Date: Wed, 11 Jun 2025 14:01:26 -0700
Message-ID: <20250611210128.67687-23-leah.rumancik@gmail.com>
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

[ Upstream commit 16e1fbdce9c8d084863fd63cdaff8fb2a54e2f88 ]

Take the grow lock when we're expanding the realtime volume, like we do
for the other growfs calls.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 5cf1e91f4c20..149fcfc485d8 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -951,83 +951,93 @@ xfs_growfs_rt(
 		return -EPERM;
 
 	/* Needs to have been mounted with an rt device. */
 	if (!XFS_IS_REALTIME_MOUNT(mp))
 		return -EINVAL;
+
+	if (!mutex_trylock(&mp->m_growlock))
+		return -EWOULDBLOCK;
 	/*
 	 * Mount should fail if the rt bitmap/summary files don't load, but
 	 * we'll check anyway.
 	 */
+	error = -EINVAL;
 	if (!mp->m_rbmip || !mp->m_rsumip)
-		return -EINVAL;
+		goto out_unlock;
 
 	/* Shrink not supported. */
 	if (in->newblocks <= sbp->sb_rblocks)
-		return -EINVAL;
+		goto out_unlock;
 
 	/* Can only change rt extent size when adding rt volume. */
 	if (sbp->sb_rblocks > 0 && in->extsize != sbp->sb_rextsize)
-		return -EINVAL;
+		goto out_unlock;
 
 	/* Range check the extent size. */
 	if (XFS_FSB_TO_B(mp, in->extsize) > XFS_MAX_RTEXTSIZE ||
 	    XFS_FSB_TO_B(mp, in->extsize) < XFS_MIN_RTEXTSIZE)
-		return -EINVAL;
+		goto out_unlock;
 
 	/* Unsupported realtime features. */
+	error = -EOPNOTSUPP;
 	if (xfs_has_rmapbt(mp) || xfs_has_reflink(mp) || xfs_has_quota(mp))
-		return -EOPNOTSUPP;
+		goto out_unlock;
 
 	nrblocks = in->newblocks;
 	error = xfs_sb_validate_fsb_count(sbp, nrblocks);
 	if (error)
-		return error;
+		goto out_unlock;
 	/*
 	 * Read in the last block of the device, make sure it exists.
 	 */
 	error = xfs_buf_read_uncached(mp->m_rtdev_targp,
 				XFS_FSB_TO_BB(mp, nrblocks - 1),
 				XFS_FSB_TO_BB(mp, 1), 0, &bp, NULL);
 	if (error)
-		return error;
+		goto out_unlock;
 	xfs_buf_relse(bp);
 
 	/*
 	 * Calculate new parameters.  These are the final values to be reached.
 	 */
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
-	if (!xfs_validate_rtextents(nrextents))
-		return -EINVAL;
+	if (!xfs_validate_rtextents(nrextents)) {
+		error = -EINVAL;
+		goto out_unlock;
+	}
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
 	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;
 	nrsumsize = (uint)sizeof(xfs_suminfo_t) * nrsumlevels * nrbmblocks;
 	nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
 	nrsumsize = XFS_FSB_TO_B(mp, nrsumblocks);
 	/*
 	 * New summary size can't be more than half the size of
 	 * the log.  This prevents us from getting a log overflow,
 	 * since we'll log basically the whole summary file at once.
 	 */
-	if (nrsumblocks > (mp->m_sb.sb_logblocks >> 1))
-		return -EINVAL;
+	if (nrsumblocks > (mp->m_sb.sb_logblocks >> 1)) {
+		error = -EINVAL;
+		goto out_unlock;
+	}
+
 	/*
 	 * Get the old block counts for bitmap and summary inodes.
 	 * These can't change since other growfs callers are locked out.
 	 */
 	rbmblocks = XFS_B_TO_FSB(mp, mp->m_rbmip->i_disk_size);
 	rsumblocks = XFS_B_TO_FSB(mp, mp->m_rsumip->i_disk_size);
 	/*
 	 * Allocate space to the bitmap and summary files, as necessary.
 	 */
 	error = xfs_growfs_rt_alloc(mp, rbmblocks, nrbmblocks, mp->m_rbmip);
 	if (error)
-		return error;
+		goto out_unlock;
 	error = xfs_growfs_rt_alloc(mp, rsumblocks, nrsumblocks, mp->m_rsumip);
 	if (error)
-		return error;
+		goto out_unlock;
 
 	rsum_cache = mp->m_rsum_cache;
 	if (nrbmblocks != sbp->sb_rbmblocks)
 		xfs_alloc_rsum_cache(mp, nrbmblocks);
 
@@ -1188,10 +1198,12 @@ xfs_growfs_rt(
 		} else {
 			kmem_free(rsum_cache);
 		}
 	}
 
+out_unlock:
+	mutex_unlock(&mp->m_growlock);
 	return error;
 }
 
 /*
  * Allocate an extent in the realtime subvolume, with the usual allocation
-- 
2.50.0.rc1.591.g9c95f17f64-goog


