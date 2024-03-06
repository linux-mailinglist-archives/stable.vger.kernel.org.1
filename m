Return-Path: <stable+bounces-26907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A30872DE4
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 05:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826421C21CA8
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 04:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34D156C2;
	Wed,  6 Mar 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL+A8YRw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7514AAD
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698103; cv=none; b=aGPApd8s0npGKKMw6kNxPAhs3rCZy+4sbBqN8SoS4Me/64CmaN/SJnvGA2gB1jycmDY0si5mn9pmWu6AzwefUpLojopNuYMNRE6ZeISi147yzqTJxfpjAoG5IoDfAvaVbjVrH0OgkNrdeuPRFwPgmiCQhhgP/Y+KWLdWI/dw0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698103; c=relaxed/simple;
	bh=/MeaEiD9vJujbGb9i/8TyfY3YwMH/pXlVWUyOqbGrJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7JsCzHA3IvE9I+KQDsDa0KSkkzl3qRF5OijctVL/bJfLsugSgDhN9zHGERXx4VaLNMC8vNxiPeCW2WXWL1MHw+USgQjWx2rRI3NeDJPLNRUQ8gRZGqIkRQj+CzOkpI8NuFvKPOq1rFu2BX1ZDpn+r2vjdHv3OBZG6/IRT0aJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL+A8YRw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709698102; x=1741234102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/MeaEiD9vJujbGb9i/8TyfY3YwMH/pXlVWUyOqbGrJw=;
  b=mL+A8YRwGLdIrRmxrhU7LwKbixFOCWV90xmwIwE+VjgO7cOz8eEvdPHE
   7m/r4cRZIDmW2Y+SQjdJn/3FI31Ui/Wo7BOjYRMQ/0jUckjy3Dh+UaCBk
   K3wbqykVGe3Mm9wPBOmsP5SiFPmeZTK0p6FIy0xASDXwrb77wm8K+Qztf
   QbfGiP5x6/KAqRt9906qZDcywkT+mofqaYBjJB+URfgy4aKwHvGL3vM7m
   WUOJD3pslAQqEMZCNK5+ZPrgA+U//d7TiQdPMC/hFyfDYEQ599pQDeBaR
   mKkrb1SzNZ0b4ZjFvFxqa9URZLHBudMghME0SEj1x2n6FOglEu8tBnSvj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21817368"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21817368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 20:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="827774099"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="827774099"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 05 Mar 2024 20:08:13 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Mar 2024 06:08:12 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/3] drm/i915/dsb: Fix DSB vblank waits when using VRR
Date: Wed,  6 Mar 2024 06:08:05 +0200
Message-ID: <20240306040806.21697-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306040806.21697-1-ville.syrjala@linux.intel.com>
References: <20240306040806.21697-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Looks like the undelayed vblank gets signalled exactly when
the active period ends. That is a problem for DSB+VRR when
we are already in vblank and expect DSB to start executing
as soon as we send the push. Instead of starting the DSB
just keeps on waiting for the undelayed vblank which won't
signal until the end of the next frame's active period,
which is far too late.

The end result is that DSB won't have even started
executing by the time the flips/etc. have completed.
We then wait for an extra 1ms, after which we terminate
the DSB and report a timeout:
[drm] *ERROR* [CRTC:80:pipe A] DSB 0 timed out waiting for idle (current head=0xfedf4000, head=0x0, tail=0x1080)

To fix this let's configure DSB to use the so called VRR
"safe window" instead of the undelayed vblank to trigger
the DSB vblank logic, when VRR is enabled.

Cc: stable@vger.kernel.org
Fixes: 34d8311f4a1c ("drm/i915/dsb: Re-instate DSB for LUT updates")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9927
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dsb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index d62e050185e7..e4515bf92038 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -340,6 +340,17 @@ static int intel_dsb_dewake_scanline(const struct intel_crtc_state *crtc_state)
 	return max(0, vblank_start - intel_usecs_to_scanlines(adjusted_mode, latency));
 }
 
+static u32 dsb_chicken(struct intel_crtc *crtc)
+{
+	if (crtc->mode_flags & I915_MODE_FLAG_VRR)
+		return DSB_CTRL_WAIT_SAFE_WINDOW |
+			DSB_CTRL_NO_WAIT_VBLANK |
+			DSB_INST_WAIT_SAFE_WINDOW |
+			DSB_INST_NO_WAIT_VBLANK;
+	else
+		return 0;
+}
+
 static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
 			      int dewake_scanline)
 {
@@ -361,6 +372,9 @@ static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
 	intel_de_write_fw(dev_priv, DSB_CTRL(pipe, dsb->id),
 			  ctrl | DSB_ENABLE);
 
+	intel_de_write_fw(dev_priv, DSB_CHICKEN(pipe, dsb->id),
+			  dsb_chicken(crtc));
+
 	intel_de_write_fw(dev_priv, DSB_HEAD(pipe, dsb->id),
 			  intel_dsb_buffer_ggtt_offset(&dsb->dsb_buf));
 
-- 
2.43.0


