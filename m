Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE37B3323
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjI2NN6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjI2NN5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:13:57 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D682B7
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:13:55 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38T9bj7F021065;
        Fri, 29 Sep 2023 06:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=SovPI1aSt+gw4BLLpm
        2FQx0+CdOUKAJeRqX1+HU1lOU=; b=dmZdYnpLMhipXsnvtPjVIN8qR6otwyZ6Y+
        U1wkqiGXgMuJnYbXVgTonIsI6SzqMH3U0PaV366rBzA6kYhrsF7hqGQ7sTJcqpON
        hXGry90xTDcIEvXMW7KMt/t4iS9D37L1neJDNX91Cieb9fG/phN+WHMdnjxRrkn+
        zX+1OvW6Eufgy5EHWCTtIpbmjob25ipfB36QgRpFqOP/x8GKgsPbWWf1+f0WxpY9
        Ey2uW3U5h3VwOLj0Py7imP6yiT33mXnej9GamaSQnRNCFaL7q9ysqDGojqQMcTbQ
        YaKYoPFPo2mRzXCCnCz2nZ4yaBYkHGUrOqfuH1lokEuZ8nLnO63Q==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9yhgnw8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1XVh0aW7epDGSadysiue452CpF4IR6To1stlakENgBlhWIYZkoS9TOjnWnyhs0r8BwiHEB/XdoGpRd2K0bmCaySthcP4ucdmc0PYmx6Ym581w4igOAA0R6hF3mu3aJeqmLiUS/c0/J78u90Fmb24MNOpWcPwbyrYzw+l9AsLWSMOyLsJjgvumTnl/UyuBqWwgNeIAUyvIVhYv3pMOaXbYtIP0c7KV4Zs1rcyjlkBn241CEKEWap1mUxRG9AN+bqBE2/dJRTAIZaLzZXjrVW3dXGxzPw/VGHLUNV4tVeI9y7E01/RvBnLewKoMC+Lg8Ffq2SSVwxnYm/Yd5aVpch7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SovPI1aSt+gw4BLLpm2FQx0+CdOUKAJeRqX1+HU1lOU=;
 b=JnxC8sIgRrINw6fbypGo9vksUYmprMGciMXbZfRJ6DyixsITLP/b8wcHQ0VyiSC7LrAsReIW/J2IftCYoeRDtdZ1uB0GC9zzakugPreXx2P7vATHPi+u46eeybGOznI3ikdXynu4rHeFpn88pcOOMSVM0MCjB2ChBEcx0TSa5F+3ey5WZn+352xzRMAwuG6LAiFPFKc7Acdg48ZXyf5nM1kxY4Ma8dm1fvE09wpnG0m3vVzrtb2EB0TGVDkChf35WLp9EHjVmRejyoJwZimx4I4riTcgNaK8LaZSDxoyRPDG8E/TloBFjbQn1vrpFaYhqTJmBq+D0/j2iEIsaObURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 13:13:49 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:13:49 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     qyousef@layalina.io, Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 0/4] cgroup: Fix suspicious rcu_dereference_check() warning
Date:   Fri, 29 Sep 2023 16:14:14 +0300
Message-Id: <20230929131418.821640-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|DM8PR11MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ab187d-572b-4e54-8580-08dbc0edeb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEZQ8Wv4HCfKpXwpTcXOodgyMUqWSwzUOsn6PLa5UET9lZDMcOvTwbxvfmY57C94BL2aTz2HN8gCNWJBBPG+07+TSDnQHzdkdatayukwokgJzwPoYdIfWpnbQmaT/jq2YV8PAcL8hTseH13fi7E5niHZZ/rd4UmYNrzisWMgPxy8I+7ceqd5nVK9fZoypBQallOtTr3gWGXF9rm8ZqwXRqFCp4ErCmduDzqcny+epIi7sHbqs0r9OYpv+b5q9an9eJGn13dYHtY9cHCrIov6cOvqAUfgw1xpvgmdeYtIvgZlaWaCHNTWRLPvP/vgQVVlLHBWEGVG+G81uys4ITtMSeLDiltpLkWF3H+gLQdX32n/QIv9QX3FcFnhCzKGqDLUHOjUgQ2925B3hz+MqO60PQ635W2FRUJWuAFe541KXQ/lZEXm8dN42vHcTyUdDy+ZvsxOo6IhaSQPOtaaD0Bd+WwZH9Q/Y+zdOhet9IYF9NI5PpHrosrVE2MdSPcFqh0ZgFt+UraqrpYiTWumU1B0Ic4DZGbbaLHipw8hdcLqcxvN7qITVngOkqK8lvb/EEiTyInOuP8ltRrnb84PpkzNPu7K7z2tY1zEVCZ2PbzS7VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(2906002)(6506007)(52116002)(6666004)(2616005)(38350700002)(38100700002)(107886003)(478600001)(66476007)(66946007)(6512007)(1076003)(86362001)(6486002)(6916009)(966005)(83380400001)(26005)(66556008)(5660300002)(36756003)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQxwJ2HIk/Bnc1b6vbWDSc7auC614pZyzfHaaZDLbbwmllFLKlqPZbYOEQDc?=
 =?us-ascii?Q?8F3XC+pCExEpYo6EHcOGXX0vgTAX+lVK6Tbe2OyOGjKiFJqBKUuYc678txNq?=
 =?us-ascii?Q?bsv8xvS2QlGTv5yMKkxernGqiikpofnisQDJN6ng9wfnkrx2chI8ZmOklDeS?=
 =?us-ascii?Q?BDexIJS2Z9khqAxWmpu3cAHKH83JLNHzF9fQsbQxNy/PhHNaJrKLJKVU6hDS?=
 =?us-ascii?Q?o3wosoUZ3VgcZcjF/jRr4GC2NZVHNuNLwGewVAXIa14C600lyFMzz456Dddm?=
 =?us-ascii?Q?hM9QG1pfGq8cttQDMwZ75e2vG8s06KrtT9wKs8MDTmP+/81hS33TNHgvXAUT?=
 =?us-ascii?Q?U7cod+4YYUPAa+Er1tIzKcUZjvaPZOJMOvBfoAoVZ7Hbrfy2XFuTvgE6am00?=
 =?us-ascii?Q?4hRvTBS3fm9Ue8TPp3kKDtloyNwzpQb5a3OGTqZv5OL5z4iSschHQ/uPi68R?=
 =?us-ascii?Q?o6xTBRdtAkpmPm98Iz9wJ3sOmXptdvPHLg+6cBlRr4QV/tv4lcmt7OxS/IiF?=
 =?us-ascii?Q?sgJLyXiDnod4FhMBIduZAdIfOCoRIQ5yVL1K232XkDtig4iZ12da19XI9NHC?=
 =?us-ascii?Q?Jl+go8KvG4NUceyGRi463nm6awXZ1Ot7jV9pQv6btbUxcyv740OFyu1MZgug?=
 =?us-ascii?Q?S2V3HkjDwSSudX0zUtvVwxnd0xWNwCsC8mpBwRanmvDcBtUFa/i4/v1mrA1t?=
 =?us-ascii?Q?vjRyR2Eb4r/K6ctCy1OayznjimQNT8BFO7xaRjFUV8cmd2dORPCGe9PqxVML?=
 =?us-ascii?Q?BMx9TTnWJaxYXXfSX7XRWxlEP3X863+uiIm3tV12xuEC6pHrfqlmL1iSw0d0?=
 =?us-ascii?Q?THHD/nYqllVs3wxbP+FdHufa9hXXl+VC4igN31pGayaCoQRZiSvNskgnFtRk?=
 =?us-ascii?Q?zi8vFCzBZzFn+TKuH/0SFXITn8eBXFUOlirOQ3IB3tpuerLAZfrxvqunKZi1?=
 =?us-ascii?Q?NmRgy78p3WCN3bd7PVrA1GdwQs+bUHg/QBziInz5XQpx831rOdPJ7iH1gRlD?=
 =?us-ascii?Q?sy0iXsTYIxo2DKfw/aaBqDK5XwlSn0DsKzNOt8c6WSULyTZjokP/hkryuaw4?=
 =?us-ascii?Q?WHeH1S4w2/hOcuDp4QaDZ/c2tag4RQxya2yC4ly7/r+ZGPy3e3iKtPCJaXbu?=
 =?us-ascii?Q?cD9gE+T1o0gibOSdu8rvmCyk4a8tZfisFgDVRgEOguXBz+6Pkgc8mdAvk2tH?=
 =?us-ascii?Q?UVW4wB/mANP9UDXhloX+LEI+YHf6x53tqP7qW/Of9+eTeiwyBJ6AuILbW8o+?=
 =?us-ascii?Q?LtK0oKAIMvKJP2Br8HpaTPijNd4A/wN+kNvU9TNCY+/eTk8xGiq5iC20hynZ?=
 =?us-ascii?Q?l39pdepny+hPtoZGEQ8zb29E/eyWwexouH8kbMf3ZA3ykWeuvnqQ9jGe3L+L?=
 =?us-ascii?Q?oCxdJXu94AnQaXCoK7jX0kzzwXf89thM2U6/2laoQmLUuipQTxV0fVDqktQS?=
 =?us-ascii?Q?bHcp85GBPHJbFaC+raxOUnxRN+8yA+g3+np9xUpkEacVQkRcIGPWshVLTN6i?=
 =?us-ascii?Q?dwVzTTeJwOdTI2jperIccls9iZ3ugzLHMIriasNsFmXuewDe5px3GZBZ9O5t?=
 =?us-ascii?Q?+A3IQ6oTniGnAhROABb7NNm5/GwLmBD7qwVrz16tA8bjw+GvuCLThepVpO+q?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab187d-572b-4e54-8580-08dbc0edeb31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:13:49.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+Et64HvCtOjFaQVtG31b+0MD+/Y9QYI1/I3uqjEyky6v018led4Kga9ZchAaZndTZoYFe87qctHNVmDNS/bv1xAdJbxfhilO0kViZslWyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-Proofpoint-GUID: VD5Qy8Yld9W--Pse4rjfiIdYJGzl4skA
X-Proofpoint-ORIG-GUID: VD5Qy8Yld9W--Pse4rjfiIdYJGzl4skA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=966 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
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

From: Ovidiu Panait <ovidiu.panait@windriver.com>

When booting the 5.10-stable kernel on the zcu102 board with
CONFIG_PROVE_RCU=y, the following warning is present:
=============================
WARNING: suspicious RCU usage
5.10.194-yocto-standard #1 Not tainted
-----------------------------
include/linux/cgroup.h:495 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
9 locks held by kworker/2:2/106:
 #0: ffffff8800048948 ((wq_completion)events){..}-{0:0}, at: process_one_work+0x1f8/0x634
 #1: ffffffc014c4bda8 (deferred_probe_work){..}-{0:0}, at: process_one_work+0x1f8/0x634
 #2: ffffff880005d9a0 (&dev->mutex){....}-{3:3}, at: __device_attach+0x40/0x1c0
 #3: ffffffc011c70cb0 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x24
 #4: ffffff8800b10928 (subsys mutex#5){..}-{3:3}, at: subsys_interface_register+0x58/0x120
 #5: ffffff8805e78c00 (&policy->rwsem){..}-{3:3}, at: cpufreq_online+0x590/0x960
 #6: ffffffc012a9e770 (cpuset_mutex){..}-{3:3}, at: cpuset_lock+0x24/0x30
 #7: ffffff880567bd80 (&p->pi_lock){..}-{2:2}, at: task_rq_lock+0x44/0xf0
 #8: ffffff887aff50d8 (&rq->lock){..}-{2:2}, at: task_rq_lock+0x5c/0xf0

stack backtrace:
CPU: 2 PID: 106 Comm: kworker/2:2 Not tainted 5.10.194-yocto-standard #1
Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x1a4
 show_stack+0x20/0x2c
 dump_stack+0xf0/0x13c
 lockdep_rcu_suspicious+0xe4/0xf8
 inc_dl_tasks_cs+0xb8/0xbc
 switched_to_dl+0x38/0x280
 __sched_setscheduler+0x204/0x860
 sched_setattr_nocheck+0x20/0x30
 sugov_init+0x1b8/0x380
 cpufreq_init_governor.part.0+0x60/0xe0
 cpufreq_set_policy+0x1d0/0x33c
 cpufreq_online+0x35c/0x960
 cpufreq_add_dev+0x8c/0xa0
 subsys_interface_register+0x10c/0x120
 cpufreq_register_driver+0x148/0x2a4
 dt_cpufreq_probe+0x288/0x3d0
 platform_drv_probe+0x5c/0xb0
 really_probe+0xe0/0x4ac
 driver_probe_device+0x60/0xf4
 __device_attach_driver+0xc0/0x12c
 bus_for_each_drv+0x80/0xe0
 __device_attach+0xb0/0x1c0
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xa8/0xb0
 deferred_probe_work_func+0x94/0xd0
 process_one_work+0x2b8/0x634
 worker_thread+0x7c/0x474
 kthread+0x154/0x160
 ret_from_fork+0x10/0x34

The warning was introduced in v5.10.193 by commit:
5ac05ce56843 "(sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets)"

This issue was also reported for 5.15 here:
https://lore.kernel.org/lkml/CA+G9fYv9xTu4bKJGy=e=KZSG5pZ+tJAmfZr=0dbuKNs=9OOKhA@mail.gmail.com/

Backport commit f2aa197e4794 ("cgroup: Fix suspicious rcu_dereference_check()
usage warning") and its dependencies to get rid of this warning.

Andrey Ryabinin (1):
  sched/cpuacct: Fix user/system in shown cpuacct.usage*

Chengming Zhou (3):
  sched/cpuacct: Fix charge percpu cpuusage
  sched/cpuacct: Optimize away RCU read lock
  cgroup: Fix suspicious rcu_dereference_check() usage warning

 include/linux/cgroup.h |  3 +-
 kernel/sched/cpuacct.c | 84 +++++++++++++++++-------------------------
 2 files changed, 35 insertions(+), 52 deletions(-)

-- 
2.31.1

