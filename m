Return-Path: <stable+bounces-215958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAzFFJTQjWnw7QAAu9opvQ
	(envelope-from <stable+bounces-215958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:07:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590912DBA4
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2C81300D0EA
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82C35B15A;
	Thu, 12 Feb 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KAU/a6zE"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654BA11CAF;
	Thu, 12 Feb 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901647; cv=fail; b=O2CVgKvXHdpejYLKX8U3rPhj0MuKPsGpOur5o7SLwz3HCo8xs1ht9wvzCUJLYvT6+kBfO7hKf6FyrQXNd62PJ0hHeUhx8Y9b0Zj/B8kvVOA5bJHna74wiJbvXWi189cJsrE5zdtS5aqUAB9DhrNEV/QE1DX/XxiFrgOimgVrry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901647; c=relaxed/simple;
	bh=hHUogyhFWkGvPItZU80hwClMYohHxb9Y992MTcP9gnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+g5NHJjyQuG9VGThmw5H06Pr2Asj6/QVJrBNrxrjT2Lzr0Du49MXw8Iiwrpd48VZ9g/Lj+uAGQkzUj6Ol6Wly1/Do1F2ZvR4X5fmDMq0WCwVhwpL9y50f0PqfifKtxpc3WfgcG5PaObBfz44PVFB4bAlWDgx/F7MqnoanX+GAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KAU/a6zE; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fixqFJfWHONfgzUkdm7+UeEmlIJAPDyX19uEa+KZsXCmDpQHSspYLzSuw/gOpgLx+WlNP82B70Rl2dJ6BHB/Jseqkqsv1oYn9+eqR60ZQkg1cZHDyktbW0lfwXY3wrutgBHsjl3YrZe2Ip2cCX34wClk+/iU2HeJb2wfQQspRmzBlaNDgPHc/CYfeTOdJlNJwIE+bHAaFNA5+dvQRL/htieCoGaivSLhLvdAs3/TgNLQ2u10x5t1hWE699WGMLrTblCPYqDUIvUkxZgLADwLOJBbUH9fLJ38lTVyQpgOAsG0MyTXLPA0ZhKwqKjfvDApgDvAP+kb6rFZHntcRez3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXkF2WqplBMK/patOjYN9fQbVnhTWC1bXr/eBrDN1Qo=;
 b=EN/hb/aTBsDK3UOw3gkdPP3rVCRoKfb+SQ+PtjMcndxPs5UdexjWVJwXJMDlXw9Th3IzIGQwker8xVaLhn3IEmnWcuUxWYp8T9j5CpuAy81zOfyXnLDBUIOMotTILHpM+6mbrQSJImZEyfr69zGzLHB4uq9YzIWQ+0N5yznE48bJi4sVWTQZ3zRcdlF8SKMmlpxY1HQ3mUArEjD3TnU3ypQKux5uaQ6O6W2Feyba0MW7YAOAJhj4Uz1WU8EPPI/e7AG4NO6P9bDHPzb5GGIPo69g6DHZPGEu7HMfNxAoovKmqNQcX1tkhh/zQyVcltkDWuldd59H/DoJqeRmR9+10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXkF2WqplBMK/patOjYN9fQbVnhTWC1bXr/eBrDN1Qo=;
 b=KAU/a6zER9vUIeYWs8S40b+d4NY4lch7/71nhuCvFl7mYuezK/DQIya8TVYDIUeKmgDRGdjrYo50jkZ4YjOR816fCtey37WT039/Voa+l6r/UTDAxBBaLxvbxqR1nkfe13Ly4u3b1ngGJKpYW1su2tflxBiBb/G7aBAneyz2IsI=
Received: from BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 13:07:22 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::42) by BYAPR02CA0024.outlook.office365.com
 (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 13:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 13:07:21 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 07:07:21 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 07:07:21 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 07:07:21 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CD7HVE3538554;
	Thu, 12 Feb 2026 07:07:17 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jm@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: Fix pinmux for pin M19 used by sdhci1
Date: Thu, 12 Feb 2026 18:36:41 +0530
Message-ID: <20260212130843.1054100-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY8PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb7b784-b2d1-4fde-876e-08de6a37a8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+U6T/0o11PN5dDarsgBMeCYBB9ki864w/9xyP5tv5iNoJUDEa09AeJcLzZtC?=
 =?us-ascii?Q?PHSfE4SblkT9DC91udGEEp382MPtg2kNsNppb7aJzM1f1flsms6lhnWEIL0k?=
 =?us-ascii?Q?jlQsn6dUnXm1KQ0c64bvOoXFmLObPSs+0MvRxZmV6xhBZQ9d3LHErJ+obPFW?=
 =?us-ascii?Q?1sFHFS4mOSJqJy29o3BeapQAmZIYaWv52ixRoD/XNgms11TchrZmiZKnGkJ1?=
 =?us-ascii?Q?J42bFZG1pCNWNuRF2oaQnH6fFjkGgxNGIsdP2CAuVJ35d2thRfbbz1l5CHU4?=
 =?us-ascii?Q?/kFvhsSK4FtCuwOxQ/K6zmUz1VQa2Q/QJSSkpnyKfAY8tUTrRmbZfYTd43bK?=
 =?us-ascii?Q?aLxgDIA6PFA64G6dg6US7+oDQXv7OQRtefSzF9rPV0CEbVqNkzFP+eS3yvJ1?=
 =?us-ascii?Q?mfIfdbWKYQmQEh9QVVFIuiQv2ZAV26loCWEEFD2YPONqNF/SrbGSDKiKG6PP?=
 =?us-ascii?Q?nGcNlqOWR4CGW9WjACVEXbekR+FJ74qFcedQx/rda+dhelod5iPGgfVqAUug?=
 =?us-ascii?Q?McxruEpIbw1BnrPWPVzV0AkVtoNMwS7MvGO8GR1zdM0SAWb/+pXq40/IuenO?=
 =?us-ascii?Q?OwrjqffwDtbNYeoHYWI3dMWDenusnPXS8AtpPdrGyZIKAVlK6W/abWef3ZbR?=
 =?us-ascii?Q?dThN11/4jWMYSWS/yOeV8rY+RMuvAVz68kyVnkMDPmU/zDrPfvUycWBNTYv3?=
 =?us-ascii?Q?5EPJWXvEfIptlYDCW0oNYcB0ODXur4nuND501kWB6eKDVKdcjbKiLo3hKbBI?=
 =?us-ascii?Q?Lmh7i2LMcU4ftkxOw6rgHxY+RHusyKekdOUOgp6BpenKpUMPsNMmwWbQ7+jb?=
 =?us-ascii?Q?ZmBbRivFmaN9XWn5b7l0oKnTofiYc2QHDv2sS2BahBiBBN+oztJmadzx+/hy?=
 =?us-ascii?Q?2V5xLgpGgGp7YaW/g1gVT9+9I5Mn1G7iduRcGlP2l4+hc2c3GH34XD8f05pU?=
 =?us-ascii?Q?vgkmKazzBqFVn1X4+ZdjX2M5RmXrVlCM3UayHc95YitXaOjQ9RsIbw5T5+wN?=
 =?us-ascii?Q?wO5xJ7zBuFWCYey9xsny6vZWdIjhs0B/hh7ViWIrD8TSbq3DA1eAVJo6I4B3?=
 =?us-ascii?Q?I3RXchP+6BxM0mWm0HavMgVHBY42xxSERRKeBPZ8GPqfeBox+nqbAG7Fvsw7?=
 =?us-ascii?Q?bxnB2t1inzBQ+8WbHs7P/QwQbxKxjdAb3HrFnaybUxn+eSQosEvAkzYBW7qZ?=
 =?us-ascii?Q?GtGbGMDcrIRKiIAkC0Lf/DxhtkZJ+aCN3ThN/Mmzl/cXycI4oQDmFUoBtlX3?=
 =?us-ascii?Q?JmBWVSA2eKIk4DkyjBnXxr8TV1DKEMtq8B5rbRpTeEMP5KARmioBwmTiMnTx?=
 =?us-ascii?Q?KsFtYn18oe2LHX5v1qiNVzRXYLeT1ExY/BTY7vQs6RrQBoYjl1h+mE1VLfd+?=
 =?us-ascii?Q?IE6e6I+NvpJ1zjr75RH31sZ6MaFDRjLlLtKys6Sml32jncOZ3Np+MY04t4gO?=
 =?us-ascii?Q?N1nH2qD97lNi/BIGir0Nsr5DC5fkyZLxWh6vSYYqOlRPFV8E63RXCI71Jkxm?=
 =?us-ascii?Q?W6C4x650+bq+RDpFTq5kcvU1UM2Vszt3YyOeElIiYSL3y7mHD6lXwotQ2qqC?=
 =?us-ascii?Q?hDn45U9wNAeaaFjydbaLzgQfU4u7+yYCWQfwZo8Lsd5GXhnHqxjuikUGsNSb?=
 =?us-ascii?Q?LPJ3u7AZcFFoNIAWZQ17J9UjpxddB99n+DecalaW8HVt678sHjG/LGTJ4JKn?=
 =?us-ascii?Q?d/8syw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3QYTttDYOXeZm2SxBwdXT4DaSB47II2Q3mn/oPw0UaR0Xdv9AtDUyUFtHb1o3aUpcpjX1r6XpI80vnJIKkMYq8xV/aLi04LiyzShvZfDBGCuKvt/RmEqShb7GKSvvoLVBFzk9j61sYczadRTHF9KLimN6VzbInGfoiIRAiJk3+JkyqMnX3qDCoZDdrUExzTiu/fjKAKEfMs4/LzOx78exP9Tkbp3Ynhf0kQoPAIAxE3FFbahFZLForl2GVpaWFjv8B0C45uXn3Vkwmw72Cew/l7kkpYs9tYMCEASfazgejNDcjQeejREaSjA6JgUHrSTAWAhwX1eSJzdDhnY3/oMpwjI5Srw8TW5S99eBx95VTXqgJosMotwPym2dvy6OoUT1koG/n64a9bEA4FfXwfEj0gpV6F8KorIm7MdlXvUsocPT/30IiVksUUrvJU+lFRJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:07:21.8507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb7b784-b2d1-4fde-876e-08de6a37a8bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215958-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6590912DBA4
X-Rspamd-Action: no action

According to the datasheet for the AM62Ax SoC [0], pin M19 has the address
0x000F40A8. Therefore, the offset to be passed to the AM62AX_IOPAD macro is
0xa8 and not 0x07c. With the existing incorrect offset, the following error
is seen when Linux boots:
	fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready
with the SD Card being unusable and the boot process halting due to the root
filesystem in the SD Card being inaccessible.

Hence, fix it.

[0]: https://www.ti.com/lit/ds/symlink/am62a7.pdf

Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
of Mainline Linux.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index e99bdbc2e0cb..9cfe7e7b317b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
 
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
+			AM62AX_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
-- 
2.51.1


