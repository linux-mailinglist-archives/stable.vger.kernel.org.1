Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA67B3325
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjI2NOQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2NOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:14:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F8E7
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:14:13 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38T9gils029796;
        Fri, 29 Sep 2023 06:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=0+8mFzuG3OtPtyejp6AZ/jOzJlsPTqMXWwKE46fB21U=; b=
        SpDCJy3qUtAYp4DveF6aKfGdFdYYrE3sJMe+umVVqm3q7OvrvCDTQUD2DsivQoft
        Wz89CjEbj06gLIla1htqa783yljF+QRGKvFtJiKcWxnnZvV3QakvgIDbQ1fd3EeX
        /cQhpyor3xx9rumHVeIS92ea1hZPM+TauS4v90yo5Y6LlN5HR/glfzFRPk5ZyzOC
        PcXv6r/qnuYlpW4UQ6WMCuBok4T3LUVZvgZeQ9It9VfArdvnGSlSQknAN06vIz0B
        T+NJ8EQAs0RZFdTuuKW/KedA1/aaLEqW8gPzR/pbvjRoLeFogMUvBTJ+PyEDGwTf
        diFKqaLXM9nZgUgi9GTXSQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9yhgnw8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFLU+RjfCVRfUj1h/vvPZl6e0hu3N+/PyiLyZoWdTR1v594izku9yik/n9sNvLPIv8j7l5pGg91e0QpxewvhnYq9CfqCmnsOUGpB8e7PzbbTB/YmtU42cIJ6nHpoa8bOMd0oQyyPAx2UuIYMjch6favmNrqObfp0+UkgbYqNeCvyxFsH9f6FMATOkwwJMUUSF53/wAxrWSMRC0AdJ5kg71IeUOpw4Uqg0HwkUXNwyQmsEpUWUlJCdo/X/ECsA7Zdfo0RGydWUN+WZqf935ttzUruLeggPVzZyhEPKCMgX4lOSBCes5WoM+1ROneb9imMbs2kK9MbY4KP/oCwWIAfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+8mFzuG3OtPtyejp6AZ/jOzJlsPTqMXWwKE46fB21U=;
 b=ajTrvEEh8w3FlFsUbPyQXDOCjtNyVXoroQX6BNAC0sF5Ks0vuAD87HvnKpIu9O87XEeHkP5De7iEdCElyxbETl32uL+ZxjrU6BA+0QQTT55l+XCt8OLLHE4MrQKCDPKsxr5JGksLTCwjYGV2APUqWN5u8XK7tgjYp2Ys5BxCl66ViNlSg7vadWQPq6/GArUlvfFctO28RgITzpY5hoeMNuyIG91jnuyJt21xWip5Wai30oHaSNAF/eHhRp06q9zLZHLA94Mga3ujxainyuqVFe2GtJtkbp93eO9EtetBBkik4mP4WhOnCcYu3s+bDT7EpAGm5CkKrG6ocG/81meYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 13:13:51 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:13:51 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     qyousef@layalina.io, Andrey Ryabinin <arbn@yandex-team.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 1/4] sched/cpuacct: Fix user/system in shown cpuacct.usage*
Date:   Fri, 29 Sep 2023 16:14:15 +0300
Message-Id: <20230929131418.821640-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929131418.821640-1-ovidiu.panait@windriver.com>
References: <20230929131418.821640-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|DM8PR11MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbeaef9-ef48-44d5-41f3-08dbc0edec60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4sRdKTkSfoD36eIgxuvdAli6lFkcc+IebVcZlkHv4Ty/hN+x7Scdd5jtbriQpNv3+YLwIuRz+5Cjn/dX3iVZZNHlVJ54hb/fmKHuWdMtL5pGfa9nZLUj2mXqiBUrZn9M4s6nc1F8Z1Pqz5G8fEvxeGXEqw7d4z/2Ml/yhZm3KpMXnpVkoxj+bZLz7d1JzgtnQwBfwjgLdhQ+3YMcWQTPdLz81oEDSVCoByyJdJjs6D+f3pMiwaAfzelATdveE7+HjesznKAdJ8bHI+Ui8/ypUMvR49/+jPUetos75gZAsqWf/5EcKZSnIc6njkYyqlcFgyRNG8BZTMO11R4fRvUK5jslC1bTvWCXNLmxOHGqmm5SijuY7W7ZpTxu08UeqHoPs4XGRRrRL3TzPa1B1F8XyQVeVMpjeA0WsBbPHnetwzLrBP5UTqVMtBILkKrhO82qtvffqlMAjF+eHDuHlDt9P+nDfAtHagzszZnHEJylybNg0T1zvU+W6oohNhfmi04A9TmpAtfDkyj50O3RX9j0Th8EvvETRqnC9qLZZQkO0vOEzJeKJKmwmMhHmLQ3xrgNKuCQQNqIjgGxjSNw0Yhqhvi2oSLG+DgFmc7Qw3MPdzK5IQO6idksuL2MMR34KFPVAdAIjHiwksBKeKZf+LJNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(2906002)(6506007)(52116002)(6666004)(2616005)(38350700002)(38100700002)(107886003)(478600001)(54906003)(66476007)(66946007)(6512007)(1076003)(86362001)(6486002)(6916009)(966005)(83380400001)(26005)(66556008)(5660300002)(36756003)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OR8sgigIoqc+WqVU/XId6UXaHd3miE08pIP7ZWn6L957BX1//bf4I/1Stcgo?=
 =?us-ascii?Q?ugZhg+/jnN3lPZWfJkoFQKbn5NmIqy2Rq0bhfq9X1tEnhUBJuu6C4g+/FLZw?=
 =?us-ascii?Q?7iiYrF+jTJP7AdisPI21rAJxUBfOKM3ZTmTwXZkqAxmS+E6cSc+onTnzTAKj?=
 =?us-ascii?Q?aq2Z62tXsjVwgPsGnER+/xvL/c/9OGuXI372lz201K1EBQYQ4zmiZt7CHoke?=
 =?us-ascii?Q?HigjvX0Lbf8qDYtfEyQ++5MytSpV7YzD6wAznBHswj/M9/h6k4B64FO65bbg?=
 =?us-ascii?Q?Ht+A8Fq4t6VSqTAxmts1uit0KOm1hKYEoevV/wS7KUiL7DuJxBRQl4RFdPFZ?=
 =?us-ascii?Q?5Uzgq8KFUacdGuoTvF8GsVy9j5KaA7+KThA74/FohXZh46V90u3mjg1p3Abj?=
 =?us-ascii?Q?0J0kbym94ChOOiDxjc7YUfN+DLPLVEspWNHqIl7+a0rBDiDlIS/mQf+DNQ0x?=
 =?us-ascii?Q?CEhjVoiNB83n8wOWFS066x1pc7ZDKZlYze4R8GmZbIzYr7yns+8KbST8Zl5N?=
 =?us-ascii?Q?w/GzeObFbrQ7ZLY8qV6soM3tyTHe+9UIpQQ1JdWsfulKpM7gci/yxYhqMdrp?=
 =?us-ascii?Q?EUJjA3lAVFwXVndEPbesJEduG2HiMtkcu1Wae0hlRuAAlrQ444l7uWEr7+MC?=
 =?us-ascii?Q?7sDCGHtQDnu7fq8/HMwKnvGZdT0XlE95Wm6rpw76IYi2rZ1xGJFrgNpqrZrv?=
 =?us-ascii?Q?p7+sQLzHQQ8gCsPoebXiANrmlGUWBD1/L2vmlkdHFm3XOA1K00MXb/lDyMrN?=
 =?us-ascii?Q?nfYA5NndXLfPPu6/FsPfpmfsTDVsagSOliRiJnNImq69Z10V0liBSuCovQLa?=
 =?us-ascii?Q?KCP3PMgOYYCNeVrawUK+ceEqwmWJBAaVroWQAMPinDJP1kByefp9Bu6t+oxN?=
 =?us-ascii?Q?H7DYGw0ZgnaTWYKPDYewmeIJshexbLFSxbd0U5xHe/3Ozt22DjZ0yHY+8vAx?=
 =?us-ascii?Q?6F3co8j64hqMGCXqgK9ImG3sgiUCJ+4bqB57NaD/L3/hgBMrdk5TfwKjVB4s?=
 =?us-ascii?Q?2lJ+Wm5goL4vYRGXO+QATDEarAQrUpYgIglDKxd2WcStsCzLq6pAZhz2FHOL?=
 =?us-ascii?Q?Yap32NzLfxUf1ehDF5esxz5pTNEfvDXbf64M8+9hN8Hlb/iA8c0Y32Zojh5v?=
 =?us-ascii?Q?bGL9wmSEBC1Ts2gxuu/ux67wc5LGGkjMCm5Qb5eKFTdt3f9S16H7ZndbBnSC?=
 =?us-ascii?Q?yC2G631Ei195yEcuwJhlNNTvRjgIM3iu5qL59MeEo+bhXLtVPbl4p1/Vtk81?=
 =?us-ascii?Q?V3s1rtMUn/LMZbe43eRvoQ3szCmtRvjEWcHGxKTMHUtLg6CsHbveoFVPunqO?=
 =?us-ascii?Q?Gh3XczinNe6HoUbY/b8NkmTYlqUSPfOz3DlZWHsHWt96mhTtAB192nVsVVWY?=
 =?us-ascii?Q?8zuRYT7JtLADHNDQCBOHQx7KLhKdaKlltjSJLB9Y3y3ZFkvmr0K/YEJiLyW7?=
 =?us-ascii?Q?Fi1YRsc0HUO/r2IhcUbcH1B4ezjQh+wuQp0A/jqd5d1ggB38WxZeDBHajfyg?=
 =?us-ascii?Q?Lo4kRPx/PXLLgw/MkBnwuz3yVlgj5SnzVJnOSyOABozo8Men3Hycvj0LYox2?=
 =?us-ascii?Q?xQpWQIVTU6cBtCBWVjrMbzjgUiHv3w7/xMnT6MgPflkvhsEv/qFx1yfcf/Tc?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbeaef9-ef48-44d5-41f3-08dbc0edec60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:13:51.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAMYIIVqcFu2pEFcvw85MTP0OM9Eq0PocgYFOp/m8XpewVQ/G4VIChQf1THSUOg+t1SNAlnkG1G5DqUm9q9HqqiP/c0+hZJ3ubueya73bRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-Proofpoint-GUID: sjfC4g6crw06ZO8s2opT4iVK4w9vF96f
X-Proofpoint-ORIG-GUID: sjfC4g6crw06ZO8s2opT4iVK4w9vF96f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2309290113
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrey Ryabinin <arbn@yandex-team.com>

commit dd02d4234c9a2214a81c57a16484304a1a51872a upstream.

cpuacct has 2 different ways of accounting and showing user
and system times.

The first one uses cpuacct_account_field() to account times
and cpuacct.stat file to expose them. And this one seems to work ok.

The second one is uses cpuacct_charge() function for accounting and
set of cpuacct.usage* files to show times. Despite some attempts to
fix it in the past it still doesn't work. Sometimes while running KVM
guest the cpuacct_charge() accounts most of the guest time as
system time. This doesn't match with user&system times shown in
cpuacct.stat or proc/<pid>/stat.

Demonstration:
 # git clone https://github.com/aryabinin/kvmsample
 # make
 # mkdir /sys/fs/cgroup/cpuacct/test
 # echo $$ > /sys/fs/cgroup/cpuacct/test/tasks
 # ./kvmsample &
 # for i in {1..5}; do cat /sys/fs/cgroup/cpuacct/test/cpuacct.usage_sys; sleep 1; done
 1976535645
 2979839428
 3979832704
 4983603153
 5983604157

Use cpustats accounted in cpuacct_account_field() as the source
of user/sys times for cpuacct.usage* files. Make cpuacct_charge()
to account only summary execution time.

Fixes: d740037fac70 ("sched/cpuacct: Split usage accounting into user_usage and sys_usage")
Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20211115164607.23784-3-arbn@yandex-team.com
[OP: adjusted context for v5.10]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 kernel/sched/cpuacct.c | 79 +++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28cf9738..8a260115a137 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -21,15 +21,11 @@ static const char * const cpuacct_stat_desc[] = {
 	[CPUACCT_STAT_SYSTEM] = "system",
 };
 
-struct cpuacct_usage {
-	u64	usages[CPUACCT_STAT_NSTATS];
-};
-
 /* track CPU usage of a group of tasks and its child groups */
 struct cpuacct {
 	struct cgroup_subsys_state	css;
 	/* cpuusage holds pointer to a u64-type object on every CPU */
-	struct cpuacct_usage __percpu	*cpuusage;
+	u64 __percpu	*cpuusage;
 	struct kernel_cpustat __percpu	*cpustat;
 };
 
@@ -49,7 +45,7 @@ static inline struct cpuacct *parent_ca(struct cpuacct *ca)
 	return css_ca(ca->css.parent);
 }
 
-static DEFINE_PER_CPU(struct cpuacct_usage, root_cpuacct_cpuusage);
+static DEFINE_PER_CPU(u64, root_cpuacct_cpuusage);
 static struct cpuacct root_cpuacct = {
 	.cpustat	= &kernel_cpustat,
 	.cpuusage	= &root_cpuacct_cpuusage,
@@ -68,7 +64,7 @@ cpuacct_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!ca)
 		goto out;
 
-	ca->cpuusage = alloc_percpu(struct cpuacct_usage);
+	ca->cpuusage = alloc_percpu(u64);
 	if (!ca->cpuusage)
 		goto out_free_ca;
 
@@ -99,7 +95,8 @@ static void cpuacct_css_free(struct cgroup_subsys_state *css)
 static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 				 enum cpuacct_stat_index index)
 {
-	struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
 	u64 data;
 
 	/*
@@ -115,14 +112,17 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
 #endif
 
-	if (index == CPUACCT_STAT_NSTATS) {
-		int i = 0;
-
-		data = 0;
-		for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
-			data += cpuusage->usages[i];
-	} else {
-		data = cpuusage->usages[index];
+	switch (index) {
+	case CPUACCT_STAT_USER:
+		data = cpustat[CPUTIME_USER] + cpustat[CPUTIME_NICE];
+		break;
+	case CPUACCT_STAT_SYSTEM:
+		data = cpustat[CPUTIME_SYSTEM] + cpustat[CPUTIME_IRQ] +
+			cpustat[CPUTIME_SOFTIRQ];
+		break;
+	case CPUACCT_STAT_NSTATS:
+		data = *cpuusage;
+		break;
 	}
 
 #ifndef CONFIG_64BIT
@@ -132,10 +132,14 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	return data;
 }
 
-static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
+static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu)
 {
-	struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
-	int i;
+	u64 *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
+
+	/* Don't allow to reset global kernel_cpustat */
+	if (ca == &root_cpuacct)
+		return;
 
 #ifndef CONFIG_64BIT
 	/*
@@ -143,9 +147,10 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	 */
 	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
 #endif
-
-	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
-		cpuusage->usages[i] = val;
+	*cpuusage = 0;
+	cpustat[CPUTIME_USER] = cpustat[CPUTIME_NICE] = 0;
+	cpustat[CPUTIME_SYSTEM] = cpustat[CPUTIME_IRQ] = 0;
+	cpustat[CPUTIME_SOFTIRQ] = 0;
 
 #ifndef CONFIG_64BIT
 	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
@@ -196,7 +201,7 @@ static int cpuusage_write(struct cgroup_subsys_state *css, struct cftype *cft,
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu)
-		cpuacct_cpuusage_write(ca, cpu, 0);
+		cpuacct_cpuusage_write(ca, cpu);
 
 	return 0;
 }
@@ -243,25 +248,10 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 	seq_puts(m, "\n");
 
 	for_each_possible_cpu(cpu) {
-		struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
-
 		seq_printf(m, "%d", cpu);
-
-		for (index = 0; index < CPUACCT_STAT_NSTATS; index++) {
-#ifndef CONFIG_64BIT
-			/*
-			 * Take rq->lock to make 64-bit read safe on 32-bit
-			 * platforms.
-			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
-#endif
-
-			seq_printf(m, " %llu", cpuusage->usages[index]);
-
-#ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
-#endif
-		}
+		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
+			seq_printf(m, " %llu",
+				   cpuacct_cpuusage_read(ca, cpu, index));
 		seq_puts(m, "\n");
 	}
 	return 0;
@@ -339,16 +329,11 @@ static struct cftype files[] = {
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
-	int index = CPUACCT_STAT_SYSTEM;
-	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
-
-	if (regs && user_mode(regs))
-		index = CPUACCT_STAT_USER;
 
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(ca->cpuusage->usages[index], cputime);
+		__this_cpu_add(*ca->cpuusage, cputime);
 
 	rcu_read_unlock();
 }
-- 
2.31.1

