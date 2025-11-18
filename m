Return-Path: <stable+bounces-195053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7ABC67BA9
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 07:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57B4B4E0369
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 06:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF262E7180;
	Tue, 18 Nov 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrDSvlZo"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617662E6CCD;
	Tue, 18 Nov 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447364; cv=fail; b=kDBAY7vGQ5Oxm+g9WH06Qlod4zh4FY9XEir/hu+T/iAAUDYusJRaxXTB7KKF7nlTuS0dHxWOdVIotV2VvhvTS2j0r5dVUhu33KOAdid6+s4yR9HEQGuvZswgNZmj/rIbbPu9yBb9Wenij6a6JBUM71CAIC7V4IRBXjkRi2kWbyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447364; c=relaxed/simple;
	bh=9C8tgq6U1UReitK8q7m4AF6rhW5uHSjXXrw7A7gFViE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JQpbpGampJNHB3kRfagUTd8YA4TJItbtnKaoIXD0V8wsrTzdxI/Htpq8xk4A6xrQWBGHkf4AZuODy1v6gRxcE81PItmUFPbHTBHv5PNrTzaQJvFD/KIIuWzdzoEzYMJqvE/mjaudLZEb+c2HO6PEVz6WhLvlmpAMyn3/vz+vot8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrDSvlZo; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqm2Emh3SyKrODMwbDnww6TonQGoSXk3I6baAu/+HOvk1xAByIIB0SApo5k0cNWTi/or8PcGnENCWKagbZn/8yQ2GmEb/kD5ZfF1atpRSgYlpJr80/ka85sSPhvvYPmjzzjWpTms/4p+8hp2FO6XGQkUzFG0rUcqs8YGU6Vsr9+sivj0cBZK6J+A8dQJ+LenleL3qYo1CMXv75W6Z0fHDrPJf5HjgVmkt6x6qf6d7TBI44GejUANLEvrpoPZt6xHbTCtUzhj7bM8VXDquFlKJJB6hdwv0LwCnCR+KxRXYwYEOxi+ZSYKjOy8VNnoor67fKBuGPSltieHEqv1a2I3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90/TRIcCiu9HOj0QgEaj1E3NX9f9oVYz8pIdRi2Lv7k=;
 b=YVJU78YlUSyf6pPMSvlP5RelnUiAXha1cgMjLd55hfKbHTfCXY4WY2d5OU12JU4qi/BPwGd6k4mrbMlhwC9Jaou8jReH3FleyINx8AFZI8uhR3txPNai86+KJtV6xGpxn15NPsPRvXDRwPPRANsVQ4JARJBNDmE/ZD/v1uea2VGNCvmgSsGyTl0wXe26xwRpK7qKMcq/R3+3VFkXeEfUYZcu1GqyVgiJoLT9xZK8bESoPrSIhHrSFME+ftqua6izCgO77/6JjajecT323Xr4/PSp/D5azBxJD73ciiNZY89R/iaB9rAoAhycsWH2D2V+uSFN+3nLyEjPBWq5155taA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90/TRIcCiu9HOj0QgEaj1E3NX9f9oVYz8pIdRi2Lv7k=;
 b=ZrDSvlZoFxecAviz3sz71prGQQs5V4xOm2ervzrCWP98p4zmoJn7Jt3cZ4DhcGv4gKxoUzQGvQL5THBfqHg31XFvvysS5rFG5v6f71OKt5tBnd8TDivuThbYyYBR6oMGFt3kx/KaZDyO83ExGb5wI5DV5+AG2R9AMgHSeiVIN53iGGp3K9NRv9/HWIlA7Ne4eOEGIR6Jn3aqsZ/3GsMN1xSp7tx0GvXNiatlsqu2AKoGC+BrI0JdsLZd5Lf2WaW2/KprUL+IYscHpw1jKodV4evz3c18ychVgeGxnneuiQHkeB4XDUhnJxplngVafzPrKEf4IlyL3emXOMrlhoWufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AM8PR04MB7921.eurprd04.prod.outlook.com
 (2603:10a6:20b:247::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 06:29:18 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 06:29:18 +0000
From: Carlos Song <carlos.song@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com,
	Frank.Li@nxp.com,
	daniel.baluta@nxp.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: imx95: correct I3C2 pclk to IMX95_CLK_BUSWAKEUP
Date: Tue, 18 Nov 2025 14:28:54 +0800
Message-Id: <20251118062855.1417564-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8beadcbf-3d42-42f8-9339-08de266bcd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7klSvzAgH3w5dKfCi+ONwOy4jf3d4nhXrSWwoqzpQtL6h5WQLsWBNly1Vl5M?=
 =?us-ascii?Q?nitb0W8Q9/+RZknPmyA2aanaxVtUiiBaRrWKvAcUo0Wx6em+Ow9Bb3njScfT?=
 =?us-ascii?Q?aMQIzZ7T3bKHorOzF37ZIfVFsr2dbwhuyIISN8zPGiTPhP6MqhPauAOK9Ol/?=
 =?us-ascii?Q?fiZ7SYPpjd78S6UEshJnrlWQepVQJSrLbIOs4ZZlfaUt7WD0UuBcQaQM/27h?=
 =?us-ascii?Q?169TmBEMM50LtfxuEeiKih6ECWoiFN8DDyGA+ksMwS0eJCIB8CP55LU9nNTb?=
 =?us-ascii?Q?F2JwQT2+JgBZkBc4Ho3qkBxGVyuH3nOvULg7DAry8vECWKJAuQ4tVErRHXiH?=
 =?us-ascii?Q?kfXMk9J8UkU2CUZ5taoLO4FJuowm8LW8KprVvGVXC4MvlEpOc3elAPG2m+WM?=
 =?us-ascii?Q?KzBwfVTvhLBgTervE1Yoq1DKxqTki4zZUkKEdS0zLb8kGcHjIeyF+HXSRvuZ?=
 =?us-ascii?Q?gJAQ1Sm8tGKhlZ9YVEEU1sgSEd29yuAUyXGJpnGr1z6eeCPqD4JZZSZi07B9?=
 =?us-ascii?Q?LFmht6ldXL4cXrv4X8U+UVJIsaexNLpyioPPyuGqt0RnOJPyznqJ2hgGCnfg?=
 =?us-ascii?Q?LHL68ZE7S8c9Sng72ndYsdsRL4xHjMlb12go2qaDvNiKOg3ZBsZtg1bocMCS?=
 =?us-ascii?Q?Dpj70O5tMTw3ZD8/TfDHz64HNLi50+/KkJ52niZ0igJLyco8J60vgr4+y9Ds?=
 =?us-ascii?Q?ojMk2OyFt2+OcxXMuJDMnvxEMhOfCaQmwRq4uLTvxcnHJFDbmaMUwJarx6d+?=
 =?us-ascii?Q?3diRioSPsiurmMCLZS1HVy4gYuMTEERYGs0CPnUM111K24m68L39P45mSnpc?=
 =?us-ascii?Q?X6n2n3Pv6WwzhH8qCx0Ka7KkzjapN0FKtDltsDunOZPhvpNSB71irE0ZahWb?=
 =?us-ascii?Q?shbKPxQYglEJbgHFVvTqoVPW6nce1XUboPmWauClpFAuaifIw8ovV0a8mtwq?=
 =?us-ascii?Q?PrcPgjiVCFIX4m+AAxnGgm6i0aKzb5FGrp4LgSXhvV+p92Fe0hHCViefuBDr?=
 =?us-ascii?Q?7HTnGsh3SmuAjlOyUcj8BEWzY+OgM5PtIBP5adFcUVHxrrXfgdypavn1HWPW?=
 =?us-ascii?Q?6lfGK6m5JoZin4BokDDN69Eznu3Z73a7kHyRGJDAxC3X/FbV4hVcJnwy+rNm?=
 =?us-ascii?Q?Genne4MWso1Sz/zd1SfrgGKh2tTP8YnleElJCnJIqofl5XZplqA432VGznBi?=
 =?us-ascii?Q?H3MshT86y2r18dkFMkJw4ZdPnvLtbliuyml0S7ECSMTdrISS43oG1NknjgcN?=
 =?us-ascii?Q?tiXgoqU009Hre0JA77MfV3ewbyRr4uk51AZ64yBCmTBUhcwyr2zsxTYOGhbE?=
 =?us-ascii?Q?mF7PRVNpcMilwVIjD0jtmng0GSSvJFhSp1PfT75DT7edwQNYxaHLgq1GtBoR?=
 =?us-ascii?Q?GDcjX+selSybuboebVb9huxHj83gj0JEp02IldbDhH/bP9+4Xt1mfxWYnw+q?=
 =?us-ascii?Q?4JprNgDjielPtrOTQOf6WY0qRrYxmPC6APS5CO59w0gOQn74hMKAos6AL1MT?=
 =?us-ascii?Q?z8kO7IeXDuqVTVlZthASCR/JpPzI8L4FXsX/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6HxygsRYnZSBA18WbClmxwr6sm1WGuQMRPAzO3XF0BWu1PcW5o56TMt7hdL7?=
 =?us-ascii?Q?lJRKxuHn2D6yecYugVjaHr0CCxuBL4KcAC8lI9nmZa5sFj7oV2v665opdM25?=
 =?us-ascii?Q?nwoe5U0s5XoIf7+rZHnsZsmAn9P+krcwMiTZdWxrD7WOEchS+s5tGGntM3cW?=
 =?us-ascii?Q?TRa3piQqVKxE1B+BvOG/pcMKNz6pgl9txeXEPQWohH/VQ0XUQQngVXrIk5hf?=
 =?us-ascii?Q?oF36+JZhErrXOZm0LbWbwcGlXibv0PvAtxKrw7IDMvLKMGRA0/1SpWzxuo+M?=
 =?us-ascii?Q?Z0cVJJfEfsYZR+FJFo92RwZW6a0vjdX+jxL1A/Kktr1z2uKbLhPiwPyOrUvD?=
 =?us-ascii?Q?dYZHhFW3BDT22zFT+QOr6KW5yza44Rz7/GptQY8i/yXHn6jkOt4sup36An6J?=
 =?us-ascii?Q?v1Hsre2IHCku9RPsi+wBeo+rnEB3pIp9zrID9EiJsxs+VuGhQ/PsOKjtCiV1?=
 =?us-ascii?Q?up6B5onJB9hZQfaoEssj3GqgFBAQp3qrmuq4SXs49ABiKVm1Kw+36z7dnkD9?=
 =?us-ascii?Q?mzw3a/jZ5eFKXZkNQKRdZhgLsX85kliIfRit6BFSCDXx25lK4wNmpYZ5H4AD?=
 =?us-ascii?Q?IC42dfUpk8OlOEpK3Pkklyr7A1uj0qPIc68W84frI0DEE0CnsmYUuTsS1a59?=
 =?us-ascii?Q?LejCBJEQ8xkHV32wuGPnYbOP9PUXjPqfAlA89tDdQDCKcJgizvLRdCeWpyrm?=
 =?us-ascii?Q?BPmp3LRzgAGlF/QrR3idFrbYz6LuG692ryV1r+5+tm9WXyFcUcI2/VglEchP?=
 =?us-ascii?Q?9Xeh8HnSBElMpq/8DgehmVQXqq3oB8VN1rz/r4o9YU1ksNbQqd76CQGkhJZC?=
 =?us-ascii?Q?j7+VnGRItjqEjP95Ka/eZwg7RqTBWNnVKyNjS+WCTN07f3uJSWNp6f7axvNz?=
 =?us-ascii?Q?LuvPl78aBaDRLNj3yXrSLSlHz6Gk9G47oYWAsha2vTHFJiCcFplZ9nwiQRa1?=
 =?us-ascii?Q?9N/HnwIyIyhrQkpgdzMPExUzr+p6k7ZPzXngat8vV8yrQkl/KUw+N6jymJOS?=
 =?us-ascii?Q?fNJrHHiXk3KTkeaIgvd2ixHqj3Fd0lMVUm4IYD1B3gaeVlo/eHutqow6xKG6?=
 =?us-ascii?Q?7oA7dg/aQBzKhVMGIDJs6EGcmkfYKyVTJiFZc6dfyyFdR3lCWhDkgDv53OJy?=
 =?us-ascii?Q?tUU8/yP72+C7MdHls2oyUDFu73HRuOP+k3Cz1cW9gD7U6TmvlFbFhwIoeGVY?=
 =?us-ascii?Q?WJpulfxPtEh6PI83lsJZsctW7nTTY9e6nvaBiRawHauhuBqATeYnkfrkp5Yq?=
 =?us-ascii?Q?seJEzbiGEXktW6297VAnNF5yoQRv4VuZCLGHDHZbrvtY89kO4L7D3vKBtQtZ?=
 =?us-ascii?Q?qRAhDNvXCTFPoqKAA2kDhHmEOY3Nu7bmliz6dPUTbLhAcHUsfJGymRsFQd7Q?=
 =?us-ascii?Q?JXXExGWzWt3wfOcj6neoOo74eMAEWXTyk2eVCdKWN060iZmivuDk3pfI9Zow?=
 =?us-ascii?Q?eToYQo6Q6J+q5aLQzUTaHxllye0vUc8j7pclma0dBbsDmZPZ1cGJNS7pOT4J?=
 =?us-ascii?Q?dP9xw4jZzqkzdv2R+JB1RchMAzAPfk8FQM3VIHzoHPBPBr7+4A5OAEkaRqEd?=
 =?us-ascii?Q?X/ydSjAtW4mMrPxcFbGEsQoRQNMUSupkp+ENgco2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beadcbf-3d42-42f8-9339-08de266bcd20
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 06:29:18.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6ok7EOYcbRLpdVQCHTvdghOkNoDygwmAMnzQMZXijfM8OnnWPzGi96VTLgGte4LMHhMp99IKD3MpkMTysDJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

I3C2 is in WAKEUP domain. Its pclk should be IMX95_CLK_BUSWAKEUP.

Fixes: 969497ebefcf ("arm64: dts: imx95: Add i3c1 and i3c2")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index e45014d50abe..a4d854817559 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -828,7 +828,7 @@ i3c2: i3c@42520000 {
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <3>;
 				#size-cells = <0>;
-				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
 					 <&scmi_clk IMX95_CLK_I3C2SLOW>;
 				clock-names = "pclk", "fast_clk";
 				status = "disabled";
-- 
2.34.1


