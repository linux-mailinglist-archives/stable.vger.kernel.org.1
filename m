Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8BE715E13
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjE3L4L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjE3L4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:56:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C91184
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nankiVoqYClOu+n8ajIC34yG3iRgyJd7ZCefJF5yUw/lkZkyiWZ7q0Vp4lCoeV9DtGmlGov2smdFgFXJvLiGnrSlZbIwqdDlbVHfzRLQ3wY0pxtc1u8pDFVcxIxS+Ep0r7Rdi0IqmGC4N05kGXma3P4qIFPzINzFrOpuCA2eNXE8FxI3q5CIMX+hRqZ5Aun+bGffCNuaA5kGTTfp7vrYyIb1X6ERlEWnd8UN81VMPes3BxNUgCerTFznBylh0vGbehhFI2e5TlX/zMaRlXuhxSnJLG4JgIgXTvqmSUNJj6azx/lpEL3IGWKE9jJE4WSVVr5nBprrHZN6JK+DR7f7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HhShjDJJq+Ljy1dsOGigqypu3V02BIDzjvCq8O59Rg=;
 b=NH/e3FRtGiTBl0QeKfcZX9iqRkNCkPLGU9SwzD4wYRv0VLCexyzB17xmT/zHplxgGfCkU7X7sCAHrttwFRZVwXhRaGpDwcYD0vAnJKnduAF3eTnsBQtKP4HsOAORVWQF0MhhlfjUlQAGkKWeDJRrCp/fKqxOMO0o/Bs8D/UGvzpXUCQe243PAwQzkl/WhahyhB/TWP4jV/2qvefX/kph6QaKACLvLDw4H/fr4HGmMN3WYw+2Q/oLWnbuReEUuQcpCE2xm9OuTuyIETAam5Xq4r/UkpXlRfNiH6Vls8d81upb+Q/PFORMrv0yZ2W2IXFq6m99qSNcO7QwHNRx/my4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HhShjDJJq+Ljy1dsOGigqypu3V02BIDzjvCq8O59Rg=;
 b=2FGRt1NUAocDFT4G8V82YRH/FKklgN+G2kRK2kBNor0S08xBBsp5dD0IyRdExQEmQpstY3pFHhfMRAsJGbpa4JjFpCYzrz3FmNzepSpq3wr19M5uE61xu5gZiuWrDVq5khVBHKjjFlIKiEiDACpCG6oGp1IrH+6k5iUjtJjE1Jc=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:55:27 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::99) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 11:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 11:55:27 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 06:55:24 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <stable@vger.kernel.org>
CC:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.3.y] cpufreq: amd-pstate: Add ->fast_switch() callback
Date:   Tue, 30 May 2023 11:55:03 +0000
Message-ID: <20230530115503.3702-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023052858-danger-kilowatt-29cc@gregkh>
References: <2023052858-danger-kilowatt-29cc@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3559dcbd-2226-4199-f5db-08db6104c258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeLxSopy9i3kXRSpN/4kQy4KX6sbJxyhPKrwLdDzkfT59tjyBUAj8Daw4sSk7arq6wP5hobGjwwH0+mszbcuGz5z8lusOEV4pBTfPf9PJbmUXGqPoTk6jp9Y691Dd6xUMPq6zc2CZpRmIkOEVXOJ7zLmd3spTh8bp1MewuOs92tnw9wIO+tbV1GzXRCwllV/Kw0/WZbapNYnoeRKP6vrTjCYtRCCgBnMUXQOvEau79iiCVoRO0On/rD3xeXt5rrR9fibkU6t7VDU0PEYF7SyxxDYyXerNeP0ccTeXflIxefoefy7ptCOEjBc19jYGg63k/gHA5DtSwd6c/8cIMMzow6uUJFAP9bNYS06SjuwMy6CW+5oSalSWkZ8/R/llQYU1QjkZwuDEpBXuwqym6ZTM/p2ShDirGE1wBdmt8oXxT+JLlvjCdox3+CzYglZ026EE+WhM96VzkYewy3urTcfzY6EnS0nWGsRAZQ0zlwOueG0PlMrWSjLENSCAGe/LM+dBEXa+tN1PbJ61DzT7pTCnbV/q+P5dCVM5yzaB0tnURaclr1gz7LDKLPY8+YGBQGQag3fLpta/ZMWHMQ9WLHTT3cEENJ5NLQBFO1X0h0K43krmb/2i438YLVcoF27XX0Ld1RwLbz7kJq3yDn7bdPH3y/UyAuVFjBB0eHxijGKPXJ5CcFgk0DCWgO27Aig+qKxB5RkBF8TS1HcrUWlEU2K+cKwKrlJiPjebVMONL6LUDgS7OY1g9sQzyoOcdPEo6G47NC6e7NdpIgBpx3U6ylU0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(478600001)(40460700003)(8676002)(8936002)(44832011)(5660300002)(82310400005)(36756003)(2906002)(86362001)(81166007)(356005)(4326008)(6916009)(70586007)(82740400003)(70206006)(316002)(40480700001)(41300700001)(2616005)(16526019)(186003)(1076003)(26005)(36860700001)(47076005)(7696005)(6666004)(426003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:55:27.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3559dcbd-2226-4199-f5db-08db6104c258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

[ Upstream commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54 ]

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

