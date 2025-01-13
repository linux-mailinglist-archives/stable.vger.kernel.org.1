Return-Path: <stable+bounces-108448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DAA0B98D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB76160BAB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F341CAA6A;
	Mon, 13 Jan 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="AfovNOY7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E54D8CE
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778725; cv=fail; b=D6MNJycHFa31UOZUE/YR8bnLGh32qp3G8KUgkuH3IWzMO0VeLPhLINHowNB254gsZgCiZLOPe1p8p24KUDTzllFSYb1bFUjM3JeyBfeLzn31f9wmo580mn0i9ci0FN3YNnzPl6xPPW9wGGGMs9vhd3KozZOffAiHFn4f5/mPsa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778725; c=relaxed/simple;
	bh=7VeFFVTxYks/vWw1kt8Aozw+n59U+is7ngy2gSqjELQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSPjQwt7CEIfHzH+AvncnPJgCbt7I4EQVK5GOc5kW4J2HTalOzTf7S6HoW59TJK6W0P1Xl8bY5uBdcPa1H7537ClbMVWaFUltG0KBhcNx4TRCjiP5/yq7C/BGNcw1bQ89F8qBSES/63IYh7UzeVFkJ2FY9LmAin0M0qt9yeh7pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=AfovNOY7; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DEOjST032474;
	Mon, 13 Jan 2025 14:31:53 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17010002.outbound.protection.outlook.com [40.93.130.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h9a4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:31:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIwFyGQO3Ssea+xbtkW+ytEYKndWE99jHOaAuqvqCd9IxD67TJ8e5zlsaruj/3rxQl2XL3y9eUy4SIFKBOCKEp8TgRXlr2vO4QFxN96kPW5XY68oJlEqmEs2owij6AeF7PR45JTvUnDaQzWM64n2QPIQYJfz+pfiBpsfy4xaYhfOcWLJVLfyzk6j5retfJctmwSgzIS2j0n0L8MfN/tQ6Tv44xQmIdeTZcW3jhXvwaem2TX0J6rftvbPCw5TvjcRiFYPjhpBlqij5NvPidmOcjTeWsL3HLPMS9hft/vAoh/3n+nW+myXPxJCEjO10y9rvQfgwSWXlLap2jLCZYd3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJXRnO82SZAvqGxyOthOa+vGMxbWWMXr2wPBWRzbjvE=;
 b=ReAgjVm5wJycEceW/ZQx+TGicvZrHBrazXX9KmkHENriitUZF/cqLAnNQYe1elvCArQgSnFxxF/GB1Uu6d8nYzmoJbqEGbkfpLQVsNRtlY3e6XUccbqx1lyYq59ezH+BeHkZNg/StyUHLSrANhGC2+vyuYQT4ZSppEViv6aVnpNV7DjitDz9j5aJNisxJX8whgW28yye1Hzhiu5u6qmSslYFxXtkF+KEpxIVl9XemhvZeUNn+xKf6xlFgUXrxj8wQh54Vuij2FTJRnNNvKEsvPF8Ji7mt+Uw/hn+lXAw153W2cgb4TZMTwk9pezOY58Q7UNkPyfaH1bvGMSaDIOFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJXRnO82SZAvqGxyOthOa+vGMxbWWMXr2wPBWRzbjvE=;
 b=AfovNOY7fBpkcpRc0goLtexg/Q8xsx/gQVB7TS6Qfu4iuwZiic+td5gC+DG+w6bWK2x2rnirWET2n46h3KZywgqf1vgsX2SNGGn6HktRCiswT6bNv5eouF/06ONcWeLQQa7XVqun02VJerYyOz1r93KLfD0zqB7lWX7OpCU0HiW9/tNFFLd05bY54XpQaXsd+oD9p839aJds3A+oA/7vjvhj9PQFLIIfpNfuQS+rB9ShtCHmlZkR8/rFs36Llm4lae4dc584aGiNtAaQLUaH7p+usUHUZXIkSbBm6loUKqFgaerUHsO8djVqv6EDRQCySkLRHuH1TOGw3OnGM4ioyQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB5121.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:31:44 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:31:44 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 14:31:31 +0000
Message-Id: <20250113143131.568417-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011353-untried-juniper-fe92@gregkh>
References: <2025011353-untried-juniper-fe92@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: be8c37e5-57eb-4f50-7b59-08dd33df00e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NY+H+BwbfLPEUlrvra9YbG3TAtqUQ02wFBZOMBkLHnL7e2+GOlAJ/QX2Klu?=
 =?us-ascii?Q?L1EwIeZjIABKAyn3JzffufWHG1vjqEYNu2Ksrb8qr4craTYnoZkRhj7X2lV2?=
 =?us-ascii?Q?yJjAs76kzhumYzLOkNb13LmQ9MN/so0PMcYCb6saXPVyY6Ga5gK5rRvNKbIZ?=
 =?us-ascii?Q?Of3z8WHb8QuRuv3NSoqme07j5F77aSxOLwMX+z8/iSQ0GnoUZ3jj+NyE5/z7?=
 =?us-ascii?Q?p2PaR/QYKLIcfiuWVazAieBH4PkKphoNDiQ7h9kNumiVXW5AhUArmg5zPu40?=
 =?us-ascii?Q?n4ZUEgFSyqeEc5ZXVx+MKDYm5xWnjneMWaD+oL5vZiYjb3+4gfWyKtf/718Q?=
 =?us-ascii?Q?v4QT6cBV4pB1jdwsDZHZL+p9AO5ob3AU9EfwsBf8PVnS7FemHYzEh3IHbsMW?=
 =?us-ascii?Q?2jhQcZrsSSlxt3H5tjxuKD0voEMyZ6YxuDVFwOQPsfcYEdhI2cIPgl3dIn2x?=
 =?us-ascii?Q?cMOEy1QpcjLHPUioGRRL2SpQemKrYBpgrCf3aNChScQHeRTn7GxzICNO1rYI?=
 =?us-ascii?Q?PfoVqogJkGZvm3vllUWTqaFTdJ3o/BWFSSn7NhavhQ0BqUuG05xn3CweE7Gm?=
 =?us-ascii?Q?YjckeuZLh5U2GMlaU6nk0B0S3truRSaC3Do6W2ZjtKU6OxFMxvVeV2bYktUq?=
 =?us-ascii?Q?EyIKhqBlMeC4yyRovU0UHBY+tl6kcTIjqCBw6Uwx6Lq6uI3qxLux1/dKdkif?=
 =?us-ascii?Q?fXUFJR41DAyXyol72fKHTeo1c/8PGs3V9Lse+zvFwWvXdEX7160ucdDoYop3?=
 =?us-ascii?Q?MCJZGq7sH/R1dXHvfcrkM2NPll9oIStGMSRcJaBSl2houUa8iX3raqcaBFIz?=
 =?us-ascii?Q?Kxv90CbeTsbxG3MC4OqkokjfXOgGJq7XvidkNjfCI0FDLD4R/SCrlzy3y3ad?=
 =?us-ascii?Q?huGVC7A/mJYkq1RyD7eJRW7G58UIJDo+NbjrD7T4pT85u0KPAxYEfyNBDw97?=
 =?us-ascii?Q?Kqyg14uSLCnSQPedqaZH5FmuXNmMS8H8HhLWTiP6vxyFx08s4/W/e+OskmBo?=
 =?us-ascii?Q?HGA1X4ykCPU/4IHQYxNN9oERj2ceDqZgcO8yBDKZ21vFOj1wblzJ5tA/x5bp?=
 =?us-ascii?Q?S1xXyvk/4X0UXnskfOh2uc2WlUVgdnnqU6nlUErpYjcs4Pk7zmkMvv2oKipY?=
 =?us-ascii?Q?v5O6fapzr9VAcoG81/K4Badw0zLnFB7yoGXEC0p8pgkcYHFWEpbiTh17WZeI?=
 =?us-ascii?Q?NnBdXJ/9MAOVGisIc5EIpkYNckBB9WxLkgyt9R6fsTk8i8/4he2XvPJq62HL?=
 =?us-ascii?Q?3VmOIKjMCJzGRAFkhLXV1qNEkGFYpvPb3M88x++QH7Zo808aJwwDCzyPPLzZ?=
 =?us-ascii?Q?SshKRCUanr8mnOF0b82CMjo1g9qQgH5rVRPKB3pXazEodiO5QKAv4/nwTXYO?=
 =?us-ascii?Q?mf+L9/N/icHaaiLWrxOPlcz4ttvntkoABkl3L/okOcsi1WQuaqW2k1Gu0ODg?=
 =?us-ascii?Q?dxY2oa8t578=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXANxbJlxYGH1/bfJbTWOSyMycdkbCp8TIz2JlkCrssuJ3wXA4AnHINb0bOF?=
 =?us-ascii?Q?Lca8wF1hk1DBCYBQgayKl/e84PD29Qzzgh5aq9WHsWveM7pocn6BagEK76wF?=
 =?us-ascii?Q?Wq3SX9xX+mDopZw5bcwgSzxrc9iVAvpSdrBQoCNkgm/10kGlCb43Zh4tuDQt?=
 =?us-ascii?Q?ZVsdog6zn3wZa9fnWZpr0tNPNOVhK+TATQ2vq7NqhpSVERidq3W6PaMYorlf?=
 =?us-ascii?Q?ecXepI0lzuSUcW0/L7j2jzUF7olMa82mLH3rJO6QdC3ZpyKs1c1djxGGJrO0?=
 =?us-ascii?Q?UEDlOy19mD1I2DAi0M9bdofxB2ipzukbwgb5MzHiBQ30CQKWWjgti6lEQT9D?=
 =?us-ascii?Q?QxxqzoEK0E41SLV+nLV1eEKPtpw3KYncEn53LWjzdoWZz3+HzHmeXsMtL2Hf?=
 =?us-ascii?Q?Cuf/utN/Vu2pafO7vf2qYJDdBdP1B1BR9QYk8jdNyVIiUhicpdfbG3eNGYTB?=
 =?us-ascii?Q?VTdsf3kjZ3hFrE8PBs5XUcPmLp/kUma38JgaFa+XHhSjQJfoFKdgXWfJgov6?=
 =?us-ascii?Q?VinM/3PeXFbi5Al1l8n0BOZTd5PPHRk5ma5QG/S3zSaZzhBczEAVBTsvQSYX?=
 =?us-ascii?Q?3ZfqLkOlpfh5Jcw7EbWbc8J67ZXwQRrMoBOjl1vd852RsPqUYlFUdWlsUbmg?=
 =?us-ascii?Q?iOo/EtucYj0DBUT5CRH1PSfcLIJgtvJx9MnBIkRY2YZp+KnDjepl/u9ZQaVr?=
 =?us-ascii?Q?aDc5MGJhX/eMzgQFYIUmY2AuAGvPS5cqebhjMKgnEQf47NxDv4py8HIlw1L5?=
 =?us-ascii?Q?ro99pwaLgqcZ82lMpQP5yII97V9lUU+8CpuP6RKYizVoIPudgyK1S8Kfi6BY?=
 =?us-ascii?Q?iSDcR577+XVgU3kanjxyz821o3IbJCIXd5RKr1DpnT3mhGdCOggxfbNXPlqt?=
 =?us-ascii?Q?UuZ46jHKadNdxgFulnVk/mqarMkyTZwmx0DFSPo5AvtcZFrtdHOt6HomT/A8?=
 =?us-ascii?Q?nIskY/jhE0M+HQD0P6skziZc+4ePWxDC3tZ//GuPfH0qVgipqiLZRH8Fw71V?=
 =?us-ascii?Q?44mKIfwR+quJMu9s0UN5W2PCUh8wMXa7j3BF8m1RpczB0sOk57IpQAnsn1K2?=
 =?us-ascii?Q?FFtBWiGY/Td+9+N7dw+VXLuqk673xcoKJgTCW8tP9ttgtwfJXZBaWgXhSikP?=
 =?us-ascii?Q?kl97CjVO39diXUTaz9quJnKLvoSis9DAoZ/4BWVM2LB21LsFJmUf5rhslwx2?=
 =?us-ascii?Q?RWrg5mjt1Lbb0ydcrrGD8RAtrAi3gMNZiaubnDBLfuHM7HndQ+jM4WmhgpqS?=
 =?us-ascii?Q?TaSUfNOG/FY6LfthHzO2B5zICEyvLpVy1AECTxqDgCJXZs9tLZjUlbyl2fSU?=
 =?us-ascii?Q?WRSX4N1jRAK5WdOdhlGKIKxy6QcqoQT91MdSW/Os4oSLDLBqgF1idaHMGBc/?=
 =?us-ascii?Q?o74XT/OEhUkXKiNJ/TFvfKonON//Y6+t1KE+gDDkS/ISToJjG9oJC0eEhVxa?=
 =?us-ascii?Q?foxJ3qa4GHq8ccqL2d+CjX4YPG3cOE7JYO3s5lHYlN3Yylj7yADihPIvkP1I?=
 =?us-ascii?Q?rPqOPcworY3mS5GuxaXUdHyzM8jIGuw3l61lJmDk3SpwccdP55EYbMYE6mJa?=
 =?us-ascii?Q?nUy8kmSrzdi/KURkl0KdVKZkowwZIjN2zplwt1U8?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8c37e5-57eb-4f50-7b59-08dd33df00e3
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:31:44.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaCfEnYywA22HlBT5zzjrcC0y+XILHqugwZSOI+/mPc+VSxHWqKOAIIXAxsqwqEh2PLMJ19rwN0nGfSzccfKww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5121
X-Proofpoint-GUID: vCc9ySYMD7nA9SEHzAJ0bqNKYMfDnU_6
X-Proofpoint-ORIG-GUID: vCc9ySYMD7nA9SEHzAJ0bqNKYMfDnU_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=916 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Currently suspending while sensors are one will result in timestamping
continuing without gap at resume. It can work with monotonic clock but
not with other clocks. Fix that by resetting timestamping.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 65a60a590142c54a3f3be11ff162db2d5b0e1e06)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..d938bc454397 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 
 #include "inv_icm42600.h"
 #include "inv_icm42600_buffer.h"
@@ -725,6 +726,8 @@ static int inv_icm42600_suspend(struct device *dev)
 static int inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_sensors_timestamp *gyro_ts = iio_priv(st->indio_gyro);
+	struct inv_sensors_timestamp *accel_ts = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -745,9 +748,12 @@ static int inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(gyro_ts);
+		inv_sensors_timestamp_reset(accel_ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);
-- 
2.25.1


