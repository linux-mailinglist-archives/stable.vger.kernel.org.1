Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F17EB20B
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjKNOXl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKNOXk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 09:23:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550DDCA
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699971817; x=1731507817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RFjXrnDWh/GfkSTw3CQFmrkYOoh0zJlNiAsI7U8PUzg=;
  b=Yd8EhFMQNAgjHq/YEFNK3k/xQxtSDpcRNAm/IU0NG1P5uvNHovsKzbVM
   vdssdGaXMlALhuG3sv3tW56TwaoKiSRVMC4TnG8MDA0KQ0XMcmVygPebo
   Q68nm30diITK5Og5Qtuwj6q8DzKHfuCxer5zZDttVzME/VSg4vwpaNDMw
   TIfQx4G6NgMmGSJxnSvJgS/jsZ90QSLf9MS/g56cb4ik6ZOQaKiJanP/0
   x7SCKix3We0uG7JQOyP95ckINA+X2KwXO7o5uvFGs69GKSMH0tA/f3ruN
   O43vslVFZl3g5PAmAkAqUyGJmog17t5KatOjrrQwC8lBpNZiIgOgnh1Uw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370007647"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370007647"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="758188201"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="758188201"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 14 Nov 2023 06:23:34 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 14 Nov 2023 16:23:33 +0200
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] drm/i915: Also check for VGA converter in eDP probe
Date:   Tue, 14 Nov 2023 16:23:33 +0200
Message-ID: <20231114142333.15799-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Unfortunately even the HPD based detection added in
commit cfe5bdfb27fa ("drm/i915: Check HPD live state during eDP probe")
fails to detect that the VBT's eDP/DDI-A is a ghost on
Asus B360M-A (CFL+CNP). On that board eDP/DDI-A has its HPD
asserted despite nothing being actually connected there :(
The straps/fuses also indicate that the eDP port is present.

So if one boots with a VGA monitor connected the eDP probe will
mistake the DP->VGA converter hooked to DDI-E for an eDP panel
on DDI-A.

As a last resort check what kind of DP device we've detected,
and if it looks like a DP->VGA converter then conclude that
the eDP port should be ignored.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9636
Fixes: cfe5bdfb27fa ("drm/i915: Check HPD live state during eDP probe")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 28 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 54bd0bffa9f0..14ee05fabd05 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6277,8 +6277,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	 * (eg. Acer Chromebook C710), so we'll check it only if multiple
 	 * ports are attempting to use the same AUX CH, according to VBT.
 	 */
-	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata) &&
-	    !intel_digital_port_connected(encoder)) {
+	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata)) {
 		/*
 		 * If this fails, presume the DPCD answer came
 		 * from some other port using the same AUX CH.
@@ -6286,10 +6285,27 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 		 * FIXME maybe cleaner to check this before the
 		 * DPCD read? Would need sort out the VDD handling...
 		 */
-		drm_info(&dev_priv->drm,
-			 "[ENCODER:%d:%s] HPD is down, disabling eDP\n",
-			 encoder->base.base.id, encoder->base.name);
-		goto out_vdd_off;
+		if (!intel_digital_port_connected(encoder)) {
+			drm_info(&dev_priv->drm,
+				 "[ENCODER:%d:%s] HPD is down, disabling eDP\n",
+				 encoder->base.base.id, encoder->base.name);
+			goto out_vdd_off;
+		}
+
+		/*
+		 * Unfortunately even the HPD based detection fails on
+		 * eg. Asus B360M-A (CFL+CNP), so as a last resort fall
+		 * back to checking for a VGA branch device. Only do this
+		 * on known affected platforms to minimize false positives.
+		 */
+		if (DISPLAY_VER(dev_priv) == 9 && drm_dp_is_branch(intel_dp->dpcd) &&
+		    (intel_dp->dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_TYPE_MASK) ==
+		    DP_DWN_STRM_PORT_TYPE_ANALOG) {
+			drm_info(&dev_priv->drm,
+				 "[ENCODER:%d:%s] VGA converter detected, disabling eDP\n",
+				 encoder->base.base.id, encoder->base.name);
+			goto out_vdd_off;
+		}
 	}
 
 	mutex_lock(&dev_priv->drm.mode_config.mutex);
-- 
2.41.0

