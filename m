Return-Path: <stable+bounces-75714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46857974002
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F3E1C258BA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81F1C1720;
	Tue, 10 Sep 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI1rX76a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A21C0DF4;
	Tue, 10 Sep 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989041; cv=none; b=T4T70YePvF/sF+knHpuu/TmK0+x8MATp8qrKL7N7Bml3MxgVFd715Iv43kipXOEFF94kMNCdFIgSLUlcA+pOV5OAUqdrJb8tp8uaYGnlI7B7KbOgZfbxfN+eU6Ek14sHNpCWJpCh6408GnEj2+/PhYMWM/OIlpt/BNNj4DzmjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989041; c=relaxed/simple;
	bh=lCF0R7gkYu9gR9wi3pViJNLBYIi/XgL9HE0iP/L0WsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1PIl3GjSriIA5B05fi4LbU7dXR7XU++QJKNEjAr8bcURNUmyQZ32vwlFsB4sCnGLph0fZg2cZnwHaWsGOfWcF3XJuTkhIN7i8VWAt//wLTS5xoSnhxEClc/mooxgjdOrO8ZQ8Ba/DLto+FIGUVc9JTc9esvAXMoOyIzc2KwIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI1rX76a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF111C4CECD;
	Tue, 10 Sep 2024 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989041;
	bh=lCF0R7gkYu9gR9wi3pViJNLBYIi/XgL9HE0iP/L0WsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CI1rX76aWv2hTxmsRQyuoNAR/plHm9gx0TDnwHKCezikVbfWgL2xbs/M3ARGSh2z5
	 DA5Lw3WhU1V6B4AzP1OrJEXS16BCTBhVxr+8G8ksF8tWiHsfcUf/8JE2VxLwGnMyIb
	 ld//ccOyjqe4bXvMov9Fr2/VHy6YRqQNFAstv/Y+CeSQ7qvkN0AUKTcahDRZEOapkZ
	 3GStvLCBEiwPCLUeD+UD6x1U1twDqcal1/09LBEa//NTkOVpVkhG7R4GChSaP6KSXH
	 a3geGDx6XbpjCHBpQG9oG6cZGL/mowgMIKSbx7qv1wJwmrlC4CR4/UEnGTTZ+slMwl
	 RM7IXSU5sP8/Q==
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
Subject: [PATCH AUTOSEL 5.15 4/5] drm: komeda: Fix an issue related to normalized zpos
Date: Tue, 10 Sep 2024 13:23:48 -0400
Message-ID: <20240910172352.2416462-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172352.2416462-1-sashal@kernel.org>
References: <20240910172352.2416462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.166
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
index 327051bba5b6..cee7b8d58830 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -163,6 +163,7 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct list_head zorder_list;
 	int order = 0, err;
+	u32 slave_zpos = 0;
 
 	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
 			 crtc->base.id, crtc->name);
@@ -202,10 +203,13 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
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


