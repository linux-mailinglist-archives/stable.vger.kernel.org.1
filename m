Return-Path: <stable+bounces-111225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BBA22439
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B851679EF
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F91E230E;
	Wed, 29 Jan 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Miu1BNLq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2A1E0DFE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176467; cv=none; b=cXbJl1WQjkDGCtwY50OU+LLcPbVZ+pnHc2mmZ0QYorrJV/ImawmMLq2/2CWSlP/Quvs63rtiyiZQJbDwVBXlfyrrgzV221hW3iaRFu1Hk2lcYE5hICAR5k+LqeqZa5jilMdhIlZSfUa4/hlpUdYPnj57qifJKtCkD6iw80uKFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176467; c=relaxed/simple;
	bh=6vjJx3Caog8s7bK/C7wEPOB7DMWBBYpPgcL9iVrNgLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltoAEXe5h5UanihI2JcwxrPUeYR2XNn59YbmxwBWmu3Fp9rRDrVjUvdSKGsOkmLwpej+NpaXNCiTUVCx1/ofk7LujSZdiVyYB8e5P/nt3cziqMMoZmfFRUqngNXWTdszuJYuu+eSdJbxW2xGjaUysFG/F7mhiZi3BBwtuz3zkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Miu1BNLq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso132972865ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176465; x=1738781265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s57dM5p1N6eiHX9IiALHJD+Z+haC3a3ncRGp07HrJ0=;
        b=Miu1BNLqTzJiIJ3J5EzfuumfGLKHitF8ehyGz14XGj9vUxv1WNpzyUy5otVMI8WhWS
         LhfEnfAgvJ5vC5kbduLXqDGA8WmfKQM0hc8NYw4eCy7UGIz3/PKufsr3frq+LDy03+g7
         jJtPheqOLSRnxymrQj1Xg0pEoCKSp7XG/SaG17/yPjycu28UBbHIMzKq0pYIJnsrhTfe
         wJ8JmiIfilJtO+EZAZYknVwhvZvL3jDppGi+z6RlB0IjHoe6IqlSpuOC5fTJEvQKfFBs
         28hqrcyNwhbCj2IQ6zuZ3EmuALsCSk1S1CzTuKdn6mXIeifsRfNaWB7QzewiEnmtq6F2
         YUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176465; x=1738781265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s57dM5p1N6eiHX9IiALHJD+Z+haC3a3ncRGp07HrJ0=;
        b=fZ59yTHukyrO+/8s4VazExVzpcIb99DUy0YHFaJK+vxUDb9GSJ6q/bRFwl8YyVbn9g
         l5hYHufh+KY0McCebe++R+5k+gZ8rPy2Cl4ZBmoC+Z0wB6NEb6COLtZdR9AhFSVRhV8K
         AYQZvMt6HG/K6Sl90VL6GQvRPRqW6MxHEZaM27xsrYm5TinmAr7Gey/Lf5A1WEnke8qo
         f6vP+I2/ih3PyRYufJasAh6k7c/+SGUdWlKmcaaGVhVCy1b40UownLA0x1w/Uny/e7Js
         wfjZUIVO4FgsCf0HEDEnUpfH3WjFondEaSn3gBNyuQikYbXB/8JZ4WNk6hGl15uxKzPi
         0/yg==
X-Gm-Message-State: AOJu0YyvitB0EnC8Bcus+EtX2R560DHqYKMaGylBkM46jfMd6tumdOdE
	p/1aRTHWib1ZnIolNK4s7oCUU20gD5PSqwD9fzBUEgeLycjWzryNwrNqP7GL
X-Gm-Gg: ASbGncvpcJVD4v0MlUSA01Gw54loHAAmMbkqLbwkcMZtgQSYx4qeEhSuoZ1LnPhZ8pD
	kDqKF06p9SzuYuZgK0Oq5LtdUya/G2AJo8Gbf/pH/ZynCxxKak2t68ZlQAxHMjypfycgjWJyula
	SuGwLGSQKlX3VwLDa51jU5L63x0axfojjkV462XgiRiyW9X/paFiv2y/f/fc9UdI2F/6ggamU1w
	ykUY5HnGw+EGFANIYOOu9lziQE2kofLYoOIjtxnV7MzJfPFyDQ59DM5dz10sg0up4vjYStzqKpR
	yKxKVc3NFSBrDjEVy5LZclNhPjlfYqAqJtsPCYkuNSU=
X-Google-Smtp-Source: AGHT+IG2sEGnHGNN2rVJoxJTqkWmBk0YfAwsXC0QlVwnNDYdsXF07XyOJUnOJQRG5Xl/LCjuYANoRQ==
X-Received: by 2002:a17:903:2f88:b0:216:7cef:99b3 with SMTP id d9443c01a7336-21dd7e048b8mr57154425ad.52.1738176465069;
        Wed, 29 Jan 2025 10:47:45 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:44 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Omar Sandoval <osandov@fb.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 14/19] xfs: fix internal error from AGFL exhaustion
Date: Wed, 29 Jan 2025 10:47:12 -0800
Message-ID: <20250129184717.80816-15-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit f63a5b3769ad7659da4c0420751d78958ab97675 ]

We've been seeing XFS errors like the following:

XFS: Internal error i != 1 at line 3526 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_insert+0x1ec/0x280
...
Call Trace:
 xfs_corruption_error+0x94/0xa0
 xfs_btree_insert+0x221/0x280
 xfs_alloc_fixup_trees+0x104/0x3e0
 xfs_alloc_ag_vextent_size+0x667/0x820
 xfs_alloc_fix_freelist+0x5d9/0x750
 xfs_free_extent_fix_freelist+0x65/0xa0
 __xfs_free_extent+0x57/0x180
...

This is the XFS_IS_CORRUPT() check in xfs_btree_insert() when
xfs_btree_insrec() fails.

After converting this into a panic and dissecting the core dump, I found
that xfs_btree_insrec() is failing because it's trying to split a leaf
node in the cntbt when the AG free list is empty. In particular, it's
failing to get a block from the AGFL _while trying to refill the AGFL_.

If a single operation splits every level of the bnobt and the cntbt (and
the rmapbt if it is enabled) at once, the free list will be empty. Then,
when the next operation tries to refill the free list, it allocates
space. If the allocation does not use a full extent, it will need to
insert records for the remaining space in the bnobt and cntbt. And if
those new records go in full leaves, the leaves (and potentially more
nodes up to the old root) need to be split.

Fix it by accounting for the additional splits that may be required to
refill the free list in the calculation for the minimum free list size.

P.S. As far as I can tell, this bug has existed for a long time -- maybe
back to xfs-history commit afdf80ae7405 ("Add XFS_AG_MAXLEVELS macros
...") in April 1994! It requires a very unlucky sequence of events, and
in fact we didn't hit it until a particular sparse mmap workload updated
from 5.12 to 5.19. But this bug existed in 5.12, so it must've been
exposed by some other change in allocation or writeback patterns. It's
also much less likely to be hit with the rmapbt enabled, since that
increases the minimum free list size and is unlikely to split at the
same time as the bnobt and cntbt.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 8bb024b06b95..74d039bdc9f7 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2271,20 +2271,41 @@ xfs_alloc_min_freelist(
 	const uint8_t		*levels = pag ? pag->pagf_levels : fake_levels;
 	unsigned int		min_free;
 
 	ASSERT(mp->m_alloc_maxlevels > 0);
 
+	/*
+	 * For a btree shorter than the maximum height, the worst case is that
+	 * every level gets split and a new level is added, then while inserting
+	 * another entry to refill the AGFL, every level under the old root gets
+	 * split again. This is:
+	 *
+	 *   (full height split reservation) + (AGFL refill split height)
+	 * = (current height + 1) + (current height - 1)
+	 * = (new height) + (new height - 2)
+	 * = 2 * new height - 2
+	 *
+	 * For a btree of maximum height, the worst case is that every level
+	 * under the root gets split, then while inserting another entry to
+	 * refill the AGFL, every level under the root gets split again. This is
+	 * also:
+	 *
+	 *   2 * (current height - 1)
+	 * = 2 * (new height - 1)
+	 * = 2 * new height - 2
+	 */
+
 	/* space needed by-bno freespace btree */
 	min_free = min_t(unsigned int, levels[XFS_BTNUM_BNOi] + 1,
-				       mp->m_alloc_maxlevels);
+				       mp->m_alloc_maxlevels) * 2 - 2;
 	/* space needed by-size freespace btree */
 	min_free += min_t(unsigned int, levels[XFS_BTNUM_CNTi] + 1,
-				       mp->m_alloc_maxlevels);
+				       mp->m_alloc_maxlevels) * 2 - 2;
 	/* space needed reverse mapping used space btree */
 	if (xfs_has_rmapbt(mp))
 		min_free += min_t(unsigned int, levels[XFS_BTNUM_RMAPi] + 1,
-						mp->m_rmap_maxlevels);
+						mp->m_rmap_maxlevels) * 2 - 2;
 
 	return min_free;
 }
 
 /*
-- 
2.48.1.362.g079036d154-goog


