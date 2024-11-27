Return-Path: <stable+bounces-95604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7639DA4B4
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67251B27043
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36919258C;
	Wed, 27 Nov 2024 09:22:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290581442E8
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699342; cv=fail; b=XbcMS0vtIjzU/J0/Se6AS0fnYEUIMGIoakroGDENsRb58Bxw5RwcotBs0T2Q7iMBfnD/hnAdxq7tIXXkum/CXKSOk/hhJH/umnqBOKa3joNcDDOsKhW6Zad77bmBcDheNxlxJ/ztvIqYZaSlTgCFftEHJdByEffQpgefUiOStmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699342; c=relaxed/simple;
	bh=OOE2jxFlRLxMD3odP2czMm1d8TQabEn1s0QbQRlIaBY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sda0+CeZ40Wj0vQP9u9G6Ujk6H5xS0f9cXpeUPYooqLaQNfhwsaoFeZofD5XtJrFTBNa0YRi8CzgNCoICwLdI0d7wgFYYFou666UDCMW838VfFR79S2fJK6i/qEhmcHOFEA4ve7intQC1oK3flo8Oa4iJUqRuNwsTbRsBb/KDRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8s1fB018415;
	Wed, 27 Nov 2024 09:22:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491ccyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 09:22:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrrWIqLkAfErurGCAzvqBPHjOkgbsSlDuPygBC4VKTY2Nv5L7UKtEfNpAMs+Yis6NMAZgwlRJQLPAI8ypzQBMfgBv9BACaPtDfqONDvHg7vx/9AG6UHYGVq9qh3xey/QdG/oLamI/l8VDuLLKq6j9TKvYyWb6iRwDbGj4xpZogdMbwOXJC15Wl+ExfF7mnL0JJmEe3QjBeSO4rBxgcbmGwGSQ+0rQPU6O2TsH6EfnTy0aLbg7hO1bwAem6KiIC9b533GCF5qoKy/GJ3HoR+grHUNcGZov8gKTu/iTD8w0lPpd8CubW1hpVqLZ3BisyrwSnhS/vNYHljXQjoGsk5Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyLx2E+n8K0eVL9ck16JLccgkVsfvIY27YULpWD+7dA=;
 b=uwFE9Sb3ESOp7tvnLuAoylfK0l8cJM4bN6iQ0zk6VWUmx6PRw4l2AFBYjzUs434QAt88o7k6fjc/OZZzg7OlYXpmNbLg1iTVV5H7jUMog8fJ4WF5SGVPjsUyvDz6WiLwGnS5pGdd1ZY+BtIDumpgyo2lvLP2ppV7BMHPub2rCNOSY0uiF/THqt2LkbunXgQMTcY7AFR+5nT40R85pX+eXuYaFOokqIEH5/PTO8rd/tAZ2FZXqu8iZ+iAMJDivP8uvPUiRuuG/kqCjGfuRwEilMROgR1cesACd1kWCifuOjHSUWphHXVdVIIUU3/8C6ohq7fR/u2nfyz9EpS1Fdgl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 09:22:12 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 09:22:12 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: alex.hung@amd.com, stable@vger.kernel.org
Subject: [PATCH 6.1/6.6] drm/amd/display: Check phantom_stream before it is used
Date: Wed, 27 Nov 2024 18:19:50 +0800
Message-Id: <20241127101950.1190303-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: cccf5344-951f-46bc-d0ce-08dd0ec4f9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQV5hv8cFim0KSYD6df/Ztfcxp+YXu9HHM5rSNFx6ESVv+zVuYS0p/1SWu2d?=
 =?us-ascii?Q?YSIe29s9fmAPEqfQrYnv+3m1juUx390ERL4jtoJQ000PVFn2D30vsWZA7cx3?=
 =?us-ascii?Q?J0fv5HL9hByUtJYmpT9PvKocn4okkZt68H73cadUDHcGd9AWznzDH8eZLBWD?=
 =?us-ascii?Q?GtTgptiK/WnD7LRpfhEnvHj/XH3mUeRrhUPamwtkipxiN62yloIpxv/u/JWM?=
 =?us-ascii?Q?HbrXhVKs6SrgONLwLFmra4t02iKEkoShjJO8xm+g0XSiq4kaYbwln68Rohsa?=
 =?us-ascii?Q?lOCFdLyXykpomu1xQ6r7hVNmHMh4qBLiR6DKOiHwvl9yEuV7lJ+ep7yiTiuJ?=
 =?us-ascii?Q?yyS1Xt32JhQ0SjtgMfNZ0PZmLzJbE0Ap9WQQTnvV/fv9OEWyvTV1aFGBkwA2?=
 =?us-ascii?Q?Pwe5WvwNHF/ZT5IKwkLyhNuG9kp9xaksRy3k1RF035vIJmbKgRYjietZaPME?=
 =?us-ascii?Q?sVHll4dDINak6vzZinib3Mq/fM77sKtrjCdFr1I+kd8ZrlOxVQx6l4Z3LXs/?=
 =?us-ascii?Q?UeFHBF9AAgv+bJp8CHl9m7EMFyK5xIeGXh9e2m79npl+6LnYmRxaIWBKnIOX?=
 =?us-ascii?Q?e0HagVh0PYuUysrCM2KUZiWjeAo114isQlV0QfYh76yDlL1RvOxTOOmnoC6z?=
 =?us-ascii?Q?mYSFn7+9dhgg6/dp8KJ9bnfx3LR8rwuZj9mkciuSWRl+gmYWub7SPj0vI3nE?=
 =?us-ascii?Q?FRqgxl7tTkC419hggSFrWAbQHCYz78dhPBKQxvatE1GYv0VnvdqD9G6fkExC?=
 =?us-ascii?Q?a2dJtWSXbHE0+aZtBuWzZvb8wAN2TSHxc6nYqbB1cEpvWZk+d4Q9mQ+SyeeR?=
 =?us-ascii?Q?AGLhSQJ0rDd3qffy5xuOGWhkfwD45/9rIEc9uMatdmy0cN6Ir/V4QRDTcmVf?=
 =?us-ascii?Q?4QEK7EFzWBPZYj3pb/cxIBIdCLikfE3Te4qhicp5O+MNbiZEk7bzQmZ9qWTR?=
 =?us-ascii?Q?4W8NZoRN0J4GKLeRs+EShQdnLfCu5UsuljtdWPyZg6nJc0/8oho8Bwazefaa?=
 =?us-ascii?Q?eoPM3qH+IyvBcE13tV6aScumt/Nx6PNzrR+SR+C/+Szjv4wos2zVzfdAZQha?=
 =?us-ascii?Q?rNT6uRouJA1CcEq0adaC2a/AaU9ukdPnJVFMrz+ANg9tP3imtkL8gNDFWi2Z?=
 =?us-ascii?Q?myhPRkspEKkFjk2AQ3vDiTZEFQafe7dwDqJQ+N6wcVEDM2b1t9AkG3ZJLsoT?=
 =?us-ascii?Q?HH4ZlBsA+1mr+PBkrRZ+29VfQRMnAOcUPBUists00bqQ/vyVa6Hd24fpKr1U?=
 =?us-ascii?Q?aBpkDVaIpemB8pJIG6nualXL5qP+7g4avhAekbPJCbQSogaBomxyhwkRNAKK?=
 =?us-ascii?Q?V7jCBv8iwTFFhgE3zXgO4AmERXuDOUkXaVOXnjA4E5YTgN5+fzDX1YN798uN?=
 =?us-ascii?Q?pkP44yfpHCRxevOJZtNSDe/EgbgSTR1qw+QS9dbS4qMS/cT+9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ed+n+sJjnK7CabexBgmJxghR2mGq1SQr9uoqdqRYUBgh0EJnsYpjAIwI5Qkq?=
 =?us-ascii?Q?uYL4zw1E8cZzm1kjqAGa+gDVP/ijLrleITNi7DZTOqyK0W1to9hJrnit773E?=
 =?us-ascii?Q?XHwaqy0paU3xNX4NH5m7IdFHmZdxqfGaB+7Yb8RssyAkFJKTacDqrvv0bq34?=
 =?us-ascii?Q?O4+2L+wH6DHOjPzroXgl+O5t2icBp5uJibY4dM4FDPEB6F4Pwe3nVYLopnpL?=
 =?us-ascii?Q?E+y7wl+sfg+Zx/9cTJMutK6P/D/Ys+bZAzwlO5XIfFiohEdNfz7TvNJsETZw?=
 =?us-ascii?Q?Iq187QTvuYay3oU+AdPYFSW2CL9YJi9LnUC6Oqf8Cc2dMpNuo7tPIAmIeYsi?=
 =?us-ascii?Q?7nKEcS0a8sQqAKcty8sIuTUNX6RhixDGeDo9Sh6vKbY28XYid/uJWiHNPmSi?=
 =?us-ascii?Q?S37AJd4oWNREH7/o5oo4I6ZCddNO2RtD9qRTDoKbt5YOgaqNp2PqnnpCn1DT?=
 =?us-ascii?Q?QWEdCN5rEvUYcYEwEXw0Q8/DLwKNNfY9NJR45wnDI4rK9bEUMfYoiX9sZrzW?=
 =?us-ascii?Q?DkIvRLw3d+2DQeRHWRi45YmChj1QAlyA4mJvmMQJCWC+CrYwmqwSalOVX9yl?=
 =?us-ascii?Q?XlSXuDRsDs0CgLX7FU2tSX7Tj/hEQgQix3h5GqRGmONs6z2fXIihJpGPugy+?=
 =?us-ascii?Q?nXSbtUbRDKUQaOHFZAcWD8TsQe8cIePrIKLOZ0F0SPZh5WrBhHJOVRtzEqye?=
 =?us-ascii?Q?3o/xLRZnJTuTUdaWtKNuwlYZ7eIMPbMVArDgILQrIdUIiUpb/Nhx1+zRaUGa?=
 =?us-ascii?Q?X04dSEHrMmuU5pgrAU3wv8WRUGFChTKu2I2LWhwvqwBT1TRFZnfXFYyxiNgG?=
 =?us-ascii?Q?ZOOIdG3YDwlneBkHlSWlvD/Qc8ZmfLlftSQb6FL6RRDDfZABBGDohEvuEZho?=
 =?us-ascii?Q?Nmvp4bRPPRxtYOAJlTkeVJabvqjoQ5xo8o3OeiUgBQtmgNSnRV4SDCjTSa/B?=
 =?us-ascii?Q?l8cBafyJt+mWty5Z1iFgVsDOzYTAnS1ThbA55ZUrPoIf95gfTkXQKR3/+jM3?=
 =?us-ascii?Q?pirXCPxzBwff/NmTFVys1CHSTVgT1DRJ4PZZ6EskIMir7yoI8xXslWztGb7J?=
 =?us-ascii?Q?cTVGyti32zNn6YZimd2+Kx5rNEaly0bNHk1tvZQnbPtgV2zxnGErhGjYc27W?=
 =?us-ascii?Q?tt+r5X/EcE9fmXerFTsyUwiKfiAptLhE6mXrZ5+mgraK3aeiz/AIr9Nyznv7?=
 =?us-ascii?Q?4g1mRp/0i5GrdrgdUyjDMopcjzdKIZqRgvcv8TKLIwOXjLOY0LbDPF06V9rR?=
 =?us-ascii?Q?B329PgV4Ia4yVHI7nkkK+kNv/mTG8Rw9vF8lYWrR6zOVn5ddL79j5x/NSrdz?=
 =?us-ascii?Q?lWD0CsUaZ8VE9rINStv2MgEWL0p7dOhinZRwgU1J++mWB5fQwjvJv20bWmhe?=
 =?us-ascii?Q?Jh1FSI4r5wuErcrW6K9JDc+6AZRIedT52nU+zNiyWluiWQhMUqoqq2DPt72h?=
 =?us-ascii?Q?Y019qKzti73sEYS31qggZ1n5JnsE2yMRLPiJPYx3yn8YjyDKaBkSQiA961y3?=
 =?us-ascii?Q?FKhIb2lKaudPVykG+c/0I6W6qYynbqvMQ2YxTDM8FC5WJ2jIrFax5ckogdKY?=
 =?us-ascii?Q?7Bv4S58q1ZfhPH/VeIjvX+G/mrC+pD9eZttRWIxpVezjxVcsqSZD4dNWGlAV?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccf5344-951f-46bc-d0ce-08dd0ec4f9c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:22:12.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4kgGP+tFDyPqFM5QBK3tChUMP87YbQf471fPmMHdmMj3XPE44DOWRCi7UogsHmfuDN+ML7ewX/wb3HV28qR0bRTfr7X5vrafGU99nGjglE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6746e4c8 cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=4FCZArr2oZOFQV62Mu8A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: 4JzdKUeIVYMXTsKzKGLlOwqZnEByA4H6
X-Proofpoint-ORIG-GUID: 4JzdKUeIVYMXTsKzKGLlOwqZnEByA4H6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270077

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 3718a619a8c0a53152e76bb6769b6c414e1e83f4 ]

dcn32_enable_phantom_stream can return null, so returned value
must be checked before used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49897, modified the source path]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2b8700b291a4..ef47fb2f6905 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1796,6 +1796,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
+	if (!phantom_stream)
+		return;
+
 	dcn32_enable_phantom_plane(dc, context, phantom_stream, index);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.25.1


