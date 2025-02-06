Return-Path: <stable+bounces-114182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BAA2B551
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAFD18891B6
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 22:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0122FF35;
	Thu,  6 Feb 2025 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCg/YwhT"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D562123C380;
	Thu,  6 Feb 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881673; cv=fail; b=q+7PXmasKbGEDklUCZhQlvGpztAMgLNzSsmrajPf2t37Tt3OAQoO+dew7R0031f7BfB1+/QRx8/maIG+me5o1hnMJUXmm7B+ElI61Ug6oCuB2Z3RymKXc2kOxNcHrntnqE+0Ut5f2E33SMBqU9S1y7Qvj72XA02YGt4Upmt//iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881673; c=relaxed/simple;
	bh=yX7y2V2uukYOBW+jG1H1wzgRx2+YYp3N6CYaomSa2Iw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ol6smQ0FW6sxaTHSw0/scLZTZOAkOhVv9t+2+bEAsGtpL7bGOtjDS6eCoo4ZDOKvVAzkDa/YgqB4mJ738UQQNp2HNY2zOVo6moC3kONY7FT41pYK9p9lE2p1rIZIaQDQGLauXTQv1SGGupBXiVJD3gRiaR/Sq+gtsPYAWY3hLsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rCg/YwhT; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZDFWKrXz3C1/O4UQO1NvBC5bNLSTCSOIeiLhtuRJGPGnID+ey3MgrQ2j5A9nC7PI73lBEYzsIHKQ/RsnRhZ8SJd4xSma58Yg7jN506Ll7Y1lXZIdGVjwArGjSM+X5dqFKyDkuijzHILzS9jkOo/UZDoA0v/vGTncvnjq6i0/CM04iZQD+dFW5Ik06ywXcAoudHtKYBzC7bfjXtiVREOE9iz5kPbfWVzuJf/d4ceTCyPTFQWZsON1Wyh2YHUGHeke+JQoQC6l3//zAiTfhc8rc8qM4VE9h8NyxpRmVwEbEkq5R0iQSRS6kf3e1TEIJfkgf1V+h6dVogwPh2rTk/jtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1UZTBhTJcYQ/yaszOUWOtN/NL5tW5Jf7Q9g46+SmIc=;
 b=K96Yf2zT53lQj2WieSXRCYJLlOp5NFn19f3sT3w2Az67qgDCobtMTH2uflroW6qBxFpnH89O4iNUWWts7ZOWw+tWeDelAK9kjkj0N4DG+HrIKY6EWFDY03vH3LwUBa6EuEpNpNGmvOwLV8rqsuKYDclx2MFNAArudQRBprcHAMS7u74XSsHAsKCAsbbhiXJ7Sz6NmJ+k5Cv08nL9NHzUE2rJb46xTfN2OHgIyWT4vO6EvNvhkx8Po4LkwFWBtxph12vogEFcxP4qXIjL890NR6tfznD4ekw+7Dw/3vcD1rz+CFSRc8WLMBoJwDZSgnapC7nOFSHibI+gPU1mqWXcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UZTBhTJcYQ/yaszOUWOtN/NL5tW5Jf7Q9g46+SmIc=;
 b=rCg/YwhTzAwbEwI8W+CNKcjem0Vmqw67qXoMzu8Z5h1ofG/s63ZBE39grOZiWluhVx1QqqtG8Qx9OiIkbkEvY/YX4DlyVeYCIN1XPZr7ISP29iTZYz0ODBDdkt/GoJSj9p4OjEVqxzIUEo8SuMycdV3bRUrho0g7C09luLEOnQzS3/tn9iPv8XlENq9qCk7FkITevu41WGz8yNg+Td2M7WJhUY/4T4bcGrIMuAaCYpzXZn4e68atj3qFlmoAoM6D8yCl5NKdWiK9Nory5WXkM8OrkRtFfzFYO/pDtOc1Yq2aXDyTu6wvbXyesHUtsQG2f7Osu69401vcTyEWeb2hvQ==
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 22:41:06 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::27) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Thu,
 6 Feb 2025 22:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 22:41:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 14:40:46 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 14:40:46 -0800
Received: from build-yijuh-20230530T223047391.nvidia.com (10.127.8.10) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Thu, 6 Feb 2025 14:40:46 -0800
From: Ivy Huang <yijuh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Brad Griffis
	<bgriffis@nvidia.com>
CC: Ninad Malwade <nmalwade@nvidia.com>, <stable@vger.kernel.org>, Ivy Huang
	<yijuh@nvidia.com>
Subject: [PATCH] arm64: tegra: delete the Orin NX/Nano suspend key
Date: Thu, 6 Feb 2025 22:40:34 +0000
Message-ID: <20250206224034.3691397-1-yijuh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a10853c-4470-49f2-dca1-08dd46ff57f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yvDZluydYDFkfHcrhAvTuYsKM1GMXjhiZ/B4zqhQy+4w2I4+kcTmxIjkJS+?=
 =?us-ascii?Q?IjnSnHknog5JqJ/lPFxq7cs4bGYxEH4pqpvOLsHYMKKkBlQDd62NxHrTO8V/?=
 =?us-ascii?Q?ZSKaANbUk5UpE7af8KuXKSrMDDnHoynoxErBIA8WLlllykQUDRAF+AzLgvGx?=
 =?us-ascii?Q?m11BnUzYZbabYBgQCiR+9DhFCsAHuoI2FUK7lG7dBM/Frq8PfC1IakV92hiq?=
 =?us-ascii?Q?cegQYremj33ewmoRiDLsc1jVnDGfPbaMi4wmTy5WAuG8VrJ+hoqNcKfdjPPc?=
 =?us-ascii?Q?q2s5q6GsM/IaDlAA9mZdoM7zcNSY3UDP95xx2hYFGSqtfcr2+xPdPm9xbMW7?=
 =?us-ascii?Q?jXEjqhBJzaDLgR+Of1u9Bdqvx7aCmnMIGrfF0XJC/i1srqKMFGhJPwg0MAMA?=
 =?us-ascii?Q?slFMP0JGVS1BnNxaWDKRLi5WyGNypkjqCXNh8/GPEfMEZRwBiOHFCVEuuNJt?=
 =?us-ascii?Q?0A3lkuMmVBKU97iJCztB8FPjF0jz+QTNvIlnExmN59/drg4eRtChni6EOhUT?=
 =?us-ascii?Q?FCVgCs9zr404EwU4NUqOJ5ivrcIWMVTPfTBhKzyo7yCRI7CtJvuD7UzkNwz0?=
 =?us-ascii?Q?ppHKa5ya79dQXzvFJiWq0Pjq46MGqCDBSD+wAfO08yeLaSV778EjHMLzKdm2?=
 =?us-ascii?Q?j0fzmPvWdKkDAY8zcnqE7fwWt3CCS2LUbAkJqwex/l1TqqYbUEDm6R/LJvOR?=
 =?us-ascii?Q?TaVKN2WOWBa1ZnwgDN5PDbDdx1DQzV0xKOTRFKFk1AFsdLrgsAR6D0NCJMKl?=
 =?us-ascii?Q?E94ajQpUbNF6/hgk9I3/ukq7oC676Bfz3QJQ3WuKr514q1vm0fEMcXuoDWpX?=
 =?us-ascii?Q?ckpafGV9xV6Lrnis5EksEVSaWOTiqPHNkmffNk5lwOIdMaMnX2ew2f27PfBi?=
 =?us-ascii?Q?XJZDolHEcZtuDjImpxncKWDm5sFx3UgvvgWmUaXixIDEw/2Y0NShVEyp5j7M?=
 =?us-ascii?Q?NORDxTzTXSa0nuM+AOcWlRzZ19jKu3H1pPZ9q1uVeAIw1ecH9ylVBwBjI+KS?=
 =?us-ascii?Q?CoqR6OQH48qEdolzPT1yTwR8CE5Svhts4jKvyirk2RaRaQlq0bARoIH1NXsM?=
 =?us-ascii?Q?8Ar++NfCX7zA2t8Skp3o1yCnhrYr/L2fC9Vo7bpyT7ORcgsGxfRKvkCY3zW/?=
 =?us-ascii?Q?1BGuwCU9qOSZ8ltjMNKQ19DwsDQv1Q4f72P1y1tqDYOegnPoS1MCDY+P63sw?=
 =?us-ascii?Q?nwSadUBZ7TdTEjcyeB4jmTrr8ss8mG6kmvORICw6p3cqH2YdmeavaTzaXR1S?=
 =?us-ascii?Q?3CVeh+eMP/BIihJV3JodMAAilmx/qP/X0OWysp8GEswOtKk1A866JhMJGdAe?=
 =?us-ascii?Q?hWGgY3wiJYJJHm5KykE9zdPHgi8HNwJLDnqALU3vUED30uXd2B3L7wNyZGtX?=
 =?us-ascii?Q?FWnzhAnvO+PRuF+bn9CckSuCUZ30SLTBm1qqjCd5uwqwxgN4gezaNX0zst9k?=
 =?us-ascii?Q?iV7hgnc93qoZwUQ5fLYLkOK4Zzuwo+163I8lnV4iOl6Jk/M0Y/+8e0s8oSOf?=
 =?us-ascii?Q?njBq1XCELrH0gx8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:41:06.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a10853c-4470-49f2-dca1-08dd46ff57f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

From: Ninad Malwade <nmalwade@nvidia.com>

As per the Orin Nano Dev Kit schematic, GPIO_G.02 is not available
on this device family. It should not be used at all on Orin NX/Nano.
Having this unused pin mapped as the suspend key can lead to
unpredictable behavior for low power modes.

Orin NX/Nano uses GPIO_EE.04 as both a "power" button and a "suspend"
button.  However, we cannot have two gpio-keys mapped to the same
GPIO. Therefore delete the "suspend" key.

Cc: stable@vger.kernel.org
Fixes: e63472eda5ea ("arm64: tegra: Support Jetson Orin NX reference platform")
Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
index 19340d13f789..41821354bbda 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
@@ -227,13 +227,6 @@
 			wakeup-event-action = <EV_ACT_ASSERTED>;
 			wakeup-source;
 		};
-
-		key-suspend {
-			label = "Suspend";
-			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 2) GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_SLEEP>;
-		};
 	};
 
 	fan: pwm-fan {
-- 
2.17.1


