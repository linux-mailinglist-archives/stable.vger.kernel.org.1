Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C35715CD9
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjE3LRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3LRS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:17:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0A93
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWPgU1ismXR/pGDp++1guKc/oUZHE79kDIaeIsbvA3VWKc+jAdYe5wg2VN9JV3/X8bgXSZgnKFTTcZ1Cfv8hdW/ZHttIDF7R2Vx5oaFDvzXt0kUsQeQFJzoP/S1DK+Rl3NfJ1DXDz8ifyCJLZC2D6UqB32O6J7Nk9RFFicA0J7e9AxHQ8uRD6gxl3S4iN7VCP6Zqrdv8WwQlD6oLzkbNkMSUZl/G8jZtNDaMYfd+I41FseTwwogHUUXc1QSz8b4SYtYekITsV0YAF2BuGZgtUiKtvbnFTJP89BT8JiNS/xjvWBBAdl0d6+5Kqro60Y9v15kbK4nEBl7LlFBfdG26EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqD+X31gS0cg2qvJc/lMYvCPERh2A+/PK2D/T9CpETU=;
 b=GWu8iL+xrviGzrmCUTTQO90BYkD2SIhkXANi5Wzs/s0livBEpKhsAAWmJwwS2IFu4xdzDPzRW7twKxwBP7Ks3B5Pv5Z6aEx6BqHftWJ3YNt74SOyssOLyVvIGtoywVGT4MKCWCfsO03a51g/rxzj2gZEX67nj21bCOdUC/cWplfiwW+tD695u09or9JKYcSznWzH4vc3xgQSw4kCQxEihK/zK6RS7S4q0RZQmyqOnkv7QGJLdTka1JNO+ReuVqKZQH6GX76nnLs06csHHjx6mImTANMKFYzlv34B98e/1sYFS8qjHtLIvej70AXgtTOl7wBW1Hwvp670d89RNWxDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqD+X31gS0cg2qvJc/lMYvCPERh2A+/PK2D/T9CpETU=;
 b=R9T2qGz0Eqi25JQjIGxkbQ6j3x1G2Ge0y2Gsb98USqanNVE7m/c+CmNBvZc220I6JOA3TzNJQERU5ueaCJ08RGjJkV8Ow8+iNaCPn1wi+P5lzU3Xx1PAbOFws1Yk6SZfE8qGOJKaxa6BieuP/4RSvGLlxv8YbqlU1AL6j2+ge9I=
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 11:17:12 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::47) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 11:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 11:17:11 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 06:17:09 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <stable@vger.kernel.org>
CC:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.3.y] cpufreq: amd-pstate: Add ->fast_switch() callback
Date:   Tue, 30 May 2023 11:16:53 +0000
Message-ID: <20230530111653.3593-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023052834-enlighten-vacate-bfd6@gregkh>
References: <2023052834-enlighten-vacate-bfd6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 596a1f85-e7c0-4f60-d44c-08db60ff6a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V7qC1gqWucvuFAqve8DBvp1YIGg/gpe/3zDruwzN82ezlJXBSmIbtGkkxvOOiqkWKwLhmM+OBDLoHP+S8e2sJ+HTBjMNfLZrU8VyVjtmHHcJ8UOKtv8+4K2J68u+cZ1449FSDQmr5rWpp9hhvl8kEaUOHS59cPGaG0byl1esUj+mAeL2lml2FMA1d2Ug0587Af8uVK2+VhA3mxw6L2UlK2AO3dEo01MW+vGCNyehxAK2C9yb1+YUp5KM71ecuNmq416up6FTw5BS61pVhYqA+HoTB0BBCGt9p/1nDX5+j11bPWuQ7an0WrdjO+1+EG9ZvY+n2cjzeN46scts6pNCBJwER6u4Mz1930zJ65ZJKJMj5Lf7fcMUDyCDEAyT6gh+bKBb7oMdIyrLApNSOMIoBUjXN6vmuwWyB3LZ4h/qN7TR8UlVgH1DzIYnlnhsreIOan6fd9MH88lK7nmRL2+xQ1ItG/s/pfZo+MlZjCO9CGhYPMRsd+LkM/ZprMYXY63N9TaL8tS9GD2TDJ8ghu/K+pObqNIfWJAf14yF9vIVm3UafgLiUB20FPeoBOwK6IRJGMzGpZDJmPTmSqVmZip6X60vOt18URc/C68lUOu1Z2BaOgzqFdUheqU0gBaJrjLYFwhGV9WkZCPCzU1mZ0ERFo2uzHB/e21jEZ7XwRCoJDXCLz8TSc+TqXySLtiAlxQxVt1+dIS1U7fVi2qP7dgUmTgHdUzG6gr5oqw94WMg1alFZo1pLl95HNlNJ20swvTuBbJxtoFz8a9B4ZGy/v2Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(41300700001)(82310400005)(86362001)(316002)(6666004)(7696005)(4326008)(6916009)(36756003)(70206006)(70586007)(478600001)(40460700003)(36860700001)(44832011)(47076005)(40480700001)(5660300002)(81166007)(426003)(83380400001)(16526019)(186003)(336012)(2906002)(82740400003)(8676002)(8936002)(356005)(1076003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:17:11.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a1f85-e7c0-4f60-d44c-08db60ff6a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

[ Upstream commit 3bf8c6307bad5c0cc09cde982e146d847859b651 ]

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
(cherry picked from commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54)
---
 drivers/cpufreq/amd-pstate.c | 37 +++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8dd46fad151e..7cce90d16b8d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -422,9 +422,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
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
@@ -443,14 +442,36 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
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
@@ -692,6 +713,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -1226,6 +1248,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

