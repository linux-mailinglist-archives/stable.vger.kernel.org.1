Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFA715E3C
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjE3L7f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjE3L7e (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:59:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7669090
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMoQ5DHH9cUFmutse1sA3Td2rAnv3WBAbXoSMqZzgXl3eTvVvQRDGqAA3aWAM+TFsmDuntQvXJHyu91YEhKyHjGRdfd5oDIn/w95q/cwE1ME4rUh01oftUKwBayFvBsP7WHX1B8ofokZlfNahHi+qi0IOp/JnDp4W6CpvMtBbfqHDJnQfr7N40/mLguAHrVf1/e96h2icjV8ZDsvnOKj7fWUHt+m4F7m75GlSdga1JxISn9HJZgYPkZymXD9pq7i4vz5V/aEizsmQ0Z5acM2cT2IuPj/zS7pN52LR/eV5cQo5iaBIIfJsmaVgeQ/p4VfFkAvkZlVyi5HfuiyT2J9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb1SmeI6bYfG+AEsZcxbp1RvuRWHk/vkE3lTk0qKh9c=;
 b=SO8z/42P0VjAfDtRckliw94CQ2faJdOA3bNP+9NYRHbeOeR3kqZXAS8CgtIAIbPBTvzP+tPPKNjeQyVjvdMys6APD+2uChfKzAVcYWKpGJfll1egbISNwj6DO42LsHOAd9xI3ly2BGQ5QClbBMeokuQFR6/X3MHgI+tRQGfHtLsPa00sCeXhm+hevCPTb9ocfojC4FeUmugRTOO0Nyg1tpZKDfpZ6Dqf2QjAqBfAkaAoIAyIEZWPNvr83SJ3NZn/boAEYjmOGdvp8nawWX0mD6Ljgn4/X8MvAccmg1yfcVWcd4ZraD7HPQswtbnoi2fp7sbuRCGgMcUhBc/ujfGCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb1SmeI6bYfG+AEsZcxbp1RvuRWHk/vkE3lTk0qKh9c=;
 b=nx7Hc5L8d3QcOIqFoJDLTLjjFhmLpFYzqpUNYt0lHtO7/nApxGKb0UInaWcsVBwZIld6fe9e9B0cG7Ku0+0Bqw2Jg3hHsWRXZ6k5vFOaDf5yNUmO0QPD3VdalLcqx8oPLDu+EZy2k952lu15KWiZgUziSXiyB30d+PGTbpA42hA=
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:58:53 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 11:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 11:58:52 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 06:58:51 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <stable@vger.kernel.org>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.1.y] cpufreq: amd-pstate: Update policy->cur in amd_pstate_adjust_perf()
Date:   Tue, 30 May 2023 11:58:32 +0000
Message-ID: <20230530115832.3821-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023052835-scoring-scary-c0c6@gregkh>
References: <2023052835-scoring-scary-c0c6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caafa28-1cf5-4771-3d2c-08db61053d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nh/tgYWHnxzg5/j8r/o+vokK3PC/vWqLJU6IQii/M2o8TtmOIL8HT5XZfy1A37oMCWy0QjLcL+iUKEjtF4xqBUjMaLKhbVMCjwMs8xi1PLX1P9xvASUaBZ5k52L7TpLhjOhiK8IP6cnwC+GlNWywDsUKDNOY7XBqYvmO29SLv72IjW34AeefMni8uwTz4KS9MdLBlouDZ9ICFeg8kxtCn4+AE3QRQuPwG3JdS+6WzDptH8gpC9KfyadptErMGw1rCRrs/dHwpN4TU/N4co4dGqxaZp4ho1Yj715P4nfPpnhrkEyV6HEAyE/M6RAERXo/PhOxIH2FrW5XFpot+iQHqi582MHq+Q3zdjz0IOpw6TYVnbNN6nAwN54LQ2+eAktP8afg6YFpUbxnWghCpz1zr+1qRHkm6rQYdvrBTM3C8u31405USrxKFJxINYEtL8SK9Z4TUS4N1Bt/Mx8TiAX5Zx3ggcXwWNw3Zka32zVuJpE4uVBpUyUYcqG54dltYNoppEEHQSirW1+aqSNPHgxUR5g1wLHXClF3DajknJWFrOUk2LFMQD3iK2SLScFuNM/VAmXoO9kddFukdJgL0qYvpugJXWo1X4sa2qoLic9frlZBRc/O6vb4fWCThTl5vtFP69tLzVuc4Iir2Zi03b1fHjRA6aaLTQXNdTPIo3obKLumMXEZyyHIhR1AFB3Jrjc96ZtvM/2trA5aiMnXVFH+2fnt1zRB9502m+UAewH7g8tuKyBmjvTpGoa/dsYtDJUkCAr86iPdS9XejgP7fLipg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(478600001)(40460700003)(8936002)(8676002)(44832011)(5660300002)(15650500001)(36756003)(2906002)(86362001)(82310400005)(70586007)(70206006)(82740400003)(4326008)(6916009)(81166007)(356005)(316002)(40480700001)(41300700001)(2616005)(426003)(336012)(16526019)(186003)(26005)(1076003)(47076005)(7696005)(6666004)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:58:52.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caafa28-1cf5-4771-3d2c-08db61053d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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
index c17bd845f5fc..cd9d9ab75684 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -284,12 +284,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
@@ -306,6 +308,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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

