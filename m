Return-Path: <stable+bounces-83722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020899BF1D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B2B2188B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03884037;
	Mon, 14 Oct 2024 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9j5fgl6"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42513211A;
	Mon, 14 Oct 2024 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728879754; cv=fail; b=TeHV1HEnmRu5Gp6PJWvtWanqsiCHAmZk7Ab60eTWZ9a+B1Q2eOLUztJHAJAhFCV6YbvgnK86eOVKUC4eXn5s2ZFezBztSlppbmyMmN9n/ORDa2l71czTcJ+HO3TsDFHn/PLrjWf4bn+p4Tp9MsrQ+6ZCMF7U4ExR7MCpH4ssjDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728879754; c=relaxed/simple;
	bh=QVxbZiIjOrxlFMNCPjb326nfTOUcMbOzZLbNRg1vs1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZQRcPCbL0mWUTDth5gSyO7FTxtZ3O7n6DPfGi4PzYhzZKRhe1wiOYccWfg16z9EDOAVKq+sPgERrmsgyRn5J4MFiIG4XcGAsObtIv0U4XeefGtQF93GKLl8X+EW2GFlCeq4A4d9ZWVe0x9Tz7cCufnIZTkQ/pJJ+NqeSB05kuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9j5fgl6; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykBF07/47ooyDJuiUvjdWYJbLCw3fs9xhc6dY6tp4M1jTunRzBZBlT89HAKPfq4uAOXYh5kYX4QJ1BuAYfwv5PToD2Tjfk3NNA0rk80n/F654i1YZeGQEgitm98HI+PpcnTgJ9CNhIvoTzA8wW7t8RrB0LRuVeHujdYVaYHsgn9rbeVUKXGdVR04qe6fwLoiNP+6qdFMfKUXxuMBq0A+WBqplM5IFre/lqju19wwtjXh6ZL6DgCK+/gytnMlNqkTwTg0LIRF3ubUAnr4Q9OcmjyL9o8z7wjSckQjJvvivdeJ1U91F14TTyqeUnh2vx2t7LC8dPz4DwP/8Q72mPBVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXxBWYiUYLagxQeOIofZXz7DW8vr+EYWJVZQDtmavR8=;
 b=bkRLapsnmKImTZhVLv/+HTTsZbS98jV1L8arAt7YsKH7k1Qjzs2Z4X1yefEMFgdeMd9EX1FNKvJ+SPsQThYuvUwXCjTifhQwPF/V7ASGEvDGT+PGjmI1oICNXv3NtCznAtKexSdkBMeM+huPTtRC3P56yQighjiWzzPuy/8oFlBox/izAxS2hNoot1bfUKFk+jmrRsU7bf+ymIEdDJcjqm7ELwZf5V7ncewJnF2FwcjTdzOGfUJo6cIchXKowEPMmFfraVtyCwXBOyXfzYEi5C47C58rumelwcDJsiaKcmWWABqe5UerRumCiOIy8oCa2ejKba/lRlkpCEuQ023YHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXxBWYiUYLagxQeOIofZXz7DW8vr+EYWJVZQDtmavR8=;
 b=W9j5fgl63m6RiAxZdcII21mTxzzGQwhZfkN+AkhwG0fU55AbXo/AUrsRnr6ab7sSl3o3v+GtcfeGrSwJ/ToYC9jlVPFyFFPSfxdncg+fxtBdVdLAeXbL6Glf5d6R0InK7UKHD7Zx3nST3kEtf1LuOkjYyRLpELZ0v3wEP2zjcbpKiMWP25dhFjt2PJikrL0RTxxrdZ+0bqGGpCz88DlrTTNg3bOlNoiX5LPgPGX0Yau2Mr1Oav3H9VLzQBMK7mxzWh61QKaAbkj2Jrec9TZA3rWRZ01wjyEhDhiir0/+zcQNba5jX0SQJ4ykZzc3X6hHIEnPge8TKq/Nb7ZeYziJUA==
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 04:22:28 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5b) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 04:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 04:22:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Oct
 2024 21:22:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Oct
 2024 21:22:21 -0700
Received: from henryl-vm.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Oct 2024 21:22:19 -0700
From: Henry Lin <henryl@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Petlozu Pravareshwar
	<petlozup@nvidia.com>, Jim Lin <jilin@nvidia.com>,
	<linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <henryl@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v4] xhci: tegra: fix checked USB2 port number
Date: Mon, 14 Oct 2024 12:21:34 +0800
Message-ID: <20241014042134.27664-1-henryl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: f10bbc16-0d3d-4c44-b7de-08dcec07d033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DV1uuW+SkrOLwY1jDRZjmnpvu1lxUzWC9HDEqWIkBgik0b1xsd2d0X+RTOX?=
 =?us-ascii?Q?vJrqUF+DiC0LqZNo806bNgbovqi1J4Vyx1KNtZAVrxPMWUxEyX+XzFAb91bm?=
 =?us-ascii?Q?FO9NQat0bI248iFIr4ItVKDb7ln9T2wuAE6tmLVHLZkmPKY04ZPdlaR/F8IB?=
 =?us-ascii?Q?4DazUfwWR/7U+L38QNQCHXo99QUQ3VxAgBgZSw9zHrgC9t3OR3vkLsc/SQui?=
 =?us-ascii?Q?6zC6ndbrRY9uodIa/f6FCuJjIfCiR0t+5arjSKAQmmedgMHTdCQjbgeypTJp?=
 =?us-ascii?Q?wNCDbiSm06gtF+MGDEXy+AsmpGr0aXtYSa1RRSflNt15dksFYTPrgdG5R0e2?=
 =?us-ascii?Q?DUfRNNWxS+x4fKHqDQEEL9DGChIEBpSHPS20wT8Zrnxb6RyvkMaATH2zhrot?=
 =?us-ascii?Q?ORgW0R6yAnWKLC03lBN3UM7dAy+/juN5izv/vIn2f8s64DlKAD7Xgh5Nh5o5?=
 =?us-ascii?Q?sxgeVe7xaCr/HqryJX+fWm6ZmPEj5y+INRBveQ3IT76V90h4lHCUBYKP2yO8?=
 =?us-ascii?Q?CGQNfDDV7RFc+B6tfeBEdXJn1i1OBwU+eHbgY0PZ0JydxTXf4INaWLdMGNz2?=
 =?us-ascii?Q?5dTxHbxUPfPtUlJxlyS1e8Tux4o8F3XkA7aFJTux+8MUANGxU90ax4Z4PIsD?=
 =?us-ascii?Q?EVFe78KeNahYIE5OhPDn1Ft9GTdfmMzCRQQVil2EiqqTMbpk9fuT6QRdfz8a?=
 =?us-ascii?Q?wPz+UzOSHcFlqkjNvDKgGx/jc2BHXPW7Qi5pptiFYoOsaBmeV2uY4HthX22P?=
 =?us-ascii?Q?AGZvJ7dSzfTzSe1v3XmZSPJeN+EP/MKH/gwnKH2id+OvpyciLBNB3u8w1K+0?=
 =?us-ascii?Q?JaVy+aMhNlYFsAcka03Rd1F9kmxw52C+YcpjhnFVoYDlm0EZsDd45lsluVgX?=
 =?us-ascii?Q?vvLra0T0K4UfWmBof+tBrqwyxpElV66flQsDdm2Ob235jJUUmZO2CrZvJ4JO?=
 =?us-ascii?Q?h/VY6TyTlo983mJ4DoEyQzWzdqhXRVj0l3OsMC0uDrrRcErYjThjR/k1MLD1?=
 =?us-ascii?Q?uOi2roDui3IGle9uUeYoDl8RHPzmP9KEgSXIuw64JXGw5YlFSSeqLtfgcP33?=
 =?us-ascii?Q?U1vCS9S+vN51eFnAPUgcH5M7v/gHWzFWZN+fymM8h2jT7Gk/dpFRvBtHW5WN?=
 =?us-ascii?Q?5tAZF9XzMSWuI6IqPjd1MjrLdhxYpFtyeRP6vnwCfMfMjIixaXQTicpuveud?=
 =?us-ascii?Q?6GXEjOoCm1CBktNUnnhlkaXYEgPG7sRQmvUqtBBv8YqYt6ReaMBJ71Edm/Tp?=
 =?us-ascii?Q?E0QG/cFZ3jtmXFzL3I28VJj1xciQ08T2IEzEvTbuOqDP5HCfgRk1fP8zXA3a?=
 =?us-ascii?Q?JdTfc5bvGds8SCd4wbX/yaqleiIRnIMoGmpvmAx8k3iSjTvpcGOjYhCIl7dk?=
 =?us-ascii?Q?GtlK9Yc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 04:22:28.0650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10bbc16-0d3d-4c44-b7de-08dcec07d033
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

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
V1 -> V2: Add Fixes tag and the cc stable line
V2 -> V3: Update commit message to clarify issue
V3 -> V4: Resend for patch changelogs that are missing in V3

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


