Return-Path: <stable+bounces-185800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F7BDE347
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC5A3AF052
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532729B8D8;
	Wed, 15 Oct 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pwJRPISO"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECA2E8DFA;
	Wed, 15 Oct 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526250; cv=fail; b=rvRcn75ZzfROq+FJIk4HUovekTCl6KTPUMiY/iAWoVUhgC/UDK9cS84PqAYN9nQHCT+GFO6JfC84WAX4DKEo+8iirzb+0InP29bphA0adOSnL1y6W3U82Bh5SSZV2TRc4pEGCY9sa8OGt1lPfii6tNUDm9qG/+m0vzRaLGuhUVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526250; c=relaxed/simple;
	bh=7GtbyP+PkGMoKflSWjQFGCJ8k1ln7K6BNMf0Mv79XZU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmBj2Ccb+o3WDbyLJZW9+jr9+N/SCJvaAiNkM0eSr+RbfrjS2DP3VYOohnNtDTqIzQMTorZ61Jme/+Iqfa1YehpoJ9+cqr8bl6zyWra53wUd+66SCW6xzj92N8k1a3AxzThKGo0L36gnbaSK/SutU1uLThINOKWMXqwsbGBPDUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pwJRPISO; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUAiT5bAGqfFkSDO81vRW0psmSjO37yRkIBidchHKItPrdR1usmDj1UhOZe/XNzI2jEcDiTA9ZrFfdlfevHeb3E59LZCEJg0HLt9q+dqoRYZIjYyLQGz+E51bgzppMD79LMqHuKFVPUQH4od0dmGdhkZzrfqgt67nzBtRX8qy6ys3Kjx/16nrMOZx0O0+TIw9A79mHfti2MThB+7CPMrq8QgwGALfgBKTGeVQgLTDNzdHwVP1PnjJmw8U6eEzS/8K157uLwVhPD+1BQDUn9GSsdNfilpw5dLq+dGyftGqZaMjbqJvbcx50tlEjtUbrwC2q9TnDST2221/tmwftb4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GlPPGYthWZo91SXdlZMLRXl8zakD4bKtf1B9AgT8mo=;
 b=xef48xO0QPdPM50Azku5yQFiXc3xLiRWrzqtK4HkZ7PM3RwRvhGO5+bhb8aBz9iWBEyyu1Qk/3vUZd9O+BJ5ASH1RoenLbRhmv1jMHEzMV1I44gFNjXao9g/fUUJzd7hvIMqP5AntzoMzWJCKz86nyKpfwWFEPiG4y7o/FDyZF66P73sgaOPxV69r4cs/i9dsI+2cUlZd8PD3Of1qetqb0ELayrsy1nEBxYZuk4FairNIByeklaSPebnNvlCr/EWDDvMYbjzzJ507YlDMtBTZLAbKhzZrKBs0AG163GLBuzN7MJPaSQGqtKFcykQHOdVspIB+RCdnl8zol1oivvGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GlPPGYthWZo91SXdlZMLRXl8zakD4bKtf1B9AgT8mo=;
 b=pwJRPISO1wKA86+dVFBHdAD2m4siQD1wdYywugZfek0+xUNr7kBBBYoVSBJ+tUD+itEOeMeZZ08fgAUMAuz5IK6vsH94gJ0ftV1GudObXkiocK2gi6AO/kFJt4qXUn+dvneQa7f92ectSfRlIAYBiugtWWO6i38/n7aph6kMB9O5zxprKApkF8KrLngjGg7qQlRPsB/gttja0fu2XhuI3wVNzoq3cF0nuWGSroTXLF1LGM7bYiKqu3Yz1Epw++AWipKPMxnFNjELgFH0Zoe2PFKTclXH3q3ix38FQ02u0Htc4ImJI9JKRF/VFhwv0HuYdkDqqH1LnssKNw/6Rii+iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB4916.namprd03.prod.outlook.com (2603:10b6:408:7a::18)
 by BY1PR03MB7309.namprd03.prod.outlook.com (2603:10b6:a03:52e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 11:04:02 +0000
Received: from BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc]) by BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 11:04:02 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	stable@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Ang Tien Sung <tiensung.ang@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: fix bug in saving controller data
Date: Wed, 15 Oct 2025 19:03:56 +0800
Message-Id: <a4c4906e48979514e0e365b7785988e79db640b9.1760521142.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760521142.git.khairul.anuar.romli@altera.com>
References: <cover.1760521142.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To BN8PR03MB4916.namprd03.prod.outlook.com
 (2603:10b6:408:7a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB4916:EE_|BY1PR03MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1d83f9-37d6-429c-e1c3-08de0bda8c79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciX3DpiuWf95ykxraZgE1ObteKV4BMZsHCYIdkHedkXpbQCbiG9+QWFHAMoO?=
 =?us-ascii?Q?ujc1CNlYLndhvFt7bi0tdfteyID2wdG13/RaB7eThyPJZbAU0T4bdU/Hc+pd?=
 =?us-ascii?Q?O0Jj6etLSd2Pmq4sL3f2+AL292AHKnktFfJugm56/QXLckNaLYP04pKWFgyg?=
 =?us-ascii?Q?eAYqqI5tjoqC2xPAWZpziMlv1/zu0mQs0yMuJbc4WVsqn2qN80y9lBkvNBPf?=
 =?us-ascii?Q?zpvfQJyMoqIV0+1gHgiqES53QYvGSUMhAdyFyeBeCQtlrcjFYRyuxYmuhLJo?=
 =?us-ascii?Q?GfoHz7XddeHCUGxiPPYjcw6RPhz/UnTYw3KOGBbu7nPNOH9wQV16FzuR8LkG?=
 =?us-ascii?Q?EP8kwdgdsgx1FjZHtK8QgJvXAQnKKQVv4/ZV5l/+FqNqDraudUYb4Uw/OltF?=
 =?us-ascii?Q?vVNXoqMb5cxW55u+zn2wHXrL8b8fxxWO6c1KeQPJtHtzXUYS74WaBoJowsAx?=
 =?us-ascii?Q?W0Q7N17nnSQTCCMk5oeyOIhN1hIQ4+55jkdTqgoH0z7xMyZu9600YJ9fBtUf?=
 =?us-ascii?Q?qNMogf5OlLADaHGSlH2PSYwMufX0r39o0ofApsA2IcRsDNYr5BpRe8qf41h2?=
 =?us-ascii?Q?YkmCD87kQVlEo5ThU2SyFydpu8TUZGZbh1KmSHO9sJ2Y0dlH3carMGZtd90L?=
 =?us-ascii?Q?ETzDG4cxVk4QTQ+2Zb+eHXUZTg9t6Hy+BFDCAjfKvLXTmu7lYqy4XsJ5OcQa?=
 =?us-ascii?Q?tqLkS8nljI9lhiX3o3sCcL63qBkVAEz56aEgP/9W8Vtqs8l75xAhHY9W6M/W?=
 =?us-ascii?Q?UAZxoCKHk8lf4Qs9tw/TGcKvNbWOzXtOAWjsY+smrX05cpzS5588NnbW+C1T?=
 =?us-ascii?Q?PWz8xuJvn1ZIjY3X1/MWt94Pvrkmnl+M3njkD/20ZQvgbf/vD9nE8rf2leQO?=
 =?us-ascii?Q?J1F2U+5Zg/ihngrL8+y8wHVcJwn0GVEN0e0Xa2gti/5WSJK39QmbuuLCV9nc?=
 =?us-ascii?Q?7NDSF+4y4TKG4o+oU+df1hCZzWi8F5N6AERf6ivxXDjInl/XwzYCvRFKKGu6?=
 =?us-ascii?Q?o/g73625eAWqEHHc+PD/EnAjYrYl8ZjGYkme9o/XOuiQ2pHv/ohkLJhXQriC?=
 =?us-ascii?Q?73QWfizXmdvXW8a2VUkIrGsds3P9nXkqXDVzJi7BV9kHt/KCDLM0Pxj85EDz?=
 =?us-ascii?Q?u3vpHQArERxweCG2aMuQSDW6MaSbS6TdJP45sF3X7xI7TwuAEK5odWRXd9wo?=
 =?us-ascii?Q?j/LMmVzew+yZ92kniTk5MzY68MPsIfVTkNuoUEKpRObfWlIml5PvoaXO93m4?=
 =?us-ascii?Q?h/eABRHOiYuv8HEHm43F0oWqws8Y6zXwx3ewLypyHIEU4zqdoaTr0iEuy/LY?=
 =?us-ascii?Q?EK1VBL/znmDiBHHNlxpmV/UXPevCM3eow1tmsMkC9e64vRiENVco1FNxGq3/?=
 =?us-ascii?Q?hX4g1DixKj+i7/Mm0QNdgs5pCzN352ncCjIU2HLDZq62ovgX94uN8GJNgtMh?=
 =?us-ascii?Q?GfAjWiBhdGtNkm6eUYB8fOTRrRrz4C1B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4916.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11Sx02HCWbtKmYWIPdMg10lInAhFHuVJtW3Wqez9rs9rt4zj/YXpig3lm5J3?=
 =?us-ascii?Q?utw3omRm9C2ZIR34vVTtOj0ZV0fL8Cnq3l0Qz3dzGGBpcfIJXQekTmQpUHfu?=
 =?us-ascii?Q?WmFAZlhQhEPiAQFufSATpsS41ZOKimm4m+y1LmNL4PH3CZlAHtj4VOdZ9Hlv?=
 =?us-ascii?Q?t6HN1ysc/axZLXpbBA9s8/g19jucwr7vCS1Nx04FuyXhJxZG6C1MMnLn28gM?=
 =?us-ascii?Q?VY876mBjcTqeIoBOyEKMS9SztbmCsuU2DOM0OXcWJHZCXXkbM9qbO4GtpMfc?=
 =?us-ascii?Q?Y/TAA6S4KC3Y1Ih5xTJk/jOd6Xdl0LStqBpC2Az6MP6qIQXlti08hmJ+wE7i?=
 =?us-ascii?Q?NoQUOXes36aJllUp27AXUtO4ED5JChw9LR7m7LLjmJ+1nF3voq6R0RR5FJEt?=
 =?us-ascii?Q?Gr9KVZ1RSU2etnY/R4RekqkjrZXzi/sWAYYpK20GvE1v2Woj8hgkVPZuEScO?=
 =?us-ascii?Q?hcagQAqMHmGeg2uUQ0JThqBfylB7bYAe5pwrq2hS7NMouW8yEuMizsJrHjAT?=
 =?us-ascii?Q?rQrI+xEMm9CRBeTALqke1yI5guz+AxE2L4sJEUONxfo8wKzK1cu22D+fazP+?=
 =?us-ascii?Q?2hLHJf18kWenpASYUel+8uPEGDLHOtx7uO/VRgz0jQpijU/BRw4j3irm3NFx?=
 =?us-ascii?Q?dA55LF3Mq41pymk90LcajeReg88E9Jdgj0wVUkHDhK6sa5ufayQKuE4+hqVa?=
 =?us-ascii?Q?1mmRjBYsA43gZW9k05TZJMdkd2xJcxsl0Ww3ygI/At/ZzFArUXlfJPBysIKh?=
 =?us-ascii?Q?hT38pUwA4+UtpZ8FeAKX+jHHddjHuSL//cwQKJjH++uQbQ4cR2TwAIcMEVYQ?=
 =?us-ascii?Q?lue8E1I3PY2qadYjB0nKUxOUfHJz+Lv7GbCDrtAlakZ+SsILmW2fuw7a/yAD?=
 =?us-ascii?Q?mtP2Q29jEvRLAARTZ6kJN2cOK+xX6GTefKdfLXshD8cIfIooIf2qMGwaPyqs?=
 =?us-ascii?Q?VyqEkznKte6i4QlU+QllLrSSuE/s+JHIzVU3OA9Mze/YE1t7mejQ1R/pyBf8?=
 =?us-ascii?Q?u6CCQ+Vk27I6ZyfUlPZzQsUU9cfz7SRe6NR+r9FcO2gFuB5qN//dWTi3X1ZR?=
 =?us-ascii?Q?I887V2nUC6CqTpuvYQLQC077ro+wA/x5U7zbNINlqLq4Ow5AIQkJWGL99ar/?=
 =?us-ascii?Q?pRIo35fgrV5M8VBtgGRoc3uNVewUrQp9U32jpsOfi26MsbZOwCiHFTA2MwbV?=
 =?us-ascii?Q?YY4v8cIVE7eq+8cgkthcs2HvYIXJwOq4ZeL4G/D55mx5Uhgjw18khOunWkPc?=
 =?us-ascii?Q?yc+9BocHo6r4fmO4diPVF3USmGpOjgtINhQBAJ9MwEDcwnV34XS4XKbkFz3j?=
 =?us-ascii?Q?HKxomilph0PJrVDey9kpjs/M7UqkCW7wPuT+WKui8i8wmKLD+Q22idpcFF7/?=
 =?us-ascii?Q?fdv/iSNx5BZlPDmsDr6N3/asB0UQjoc8kFUuYiO08Tif7OnTG36ebhAXOfYK?=
 =?us-ascii?Q?GZLrFXPuetByvInxIiBp13w1wW32YmThBk4nKrJrfLd+8lfhzWXuCFXLCZR/?=
 =?us-ascii?Q?E6mvYikbRPkUtSiwAb6kcqsfXLxtFBOeJQmSUvSesQ0yZmFyujJOFtBgvKD1?=
 =?us-ascii?Q?v6Twjn/iOnuYiIGL98gbCL2YOb39QlSWhh3cJ+oIxKmfQCmW4aDXGszr+vtH?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1d83f9-37d6-429c-e1c3-08de0bda8c79
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4916.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 11:04:02.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZZOKUeV5sqrQeVa+zGuASMCQKvug9I+tZ6ijRmkK8Hyzy0SrP0XZnBc7lu5MEp95HA+1GZ48kAQegmTb5RDNbKa8O8No1t76s8S1Q3R+YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7309

Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata. They
both are of the same data and overrides each other. This resulted in the
rmmod of the svc driver to fail and throw a kernel panic for kthread_stop
and fifo free.

Fixes: bf0e5bf68a20 ("firmware: stratix10-svc: extend svc to support new RSU features")
Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..00f58e27f6de 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -134,6 +134,7 @@ struct stratix10_svc_data {
  * @complete_status: state for completion
  * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -150,6 +151,7 @@ struct stratix10_svc_controller {
 	struct completion complete_status;
 	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1206,6 +1208,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1237,8 +1240,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_fcs_dev;
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -1256,8 +1257,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	of_platform_depopulate(ctrl->dev);
 
-- 
2.35.3


