Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602EF6F814D
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjEELN7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEELN6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 07:13:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9042F1A106
        for <stable@vger.kernel.org>; Fri,  5 May 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683285237; x=1714821237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQk53vK2noTp4D/t0s3QwPzuNDs9va10+uSyM8ZRwmc=;
  b=MQzGfzf1EC9WE/f7gsTn1hqOeZ5mQocGyYtkx0pkSEDh/WyrQLDjDNIf
   qsBFfsjLpKOhMSB2EhCdmLYihiy17f/bj5VCBMicZcRbmA/tzFMTkEdSs
   6V+mlrOg/1kdR0ltHUDuvLbSiA5PB3UgKmrGOHlC2lhovqDvQC/cr+wUd
   vn76HokW+mftY34214e1rvRQgjOaIc4LaIVFumD2hZap3zPezXtBViS7q
   sRAgRmXqjcjs7SSxEkzZfAnPqbQxr5+5pbol1FEepSYYFAlji0gbIXrbf
   sNTyCMh5kiBXHN6z+8Li0C6FfE1C86v4sUZ9iSWrJCTdDpIcxHIlk0N+w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="338372607"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="338372607"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 04:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="647807632"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="647807632"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 04:13:55 -0700
From:   Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     imre.deak@intel.com, lucas.demarchi@intel.com,
        stable@vger.kernel.org
Subject: [PATCH] drm/i915/display: Update the DDI_BUF_CTL active timeout for ADL-P
Date:   Fri,  5 May 2023 16:39:17 +0530
Message-Id: <20230505110917.1918957-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

For ADL-P the timeout for DDI_BUF_CTL active is 500usec.
Update the same as per Bspec:55424.

Fixes: 5add4575c298 ("drm/i915/ddi: Align timeout for DDI_BUF_CTL active with Bspec")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.3+

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 55f36d9d509c..6d8e4d7a784e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -216,8 +216,11 @@ static void intel_wait_ddi_buf_active(struct drm_i915_private *dev_priv,
 	} else if (DISPLAY_VER(dev_priv) >= 12) {
 		if (intel_phy_is_tc(dev_priv, phy))
 			timeout_us = 3000;
+		else if (IS_ALDERLAKE_P(dev_priv))
+			timeout_us = 500;
 		else
 			timeout_us = 1000;
+
 	} else {
 		timeout_us = 500;
 	}
-- 
2.25.1

