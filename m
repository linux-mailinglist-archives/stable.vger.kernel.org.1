Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47F6FA74E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjEHK3P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjEHK3E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE4D860
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B90562679
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED2C433EF;
        Mon,  8 May 2023 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541741;
        bh=BWRJK/SZL5xK3HLqqcjp8qTFYoR4+FcGnvHUMd26QxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca0tPsn8aToptkJg/esaBvOtgnww5CXJszV/x7oc6UqlsonOeR/mwO+4qcImrREVa
         hr5o4eVegUbffYJa+1P+vNzJtZ0rViaDFXmC7Why4QWz1uswI8Uv3TiPltDatluSit
         t9txsI/0kcolC0ejKn9+I8Z58lfa2BsrX5hyONd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 205/663] cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos
Date:   Mon,  8 May 2023 11:40:31 +0200
Message-Id: <20230508094435.022447155@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit e2b47e585931a988c856fd4ba31e1296f749aee3 ]

The OSM/EPSS hardware controls the frequency of each CPU cluster based
on requests from the OS and various throttling events in the system.
While throttling is in effect the related dcvs interrupt will be kept
high. The purpose of the code handling this interrupt is to
continuously report the thermal pressure based on the throttled
frequency.

The reasoning for adding QoS control to this mechanism is not entirely
clear, but the introduction of commit 'c4c0efb06f17 ("cpufreq:
qcom-cpufreq-hw: Add cpufreq qos for LMh")' causes the
scaling_max_frequncy to be set to the throttled frequency. On the next
iteration of polling, the throttled frequency is above or equal to the
newly requested frequency, so the polling is stopped.

With cpufreq limiting the max frequency, the hardware no longer report a
throttling state and no further updates to thermal pressure or qos
state are made.

The result of this is that scaling_max_frequency can only go down, and
the system becomes slower and slower every time a thermal throttling
event is reported by the hardware.

Even if the logic could be improved, there is no reason for software to
limit the max freqency in response to the hardware limiting the max
frequency. At best software will follow the reported hardware state, but
typically it will cause slower backoff of the throttling.

This reverts commit c4c0efb06f17fa4a37ad99e7752b18a5405c76dc.

Fixes: c4c0efb06f17 ("cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh")
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index e8e42dbaf86c0..64a50777d88b8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -14,7 +14,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
-#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/units.h>
@@ -57,8 +56,6 @@ struct qcom_cpufreq_data {
 	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
-
-	struct freq_qos_request throttle_freq_req;
 };
 
 static struct {
@@ -348,8 +345,6 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
-	freq_qos_update_request(&data->throttle_freq_req, throttled_freq);
-
 	/* Update thermal pressure (the boost frequencies are accepted) */
 	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
 
@@ -442,14 +437,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 	if (data->throttle_irq < 0)
 		return data->throttle_irq;
 
-	ret = freq_qos_add_request(&policy->constraints,
-				   &data->throttle_freq_req, FREQ_QOS_MAX,
-				   FREQ_QOS_MAX_DEFAULT_VALUE);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to add freq constraint (%d)\n", ret);
-		return ret;
-	}
-
 	data->cancel_throttle = false;
 	data->policy = policy;
 
@@ -516,7 +503,6 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 	if (data->throttle_irq <= 0)
 		return;
 
-	freq_qos_remove_request(&data->throttle_freq_req);
 	free_irq(data->throttle_irq, data);
 }
 
-- 
2.39.2



