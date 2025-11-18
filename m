Return-Path: <stable+bounces-195099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B459C69374
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 12:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2A5F4F0E4E
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E8D34E760;
	Tue, 18 Nov 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mCBFfJ7N"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92586286A7;
	Tue, 18 Nov 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466590; cv=fail; b=auC55emus4vUgv3FY1WnLzvOWX6/aHaZAWxFAAHxOdiNWYsHw65SJC9Siy8Q9M3aW4w0fQa3ghnknJaM4zPZO7BHzhaVbFC8IpE24cjQ3UddOBUxpQmnmnniAgWS7LiCJHoiBKoYBNcq91V74VQUbTHzDHtEeYcWMKiZYEclbag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466590; c=relaxed/simple;
	bh=QIO56CsUOF2vCp1AnTvx+dn+VT6XdEaVd5+7ERX6AyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqL6ugqlT+TRV8bQyI/hvj5KKdCtQHDap3626DHAhCnUX5mIxfzuDQWkLIoWMYTXoH/hR8wZg6ZzvUi8+cQpSbFW/vUdS0TqJBB9BZjYRdTq1uutMQQnHtiQo2bd3/NXHsYCxOZm2ue8j0dOtkHRpRVrgPC98Up9kuV6cKTyqMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mCBFfJ7N; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI6H0Nove/R6F/YilfcxH0jl9vVN+TUcOXcuDnFEr9HvWRH7amndmMHhDROD8MxNH6/eh/Ghc2ocncq6EIKfBBbkEtotoEcPieGNll8dL1vGavPsJmIT1xuz7ujrZJu9yG5nKQuMoBRfXbSXidu3sYyiwMXZ0V284X+BLVYDmgpiHE6dDkl4xcx9FQkQKFM1Q7Bz0yzQJidoVCDw9qKkKn2SOdSNbpcbn/5oStgy0n0kHR5jYvsF1fKABZMTdWEpjnyvagHx6iFGHe+8csECsH5JdZk1IfXSvLaG1Dw51qeQFQ4wWtbOhGrRHzxC8N9d4qN/9MXsPXEfPplCn9tEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNHAUdoyb9WR+gsh0epDtNv6KKNRHm5QwOpHgtoL3vA=;
 b=uMd4o+Mg2uhBnt2SaG6aonumj72a5nn5AbztUmYvJ/h8KVl4Kod2Jf4KI/62abWrV3aiYgIjEKNfKac0q+su9z/XYatjVcE94AYgISMV9PRtJOCCshFToI0GsmZxkW/8GIpkMkJjOvL3DnkurxfW7HZYdHY17Pit7XFcXva93cpcPkn+BpTV9Kj2MxJKrl58m7Y5RwlseXXtYqE+4pCnKIsRT0K2eoMDMin3uKZX1vXO4Og8e+T07Anv/byE/7eMlM4Bp5Xra2aFyEym4YFcCkgg5t8RhrIMq7pvFyFQqyW2RLDKT8wSII5Wt66rbNBYD6jwFOvrXScGzXDTIRVPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNHAUdoyb9WR+gsh0epDtNv6KKNRHm5QwOpHgtoL3vA=;
 b=mCBFfJ7N+XWxOw42yI64ZiF0M/haG7M6R5Mu2JhWy41ZTJUaXF/yxge+STwUmdgswc0YVNgS2Nu2fIeCaFqVKuR3pIyYsPdqSVjaJV500RBr6VXXFlniOOuowOfmHdH4/P1YgiGvdutqD3RB1XHTqUlYbbZxNUuLwjZOIvrSVoI=
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by PH3PPF7B51A0F8B.namprd10.prod.outlook.com (2603:10b6:518:1::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 11:49:44 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::11) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 11:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 11:49:43 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 05:49:40 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 05:49:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 05:49:40 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AIBnaFk003419;
	Tue, 18 Nov 2025 05:49:37 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <y-abhilashchandra@ti.com>,
	<u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e-sk: Fix pinmux for power regulator
Date: Tue, 18 Nov 2025 17:19:22 +0530
Message-ID: <20251118114954.1838514-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH3PPF7B51A0F8B:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e129ab-bdd0-4ba0-da17-08de26989078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+mVwYDkOKoG+b3tHVhBAbTjOknnhQ4M/PgsXoCTkXEQ7E2rHkh50vDuHlXc?=
 =?us-ascii?Q?wnI1w3x8idJ7caUqcsRz0H/BVPzPJfPvENCAUnm51xwz8dSQze5Or98951pO?=
 =?us-ascii?Q?W+6cqS16zXLk9pfVIkvIYuiHLnoIuD6BDxas5KCBjd1RcHTIoqTHmnbllE6A?=
 =?us-ascii?Q?QHy7ZX310fGGGfjNdI7y4+T6sjjxdzmQeaiimatUzOmxzM7q6+rBhqvr0x90?=
 =?us-ascii?Q?kHyNqpghYAtHyH8jxeLwE4Hjegaki20btK1yBT/qb/DCtBsG9EmGkVsp8+81?=
 =?us-ascii?Q?2duElZeOlg855t2iq3Un+9r3RYhNEck+3UGh803HK5U8udC+a4mDGQJY66/J?=
 =?us-ascii?Q?bZj/Zc34bLBCrpoLqQCyM4ZRi5QbCDhOi9KPzVObqOTCOLh7HEO9BNn2QZR3?=
 =?us-ascii?Q?JstLEsDf9fSrY67MRuxcDNigYSiC5dpUnKjL/WziQAjO3U3lmWNeX/R3S+g7?=
 =?us-ascii?Q?RCmbItny7l0Ln9dMzboOuB147GS0HAOk+c7U0oP8bSXW27jB3Dtg4DlbWMV+?=
 =?us-ascii?Q?haW3/iGIkKXytRcESSx6RztTmlU64bzCVUSE9oBaJyak4pdRYAT5T42wAlpX?=
 =?us-ascii?Q?DWVNwEFZ2mB4IhkyfF6v99XxuCUQZbKbTuAN0egQp2Tr93helk+stKXucMKi?=
 =?us-ascii?Q?vDLyu49+8V46UjSD2LBEOHJaGkVGvQ/9I2CNiaFocM8FvMAWF7TdpnyJfipf?=
 =?us-ascii?Q?Osv33k6sGKqV6RpSMhz6CakjwMF73StFzapiinq0z/b52aYbCSA8jozM2pQj?=
 =?us-ascii?Q?y0F24TzyTAgFT2Yuq3xgidqGI0CzjJjP0X+kqs+ywVVfehE/QPKiUr99+bSr?=
 =?us-ascii?Q?JbdHdufzGDUT6Ybhb3rhFzeHEtxqBcmbhEfkvVfQZz14yfdlLDT/nbR8p/N8?=
 =?us-ascii?Q?S8toFKsRLjesSnRtB2mfIIULuIxMw3VbSfb2rqLYSfFpNrS6Woi5v28Scumn?=
 =?us-ascii?Q?GvqxD50R2SLHa5X+mwR3Ucmc5lZTkOw8IFfZgjORbjvuu4DmHilOBVBo2vxj?=
 =?us-ascii?Q?BaQ9C4qgPj9+0OOgrKMaWNdlacwr1ibfkaG1iDNnSFuBxuga8UJvmgDKwJKE?=
 =?us-ascii?Q?C3PpqpaKOUVhrVC4eb3T58IjskYwL0JULmMhUP+URdGtQfaNMGUKrs/geO3D?=
 =?us-ascii?Q?YBPe5mIFbw4OO+eYT2nLpMFCu0ZMXSOsRZ8FRQF1YyDnMAkgXUKCdzK2lMyP?=
 =?us-ascii?Q?ZTgTrok0l6UZiodiuAyegIrhyCKFyEc+uZguvkdc135SIJzKTXx7qzBc193/?=
 =?us-ascii?Q?NrOC+N2TcaLoIZ/sAiNtv0NWuZ2GbsDexaDTJKCrCRZRPapXZQjaQlaGT773?=
 =?us-ascii?Q?g4cykm0E3QBReA1XAK8LUfIwwcPA/1cO5LOWKm3wPT8iONzfM/Xqwjf/Br5B?=
 =?us-ascii?Q?ss/N4vqPCEUPm3O9q++taYrJUhCjBhbWnUQBBwKmLPe1vYq0oV/cfAxFpsGE?=
 =?us-ascii?Q?qee1cQVmwkeIDl3qGSGhvmfmriuiMr3nB5xRyP+2eaxswz+C9JTvLJS0zVvc?=
 =?us-ascii?Q?tIArjglakr2sfaOvhH4dsxDQ/Zzwd+C7kWd5lx6GWh/xJT35K9DCy26ZSSS7?=
 =?us-ascii?Q?pyvO175RgEuaG4pDCdA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:49:43.3163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e129ab-bdd0-4ba0-da17-08de26989078
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7B51A0F8B

Commit under Fixes added support for power regulators on the J721E SK
board. However, while doing so, it incorrectly assigned a non-existent
pinmux within the WKUP Pinmux region (pinctrl@4301c000) instead of using
the MAIN Pinmux region (pinctrl@11c000). This leads to the following
silent failure:

    pinctrl-single 4301c000.pinctrl: mux offset out of range: 0x1dc (0x178)

The datasheet for the J721E SoC [0] specifies on page 142 that the
pinmux of interest which is Ball Y1 is PADCONFIG119 and the address
corresponding to it is 0x00011C1DC which belongs to the MAIN Pinmux
region.

Hence, fix this.

[0]: https://www.ti.com/lit/ds/symlink/tda4vm.pdf
Fixes: 97b67cc102dc ("arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
e7c375b18160 Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
of Mainline Linux.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 5e5784ef6f85..77dcc160eda3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -474,6 +474,12 @@ rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
 			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
 		>;
 	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -536,12 +542,6 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
-		>;
-	};
-
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
-- 
2.51.1


