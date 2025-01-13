Return-Path: <stable+bounces-108440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F0A0B88B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5157A433D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859723A575;
	Mon, 13 Jan 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="saKLkvIN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D91BEF8A
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775862; cv=fail; b=eiTwjel/VtCbwwoTGLblqJCWOZBhE1wUAd6PcsZI6YeI2anapYfjuRv3jw2gx6knPRXVEE+sYns/sORm6UZU0rkGzBRpayR29ecmJAQmhTsDlVhZlLHJqZ5L+sY7yP+SQVl493IuaTpvJreU1/JlaJJAfeht1LKxR3DZYXXiyEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775862; c=relaxed/simple;
	bh=kUMFBu2fvBnH+o1RdAKVIAamyJvPFndQRVkGybXjNuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaqG0ppXsRS9uZ3cXPwMkjkpeVhWdGCphtApcoPXfSNDBVt8TiRnBSZUO55B5GnOKoxoisEBzt2+urTFYVs1DpxhXfOc0/Iz0lzFOskyK766D3KY3Mg3oz6kOPaN9yKl5OoGIylGUi2VYUYOMbs3KmTL2WGAVNVqAinoSAbWFHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=saKLkvIN; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D0TdSC011879;
	Mon, 13 Jan 2025 13:44:09 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010002.outbound.protection.outlook.com [40.93.73.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443hq4h9we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:44:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luEBmPbZSfIAtmoMfLuByIFRvzdy7lZs48Y1UWYTPMTsQlxLwMpnE/zIpmQc0MXa2uccK78cBDvIAW+Q0/K9oRehqEZW+1lO3HK81wdjlvfnqApMR9Gm0c/Japk//ew7ba8s+AMnz/jfeWQL8ibLobWtsnCZ26gLkRqKQjk6Bw/VfKaEDXMuwB6kJLR4sm/2whGpAmhE+yEYWIHnI7Wwv8feztMDYtpfugMcuu2FxxdBFoTA3qPldp52Qf3PmxcL+PMnJlCUoEa7Y3c7r1iKiCXUBHEOgOM3qzk9qdZcFcpUnF+E7zGelaVWee1Irlnw72Bb4Ox10OAuPgzUfnpe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp17LN1+8ifV7lvUqM7WSljoUB93uWr8hfL7cw5zKpw=;
 b=h8J2FzEAnE6aHxTOa4Grr8FgMCIQ7873jg2FAAzqwutLYuqC8Up7jLtivtPquIfPVnqqlN4YRzySGHi1Mb2lgWZIgpx6hOLkcuEZTEO4N10aCl8f442dKBAqAzS3rsQDU9I7bTH5DF6CdUGI0s1a5EgBThPGSQbAUVDXgPXI6QE8wDHM2WLXSUE1dxxQSsdQ/3zwf1EGV/sD/CF9Aynb8XjudBlC+p0PgU0/K1RVj4TeBTdwp/IOnMd6dDxylX/1zCDG6YDAIdRr+cK8rgdmmpaWSechXkyHFdiF9Fpcs3WLkAMgQuYw+N/p70uipAmr84kUivXLeZT1sykjXf7wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp17LN1+8ifV7lvUqM7WSljoUB93uWr8hfL7cw5zKpw=;
 b=saKLkvIN6VOE6WmMXXH9dVs4SmMkZTERroY+7Uzq+efrzljWFzD8eWKdR//RPM7Bs7tV/ls4TmGKzLJrJaJyqdoRCgx2IkX1mpHQqgnY85pxpOk5nUJufLTwF16wC711z6h1+BWQB0XaOWabPRhR425dhE2ZxFalkCBBm9aXwv+Dcmir/IJu1W+XrCdOP3P6c223eDLfPOuSoG7/OzoVJgYdhCshJmOkjo/PjJKR7bqGOpFWFo7BlKRNpQA6ZxXIerVqtKfvVwIauVs00e+n8plJdwsKIRDo6nvD82SYacWvEM240VdkLXYZmDxR72nrcG/3UkMKH6nLD7A4NiApkQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYRP286MB4735.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:44:03 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:44:03 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:43:51 +0000
Message-Id: <20250113134351.378484-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011347-quilt-fraction-73b6@gregkh>
References: <2025011347-quilt-fraction-73b6@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::13) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYRP286MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3924a9-4860-4ad8-4ff8-08dd33d8574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZMnqlZjHkWEKqf+HcTf81DD61J5VDSpH0FCwj68DAPi7vrsFSWV//vIkKby?=
 =?us-ascii?Q?r2oYGjFw625EaQUYiBYf/fU553wbWkkHS8iRlQIqX1cLMGy+iED7IRUHD/M/?=
 =?us-ascii?Q?7pqOivebS98CLLnLet4oWqyexTl4pCZO2Ua41wpFZ5WKQncoBfixMOivqAe9?=
 =?us-ascii?Q?+jgmL6lazt2fTUeds1hpF1p8ZE2t2K+86DJEbChIlBGsVHEt2GrT/vkwFXoc?=
 =?us-ascii?Q?oBLvU1kCbxFMyQKt4SgnbCe5ZCXxJcajsOSQENQnzLt/0hB6JBU8NlGOznZO?=
 =?us-ascii?Q?xbzDcZ/ykEPzAPrAMkkxU442bLomLWdSuYagNrWc7JfeT0xKlquEl5PSLxJO?=
 =?us-ascii?Q?FLmWDsOZfj4Vyx6Alc3Befyr3xNLOTmREUByD45CJIgXihLTA8LTAu1m9qdj?=
 =?us-ascii?Q?gKsqvPHnIV3VbpIgH4i33lSGRSvJ/h54T2P0K2lnJBOdvzdFzfnBtMfbLWE0?=
 =?us-ascii?Q?9SwVchZPFCASYf823d4xQrvN77SJjEK5TJx4gLrxOJzVLwrcfpDbjgQ8f0BC?=
 =?us-ascii?Q?V1C4KVCsHVtQJnu4qYp8RLT+nJ1gbaycv9iroWSdd25bxiZ22qKO0liUWfzW?=
 =?us-ascii?Q?SQ2lB6/dU7O38AKypGKeCP9X5pA9+ucz229ZMZpUI4Bi7Ze7X8ebbCC4y0eA?=
 =?us-ascii?Q?nhKWUpWyu2pHTh+//xdmQnzLj75KxdIXvC7J2HI9pPDxcAMQ5UzCHWkbnn2/?=
 =?us-ascii?Q?bsS54Yv4lp1Mpl0PI3C2k6uFehxPgojh0Qdv7cd8r4DnV55awG7AAi6j2PaJ?=
 =?us-ascii?Q?BZMYMEISjD8UMuCKCImbrwwU/gwH/mem1gIayrCIcFxdRHTyk7OUWJ89jUFR?=
 =?us-ascii?Q?aPpuMhLeIO9CoyGGCbtg3UsC2XqwJHWpuo4YfIm+j0QB0bCj2wbujYEYlZO9?=
 =?us-ascii?Q?T2dm/+J7QNUAPCdA5PvonAgRZ2KKPP3v5Vwv/Yv/AbwOg1hfG4hMzJC8ARmP?=
 =?us-ascii?Q?f2hWYkPUcwzeI3pQHBbkeeUGaJO41qusJWi9/bBl9UQQ7Yx/uQUDzuMsIURv?=
 =?us-ascii?Q?iuoL4V1KYFc9+q4GAMzKeFx2ssCeGXExnlObxDj1ng+JtTKVy6Aih6xegHL/?=
 =?us-ascii?Q?EFrWpG2BNpn007bZmLHvZZPaPk1sJvQhvUF7MY9skfXhsj/eP44+6W0+d90v?=
 =?us-ascii?Q?7S6pcRtt+StesV2HLhaGurj0waKWTxxK2OxkBEaFz6UKYiqeGDT7ArP2L1Ue?=
 =?us-ascii?Q?LbWwMYM0VVEVs1wD4lahn5SbkfY0XMWyL6TOs7I8jhHY5O+2HVRrGtXNEYDJ?=
 =?us-ascii?Q?Z9ccQrwyt+E6Qfqz3/PbzYednMNy3OEP8nEJ8wwkOjLTv4oLxjuuEXUZrQG2?=
 =?us-ascii?Q?0tE3kGf0ITwd88K9ebk9k2wN+tJkoyfNeIZ3TvvXv4SvCzB1Oe77gZHqHwtS?=
 =?us-ascii?Q?kuXo+sU2HYaFUiJVcxXK6GRwiQywylsfN3Gwx29hEHcbBcBlgdXq6KZ+tjVY?=
 =?us-ascii?Q?7rUdfKLs15M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9ch2aFPW+vEZzNsfftiZJ9KCIvKjpzzlwAcc49jsomf+By8heEys0vMQ7jf?=
 =?us-ascii?Q?vyTyPE63b+0BbTUVD2vlAinclXrm7xfaa2pu+Bu2nrTz2vSMfQilErCXDqBF?=
 =?us-ascii?Q?Xtq51eda8jLTL+/NtvDnwHrXXYEvpLRbdkoAZJyV+HUZRhqaIVeAHtv/pzWg?=
 =?us-ascii?Q?I3dDZtxq7qKFbHwxilir6vVvWHqEktIflItvravQKR6UU+M5UDHuXBBIA3vV?=
 =?us-ascii?Q?1NuUAAdiTBXORC3I4NOTZ1iZ1d6SprzEHXZy6lXbDxiA759bYotXby/exmiI?=
 =?us-ascii?Q?uBvcsVsQLzGxd/yXMI/lJMco04TiK2F+GUo9zwc6bU8s2L/QopvJcil9MThb?=
 =?us-ascii?Q?RLf0BrYr8Chbyp3GBDe0XgqJhVZ69zCiRr5NZIcmLSdMgm4TU43G22LoHHuj?=
 =?us-ascii?Q?uwf/2LsfB7J8fTdv71HTKm2VW3zdjewoaoMuL03PCo+I5RpsuntNkFL68RcH?=
 =?us-ascii?Q?VsuE8HOeXFvHgO4NK+P5IalaLBZyZO0mJV7b2JlQNgucsdXBvWxhzxszYRkm?=
 =?us-ascii?Q?MVofwTPy4xhBzj88AUwlMr6tr1lU4PWA64tpLtGQZyK0rsxxkcS8P4hbtf+8?=
 =?us-ascii?Q?ZbPsct32ZwSBEeflWnPhpeMUjW6IqbXJsr7Nto6S8Dsxi+1/E51KviMTa2O6?=
 =?us-ascii?Q?ia6WdNBjB7wBdcuaTq4IMjMiMsvq6ViPx0uE3Z2gUPdsEDGfF4qluTk6DRhQ?=
 =?us-ascii?Q?TRycNHUUM6L603slaa+kUFBdLAvDH0vRuqgSXlvMgbIOnR1L5k6lhPGTNDFu?=
 =?us-ascii?Q?yVAXGFOC37DmdsvJS6Lu6ZLg3ncUwn+ryRRFSX+piBhOvVyKTZPOC8IxKQo4?=
 =?us-ascii?Q?zn1U9CvWYQ70F1TRzKWgfM2zGN8kwsT/sM/JbFYsPu7nMIBoXZn32JKUtXpI?=
 =?us-ascii?Q?SA4Q2hQnfBSHAPNbUJMRBGhpk/q/cP/obLaeWU0DRPWZXz2AiKJfjUWbjjWf?=
 =?us-ascii?Q?LoSsAsSFyHcp4Q67rt3Vu9RWuHcliSIdxVQYOFZPRXzGOiQm0L/6ue40Sg4x?=
 =?us-ascii?Q?DknGgAwSIv5KFy84oWMf2jrcKc6CfICV51vJavRmXLf7cBcccOXAsa2KCPwF?=
 =?us-ascii?Q?d8ULYzuvQR0WotIYPYvxwxa+B0C67tWwWBOXvZuG1lc68gOQ5ZkJ98/8iUDq?=
 =?us-ascii?Q?qH5l29BJVLSEs4EO3OOCTWensxFAXd9766hSZtLBHwDV4ZWhkOs0FerQAQCJ?=
 =?us-ascii?Q?Hy8T4N/TV0KXXx5rqhMf+sYny78zONSwGjLcaxakwG5fDNUa5+LCgibapHpH?=
 =?us-ascii?Q?apbsGqNbZZSQSpahmbVeD5rWbSZIqvrskC+i1loT537eCHUzyHsVBui8DriS?=
 =?us-ascii?Q?+5oKCzYMJI1adLRGKHpqOABOZHLDL0173zCyR5ITjXpyOkeFtmVxxN+tl7Jn?=
 =?us-ascii?Q?fr9hJIAxZS27hSYaqFU1muWliLtUue/oZbIhnmFL6/oB17TkWQmNheWTLyKk?=
 =?us-ascii?Q?tmC+tMdDLYUbz0FObAwOLoPoZvmVILc+tpyJg9UOSh59U79AV6SosyW95DqC?=
 =?us-ascii?Q?FSeGyfrZ7VygxQFsgqxEBRRHvs+S0lFdBctz2ne3w+xCzgxoGgPUfxWKytwO?=
 =?us-ascii?Q?YOcdF3ci7PqtGYjN7QlT/jo7mffDkSSeNbvbpd7D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3924a9-4860-4ad8-4ff8-08dd33d8574d
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:44:03.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utJdf5YPrA3ViOxMcit8VYSMSEtEpEku5adY7qEKCw55Qc/yij4avtyyDcnl1SoVblqhO4lX2Ze3x4mcv//4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4735
X-Proofpoint-GUID: ETlRsK9TWuy52Ch6c2_3TU0w8cYKmy-E
X-Proofpoint-ORIG-GUID: ETlRsK9TWuy52Ch6c2_3TU0w8cYKmy-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130115

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
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 +++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3d91469beccb..20fb1c33b90a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -360,6 +360,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..f4f0dc213769 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,17 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index e6305e5fa975..4441c3bb9601 100644
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


