Return-Path: <stable+bounces-108444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C8A0B8FF
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB31882A06
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549322F179;
	Mon, 13 Jan 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="FC+ZqhUU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A202C8C5
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777030; cv=fail; b=EzXJQK7GRRtZWJ2nHSTsc7Z5lP7ltd8bHs+aYr0bMJdv7gTARw5QITDxK0yjP8OKPHuqaI0RFEatR3WQSVxrc0e0Y7DSkk+ztB1ev4Oqh7Nl4dU1io6e0XAE4BdHGBIXLbPUL3SD5bsxR/4coWG2+frRaZM1WBEO4HVuVHJuatY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777030; c=relaxed/simple;
	bh=9u5RVpABs14oOixuXiVdQDFca22z04lPlMDaeulPRoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTAyDpC0NauumwbUIbDuUSaaSsEVVVI+Cn4f54YoG8mPmfKK2Vrg26BsmFc3EB39lbvWyfhYnyXunmLspZCyvDrBHxs9rpu5iwCV7N3mMb2+Xq2q0PSP7N96BO7tw1j5Pzc4FF2knzZkROZzCkcjScFKc8+77XU1v99O3j3zaSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=FC+ZqhUU; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNR6x8013647;
	Mon, 13 Jan 2025 14:03:42 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17011028.outbound.protection.outlook.com [40.93.130.28])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h99mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:03:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkLj4Vcti+H2fo1jILxISl+BenQRuEKtVt9Ubo3lvfeWBfW9fXgn1IYwLMn6Rk+TdC5v8SpXA659qo+ixvGI/tzMxVO1GZDWxf3iX1HUyPWeVfhM0MWCtB7wSqbmbylu3rYGdegtbJl8HgD6DYMLiTpk7DvOD7b3oBnlgVSyfv+biRlG/V5t4LGnk57RGrJ2pNk4auFW4DqVI3QsGzIZj1RbrwmbUl3D7liG2KZyFwPnbIrmLUVRIICn0dkPcyWxpCG5SPnqpJJNKDGztkgdxYU127huyP5b/UYHbBffrc5QBxcPJMjzb/PTMrPcujI0TwhG3HxFyhNan7Y9oIezVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKUTQc+lNMVpErhan9zZG/MnQtgil5BlMEiDI3wtOLs=;
 b=PCEKeR3lRhIyXAIfITz5Y6PSkql7v9zmeMZMA42CvEtyAtv4xSI8j6mptMFeL0DYPiPL80H3G8g8dLauwZt38FKBI1b7MlPOMUN2aEBje3KxKMWB8jt018k4k5ec5C6PGhQzZmspDHkvYaJfJrdoeVZgLztvTbDs25rDztD4mLczW0CnDPGUesK6s5CPH5fXNcBdupnbZjcn6xNJDa663HTQQxTWIr1OMUZIrSY5JltQmLFW8SLIhQWkkIp5IY1UD3iF12HW5n6D3dRLwPvNG9y9b7bcb9L2pf+LGROEZGbn1CblZUAnrlZGpbrHSXPfgq6hS6JSTrLXBmm7zuEgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKUTQc+lNMVpErhan9zZG/MnQtgil5BlMEiDI3wtOLs=;
 b=FC+ZqhUUT3wAudqaMqCnhC4xRZhlNlkugdQsbSwzyq0IAGPlRpbdqKyKr8Jgpr0hBRwnIh+dW+8h+nAz99kf6EEQbgDZPf5Nc+aZI/xdBQYKVzfj1QT+jfajvbASgNXDpTeQ06ylFJw+YKaawHmjdywNdfnAHjEtjG4qRg3SlkYYKVKCJDfwpmreO4BTQTA1ZYHmbo6epiJFH0+UNHnLtP8TegzmSvWhdgr2DwbWpDgCPwMgFJX2BXQbnvi9/6ZNq4x7GAAxRYlpMMNb0j6xlq4am5nTr8TdgNuZA17RFZAEghj5RbJMLDvGbE1PWxUSe+jgyPwwMznADl5vE6VReA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3411.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:03:38 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:03:38 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 14:03:25 +0000
Message-Id: <20250113140325.505120-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011357-immersion-detonate-d4eb@gregkh>
References: <2025011357-immersion-detonate-d4eb@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3ab053-b1c2-4acb-c49d-08dd33db1373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PC/58S+OOFLgmvDkIuQXtd7KBu6K/WP6w5cOuKZt5CjdMvXpF63TQFsgJ/1w?=
 =?us-ascii?Q?4APo2+Tl0FnZe/bkv5UYW5L25eoWHNqon2v/Lo87Mk2vNIHAjXl41bvqQKWN?=
 =?us-ascii?Q?v7+c5yIZ0TxlWV4pnbzAP0KPiSfCUK4yxXhNLIq/PY6JQrHfQrewOtUkK6P/?=
 =?us-ascii?Q?C87Ry5VJStwENy5TteKlZUC8XKuZ/wAFbQj3AeMOshn4N8ATPm0lz+jOSPWq?=
 =?us-ascii?Q?IiCmyITZb/sQQeUp5TOGTwgKBIvFDkZpX9ogpHNwBgJXzcYZYPB/kbr5JMUE?=
 =?us-ascii?Q?NeEJ4lwDP+IYDfLuseD2ZcNb1FLa8E1xeCuDKV72NLW852roN0U5xkR0RHUl?=
 =?us-ascii?Q?MB3KTPubYDWtIE43UizmYBPveghQ0ngkQAE041oyk15lAvosLrCEfd9aOPOB?=
 =?us-ascii?Q?aUDVdz5QXiumohc0udbWx+cN32w1Hv/EXL4VnjWpL6Ix/vmnoHM5mdFTV9UN?=
 =?us-ascii?Q?dvI5kkGnlj95p9TgZ9ZBInb8NW8Ftlg/S17AjkZrzXF6BnK2use/j55brou4?=
 =?us-ascii?Q?EMZp8pHOS8RMiegtqtxPuFgiJuCY7XjwJxJyCT2i4rol7pdjdK6vkPg++CLv?=
 =?us-ascii?Q?N7bikpCwtAKl8zv9F0HavIgZIuYjtJlqcXX+IGLk4+CDX/grh0tn+xmQAoY7?=
 =?us-ascii?Q?x/rJEm4jtqR8TR9nMgu3UFrval0OG6ChCpjHVj6E/rzsPFUIOqUH6JNOyOgh?=
 =?us-ascii?Q?I6OYoy2lqoBgJJRszxVGCyHbz4863jgnBtfzkeYBwiedWib0rYn80oVJSkhz?=
 =?us-ascii?Q?4I1XAoD/Lnb6yObpzNqyo5uK5hXCPAa8A2ovT7t/w/xmU01BeFCXboQB1YV/?=
 =?us-ascii?Q?Bs70Y2hIOnTFw4dOvxJWJsdLhpyGu5MEy+nxzo7EgBsZTHedi4t5jM4QIwA6?=
 =?us-ascii?Q?2r85r/hvlovXuDg+Ls1tmanV/ZJlhxe+YmDScKy1cXR+qHOOrk4c7lJc7UbC?=
 =?us-ascii?Q?VKbVd97HIfJM1kiObAaoc/opFx+Utr2hx6tUgZp26bFLrRPpajysa1xXwpD9?=
 =?us-ascii?Q?Nl8GwSUoz+O3z/pNADmiZwNvkSzrn7ufGwmvbthwgNFGniEF6DZMHs4xiNbb?=
 =?us-ascii?Q?5IsglM7FyXd6XXwTPbjkGHg9emm9MwrjoipkuMIuTRQqDOw9Nwe5jM245kl4?=
 =?us-ascii?Q?pbe0IuMI0KSppCTs79Y/KPAQmPiTilO2MQdN4Jc90oFJPCcH/r6NRI9NxRRx?=
 =?us-ascii?Q?FqvVc5h7CiItcD5JpFaORAlFXjW8TxWsbidpvUGRDd3G9fTBks6nMWQquPsv?=
 =?us-ascii?Q?KmBPidCrGiMNTXK/FwBK1Kx4JjdUX6jy8PiGG2y7l32l4UeL6eZ8Qdk+BRJn?=
 =?us-ascii?Q?KBGpa48Lj+BdtZ5MWGcrFTWCgyE/oCfKsM/SaP5jDyTmsgbD9oDpjPe1/E2m?=
 =?us-ascii?Q?ZO7nQgOaboa388IGHc6IxlYhH8Ib2y4Qk/BGtZS1kVZlWuja4gFhUoIigH49?=
 =?us-ascii?Q?lzj2hsyAhdc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDGqy33US5G9OZFnT9TiWUTEenWv8qdapk5Kaqt5dEDFIEGWt4ySX8a00rcW?=
 =?us-ascii?Q?rMyctkumiulWWajl+8Wuvlda9M4kIxSE0L0+qVXOBiBuJM+2dmATzHfq2jsz?=
 =?us-ascii?Q?kKL+c+27IT0F2eOW4w2Z0Oak824mD7mpIwg5PgQZwee37UEAS5B03seeZV9Y?=
 =?us-ascii?Q?R2nXa25Kw7C0bAZfFBc8G4yOhZsfopaBKAkgtHdGcJUGwHRTk7ySboHyGR4p?=
 =?us-ascii?Q?HyGfEWRQFNKLaYbDO7wg7Yd5pCvKd5jxQX6HVnhhYnGQNpK3DDvZMb5rPDnf?=
 =?us-ascii?Q?3Df5rX3lroeHRMp5tccQtLATxaWnW+ozRs+pPidOcpyObeVmCli0Uie2G67P?=
 =?us-ascii?Q?dmrlDxzZd4XjBx5E9+3o6Oo2zUg7jceU+GL05pUZHucGwh6q7Eg9VT+WELBI?=
 =?us-ascii?Q?x742C/5obbfR/PSzuWwdSfqgfDLW/38ckXYSNdCQrNPe0dRpSF0YZIjgK3G9?=
 =?us-ascii?Q?Zvsxb8jCjE+uT7pFNRDsuOOzO8gJrkpVXhlYQNlSYVCeqjVZEZVCQNezkXBS?=
 =?us-ascii?Q?O+78B4k7hOXta3vJgxR+jU+veA5c5GFTgGy7kMqIekmKGHp4O/WSW2MwdkB/?=
 =?us-ascii?Q?fwWZSav4wh3J0hxkymfO6mFohlWpM94bNbWyVZ5T3JJkqJ0ePuuMrjpBiE/n?=
 =?us-ascii?Q?J2rIZ2wSM6zQk1FaeSZpBmh+klCHLcymgiH/ezGcTBLjDnqChjM+fD8WXoL/?=
 =?us-ascii?Q?VAvoIywqQspobsNUcZ4eLY9+2RHFoDCUHB69PYiE1H3lOOfUBValvRYqzMzQ?=
 =?us-ascii?Q?HP9KuB0Ai3bHM3FHAkwfpLds87OYDlCb3ybhDOtul54mm6UZum2K3Mfku1ul?=
 =?us-ascii?Q?GZ8xGpqNrz+evlyYwTZVV3JVlybGsdMWhyiJnRpPO+6ky6mUkD+pWISIpj8e?=
 =?us-ascii?Q?GnekIiwG34lD1drisN4GYORBiqpx1BK9n+QDgLaaMHbcIjkkiEZk42qLJ+Ek?=
 =?us-ascii?Q?bBkAHOjbsGHuLt4h5zYCIS12/C/a1b0zfX/6bTUCzG3g6mGzYnjdYzouMzNe?=
 =?us-ascii?Q?OnZGtsDkGy9pMhHOQdCeQUB500QuGOEvN3zI5iOvKxRvVMweqfTRWuYhVi++?=
 =?us-ascii?Q?Jv6RlCuYHuKZZJGJRaXFL9OerMJLomvcIBJjg8eDvbc1fZgTr8nSUB4usvjn?=
 =?us-ascii?Q?zjEwedit5acOxjBHy05/zw5CFg3F78bBGT4LXyms3V2tkiEhe5nWftSrhwAN?=
 =?us-ascii?Q?HbcfrEB9f+TMdWr6Z/vKijRn+6iG6LJ1vMHM6a95AW1lzlYM9gS+wvIjVx7b?=
 =?us-ascii?Q?0YUHZBiqvKmpFbixCNZT8wlailDoXFGdhrsR1vk5xRTM7hOGFDZf2fQoHrox?=
 =?us-ascii?Q?EfwF52wBdSjFjHqLMOK1a2rSmORWjoB3FQqO0VG6typlA6EdK2QPIEoW1+u9?=
 =?us-ascii?Q?U3KFlSX0pTKEsQx2Dps36x7J6vrdWh7y2zeM+htyStPahyQcJXGGATFQE/8X?=
 =?us-ascii?Q?xtoJqKFpuxUOEOe5jRh4zydXZNbRwCnGbT1Y2gVQ+1gE7CnzCO48tgBodpON?=
 =?us-ascii?Q?GTO2WvlSGeLXDyVNPId0DTmNtktKQBOMTbxxtNPJxh9gxtqj3nohFTVdxCpi?=
 =?us-ascii?Q?vFR7XfXn+I+ODwZ836wPJXcW9zwSRKtWUwGN+8q7?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3ab053-b1c2-4acb-c49d-08dd33db1373
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:03:37.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WftKMHQrh2vWqevyxtKJ164/wDYZzXr86+cpcjB64CwfvwWN8Yq3S6TVZWCM88u+WoFKsI8LWi6vSlrhXf4Czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3411
X-Proofpoint-GUID: 1ViBrjrrtcBF2qxzOFCcB9MFMncmHOc4
X-Proofpoint-ORIG-GUID: 1ViBrjrrtcBF2qxzOFCcB9MFMncmHOc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130118

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
index c3924cc6190e..9320259304cb 100644
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
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
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


