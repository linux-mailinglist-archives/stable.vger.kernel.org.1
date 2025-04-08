Return-Path: <stable+bounces-128820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7CA7F4C5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B9179468
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434425F99E;
	Tue,  8 Apr 2025 06:11:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7425F98E
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092685; cv=fail; b=EOKaXkK16kPzPeVsGGIbQ+hV0UVyGjHrqieGPJWSWL9j+Cbtrt384WCykhsrAXF4++b7Il6+opVkg+4sWFtsJMHiMDm5OLxRhR8vWvp7Bdo8wnS0vYMkNQWjhlYgky4ouESsf/nJfQNTsM8U4UHZG4XpRzSgVw8GjoxMHCrLC6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092685; c=relaxed/simple;
	bh=AbmmfEYPhbMrh0h3iiqCiPHC3mcH2KgenXzNiyct8Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PVKaL+RjoIf2o/dQ4Qk6uXnG3H7NFgo3gDr9nnmMmcJO+kcEnEzXxE3cFW7GyPhBn7dpT+wpyMfmtx9q4KOmy9+CLXq+gHVJG8wVD9vYYTN7SP6L61d4Uj/eHEXhz+GZLHkL7+lvbb9LDrgJFv/cnIXroQUTn0569DY3E/nCdQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5385Fl8a031183;
	Tue, 8 Apr 2025 06:11:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tug8kd83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 06:11:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk34MTRWSTDX0JKEadrn8RZN8Km/cLZ0uWHYSX2shkLd2jyhYFf9G1WC6xrAOuZJdmicU1QU5dOMboarg0cvFkXLNvaFLIcf6KSV+Zp5zHHlfB0TK5Xnu5/ne7LQd3Ih8PTVLyCYhHd6kdOXDf3dRujsrFiPETcHb19IbAQTDH4+s/q5jzwx8HfYGy5gxN5uOR6hQe29tyraX9Z7d/1ta1iUpl2WHEZQVsyx6pLztp+NFR9p6HOEnJhqIgykmSHm/Na3WuEN9nDwc0q0QT6x/6llqHLff8LlHzgcKyP9JOG5hGXeNbEFPbcjMmHPkN8zqNCVRwHWO7BMQuVvTt/f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2UY3foxSviQzsgKkVacyBWv8y0AE7frTKtPVFUe6jY=;
 b=Ghrudu1CKjwaLv9hN7Cpg3AFn6t/jCP9AnIrRjV5NitlApVfF8fiDKIWyPH4IVC10Ft3DSX1SAelVbz8i5n0VI0lKlTvvg1FXsaDx61DfURqlGnwsiHBkHZ8TwCX+ioQ2nSvrsJ3wwVpvd1lmBN2KESVx3W4D7a5Twttob5ACD7GX0YgdGd1HjDI8JnVjgtG28eSs40VVJB4coBe6rTi2DKAHR47BQ/CAIpQ9Gyf6Jl6CMmZBFXbyTKcAncsS9zmepGi9FLEnK7GBfLIJ846vfJoPk/Mz7IaYokIDyZw0yScouXn4syJbcCmFgMnMH9e1tI6VfBMRMjUozlFSnc+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:10:56 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:10:55 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: peterz@infradead.org, elver@google.com
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
Date: Tue,  8 Apr 2025 14:10:44 +0800
Message-Id: <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: b62f515e-dfe4-4dd4-95af-08dd76641f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y51q9EnlwwMEoDSP9Jr2H7UaoaUJwQnyTh3jXWuh8t2Hnspbq8FUivlvOXys?=
 =?us-ascii?Q?s0btAtPUDxAbOzXs2IIBQ6MGzVM4DffCKI39Q/YgeprVRqS19DhQ503nKq2G?=
 =?us-ascii?Q?peho8GGlKzPccO7njc9cqqr1V+FEwQtZL0yJfijOf7bWPH0Tsb6UzLeBU8K6?=
 =?us-ascii?Q?qVA9eFcW2vtSmSasMkWCx7GTnwOG8EzeDfdFX26hoOlignQke23EcVWgHpVO?=
 =?us-ascii?Q?30hiC6F3Kkd2GXhqH0W3rllJvEv/TXeseZZHMHiTzIq7j3QwkcASwGqdtLx+?=
 =?us-ascii?Q?NlOq/TTMlMK224eJQbW2WBlNdummb8uJm2ZYn9vH5lbXERHAkUmXsVJEWiQQ?=
 =?us-ascii?Q?boPmwUxMi7/wEp6b46LS1ab581NR1uocCykdqiZ99r2nr1TnudNL+GGoEGJg?=
 =?us-ascii?Q?H4GNsp3EjsjwW3ODHhoxKxUpL2PxDbvt+7sShKm0wOHqg1PauCpsQMftPnOT?=
 =?us-ascii?Q?QxBlNjjzGReT2DYayB9udb1RypYSNyEFu3BX074Lv9FalycG5ajXHCd7uNn8?=
 =?us-ascii?Q?fnisch+fZ+Z0EdnAa7QZs9tJQV/zOX1hFIwTa88G6yyJP3cDaulToZNXf3XW?=
 =?us-ascii?Q?pkM5BsH3gEDHGJU6WjUOp3xxubvgYJgMRe55lwUrg1RaOQOsqgoKNHWxFw26?=
 =?us-ascii?Q?YMYl0VkjNto6W/bjaOxTigILVSWzYo1vGuadVg6xIRxJ3O9GwPDZjXai+AVU?=
 =?us-ascii?Q?CfuS/llgbi4i1DNTuHAr21gGePfqrKES+y0Kuq2Q65lQmFEH7rbPlNAYmlhO?=
 =?us-ascii?Q?V6pXZQlnBXHWPxbQbyqR/ke2PORdb8z0KGKOgmzaqPrNLfF9fD4znzz2aerA?=
 =?us-ascii?Q?+WiXY8DwQsGT0KQSq4OVck0BRkpq00YkbHhuq+acPffiyVY+VszK1iOD8DmA?=
 =?us-ascii?Q?LxJ5lyZLSHSWkPJBfEV5wHei6YABjKVQMu/tyoE2sxiK+kP/Ib03/+hPNIYZ?=
 =?us-ascii?Q?4h5/YoOFS6ayVqFsNVbvkCLr8Ab2GNnhNKZAqvsqTwsiKOIpJgMpkhobtsMT?=
 =?us-ascii?Q?lX20aZaLckFesdNtGlEasfIZBRcvGBE5QYNPNeQprW4MMVq9owYh0VA283kj?=
 =?us-ascii?Q?cw6lsr2eRnvHs+qQ/CARgNk3iz2Vsd2io5CF1dS4p3+wUSLU7HdEQTvlNZIJ?=
 =?us-ascii?Q?3BhJadKCAMqTtYXhC1wNwFvptMvOSezLiRJodHvusImxnu5BHL7AH1yebutW?=
 =?us-ascii?Q?tf+ng1tNBh2rAvvNOznwSb+9WNE5ETh3xO6bwN9gWkc8a8nHi/ex+uRzF8TD?=
 =?us-ascii?Q?5HDbe6N5PhvBnhgveiszsPh4zaOX01Oy/+ohuPmerJIPUU2dgp9U9V1Yo3vJ?=
 =?us-ascii?Q?LWz8s2Dp9ipdQ7SPEdcr6vbX7aJ0cJKM5izKVYOuVKU+xEHXJPVgQSJgGKtR?=
 =?us-ascii?Q?NBBrbDP4YvVFM9yG9tMjYsPT2rcZ0VD3GM15VIBo9rN2z+s94QOj/eVhMtW8?=
 =?us-ascii?Q?rNXLTSGcPMBRcohSbzfeEidNxdC60VdH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxa0fpF1nJM3YZ4RVBLu7EWoeuZGcxEmXwLErGHSdyUVyFzXbVbChvT25ZYW?=
 =?us-ascii?Q?rQh7HuaHGQhwpKvKeTi5qlJ3JhFTBd0jgrI0pSlyDW6SjrE7khEoA568SHSr?=
 =?us-ascii?Q?39xw0u3CiKkGQVXcU78wtinW3IxtfCmTgbMTelUKUml1Srfta8Sf7vFR3rl/?=
 =?us-ascii?Q?yqP/K0ploQ3l0eLCDZhpl455ZwlmjBxapFiWOXhFoURyZ77DTF5w9rfcvTcO?=
 =?us-ascii?Q?y4dEGavvw12BjMZMk67Ya377lBX4j1WrBq+ElcLOyVX9RFJXqKuTYPtlIeag?=
 =?us-ascii?Q?iwUf/OkPMZdXgL5fALkLcdnVmn7lpYEZFKM2SeZytY+KYlgaybPoZsTOt34i?=
 =?us-ascii?Q?j89mIwYNUniiBhWWgxKs78m/eo9RD45Wo+bAn/+GMmIu4COIx1HDODOkuTut?=
 =?us-ascii?Q?6oX29aSQK2h47+OrbdbfoowS4SRM97Df02GE9M8i7aJg/W1vRkd7NCrialDW?=
 =?us-ascii?Q?YAu029FiBvl6M6M2z5LgRQeIlvu66f/nr2LuuS/CvZBQYEU/FEFag6SiyJEk?=
 =?us-ascii?Q?I9i8GCTlezvi4EmhKYBZ27KBiU2abKr8knysKy+DfN9y3m2zt5Ja3n/61ZE6?=
 =?us-ascii?Q?G85fDcZZ6ns9nJwwI6ws7kj5N/hmehsoCi2jRnLX/myaeV7RCYnIkMffSPYd?=
 =?us-ascii?Q?lVu2w5SlGsbGyleC+6hubHAu9xuxoW4+61QG50zN4bIzw5BoEf8HFabglPmj?=
 =?us-ascii?Q?gvDftu2wMRwte8Y+GL4uAVOC9oGUL1VAF+GtB64b6TfL/XKRiVhrpDO+jkbt?=
 =?us-ascii?Q?rDe0yaKQxJ/RhNF2kn/VoLcDY6yZ71+1290OiZi1mTYis2sIKpidrMtY/AFg?=
 =?us-ascii?Q?/KF3gyNF3j3UMmD2vPKk2Gi1/1cqaBho4sN+7wr1Rckq8BHmwIGxTLAMZf+o?=
 =?us-ascii?Q?llo98KIbHYMOvfWyPqDaZ5ZotX34W08qrKIebr6wCTuBG2WXm9EqD7pubByr?=
 =?us-ascii?Q?pk+7EEV8/K2AVbxUNaTGBSzXTq7bliZPQNazCfnhlBiZ4ezAhuRlIxp3WJDp?=
 =?us-ascii?Q?KDDVxKtFM8hn+/yXmI0sFq7RnYzfJzysvQIqAx01TOqm7D32v0xBaUSat7W9?=
 =?us-ascii?Q?GyD9puJY3s4pCOu8sldL1aTtGG57hPIJVa4H3mbu4y911hnIfXsJpQVG1JE6?=
 =?us-ascii?Q?ffsRQv3Qi1FKlmxmEJFriELbtn9q1dSTEBPJMAXvFivLQmckN2VQ622j95nj?=
 =?us-ascii?Q?/OEsfj8ORTntm0k/ZFu3c/8LjuMkAIaLtqwHC+6VIesi9Q84ScoshkbB20fj?=
 =?us-ascii?Q?zGSCKLy7iecI+wVF0YgHp6PgNEVHC8wSH5/eaTVQMXrpt3e3UevvgGbtoo5+?=
 =?us-ascii?Q?8HVBqB/p6+M9rMKP0EktU7A+ypAf5CFZqri32DYIIIhWGOlPFINKKOZp92Qn?=
 =?us-ascii?Q?1TGm+Ls7rw3tIBkScx66z4OJnE/jtA8KHp2aNSSXJ9ZcgpoTSu3NsHLPsFcf?=
 =?us-ascii?Q?R/DbMNt6NDrzeTq19c9qANKQpZBE9rBvU3nL9BCQjkl1KDpmj881EVd1KJO6?=
 =?us-ascii?Q?GdwE1ETBsA7D7DG0Rj9FLBi8DVn1TSvHWkt/E9WxEZV2dfF5enpMseGTeTfL?=
 =?us-ascii?Q?td/h42o/3W1xR6Xf6VoDAMcOkz9QLVjrkibw4CZxVJaEVdokOGc1qz+bY5gf?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62f515e-dfe4-4dd4-95af-08dd76641f78
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:10:55.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45ISPyzBmZzC/QxJ7619v+URurSWIEAXrtBOo5SLkOuKTWI5PmS8jdAnAksXuN/pq3Ff3pO9P9NiqtdOQhRebXavfVzDMVaB38wV+hgLxhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-Proofpoint-GUID: cyeriJw1sR1E77qri2-7SgIMf9MQ1-II
X-Authority-Analysis: v=2.4 cv=YJefyQGx c=1 sm=1 tr=0 ts=67f4bdfd cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=JfrnYn6hAAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=nH8-2f_qSLLOlit-Fe0A:9 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: cyeriJw1sR1E77qri2-7SgIMf9MQ1-II
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080043

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]

Per syzbot it is possible for perf_pending_task() to run after the
event is free()'d. There are two related but distinct cases:

 - the task_work was already queued before destroying the event;
 - destroying the event itself queues the task_work.

The first cannot be solved using task_work_cancel() since
perf_release() itself might be called from a task_work (____fput),
which means the current->task_works list is already empty and
task_work_cancel() won't be able to find the perf_pending_task()
entry.

The simplest alternative is extending the perf_event lifetime to cover
the task_work.

The second is just silly, queueing a task_work while you know the
event is going away makes no sense and is easily avoided by
re-arranging how the event is marked STATE_DEAD and ensuring it goes
through STATE_OFF on the way down.

Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
[ Discard the changes in event_sched_out() due to 5.10 don't have the
commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 kernel/events/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f19d6ab039e..798c839a00b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2419,6 +2419,7 @@ group_sched_out(struct perf_event *group_event,
 }
 
 #define DETACH_GROUP	0x01UL
+#define DETACH_DEAD	0x04UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2439,10 +2440,18 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
+	/*
+	 * Ensure event_sched_out() switches to OFF, at the very least
+	 * this avoids raising perf_pending_task() at this time.
+	 */
+	if (flags & DETACH_DEAD)
+		event->pending_disable = 1;
 	event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
@@ -5111,9 +5120,7 @@ int perf_event_release_kernel(struct perf_event *event)
 
 	ctx = perf_event_ctx_lock(event);
 	WARN_ON_ONCE(ctx->parent_ctx);
-	perf_remove_from_context(event, DETACH_GROUP);
 
-	raw_spin_lock_irq(&ctx->lock);
 	/*
 	 * Mark this event as STATE_DEAD, there is no external reference to it
 	 * anymore.
@@ -5125,8 +5132,7 @@ int perf_event_release_kernel(struct perf_event *event)
 	 * Thus this guarantees that we will in fact observe and kill _ALL_
 	 * child events.
 	 */
-	event->state = PERF_EVENT_STATE_DEAD;
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
 
 	perf_event_ctx_unlock(event, ctx);
 
@@ -6533,6 +6539,8 @@ static void perf_pending_event(struct irq_work *entry)
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
+
+	put_event(event);
 }
 
 /*
-- 
2.34.1


