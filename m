Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA9797B13
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 20:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbjIGSBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjIGSBv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 14:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9562B2
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109691; x=1725645691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QWmd6zN6mmJiS8VHQ5wb2+PjcdfEbLLEVShSKta4ZhU=;
  b=Y4yxZDS51pTYxr4EBP4U/XIbd9fuCmcQjbDk0TbwikhX74F8FMdBNN6Z
   T4ZpchXIAswlwb7jloE+sZ1gFpw9xMmtDTtiAiHEGTneJAx5LVrxy6N4B
   hiyBCs5BjIeIDQ8arPGH/gjMxqyVxjc5V2+febY61SalobNIWji2+fz/L
   XjBc/cllnqxQ1uM63bUdUzpM9rh0T4QUgv+xcIfz1Kpj8l2Q8RxDRC5IQ
   9ZTS0JPmlGpBZ3IV8EniXrEcBrkgNECNzt4yGS2IG57ca2gHRb0JrKeGc
   c9wz2QAUGz160BCOLIzpd//LMZr+7KwiUO6hZIoH7qc2MGygeKJaSmJSV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443721335"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="443721335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="777050314"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="777050314"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.153])
  by orsmga001.jf.intel.com with SMTP; 07 Sep 2023 05:17:37 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 07 Sep 2023 15:17:36 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] drm/i915: Only check eDP HPD when AUX CH is shared
Date:   Thu,  7 Sep 2023 15:17:36 +0300
Message-ID: <20230907121736.23734-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently Acer Chromebook C740 (BDW-ULT) doesn't have the
eDP HPD line properly connected, and thus fails the new
HPD check during eDP probe. The result is that we lose the
eDP output.

I suspect all such machines would all be Chromebooks or other
Linux exclusive systems as the Windows driver likely wouldn't
work either. I did check a few other BDW machines here and
those do have eDP HPD connected, one of them even is a
different Chromebook (Samus).

To account for these funky machines let's skip the HPD check when
it looks like the eDP port is the only one using that specific AUX
channel. In case of multiple ports sharing the same AUX CH (eg. on
Asrock B250M-HDV) we still do the check and thus should correctly
ignore the eDP port in favor of the other DP port (usually a DP->VGA
converter).

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9264
Fixes: cfe5bdfb27fa ("drm/i915: Check HPD live state during eDP probe")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c | 19 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_bios.h |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c   |  7 ++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 858c959f7bab..aabecd2beb14 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -3540,6 +3540,25 @@ enum aux_ch intel_bios_dp_aux_ch(const struct intel_bios_encoder_data *devdata)
 	return map_aux_ch(devdata->i915, devdata->child.aux_channel);
 }
 
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata)
+{
+	u8 aux_channel;
+	int count = 0;
+
+	if (!devdata || !devdata->child.aux_channel)
+		return false;
+
+	aux_channel = devdata->child.aux_channel;
+
+	list_for_each_entry(devdata, &devdata->i915->display.vbt.display_devices, node) {
+		if (intel_bios_encoder_supports_dp(devdata) &&
+		    aux_channel == devdata->child.aux_channel)
+			count++;
+	}
+
+	return count > 1;
+}
+
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata)
 {
 	if (!devdata || devdata->i915->display.vbt.version < 196 || !devdata->child.iboost)
diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
index 9680e3e92bb5..49e24b7cf675 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -273,6 +273,7 @@ enum aux_ch intel_bios_dp_aux_ch(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_lane_count(const struct intel_bios_encoder_data *devdata);
 int intel_bios_dp_max_link_rate(const struct intel_bios_encoder_data *devdata);
+bool intel_bios_dp_has_shared_aux_ch(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_ddc_pin(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_level_shift(const struct intel_bios_encoder_data *devdata);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2206b45bc78c..aa5f602b56fb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5889,8 +5889,13 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	/*
 	 * VBT and straps are liars. Also check HPD as that seems
 	 * to be the most reliable piece of information available.
+	 *
+	 * ... expect on devices that forgot to hook HPD up for eDP
+	 * (eg. Acer Chromebook C710), so we'll check it only if multiple
+	 * ports are attempting to use the same AUX CH, according to VBT.
 	 */
-	if (!intel_digital_port_connected(encoder)) {
+	if (intel_bios_dp_has_shared_aux_ch(encoder->devdata) &&
+	    !intel_digital_port_connected(encoder)) {
 		/*
 		 * If this fails, presume the DPCD answer came
 		 * from some other port using the same AUX CH.
-- 
2.41.0

