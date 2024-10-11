Return-Path: <stable+bounces-83472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E299A6F3
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F34EB21949
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A41940B0;
	Fri, 11 Oct 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1RjSbuc"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3317BA2;
	Fri, 11 Oct 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658297; cv=fail; b=LTN/EK2LitaQgyiohDqGqBVEhgdQ3oJ9p5XXahZTVVUIB0xfAoHH9ehnRzwMwC70idok/Zl8p20038uP9l9bOduIWJJlcmumvW6Rg4ZeQErtLfuZnTlJBffoTHHnX0KicJ2MRtVvgVIwsOURRjjHT1nAav7R9cQxAsCfzgjKbHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658297; c=relaxed/simple;
	bh=+mu2GDPluc0pBHO469Vog6TiDWn7NC+1DK6wjyPtlrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGUUPls1we1fHGL+eFTRlGt/rCqj6/O5aPXwG5kneFV8h600hNpngEzxI1O5NDKCWVyt2fCgmv3yiixDOgZkv/kchO2EaaVe5EfeYTGB4De5iJstM5rxw535W6wqHReHyxfZe+1ipOfct5hxJslIeRFx4y77ovlX3Iu9J1ckY8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1RjSbuc; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpdgNCDiWbnBykTxoU8lpjgzBuSSvgEa9pT49Spfun0hETwlqrUbD5PWmmg/dckgN2r0LXQSYhxeFW255+SXmaKdwMWPaixiPyHMThobWH6j79L/8pIxzC+u+HlQ2Q6JeRGqL7n8NiyubickH1dvaAXMbWyFzTwc+CefeKHAPka25J8q331fpLnuoK8aYOsUv5tRClLnM5FWDNRr0Y1HXUUzb+niutwv1P7BObVMHhM1AN8ZDJXVkpTLff/3zMf/POtXc6A4MAre4oXAigyh0fbk9088fdVxBdZO2NxBiDPuqicvNM+XO4c102irAfHPiIRxzJZ6zBBVKcvJulkX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6xoX9kSWcxgWe7jjjkJ9VAokdmmNJYa3m0sswo96PI=;
 b=b+bbi5EdWt0RJAD3y+necwMtrmYAAs9UP0B5oNUmqw6JiUp18dbREQH+XowRgbW+618nwatSDcpzm2qqWyTm3ZbWtrjkPt26v00RTNYqHWbRv6lEh8/OkGIci4njp/YVuAtLBee9aTYHiT3yI/Y/+AJKb0zGD2Fs8nLsHOm+aEBi9/fQJHpcyaPQuvlL90ZHv/PhSSyQn4NPoU3TTZKQCavtLgkdwZ9BKLn9NOITKWoSM+WHo6a0I0kub6jSId9EAawabQNkKNpejF9wbqXRT7Jo2eug54jSSaPMIXMJcqE1LtIhqKMLPsEDO3FJIJI7SI4KLYNe78kU0cCnstLvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6xoX9kSWcxgWe7jjjkJ9VAokdmmNJYa3m0sswo96PI=;
 b=N1RjSbuc2/lsS/lRS1uJ73wO99uo4QrQ6N5LPhfwlHA7a8neQeENI7b1P7u+sRO7Oe+F9w8KJtF1vFbVxzCp7RWlEfBPzEl7l56WGnxIcAl1vnUQP5kL1ws5p2AD7ETf1l/hjuqvQ0MT3ZgQih/mXKg/yWm+nFI2hg5EOabij2N8JclAX/fJNUVTAXJXB4S4KPbDyF+KsocR15whPgXFz+h4aF5vpNUdLKu3FiqTb7+lJ8uepvFWr4RTJKyjI0SfVqL5w/MoBtWU1Kb9tGcPXhh4VEJoB8z9UcFUxkRa5cnRHQDCO/D993zDBMJvmFzkEiVuATyurEDiDJTzePgrNw==
Received: from MN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:52f::30)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:51:31 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::2d) by MN0PR03CA0014.outlook.office365.com
 (2603:10b6:208:52f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 14:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 14:51:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 07:51:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Oct 2024 07:51:19 -0700
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Oct 2024 07:51:17 -0700
From: Henry Lin <henryl@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jim Lin <jilin@nvidia.com>, "Petlozu
 Pravareshwar" <petlozup@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <henryl@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] xhci: tegra: fix checked USB2 port number
Date: Fri, 11 Oct 2024 22:51:14 +0800
Message-ID: <20241011145114.8905-1-henryl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a9610a-b2a2-4ca5-7b69-08dcea04318a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQnjUN2ydezHpn5uXvWxdmZsFdMLhHDRo22B4GiV7SyX8+MpjoVkMY+KJwrx?=
 =?us-ascii?Q?nBW6iVM405QBZFHsJNFH8zvXrC0jMiEjMont6l9jDDr0o8TyO5q7bNeI+rbP?=
 =?us-ascii?Q?MW0LvVznJCIkxK2wFWLNBcYuyJ8ZBJLOQ7paqAlzr8vDt05CshkHaL2m6UrT?=
 =?us-ascii?Q?BTHqI9or22lonKY08t7OWAEa4itoEOpTD3VeGGPSvxRIyC5pMA27TB3RkDt+?=
 =?us-ascii?Q?JHxQuSQuWIIsOXHk94anPkPXEYMkyGCi70BzArYQIU1RKcKDBUmlfknXX5FU?=
 =?us-ascii?Q?d5BBsST0XeJuNlcFAfKa4hNYQVebXG2kNdl+eVGomRFiGTuDQ+jAicueUuuH?=
 =?us-ascii?Q?PN+n1ZHpUtJcVetb42qSLycy3RSYZ/6swQOvn35pYsQZ6NLG6kaZ5ejg7vP9?=
 =?us-ascii?Q?mPofGiR10vzWkpCoXjV5JltJNwYnLNhxEUrpRJ8dVa4jdLCTtNUwT0lyPZg2?=
 =?us-ascii?Q?3rTTFMwutpECUkPBJKiG4PjTTDdKyByifxSHpuOv1/mrVDPY5kJ2Pu8spZf8?=
 =?us-ascii?Q?hJVBuzb+8Udckwfu0IpPeKl7MaH1D0+Ewm5Wd2PiHtfgQ/l/eQQ/g/SW3D0N?=
 =?us-ascii?Q?FHQJp/EJd7nnbUdFqhMIeojvquz2udovpgCbiZdHjv4X/Z7O71U5Fzf10xD0?=
 =?us-ascii?Q?410kYWwPS6w758IL5WQQqvyNoJ5g3oJsATFkgvWPHSxJMSW+8xbzN+KK1giK?=
 =?us-ascii?Q?8mg9+YCVRVk5wryf7k52TLEbZTK6t1l/Lx73n2cJcndn2AliQglRNClYEwgv?=
 =?us-ascii?Q?XroYyJo60jgOQujUNBSunx1nI7ILPq2KoUGiazRW7ZjKaV2HIEeKq+6ZCvt/?=
 =?us-ascii?Q?5mEvGOgvMwerL/2Zg+3S0fKgRjoNr7vLbixTNSROSuD0SX+RaMhp2RmoWGSg?=
 =?us-ascii?Q?QAGMj+CsqyYZKTMMGour5I6ulrhZXYdrx36H7MTL+GpMSKux3pN4MlAsLC8c?=
 =?us-ascii?Q?LKsYVGqt4CWWb/jhWNwijpEpyx83vx22dA8tLwVJ0+yucfgZFgELOUygdVSN?=
 =?us-ascii?Q?6GvrUEcdS0T+glCgyEiQMpv8LKMEZQFxseoNMbJ3YQbGgQLSW6f/y5ByuMQe?=
 =?us-ascii?Q?oTPB9OZKN6FEafNVv2jo3wwmhOAWPDbXigDDaltB2IL4pMS/Cz0GurEogewd?=
 =?us-ascii?Q?aeRzPSCA37sdpbs+HsL09kYeYykcMN5KD6FUvyrUgIvsaRwN+XOFOWT6qeD4?=
 =?us-ascii?Q?rnJ3ZbYkaJDkWrDW+DMETSQRinL+Qr6HvknfaoQ4LDxKerKDpY0nvt9Ga886?=
 =?us-ascii?Q?lTYBa+xpCtFsdBQD1Zgr1aegEp+9y7Eh7CLfX8v5YGl6DPMK3T4AfvlOLlxU?=
 =?us-ascii?Q?fjj/hnw2CaPX29ZDB968FBINTf6tiYz1lk7gRUy88fPOUG2uqYP5BhCYYZaf?=
 =?us-ascii?Q?gKXy4DA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:51:30.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a9610a-b2a2-4ca5-7b69-08dcea04318a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

If USB virtualizatoin is enabled, USB2 ports are shared between all
Virtual Functions. The USB2 port number owned by an USB2 root hub in
a Virtual Function may be less than total USB2 phy number supported
by the Tegra XUSB controller.

Using total USB2 phy number as port number to check all PORTSC values
would cause invalid memory access.

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

Cc: <stable@vger.kernel.org> # v6.3+
Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
Signed-off-by: Henry Lin <henryl@nvidia.com>
---
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


