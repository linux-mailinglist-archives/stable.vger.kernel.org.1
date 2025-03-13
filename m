Return-Path: <stable+bounces-124368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4ECA60292
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16F917C57A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7701F4288;
	Thu, 13 Mar 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+OqMzEN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F31F419D
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897576; cv=none; b=mFuLyJa8dIx61VuXEsQkUgr7J3D33Bth7QirsUhS+/MJbU4nJISTVirsschJUItY6MEPjdVAMrFTOTKkZFFIoSE/o1b40dhOXnTZ7ILrZTpTtE2bRmQqGGSk2aFAZKjKHXN6din8lARdC7O3bosbOpTullyOFAwuCAGaP0WCua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897576; c=relaxed/simple;
	bh=I44W1+N3O57jHlCKp+mg95nXuQLRfoDAoUguSIqRVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+r5u9+lp9GUoj+1jBRs5hiZSVDNFQ0wnqlG0yzH2pqOIcbFMTN6OhmYE8BNVyn/luMdunffxFC5cuu+RRaflK08UVcz374zAaJ5frwLBhjnF64bEVW/KAXpz8MGfr0LJMNJO/9wTGL7CHDV1GQwg2eaZ03X5Lt5DBR+UjS0zLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+OqMzEN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so23268355ad.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897574; x=1742502374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiqOrEA05OZCG4+5FYiBOhGEpe00mbRrh06/pRzLQgU=;
        b=f+OqMzENom2kxElspgjwWb6gw9KaagsTAFOhxsUSqyeYq36bMl8RaDK5Cq4RysIfDk
         n228YBQ/Zd3yADDKwvBbf/LEWKFbbK5ZwxBl2tCjwH4fB5fgts+m8YAwrn5iV1205NoD
         hHN2avsWijkf3ZAxE705V7+TZkrmv/K4vjO6LDgQZ4W6ATy0hH7KmU3BNVrHybk7efJg
         OYJUh3T8nd9roM8Q3RbT/RFlPbv0/q73plymHElmx++vEtFRidH/WvwwDbv7UmL23zgU
         wcrrASeKM6//G615QHmR3Z1Neu5mjU82VFQaP+qjazt08A36CB+Kn5ppnUd3iMIdRohQ
         IQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897574; x=1742502374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiqOrEA05OZCG4+5FYiBOhGEpe00mbRrh06/pRzLQgU=;
        b=Yq99qxeyj2O1HyFxT4s6nqnarg/J/zv4jgzu2Ex7nWSP5vWmpaAv15Hynn5dKcCo8N
         NH0Gb7cUUo4m84nMnor/xTsBmB2qa5oZGqCWc2NwQXY4JcKvlSlDmuAZ39tztounh3S5
         c8Yh3BY7/bDWyYVaTubWnrCancPiQQTnRevvY4XTxpax4eFqYRXbP933FXhien0Iksqb
         1dCzbBvwDQhJLb2W6WDo0kr64cqR8QmSkqpWHaOfhDieWqsF0wU4Sx83SBz4k6mI+6ZB
         pK5osE+CoO4an9DiW4j+x+zdoPMtpWg5UZCx9qv0hfafjQURvDi16ryUqXetU4T2ipgO
         iY8w==
X-Gm-Message-State: AOJu0Yz2ilVufhPMDMhuPEPwp+gGBReKJzPSHvQ8f8KdE36iPXN0C1rK
	8AG+njen9zw52+QDVFxo/nPPnrjVcpblnaeLO8ShYQbY7yf/4krUBFfwaMxp
X-Gm-Gg: ASbGncugobw/DkgqnhJ4X5HxgJWf9JlGrZpd8GuPUECvt0KhojoXz4ilyJeWsOykA+H
	uwDneNLsDOw7pxJI//8LRmOShtmojsTjRiEyuxZVW5VYRGIiaZSFidKwa/5nOYhwFW+SeUPA0Z0
	w89lhluzFQDSshUB6yIOQRj1YIb9TUxjBEtmHSXxMrB5ufN+uYRhiq4t/JmWrgEj3QhYwP6G9ct
	HDgRItXLHmFBlJDgk52dHg/ge9cnUWMjdptmD3xBdC+2wmpq1vZdzQrX2UW0iLafroINXYxK/YG
	O3OuhIZX04EQtXxfi3tEUU+8oMm83nrAkFPG1i1VShhr8uG6hA5QbN0/6/2UL4peaLmSoQ25ghZ
	b6USO5w==
X-Google-Smtp-Source: AGHT+IERuY4BzDvYb26BhbqUSLcak0l+ZA/K5xTlGAbD+SSGG3olmAFAGyL7AjcT/kRRGefF2AIoXA==
X-Received: by 2002:a05:6a20:2d22:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-1f5c1183cdcmr111678637.14.1741897574055;
        Thu, 13 Mar 2025 13:26:14 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:13 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 11/29] xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
Date: Thu, 13 Mar 2025 13:25:31 -0700
Message-ID: <20250313202550.2257219-12-leah.rumancik@gmail.com>
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

[ Upstream commit f29c3e745dc253bf9d9d06ddc36af1a534ba1dd0 ]

[ 6.1: excluded changes to trace.h as xchk_rtsum_record_free
does not exist yet ]

XFS uses xfs_rtblock_t for many different uses, which makes it much more
difficult to perform a unit analysis on the codebase.  One of these
(ab)uses is when we need to store the length of a free space extent as
stored in the realtime bitmap.  Because there can be up to 2^64 realtime
extents in a filesystem, we need a new type that is larger than
xfs_rtxlen_t for callers that are querying the bitmap directly.  This
means scrub and growfs.

Create this type as "xfs_rtbxlen_t" and use it to store 64-bit rtx
lengths.  'b' stands for 'bitmap' or 'big'; reader's choice.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h   | 2 +-
 fs/xfs/libxfs/xfs_rtbitmap.h | 2 +-
 fs/xfs/libxfs/xfs_types.h    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 371dc07233e0..20acb8573d7a 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -96,11 +96,11 @@ struct xfs_ifork;
 typedef struct xfs_sb {
 	uint32_t	sb_magicnum;	/* magic number == XFS_SB_MAGIC */
 	uint32_t	sb_blocksize;	/* logical block size, bytes */
 	xfs_rfsblock_t	sb_dblocks;	/* number of data blocks */
 	xfs_rfsblock_t	sb_rblocks;	/* number of realtime blocks */
-	xfs_rtblock_t	sb_rextents;	/* number of realtime extents */
+	xfs_rtbxlen_t	sb_rextents;	/* number of realtime extents */
 	uuid_t		sb_uuid;	/* user-visible file system unique id */
 	xfs_fsblock_t	sb_logstart;	/* starting block of log if internal */
 	xfs_ino_t	sb_rootino;	/* root inode number */
 	xfs_ino_t	sb_rbmino;	/* bitmap inode for realtime extents */
 	xfs_ino_t	sb_rsumino;	/* summary inode for rt bitmap */
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
index 546dea34bb37..c3ef22e67aa3 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.h
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -11,11 +11,11 @@
  * extents, not realtime blocks.  This looks funny when paired with the type
  * name and screams for a larger cleanup.
  */
 struct xfs_rtalloc_rec {
 	xfs_rtblock_t		ar_startext;
-	xfs_rtblock_t		ar_extcount;
+	xfs_rtbxlen_t		ar_extcount;
 };
 
 typedef int (*xfs_rtalloc_query_range_fn)(
 	struct xfs_mount		*mp,
 	struct xfs_trans		*tp,
diff --git a/fs/xfs/libxfs/xfs_types.h b/fs/xfs/libxfs/xfs_types.h
index 5ebdda7e1078..7023e4a79f87 100644
--- a/fs/xfs/libxfs/xfs_types.h
+++ b/fs/xfs/libxfs/xfs_types.h
@@ -29,10 +29,11 @@ typedef uint32_t	xfs_dahash_t;	/* dir/attr hash value */
 typedef uint64_t	xfs_fsblock_t;	/* blockno in filesystem (agno|agbno) */
 typedef uint64_t	xfs_rfsblock_t;	/* blockno in filesystem (raw) */
 typedef uint64_t	xfs_rtblock_t;	/* extent (block) in realtime area */
 typedef uint64_t	xfs_fileoff_t;	/* block number in a file */
 typedef uint64_t	xfs_filblks_t;	/* number of blocks in a file */
+typedef uint64_t	xfs_rtbxlen_t;	/* rtbitmap extent length in rtextents */
 
 typedef int64_t		xfs_srtblock_t;	/* signed version of xfs_rtblock_t */
 
 /*
  * New verifiers will return the instruction address of the failing check.
-- 
2.49.0.rc1.451.g8f38331e32-goog


