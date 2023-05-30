Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580EB715E4A
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjE3MB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjE3MB0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 08:01:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA09D9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 05:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5MIqkFEx0sxUfvQ+bXHO/Ri1OzQRf9wQ70e9Cn5viLztCHcPhTtlBEFkSy+m6wuPNSgni9SIwLOXnqZ+ddeq5gPHGNu4Gz9lJ1jEItlZv4JYnDWd83PEr8jSXKm2CD5Rh2Zay/Fw/c41Vyns46+4FQxPxXJSmiyjRPx6zwPauuBwafiWZZs0ccgH8xOXkzIJSWWUjO93ovoHtcRpgRAXQgkfm5r3mFGSwtUuotZc8fgty2WOJ3mGSM0bjAEu+mKW3XFt4EPu8RmKC78JD/6/jTlVUteps9Y8dNhcioaE+ednRc+ERG2YmsYrTlPcXWt9XHozZ+RXBP0xclPerRHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmMUo/vOcOlVBDBzTnhcEnjhvkvZQhZHPFE9qm+VPW4=;
 b=SQmLmscPNsv/o5yluI0P5i9AqCSbXeKt+HyN3CiJLaqhVMZdhslTqQ+9a2Dt6ijKjNo7oCukKqlm8hihtAQUhDb2IFSUFFa5bl3mUXadrB0fqszM7Ig0WX+dcEsKTpYmfuSts7HHdO8Yt6EbSkVe4zD1RrtDAULMQH+dycsA5y93n627uumpfInTGB5luO1jngoC0mR2fckR/E6pakqEYrVcS0VOEHGls2nCWpcO2zPwZhN6XW/VOIaGfTV/sENJpRIRFX4iyPc6GVYu65LQ7BOOFNnLZzO4jRWPka8ivPZb+O2nJAFy/XO1o5x0UWJ2wipUST6ZY1kSd81+fn+PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmMUo/vOcOlVBDBzTnhcEnjhvkvZQhZHPFE9qm+VPW4=;
 b=3jKaek40unA+5kKWaF/lKPq1lI8rE1Qd7CGunAGbFPPyrNF4rBgG0qyNqi3D9zQa98IZ7047mEKg7NQL+rJ/Sop848ePP8qOzbqOGNvlB3Is1rAXXmnryPjT/X787nc9rniGf8zcltMiZxkUA5qBRBow91DozhFZ6i8mZau2BO4=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 12:01:20 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::2d) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 12:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 12:01:20 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 07:01:18 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <stable@vger.kernel.org>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.3.y] cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()
Date:   Tue, 30 May 2023 12:01:00 +0000
Message-ID: <20230530120100.3942-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023052834-enlighten-vacate-bfd6@gregkh>
References: <2023052834-enlighten-vacate-bfd6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 490d99e5-3883-4652-1ed5-08db610594e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnv6HoCpdtBj9MhI/6bzJAYWa6JSR5p9bfwrCnyOSI7KeMiljIw+cUgXcad8TLLFYEIB+qD1CyPjDiSscHHrAKlY5MB8TNIkOICbqlXSbmXW2b06/1Cxt7EFXgdSHRkQV7JRJQ7Oe8jYiFgvJ5a23LFMzPFq1UMyreq8GtBAE4giIJPmWejuFCLlvJm/pAH7D/ZgSm2b5KbI9qu2khJv77ew1twQrwmgw+sg6pmSFXa6+zsslDdVKfLzSvou/IQphPGef20QiYuvlnG6Dm2UGuOUYZV9F5ZBSZJM9F+fBtm8nIphNeOyY8T0ua4Jononu79c9lZy2MhuuyHx9eqGXX6rjNJjuXdwha38sQ6sziAauw8f2fErymF7jLTZ/DN2Tm1BVfH5EIVz8jbz5TtFJAOAMbeIBG7GYOu22sfzTt3ZyjMfqz55uJrH/Ni+yxJabkoq2D5OOXGffggiNViwj6B5CA3GbeOQncA0O1pJT9YGlfEomR7yB6J2BTvm0PtMjsLKS82KxAsqPIoTfvyc7Xy/HiHJgU2JNxJpoQSJqCFVzwn27/S4J3+uzRBcvJxVsXetx/wtThdj+iaDh4KmT7Xgujd+1pPupVmhQZfi9v2wMX77SbOp9ncUWtlsYVdzTpEvkyn0qZydbZiW+enri0chk+c4YtUV5rl4SE+0ltcJkCY8PybI8MijahlgpNzCuUQirTYs9co5wCmfkqfMiz13ZCL1UNYnWtSGsJazW0wo/6A6c541krhEIsYcVInCdOrKFEKpJ0u6IHlovshz1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(186003)(16526019)(2616005)(41300700001)(426003)(336012)(83380400001)(1076003)(26005)(6666004)(7696005)(36860700001)(47076005)(478600001)(40460700003)(54906003)(4326008)(81166007)(356005)(82740400003)(70206006)(70586007)(6916009)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(15650500001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 12:01:20.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490d99e5-3883-4652-1ed5-08db610594e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

[ Upstream commit 3bf8c6307bad5c0cc09cde982e146d847859b651 ]

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
(cherry picked from commit 3bf8c6307bad5c0cc09cde982e146d847859b651)
---
 drivers/cpufreq/amd-pstate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8dd46fad151e..497bde9cb213 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -457,12 +457,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
@@ -479,6 +481,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	target_freq = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = target_freq;
+
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 	cpufreq_cpu_put(policy);
 }
-- 
2.34.1

