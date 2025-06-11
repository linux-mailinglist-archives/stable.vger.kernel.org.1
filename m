Return-Path: <stable+bounces-152459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB093AD608C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CB77ACE20
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73A425949A;
	Wed, 11 Jun 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyJPF2AR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64D2BD586
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675700; cv=none; b=BkyKG4hMdWlqaJrYTaVcnThZOcN7MMOXPZkFfel4i7AGkY82WZjHXbTy7UwKYG20o5BE6QeKNtH3p+KsYsXL2OZ7Lo1gA2JoBJjp8z769ss2/vuYlbbjKW3Gbx8V4hbZ8RYgqlqfBctPsrg5qu7yMsf+0DlltSA57XQfhm8wEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675700; c=relaxed/simple;
	bh=dA3Bk3T7Hw25A6cRVhjnp1isfvGCExwRcl7eHgL883Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo2Gr6FcDddqtk3vOFG7aP8Xop1aH1wsWqFP7cmXhuCeDBK5kBoRb8ybEGfPAg8vtLw1YkN6OJ0GcnJ9eUrHNmGyuLUk8CGN49W0Z43FOdgzrzms98elxgqKIxAYdtfImJL8D+b9OKPJxj9TxkVDAtFzUSv2A1Sl9FK6S4EfsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyJPF2AR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313a188174fso1263629a91.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675698; x=1750280498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGcQUwZO2mA8QewyqXgdnzIRooDKJjWxPTOOk1GtVDs=;
        b=CyJPF2ARzyb83+C7ALCtylykjxNiD6DOszk3EV8ZcOsPxmj8k5bVlBbk0rjJVSi+FO
         pcLLqPsaMQMYVzIS8vLcg9cuh4nkc8ES5NEwL5xWZECBeHjoI7OPBnu9GuRK4YPBa+Mq
         jMVEWWzRuPitgCMWAUQsRY1Mvdn2xghwqVCU+Hz3vmecw42PZMCS8xBC2W6phrDl8hxl
         fl2EQkrl4L8kNb2HX/vUMJUH6uUF2/DVJm8Xcbn6fkRDdqhGSylulkCNv3xry7scgnSh
         QNfV8BwkHRsMSw9t3GBFshpli99IG3Rek98TrHCnIonus16XpayhYsob1vDFKKklStrM
         jelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675698; x=1750280498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGcQUwZO2mA8QewyqXgdnzIRooDKJjWxPTOOk1GtVDs=;
        b=U+HpuTzGxMwo6AGzjSiubSjQo72bt+wR+8BqBpQOl0OsAEQuYZZ6Gj9ufkW/s/vdW2
         fv9IFsMvbN8LcaxQ7p0/VK9fdxxxkYC2jeCZrGeAMRhWYzgwFuKcL45g6s6mMHOkozOD
         YPl2yOf2HHAgdj0QFaTr4WaOSJllBGpr1W3xPnqZ6CffJ7XdGaNejGPEeJunbkF8pYON
         Y6gUDUE55NPkwhuZuguic1+xnZBs6dNE2lhECwp72jH2bVienhTScEmeOJiL/n2S6Z3z
         p/7AD1cki2E1XElNnJxADFRzPWxEbB2MUswSpaUtAS/5dyDATc8QI+azBX5MdxeWi9vt
         hfGQ==
X-Gm-Message-State: AOJu0YwSr8aIFMjoYAeRfUJpXN7KbHEBVFqDePiq3dyhfGhH6u/M8QyI
	2vwMaBVEs3ofC51EIDK+BWRlaPxm7mopAQmLI6QeEeAHsDAQTbl3BrTnXIdBmtYm
X-Gm-Gg: ASbGncuhgeUOXEHVvLfyBBL/xdnRAauMruGE9tMuVxWowW0U0onpmD5g4SLb75NpuNk
	TKz3u4qO/OdKjARlF2+1hVgL3LKQyH/On3yGGlndkAYhtwDlKO4jhIkgqgOFmuo1jUDUNXjKBXy
	zUCwClk52x6P1yzCLx0Cjf+RypNrY6ehNkgkO0WM4EgUCZlj3XZKt+Q+J0I9IR5MYIG9Rt4NrU6
	x/wGhdc59SA/hYO+YGr4NI+lzU+I4HfmqnEluRmp6CNQ/aIWfUwYazasXg0XSHcNNLdID+Iu6T1
	bBwyXWq6N8qMSpRv4tKAPWy8B8uCIWYC+zjmxLIT4iqqeWaezdHLGlBTVCfYnHY+SsZqm9KPdYV
	5UsL01P6Wp3s=
X-Google-Smtp-Source: AGHT+IF/C1yxftibFjbfFuIJ+1+6t9FYL18U6EwAcYTkj1kIPKo8li5HBWIai/wiyX1kWTb55pmOiA==
X-Received: by 2002:a17:90b:1850:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-313bfd7b069mr1205386a91.2.1749675698201;
        Wed, 11 Jun 2025 14:01:38 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:37 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 05/23] xfs: fix logdev fsmap query result filtering
Date: Wed, 11 Jun 2025 14:01:09 -0700
Message-ID: <20250611210128.67687-6-leah.rumancik@gmail.com>
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

[ Upstream commit a949a1c2a198e048630a8b0741a99b85a5d88136 ]

The external log device fsmap backend doesn't have an rmapbt to query,
so it's wasteful to spend time initializing the rmap_irec objects.
Worse yet, the log could (someday) be longer than 2^32 fsblocks, so
using the rmap irec structure will result in integer overflows.

Fix this mess by computing the start address that we want from keys[0]
directly, and use the daddr-based record filtering algorithm that we
also use for rtbitmap queries.

Fixes: e89c041338ed ("xfs: implement the GETFSMAP ioctl")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 202f162515bd..cdd806d80b7c 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -435,40 +435,26 @@ xfs_getfsmap_logdev(
 	struct xfs_getfsmap_info	*info)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_rmap_irec		rmap;
 	xfs_daddr_t			rec_daddr, len_daddr;
-	xfs_fsblock_t			start_fsb;
-	int				error;
+	xfs_fsblock_t			start_fsb, end_fsb;
+	uint64_t			eofs;
 
-	/* Set up search keys */
+	eofs = XFS_FSB_TO_BB(mp, mp->m_sb.sb_logblocks);
+	if (keys[0].fmr_physical >= eofs)
+		return 0;
 	start_fsb = XFS_BB_TO_FSBT(mp,
 				keys[0].fmr_physical + keys[0].fmr_length);
-	info->low.rm_startblock = XFS_BB_TO_FSBT(mp, keys[0].fmr_physical);
-	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
-	error = xfs_fsmap_owner_to_rmap(&info->low, keys);
-	if (error)
-		return error;
-	info->low.rm_blockcount = 0;
-	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
+	end_fsb = XFS_BB_TO_FSB(mp, min(eofs - 1, keys[1].fmr_physical));
 
 	/* Adjust the low key if we are continuing from where we left off. */
 	if (keys[0].fmr_length > 0)
 		info->low_daddr = XFS_FSB_TO_BB(mp, start_fsb);
 
-	error = xfs_fsmap_owner_to_rmap(&info->high, keys + 1);
-	if (error)
-		return error;
-	info->high.rm_startblock = -1U;
-	info->high.rm_owner = ULLONG_MAX;
-	info->high.rm_offset = ULLONG_MAX;
-	info->high.rm_blockcount = 0;
-	info->high.rm_flags = XFS_RMAP_KEY_FLAGS | XFS_RMAP_REC_FLAGS;
-	info->missing_owner = XFS_FMR_OWN_FREE;
-
-	trace_xfs_fsmap_low_key(mp, info->dev, NULLAGNUMBER, &info->low);
-	trace_xfs_fsmap_high_key(mp, info->dev, NULLAGNUMBER, &info->high);
+	trace_xfs_fsmap_low_key_linear(mp, info->dev, start_fsb);
+	trace_xfs_fsmap_high_key_linear(mp, info->dev, end_fsb);
 
 	if (start_fsb > 0)
 		return 0;
 
 	/* Fabricate an rmap entry for the external log device. */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


