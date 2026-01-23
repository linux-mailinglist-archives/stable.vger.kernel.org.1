Return-Path: <stable+bounces-211406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJH0OKuwc2nOxwAAu9opvQ
	(envelope-from <stable+bounces-211406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:32:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6F790C1
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A032303CA61
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2A235071;
	Fri, 23 Jan 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lr+iIcxg"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D913EBF00;
	Fri, 23 Jan 2026 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189525; cv=fail; b=RVY2sEOwUSulOQfjYdNGOSugqHcpvWILcnHzrSLHoRKi2U9+s2jN69V5uTm484Hl+qyzh3ImWu3aXZ2mts1D9L4yM832tSozH5wsYiLdpL77/tCb8Lsh1Li/BNLw4uROr+BN3Z45AfvUnp2BAtetQgGZIN6qkdA6WSTre9wakKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189525; c=relaxed/simple;
	bh=HZHqws/RbMR4E6+n+z1z2jI2EHrkiydp8HRIZQwNeNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rhqFkpXSZNijw5Xn282Yx4bU0KLUID2dETCEJ9UuCkrV4zL0qrh7eJN07jGnAYq/4wqTGdclWuYtN8+GQBT26HV414zpRqErzEREf5rmQ2/Y2wIlkqYEJvzrJVhLW4zdeJWMEbCoADx7u5LiulGZmQ9WX/nwvhjKQIcfnkTRa+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lr+iIcxg; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7up0t1bgDj+ms4VmuW8byx1Tbs4g2UUJQQBzvAZDrtD4qw6VBEAmo44Zlu8P+7RSKMcJkECqH0LXZwXfCiN0I2jXLOo3MPOyOSHH7Zq5yrowYdngynV+Ha9iUi6k5eYv+tUTxD4uNC3ZtkXAle081GjROOtFvPZaMMTK3V8O2mYyLcj2PFVLDkC9S7m5cu8nxjMlg9MN4aWCYKQ/OBmthyy8x0ZlBFWvpgnU3MrxhjMcbi0GDiyVlsd5XrZhxL62ESmaWClMb+UrvT5LOn/IbpZkADPGTZk5OdCXB5LFGqc/jzSmcbZEeZ2rjl8vUjJqqC7MdeHZNQhuwMzIeJMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H35GJQkbWnFOZwBlgucIiBWstBlZN9gMLFGnm9aApnI=;
 b=USFsnwBps9LAQmPeHpzgoznCAELBcvBubTySfJ5SrWXy/vuexWkX5ttbbZY0KzoFzUm6W25buQjJvWuRzcZ0NKU6K+CYWK62SC6zoT9+A88mZnoLk73CmCJWQFFwVZycsUBy0UBILOgU3/N5GvD4Zuc2nenSqHXoCoBHaFOpxYGGb+cEcrbFOaVlNPIqmcnneIm1dDa95eOSo975/aL0ItbU5dFoJMFLG1XQmuKSVxC7q9d2xMUhbSMFqdTIuJaLIF8O8XrbaXhS3u3tZnHCQXGT7U5UbZBvELCdiHR/wI/DvNq0TxLTylIYa87ne4tRQkdRrBC2fdKiKk0FS7rbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H35GJQkbWnFOZwBlgucIiBWstBlZN9gMLFGnm9aApnI=;
 b=lr+iIcxgbJKf/3hL/J7nkoT6sdcCSQR7eW/OyxT6GCc5xWt5txoeLuNjtkT3nH+46jLZxMHSVmqFNviVQfZUPOxOSZBxFKAOumuwNJu/lOg6Es+7R2xTCQB38d7sXR6zKiVGCt4nONvdV0/Po+/egWq84NMjWJsV8gf9A7l50bGdyUkVl6i4Dc1IMoPiZH2XhRU5oIWbegzlzZe3bymsYnHFc8CDqPaLWer6dKOzrMMwG12HY5j7+O1dNVDo7q8Bjrg0sYgQIIxSzDc5Sgwqlm6vhEMdJSwLS8nkCMy17lZaBqhg+6xSgSxc6ruGEhxbXnBQ1pmVRa3zpV5SmBGknw==
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:31:57 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::31) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:31:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:31:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 23 Jan 2026 09:31:25 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 23 Jan 2026 09:31:24 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <waynec@nvidia.com>, <haotienh@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH V4 1/1] usb: gadget: tegra-xudc: Add handling for BLCG_COREPLL_PWRDN
Date: Sat, 24 Jan 2026 01:31:21 +0800
Message-ID: <20260123173121.4093902-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6e8135-900e-4422-ac58-08de5aa54e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLk/ntkgce9PNLt861gL9+4q3XOIO226nXSk2Kld9DmUSBxTvgZAhntNtZVj?=
 =?us-ascii?Q?ZxwEewa9NSet7Gj/Lwe2YUvrrmDjCIe92dKYKGydMn9HvN8ofJiQwMY3mae6?=
 =?us-ascii?Q?SW4uDpgQns7S6Zr/5wgKZIfeVBc7a3Hs9ZTwwKUqmtSVDO7qbLqoWJ73/s9+?=
 =?us-ascii?Q?Iiq6pTNbvjtWVMb2QZXrPnVV67pghGkIjAT01i4sSh9OIEwfAuwBReAExsOZ?=
 =?us-ascii?Q?6zPyBzEoA2ReXODY5xWuLfEAVj94AwQZ6pm3aMTDDhuAIEF/Hnt5oRL86qBd?=
 =?us-ascii?Q?2YXHDT3JjF9xvksGSmcCaKRRQFCVYND2KvugE/aQ+7oLu/REDznzYCk6+wlk?=
 =?us-ascii?Q?469hkVAx6Z1c+pGpp/rXJUDELLYypI0J7CYwNvn1GkZU6qDbHDO9DoQ0xA68?=
 =?us-ascii?Q?EURZCoNnOiHtq/yfvSbH2FZagCyAlTj8vempkVIboobDrlsK/418Mia4mj9F?=
 =?us-ascii?Q?jFXlQqUpsDMR0lH3rIsUumkoF4JRz9KZEg0/nHHxuZLhkxj/hY7UlF3dbgY5?=
 =?us-ascii?Q?F/GwIm/RnpFD5yAF3gMADnJu16bnfce5n+tMX5yYF1UcsjqwOr6PKy3+j+iQ?=
 =?us-ascii?Q?PSowT4nR+2EsO69Xq+n5c5KjWHc/utk9JQIGmly/JbLcPvfO48JRGKoHFIr+?=
 =?us-ascii?Q?2L2wOqSn9d3iePoAQT1VROZr52bkiXfoHrUZZyVrfPoFl3ruVj3lxt/cpker?=
 =?us-ascii?Q?/bUha3QojsJakYgKIAQn6UbrhhYctRhCBEJfLn7VW/xpI4V2gqBg05SYbrTH?=
 =?us-ascii?Q?kTyaMeseoMcd8+0Ro4j4WnZBW9pO7Z8m49uUPN783s5JRfWEFqQ+JgeYzSQY?=
 =?us-ascii?Q?A+C45jy+rMDKDuneIYWsDo3tuJsROCbJJSIoUaP4/KDjJiyMiuTIx2NEXcpm?=
 =?us-ascii?Q?FKLb5HOvxuwQ/hjxFOk/SGyA2ek2NJc5webTtCA2WGH/9yus35ew1d439dh4?=
 =?us-ascii?Q?XBWqIMZpYHzGQBK1NhtjgMNABVsWYRvddFOeRXHBDrqzPnNkSFhk56X2ygrr?=
 =?us-ascii?Q?GztQd/xele/Wl3Hc0bKuPxlaM/uHHqEHH/PNcY+QP79flf5jT6ftO+DekU9K?=
 =?us-ascii?Q?2omjxnO2esEZdYDgONlni0tAV/b3rsIeWVyhHLJf347nI6vonC6x/uzS8FC0?=
 =?us-ascii?Q?/9swSfTttL8n2h31PyXK8U/fyiIcqfUovmCXNwgjNa7vTnHqXXlcE9ZVT5hF?=
 =?us-ascii?Q?BEHSq8QmXVxcKQ5x50BoOavoAAgN8PRpVyiLNwOvJSJfLHaAStO83qRRs9fh?=
 =?us-ascii?Q?1cKgDMKoqIc0z2Z+ZwCzSirYhgS++b7MB/m2UpHeA57L0lcCN6qw1mymzrGB?=
 =?us-ascii?Q?UGWIV7zrLA9QB9tDzlBCOaFd981hFtMLWT08SYNe4aPK0X+xn99pfwvBX8K7?=
 =?us-ascii?Q?oaFr0ZRgEaVF5U6c0pUpS9STr86v8jKjeDKObRxK0aPw723uBiZrmfqczKzj?=
 =?us-ascii?Q?CLAj3UMx80oGqhsUmMZTza0/DV5MMfemNl+Q6VbBDkinxt/ZH6sNI1YT4En/?=
 =?us-ascii?Q?xYYxOzmhksEtZUf0E586p8Kr6YCTfxknpA8by+RPdGiTRoa+jukAnYxCmTPo?=
 =?us-ascii?Q?sWumNeyHRavLOk++fPEpTPG7fc8rczsyNlEbqdf4VaC5GM1D9LUPdG2rMiSS?=
 =?us-ascii?Q?xQZVuZ41cSDgNPjs5+pi3YhusIB2xPqhyMImSFpQmKILr27eToSn5L/KOZNH?=
 =?us-ascii?Q?omUB3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:31:55.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e8135-900e-4422-ac58-08de5aa54e19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-211406-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waynec@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 53E6F790C1
X-Rspamd-Action: no action

From: Haotien Hsu <haotienh@nvidia.com>

The COREPLL_PWRDN bit in the BLCG register must be set when the XUSB
device controller is powergated and cleared when it is unpowergated.
If this bit is not explicitly controlled, the core PLL may remain in an
incorrect power state across suspend/resume or ELPG transitions.
Therefore, update the driver to explicitly control this bit during
powergate transitions.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable@vger.kernel.org
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 9d2007f448c0..7f7251c10e95 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3392,17 +3392,18 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 {
 	u32 val, imod;
 
+	val = xudc_readl(xudc, BLCG);
 	if (xudc->soc->has_ipfs) {
-		val = xudc_readl(xudc, BLCG);
 		val |= BLCG_ALL;
 		val &= ~(BLCG_DFPCI | BLCG_UFPCI | BLCG_FE |
 				BLCG_COREPLL_PWRDN);
 		val |= BLCG_IOPLL_0_PWRDN;
 		val |= BLCG_IOPLL_1_PWRDN;
 		val |= BLCG_IOPLL_2_PWRDN;
-
-		xudc_writel(xudc, val, BLCG);
+	} else {
+		val &= ~BLCG_COREPLL_PWRDN;
 	}
+	xudc_writel(xudc, val, BLCG);
 
 	if (xudc->soc->port_speed_quirk)
 		tegra_xudc_limit_port_speed(xudc);
@@ -3953,6 +3954,7 @@ static void tegra_xudc_remove(struct platform_device *pdev)
 static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 {
 	unsigned long flags;
+	u32 val;
 
 	dev_dbg(xudc->dev, "entering ELPG\n");
 
@@ -3965,6 +3967,10 @@ static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 
 	spin_unlock_irqrestore(&xudc->lock, flags);
 
+	val = xudc_readl(xudc, BLCG);
+	val |= BLCG_COREPLL_PWRDN;
+	xudc_writel(xudc, val, BLCG);
+
 	clk_bulk_disable_unprepare(xudc->soc->num_clks, xudc->clks);
 
 	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
-- 
2.25.1


