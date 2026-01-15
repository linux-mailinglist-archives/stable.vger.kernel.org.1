Return-Path: <stable+bounces-209962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E1D28DA3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04687308ED82
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20830F539;
	Thu, 15 Jan 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uVJBGDyG"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB532329C54;
	Thu, 15 Jan 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513622; cv=fail; b=gDTTP7Wj6QERwCqXWafAvelsD28YDaQVvx4QpVVLh6N33A8pCetS4Xvj02gKjpKUVWHat118qoUi2kqqrhGDWwxL/8gAIAPEc9LoR3pjwzZClreKggUek6Vbdr1oTLlu4xo4ZruJsHl9PNKs50tgdk4wQYAMApqnuwOc+HU6cLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513622; c=relaxed/simple;
	bh=A5wcQ5ygMbxHF/UsmxUk7S4v8A2iG9LZZjrjiHxE2lc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W9zqJ0vfWrV3mdRuV0BJ4E5nVp6xWioYtU4dWWizHhDZDmA4/1NeIrWh+rYTPaEPfowF9hRDy8bxDNGq59T61IrHfrufZYlZ2sQ+NB+yZrsa8Tu2kYo0YWOpVPAXsr+g725Js+vqETkzbOOZ0lyL+9cqdy6pjb6odNm06ditqaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uVJBGDyG; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYW1jf+6blD+dNioyfqgReb0TNU7G/zt4IfQRzEvlVIHGwqS1vSz2PDMsbfnjQoUSsUL83JeB5edvu9gzzcoiGjTSq/CYWtoLdEJtzPIi5OMBOn7lXKO/kT6ujM1wTdWJL6NPj2Eiinac2D1BCe8rx1HNvOSsPtYfwUGoKpbcLAY6Gxlb7H3GN3n8y5U9VPdKHaW0xUuB7XFzuk1ym8pSsJ4CWsyjwUlfWj6w8ZOik5USt5IX+AQmrIgS+dKhQrN66W8abYoB2brNE/XSPCO6MDaCYutaUQOX4uJNEtCd/tBX35121CQcxP0aBadyqBAUVukoUaD5yCHojf7PFVL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXUk5zkIpi8mGWPYep3T7lmX4wE9FYluQ/kX1YUWcZY=;
 b=t5rD6OIZWwWhGoXfijh3AhJKayJBR6AYrFYnRucQhT7Zrf8NjpX/XeXqfMo2rCacFTSOWGmXhyn70BVLVq3RvN6Ndg+yWkEBnKA2bfbt4oZE5g9TJFKxTeGx6mATmsLOBW+ZX/9p4cBq3hD63jKtf2/Q0X+o7ZVXW1Chbd3/lHWQKDC1mXLDs4+Xe88MuFAtOTKXdhm07semuXn+WGssnKxX1XNy/XSEYXGBwJiDWWTotPQGvF3mb3ElQtyUQxGsjgfpNwXJfHLWTLVzzd42trAthORQMPKg5L5P3wQtTlo72+VJFfdl7NiCPitQ4m9eIqe73877I1nMfKvkzVJZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXUk5zkIpi8mGWPYep3T7lmX4wE9FYluQ/kX1YUWcZY=;
 b=uVJBGDyGZuazD6y9Z82OE7Zaey4/PAKCCO1dUuyQPDuG+VL/TbW40Eqod2ObMvatFdKasqPHx/tHMCgT0Zdh8PotojqsutfssiHDBlL6fwRs9gcfcFsBxU4qWq0YyetQm49tY6LZDL6VL0USANfJ0+wxFkczG/gZEuo0cDVojLvkuCcZy/iBJ99+myGOue6S7hvBUVSYQt4+RKUuqk2Xzc+4XSBPfrUz7YaBe87gPjiIVm2ckCfSl3g1oVTGu+rIDtkb4S5/hDmbzGXD1RUbn+SjHdZsw1beFJ5A9VbjOOMvDYxOvukANMBysgESLPB/FlurKvcnEWaoFBQX2iNd8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:46:54 +0000
Received: from CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f]) by CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 21:46:53 +0000
From: Penghe Geng <pgeng@nvidia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Penghe Geng <pgeng@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and host claiming
Date: Thu, 15 Jan 2026 16:46:48 -0500
Message-ID: <20260115214648.168365-1-pgeng@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:52c::13) To CY3PR12MB9630.namprd12.prod.outlook.com
 (2603:10b6:930:101::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9630:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b5b8e5-6440-4996-27e2-08de547f98cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGafyqyH/qEjdope2nHtWklWeVtYtQJkd3IfDDhkCeudUvA+ANN64R9nEntp?=
 =?us-ascii?Q?IliUnxNjLU5Ny5TFyniQqBLoTyuPsRWIRhAxXo36o18Gi19p57Fpz4EaILcF?=
 =?us-ascii?Q?NE/fbq55dNW06XQb3hBqWjOao8j76b1qgwW6cVKX05zFh4bl7egnvB7xSEao?=
 =?us-ascii?Q?xFTLcC1u5zcD89bcdH2znsDv0nJdp4YxXbaRRZGMe6CE+6/SrnNKtTzpJ4a/?=
 =?us-ascii?Q?/OwzSE8mLINB2cPsOIP+p25YOyeJmdZ4zfgt3t3c+FqhrwiFmOulBoP1FFVP?=
 =?us-ascii?Q?eErD2gNaaRTmAddCLbXzkD4g8GH+byBikIwdkWGlC1ok1aAljZ+JnPUYMS+L?=
 =?us-ascii?Q?aE8T4g8r/DUpxUrq/Lb8Quflkt1GX+A+w1lRe/H4aizG62SekC/s1nBc7Ckg?=
 =?us-ascii?Q?QCZrMsxDDfZikXrIs8zZO8u9phzaIfoCrBPFSqFcvX4zDLPqd5xGVaVQjjAs?=
 =?us-ascii?Q?Xuj27TGxkUBVtzgX5rGZwZ1z99iPnWpapbUCaKTbR7aW86XJGfKyAhmnkyGn?=
 =?us-ascii?Q?VqvGu388qQoBNDZ7t8UwhbSZAKndw3PNiS54wSGkrVxcirYaUIWWC1H7riKR?=
 =?us-ascii?Q?c1Mtv7BaNEYhMHs3EbYpZ/06C6rWQf6ki5ULYtaFCFnyClJULrlY5/QutWg8?=
 =?us-ascii?Q?CjMg9vu+ucLYZV7HmImOIzB+zXoTCK8VZwLnRcrfxmCZDriq7fsceUTmFdt5?=
 =?us-ascii?Q?BjUSL2NRPjMxluRuD0Bt6rF7GhcCOaryuqG+enDut4TuLUQWy7zQSoePwxEt?=
 =?us-ascii?Q?lHyDQMhBRnDM+H/uHef7NyCZRFeOpS6OI+ixMcCetges/CgvZkobJ5DcNhbk?=
 =?us-ascii?Q?n4Ew1pq2agZLGlUIOCTe9bhBN8ddSGQPaUMdYE+RXpgn6xKGlY6VKvAPeaTa?=
 =?us-ascii?Q?NpC8zXt48ibtkSWx0l09P8fxgGKItN1a8o1GIs6dI8yi9JOQrsceFpqqhz/F?=
 =?us-ascii?Q?9V6i3kjF+3UF9L9sS7YPH7geBUZ8uMC/qLloYiGfMYCIaq00Loddr16m+2k+?=
 =?us-ascii?Q?3tBguJlyEJ6XMmbK6rI0gI6dajyuk98/6orEfpP/OEuyk542d2Q3KbVQvzdN?=
 =?us-ascii?Q?upnaSbHWs8i4tnYYPGNzWtjX7/H/XZtnU8g+L0wjnA3ypKUhCNHoCLfPIx3J?=
 =?us-ascii?Q?n+gmf5G58AHcrkFEXYNPMGoTrrMpHC+lCLWoERWrKq7DsOMhkVp4SAqBPS47?=
 =?us-ascii?Q?BL9ZYEvTpOf7w0YXIh9bA8Rzb6bCpVkUDn7rYCMd0/QMB/x/PRTPNzwrIl5V?=
 =?us-ascii?Q?6DMVaXBHkmtFlRPGoxvO0ciVMBqAmqfIpXijs/qiiOo0SuPIfyh9S8W6801Z?=
 =?us-ascii?Q?84jOcFw1ptVEVZPGxpcovOsSy7GT+s+c/8SpgbF4nSHFIgAIg+CmJoB3TBEv?=
 =?us-ascii?Q?nlMcA5nivpTrTYZm8vGpZHVsxJSaeCp9iKhcp3BKTsBYNlMOqMxAj1X4KpFm?=
 =?us-ascii?Q?5uKEZH6L8HF0NXhDrYNrce+Xavb7U+uvq23eTkmzeaZ5tJYD+X6I/2L6E0iC?=
 =?us-ascii?Q?gaiiPlMuBZmvADViqC0BXZB1imTzdf+Fb01qGdDJR2I/N0ULBNRsr7s4ePeR?=
 =?us-ascii?Q?JA7lsLRQDdFh2efwOzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTiXtsTri3oXKWJsX2NubWFb2iPEOPvoqde+oFVJV9Fjr96/1lwQobcSD1w2?=
 =?us-ascii?Q?bvxn64/33M6mDzch+jRzr/oPMESzTymiJewElNdiwH4vuu1i6Dm6KRXQ+0jy?=
 =?us-ascii?Q?Rym/rw/aXiWd5Z4tCv0wvYwWYSMZXaLnGJJ/K2U8ZxL2sxdZO7PZ21jKhc7G?=
 =?us-ascii?Q?UCjL1xuQFrFprCtbHhksp/kyzg7cDt1GRRND/S4FSxmOeoVL8ycJKKRjUyPS?=
 =?us-ascii?Q?GFDRI8ERtI6RI3nT0j4L9CwOsoXqG3NJ6jpu19haos4iL5BFtHV7uZ5TH/+g?=
 =?us-ascii?Q?aeMxtFldjZ/snZZzqhmM4o+aOZV6EbIzuVVtuyyXQUO0yA7Ye8T3zrqkVBPF?=
 =?us-ascii?Q?IhxOWZHbTGnzuYo+7YOCClGL3NjPulsEVRdbt1YOrRUkW3XwrRis0A737aj2?=
 =?us-ascii?Q?gnoGmb2v9OwsZGwVmcidmwA8rA6i/hAGUU5Zvs+BmIXosYjfZ90EUYp12Hup?=
 =?us-ascii?Q?Jz2fiJTBQLHPiLa1CQgaFaznjXwM3dcWcrm5+6vyqa9yQMCbE4X68Rul2OKV?=
 =?us-ascii?Q?simvJxTM6LL0PS9Ip6EBryITqNN/KcFEB0gq95JpbXU/59VOqqaofS2NpY61?=
 =?us-ascii?Q?7ft6OwnnEc4ZPDe20vCWLZy47PrwWfRJq3TAY0ohHL/Zg+OFPJVbhtc5RMQr?=
 =?us-ascii?Q?GEUx+BYcR2Off/g89OA6yx/wjTaClwh+TberEMEsQsIzXzLpUfsXZZ/ff+zC?=
 =?us-ascii?Q?VzU6vLGvDRAixABJE8bI8aydu+GTbN2SedQvQ6ucnzFjMy7hYbQjwTiPHEdB?=
 =?us-ascii?Q?aX0CavFCHdK774lq5TEf+LSZmRtLEfb0QPZuFigmdXS4QPhI0U9gyvDKE4Cc?=
 =?us-ascii?Q?C4rXZ4q6J2cAXAKep4p9acQ2A4vd6k0Rtph2Lfrgv1R0eXCgIXxl0xAAEOWa?=
 =?us-ascii?Q?/a498gsUAgVbSMROKQR1YG//lWKLZbqIztUYhjIyCO4FvRKHlB4FacFk2Etv?=
 =?us-ascii?Q?hPZ3YtcoU1awmWSzje6mwUMphlgZH3nfcarpp+NP0/909MNSQJ7tkU/4s5m5?=
 =?us-ascii?Q?ezsh3KUxwJzBqHcXu76i3N3PlZL82lmjhNpbyfU9n7hTcN8vErsCdIvyFna2?=
 =?us-ascii?Q?6542gJcook+HpTtXFi/qy3bO5aXRqF+HClYxL+7SGmqLZ609W1wbviBK0EGq?=
 =?us-ascii?Q?OXgqrPPrHQMTkDHDzKO3Udts43OmCHrs1IdHmcKyqe2QkyIXmhIeLGlZb9+Z?=
 =?us-ascii?Q?BMpCDCbrXEbstHqPHyx10jSHXi+V5pucAv0g+VoOEJkbDLiMr/Antyxja0ps?=
 =?us-ascii?Q?91q0vPrXfQTxw8ENAGuE7iZUQ4Dobmnf8ugb6ik7SWIKGAN/9tTVKmwS23xE?=
 =?us-ascii?Q?9fA+U2HmagQsZeqdtsHLYoU09aN13YdFBNrnP18wumHJ9cB4PGOM2k7ABFO/?=
 =?us-ascii?Q?qlIwwgq0tXwBicWFBpQSNo1CQzwVvMVEOuHDow653+eoTP8/gqaAxz7MjHft?=
 =?us-ascii?Q?tfaHOFZB+BkSgdZUzR6dE6Xh2H4jJ8U+zzdN2DHo/QwWDHXmpeSQwoQ6CiJo?=
 =?us-ascii?Q?yhtKUpMXr5WFlQqN64i1QNo3tEkOEA1a8huE46ctyAtI317p0KW6N7000Sj2?=
 =?us-ascii?Q?nwD2maI4KPH46WqIxkqpHK6xvayQCVKuf8t4sJDym0UKmqf2JrDdOrpLAifQ?=
 =?us-ascii?Q?007+2hgm5PW1UNw62rW8O8ndI/ydFUuLCgKR6YMrBgRKxi9mkgUnykbCUEov?=
 =?us-ascii?Q?on/mZAJx/wCal0faz0EURLUH0N/P0pfBlVYBfzBFRDGcd8htXFwIqcuW6uzE?=
 =?us-ascii?Q?pAC79n36ug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b5b8e5-6440-4996-27e2-08de547f98cb
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:46:53.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UkUWKnuWxcwhSjpumJBw5imu6mqoEgrmA/qu+dy2ytS8YYn5t+TvM+Om+CS+d37I9nwNM8fsXLLz4f11FpX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484

The host->claimed flag shares a bitfield storage word with several
retune flags (retune_now, retune_paused, can_retune, doing_retune,
doing_init_tune). Updating those flags without host->lock can RMW the
shared word and clear claimed, triggering spurious
WARN_ON(!host->claimed).

Serialize all retune bitfield updates with host->lock. Provide lockless
__mmc_retune_* helpers so callers that already hold host->lock can
avoid deadlocks while public wrappers serialize updates. Also protect
doing_init_tune and the CQE retune_now assignment with host->lock.

Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Penghe Geng <pgeng@nvidia.com>
---
 drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
 drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
 drivers/mmc/core/mmc.c   |  6 ++++
 drivers/mmc/core/queue.c |  3 ++
 include/linux/mmc/host.h |  4 +++
 5 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95dbfd9cf..0b6b4a31f629 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
  */
 void mmc_retune_enable(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 	host->can_retune = 1;
+	spin_unlock_irqrestore(&host->lock, flags);
 	if (host->retune_period)
 		mod_timer(&host->retune_timer,
 			  jiffies + host->retune_period * HZ);
@@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_hold(host);
+		__mmc_retune_hold(host);
 	}
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 EXPORT_SYMBOL(mmc_retune_pause);
 
 void mmc_retune_unpause(struct mmc_host *host)
 {
+	unsigned long flags;
+	bool released;
+
+	spin_lock_irqsave(&host->lock, flags);
 	if (host->retune_paused) {
 		host->retune_paused = 0;
-		mmc_retune_release(host);
+		released = __mmc_retune_release(host);
+		spin_unlock_irqrestore(&host->lock, flags);
+		if (!released)
+			WARN_ON(1);
+	} else {
+		spin_unlock_irqrestore(&host->lock, flags);
 	}
 }
 EXPORT_SYMBOL(mmc_retune_unpause);
@@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
  */
 void mmc_retune_disable(struct mmc_host *host)
 {
+	unsigned long flags;
+
 	mmc_retune_unpause(host);
+	spin_lock_irqsave(&host->lock, flags);
 	host->can_retune = 0;
+	spin_unlock_irqrestore(&host->lock, flags);
 	timer_delete_sync(&host->retune_timer);
 	mmc_retune_clear(host);
 }
@@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
 
 void mmc_retune_hold(struct mmc_host *host)
 {
-	if (!host->hold_retune)
-		host->retune_now = 1;
-	host->hold_retune += 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	__mmc_retune_hold(host);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 void mmc_retune_release(struct mmc_host *host)
 {
-	if (host->hold_retune)
-		host->hold_retune -= 1;
-	else
+	unsigned long flags;
+	bool released;
+
+	spin_lock_irqsave(&host->lock, flags);
+	released = __mmc_retune_release(host);
+	spin_unlock_irqrestore(&host->lock, flags);
+	if (!released)
 		WARN_ON(1);
 }
 EXPORT_SYMBOL(mmc_retune_release);
@@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
 {
 	bool return_to_hs400 = false;
 	int err;
+	unsigned long flags;
 
-	if (host->retune_now)
-		host->retune_now = 0;
-	else
+	spin_lock_irqsave(&host->lock, flags);
+	if (!host->retune_now) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		return 0;
+	}
+	host->retune_now = 0;
 
-	if (!host->need_retune || host->doing_retune || !host->card)
+	if (!host->need_retune || host->doing_retune || !host->card) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		return 0;
+	}
 
 	host->need_retune = 0;
-
 	host->doing_retune = 1;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (host->ios.timing == MMC_TIMING_MMC_HS400) {
 		err = mmc_hs400_to_hs200(host->card);
@@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
 	if (return_to_hs400)
 		err = mmc_hs200_to_hs400(host->card);
 out:
+	spin_lock_irqsave(&host->lock, flags);
 	host->doing_retune = 0;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	return err;
 }
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 5941d68ff989..07e4f427fe15 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
-static inline void mmc_retune_clear(struct mmc_host *host)
+static inline void __mmc_retune_clear(struct mmc_host *host)
 {
 	host->retune_now = 0;
 	host->need_retune = 0;
 }
 
+static inline void mmc_retune_clear(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	__mmc_retune_clear(host);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static inline void __mmc_retune_hold(struct mmc_host *host)
+{
+	if (!host->hold_retune)
+		host->retune_now = 1;
+	host->hold_retune += 1;
+}
+
+static inline bool __mmc_retune_release(struct mmc_host *host)
+{
+	if (host->hold_retune) {
+		host->hold_retune -= 1;
+		return true;
+	}
+	return false;
+}
+
 static inline void mmc_retune_hold_now(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 	host->retune_now = 0;
 	host->hold_retune += 1;
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static inline void mmc_retune_recheck(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 	if (host->hold_retune <= 1)
 		host->retune_now = 1;
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static inline int mmc_host_can_cmd23(struct mmc_host *host)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7c86efb1044a..114febd15f08 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		goto free_card;
 
 	if (mmc_card_hs200(card)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&host->lock, flags);
 		host->doing_init_tune = 1;
+		spin_unlock_irqrestore(&host->lock, flags);
 
 		err = mmc_hs200_tuning(card);
 		if (!err)
 			err = mmc_select_hs400(card);
 
+		spin_lock_irqsave(&host->lock, flags);
 		host->doing_init_tune = 0;
+		spin_unlock_irqrestore(&host->lock, flags);
 
 		if (err)
 			goto free_card;
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 284856c8f655..5e38759c87f5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	enum mmc_issue_type issue_type;
 	enum mmc_issued issued;
 	bool get_card, cqe_retune_ok;
+	unsigned long flags;
 	blk_status_t ret;
 
 	if (mmc_card_removed(mq->card)) {
@@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		mmc_get_card(card, &mq->ctx);
 
 	if (host->cqe_enabled) {
+		spin_lock_irqsave(&host->lock, flags);
 		host->retune_now = host->need_retune && cqe_retune_ok &&
 				   !host->hold_retune;
+		spin_unlock_irqrestore(&host->lock, flags);
 	}
 
 	blk_mq_start_request(req);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index e0e2c265e5d1..e7bddbafd1da 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 	if (host->can_retune)
 		host->need_retune = 1;
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static inline bool mmc_can_retune(struct mmc_host *host)
-- 
2.43.0


