Return-Path: <stable+bounces-152467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F280AD6094
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054E917AA01
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D32594BD;
	Wed, 11 Jun 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyuCOUFX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C622BDC38
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675709; cv=none; b=NjcHyeigNbs0re4LQYQMolls8nnm7+iIpyXt+k9UdJVD3+q36DAJn7wjafQGRqr6kWtwxQ7NXoR5w2+4vPJWTHSNPrk42B6xRFsjaGR+qD/zyZsZvGZNKeK0I6bBnsqmyLG+1LznKhhvLMREZ7LzUfgQuXTeMgtZsgcKoObwFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675709; c=relaxed/simple;
	bh=Yf5IPK1idHjnKfcaZkB5AAXRpybA52lh5K4gwU5mdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT1WYiZ+HhcJB1AqNclZui2nkn6nOJXubicObd5vI7uYNejTCoHVSjGAhOVeEEZh9vHqXJBebC68Osq5Qs4ES9QpFN4VwbnKP3VDAwia/Rdjazc9iekUd//ZYY9yLgdhy2t8fauPh12YYZp6YimRmi5kl0q5fPnHDJgqY8tg3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyuCOUFX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236470b2dceso3339115ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675707; x=1750280507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TpTohhoGxpPpDlJLiJVERmzOQuCtbEqPYTERLeOIpc=;
        b=fyuCOUFXL1IqchgWJ349J+9kF+VjadVw3nvom+qm/X2GcxECAovu2Hj7na4gCgNETJ
         AmA6+wdEZsh+Y68vYfmo4LijG5PXpBNDCrVakrDOm6W5DfH12+cCcRR0YWCWuT5Owzub
         mzp6zuZYO7dmM8tnIab80odpfSXGIphzRcnghOZtOs3QO0M/idtlt6LPI87kUFaXu2MG
         1/kQMZ2uQYj7xiYP2HgaPI061ScBOQ5xgN0tiPw+QkOPQxKv7dzlC1r2tRco6+KBDXnV
         gT08/hSj7Z7zoKSYc0/95Go9PB8lmYheDX3fQ8IkOYA8+ssVs5h9wtn+4hO8z7GU8KXA
         y48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675707; x=1750280507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TpTohhoGxpPpDlJLiJVERmzOQuCtbEqPYTERLeOIpc=;
        b=RPSl+DLJO18SwzECSVAdPNhKpVKKNY4DeJEMhOZDea55syfQMB1X3FwPB3ipPpygEe
         pSWSRyW/pWLUg0T5JJryd9QaFECejdci3UNu7rTVGjkw6DrS1rl3XjgST8ZUf5vGP95a
         Lp7/xBUkWcPNHT6XokSrNo5pBVb/dZHG9/viv75uTLTIzUowh0iCEnoZ3YdntOQqd2Xe
         3naVBMdeDHnC7PoTNYwgWRVZrsa+eHUfFGaM3Hg0xuhEn6oxhcmWZN5qRSnrt6xS0PGC
         QZkF0dVW4QzgHIBFdFqYGE/rq8S+P4+KVQNRqLiuKDJCxlnSfmwGMSQXPMli0fqifA/9
         F34A==
X-Gm-Message-State: AOJu0YxeiwgCC1XiUx6j6TMAU9fHXgGB7qabpOv6k3sTjGuU9nOfYguX
	YqcAUty/8i2e7YN/WFL79dQZer5aMqBzgvV80zlkFPHhfFfsvkRGv3w+hhqHiBeh
X-Gm-Gg: ASbGnctcgHssGHB8v9aLo5WpC7t8GRucDROzjyuzg7THDwHe6C/7ajc64BNvBmRHpRC
	LA2PZkPoqeY55AXULju096nA4eCsRWWmg2p5A+/hBEfp/0OSnam/APbeF9ThJT/Tv21EAKCFRH7
	5gAT8i+AfgWD6vITItA1xh2CkSxffu0U1xy/oRu91INcPT8t5dYzxObPCFheywvwWImDEB2WY+T
	VwLZUzuKwJR01eQLKEtffRqWkVmwWHe8HfhqmV4FKXXmqtEVQT+8RXdwRAYcy8Z6sSk5pwBVkDH
	32uh9VW9J7N/vbb/nt/cvrc0gQ6WKzmPWLsfBXumZXNwO7vx9+6KXlZ5K45mBgRpMxViRBHfRbF
	zoDkdOnL44UA=
X-Google-Smtp-Source: AGHT+IGTtQdgsOdPkd3daTpXGJwwDUuyYHSQ9uQsj4wzJWpJFWjnUhdmfiPspopEZCoBA+ih6XqUWA==
X-Received: by 2002:a17:902:e889:b0:234:c549:d9f1 with SMTP id d9443c01a7336-2364d90fdc0mr7676795ad.47.1749675706709;
        Wed, 11 Jun 2025 14:01:46 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:46 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 13/23] xfs: create a new helper to return a file's allocation unit
Date: Wed, 11 Jun 2025 14:01:17 -0700
Message-ID: <20250611210128.67687-14-leah.rumancik@gmail.com>
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

[ Upstream commit ee20808d848c87a51e176706d81b95a21747d6cf ]

Create a new helper function to calculate the fundamental allocation
unit (i.e. the smallest unit of space we can allocate) of a file.
Things are going to get hairy with range-exchange on the realtime
device, so prepare for this now.

Remove the static attribute from xfs_is_falloc_aligned since the next
patch will need it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 32 ++++++++++++--------------------
 fs/xfs/xfs_file.h  |  3 +++
 fs/xfs/xfs_inode.c | 13 +++++++++++++
 fs/xfs/xfs_inode.h |  2 ++
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 6f7522977f7f..3c910e36da69 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -37,37 +37,29 @@ static const struct vm_operations_struct xfs_file_vm_ops;
 
 /*
  * Decide if the given file range is aligned to the size of the fundamental
  * allocation unit for the file.
  */
-static bool
+bool
 xfs_is_falloc_aligned(
 	struct xfs_inode	*ip,
 	loff_t			pos,
 	long long int		len)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	uint64_t		mask;
-
-	if (XFS_IS_REALTIME_INODE(ip)) {
-		if (!is_power_of_2(mp->m_sb.sb_rextsize)) {
-			u64	rextbytes;
-			u32	mod;
-
-			rextbytes = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
-			div_u64_rem(pos, rextbytes, &mod);
-			if (mod)
-				return false;
-			div_u64_rem(len, rextbytes, &mod);
-			return mod == 0;
-		}
-		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
-	} else {
-		mask = mp->m_sb.sb_blocksize - 1;
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip);
+
+	if (!is_power_of_2(alloc_unit)) {
+		u32	mod;
+
+		div_u64_rem(pos, alloc_unit, &mod);
+		if (mod)
+			return false;
+		div_u64_rem(len, alloc_unit, &mod);
+		return mod == 0;
 	}
 
-	return !((pos | len) & mask);
+	return !((pos | len) & (alloc_unit - 1));
 }
 
 /*
  * Fsync operations on directories are much simpler than on regular files,
  * as there is no file data to flush, and thus also no need for explicit
diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 7d39e3eca56d..2ad91f755caf 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -7,6 +7,9 @@
 #define __XFS_FILE_H__
 
 extern const struct file_operations xfs_file_operations;
 extern const struct file_operations xfs_dir_file_operations;
 
+bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
+		long long int len);
+
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 88d0a088fa86..3ccbc31767b3 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3773,5 +3773,18 @@ xfs_inode_reload_unlinked(
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 	xfs_trans_cancel(tp);
 
 	return error;
 }
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	unsigned int		blocks = 1;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		blocks = ip->i_mount->m_sb.sb_rextsize;
+
+	return XFS_FSB_TO_B(ip->i_mount, blocks);
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c177c92f3aa5..c4f426eadf8e 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -620,6 +620,8 @@ xfs_inode_unlinked_incomplete(
 	return VFS_I(ip)->i_nlink == 0 && !xfs_inode_on_unlinked_list(ip);
 }
 int xfs_inode_reload_unlinked_bucket(struct xfs_trans *tp, struct xfs_inode *ip);
 int xfs_inode_reload_unlinked(struct xfs_inode *ip);
 
+unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
+
 #endif	/* __XFS_INODE_H__ */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


