Return-Path: <stable+bounces-108436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4B4A0B826
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B501667AC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70622F166;
	Mon, 13 Jan 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="gYGMpOmt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94425760
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774952; cv=fail; b=jiaPpIRaCay7Zmq5FKVzxNkjYE1JuqStexfIT0j2vkDoULxi7U2E/f7WsRddPh7tN/HqYjU4mybu1Pg2zVovh0ZUjT6jIINvUwuA7OgrAEYB2jTgscAHcrerHAKOmXCNX1s/13y5nGcwaOHsXCoeMCTbVNi1+zuRO5z6yAQhP+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774952; c=relaxed/simple;
	bh=7uHAYpayTuzOqaU/1ugXMmV8wAG4t9DAcB/Kib6KgpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiPxAvoI0toLvL47zvrNMWGZN04s967cRj95lCEPKeVmGPH4eQOo5HPCFZhBnBYMfoYKPcxSeXPpUIy1Ngx6e6iwanz/luTcgLric+FOvcoh2/nNULzh/Uz7OF9PXg5RaqgrtU2pYgI88CRpOs39D9hPEiF+2aejlyod8ppO4E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=gYGMpOmt; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D4S3LL008316;
	Mon, 13 Jan 2025 12:47:03 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17010002.outbound.protection.outlook.com [40.93.130.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h985u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 12:47:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjHPy5prxsXKBCPbDkgpj7225EK9pO/sRawToNsiYvegc7Y3DmxLvkOap8n3/igHLjiajnV0orYjLdLBdarJtGqWTvUVdaDgovmHXPmC491iidP3S2PTQ+cyyiv6fUnlh4PH5kY+7iitC7NLnPyIc65kQHKZeqoHvnyuk+gl0j5Q/fMDhO72iCvTMjuqU+0m/hft8b3tKFDptm8BZLXJKkm2ZTUqs9Jz+YVJZR5ndgM/9kwl1XZjzOgtWtUYjS+u6ckTyb2Mh7SQ7M20ZwQz3Tc8XvdBK4Cj/3HhuppOWH/9yHZJPUcL33vBe4KlYuIiuq7G5Bd4zg6+6aEU7z+R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIfGEQXErl9VbRGB8K8b1x/ANu43K5/ms81nJxp0evo=;
 b=CPxMtlqSNMWRRLal2VglfqPfEZZrW5S9yC9Mc0/n7BqOautIPXb9EY84J8b5sLKmO3aUlPfXyoGJ5WQi+qE8fmV4s4sAniJCiekFJmV+YWcUUpvnR3I42Kd2SgHnXYZFIgi7FhK4Ydhm3Aj4NqxeU2kDBxysHMLpL6ZpFk3d/z2GmygDAwNYE9hqynLtsngsHg/f5bnkW0wH+HUmq3nUlbntLJJwLXKaLDQAGYRe46vXNzWIkrvoIBGGTJ5/ceapSsFYgWJIAfdHf6hDIOzciw9X0B9MIFCia4fHHHULhBBqEqyQtRYqUbQDTMZFUF+0VPDy375NEs2I7zlCAYYPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIfGEQXErl9VbRGB8K8b1x/ANu43K5/ms81nJxp0evo=;
 b=gYGMpOmtu++AKRuygS2m15lJE2hozfCAIjqIGpRLOiuQEYuC1l+rUNccRkuI7WcqKKTF3J2iV9wyffnTH3g6ebMI6i0PgezvOWfAbVySJZRPT0GqLvABUrjDH/NyQW/MfuYZlhzTBLGmLjmN+wjyeibuaOTe2NkkxCkcxNqi87L+s5Yu4G1MqlRck+FrYUUxNrK+82Ia7YabnhhIa3ycD1r1CqdqiZh4YLD7bYF+CDQDUd6zyDCl57u6qHnh/4zEb3hQW+ghFmNEn3ahXp0YDxsj5xjPForHI+7Ntm0LAmB6p8o/UAmowA/rUJv8pqdQSSV3k5y3YeqRRJ3wQ6+fjg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB3495.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:46:52 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:46:52 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 12:46:38 +0000
Message-Id: <20250113124638.252974-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011346-empty-yoyo-e301@gregkh>
References: <2025011346-empty-yoyo-e301@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::10) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB3495:EE_
X-MS-Office365-Filtering-Correlation-Id: 795c117b-006a-47b3-14dc-08dd33d05a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIC788+8dfJICb2Rdc2kQxVeoSPsvUOrbWFtvxD2IopXIEKvtETF7hPGasar?=
 =?us-ascii?Q?VSGHKVv4YfuVd1aQTb+QUFK8MIGO3cHmi2IHt7RvN/IvF+HDOdgPe9ygniwb?=
 =?us-ascii?Q?fW6Gvz45BSlm8ARF9e9QZ3YmxEzzp6nwgdAT3b04h8tyeJBJHaIuY1gD3C4e?=
 =?us-ascii?Q?bCWVk1uvSIjSeGmTsimZX6q1U/enXZhVYTvCsr8Oc4vvEUKMHI1inH46vVjy?=
 =?us-ascii?Q?hRiRInPYFXq8oU7CGG3FRKL49yb24/PVuUvfGGq7xT5ZNtsYA9CVtvhPjnqj?=
 =?us-ascii?Q?Q5wCnDVDWDrJKnxmdgQuHMdfQoV6IvQgSeeGCHJrfzBw+2X3l88zP5/yQzwd?=
 =?us-ascii?Q?a2BPOQSqWl1phS5DU2/T2DoNn7eMxO/OLpNjMlaly/KrTB1k/R2+MeClg0RQ?=
 =?us-ascii?Q?kSivrISCmRbK5SioThF68sMZCwa3xJGh1Z8clP6xl/ppRM2orZMoSTgkBG/4?=
 =?us-ascii?Q?vcc4sdF+sWlY9J7pHkhB4vbnKt59/ZpaNRBsvbKsHmdkXDIPsAprHGAGQbKt?=
 =?us-ascii?Q?WoTyLZ86IcVPNnxckn6glmjsX1t82mCErffEBQRIB2yWja+cvIghB64oYR4n?=
 =?us-ascii?Q?KpfkIcBWOo+lY4XAd6ucOHILL7KeBImjEMHYz02A02xA8BtU3tFJaCFtsvvE?=
 =?us-ascii?Q?+zygZRJU6JacidXWqvY1yNoLOSkSQlxZ+ZkaPd0QqYqIQ3hiYegaO05M4L1T?=
 =?us-ascii?Q?/G5P0NQRf6IF48jM98toucjeCmujPyrA9SLh0rwB3rxmOypdaoFFNYmrKlUO?=
 =?us-ascii?Q?/YGni5dPtVFiB8jkO+G2zvCOPSAEyzQ/AsXXsPWRRvAhLwUiZS7vpmUuqA0n?=
 =?us-ascii?Q?/ADzoTc+FMhdzJW+qbmkvmR/mnWFYGhul70pkYu0Y3emgd4xL5llA7lr5mRX?=
 =?us-ascii?Q?lSgymsX9pK+lKmsa73b+EccUgzCV9BcByDrVK8jO/dJY4yucMcuwS8kfUyYG?=
 =?us-ascii?Q?VZ71+8r5jNb67lhtu0YtMo5vETZuJ4PX9kICDF3CZWpRlOJQHEoQY0SCTnx6?=
 =?us-ascii?Q?QAR+lLUyWb5Y05vXS1aulKIxvDNckCo9jcsHYgYwzD5OzHUpYZo9nA3RIyah?=
 =?us-ascii?Q?ztGPxCk8rIbvvKd2rOtatJPB4TlQeuwyotKMvDMQo5fJuzbvkK4MdqULqBnl?=
 =?us-ascii?Q?9RF0IFgjF2j7fdUeYtRC373PUsLCNGmp/uLTekQtvO0IuGFIYDs8+l3ymxmx?=
 =?us-ascii?Q?skRyCQloUlIFSLi/XWLKYUSHGrvLCkNdVhRD007Ma3dR4Hz1qEa1sjjW+gcR?=
 =?us-ascii?Q?7ZSqVh9avenln5e7onWU51q172HkdZWHc0PeI4sq/3DeEaP2nauHkYKzvlDK?=
 =?us-ascii?Q?VsiLaJYS9clr7zpkdHfWg41D9HhY0+bB8TOy3mhpUFp/swIECTAZQ9/SF9KJ?=
 =?us-ascii?Q?fnfZszJ1oLml+JzsK71fRraRavU+v6QNTMAd7fPlTlOD5zE50dSi+vS0pzNe?=
 =?us-ascii?Q?6gzuCtb9rDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXt7tkZBkL5Y5k8Q7p0duaCuXzEBWzlGS09GT/qh+9WCBRMrY1dJOL8sDZNl?=
 =?us-ascii?Q?NuUvVpFpgXhLYHZk9gGdyFh3WViXGyJI+r+U+RHBYxBBvR8c01mFfNRGwn6p?=
 =?us-ascii?Q?G/z1u4M1Zx3H0Vu0TrwIGEw5YKrqLP24+C3nKZZGuQQLT04a76KHzT4LWkjh?=
 =?us-ascii?Q?ETgnGAG0UJJEVpdbakObgj2YhrvLFP0lG4lmc09oT2gqz34+vbvRYsG0u8Fc?=
 =?us-ascii?Q?7iYOOCorVuqv59JikFUKolplNgb/2e+eWwnFhfSkgfoVO2c/UNn+ZQF/33aN?=
 =?us-ascii?Q?3CNXVKIo3cK2JWKOLq3QJAUqB68r/soMUC76vIqzHpFfEDrxGr3JkutBD2Vk?=
 =?us-ascii?Q?Vgr3ITIH2fIcXeBEQzxqErSsVh77S29EZi/acpmCw+vdyQwRPCsLDgBz9uJn?=
 =?us-ascii?Q?OmuIOzaWD6VuhkOrGF5xX0GXIEWxhOnhjozdAU2EhASezOJBoeZQhz0Id0Y+?=
 =?us-ascii?Q?Y0ag5AKbEqtLWNtb2husCatbj7R7SC+Nd4mjFZ+87rYtJo8SMMY43BSqs1U8?=
 =?us-ascii?Q?ytIiw3YRIblkGx9XFcPkUxebxGKeyssIpSEwPTTCP+cWuVPGw0Sulh4stv0I?=
 =?us-ascii?Q?KNZezn47xqYZZ4V+REUPLhOd1ZNwaUBA6J6LZpW/CzzEj+9HYDcNI1txBA+t?=
 =?us-ascii?Q?UEHmVI+SxnxiNERUKsqT5WMsG6a832+iWOgyquH0cXfOv/G0Zbj62E7Swt2D?=
 =?us-ascii?Q?0d3N3lD5fPILv3CArltZF/BA7xhCxCAGgkjF1HPBPW7NnAB4gwZEvFW/NCRQ?=
 =?us-ascii?Q?S1O8RHA5/HQLWM5zg4CA4HVzySocM2eMxAa+O7WZfuXAY2YedDja4FhYOk/g?=
 =?us-ascii?Q?7ITt1g/3adM1WEaUaMW2FDxO+4eeUu44oa9QG4w6gLLhZufAEBHPVAeOI7dl?=
 =?us-ascii?Q?qDig/6+ZK3XRWqgAb8RfcYHDwGxFozo0doJ4PRQaL5JXUc78D33kMYrY9ChN?=
 =?us-ascii?Q?WsSW8BCsFdDohLzd2/ABb+xHPENEG2U2yZeD2xz8txtFxADWYQAyEiU0XeV1?=
 =?us-ascii?Q?4TuoF7B0DzDkUG/k5y9AMoeRAqnQy1XlE9Wqmvus/QuVW8ItqHbeijm60RAR?=
 =?us-ascii?Q?CneOP9m9H+LMNy34kd/sYJasvkFBdiQVAEnBh+o0qM3w37xhx3gAnFpXn2lo?=
 =?us-ascii?Q?zR4xX4UIeQ+VDB16E2BwaXB8AUKbKN4rsOlqhsZyfUZtwNMPn+WozLRsFd11?=
 =?us-ascii?Q?2KTSyd+9I+4vlSWpohDQtsYVCZCmkNB80xJYf6cEUQMXcsrNGhDPNZKH+Kog?=
 =?us-ascii?Q?8McHjeJwq6WrTCSXPiXEtMuDAafPiN8UPk1K3p6ubfzb/7iOM1M+Y5ulWqfL?=
 =?us-ascii?Q?mcKMMl00tNA8a/LW//sw6w20ss6FzBkMHASr3MpBxmkL1R0nEif1gi8ZF9qB?=
 =?us-ascii?Q?bGiVkwu95IuAfgedCT50Ph2DxrUG1I05D0FLFbEwV4K3CrnJQ7DpCLQQxH64?=
 =?us-ascii?Q?ZdVc5FJ7o10roPvNJ4oVnX2IEsB/yK3oSo9ZnOraeLUhUMdx/L0fZR8RIPc+?=
 =?us-ascii?Q?I9etO62Y0uUExMQEE2ezVWU60F7Rg5hqdOoLd9l/uNVvQd6PtQtFBt0M6p9k?=
 =?us-ascii?Q?rIbBaN1cd2UVn1aXwjyriIp7rUe1DsDLLijIw8Tf?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795c117b-006a-47b3-14dc-08dd33d05a9f
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:46:52.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FM/X/YvPeKwGJHiqltlpoFtraCaQSH05+BLUG06mhqYJ1eub1QJ/c462As5BYWuswF2E5lIHef8OamUDw0xGHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3495
X-Proofpoint-GUID: XrMvTLR751axaG0Xfyd1A_15HtmMJgcU
X-Proofpoint-ORIG-GUID: XrMvTLR751axaG0Xfyd1A_15HtmMJgcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130108

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Add specific SPI regmap config for using only single write with SPI.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 15 +++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0e290c807b0f..94c0eb0bf874 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -362,6 +362,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..04b006d71526 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,21 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.name = "inv_icm42600",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.volatile_table = inv_icm42600_regmap_volatile_accesses,
+	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 6be4ac794937..abfa1b73cf4d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.25.1


