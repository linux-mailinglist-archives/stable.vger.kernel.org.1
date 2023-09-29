Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CFC7B3347
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjI2NQP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjI2NQN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 09:16:13 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331FCC2
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 06:16:01 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38TBnH0q023952;
        Fri, 29 Sep 2023 13:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=F/+PSPdeABgD1r84Yt
        l8BFEY20Yqin6qN0VrXKiN7d0=; b=iatxMjLb8RCf0wbjRm5wkyXHhdcysoURs0
        0tMn9MLjdeMR2nXXBbjWbPUe8bp1gVXj/BNWkjEDTtcBvow2UdGzUT/l54mT5EAW
        rQJrs+tI1+GZZbg2hX0xaeg6ZozRm99UDcDfr6ua1nTd2e/nfxdrj5fahhpKyK7S
        s2YDWIn9oqbvtOBy1mPFO7xHE5QHGX8mgBxwMy6p51TcriUDbiKGADtZF6kT3MGw
        Ik5/STuA8WlpHZszJi3l9FfFP7Z7TjWEr9NQbXIRZuV6x3LKHX365SMIK5vvq8jz
        wKIIWXfxJRLEOLuKD0RakBG+17eK467oyufIB0Cih+UNl3BWIZFw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9q06e4td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:15:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxaBhJmSiVP//A/fjTBTfE39+scCJEJcShVZNN5K89g97RZbOPU1V9WLzCgJ2N1rUV/HiaunthBaDO5wpgRaEOeNkHAo9j+zb7KyDO2kvciCO2Q7q0VBiR+wEHb7wTIsHMiewCGWycpilw3cLTkRs+ji0d8HwK8iucytWqnb2yceYAR3Wi90Yc0Y4f+gHeazd4VBl4d6wA7WhvVdZXoStIgDLNvT7AuS5D0s5Wy7P3R/NJ7xapPysfiyF7URyuPHwKpzMoi6fI4JkxXY54pd/d1kdwx47kNx4OiotbBK6mSXfUyBQ2w/jASCH+rO4Ik5IWiuSqZ6pZa9hJpg6zBjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/+PSPdeABgD1r84Ytl8BFEY20Yqin6qN0VrXKiN7d0=;
 b=X7Ei2FBxP7bPCuAqINZ7t248mgVQ6GeGdO4LYijJ2dgXyznv8osbj6FzpD40Lg0vAd2DTqQkbnm+B3r40BixW+z9tOfQqX+WRVqqtsmQWax82ZbqvdtGc+tiye8RcrBWIkhSdieGAF+3kwQsfpUrWEEZ/SM1ncnF5YGzvAuf5okK0ojeQAeOAiCF22RrDHXR94cDsXcglIngWsBaqIj+MDCcK2us8RBy7zHmpxNbMQZQfzcpm92c6kbpBMxUR2xGNDl1Q1QraTS8oipzw2k5kKWaO0gDi/aksuGm+4b9Hs8tDZnqJfg2OH312DdsRzZJYq2nP+IzmspJarhxlUMlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 13:15:35 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::c461:13df:b26f:b828%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 13:15:35 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.15 1/2] sched/cpuacct: Optimize away RCU read lock
Date:   Fri, 29 Sep 2023 16:16:06 +0300
Message-Id: <20230929131607.821861-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f72c79-3f67-44dc-4c01-08dbc0ee2ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv+9Vr181E+mIC9F7g9U5ynwqzp1htXmTg+olO46XPnG4yg6rpfhFuhIlH0oXII6AlaRDXELAzWFoAQwaB7SOvn4BSXRy1Gr+gi7d4FSCVogf+kMC5Rkj3kJvspALsoCUUGwgrZ0L5BYbpyzYgImT4/MjvNWwuWtBYGQ2LFQffQsmNj/NiCHCJ/66vyQ42/jN4An7DqHFavhbrvQoawbf1BdYOHr3DnhGrzi2WTwnq9N+agHL5t91njA1Ttm893Dl+d5/IOBBTc7PgRuTKEzRBzsDWg453jQAM2uBD+0rntPHADjK6QEOEEnEJVoZMHvE0PysGmXc9P60lE5MqA/KJ4+OQ9o2G4NA3uWVWK3O8HJDok/1pM4wzPL0KZImZ7K1P+IKaO6Op9pim1WwGQFQxAiDEtd+bxKCHRXXz8S1pEMlhIXgy4Q9CjFy1sC1b+jTuRl10LqBgQfUI/dDxR85YFYy4ALa5fC4piDF/loaCAP6ixOrtk9oI7xO93tKAZB0NjhPEDfApavGaWmpesJPM+LpUbzea78vtPftHNKx9riuMgaOhlbvSyfxlPdeUBrS5SUW/DoA4el2NCuzY8hD4ynaaWh5TNUD6pQCDIncvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(316002)(66946007)(66476007)(66556008)(54906003)(6916009)(8676002)(8936002)(4326008)(41300700001)(9686003)(6512007)(107886003)(26005)(36756003)(1076003)(2616005)(478600001)(966005)(6486002)(83380400001)(6666004)(52116002)(6506007)(38350700002)(86362001)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UvbLq2FN/AirIWuC3kAH5O8HLlaWtg70RPXOXtWvSrCO1GT/Y4gqqkha7Oye?=
 =?us-ascii?Q?y9dG/ScYsb9Ck+MVyBs9vn/kmAogi1oJ+FQ8Ahgm/0H3Wo5ubq6SCpXZ541H?=
 =?us-ascii?Q?2Oy2/niU4lDvsbatmfxl1LEb/w8KCeur2SizTWzUL9qfdMDvrS5H6YZXJMRg?=
 =?us-ascii?Q?VEqKGDBan+WjrqELVOrz2ohntwLQNg+DL2UTcSeXJKi5++Tj03vwyym8s5AD?=
 =?us-ascii?Q?Q8Cq7CiMf6xqzJJIW+H+t4YHvxxqwCZWvtsxJSnk6Ts3/GbnIobyjbId4IKw?=
 =?us-ascii?Q?VJP39XiCHB4nO5DTgTd3A8cDpeRwXCy0Z5viFHppIrG81jqgZmue5olVSdnU?=
 =?us-ascii?Q?h/N05ArQqH/lDDO9Oa8UGQQPVaN8ERASXe3ZF+F5fVxcqUA7fjzMXVfDBPFG?=
 =?us-ascii?Q?EVQ+xKklPZJlTsfvmT4tcqtmAuqOkOSMMROgkSc5XFMlpol9IzMcggJ/TDDP?=
 =?us-ascii?Q?odkw5Brt1CY/UDqRnkFii5X6v2KlflqSleF9HYTi5OhnW29ypJbInHh8EwiG?=
 =?us-ascii?Q?MfhDbQ/zFP1n0Gksm3k6FqLNeRlXQqaHk7VmnZrrJcHQQToAUV1wuFcuu66R?=
 =?us-ascii?Q?srcr7TAXZFm7xWdY7S485iYJb3lu/pXB8zHTbFI/k3xmW1jPQV4zl4AdPmCT?=
 =?us-ascii?Q?IIThdzi2PU9ctBJtWb72CO9R1s5eDihZbbP8Y9R+WnBrtXEyscESii7KBX4C?=
 =?us-ascii?Q?0bLJWX/tbKrKMbP2FJ1SwawO7gCk8cOC8j6h3PdygdckwMYkUqVJm06pzLfn?=
 =?us-ascii?Q?+RYCd/wXg6xP8zzBXP3wHbNINisPnfxZr6b4XmEGmBWSBe4Zdrge4A7He7DC?=
 =?us-ascii?Q?i3Jr2mrWUO6KwvGaujF6ouXNPsN/aWWgtuuyhEwah3Oi2Aet+UCG6fDlGF2N?=
 =?us-ascii?Q?hEuk8I3S1r/joRN8OsNXs6SaoKRFMM5d4uZ7vDlKKyd7JW162J+uYMR+yMWA?=
 =?us-ascii?Q?eah9V14maK+YHPnaMtWMXZVLU3KGzjZuSUjam+5ShuLADg+JxJUH9P/YphMk?=
 =?us-ascii?Q?D4RqLABWR86lTpeZKfdh6bkrMdVPJN0XCPAn8x+gS/AOfmxZFipNJNxiQFIy?=
 =?us-ascii?Q?QFzht8npj+0osLOIlGYgLUuE88ouWMM2uCot9hbZcwXcPE1KF1JXVY/7oabJ?=
 =?us-ascii?Q?5D3xkz/vcNNPn0r08kCPrtSb+ONpo8vZPZfS1Gh9ioVkyGOPDtOvrFQSVYH3?=
 =?us-ascii?Q?oNi8HDqSxWsUaIIF112AmOhWdRR1dcc3hEHJyztV4reypmNlX2Hn9WVQoRB/?=
 =?us-ascii?Q?swKXGwoynY1D5BpQSjM4ttsTYYSTwjBpdsSPEDK26bie9H9Olje9RWyL9bHG?=
 =?us-ascii?Q?zPUIi+AbFyHSr8XrTOarKD8B0k+edka8RDep4XvYlDmkHQ1IT/Evqt8QLuuj?=
 =?us-ascii?Q?kevLQIh0GkxZFcKL7bvBlQ5om5yHHZ7w1IF4odFpcm/p97oEqGb73WK+ayjl?=
 =?us-ascii?Q?Xzrr7/3lJ1u9vuSb+qD3/Nzej9s3GK6TL14I47Z2K2rc0y8JpnU04Y2618S9?=
 =?us-ascii?Q?Ya80EA+inYTAWZBm3nvvggkP/QF7sKWXFlOXjUDPckE7hrjTo5R985h4qY8O?=
 =?us-ascii?Q?C1dTNmJqXe7stchm/hAXqsdPX/rtLEnCjphfxpIJJ2dRCLhMYsdXejCpxzFu?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f72c79-3f67-44dc-4c01-08dbc0ee2ab0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:15:35.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q692gAei9cv4aoOOBsJEho3om7vzks5gRirz0EGlDN1c3AWr3km5wHWHK6+fomaOk7xqmUlCnVCL6Tgc/dWQ1skUtaNJE4DoVr+KLo+0BP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-Proofpoint-GUID: divz4tL8xKvc40AvxVu8e_QSAzBXH6cu
X-Proofpoint-ORIG-GUID: divz4tL8xKvc40AvxVu8e_QSAzBXH6cu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=787 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309290112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 45cdb12243e3..f425389ce4bb 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -792,11 +792,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index cacc2076ad21..f0af0fecde9d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -331,12 +331,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_rq_held(cpu_rq(cpu));
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
-- 
2.31.1

