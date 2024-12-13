Return-Path: <stable+bounces-104160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF19F1B27
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA89F16B24C
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB01F03D9;
	Fri, 13 Dec 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3YtTAmO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06E1EF0BD;
	Fri, 13 Dec 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134183; cv=fail; b=duds/6bKAXT2qMdy7wclPYFgWklPAsLe3Acr+EngqWF52kd/aCQJJG4AlPs09q8qnx3bRnmOnrYl0IUeygSxcFpMwklj1BO/uv9pbxpSHCm+bLTsJDTT9LcliVzzJGxeDuDeHrcn9VWG9NU2yFDOdX0v9YQDh/Oj9MmP6Lt8H94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134183; c=relaxed/simple;
	bh=giExGeoIgVSIkqggSBnp6juX+Ssqyyz1GsYBx8SxYgA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i2AS09xTrx+c6atLCLicpMBlVnpLUG8ZYGYnOKNxyuO/gDLUcQvSZWBYZKmG00rqEYe/UY2iengEENlbjwiQ78JQtcmFXuosXwPI64zzQI4wVG0cZ+msnNWFAtAZltQIIRjO/XZUb+Gia6fF8O7EpX3Rl0c45KxGqT1ck1dshR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U3YtTAmO; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8IpJeSZ3tTMm8Iw6gpFcORfZMs7RGGXffUHAQYRKxjvFMZBF6Ne4XUuiL5oB3f1BGcsA7qsTwrDo3fQZnGf6s08a7mVHZ5ySsmS5qh2I5ZXci7tkXXKfjFKobEgywn23rQFxfkwWPJxu3cATww5Ge8KLrEp6lFXbQvr5k+5IPw0uWWLeEqRClNFzzXdlxneKbEdyMuZ40GBrgvYdX5d6MjqHWGefBfGpniSEq9u/XR0kqVikMEpaNWsNiR6cCUkDfdgde3IpzfJjbwDIrqfMZ/USDbjmxNXMManvflFZ2/9Uo8wUmEThz48hZ9KCLYUwfLbb3piYjolBK88Ta0sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxkIBnKWt0opLUR815aEEkV0DnJ/SDEjuMBuCBzsdlc=;
 b=RViGFAicDU/rDbrtLBJjrftfv6xCykEitTfz/MBAOv1IyGnMROcY9p9v/j9CIWgZftB9RGBMvLEjnPV2rU9ZFK8XwCXm0m+R96W4yENXtpGmmQ2bN6pV1uqWETAknavufXgHG+symKmvC/tfPMNG5xvPbMoOAPwMKSlXjoC1+ce3anjVD2gcFJElwGo8S/T5QGDbzV4zm8aT4y/wVZmB1AgOoCe8DRgP1juJvvKb2yCnLbYlgO10BPmJuXYmqILET4igG8XTdFoZnsvNALDvaZ/DCvzYM0aKBiwpDbh5B45Upw4epWqlIYNzn52uU3Dx0YqzzwUYe+XxgI7viYQJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxkIBnKWt0opLUR815aEEkV0DnJ/SDEjuMBuCBzsdlc=;
 b=U3YtTAmOPpZqfOtr94csXHoTmmjiX4zufkhhBP/cDMpVhysCv2xf/6oKF3akelPVVfQwzuWVRkucSTSI3oYECo+TwWi9Q+4aUqc9EH8C6RoXCLB6ixt+gNlIXg9WvhoIz31lCGW9ZO1WtagUnnM6aDhVEhYgwO9mpWSHFoa1uvBXD5DT/Us1AijCnTKMl/+D+mPLnMnHRPo94p4/dgBN8s05tV7X27txbcbck6Q8rtuabDP95b2T7TmrQaqp/b7HEIXvsJzHpfmNajKtg75drK4yhGsb6QLGAgMUJAgbHUofKApPqwfqCBdMshuX6ztpPckdjN792SW+3AXlc+kQmA==
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 23:56:17 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::ad) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 23:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 23:56:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 15:56:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Dec 2024 15:56:13 -0800
Received: from build-bgriffis-jammy-20241204.internal (10.127.8.9) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Fri, 13 Dec 2024 15:56:13 -0800
From: Brad Griffis <bgriffis@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: Brad Griffis <bgriffis@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] arm64: tegra: Fix Tegra234 PCIe interrupt-map
Date: Fri, 13 Dec 2024 23:56:02 +0000
Message-ID: <20241213235602.452303-1-bgriffis@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a344e4-42c7-4503-b54c-08dd1bd1bc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4he+8LYLYX6UafoOSVcT2u49Myi3irA69UxRJSly4vRkjTnDmPH2jkP3F/XP?=
 =?us-ascii?Q?5M5usCV0QLyDI1Z09I0kLIFxdLXBSghcW34V/Is+/A5dYkbY5UkrUq/7+PI0?=
 =?us-ascii?Q?G3GPUKNA7H9GxOhBAqAVkpq7dbZ/2NGUjn+6tySWxcc1Wr4N+Zi5QMCfFYhJ?=
 =?us-ascii?Q?yeyl0WTGI7TdiB0/4D3Vl4fOL0k8HhMuwMbzni6LdSabTts/VVyQgB+U2kC7?=
 =?us-ascii?Q?P0C+UNn/VfYkRdNjnpPuX8Vfedw6VvBXkFUcNh6hMOg++3l57LF8JW+CRNdv?=
 =?us-ascii?Q?doYE38OYmdmAcNKScuZEPQx6u9QiLqSs/HsMI09OyeB7BjGkkQuLApQb9kQJ?=
 =?us-ascii?Q?slGrPgpQXQ3wQwagoFuLAje8l1d9q7fZl5eAtGQq7C5wXrwGcygCWUptCZ5D?=
 =?us-ascii?Q?rz9Br6EWiTz1vxnSrbQe/fsMTT3OOWmmSjZZtIvwANqz/7yPIBJ5Hm0MN7ml?=
 =?us-ascii?Q?mvQ9aulqDXDG8f8q27p+onsgwYlk2lqyHie+9lWBrvOsg9hm8VJc2Ob4j0x0?=
 =?us-ascii?Q?dHjWr9jkgBXxQvIx4blJWuSyvrzy+l+1mq7RHMxNoKsEOmlsAE9oON8wp1US?=
 =?us-ascii?Q?cxcjPD3essiAHIzSHahOa2oEwkXaDo++MWqxPm51wxemD2nKSqZc7iMnMIu/?=
 =?us-ascii?Q?dojsUaZsl4ZZXmROlWBaORQJPM+NocNz/q/2HI30/TDXZfLNehe8El8TXIVK?=
 =?us-ascii?Q?BNM65FTy1HIm4fccEMB9tLQHoJvL+uuDiAiTm2ceJ90jQMuieOleGVejy4Jc?=
 =?us-ascii?Q?YUt/DpmlUGm64hsx7gbsSe8tZ07CCqiDadqOMZhA1Zo0iJ4TjTp4AxasiXlm?=
 =?us-ascii?Q?SbihkzD/fxCWBm2G4JNcep/DDPCtBoltBlOXY4ARpuxg/fcLkFJhU63GN+ST?=
 =?us-ascii?Q?ezzPJQ8hgR2i4fWjzxtLXh/wpiYFsYxskbNpq5CHziDd6NCy/b68CQgVL7BZ?=
 =?us-ascii?Q?ENLCBigJg09mzM5uV3fst4nWaxVp5ekUxlj6hTT+jTnY4dsEri/Zck4MFuJW?=
 =?us-ascii?Q?d7wxptAdMcm7/pf6b1go4Xhr29PNB3v+dx3g8Nzz3tt3r5a9G+W8NEJoQLT8?=
 =?us-ascii?Q?hZ1gLoZjQswjW54Qg7EIKiC6ak5C4ndyBO0HuQQxOhGSXEDo1OBmmXDSuToy?=
 =?us-ascii?Q?uOTi0maifxlBJ0psgGKs3w2AC6bcEZN46mfXTH/jEWiE+0ULYOeqkSvzRpTU?=
 =?us-ascii?Q?fCSvVAgGl9qFj5mJJSyjdyx+pnC3iO7cTG6ujWJYJn3gE8wO9UMpGlDFBSvS?=
 =?us-ascii?Q?3JCG4pYeQDF/BQDCwulVqKqdBh+bGduLMdCugX+A9qGXQyT8c9uN4fQwoYIW?=
 =?us-ascii?Q?wsJMCVMuZeMNwTX8Xxmw7IsY7jJHyo2Ksh3ful+yVh65XWu51uSYy/hStBht?=
 =?us-ascii?Q?WCy3vBQ/0pfIpif5LeSbDp0yBCii8sw/ZGK8Wxm0TsH997nrGrXSClrFsrAs?=
 =?us-ascii?Q?7Api9GavQW1o/IY7AZcJvDeCc5OCy/LD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 23:56:17.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a344e4-42c7-4503-b54c-08dd1bd1bc2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

For interrupt-map entries, the DTS specification requires
that #address-cells is defined for both the child node and the
interrupt parent.  For the PCIe interrupt-map entries, the parent
node ("gic") has not specified #address-cells. The existing layout
of the PCIe interrupt-map entries indicates that it assumes
that #address-cells is zero for this node.

Explicitly set #address-cells to zero for "gic" so that it complies
with the device tree specification.

NVIDIA EDK2 works around this issue by assuming #address-cells
is zero in this scenario, but that workaround is being removed and so
this update is needed or else NVIDIA EDK2 cannot successfully parse the
device tree and the board cannot boot.

Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT")
Signed-off-by: Brad Griffis <bgriffis@nvidia.com>
Cc: stable@vger.kernel.org
---

v2
* Add "Fixes" and CC stable
* Give further context about why the patch is needed

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


