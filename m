Return-Path: <stable+bounces-200849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16134CB7BF9
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 04:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E7C4302B305
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54A2F8BCA;
	Fri, 12 Dec 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lICu5pvv"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C22D193C;
	Fri, 12 Dec 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509762; cv=fail; b=JrPP5Hltu8Xxe28TR58EKkKo1lyTW67jLL2I5C4ZHOxl3FtnTdPSlEVfaLvZ2cKOfVggHDM5LEj9DoAwmVS62Pp8c4g8zqgH0Gciwt1eHn+K2hgczCySQm2Kt8GWbwP7gvesCQyVQWAWD53h41uFKkNAdC/uR9/XM8wgTmCSl3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509762; c=relaxed/simple;
	bh=2r5jC+UXVuRE1nNI3nQ/YqB694sy67lJqmkfclYNPcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dp/mgrChrNP6GV0W8X1kc3y5muW4a7ut3YeLM7876eDNRE/5vyLXJHlfCD46/Vd0fi/CP9BZHdZdM7GK79by9kL+q5QRscOmNXws4LGr8q/ellB6uZmnTHG6gqk/ttKY/VyLbx9qDQqKb1arH24RVX6j1MPqvNcn3Xhuh7090z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lICu5pvv; arc=fail smtp.client-ip=52.101.61.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnWkJpbnVhW757Oa++GzreJ0/EfTBqZrSTzPsBYiJG6khJuJ/rsQZyqtB611vrdzlHA2rykbLMYL7W3kG9QNmqcrIv1brnomO9zA6zb1511j2ASnFenR03qjThHfY2xYcsB3C0kTNZxJZjeGFJE6VMDh6sGUVpaU3Z8YWS25FAXN3yGOC8e5R0RpnpnxPXVzY4rNSrR4NPvWpCMDq+tZfWLfB5BnasjZgiBcBmQFyOfjDQOyEhuuTp6gBwsgmp5GwUSUVUgpGx4henlaUUK4iMWQsotr2JhuJr5eAQX5V1ME2FHEALQaDVGbCBm5HAPdNQamwjV/lMI3J+WCtgEwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvqp80v1hZY7JpyDe1N9bPLp2iDFwrD2pzo9jgoCJAI=;
 b=jOQQgsX6NZm8AuN8L6qyJy+co2eoukH+MdqHfBCpCa1GzxUYdKPpG8P6Q7XfpEo2yAPSBkr0T1W9No89IAYW1ZhEzQQe0vD5i/0iQ9FPJ5uQ1oLJWYFKoESlzy/fZrZtxI1POJlTO0ixYKNQsJRPSvtvLiSrUBV32eSlXfMQ66QYJks7d6j1EVS6OPd7NCT/YEYNCryd8qoz4NpJGjKIm9C0tcVwJ96v1X/WDWAEwfNNMeqpAAMYCvTiVn8QeZvbpI192BAHE7WB846BCunQfLBM+Sw0ahNTzm6KnWsitrbYvNL9sTWpzE/LEd+3RvzFeDzsNtq7zBoeBMtVybaYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvqp80v1hZY7JpyDe1N9bPLp2iDFwrD2pzo9jgoCJAI=;
 b=lICu5pvvuuPj06V/UGBlbpjL3V89qQsDKWyCpnlShBnEgpHdmd9f2Naxm6r4poKVYRe5phb2iHzqBu5i33up1x/ywQeqYaeOT+bTI+xOlp7ii2KLnYtcNraDaxLB2Y2j6a9ObP+uHrRieysWtchxn6vyzh16hUZu1M0cURVM2qpmFxAr885XPDNM4s26K8mMDu7ElzK+uNEYGCxrByIrgDG5z6qHY3mCP0v6k002JEGLv8U3DY8j7WpjB0Zqg+EmCkFA5KDAXUkeZjjGru7O5mKfS+GIMRUgqI0OE4vkFwIe5eRO4vVijRODNixTFhWz3/hclUfHfT30FAtTjPP1uQ==
Received: from CY5PR22CA0033.namprd22.prod.outlook.com (2603:10b6:930:1d::33)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Fri, 12 Dec
 2025 03:21:40 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::4f) by CY5PR22CA0033.outlook.office365.com
 (2603:10b6:930:1d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 03:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 03:21:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 19:21:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 19:21:20 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 11 Dec 2025 19:21:18 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <waynec@nvidia.com>, <haotienh@nvidia.com>,
	<linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7
Date: Fri, 12 Dec 2025 11:21:16 +0800
Message-ID: <20251212032116.768307-1-waynec@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 9407c726-9ca8-4a1d-cd5e-08de392d90f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?75IbJdORmZte31d2zWraZpsAjHpusVw2ebJtLR22PYRsXcSS/8uKh5Uw4ULY?=
 =?us-ascii?Q?7YunMkwh7R8bgrAVWqS086GQOjsAZR3RT0U9vg6GhDszO2UVQZCmAJ+VX1Gl?=
 =?us-ascii?Q?qpMDC2lsGkMl39sB5Ze3NS8dBQFIzay/7L+pya64peMaBYP0Tv7mfXRV4JEW?=
 =?us-ascii?Q?idq4+T9NeLFC/Va2yOkiQbtip1r9TsCI/E1hUdQUAbSz2j1tf+Gcy9FO/6Ns?=
 =?us-ascii?Q?Xy9ItGwHGOTLrAcsvatwysCS4q9tmyScJ+/haOmpZcAa3yHpqJAUoOgyLSbX?=
 =?us-ascii?Q?pU9zy9BUwYxswJELeglDP9Z/bk6yH0dEGuM8Oi6un8A0XywtKayCf3/4mPbx?=
 =?us-ascii?Q?rheFm1JjZIdLEvdkwKrCfBV6nTCluOptRWxmUda3pIG5s3DXkNkYMDUXhZsO?=
 =?us-ascii?Q?seCUMXhi9Kz2IGz+mYBpG/aBqL3Za2tjAwCeTPRZ6B547izIPGjTNA29O9uE?=
 =?us-ascii?Q?YEpTZvAA2hG5Am0xrgshwpUj6yRbANrZ4u+REjNobMrPlXQSLI3s5yWSVNaA?=
 =?us-ascii?Q?1L06Q1rZoeUS0H2vb4K2Q90ujTQNqI48b1RefUOxvAq2IasmtHS61hp6sMDY?=
 =?us-ascii?Q?05VQyB6psNMk4e+Mg3Dv2GzH2pklknwd3q2WyqY0gq5sATWf2LCmSTWBO4XT?=
 =?us-ascii?Q?rbKwLOMn2COq3S6+dXpu3gI5EBPMJLaHsvr3nIxhWWE3tUAw/QrteBNav3+p?=
 =?us-ascii?Q?aGnt+3VYagPMSGtd0xg7ex0aNhvXotSi/oHJ2pONdRj//kJZdkDMFxNQhjAi?=
 =?us-ascii?Q?x9IltA5/PPe/z5RBc4ks9NZKCAC3RHe3lj3gH2e0zXHHKcTo0tsPx9emDZKV?=
 =?us-ascii?Q?0vOa1XcOMK49AdKE4iniUMYzVQs8t6+SfH06E26OSGshMN1V5sMZdEPfuL4s?=
 =?us-ascii?Q?xoogLfh7Z7BvVll2HOks6yy9ZC7Zh/mSBSrskhbBI5+NkYAIDYl2m/VYeiKF?=
 =?us-ascii?Q?4oZktvpXYqZZZCGfnJTAwyDlV44buSOEEgT2kRPzvhApx8cxOHQOyLOl1yod?=
 =?us-ascii?Q?5z/jvptDmzyk37MdFXhVQacnSnUNs2sNmy1u430UoyYaOCn8UBL3ry36xfE8?=
 =?us-ascii?Q?RWDM9RlGNjbNxJYI8YLvEEecmNtHpL+EXrkDH2fJPKlFFUs+oXARhFg0GMHk?=
 =?us-ascii?Q?5Vy+lTVM0hO6qhnZ9rXCRD4JGQQlnIx4w2kc7tW/UpIJaaYSRY5gzktbnefZ?=
 =?us-ascii?Q?VQH5cTB/S5bpOE6zYjC0FBiCZsW5UtJFqs3gRxFKIoRObWVvIzv+1FnyuR3m?=
 =?us-ascii?Q?yR5AUE6MhM/R256h8GPObF1Cy3eFvbTMA00k61WfihqgTTQZRNHXALQHT5x3?=
 =?us-ascii?Q?oZtUwgA3blSnIEWQSfZOci+fGV1gUwqx1zZVW2L6sSNhWfE7MOw8dvYDFfrF?=
 =?us-ascii?Q?Lg/QpHGEzWW79VuGyk5qa8Agws6IeDjZ/eq+NogzCjugAmG5D2OIf3wrsfJb?=
 =?us-ascii?Q?DIDJSdM+usHmiamnMTAPM9IT2S0Omk+ytilDqr6v5XijKgtHGSD3t4pz15rd?=
 =?us-ascii?Q?dRPYyZu3eEMRhwMwtzS2aw/2kuv+25zDrsPplqdvml9DAFL5g98XHHm6mW0Z?=
 =?us-ascii?Q?nXTzVAjlnF5CE4AJQhI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 03:21:40.0264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9407c726-9ca8-4a1d-cd5e-08de392d90f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

The USB2 Bias Pad Control register manages analog parameters for signal
detection. Previously, the HS_DISCON_LEVEL relied on hardware reset
values, which may lead to the detection failure.

Explicitly configure HS_DISCON_LEVEL to 0x7. This ensures the disconnect
threshold is sufficient to guarantee reliable detection.

Fixes: bbf711682cd5 ("phy: tegra: xusb: Add Tegra186 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index e818f6c3980e..bec9616c4a2e 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -84,6 +84,7 @@
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0		0x284
 #define  BIAS_PAD_PD				BIT(11)
 #define  HS_SQUELCH_LEVEL(x)			(((x) & 0x7) << 0)
+#define  HS_DISCON_LEVEL(x)			(((x) & 0x7) << 3)
 
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1		0x288
 #define  USB2_TRK_START_TIMER(x)		(((x) & 0x7f) << 12)
@@ -623,6 +624,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	value &= ~BIAS_PAD_PD;
 	value &= ~HS_SQUELCH_LEVEL(~0);
 	value |= HS_SQUELCH_LEVEL(priv->calib.hs_squelch);
+	value &= ~HS_DISCON_LEVEL(~0);
+	value |= HS_DISCON_LEVEL(0x7);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 
 	udelay(1);
-- 
2.25.1


