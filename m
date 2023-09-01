Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2578FEB6
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349859AbjIAODy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAODx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 10:03:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EB10EC
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693577031; x=1725113031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zXfCtoMrzbDTA4n+1nOcRqiErSkQmB5TanHacVFv9Go=;
  b=TRL2CS1Q3FJ60Y6L2q6GHjmaM3vi0IKgAJQodGs5k2yARXNLSDzGCXhg
   PpAhz9g8nOxBBau/OlRkoWFWRjBdpqeK17VpCJENVtqkOv2mAu8LCkW4q
   oXdikO9Dw+vlvz16o6uLNtV/as+m3m+lXSO0bo0qWw0ybCWl+213nThen
   5MCi0f7XMKrL2B9djWIEwcLwbm0CyrV58sZutHJeAnjR/IXbPpvHPHfAX
   ziyOaaymGTezB8mxpHPHPI4o9Wu+XlpqS86g1K+ljGeziMTZO+vWEPVYh
   7fLVITUkiFkAJylxqS4TQ0/xmhaqgmGscjj2Ukgo+hrf8GMGh9Vsks4/m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375126747"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375126747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854714924"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="854714924"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:03:47 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Tejun Heo <tj@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm: Schedule the HPD poll work on the system unbound workqueue
Date:   Fri,  1 Sep 2023 17:04:03 +0300
Message-Id: <20230901140403.2821777-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230901140403.2821777-1-imre.deak@intel.com>
References: <20230901140403.2821777-1-imre.deak@intel.com>
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

On some i915 platforms at least the HPD poll work involves I2C
bit-banging using udelay()s to probe for monitor EDIDs. This in turn
may trigger the

 workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND

warning. Fix this by scheduling drm_mode_config::output_poll_work on a
WQ_UNBOUND workqueue.

Cc: Tejun Heo <tj@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
CC: stable@vger.kernel.org # 6.5
Cc: dri-devel@lists.freedesktop.org
Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9245
Link: https://lore.kernel.org/all/f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 3f479483d7d80..72eac0cd25e74 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -279,7 +279,8 @@ static void reschedule_output_poll_work(struct drm_device *dev)
 		 */
 		delay = HZ;
 
-	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+	queue_delayed_work(system_unbound_wq,
+			   &dev->mode_config.output_poll_work, delay);
 }
 
 /**
@@ -614,7 +615,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			mod_delayed_work(system_wq,
+			mod_delayed_work(system_unbound_wq,
 					 &dev->mode_config.output_poll_work,
 					 0);
 	}
@@ -838,7 +839,8 @@ static void output_poll_execute(struct work_struct *work)
 		drm_kms_helper_hotplug_event(dev);
 
 	if (repoll)
-		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
+		queue_delayed_work(system_unbound_wq,
+				   delayed_work, DRM_OUTPUT_POLL_PERIOD);
 }
 
 /**
-- 
2.37.2

