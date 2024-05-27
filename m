Return-Path: <stable+bounces-46271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2978CF8DF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 07:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048B4B20950
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2212C153;
	Mon, 27 May 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx6Sy0Bx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1548F40
	for <stable@vger.kernel.org>; Mon, 27 May 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716789092; cv=none; b=szXt4w+lf/McLkCgpHPUj7cfBwjRLlgo9lRrmzwDsChkIflfzwCZ3feCNoCt3rgG7cwfMX7SSr6aAZgGzqjog41Dkq3cP5mes1Lpt0qYNJy3GY6RNjB0VsDcUDv2Oi5llH7ujr8CMUiCc6CW8L2sueOhnKaE5hYsQoineZcZeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716789092; c=relaxed/simple;
	bh=sNQApo+BM/3I9BrUX3kPhK+8S2ynY//C0EpxIBYGioQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGNpOxLI8EmswRq/+cDTg/K9hIqPdF81ZBfNLYZ550M1Naf44e9W679fT5mUjZHbmFT6UMYuI7a84oThLhK+3mZDHAKaeO0HZMBM/uetKvggZwiyH6lWxePpE3Wxh5IChaLPGt94KaXrF5SZGiWqPB+Sd17tpR93NjKosV2h6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx6Sy0Bx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716789090; x=1748325090;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sNQApo+BM/3I9BrUX3kPhK+8S2ynY//C0EpxIBYGioQ=;
  b=fx6Sy0BxYiGtxKOHWBQxMW9hlQX4REYi5wQBIqn9FpanHMBYkPIybgJX
   FwPt7aHHd+V/jK0Eax2vQdXCKT4ztzEr79rCfjvQmVF0xYp4kTfwKUYAD
   WhkmzFBHAs6psDb180K0mMmu8t894hJLz0wFVYpc/JDPsuATfo/jlp0n6
   f4EnQ0rVDPafRxjKhWB6bG8HInMIRC348V5zSVEicdtC53Vx75pYCApmY
   yHUu3DLNgL55WLkj7/LHsC7VIP/1f+VXp1YUoZXZWrEfVBep8RzFShVqE
   iVGEGyWPUncwRIF3qAg0TGC4kgSouiOwQIWrRbuVcBdFGj24+Af/gkPmD
   A==;
X-CSE-ConnectionGUID: bmyAbOfzRyKGleYKXY+/iw==
X-CSE-MsgGUID: qZIK0IZgRVqp9F5M3Ev9Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38471664"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="38471664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 22:51:29 -0700
X-CSE-ConnectionGUID: 8EwKwr+xTt6sX3MUqvbBvA==
X-CSE-MsgGUID: o7lmzRx6T8i1Xnw0cLUFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="65441208"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa002.jf.intel.com with ESMTP; 26 May 2024 22:51:28 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] drm/i915/audio: Fix audio time stamp programming for DP
Date: Mon, 27 May 2024 11:15:47 +0530
Message-Id: <20240527054547.3072037-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024051325-ipad-sturdily-5677@gregkh>
References: <2024051325-ipad-sturdily-5677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel hardware is capable of programming the Maud/Naud SDPs on its
own based on real-time clocks. While doing so, it takes care
of any deviations from the theoretical values. Programming the registers
explicitly with static values can interfere with this logic. Therefore,
let the HW decide the Maud and Naud SDPs on it's own.

Cc: stable@vger.kernel.org # v5.17
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8097
Co-developed-by: Kai Vehmanen <kai.vehmanen@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240430091825.733499-1-chaitanya.kumar.borah@intel.com
(cherry picked from commit 8e056b50d92ae7f4d6895d1c97a69a2a953cf97b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit c66b8356273c8d22498f88e4223af47a7bf8a23c)
---
 drivers/gpu/drm/i915/display/intel_audio.c | 116 ++-------------------
 1 file changed, 9 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index aacbc6da84ef..a5fa0682110a 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -73,19 +73,6 @@ struct intel_audio_funcs {
 				    const struct drm_connector_state *old_conn_state);
 };
 
-/* DP N/M table */
-#define LC_810M	810000
-#define LC_540M	540000
-#define LC_270M	270000
-#define LC_162M	162000
-
-struct dp_aud_n_m {
-	int sample_rate;
-	int clock;
-	u16 m;
-	u16 n;
-};
-
 struct hdmi_aud_ncts {
 	int sample_rate;
 	int clock;
@@ -93,60 +80,6 @@ struct hdmi_aud_ncts {
 	int cts;
 };
 
-/* Values according to DP 1.4 Table 2-104 */
-static const struct dp_aud_n_m dp_aud_n_m[] = {
-	{ 32000, LC_162M, 1024, 10125 },
-	{ 44100, LC_162M, 784, 5625 },
-	{ 48000, LC_162M, 512, 3375 },
-	{ 64000, LC_162M, 2048, 10125 },
-	{ 88200, LC_162M, 1568, 5625 },
-	{ 96000, LC_162M, 1024, 3375 },
-	{ 128000, LC_162M, 4096, 10125 },
-	{ 176400, LC_162M, 3136, 5625 },
-	{ 192000, LC_162M, 2048, 3375 },
-	{ 32000, LC_270M, 1024, 16875 },
-	{ 44100, LC_270M, 784, 9375 },
-	{ 48000, LC_270M, 512, 5625 },
-	{ 64000, LC_270M, 2048, 16875 },
-	{ 88200, LC_270M, 1568, 9375 },
-	{ 96000, LC_270M, 1024, 5625 },
-	{ 128000, LC_270M, 4096, 16875 },
-	{ 176400, LC_270M, 3136, 9375 },
-	{ 192000, LC_270M, 2048, 5625 },
-	{ 32000, LC_540M, 1024, 33750 },
-	{ 44100, LC_540M, 784, 18750 },
-	{ 48000, LC_540M, 512, 11250 },
-	{ 64000, LC_540M, 2048, 33750 },
-	{ 88200, LC_540M, 1568, 18750 },
-	{ 96000, LC_540M, 1024, 11250 },
-	{ 128000, LC_540M, 4096, 33750 },
-	{ 176400, LC_540M, 3136, 18750 },
-	{ 192000, LC_540M, 2048, 11250 },
-	{ 32000, LC_810M, 1024, 50625 },
-	{ 44100, LC_810M, 784, 28125 },
-	{ 48000, LC_810M, 512, 16875 },
-	{ 64000, LC_810M, 2048, 50625 },
-	{ 88200, LC_810M, 1568, 28125 },
-	{ 96000, LC_810M, 1024, 16875 },
-	{ 128000, LC_810M, 4096, 50625 },
-	{ 176400, LC_810M, 3136, 28125 },
-	{ 192000, LC_810M, 2048, 16875 },
-};
-
-static const struct dp_aud_n_m *
-audio_config_dp_get_n_m(const struct intel_crtc_state *crtc_state, int rate)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dp_aud_n_m); i++) {
-		if (rate == dp_aud_n_m[i].sample_rate &&
-		    crtc_state->port_clock == dp_aud_n_m[i].clock)
-			return &dp_aud_n_m[i];
-	}
-
-	return NULL;
-}
-
 static const struct {
 	int clock;
 	u32 config;
@@ -392,48 +325,17 @@ static void
 hsw_dp_audio_config_update(struct intel_encoder *encoder,
 			   const struct intel_crtc_state *crtc_state)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
-	struct i915_audio_component *acomp = dev_priv->display.audio.component;
+	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
-	enum port port = encoder->port;
-	const struct dp_aud_n_m *nm;
-	int rate;
-	u32 tmp;
 
-	rate = acomp ? acomp->aud_sample_rate[port] : 0;
-	nm = audio_config_dp_get_n_m(crtc_state, rate);
-	if (nm)
-		drm_dbg_kms(&dev_priv->drm, "using Maud %u, Naud %u\n", nm->m,
-			    nm->n);
-	else
-		drm_dbg_kms(&dev_priv->drm, "using automatic Maud, Naud\n");
-
-	tmp = intel_de_read(dev_priv, HSW_AUD_CFG(cpu_transcoder));
-	tmp &= ~AUD_CONFIG_N_VALUE_INDEX;
-	tmp &= ~AUD_CONFIG_PIXEL_CLOCK_HDMI_MASK;
-	tmp &= ~AUD_CONFIG_N_PROG_ENABLE;
-	tmp |= AUD_CONFIG_N_VALUE_INDEX;
-
-	if (nm) {
-		tmp &= ~AUD_CONFIG_N_MASK;
-		tmp |= AUD_CONFIG_N(nm->n);
-		tmp |= AUD_CONFIG_N_PROG_ENABLE;
-	}
-
-	intel_de_write(dev_priv, HSW_AUD_CFG(cpu_transcoder), tmp);
-
-	tmp = intel_de_read(dev_priv, HSW_AUD_M_CTS_ENABLE(cpu_transcoder));
-	tmp &= ~AUD_CONFIG_M_MASK;
-	tmp &= ~AUD_M_CTS_M_VALUE_INDEX;
-	tmp &= ~AUD_M_CTS_M_PROG_ENABLE;
-
-	if (nm) {
-		tmp |= nm->m;
-		tmp |= AUD_M_CTS_M_VALUE_INDEX;
-		tmp |= AUD_M_CTS_M_PROG_ENABLE;
-	}
-
-	intel_de_write(dev_priv, HSW_AUD_M_CTS_ENABLE(cpu_transcoder), tmp);
+	/* Enable time stamps. Let HW calculate Maud/Naud values */
+	intel_de_rmw(i915, HSW_AUD_CFG(cpu_transcoder),
+		     AUD_CONFIG_N_VALUE_INDEX |
+		     AUD_CONFIG_PIXEL_CLOCK_HDMI_MASK |
+		     AUD_CONFIG_UPPER_N_MASK |
+		     AUD_CONFIG_LOWER_N_MASK |
+		     AUD_CONFIG_N_PROG_ENABLE,
+		     AUD_CONFIG_N_VALUE_INDEX);
 }
 
 static void
-- 
2.25.1


