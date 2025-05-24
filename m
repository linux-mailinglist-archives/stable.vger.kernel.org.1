Return-Path: <stable+bounces-146239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8CAC3015
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BB6189FAFF
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C639FCE;
	Sat, 24 May 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="e0LV+hvW"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2108.outbound.protection.outlook.com [40.107.94.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7822DCBFF
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748099765; cv=fail; b=D39zDPIJooo7CEcKwhYh2Ym4Mmd/OVyTnq1NpuY/nNKW6/1L8kognG5yMmbGXxz5MpWQPaORJe2NOCPkV8WCqv2ugAYMJhQfuOYADsPiSX1MRkxvG6lWs9EV2XEV2McE9r9QrEdFqv5mCAEgxo6+o6qnuw0MKMbDBtkuVRzqBR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748099765; c=relaxed/simple;
	bh=FPvIJ7SQa+N19pRC0/vPMKXd6kpNT9g+lkI7uOQmxhk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:References:MIME-Version; b=TLbsRTP1VeReYDe/zdCW/nnr5fQE0X9sLrj8hTV7gMYxq6RqCoWKTwnWVHAlN5gb73s3myBKF27FlVsG/jfPtJ62LgDeWfaXvQ26GrbQUYb7XeZawQkEYsyyhGeqzVcTTMR4VN68nQxO/F2R2rJIW+FtqLuf88hyhPZsbyo2DZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com; spf=pass smtp.mailfrom=labundy.com; dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b=e0LV+hvW; arc=fail smtp.client-ip=40.107.94.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDnwvv1OU5J8xJ1qHQ2WhLdbNx5h/tLWmsl2ex180kq4ozlK5+/4BwqPOBfZw334k7kmT57R5vRmoXhuVSrsDAbzI8V2opzuUKzw6e3FDvoPJcSsaBnrH+m9fZfNftc1eDUr0FC0V2PZdXT9sW+WQLNE3+to3BTv5jc5OhMGDMwSQnbRi69c05r6SWGNnj+ytIxmmQdvbWBTxfPUGBmknCldj3IHZ2SZmEPILL0E1CLc3y7Z9Xt1egC6Sdv/vZKk5sWJ/tFLd4XpTXvQhuoriMdm/8SYVzAhcxlAHqBCK/K3cs3lW/dJIhuPAHnKq3gJlfrXpkjOmKNSeZlHzigqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/A/y8bo2grrpTtFRbGzout5NfmwMnVaJU3V9hM1m8k=;
 b=M5jOFE49DbOov1OPIy0LXwtQGJ88WnijECmQOaKqaBJUmU8tLJh4PHlRpEeeXi12k5+d8gnPrvIcRLhP3HI7GSACyrjNDzpzUwFxSoOVUvpwqP3vNnRQKefLyzR1RHCjQnbnGyqH1AFMdE6+0yeQROLVpNDc6xQ9g97WH8ua0oYRwZyysHWA00a3lmYjIx7LR0zS0w5OYre0pcJ0r9AqOWs7hG4cBkPD/xiLucI8TFWXyNyjM2GQTp67vczJkA7JxGbzABtXT+MafAipsQj+5E2k2bAEJy1lggAAlXQ2wZFqlJcY30BmHnKwyEs0ZzNzkVBXM6ekMeHihQx4rPXCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/A/y8bo2grrpTtFRbGzout5NfmwMnVaJU3V9hM1m8k=;
 b=e0LV+hvWTqHU6ZhfA9grXDdxSn7QI4JrU+BCkrBDNkt88sc3QZ1wYjsZH8dyueLwcue1SAoxmhK13HPHoRIYXrIO4mIgXzhJyfpZmlF0sfBIIpRWshAILj3hPHw2UuEYhDnzlD9BHT+nInK9r53JbqlzU3KFVUN6AaQI1tAGIyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from BN7PR08MB3937.namprd08.prod.outlook.com (2603:10b6:406:8f::25)
 by SJ0PR08MB8183.namprd08.prod.outlook.com (2603:10b6:a03:432::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sat, 24 May
 2025 15:15:58 +0000
Received: from BN7PR08MB3937.namprd08.prod.outlook.com
 ([fe80::b729:b21d:93b4:504d]) by BN7PR08MB3937.namprd08.prod.outlook.com
 ([fe80::b729:b21d:93b4:504d%6]) with mapi id 15.20.8746.031; Sat, 24 May 2025
 15:15:58 +0000
Date: Sat, 24 May 2025 10:15:51 -0500
From: Jeff LaBundy <jeff@labundy.com>
To: stable@vger.kernel.org
Cc: jeff@labundy.com
Subject: [PATCH 6.1.y] Input: iqs7222 - preserve system status register
Message-ID: <aDHip8uMZlBzg6kb@nixie71>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 2025031607-striking-creasing-c69c@gregkh
References: 2025031607-striking-creasing-c69c@gregkh
X-ClientProxiedBy: SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::21) To BN7PR08MB3937.namprd08.prod.outlook.com
 (2603:10b6:406:8f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR08MB3937:EE_|SJ0PR08MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1feb82ab-496c-4d24-1b8e-08dd9ad5e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DEg8ROUKpPRow+bB2ujK6F9n5yTHxqSLihWRBKrsZz4hwp5zZj8QDinciyws?=
 =?us-ascii?Q?bwFw42URy2VlY6tfqUgyEG3JrBfc72SRZGTYxQP6mPUGLlsVFd+OW4VBnaOv?=
 =?us-ascii?Q?xmxwk1gAN4suaY4GOGJBZD4WpPcwtOcZ/jBffzzMwP4UWNeu6ObJyMSX4er/?=
 =?us-ascii?Q?R+kk0luy2ZFem1lb5jwqB20oDqznDqYy9R1nH63EBoXXiK66lCYPQ/K1HITS?=
 =?us-ascii?Q?c6p0I7AsNPljhkKcDeCjbizzA2JYjIgW2HGztjVmLsaxSbjPGmP5dPd6hZmo?=
 =?us-ascii?Q?MEgmcEgFBbUKWH+f0Nb924RWsWzzlKBdnj3LN1njHyRMeGy2VaBafdbWrJnd?=
 =?us-ascii?Q?cgYX1k8gOsXTp+dp1py7VP2dIYylzBlB0qAIsIS6ZEzw1ZV3bLea2e4bR6M0?=
 =?us-ascii?Q?D2XN/Ybas5JKvKPfnqZM8eKZNhGtYGhMBd9boSIL94mTn1TiqvGf3ZfeNMYe?=
 =?us-ascii?Q?btIPfJPfWX+8vQr0nK+jP0FiG68cnj4iKJ1wYhOkJvmiSI4fX34G3q+uVS2u?=
 =?us-ascii?Q?CSmZ1mNT+URmh7+RR4dcHdBmvJZC85N+UU6v5xn6kuxURDkXMkY4/FU2V1jp?=
 =?us-ascii?Q?6O3Qr5F9i++2tbhY5SSO/FEcb0q/fLndwpVZASI8yJgJpRrWXQTm0etzVbJ4?=
 =?us-ascii?Q?y2FkpgaGSrfltlkEYIJVAZJ6n44TzY6+kireIConz4x3lqFwzhg6VogKRCqt?=
 =?us-ascii?Q?HKT5GCW+Qr/1OFLdPpv0q0QsnRWFnr1ba8sJq75zUC6YAgi3LEp8Q+SzcP8X?=
 =?us-ascii?Q?D4BnN/GMtoL5ia9One4YV+nET562t/+n8aOsQx6ybgQmIDMx3zQMYvyXJ2xZ?=
 =?us-ascii?Q?7Zqe1HYD6KzpW1zB4YOIy6bIsRDiOv93COrRQY9v9q1dFc+1zyOu1Mp5zlHj?=
 =?us-ascii?Q?kVSDAu0jgl+mWkvHsYeIex8j6OwDSoF0I54P/5Q+y7pjaY3NdexRfZfUfyhy?=
 =?us-ascii?Q?+vaeqJabVIwP/Oo4dLy6idm5EL/J0ezv+qEF7sC6Fgp/vgYbxDhv5bNvH6ty?=
 =?us-ascii?Q?YxBeW33G0KlQYzMM05IlXIOmgfzqFXH2ryXYgr32z26c9RMJRHeEQIua1A2a?=
 =?us-ascii?Q?c29IZk2+9Mj3lGKgrt9vX09mQKbTkq4kJD0xgvLlZLgZXYowN6+yrty2ZoF+?=
 =?us-ascii?Q?BDXo9IyaWfnS8GzjnRK/uquH4SsKbrCOzp+rFI2+G+jN9urzC/lUMqvubvoD?=
 =?us-ascii?Q?kz3AI5v7tLEQ16Go4NsGTpXxbIMclApvOl4Mb796BhFmTkWOkB++sLtFF+EK?=
 =?us-ascii?Q?6t0gZXoptlVDsbcDA0iTf4M8b8MMm7mHUrq3GGxKYXN5YeH0zSOHSJxh6ot+?=
 =?us-ascii?Q?j+YMT2tEcBB5x1ZLIux6sr2WzaR0j4Z8FClLzdHBJY/P0LSBJqqEGTonMgUh?=
 =?us-ascii?Q?RL74IgWtc7VGzNp4YA4x19u6fOJREnxS5/5syspOAV9N0S9435RpJauflcY4?=
 =?us-ascii?Q?zGfu5WYVBnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB3937.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPpEiubbSg8Jg4w3fou1lW66xgf6agst8aGyHP95TF3/srGgtdT3aiq7GXuU?=
 =?us-ascii?Q?uu5yeFQ0iFd8vr09TV5D3HC5ItDp/gycelnnORGg/AvQZUmRQCsb/sgQiVbu?=
 =?us-ascii?Q?LEVBxlBgc7fMzYRldcINncGjeSOyk3U9wsJEAS6RUD3gEzzQngDxFf9QdqgT?=
 =?us-ascii?Q?j7bYIeEclaw4T+Q3ggc04x/egSDhVc4rDfZ/BzShsZdeH9JhNl1ewMdZROwK?=
 =?us-ascii?Q?59P8OMGsLMpop7aQ00cGzZhthA86My2MfukNdPYcTp0BVTgeEJ3jxGXbRj5u?=
 =?us-ascii?Q?GUylSESbCGZYIoqM+cyVyeoWtXiDgI2ZNJznEVtbOMWNlnLQRONsn4C0vzCB?=
 =?us-ascii?Q?NsolCdlM3NQgurnkD0eI8/eb4lvigKM+ureaG9UcC+Tba0BRuax8V8KVK4xm?=
 =?us-ascii?Q?3vASjvcwdjCCz4eO7lG39CgmrQaiYEjZ6wbdYRfGoJSpixBJ6IZ+KoJkcI8J?=
 =?us-ascii?Q?H0UMwMpZWGLcZYcGVM2LWXeuKB8PLVuSQXPKgjcVdr2WGtEhSgK5XGqI+eJw?=
 =?us-ascii?Q?f98sB2Dc17LRpVyFnN2ZWJGv5gyNOOywjWjdTmKX35EKKiW6CkZpNAj4tLzP?=
 =?us-ascii?Q?+m7wXzAvks6PYE8T1gte7qYSg7TfNqoLZW/gV1DZdCCT7OBRoP6YQ7WDqgDp?=
 =?us-ascii?Q?gDjT6Y/LjDf4vHXwFpeVIdfFQue6oqXGF6pvvUSkAlz8hFbCpuvKJQ+DZ95p?=
 =?us-ascii?Q?JRy3lNOnAZckX4DDt09qmRpBuQHv2NlIUzAHKeyany8Dl/LJ0bZ4Z7GxaQFU?=
 =?us-ascii?Q?+FxYXhxeWu0qhbhP0ReJ7cjpXNB9VxBac3j8lpbaxDZMJ4eVUhWAQ2VbHFSN?=
 =?us-ascii?Q?J/YiPkxL/r5Y47yp9xoOLGipwUuNqtL0N/1y0mevcokoJSKgmncNyDvfadAh?=
 =?us-ascii?Q?2Wa8IKBR8ZVRtznr3TdxtAI9Ka3KVmVKv3tMtyABkWFDUcF4PcBCj50QQWJB?=
 =?us-ascii?Q?hNtLG5XTXuLTu3hwvTPBlskFsYjLCwvn0oCNQXJB7cXf29OAdd5QiKal3ImL?=
 =?us-ascii?Q?O38k1u9D+cy2g07qsimCWn634Z05fUUZ5US7GjkODquI1rXZAqOUHYBnGeXJ?=
 =?us-ascii?Q?8kfFe2d5ZC2dCHraE2rYlFapz5UxlW9sHtpFCEjwXXbV9oFNy/9+1LXTBJdr?=
 =?us-ascii?Q?kcc+bU/ZB+I9RdDvyG4zTEXAf6M12W9wkRshihFXJudPhrrQ1gqCAad1Rmn+?=
 =?us-ascii?Q?Y3RnCgzlnzNIVmZBKPCxjgYwBiBBRxzDTnrGdaSXwq51volwSk+7JnSDkSbQ?=
 =?us-ascii?Q?IaiLqmSf6cnp4l8BqIgFjabrDD+ycrn7+JdYKK+c/Lp1yqUc2yc7mqsQ3+5Q?=
 =?us-ascii?Q?ZDJJ2Dy/onGcCdZkbxyD4ej+V9X7T5+Oc1sPAqeVQ4D21dcN7rZdgt4h8fcE?=
 =?us-ascii?Q?WlguwvgwmzOgmTc7Sw4QX3zbqhKpx6X9bf9NdG2W8B7OLPLyeJRtwrgvQfmh?=
 =?us-ascii?Q?hIXfYouGzIcdMqx2WaAdE3u3YPtvCqV6xwDDZNflzkIGWFoc/skSe2GA9iQ2?=
 =?us-ascii?Q?igP4BoFHpipQjHn62UCBJCwJrISFAMsct6fH7dxaJVnPpfe81vUCwiHomuSo?=
 =?us-ascii?Q?z0/l10st2vCp3Z4qpo6dSTUbwa95s3ovg+6Jpndl?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb82ab-496c-4d24-1b8e-08dd9ad5e2ed
X-MS-Exchange-CrossTenant-AuthSource: BN7PR08MB3937.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 15:15:58.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5z07cZANe0LQLWCACGKLPrPEiv05pskEewP+PbWIgvLi5BDeH0QJ7l/qe5yGQYn4Z50RLYH46q1aR4cPGYwyQ==
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


