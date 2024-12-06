Return-Path: <stable+bounces-99360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9E9E715D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3777D16784A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794BE148832;
	Fri,  6 Dec 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="gzLDQOIF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6121442E8
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496887; cv=fail; b=tMan6UE1ehpa2zxD2GJyf1Xo5IiwadOoYiDyFBZe8/DPv/UH4Gmd/k7MJScUjRDJwwCKCM0LMaoMhxmyb0pl30G+G4wmfdDKmrDeqSxL1l8rJAlAs/nKd2RDIdBL6g57OokBW/Ni1Z6HRVdECVSfM3BUicKJbQhfRy/90sBowok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496887; c=relaxed/simple;
	bh=5vFFxxf6g7nNsRqwdwnZHj7lEi4OH7fcCEVIz0k8t4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIqmeqAuAR+KrZ7N3Zuziv8wfGZihfrdPAgjZWYL0I9ux9S+QUW9qXhWgjyOGOJr/WQh5HAu9WuHgySusIy6TIQ0BgjF0IJXSn+xu+/LquIA4z6iPASJXsfIFu3KRp1dEnY77lexFYjH8lj34wQVIqSkN2BpO85eOdxp/xmlEgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=gzLDQOIF; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Mk4Cq025476;
	Fri, 6 Dec 2024 13:49:45 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011027.outbound.protection.outlook.com [40.93.73.27])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 437s2yn1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:49:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyaxk+++v/MAI14z3CJe5hyGcVvv6Fd/sjLQ39q6fwcoTrvFygeFL0vj25XKiFj3Dt14pQTSY9R/DsIhbSIeVHdIE+tYX/nZyLlQH0fxAL0oYAKZEmrgJMDCoHcpkxn04K0Kxb538KZE9uDgPG9YiiT6/BIONwZWApPf3uqCdS2pi54pN4CpZmRwZy+2OO/XPVWUYv0g2dwijW1cMXFQ4oif1cS1BKZSTMhfy1KXVmSCawPVE/miIfQlLOre1VLwK/t+5IDyy83bkItT0iNv8+IKMmd75fWwFaeoCW0rcZro4ubAfIqGxAG5YBv8/ivQlQhOLVENuohEMCoijSsyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHoNVyJYcc7B4N0VTPD0vVTvu+xKsRIA9fphDPU0fGM=;
 b=nIv5CVRyRYfd6B9D8H29/Did43+hIEzXRqDmsPMaUt3Ed9WSZcOfcXZE7a/YVtdDgVm0oxAWeitsZMczpNQlr9XpKSolJWYq4qfdFsV9hkREV0zQoNgvhPlQSTEtE1ZWw12J0vyR944RaasL3X438jT7A/WGjXvGTFCAwa+W9CessUAYhxlY8rf/JfO3V2w6bcihExRmqCmwRp0fAL2it4ouqw14v45oCmWr1BS9RxUPuSGCyMCr8KvgBmd1YvmTv9TvjHR5Etc7a7RMsXD+rGdWQmgCQqM0NyiW14qDSqeWYNmbKbpDs8tNGYYdAiJ4WsbN9EUOR/jbx+nxRH6jrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHoNVyJYcc7B4N0VTPD0vVTvu+xKsRIA9fphDPU0fGM=;
 b=gzLDQOIFCkdSIwS0lFJpsx+uwosEQHskZoooS/Jrwm4+/QENX6xw/YMtK1s5YGmouz5K38LeVhM2cTutu8lQS1IzwIHLLRdQS16Oui5Jbb7H2aU6HawEoZ7/jj0okOdxwTMjUeyNWiVc44Vv5toT3o61G0V1F1+tSU4n18etvsKeUYv8wVl/qDfH/cAecLuCqtyYYnZVOSFiE9hIvmJZ3g4dcZJvQ01zNW+bbOZNlCKPP68D0YKyqbfpRnMVg2xwcusjCmoMsTOJbae/jpL/XwrmUV5gAxbmjzHLHEdj9uOesYh4xMiVHOzComZVylIqE7xNOzoFyenC1uER00fxSA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB4894.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:144::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 13:49:39 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:49:39 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: invensense: fix multiple odr switch when FIFO is off
Date: Fri,  6 Dec 2024 13:49:22 +0000
Message-Id: <20241206134922.57001-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024120613-exploring-lifter-215f@gregkh>
References: <2024120613-exploring-lifter-215f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::14) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 37632c4f-ede4-43c1-78cd-08dd15fcd3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2T7dFg+KJ18V1Uj6TWLDJ22ruZdcgMeRQsU7S3Z1FmNPVn4tqPNYi9Z68vE2?=
 =?us-ascii?Q?QRfGnlYEd/qMaoFVZJoXD2gppiIL9nAyaRG2Fz8KBU/iJUM+8aDQFymfdFup?=
 =?us-ascii?Q?LmeK+ONrYIQnEE7qdzhkMHHayaihfTF5bCAY1RCS/LAK3c6W5hx7KPdZeQsb?=
 =?us-ascii?Q?dG5N1P+IMmquW5X5L0yf9BKutK1cntH3AHS/p24h95VuU4NdGjvU3JtieXVo?=
 =?us-ascii?Q?9uL9qPs+H9rDlp/skArI7pmF3XV2WCogvwK63ZN4jsY/gfXwwsT1g4slN6kl?=
 =?us-ascii?Q?a9VRrpePmSnTzT2BGHxNn3xMLxqvypzxCq9Wnmv7vsv1FlLZIR6uxKLG4uij?=
 =?us-ascii?Q?c6mqMuCLqq0RrohBIbxZaqB8tPbHwt8PB63BgkAwAe03JZJSxQk+WYm3fjIV?=
 =?us-ascii?Q?M47Nh9GDMbs3cw15UyF0C5ZVkiu+FLa875TTPJ1JL2WV+NP+H3tGIWZSj/PB?=
 =?us-ascii?Q?qwVCg1F0rFqf9dTk6pLOOILd5G4X793KdISKeb7YYel81fyhAxggIwkEhakd?=
 =?us-ascii?Q?TV1DXLxygJ9k8+163rFxpYnSimOzIejVNO/6s9nzxf6iN0CBd8fYPSaX7WOr?=
 =?us-ascii?Q?oQWLaxlJKkHvXJXWMczDafxNQKb2GmH3VDdyXFs+ERNkLgHOdvS4PHFEmA+k?=
 =?us-ascii?Q?lkef98b7XnrzlLQbYMm5JR6OQyjzBNUn+llrYFobP3eOEBbHN01IkFG+4Pec?=
 =?us-ascii?Q?Bkv64LENp4tMQlkcBI6ogQMpESRquGICFSKyOEzVTV9r49JqCAUNvjLw4VgQ?=
 =?us-ascii?Q?5J1RNzq6A7KdzbhZaFlTg77/BC06iXeGJUUeSzMigGgsN3razo0/Ya9N59F0?=
 =?us-ascii?Q?DMOItTIQrfVbsMt4bY7tyE3msGKWcNVsZICNl0bighs72S02XLVrPsiM1cPh?=
 =?us-ascii?Q?YRGlZJfyya2OTrrPH3eH/ao42YclOXivM8Z/58s7xJwYxKSUaINoRJbjdi8k?=
 =?us-ascii?Q?ZKhfarVkuCxVNH9iOSDJgtOzNHdYmRxVjUBiARJmQJsDouGCa01HWRSvcXCz?=
 =?us-ascii?Q?5nZO3XWQu3h5sa8zVe42JHfsbk8FogkoWdccSTzGfhrncOUimk+R1OhDUcLk?=
 =?us-ascii?Q?p8kLxF2yv1o5hy6sgtdAFiDfnOar8bgMwv/37gHz4aYEaZLeFtBRa7MJW12f?=
 =?us-ascii?Q?lxBnl7SmPN6wRKP3AEfJjW9mfBytLkEwKob2isPtV77ZmhoOk5aYPsKSm0sb?=
 =?us-ascii?Q?DPibO6Yrs3D2VlAKw9JMHO+MzC76KN6bdkhJe85NKW27W9C9JP55R1qr/Ymk?=
 =?us-ascii?Q?6I2Wi7q07QJq9ZkGjsaSUYu9gyRBJcBUWtbwRy9Zj9UyZsLSqYcYYa4DwCX7?=
 =?us-ascii?Q?YBEa7M99nS/yo1mPE8xyv9WkRdxn/Ax1Ndd9CXZ7jzI+2KLhOGGxtqP1iRWU?=
 =?us-ascii?Q?IFLpSoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rKzZ4TlkFAmrZgieuCFaqWi2lXywzPlcyQLL13w4yjxS8YGQuAEigZh9hu5?=
 =?us-ascii?Q?9Grk17tf0EwugTD7oMWCQ9sGU1NHcA38Y+GqNVGdJP3VQRJB7XwvH9QIECpS?=
 =?us-ascii?Q?qZwTqGUM1tCgFFpmaTjEZF9Yzu7pwWfRKUk5ychK3CaMnuFaWZz1uHgpfPpp?=
 =?us-ascii?Q?Fx0QQlEDrcgjQbPvgMFDqXdpDo6Hh7Fc4I4QneknNhA7UPXnFMtgzu2amfGz?=
 =?us-ascii?Q?YsIqUd/Kc1ZfjLcBdhZTaRI6Ox2iSRur8EvN11APIBFG1SmrOt/UtkyK0wN4?=
 =?us-ascii?Q?QF0rOsyw5y0Pqo8qi/VL3Bdzv7PRlaWitlZGwxelaMtKQ6n46Ob5ygqTMJdd?=
 =?us-ascii?Q?SnP4/O4lvVH6grjuRGhXjlgmvU/GhPNvEBXkilx4/CjP+jJm8XOd0xbH3rDc?=
 =?us-ascii?Q?FdEYC94h5PhuWAP7wJuMxCPjvYqm+mnk0bWb7RK6JRouUaufPile0v6ahQYa?=
 =?us-ascii?Q?2AdZenLpOCKe0emmbbBaZYctoLM521szpaE/XIr32+wi2+MWzv5tWr5Ft4eM?=
 =?us-ascii?Q?5+UpyxKeYgNxdm0KbbYB8F7GaUa4k4gfNXVRaxeMVVHDppyy4XbQi+D7fxlW?=
 =?us-ascii?Q?HE9XqTLzWohSjGT4x2FgU0zkxozCOnUPk6VJjTIr7yfGT+mepB90KTK6uM6+?=
 =?us-ascii?Q?Q9P0BXzoQm7ubImoOAm0HUw+qrC1R+5TXghxMBVJJ0NZRN/G5A/EoGsyruyj?=
 =?us-ascii?Q?+OMghcjBNp3rcZWb+qETx2ifjxUrM5BJ6YEkp+Kt2LLKMAufPCXQzzL85+TA?=
 =?us-ascii?Q?9oLVjZaBnoZCtVEikekH2tL2gupQ83NIEKJPpqldEGrJrxLeWXDpnzVwPgtY?=
 =?us-ascii?Q?U+g5WYJyNKwQMlNIF5Q+p/IqpLRBVIFEIt+L75PtJYeOtaGHZCjKGHjjbJzw?=
 =?us-ascii?Q?36r3hs6xa6HYG69gqj5lO338Ka4T2TRjx/57NE5e2r9Pi6knAgFglEYVlYkJ?=
 =?us-ascii?Q?wo68QHGDxXFYwtUkRDOWCPN9vdReww+nXv92mo4K2E/Tp8IMOeqCwHkZFEvJ?=
 =?us-ascii?Q?ah0TGrfb8JYlWphR3Gumye2yQFqN0nNvqN0VkNMBYv/ytAAby70EcH28OqPI?=
 =?us-ascii?Q?qSVvAnvmy3BOn+hzKknfGVyJIKEjOS8W4ALG+ue8xy6nDjLGs9bMIQ3XHN5S?=
 =?us-ascii?Q?xnH6wvX/RVSW5gPigjB0ZL373S6TshQLJQvoh4N/B3D2RwYWRz5lu6AZvbYM?=
 =?us-ascii?Q?yzbqKT/4C/NA3msg5L8yboklv72qnm+Bd/vBlBmS/Me0/oOwxqOev24i2eNj?=
 =?us-ascii?Q?fsJklv4wQYyXjCfW8qgsqw+kx86+mSdhCgjCKz5H7xlAkCLyQSwfe0pLcsC1?=
 =?us-ascii?Q?ATKjjsmEE1JWL2GND2HYQ/goJLprD2pKFvCar7YXSlBCA4IlAOx+2qmUl83O?=
 =?us-ascii?Q?dbhj4HTFL/T/X4QblRZ4UVFwATV2K7jBO6sTfxkF78+cxVkjgOgKqGICr4Fk?=
 =?us-ascii?Q?DIxKZ8GG5B6aBwGK+V8cldCulTquUpSgto2gme51aZpntNXDsJB93m1Ra5gs?=
 =?us-ascii?Q?ZJMN7DlmtIV9VqVcHp9cuKAUIi6I9rNy/y2SXxgr7TenMBW00FuKYX59V0Oh?=
 =?us-ascii?Q?48x5bOMexFdQ7U6mbqo83aVi79Od6kMgEnu4P2a0?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37632c4f-ede4-43c1-78cd-08dd15fcd3c9
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:49:38.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC5+a27Au3eltpttkWVhetBB/Jd18dHzbWdVKj5ztlIV5Cd8XlkRTN73mAt8eS86EgGfqnJlW3m7v5G3XpC99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4894
X-Proofpoint-ORIG-GUID: zxH1I8Sq6EoaoAjVn-kwLnH832HB_LJY
X-Proofpoint-GUID: zxH1I8Sq6EoaoAjVn-kwLnH832HB_LJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060104

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When multiple ODR switch happens during FIFO off, the change could
not be taken into account if you get back to previous FIFO on value.
For example, if you run sensor buffer at 50Hz, stop, change to
200Hz, then back to 50Hz and restart buffer, data will be timestamped
at 200Hz. This due to testing against mult and not new_mult.

To prevent this, let's just run apply_odr automatically when FIFO is
off. It will also simplify driver code.

Update inv_mpu6050 and inv_icm42600 to delete now useless apply_odr.

Fixes: 95444b9eeb8c ("iio: invensense: fix odr switching to same value")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit ef5f5e7b6f73f79538892a8be3a3bee2342acc9f)
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 2 --
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 2 --
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 7b19c94ef87d..e85be46e48d3 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,6 +70,10 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 	if (mult != ts->mult)
 		ts->new_mult = mult;
 
+	/* When FIFO is off, directly apply the new ODR */
+	if (!fifo)
+		inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 72e954138102..47720560de6e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -99,7 +99,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -127,7 +126,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index f1629f77d606..d08cd6839a3a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -99,7 +99,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -127,7 +126,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e6e6e94452a3..376bd06adcdf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -111,7 +111,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
-		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
-- 
2.47.1


