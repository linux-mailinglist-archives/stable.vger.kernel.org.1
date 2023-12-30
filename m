Return-Path: <stable+bounces-8966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632728205A4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F441C20ECC
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7479EF;
	Sat, 30 Dec 2023 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgNVEm6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F488483;
	Sat, 30 Dec 2023 12:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13899C433C9;
	Sat, 30 Dec 2023 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938225;
	bh=x7bneNO96w4mP8mNvakxBLUz2nzxrkzhO+vB5653KOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgNVEm6jdkx78moWxIeiBzfZOOytmkA7HogGfhwpwz4zj1OFC7PnUzvGZxvaCzvmm
	 1JM3f8+lq07GFGz4uDwL/yfMifl8Ilb3FHYHL0ZdKIgzHoZEnac1VE5VedeXBncgvE
	 0LWioQ07M32kfAwyaDusmi+dnTtAYRbBbs+VWX6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 051/112] drm/i915/dpt: Only do the POT stride remap when using DPT
Date: Sat, 30 Dec 2023 11:59:24 +0000
Message-ID: <20231230115808.350404014@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit ef5cb493a9acd7d97870d6e542020980ae3f3483 ]

If we want to test with DPT disabled on ADL the POT stride remap
stuff needs to be disabled. Make it depend on actual DPT usage
instead of just assuming it based on the modifier.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230320090522.9909-3-ville.syrjala@linux.intel.com
Reviewed-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Stable-dep-of: 324b70e997aa ("drm/i915: Fix ADL+ tiled plane stride when the POT stride is smaller than the original")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 23d854bd73b77..c22ca36a38a9d 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -1176,7 +1176,7 @@ bool intel_fb_needs_pot_stride_remap(const struct intel_framebuffer *fb)
 {
 	struct drm_i915_private *i915 = to_i915(fb->base.dev);
 
-	return IS_ALDERLAKE_P(i915) && fb->base.modifier != DRM_FORMAT_MOD_LINEAR;
+	return IS_ALDERLAKE_P(i915) && intel_fb_uses_dpt(&fb->base);
 }
 
 static int intel_fb_pitch(const struct intel_framebuffer *fb, int color_plane, unsigned int rotation)
-- 
2.43.0




