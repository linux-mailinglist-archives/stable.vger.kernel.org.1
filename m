Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA842719E31
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjFANaF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFAN3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C1199
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE136450F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6DAC433EF;
        Thu,  1 Jun 2023 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626149;
        bh=0gQE4kISWtQk4+U8e4MuMW+y4uFIpHJBnW3l5++bCrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sX125/j0rWvh0r8v7b9sAwxpGlRW+jcYaqNLFBLI6HSZQMii2HIL665xS9ATrQNpj
         jalOzUD6x1QBiI5w/wP5nY7JSSX1T+mU2ZA7MX/FOVu8ByLhb36LvqsepJGZboMqYW
         3O8A1FJwaWGvOKQKstK96RB1KdHM4kE7/wqjL2PY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 40/42] cpufreq: amd-pstate: Add ->fast_switch() callback
Date:   Thu,  1 Jun 2023 14:21:49 +0100
Message-Id: <20230601131940.857550671@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gautham R. Shenoy <gautham.shenoy@amd.com>

commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54 upstream.

Schedutil normally calls the adjust_perf callback for drivers with
adjust_perf callback available and fast_switch_possible flag set.
However, when frequency invariance is disabled and schedutil tries to
invoke fast_switch. So, there is a chance of kernel crash if this
function pointer is not set. To protect against this scenario add
fast_switch callback to amd_pstate driver.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |   37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -249,9 +249,8 @@ static int amd_pstate_verify(struct cpuf
 	return 0;
 }
 
-static int amd_pstate_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static int amd_pstate_update_freq(struct cpufreq_policy *policy,
+				  unsigned int target_freq, bool fast_switch)
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -270,14 +269,36 @@ static int amd_pstate_target(struct cpuf
 	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
 				     cpudata->max_freq);
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
-	cpufreq_freq_transition_end(policy, &freqs, false);
+	WARN_ON(fast_switch && !policy->fast_switch_enabled);
+	/*
+	 * If fast_switch is desired, then there aren't any registered
+	 * transition notifiers. See comment for
+	 * cpufreq_enable_fast_switch().
+	 */
+	if (!fast_switch)
+		cpufreq_freq_transition_begin(policy, &freqs);
+
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, fast_switch);
+
+	if (!fast_switch)
+		cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
 }
 
+static int amd_pstate_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	return amd_pstate_update_freq(policy, target_freq, false);
+}
+
+static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
+				  unsigned int target_freq)
+{
+	return amd_pstate_update_freq(policy, target_freq, true);
+}
+
 static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
@@ -523,6 +544,7 @@ static int amd_pstate_cpu_exit(struct cp
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -614,6 +636,7 @@ static struct cpufreq_driver amd_pstate_
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,


