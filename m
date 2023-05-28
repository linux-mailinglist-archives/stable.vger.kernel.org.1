Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A593713AD2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjE1Qzm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjE1Qzl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF83BD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F293F60F4B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C137C433EF;
        Sun, 28 May 2023 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292939;
        bh=gx3V7Fe80RxY05rY3EJixGuWNRk0rwGz8i4e5d39rF0=;
        h=Subject:To:Cc:From:Date:From;
        b=PMxMw6E2SEg9ydP7qEWIsu9suPLfCpauTAG6ZIQTFQbxxO0hQ/SXy705aPHPrp65s
         OWdMhx8+99LGDkJepOvI6vsYW32E6tra8/vl3N1riLJHK9ooUr+efZLKfeBAK6XQgZ
         TUuBxr2ZXbaGqCpLFEGcP8tT6aQjkwlVLuqyeekM=
Subject: FAILED: patch "[PATCH] cpufreq: amd-pstate: Add ->fast_switch() callback" failed to apply to 6.3-stable tree
To:     gautham.shenoy@amd.com, rafael.j.wysocki@intel.com,
        wyes.karny@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:53:58 +0100
Message-ID: <2023052858-danger-kilowatt-29cc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052858-danger-kilowatt-29cc@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")
3e6e07805764 ("Documentation: cpufreq: amd-pstate: Move amd_pstate param to alphabetical order")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Wed, 17 May 2023 16:28:15 +0000
Subject: [PATCH] cpufreq: amd-pstate: Add ->fast_switch() callback

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

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..45711fc0a856 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -444,9 +444,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
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
@@ -465,14 +464,37 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
 				     cpudata->max_freq);
 
-	cpufreq_freq_transition_begin(policy, &freqs);
+	WARN_ON(fast_switch && !policy->fast_switch_enabled);
+	/*
+	 * If fast_switch is desired, then there aren't any registered
+	 * transition notifiers. See comment for
+	 * cpufreq_enable_fast_switch().
+	 */
+	if (!fast_switch)
+		cpufreq_freq_transition_begin(policy, &freqs);
+
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false, policy->governor->flags);
-	cpufreq_freq_transition_end(policy, &freqs, false);
+			max_perf, fast_switch, policy->governor->flags);
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
@@ -715,6 +737,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -1309,6 +1332,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,

