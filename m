Return-Path: <stable+bounces-152475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E31AD609D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D687ACF4E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C72BDC3D;
	Wed, 11 Jun 2025 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N48/XOTC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228C19A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675717; cv=none; b=LViFJn8bZtGqBAnZGkLlWZfe3lMgjUHAlHCPToRIUziHkHOzsQB7gCGXwuRU6UE+qxgvB46GcUuoquGL1PYg8zKTF8bEWVZwmlMCMlo+Q38m3MIfy0J6bXqITH1sBk7WksfYn5rDCAeadyEif8WbXGPS4E/HbFSnPs5aNhetpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675717; c=relaxed/simple;
	bh=jF8/nbaBukuSqV3qFWzYWi2HW+Sgexx1ocTL80oJ4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5/9G0rpbPuLo2mVbG/5sZmfvXujZ7H+SUjC+xmU8NbdtCtxtz0+p/MfYUwk8oBIuWqHxxBrvmedMBh6wzFfjOKe98exQ2woeE/YFhFthORHDcYPSJMkiU1TN+s1yzMGiMPRJusbLgAdlohi2xxrkv6oFakLTJRRZkoMRvdD7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N48/XOTC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23508d30142so3636565ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675715; x=1750280515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyiPgYpfMdYTiQJncbeGQMgW3gD+GZdeWjhTxrhpxds=;
        b=N48/XOTCYmGpzBZtP4vbu/b2L3J1PaqBGr287MUZ0tNvfr1/xEPOtJz0F6VqwEG4m+
         cy2X4/TQFdXr6L2Bk42rm1WDeZTPZBMX70kk9qeFzKunmns9gmmy48QecLuZHVaYU/bj
         6c8ou6Zu9i2tUJHpZnMMATrzEVwv+Ak9HJ1nB72wo/wKgcKF/kDfaI5+hRKzm0PbsQRs
         YywLX45CWMyQeln1cpX7oZDvgWMYHvcqHJMbpAn6Y2FZrkLVH1rGgqtpq4CL/bU2Rh9h
         kjc1ZYdj6Bb6dtLNtT9XJM5F0Sa0MBxUqWCYci0t6njq6pnAeA+/j44IatraW7yY4TUM
         HbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675715; x=1750280515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyiPgYpfMdYTiQJncbeGQMgW3gD+GZdeWjhTxrhpxds=;
        b=hM2mNBerUOozUmA/K4Cg+IHONDz5XjjoKRxg+V0Xb0c716tkeCbLnlAgD+9SC4pq+g
         DBCzg5o/gq8gYAl/PPs2UtB1P1X+/t23/pncbWQ9DnR6xsiWbYUGKLgqOOnqYaw7N9P+
         hAl8Wf9GKYZ30Ny8rVL7EmARygazdm9nnwWtX+1UdEAnhZn167FRKV1OpimxL8MT6M8F
         EVwpeMGMSeVKqUvEGu2mhoPhlr6SsVS4gT/Y+ubJjJV77NUqVFHbXeeSHdI8ZTMJLIiP
         VV4YnJEaiv1VI/komgQw7frMc262u0roEf1QV8Z3lZhSLnNf09KBVB8wHtocyBDiOHAj
         wUpw==
X-Gm-Message-State: AOJu0Yxq9LNAlzodJx+YdX93j4KFXxnJQH7gMkh819eJe6vYm5ie7EUo
	UF19jJ8AZ5Ad2Fot+9MvtOZCqg0s/UvjTts5ExQh925hoISbBw2fHZE263TS4ngd
X-Gm-Gg: ASbGncs3UuVqXvnSODPhr2G3ghrJgJ/xXVZuN7VyDxGppwg1VNHpF+BRtX3AT0ctCvK
	+oNhl8ipWN/YSJXGjc3AEgIYwQtuV55/WiFpYGtRr82CgbXoLcZ8aScNdLi3BX0lCcPXLSJ132D
	p1o7LUOBwoQDElwLJFH1DX3VxBS50u0TLpIPsq7SnlIijbllhkJVXAoB6n7vRhCuNuBHaKIYytZ
	yV0S1QOS2HkKS4NYcjpthhivVHPMfzif/2WNemhzd6pbR/LLxzqL73nvOPU3TDJc6sIXeAghIJa
	rgEfqJqczwi7boqp4ZRq++xes/nyy2CA3tPrHc/cn6tAWIOi5XXi5zx9X2qnHkUt6fMNSymi68p
	netRjcbrndfY=
X-Google-Smtp-Source: AGHT+IG2Nmt7Sipj28sCYMKKsLY9fqsD2ut63Vdxt4MHxF6gYXUjRqmwg7hcLlsbpUGotMtbEYur1A==
X-Received: by 2002:a17:902:ce81:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-2364ca62744mr15053645ad.40.1749675715199;
        Wed, 11 Jun 2025 14:01:55 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:54 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	wozizhi@huawei.com,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 21/23] xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
Date: Wed, 11 Jun 2025 14:01:25 -0700
Message-ID: <20250611210128.67687-22-leah.rumancik@gmail.com>
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

[ Upstream commit 6b35cc8d9239569700cc7cc737c8ed40b8b9cfdb ]

Use XFS_BUF_DADDR_NULL (instead of a magic sentinel value) to mean "this
field is null" like the rest of xfs.

Cc: wozizhi@huawei.com
Fixes: e89c041338ed6 ("xfs: implement the GETFSMAP ioctl")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 1efd18437ca4..a0668a1ef100 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -250,11 +250,11 @@ static inline bool
 xfs_getfsmap_rec_before_start(
 	struct xfs_getfsmap_info	*info,
 	const struct xfs_rmap_irec	*rec,
 	xfs_daddr_t			rec_daddr)
 {
-	if (info->low_daddr != -1ULL)
+	if (info->low_daddr != XFS_BUF_DADDR_NULL)
 		return rec_daddr < info->low_daddr;
 	if (info->low.rm_blockcount)
 		return xfs_rmap_compare(rec, &info->low) < 0;
 	return false;
 }
@@ -984,11 +984,11 @@ xfs_getfsmap(
 			break;
 
 		info.dev = handlers[i].dev;
 		info.last = false;
 		info.pag = NULL;
-		info.low_daddr = -1ULL;
+		info.low_daddr = XFS_BUF_DADDR_NULL;
 		info.low.rm_blockcount = 0;
 		error = handlers[i].fn(tp, dkeys, &info);
 		if (error)
 			break;
 		xfs_trans_cancel(tp);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


