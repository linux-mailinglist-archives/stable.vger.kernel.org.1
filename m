Return-Path: <stable+bounces-61784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3FD93C827
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74151F2190E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E219DF72;
	Thu, 25 Jul 2024 18:10:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3C339A0;
	Thu, 25 Jul 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931007; cv=none; b=SJSICll4BDphhUpilL6LTsMfryFRe4tO0q1wtI98rIIgSoGSjT2n+TaV9GVmOpcQoZm3Fwr8BeWL2k0KhvkQfkS/n/VQzxjHpzb26pq1SxXB3Y/9dDbNIT0+9cMciPWydvqKPfBtgxORtfQJ7SbiTiefhQtJD1FfRgi8QCVbWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931007; c=relaxed/simple;
	bh=3d1lkerYjEzQAmgzNkELGoKubu7y/tjQ0HLQAN0wUas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EyFX9cFRqj8jr5PXHHXB2Clrp1lFD7D2wIEes8D1Q1yDvCPyVTBce4sjxx6mUkvLdrCM1z3C5N/uUeii0yo2dzUEV5ZMjNB7JfAcjwv9oyJvT415ZKBDkAVhfHllTmyqLN7iV6bmFjGJbGiYO7Wt7ofbrT3cuvzXnMlq2s4TKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 25 Jul
 2024 21:09:54 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 25 Jul
 2024 21:09:54 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jerome Glisse
	<jglisse@redhat.com>, Dave Airlie <airlied@redhat.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
Date: Thu, 25 Jul 2024 11:09:50 -0700
Message-ID: <20240725180950.15820-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Several cs track offsets (such as 'track->db_s_read_offset')
either are initialized with or plainly take big enough values that,
once shifted 8 bits left, may be hit with integer overflow if the
resulting values end up going over u32 limit.

Some debug prints take this into account (see according dev_warn() in
evergreen_cs_track_validate_stencil()), even if the actual
calculated value assigned to local 'offset' variable is missing
similar proper expansion.

Mitigate the problem by casting the type of right operands to the
wider type of corresponding left ones in all such cases.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling informations v11")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. While I am not certain that track->cb_color_bo_offset[id]
actually ends up taking values high enough to cause an overflow,
nonetheless I thought it prudent to cast it to ulong as well.

 drivers/gpu/drm/radeon/evergreen_cs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 1fe6e0d883c7..d734d221e2da 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -433,7 +433,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		return r;
 	}
 
-	offset = track->cb_color_bo_offset[id] << 8;
+	offset = (unsigned long)track->cb_color_bo_offset[id] << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, id, offset, surf.base_align);
@@ -455,7 +455,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 				min = surf.nby - 8;
 			}
 			bsize = radeon_bo_size(track->cb_color_bo[id]);
-			tmp = track->cb_color_bo_offset[id] << 8;
+			tmp = (unsigned long)track->cb_color_bo_offset[id] << 8;
 			for (nby = surf.nby; nby > min; nby--) {
 				size = nby * surf.nbx * surf.bpe * surf.nsamples;
 				if ((tmp + size * mslice) <= bsize) {
@@ -476,10 +476,10 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 			}
 		}
 		dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %d, "
-			 "offset %d, max layer %d, bo size %ld, slice %d)\n",
+			 "offset %ld, max layer %d, bo size %ld, slice %d)\n",
 			 __func__, __LINE__, id, surf.layer_size,
-			track->cb_color_bo_offset[id] << 8, mslice,
-			radeon_bo_size(track->cb_color_bo[id]), slice);
+			(unsigned long)track->cb_color_bo_offset[id] << 8,
+			mslice,	radeon_bo_size(track->cb_color_bo[id]), slice);
 		dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d %d %d %d %d %d)\n",
 			 __func__, __LINE__, surf.nbx, surf.nby,
 			surf.mode, surf.bpe, surf.nsamples,
@@ -608,7 +608,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_s_read_offset << 8;
+	offset = (unsigned long)track->db_s_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -627,7 +627,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_s_write_offset << 8;
+	offset = (unsigned long)track->db_s_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -706,7 +706,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_z_read_offset << 8;
+	offset = (unsigned long)track->db_z_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
@@ -722,7 +722,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_z_write_offset << 8;
+	offset = (unsigned long)track->db_z_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
 		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);

