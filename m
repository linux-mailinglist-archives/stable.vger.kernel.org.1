Return-Path: <stable+bounces-124364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89ADA6028D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8469619C589E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682941F4162;
	Thu, 13 Mar 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMpuDXB+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B11F4615
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897572; cv=none; b=J8jb0zSudUJ+5f7IWC2qg4tqXM4bjnNTOxV4QvwjWiOjFk9HicLwTZa5sX6P9iBF9HbDJth0jcHTrmZXJ/n95MPS+KqPWTJsjVUl58hixn9ObhDNkicnKbdUMs3bYZ+uEoDwnST7EvD2XZCuwOlCQYEgb9Q3Bks19XrOX0KRKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897572; c=relaxed/simple;
	bh=wX9mSMLxO9R7bI+Rwk4K4MJsm2ZruMRYbh6Qodq8Qd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdpgKeSAr2IDiTt+MzYtYwMC+Lzw3+IWXnhA3wul8XOhGAafNhSh8bQEcPM43p3oNRSJjsmDrLwzdnCjs7CPQY3XXcIBZuDACpfZkf/cxaT/kZB6036pOydN+7/KwC5NUQR0I/OMBz4XbiYqDza2CtRuGS9Wa2yYhhoR0v19oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMpuDXB+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so30605725ad.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897570; x=1742502370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS33kG7koSdB/9bgxYwAZFGGJnuzQWtGbdmaSHj4P/w=;
        b=ZMpuDXB+9zq0smw4fTtq0WDM0A2HbUrf6xWyAN0Q0i2nqvuABdz7eQVL6sSFIp3ujK
         H6QQa8Qz2TQYcgOTYXvDzrFrmPNxJAA3XzxUiyk4Jlx3N8jTcvbjMRAQ1+j58jUshZmo
         GXmW+IjfSuhaggDL5wIAA1CLPYn76zqGjGpOR8ihq8UOkQOMD5/PceT8M1bsko6JoiVG
         bQ5XFh2Da2uS4sU2FeVCnkfTdc3hlmhCPmMGSnwCefBzgjH6tpFuWIC3HZV1t+Nkpogp
         Ic11nu8celyi/bFK5C4Vm7p2HW8S/tYslHBfKjHHPKoIZ+PtNRAz+IewacmASwlLlkhe
         5xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897570; x=1742502370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS33kG7koSdB/9bgxYwAZFGGJnuzQWtGbdmaSHj4P/w=;
        b=VW/PN1A68xWTT53EjaM7jBxKI+zss6DGaE+0BYp7tC7VSJl/mTB9iBwpVIipUTMOwW
         oX+hS5ittc0ff5tApz+FeXpS98CgoDtNhvrZ8n0PrI0464PflrpZVW8ad8gkBzLvRM6R
         aw2jxZWeRUMDyns2W/xbNMBAOGxDVraRkmtVPUpZ9IYMz63UdhRxY+5Qh6kAka8y07pD
         8RtpnqcwQMtozj6+up/mSNpRbyi1bL+UL3Hg411Ap48tyTe+xOTO721ZYo1uPEwa18Eq
         oTp3LngD76vvi2kqXwEhdEnX/+S0p+JJOAmjNkmR4yYwAoqUGZyRYw6croXrxyBWk1DP
         wD4Q==
X-Gm-Message-State: AOJu0YwU+ckeNophLYmALLU7PwiNYD1mladNQ64U617UXHAC1kKzsxi2
	rrTbeuZFE0bsqRmvJNONxZJcH4i4GT/Oq8FVhWItnLtWgxQ4eInBYag9Mg==
X-Gm-Gg: ASbGncsESplM2V80jUbOFpLR74lyEcaTbwmXNCCoILxv000NJmcD64Ui+bzbKrspOlP
	Aa2BLNvyLWPrzRFyRXqmSgdErEprCRQ0Qe5gYRTeA4ROSL5rqmlcQx8diMUuazIscn+14zUA18k
	xacXQ+tTgyjBc4e5za81r0EQ7OIrymOfuZyiCA4D/SXSxAEAFBSDndGb6rbLhWrs7KGqgA1dPU5
	NpFPUpDSrREG4wgdthVtggrLCZ9VHKjvJ+FtwMTzSDlufOG+8X2Gv85NVvslA2+wJF2yA1DlC9B
	OixMh6rXgHWywAz6O56h461oe5SU+Vhuy27twK8HxsUfXg1f4lHAVxDvuhAGOnJIisq80Mo=
X-Google-Smtp-Source: AGHT+IFxW6OPAccJuSD6XpKzAsIo+pdanG+1bMUcP2njJ7lcm38OZH573tRmuQAPkxR89Nm1aNUwbQ==
X-Received: by 2002:a05:6a21:4d8c:b0:1f5:a3e8:64dd with SMTP id adf61e73a8af0-1f5c0ef0274mr128973637.0.1741897569784;
        Thu, 13 Mar 2025 13:26:09 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:09 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 07/29] xfs: fix bounds check in xfs_defer_agfl_block()
Date: Thu, 13 Mar 2025 13:25:27 -0700
Message-ID: <20250313202550.2257219-8-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 2bed0d82c2f78b91a0a9a5a73da57ee883a0c070 ]

Need to happen before we allocate and then leak the xefi. Found by
coverity via an xfsprogs libxfs scan.

[djwong: This also fixes the type of the @agbno argument.]

Fixes: 7dfee17b13e5 ("xfs: validate block number being freed before adding to xefi")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index ec03040237db..af447605051b 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2487,28 +2487,29 @@ xfs_agfl_reset(
  */
 static int
 xfs_defer_agfl_block(
 	struct xfs_trans		*tp,
 	xfs_agnumber_t			agno,
-	xfs_fsblock_t			agbno,
+	xfs_agblock_t			agbno,
 	struct xfs_owner_info		*oinfo)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent_free_item	*xefi;
+	xfs_fsblock_t			fsbno = XFS_AGB_TO_FSB(mp, agno, agbno);
 
 	ASSERT(xfs_extfree_item_cache != NULL);
 	ASSERT(oinfo != NULL);
 
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbno(mp, fsbno)))
+		return -EFSCORRUPTED;
+
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
-	xefi->xefi_startblock = XFS_AGB_TO_FSB(mp, agno, agbno);
+	xefi->xefi_startblock = fsbno;
 	xefi->xefi_blockcount = 1;
 	xefi->xefi_owner = oinfo->oi_owner;
 
-	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbno(mp, xefi->xefi_startblock)))
-		return -EFSCORRUPTED;
-
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
 	return 0;
 }
-- 
2.49.0.rc1.451.g8f38331e32-goog


