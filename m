Return-Path: <stable+bounces-146240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771FDAC3018
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148067A6E21
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB51940A2;
	Sat, 24 May 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="CvWNGBWX"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2125.outbound.protection.outlook.com [40.107.94.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF43D984
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748099955; cv=fail; b=iiyOc9yoNKp2TuI0uMwnnf98zyrjAcyJYOubZ0UfpPNR/aExurfTn9DC6ydZDE8B9UjPOl9LdH/yMqcDAhfQptV0PCOTPNBaAqHQXnMhr0IqDRh7ubxhdQAhyxVEqnURHOyD1mKhljP6LfW3WwRM5t++t3Dfu4Cu6x/UZcVNNLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748099955; c=relaxed/simple;
	bh=FPvIJ7SQa+N19pRC0/vPMKXd6kpNT9g+lkI7uOQmxhk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:References:MIME-Version; b=VHPa03kjM6UiUdCgk5jO89IrDOOYOnKw/t/jmhPwSphSNkBc+yD5uioaAXY/JXe7tCUurQ6ekSgaldygKBQTZPI11s2TXu4yhFpxP0o9aFRSEcVLfkNr+WVaZbcn99Hwt0M5FuGhxJMfx/odoRdtSgMdTuO9QghxtkF325++rbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=CvWNGBWX; arc=fail smtp.client-ip=40.107.94.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0HH1pZevI5EYq8ajp650xipsWgMmCcG/2QV85V+I+I/1F/0ArM2g7LBZKEbcmE0Zq08Utq9/PVNjx9AYd8vRQ+GOdj5GH3zTtdLliNtYuFV9D3fjinrl2JGiWTjrcmNfnR1FpV8C4XB/Qg7zL3tXeh7ersSkgrTrMOuHSJYbPIa65ccttIVzljCLWhHmFtXDJ+1NAEvV/0tpqtA/iRK+z13Opf7hnpbAZE3fgMNmD2vOALWZ91l1ldVEOjeGIICAjrs0grJfTI/NJvi1n5eRjs8DuE2ROyyJTCduFyesnoyjmFOKzXiildv8BxM2ZHJkSow/7oStNjM01278BIqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/A/y8bo2grrpTtFRbGzout5NfmwMnVaJU3V9hM1m8k=;
 b=bt1fHt3V5ktvK8w+Gj8viHf42pc7NiWRS4rh31DVfQ910jXyvVa/CLhH97jIcTzHwK6qCqtfR+dJ7HOQ9UlSB6LmTcRSdD3V8e+dWOgmWSob52FJY/iF9KdHh0j3kVxj4T114rNbceFKi1uAfwyVJd6aAFpMWXyU7YP2Xqz/RV2cAANsxYg7rpGDNpxz3RhRsQzPvfyJyEy4J2d4dKwE4qc+a6R0rpgMNNxyjjhCau/7bzJzClUZNxgUiCyaVZDVbMP9/ZkRdyIkIoRw3uhBCQQGzovfzURft6u3E2snv13nQdFi+VecyvVLOy0MFFq+EvVIaEv4iLhZXdexsK3YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/A/y8bo2grrpTtFRbGzout5NfmwMnVaJU3V9hM1m8k=;
 b=CvWNGBWXuy+eh8K3YEFULQcsx+KwGL0PyTJiEIVXqGbKwfDRiUyfYnWmmXqbtrd7soUFdm2HMEBCQ5XCuzRVWEJBxvi9nbXolo+z0sjZD+1LoHpu0qOPGsRauJ0+XVN3wJ78zYGEELmV+i8GJAdksxYOIoR0i8JHfSpwjDCznMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from BN7PR08MB3937.namprd08.prod.outlook.com (2603:10b6:406:8f::25)
 by SJ0PR08MB8183.namprd08.prod.outlook.com (2603:10b6:a03:432::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sat, 24 May
 2025 15:19:11 +0000
Received: from BN7PR08MB3937.namprd08.prod.outlook.com
 ([fe80::b729:b21d:93b4:504d]) by BN7PR08MB3937.namprd08.prod.outlook.com
 ([fe80::b729:b21d:93b4:504d%6]) with mapi id 15.20.8746.031; Sat, 24 May 2025
 15:19:11 +0000
Date: Sat, 24 May 2025 10:19:09 -0500
From: Jeff LaBundy <jeff@labundy.com>
To: stable@vger.kernel.org
Cc: jeff@labundy.com
Subject: [PATCH 6.1.y] Input: iqs7222 - preserve system status register
Message-ID: <aDHjbf7dPo8hMPbr@nixie71>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031607-striking-creasing-c69c@gregkh>
References: <2025031607-striking-creasing-c69c@gregkh>
X-ClientProxiedBy: BN9PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:408:112::30) To BN7PR08MB3937.namprd08.prod.outlook.com
 (2603:10b6:406:8f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR08MB3937:EE_|SJ0PR08MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: b9305464-a2d1-4175-5693-08dd9ad65630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vluMC/miHKjEdpMAbHIPIe7A2OhiqMgKzf5mkNOn2n8tLfjV+6Py7KWKbFy+?=
 =?us-ascii?Q?gHaqevTdsVTuASrVT8iGBWuSJ3qMT5vmLumPa418cda52enVjPLPg1SI89JX?=
 =?us-ascii?Q?OCuTCNuPBKxp7Hiv1TuGPW00WcAJmCb8vm3s+UpUCLP2HqRueyuJJt5x0kp7?=
 =?us-ascii?Q?4w/siH2Baqaz8yKzxNdA2v6dJQNph24oJBtu8yN2JQiGS6rQwHM06v791JKh?=
 =?us-ascii?Q?I4cY3d1PND2EWqiCrg7guX5PfGgJOpzycH7ppcUoo/Ti3OYAOf4k8C4PSuhA?=
 =?us-ascii?Q?rlxarAAU4z2e5ua1qehFkHYyxHbVkrtL6W4GN9wESj5I3GFP9/FlVrDJrGQ4?=
 =?us-ascii?Q?DymTrzDSCcPrG3FvKkjZZzh/4TNgEoSTnGzQJKuTZS0T3NCxj9G25DjNBNOp?=
 =?us-ascii?Q?zZrOYdE/7ZEKHFLILNz9z78eoEDUmjfAzVooN5CfHjWpkqvxdhqcdT0fV2ky?=
 =?us-ascii?Q?2BJaLrLQqcgEDnWaV7JVCrC7DdK4tDkN1OzrZkC+GGOJVqy/R5KcE2ECtWXq?=
 =?us-ascii?Q?wv59uKVnyQblGPojE73hhi1n5jnPY3vifnd8Ci3MHnapIuuWBuiCmPml+AzO?=
 =?us-ascii?Q?KmtT7RbQabDOhbfpNO845rh1nVJftwxI7RjTViB7uP4hhk5qeBrZk5teeOR/?=
 =?us-ascii?Q?Ye68vwmPbdMxMUZs6lO57jFNEqjQFCn9VtI0m5PrME3rC5qv+/pt6Fh3GLwk?=
 =?us-ascii?Q?0Bf6yb8FlX5ODXxRIU33MIDLgBTKf5ee5f+1DTGWpi1Fpz51ksfg8h2jfzzF?=
 =?us-ascii?Q?e0AA2I+MhJ+Dg4fkFQ2s3XgWRp/SU+aXu4yk7ZaKcOoo0VnnO8ag18EveuKj?=
 =?us-ascii?Q?FzR09HNO4KCPxNHFfNIkEckNtHsROIQNbXVK62RNpk4L/zEmS34Yzb1CNM4E?=
 =?us-ascii?Q?b5XGe2Qnv4CRBzmMAT0Na2JIKAoAbjb4XPlVR44B4V++oZVRE6KvzymnK0nM?=
 =?us-ascii?Q?wU4eVhFYM45U9wW9EjbYGUDB5dp+Sfp0EFdklcahmInogrND3HHZUSn8m/yg?=
 =?us-ascii?Q?nsFGZWb++V7n+bbW3E7pNTSp3DUfqBSIN/GZC76YLlBNiyO6gW/qW0VVHFUP?=
 =?us-ascii?Q?MZ3wbvnPJY73quyhRMOjRXVpKzyUQmlc974nDt08RBmobhtMcBNYx5iw5QPk?=
 =?us-ascii?Q?XsdM+Ad3c8oxvIF3PZyuN4x5auQQy8kbQcT/PoyZnUMMxuFdZZfewWaIQzuF?=
 =?us-ascii?Q?bLMYOyJz4gfmwxmfsz6Dr0Y3I1zG66cgEUf3u50z5xAe384APA8qPIm242YB?=
 =?us-ascii?Q?KFUACyQZg2e/9HMewTE+KV3BssHj/Di6CHTyVxbWtqlewyC8JjE47gNn/nom?=
 =?us-ascii?Q?+GC0y6xVv66LLRHd/ls7JphgxNswTZu5ld/+aClFDyoOc5BEVXPEZmbVEEzI?=
 =?us-ascii?Q?RuaeiyB0WBJ1ku1Ot/mvjuBzbKmgzNYuuHbqY42624CjMFRDz5DeqS6X7ht1?=
 =?us-ascii?Q?vQw5lEJ00CI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB3937.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBOYK8uROxho0wre7OKL1wT93bl3qvbCn1MIOo5XmdvLsf1WUiSS9U+OPN8/?=
 =?us-ascii?Q?e7S9GM/Uaq/ixKlfSIi0RTv39MUVM7E7pIPV362Ufm2aGS3+663zMr93pLxv?=
 =?us-ascii?Q?1V4MFMZzrQRWT3s9fzIwIVLMk/F4aKGLcaLPTPlopwNQyoJoPOC/nazCrCeB?=
 =?us-ascii?Q?n56CTB07NEhzrvAT2CA4106eVEtdl8KXiR+xbYt7BFx2b280G0KPi0U1pD1n?=
 =?us-ascii?Q?5To8lYOvKHQyTdo2lOrjyJFCECJhISuXzzZF9MWGdAMVqPvvgHfaepS/rodN?=
 =?us-ascii?Q?sWCwi5QuaVA92LNJXPu9IJ+poYN94HFCcgNIjzux6moHZEosD/VgjP27lChe?=
 =?us-ascii?Q?EQdyHZ8rjOUWFU8/+k/n8/1Ie1AWM2zzOBHIQ8BAYDXgu2mQldh2C2OKys46?=
 =?us-ascii?Q?iQbsw6X0eufKXKuArGkgKYHFIB6Qldj49HlRov5YcPD9o5p0NZS8woXFcdzQ?=
 =?us-ascii?Q?5d2LD9phqrPJQCEygEeR/0Edb6RDat6TnwQDGGPQiRQq3ZfcFKvDRxHbytkj?=
 =?us-ascii?Q?CyyvFhKUvDGYzBS3HngWWEMqCV87k6RX8dMf3/tmgfL3uGWp++r5ne+hOsyT?=
 =?us-ascii?Q?VwelRVUl3dEGNv2o/Vc+/JIPv1gnNvRFXcuZwFXJuGz7D42eP2GvRXn521zb?=
 =?us-ascii?Q?XMxhZatPk2BKN06E0U6QLCkVXv8djopiZOcx/gKIgYT3YK0dn5FpI+Q8eH05?=
 =?us-ascii?Q?d7Ub5WlZWM8mlqxipYRBn4NtfTiZSBhnwRBdm8YUmaVXhL/cIuLeUtLZTNEK?=
 =?us-ascii?Q?tWmz4ohlvdoS69hwlsGlCEqa5enG9TxvFnHZVQwNjYwXgOGPg+GvC8sMO5t0?=
 =?us-ascii?Q?R05so9besZPbLjlCj60zD16W2v0p4abZyReqSv0n1sAUTiLtzS19u7sdeF5x?=
 =?us-ascii?Q?E+v9HYjKsemzR7e/JFfbPuf9MjRfx6TK/KekYpmMQhNGYX+wBPq3Ae4hmuV5?=
 =?us-ascii?Q?dkYtPohUVTjqyrMWhdcWwM2KmLMqDr0wBSu8vRMwu3425hclFJbQiKYnquOj?=
 =?us-ascii?Q?L13xzXLdI57EdNrGJ0ip+uNqfmi/pm2hzQ04OlcKhlJ/cHGNJVzzJ1tvUbGs?=
 =?us-ascii?Q?n49NCe87AcYTC0fqiiYqlHRSsqi5Me6o/RtTruyBVSEMJ1+zxShTLO2UWxoG?=
 =?us-ascii?Q?a1Ue+a/P602uQUL9/wtw8nvoq2QWFkD8zG0Pf65qwBWZSj//C47X5P2eIjL0?=
 =?us-ascii?Q?NTRuEtD2DBD6K6EhMCG2h5Uw2mdojhxdWZtGRJeKVrMljl7xgpYDwOxBvFmT?=
 =?us-ascii?Q?b6DEPiIXM2B3iikFTvPxVcM9AfnDVi6pIpfLBFFjGY1Mni1O7E8SiCg3wJpB?=
 =?us-ascii?Q?VSWdN+P876Q1Vpli06ldNo3xu4KIk5Wj2RpTjmsQLLGPtU9nwrXfzT980PzY?=
 =?us-ascii?Q?/NoNnKdiBrRnmtIGdf9IR9OJNqv3Pl5WaqWuumT7U5O92YPOCKLfszosaRaZ?=
 =?us-ascii?Q?kqoB/5iUjKAxegR77cvkiOtKt1NV31daXbWtXMkDaSRBO+V+V/+F+79LcPVY?=
 =?us-ascii?Q?Umy2hp5+8nY0NZ2+yh7FuOq3RboGVv5E2DovarHBM4AotiYNEoHREfyanQs+?=
 =?us-ascii?Q?QbCj/wHKYdKddpStlB5fFAx6b7gPtCGCxIjBx5aZ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9305464-a2d1-4175-5693-08dd9ad65630
X-MS-Exchange-CrossTenant-AuthSource: BN7PR08MB3937.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 15:19:11.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dI9v+i/fn3QTyNYrbr+WM9CLJPBfig4yZrWX46lsVnEdc1wGzSMwdVMHdsm6E0c/iu4fF4a/zR5uwcVgAmAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8183

Some register groups reserve a byte at the end of their continuous
address space. Depending on the variant of silicon, this field may
share the same memory space as the lower byte of the system status
register (0x10).

In these cases, caching the reserved byte and writing it later may
effectively reset the device depending on what happened in between
the read and write operations.

Solve this problem by avoiding any access to this last byte within
offending register groups. This method replaces a workaround which
attempted to write the reserved byte with up-to-date contents, but
left a small window in which updates by the device could have been
clobbered.

Now that the driver does not touch these reserved bytes, the order
in which the device's registers are written no longer matters, and
they can be written in their natural order. The new method is also
much more generic, and can be more easily extended to new variants
of silicon with different register maps.

As part of this change, the register read and write functions must
be gently updated to support byte access instead of word access.

Fixes: 2e70ef525b73 ("Input: iqs7222 - acknowledge reset before writing registers")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/Z85Alw+d9EHKXx2e@nixie71
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/iqs7222.c | 47 +++++++++++++++---------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index f24b174c7266..3bab7749f8ab 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -96,11 +96,11 @@ enum iqs7222_reg_key_id {
 
 enum iqs7222_reg_grp_id {
 	IQS7222_REG_GRP_STAT,
-	IQS7222_REG_GRP_FILT,
 	IQS7222_REG_GRP_CYCLE,
 	IQS7222_REG_GRP_GLBL,
 	IQS7222_REG_GRP_BTN,
 	IQS7222_REG_GRP_CHAN,
+	IQS7222_REG_GRP_FILT,
 	IQS7222_REG_GRP_SLDR,
 	IQS7222_REG_GRP_GPIO,
 	IQS7222_REG_GRP_SYS,
@@ -190,6 +190,7 @@ static const struct iqs7222_event_desc iqs7222_sl_events[] = {
 
 struct iqs7222_reg_grp_desc {
 	u16 base;
+	u16 val_len;
 	int num_row;
 	int num_col;
 };
@@ -246,6 +247,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -304,6 +306,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -358,6 +361,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -400,6 +404,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -447,6 +452,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -504,6 +510,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -1217,7 +1224,7 @@ static int iqs7222_force_comms(struct iqs7222_private *iqs7222)
 }
 
 static int iqs7222_read_burst(struct iqs7222_private *iqs7222,
-			      u16 reg, void *val, u16 num_val)
+			      u16 reg, void *val, u16 val_len)
 {
 	u8 reg_buf[sizeof(__be16)];
 	int ret, i;
@@ -1232,7 +1239,7 @@ static int iqs7222_read_burst(struct iqs7222_private *iqs7222,
 		{
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.len = num_val * sizeof(__le16),
+			.len = val_len,
 			.buf = (u8 *)val,
 		},
 	};
@@ -1288,7 +1295,7 @@ static int iqs7222_read_word(struct iqs7222_private *iqs7222, u16 reg, u16 *val)
 	__le16 val_buf;
 	int error;
 
-	error = iqs7222_read_burst(iqs7222, reg, &val_buf, 1);
+	error = iqs7222_read_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 	if (error)
 		return error;
 
@@ -1298,10 +1305,9 @@ static int iqs7222_read_word(struct iqs7222_private *iqs7222, u16 reg, u16 *val)
 }
 
 static int iqs7222_write_burst(struct iqs7222_private *iqs7222,
-			       u16 reg, const void *val, u16 num_val)
+			       u16 reg, const void *val, u16 val_len)
 {
 	int reg_len = reg > U8_MAX ? sizeof(reg) : sizeof(u8);
-	int val_len = num_val * sizeof(__le16);
 	int msg_len = reg_len + val_len;
 	int ret, i;
 	struct i2c_client *client = iqs7222->client;
@@ -1360,7 +1366,7 @@ static int iqs7222_write_word(struct iqs7222_private *iqs7222, u16 reg, u16 val)
 {
 	__le16 val_buf = cpu_to_le16(val);
 
-	return iqs7222_write_burst(iqs7222, reg, &val_buf, 1);
+	return iqs7222_write_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 }
 
 static int iqs7222_ati_trigger(struct iqs7222_private *iqs7222)
@@ -1444,30 +1450,14 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 
 	/*
 	 * Acknowledge reset before writing any registers in case the device
-	 * suffers a spurious reset during initialization. Because this step
-	 * may change the reserved fields of the second filter beta register,
-	 * its cache must be updated.
-	 *
-	 * Writing the second filter beta register, in turn, may clobber the
-	 * system status register. As such, the filter beta register pair is
-	 * written first to protect against this hazard.
+	 * suffers a spurious reset during initialization.
 	 */
 	if (dir == WRITE) {
-		u16 reg = dev_desc->reg_grps[IQS7222_REG_GRP_FILT].base + 1;
-		u16 filt_setup;
-
 		error = iqs7222_write_word(iqs7222, IQS7222_SYS_SETUP,
 					   iqs7222->sys_setup[0] |
 					   IQS7222_SYS_SETUP_ACK_RESET);
 		if (error)
 			return error;
-
-		error = iqs7222_read_word(iqs7222, reg, &filt_setup);
-		if (error)
-			return error;
-
-		iqs7222->filt_setup[1] &= GENMASK(7, 0);
-		iqs7222->filt_setup[1] |= (filt_setup & ~GENMASK(7, 0));
 	}
 
 	/*
@@ -1496,6 +1486,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 		int num_col = dev_desc->reg_grps[i].num_col;
 		u16 reg = dev_desc->reg_grps[i].base;
 		__le16 *val_buf;
+		u16 val_len = dev_desc->reg_grps[i].val_len ? : num_col * sizeof(*val_buf);
 		u16 *val;
 
 		if (!num_col)
@@ -1513,7 +1504,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 			switch (dir) {
 			case READ:
 				error = iqs7222_read_burst(iqs7222, reg,
-							   val_buf, num_col);
+							   val_buf, val_len);
 				for (k = 0; k < num_col; k++)
 					val[k] = le16_to_cpu(val_buf[k]);
 				break;
@@ -1522,7 +1513,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 				for (k = 0; k < num_col; k++)
 					val_buf[k] = cpu_to_le16(val[k]);
 				error = iqs7222_write_burst(iqs7222, reg,
-							    val_buf, num_col);
+							    val_buf, val_len);
 				break;
 
 			default:
@@ -1575,7 +1566,7 @@ static int iqs7222_dev_info(struct iqs7222_private *iqs7222)
 	int error, i;
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_PROD_NUM, dev_id,
-				   ARRAY_SIZE(dev_id));
+				   sizeof(dev_id));
 	if (error)
 		return error;
 
@@ -2391,7 +2382,7 @@ static int iqs7222_report(struct iqs7222_private *iqs7222)
 	__le16 status[IQS7222_MAX_COLS_STAT];
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_SYS_STATUS, status,
-				   num_stat);
+				   num_stat * sizeof(*status));
 	if (error)
 		return error;
 
-- 
2.34.1


