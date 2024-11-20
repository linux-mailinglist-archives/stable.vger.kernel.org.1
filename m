Return-Path: <stable+bounces-94441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAB9D412B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE6B319E5
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AA142E7C;
	Wed, 20 Nov 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUMV4sG8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9813AA31
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120896; cv=none; b=VnckkNOKt9AQ7mjNXyOIOsCxL1ad1xOLa9skOh8vAn05TFaIpxzOr2vBz7wsWaXzLKfKDdsTVWEOrWvj3w1uirwyahwgXEM39FlzXr6CaRwY95ofU632USKWMggokh9npuWEqDhwI5oeK5UgRzmQfjVOWth1EbClCVH7KF7w1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120896; c=relaxed/simple;
	bh=g3A3r3MopyN8cFO6jvBckjdNob0tjvA5Qrwv3A0PpDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u84AgUAif2pNzfx7L3nJ/aASXE5aSQfHSTeW4lV4JOEGssU0Rg74fytQ7VzrPvs9apMCER+dWXC13+R0DjIsNCa11I1xwFBxcGPTsHZ7eBFt1CpG83wVAzMksVgik4XigsYoLzb3+aH5PnZvapu2Oqd5tAtK4yxfuGpjOqcAfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUMV4sG8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732120894; x=1763656894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3A3r3MopyN8cFO6jvBckjdNob0tjvA5Qrwv3A0PpDo=;
  b=MUMV4sG8yV24jz+rz0Xby/8I9BSA117FuKLUslOwi0rGmHB5mbPm7yhp
   aJ5taQlKSB4aWzb0OEvq6wCHxT2yluW+bkw/6/YRTzZdck1h5kgPGt7p/
   TR97H124GzqBaWfBYGYnkYm+0gdo3Ro0fR55ugPSygSIMdw6IYR72SaUI
   eK0V0TZ6lwuILenbe1ABoD7Jt5e6O/SzbOx/3asQSx8vf3t+QV7PIIyoR
   0TwecQQsV0pagDh3zg7QgvLj3ig/b8aTUyw9nq8Y3o7qzdXl9bEAynuqV
   uDAAzm+o2k4BcQ3rBumMRnKI+DDX2Ri/aYX+07PsUleSuVt2PqQT29JQC
   g==;
X-CSE-ConnectionGUID: SOgoJkiaTk+CPdNePBpNRw==
X-CSE-MsgGUID: sdGwYdRuRmqcFyIPX+OQuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="49620295"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="49620295"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 08:41:29 -0800
X-CSE-ConnectionGUID: ok5lBF/JRzC9h8pgBYoUTg==
X-CSE-MsgGUID: xs7bx+DlRseqyXB4PlWRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90137153"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 20 Nov 2024 08:41:27 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 20 Nov 2024 18:41:25 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/4] drm/i915/dsb: Don't use indexed register writes needlessly
Date: Wed, 20 Nov 2024 18:41:20 +0200
Message-ID: <20241120164123.12706-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120164123.12706-1-ville.syrjala@linux.intel.com>
References: <20241120164123.12706-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Turns out the DSB indexed register write command has
rather significant initial overhead compared to the normal
MMIO write command. Based on some quick experiments on TGL
you have to write the register at least ~5 times for the
indexed write command to come out ahead. If you write the
register less times than that the MMIO write is faster.

So it seems my automagic indexed write logic was a bit
misguided. Go back to the original approach only use
indexed writes for the cases we know will benefit from
it (indexed LUT register updates).

Currently we shouldn't have any cases where this truly
matters (just some rare double writes to the precision
LUT index registers), but we will need to switch the
legacy LUT updates to write each LUT register twice (to
avoid some palette anti-collision logic troubles).
This would be close to the worst case for using indexed
writes (two writes per register, and 256 separate registers).
Using the MMIO write command should shave off around 30%
of the execution time compared to using the indexed write
command.

Cc: stable@vger.kernel.org
Fixes: 34d8311f4a1c ("drm/i915/dsb: Re-instate DSB for LUT updates")
Fixes: 25ea3411bd23 ("drm/i915/dsb: Use non-posted register writes for legacy LUT")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 51 +++++++++++++---------
 drivers/gpu/drm/i915/display/intel_dsb.c   | 19 ++++++--
 drivers/gpu/drm/i915/display/intel_dsb.h   |  2 +
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 174753625bca..6ea3d5c58cb1 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1343,6 +1343,17 @@ static void ilk_lut_write(const struct intel_crtc_state *crtc_state,
 		intel_de_write_fw(display, reg, val);
 }
 
+static void ilk_lut_write_indexed(const struct intel_crtc_state *crtc_state,
+				  i915_reg_t reg, u32 val)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+
+	if (crtc_state->dsb_color_vblank)
+		intel_dsb_reg_write_indexed(crtc_state->dsb_color_vblank, reg, val);
+	else
+		intel_de_write_fw(display, reg, val);
+}
+
 static void ilk_load_lut_8(const struct intel_crtc_state *crtc_state,
 			   const struct drm_property_blob *blob)
 {
@@ -1458,8 +1469,8 @@ static void bdw_load_lut_10(const struct intel_crtc_state *crtc_state,
 		      prec_index);
 
 	for (i = 0; i < lut_size; i++)
-		ilk_lut_write(crtc_state, PREC_PAL_DATA(pipe),
-			      ilk_lut_10(&lut[i]));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_DATA(pipe),
+				      ilk_lut_10(&lut[i]));
 
 	/*
 	 * Reset the index, otherwise it prevents the legacy palette to be
@@ -1612,16 +1623,16 @@ static void glk_load_degamma_lut(const struct intel_crtc_state *crtc_state,
 		 * ToDo: Extend to max 7.0. Enable 32 bit input value
 		 * as compared to just 16 to achieve this.
 		 */
-		ilk_lut_write(crtc_state, PRE_CSC_GAMC_DATA(pipe),
-			      DISPLAY_VER(display) >= 14 ?
-			      mtl_degamma_lut(&lut[i]) : glk_degamma_lut(&lut[i]));
+		ilk_lut_write_indexed(crtc_state, PRE_CSC_GAMC_DATA(pipe),
+				      DISPLAY_VER(display) >= 14 ?
+				      mtl_degamma_lut(&lut[i]) : glk_degamma_lut(&lut[i]));
 	}
 
 	/* Clamp values > 1.0. */
 	while (i++ < glk_degamma_lut_size(display))
-		ilk_lut_write(crtc_state, PRE_CSC_GAMC_DATA(pipe),
-			      DISPLAY_VER(display) >= 14 ?
-			      1 << 24 : 1 << 16);
+		ilk_lut_write_indexed(crtc_state, PRE_CSC_GAMC_DATA(pipe),
+				      DISPLAY_VER(display) >= 14 ?
+				      1 << 24 : 1 << 16);
 
 	ilk_lut_write(crtc_state, PRE_CSC_GAMC_INDEX(pipe), 0);
 }
@@ -1687,10 +1698,10 @@ icl_program_gamma_superfine_segment(const struct intel_crtc_state *crtc_state)
 	for (i = 0; i < 9; i++) {
 		const struct drm_color_lut *entry = &lut[i];
 
-		ilk_lut_write(crtc_state, PREC_PAL_MULTI_SEG_DATA(pipe),
-			      ilk_lut_12p4_ldw(entry));
-		ilk_lut_write(crtc_state, PREC_PAL_MULTI_SEG_DATA(pipe),
-			      ilk_lut_12p4_udw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_MULTI_SEG_DATA(pipe),
+				      ilk_lut_12p4_ldw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_MULTI_SEG_DATA(pipe),
+				      ilk_lut_12p4_udw(entry));
 	}
 
 	ilk_lut_write(crtc_state, PREC_PAL_MULTI_SEG_INDEX(pipe),
@@ -1726,10 +1737,10 @@ icl_program_gamma_multi_segment(const struct intel_crtc_state *crtc_state)
 	for (i = 1; i < 257; i++) {
 		entry = &lut[i * 8];
 
-		ilk_lut_write(crtc_state, PREC_PAL_DATA(pipe),
-			      ilk_lut_12p4_ldw(entry));
-		ilk_lut_write(crtc_state, PREC_PAL_DATA(pipe),
-			      ilk_lut_12p4_udw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_DATA(pipe),
+				      ilk_lut_12p4_ldw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_DATA(pipe),
+				      ilk_lut_12p4_udw(entry));
 	}
 
 	/*
@@ -1747,10 +1758,10 @@ icl_program_gamma_multi_segment(const struct intel_crtc_state *crtc_state)
 	for (i = 0; i < 256; i++) {
 		entry = &lut[i * 8 * 128];
 
-		ilk_lut_write(crtc_state, PREC_PAL_DATA(pipe),
-			      ilk_lut_12p4_ldw(entry));
-		ilk_lut_write(crtc_state, PREC_PAL_DATA(pipe),
-			      ilk_lut_12p4_udw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_DATA(pipe),
+				      ilk_lut_12p4_ldw(entry));
+		ilk_lut_write_indexed(crtc_state, PREC_PAL_DATA(pipe),
+				      ilk_lut_12p4_udw(entry));
 	}
 
 	ilk_lut_write(crtc_state, PREC_PAL_INDEX(pipe),
diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index b7b44399adaa..4d3785f5cb52 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -273,16 +273,20 @@ static bool intel_dsb_prev_ins_is_indexed_write(struct intel_dsb *dsb, i915_reg_
 }
 
 /**
- * intel_dsb_reg_write() - Emit register wriite to the DSB context
+ * intel_dsb_reg_write_indexed() - Emit register wriite to the DSB context
  * @dsb: DSB context
  * @reg: register address.
  * @val: value.
  *
  * This function is used for writing register-value pair in command
  * buffer of DSB.
+ *
+ * Note that indexed writes are slower than normal MMIO writes
+ * for a small number (less than 5 or so) of writes to the same
+ * register.
  */
-void intel_dsb_reg_write(struct intel_dsb *dsb,
-			 i915_reg_t reg, u32 val)
+void intel_dsb_reg_write_indexed(struct intel_dsb *dsb,
+				 i915_reg_t reg, u32 val)
 {
 	/*
 	 * For example the buffer will look like below for 3 dwords for auto
@@ -340,6 +344,15 @@ void intel_dsb_reg_write(struct intel_dsb *dsb,
 	}
 }
 
+void intel_dsb_reg_write(struct intel_dsb *dsb,
+			 i915_reg_t reg, u32 val)
+{
+	intel_dsb_emit(dsb, val,
+		       (DSB_OPCODE_MMIO_WRITE << DSB_OPCODE_SHIFT) |
+		       (DSB_BYTE_EN << DSB_BYTE_EN_SHIFT) |
+		       i915_mmio_reg_offset(reg));
+}
+
 static u32 intel_dsb_mask_to_byte_en(u32 mask)
 {
 	return (!!(mask & 0xff000000) << 3 |
diff --git a/drivers/gpu/drm/i915/display/intel_dsb.h b/drivers/gpu/drm/i915/display/intel_dsb.h
index 33e0fc2ab380..da6df07a3c83 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.h
+++ b/drivers/gpu/drm/i915/display/intel_dsb.h
@@ -34,6 +34,8 @@ void intel_dsb_finish(struct intel_dsb *dsb);
 void intel_dsb_cleanup(struct intel_dsb *dsb);
 void intel_dsb_reg_write(struct intel_dsb *dsb,
 			 i915_reg_t reg, u32 val);
+void intel_dsb_reg_write_indexed(struct intel_dsb *dsb,
+				 i915_reg_t reg, u32 val);
 void intel_dsb_reg_write_masked(struct intel_dsb *dsb,
 				i915_reg_t reg, u32 mask, u32 val);
 void intel_dsb_noop(struct intel_dsb *dsb, int count);
-- 
2.45.2


