Return-Path: <stable+bounces-135134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F1A96DDA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF181188B9F8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD0281535;
	Tue, 22 Apr 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="kaas8Tku"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B728150D;
	Tue, 22 Apr 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330553; cv=fail; b=SwhEQLjzD4g25/fQbWoQKuscPYlu9SwL3NS0z7i3cyyjhv2cCVLby+05jvwElTGwRMSyhU2qzA3ioBpIq0v1Mbm1eGfXgnSSdETaxZQ4/cSGQ8x8s1ejfgxIHX90u4eXLtIu/H9SdRPPRwalPSPhm31xuZdKbRFSxj4OFXRhQFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330553; c=relaxed/simple;
	bh=m1EPvg0Rmr4tA2gDKnhy29t0GzhsovfVSuPtHqvJO+k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iaebaAAx5J5wIkTgXF/MtNnvY8nteWXe/J8rMbp2sbJS4ThbB6ffwslmdVZSoPm4CEveObFwCIj1DWTTbX5KbBRZwFGfR+h3pEY11IfzgvGK6xy1bJK7HxenrsIcaocB9fy6gqWjPVHxIf1oYH6XEoGyqlhGQA7ttUepU/ybM6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=kaas8Tku; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiioy/Ll/BshE6A2NrdvTgPmLoC8rtwhHIOinOcosYCdQbjuFtezlDfDSqKR+pe2N0wunvrU9PZ5JToUey3dKz9+KB0KBVR8N+7npf4XPxA77EyRGB4hr7qxc7LrBp6j9vH3Geu8syNLekOeB1Vuhrd4P9bRAdlButX2jAQgcZF8ni1HAore7nlDQKo1MgpxwQUPm8sXGioT8FsmBqKPPKmBn1cQWhGAfi2eXbQaGmV0a9+i4ya4EhW1RaX/WXSEW24bURmrytogT77tET51sXTXLHvQFA6pR3P9G641kE2GFdcPb9m9H+aOdEnNdSw/B1LGFvHA1Gl0s6NZ7AxVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsVTLtTcR8cr2HxJckI/1cGhfzkcXuvn/8nhq6HkZeY=;
 b=jC50ecT6g6/OBMAOU3FJUX3NlWT7tvnt3UM9ojpfuboEfoB4YQ1zZhl5eAeVnWnzlQpGh4t7hgsNJyZEOwvraGby68ZpvONeISVtkbYCTWVwxvvasznQSDpHCvgJU3bCw5b4f1OCLm66P3KNTUHwBg292lQ65tVOIUAvFeVU8+qea/vKr35M6EP3IIxDZIisx+Q+aRXHkN867jV2yoeAP3BRG0i7J4+UoU8o6iDSXYtiK084EtNF8J+uj7pMwZ5tkzWRd52NMj9iPrMsEE0ee8ATXeKNEt+vAz2DCagOIx2dAFU9CYiTXBVmejx1jrCCzWiqzspXKg7W9Ic5UTVKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsVTLtTcR8cr2HxJckI/1cGhfzkcXuvn/8nhq6HkZeY=;
 b=kaas8TkuuM36hjBmWT/J+3ByhdhceizgGctbDP/DkIfoTBRTnB/EMuct/asMyNKcKTpk/wIljW9jg+d/zZq90ekV8LJxH8oqWFaVyFgqbBR+LP3rdFTfeGifq8WXZtHpN3PbQ8eumCnmHEimvIkdGZ0sSmynJSeGWI8qVRSoIMIMqvLp6Zef3CUZfFiuQx0yHloO6mHi5mfgPKlNDAiGShud4C8zDOIw8/R96D6tIHPyhmpSML1lV1NaKLlreqjc8e+lSyiXEgMsh0BVz4ZUML07AVFMqx0wsYO/956uWLSDwhztNg+4qJAod47/RMgQ0xzb9FdCR8fqPxOn+DWDEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com (2603:10a6:5:6::24) by
 PA4PR03MB7086.eurprd03.prod.outlook.com (2603:10a6:102:e5::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 14:02:28 +0000
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068]) by DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068%4]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 14:02:27 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	stable@vger.kernel.org
Subject: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to usdhc2
Date: Tue, 22 Apr 2025 16:01:57 +0200
Message-ID: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0176.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::21) To DB7PR03MB3723.eurprd03.prod.outlook.com
 (2603:10a6:5:6::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB3723:EE_|PA4PR03MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: cfef268c-c3ad-4ff7-080a-08dd81a65073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvSPGPG1uNfTGZYnBal9I/1x2D7hMB+Vy7eGO7sOK8x/Rpmt3xLi9+qT894L?=
 =?us-ascii?Q?9izu7+G6aFaltzfbEDVgVObikpyDdEZGCsZf1rcvj5tZosbKvscsQWqW9qm6?=
 =?us-ascii?Q?tcrJFJVOWZ8mebva8q/MqFV3CuTeazN+oO+UM71iODst9zz+RVL2+L0Gv+GL?=
 =?us-ascii?Q?teAAplo8ILEgOKqNW5YNsnKgPQvrVkEQfxsbi0yl1YBxJTUq9joCnqwHafmT?=
 =?us-ascii?Q?ad1Rz2/eynD2xw5qPPacA+/NTWG7GSH3zz8kppmyIWuKUXirwTvjMubUwRCK?=
 =?us-ascii?Q?Ya5ovoYSJIblehya7B/XR88jOc75lKL5vW+IhohzC4aqELkPNYbB5sAf0giH?=
 =?us-ascii?Q?gYXns52JYpKQZLs1igaF7SiKgkbge7oQlom4qPgv26IydgqrnqAnfAkkIbaa?=
 =?us-ascii?Q?2nx0+NH0rMJtA09KoEN+oft9h5T3e2kIzCYCKGtBnjBSW7P3Lt7fXASO8/1K?=
 =?us-ascii?Q?SHO9FgIwHv9mLwFsjSCDQxdL/DNUv2YMKvnzlZfg/uhqUqUnbqwO99DO6RIk?=
 =?us-ascii?Q?BeMPVelrQzvP/owlGuiyM6U+0onSfIBcguP3Np9QDjAdxkA+ck6sSixcO+JI?=
 =?us-ascii?Q?wde6vbtgvL5qAaGfPfHeg7j1Sn3o94kNAUW5OBmKGORtKihAsquZaKnNlKAr?=
 =?us-ascii?Q?2LlGXPWvlTGwqIBa+6SrIrWJeIiGptvUkZz3Gl7Ar3gUv0kaSJofRcWGf09C?=
 =?us-ascii?Q?7vsSqvJhiCjVv2i53xapkeqzFLIABrTBI4XR3RiBw3xxufTWUjf81Y09nSjX?=
 =?us-ascii?Q?xTQkXUOSZDUMXNzOe0YNOnN5agLY7F87SrsfU6MR03lYp3+Xy1CQ1hCdbt1a?=
 =?us-ascii?Q?ZBLl4x/RguJzMpvGV9/ty/VzPbY3LiZ6YVmy5PSwE9/vpeezWI/ISPhFgDTW?=
 =?us-ascii?Q?QiNqH3Zd6XaYn/VX6sfk6B3yrGtCww7vWoOSYpTUMx2HZqJBF7e0+PawyhKL?=
 =?us-ascii?Q?h0ltp1fjyKkGsLdmul1G9iXXaopGsdhxvCjIFbnULXBy7ZNUAQeOpEKowlDC?=
 =?us-ascii?Q?bWAiBSMq02kh4NP9z50LdAAzVIgS7dgyN4bILLngRDgl3ZwELe2ZQ8dk8bYM?=
 =?us-ascii?Q?DLwYsxCs55nh/6l2b2flZlrBlBnL6OgUolBWudxUE7cfmJFz33Wu/mI9dIx1?=
 =?us-ascii?Q?JbPmSXscXi+azGQkNHMYVJHQwdVbFpYzNwAHD+fYCjwILBh1jCF3TfB0jvWm?=
 =?us-ascii?Q?b3K+nim0BlCGILLYx3KBRSJ4UItJS/1kDP1BTjlU0qrpaT2OL3D4RxHX9BqE?=
 =?us-ascii?Q?+rYUkmJWj1DRItGtYuo5J9/oamHi36Tfpn/fm+Kqp+OmYB/qHsHmyIolI9s0?=
 =?us-ascii?Q?LnG2LSpHt67YkI9wKNqkJhf1ZMLvVJAc0N6eJGz26HVUVg3tm3+vFXQaxZxb?=
 =?us-ascii?Q?pZCWg1DkZPdnRNiO5AOXcQauJ9/Py21gCz7nzhzP5WTTPZoBG3+bTEFffEWE?=
 =?us-ascii?Q?JqD9TDe+S5WWdyDXkq3UBKmIZ5zQksfZh9DHJZu1j0pE/lVzU7Biwq+jM4Qw?=
 =?us-ascii?Q?jaGCVMuA+cmDDP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB3723.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pLDwXiVeW0XrLRNvFneykE+Nj9vE49lRN+9seoDAk83rjoxGQRoWUIHh4Qt?=
 =?us-ascii?Q?Ti3zLDkHmY12T16DFELFvc2lZTxy5kys+JQc3NOnCUixfJ4M5oIRTXv8anlr?=
 =?us-ascii?Q?7EayQHBujfYqKUGMOyDNU0TjrsrNCryGJz1GdI34ReIPS1BuzFXoVnOt/VDY?=
 =?us-ascii?Q?NFRvC/JzqGITfmuPkXLTJPnxg13DifovZBvqOJr37IzSIZaR8E7zcbOqzCuO?=
 =?us-ascii?Q?yPrWAtepQPYPDVrvn9qW2imWV6I8OVpJo6Flack1HWz9J3XxRU9NmzChi+9U?=
 =?us-ascii?Q?+XUv7rL5rt3vN2cCF8aarkisRBE7Q5Pf0IFtR5ImPc1WrSuKzhlYjXDcGRAf?=
 =?us-ascii?Q?haQeeYPhW7WF5fSlL/dRntF7GvNVoeJ6AiUzvfo1ZnFw9L8X69cAS2mrSKcC?=
 =?us-ascii?Q?R7yfsI9km0sNdXCa7NPQJxOyCizaTborGyLocPc7l5YbQdJTqz2KcXu5GthJ?=
 =?us-ascii?Q?Qk3X+imm9s3FtChawjzYvZq+ZqL0ucsC31IAs2w/A+n1uw2Pk5i/XhPFYgG2?=
 =?us-ascii?Q?74DZcltMI8krkXqgPBnrOqLh4ieYWsOTfCr0RLoUFUgAIkr0pUF6UpwXUbVD?=
 =?us-ascii?Q?HC+XPirc+TAi4Q2aRyXh44uUHr5zraIHdmsp9FWuaYjnQ8b81cMrMuReaBXy?=
 =?us-ascii?Q?3R6beBrSqn7HpT89xGTPoeEFBsn+XZ9uRU81ncy9HghHquI3xnZMttMgbHLJ?=
 =?us-ascii?Q?x9zWO8w+AViyCwVnVCnyBMnm722xYe0W73bVXyjEtgq5jpWLTToAPmZj1N6W?=
 =?us-ascii?Q?7H9ukSVy/7s29Gf1WceNb96nkD6jtOZcDIlGJPHVqC52uWOwjtejjk6zL+Wu?=
 =?us-ascii?Q?TzQzWxZwrY+g6nrPXMO5Q44v9fQIhlvBJQo9oscDCJQLKY3kUvlE/qTH7h0Y?=
 =?us-ascii?Q?zoC3qDK9wBLG7+hoUZvrCr5ftgD8mLA0ZrsvGTGZS3fDwpVy93KOveAFwOIL?=
 =?us-ascii?Q?vfMAdqDj1/4Ptwdf+lrJHeO0DI9qjTqgYP2sbKraD3aN6GGjFg+hXd51fuXB?=
 =?us-ascii?Q?0nBpkVBwHYCoZtpZC7W82xw7iwvv8upTCw7k2KqUnpzx1ylmNCDmNCqt6XlK?=
 =?us-ascii?Q?SYjgaENl3Qqii3F5wRFWNzzaqDLdmk1SiWWDxO8SKjv5gv4FWTBpUDuZaQkf?=
 =?us-ascii?Q?9Ury//HnNfMSJ1Bo8GWfIFIh4hL+matSH4MplL+6FCMFrOgf976PHanEg1Gi?=
 =?us-ascii?Q?6usGMpR4n3vhZ+blaDUCtgv8fUZiXmZe6Nlo8x8SJVmjMTILF+bvE8ZwhA9S?=
 =?us-ascii?Q?G/O3Ke+FjU08YS0KSiq7oQ2x5w+LUhssG3H07J4IUy1FuAFG+f5G9AyMFjr8?=
 =?us-ascii?Q?o1quuENVcC9ujuKSYseK8rIJgOh8leehnUbUZmRLM2YTzGqLv7FgpwrJNCAh?=
 =?us-ascii?Q?knQentJb8qjfXGXe3z6NDYLmNRfjMoyfGgcDiNmh7TfH+iH/E9swc9LXThKo?=
 =?us-ascii?Q?417KPm+N4Mlkv19uZ7c0dGA56WDwO/GyMMQN7lz/JvhAuT6A0Gm/siKLfv/1?=
 =?us-ascii?Q?oBy9atelFrN+12G5dChhV6DADaO8Buagm86DsGEGH/KmoukG0/q4E3UEc+ml?=
 =?us-ascii?Q?ukMcP6RDd377TSm5yDzV/L/QCBeZtD4yVk+itjbx?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfef268c-c3ad-4ff7-080a-08dd81a65073
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB3723.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:02:27.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEg1SkNRtKRbJGd1QcFNJ5saoeZYRBh8X4eFQ+rnLdXjEK/haIEGnSP1++wtEC6duOQHch/1aEXgoQev4Sm2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7086

Define vqmmc regulator-gpio for usdhc2 with vin-supply
coming from LDO5.

Without this definition LDO5 will be powered down, disabling
SD card after bootup. This has been introduced in commit
f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").

Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")

Cc: stable@vger.kernel.org
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
 - define gpio regulator for LDO5 vin controlled by vselect signal
v2 -> v3: https://lore.kernel.org/all/20250422130127.GA238494@francesco-nb/
 - specify vselect as gpio
---
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 7251ad3a0017..b46566f3ce20 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -144,6 +144,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		startup-delay-us = <20000>;
 	};
 
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
+		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		regulator-name = "PMIC_USDHC_VSELECT";
+		vin-supply = <&reg_nvcc_sd>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -269,7 +282,7 @@ &gpio1 {
 			  "SODIMM_19",
 			  "",
 			  "",
-			  "",
+			  "PMIC_USDHC_VSELECT",
 			  "",
 			  "",
 			  "",
@@ -785,6 +798,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
 };
 
 &wdog1 {
@@ -1206,13 +1220,17 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
 	};
 
+	pinctrl_usdhc2_vsel: usdhc2vselgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x10>; /* PMIC_USDHC_VSELECT */
+	};
+
 	/*
 	 * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
 	 * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
 	 */
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x90>,	/* SODIMM 78 */
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x90>,	/* SODIMM 74 */
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x90>,	/* SODIMM 80 */
@@ -1223,7 +1241,6 @@ pinctrl_usdhc2: usdhc2grp {
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x94>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x94>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x94>,
@@ -1234,7 +1251,6 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x96>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x96>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x96>,
@@ -1246,7 +1262,6 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 	/* Avoid backfeeding with removed card power */
 	pinctrl_usdhc2_sleep: usdhc2slpgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x0>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x0>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x0>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0>,
-- 
2.47.2


