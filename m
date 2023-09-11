Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434E79BBC1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378931AbjIKWiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjIKNyD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:54:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D9CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F3C433CA;
        Mon, 11 Sep 2023 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440439;
        bh=jWLGLUtSvxUW8KozbI4+5TnrVEcKTuvg6sXtrRfWgGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNcURoo3XCCRqNPhyUWX317KF7il7VnQEDzMjvB/pcUfJuhxI4K6WojnKLWypyjc8
         QOtN6qKYXacxyDMCvrxjWAtiXh5/ja4DqNpOX7YvBkNNNELi8l0XAD/WCMKYv4orzg
         RW9gbyqPyHNVWtkQ0zLR/Y+btu1vU3AZTnN9PfPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 062/739] cpufreq: tegra194: remove opp table in exit hook
Date:   Mon, 11 Sep 2023 15:37:41 +0200
Message-ID: <20230911134652.842826676@linuxfoundation.org>
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

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit de0e85b29edfc68046d587c7d67bbd2bdc31b73f ]

Add exit hook and remove OPP table when the device gets unregistered.
This will fix the error messages when the CPU FREQ driver module is
removed and then re-inserted. It also fixes these messages while
onlining the first CPU from a policy whose all CPU's were previously
offlined.

 debugfs: File 'cpu5' in directory 'opp' already present!
 debugfs: File 'cpu6' in directory 'opp' already present!
 debugfs: File 'cpu7' in directory 'opp' already present!

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
[ Viresh: Dropped irrelevant change from it ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/tegra194-cpufreq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 4f572eb7842f5..75f1e611d0aab 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -520,6 +520,17 @@ static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
 	 * Preserve policy->driver_data and don't free resources on light-weight
 	 * tear down.
 	 */
+
+	return 0;
+}
+
+static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+
 	return 0;
 }
 
@@ -550,6 +561,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.target_index = tegra194_cpufreq_set_target,
 	.get = tegra194_get_speed,
 	.init = tegra194_cpufreq_init,
+	.exit = tegra194_cpufreq_exit,
 	.online = tegra194_cpufreq_online,
 	.offline = tegra194_cpufreq_offline,
 	.attr = cpufreq_generic_attr,
-- 
2.40.1



