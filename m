Return-Path: <stable+bounces-92874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A89C667D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976DDB23490
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F324AD5A;
	Wed, 13 Nov 2024 01:13:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820652F5A
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460380; cv=fail; b=tre8zmtzhilp0a00j28CsOzsb4eJ3nPpmGhKDurgb9nLwi7KDgw4HAl7qiRDcxCjtgy8STnxRbWhFZyDlNqLoF80Z+4SicQKEsH6WGlPtK5sNWVK5LQ2OmPI9zcu1gcEkxxl0/lROI/05HYiDxRwLRAC9htj3q340XdwTaL1hjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460380; c=relaxed/simple;
	bh=FeXz6uPA7CXWlQRGH4JXpuzyvbwXGZAiKRKbXsYu7Kw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u68dddokB8XtupVy7yILUlFuribjRz7X6lJjg9WA+MuyTks6BRgr3PvipLfcHTR6Z4pSXXSCxqaWufI8nYVV6CukwpS0BTIVfqUBWD3xfGOK403hb3q6Pk1+CKgZztUPioB0HHeOTU6hCy5Wdm7xmVupWCFRw852dOTEn1+J58U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD0p4Pf021923;
	Wed, 13 Nov 2024 01:12:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwv49ayu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:12:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgwtkYx6dDjsvevDEliWX4eGkF5Rix2fzoJM17FIcJOmeddyMDWthsueKRKJjUbRqcdvsrZucng9cOEk85JAiJhH1zMPD0yCYOQ+4v9i8UpPrIh5A51wWMgu5/BYWzEmMWZZfZvZ7nSwGFB98NBvnNm8Z86bYqjYc8sMyHNnHXwoFrTd0WDEZnRLzyxpzoZFlnyH5cvyp25FwhEco5ZOTyM8huJXjiWB0UKCNzcqCtNy3thEJuVEp7TuWPaOyerUFEFkwhRlUN6LLh5eXqh01nKFWEYwTKGbVRaaYS7zPwl7+2zLuejrHlp4VCRQETMmlXc1nlmDjmnCtdh97DZDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGHZL2Mxa7bzpCY3T557SCCXDXtX5lhTdqTjp7R5r4k=;
 b=nmahhukudrLtFaAGV6u8gzJgohTcRBtLRPwBklXNXV0lILBZKpeLVPVLSBOuCJIpcK37j2xsBOjOA4XxIbE85o5WdTyKUQUWhQKrAYr5A0ZBV+qlSw5sDAifmdhw0ZidA4pcUm2pQYpBLQ8HBHn5xNMG0ftAH0XlHzmneMHO2UAHYXxSHDSWjpDhg5YdLsGdPX1pm7QSKJ2g6fRlzRWOMjoDvPuT4aorPop3OsYHcbBum7b1yjcNmaHPD56pNIbS27ugS4QPGzB7PxG8TWLANoB2t+CFFN2A/f8M0X4ixzye+qw2XMm+u4U3/1W6ixVf67YV6WITcV/JQtdzZcM0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 01:12:28 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 01:12:28 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: linan122@huawei.com, yukuai3@huawei.com, tj@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 6.1] blk-iocost: do not WARN if iocg was already offlined
Date: Wed, 13 Nov 2024 09:12:37 +0800
Message-ID: <20241113011237.488632-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA3PR11MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf62f41-f652-41e7-339d-08dd03803dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8p53phT7kBpEvbX+8vSXWLGRmQDfzV/GSOQOowLbssEyxD37gWVCxvGa12ht?=
 =?us-ascii?Q?CqV04lzH+FUp6jPcskSe/HGKu35L7hMaBLvSr5Yn8hp3cI4IHE9ujvtw+7b7?=
 =?us-ascii?Q?ca1IjjTUYojWWJ8lWjvB3xTwoP9uitAq9IGzbZy1w9dBRdGzlLMO7Ryypq7a?=
 =?us-ascii?Q?Mzt2DQnmzy/bOudZUKPctumKKqzQ6ySjyB9aYg0uJ9u4jmdUYQaNkzBPE+Z6?=
 =?us-ascii?Q?C6EvGIeiHe9ypa+RSCOmoH+hSDOFsv2/p5ph9QFps5h5/X74rGFT/fvIisnS?=
 =?us-ascii?Q?yAnHBo6TorHzzpYn+gN/Zike/Q3uD622FZw1OXSKhTZCPk2noDST2St1nwLn?=
 =?us-ascii?Q?EamstYCS0e5nxtG/RYy/wwugFndZtOTIYuOqDp1IXHS71keX9sefenssGuxp?=
 =?us-ascii?Q?An3qZMHuOId1IdA+4mKhftLBtSbcVNERkE5ucMli9hufq2DKBhtKh/zbgK8d?=
 =?us-ascii?Q?GyVG22KNObX2d+7rO3n6MV+BCkFLrYKNykR07bsdAz3Z2FDH+ijDt5FFI3mg?=
 =?us-ascii?Q?LSdC1Bq+mWbmOp74gSz1EDerbdTfSqb6jFSNBEzUzB1lRcN6KyJB0S1TyRrU?=
 =?us-ascii?Q?3VYJ1+KLAyFFYsKgF7OV5Nd6r91pMUgk9uens6Nhh1ckSGf7PXZsSmIlJkBT?=
 =?us-ascii?Q?Jehc4qnxymufUNV8bY+noSomgexm0GGSPTeuAm5Lkb3kqgfZN7rxOTtbrQ/o?=
 =?us-ascii?Q?ia6zh1dUcXdBwhJtr7BrEyCQAmBSqG/6ek4SiMSxusI8IrkwRRGxiB+GX3B2?=
 =?us-ascii?Q?+2sHGsRk/jjz/11heOBKocmeBgwj1wOAMPtOqcBkuEY2uMH1LA5P6YF9p9AS?=
 =?us-ascii?Q?R5A8U7nA72fqFesztPlhXXgijx5td6IzKfxn4vK3vVcdZAivOrCTOat7MUYr?=
 =?us-ascii?Q?fjYcyVl/80mqrVGIHHyUSsNDuNNPQJI9x+oaZ60/3w8F+hcwN/Jdafth1ekS?=
 =?us-ascii?Q?Gr05KnF+LjAcoF8P7TGwMMrFaIR0Ke+dsDQQDdXIIo23ruOeJdGWr7ugV6nb?=
 =?us-ascii?Q?mlgTB/h/jmXzlRlfFaApPkCC/gfhia0p5VBPHamlJAgAbzGa4A7REazpl1tB?=
 =?us-ascii?Q?u07FIrmgDiz81fqHLBFlX5zhSXhwzhyON73d99PgVk/1yI5MPR9tGWQ2M97H?=
 =?us-ascii?Q?P3HqFxInlB3qRi0kYFhsaisfIRo3xi8Z+6DQuSneXWJSYuAWwHpwQZI1pmRE?=
 =?us-ascii?Q?qz4T1wSajHYYlbXeGJyMkFgZSxlS9AAEoaoFsJYUbtsUW9chwwaBXmnUavNm?=
 =?us-ascii?Q?qUprGXb71TmBdIFgwPSrgQ4K0MnkxXQHR0G/urrRtnnkuUq/CSOl2mQNRR5d?=
 =?us-ascii?Q?eRsjtM+1XPgPzxF5ynDA0nb9hqoaA17RAoJESq4ZI8mWtHSaWBGzb3GhJb4E?=
 =?us-ascii?Q?RuX5Xp7fox6Z1ro1n2tCbYx/hNw/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ievnt3mY2i5B7lQoZrz0hJjXq1Zdb42RAeXbJER9nGSiLa324RO0NvvpqKqQ?=
 =?us-ascii?Q?suEF/v6b07n6Ibdn9/OxphKbS0SwiLobIIc51iTW3P7FksOc8hcVieiCfJ5i?=
 =?us-ascii?Q?ukbFjKzJtQz8X5s0RluYu28BqloiuUpABJVs2p3HxrkA4jBk5IyjRysoMKE6?=
 =?us-ascii?Q?mTbeIk5q8k0fCUQnIsfOjlX6NWVfh0+SwahpmccWBId/qOVRmU8XeU9s9eDz?=
 =?us-ascii?Q?Js1GvEj2j15jMnp6/Nfgh7B0yzFr2fWTVh8TZ+XoWpSWjUIpG4BTrFc2hQe/?=
 =?us-ascii?Q?Aulleal10QDNNRH66EdPGtGFmizf9PrBrT/kntaIlxTDyDyGB0hWF1b40ks5?=
 =?us-ascii?Q?XTTVcdAV2G2sWOaBRuCJ5FBoQadvoY/AyBUequ2p+ArzjgaRrSgnn7t3XBIn?=
 =?us-ascii?Q?RsnJwK6iae+DO0FR2/mSdAUj6cBFsAjELFuwxN5gcKvZJK6mYaVHQgqFhxig?=
 =?us-ascii?Q?crkkxHucE45ZAie+LNLwhjY9yA5wsf4vPOKkXDdD3wvXZGnNmLa8fXIrm7Ho?=
 =?us-ascii?Q?OCG4LMF3POMoixxy6O71/AfMkmU1mKmZzxS8WykyWb4JLKCNhpUJKZpA1b8y?=
 =?us-ascii?Q?4wGCosvHUoqwTDYFGVLyuWNvwImKCxcrJjiJe8XCiKOTYSQcV7gmrn8jF3fV?=
 =?us-ascii?Q?5ULkTTAwijTM1+Ya8UgZwiMXdrW81ZwRw+3Ri82aduVfRsS+keJnXEt5AoXA?=
 =?us-ascii?Q?mLRpL7PaU5P2G2ZUGYUWKT9Lhw/7Ij68ZvIQD0Guzf21leNHNCB9y5N01CeD?=
 =?us-ascii?Q?joBzOIq6c1Zusbgt1C725KyDCJqKzPx2ETAs4TD56DfWmThc+RSSSAOtuw9I?=
 =?us-ascii?Q?yiPiSNwEuG16ri1CbKAQMA3IamB3MnpyezXxXgCERf3nofbehfe3BhVEen3v?=
 =?us-ascii?Q?OKWNdRr6MUgTl9hzNjmwmYPspfvfCJHKY3u2yZmYxsaEXwrtRKia9m39W7sr?=
 =?us-ascii?Q?5JdnthEW8Jrsc1cc1HZHSX19zgaz3vn/qxxTbfik1DhpxnJPuvEl+jsLobM6?=
 =?us-ascii?Q?7rb9UZnjAo0yx2Wm8QdLGsjGSDUohNler1urYNClJlAoItCDBM8ac1zLRuzE?=
 =?us-ascii?Q?LWf64I+X8zxkkAGibnnmuGLudu+WaWlthPU/bGWVK/SKF3puMWBvJZdYq9nf?=
 =?us-ascii?Q?Z1XWGrE76+6KcaH4nOSGgmkrX4AtKsKJ+HU2iEkFucvImd22hNoCuBxzl3Gn?=
 =?us-ascii?Q?1geWd8Rc2epHmRegB0Byh4hJysOdZk8+AJwkvvbo002hFCLgFwNi6eqQy601?=
 =?us-ascii?Q?oaGekXf4648J3vgX03paZlJjPMV8lz7QmJf0Bo1PVihRTfee6dzncT8qAuGc?=
 =?us-ascii?Q?1rDGhS6tW4NTSPs6Dx3qL0AoGZNfT54CnaAB4cQbL0zqneqFviECx2sA2io9?=
 =?us-ascii?Q?W9Z/bxuFLjEg3UinyFiyoiHpXrxciz/k/S4kGMQD0gkKsKRA3bwXngDQ6ozz?=
 =?us-ascii?Q?GhdcHa2CvY/BSqe0/qSJnluUCM2NHMPOhVx4WVRC0FK3wBXYy6B7XFLbfUub?=
 =?us-ascii?Q?lapuWhbD8MSL2tMHuuWk/FARqEQfgU+qTiO5PuXi3cnuCHUQZny52DdWRP4K?=
 =?us-ascii?Q?E7tZo29jSrYKW5fVIyP82kX59nCKFo2udZQVEP8tVw6dKAYWFLdbaD9EXWx0?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf62f41-f652-41e7-339d-08dd03803dd6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 01:12:28.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tahj0rwKXExyHgcmjD9pjHrhyV1YffVxLuVz6LSdNTJpS9mZNCIbXdyjRh9AI8bZXSw7nz3UsW3UnFSdmYk+9xVtUJVSeIyxk6vtFYCseMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-Proofpoint-GUID: NSRmn4ORAqpBUX3toy4ODl7_ewO4N9lI
X-Authority-Analysis: v=2.4 cv=Ke6AshYD c=1 sm=1 tr=0 ts=6733fcff cx=c_pps a=6H1ifQWhBrriiShMtbI+RA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=i0EeH86SAAAA:8
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=t7CeM3EgAAAA:8 a=XQwRP9gPe-XL7FU9EZ0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: NSRmn4ORAqpBUX3toy4ODl7_ewO4N9lI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411130009

From: Li Nan <linan122@huawei.com>

[ Upstream commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6 ]

In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
is intended to confirm iocg is active when it has debt. However, warn
can be triggered during a blkcg or disk removal, if iocg_waitq_timer_fn()
is run at that time:

  WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
  Call trace:
  iocg_pay_debt+0x14c/0x190
  iocg_kick_waitq+0x438/0x4c0
  iocg_waitq_timer_fn+0xd8/0x130
  __run_hrtimer+0x144/0x45c
  __hrtimer_run_queues+0x16c/0x244
  hrtimer_interrupt+0x2cc/0x7b0

The warn in this situation is meaningless. Since this iocg is being
removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
is canceled after removing 'active_list' in ioc_pd_free(), which ensures
iocg is freed after iocg_waitq_timer_fn() returns.

Therefore, add the check if iocg was already offlined to avoid warn
when removing a blkcg or disk.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240419093257.3004211-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 block/blk-iocost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 772e909e9fbf..12affc18d030 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1423,8 +1423,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->ioc->lock);
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	/*
+	 * make sure that nobody messed with @iocg. Check iocg->pd.online
+	 * to avoid warn when removing blkcg or disk.
+	 */
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
-- 
2.43.0


