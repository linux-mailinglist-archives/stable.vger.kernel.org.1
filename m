Return-Path: <stable+bounces-104237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A559F229D
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A0E7A0F5C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78942AB3;
	Sun, 15 Dec 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXFlpKH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE377483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251630; cv=none; b=m3zYAm++Wg6bDYqT8OOphWmBTdtZJD406+9IL5CLhvRDBtAou7UQvx9DVjV5OLUKzTtoKaxkTV2Z6wV/iL/Wd/4v9dP9xwgIbzQPww+bJTS2hJlJ0S5gL248cBHC62e0aWroebyFcEoWCpzQawL1tvXzmYeYpRQHze0CCTdj1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251630; c=relaxed/simple;
	bh=hYKPPLrONhsMZrEvRFMvXjE2SCRrGNKwGamOHY/FG34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=px4Munl+TABYg5RDOUkk7zGA3AJds2OWfKNe+H1HMvbsks2v4brLFnZ4VjZAt0/iTzbE8rREkInSuCpMKUcucN7mSKNrbBe0hbJdow9TrP22wcFsDcnDe//4Cq1wzzkXF+vEzIwdOF/NEAAiyM1PLW6+bn7MPJxIDkgjnOjA2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXFlpKH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16EDC4CECE;
	Sun, 15 Dec 2024 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251630;
	bh=hYKPPLrONhsMZrEvRFMvXjE2SCRrGNKwGamOHY/FG34=;
	h=Subject:To:Cc:From:Date:From;
	b=iXFlpKH5ejNDAgZwgHMPOLFTZfXnLmjaYrpuRCzUuPmSgQkGqj0feHmVaBEh509td
	 NpTAQD+8YFZJVkLeQ6J/N5xbpYy3aY8YUUeVfO2EnYTv9bNhvLrGbbo5KzcODCC692
	 2nidP45rh9nIzdfaur9uQAuKIioL5QPw1eFs7j/A=
Subject: FAILED: patch "[PATCH] drm/i915/dsb: Don't use indexed register writes needlessly" failed to apply to 6.12-stable tree
To: ville.syrjala@linux.intel.com,tursulin@ursulin.net,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:33:47 +0100
Message-ID: <2024121546-path-thicket-fc09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 70ec2e8be72c8cb71eb6a18f223484d2a39b708f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121546-path-thicket-fc09@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70ec2e8be72c8cb71eb6a18f223484d2a39b708f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Wed, 20 Nov 2024 18:41:20 +0200
Subject: [PATCH] drm/i915/dsb: Don't use indexed register writes needlessly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Link: https://patchwork.freedesktop.org/patch/msgid/20241120164123.12706-2-ville.syrjala@linux.intel.com
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
(cherry picked from commit ecba559a88ab8399a41893d7828caf4dccbeab6c)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

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


