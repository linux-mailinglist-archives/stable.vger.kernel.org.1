Return-Path: <stable+bounces-45161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079058C658D
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393651C21F37
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764B6F085;
	Wed, 15 May 2024 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AyuV5Ne"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235556A005;
	Wed, 15 May 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772251; cv=fail; b=SrNhRhAWiUFvlejBVjwnDoQJ2E/RfBACLMaR14Py+2S1hnHdhOdftHkd8QfbHrJhiQbIV+Fh5iL19ROSBT/sodowg/3cpLDQk9xJuqp8W7dAQLkayjjb0I9w0WoWNwFeq1hvWPM7SqW7METwxzp+4VSgSuJyvpkWpoI7YAxyFmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772251; c=relaxed/simple;
	bh=DMO3F6aCNQtwyjXnpWpKK3y5VEszzdlulV5ahxO3lxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0UyAPLL3XDZVreGZGVjulSH20Q0UiR4WcAcw4II3vxhiYLPqD7GmOR6XPWLdYlaJ62s1QLs6jyc7GwiHiuWP+BhpMc2ljRIiB9T8/x5cKzsKYkA4poIfHB07B4DGf4J5tqkM3H2ESZ2oUAPi1IpibWcYSwByTLXpMhTYXf3CEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AyuV5Ne; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKWVVKa6p+TRYGU3C1Zxpa2/bWi/LzgFL2JglhwTfu99NVRVPrJ2rrXENiL6yKPh88mZm0i4D3tgA+Pt9TMtUbZ03zyZJdqeLkp4g9s3h/VTpD+q2+whrkwFZ6T7roFbf2N8+suOoBqv97d/ki+RrsmTorFZgbF3Sc0EKu2meIQ0VCf6yPxxz1cf5n23h4OxcpfLEqB2FEPwR/rmNGnghf8E3bYGRyTBsmgZb2a3Un4RykKOS1fDhuxHiziq0Duid3w5yyZDFAr0buMM008L18C/kbOzNbUTnt/VFRSiwoPHn2wvmhX7aP+ttG3KJ1HMBZd5BjXazf/DreCU9cReaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxS50D6WIV2nsBUdq+i3kGRHpg5tcqiBPMMnzq6/a1s=;
 b=nnSoNb6gKTF8asqnX3lR+8rbC5IMdV4/dlzl6CD9fBiPyk0lBu94x1g9tMZAISKzB7cwDLh6qGDvQxNxAA/4yGt+iDV6039CKnlpM1sg9b8XhKGBztGj8aJgikBpI1pop28p7bzJk3zNMKpsp3VFnXaiAIA3AW3a8vbprVxRq+LAc8GXb3B6eNFgPIk27pw4KkQDS9F9EL3Pgt+CiMdLwxlhBxOogqwSyqk08nYTb6iusT9fLAQ8aOokWK3YLHjoj2iwx4vdGN0HDQVDqast+vLilpffM1dpyyX2JsNo46LRQC3S2s0gPoPj9+6h+QDSqVgfiV+KfQ/8QxiVjEmpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxS50D6WIV2nsBUdq+i3kGRHpg5tcqiBPMMnzq6/a1s=;
 b=3AyuV5NeJqlnyKFw6jGLKTYWtGxY8rzrCiniUNziwZXfMcUcvcL4ktw5KaZ4m9JqflrtszPtp26IBWzbeXykQ49uPexRohGugTETgHkHdehQt1gytFjhZL4Q8NM2pnH9UGhZlvaSNjag6GABuEDvKC9i4Q3vyzNLHtnMVKoH16o=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 11:24:06 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::74) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 11:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 11:24:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 06:24:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 06:24:04 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 06:24:04 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] drivers: soc: xilinx: check return status of get_api_version()
Date: Wed, 15 May 2024 04:23:45 -0700
Message-ID: <20240515112345.24673-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jay.buddhabhatti@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: b43c727c-c2ea-4e6c-5093-08dc74d187d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jR6o3yCRnoZm/noWQ7Ji3GxZNYY9gFRhCeS+1mKvMaoLjHDQ+pqPoZu/JZsr?=
 =?us-ascii?Q?qF5V5MvxUi8YEEixkH6xDzCmEsOmZkRS/hZE08duwV+lZIMutUCXbwbrhE1x?=
 =?us-ascii?Q?ZpgpvVY5Lics8e+C3nruyVv7vl3AJi9+4B+pEUdsFO3I+Txu55mcc2u4pQKK?=
 =?us-ascii?Q?TMRlil0wzPbjnWD6slstYdVGvw5/2T1IHX21zJdu+ub2RBSqz1k3JgHfmevU?=
 =?us-ascii?Q?/MXVHpAQ1LGd0mW8RmGkmdB5BlZV58W+KGvRnZmxONxMJjU34dz0XXDAtvKw?=
 =?us-ascii?Q?9Gcc6AJoqsyLvxzTyWjL1ZpFXJ6nl7vk9x4uo0hJYyamvh8iV7GjAYd4qWfv?=
 =?us-ascii?Q?YbozqzmNubruPWkUX0TsDZ88ZS0Y3BAuiC/+4R0rmXwqOyDRSel/SxUG83qK?=
 =?us-ascii?Q?tjPGiNn+Z2SWt+KXLDUDahw06g0YFfvYuKLYV428zK2ckcE02AM3bLLFB9YY?=
 =?us-ascii?Q?nFNbp11Zd6Sn7kBhcG7QpdwFHkXOug8UK1BR3RW2dMarXYcjvWQatTHxeq50?=
 =?us-ascii?Q?ayc4FldughaTmErNWJ6iSQjcTnmGMmNcv7nSq6MLxxUXtllF24yzLU6fWQhg?=
 =?us-ascii?Q?de4vEpFhVii56XIBtuzNpUhcyBS89YcDlX1zAKBcoWJlcA/ae9ZtIFvVCweQ?=
 =?us-ascii?Q?xphFlPlCBHsMy393SaK0j6mH5kqk3f5+jInY7OODoWiL2MxUAzZdMralFFC/?=
 =?us-ascii?Q?kRzZFvwL0I/xO6iFPAkJsGDEND6ckU9cpq5CgvQj7wUr5ol41XGcgSoaVAED?=
 =?us-ascii?Q?3swj+NXl0TF3QstMZeH50FlU7Cql+XFLrRITbHMvx7L+6VcItUqPEuyNj1lO?=
 =?us-ascii?Q?TeTOSpUvNBymJouBP7FExg/stUhGSZ5yFLRQoohKQZ52idQ8+mNZHPG2mvXh?=
 =?us-ascii?Q?AJG2iu7sii9wN5KoR0roEvrwLqtlZQ/v6zRI0wLVQa8Z4reU0BhDbQc2qKgI?=
 =?us-ascii?Q?5zA3HA44E2KPSfS+lUVZGYAYlzUuhZs86+cTlJ5pCjczA/GQ7+Sv9kyKYLDJ?=
 =?us-ascii?Q?Ccgeeu81JYxVPGE4SyqrKszVosYwjvQkfHLTjeRrVHbtJArrkuWZZw0xyNTN?=
 =?us-ascii?Q?/Z89ZqaCdrl0joCssVxlO+Rf9JY4AaNaUjQuRbQ/RVTogQqoGrn0VyU9voY0?=
 =?us-ascii?Q?0qThhpePOqAy3PgAh4l2HnNJkZR6qX2D/ifjnffUYnLXWutvrZ4efFbBvI4e?=
 =?us-ascii?Q?Mbio2XwQMv3VfmDElJ3AoBjgdUgLFyxNQN+zVo7C5Qq5vf91c+JQpGEnUH3r?=
 =?us-ascii?Q?ZLTHs1cvsHRCkqKGsKbpDHpQhb8XEbY/jgGUOh87fNMR25nO0XGCdyYBQ3QY?=
 =?us-ascii?Q?MRk1JeeTRTasNVTQQGAQWYhS1EhMiSiL9bNZwWCS+ij09A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 11:24:05.4383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c727c-c2ea-4e6c-5093-08dc74d187d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

Currently return status is not getting checked for get_api_version
and because of that for x86 arch we are getting below smatch error.

    CC      drivers/soc/xilinx/zynqmp_power.o
drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
used uninitialized [-Wuninitialized]
    295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
        |            ^
    CHECK   drivers/soc/xilinx/zynqmp_power.c
drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
uninitialized symbol 'pm_api_version'.

So, check return status of pm_get_api_version and return error in case
of failure to avoid checking uninitialized pm_api_version variable.

Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: stable@vger.kernel.org
---
V1: https://lore.kernel.org/lkml/20240424063118.23200-1-jay.buddhabhatti@amd.com/
V2: https://lore.kernel.org/lkml/20240509045616.22338-1-jay.buddhabhatti@amd.com/
V2->V3: Added stable tree email in cc
V1->V2: Removed AMD copyright
---
 drivers/soc/xilinx/zynqmp_power.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 965b1143936a..b82c01373f53 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -190,7 +190,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)
-- 
2.17.1


