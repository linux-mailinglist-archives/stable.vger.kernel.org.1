Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABED79ADE2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353914AbjIKVvc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjIKOcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDDF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB8C433C7;
        Mon, 11 Sep 2023 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442763;
        bh=09LSTOc56kAarT6FX9XDLanBgAHyuF5L9vHV+XXSQZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoF19VGA3OmGuFP7mqBDgymu3YuPHDyYVpdyCf4K5+jUGdjZQ/MzAW2PBV5SPSnkZ
         gubsenryEQJ0Las8c9R6/ANBQmN0XvwbvXz7ko9yGCnb4HudykX29A6IYbZTW+WgGO
         VKYPfFU6OPKYLMQrYr1fviQbGIFor99DiyJNgQPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 139/737] cpufreq: tegra194: remove opp table in exit hook
Date:   Mon, 11 Sep 2023 15:39:58 +0200
Message-ID: <20230911134654.382862593@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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



