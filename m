Return-Path: <stable+bounces-83430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A999A055
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14811B21F78
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569B20C496;
	Fri, 11 Oct 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aK5gZFpB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F220B1F3;
	Fri, 11 Oct 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640127; cv=fail; b=AWSanH8Nw+/P6oD8mDGVO9k2H+muyqHHZ5YApdKK7nwQzQOLOImmmHGkptNaRA90r1sCmQk3+QNJeuooL7HD60CFxnvwgbpSKH/g2/D8On2h1x0wdtWvkMSqSadPEWZiGGTAUVN+CUM3UKX5I2X4+mtgQQdrUtqhdqpvJaHOUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640127; c=relaxed/simple;
	bh=SfithNTT8v13ihcMgq3/ClUM/cFo5QMaGX80TH85X0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FSAjlu1Ze/QLta0Jkc/WKrvNAYBTU0OgSHLkm/XTB0arJTASq+BjTeMqBISdHik8j1CpqjdEnAQjL8V9LjKHf3dvJdjcOtmRAD17u2B8ymHU/gvmbYSVvwJN126f5X2Gr1RstePKVYoyiqXcbTsc97OJNAsaJ64TawfTHZ5OP8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aK5gZFpB; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbPEAeLDRFCwRUqWJPSNbMl++U0Bni9FR756pTDm91pHMPunDBQ1f3XFWr3u74HK5DLlpRsZg7aPqh7nUuhdB8uHd2eVo9MXzOtb8Na5el7116ndJ3NetEQzc4xmGyEOY3zm3ywLnNMzwZlffQiHQsiq9ZbDZjOoI123QembjjoZUN0WdNhieYL/H/+ytqxzwRZ2RB2kfssMS/u3nUDHS0cKr+z2eH09wXzErGQc9kjPEObSfrdW1vG1PYKPBQ0+3T1dEX7d+96wjmbViDjQDSAwtsbFaIoDUEs1mSJlMvjsnalSwm77ha72ZBgptVzevNgHWQsKW/rflFcyK9kXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phMai2nW7bDa0x3vWAdHVhmLpDF2/gW6hNR5kzEZ0wg=;
 b=m26WgewQCPawyR2WONtUnN3l01+k82WGj1KOQiBhXsuuxMgr+UHIph7QHdLd7cmAIowHWyw+uirfeBo/XDa8/zxWP91VQxn0Sh4Y2rPylE6/1E8O6aqNKc9PTHIEm9QboWSluLLZMsNezTihgI36SN9HuhprGVXjAoR50SgA8lnNmp0962t3d+ixFbFSUmWWzSmd+9XyM8vPwsj9uXDoWfK3/4LT00I5qtoIkDPV7H96ZrSLhpOc5Bvb+5AUuRRPaghvryWbp9PNixbbqAH+8uImvVoHTjpcUzuq8r1qhTEVLIXDRowJ/nexRA6F+C3IL3yNABoQKSgF9dW4fA9zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phMai2nW7bDa0x3vWAdHVhmLpDF2/gW6hNR5kzEZ0wg=;
 b=aK5gZFpBhjvOh0eDFhe9YMFG8pHWGDlMvB8X4vX3Wafd0wxHEaExZJJX8ByP65ls1JIfzcbZ9E9AwZgHD02VbaqgLAVrdOhZwJD8H4Lh2AU4uIvMXDC966wWUHhCQVyP3i3WE/K4dIbrNIgWS3yeaswlStLhd3qarEb0bXFasJhJFupcC6zYOLofVNCZvfRNQr6c6+qfhOzx5SxATYIg7gel40oL/tdlKFfP7tgR0sh7J3hm7iczUzmJ5jijijdAdxuIdeI9H4PAtuPhDno4/UFEgfvjKbxWLJDCZg5gXiKU2jLKVURJyDD2XIWTjMKHgHfcPF8sijk9dbxdY1EHAA==
Received: from BYAPR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:40::31)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 09:48:38 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::89) by BYAPR04CA0018.outlook.office365.com
 (2603:10b6:a03:40::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Fri, 11 Oct 2024 09:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 09:48:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 02:48:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Oct 2024 02:48:36 -0700
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Oct 2024 02:48:34 -0700
From: Henry Lin <henryl@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Petlozu Pravareshwar
	<petlozup@nvidia.com>, Jim Lin <jilin@nvidia.com>,
	<linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <henryl@nvidia.com>, <stable@vger.kernel.org>
Subject: [v2] xhci: tegra: fix checked USB2 port number
Date: Fri, 11 Oct 2024 17:48:03 +0800
Message-ID: <20241011094804.45528-1-henryl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7825df-c667-4701-3678-08dce9d9e20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jF5EUjkkiCNw+OBTHIAh8jWZRbaCaKvutI/Xe6/eh9Db+Koxovt1z9M+a3pU?=
 =?us-ascii?Q?CVRtXHMqUxCCwYoSfWFWWNgLE9+kWMxmyk7Gi0BDDDiJEVpaOApNSKgWsK9C?=
 =?us-ascii?Q?ZGvJ3qDueH28EZftnohtI3zF4WrsyvJD75jnSGnXBvxNOpr+VLnPIH2kF7XV?=
 =?us-ascii?Q?JXfoRNL1xK1nYL5xL1/O9cF5Zlfj5K4p7No7bh0WsDuQCjietduZw+0De69h?=
 =?us-ascii?Q?ylym0okHEOsH948brywb560ixj1HzGwk+O94GxusBnnVuw8p4MOJsgjbbjo4?=
 =?us-ascii?Q?X+p7/TY4C/5HV/kWi+bfz5EDy9zuMG2w/X57HXvFQHDYXwNk+pMzHN61oQV2?=
 =?us-ascii?Q?mLhwYhgQ7PQoRIsEthKZny0Y9Gl/Oi6HmDWhj5AQQ6A5PUrEzHMsd7fyFEbK?=
 =?us-ascii?Q?swbw1U/52S51b4mNALg+VeBQfhDURRgEj7mqX2LFOgayBfYJ0Z7NEiK6qBoC?=
 =?us-ascii?Q?ST4GhvUYHVf5Iz3iU2jfuyqhHaWeQBgV0/m/Ej2lRvit3XfZFHnXpyc+QzXz?=
 =?us-ascii?Q?0jApIwrO1FXdoC33/qhCZCcRlW2FxPeyBi6uol1bwyGXFxpWvfSwf4klA5PC?=
 =?us-ascii?Q?/K7sFBfDqXOBbwAw6f9BUMkF4HfaMAfQ5Isgx9IdhYXUk9rC6EtNo6ujPsCh?=
 =?us-ascii?Q?sIMFFI20i1m/fhDG8WhVBPxQYkg0hxNxCJzkIp79JVQRVmtaVhiwaKEf4P9R?=
 =?us-ascii?Q?hjZwuhdVd01XZpJWMv+izmzYQeY78YlWhT59YfFUrL9xLMoFERpm2I0P1eHY?=
 =?us-ascii?Q?0urMyY+JLCaEAJMBOteOS++1mwmBFfdyY0aZdNuvkk/2/ix8nvRH19fTt3Sf?=
 =?us-ascii?Q?m/C1GnI82ckDUohJ8/LnPYGX3NOZGZzg3ZVTSoZVQNLRggxYRq3NaCA1+6+e?=
 =?us-ascii?Q?nYMD8k/61LfXV7tYnF1a/0cLpSKnm5E8E9yhfCDj+rGaiLCIJg8/3rqtl31a?=
 =?us-ascii?Q?EXyk5MZChqp0kmH/pKTfrwH0kWuZgjpHs74trvpy/wFTAQ8bm3DBiaX1Ixa0?=
 =?us-ascii?Q?Xyx/HwbDFFXnU/QYB/rzUYZ4IilLCELYG/gtyaaAG/7sWyk7ycI6jr++eOnH?=
 =?us-ascii?Q?N9URgo81bhbPLwTHoqaMvG3ljzqOFCgqP403XOXfkUaY67YeuwLEbtOrQfE4?=
 =?us-ascii?Q?dZttahr/oI623DH6gKknyf/q1kdfsQJnVphOjBq57dufnN1x0j80rnZqLe6w?=
 =?us-ascii?Q?1nK+zg4Xe9ws4uzsQYW1Zg6ouzoFe7opxP9H9cT55GlfkjV86S5UPoDg8oL1?=
 =?us-ascii?Q?7saW2CKVvfkUsbjvBCrOQ6/yUS+XCiPWjopzPAakp+Ri4Dh0brkrDF2D8RTm?=
 =?us-ascii?Q?5yx59U75qmNpjIFcz+G8o/5wN0DeVqPkCxL+iOLrS8H/RK8FWJBqXsSa+hW/?=
 =?us-ascii?Q?EpcEyBI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 09:48:38.8794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7825df-c667-4701-3678-08dce9d9e20a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005

USB2 root hub in VF may contain less port number than supported USB2
phy number. Checking all USB2 phy number here would cause invalid
memory access.

[  116.923438] Unable to handle kernel paging request at virtual address 006c622f7665642f
...
[  117.213640] Call trace:
[  117.216783]  tegra_xusb_enter_elpg+0x23c/0x658
[  117.222021]  tegra_xusb_runtime_suspend+0x40/0x68
[  117.227260]  pm_generic_runtime_suspend+0x30/0x50
[  117.232847]  __rpm_callback+0x84/0x3c0
[  117.237038]  rpm_suspend+0x2dc/0x740
[  117.241229] pm_runtime_work+0xa0/0xb8
[  117.245769]  process_scheduled_works+0x24c/0x478
[  117.251007]  worker_thread+0x23c/0x328
[  117.255547]  kthread+0x104/0x1b0
[  117.259389]  ret_from_fork+0x10/0x20
[  117.263582] Code: 54000222 f9461ae8 f8747908 b4ffff48 (f9400100)

Cc: <stable@vger.kernel.org> # 6.3+
Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
Signed-off-by: Henry Lin <henryl@nvidia.com>
---
v2:
- Added Fixes tag and the cc stable line

 drivers/usb/host/xhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 6246d5ad1468..76f228e7443c 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2183,7 +2183,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 		goto out;
 	}
 
-	for (i = 0; i < tegra->num_usb_phys; i++) {
+	for (i = 0; i < xhci->usb2_rhub.num_ports; i++) {
 		if (!xhci->usb2_rhub.ports[i])
 			continue;
 		portsc = readl(xhci->usb2_rhub.ports[i]->addr);
-- 
2.25.1


