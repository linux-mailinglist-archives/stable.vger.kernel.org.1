Return-Path: <stable+bounces-124367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC7A60290
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E7A19C58BB
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28B1F417E;
	Thu, 13 Mar 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7PP21Wf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D01F3B83
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897575; cv=none; b=FQJGXyq8GhKEAuPmWQeDqf0yPfwDKl21uVTz6uBTLK8HzPiEaDzsIjmBp4iyJ9JscvSSNgEzmzdlOC095HoTAIZOz9z212ob7gLoBPPf2ZM3pYc61ySbR35pryC+yVH+vgsORyPtMIIMt+wTYo2KC86guT509OmdlDmPsfR79PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897575; c=relaxed/simple;
	bh=iFyUo8WwpzwZnfz31koTs2NKWD+jT5McqEyDXlZhzMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhrsXBpDK41BzTeCpVhkzpARQoHNE58uIgTzibSJxd18nDWg0b/7XpRfqLqdyYLwBatroe8SMF+7Y7O6lsB+Ja7mvjjGOcFvdD8tTTOOtCIvxO0vaWJNUaaqDxjHtTOto/n5c5GHFn72W+3McIuqF/eLw7u8A+mJ/wqWxvWNIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7PP21Wf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so38182705ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897573; x=1742502373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk4kY0VszJ7aytgGcCSOCm7MK5ZcoT465AUF7GvnJfg=;
        b=F7PP21Wf4dcgGh2WVhNWsrxmiO8XV2IJSK8dpW+LBQ4D7geoEUWR3BYLfba9belCHL
         KcdULkOJavxoMCFjJ3BKahu5XLN5g+ecaF4yNXy9vr0bB6tcT1kmKiRLKstUALQCXUZj
         /SHUsRZNpOXX2jfHnEd1jVPbaR2Zg/3/aQ3O37oCrY3BDaRBA4cIGURpZou9oLuqUHl8
         Ii2yezf+xKoStxApsxMvhtZfRkQ6vji8XAhpH6jrQhySVR/KjBGzyXlC+rISFylInSsT
         ZlMit6BDMpderyXjnAbErJLWcGmg7bcey8gfeJXpYwmQoIyj5zSN0TbkuJLGAhF+VtXz
         Y3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897573; x=1742502373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk4kY0VszJ7aytgGcCSOCm7MK5ZcoT465AUF7GvnJfg=;
        b=qm6rhL6k7WjzAkltDxVglLhQmoiXFCLVt9mN4egiFQBSMwt3V0xG8zAAuMMuuBm2FG
         ACgyfsO3BhxQLsxiL/s4Kw8QFxYFkPbKnDaE41BFemAdTRpAWGQiSpDZy4A7akELMRkI
         qk//9RBDMzFWqr9LtVZAPuOJ/wmANScyuFrIG5vYz68YZLqYXDdSazdbrRLNGWBx1ndv
         aOdOV5f8hxjfkgL9onjxV82PTXKu6KHBGG+HCZdxa3R3tT+QeS5OkWwIaXPV2+HmVwJ1
         oAx9UXJbcLEm8O9NrYbA+q1ciSC+nVGpdDdF9uuY0iFWd1WjfhDMa9mhCdMsA/ShGj08
         5GXg==
X-Gm-Message-State: AOJu0YzXXAiZuZP/qp2VZ8bbqBKFm8mTLWJC3QIk4Fu/aMCFTGUqoth3
	X72cr6BOtnP34YTPIQLaktVv5/nZigubE2owQPiobvab0Tez5j+fBDaVOx1s
X-Gm-Gg: ASbGncvP7660hJpUDSbH9OZUQ8AQFkSxUaiUS9BxafzXoIUeUDZJPq6VT44jtISsv+1
	Omt0RLyQi+BpquKmPlZ1Y3W0nAWsJLOFAQ2XNsCQqjm7gIIeVuuVi3GqUJ5IIjo+ADQlZ5jrCw8
	1vwxwkVYEA25mOgfca4chfwektbDtz1SEEcuZQlRi0FmIFCvIk/0gJwQTR6wF5sYfkjMpb+oGB2
	P55+bcIkwrhPgGpLPuR+O1JhTZdpU08fEROBVKadsPGaG4xbMXYVad2vSkyld4sj4ETYeRpfEwq
	/3WUTyH6JoNDYJV7HWF+F7TwBIItKxSqPavbjWs2PDf3pxcDAjf0Xfh4uKOcJrmtqD0f4hI=
X-Google-Smtp-Source: AGHT+IFpFzxJNzNeputK7r9DAASjqJZCHu4J17L4pCHeG6WyVIz91KEDNsxW0G/vZL1x70o4ERH2kg==
X-Received: by 2002:a05:6a21:62c8:b0:1f5:84c8:5d03 with SMTP id adf61e73a8af0-1f5c10ec677mr104684637.3.1741897572967;
        Thu, 13 Mar 2025 13:26:12 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:12 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 10/29] xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
Date: Thu, 13 Mar 2025 13:25:30 -0700
Message-ID: <20250313202550.2257219-11-leah.rumancik@gmail.com>
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

[ Upstream commit 13928113fc5b5e79c91796290a99ed991ac0efe2 ]

[6.1: resolved conflicts with fscounters.c and rtsummary.c ]

Move all the declarations for functionality in xfs_rtbitmap.c into a
separate xfs_rtbitmap.h header file.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c     |  2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c |  1 +
 fs/xfs/libxfs/xfs_rtbitmap.h | 82 ++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/rtbitmap.c      |  2 +-
 fs/xfs/xfs_fsmap.c           |  2 +-
 fs/xfs/xfs_rtalloc.c         |  1 +
 fs/xfs/xfs_rtalloc.h         | 73 --------------------------------
 7 files changed, 87 insertions(+), 76 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_rtbitmap.h

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index aac071e4d000..c99fd7fe242e 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -19,11 +19,11 @@
 #include "xfs_trans.h"
 #include "xfs_alloc.h"
 #include "xfs_bmap.h"
 #include "xfs_bmap_util.h"
 #include "xfs_bmap_btree.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_quota.h"
 #include "xfs_trans_space.h"
 #include "xfs_buf_item.h"
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 655108a4cd05..9eb1b5aa7e35 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -14,10 +14,11 @@
 #include "xfs_inode.h"
 #include "xfs_bmap.h"
 #include "xfs_trans.h"
 #include "xfs_rtalloc.h"
 #include "xfs_error.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Realtime allocator bitmap functions shared with userspace.
  */
 
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
new file mode 100644
index 000000000000..546dea34bb37
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __XFS_RTBITMAP_H__
+#define	__XFS_RTBITMAP_H__
+
+/*
+ * XXX: Most of the realtime allocation functions deal in units of realtime
+ * extents, not realtime blocks.  This looks funny when paired with the type
+ * name and screams for a larger cleanup.
+ */
+struct xfs_rtalloc_rec {
+	xfs_rtblock_t		ar_startext;
+	xfs_rtblock_t		ar_extcount;
+};
+
+typedef int (*xfs_rtalloc_query_range_fn)(
+	struct xfs_mount		*mp,
+	struct xfs_trans		*tp,
+	const struct xfs_rtalloc_rec	*rec,
+	void				*priv);
+
+#ifdef CONFIG_XFS_RT
+int xfs_rtbuf_get(struct xfs_mount *mp, struct xfs_trans *tp,
+		  xfs_rtblock_t block, int issum, struct xfs_buf **bpp);
+int xfs_rtcheck_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		      xfs_rtblock_t start, xfs_extlen_t len, int val,
+		      xfs_rtblock_t *new, int *stat);
+int xfs_rtfind_back(struct xfs_mount *mp, struct xfs_trans *tp,
+		    xfs_rtblock_t start, xfs_rtblock_t limit,
+		    xfs_rtblock_t *rtblock);
+int xfs_rtfind_forw(struct xfs_mount *mp, struct xfs_trans *tp,
+		    xfs_rtblock_t start, xfs_rtblock_t limit,
+		    xfs_rtblock_t *rtblock);
+int xfs_rtmodify_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		       xfs_rtblock_t start, xfs_extlen_t len, int val);
+int xfs_rtmodify_summary_int(struct xfs_mount *mp, struct xfs_trans *tp,
+			     int log, xfs_rtblock_t bbno, int delta,
+			     struct xfs_buf **rbpp, xfs_fsblock_t *rsb,
+			     xfs_suminfo_t *sum);
+int xfs_rtmodify_summary(struct xfs_mount *mp, struct xfs_trans *tp, int log,
+			 xfs_rtblock_t bbno, int delta, struct xfs_buf **rbpp,
+			 xfs_fsblock_t *rsb);
+int xfs_rtfree_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		     xfs_rtblock_t start, xfs_extlen_t len,
+		     struct xfs_buf **rbpp, xfs_fsblock_t *rsb);
+int xfs_rtalloc_query_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		const struct xfs_rtalloc_rec *low_rec,
+		const struct xfs_rtalloc_rec *high_rec,
+		xfs_rtalloc_query_range_fn fn, void *priv);
+int xfs_rtalloc_query_all(struct xfs_mount *mp, struct xfs_trans *tp,
+			  xfs_rtalloc_query_range_fn fn,
+			  void *priv);
+bool xfs_verify_rtbno(struct xfs_mount *mp, xfs_rtblock_t rtbno);
+int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
+			       xfs_rtblock_t start, xfs_extlen_t len,
+			       bool *is_free);
+/*
+ * Free an extent in the realtime subvolume.  Length is expressed in
+ * realtime extents, as is the block number.
+ */
+int					/* error */
+xfs_rtfree_extent(
+	struct xfs_trans	*tp,	/* transaction pointer */
+	xfs_rtblock_t		bno,	/* starting block number to free */
+	xfs_extlen_t		len);	/* length of extent freed */
+
+/* Same as above, but in units of rt blocks. */
+int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
+		xfs_filblks_t rtlen);
+#else /* CONFIG_XFS_RT */
+# define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
+# define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
+# define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
+# define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
+# define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
+# define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
+#endif /* CONFIG_XFS_RT */
+
+#endif /* __XFS_RTBITMAP_H__ */
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index 0a3bde64c675..faf6e0890d44 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -9,11 +9,11 @@
 #include "xfs_format.h"
 #include "xfs_trans_resv.h"
 #include "xfs_mount.h"
 #include "xfs_log_format.h"
 #include "xfs_trans.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_inode.h"
 #include "xfs_bmap.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
 
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 062e5dc5db9f..a5b9754c62d1 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -21,11 +21,11 @@
 #include <linux/fsmap.h>
 #include "xfs_fsmap.h"
 #include "xfs_refcount.h"
 #include "xfs_refcount_btree.h"
 #include "xfs_alloc_btree.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_ag.h"
 
 /* Convert an xfs_fsmap to an fsmap. */
 static void
 xfs_fsmap_from_internal(
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 0bfbbc1dd0da..7ce122da43fe 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -17,10 +17,11 @@
 #include "xfs_trans.h"
 #include "xfs_trans_space.h"
 #include "xfs_icache.h"
 #include "xfs_rtalloc.h"
 #include "xfs_sb.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Read and return the summary information for a given extent size,
  * bitmap block combination.
  * Keeps track of a current summary block, so we don't keep reading
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 65c284e9d33e..11859c259a1c 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -9,60 +9,31 @@
 /* kernel only definitions and functions */
 
 struct xfs_mount;
 struct xfs_trans;
 
-/*
- * XXX: Most of the realtime allocation functions deal in units of realtime
- * extents, not realtime blocks.  This looks funny when paired with the type
- * name and screams for a larger cleanup.
- */
-struct xfs_rtalloc_rec {
-	xfs_rtblock_t		ar_startext;
-	xfs_rtblock_t		ar_extcount;
-};
-
-typedef int (*xfs_rtalloc_query_range_fn)(
-	struct xfs_mount		*mp,
-	struct xfs_trans		*tp,
-	const struct xfs_rtalloc_rec	*rec,
-	void				*priv);
-
 #ifdef CONFIG_XFS_RT
 /*
  * Function prototypes for exported functions.
  */
 
 /*
  * Allocate an extent in the realtime subvolume, with the usual allocation
  * parameters.  The length units are all in realtime extents, as is the
  * result block number.
  */
 int					/* error */
 xfs_rtallocate_extent(
 	struct xfs_trans	*tp,	/* transaction pointer */
 	xfs_rtblock_t		bno,	/* starting block number to allocate */
 	xfs_extlen_t		minlen,	/* minimum length to allocate */
 	xfs_extlen_t		maxlen,	/* maximum length to allocate */
 	xfs_extlen_t		*len,	/* out: actual length allocated */
 	int			wasdel,	/* was a delayed allocation extent */
 	xfs_extlen_t		prod,	/* extent product factor */
 	xfs_rtblock_t		*rtblock); /* out: start block allocated */
 
-/*
- * Free an extent in the realtime subvolume.  Length is expressed in
- * realtime extents, as is the block number.
- */
-int					/* error */
-xfs_rtfree_extent(
-	struct xfs_trans	*tp,	/* transaction pointer */
-	xfs_rtblock_t		bno,	/* starting block number to free */
-	xfs_extlen_t		len);	/* length of extent freed */
-
-/* Same as above, but in units of rt blocks. */
-int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
-		xfs_filblks_t rtlen);
 
 /*
  * Initialize realtime fields in the mount structure.
  */
 int					/* error */
@@ -100,59 +71,15 @@ xfs_rtpick_extent(
 int
 xfs_growfs_rt(
 	struct xfs_mount	*mp,	/* file system mount structure */
 	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
 
-/*
- * From xfs_rtbitmap.c
- */
-int xfs_rtbuf_get(struct xfs_mount *mp, struct xfs_trans *tp,
-		  xfs_rtblock_t block, int issum, struct xfs_buf **bpp);
-int xfs_rtcheck_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		      xfs_rtblock_t start, xfs_extlen_t len, int val,
-		      xfs_rtblock_t *new, int *stat);
-int xfs_rtfind_back(struct xfs_mount *mp, struct xfs_trans *tp,
-		    xfs_rtblock_t start, xfs_rtblock_t limit,
-		    xfs_rtblock_t *rtblock);
-int xfs_rtfind_forw(struct xfs_mount *mp, struct xfs_trans *tp,
-		    xfs_rtblock_t start, xfs_rtblock_t limit,
-		    xfs_rtblock_t *rtblock);
-int xfs_rtmodify_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		       xfs_rtblock_t start, xfs_extlen_t len, int val);
-int xfs_rtmodify_summary_int(struct xfs_mount *mp, struct xfs_trans *tp,
-			     int log, xfs_rtblock_t bbno, int delta,
-			     struct xfs_buf **rbpp, xfs_fsblock_t *rsb,
-			     xfs_suminfo_t *sum);
-int xfs_rtmodify_summary(struct xfs_mount *mp, struct xfs_trans *tp, int log,
-			 xfs_rtblock_t bbno, int delta, struct xfs_buf **rbpp,
-			 xfs_fsblock_t *rsb);
-int xfs_rtfree_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		     xfs_rtblock_t start, xfs_extlen_t len,
-		     struct xfs_buf **rbpp, xfs_fsblock_t *rsb);
-int xfs_rtalloc_query_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		const struct xfs_rtalloc_rec *low_rec,
-		const struct xfs_rtalloc_rec *high_rec,
-		xfs_rtalloc_query_range_fn fn, void *priv);
-int xfs_rtalloc_query_all(struct xfs_mount *mp, struct xfs_trans *tp,
-			  xfs_rtalloc_query_range_fn fn,
-			  void *priv);
-bool xfs_verify_rtbno(struct xfs_mount *mp, xfs_rtblock_t rtbno);
-int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
-			       xfs_rtblock_t start, xfs_extlen_t len,
-			       bool *is_free);
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)	(-ENOSYS)
-# define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
-# define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
 # define xfs_rtpick_extent(m,t,l,rb)			(-ENOSYS)
 # define xfs_growfs_rt(mp,in)				(-ENOSYS)
-# define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
-# define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
-# define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
-# define xfs_verify_rtbno(m, r)				(false)
-# define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
 # define xfs_rtalloc_reinit_frextents(m)		(0)
 static inline int		/* error */
 xfs_rtmount_init(
 	xfs_mount_t	*mp)	/* file system mount structure */
 {
-- 
2.49.0.rc1.451.g8f38331e32-goog


