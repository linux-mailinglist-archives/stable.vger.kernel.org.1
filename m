Return-Path: <stable+bounces-141583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C361AAAB4D1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFA3A6694
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89F480B6D;
	Tue,  6 May 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYCom5IF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0402F2756;
	Mon,  5 May 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486796; cv=none; b=YmUDh6OCjVj29AD8XGW2agdRMx1/erXpscWmeRZAcdPCTi6+x4J0HBm89uV2jSfk8pBPcFrzv5vXhkl4ggjHCKU2qm+zh2ja9KgQrDqZOpB4WHZU1D77ECXU6lp6AF2yisIAIva/utYouUUvzgTej1mDIBit2uhK8o7VVPevEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486796; c=relaxed/simple;
	bh=QIWVtHA6zF1jcZ5HRpCj+W08TDWiNibpqUUg1w7q4qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmUmIjcXetKskI/z2y67O91IAqH34b52Vq6h2FFLzadOf7FXnINC9MUvUN6r0Mw3tRDJpFxMVLb4CzrIIvEMhDf39mQrNU5ESp/hfkc3pr+HfYae9Y1U6+qEJJEg+XtO1T29jv9b6r3O8//ipzzt8hhQ6Kek6O6meTiu9Vul/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYCom5IF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C7C4CEEE;
	Mon,  5 May 2025 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486796;
	bh=QIWVtHA6zF1jcZ5HRpCj+W08TDWiNibpqUUg1w7q4qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYCom5IFora5qhRyteIYI30mFUW80SAfF78fZ9zX6WZXYfoXrrgGxG/W/HQZ2GSjv
	 SfOU76g3RPqvfgVCvHOeinIbEbqWEQs7/v9+hh+2BRx85uQWU07eamvXEPSVRtF6vZ
	 DZqYNWQShbFwg5znvPLabvnSyL30B0VasKbmto1k6wPwa9FjggMvX+6Qx0D1sL1Nv+
	 se19O1WjGSs6sXP5NKnKDcT708AUQYJpnGSBPxqh5Gy8e/1z1n+St+zX2H+5oqSKQU
	 mZSUcvOQa3aUlw6Xkk020UrUQUlX2cGSiWBjkfus6RSiceDUHmlbeZ344rMYM7c/bl
	 OqVUhze+H4seA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Simon Ser <contact@emersion.fr>,
	Manasi Navare <navaremanasi@google.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Simona Vetter <simona.vetter@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 210/212] drm/atomic: clarify the rules around drm_atomic_state->allow_modeset
Date: Mon,  5 May 2025 19:06:22 -0400
Message-Id: <20250505230624.2692522-210-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Simona Vetter <simona.vetter@ffwll.ch>

[ Upstream commit c5e3306a424b52e38ad2c28c7f3399fcd03e383d ]

msm is automagically upgrading normal commits to full modesets, and
that's a big no-no:

- for one this results in full on->off->on transitions on all these
  crtc, at least if you're using the usual helpers. Which seems to be
  the case, and is breaking uapi

- further even if the ctm change itself would not result in flicker,
  this can hide modesets for other reasons. Which again breaks the
  uapi

v2: I forgot the case of adding unrelated crtc state. Add that case
and link to the existing kerneldoc explainers. This has come up in an
irc discussion with Manasi and Ville about intel's bigjoiner mode.
Also cc everyone involved in the msm irc discussion, more people
joined after I sent out v1.

v3: Wording polish from Pekka and Thomas

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Manasi Navare <navaremanasi@google.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108172417.160831-1-simona.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_atomic.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 10b1990bc1f68..36225aedf6138 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -372,8 +372,27 @@ struct drm_atomic_state {
 	 *
 	 * Allow full modeset. This is used by the ATOMIC IOCTL handler to
 	 * implement the DRM_MODE_ATOMIC_ALLOW_MODESET flag. Drivers should
-	 * never consult this flag, instead looking at the output of
-	 * drm_atomic_crtc_needs_modeset().
+	 * generally not consult this flag, but instead look at the output of
+	 * drm_atomic_crtc_needs_modeset(). The detailed rules are:
+	 *
+	 * - Drivers must not consult @allow_modeset in the atomic commit path.
+	 *   Use drm_atomic_crtc_needs_modeset() instead.
+	 *
+	 * - Drivers must consult @allow_modeset before adding unrelated struct
+	 *   drm_crtc_state to this commit by calling
+	 *   drm_atomic_get_crtc_state(). See also the warning in the
+	 *   documentation for that function.
+	 *
+	 * - Drivers must never change this flag, it is under the exclusive
+	 *   control of userspace.
+	 *
+	 * - Drivers may consult @allow_modeset in the atomic check path, if
+	 *   they have the choice between an optimal hardware configuration
+	 *   which requires a modeset, and a less optimal configuration which
+	 *   can be committed without a modeset. An example would be suboptimal
+	 *   scanout FIFO allocation resulting in increased idle power
+	 *   consumption. This allows userspace to avoid flickering and delays
+	 *   for the normal composition loop at reasonable cost.
 	 */
 	bool allow_modeset : 1;
 	/**
-- 
2.39.5


