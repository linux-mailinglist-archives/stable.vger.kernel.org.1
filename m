Return-Path: <stable+bounces-124376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BCA6029A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964919C598A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C41F4619;
	Thu, 13 Mar 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpXHHL7U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C901F426F
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897585; cv=none; b=edEsbX7OMIf81c1nq+cG7iY5nduaEsta4S2dHLQwiMoMTuTghJxvnc/BzoUpg8zjQbEiyLwKLkTBSuXH98qvGs0M0j7L0H6mviWc+DwQEWVYqLcxXFC+yeALj0wHiDdHV+vtz+kwJNZKphhRYNAglB+ekrh2b+E4DiQxI6WLQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897585; c=relaxed/simple;
	bh=tlnXY2/RcdMt2QjdgNDxX48I1W30nMoyJAUVGzWvYco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6axCLeU8X8x7FvJHvRccwukMbe22wqRstca7NlOdbb4kp88G5e9srDbpbdRu6MdM8Y+1MUX/tgH8QO6kMW2l05QoFWY51xFp+uzg6bRkXFC3NR63uJnUUNyawNLjQyA3I7y34jenuXEDkdAWoPx/g6xme3tCT/TaVY7L3zCMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpXHHL7U; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22403cbb47fso28726435ad.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897583; x=1742502383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXxkwbdNk4WDN+Fm1J8HrS2Mmot80YBLvIWA+Ua4mZ4=;
        b=KpXHHL7UwJVrPQon88d5RU896+3yVW/wMHSUp1MnpXWXfO5UeoiTdtiMNDtFzyuS/B
         i14kb5LCUCnZEmTurX+qsD4iGVM8ASJtRjaXUZGyC7Pz4YmbktzRWPpyD3BFAV+wPRPw
         dGlUX0DgVF7tD21aCBs5sLvK3MKGaUVkZ1MJoubS115qRwgyHDNu1O3dhB9fpMDp0OUR
         XNRQ+do1LC/auqWVRPsZ7iW2KCFB5kDh35hiZF7P/Bls/7Diifn80u76kWi6Kkl6nPU5
         hzlu2nMfsIAeWQPJ0sUiLPelqf/jXoPQou/yRAdna9UEvRfP9AVeflBL7Qb24wurvpKp
         dNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897583; x=1742502383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXxkwbdNk4WDN+Fm1J8HrS2Mmot80YBLvIWA+Ua4mZ4=;
        b=WYwWuyfktC1k2MY0kRHzL/44IQCjCxHKQmLynFnpQOkfQEzS9U8N0k9RkGUsf+v23Y
         MS3zkRJP6h1h5CcR8Wl2Tx2XIGOrblqRyGnVAPOUBV/tzAk2oe3Tr/yhtX7VkrU4onEb
         L8EmtHYIZAket3kHZ/Ag0th+ugL9vNR8pI5DFl56d8CX5TUaOO6FKBQd4jbIzYACSW6W
         NFlB49A+6EFJjscxaRmCvKIN00ux27xxiN8QRJwOSgzNUz+MJ/zlKh0BpM9JCrTbKWC2
         V9/bARcwxhU5F7vMN8IeIvA/xbzGY2rv5RjQQmx8IhBc/0qmTQU3HMQWNL1a10zwgjit
         mSYw==
X-Gm-Message-State: AOJu0YwQd5CFz7v2G8sQvaTM1MW/T9caAgf7fn6GEuIK3tkrzowLOhTM
	hL24QAz+GtB2I9UyRS5YtrPDniMUnQ8uGoJUOwbDVPrfSPVD1+h66c1UOn5M
X-Gm-Gg: ASbGncvwoLATl4/aPtJJoNeEdpLaAw3ZzNSpsBoYNFYwQglXz5QFs5o6ullT2ywmxdr
	4rUfJyRZkG7M9ogesBHYP3gjTxxu9pBucP8NvhgQfZ4Y7RAiCP03x212dIwSKUVA2UQa3wW/SHs
	8FZ2jLBOUiRnCBVIaTmv7S1Z3LSOys/oARMMaeZjqRC5qK90i+jbUIkw4n66VfssvyhuDDrC3c9
	LYBdIae+3pQYyL5Pf/Ubcjqy5mPP4sq84jkkWCKAkmL/NbFqFF8Bv9b2ONoC1MYwk7NU+61w9Ei
	ohJcHxNAXVdtYv2WyG9HK00Zbu7xODX273Om2B52xKsoP+l23+tei3Ctqd5qFMwEY+ggOy8=
X-Google-Smtp-Source: AGHT+IHlphiE1G8Zja/4sn1lvbVYAEYXLQLzHshi/h6s9IACiJeLF1qmbnzLNeP7AXzU68ZfX3h/bA==
X-Received: by 2002:a05:6a21:b97:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-1f5c13da31amr41624637.39.1741897582692;
        Thu, 13 Mar 2025 13:26:22 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:22 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 19/29] xfs: don't allow overly small or large realtime volumes
Date: Thu, 13 Mar 2025 13:25:39 -0700
Message-ID: <20250313202550.2257219-20-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e14293803f4e84eb23a417b462b56251033b5a66 ]

Don't allow realtime volumes that are less than one rt extent long.
This has been broken across 4 LTS kernels with nobody noticing, so let's
just disable it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.h | 13 +++++++++++++
 fs/xfs/libxfs/xfs_sb.c       |  3 ++-
 fs/xfs/xfs_rtalloc.c         |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
index 6becdc7a48ed..4e49aadf0955 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -71,16 +71,29 @@ xfs_rtfree_extent(
 int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
 		xfs_filblks_t rtlen);
 
 uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
 
+/* Do we support an rt volume having this number of rtextents? */
+static inline bool
+xfs_validate_rtextents(
+	xfs_rtbxlen_t		rtextents)
+{
+	/* No runt rt volumes */
+	if (rtextents == 0)
+		return false;
+
+	return true;
+}
+
 #else /* CONFIG_XFS_RT */
 # define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
 # define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
 # define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
 # define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
 # define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
 # define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
 # define xfs_compute_rextslog(rtx)			(0)
+# define xfs_validate_rtextents(rtx)			(false)
 #endif /* CONFIG_XFS_RT */
 
 #endif /* __XFS_RTBITMAP_H__ */
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6b87b04d0c6c..04247d1c7523 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -500,11 +500,12 @@ xfs_validate_sb_common(
 
 		rexts = div_u64(sbp->sb_rblocks, sbp->sb_rextsize);
 		rbmblocks = howmany_64(sbp->sb_rextents,
 				       NBBY * sbp->sb_blocksize);
 
-		if (sbp->sb_rextents != rexts ||
+		if (!xfs_validate_rtextents(rexts) ||
+		    sbp->sb_rextents != rexts ||
 		    sbp->sb_rextslog != xfs_compute_rextslog(rexts) ||
 		    sbp->sb_rbmblocks != rbmblocks) {
 			xfs_notice(mp,
 				"realtime geometry sanity check failed");
 			return -EFSCORRUPTED;
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index eca800e2b879..2dcd5cca4ec2 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -996,10 +996,12 @@ xfs_growfs_rt(
 	/*
 	 * Calculate new parameters.  These are the final values to be reached.
 	 */
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
+	if (!xfs_validate_rtextents(nrextents))
+		return -EINVAL;
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
 	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;
 	nrsumsize = (uint)sizeof(xfs_suminfo_t) * nrsumlevels * nrbmblocks;
 	nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
-- 
2.49.0.rc1.451.g8f38331e32-goog


