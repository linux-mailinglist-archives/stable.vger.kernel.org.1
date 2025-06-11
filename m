Return-Path: <stable+bounces-152468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8AFAD6096
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8747D3AA6F1
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4891EB39;
	Wed, 11 Jun 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHa1cD4b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16C25949A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675710; cv=none; b=Md4EfGk7mJ+8dRG4M1dFn1IYpHji+QNrMPiplCGG3AuJPV5u/jEPEaaYBW0ERn9Ju462zRw8wvaVN9B8mwWmu4LDk2HSb6Ap2bA+mlD6nCcFIWZY6t4z+T+Y7576eayhdlSkUtcKKXLQnjvz2sS/QIHWZzSiQVouuuRIGDb4YDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675710; c=relaxed/simple;
	bh=JgQ6lFEGf/8/P0AZ5p/9kNVn5MEy/wxym5fmkn7/z4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qb6/YeHn51O4h3VlUrTKlLPKrNwRcdyNGFsu+OboRjMxNJu1CzeF8n8S6FFAXBx9a7swVhHPpVZjHUM+hxq4jF8AjY8c8HWR/Ka4n3r06yyEu5G9tM780fy9ZNtVFaYkyFe2PT8gOPVqB92Xqs/cpinOXzTewQq65CpnNYED048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHa1cD4b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b9dfb842so3347165ad.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675708; x=1750280508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGlkrYyz8Nfk4HOVd3bkXVI8Ve/yITe9i9g3y/fEfWs=;
        b=KHa1cD4bPCXhvJx8CvLu52iqUPInPkbhbluNbVtlWR4TBc1SZewpAsrHC0vlGlXFyX
         841iWhNGC2vD8FZ1AWS5SQETWEPKT5TsTKlcwSW8PCqqPoeC2shhE3WLPIaLl6QHCILL
         7X/VtJ+5kORscddSCu7hYKD3CcyoqSP1sqtQ9/Stn/f+7L9szrjdQeZL5BAQr2Fwj/FS
         Z36EtkMdKzO+MONxk3XHhPw7aJy0Ej2hqeoDBjqXPTvD10P1XFAiZP1rcXeMVNxs91QW
         ctVDte77UmgamxsHUiP5uP5c3pDEruH+F5Mswo+P2JACT2AkeH/3FjJjaNPEJd/IkOs5
         Y6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675708; x=1750280508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGlkrYyz8Nfk4HOVd3bkXVI8Ve/yITe9i9g3y/fEfWs=;
        b=A9xl3hcF2L8tXNeuIK1hbY/zj/TdHslEq0myap8kHQRzd7t3o/u/pEaOBYmZwAhYkU
         m53eEaqeU2nXYhhyYMUviAyUEXC5PBvNnGOUYuAvumBRqYhn7PVS0jG/TANt2P5kaRL6
         T2Ea4jA0cP+BCACqd8kLLSqq+GoxV6DXeiGYErCm4KVOG0sWt57tUJvt12Qv1VraAF1m
         HUp1VjTPft94UQYJ6D0ORAwna8hMiTWium/TGCmN4va0y8GoeOtXKhXC2/t2xz7d0DVz
         XgjZGyKqBna57j7xLHkIkR9ck5lWti0VL3mZecfTGl0TPI1bLbiwY1GC5VdMoFs7qaLI
         kdIw==
X-Gm-Message-State: AOJu0Yw3MBsL9G5UOfmuQ4Ylxf87TbdEDvQlDaBHviBHF+Jck/T6CmMa
	wGBQOSxrla4nRgP+BOJD7qZqXdYPeOLzl33IGjdDU75xr4z+KJsqlikxhDSC4smD
X-Gm-Gg: ASbGncs5MBKHEDrkvYYN6RMS2ptDDK4qBWEb0ynmzRUpt+7zLr7K8XPAyCOHGOfW+Eb
	mi9MnJV3X+EK+JR+idrhI653vaZ+pFiA1QhGqNM7TFIsUW6WaXMw+3H4lJJaULS77LbByQEmF56
	5sB2JtOsUElcpDT2Ra37eVOUZSYSYVAr0k7GOxDxf89xTdxXTkKMdWXIdothTgJq4KR+g1rhlsm
	FuoYAGiA18pGNuhMnPQ9bMODf4xDaRVm/D+H2y00DEGCvC5QpG4yeTXPQ6zzelJU0w0kKEwQbkF
	EbAn876W7JI5VrYchHnLRcHa92xGsVgJJnRQEPSSyu3u4ZwO6qH+23oazrSypOn9kMDgRyQh9Ly
	JUIMdzfOsMu/L+j4WRm98xA==
X-Google-Smtp-Source: AGHT+IG9sIQISYR3oO/Afktk3g7jU6wvFyjEePq7SQsnyy7w8u3VQrHx+Ej0x8zLAmQHB3hM+Ic1yA==
X-Received: by 2002:a17:902:e889:b0:234:c549:d9f1 with SMTP id d9443c01a7336-2364d90fdc0mr7677455ad.47.1749675707793;
        Wed, 11 Jun 2025 14:01:47 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:47 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 14/23] xfs: Fix xfs_flush_unmap_range() range for RT
Date: Wed, 11 Jun 2025 14:01:18 -0700
Message-ID: <20250611210128.67687-15-leah.rumancik@gmail.com>
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

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit d3b689d7c711a9f36d3e48db9eaa75784a892f4c ]

Currently xfs_flush_unmap_range() does unmap for a full RT extent range,
which we also want to ensure is clean and idle.

This code change is originally from Dave Chinner.

Reviewed-by: Christoph Hellwig <hch@lst.de>4
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 62b92e92a685..dabae6323c50 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -961,18 +961,22 @@ int
 xfs_flush_unmap_range(
 	struct xfs_inode	*ip,
 	xfs_off_t		offset,
 	xfs_off_t		len)
 {
-	struct xfs_mount	*mp = ip->i_mount;
 	struct inode		*inode = VFS_I(ip);
 	xfs_off_t		rounding, start, end;
 	int			error;
 
-	rounding = max_t(xfs_off_t, mp->m_sb.sb_blocksize, PAGE_SIZE);
-	start = round_down(offset, rounding);
-	end = round_up(offset + len, rounding) - 1;
+	/*
+	 * Make sure we extend the flush out to extent alignment
+	 * boundaries so any extent range overlapping the start/end
+	 * of the modification we are about to do is clean and idle.
+	 */
+	rounding = max_t(xfs_off_t, xfs_inode_alloc_unitsize(ip), PAGE_SIZE);
+	start = rounddown_64(offset, rounding);
+	end = roundup_64(offset + len, rounding) - 1;
 
 	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (error)
 		return error;
 	truncate_pagecache_range(inode, start, end);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


