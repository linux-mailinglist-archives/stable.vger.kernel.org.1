Return-Path: <stable+bounces-75721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF81974012
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28C3B23FE4
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FBD1C2335;
	Tue, 10 Sep 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/SFggGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6431C2332;
	Tue, 10 Sep 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989062; cv=none; b=tjDqDpGN2Wy+xAXvFcwu0ziRSkR3cBHlJz7vX8bkF/+EkSCqAtjTQ+D8lV92IvU7pC9Hlco4JXqZS3URDmGSySvcq+IwqL1Nff8h2jhMg24DqQb7hlZu7svFgp6RS7cT/veE9PgHL43C0EVslv/tucuzeKGdUyiL6eSvghGvb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989062; c=relaxed/simple;
	bh=Y1oiPIpBgTdpuKr0fyT3Wi7Zryu3iuPTCUZiEhfA+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZKAQDmsD92vNyMi094Fa672kkbyuYzp865jw17q7u9a1WAAkaz1q+enVrgpN/jdvunAAORHzRE07NJVbZUsGsG/L7cqPdpSyWpynDrBRbUKpw6tHjiEFErJBDT9s2a6TwT98wYXzVoKArZShSOmQrwl9ZSPylazwciKFB3quws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/SFggGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492B1C4CEC3;
	Tue, 10 Sep 2024 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989062;
	bh=Y1oiPIpBgTdpuKr0fyT3Wi7Zryu3iuPTCUZiEhfA+U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/SFggGW7+ipU8+YEiCeCm6Hq6fO4pZwqTyURJZX/rjjjXaxtTpegu46Ys1m8nCmM
	 PLAMda+Sj9SdGYJQu3GmLpGnZvt9omKPMsaAc5I/PaTrNqeqpQq4cmaiBC3L9VFqXm
	 OahnacRQy6SEuLEoKbCN5mgjsB2QJ/QipMKBYA4Pp71fndZ9uPBHS6i2+hp+Y0yD6W
	 +1lgEOZfIhqo831Atoy7ljDZTH0q950T64lbx49r8bXx6j2q9Snz4HN31Pyq68ve6e
	 DFH2mMzgaYvmdpDty2TFDpHwHfpjiVWtRCCvdxJvhPDpB3WQ+/iuk01H3HoxFQEeti
	 cpmi3rLF/hbNw==
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
Subject: [PATCH AUTOSEL 5.4 2/3] drm: komeda: Fix an issue related to normalized zpos
Date: Tue, 10 Sep 2024 13:24:14 -0400
Message-ID: <20240910172418.2416688-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172418.2416688-1-sashal@kernel.org>
References: <20240910172418.2416688-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.283
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
index ae274902ff92..4e9c3184a906 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -148,6 +148,7 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct list_head zorder_list;
 	int order = 0, err;
+	u32 slave_zpos = 0;
 
 	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
 			 crtc->base.id, crtc->name);
@@ -187,10 +188,13 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
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


