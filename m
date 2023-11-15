Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9ED7ED098
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjKOT4f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjKOT4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B21AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FE9C433CB;
        Wed, 15 Nov 2023 19:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078177;
        bh=5a8Kx8F9U98yqAA2TeHQ5ZzmXwmqvygANHcR0l931DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aN2BIiS+SzOeaUpVFjWuJ8VzHIr9T7uKX3LYzc5qNti+kvRpDoA3wcPH5bsAQl78s
         wpGIBvMtOD4FZKt4jlPfl92ZPxBoSUxEwNBlEZeEEH22A8wJELd/pymdqUSN70Lgik
         OqzEN1NREV3VU5JsX8dWAm9cg50dnYtr1+v3FkHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junhao He <hejunhao3@huawei.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 158/379] perf: hisi: Fix use-after-free when register pmu fails
Date:   Wed, 15 Nov 2023 14:23:53 -0500
Message-ID: <20231115192654.459431962@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit b805cafc604bfdb671fae7347a57f51154afa735 ]

When we fail to register the uncore pmu, the pmu context may not been
allocated. The error handing will call cpuhp_state_remove_instance()
to call uncore pmu offline callback, which migrate the pmu context.
Since that's liable to lead to some kind of use-after-free.

Use cpuhp_state_remove_instance_nocalls() instead of
cpuhp_state_remove_instance() so that the notifiers don't execute after
the PMU device has been failed to register.

Fixes: a0ab25cd82ee ("drivers/perf: hisi: Add support for HiSilicon PA PMU driver")
FIxes: 3bf30882c3c7 ("drivers/perf: hisi: Add support for HiSilicon SLLC PMU driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Link: https://lore.kernel.org/r/20231024113630.13472-1-hejunhao3@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 4 ++--
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 47d3cc9b6eecd..d385234fa28df 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -416,8 +416,8 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	ret = perf_pmu_register(&pa_pmu->pmu, name, -1);
 	if (ret) {
 		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
-					    &pa_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
+						    &pa_pmu->node);
 		return ret;
 	}
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index b9c79f17230c2..7d363d475deb2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -450,8 +450,8 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
 	ret = perf_pmu_register(&sllc_pmu->pmu, name, -1);
 	if (ret) {
 		dev_err(sllc_pmu->dev, "PMU register failed, ret = %d\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
-					    &sllc_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
+						    &sllc_pmu->node);
 		return ret;
 	}
 
-- 
2.42.0



