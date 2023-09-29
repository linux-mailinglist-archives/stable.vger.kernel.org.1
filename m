Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BC17B3326
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjI2NOY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2NOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:14:23 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917BFE7
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:14:21 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAeMGI004098;
        Fri, 29 Sep 2023 06:13:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=AK5icVqbqhp6KyNJc08jwnLVdjMWo3HivZOomGdJ/uA=; b=
        XJqcemf+QiHHXKeuFYFANdHYdIy6d0BfY8STzgniSsoWkws+OeaCqk4L9Dyq0aEJ
        1vz+dBe4UEu/pKtqHiC9IrK0FGDmPgYDa5rCs6y7jlIDRRlM6PEuACLGmHM/ygqB
        u/rghTWu3iy5F+eyTXZ1zaneKov8x0pWVzIi3P0BPkTZU68m5qZHogjdWZPQh54/
        yqzOU+pBxeDagAJ2B0RPxO2o3fXEc179U7HD8CS48JgUovqv3P4fvik9lIDQownU
        UhOCNbZ4d0ZQ8ShyTJeKRNTAEmIZqSmfBkBhSCEAc628S+Kb3qhUrB0aa1io95Bt
        sjAuRK/ZxktdtwGnToWO4w==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9ua0p1ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAd+dbriYuIJhebIE96DcPfOHmHHxzE3qTW95McT2VkrU8Hj7hJFIKHMeuxuCafDXKg92xH0rDtLNyALbPDRT+8Ugi0wwPdaELHnWKiFUVqS5lMhpKf6GQy6kSwrn0fmaYo2L3lSPM2qgFQWsBIuxqbskJ5p/A72GV85lGOZkLntB4RSywZVjpSMR8+6rScveia3o34iJe25DXgYkXn5wVV/eb4BL5LZa8cyNozg5Zuwe4I4Fb5yp+2pznjyWPyY8bx+C3EGXyJByHG7aAuFEfvV0ikhbKQmfEprchCmVGAXdjbB7uC2DVwe95AtvhkRU8m+Wm7C0usYyDZZaQrvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK5icVqbqhp6KyNJc08jwnLVdjMWo3HivZOomGdJ/uA=;
 b=FWTZcMT9ajGeAQBxC82II+ZNjISTq8357P5x56siJWBMQVn5rxaQof3U2YGkbBK6wtNsTOeZW5Sg5rfF67SmtD6fml4he1EFtUf/sT9DnMTmB8CeXIAdLjxtvOG+gvjFgB7UARSo4/xl4uNc/7i7jgcE7gzcIqyHfmqP+3hNRhVJ4QLasjqih8jBx+zQTkYjZM9ufQ37WFj8UpZjDrkEfLz2yzZf1iKzBWwWoWhVNONmbV0mIhPomK3H21twZjrga0USACFUKXGhEdVel9crv8oNWO5MFWPLLF1k9YiMDXdJ634XK2AVjNQmVzpBKcCqrX/CtE2fqrGzexUGPJ1XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 13:13:54 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:13:54 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     qyousef@layalina.io, Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 3/4] sched/cpuacct: Optimize away RCU read lock
Date:   Fri, 29 Sep 2023 16:14:17 +0300
Message-Id: <20230929131418.821640-4-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5a2aa31-bd6d-4e8e-99d1-08dbc0edee78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVr30ZWEmpxJufX6MnS9TwHeVqKOpGa9/Q9MSwdwmUIQq5JWCweOfUKel9uMxHoMfUdztXo5cs0n/M6MpCWe1dzqs6uATAY3NMX10aMN9Wue3p7JLpBz3YdPu5eVhwiXDeRN65HDv8ObtIr7kg/6PpX+SI7SwvLQpGdfCEih51Nlpd80Zapxx+41Ej+NOv5i3UTlFxCA4TEmpSFLJ71WP2Nr5C3YldFnvX/uqhIfw0AAVNE++iUiMbjHnfMwJybWjVzJ/Rn6SlBvWv74kpkBz6mtbdgDmMfMpZleYuPUJuV6u2mGprDx3UvVqrPmYdG5MXyBkUIFVpl8kShWt/fBYzW7eKDZz6l38TKnwF2Aq0OIBK6fFCw3kspzxdVFHe+7+ygaXsvRw6mn8KmXAQtQ1dtqxt62WNdWvxaLzc6VIc0Up5c9UurPbx9xkOpSBpkt9tjmT7PfGm0sY9hlhEBAbYIecHrf+ZkoE8UzbQ2GJGw9u9RdImncki3LF58UJp4iRIpnkjIUPhbJgU+MWApHAYpgHg/KIAgUDPuOthfgFDkNdBFt5eh8oFh1a8WQlrgOFZN0ghdPzJ/VJ4Txe/VSDx92cfm351DOM1eeVsOi0xI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(2906002)(6506007)(52116002)(6666004)(2616005)(38350700002)(38100700002)(107886003)(478600001)(54906003)(66476007)(66946007)(6512007)(1076003)(86362001)(6486002)(6916009)(966005)(83380400001)(26005)(66556008)(5660300002)(36756003)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbXMlNWb/ff0YrYUtMrIkB8utAzKVdX4gGz8A5KAJAAcDj8slTdXPdtxCUYJ?=
 =?us-ascii?Q?NiIrLXFcA1be+ugLyO4D/agsYpPEcwQTTu21+iv10IIpSdZ2xCGDeb6rgjzN?=
 =?us-ascii?Q?6T5ugnEyKyOOmUtDjwqc6tkgyyunpqr78yNujGc0wbLsp+IiSnaqt/eUviJt?=
 =?us-ascii?Q?vyETVL+pEI0uBAKnF2qEGxs/reU9MeSXoi5MbMPi81tj2yLlgDw+etj7DYvs?=
 =?us-ascii?Q?16Stpgx83EYkHjk+WnE8Hxbc0iw7GSM7SvTyEIFrtOx/2b9yNG1vPHAcwe6u?=
 =?us-ascii?Q?nkcXKzUvo2IMf6l97m5y0jOYUPoc3wVc50PduZZgaH+qTsLyPRHV7OTdtMXB?=
 =?us-ascii?Q?hRizp1OZWmxhuHOsyW47aHztZzGXuniog6l6nZYxctztztWHYsolF3sVXQNF?=
 =?us-ascii?Q?rSQT/vVJ1S/MYWYYRUq42Iy0l54ENbRBwTUG03z+8fsP/jx9PzzH513kXHC+?=
 =?us-ascii?Q?ypchf63HtuIllgEzqiLNP3GqudNeJIlTeZf5Qcku05CWM2EUbN5IBvXjgU86?=
 =?us-ascii?Q?O7AbiR8/6A+0B+oOrfFYvTv0Z4gkmH7LjgFmN2rVBf9PQc00yjmBQqdzCukX?=
 =?us-ascii?Q?Hv21wW7MpU/uTWquaRdh0ym0BMeCaVdrZJoxEdPD4iK5dEihNkHn9xzMG0Bm?=
 =?us-ascii?Q?C+xhUVCwBdNHGWA66kO1TXftc7XUYyJxCKsc/4lTz3tSzQA7637QDAGEiT3K?=
 =?us-ascii?Q?kD8po7A1OQ3gNRD49A8hSZ2ebCOVz1eWWl80mDEPOU50eBit2N9j2ndFfmyc?=
 =?us-ascii?Q?DKNIS1Dd8Lgv5yCBcFyt4r9x/Oy3ExcVEzUttgRVrkObb8fcbX60lB0TteVf?=
 =?us-ascii?Q?CorO3LKs+FvRyoZSLOsad3TyzGjU96naBi9YP/Oe2LApgf7vzokmUrTSAaQZ?=
 =?us-ascii?Q?XWWJ0ibmUgLvnmTpzCa5EMDoUyCAbhqAXSRWZvoPb4XWqnfBlJHjvXwB7bl7?=
 =?us-ascii?Q?rbEzo/XKeqAYjxFE7Tm90IOOCtVBaYwZiuitc+1D7Fffmtp5YAi/1IF02pzr?=
 =?us-ascii?Q?B9A/X+rj+o3jHseP2l6iZIjahlKhxLoroSDCawtWBYQYeK4K/uyjg8CkEsYC?=
 =?us-ascii?Q?CmLzuLy2BT4Ko4v4SxoIDvRD17mxomiwFg2n6UhS9TNPRrPiVxg0vfH4cMwL?=
 =?us-ascii?Q?oE0sUH0HYferPbMT3UivlFA5/U283f41Frg1M8AeIRUj5nyg8M81M4X+hOa0?=
 =?us-ascii?Q?AKOoW3jhA9c9ro2HYIv3F3Ggkp/g9gVCT7PpdmwcH/TuNM9FZWIqztiw2E8q?=
 =?us-ascii?Q?r8E/lOMf/5COr0RW9lFiqP7i3jVd5Q1UBr74WT+GDVjybM2H7pdu6UKNUqap?=
 =?us-ascii?Q?Hyx1+hA/jek7s2/rLPwbzox4rFPTLC6gHJxNAij5H702wRfhYGoSAWGVT+xF?=
 =?us-ascii?Q?qi0YEtj86ZtuaeyWgAxAnF96MfS3QVkDVWfhuBjMdg2EcvRjrZce3M46yDm6?=
 =?us-ascii?Q?xYhpB2moAx9p/tvsX9TNA11pDO+v5VGRynB715mBrEHa144ZXVUHzSjCD6fu?=
 =?us-ascii?Q?77oKfXvnj7MQpN0lJ+ctsBP3QtYo7QZZbCYicyY9hU9BK7GtqCvJARzF8NE4?=
 =?us-ascii?Q?93ay6h3DyUplYE/AKY7NEpRjWf4cJcn4EV5UgbKIfiGPkTm+iqntruG2WLly?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a2aa31-bd6d-4e8e-99d1-08dbc0edee78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:13:54.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjW3llQBZUwudoEaTuyQDzkVTvC06HqLn4KW1QoKTAC4FCfv7GWMMSOL7errrikBe0dYdau7BZkl/CpE5HrzwMrbML4YZX8j4pnYEhlC1bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-Proofpoint-GUID: WTm7vaB1fPs7jy-rEqhFbgcgGN2kzBcj
X-Proofpoint-ORIG-GUID: WTm7vaB1fPs7jy-rEqhFbgcgGN2kzBcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=758 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309290113
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

commit dc6e0818bc9a0336d9accf3ea35d146d72aa7a18 upstream.

Since cpuacct_charge() is called from the scheduler update_curr(),
we must already have rq lock held, then the RCU read lock can
be optimized away.

And do the same thing in it's wrapper cgroup_account_cputime(),
but we can't use lockdep_assert_rq_held() there, which defined
in kernel/sched/sched.h.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@bytedance.com
[OP: adjusted lockdep_assert_rq_held() -> lockdep_assert_held()]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 959b370733f0..7653f5418950 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -779,11 +779,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3c59c541dd31..8ee298321d78 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -331,12 +331,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_held(&cpu_rq(cpu)->lock);
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
-- 
2.31.1

