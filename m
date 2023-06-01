Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C2719E27
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjFAN3h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjFAN3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3759D18B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BA7644F1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538EDC433D2;
        Thu,  1 Jun 2023 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626122;
        bh=8cPrpwpUSHGwTVsLhEmDkOUS2HMtpoNlheNK71BGlsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFK0hcXHf8VK6g2N/0ISVAJsdWlxNh6jm82UncXJMIgolGBQjYx7NmnfzwulP/hpS
         G+NeGvhARV50Br3yY9pHMtpS0t80M7Axci8G41CzldfTtkFSw8mEjGgwdS/M0I+MpG
         ZrnWX+p/wzwi6Ta0sdz+HoYoqe9e1rkQj6CCHN00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wyes Karny <wyes.karny@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1 39/42] cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()
Date:   Thu,  1 Jun 2023 14:21:48 +0100
Message-Id: <20230601131940.808879850@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Wyes Karny <wyes.karny@amd.com>

commit 3bf8c6307bad5c0cc09cde982e146d847859b651 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -284,12 +284,14 @@ static void amd_pstate_adjust_perf(unsig
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
@@ -306,6 +308,10 @@ static void amd_pstate_adjust_perf(unsig
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	target_freq = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = target_freq;
+
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 	cpufreq_cpu_put(policy);
 }


