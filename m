Return-Path: <stable+bounces-53700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AAC90E3E9
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF41F24F91
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86916F308;
	Wed, 19 Jun 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUkZgd2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB436F306
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780381; cv=none; b=aUeTrk72Q50zjo2XBjkWfx1Ie9dt0cOU2gNlO69q2zWEwgxLXtwuUwfTGkI9CBWB0ku0EZuhcG4GuGnaEiYMRxejr3Aj7yxq/pezGHBVEfj5M1rWiKFpuZSxzTc+wBKEObMctWVBEXopuPfUCx7BqJk3Er+JDmdCW/YsndsjZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780381; c=relaxed/simple;
	bh=L2whh6Rgj+0ZpQRKL/apOWOYfV77RDRjcY0LvP/Fl6Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oTn5pXq+TEeJILk796T1Mhko545aTtPdRIySqFz37ZDx/qgiyiXGdwD4wLivC5sseirL16SDiQJgp9IDqTHJDQf5V7NaiST2OsjgABsMIHnqvJVoUZmx1ujDc6DGtAk+hUBdKSOySNTL4Y2DIi1SVCKzbSnksow5e/m1rxP86f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUkZgd2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A2FC2BBFC;
	Wed, 19 Jun 2024 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780381;
	bh=L2whh6Rgj+0ZpQRKL/apOWOYfV77RDRjcY0LvP/Fl6Q=;
	h=Subject:To:Cc:From:Date:From;
	b=bUkZgd2f8Xjy79+Oefxhku3jkYhmgDbCfnCRG4OWZsHTrLg+xplGT2rnvHJEO9uDR
	 ZDUNwiann8dghn+MyZxXHRKLifbnVeHnI9YvCt//fUo8FgTS3x3e8LSTaZmOPdYkYR
	 kpTNocZ86K/pI6mVCqHIBQV9zt+cFOB4hSXuKsDg=
Subject: FAILED: patch "[PATCH] drm/i915: Fix audio component initialization" failed to apply to 5.15-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:59:27 +0200
Message-ID: <2024061926-chasing-national-1d51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 75800e2e4203ea83bbc9d4f63ad97ea582244a08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061926-chasing-national-1d51@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

75800e2e4203 ("drm/i915: Fix audio component initialization")
bd738d859e71 ("drm/i915: Prevent modesets during driver init/shutdown")
1ef28d86bea9 ("drm/i915: Suspend the framebuffer console earlier during system suspend")
24b412b1bfeb ("drm/i915: Disable intel HPD poll after DRM poll init/enable")
a1a0e8630711 ("drm/i915: Move audio deinit after disabling polling")
6a18ae51d265 ("drm/i915/display: Print display info inside driver display initialization")
40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
15e4f0b541d4 ("drm/i915/display: rename intel_modeset_probe_defer() -> intel_display_driver_probe_defer()")
ff2c80be1a00 ("drm/i915/display: move intel_modeset_probe_defer() to intel_display_driver.[ch]")
77316e755213 ("drm/i915/display: start high level display driver file")
d670c78ea756 ("drm/i915: rename intel_pm.[ch] to intel_clock_gating.[ch]")
673515ba0249 ("drm/i915/opregion: Register display debugfs later, after initialization steps")
893a6c224a24 ("drm/i915/pm: drop intel_suspend_hw()")
d3708182cbc3 ("drm/i915/pm: drop intel_pm_setup()")
3dadb4a17035 ("drm/i915/wm: move ILK watermark sanitization to i9xx_wm.[ch]")
94b49d53acec ("drm/i915/wm: move remaining watermark code out of intel_pm.c")
1b2146de7c5b ("drm/i915: move memory frequency detection to intel_dram.c")
2bf91341ee42 ("drm/i915: Move display power initialization during driver probing later")
e5e43d3363d7 ("drm/i915/display: Pass drm_i915_private as param to i915 funcs")
7ee6f99dbc45 ("drm/i915: Replace wm.max_levels with wm.num_levels and use it everywhere")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75800e2e4203ea83bbc9d4f63ad97ea582244a08 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Tue, 21 May 2024 17:30:22 +0300
Subject: [PATCH] drm/i915: Fix audio component initialization

After registering the audio component in i915_audio_component_init()
the audio driver may call i915_audio_component_get_power() via the
component ops. This could program AUD_FREQ_CNTRL with an uninitialized
value if the latter function is called before display.audio.freq_cntrl
gets initialized. The get_power() function also does a modeset which in
the above case happens too early before the initialization step and
triggers the

"Reject display access from task"

error message added by the Fixes: commit below.

Fix the above issue by registering the audio component only after the
initialization step.

Fixes: 87c1694533c9 ("drm/i915: save AUD_FREQ_CNTRL state at audio domain suspend")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10291
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240521143022.3784539-1-imre.deak@intel.com
(cherry picked from commit fdd0b80172758ce284f19fa8a26d90c61e4371d2)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index ed81e1466c4b..40e7d862675e 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -1252,17 +1252,6 @@ static const struct component_ops i915_audio_component_bind_ops = {
 static void i915_audio_component_init(struct drm_i915_private *i915)
 {
 	u32 aud_freq, aud_freq_init;
-	int ret;
-
-	ret = component_add_typed(i915->drm.dev,
-				  &i915_audio_component_bind_ops,
-				  I915_COMPONENT_AUDIO);
-	if (ret < 0) {
-		drm_err(&i915->drm,
-			"failed to add audio component (%d)\n", ret);
-		/* continue with reduced functionality */
-		return;
-	}
 
 	if (DISPLAY_VER(i915) >= 9) {
 		aud_freq_init = intel_de_read(i915, AUD_FREQ_CNTRL);
@@ -1285,6 +1274,21 @@ static void i915_audio_component_init(struct drm_i915_private *i915)
 
 	/* init with current cdclk */
 	intel_audio_cdclk_change_post(i915);
+}
+
+static void i915_audio_component_register(struct drm_i915_private *i915)
+{
+	int ret;
+
+	ret = component_add_typed(i915->drm.dev,
+				  &i915_audio_component_bind_ops,
+				  I915_COMPONENT_AUDIO);
+	if (ret < 0) {
+		drm_err(&i915->drm,
+			"failed to add audio component (%d)\n", ret);
+		/* continue with reduced functionality */
+		return;
+	}
 
 	i915->display.audio.component_registered = true;
 }
@@ -1317,6 +1321,12 @@ void intel_audio_init(struct drm_i915_private *i915)
 		i915_audio_component_init(i915);
 }
 
+void intel_audio_register(struct drm_i915_private *i915)
+{
+	if (!i915->display.audio.lpe.platdev)
+		i915_audio_component_register(i915);
+}
+
 /**
  * intel_audio_deinit() - deinitialize the audio driver
  * @i915: the i915 drm device private data
diff --git a/drivers/gpu/drm/i915/display/intel_audio.h b/drivers/gpu/drm/i915/display/intel_audio.h
index 9327954b801e..576c061d72a4 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.h
+++ b/drivers/gpu/drm/i915/display/intel_audio.h
@@ -28,6 +28,7 @@ void intel_audio_codec_get_config(struct intel_encoder *encoder,
 void intel_audio_cdclk_change_pre(struct drm_i915_private *dev_priv);
 void intel_audio_cdclk_change_post(struct drm_i915_private *dev_priv);
 void intel_audio_init(struct drm_i915_private *dev_priv);
+void intel_audio_register(struct drm_i915_private *i915);
 void intel_audio_deinit(struct drm_i915_private *dev_priv);
 void intel_audio_sdp_split_update(const struct intel_crtc_state *crtc_state);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 89bd032ed995..794b4af38055 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -540,6 +540,8 @@ void intel_display_driver_register(struct drm_i915_private *i915)
 
 	intel_display_driver_enable_user_access(i915);
 
+	intel_audio_register(i915);
+
 	intel_display_debugfs_register(i915);
 
 	/*


