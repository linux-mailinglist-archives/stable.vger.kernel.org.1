Return-Path: <stable+bounces-3311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF17FF502
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766F41C20CAA
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07754F96;
	Thu, 30 Nov 2023 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIWdfwNj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB4482CB;
	Thu, 30 Nov 2023 16:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC36C433C7;
	Thu, 30 Nov 2023 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361508;
	bh=Ftqq3xfrtkvh+Np2U7j6uckka0ex5meDiOcjP/mFZmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zIWdfwNjFHiuXf8nxEfkBoumXTDlf8/c0nITRhYH+zqwQKXyEhQUZS/o7GNyrsXlE
	 3LvoTY3oenWh0Dz29vcHVr5pQGmgNXEqIgjyaItWW/a2hRaW8MsdFY728Rb9aIvob+
	 /9WDiI2Jwht70O+dE+kCh1Qz0pbMEkVFc4OxaDVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Karlman <jonas@kwiboo.se>,
	Diederik de Haas <didi.debian@cknow.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/112] drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full
Date: Thu, 30 Nov 2023 16:21:13 +0000
Message-ID: <20231130162141.146196913@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit bb0a05acd6121ff0e810b44fdc24dbdfaa46b642 ]

Use of DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888 on e.g. RK3288, RK3328
and RK3399 result in wrong colors being displayed.

The issue can be observed using modetest:

  modetest -s <connector_id>@<crtc_id>:1920x1080-60@RG24
  modetest -s <connector_id>@<crtc_id>:1920x1080-60@BG24

Vendor 4.4 kernel apply an inverted rb swap for these formats on VOP
full framework (IP version 3.x) compared to VOP little framework (2.x).

Fix colors by applying different rb swap for VOP full framework (3.x)
and VOP little framework (2.x) similar to vendor 4.4 kernel.

Fixes: 85a359f25388 ("drm/rockchip: Add BGR formats to VOP")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Diederik de Haas <didi.debian@cknow.org>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231026191500.2994225-1-jonas@kwiboo.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 41cd12d5f2fa2..4b338cb89d32d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -247,14 +247,22 @@ static inline void vop_cfg_done(struct vop *vop)
 	VOP_REG_SET(vop, common, cfg_done, 1);
 }
 
-static bool has_rb_swapped(uint32_t format)
+static bool has_rb_swapped(uint32_t version, uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-	case DRM_FORMAT_BGR888:
 	case DRM_FORMAT_BGR565:
 		return true;
+	/*
+	 * full framework (IP version 3.x) only need rb swapped for RGB888 and
+	 * little framework (IP version 2.x) only need rb swapped for BGR888,
+	 * check for 3.x to also only rb swap BGR888 for unknown vop version
+	 */
+	case DRM_FORMAT_RGB888:
+		return VOP_MAJOR(version) == 3;
+	case DRM_FORMAT_BGR888:
+		return VOP_MAJOR(version) != 3;
 	default:
 		return false;
 	}
@@ -1013,7 +1021,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	/*
-- 
2.42.0




