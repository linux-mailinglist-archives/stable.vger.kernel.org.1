Return-Path: <stable+bounces-124374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B0A60298
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD92517CC47
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584DF1F419D;
	Thu, 13 Mar 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY8gvvD4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCE1F4612
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897583; cv=none; b=JEJRRa4Z6frbgoGxXKh7XZmvBfIU1iOfUVMhKHx+1b3KDqEFJweAFnwuA/mIqx0HFQgbZTCTmYBA21WwsGNwNpS10x5YcmfXHNIvPSwajZfGWNpKu3HMHqmUc5JUPJlUv0q2SS4QCqP78kvfvb+pfY//rfjJEadN0HwGdmkdxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897583; c=relaxed/simple;
	bh=KPXBO5dTPyaqvmb3LEkmOZsr6UxKmBmbyA4WVsGrd7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq8y8GG2SimuYeBavKo6B5noBRNb9MIsDpznDsW66GNtY5WXXJT7FzdJe8rhfi4gjtI6gwgpiXR6F9s3ivokxOI1PKb06RpJDQe6PyGjuMOANUHOxsyLGfMEGxVFXypZC6INeUjuzyomRBQn28BZXN12GZSnvdWzPS15vIz9HnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY8gvvD4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2254e0b4b79so38868775ad.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897581; x=1742502381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaMDCk26lkSUzBwC7zmTWw9dCseYUtQlBPwwo+/hNzo=;
        b=WY8gvvD4xvT70ElAZewl1zySxQBZe7Cd+kxZJ8oZqRGsyV9tIDR+0vofEnNU5GetLe
         6MiaNDteMFAW2xY7j/EYrXj+wwADwY5t8uMyHcbnzt2jBslcUQm/qMAkfi1rkaMGFsnv
         FNQ13YibIYPYAnHpnCFNqiqACoOSLQKYkMGfsXRjfAAuoK//nU6EaxJd0UPYOJ1QuuTn
         gMhiSuRKWbpO7RIYbp8ras07zb/nx/BEhBvVKk3h/UEikzUBjsnXwbb9ECKbtCFMo2RQ
         kddpA5JToxYQEA4aDpPQpjez5lQ3apWMPayb/acpp3jvpwP1Vctn8WDkZsGpiKXSLxtV
         C7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897581; x=1742502381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaMDCk26lkSUzBwC7zmTWw9dCseYUtQlBPwwo+/hNzo=;
        b=Gr05nLJYpTVpcrEts+1ZtBF7yGOI1AwQ/+vaWt73o1+VWy7i3GIJ024kSr+BY7pnb+
         ieYOQ/3coMS05An8i7kdRhchjlJ7VNQ60RERIP6klplblItu3hY1y4aWx4yAAi0Ch/Ub
         qDjeTp9MfmNNq8Fj7OcKNd1TCJWjqsj8Pmprnjl3PX+GaWqNTvmC/hvjgQStXBQAwupR
         3wcdkpccs+El2zrBSCt+NnoQGd/csegakauT/CG7LVqR0BL358kNQQJhVAeikvawIXJZ
         F3mDT5d3GIFGW8uR8S7ayT0NSJ57/+8Agkcwm6zVqjjCYXLIZodL/mZlwkR5kd4PmIJi
         OIQw==
X-Gm-Message-State: AOJu0Yw7ccY3DIaH7CVGJkyHqaf5Jj+xtw3Hb7/e8QhrFLufOvr/NcQl
	4zlmju8UT2MKok91Y5ROvl2HYU9sTKSLZnsz9u+7fYmJWOT9jMI5q9pXVgbv
X-Gm-Gg: ASbGncsDrCdhpFxTEhmh5pzvNGUhj98kIafec04hV3zbDyA7IOXnPAUoOnt1pp/qHbS
	KrdFtYZ9Of+Anw3yeXBrE+CL7/FaQgHD5jmZSchzsyMN1v8EjQ0ioMNRQqHyzokDuOlvoMytujx
	xtw7nw/I3z9ue/TOzJ6HzuSWOpgk4pwhsMigF9oOYmSxmEVPQ0Yc8BgaWYbDL3dVp2pkUB3syO4
	1LmUy1kNkaotoFWNiMuEh20QwkUAvFPTXvwIESB1U/7C87oGUBnfnI9O5p5GVpuZY/rN+Rbg9+z
	Y/02AqbZcAkL8RP8/3onyb8zOafxfCGYhQswos52sVsxBucj9ZCmu3jxWDhvc3wFAVRHD3Q=
X-Google-Smtp-Source: AGHT+IFZ/kKSTL5j1vEFeMSSlziBw+2tlUNPTfuv7jp0n+qQDhbsbtz5XtlQ5zc8fYP5UsqFwR004w==
X-Received: by 2002:a05:6a21:e590:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-1f5c10fac63mr122930637.1.1741897580562;
        Thu, 13 Mar 2025 13:26:20 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:19 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 17/29] xfs: make rextslog computation consistent with mkfs
Date: Thu, 13 Mar 2025 13:25:37 -0700
Message-ID: <20250313202550.2257219-18-leah.rumancik@gmail.com>
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

[ Upstream commit a6a38f309afc4a7ede01242b603f36c433997780 ]

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
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c | 13 +++++++++++++
 fs/xfs/libxfs/xfs_rtbitmap.h |  4 ++++
 fs/xfs/libxfs/xfs_sb.c       |  3 ++-
 fs/xfs/xfs_rtalloc.c         |  4 ++--
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 9eb1b5aa7e35..37b425ea3fed 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1128,5 +1128,18 @@ xfs_rtalloc_extent_is_free(
 		return error;
 
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
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
index c3ef22e67aa3..6becdc7a48ed 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -68,15 +68,19 @@ xfs_rtfree_extent(
 	xfs_extlen_t		len);	/* length of extent freed */
 
 /* Same as above, but in units of rt blocks. */
 int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
 		xfs_filblks_t rtlen);
+
+uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
+
 #else /* CONFIG_XFS_RT */
 # define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
 # define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
 # define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
 # define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
 # define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
 # define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
+# define xfs_compute_rextslog(rtx)			(0)
 #endif /* CONFIG_XFS_RT */
 
 #endif /* __XFS_RTBITMAP_H__ */
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d214233ef532..6b87b04d0c6c 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -23,10 +23,11 @@
 #include "xfs_rmap_btree.h"
 #include "xfs_refcount_btree.h"
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Physical superblock buffer manipulations. Shared with libxfs in userspace.
  */
 
@@ -500,11 +501,11 @@ xfs_validate_sb_common(
 		rexts = div_u64(sbp->sb_rblocks, sbp->sb_rextsize);
 		rbmblocks = howmany_64(sbp->sb_rextents,
 				       NBBY * sbp->sb_blocksize);
 
 		if (sbp->sb_rextents != rexts ||
-		    sbp->sb_rextslog != xfs_highbit32(sbp->sb_rextents) ||
+		    sbp->sb_rextslog != xfs_compute_rextslog(rexts) ||
 		    sbp->sb_rbmblocks != rbmblocks) {
 			xfs_notice(mp,
 				"realtime geometry sanity check failed");
 			return -EFSCORRUPTED;
 		}
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 2f2280f4e7fa..eca800e2b879 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -997,11 +997,11 @@ xfs_growfs_rt(
 	 * Calculate new parameters.  These are the final values to be reached.
 	 */
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
-	nrextslog = xfs_highbit32(nrextents);
+	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;
 	nrsumsize = (uint)sizeof(xfs_suminfo_t) * nrsumlevels * nrbmblocks;
 	nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
 	nrsumsize = XFS_FSB_TO_B(mp, nrsumblocks);
 	/*
@@ -1059,11 +1059,11 @@ xfs_growfs_rt(
 				nsbp->sb_rextsize;
 		nsbp->sb_rblocks = min(nrblocks, nrblocks_step);
 		nsbp->sb_rextents = nsbp->sb_rblocks;
 		do_div(nsbp->sb_rextents, nsbp->sb_rextsize);
 		ASSERT(nsbp->sb_rextents != 0);
-		nsbp->sb_rextslog = xfs_highbit32(nsbp->sb_rextents);
+		nsbp->sb_rextslog = xfs_compute_rextslog(nsbp->sb_rextents);
 		nrsumlevels = nmp->m_rsumlevels = nsbp->sb_rextslog + 1;
 		nrsumsize =
 			(uint)sizeof(xfs_suminfo_t) * nrsumlevels *
 			nsbp->sb_rbmblocks;
 		nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
-- 
2.49.0.rc1.451.g8f38331e32-goog


