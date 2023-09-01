Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE078FEB5
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjIAODx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAODx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 10:03:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EF10EB
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693577030; x=1725113030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bNiEa0jL19K8lIItY6lSay6eWCAU+ZIE8PmKYRxuxwU=;
  b=hT493RhnZ7ykmVU+7pfNFzKe6oA/Bpp/jdNr+fAhB9ZMv9CnPdLeevzL
   pWIEM+ZJCp2YUE9wPoFkYatiY+0Yei/8hcNfMoXLXdWUq5PrZnN1XpC0U
   ZqmAXurv49b0LNbfoRH3cIrPVMoF1tWzwlSO1go3Tblc4VOtt5nZEbcYJ
   kHTbsUaCZm0LnOmf8vZpd1/BGnl+WO+YT/zyGOLCJ4HzxlDyAs5MMqKjS
   E/Tw3tmqoEsBtKjxVFK+c1yBVmMIeaqEOoXwOs1vMswaLCVk/XGuK4cg1
   h46dc9GOvuKDTeSBM6ylVChAXH1pgo6O22dwQ34hoyj44aFMMaWMGO8Aa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375126737"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375126737"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854714922"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="854714922"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:03:46 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Tejun Heo <tj@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915: Schedule the HPD poll init work on an unbound workqueue
Date:   Fri,  1 Sep 2023 17:04:02 +0300
Message-Id: <20230901140403.2821777-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Disabling HPD polling from i915_hpd_poll_init_work() involves probing
all display connectors explicitly to account for lost hotplug
interrupts. On some platforms (mostly pre-ICL) with HDMI connectors the
I2C EDID bit-banging using udelay() triggers in turn the

 workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND

warning.

Fix the above by scheduling i915_hpd_poll_init_work() on a WQ_UNBOUND
workqueue. It's ok to use a system WQ, since i915_hpd_poll_init_work()
is properly flushed in intel_hpd_cancel_work().

The connector probing from drm_mode_config::output_poll_work resulting
in the same warning is fixed by the next patch.

Cc: Tejun Heo <tj@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
CC: stable@vger.kernel.org # 6.5
Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9245
Link: https://lore.kernel.org/all/f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index e8562f6f8bb44..accc2fec562a0 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -774,7 +774,7 @@ void intel_hpd_poll_enable(struct drm_i915_private *dev_priv)
 	 * As well, there's no issue if we race here since we always reschedule
 	 * this worker anyway
 	 */
-	queue_work(dev_priv->unordered_wq,
+	queue_work(system_unbound_wq,
 		   &dev_priv->display.hotplug.poll_init_work);
 }
 
@@ -803,7 +803,7 @@ void intel_hpd_poll_disable(struct drm_i915_private *dev_priv)
 		return;
 
 	WRITE_ONCE(dev_priv->display.hotplug.poll_enabled, false);
-	queue_work(dev_priv->unordered_wq,
+	queue_work(system_unbound_wq,
 		   &dev_priv->display.hotplug.poll_init_work);
 }
 
-- 
2.37.2

