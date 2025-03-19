Return-Path: <stable+bounces-124874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C2A68355
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 03:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242DA7AAA7B
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE8145A18;
	Wed, 19 Mar 2025 02:50:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CA17E0
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352608; cv=fail; b=qqpY+ZkVC6Abl+hNbS0PJu9Zwx8nYQ/0Z3EFtSX/mDD5/PbtIG8Ru8mncsToILD2WhUwXsr71VGVBDruIlEqPXdHTUf+YhNTopHtDmGdxmhwJq3gDhDmIXKgqQoxU7iVk6v274p8ItmWH2856DHTnZzODRrX9CIMu8FgwsucBhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352608; c=relaxed/simple;
	bh=NWKOEdxtz/P+vzHKe94afPMhzwThYvURp944jBRQhCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IncML97P++sfngt03Q07KEA0RYbljYUKe+8HIoknhh1iAW8jdfapXjX5xMoTvpfjSU/BvccoKgf/bOfa/3Gjx4aIVOcjE91xN+I+w9pBYA1bD50SAXAPPFBe5dhyWjzGEl20YZk29LZVRWlOFzGLCQo+wZL0qTIIE3PtP5xL57k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J0v4ue003329;
	Wed, 19 Mar 2025 02:50:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45cxs0v5bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 02:50:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkA2t8v2PE9mh0uHONXDcUrVmdaceWxENPMHjEpKiUI6gs859Bb44CFI8vsYjbB49X852V9MIVpT0Sr/joKdZK55y+Hvf4bLD+/1Pb86kxXeVbFqrtYXsrr3ScomN9P4KagO4tIYMqZAWfeKnJQPIhRqlmUGM0IIMuFH4ZW/WDmgTyamzB9/QAmchZPG26I+CxiiCx3iZWqB0QzRSUkpPjW/U/E50/Bto/wCIyxzZJjWoj2h48ColiQCpkEYwBznVqizItOUzY9PE9tLC2Zu/Cbvit3B3aIPxudX4mpZbg33nF7TmARJAALwL+LaX4bp1gNReuL4tyg38LwQD8k9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p91LB/QM8/nDUer5C7+++ecSE7cxbaKtu9SHhYAOefw=;
 b=Teq7iFtXt30lMnHHz81e11F0ov/vTZYemMgPWZMJ1GfF290JFTNxzam9G0EPzJ6EBnvBFn0gt/iu1/HvHezHToxhBSub97g6gR8PyjsXHvwADCfWRLRSYjy3zCTf99bEQ1OTNSPUiaz6ZKYwOqD8DoRYRe5yjLTnwATsHuYh7PTEn3tg5c4gtqf68hXuOQhW4zyTPfGd6VqNt1lWrpy+kB/6EaAKZD5zVqbkPpOVOjLXFNVzo+kFxkm+83/9vyAT90ZP/oD9cL3qbwkH3WM/T4jIa2e9Pe0Q/uxWAtC1HWual64t7RlJK/OgLbjcfsDlPnfN0xCoFU65uaF9EaBeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 02:49:55 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 02:49:54 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: yunfei.dong@mediatek.com, angelogioacchino.delregno@collabora.com,
        sebastian.fricke@collabora.com, hverkuil-cisco@xs4all.nl,
        bin.lan.cn@windriver.com
Subject: [PATCH 6.1.y] media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
Date: Wed, 19 Mar 2025 10:49:37 +0800
Message-Id: <20250319024937.530352-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:404::16)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 636c432d-a36c-4f9b-5c57-08dd6690ba7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsFDsQmvWYHvSuzvOjoKUdeboh05OxWJo612C0kWfm6lm6aDmjr90p66By7M?=
 =?us-ascii?Q?YsCbrnlT6R7xc/d6V0FVGzFatYj906w76KQO0B65W4YNmMor0sSIKYaEffHv?=
 =?us-ascii?Q?O5Fhyhct58VkqFs39pRQQ2MGRUPwTInQNZoFSJUzv4TCegn7sArnUIE9wl1I?=
 =?us-ascii?Q?SHUt6O2TSo6HYRW3fWOJAPX/epRAxsH50t0JM1Ux7j742yIoz3qJfV7rQZO8?=
 =?us-ascii?Q?GVoSmIUW4s72XhE8v8N9IUE91SPZYNp0J7D5jgvQeUzJaznqImSYR8YjfZhB?=
 =?us-ascii?Q?uOpNOhjKy34k/SOXOeXUWsHDEubDiytH6qtMuCM0ldsegaMjKnGQWTxp1b0E?=
 =?us-ascii?Q?26zclGHq9h86EEARYAUuX8vMFjTv4hmaNTHA2Ewe47fW24X9LtxGGZp3iOWC?=
 =?us-ascii?Q?5MxgRDnBUjU0xsdS3mslMy5+NPC4Cj563G0YYYcgjv2cLkCBY7rijDMccUwO?=
 =?us-ascii?Q?SSYlwfUWw2NBhrxbXuu0RL4nub5xww8DqmLCTM/BfwN6Q0DQNGhXKbMZ1W11?=
 =?us-ascii?Q?uRt4LbtDZYsa2ICW9mVaaUWS0aFC3fk+LELBSjIwslt769ICBqTySnIcsnft?=
 =?us-ascii?Q?QZy6iDPVgge9yuUAjmvgWgqEdm4eC6E1WFh82jDU9jDIZsEnobmRfRXB7jSR?=
 =?us-ascii?Q?gJyVp9TKp3W9P5hHspKi6Bm0xKs29KTXyU5bzbS5GIR//Df1nEch3RQBOV/v?=
 =?us-ascii?Q?6g+DkaYSGuq6oqgqm2DmSsHDSnH5ask8KXh/ztu8+0FNDmqF3dT6SFHrPjU+?=
 =?us-ascii?Q?orG2dGPHK/RIf3emWB6KbOWQwDdWIaS3azk+gDrSRX3BPTo/7CtX+I5Xtynu?=
 =?us-ascii?Q?pW4D5Bk1RyyeXx6wEuekzSoZFdDeVtnXP8QnBz7l3jKu2HC7eh2+OGrlfAe/?=
 =?us-ascii?Q?1RiK4rlRAtegS2WofmyQ2sXAqhSNx43/XotzQgXSk4vJ5+ZJ26YVFhf5znG+?=
 =?us-ascii?Q?YvLiEdQjSphrwnEKX8YIzeDZzqRgcuz07Ysll1Gqc4CUbRMTVfVdcfc2FIht?=
 =?us-ascii?Q?xtCZzzYlUO+7k0ZnnQ9PbGf+5n2a1zkeNJh8mLmptpzuMfFGTt33C/pg35fi?=
 =?us-ascii?Q?QcQOMfVRAMNRpBRInX6JcYHZTHjVrE/ECdYbGde2nlJ+iiksPDShguh6I42P?=
 =?us-ascii?Q?g37ep3ZZ4N3wswAVxLkwQqfkPiy7+pgBdbL6oArAa53tg8sHdpyKBBEvA0Zw?=
 =?us-ascii?Q?es83qdb9V5Z8Z+PJ+48F4ZjHtdDW4Yr8uBggwj9wQCT9YRcDvvGL7+59SCXs?=
 =?us-ascii?Q?PGTcPBlyGH3mtpmm0L3goqcXWF8WijXuvrAXTOBlTOkIqqkwGjPteMNiPZ+c?=
 =?us-ascii?Q?h1VBm5MVHmRBhDVed8TvhYRdhChP3lPYGaULy1OSl62faZXVUjSWbg84/8CE?=
 =?us-ascii?Q?88weTvV73iLrVW474HnGSzUqI2+z28aXHo2OFFYiQyvYMxXXEPHht+bkL51M?=
 =?us-ascii?Q?o2yffR0S0p1b+jVWVmZoB7FbSZaoEP30?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxV6Y5p85ohdjeg1qlEKPIGaVAnA8tGY9ejn7/Saf7d0bir3smKeg9jIuYRH?=
 =?us-ascii?Q?6BvfixXjkUPYn6SdjeSuPX1o5NIwT4u7rV5r1vRVkFLlF8Do64Wvb0tiKt6n?=
 =?us-ascii?Q?ZqiRseLPbcaHxzVQVQUNJQ63Kkxy9Uwm7IF6StqAd4e+0geebOTGjsSSq1bZ?=
 =?us-ascii?Q?mZEkWUGo13+OeiYHz9FhMBUh3l2d5aHU4ZrUJ2osNXoatddZ8rDsYD/nCeQp?=
 =?us-ascii?Q?JLJ/sSfZwpWlsre+OxIOIB7f3vVuumP+Mw696u7lUsJ89uAUcxD8ERiNd00i?=
 =?us-ascii?Q?UfTThMzviLXpjb6fLPp4VcsQMimmuBu3P5j0a38TcJIqfTWn8p3l5zm9aeDV?=
 =?us-ascii?Q?EezxnVwaCuaZWvvRKg0x5gRImK4dcnHgl0dhLN9VuZFpBYIVeiE1W9uSfbpY?=
 =?us-ascii?Q?ozOVW3DH8fVPGbL3L+0V6ZOkJ91P3DMADXZLqrNSVpPOVitmhnOMlFrCJ5KJ?=
 =?us-ascii?Q?63titLDXe6dGWqWzTopaGWHvpPyt7hKaJEdPI4KYUTZ6xi9d1SU0UmYs6Cyr?=
 =?us-ascii?Q?d+GLs4rh5hNuNnbgz1D5BmjfYtEwOGz9kJfTCce48XBDTWix/h5JaoElbsf6?=
 =?us-ascii?Q?Jm6xo7GX7LCW7zwFJvCJguRNdU50RatKFYNJOitJZ3QnJ3o1SqLPkigb4Sfp?=
 =?us-ascii?Q?L7YJv+k55PxHB4oWdAtQfK7ttTs6pSlvXyrS/fAewV2bnOt7XRtcQ7F9BSJc?=
 =?us-ascii?Q?Xb699rx5zFQFLIKzQG9G0lil6ZWBgi5yIxTVN3tCUdSz9lmZGJ91eQ/Ge2cp?=
 =?us-ascii?Q?BNWvmqgjFyVsmiIFf3wwzjbUVPtlRd0bvqs+m7R62DWCcscHtdDQV+ErIFfy?=
 =?us-ascii?Q?R6GtBAqO7BlNRdguFn//X+3qMKXA2bDiQnIPBtsaIjbULVuXSKBrcbQ9xDak?=
 =?us-ascii?Q?JaLKpplJRCirreTP+QzfB+sE012KC9Aup0kvFISFFhP1bJXXe6s4rYLNnk85?=
 =?us-ascii?Q?THkPiyt02KezDhQ3I85iEmlqOFGRe+ZvfWC0RhdaZW9BsxEotTe/auQoOUKV?=
 =?us-ascii?Q?l0ecJw/eLdgGUivZ7lP+vW+QJ6Z/MmXpTBs4xCGTnjFgbnw435lTFrjTVE2Y?=
 =?us-ascii?Q?Dz9OvGnRdXNgysA8KFCWxTLuwGNv6Jpa09+7uaarrFUKzA+giYTNzSM0b9qL?=
 =?us-ascii?Q?H6OoDJoAS8smxDyezhAGOl8iVlD4zXvyiW+lUohpx5N8lmUhGqrXpNcDdZcB?=
 =?us-ascii?Q?9P466O1Q11ffz/CwOTt16RkgFkM/UfZ49dMxkJFJQYEYux5Ohos6G+NYEHXE?=
 =?us-ascii?Q?Z8mmd+6Hd5DsbRgMUq+hpnUdPGFrGewVOYwsNXteqkzmDpckKycqEnW8kkZf?=
 =?us-ascii?Q?F937MvbFcgSBqSjP57q3TqJmhIJVtkaR3QzKXk4TlBI9n0ltTKIYNOGxdVw8?=
 =?us-ascii?Q?rUJrI9/Wx08DSWieHlDWeSBV8sZS2M0EV0Fe8bBEwaAL0BkVl0/Fjq1La1G5?=
 =?us-ascii?Q?LwwHW1kk2prs+21/EtvWxjYN/tjNTVvDD9JN0vuZTw1vRLLyuTj7HhY5peab?=
 =?us-ascii?Q?twtF4XXHGd7/943fDwg5JQDgQtHCrmyBuLN4NMQea+uV8hZ5wqY71IoDJquW?=
 =?us-ascii?Q?kbsjSqVhztKDEpzTPCfEpQ4qfZJ9+7EoCSsHpjwuBO7GQ2dvdrgPsGqG+FXK?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636c432d-a36c-4f9b-5c57-08dd6690ba7f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 02:49:54.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnAFnJaLzT0lXmNmK6cs+WJJ1GlhbHtfrYyu83ac0WymR1LtPiCPkei1MLWllOkMB4U9orxGMHOYOdd8mzQXMn6kczddueM0uNvSqzrJ4/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-Proofpoint-ORIG-GUID: pTnxXtE88BHkxd3Ky-u5eYEt0TgeFYQj
X-Proofpoint-GUID: pTnxXtE88BHkxd3Ky-u5eYEt0TgeFYQj
X-Authority-Analysis: v=2.4 cv=NY/m13D4 c=1 sm=1 tr=0 ts=67da30d8 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=eBMQqnqon-5XQPKEwSsA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503190018

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit b113bc7c0e83b32f4dd2d291a2b6c4803e0a2c44 ]

Fix a smatch static checker warning on vdec_vp8_req_if.c.
Which leads to a kernel crash when fb is NULL.

Fixes: 7a7ae26fd458 ("media: mediatek: vcodec: support stateless VP8 decoding")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 .../platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index e1fe2603e92e..22d8f178b04d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -336,14 +336,18 @@ static int vdec_vp8_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
-	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	if (!fb) {
+		mtk_vcodec_err(inst, "fb buffer is NULL");
+		return -ENOMEM;
+	}
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
+	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	y_fb_dma = fb->base_y.dma_addr;
 	if (inst->ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1)
 		c_fb_dma = y_fb_dma +
 			inst->ctx->picinfo.buf_w * inst->ctx->picinfo.buf_h;
 	else
-		c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+		c_fb_dma = fb->base_c.dma_addr;
 
 	inst->vsi->dec.bs_dma = (u64)bs->dma_addr;
 	inst->vsi->dec.bs_sz = bs->size;
-- 
2.34.1


