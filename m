Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670A7932DA
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 02:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjIFARj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIFARi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 20:17:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF71B4
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693959455; x=1725495455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fsprNLE92UYWoVyvlzfMcV9/C+yTh2UuD5M65H8LqoE=;
  b=kfBUKWyedfppq9jOzT52B5wU/xIcR1GrcmzsRg6HtKeuwb/aF/ulfDzY
   Y0WX1zzHBLZQFL0lYhNADHcUmm6hJuEc0vq42DHFNJyNFeyvWPhs6nw7r
   o6MDGl3BPuU07mrAU8Hm22y6F+UNw2qVENsW288ho41M5M4FFea39dzBD
   gPZiQC+7thIih6dt+jNOdijWzkX5ua6fLxkyOv4fI2d6oj5qTGtlMpAzG
   JpoiTg9uyWoEP4+HWuofNRAzyRle+wPcvqNPasv8CgR2lW/SBsihgG9Jt
   S9KXEI6CSJ9vOABzegCAfiPxXNUkMZgI4U0HyAnpHImDv7wgjs9TDaMr+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375833568"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="375833568"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 17:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691108819"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="691108819"
Received: from yjie-desk1.jf.intel.com ([10.24.100.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 17:17:34 -0700
From:   Keyon Jie <yang.jie@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Smythies <dsmythies@telus.net>, stable@vger.kernel.org
Cc:     Yang Jie <yang.jie@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: set stale CPU frequency to minimum
Date:   Tue,  5 Sep 2023 17:16:46 -0700
Message-Id: <20230906001646.338935-1-yang.jie@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Doug Smythies <dsmythies@telus.net>

commit d51847acb018d83186e4af67bc93f9a00a8644f7 upstream.

This fix applies to all stable kernel versions 5.18+.

The intel_pstate CPU frequency scaling driver does not
use policy->cur and it is 0.
When the CPU frequency is outdated arch_freq_get_on_cpu()
will default to the nominal clock frequency when its call to
cpufreq_quick_getpolicy_cur returns the never updated 0.
Thus, the listed frequency might be outside of currently
set limits. Some users are complaining about the high
reported frequency, albeit stale, when their system is
idle and/or it is above the reduced maximum they have set.

This patch will maintain policy_cur for the intel_pstate
driver at the current minimum CPU frequency.

Reported-by: Yang Jie <yang.jie@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
Signed-off-by: Doug Smythies <dsmythies@telus.net>
[ rjw: White space damage fixes and comment adjustment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d51f90f55c05..fbe3a4098743 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2574,6 +2574,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 			intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_hwp_set(policy->cpu);
 	}
+	/*
+	 * policy->cur is never updated with the intel_pstate driver, but it
+	 * is used as a stale frequency value. So, keep it within limits.
+	 */
+	policy->cur = policy->min;
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-- 
2.34.1

