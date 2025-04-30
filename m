Return-Path: <stable+bounces-139229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D4DAA5751
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD179A13EF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42C2D0AC9;
	Wed, 30 Apr 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMCwARZJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE32D0ACA
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048435; cv=none; b=TKyNnCSJn2iIsHWptsquf+ryKqV7AMSSutXzMeLN+FjFgQ8cd/dl2QN4phyxdzfoy6CoaYPOLJRy8tbqDTdnYRE+IQNGyOngn3lISj7PwQEgp7rdN8i7O556cFMe4zRl3piup4UwIT8pEcgZisBjkK4S7aFQB46mgY82izBpRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048435; c=relaxed/simple;
	bh=8P5rzlQpDwtQcqcA73qe7YjasyXRP3t15vByIojlsW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm6nETJ5yqOm4Vpg+eEfc4Z4Jp7kHw7wyKLfU5hb4goLR+fCYvH30kwaHRb3Nk5pSo6WnLk/DqAXkAX+RD5WkOHY5AhjvqCmATJB3ZKjCd54nkziA3GJEv6lTekfFv+xRzeIIO6lUcXIWc6PGV2KNP/Pv+BADzGeUXJqMoAlWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMCwARZJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73bb647eb23so380977b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048433; x=1746653233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GugQTnlR3WC8uUHbfblBEf9yAAuCbj+TDQtDCVZGoTk=;
        b=YMCwARZJ+HkpLUvs55v8ADvqsd97RaqI0XnGKLHK84hSTJcOEpO3DxnSSA3gFVT22s
         oesP4QMyrYO237SPQDbGw7iftsSItm1p2jx4pdsOdKPD9xVShr91WFw/p7TBMk1gmHl1
         5xb5F8uffgH+inSXv7z29feW8wHtFRu1hj+2vufv8jy2bDTaePiWq1KKplOWZ81t1VpC
         ytce0uOw4+sGD7peTvG2ou98+G20D472zE5Sn6YvrVFIl/T8NYHptqcxV8b7lmWOdDFC
         LfOzcw3zgNmFuqPhmJifShwB+o5Xsido1vJ0+gpq3rQdsXPy5IM8FJF1/jRwilvr4jGN
         I98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048433; x=1746653233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GugQTnlR3WC8uUHbfblBEf9yAAuCbj+TDQtDCVZGoTk=;
        b=NFOZ9sKQFqKeFi0VI8pWNuOHG5uYPXdMvuPVM8uKd+txO2DjISEWunZv0ejXqmZaJw
         vOaL44DypLpUCk8OwckUNsM6avhGgw96KLXVo3SpxiZGUehTOlCPaAdkr0miS8xBNeFk
         ZL30pbpSSsqopFxTXURR3Ob7pRv6X1ojZcQE94tXh6klWExqoigSCeWR/wyQndGpK4JC
         CrU0EckpOM3r5aCkDlX8GGHxoq5pGo4VvmApoBur37QQNLFvkv+sgahNCz8l/b02sP+b
         yA0gmGUFjLeL9aNa8/ZzMHiaFpparh5DsynSHOtQuXBK3Bniw/YHKXWbjZeOry/i1Gma
         nUYg==
X-Gm-Message-State: AOJu0YyKHBjxKDjMPiIaXKpsV+ZhacVzMM60lAyISHrb5/l1yoFq+pus
	BvVnYILhPrunEEVeMKd94/p0J2lratinetwaa2TkUWDEHB0lNihP2wOvDw==
X-Gm-Gg: ASbGncuInksU7SifZiVLfhiOiJAPTOTxDzcsIibTLgCyLHgs0fevyQEAOAjEOwQ5gx0
	e3sXJwNMmeP2Uu7XsGBbR++SEsWRIWUW9NLt7B6MFuS/lFO5bycm0hXwGAFzMxYIr/O2jLMYqfB
	+CEoSLLUso9qTlDjEBsS52b0POs7FGXVsEqGVHtj7fpeLu77g/pW41FRuosaBJoXHGimyma5qKj
	b9MbCB5BQGq51Hd850rWbAxgtkT/4JPRQZWFh+Yg3cr1iJTUVvmEuElg7daUb010bCWpuSxjWmJ
	Djco0HepvsCKqZ/3K1I0DW2JCD46rduM5cvf9RRN+sc44Md3+nnXiIDnd5J5AuD0yhEe
X-Google-Smtp-Source: AGHT+IEwRkpbJbnIj8tAgPuCYtvMeg+cFsT6BZ7WEWqLgf0EQlw8cpARhVI9hEKxtaocdYUl47U/ow==
X-Received: by 2002:a05:6a00:acd:b0:736:34ca:deee with SMTP id d2e1a72fcca58-7403a77aae3mr6381988b3a.7.1746048432746;
        Wed, 30 Apr 2025 14:27:12 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:12 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 02/16] xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
Date: Wed, 30 Apr 2025 14:26:49 -0700
Message-ID: <20250430212704.2905795-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d69bee6a35d3c5e4873b9e164dd1a9711351a97c ]

xfs_bmap_add_extent_delay_real takes parts or all of a delalloc extent
and converts them to a real extent.  It is written to deal with any
potential overlap of the to be converted range with the delalloc extent,
but it turns out that currently only converting the entire extents, or a
part starting at the beginning is actually exercised, as the only caller
always tries to convert the entire delalloc extent, and either succeeds
or at least progresses partially from the start.

If it only converts a tiny part of a delalloc extent, the indirect block
calculation for the new delalloc extent (da_new) might be equivalent to that
of the existing delalloc extent (da_old).  If this extent conversion now
requires allocating an indirect block that gets accounted into da_new,
leading to the assert that da_new must be smaller or equal to da_new
unless we split the extent to trigger.

Except for the assert that case is actually handled by just trying to
allocate more space, as that already handled for the split case (which
currently can't be reached at all), so just reusing it should be fine.
Except that without dipping into the reserved block pool that would make
it a bit too easy to trigger a fs shutdown due to ENOSPC.  So in addition
to adjusting the assert, also dip into the reserved block pool.

Note that I could only reproduce the assert with a change to only convert
the actually asked range instead of the full delalloc extent from
xfs_bmapi_write.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0235c1dd3d7e..f8a355e1196f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1528,10 +1528,11 @@ xfs_bmap_add_extent_delay_real(
 			}
 			error = xfs_bmbt_update(bma->cur, &LEFT);
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_LEFT_CONTIG:
 		/*
 		 * Filling in all of a previously delayed allocation extent.
@@ -1557,10 +1558,11 @@ xfs_bmap_add_extent_delay_real(
 			}
 			error = xfs_bmbt_update(bma->cur, &LEFT);
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
 		/*
 		 * Filling in all of a previously delayed allocation extent.
@@ -1590,10 +1592,11 @@ xfs_bmap_add_extent_delay_real(
 			}
 			error = xfs_bmbt_update(bma->cur, &PREV);
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING:
 		/*
 		 * Filling in all of a previously delayed allocation extent.
@@ -1622,10 +1625,11 @@ xfs_bmap_add_extent_delay_real(
 			if (XFS_IS_CORRUPT(mp, i != 1)) {
 				error = -EFSCORRUPTED;
 				goto done;
 			}
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG:
 		/*
 		 * Filling in the first part of a previous delayed allocation.
@@ -1659,10 +1663,11 @@ xfs_bmap_add_extent_delay_real(
 			}
 			error = xfs_bmbt_update(bma->cur, &LEFT);
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING:
 		/*
 		 * Filling in the first part of a previous delayed allocation.
@@ -1746,10 +1751,11 @@ xfs_bmap_add_extent_delay_real(
 		PREV.br_startblock = nullstartblock(da_new);
 
 		xfs_iext_update_extent(bma->ip, state, &bma->icur, &PREV);
 		xfs_iext_next(ifp, &bma->icur);
 		xfs_iext_update_extent(bma->ip, state, &bma->icur, &RIGHT);
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_RIGHT_FILLING:
 		/*
 		 * Filling in the last part of a previous delayed allocation.
@@ -1793,10 +1799,11 @@ xfs_bmap_add_extent_delay_real(
 
 		PREV.br_startblock = nullstartblock(da_new);
 		PREV.br_blockcount = temp;
 		xfs_iext_insert(bma->ip, &bma->icur, &PREV, state);
 		xfs_iext_next(ifp, &bma->icur);
+		ASSERT(da_new <= da_old);
 		break;
 
 	case 0:
 		/*
 		 * Filling in the middle part of a previous delayed allocation.
@@ -1913,15 +1920,13 @@ xfs_bmap_add_extent_delay_real(
 		da_new += bma->cur->bc_ino.allocated;
 		bma->cur->bc_ino.allocated = 0;
 	}
 
 	/* adjust for changes in reserved delayed indirect blocks */
-	if (da_new != da_old) {
-		ASSERT(state == 0 || da_new < da_old);
+	if (da_new != da_old)
 		error = xfs_mod_fdblocks(mp, (int64_t)(da_old - da_new),
-				false);
-	}
+				true);
 
 	xfs_bmap_check_leaf_extents(bma->cur, bma->ip, whichfork);
 done:
 	if (whichfork != XFS_COW_FORK)
 		bma->logflags |= rval;
-- 
2.49.0.906.g1f30a19c02-goog


