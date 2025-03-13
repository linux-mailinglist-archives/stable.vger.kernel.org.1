Return-Path: <stable+bounces-124386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266AA602A4
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD49242224A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D61F4604;
	Thu, 13 Mar 2025 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmzthNwX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED01F419D
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897595; cv=none; b=DZpgdBOkRtkW+m8pZCfOKTEWxYoN/VgHO2aQYhpwN24dTG9LhX+0tCclWIKqATAjVxOENDxP3qBROnbvmQsOAIJDfgotgFhcd47czFebdHnYsXd+1Z81SNaIkrU366NQ1QuEjSJgHUdfEr8NGhJWhnlCCOTlGai1qguKml4GfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897595; c=relaxed/simple;
	bh=350PnGXkW7zpT6xuQqzz/XMV8vTx2Y4rLSAKdAEhFFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knRPyW6jh+AxOs5zra1TGIYkDHgJhflMdKP99WZfY7lfcyez+fM+Or+89eVTtrrDtDLBKyFo2qTk5s4euqyJP1ec5bxDABw9gaYaWNz+vKxOs6Sse8i5pYHvLjqUOXIZ1gQrQZWdOCvAUM97aiMMZl00vAZcR8t0gK3BE3RyUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmzthNwX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224191d92e4so30365935ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897593; x=1742502393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mUXFve8p2lBOw/+6j4U82ldi6eE+R8V5P6gq7gJT8U=;
        b=bmzthNwXZvyoEEVuMXAZMg9Cbd8H+feJu81yESSXy/fsyDdL8uf6qT/R68We9yrvss
         zmMREEm1cTaI9RAgMiOBwhBSa1r7Dq+cXH17OtUf7IpwjWY0SmocmGxtZAk2+1m7so8m
         1USluck4lifclfLc9NpGh4OKKGM72cCdspx3n+49XsAn3GovrAGp4oUM0Bu9QIfEE/N/
         3A1HNBOHiVAtbGSZJ9KWncN2sO/gDyCKnbEk3jaE/QppTyc7mrd4qx9VTOmVU3T6Dsqh
         /rCA0ng4dlkdhG/cJrNvs96TiaH0jzZW8soF0/QvTVS1T7s6Wr26QkU6XnRIc/Uh7iFo
         Yb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897593; x=1742502393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mUXFve8p2lBOw/+6j4U82ldi6eE+R8V5P6gq7gJT8U=;
        b=q/5xbZpj2ZajBjNYJMbIJ70jNmbtjwge1zgRUmTzE8GN9p381/v5lVs2XL45LCTMMZ
         ykcx7SzlV7WtfhzBe2wPoF4MFhxqPyqXIxWYOHK3nEdkuu6I6uncMHlbEOKSfrmqdbmB
         TMTRQRgJKQOuZH22XxidzG+vdDhCimycaCWFw10S8b5k4Kbufafk84E7RoIAafTBjznQ
         hew6LJAoLfyovKmVS3U1S2laBelrvGf5rkm3Ti2mP6L7zjouiHvLVledL/sr3iUei4+c
         9IGm5c4lS60d2am03s0FXRAFsU9QreP6SmprNgobunjWosITCM1/3TWq5GbCVTy4pTj0
         VPfg==
X-Gm-Message-State: AOJu0YyVvt4gFEACxeWk9+yhTTSHKs7266pqURl4Po1RFLs3OYCBBCy7
	AWfIQnfvMqecqb/b1wViYhxsSx/L8SLZhawn0GNrWftcUOiOpPL0dKa67wUD
X-Gm-Gg: ASbGnctrWSyuN/+WOFcBJT1vGfzOcpoaB+BYf9DPkNRK+7NIpXiATa43W9A7vParCT6
	oH0nNNYqbe8pwufUPRQ4/Q+z1WfQNerhUdQUwIE9AuwnNhBTQZSVLPR9Z90tseHgy22APBUIw/5
	Acxlg8ea/Kt+mNIrSrOSHtzeguDCXvaQgiW3/nFNhvzXe5TvissKOi6Rc+u2Q50ozoN25XGaEup
	k69XFDuywaA2l4rA2apvdTYtiSb8sqRkIPjVMw7Qw4nqXfPVt2gf2y7Qq1fXb7qVl+mHYJ9vNHU
	qaQ9Pl+zOtdf3wuTTkqPT9godlEu3QSMukFzlPPozVyHoWEX3Q9/sEJQaLEdYjHeKuDDgxFLQ1Q
	FH6aqiQ==
X-Google-Smtp-Source: AGHT+IFfFYhWIIz5Wq5MyLJV9ELNnW2fGPmlz5y6+cxwHfF+YglWOPEBysnXDLP27IRgUG1N38CmrA==
X-Received: by 2002:a05:6a21:328e:b0:1f5:79c4:5da2 with SMTP id adf61e73a8af0-1f5c12c7f13mr81217637.31.1741897592773;
        Thu, 13 Mar 2025 13:26:32 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:32 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 29/29] xfs: remove conditional building of rt geometry validator functions
Date: Thu, 13 Mar 2025 13:25:49 -0700
Message-ID: <20250313202550.2257219-30-leah.rumancik@gmail.com>
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

[ Upstream commit 881f78f472556ed05588172d5b5676b48dc48240 ]

[ 6.1: used 6.6 backport to minimize conflicts ]

[backport: resolve merge conflicts due to refactoring rtbitmap/summary
macros and accessors]

I mistakenly turned off CONFIG_XFS_RT in the Kconfig file for arm64
variant of the djwong-wtf git branch.  Unfortunately, it took me a good
hour to figure out that RT wasn't built because this is what got printed
to dmesg:

XFS (sda2): realtime geometry sanity check failed
XFS (sda2): Metadata corruption detected at xfs_sb_read_verify+0x170/0x190 [xfs], xfs_sb block 0x0

Whereas I would have expected:

XFS (sda2): Not built with CONFIG_XFS_RT
XFS (sda2): RT mount failed

The root cause of these problems is the conditional compilation of the
new functions xfs_validate_rtextents and xfs_compute_rextslog that I
introduced in the two commits listed below.  The !RT versions of these
functions return false and 0, respectively, which causes primary
superblock validation to fail, which explains the first message.

Move the two functions to other parts of libxfs that are not
conditionally defined by CONFIG_XFS_RT and remove the broken stubs so
that validation works again.

Fixes: e14293803f4e ("xfs: don't allow overly small or large realtime volumes")
Fixes: a6a38f309afc ("xfs: make rextslog computation consistent with mkfs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c | 14 --------------
 fs/xfs/libxfs/xfs_rtbitmap.h | 16 ----------------
 fs/xfs/libxfs/xfs_sb.c       | 14 ++++++++++++++
 fs/xfs/libxfs/xfs_sb.h       |  2 ++
 fs/xfs/libxfs/xfs_types.h    | 12 ++++++++++++
 fs/xfs/scrub/rtbitmap.c      |  1 +
 6 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 8db1243beacc..760172a65aff 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1129,19 +1129,5 @@ xfs_rtalloc_extent_is_free(
 
 	*is_free = matches;
 	return 0;
 }
 
-/*
- * Compute the maximum level number of the realtime summary file, as defined by
- * mkfs.  The historic use of highbit32 on a 64-bit quantity prohibited correct
- * use of rt volumes with more than 2^32 extents.
- */
-uint8_t
-xfs_compute_rextslog(
-	xfs_rtbxlen_t		rtextents)
-{
-	if (!rtextents)
-		return 0;
-	return xfs_highbit64(rtextents);
-}
-
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
index 4e49aadf0955..b89712983347 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -69,31 +69,15 @@ xfs_rtfree_extent(
 
 /* Same as above, but in units of rt blocks. */
 int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
 		xfs_filblks_t rtlen);
 
-uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
-
-/* Do we support an rt volume having this number of rtextents? */
-static inline bool
-xfs_validate_rtextents(
-	xfs_rtbxlen_t		rtextents)
-{
-	/* No runt rt volumes */
-	if (rtextents == 0)
-		return false;
-
-	return true;
-}
-
 #else /* CONFIG_XFS_RT */
 # define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
 # define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
 # define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
 # define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
 # define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
 # define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
-# define xfs_compute_rextslog(rtx)			(0)
-# define xfs_validate_rtextents(rtx)			(false)
 #endif /* CONFIG_XFS_RT */
 
 #endif /* __XFS_RTBITMAP_H__ */
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 04247d1c7523..90ed55cd3d10 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1365,5 +1365,19 @@ xfs_validate_stripe_geometry(
 				   swidth, sunit);
 		return false;
 	}
 	return true;
 }
+
+/*
+ * Compute the maximum level number of the realtime summary file, as defined by
+ * mkfs.  The historic use of highbit32 on a 64-bit quantity prohibited correct
+ * use of rt volumes with more than 2^32 extents.
+ */
+uint8_t
+xfs_compute_rextslog(
+	xfs_rtbxlen_t		rtextents)
+{
+	if (!rtextents)
+		return 0;
+	return xfs_highbit64(rtextents);
+}
diff --git a/fs/xfs/libxfs/xfs_sb.h b/fs/xfs/libxfs/xfs_sb.h
index 19134b23c10b..2e8e8d63d4eb 100644
--- a/fs/xfs/libxfs/xfs_sb.h
+++ b/fs/xfs/libxfs/xfs_sb.h
@@ -36,6 +36,8 @@ extern int	xfs_sb_get_secondary(struct xfs_mount *mp,
 				struct xfs_buf **bpp);
 
 extern bool	xfs_validate_stripe_geometry(struct xfs_mount *mp,
 		__s64 sunit, __s64 swidth, int sectorsize, bool silent);
 
+uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
+
 #endif	/* __XFS_SB_H__ */
diff --git a/fs/xfs/libxfs/xfs_types.h b/fs/xfs/libxfs/xfs_types.h
index 7023e4a79f87..42fed04f038d 100644
--- a/fs/xfs/libxfs/xfs_types.h
+++ b/fs/xfs/libxfs/xfs_types.h
@@ -226,6 +226,18 @@ void xfs_icount_range(struct xfs_mount *mp, unsigned long long *min,
 		unsigned long long *max);
 bool xfs_verify_fileoff(struct xfs_mount *mp, xfs_fileoff_t off);
 bool xfs_verify_fileext(struct xfs_mount *mp, xfs_fileoff_t off,
 		xfs_fileoff_t len);
 
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
 #endif	/* __XFS_TYPES_H__ */
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index faf6e0890d44..fad7c353ada6 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -12,10 +12,11 @@
 #include "xfs_log_format.h"
 #include "xfs_trans.h"
 #include "xfs_rtbitmap.h"
 #include "xfs_inode.h"
 #include "xfs_bmap.h"
+#include "xfs_sb.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
 
 /* Set us up with the realtime metadata locked. */
 int
-- 
2.49.0.rc1.451.g8f38331e32-goog


