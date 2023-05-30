Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4844715C8C
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjE3LFZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjE3LFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:05:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBA93
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtuwZ6gu3cQ3nt1O1FN+UHJEQGnA6Yj97UUHXamMD0iGtEr8JTIYZjpZiYCEPZqwxGhr10deUMPSC36eLp+uNHH82Gu1M6+FZk46/c6tJpHqSrfbKIWoP+VmGSotq3DJ3QzaO+kkVS4SN6hU5SKULBbUPnranIRh7vx+1UCATEJINNB1HpupQVlJEEEIxJ428FBsMs6buFC7/ghGaZWHrDhPAfH5qxoPteVAozInf0LcKR0A5yXGk3sO+zRXpzuP+4Gg2n7bJtY9DWWHqSdkhgPMfrLHDefT0wxK4HyQjSvZVHR3ougGSD9MyJdgxAh5KpAXNZdsobUfMBOo/NZf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqM/v0lPwspVemr5u0SDl42S9EbPYcO9Jm0yTAC1YEQ=;
 b=OGLOTNNMk/s8boZqCHpJZP75o19i6XCwmYIxaT7i7Kj6TRzmhxTFyCdejvR2OJbLz87GSoFeHe9krg3IlN0Z/Ewab2TxYU+mGbOoUwZRnNjZOgepIoEm2RczbLgkCXUdTesuQjFZIfyKKtGxvCQHlRcmQQbe8UBqMKKkBRL1w2YjcNdic2J9SVqWN008JiVHTxLOK7ezdOKNW/LWdUzUgo8Zg2Gk2PVNKXlb2SY+ksuQTHL0xFzjnvm4YUOVFUq0TqpmHjykHOo6V5qhptpiHUU5gVWwAXpVAyMJA3wnh4R1auFLGVDjhdrryuveUR8ffkaILrwThWPNp9TzVrcZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqM/v0lPwspVemr5u0SDl42S9EbPYcO9Jm0yTAC1YEQ=;
 b=SgnG267axD2ZyGGvVEzAqGFEFNRkPQoYLE/Mh4I6mcXgFwB0EVASW8WU7PT80Bi2QpgRgriganJYlKXRv84/xpW2VnUk0G53faVitcx0Z2Y01Axid0QiQOB+VuxXSielv3HmEe9PJP8TxYvGnkJV+qVcG8Zmdlokb0aGOZ9Hbpo=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 11:05:19 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::bc) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 11:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 11:05:19 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 06:05:16 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <stable@vger.kernel.org>
CC:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1.y] cpufreq: amd-pstate: Add ->fast_switch() callback
Date:   Tue, 30 May 2023 11:05:00 +0000
Message-ID: <20230530110500.3412-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023052858-overgrown-profile-8066@gregkh>
References: <2023052858-overgrown-profile-8066@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2b6e70-ea18-484a-68eb-08db60fdc163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTi68W2NbW01aox3onvOq28xdaUWYbRRrBzaFgZn0t0k1ETGogB11G6QTAC7JlCc9pIYwAKvcDJKS9F4b1F82kEKCzLRR0sUpGXVt2pBQT1MiTBTZ+6sdfgihgGqZkmibAe6dO0SZBrKLpklJED/CC71ZiNeTVkMFRJOZIoTVIWEkdQ5ETqsQdSiuHnoF3XD9yuAb5jks81eaMf5o+2HGZt+tQ6+YfMrV/rJsv484LvcVviofqz3bvjfkufTPguktwSCN3ahdcdxTdT9UMC8pUsT1Ohp8hbUPf1UpdqlRXhKW7O8sAKLqCtZyWq8PPt/wl5nSrFIwMFwFGQthWnyj79IqS/PEhIeW2lKvaU6VQD4Nk09yFw5CwNicKFdOhaerFF2ChySt/cNlCjEZ6MGoykdg5A6GpIaplCj3Csw/bRrIOdU7Bk62Pn9weTQtCldfY2PDXgVHgAPQBeRqxBAzyv+niIp2ntZQ1TsY3OSrMgrRDfh7LrIAqF6jSPeUVlCRvaOtatEgQkEBy7JvAcdNDSC1fO+ysnkcFTuwmziIxhQKm+VMooZ9DiXtF2HLjGowCl7J8KV7kTXMMraY/gsHuM0nyxhttAkjd/JOOjS610cdFXK9+D3LvTOuxmQnmhs0VbuoYg2MB4rJhWnrhP9/TKNs9cFN4ziRqUxbw3ibqWn8SLlqx0a8wjSABJJXxzRB7T6grVaPf2qhPbqQcCaveRhrbNXJfsI6Aqs+vnClCQtqQw6gfjTL3I+nsECDRQiFzxmq+Psrzk+pS5FPDD0hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(478600001)(40460700003)(4326008)(8676002)(44832011)(5660300002)(8936002)(36756003)(2906002)(86362001)(82310400005)(82740400003)(70586007)(70206006)(6916009)(316002)(356005)(81166007)(40480700001)(41300700001)(186003)(36860700001)(16526019)(26005)(336012)(1076003)(47076005)(7696005)(6666004)(426003)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:05:19.0098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b6e70-ea18-484a-68eb-08db60fdc163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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
index c17bd845f5fc..446edc0fd192 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -249,9 +249,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
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
@@ -270,14 +269,36 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
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
@@ -517,6 +538,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -608,6 +630,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

