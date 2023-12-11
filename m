Return-Path: <stable+bounces-6367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3674280DD50
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 22:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8301F21C04
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118654F83;
	Mon, 11 Dec 2023 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGVA6R5Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF154E5
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702330708; x=1733866708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzK5eNSOrHeGL8ouJnrLvyRmV1Ppxynx+Z+R/vu2bak=;
  b=XGVA6R5YcA9P8tLn4zFu755T9PK1OxCBP8qUBElYaTCwrKrCZCF5T/um
   sLQlcxwUTesrWRXvnj+eFURokP09pIBUH9Mj8fV3u6Psba4byvkhFO7ZV
   MyAWtzXwwSFhk3V1lbmcmhWQW3S9wDUB6gccqMPlBqw1pmzfoGNAHe9W6
   Up8rJssyz1N/pMOnk18u74PUD5Vj+RD1d54dVqX056nXRLGFul0eAgAoz
   w0BgdlLEYKCLmkSMLd2UCDagfCPQxoj549hOjqOeJhRpogCkW71gP9cHT
   OOF4IBOuvMkNdqgS/eTmAQxU5LOWmljeBeYReDqh07w44MPz3isr/PO/Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379712235"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="379712235"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766547032"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766547032"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 11 Dec 2023 13:37:54 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Dec 2023 23:37:53 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/4] drm/i915/dmc: Don't enable any pipe DMC events
Date: Mon, 11 Dec 2023 23:37:47 +0200
Message-ID: <20231211213750.27109-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211213750.27109-1-ville.syrjala@linux.intel.com>
References: <20231211213750.27109-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The pipe DMC seems to be making a mess of things in ADL. Various weird
symptoms have been observed such as missing vblank irqs, typicalle
happening when using multiple displays.

Keep all pipe DMC event handlers disabled until needed (which is never
atm). This is also what Windows does on ADL+.

We can also drop DG2 from disable_all_flip_queue_events() since
on DG2 the pipe DMC is the one that handles the flip queue events.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8685
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 43 ++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 63e080e07023..073b85b57679 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -389,7 +389,7 @@ disable_all_flip_queue_events(struct drm_i915_private *i915)
 	enum intel_dmc_id dmc_id;
 
 	/* TODO: check if the following applies to all D13+ platforms. */
-	if (!IS_DG2(i915) && !IS_TIGERLAKE(i915))
+	if (!IS_TIGERLAKE(i915))
 		return;
 
 	for_each_dmc_id(dmc_id) {
@@ -493,6 +493,45 @@ void intel_dmc_disable_pipe(struct drm_i915_private *i915, enum pipe pipe)
 		intel_de_rmw(i915, PIPEDMC_CONTROL(pipe), PIPEDMC_ENABLE, 0);
 }
 
+static bool is_dmc_evt_ctl_reg(struct drm_i915_private *i915,
+			       enum intel_dmc_id dmc_id, i915_reg_t reg)
+{
+	u32 offset = i915_mmio_reg_offset(reg);
+	u32 start = i915_mmio_reg_offset(DMC_EVT_CTL(i915, dmc_id, 0));
+	u32 end = i915_mmio_reg_offset(DMC_EVT_CTL(i915, dmc_id, DMC_EVENT_HANDLER_COUNT_GEN12));
+
+	return offset >= start && offset < end;
+}
+
+static bool disable_dmc_evt(struct drm_i915_private *i915,
+			    enum intel_dmc_id dmc_id,
+			    i915_reg_t reg, u32 data)
+{
+	if (!is_dmc_evt_ctl_reg(i915, dmc_id, reg))
+		return false;
+
+	/* keep all pipe DMC events disabled by default */
+	if (dmc_id != DMC_FW_MAIN)
+		return true;
+
+	return false;
+}
+
+static u32 dmc_mmiodata(struct drm_i915_private *i915,
+			struct intel_dmc *dmc,
+			enum intel_dmc_id dmc_id, int i)
+{
+	if (disable_dmc_evt(i915, dmc_id,
+			    dmc->dmc_info[dmc_id].mmioaddr[i],
+			    dmc->dmc_info[dmc_id].mmiodata[i]))
+		return REG_FIELD_PREP(DMC_EVT_CTL_TYPE_MASK,
+				      DMC_EVT_CTL_TYPE_EDGE_0_1) |
+			REG_FIELD_PREP(DMC_EVT_CTL_EVENT_ID_MASK,
+				       DMC_EVT_CTL_EVENT_ID_FALSE);
+	else
+		return dmc->dmc_info[dmc_id].mmiodata[i];
+}
+
 /**
  * intel_dmc_load_program() - write the firmware from memory to register.
  * @i915: i915 drm device.
@@ -532,7 +571,7 @@ void intel_dmc_load_program(struct drm_i915_private *i915)
 	for_each_dmc_id(dmc_id) {
 		for (i = 0; i < dmc->dmc_info[dmc_id].mmio_count; i++) {
 			intel_de_write(i915, dmc->dmc_info[dmc_id].mmioaddr[i],
-				       dmc->dmc_info[dmc_id].mmiodata[i]);
+				       dmc_mmiodata(i915, dmc, dmc_id, i));
 		}
 	}
 
-- 
2.41.0


