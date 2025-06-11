Return-Path: <stable+bounces-152477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060FAD609E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961C217BFCD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ABD19A;
	Wed, 11 Jun 2025 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJL+6UPZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC311DFF7
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675719; cv=none; b=D8JYvqXO8i1PPILsiOeEdpQAg4T3Ie8YJNA93JnVEjTzsNPc5F5ZwVFoACyaszYQqrzKDDv+Fum83aeKXTiPLNDi8zrtaBK9m8bTUmEg/5Jrf57g+rc/f4slt8g6AhYzx9uBQBoGj9Oi2d/9BUbZyin2Rp3YuOqQ5ch+oK77L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675719; c=relaxed/simple;
	bh=4cK6Ba6ZQhHcZfiKHkqwBc8TB54HRic1mF7Hq5fYX18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFOmwoa/uy8NqiUzSeht5aZyYqXeWut4Giaupsa1rPPW0Y7GqfNpwoGtB3qC2Fkvqv/CxKbJtQkJlgxaoMKuMg9rPXdyXf42NV7vcpA/G/DTmy8iIpcHlZGCaELEudGnJcHiiiDHbpgACRqhpFDbnae14Ed7wtWDZc/N0xECP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJL+6UPZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23526264386so2662705ad.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675717; x=1750280517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIMck/J7HmGb3HCvlJ+XEKrpOfsyTEh/GTB7pCjuu+s=;
        b=AJL+6UPZTcc5Qs7wv7ptH1fw5WSLSVcqoa8Ruq7d3QoWtVw77vvQ8dLcRcZG6WEUqW
         xTsnXEm843nH+JF0RlS1qWYDsw73uAjuR5kbi8GiFMndGM9MixTcOsnnrRnrkaMFPvgr
         sYYUubYQj7TSl0QdDfAckQ6z6Mcx9R26n6DXIzdbqv8KLpLY9g9ix34aG7DXnHZywXfd
         JYLbKTcPDEIsJWnkquRa/fMgPEFW+jPwItsNLuyjMYM8k2CRNfSHZ7KbSUcBJK0wh2Af
         zRfVd+vWa3Otl0vDbNl9fpszCQMcMgnbUvowWVSfM4FQUUOm/XYqsWZvxvdrpFw8DEqg
         MK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675717; x=1750280517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIMck/J7HmGb3HCvlJ+XEKrpOfsyTEh/GTB7pCjuu+s=;
        b=aXjn4yk9ad6uL9ncVVaAaybiXpgVTUKhuEoftsjip8sWfcfseJro/Of4up4cg8kcfL
         wQMvEm5G3BWhjbcCaCMSJGbHBi6W1RfodnetCMz+0m4ZyHwdPbpi9hfgmWKbla6zoP9x
         Bu4K/KD3bde+gJ0+EIDiRCh+tSKhPWAquV76Th5FWSf/8xzherLj285ZgFFIKlpjU3O8
         kPFF94Daw9Y51eLm1/UlrV2SoN7ZVHLJNz52noXxv05xXA4wo5Y5I1Ecog4CH9OkqMVq
         9uDfHpGRczPZDpYYwJkmHdOSpmX2+w61iefFhy/zQiusGYhq8dGgmv4+vQpPrLWt3Z48
         qd4w==
X-Gm-Message-State: AOJu0Yy46Sfn/w+GCoqCA00Ny4XQXZuQ7p17WAuPAbWHVEFQ2JF+CQ2B
	aetymGvTWEEy+gRYwvZCTtwoq03b+hpk6SWi0lDj+sUOpMpVeso8aApVEjxvL9i7
X-Gm-Gg: ASbGncsvJm8h4RIhqhMUM8pc9D1uXh9RWHdpcpOoJrfdmxfDtY+EUivtE4x5D5MOv7Z
	HRro28HEqPbHZVPaUjF0/sx8Dy68b9TGtkydccUd17DHxWFWx7tBVSZGPf4mQ/Aj8rcFy2X3ukk
	ZRg3AoREAae0/GhEJTsTJ8Wd2ax33iAIJTqLzc+WR2ygbYKKCPF3tTGTMAvyuV6qLIT3AzAlGcD
	xFBwL0klsAClNNFl3RnMK7n9nY9tz6N+82bG6mCtJERs4WrQcCeUSHZ4GDkdJJ9FroIRoXhOZaB
	NCFyHDJjjndGByR6pUHN2Jsbc+JoQgMSrcBqKNKgP2bymssJFiNPhvu/3Qrdx2mHB0jyW0lrQI6
	1HoHx+O9MmOY=
X-Google-Smtp-Source: AGHT+IEi3V5OdJZq9FG/s/Adr2qgPeDe4btzNVlAo5V9W3ZZ3KBbPTXJjMboo2M/E0I7DDDLOxbttA==
X-Received: by 2002:a17:903:22cd:b0:235:1706:1ff6 with SMTP id d9443c01a7336-2364d54486cmr10046975ad.0.1749675717307;
        Wed, 11 Jun 2025 14:01:57 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:56 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 23/23] xfs: reset rootdir extent size hint after growfsrt
Date: Wed, 11 Jun 2025 14:01:27 -0700
Message-ID: <20250611210128.67687-24-leah.rumancik@gmail.com>
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

[ Upstream commit a24cae8fc1f13f6f6929351309f248fd2e9351ce ]

If growfsrt is run on a filesystem that doesn't have a rt volume, it's
possible to change the rt extent size.  If the root directory was
previously set up with an inherited extent size hint and rtinherit, it's
possible that the hint is no longer a multiple of the rt extent size.
Although the verifiers don't complain about this, xfs_repair will, so if
we detect this situation, log the root directory to clean it up.  This
is still racy, but it's better than nothing.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 149fcfc485d8..fc21b4e81ade 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -913,10 +913,43 @@ xfs_alloc_rsum_cache(
 	mp->m_rsum_cache = kvzalloc(rbmblocks, GFP_KERNEL);
 	if (!mp->m_rsum_cache)
 		xfs_warn(mp, "could not allocate realtime summary cache");
 }
 
+/*
+ * If we changed the rt extent size (meaning there was no rt volume previously)
+ * and the root directory had EXTSZINHERIT and RTINHERIT set, it's possible
+ * that the extent size hint on the root directory is no longer congruent with
+ * the new rt extent size.  Log the rootdir inode to fix this.
+ */
+static int
+xfs_growfs_rt_fixup_extsize(
+	struct xfs_mount	*mp)
+{
+	struct xfs_inode	*ip = mp->m_rootip;
+	struct xfs_trans	*tp;
+	int			error = 0;
+
+	xfs_ilock(ip, XFS_IOLOCK_EXCL);
+	if (!(ip->i_diflags & XFS_DIFLAG_RTINHERIT) ||
+	    !(ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT))
+		goto out_iolock;
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange, 0, 0, false,
+			&tp);
+	if (error)
+		goto out_iolock;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+out_iolock:
+	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
+	return error;
+}
+
 /*
  * Visible (exported) functions.
  */
 
 /*
@@ -942,10 +975,11 @@ xfs_growfs_rt(
 	xfs_extlen_t	rbmblocks;	/* current number of rt bitmap blocks */
 	xfs_extlen_t	rsumblocks;	/* current number of rt summary blks */
 	xfs_sb_t	*sbp;		/* old superblock */
 	xfs_fsblock_t	sumbno;		/* summary block number */
 	uint8_t		*rsum_cache;	/* old summary cache */
+	xfs_agblock_t	old_rextsize = mp->m_sb.sb_rextsize;
 
 	sbp = &mp->m_sb;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1175,10 +1209,16 @@ xfs_growfs_rt(
 		mp->m_features |= XFS_FEAT_REALTIME;
 	}
 	if (error)
 		goto out_free;
 
+	if (old_rextsize != in->extsize) {
+		error = xfs_growfs_rt_fixup_extsize(mp);
+		if (error)
+			goto out_free;
+	}
+
 	/* Update secondary superblocks now the physical grow has completed */
 	error = xfs_update_secondary_sbs(mp);
 
 out_free:
 	/*
-- 
2.50.0.rc1.591.g9c95f17f64-goog


