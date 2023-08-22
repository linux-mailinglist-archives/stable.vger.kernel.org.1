Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B5783EBF
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjHVLaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjHVLaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 07:30:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4493CE3
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692703804; x=1724239804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWEuM4oKeWdeSV5BzAiF3l7DSIV7C/w6JQFHFkTo95A=;
  b=LxoaS8VbrPyCbTiiuauuAgfDWpb97+nuJmvCuFnWx3hkZvrF2MDMnXgl
   7r09+UfbWOMAP5QJ35Uw2QbCejDXzzR5+5hDU3Mm3nmgtGXy8lVK4IbSm
   YdAmPT1dneK8igxU2MZgQ/f6fgf7eTd9oUomlsFVVQjtdGBzbKCIk+ijV
   56024vJh+Y/fDqF4PiXCmcdACJi959gYBrbbElPgUjfPYWdgZnM95RI5s
   I3KRRW8o82tdElp3YTTO26FFrb+t/504GkL9cgnzxO2ZSCIBVreO3IKN8
   nr07ODtST7A+KFRFuO597Qyf1ZaxCGgn2LHzJ/GorS1pbqx0tOWRvf2pv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377611515"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="377611515"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859886955"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="859886955"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:30:02 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [CI 2/2] drm/i915: Fix HPD polling, reenabling the output poll work as needed
Date:   Tue, 22 Aug 2023 14:30:15 +0300
Message-Id: <20230822113015.41224-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230822113015.41224-1-imre.deak@intel.com>
References: <20230822113015.41224-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

After the commit in the Fixes: line below, HPD polling stopped working
on i915, since after that change calling drm_kms_helper_poll_enable()
doesn't restart drm_mode_config::output_poll_work if the work was
stopped (no connectors needing polling) and enabling polling for a
connector (during runtime suspend or detecting an HPD IRQ storm).

After the above change calling drm_kms_helper_poll_enable() is a nop
after it's been called already and polling for some connectors was
disabled/re-enabled.

Fix this by calling drm_kms_helper_poll_reschedule() added in the
previous patch instead, which reschedules the work whenever expected.

Fixes: d33a54e3991d ("drm/probe_helper: sort out poll_running vs poll_enabled")
CC: stable@vger.kernel.org # 6.4+
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index e3ca192eb569c..e8562f6f8bb44 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -212,7 +212,7 @@ intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
 
 	/* Enable polling and queue hotplug re-enabling. */
 	if (hpd_disabled) {
-		drm_kms_helper_poll_enable(&dev_priv->drm);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 		mod_delayed_work(dev_priv->unordered_wq,
 				 &dev_priv->display.hotplug.reenable_work,
 				 msecs_to_jiffies(HPD_STORM_REENABLE_DELAY));
@@ -727,7 +727,7 @@ static void i915_hpd_poll_init_work(struct work_struct *work)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (enabled)
-		drm_kms_helper_poll_enable(&dev_priv->drm);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 
 	mutex_unlock(&dev_priv->drm.mode_config.mutex);
 
-- 
2.37.2

