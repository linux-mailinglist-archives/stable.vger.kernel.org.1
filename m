Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF317ECD58
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKOTgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjKOTf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688B81B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1774C433CC;
        Wed, 15 Nov 2023 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076955;
        bh=U10DjcbL2XGDJO7vCSTVmMaMcjZr0AqwDvh10vHydKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sp36/+oClv/JoYbweTG5Qw2lZlIfs43LC5n0Mhct/v1toLoooQaa72Sfhst8uKzJu
         FUYG0PtOOww4+1KwGamTVljM6Jozg5IfxlBE6b4CGFgo+XbxRBjJXU99tRFVRZ9dNb
         AoSwLTRr52eoxdSQmBAtmWoNf1r3OwDPKrIrNqH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/603] cpufreq: tegra194: fix warning due to missing opp_put
Date:   Wed, 15 Nov 2023 14:10:23 -0500
Message-ID: <20231115191618.520069104@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit bae8222a6c291dbe58c908dab5c2abd3a75d0d63 ]

Fix the warning due to missing dev_pm_opp_put() call and hence
wrong refcount value. This causes below warning message when
trying to remove the module.

 Call trace:
  dev_pm_opp_put_opp_table+0x154/0x15c
  dev_pm_opp_remove_table+0x34/0xa0
  _dev_pm_opp_cpumask_remove_table+0x7c/0xbc
  dev_pm_opp_of_cpumask_remove_table+0x10/0x18
  tegra194_cpufreq_exit+0x24/0x34 [tegra194_cpufreq]
  cpufreq_remove_dev+0xa8/0xf8
  subsys_interface_unregister+0x90/0xe8
  cpufreq_unregister_driver+0x54/0x9c
  tegra194_cpufreq_remove+0x18/0x2c [tegra194_cpufreq]
  platform_remove+0x24/0x74
  device_remove+0x48/0x78
  device_release_driver_internal+0xc8/0x160
  driver_detach+0x4c/0x90
  bus_remove_driver+0x68/0xb8
  driver_unregister+0x2c/0x58
  platform_driver_unregister+0x10/0x18
  tegra194_ccplex_driver_exit+0x14/0x1e0 [tegra194_cpufreq]
  __arm64_sys_delete_module+0x184/0x270

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
[ Viresh: Add a blank line ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/tegra194-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 88ef5e57ccd05..386aed3637b4e 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -450,6 +450,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
 		if (IS_ERR(opp))
 			continue;
 
+		dev_pm_opp_put(opp);
+
 		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
 		if (ret < 0)
 			return ret;
-- 
2.42.0



