Return-Path: <stable+bounces-104155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BBF9F17ED
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E98166F62
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5F1990D9;
	Fri, 13 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DsEg0gg0"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA81946B9
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124764; cv=fail; b=S/loqK32vv2MHtdgeMvA6RNqVk4vYxe2rfAtp4NIeilJ1W7BH5nuoMfz5hg/aoWNWZPmbl+5m8XbRVNmihVGgTGbFEacszDJ91nzxY7x7LquBWeX/YLx6a4scIYCNj0oBRR+BN/RJCcnk0myO6fxm0Z5QiUBy6psvDm+usb19EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124764; c=relaxed/simple;
	bh=VaDZCyV0TlGI/YwFjraKQaWanqQmTVxlDp8mm3mgk4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3QXhE07Wi+z4uqMY7uXi2S7ZfNqFdLFTfhn/nXvi/wyn3wIxK7S+FYMbXNC8a7uUFCd0C0hMQCRwmTTkHfDrNoLEd3fAC0mWLhUDN0JVzyOCYFnNeCkXScso6FXcX07ZkZXCbIEygXNY6KosaPg3CQ0D3mQa9TOdwTW18rKfDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DsEg0gg0; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLTkuHNoy0Z1wZbBxOpkiJXmlmnGM9T4UnWMkWkTceKsKvn/jQaJDkc15R841zxFzjPKSLVbK306NZ2HoVIOfXJ781OnuZSkAbMB4fF+twLFHw3GFCYjjMX0AE/m6Fe7PYyqHYISuwUY60j96ra9pwG9fCdpV4ZKPpQ3jWpzoNsgJWPFKE6lSc9PS81eNI6jmd3AnQ2d6Boo9CKwB1UbjTSwK6Wr4ywYBN4Q/OumvzM18gvtmCmCizm3vbdPH6bj3qNeyDNM5lBGNf5w+YTOQ3usyr8KyqgExHUlcHGj6LzTG2pnVSLuUcpC70uLdy9kCgb+RjQ2ryuXmp8gs4dGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B02+Fjsvot83EHICOb9SH/SWC1jt7gkBR/5a2yCtkCc=;
 b=uw6VDJRcI6No0nOfpx6Zrk7IkYwI0neWDaoSdjMQCo9EIeNs0xrXIoF+RiNHHCjjyOgYaH9EZ+4J5ipl1xUl+eodqeEd/RJYjIat3XsZjjiYw3UYyLmeknDZop5mXZlnwF4qNk3iTkp5yti88oMHHhEj2erdK4aQa1HMm9niPnv0OytH4WXqxOQkgoZgGHoipjkr01v1EA7FC9YNLMLDyWaagbKMpPaHRPSCg2e28PooXWiiGM81ujR8ctU1/3I0C6CjtxO0En6SU/4+iDGGl0X1TH2Acx54jgf/e2p9NtGou8rwMUbOCeZBy5byK2MUEqKRNdl2gqo1ixN2JCD9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B02+Fjsvot83EHICOb9SH/SWC1jt7gkBR/5a2yCtkCc=;
 b=DsEg0gg0UTxw+uO7QPdsWH3kJdLmnMszt7r3WZ2Wb5mv9mU/yWQP/lMc4EV6358IG/34NXI4xINN910+JhpIEc5mfTERtV5RaQd0NlA+3N95XVRtY0mQKM52vTNG4+u7MFA8BHqZ0m+oJ32fyyDtktUkAryvyNV/v5GErwaQxLinJKv8CdQUbtLfo7P2IF0o6X6mdsL37vFfpbYN79fDWuC+93IO1UlPPvu/kVjb42fcYf3MylyHY35stc/u/olE9CB6HxYhyrz2Z6Hp0K3JIoC0yS3Y/t8YadZ5gFlOgrKc5e6BDuFcMi6M65Q4cCyJDbixzoYYV1nXIgULMVhAWA==
Received: from CH0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:33::9)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 21:19:19 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::1b) by CH0PR08CA0004.outlook.office365.com
 (2603:10b6:610:33::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 21:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 21:19:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 13:18:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 13:18:59 -0800
Received: from build-bgriffis-jammy-20241204.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Fri, 13 Dec 2024 13:18:59 -0800
From: Brad Griffis <bgriffis@nvidia.com>
To: Brad Griffis <bgriffis@nvidia.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v2] arm64: tegra: Fix Tegra234 PCIe interrupt-map
Date: Fri, 13 Dec 2024 21:18:20 +0000
Message-ID: <20241213211820.333482-1-bgriffis@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 26611958-a03c-4de8-1da7-08dd1bbbce16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XH4t5/hEQI9rhtfp32+fvbf+SwIlbNDnSuvMyZ5gp+1RtgdCQyFD/zhq0JDQ?=
 =?us-ascii?Q?uW4Rd1IV/UOy4wkMJLOSTxkM9x+VdL5l1HudNkJug3KG5YUkHLwwM1stjeGW?=
 =?us-ascii?Q?Z1fN5gep5o1yb/rxuTcVlotGyCA+8EUP27IRw7rr8SRbb9dES6A2rPRz2grz?=
 =?us-ascii?Q?tilmkvA1itWypk050C5GFkGrmZm/wVlHKoGggDPVdbodRYOkPPOMhOwMS3ww?=
 =?us-ascii?Q?mzDyb3qAuf9dCD4h/fJqEfB2FNx8N4uq0+cB6QbhSJdKAkHudNoPPO9dMIzH?=
 =?us-ascii?Q?Z8EXMUKEU8Ao+yNAgIQcioTWmadlj+lMNuWTDhUT9QHzqiBAIThoosnJ1EsT?=
 =?us-ascii?Q?TMMMh6Ihrj2CD7MAcy5qS5QSOH7NiANQIxc4ftcKyXVJcVLF1dpjQSx0kWKi?=
 =?us-ascii?Q?K7XiI4hNbPjxvIojjAdUzymcjTo1FzGqZZxgB7Rwns3QV4PTf41pxXYBxxzD?=
 =?us-ascii?Q?B5JidSw719ZJ9SA2czWmPkTdA5BrCcx2hOyaR+MCcobyDvICU6Y/NTxVu0Xl?=
 =?us-ascii?Q?VR66PNaEkKA4yo71onzOYhBSgOH4TKMBUBMPfusI9YRzcAZ5TthFErLZiEnv?=
 =?us-ascii?Q?jhcUkWfn8dJlid2CSw9++fI39CJWZXEAAaGifJyOWdNH13jUfpTyLhtwxKpx?=
 =?us-ascii?Q?GfPQarLoViLq6e4LxJzg3d/rrNpOBtbT/09Qf3xPP4EQBa5Ehxx0tSV98I7O?=
 =?us-ascii?Q?Nq1GoRo1un8RQy/T0bILWCdgCnKVjRqicNJigTkIguzkFZILVqpeGs8hpoZI?=
 =?us-ascii?Q?UPiBq4xDFUnefFUc6Y6oDO28qcKhJS4bDhgFL8HngXfth69YAELeM+ItjPkM?=
 =?us-ascii?Q?MuB3cg3fhAehIw49Rs75YbJZyTyZ3s6EJiL+Lgw+lfg6xlbr//NdlzFMXP9l?=
 =?us-ascii?Q?xyVs6Ou98MBuMHjequpXepn0LMrFe25siSmH57Knc2xLOvFUDu4TVYAKEcgC?=
 =?us-ascii?Q?zYCx95xE5gT1ZqCEmH7Xfn6dAz4ZT+yy+JRLCIrM8vS55ujxHiXjeftvvgp6?=
 =?us-ascii?Q?fXsby6SzfISi33AjZQ5yR3cJ2yOvL3PR/v1orpwIuw31hi1g+p5NIWNGNYyO?=
 =?us-ascii?Q?cQORJy01P+aUGYAE30FbEOd17Zzc1sHR1PW7WkBjzzko8nCDEsZ2e8Bo5Ocw?=
 =?us-ascii?Q?vAG+DuSOG+FvGoMsxL+6js1CXOPTT7pYvVVUBnpHqer0B1990icQQiYcgSUO?=
 =?us-ascii?Q?oSvpppfR44mIay+hGwSWiAr24KTg5NOc7AM0S1j6r/jFQD0uVhqshmhEjFse?=
 =?us-ascii?Q?rVRR8FYsOiU6VVezkLg3k23nNxK6WjUsSl2067Ehjc4Y9NcgqffP6AuP19u5?=
 =?us-ascii?Q?VeiKbSGIPtwfuJO7FNcR86v5gy61i+k6tgqj1bMPbyPy9GvpTvLnc+UV92B5?=
 =?us-ascii?Q?zb3ILJOrFgS2g3r8IuKk25TAC6DzGeMu2AoLBt0QPAFWJVHelu2GiKcsc7P2?=
 =?us-ascii?Q?kDWsx8hiZq5YFA7nSzlzdYUlZvCoV91L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 21:19:18.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26611958-a03c-4de8-1da7-08dd1bbbce16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

For interrupt-map entries, the DTS specification requires
that #address-cells is defined for both the child node and the
interrupt parent.  For the PCIe interrupt-map entries, the parent
node ("gic") has not specified #address-cells. The existing layout
of the PCIe interrupt-map entries indicates that it assumes
that #address-cells is zero for this node.

Explicitly set #address-cells to zero for "gic" so that it complies
with the device tree specification.

NVIDIA EDK2 has been working around this by assuming #address-cells
is zero in this scenario, but that workaround is being removed and so
this update is needed or else NVIDIA EDK2 cannot successfully parse the
device tree and the board cannot boot.

Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT")
Signed-off-by: Brad Griffis <bgriffis@nvidia.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 984c85eab41a..e1c07c99e9bd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4010,6 +4010,7 @@ ccplex@e000000 {
 
 		gic: interrupt-controller@f400000 {
 			compatible = "arm,gic-v3";
+			#address-cells = <0>;
 			reg = <0x0 0x0f400000 0x0 0x010000>, /* GICD */
 			      <0x0 0x0f440000 0x0 0x200000>; /* GICR */
 			interrupt-parent = <&gic>;
-- 
2.34.1


