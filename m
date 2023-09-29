Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECA47B3328
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjI2NOl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjI2NOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:14:40 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F216E7
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:14:39 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38TCQ2AT004913;
        Fri, 29 Sep 2023 06:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=0whZthOOdEyVuZszguYxuW8MWLTGRNjKjLhlNS/VeCI=; b=
        USpBRCBOVpgE7AZodxI0O0ZvwCFr+A9pLGgqEUJ+0c6lZiyyeB1/p13iBAE1WQYQ
        8jNXDdeoVSKtX0VXY9wRgM7BJiPBgT+DXK6VgZJg6RVKbsl4OkREq28kn4Pna/Bc
        TdMKb0ddvI5wujsdXVf04DDoTILUDwNqF34UJ39sMV+TmPAOVimCHX/Rdp6fTBUY
        hniG+FiXQ8TR2XRxvXtNEFTlVUONSQ0+A1CZar6UFQDxE1vc69h4iS4AVW/c9HnY
        PgCgqMXpmgY1GXkubBd8OV0jRM8JyOjsHer7F32VGC0BRKOsvlO8kCh2uoeOBMI3
        dEJkvxhwPR/Gp58LiinOwA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9yhgnw8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghFPZlKbBigWRRh/yQ5SS5otuz0jsuAn1NyfBVSN1JNcnVkgdDyZugD1pqcw4p0eyxnWeuHPB1+22ubnrqY5/RWGtBEwweFiZoq8ljwRbvzAePqVsut9whqqVWZyK4Q8bJSVXvCBt/ILhi1G4rg/m7tLSsT+sE3A42HPXMi/QNv0GqZxbFYio/hNPXfroTXASPkY6/ZSlYGfJds6lEkMxkGAkW9IcRQdsErsZ1iZVOV5uPK4k6y/ggbL+McGtAdGPf6bVFl6/ib7wv9DCv9OxRMVyfryKy1iTca1qG8NjQnsaMANXFU9TKAsFvTQlQEFlI1A6KMY7SFfmCbJmqKFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0whZthOOdEyVuZszguYxuW8MWLTGRNjKjLhlNS/VeCI=;
 b=L7bBQD7c3GxqKvU7A1RU7gj9GiCEaUDlQZX4eMGeeAsTk1v9OBS+JuUdvYt6XZh/uBTcd6vgXMl9gpPRnkanSek5ce8WRGEehcIcTbDgFEry5O0FmULPTNW5LWoWfmfcz/Sm+nHmxI18GCN8E2vNPctJgtygUyBb1jzO7nWW+Efav1/ATYkdFwQMcAXokeYTb2BIErmnw9Z/+kx92tUVcd4oOEHcBx4CcarS2+V14qGfRSIVji4m1FrPd0sMOfWLfOdfncv72Yy2Iwd50L/eMca/LNzILFmTgl6R5TwQxnWqZdPGzR39m87Q9IULxMWC3tyaUJe3G8jxBNAI3Dam5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 13:13:57 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:13:57 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     qyousef@layalina.io, Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 4/4] cgroup: Fix suspicious rcu_dereference_check() usage warning
Date:   Fri, 29 Sep 2023 16:14:18 +0300
Message-Id: <20230929131418.821640-5-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 672e73d1-78ad-42c1-9fa1-08dbc0edeff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INJsX5wI5IXIdvdqog5j19K2BWN+OglGzFYesGNrleSmqHwP5VYzNRSx13VyBhCutqwc+ZeGexOfXNCG+L09K654SkKGfbFApt8/TgNQyN48661U6FgXgzeUcmIPHC2/NRynPu+t1krVfl34F3/W8HRu1Fgp2+aDnlxJyEbKQEJQQ5mK9dzNSC5ZCeKBW84nKzkOeYKfDfVmY3EDLGtuUz2hKuBdV14Nmnyb1pgz1MXJ+kKzJDVilYxRYACdV/7Z5MhQHsLC8o/Q2e58q25BA9rREDcbEArAeqATLgxRFqYFk5uztqxL9EYnUzKNc+Cq48a2IFyjhV0kRQJSs9oeN/YIsg3aeduUbLgIo9buuCahuFH0Dp0mx5J12F201jL+GJTHv+2C6E1Ss4uMq2XJppSdRKn7kHC0WyC5yeQyBA90QDleJq6/TPpwpYVGoVgQehw0qqWgG3/qK7xs3y3mcRxBFEH94/rG5BvuexVOEIJGXkwqNXodCHH8RX+9Szw5wr3TcHuYBUxFs3JSde1tKL+LdYftyLkbB8MxLQcoBKKHlekMymxaGJ8FhAY0xxXfkVK2Is8jqw61aeFxhyQCAuzvd/lHIAbG+HL+3WDhq/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(2906002)(6506007)(52116002)(6666004)(2616005)(38350700002)(38100700002)(107886003)(478600001)(54906003)(66476007)(66946007)(6512007)(1076003)(86362001)(6486002)(6916009)(966005)(83380400001)(26005)(66556008)(5660300002)(36756003)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PuBsepFvQJNV9uEMcDNe+YUWAYD3PKaETOZoFt5QA5YIRAN4ULhK3lNoF+kL?=
 =?us-ascii?Q?ybOTosjf1+6m61FxiMq2uWZiAcTGOKLIe5ro2NZKlql2Bxzry6JUZ/gte3zj?=
 =?us-ascii?Q?zBOCmA7KVdbIW6PzfdEsCVGw3MTdiUVJdyXhFoTwZ7MIUVFAkyiwWk32TXz0?=
 =?us-ascii?Q?wyxiHYNfhAi1C+2J5ihW4ySHcNwY0CiDFSr10qH4qFP6Lc6d4gApTquksHuA?=
 =?us-ascii?Q?cj2VlC/wg89oiFqPzN0mI7denj2cG0M8J/9erQXKjrgA2GdA+5+t2Z1sGBhq?=
 =?us-ascii?Q?6pRlAGc7eP6jRv72VCERLLfWfoO4Vj2Dr7uWeCOQdVzURilDYugnw0QQeUa/?=
 =?us-ascii?Q?EtSvKGka8GBj/cFi259JRuCGBq7cHlbz53eVePPR9YHeUClsxUIu5M5SdD3g?=
 =?us-ascii?Q?ZPb0iiR36qorSKGea8lrGg1K6RKVXk/HJsbiYT6Pn9AUU/J7YYwOlwCZU2Ct?=
 =?us-ascii?Q?f26tXW7PWz/JO0lTWrEngqHO71MMMBWveLGtYj4Cj+kuBcZrdrChpQOIHrv+?=
 =?us-ascii?Q?IwEdJqJ0jBaU/CAwTgPcQMRZTC53k59TOkASv9d95NtayQIX3G2R+yEF2OMC?=
 =?us-ascii?Q?vOUllpxOwRxfp+nHpff+UGmtKXU8C+Kb8hr/d4dmjv6FDbz/EyMOATj1AcYb?=
 =?us-ascii?Q?u0fi6NodKMwcoPti15xwTC3euYgFereknu1YzzVU575sy1yWbIEIZVoaNz5B?=
 =?us-ascii?Q?P+fe2bVoaw3iImK7fktDuZa1rJDE3grzDQaakZcGqp5EKvOrIJQ3Sa/2dHz8?=
 =?us-ascii?Q?3xeOLlemiv16MA5EB4iGrUSwgJPgzfF54sPgR7ttKKZHBd7G5RLzra4MSQHc?=
 =?us-ascii?Q?1okM1tf6NHtFOfkzt/jcUbt94UKyqKqJFraDUQ+PhHlaRuuj170qYNCL44Rw?=
 =?us-ascii?Q?41T1MQ2yRKOgmK+5z1xPP7YW4hwVD3fmgw/t7Qnvv7TztpES6ljO/o8FC9Rc?=
 =?us-ascii?Q?3wBz4in9o8oMqXE5VYW0jqMNSeqpRbhqlDXEjHANiMd2FmFsKqLhzsyB8syi?=
 =?us-ascii?Q?39F1QqumX/KN25KiMtBKkOpTOEZqVvotkub3zPbBSx2J7f0DTsS2VgmPh1qo?=
 =?us-ascii?Q?aCZZA4Jc0WhSbK2uq1JWsQaSR1+N5LcHivVwkYzndt/p/49i40gCH3birRYW?=
 =?us-ascii?Q?GiB1luW4rI0kZJFm4a/hXXZnZ+D5jlVLtwQrweUvyT9wC9fBxUsZM/6KebQ+?=
 =?us-ascii?Q?m/03S30wHsyLwEg/5YPXY3UkHUatEaf1IlVGluV5I8lOIYRelU4Z6N+p3pVt?=
 =?us-ascii?Q?EQztORPybhmhivHW5kfKhy3/7qmX8Y3rogbU1m+CkjEv6uBQowKDDBhEfh1z?=
 =?us-ascii?Q?bvMRu2ZXdp4BIJzGvyjyzgTICBYHgrLMUp8SWEtcHSTN9reKhBcqCsfDTs+b?=
 =?us-ascii?Q?jobRDDjIRIatpyAKufs2WX6DkAsoXJUqZmlxKQhbaB8/PYOHlT1oIcDs37TE?=
 =?us-ascii?Q?MDO0E1GwgcmMFnKxZ8HviaKdd3rqYViIEmjLbTHWyPs2VWbYagIlpYbttbEL?=
 =?us-ascii?Q?9pm6yZQm2YE57Ow+qRaupgXV26eNlFg3jD0q8aVzYZrMFgAezyaU18ynnw/w?=
 =?us-ascii?Q?D2KvLWySNTwfmhCCJbuJ/RUqWUMb16T9Am2tZ3UYWZXsYDRHl9T6CcWIiUYz?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672e73d1-78ad-42c1-9fa1-08dbc0edeff3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:13:57.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiAqpFydyBEGisyn3QJzcaPT6t6WlChrCpVzhobGACNHzLRM/JbwIkuM6CXyQa+eBIbjQOxYOHN8LjvUwfqrLkpGqXkojGwMbgDXDMwkBqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-Proofpoint-GUID: SwBiD1s1aaIIAqsS0R_FCKA-NCjXc-23
X-Proofpoint-ORIG-GUID: SwBiD1s1aaIIAqsS0R_FCKA-NCjXc-23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=636 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
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

commit f2aa197e4794bf4c2c0c9570684f86e6fa103e8b upstream.

task_css_set_check() will use rcu_dereference_check() to check for
rcu_read_lock_held() on the read-side, which is not true after commit
dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
commit drop explicit rcu_read_lock(), change to RCU-sched read-side
critical section. So fix the RCU warning by adding check for
rcu_read_lock_sched_held().

Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20220305034103.57123-1-zhouchengming@bytedance.com
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 include/linux/cgroup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7653f5418950..c9c430712d47 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -451,6 +451,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
-- 
2.31.1

