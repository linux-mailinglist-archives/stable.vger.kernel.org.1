Return-Path: <stable+bounces-78870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABA98D55D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AE1F21D78
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584531D0434;
	Wed,  2 Oct 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugzA5ChE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA921CFECF;
	Wed,  2 Oct 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875769; cv=none; b=W1XRmwDFnrIgQjS28mN1gmDH3wUx6EF8xaAbzr7k+0hPdms8e8nuuNtb529622jcnMCu5cAXxFmnv9lTuoV97drJAsZP2OKJigj2oK0Qx4sgSzuc8nF1Qg/j+pm1qorZXnG/SgPNond5A6f5NDxVL+Wg/MEr6SsxXosyrcas4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875769; c=relaxed/simple;
	bh=yNs49o6hbi7HYL7HzfCm7Llhf2PBsq/3Y987jEQtI2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrczYe4BblwAL6sJW2sGVbPaYAOG3ZXpyZvYLuUyGYeDXdzIaqR4SnVfpjbVApoYsrj+N7QbVsYsgQdNAxfWt6noyYQYtfw/IFT3ibgIh/u6bo3Sa79gcJV0cme3OOLdsuGnLl/nBYwDAZWVd3HQg4f3SGlicq7KMO9ie6kDhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugzA5ChE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C492C4CEC5;
	Wed,  2 Oct 2024 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875768;
	bh=yNs49o6hbi7HYL7HzfCm7Llhf2PBsq/3Y987jEQtI2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugzA5ChEGAtUoOxp45XZmHX+PGiouMFZa0F67fXUZfKByngmlD12D/oiih+flEbDG
	 qrvUBW/6z1BXBxn3oE3NT6mLbPKHDjcvuz6Utc+shK4nNFjZ+rV1vcRMUwOoLcwgOy
	 2UJVBaByVMqOe+sc7YVgBWGJueylvts8hVNowEf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 214/695] drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
Date: Wed,  2 Oct 2024 14:53:32 +0200
Message-ID: <20241002125831.004937399@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 3fbaf475a5b8361ebee7da18964db809e37518b7 ]

Several cs track offsets (such as 'track->db_s_read_offset')
either are initialized with or plainly take big enough values that,
once shifted 8 bits left, may be hit with integer overflow if the
resulting values end up going over u32 limit.

Same goes for a few instances of 'surf.layer_size * mslice'
multiplications that are added to 'offset' variable - they may
potentially overflow as well and need to be validated properly.

While some debug prints in this code section take possible overflow
issues into account, simply casting to (unsigned long) may be
erroneous in its own way, as depending on CPU architecture one is
liable to get different results.

Fix said problems by:
 - casting 'offset' to fixed u64 data type instead of
 ambiguous unsigned long.
 - casting one of the operands in vulnerable to integer
 overflow cases to u64.
 - adjust format specifiers in debug prints to properly
 represent 'offset' values.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling informations v11")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 62 +++++++++++++--------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index e5577d2a19ef4..a466132833936 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -397,7 +397,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028C6C_SLICE_MAX(track->cb_color_view[id]) + 1;
@@ -435,14 +435,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		return r;
 	}
 
-	offset = track->cb_color_bo_offset[id] << 8;
+	offset = (u64)track->cb_color_bo_offset[id] << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d cb[%d] bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, id, offset, surf.base_align);
 		return -EINVAL;
 	}
 
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->cb_color_bo[id])) {
 		/* old ddx are broken they allocate bo with w*h*bpp but
 		 * program slice with ALIGN(h, 8), catch this and patch
@@ -450,14 +450,14 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 		 */
 		if (!surf.mode) {
 			uint32_t *ib = p->ib.ptr;
-			unsigned long tmp, nby, bsize, size, min = 0;
+			u64 tmp, nby, bsize, size, min = 0;
 
 			/* find the height the ddx wants */
 			if (surf.nby > 8) {
 				min = surf.nby - 8;
 			}
 			bsize = radeon_bo_size(track->cb_color_bo[id]);
-			tmp = track->cb_color_bo_offset[id] << 8;
+			tmp = (u64)track->cb_color_bo_offset[id] << 8;
 			for (nby = surf.nby; nby > min; nby--) {
 				size = nby * surf.nbx * surf.bpe * surf.nsamples;
 				if ((tmp + size * mslice) <= bsize) {
@@ -469,7 +469,7 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 				slice = ((nby * surf.nbx) / 64) - 1;
 				if (!evergreen_surface_check(p, &surf, "cb")) {
 					/* check if this one works */
-					tmp += surf.layer_size * mslice;
+					tmp += (u64)surf.layer_size * mslice;
 					if (tmp <= bsize) {
 						ib[track->cb_color_slice_idx[id]] = slice;
 						goto old_ddx_ok;
@@ -478,9 +478,9 @@ static int evergreen_cs_track_validate_cb(struct radeon_cs_parser *p, unsigned i
 			}
 		}
 		dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %d, "
-			 "offset %d, max layer %d, bo size %ld, slice %d)\n",
+			 "offset %llu, max layer %d, bo size %ld, slice %d)\n",
 			 __func__, __LINE__, id, surf.layer_size,
-			track->cb_color_bo_offset[id] << 8, mslice,
+			(u64)track->cb_color_bo_offset[id] << 8, mslice,
 			radeon_bo_size(track->cb_color_bo[id]), slice);
 		dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d %d %d %d %d %d)\n",
 			 __func__, __LINE__, surf.nbx, surf.nby,
@@ -564,7 +564,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -610,18 +610,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_s_read_offset << 8;
+	offset = (u64)track->db_s_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil read bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_s_read_bo)) {
 		dev_warn(p->dev, "%s:%d stencil read bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_s_read_offset << 8, mslice,
+			(u64)track->db_s_read_offset << 8, mslice,
 			radeon_bo_size(track->db_s_read_bo));
 		dev_warn(p->dev, "%s:%d stencil invalid (0x%08x 0x%08x 0x%08x 0x%08x)\n",
 			 __func__, __LINE__, track->db_depth_size,
@@ -629,18 +629,18 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return -EINVAL;
 	}
 
-	offset = track->db_s_write_offset << 8;
+	offset = (u64)track->db_s_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil write bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_s_write_bo)) {
 		dev_warn(p->dev, "%s:%d stencil write bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_s_write_offset << 8, mslice,
+			(u64)track->db_s_write_offset << 8, mslice,
 			radeon_bo_size(track->db_s_write_bo));
 		return -EINVAL;
 	}
@@ -661,7 +661,7 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 	struct evergreen_cs_track *track = p->track;
 	struct eg_surface surf;
 	unsigned pitch, slice, mslice;
-	unsigned long offset;
+	u64 offset;
 	int r;
 
 	mslice = G_028008_SLICE_MAX(track->db_depth_view) + 1;
@@ -708,34 +708,34 @@ static int evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	offset = track->db_z_read_offset << 8;
+	offset = (u64)track->db_z_read_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil read bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil read bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_z_read_bo)) {
 		dev_warn(p->dev, "%s:%d depth read bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_z_read_offset << 8, mslice,
+			(u64)track->db_z_read_offset << 8, mslice,
 			radeon_bo_size(track->db_z_read_bo));
 		return -EINVAL;
 	}
 
-	offset = track->db_z_write_offset << 8;
+	offset = (u64)track->db_z_write_offset << 8;
 	if (offset & (surf.base_align - 1)) {
-		dev_warn(p->dev, "%s:%d stencil write bo base %ld not aligned with %ld\n",
+		dev_warn(p->dev, "%s:%d stencil write bo base %llu not aligned with %ld\n",
 			 __func__, __LINE__, offset, surf.base_align);
 		return -EINVAL;
 	}
-	offset += surf.layer_size * mslice;
+	offset += (u64)surf.layer_size * mslice;
 	if (offset > radeon_bo_size(track->db_z_write_bo)) {
 		dev_warn(p->dev, "%s:%d depth write bo too small (layer size %d, "
-			 "offset %ld, max layer %d, bo size %ld)\n",
+			 "offset %llu, max layer %d, bo size %ld)\n",
 			 __func__, __LINE__, surf.layer_size,
-			(unsigned long)track->db_z_write_offset << 8, mslice,
+			(u64)track->db_z_write_offset << 8, mslice,
 			radeon_bo_size(track->db_z_write_bo));
 		return -EINVAL;
 	}
-- 
2.43.0




