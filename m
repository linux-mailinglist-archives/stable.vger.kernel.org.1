Return-Path: <stable+bounces-135119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A0A96ABF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A48164413
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1C27CB36;
	Tue, 22 Apr 2025 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="EWejvqhk"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F420B80E;
	Tue, 22 Apr 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326006; cv=fail; b=sgimyOwNxkIkZTGrkwsaMYSN0lqdRJ8FGD8J6TlFAMyKCS3NDPMZGgsE9AuczCsn6Le7cykjeifTQQynib6usgRtOoRxAV7/F9UCCtb54aq6Vz0kkqx70bblrgP94RF623FCAxKTfi5nfpo5MAor59S5AZF9RSfRiBZMZRrCF1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326006; c=relaxed/simple;
	bh=5ZHBFQWoFrW61jZQfCfF0s0UcEC4juDKti0jWlwEB1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PBkhU8drGj31icwQh69E/P/s5LXxS3Q7HLB1Z4Z6sRQ023DIAsqkGkxfkD5s3tzN9yz9gz+Z5fi0W0QLCWOnYR+COCAYwBB7m/OWGKojXB9RK0Odly/FC1GkeUyeXVxqJDqYk6IxNimil6c1EVd6kynqIC8iyRO+orGR2ij68C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=EWejvqhk; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAwMBOqjeA7h1m0ddrxXAVTt/NnU90Xmp5FDI0L9LQn3fVjAYfIqSSlQlS1Kfgj1iLEeZOcuAvqJOtt8svndxKlp+oYU0RCJNxJfW4XkP0gGjrKbHirw2roUkgbek+twRaZhWFHgPe65cR/b7LR54nVbPvm5TcU2LSQEVlQPxvnAE6kT1HA2gppRt/qo4c6OKiQPXmqEMSJiEc4fsJVW8TlV7oxIMgXwisUnj0+RPi55QYTDmXmTUX4TWM/tgmV5c2TCT0xPrl+qy8ri0re2/NE1gblY2vVC5Xdw6yk5l6ODPvj+T6qTT0hnX04Z6DlHbadAwJThqFN1e5Sf+FX62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OESczEWyRg3nQJ4q115jWIpffP9PsNM3FPPXtUS8LDs=;
 b=d0yjbQxxQnYq7wGZb26DonGTxjXEx9zqIr4LR/KatiBdTABPeOtJoap6kaehU0MFK0fUIOq2xr+pEJz+YdoJcUGx3r61t2t88Lrzz5m4HAfzun/C5cTx6s6J5YKsgFKiRXf+cTfcogEb5Akfdem79CiG2sviOBbyx2r/6j8nNOnyrMttQZocvqAWw38xL3V+ywbBPI4824MbQwXSHmFUr25qE07Lva/7lCgNO4MwZkWNV9YL/Zd7mAHXPRxkB/Rb58xJTTWdc0bcT8FF3NT/pDRS+nHiyNnC44Po0iofFn+8+A5ZUg3vidbNtY0wlmhJrB/iSnwBiWlNh/L/2QUPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OESczEWyRg3nQJ4q115jWIpffP9PsNM3FPPXtUS8LDs=;
 b=EWejvqhkznLBvDlGfYE9M5nqgwefzQNE+AQTfWfEJonEmZNKm4NOCkT+K0a/QkEK7yv3HlIUtzmKijfvYXiuENyW7+9GlZxQACoXVtS/Hwxopiub77gKqsLDAkEs4Yi0HRClEBjDvyakm4S4/Bt3dl41mNEam4jCDaO2DtaSJ3QnIkXuV4mtTXvvwryi0dr011ubeTRIZDt1MZEAuWjG0+Iq8jMDrvKOzjTsYfEuSmq9eZEa5+q6M1WQhQFOCGVo/yKzKYHVtls1+iWisWSPu8wytZoRGX87G2FSjwf9IoeHyYSbBwmrMlTdkLa96AX2kqYJLEskehiOhBXoMb0iPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com (2603:10a6:5:6::24) by
 AS8PR03MB6869.eurprd03.prod.outlook.com (2603:10a6:20b:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 12:46:40 +0000
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068]) by DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068%4]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 12:46:40 +0000
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
Subject: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to usdhc2
Date: Tue, 22 Apr 2025 14:46:15 +0200
Message-ID: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To DB7PR03MB3723.eurprd03.prod.outlook.com
 (2603:10a6:5:6::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB3723:EE_|AS8PR03MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 3286cfc2-fbd9-4240-0314-08dd819bba1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B4fW4arMcI93A2wIvCeWn6JUci4Rg3T8XzVK9tjAvxaQbPO+wYGB8nZXuqKn?=
 =?us-ascii?Q?pnbwX0HMYHnCvJ+PhqTeF5nVJApmU87+CwH0ymD/nruQ0l+IkdVBkgpnjmQP?=
 =?us-ascii?Q?HV5Gh7VEL9/CK5urKwvO4tcZX+JBDTYjB/4AIZonN2dC6k8kDR3hG256UXWb?=
 =?us-ascii?Q?M2u7DY+DPEwMi4vLTv4RvdrW070B9A4GH0S79fVAdFk0An+7v/Tr7OrM5yDV?=
 =?us-ascii?Q?Zpc9X+Lx+iqiYJrM6AEQFl1CvyqkB6GonMlzUXtZOyuwR8LMDtbnupOE7fat?=
 =?us-ascii?Q?LVyyXMkLfJbplHhzB/mJRSBwX4xO8P5fZXs/TW4W+hE0RNiRL5E0qim2HQtw?=
 =?us-ascii?Q?vW0Mr7GwCdGMJL2NPmxhBhO4L3j7s0prjKzWDYtCvOqC4PGHtg1n6UKovbDW?=
 =?us-ascii?Q?nok7lTeOsZnqltfZZd+iOsh1fPnVAbhFcIrpQiJZWhGa6xzXNETiJKxg2jkX?=
 =?us-ascii?Q?D4UOsRcpk4G1uXvTmqYX6cSbYn6/7QwlgmwrFWIssUhy8Bs0KxfRTf8t0z9c?=
 =?us-ascii?Q?GodkBYRbAYgeu9ZpuSIBzMwY0OtV2yaUeUxqlt/wpgcJ7tGu3Jvg48S9Vi0S?=
 =?us-ascii?Q?XalCsCIOWjcMdpR0LYJ5mmX7jh65VPoekhLqrdsjOttZzwUfRoBd2WQzdtlc?=
 =?us-ascii?Q?EMVADyM/JgcsqHJGtLH8/q7bSkjPv7/YE6s7dplI9Eah2nV9bWW5tzO6VGY5?=
 =?us-ascii?Q?i3p2DATnk9VZ/4nrRbIREUWtln4TIfmvRuO9MChkU6KSg5U/CuUnBSPSin22?=
 =?us-ascii?Q?Ungn6HW5C8Ivh9LWsqn8ZIt9YTGfv5lHUSVcUAepL7UNG5QYrD0EMDABytfK?=
 =?us-ascii?Q?RDX5cFD5wfJdtv2/QoB+qE4Afwv0BeJ389SkSFdoF3GcyTUku5bTuoPTSPH7?=
 =?us-ascii?Q?dnlbUJZjN9fdYwp0B1WkPUSSCyvxCprfF2QvjTElH5iQwMDtR1P3JxQBF4lk?=
 =?us-ascii?Q?xBjUbX+eS0t4qNy419wzIIfK+AA5EAIVh88LK0V/qnkrdeoVBg4VmIMcLwpm?=
 =?us-ascii?Q?Lp1ex88wxGBzDkRPKF5opkJKRDVY6BfNoe3Qvrmc7Hr1h6dzCPvH/msJBFY1?=
 =?us-ascii?Q?iTPHG1F6KLfZ/oftY443wCkE5+55IiexW7vkfT+Nhjizza2DndQujUOPk8d2?=
 =?us-ascii?Q?gwbgxjIbPZ/dQZYERreAZkNH5zFx9f+eMGmED5wXrFvCijTIgjK0bU70X41i?=
 =?us-ascii?Q?1EA1qV43PaWMYTmgQm2JBxHJMTc1ZM1BXgeHgHOvTjJJPsZp2MgL4bbuMCLs?=
 =?us-ascii?Q?Ms9dtU7+N6/5NHN/+HiUjvg4nV6fITvSsj5zORab1JkL6fOTOHLX46pRF7Fn?=
 =?us-ascii?Q?NdF6Sgp8Rtxa+Zj56k4Eh7NYE524EcP7voSyYLlkGfUCKc4nooNsIVYtET45?=
 =?us-ascii?Q?Ee2ch8aKoQDNMPWUtPCrXTXaHVxjG0r+vID2AsAAJ8ceXgjPZuWnw300vUEG?=
 =?us-ascii?Q?3ZSqBsnliAwRVPbkUPedAzx7c99Zqjm2rZTBrnGcW6LugbzTFl80x8tGHmQL?=
 =?us-ascii?Q?DZxY0J9u2FDvYB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB3723.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXOjt3cypIv9BsfDWei1iqc5v8g8SkRocFKppAoe8iA4ak42u2U6T+9cwGJy?=
 =?us-ascii?Q?EQjviS/3Jd+QOk76gZF1YkBxqhmjdxGfOEjBsVtS5U3OsW8Kz0k6XZkZwRlL?=
 =?us-ascii?Q?D0xD3EcTLO5nHjtkt4+rcXn6i3qKRWEj3nXjdaGEaFlKylmkBoPECCXJZ3cM?=
 =?us-ascii?Q?v3HREKhkOSvBk6LxIsvR0yos2qzGjj6OPxRDIklLV/b/pbZOxPc5IZ02xYG5?=
 =?us-ascii?Q?T1oRT1txXaluzfiAl4+ZuA9Pzvpge+WELI2ooPl/ynbAizTiwsuBPEgXvKOj?=
 =?us-ascii?Q?wRkWR5WZQf4WDcrbwhZfAZ9RFDbb3vYX9uw5G+3LGepW6wJvGZz0vJiHNlZv?=
 =?us-ascii?Q?aIkQPc7eSSJ09jco1mykvmnh238jF+CbH73sZpE5/lZVBfqwJaHWFyy3eDiX?=
 =?us-ascii?Q?EiujjgqrQFFo5qKmymrvqSsnxopCBCOF3q+ymyQz8oxZ9krRLDcIwcu0OrYH?=
 =?us-ascii?Q?P7Iuq4QL71opSuS+oyGWayVI3J+9ui6JIWhV+t7gd+Ukfe90ABcXe80t0kin?=
 =?us-ascii?Q?3AsOSrxNksKkD9UDM3GKm++gJ8yP7vxt/4h918OBxmcbvpEl4AlefgTmE+/M?=
 =?us-ascii?Q?yA49p9pF/mCFbjJVZWu+dtDV02dRH4kM7K2Rl5EYK2wNc4P6ltj4HigCgphO?=
 =?us-ascii?Q?uKxTcZaMH6J+kdEF8fJNWW4dRqMylpYox5sWeG6tUkvAT6b+hGSyb+3wOnhP?=
 =?us-ascii?Q?xo5HSdkvGQU7S287/O7IOxgWOpol3dVdR7WF16BQZt/Q2WX5oP1g+1NJHI7f?=
 =?us-ascii?Q?8zup2C2Dh2PsUij3uxvZ+xZhP/SA1CdZjTj5ZNU1QyJv0ZbdMFQlyKuy3m8z?=
 =?us-ascii?Q?xTqgV7Mz7TGuKPWUhHiFt/L1XUqc6BKpTZjw61VpAkFFRPqxCkfmSRL9Amu6?=
 =?us-ascii?Q?G/QN6uDHNmcCc1XR0q/3Ha+crs+nCJNmir8JfMFWNAdHjWS3Nz7vq6PDrRgL?=
 =?us-ascii?Q?0o2G2FUT81RgYDs616XV3QLcVmIsgzINHGVCgGE67zcxI9ZIJXGyhhHoB5Im?=
 =?us-ascii?Q?Ce8HW9FH5qy1n1eGdHkBUjogvA1667UVFzCAyy1nWcSMQ0A/GBZ88oGbDkij?=
 =?us-ascii?Q?23HZuRfN2twnltRgGp1/vBUYDK3wrCrAvve639NA6Je6h1v28xpE9WrYUNKq?=
 =?us-ascii?Q?AXiPH5PFV5PSzfY0oKKi5C30IKR5yvIaO1s44hgAtXBZP8GQ7qeqVo66L4gm?=
 =?us-ascii?Q?ew3yv+jQHzCZE2exOEhzI8gEZTXXoah+Rvq/kcnQdUb5UnlbKbO2etc0EP/0?=
 =?us-ascii?Q?mUXpSMuQujbPZRZQE3jEGLr/2tnmQqHz+1YdiUtjXdqRY46Y1nEXn0j2aWko?=
 =?us-ascii?Q?1s4lSuSZPc4dAfFvJah/wvoKcH0Hb9PiSTewvU5QRcQGlmt9pv4P0c6MbSVy?=
 =?us-ascii?Q?yJcXaH0JDUs8EZVsT/mcPqNP/AxQCKPmxu2UugQOX7OLO4Dl/YGIpsJgEEFD?=
 =?us-ascii?Q?c99K1+zC3LNEnJZ2rDlEDf8lyuRWQdxicJtzwYQ6PD+rxvh9IMcWCodlKXlM?=
 =?us-ascii?Q?xLMpCpDDcXhYiRVRiHgmuBuInqGXOoXQl9AwwHxu0dB95k22SrkGVHr6dAZx?=
 =?us-ascii?Q?d0GsFGpWDMk3V0c/Ic2pCiZ9o3v0YN/jApNhT7NJ?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3286cfc2-fbd9-4240-0314-08dd819bba1a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB3723.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:46:40.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5+4NVD5/XX2j4STWcJbDab0KGU7sCgn8OuHrfB16JKyhiglVWxQGhYnzxd8k2H1zReCMzB8YOziMcXIZBBOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6869

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
---
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 7251ad3a0017..9b56a36c5f77 100644
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
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x10>; /* PMIC_USDHC_VSELECT */
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


