Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4047B3348
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjI2NQS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjI2NQR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:16:17 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F011B6
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:16:15 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T4VQgK021736;
        Fri, 29 Sep 2023 06:15:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=kRmZdpANyJYyZPdhYzH05t0d47b8zQqYraGWkDxxXTo=; b=
        jESa6k4CrXiiPyRCQQhCaT10Ku7NoaRCMIBAzNwkFVz28R3mQeAFcOXxbAg1S6Ih
        MzgpAj9XF/RVxvSz94lRfdn2lE4ONinkgneq82BLUJO9YV+REaexKJiDS81ll8bW
        viRgtAAbwHOk2R57wlkw+YzHsghN8TNwN2fP5ls8pdvKX0WQkA2kWmlKWzcdvWoB
        nVVEh3ZEgeP7rRnyNE2WCyemL28uO+W0olQRNtm0qso6IlvAPb8yzcOoVbNQ4QpV
        8ypdCOdjhMHAphi/0OJMP6GyJuAtYAddfDL1CSLotSiQxpx7aygc3Z5mP1XgN7Th
        uIF5a8eoDvf/7fKmKyCUYA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9ua0p1q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Bp0P7S8vnmwIDBBLd+sFvddMpVZXi2+BXE3wKvXTHZJQJI/tGfOe3b/4FpBbI1Bi1W40hJdVs93EMupFyYPhmWt9694WL3hBB4ULwlEWu4kp1UiKlH1RDpLEeEjzYJUze+nAVlU6Tms9A68bJvP0ttWudSnIr3pTeVUH6n/eOiw/8IS1vm6VDtc07200t7CcfW0YukJG01q6UsMQGjB22B0AdzOTgBVJVDbWxv/H7MSWwaZu6OIh+tRGJreJtVm3YdGR0KI2G/8NHCvIsCpc/53Yu6huOE64QEWOrq7mKXd9ND728GWFe/MAWN9L2uAa6HQFXWdMcHivYXd13lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRmZdpANyJYyZPdhYzH05t0d47b8zQqYraGWkDxxXTo=;
 b=FvDAtP/9j2CEhNAZKQNxlR+INMBa89JT9C+DNdNNUyXAGLua2Z5hfNSPXGJkki1GoeHlSzJTEfiSLxt784wUtbtwYbtac9/TvsY8uL6iXfh0rsg6J6LWO1Zid9CAC2A73oWRZI5JUsg1duuNAgi8MygfEb5ewhj4Z2YBdMhCLV4GN+IONuiqeE9TQ4dqZTxMdf0P5E63hyvs65eUi3ubBkZeMaCXMCVXkBIx4pmd3Zn+2O/tjq+rjcAPlJDW0rcVxrKYIwfsnLua1eUZN33gfjtn7gOWSuBaeMs1dlv3qG7tM6wG3CJKxhvtLKsodbjInxbT0Yi02SQYf/Hzfv3GPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 13:15:38 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:15:37 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.15 2/2] cgroup: Fix suspicious rcu_dereference_check() usage warning
Date:   Fri, 29 Sep 2023 16:16:07 +0300
Message-Id: <20230929131607.821861-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929131607.821861-1-ovidiu.panait@windriver.com>
References: <20230929131607.821861-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d92dc8f-7788-4292-79a2-08dbc0ee2c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aILh6x7QlVXZWeGaGRGS9b7YVZRzEAsngg1k6c6JaEldU0P0U/oOFeMJ/LD02PpDZdtR/RoOuaue50D3/86Pvetx98EB7A+9YXBsu7UX4y4EljFHXoIsH5MLAmJbOidFX0cDF38atj4CPZVSfMt1BcF48l5Y5WOacyRHeahEtLsrgFiNssnY7aZw7G6m7aRnGu9YD48D754IP1RojrP4EuD4bgqxtRmz6E8lJLGi1aQN4ALBVvPwhPcMn+VcHLdwMw7iR1iuVg0lx8hpMXnK+7JZHSnIJY2iulhOZ5irHOzExMzCFtWQiRxWRZMwE9ru8v2Urdio210hy9h12018uQPGTBOY61TVi29g5P+KaJ5Klb45kSdgK7hV47aIrKd1iRKrXSCdsqWJjOU5DKU2iygVPq6n4eDyU6qvjO50TzyLLHx0n+TqX5istv1lH03q9ahGwVafwAtu9wLyaSFf5afD54J+p+TJB4CDxRIS1cI3+pL2UWppXaqDvnmPp53TGxVPfSOZFU4oOkgA+M1MKLa3o4mamr1GLeJjhdGrTq4le4tLI5sXq7igMy/mXt0cVesWw8HVI3AfEr6Vc7sS1VfNPRgyVq83ZJQN7LcM3uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(316002)(66946007)(66476007)(66556008)(54906003)(6916009)(8676002)(8936002)(4326008)(41300700001)(9686003)(6512007)(107886003)(26005)(36756003)(1076003)(2616005)(478600001)(966005)(6486002)(83380400001)(6666004)(52116002)(6506007)(38350700002)(86362001)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kt5J3w4ueknVR9reucYQeTfZSVulHOkcbmqXVyWLa2wqp09jBH7VtgJZom5q?=
 =?us-ascii?Q?VAf+TME5Ng9meqkT1RKy8xw9zg7OM9G6B9PecCo2s1h29MvxU8kz/xt2z7cK?=
 =?us-ascii?Q?0rJEIKOi6kDC4Rg19GAPDOCIlKddwEivdd1DekPtaLjqvsLOD3Uk1TcJ5ntV?=
 =?us-ascii?Q?xeRk9tmWnaMnitk7irDQia0QUiek9RnRcEnX3R8UpHBlfTkVw2hA3fM0UzKf?=
 =?us-ascii?Q?n2Ao3rMYT4dm9pir27yUieA0kSRR2Kc+Zk8+xKVJCRVgaNsMEmXHpX98HS4G?=
 =?us-ascii?Q?VzQJGUJOjtDIyWxQ3odKwWWq9zSHZSLGc9mVUlDOoGO+ZP3PWihBbtulQrTk?=
 =?us-ascii?Q?w6EfOshjig0exahEV2jQExfFkF1+4/wtbv/lLJaz+sYEG/1/IRau9b7DveWT?=
 =?us-ascii?Q?2pED3MbAbV23KaDPywbX1CBEf+WQhhzk+2OtbOjfj1QoFfQH+Eh5zcvLSZYf?=
 =?us-ascii?Q?Lks4346WvYKLq1Oc+eTW98swzdthI0YXSIvqexPwq/fVmtfo+wfMxKegPoxQ?=
 =?us-ascii?Q?P9+dSvFN8Gzm0iiJ8JaZaQnKA/BRz4Iydb7b2eezcVfpfzlNspx2AcztbJ0x?=
 =?us-ascii?Q?DzBAuEz60xzFPQUTxCyHIPIZqCfw3wtsgnCXlrqLrw5el9mRN1d4WLHseDfx?=
 =?us-ascii?Q?TZfZriqp2bE87u2HcVDvFJWKBMsefbgBxUi8Sv8aiI/034FVKJHP79CXXb3k?=
 =?us-ascii?Q?1VQ6JawFYVJaZnX+ptHWlZrHNNX7VW3TnRE1S5xcZGT4I7M1Q9X6XHmkWpeZ?=
 =?us-ascii?Q?gTkGm6ONdwLMpmqIoVgPEhfKlK3RHKSJWito6/uNww1JK16aULnZDbp1Tt5J?=
 =?us-ascii?Q?tAbGuYtQA8SCPpHmDf6OHdhWDfhwYX582qsu5RJclqVG1HjEa88yUVOVvOAx?=
 =?us-ascii?Q?k8FY53pXY6e2HrlsfRU9G6AqQnXAOJqeju+8jFYw9MnFvjOV7N5IaE12GuAw?=
 =?us-ascii?Q?gIPvp4pmH9DDSomMjVHsueEHjyu5vZEtdAOutEBXY58o7SV6AgSP64iAykOv?=
 =?us-ascii?Q?HYYvvyp+xmBHqH8CqePZUq0DhmIt9I725TTYQlloyB4B4uWiSP1hHfyQHXQy?=
 =?us-ascii?Q?669BZ+Nnktugboerm1p9q+Dmj9apVkEw2qaw9hIWAU5Ex3lWyhuk4soT0Uub?=
 =?us-ascii?Q?85c0qduw146OrcDZ9lmFiMfCUUlgEnQ26+pG1dLNzl4TE/RZM+WUElqnsDK1?=
 =?us-ascii?Q?rF5CeF6ge/eqkzFEEoDUSKnDn8Fcqux6IFAUxOCYwkCOic5Zn12Q5wayS4f2?=
 =?us-ascii?Q?2PHGKgQJlQgEuptarm2payLvd4TRl1nBr6uH4YZ+uAUO7CtJS2agG/8jPvGH?=
 =?us-ascii?Q?WmhmZZ/mHt+6KoMoqf6LOq3D0BBF960eLgxIffI9qdNo8O4u7bHxC4Cm78j2?=
 =?us-ascii?Q?9S4DkbeDrPaHA4ST6I7UD2BUpThuTxqy+l3IQdmYiDsHkUBJ/fRpwRsgmOAQ?=
 =?us-ascii?Q?YDm6bFcl2OOaEIN5eSzQxoVYyFZJUXOq62P3Zu5yK8HN8/K5Iv7jK3Kqatvw?=
 =?us-ascii?Q?l8XO5478mbdnLI6XWIkjifSFXbIYL6YbQvlVDKzjDgLhhFNZHVuOkq/xOc2M?=
 =?us-ascii?Q?HmAlKEIUU3Ax6B8ndWE0zdQHJHDyPECs7AHYVdDOnIz+MqB/F299LaqpTHb/?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d92dc8f-7788-4292-79a2-08dbc0ee2c13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:15:37.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbHT3T7qo78orZNvdu6YWx4tJzzRsQUtkrwldS08JXoEkBtanpuHRhEVmVip7G0Cmn5qFFC+A2IpfE/sfLQNnIb5fVGAaKOrtrWP8KG4vEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-Proofpoint-GUID: LetTGF77MS3PGpg0IvRlN2bZ1x5nIf7b
X-Proofpoint-ORIG-GUID: LetTGF77MS3PGpg0IvRlN2bZ1x5nIf7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=636 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309290114
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
index f425389ce4bb..0d97d1cf660f 100644
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

