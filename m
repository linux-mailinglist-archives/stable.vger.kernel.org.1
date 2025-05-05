Return-Path: <stable+bounces-140976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABAAAAD4B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A753A7FBB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC233D34E4;
	Mon,  5 May 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHi01gUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB7284B5A;
	Mon,  5 May 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487096; cv=none; b=gUpwpExttG8pVEYZAQ1xuzOW4WHQ7Bvg44geKEjt+h3mCTagWKq+Hy3IAj/AzexrJuII89kO6/bIgwaUaGh5EAoBUdIoXDhzxhBQEyjAoxCDozn1MsAM8CbDALlDzTvQf+EuSI6yU/LlYQiVY2cLQ40NlQs4R8Oq0koYnccWyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487096; c=relaxed/simple;
	bh=1oiwZ7k+nRilmKzcV9sWrVdAFE7uspjwuesfxdz7kJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRajNFXw7GoPExckzkoCo4fwXfcCOczOQhbItY/PLB3QJQmyK+4qVllOLbGPgO6B66Nu0WOgzT/CmCc6kP7+9iSMUa/SUcoPCzdDhP9T4sKubkaitmhLJm6en0k04QRs5InSa5JzJxLb8PM7M0mNUnVI7tkayjx82RWnFhM4c9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHi01gUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39888C4CEED;
	Mon,  5 May 2025 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487094;
	bh=1oiwZ7k+nRilmKzcV9sWrVdAFE7uspjwuesfxdz7kJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHi01gUdJLORnYZTjOeW5Kl9b8FjW8p40CB+1i2pazJAUkcuUVArEqKqu9pPoKwbs
	 TUVZpp12Zo8h6AFMv9t9FpBU1t+P5i3ZWhrJ1p6RfJIvq+/J9PaWXTT8QbLfnh+9E2
	 6lXYbMHzvxsDjzHR12R6ndA/aRlZvy44f6MzJnflFr7ERsWjKkqn6WkeyRLLQhQ+LY
	 +Sn8TdRxL9UrQySw1v0y5pVg97AHnaG9xrg9iU8LNMNrm9HqwXXbzlXwxFrowMzK5P
	 VHyw8TBJViUaGPr/+wQhFOLgpjXBTJ0Kwblx8V941Kn6GEFAF0dAzRbGnkZKf9CQ/V
	 KZju0/Q0+WHgQ==
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
Subject: [PATCH AUTOSEL 5.15 152/153] drm/atomic: clarify the rules around drm_atomic_state->allow_modeset
Date: Mon,  5 May 2025 19:13:19 -0400
Message-Id: <20250505231320.2695319-152-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 1701c2128a5cb..1b8dd160c51f9 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -353,8 +353,27 @@ struct drm_atomic_state {
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


