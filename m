Return-Path: <stable+bounces-188960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E130CBFB4E9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA841891702
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D029C338;
	Wed, 22 Oct 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwHxR+GN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DC316183
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127649; cv=none; b=A6wGsj0bybu5g5N+iHLwT76ZFiZsYHkfT8eggwxNATxxaHXnDfePXiYf2sLh2nnOpB7Bxwn2qjfiQ0vSCpGVDyCrCYjDQO78QP8+6ck4oNqNvwRGVXWLfYlH7hMxPFnDEIN43UX4UIpZCkZxSnNyCpvY+l3B1Gngxl7f/pAXZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127649; c=relaxed/simple;
	bh=18qmIiliJyC6FuYP/6FDUOJhUAVcE11fF/xkZeb16kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpTvRk970QkTkT8SSBEviXb/3b/Xt6EL/ls4IAiqiNjb7oDUiRhH32xAC5auIxMjPwS7MszYPiHiFB2HgpDQbNcbYIQPERwRWteOfddbCUNP2t20gQaDJMxwLHMRb88/DzUuQ582y4QLPbqGM5kYClpYPxwISNuEDKBgd0ArxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwHxR+GN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761127648; x=1792663648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=18qmIiliJyC6FuYP/6FDUOJhUAVcE11fF/xkZeb16kI=;
  b=TwHxR+GNj/23XGKWGJ0XJk7lWyLQMgraolfRSnFqS1TvfCG3LZA4jtm4
   gROpbaGx+uMqTMYbiL9VZuRbWgFcp6+ArmEKMgAEOHkEEITzihbfrEvV0
   hyBNb9+//k6N3aVeO+mB7+XE0LNJYey0zEt4Ixp5QAdkZh2sIuVTFX+/c
   T+e6ra0m9oVOCm5NaDwyZMiZRtzMXXbPkeMMxQkBWOIyOxYHl1M9lBE9p
   aUEsiegQlp4vHF7xSDm55A5D0K8Fqffqo6IQqMvmUmwb44ze5lhYg9NJX
   y8zNoHXftR7HGswMwOoGbjt27LbjmwYiP340UA3jwVpY/YEFoI52xLmom
   A==;
X-CSE-ConnectionGUID: RzVl0B/dS4inFq051ojYNA==
X-CSE-MsgGUID: 7B/k6IF6S+65lHhT2NK+ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73561240"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="73561240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 03:07:27 -0700
X-CSE-ConnectionGUID: bV6F2B/gRg2QU0SixhNUZQ==
X-CSE-MsgGUID: CmHa5xffT7qfhCTD0KizMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183535843"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.74])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 03:07:25 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/3] drm/i915/dmc: Clear HRR EVT_CTL/HTP to zero on ADL-S
Date: Wed, 22 Oct 2025 13:07:16 +0300
Message-ID: <20251022100718.24803-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022100718.24803-1-ville.syrjala@linux.intel.com>
References: <20251022100718.24803-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On ADL-S the main DMC HRR event DMC_EVT_CTL/HTP are never
restored to their previous values during DC6 exit. This
angers assert_dmc_loaded(), and basically makes the HRR
handler unusable because we don't rewrite EVT_HTP when
enabling DMC events.

Let's just clear the HRR EVT_CTL/HTP to zero from the
beginnning so that the expected value matches the post-DC6
reality.

I suppose if we ever had actual use for HRR we'd have to both,
reject HRR+PSR, and reprogram EVT_HTP when enabling the event.
But for now we don't care about HRR so keeping both registers
zeroed is fine.

Cc: stable@vger.kernel.org
Tested-by: Petr Vorel <pvorel@suse.cz>
Fixes: 43175c92d403 ("drm/i915/dmc: Assert DMC is loaded harder")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15153
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 55 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index be6d37ea1139..5ba531e3bc36 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -550,6 +550,36 @@ static bool is_event_handler(struct intel_display *display,
 		REG_FIELD_GET(DMC_EVT_CTL_EVENT_ID_MASK, data) == event_id;
 }
 
+static bool fixup_dmc_evt(struct intel_display *display,
+			  enum intel_dmc_id dmc_id,
+			  i915_reg_t reg_ctl, u32 *data_ctl,
+			  i915_reg_t reg_htp, u32 *data_htp)
+{
+	if (!is_dmc_evt_ctl_reg(display, dmc_id, reg_ctl))
+		return false;
+
+	if (!is_dmc_evt_htp_reg(display, dmc_id, reg_htp))
+		return false;
+
+	/* make sure reg_ctl and reg_htp are for the same event */
+	if (i915_mmio_reg_offset(reg_ctl) - i915_mmio_reg_offset(DMC_EVT_CTL(display, dmc_id, 0)) !=
+	    i915_mmio_reg_offset(reg_htp) - i915_mmio_reg_offset(DMC_EVT_HTP(display, dmc_id, 0)))
+		return false;
+
+	/*
+	 * On ADL-S the HRR event handler is not restored after DC6.
+	 * Clear it to zero from the beginning to avoid mismatches later.
+	 */
+	if (display->platform.alderlake_s && dmc_id == DMC_FW_MAIN &&
+	    is_event_handler(display, dmc_id, MAINDMC_EVENT_VBLANK_A, reg_ctl, *data_ctl)) {
+		*data_ctl = 0;
+		*data_htp = 0;
+		return true;
+	}
+
+	return false;
+}
+
 static bool disable_dmc_evt(struct intel_display *display,
 			    enum intel_dmc_id dmc_id,
 			    i915_reg_t reg, u32 data)
@@ -1068,9 +1098,32 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	for (i = 0; i < mmio_count; i++) {
 		dmc_info->mmioaddr[i] = _MMIO(mmioaddr[i]);
 		dmc_info->mmiodata[i] = mmiodata[i];
+	}
 
+	for (i = 0; i < mmio_count - 1; i++) {
+		u32 orig_mmiodata[2] = {
+			dmc_info->mmiodata[i],
+			dmc_info->mmiodata[i+1],
+		};
+
+		if (!fixup_dmc_evt(display, dmc_id,
+				   dmc_info->mmioaddr[i], &dmc_info->mmiodata[i],
+				   dmc_info->mmioaddr[i+1], &dmc_info->mmiodata[i+1]))
+			continue;
+
+		drm_dbg_kms(display->drm,
+			    " mmio[%d]: 0x%x = 0x%x->0x%x (EVT_CTL)\n",
+			    i, i915_mmio_reg_offset(dmc_info->mmioaddr[i]),
+			    orig_mmiodata[0], dmc_info->mmiodata[i]);
+		drm_dbg_kms(display->drm,
+			    " mmio[%d]: 0x%x = 0x%x->0x%x (EVT_HTP)\n",
+			    i+1, i915_mmio_reg_offset(dmc_info->mmioaddr[i+1]),
+			    orig_mmiodata[1], dmc_info->mmiodata[i+1]);
+	}
+
+	for (i = 0; i < mmio_count; i++) {
 		drm_dbg_kms(display->drm, " mmio[%d]: 0x%x = 0x%x%s%s\n",
-			    i, mmioaddr[i], mmiodata[i],
+			    i, i915_mmio_reg_offset(dmc_info->mmioaddr[i]), dmc_info->mmiodata[i],
 			    is_dmc_evt_ctl_reg(display, dmc_id, dmc_info->mmioaddr[i]) ? " (EVT_CTL)" :
 			    is_dmc_evt_htp_reg(display, dmc_id, dmc_info->mmioaddr[i]) ? " (EVT_HTP)" : "",
 			    disable_dmc_evt(display, dmc_id, dmc_info->mmioaddr[i],
-- 
2.49.1


