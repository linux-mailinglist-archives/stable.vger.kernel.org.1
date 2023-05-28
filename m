Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02169713852
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjE1H1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjE1H1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43CDE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD14A60FAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075D0C433EF;
        Sun, 28 May 2023 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685258863;
        bh=LHqP/aNq4aM+IfRJ4APph1CaMbH+MRgbCppPkrRYuaI=;
        h=Subject:To:Cc:From:Date:From;
        b=sf0CD+47DTQHbrrIoii3uNua+w83jfXY517/2b958Y9cNJEdn4LXw/ElxuYMZ+HE5
         CEW7E0rC/NEZsaODfr4O2fTc02AiFYGalc/d+tra1OjOjIcYjMd45ckkAd5QsxWEL/
         +bdkpnugYT/gDnHwjmJO1znPcM8vNvJIcHB88lIQ=
Subject: FAILED: patch "[PATCH] cpufreq: amd-pstate: Update policy->cur in" failed to apply to 6.1-stable tree
To:     wyes.karny@amd.com, rafael.j.wysocki@intel.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:27:33 +0100
Message-ID: <2023052832-arise-impeding-18c7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3bf8c6307bad5c0cc09cde982e146d847859b651
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052832-arise-impeding-18c7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3bf8c6307bad ("cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()")
2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")
3e6e07805764 ("Documentation: cpufreq: amd-pstate: Move amd_pstate param to alphabetical order")
5014603e409b ("Documentation: introduce amd pstate active mode kernel command line options")
ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
36c5014e5460 ("cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()")
4f3085f87b51 ("cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3bf8c6307bad5c0cc09cde982e146d847859b651 Mon Sep 17 00:00:00 2001
From: Wyes Karny <wyes.karny@amd.com>
Date: Thu, 18 May 2023 05:58:19 +0000
Subject: [PATCH] cpufreq: amd-pstate: Update policy->cur in
 amd_pstate_adjust_perf()

Driver should update policy->cur after updating the frequency.
Currently amd_pstate doesn't update policy->cur when `adjust_perf`
is used. Which causes /proc/cpuinfo to show wrong cpu frequency.
Fix this by updating policy->cur with correct frequency value in
adjust_perf function callback.

- Before the fix: (setting min freq to 1.5 MHz)

[root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
      1 cpu MHz         : 1777.016
      1 cpu MHz         : 1797.160
      1 cpu MHz         : 1797.270
    189 cpu MHz         : 400.000

- After the fix: (setting min freq to 1.5 MHz)

[root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
      1 cpu MHz         : 1753.353
      1 cpu MHz         : 1756.838
      1 cpu MHz         : 1776.466
      1 cpu MHz         : 1776.873
      1 cpu MHz         : 1777.308
      1 cpu MHz         : 1779.900
    183 cpu MHz         : 1805.231
      1 cpu MHz         : 1956.815
      1 cpu MHz         : 2246.203
      1 cpu MHz         : 2259.984

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
[ rjw: Subject edits ]
Cc: 5.17+ <stable@vger.kernel.org> # 5.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ac54779f5a49..ddd346a239e0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -501,12 +501,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long capacity)
 {
 	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, lowest_nonlinear_perf;
+		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned int target_freq;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
@@ -523,6 +525,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	target_freq = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = target_freq;
+
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 	cpufreq_cpu_put(policy);

