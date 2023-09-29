Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF997B3327
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjI2NOZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjI2NOY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:14:24 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07D1AB
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:14:21 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38T9gilt029796;
        Fri, 29 Sep 2023 06:13:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=4T7KQ+6e1sOE9p85GTWeuhBDCit2hiPoxLcYeoregYE=; b=
        GjKZPTuwW8ehWvwYlNnJkVWvFxQEF+jpKRLDGVANl4iryLvJnsKWxaqznQIndTwb
        MbYT/PuiKwz8rS4iJOCRrnFDiaHzrxUN/nL9gi8900CLiHpENTDipDrI42a+zPxN
        pgn8rp9Lp1OamaxykvIVop8dl8fLFQ3P8KDBpINsWuI+1EayJzYK5eZrQtYfIWdn
        fbrAAkrXwehussrq4DyFweTk2dIrYtej2XJvVm/3+sEn4Regp8V4blswf4KHBr5v
        csPaIz1/WBCpw0XnmRvNV2a5DA6mfe2vJpZA91Fx26HkNDEL0FP8SKyyJiSj81dk
        fEb3Icyfi/rIamWipm+VVA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9yhgnw8t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZkBdjcgBCTbhO7Y8wdsuhDjWimt2usozJfuYtP+VV0QViiqvrsspeaQCu7f0emL21dYHhhBsZsB4sXbpu2U9QYkI6IWE3qzHyy/t361fJjaMIuPWgFcPL67eGWBIik460OxrSv5lLZqZS072HeAgT2hFssBK5TnC70T+OmlbvJhuFxrUXaotSt1kuDW/LImqim1lqxJG24PO+xw7hgydosDsKYn6sVe0l3ht2W+pLfkvR3KwksZXYdZvaJqR2+DAOdxY6hUPW9V+YEyKt/m0Hr3ZKKr3jswLttZcbRBkrSqxM9QNcGh0Dqfn64N14PrMxfNEY1tnWHIIaju1MpzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T7KQ+6e1sOE9p85GTWeuhBDCit2hiPoxLcYeoregYE=;
 b=dJXu8rUfznTf5fJHVHGFvyj51In/5CGjW3saR/xfgPj3XNg4/xVeELyVMCSHChCbEZkOEYFL2S9xhPUX+ZvjEasbRsH6FNFoVGEYg1oiZcPDkYkIQh2JsQIGcPvTxb+OXFe140QF5yoHpitngbatm69nB0VlGhj+01bkVoTX8vpXo70Nzf0aKYK2sxTt3oAWKiyEIG7OzLrYDVJuaHFRucjWdCSq4UGkBHtabti5/Bex66a5n6ijHZ96+YkX+SHkVO5ZFYP3bJn6T36ZskD+XvEJXEVU5m33890HgXAp0RKczQYanlc9aNRzdKGj+Il8L4GfqkKp4H4nXroJMTkZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 13:13:53 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:13:52 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     qyousef@layalina.io, Chengming Zhou <zhouchengming@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 2/4] sched/cpuacct: Fix charge percpu cpuusage
Date:   Fri, 29 Sep 2023 16:14:16 +0300
Message-Id: <20230929131418.821640-3-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8748bcac-f9ee-4529-d7b9-08dbc0eded87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP41TX7nHlxzxqeRjatlZ96q/YZBhWrTIvw91SEC3BqRwa1LAFWhr2ONySF9boZ2aegXwn/bN2kNOf1OVi1gA9Q8WXRHyVa0a1GWJsEdRWsy4JemkfkvQm/pq19rJ6jYkF/N+Fsc1VztIr8hmuv5p0x1U+1dsr9CJlWIFqNWwlB4rmpq1tGzzwFk4VeiW89Hzg7noCpH0bQFZATmg6tMzh8v06ZUh8nwMVdEhUyOPJvK80j7/ribU8SUCEppSN0bbVQCWr7hapEEqn4Ca0YXGH6MES3gqcAc7gcvRgOCPWdt1pTapdYwwBs8Y80weAOBzoVsA1zV0+wBgNBkf21V5gYdloF3JBC+p13ofNAk2JGc2/768ddnolCEM4tgckqNlM6fxSXaP5pw4+ieqV9Xxk2NV7IZT60ztEggBScRqxlqlxbb+BAnj6z/Q8LdVO1HAnj473xoT6//2ygmHT1pG409QO1F3zlMiBf0ZVFtH3x9lPGYwPVpZxWKCw5XJCktHCpp30dJ/DyynvkNAQdBMIDPnCRBAWCB8nqKpgxcJPqW46UA5S/+nhsFozbiyMh9ooVFXHtQSTDfip/9I0BQxGP56pdYrM6VUte8EiXwzhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(2906002)(6506007)(52116002)(6666004)(2616005)(38350700002)(38100700002)(107886003)(478600001)(54906003)(66476007)(66946007)(6512007)(1076003)(86362001)(6486002)(6916009)(966005)(83380400001)(26005)(66556008)(5660300002)(36756003)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oxCdDMhupaPZyE2pF+4Se+bvRsxwHlpUgHZOXNt5UFY+l7HcqFI2ozUWziWO?=
 =?us-ascii?Q?T6jXpftgelaAAr5S8NONdIlqdxy3xJeZkWIJVQJ9WKmcuCoDGSj1Ea9kU/Uq?=
 =?us-ascii?Q?8X4YeDOOrQ0H3VFR7qPlLHHCFj8sMTHJ+4APrB6M4RVQ0ioY3A/sYfk8ygAo?=
 =?us-ascii?Q?X3gwWQB8UBjjHwsiUXuhXlJC31DnWd1SU/qeKERR9aNe+1yt1GK4O2r4QaAy?=
 =?us-ascii?Q?1WCayaoW+iDeC7rNAI2tA/o3LIScmYj3daVOiMq04atBVCar7A7pZ+jFJcm2?=
 =?us-ascii?Q?X90Sb5j6TLpiJy5gj0LlQBaD0oWsnphA3FF0wfANUH5zsC1GjpS36Q7IocTp?=
 =?us-ascii?Q?uw0IBNNGqkjhZHVs1XEtCl3YbUIZzCOU/HL/klQZeR3TlSS5DzbJqS2JQjIg?=
 =?us-ascii?Q?XG4aLACqGZHTCOiD7+u3OJiCqy4ggOJ8XPtWk3xowXQObu1+4tfEHZ4HVDHh?=
 =?us-ascii?Q?6ajy14gzHXEbs/jOMIxehBHcWUBdO43jv1HQqOjnN9JKwMfmSKOyRaj82IJE?=
 =?us-ascii?Q?vY8vAq/R7JNS57Ff+NZ7HDx/UAmqIZtVzP9ksQrj2ZbHFeMJZu6jnS4RWqQO?=
 =?us-ascii?Q?oci13iuOpr87iehfk4MRQECiQOh5bm50OL+DwsfvMNl55qos2zBA3S32PxKK?=
 =?us-ascii?Q?MG+7KNEVKqtZuXUxwCBh+W3CzAmMhcs0Len8r4QgLMR0B87gH8CaNlfdhVbZ?=
 =?us-ascii?Q?JRYDDhrwYRUdert6CrGwQQ3QBA7TE77I/XgDQGv4H8tiwBXxyDwLeK47KAgQ?=
 =?us-ascii?Q?L9KV5x1b3qxBOh3Gti3dNk4jR3ptOXNfOFHpoCnmFtOO+WKB+/AQSuWfOndZ?=
 =?us-ascii?Q?T5YmJVmyXfdhQg2F+k56GgMewmmXB3NNbCPObmpkHY3yML6fpSz2Y+WvC1QM?=
 =?us-ascii?Q?ae6ApeB3ocrfNgPmKM+safCLI5mr/KCiYix+ax40tgNnT7bffX6MTkc97Y6U?=
 =?us-ascii?Q?bdJEFe6tU6SCFR+CWK3nd70HfYz1M2lJxq2oM1L8iNf1IEkmI92asv82VzD+?=
 =?us-ascii?Q?IEqETf9B8T3zeePfyi2CLjmtHJ8VvFqgr52fQ+jQGpdrI8tXgOX9XRlma39m?=
 =?us-ascii?Q?qBbFJpu0YQp4pqUQVvHFpRGPukcCyCPzeoL79rNw1BhW7q96XssTWkmm1JGL?=
 =?us-ascii?Q?RXBMqFCtwqqITmijlg+GtastfVWwWQ0KFTwunRVlpywONZMmI80WUQDTYjhO?=
 =?us-ascii?Q?Kb1OgsUuhNmO/8UqVbSUjqzzPivf/AXPrL9YlnjI13VWycFmKLk6U/1+8W2g?=
 =?us-ascii?Q?w8cnifCO3LkInexSkhhFLanYzmnis9EAkApUKOVDmI3wmLFGOol2CLFjKPYk?=
 =?us-ascii?Q?XVhMsYV9XgtmUAd5Gd6s2bMewdVBxv4kmvczmh7IH0h5VMnh2aiklD7pituP?=
 =?us-ascii?Q?bM6a0nV1GEnXqHFPdSbe6c3Lf3K4ItQBgo/dJk6n8x08QOL24rz6mDBqx3bF?=
 =?us-ascii?Q?8vJ83h4heXPI5jkF+X/I1Z9DLWKnCd4z39PvSWZfr+gRSni5mR+adURpI8vx?=
 =?us-ascii?Q?1YS92PuEmn3IQYf2FFMG9A2hov1eqbAHXq8nEa+1UysWQ1Aw61BiDKPV+XR/?=
 =?us-ascii?Q?zDaTnOmkVrIp2MyvDRczBoIOVi/DpjulBM/eqJeL9kJMA/PZPPN3lV+n6lBD?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8748bcac-f9ee-4529-d7b9-08dbc0eded87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:13:52.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XDq1j6+TV6NRyrfBXjLj7T8gWks3AvV8Lv+ni9Gb4F2klMS/hJMBlKc+hwEW7aqMZx8gF/jiI8EEDB/XivJ4en2m/eXl/5cDoRk1Sb0PKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-Proofpoint-GUID: qlskkcandWLRZtMF5FV-G00L2HXqZYuP
X-Proofpoint-ORIG-GUID: qlskkcandWLRZtMF5FV-G00L2HXqZYuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=861 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
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

From: Chengming Zhou <zhouchengming@bytedance.com>

commit 248cc9993d1cc12b8e9ed716cc3fc09f6c3517dd upstream.

The cpuacct_account_field() is always called by the current task
itself, so it's ok to use __this_cpu_add() to charge the tick time.

But cpuacct_charge() maybe called by update_curr() in load_balance()
on a random CPU, different from the CPU on which the task is running.
So __this_cpu_add() will charge that cputime to a random incorrect CPU.

Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
Reported-by: Minye Zhu <zhuminye@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220220051426.5274-1-zhouchengming@bytedance.com
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 kernel/sched/cpuacct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 8a260115a137..3c59c541dd31 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -328,12 +328,13 @@ static struct cftype files[] = {
  */
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
+	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(*ca->cpuusage, cputime);
+		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
 
 	rcu_read_unlock();
 }
-- 
2.31.1

