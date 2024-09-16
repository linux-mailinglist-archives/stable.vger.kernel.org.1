Return-Path: <stable+bounces-76496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73997A347
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901C51C21286
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A4156F3B;
	Mon, 16 Sep 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="AJPbBM8R"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2138.outbound.protection.outlook.com [40.107.22.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4391155A59
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495000; cv=fail; b=KvIwL6w/kDLoACxg41dW8ZTvtcpo1exGibwRadeN+Ns/b0PTg8etd3nDWr9cQpJHudGmn7PNhDiFVTB17pt7KlFyu1RkKbPEsJ1k4BP3JNWVovvQF8eyEsaOVJnmA8FE6bxlLVOY+RDVcG5LfzBGVtNMXUoi3aPcPwgo4buTptw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495000; c=relaxed/simple;
	bh=nxbXn3EAIvu8I1bsz/JdMwuseSJ0nDwWdtlzQj9YwP0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RDtBxfMr0qu5C21SJviH20LgK1cmouvF14eZGsbm7C1VkyoukoPnI6Uhly5aITsAgNwKxKw0OiqvWZEPUzhRKUP7Kc6vVmq2x71lZcL6aIwMtYfdZP3gu0IdsQAtdXaBRNNZblFxZ+AZDb84shjByDjPRqAXr3+DKtsM4RSLF1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=AJPbBM8R; arc=fail smtp.client-ip=40.107.22.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yce/o2oQRlbAR2MHJcm1ValG4G+E9ifqtKkvmFptD9hWLhiKZRaynjGUNhKdnVqsZ9rU2iQxbfoleGtbTYxxvaSKOdpO3P9eg6qnfHKKrahSaf4p0DPJQURSDiaWBI2mjkPwBzFVF30ffX55NRxOXXw+yPRX378I0s8F7H4ZaUH8Lp2hmHH6y7ebOQkCCk7vGbiVgpHmvVx5xgqqUn7AnnNSLztlOQSsGpQiayHcyWd3JgYno6OtqWHEBCbQDRvCSACvJ1NMl7w1rR6CSs7Fwn/ssIzgdoDWFh81+NHAUmLeXuFHV2VkwfVCTj9GAmNtVkEmd3IsFPjoQZn1ZFdyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjskuQoCbbgI2QPmjiTwD7bDoUKYIhEYUEWLMkxITwE=;
 b=gyoW8G7HDsvD46Msa5s5mWtlh1K8XFz2Wx5ShcKH0kRAfyqBBBKmVQNI0HTLKmv9f6PcB7lhCy6fzaF9Ro7vOXivfBBOc9u+YukaYJi9BRVQZm3SQZo7MIDHe13AaflDfXbpy9i+XA87uzkmMe9JmBxQ7ajbCc3mWa31GC5tzwWEC3NUtFPHhJRA+fldGfwz9UZ2JucCV6ZhBd3xVz6879f3/idyRtXeZUKktSeHiIk1sNEKxVpjOn/tU6v3Odbytj0qANAjjNGhO0K2u7x/tJYm4UzvDDcWZFHzZlIIDBNU8ZkHGOyMnZ3q9wvkDJLy+snIu/YcxOxt3Wkr7BdNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjskuQoCbbgI2QPmjiTwD7bDoUKYIhEYUEWLMkxITwE=;
 b=AJPbBM8R6lmudlOmgpdVzEr/24cq0XkNLEYIQ0GkDBNmEggg0BCm1N8OD+felJ2flOw6+wQ5DaF0wjMcuMAejf4xfJPWNiEmKmn9Dg9WSeMe31jmZpQqARZft2URoPGsV/lmnMmlTn4rI6fp1mSwRYjPcHJgm8jzADjDjqdffHI3bmxKPTYS8hVM4+GU0WXf2r8HytS6VE9FZ8QNKkZRsiXufg9qpl3UM3AYr+LXEborL+PcMeKkRw8OajSsyIOfTFMFoP/XzkM2X4YjJnTlRZlQ/SpJdmTFql+RDLpQylNpdHClmj24TFY0rofLAcmjye84IjWt5Uj2viEfTxfWNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DU0P192MB1748.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 13:56:33 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 13:56:33 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.4-v4.19] gpio: prevent potential speculation leaks in gpio_device_get_desc()
Date: Mon, 16 Sep 2024 15:56:12 +0200
Message-ID: <20240916135613.629127-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::16) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DU0P192MB1748:EE_
X-MS-Office365-Filtering-Correlation-Id: 823bc920-7282-440c-2d32-08dcd6575f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tad1X/27w8F5OKv7DL8ziktyoySUyeen0svdQ0xv+8w9FrAorrsM3ko/SDr+?=
 =?us-ascii?Q?vjOX8u4AicEVTeQLdj559DFn9MrEqTPBhDbYXhu3dJ8wRn1WF54duqeDmG4v?=
 =?us-ascii?Q?PyQXp1eHezPUyG2qg9erOXGUTQjom2/tjg3sGqb93WeRMSbOmZ7BS68xupp4?=
 =?us-ascii?Q?1YyPTfAheRtrXvKseJNXR5t+c0YxAy/J5p3/8LR+IfdCqEvnINSeCCZeEZVr?=
 =?us-ascii?Q?16YBkioOrNJrhwvZ9MR7qvITva8pVq//q2qREeVxw8MOlgunHSYVYOYrpytn?=
 =?us-ascii?Q?vOCrMrVhDaHXgCQHhvKjjCBfrzPnSgPJ8hYRnHcHAe+BBueUeoaGkLi6TUmz?=
 =?us-ascii?Q?wpXtxzcuL9mez9HWjUxHkRn5ml9ajHOrza8+bSAqQ8oUHDFtTt0vZmQpoD6m?=
 =?us-ascii?Q?qL9nM9akdMdi9z7+lxFmAYJlo8rEl/U/BzDa6MswZBF9PlwAWXIdhwrAWv1T?=
 =?us-ascii?Q?SoQly3m4D11dwwuLteAh39buuoNaOrjTa5kWvPtn6A5T9fhdz11LVWTcbYQd?=
 =?us-ascii?Q?c6tCeYuYYm+xUGnuFeYW3QdSj6pxeUFB6yzGcwGzntUOXwtuNyweT1Yq9BJv?=
 =?us-ascii?Q?3Rh0YDz1DbP+XImnprNOyr7rqVkALFv+zA4CU5DigK7gjjpoFdExelbfEA55?=
 =?us-ascii?Q?FImuxl9BlTmmauLpzo6Mvz7IswLIx5WTCcnAbGOPamWUsVs/eaVVxOyoJdTP?=
 =?us-ascii?Q?aK7mbk6ytkZwYCD2PmNJ6+4NFQAbIzg4mOpfuIcc88eUhoxplS60Fb8cM1Oc?=
 =?us-ascii?Q?p5H1gexaFMWgDyYX7V+UxMkS7EHmXuG5CrBrtQi1Izl8kxxgb7Im0Y+Z0D44?=
 =?us-ascii?Q?iqgJ9HYsvk+0c4xd2AoIE6cJ7VPoDAKwrhGV8gDVtvkOp4lCB15LqTzt0rR6?=
 =?us-ascii?Q?y/hMGLNf4RIisuRgVoKICWNKPvPRVOE5wChgWSij0kI69Dx4AcNRFld33f7w?=
 =?us-ascii?Q?X94Dy0ICGfjMvm9NTpnVC31bkKVnb+0ppMrJ3aEDi0bCzL64hCgZCpIXX5sc?=
 =?us-ascii?Q?C+buMzXnUtx/swrJMsoh6/GJM2zS9ENgfxZB4hvCSSbmjULOIFkHkqt/EZMQ?=
 =?us-ascii?Q?Gwy4vdHDEO3j8ifgYd7XXGpJQ861CyOJjlE64dVGO+n0nR6AITpAtoKx06zc?=
 =?us-ascii?Q?OPak2RM2xdgDWxaJmKq/fNiL60Wg+Erj8F4ktv3EypP1477xhDSidXJJUcyS?=
 =?us-ascii?Q?BziMFB4A/8Pqb4+sGopEPiNhWjD950nfQJTNM8BaZ1RgFpu/V3BJ6rucswr/?=
 =?us-ascii?Q?tvsamlk4vr1s7jp8c9YLL+mriIzJT3lHSePKkTwyIuRswsG1aP0LSom+XoDF?=
 =?us-ascii?Q?kXd1BnCaIBQCSb+MG6RJOFS+zviJzo4slscAWHvXPCB+SA2PbK4tMheuy6Zs?=
 =?us-ascii?Q?FsCA9y9znD8VMEGkewLY19BEsjFChtBlTKUgZ/0/2v0Qf3z4Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LgjOzq6YJ7Mj5qrwyJc81EvQ0P/mpfAQTuCyf3H/Xx/FugP4bbsV2BnbumS/?=
 =?us-ascii?Q?jMxAhEATdxdGcXJ+yn0CaDudEk6xSIHCYx7yt+iyRioRthNvyQEPBybQBuPO?=
 =?us-ascii?Q?dEpP/o0ATjcDkjthWT2yS5ul+l8sZnj2lB7/JVaCmjv69I4xcozEZ9iWqqIJ?=
 =?us-ascii?Q?XNAyEkQ4rUwlVuq9XKH8lS3n0OaA0syC3a3QhDOfHcnp6/eLdy2c9EYxYFfI?=
 =?us-ascii?Q?9Lg60BwWRXLZjnPa53DsVqQBTGhU+SRfHm4hlT1QXwaZVrgQJUu1HgxSkuR6?=
 =?us-ascii?Q?93siN2Bbewr/8auEVFrHl7xPV58ZnZWnleOiEYzhvh4339kwscT9Fg4dsEss?=
 =?us-ascii?Q?OVj+MClPFpBWd5gO6lvlzvxxAhjytnU0avXO3GyHVZ+bb3/+hyZ0tsFpIeiz?=
 =?us-ascii?Q?nTmLgN2loxu3lmb5IXp8fiwBSOEh3aGyCvcLpRqxUIMQ7zZjA3+A0Gd9pobG?=
 =?us-ascii?Q?qrCjUh1mx9oS/erIcTBLMTQVF7lq3oOhpqQW4Qu23rFS+vsokGXCXKkD/B6X?=
 =?us-ascii?Q?SDw534bZ4Mxws73akSxWK7LgEAcX9RDJ9aRy7O3ybLNgv9n0OpQ4anOJvUHr?=
 =?us-ascii?Q?biXSur+OuF7JLUL8xD0tkke+9zeExjIx/8GohS9xuFpo3AO4Ln34E0lRajlm?=
 =?us-ascii?Q?GZAgaqtNdgwHA55067ZJDrX/P1HM4lSVB4tvDNbRMy7iKQOIBl93KOdRsbg0?=
 =?us-ascii?Q?C8zY8+b9YKB73fTDLXQ7ct3X/fNz5TS0D7K5mzKgJ7YvfBLjwrqE15LtlSzV?=
 =?us-ascii?Q?APfLEe1XioY1HfYKf/i7BDFIcT4bwFxKdB5nyUSHVbR853aKXuCB3D+msxUs?=
 =?us-ascii?Q?20UbUCl/ZsLoisGeZhOAKLlIHVrXGSieuAI+Y4tvNZp2BRJqZWVtbLNY85gO?=
 =?us-ascii?Q?IynjHyT0/s/gZFM62AJfUe7PXHxitDQ2eGUKgXamJxNPK02FPAU20AexBzC8?=
 =?us-ascii?Q?yiCn0nRDwrevIIpWip8mngq3SY11JsbRWPCHxsGmJvW49r3Zo3+zNJ+ii9Z0?=
 =?us-ascii?Q?SCVda3UWU8fsSNE0fBGxs1KcQXNHz2fLeMhNI9NOCqFB35PxWwBdZ9CWb4WC?=
 =?us-ascii?Q?zRbNutEIj+rtdaI75FkVyJy3bxwKMuxHe86JM/sB1tXxvgtRclTXDcp8OGtQ?=
 =?us-ascii?Q?ErxJ35aynWkB2o6ZqF0jkpmDRAMEXIJfsWfB+MYafh0FK7kjqH5Gt1o93cni?=
 =?us-ascii?Q?/7qyMSYJTewfEP0zw6+LvPB5+Kse/4BnUY79Enb52oYa+gjNDVNv7xXvArJZ?=
 =?us-ascii?Q?HD5bJZmYYpfNU5XMZXWjS0W5BlcZFdD4Up4+JCUg6nbGTPmbbyjLk6vDLGVy?=
 =?us-ascii?Q?if2Qws7yB4V1gX82T4DS+wTO3JgOiwt+RMUjkDW9e78pDIO+hVTNxawbCf4C?=
 =?us-ascii?Q?q+Ef3MdgdPRILYRXvqHpEQO6LF9HP2V2Wg0wseqYgpDDAl+7/3Iyl0ypKwcz?=
 =?us-ascii?Q?YtDtRuvL5FiygxIsUs6PDhGJiLFHlifDzckIfiG7pXfMaYuh/HBWwBTOGAuX?=
 =?us-ascii?Q?SXWKf9G741IOcaKHDfQkeIfMP9XekCotNfyAJRWM5OZ/7tzuyKpmRHq6yT/Y?=
 =?us-ascii?Q?hX4MMjMkiOs0fQ+tOcgtLVpzSSiXuK3o6ECMPsFM08YXMhTJrDSVJcgO0qXP?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823bc920-7282-440c-2d32-08dcd6575f8f
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 13:56:33.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5g9Vw8XhZwccQLhBBHMsoMlBLHRBlb4iHhGxEvWpRL3ynQhZbPRfd4FTYy5r3Vdmynvu+B2NVnPnbW8pMFlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1748

From: Hagar Hemdan <hagarhem@amazon.com>

commit d795848ecce24a75dfd46481aee066ae6fe39775 upstream.

Userspace may trigger a speculative read of an address outside the gpio
descriptor array.
Users can do that by calling gpio_ioctl() with an offset out of range.
Offset is copied from user and then used as an array index to get
the gpio descriptor without sanitization in gpio_device_get_desc().

This change ensures that the offset is sanitized by using
array_index_nospec() to mitigate any possibility of speculative
information leaks.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Link: https://lore.kernel.org/r/20240523085332.1801-1-hagarhem@amazon.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abdf448b11a3..f83b2214d704 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nospec.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/device.h>
@@ -147,7 +148,7 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
-	return &gdev->descs[hwnum];
+	return &gdev->descs[array_index_nospec(hwnum, gdev->ngpio)];
 }
 
 /**
-- 
2.43.0


