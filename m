Return-Path: <stable+bounces-42988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521AF8B9DD3
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF881F21132
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07115B554;
	Thu,  2 May 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqtxwPbd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DB15574D
	for <stable@vger.kernel.org>; Thu,  2 May 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665173; cv=none; b=nUuZ4ZVpHiWW9aSKgm9P375mMQjzk/uUdoR4iUoVAQzcOoeJcZLOgNVq2Yu5jEX5PVb68y+77P2IyQHcGzaPTxbsoRxE+/O8c6rq0fcKGLnn1a7wuH2VE7CoFLjRiBUb8fAJmvIUQf7SY6B+S436+GYpueFLVR+0nE8JqknopXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665173; c=relaxed/simple;
	bh=H88WDtnSl6TI7VAC9IgLhDXM4EViQ8EpmNDGb+5HQIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJPw0bxJUnBUbgfdO1Kw1CkLKxa6kroW29lRWzGcVBq1cFc9YVUpBB6G6tvC1f2zIhkLyMZ5JOSjaX/gW9fcOZZwKPfmTK7MiKO/jqvjtU/ZNg9ii0pohTqxLbhrC4ihJiEgTwEyVzY6lDM4edW6AwpIpywFb0+xkLElyhI+JDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqtxwPbd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665171; x=1746201171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H88WDtnSl6TI7VAC9IgLhDXM4EViQ8EpmNDGb+5HQIk=;
  b=BqtxwPbdQ25+6jbt0uvz0w+Ay7sizoK5I+HxiaxmqxEPiOiSgMqgFrAO
   hRjjTee0jjcEbgeibCSwazqx62UirCUT3EmMgPGnEWvKBh4aK0Pu/BRha
   T5W2GNXkyz8ezB1AAjG0pQ05bO//JtPQ3sScZdqTPLkgylSx87G4/vEQF
   CfNq7nG95hbqw8m6Uxo21KK0aRlo3xhEdzihWBkehECS5yK0jadthLr+e
   e7TiT1WpuTo7BP9wvNoyvjnpSRqe8sQSgSpEzL8+BjqDVj4WLV89wTADz
   1XsQYRmP/K4u37laPNLp84xvrnLhgxBSx1+cAjBJFIIWmE/EZkKuTaU1j
   Q==;
X-CSE-ConnectionGUID: /tNf59bpQAavIezEEv2ouw==
X-CSE-MsgGUID: DTaw2YrXQLadY0+op0QwLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21129968"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21129968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:52:50 -0700
X-CSE-ConnectionGUID: sX7iyOjSRimzMRLo/zuOfA==
X-CSE-MsgGUID: 1Tb3OG2LQ6mpNg6NZSgDLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31630377"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa005.fm.intel.com with ESMTP; 02 May 2024 08:52:49 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: 
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/audio: Fix audio time stamp programming for DP
Date: Thu,  2 May 2024 21:16:55 +0530
Message-Id: <20240502154655.980686-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
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
---
 drivers/gpu/drm/i915/display/intel_audio.c | 113 ++-------------------
 1 file changed, 8 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 07e0c73204f3..ed81e1466c4b 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -76,19 +76,6 @@ struct intel_audio_funcs {
 				       struct intel_crtc_state *crtc_state);
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
@@ -96,60 +83,6 @@ struct hdmi_aud_ncts {
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
@@ -387,47 +320,17 @@ hsw_dp_audio_config_update(struct intel_encoder *encoder,
 			   const struct intel_crtc_state *crtc_state)
 {
 	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
-	struct i915_audio_component *acomp = i915->display.audio.component;
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
-	enum port port = encoder->port;
-	const struct dp_aud_n_m *nm;
-	int rate;
-	u32 tmp;
-
-	rate = acomp ? acomp->aud_sample_rate[port] : 0;
-	nm = audio_config_dp_get_n_m(crtc_state, rate);
-	if (nm)
-		drm_dbg_kms(&i915->drm, "using Maud %u, Naud %u\n", nm->m,
-			    nm->n);
-	else
-		drm_dbg_kms(&i915->drm, "using automatic Maud, Naud\n");
-
-	tmp = intel_de_read(i915, HSW_AUD_CFG(cpu_transcoder));
-	tmp &= ~AUD_CONFIG_N_VALUE_INDEX;
-	tmp &= ~AUD_CONFIG_PIXEL_CLOCK_HDMI_MASK;
-	tmp &= ~AUD_CONFIG_N_PROG_ENABLE;
-	tmp |= AUD_CONFIG_N_VALUE_INDEX;
 
-	if (nm) {
-		tmp &= ~AUD_CONFIG_N_MASK;
-		tmp |= AUD_CONFIG_N(nm->n);
-		tmp |= AUD_CONFIG_N_PROG_ENABLE;
-	}
-
-	intel_de_write(i915, HSW_AUD_CFG(cpu_transcoder), tmp);
-
-	tmp = intel_de_read(i915, HSW_AUD_M_CTS_ENABLE(cpu_transcoder));
-	tmp &= ~AUD_CONFIG_M_MASK;
-	tmp &= ~AUD_M_CTS_M_VALUE_INDEX;
-	tmp &= ~AUD_M_CTS_M_PROG_ENABLE;
-
-	if (nm) {
-		tmp |= nm->m;
-		tmp |= AUD_M_CTS_M_VALUE_INDEX;
-		tmp |= AUD_M_CTS_M_PROG_ENABLE;
-	}
+	/* Enable time stamps. Let HW calculate Maud/Naud values */
+	intel_de_rmw(i915, HSW_AUD_CFG(cpu_transcoder),
+		     AUD_CONFIG_N_VALUE_INDEX |
+		     AUD_CONFIG_PIXEL_CLOCK_HDMI_MASK |
+		     AUD_CONFIG_UPPER_N_MASK |
+		     AUD_CONFIG_LOWER_N_MASK |
+		     AUD_CONFIG_N_PROG_ENABLE,
+		     AUD_CONFIG_N_VALUE_INDEX);
 
-	intel_de_write(i915, HSW_AUD_M_CTS_ENABLE(cpu_transcoder), tmp);
 }
 
 static void
-- 
2.25.1


