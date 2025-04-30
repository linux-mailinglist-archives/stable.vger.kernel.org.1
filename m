Return-Path: <stable+bounces-139236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF0AA574F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15811B66815
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A992D269E;
	Wed, 30 Apr 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxn54VhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687302D269C
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048442; cv=none; b=R89XOd05Ualzhsql3H6W9LhckJoVSLlXkXZB+52rEb50yA3hnKicMBR0O0CQCr63De0LVsOervA+lc8wZt7lLMzDSl4gLA9co9c8fRlpXNEGhsv4dgO/7XwMQhmzzvA9rgLgSlDH7V0zlaq8riYqqtSMX3jfQnN8LxIKsnB9yMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048442; c=relaxed/simple;
	bh=97JtZVdw0hhs5hqR/1f1rTZfZhgscnF00y+CX2//uu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUw7hBVv7yjnKPW+smV+94d4LTQPfatSkwHrtcrKUgfP1tHztvJj4nkSueEbz25imhIZi/TATBP2EVgg5bLfXaEcRMQDLNwlHQOvw6ruTINrGgjOUkvWkcktWmi2L8m9SvXAGUV3NrgfAC5ZCcTKWVRAyvhZqGrGy77Kd09p7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxn54VhZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736b0c68092so382052b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048440; x=1746653240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFEvSr759FQ8v8G9pUy3oih77cUyS6T1JdL8J0ioieQ=;
        b=bxn54VhZsr5TMhi2vhSLgsssHKPUJmfbkYHxz0eni5Qse34g02vSeVOqc5iNwdRwQ5
         z1G4CqgTqV0ScJR2OP+FTSh6ikKbLCzHpzJI933MOc58Y22t95UtUBJDRGVuhwuwAxOW
         kn/XTq85dti45/WZCpqfw8fnMIejsnaUjF6sjthWpUSG6W9dr0E58t8FvCuIFLXlZEHx
         4+c42KYbuydi4KdEXGvO+KI9zmGxysqL0l72pdJWEqlAYZzkjrvSSXUblSSFhciachuJ
         Kflkd4gVbZvyD20hqREfFQeZukD6qZ4oUr53LTvth3VX9DgStSc52LIAGGPR/vROqEno
         8SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048440; x=1746653240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFEvSr759FQ8v8G9pUy3oih77cUyS6T1JdL8J0ioieQ=;
        b=Fvl7DI/hUVFhicoJMckBzlW093AmzTyECLraikdnZy9zAqGvvir+UL/C6AVx8Oixaa
         5vWfiPRNngKL3m9/KDrvQZRmsRkuOfcKfLmtVPBMSadYYRdh4ycq8MEL2KbOTk/6hYmW
         C5KnRK718BM3f22Y5r/TErJh3SMKzq63llle3egeZ2qFQh0/xaiaRd0LPhoGu3B76WJd
         /VYvUWgYKG1RkM6nCi4CeaffrEYkDREuEPlMfeatEeYC8Gx/TIW2rstdO2eu0RksYJ9s
         nlqu0x+6d/QfVWoDNM9JKId6olynevWHCz3ptEgYhusWn5CODiqoxPGJ5m0WMqdpuEHM
         Yr1g==
X-Gm-Message-State: AOJu0YziIuNDGbfJIFnoFpMgCgUJ0cklOZQ82PtFrxOsh/4FC8MHjnxj
	8ScuDLiRHlwf2W3KYpUUDXxIJWB9be6d31652YC6JDKMCC00HfKofUiIgxyy
X-Gm-Gg: ASbGncvpSHsVabaHorOiSLzjqFBzlU7As3Yv6nBGfTtxn10y1vefvv15wl3fJ+BaWqh
	zJJbOq/VLEixfnkqlMrFppoSKGvVRCGYx1kUPAHN9XiQrD6QoBsMD/46QZ0bwUJGHHnIDTceYFD
	5LSaYfAQJT91LzWnoD1YrQctxTicko9ZT0bm/+o7pKwqimpNwPdUS/A4rFlUswSXJZkeVGO5kaJ
	VwecDEzhhO5+eVGnfpaPjf7vxz2o7QwCG0F1u6PpD4S7EK2r1+1XKEHlxMbD2SMVF0SM+GOBrvO
	WdDmkreOO/VjtBzeoWRRbOIceAgXhuW/9rzkaiSLOK4M3qM8Gjnfbfg7otyrpnDXVuimSgwX6IY
	AGW4=
X-Google-Smtp-Source: AGHT+IESI2TrDqd+wlKL5S/bgZYhcRRUNvkwS8u/ujB6Yemj2R42wHC/byEvuw4Nh56A3qBurcOa9Q==
X-Received: by 2002:a05:6a20:9f97:b0:1f5:87ea:2a10 with SMTP id adf61e73a8af0-20bd6848f90mr64424637.9.1746048440338;
        Wed, 30 Apr 2025 14:27:20 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:20 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Zhang Yi <yi.zhang@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 09/16] xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
Date: Wed, 30 Apr 2025 14:26:56 -0700
Message-ID: <20250430212704.2905795-10-leah.rumancik@gmail.com>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit fc8d0ba0ff5fe4700fa02008b7751ec6b84b7677 ]

Allow callers to pass a NULLL seq argument if they don't care about
the fork sequence number.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index f8a355e1196f..92d321dd8944 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4578,11 +4578,12 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
 		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-		*seq = READ_ONCE(ifp->if_seq);
+		if (seq)
+			*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
 
 	bma.tp = tp;
 	bma.ip = ip;
@@ -4624,11 +4625,12 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
 	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-	*seq = READ_ONCE(ifp->if_seq);
+	if (seq)
+		*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
 
 	error = xfs_bmap_btree_to_extents(tp, ip, bma.cur, &bma.logflags,
-- 
2.49.0.906.g1f30a19c02-goog


