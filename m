Return-Path: <stable+bounces-93930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93979D213A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7223A1F21E27
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BE155C8A;
	Tue, 19 Nov 2024 08:06:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5A7F460
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003594; cv=fail; b=ZvpK6TSRuA1gk4PS1wMNJB6vaee3SlnzwPLE7K+vI1biVBtQnYaBKtqaQ+18fJ77CzKVmmq32V4fk31KWVBqCNMarOOqg9qYvSTjo/+gxl8l5B0dd5mAAVEjCKMFgeTcx7AMEQpBIOtE50+E2OhD4zMrbO6HwaBg479Z9/t3t+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003594; c=relaxed/simple;
	bh=XIyvpgnBVjz/0H57Ab69qFUh5rNeng7V3AeKYTZzI2I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mzEKxFY3upcU6Uy3/r8oPH1aeEUUqKWjvuwU92uS9DZc0LoIibzFumVRyYaG+LSfMG35hWZEgvGrnO5zw6qTwA9bpeFA8PYb3z8S0v5kGHM5xE922K2oby0u5uj4lBGWynVy3gAhF+NBgbG6I2pM4VhWNWsFysa7ILVHvK3ni1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ4E2i4005087;
	Tue, 19 Nov 2024 00:06:25 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7tmk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akZXWOxOWRQ0uxXDIIXJj77gGXBuvpkGRM6RjpTh4MbPFjUgwjluCGacxUSyaTWxdKJh1MD4I0psa7AafcV+wNWNEZeZC4M6/Yw3O5pS73jEPKCZ1PHYzX8IiDWx2aNp5BMdzDisq4mUflQu2j6A+9RmAWr9PPF4j3/VuHNq0yiSA6Sn3D5rzeMiWkaXe5tC81/z8n4DqK6TuJ18ImmvCN/GswBid94ugYLMKA1+G23BFXuA/PC3zOhnOM4ZaYNp8eKoti9qAXjdTj0q6RXa/CZ4vc+WuwlUtYibq6E33o/6pTFxMQFKW5Nbj9692mQqeClsE2/GirFlC+bUO8FFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrLvoqs6C+eZ4CTEUDBuLH0AXtM+IxBNKnA3+s2lhic=;
 b=avtrTwRGvqpa5UyPfaihDTWfXEHjwK/Z10uTPRDGb71LJv1Z1IDMM66nPY5/p63neGRVgHNhKZo3S56CyuLBC+SsQSTrClmKuQpixwcz8c0N4RNBESJbc+InmzLFeApj1j0WIMt5OB4fD8W0DGqRqGHkkd9SIiTdc5pdie4g3vpi/qCnfzDB8olTRowUJPboW29lALT8Hw4BK5bDCOsjgx5cDQD042GJEkXF6aza+4DvojGK510eoUcCDidWDAswg2gx1QvX79VZ6sB0N5rqlZ8UdBNpSr/nXoYgUBVIjRpJKOrm128I97C1aP5KV3darfEZvboGwFqVeOfxdN/0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:06:20 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:06:19 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: vladimir.oltean@nxp.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] net/sched: taprio: extend minimum interval restriction to entire cycle too
Date: Tue, 19 Nov 2024 16:06:18 +0800
Message-ID: <20241119080618.4010517-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: 836ed739-0ae8-448d-0f1c-08dd08710ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NM7RWjeqJqC336k0oGaZ7mNEERvlF8NzYkOFscOH5cYl3DyDEVAwMQzDVrLz?=
 =?us-ascii?Q?U3FwUqWK2YYmjs+COKTLLUKiVkI2Nj6c7WvkmUZKb/nNhsinreCR9jbC8/+r?=
 =?us-ascii?Q?G3JIycSBgY5oJqTKbBB5hftFVSC6/imkFmdYK97DdLwlY5oZZbcn0N75FP1M?=
 =?us-ascii?Q?40Gnqes4OpW+Z+sCC7XBK/aTuLCxz5Gq14vn2/9xuNquzBr+vTcOa4qlDXO4?=
 =?us-ascii?Q?mUZV9qDniU3Z1oD4EVQ2A7EVFKCRCJOfyYUETAKzTpTu0ocWKo6LQVRq9U5g?=
 =?us-ascii?Q?cJ/II4WulNrpdp61vLHGZ5I+2sLl+SpI4e1DB0e0R90Hq/DicCXsJy1wgt4Z?=
 =?us-ascii?Q?ELMShmYztSfyimYHWwQ5psStN3t5+MMko2imfBOpvlVhn6Fj4JEF6gCXrrPp?=
 =?us-ascii?Q?OnX/Vqh9KwP4iAdMdeqKz587yFsEf48dVl4aFCjbsPjQv6tAgFv8wjdpQpQD?=
 =?us-ascii?Q?EFXXTXsglpbWK0bi31LX3tbr1XNxcAlX/ipyG11ovCCeS5wRApXm+Jbhv0TA?=
 =?us-ascii?Q?3fa1uKNKwLKw8tYz5H25Zxg8x+HZFvN/stMXGkEuwTz4QkKwHpiIAvRTedjl?=
 =?us-ascii?Q?hhKN3YByVWK8WOZlSlHEXKM5bMrNKz5rKzAB+p2SIML9+n3OV7m2MmXe1PsX?=
 =?us-ascii?Q?STnAboN3wLMX5TQOiUXEqL4a8O6XXLVLleG0ZS89wdVrYUFVxCaDGlHx7BCm?=
 =?us-ascii?Q?0KCzVynwjjl3YG8TQkrxC7nUHp0zwLtb50JXX/FltP56Lzleu4TPRf7S13yH?=
 =?us-ascii?Q?lErpUZTNlekrKAf4Fp0mJLsHC/hyEYfSdqlZ1fWurB0w86EJdIgf6N4A3OHh?=
 =?us-ascii?Q?YRd6NFcYzv7k7iRsJwCW9+3m8zdUJu0mmPr6bo6S+6Ag339rsqhk8xGrj1fr?=
 =?us-ascii?Q?JyclFIjuX61NXSbVi57bM5vCS+2ZSf2tPtdsPlXtvbE876ydbU4PEft7fCvi?=
 =?us-ascii?Q?6YOTtzeMTxoxdo+RgU+GDIh+pWnq0UJATZ9HkL6lDKnI26z5ugm7GYAesVb9?=
 =?us-ascii?Q?V4ZLunStb2xnrP3iXjGLQOLlMXhwc57wcT0PNOT6CAVeD9IPTUlWZojNF/AN?=
 =?us-ascii?Q?kdOC2hFejoJKFuEA4GTiSywZh5YSDrEh3cv8DmErmoTGzeNJ2RhgVBv4WfYt?=
 =?us-ascii?Q?NOdtNJIwf/U57RaXqRW/74r/NKjtnfAJ4XDFMuGr0DoMhRmfXsWlne4nvaxo?=
 =?us-ascii?Q?XQbFOG74eKpU7Lg7UexfVS3rZVn5ukIivCM3qSJfTT7kDdljfd9RYDY6VDBk?=
 =?us-ascii?Q?P1tKoSosrOdtJMv5mfiOlgGA6sm0zwWiLDMpyiUB+If3LtBu20XkDTYGidjS?=
 =?us-ascii?Q?GiYnmu4UF8EgchNA82Jn7XIQwJRG5TWeqj0P3LvYqnkgkO1gAPvxkGXSRwUz?=
 =?us-ascii?Q?5tXJCnyr4Kqtyzl1mseMlwlQ4o0A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCzAARu8nsIyZPLnKHxlqm9DQiuXHRRBnV4Lkp3ajz9vhxjRHMCYeLw/ApAr?=
 =?us-ascii?Q?1YRFF0Z5XsrT+A01TLBjsFXoRJ9/RNQEaHWvm3FBlltERzjI6nf6WQotA0uK?=
 =?us-ascii?Q?qxtnS3kD+LYrP7gwK39hbPU1rb8HK/ELUmHjdIFjeSXBvVeX9r7FScwk+aNt?=
 =?us-ascii?Q?lq/jiQmD9UfUI/X8zlCq7kgsuOHQ19OBns9W7zQc6CwrNbaqJYdn0hdai34q?=
 =?us-ascii?Q?nSh9+mKUybVgswIgu11ZyXUUoFdXAxo+UqN8LSKf93zle0yBNkTew147jUFK?=
 =?us-ascii?Q?WJK/Oc44WH5qqfXCiya1eamXbhh5QTeyAkOF4m07b86Qy/aTbxaVhlwph2Bm?=
 =?us-ascii?Q?b6Dq2z1j6+gD4nmq0gTGu8jgK3tIKOtYocp4pvavcpLmjydcuk5Gl58RpTnz?=
 =?us-ascii?Q?WrgOtQijxZJ/czV8zC81RbVpgp3c1RStzOB8VSl1ks2z76k3usScG2YrFpGa?=
 =?us-ascii?Q?09Cs1zQv3jBlmuB4XZ6EItCrH0NRFC5pBAT2Mted5CMFORlC2H/s+rN5Z0KN?=
 =?us-ascii?Q?vAh4yGPC+famPDNPrkxIWmaMgUev81UQmCKlStE0R05CCukpY5Uxrnb48Mk+?=
 =?us-ascii?Q?rB5j5QOBGhbxLWqonMLcvT0Nwmu+XMElgE2SHzG7BBsMrRuVvvQcsw+EwiGe?=
 =?us-ascii?Q?gsRZAL1t8HgyxiIO0pmbNN1QBaYh1pHhF9JR+V7toKQxE24RPTwjilLccmvO?=
 =?us-ascii?Q?NpaHs4Vv9zWWgiIl1OZ6KD/A/1ZvQ19cLqqJz+aIbG4Wx8GWL70sQjFLoXkZ?=
 =?us-ascii?Q?k5LbAqO3MR8IvtP3r52m5hAwGVEL3zv5ew8+3uz+DnPraBw4yHy3VVjOfJCn?=
 =?us-ascii?Q?TKL6Q3wP7emwE1wKyBKtR5ALZ5H5gy+StUyhw/PSHvIwg7F0q1gl95aLf//N?=
 =?us-ascii?Q?cGacX4oUCwDk2x0urn4988Z3NpUL1HPdn77DdolPjlPgaGFZNq/iLB6zXLPB?=
 =?us-ascii?Q?B3zO38sfgfd5Z9vbJ/UnaoIYop4jweGn+V2YTD4AGJ8zQe+hby5PY6ixW6fK?=
 =?us-ascii?Q?ZisFtY/mVpFpz58R+Phxu0I58zTbxDCXIj/Fw5Dxxz1o+uyS/Fq4JHEFh0iw?=
 =?us-ascii?Q?tmTQWqpEMujUJ4IgjHHkI82qeMUDATYgNONMC5zBmN5xe9i4mlrhPAVrGASh?=
 =?us-ascii?Q?wwEOJF9DRYpHIkhqtD2SVIkY8wr6+TLZrqEb834Db3js5DYy7w09sZR4xvkc?=
 =?us-ascii?Q?sfl/f/jXwjF8FH4WPXQqGcYdxkl/D0vOw5fVk+mqp4pGAJcvj/QLJDXmezsy?=
 =?us-ascii?Q?wXETVuf853yE71yuXFkx0eWMNFctTTgsAgF96S2eTzOAUq3ajSQzteOFJsLg?=
 =?us-ascii?Q?QbSzUClaoF8qCKvv77IqAZulCKoo5ObsyHl350VAxngcvMxxcdxMM92Lx4yk?=
 =?us-ascii?Q?TnAysazcviu269y7OQMYbugAxlkehuKjVf/N1p7pGHz98TUiuf+/EGcA6QMH?=
 =?us-ascii?Q?6lpW28vd/b2GjravQ3PJMpErz3BkA6C/nHIUgO9uxRF78elrWb2xhfQtDF4L?=
 =?us-ascii?Q?lBWxxKMxQK7OabOZha3jfgfbioeZLle3SpfVUaCrw/ZA1V/PrDTp5w/2Vkbf?=
 =?us-ascii?Q?ZUUZW7nng6OtW0t5ZvDNgR4sVkrj12EF3atiAXFxDu7GuLTBVGeDoTqpSToY?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836ed739-0ae8-448d-0f1c-08dd08710ce8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:06:19.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DQaceRp0Ih1bnA+sNlGWYGa5PyeOAPTNbeMTKevEDw2kKiWf2H/ruMixpo510Xgh81yzcBKapy1ZsVolYEg7UZBmFSA+8qRkemeI6BjZS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-Proofpoint-ORIG-GUID: pIexCwA0Vqby1IQCGJVnPFtcSuB942CB
X-Proofpoint-GUID: pIexCwA0Vqby1IQCGJVnPFtcSuB942CB
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673c4701 cx=c_pps a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=8AirrxEcAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=4hBp13tpU9xOdobRFKkA:9 a=ST-jHhOKWsTCqRlWije3:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190056

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit fb66df20a7201e60f2b13d7f95d031b31a8831d3 ]

It is possible for syzbot to side-step the restriction imposed by the
blamed commit in the Fixes: tag, because the taprio UAPI permits a
cycle-time different from (and potentially shorter than) the sum of
entry intervals.

We need one more restriction, which is that the cycle time itself must
be larger than N * ETH_ZLEN bit times, where N is the number of schedule
entries. This restriction needs to apply regardless of whether the cycle
time came from the user or was the implicit, auto-calculated value, so
we move the existing "cycle == 0" check outside the "if "(!new->cycle_time)"
branch. This way covers both conditions and scenarios.

Add a selftest which illustrates the issue triggered by syzbot.

Fixes: b5b73b26b3ca ("taprio: Fix allowing too small intervals")
Reported-by: syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000007d66bc06196e7c66@google.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20240527153955.553333-2-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/sched/sch_taprio.c                        | 10 ++++-----
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 22 +++++++++++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1d5cdc987abd..62219f23f76a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -915,11 +915,6 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		list_for_each_entry(entry, &new->entries, list)
 			cycle = ktime_add_ns(cycle, entry->interval);
 
-		if (!cycle) {
-			NL_SET_ERR_MSG(extack, "'cycle_time' can never be 0");
-			return -EINVAL;
-		}
-
 		if (cycle < 0 || cycle > INT_MAX) {
 			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
 			return -EINVAL;
@@ -928,6 +923,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		new->cycle_time = cycle;
 	}
 
+	if (new->cycle_time < new->num_entries * length_to_duration(q, ETH_ZLEN)) {
+		NL_SET_ERR_MSG(extack, "'cycle_time' is too small");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 08d4861c2e78..d04fed83332c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -132,6 +132,28 @@
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
     },
+    {
+        "id": "831f",
+        "name": "Add taprio Qdisc with too short cycle-time",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 queues 1@0 1@1 sched-entry S 01 200000 sched-entry S 02 200000 cycle-time 100 clockid CLOCK_TAI",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
     {
         "id": "3e1e",
         "name": "Add taprio Qdisc with an invalid cycle-time",
-- 
2.43.0


