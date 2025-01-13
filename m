Return-Path: <stable+bounces-108428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C2A0B7D8
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B1618857BB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7AC23A59B;
	Mon, 13 Jan 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="VyDzcyMj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477423A579
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774076; cv=fail; b=JxuLsDX0sb149EOy83xa2xpWpdnEqt/05GTU+kTcit64v1A+gBigDUonjwXVz5fXuEWCkU7uYJSw/+hTda+bzViR7wOzgzY5abCDvSwZLV8JpwaRqEXy8ozkPSlvznrrRLslomzVw7aNI/ENIiK9dKiy4jDXMhV9o2NOaBq+kOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774076; c=relaxed/simple;
	bh=EQ+qkM4TSvSwV6feiy7qsg/V9bBdf309zbfGmSU4Ujo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7c1MjBEk7a3+jD2BC32KbY0AVRGvDSWe0BUoFTpokEViIW5s7o1byH0DmNi1U49fz9M+Ths8k3++0jUkFF1ocAyAhXVWVDtzQYPuFea1prd5YXWxOpo0zNZ6pTlvwqH8B/xHX6lGb/vY07RLiVfVtInokrJNY0JH5oUq9qMdxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=VyDzcyMj; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNddmM007936;
	Mon, 13 Jan 2025 13:08:17 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17011028.outbound.protection.outlook.com [40.93.130.28])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443hq4h980-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:08:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhfrCXIgzdLWDcqMfXk6Wc5NdGnrj7t1cv0XqTQdXBeqkq/zMqCTWwEinHN7fSZa/Z5htbT9N3Fnr3nWMs26Pd6h6Lenu4yElotf5fMB9iRhzZS6wK/gf/V6ENyFRxD44zRCRtp4pGhvTarB9FbEG8cGHSWz/NEpnPS6nhNeDzGpJGwlitQ7IZQIcn0231b+0XinCZZQa5tKyY4cL3fhcMmz9aC/rpY24ReCwjroZ3tq3GtQ1bjcGD3fcRt9jp5VWLA2cF86s7KmeN9ToNW3wR6b2hN6Zg942aEE1WQyCF1TRWTSCmiTwYJ+B18kE6A9b5j/Y6Ay0uv33thVQLe/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZyNfV7DB766VDrfVAH0ZutmMRWmGwvS1W6wPfPlibI=;
 b=RkGHKNzBdE55OdWNT8/7CBfAGXrI3YfRx4zaEwz6aNkhzIg9COoGXOx2Dk3iJ6WsJpJWC/Ml+smpFpLiYH9wPssZI/eea7EIMlsZ+nQc479n2K6FUcqG+N4CymEI+aUpdIrVTM2D7BEUU5oKlg+gsh4Ifp62Q0fJnMMeTYo1vPf143Is7XZ82uW1wPp9dz53M5At6UBy0S0HfkAYFWs0QnOx3iSm1JJJbqckremCF3fcgvIbQJ3D7PZ9BP+NAsxssTkbc197sMzAlB1PKHGzz+DhPgPdlGrIs8CnVih1xOzqo89gmTr0T015zUx3hDoYCKt3VJAVt+74XvNC15X6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZyNfV7DB766VDrfVAH0ZutmMRWmGwvS1W6wPfPlibI=;
 b=VyDzcyMjvPWf8cdTBFYvZeb39CHuyYqv7wWAuJdDRYFbmlwniWRMRfAtHqi0NnbLY4m5PRmpX7NNuS819T8J/88TTbqSDLARV2TVUT8UnlOvUmR0XkhAGVucdeWEXW6X2+/Oe+wMbaBOZgSXjXyzAGT62pkgMqINOHTQufiCkdyU4GH/C1AbhOVfpo6Mw7NKrFDy/aJs7LAjea7xapoL2t09hmTeIQXWz3Y/Yg/B1KUxGLubjjWVc8Q/w3nlYGKhQ1Xo+1BGzXvXkOapwNT4aO1MkoGMjTmAMZLjPGOkJrD1ZKi8klQ/F1MLVFp+Vo8sOnEaLwMNWMK1a5JKhav+Tw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB2824.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 13:08:13 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:08:13 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:08:02 +0000
Message-Id: <20250113130802.1930-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011357-immersion-detonate-d4eb@gregkh>
References: <2025011357-immersion-detonate-d4eb@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0203.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::28) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB2824:EE_
X-MS-Office365-Filtering-Correlation-Id: b40b3d2a-fa75-4d97-c23a-08dd33d3562c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wcHhVI7SqJmmy5LKowRPe3wopsPK37myNAIJ/tVXZBetlM8OKKGzL2sIPgOJ?=
 =?us-ascii?Q?s42d+VFMG/FSpQD8S30HiBO918LvNdHLtJKXMPGrCwEKucYxQJW8PYWuFQQD?=
 =?us-ascii?Q?7/CKE6IQfE1fpGHjF7hLXW5LcYRQNsQCBs3HwlvKK9jvPBu8dBmKlLwbfU06?=
 =?us-ascii?Q?kUeZ55Z/DFvvkWGhNQKA0SS7CT+65tPHK5hjdGCthaVtAR7UnZzkCeIBSg0P?=
 =?us-ascii?Q?CsDcppKcqtDKkLNQijPrVU/kCqWIRvtkt8D8TM9mPZYS0onsRDBPY4iVmGLH?=
 =?us-ascii?Q?0Rh1dST4i0Uhbd6iL6WLyBAFjAykJ0Vv7BoenONrYYeaOGCyDQhuiTs7yHLr?=
 =?us-ascii?Q?CLPy+qIJNWsJAyeIbHq/iSL5tnTJ71PjJR27b//HjD3wRV4cy7U7E8f93oan?=
 =?us-ascii?Q?zeursWdbyHquAv7GYPbAAGhY6v4LJWvgDCyCX9in2G1zRJv12YB30XkoaTaf?=
 =?us-ascii?Q?A3OJ1Jhyb4ipGiy4mz4PHe8Wp1taWcR3yMDZBHu4hTYobovXILmkNnyhnsgo?=
 =?us-ascii?Q?t6nkggH3ZesNZwkL5G0z4oQLZWqVIgO4o/UzzQzoxwuz5K4J73tfs/K1ci78?=
 =?us-ascii?Q?5eNSfh8g0sqMgj2UTbiOAaeXYPI4V6DQWM+2VMwIYLa3K3vn3Xv9bvQ5f4xy?=
 =?us-ascii?Q?DaX2yXErbspjeSE8YPkCHBFwJvp4sZtSu2M/YsTgnohxlICCZlOrWIHJZVm0?=
 =?us-ascii?Q?PNm4L4m4XidDSumLZdRvQb7CFM1Ngtc1xUq7Z/ji17j5KgnOuBhDpjnEErGi?=
 =?us-ascii?Q?vAcwKlaJvR+tYUuOsQMzbtcN0osLFSWDIprYZOmfUKhzjT3KyarLelSPO2hB?=
 =?us-ascii?Q?6BPc4olVRal0QUyfflhgIdchlfLIR3S/3ZRprU1QjAlbLH6IdihnuVp3Jajm?=
 =?us-ascii?Q?+rKJEV9uPFFUcM8FCflfF34ilMCIWqKJR8li2H7h42TbCmCwed/8NSOcFNet?=
 =?us-ascii?Q?z6ceCvFmYd1k8FMu14KTWNDVLnpI5LRuaYsRB6kcT7HxeQvgiJuOHDTMgz5S?=
 =?us-ascii?Q?QUPTUYi1KhcaCRrLxUnn9QbDkgan2+FLVpqa88emGpmsurryhlX0AsEcKjJH?=
 =?us-ascii?Q?J7PauL8r/BCTxMs6WX7tqTcK4dhTGVj+TkDurHgcrY16toEP2mVsk/HLruH8?=
 =?us-ascii?Q?eJ/5QIwa9IeIjm73q/ayQB5304pflN26l+U+uEJb4w3Wzhzp3aySm5Ygnjer?=
 =?us-ascii?Q?HO4Omaxjy4EJYGvwS35RORg1eKnziEDbQjqCFT4eNHwn1hcPQhbWujEnsgO1?=
 =?us-ascii?Q?pjMCBrx1Q2DEQNRS4EgU4zprL3L5GOfkzc1bmEdmdFU2Gx0TWoz4tt/Nn66s?=
 =?us-ascii?Q?zKT4FoTPHrF246N43MFVBf9lbOeAa/J6aRdBTnn68Tn+gif5p9QWzue4roz2?=
 =?us-ascii?Q?nsv6alfJP4P5Kulgdhp1DF9qGP0et6udfKseTbe6wu1Y2mnMhO48VWqxzC/f?=
 =?us-ascii?Q?6w3HW4YPSpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUuiSufINzjNJ5tEnX89mWWjmvEdj4AYf15IOJa/Fz+xds9Ll8iy1lo1amIc?=
 =?us-ascii?Q?pEEXywH/fjeEiMAXCvzgGTXxeVe0hWksfp5c27i38VCrmJD/F6scHpGik4PO?=
 =?us-ascii?Q?LZ2CJ26af7SdS3JXAQxoYUStsvtSJulhQvw4zhymQbN4GQ0gQfhdjIocLYhL?=
 =?us-ascii?Q?zpj+1vNAWWGI5iqrpmeZHZAWbPYMjss7DmfqeZnHYnZDg0wiE4GuBaYuJ+sK?=
 =?us-ascii?Q?XeWoGiJA2sW7WZYPg8jyvRnLuw6QKhhjLG6O/Q9Ns6ItCTb69r/2NtosBxEE?=
 =?us-ascii?Q?jf9An+WL8hD/kUUobXzpGJxIV/vaQjX/Di4PqQSGDg9GSVE7iPJ7EOosFHSO?=
 =?us-ascii?Q?KfgZrEwZeOFmJMkJkc6vzM3IrP0l7ArUkPdh0+gJh8BePAUD3NN8dYDr31U2?=
 =?us-ascii?Q?VlEV/8d/ElhJcwITuOuiEXROwjK2jb66kwyZ10Ai99Qo8itw2lHKX4UET9cv?=
 =?us-ascii?Q?vDdXH9ufJK1Q6IG6/1vfdW3I6Y6XZk+E5in3YQ0RP4SvjuRgYCrCAYMqWz/U?=
 =?us-ascii?Q?w96aChm7hQbSgxKVD25fKFRtareIy+sHAu5euH4uY0AuATkVanAeEGcUrj8N?=
 =?us-ascii?Q?QwxMJLnbU5WX07LPtTrDP3WBg7XSVQukUfrP/Q1gVrE52dJGzPQVnGVpgRdw?=
 =?us-ascii?Q?k2FoQjUsS2IJ+raHeHDNbRxpIRVlSwBPmt3P9Y/wdLA3FBlEEGubM3A54DH/?=
 =?us-ascii?Q?r0lw1jEoxoryseLA3jVd7Ck3S7tFczaOsAOCPGbm8ossWIb6v4lcADjxGLPN?=
 =?us-ascii?Q?SH3L0c3MtePu4pb79sHGbf1ZJNwI/xfjxYVaA4J1mH4RwG0SkpPCuhTc9NQH?=
 =?us-ascii?Q?bXtpFwoGZI2p/qUeL+7VWj3CW+AIA4auepqeYodOUvM//WQYNpEGxrJXffli?=
 =?us-ascii?Q?z5Us1647m/3VjWCdhRSWlduV/106bLJ4Uq8TnuHgl5TA3w5Y0tkOiTz5qmX+?=
 =?us-ascii?Q?asdagIETJ96AdChbwL/2+T28AhRniGC8Cl8jX99kp2lcvgUE+1w5Nq4s1MxD?=
 =?us-ascii?Q?bnAlijoRq7aTiUZTdsFN1T6nhO1gMMW8LG9jftjTRSvSra+GTrgVIn8Dd89g?=
 =?us-ascii?Q?tUUaWTaspXqjkZIjILzs7FGKPdcTmB52LJE0ZHNIbaGVBUsbwYkZsyd7OO0g?=
 =?us-ascii?Q?qHaRhevfrEL0wtyJztpkQsh0GV9LKiUCGG1btP0O2+IymuQJsYvVDT3Gcrdm?=
 =?us-ascii?Q?eUu2LGzIkUvXpa24GeW2H7XT/QHbJhfc9mc1swveQslLIhLAjI06HdBMcVCP?=
 =?us-ascii?Q?aYP3fRAoUV1XagulPK02FpsBXxwb2JwLveltBEg9tTSdZ6yROiauZslav+Ml?=
 =?us-ascii?Q?o0TjGiaFv5yqEh7vy/aNl5HamF9X34+kz2BQJDu0QSxF15PNw4Gwi6FftgbZ?=
 =?us-ascii?Q?jCknoG3e2caTsTRLJdA09iesd7xoCDWfqm/XOyXssWfhb7sZSXVjrJYJumiE?=
 =?us-ascii?Q?V5q54D+leX+4Y8xhOpjo76kUJmU0m/5Zxx/+Ix7X5h9Zh+TX2lXgjn9N6PT/?=
 =?us-ascii?Q?+dF5buQYaxsLy3ZNNhStee0EXUab00T/QyRqRKMt5KX71Xsnw9LJAbQdUU0P?=
 =?us-ascii?Q?TCVtUFgHGX/B1qTkAuFbVN3AbmPFMK7+NixRebou7H3TzAUREvDA5aJpuubH?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b3d2a-fa75-4d97-c23a-08dd33d3562c
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:08:13.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3SE/hKp1RmXfHYzKOFekwm5cSGVKBYrbMYGr1nD9UvFTM134zqyMpZ451z5uZ6HOTgUhpYSUsSciYUXCS0UMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2824
X-Proofpoint-GUID: V1pnTqkS6lhoeCCLD_zI5FV_Ahsan56O
X-Proofpoint-ORIG-GUID: V1pnTqkS6lhoeCCLD_zI5FV_Ahsan56O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130110

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
index 3a07e43e4cf1..18787a43477b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -403,6 +403,7 @@ struct inv_icm42600_sensor_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c3924cc6190e..e6f7594aa669 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -87,6 +87,21 @@ const struct regmap_config inv_icm42600_regmap_config = {
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
index eae5ff7a3cc1..36fe8d94ec1c 100644
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


