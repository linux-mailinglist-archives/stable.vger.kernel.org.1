Return-Path: <stable+bounces-75700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51A973FAA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F93282DE5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959711BD4E7;
	Tue, 10 Sep 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8xtvFrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C91BD03F;
	Tue, 10 Sep 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989005; cv=none; b=qFys2/xh9GvXG5G1a5m+QNObRUl4Pm47n277I8NaKydf4z7c/eqOvEZTjXXDiouev8RRymOw8+g0bV4LubU2FQYE3dO239MKZfmTyrPhlincltZnmsxaSXPHnzYCN2oEz5soQgGcB71O5B0DIs1idSzyn6//VMnAUJ9gdKNImCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989005; c=relaxed/simple;
	bh=bWqtFkgZzaf6QkutbrreOLtFh34Q3IAmHaIsUB0mX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWkDzduvOwGiHu7czShJmT17+tqQ7gFemliPE0U3+HsF20q75wIjF3veWmLismSvr4vQ3zxL5FKYsGHsD/pWfUlx8ldeF1qOv/LDZyHbhJEp4FrVWVCqxelQBDxcPDxp7Cfa3h9h68tEU2bNLwVBvEKYzL+DNhDQX3c4UpHOrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8xtvFrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00703C4CECC;
	Tue, 10 Sep 2024 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989005;
	bh=bWqtFkgZzaf6QkutbrreOLtFh34Q3IAmHaIsUB0mX2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8xtvFrAvnn+oimp2zlA4SYRA2oGCEIUYkAbTcamzcoM2ztNs8qNRprlgVwHH2H06
	 Q57Lw6agoSWEXNNhsRptfBELpG+1RE5M4y3x7CU0ja72t3Qv714/jXXGY3YJEJ2FxE
	 n6nZA8YIg0iX2L6xxRUkCoAFkpnHPhY/wT79AcEsOjF+mRUkBMZW1FKVKx00PZKD5d
	 Xfuah2an0sh7iEpgfPhuAAxrdvWNTVVthCUnHqBKFqVGZqmzKs9ExXp1oIZvOY5VJC
	 vBfIbL5DHKw4qNJjBjtR1aavhneI4ejS+mUIFdFyLkE7lZpoiV3d+GJTHy1f7/VeF2
	 q1hH/Uq88qujA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "hongchi.peng" <hongchi.peng@siengine.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 10/12] drm: komeda: Fix an issue related to normalized zpos
Date: Tue, 10 Sep 2024 13:22:52 -0400
Message-ID: <20240910172301.2415973-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: "hongchi.peng" <hongchi.peng@siengine.com>

[ Upstream commit 258905cb9a6414be5c9ca4aa20ef855f8dc894d4 ]

We use komeda_crtc_normalize_zpos to normalize zpos of affected planes
to their blending zorder in CU. If there's only one slave plane in
affected planes and its layer_split property is enabled, order++ for
its split layer, so that when calculating the normalized_zpos
of master planes, the split layer of the slave plane is included, but
the max_slave_zorder does not include the split layer and keep zero
because there's only one slave plane in affacted planes, although we
actually use two slave layers in this commit.

In most cases, this bug does not result in a commit failure, but assume
the following situation:
    slave_layer 0: zpos = 0, layer split enabled, normalized_zpos =
    0;(use slave_layer 2 as its split layer)
    master_layer 0: zpos = 2, layer_split enabled, normalized_zpos =
    2;(use master_layer 2 as its split layer)
    master_layer 1: zpos = 4, normalized_zpos = 4;
    master_layer 3: zpos = 5, normalized_zpos = 5;
    kcrtc_st->max_slave_zorder = 0;
When we use master_layer 3 as a input of CU in function
komeda_compiz_set_input and check it with function
komeda_component_check_input, the parameter idx is equal to
normailzed_zpos minus max_slave_zorder, the value of idx is 5
and is euqal to CU's max_active_inputs, so that
komeda_component_check_input returns a -EINVAL value.

To fix the bug described above, when calculating the max_slave_zorder
with the layer_split enabled, count the split layer in this calculation
directly.

Signed-off-by: hongchi.peng <hongchi.peng@siengine.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240826024517.3739-1-hongchi.peng@siengine.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 9299026701f3..1a5fa7df284d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -160,6 +160,7 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct list_head zorder_list;
 	int order = 0, err;
+	u32 slave_zpos = 0;
 
 	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
 			 crtc->base.id, crtc->name);
@@ -199,10 +200,13 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 				 plane_st->zpos, plane_st->normalized_zpos);
 
 		/* calculate max slave zorder */
-		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes))
+		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes)) {
+			slave_zpos = plane_st->normalized_zpos;
+			if (to_kplane_st(plane_st)->layer_split)
+				slave_zpos++;
 			kcrtc_st->max_slave_zorder =
-				max(plane_st->normalized_zpos,
-				    kcrtc_st->max_slave_zorder);
+				max(slave_zpos, kcrtc_st->max_slave_zorder);
+		}
 	}
 
 	crtc_st->zpos_changed = true;
-- 
2.43.0


