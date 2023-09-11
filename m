Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9979C0DF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjIKWrD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbjIKNv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:51:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3EDFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:51:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3905C433C7;
        Mon, 11 Sep 2023 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440314;
        bh=JGa2s9BA82mfzcZQIx+gT7WCX9Hd9i48Mb9GGu3W414=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxH6vjGDnCafB1PP5YPaH9c1uqRj0B82RgYhj2wGg6UyJUso0HSn84LKNE/Utcjip
         /1K6lP6ZDu7ZPpC0Rzex3vDMtNZ2Wu+cFzkjnqkeN2daOGjFCgS2xlzPnfTYyFy0Mp
         rbMqQ/dyJjJOhtzkYwVFzPH1Ddn9AZK4tY/us938=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jie <yang.jie@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 002/739] cpufreq: intel_pstate: set stale CPU frequency to minimum
Date:   Mon, 11 Sep 2023 15:36:41 +0200
Message-ID: <20230911134651.010670934@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Smythies <dsmythies@telus.net>

commit d51847acb018d83186e4af67bc93f9a00a8644f7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struc
 			intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_hwp_set(policy->cpu);
 	}
+	/*
+	 * policy->cur is never updated with the intel_pstate driver, but it
+	 * is used as a stale frequency value. So, keep it within limits.
+	 */
+	policy->cur = policy->min;
 
 	mutex_unlock(&intel_pstate_limits_lock);
 


