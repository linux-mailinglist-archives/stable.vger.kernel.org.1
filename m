Return-Path: <stable+bounces-136548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FDA9A946
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF05D16F778
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8192147F2;
	Thu, 24 Apr 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="gBaJmauJ"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78904383;
	Thu, 24 Apr 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488852; cv=fail; b=I3pYgI8e69BdXgurRl0RK1V+tPOWm2kxxvaUXUuKOlUhFgFTcPqVXwaVxAXxOiQyFIqgeG7BIoMfVOMnwh8eoCcq1Nm6hiEzK1ol0bQc6WMp4X8to/be2PpMFtoNQiNXB6iHF3OYmznc429cSFM/Eh7qE7hQNtn0MojiDNZPrfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488852; c=relaxed/simple;
	bh=MJnb6Ul6gL3ygsPQQdmyK9WJVxWgigwaO/73nwu1Z1M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bDzKQWbr/8h15ySDzWsWlYb0reSFeVxdvPeeCRlbLjFVjbMCfHrEHoEVU/v84y3MUO6QAxcy+KI+Fqo5sdGjPad5tmsYjORhXdpF/mkidbN/fd66ksyuryu3PNV3Ei09uKEvxPmHW0zpS5WaYLL18BqEH+EyM2MeFjXNrFmTigg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=gBaJmauJ; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrSLfWNirJE+Df8z48EZ5DprHzddB1NUEtuZU+B9kaMPnBe8e181ASkS6duq58/tkpJ8PWbyENXUUp2+/sCa39WIpSEHjcvKSOXvhBbWaYhKYsgS2Qgm/UigU08ASRr8Z6q9cAMBA/g8demWcn6ZF74kIWzh3t8WDpGpCJB3ruqQn4SZScIs9dYWQTZ0G8AGsO8RuZlQLI1SKwPcMC0mg9ZBWPu5aPXgn98rrFsc2dag1g5ZYkShGgnxUmk+kQZYh5Uq0sD0voa12IEep9utW0Z+5nsdxJgeRuCuk1a6wzAeGPIGPj8gqFvQc1/DyJ9BDkH51Oc6EuAyZ9LEv7gO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ZIzd9hbAVCYujHJSRFWFzaoPdwapJ/LYnJaf0bMvM=;
 b=cynGEME0fGAtDYi7qpTJWSO7o2wjCIrFDqNgWIoSDBBg+r5/IE09OE2q1aniIsqCIAAUWU4ZuMt8cBCLJmrWpgv8mho7IWsEeSBHlHpRJnxQeG1YFAB/47R/LaU8JCpwFGaVbCoM2/HrxheQzBxtUL6u7bY6GpOYDUp/CDtbYrewap04l0ddqB7GS5FKpaVdHOrj3bvLMN9EAFgHfi67WwTO1vkgEKUyuWPC4HF025LgWZmtGIguhUo2kYP2kkRBOlq6t8bRBX+AzxWJzI7zVAALXNs1Sr/b/+5N+M320diWtul8mQO5G2LAH3YZXnqv1J9DTIF1XpIRdV1tJyy+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ZIzd9hbAVCYujHJSRFWFzaoPdwapJ/LYnJaf0bMvM=;
 b=gBaJmauJw8vOapdiZ5Z0VG/Apq/2AuH64D4EWYWSA/fTUh63zAm2YK3zRxSHHHCVmUHeZVtgDmsc09gD+Svyszm8tQd7Q1laLKTPf2EiIR4LWzcLPTYnuFVediF7cpC8eORiaGeMhO7NtMk6d5piLKM+oGlQ1d5LNc0Y7Qf0iAO8Gf2a1/hWGSINIUfY3ZnNB5HaZcnIUKoAoMBvqHvTX8D4R/R1QTG6dS5QC6I4oO15R4FCMmrGAZpBEtOIHTRPejSOSL/vUkiKKfnaDVteFq4Gvvvb8h7Y0/PtuBqOuQ1mwRQKY97/rCwlN33y70UkCBhHzAHCC+4DdeDyi0zLVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3728.eurprd03.prod.outlook.com (2603:10a6:803:30::14)
 by DBBPR03MB6763.eurprd03.prod.outlook.com (2603:10a6:10:201::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 24 Apr
 2025 10:00:46 +0000
Received: from VI1PR03MB3728.eurprd03.prod.outlook.com
 ([fe80::c7de:54b4:3ebb:88c1]) by VI1PR03MB3728.eurprd03.prod.outlook.com
 ([fe80::c7de:54b4:3ebb:88c1%6]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 10:00:45 +0000
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
	Manuel Traut <manuel.traut@mt.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to usdhc2
Date: Thu, 24 Apr 2025 11:59:14 +0200
Message-ID: <20250424095916.1389731-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0081.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::14) To VI1PR03MB3728.eurprd03.prod.outlook.com
 (2603:10a6:803:30::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3728:EE_|DBBPR03MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a202fe1-cfa5-477e-f483-08dd8316e175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npDOO9vCr2C6NB7BjfqS7tc3mJMK7tfu48UPJZJPEydyWjt91uwMuNOFQks8?=
 =?us-ascii?Q?TrLx0Riib2mU35C+6lWxXvExB6lCBiuus1K1MIKtzrK9Z89ILK4iODKpoqmU?=
 =?us-ascii?Q?I9ZScRpH0NssMJxbPIR3W8KzZJsZVYZvu5Ka8gXLmpoxF0DQGrahHlC95dKc?=
 =?us-ascii?Q?4juN0csEljCmjz31+T/Vlnoog7PqiF+cviCiA1DY3CgUTo0ynbxehh0X4rMF?=
 =?us-ascii?Q?s0hT+G/aWqLeTBRVS7rQNaZIRWKLK6tYKqTQK/+22C3j3u2GwOleIiDkIeBz?=
 =?us-ascii?Q?4IA/MIPh7KFL3dlqsSlExUUJ6WG853SHmUedofk5pNYyIqwVmuIF0XbANwU6?=
 =?us-ascii?Q?xZeQ6MFObxg2TpiJipMoUlu4GMSRX5o7dJkdBhJb0RtRY5ukbTsodL6VLiho?=
 =?us-ascii?Q?W8YcM+Gcz1FaLLIwyICBlcGTjvaJco0/N0n0w6SfUbD33U5UGfJuZBdwaFmN?=
 =?us-ascii?Q?D/45MpeLpiL8IKZ7LYSr8Pn1QjCEXJhsX3VjawJr3qXODGQyIy8shgQDSn+9?=
 =?us-ascii?Q?7nr2/6z6nlOu9bvhvjRIIPKkKQqUabq56QnOgYNlASC2ydJ+vMZLbHDyCocx?=
 =?us-ascii?Q?4q2PKMlBTLn7L5dO2RCpKu1rboAF8cXoyQpkfW0a2FGmllHksiYjE8gN5XZX?=
 =?us-ascii?Q?jNaq2Y6z1xYzyQcatrjh41bBFzsPBjHiVa+5XgvAjA4tEGUwIsLrtPm4cE65?=
 =?us-ascii?Q?GIKoXq0RgwTviwP7MwrcAt/mD3gaPocHRsKOjiCdAeK5kjCaCyaFYtJDyVL5?=
 =?us-ascii?Q?ErkRcr/ZGN1aP2AT1mEyAHzS8A4F2snY9fvNOTsqOOGLaGXdyATXaq/20ZmJ?=
 =?us-ascii?Q?NCJ0omJ2VZiO5XiKsf0wWCnOipTJV0PRRorJd/rZ1orA7M/uEh1744OC8Zj5?=
 =?us-ascii?Q?1gEoicaTWSL72Id26MUXaGb//t6fPqbF6cl/RA8RF9+5PxBeYN+nssURsba4?=
 =?us-ascii?Q?AD1UiBV1nqcb/LPDIR4gB9+/R5bJuMjesQGawwjCnl4NTmw0oskFStQobM5v?=
 =?us-ascii?Q?XxfvAm1HOyPvjotu9IRmLqqvO+HQYITS5zd1yzm7mOMvhty/v0yl8NLhd7EE?=
 =?us-ascii?Q?cPs6qBbpYqvLSTm0TNwmAXM5eRs1KWslal/nyei+OvuSAnVQZh3pJVwJlyeA?=
 =?us-ascii?Q?NhJKZ6sFruF+pl8KJ/kTOrVMaXqSFLqudqriKuj3BydV65HrJ2R9pYJvU6S+?=
 =?us-ascii?Q?wqGWIaOFtHq3OoiFekQFJbg2eyQIVv8MVS2KDHIf/HjK0K4iIWJuTFvR++Ta?=
 =?us-ascii?Q?hiFmZTn8WFIZ8YqvXLsXJJLZDZgBibmnrlofaVkUYn+0avBP+G7dTa4W10WK?=
 =?us-ascii?Q?Of2VW8jhz/TE+SZJKQ6r1CmlQzsLZbs0AccWuG8j8paSqyUYGjeJkiJeB77a?=
 =?us-ascii?Q?x2K9EyOi5QTJ8Pxt3WklaAH1IfFKHq+Svn0GM4KPTiLBInM4AzfeFa7cTopY?=
 =?us-ascii?Q?GorfhCBYj0rRzjlb5nICsvO5AWfcPJ1Mi/K5wq79xHql5PLK0anQU3R6/Mqp?=
 =?us-ascii?Q?G3wKdjpuABuM8Pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3728.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXJ9b8o8eMQiKtH/UvKVleYxIvO4ZNYTd9N56jg1xLJRl9HrFKn8MG6m2CB/?=
 =?us-ascii?Q?RrYOWi8jd1a77AqmIHMANs6T56f9IvRVCwGNnmXjZEtIe73J7j3hEh8KCYiT?=
 =?us-ascii?Q?idwIV9xIzfmoqcFC0SrX52y9hT9+DmnfpuJprFDXw/UMg0gMy6hc5yGft79c?=
 =?us-ascii?Q?CtQqe4DMY3BZmYQZQWJOEHuHZj+lZA/Anpw7kLgDuNMtNVndRxg3SIGYuRtN?=
 =?us-ascii?Q?Oo4beFEDRGyv11Pa1/EJaa7NCB4nRdsYCdPn7xAlyMDPjUdV7fmWjyhoGAuD?=
 =?us-ascii?Q?tSZFrCH7ovVYl1w9HASg1b5rn4XxF7CilsXyzOLV0DkRG45phLprfBfPxTWG?=
 =?us-ascii?Q?0QfT2mLHCdO0QoES/kI2B5s4Fzl0FRbimOnuN1/rda16WIJHmYCcAvtR4WxC?=
 =?us-ascii?Q?nedK/gqLy9QjcKYeK2b801mq85NZ8exfz3TKjIEZeDKKy3J3bRu2RLrE+GNe?=
 =?us-ascii?Q?WgbQ9fiKSOcO/pND3a7sMool48okJt+Xim/2dFFKpefWG3mpSFdR9YV82WXb?=
 =?us-ascii?Q?D3RccJoLYn7rOmEiY74Fdlf+jzPAqGxVP7hfH6nC7m3toOPpj9YGx21BPsXX?=
 =?us-ascii?Q?HGZcQ6PVWEHPEW9wuWxlsf25B4Kh25yi0mnXoGxY3KyzX9QeG8455M/nilt/?=
 =?us-ascii?Q?yxad4IQhtI5OFk/hN2eBm/lndc3WAlYnxHAFOBTj18tVhzKSE1jJW9ibBs2O?=
 =?us-ascii?Q?7r4wqkK3Hsih76E/RGq26Ek5mgpC+EoZQO6Cbqkzf0DtptP4ypAkL0i9yQM3?=
 =?us-ascii?Q?2BBBk/IPz3QJhufWN0gq6XB6WNZdE04NmpLHxxYOCWadkZZYt7qOEO8iCw6s?=
 =?us-ascii?Q?HJmVZJ96H5zcwFkuDa1JJi/AzgRrAGNShSQD7vVxd4PeKyk2UY31wbGOE+uo?=
 =?us-ascii?Q?Q/ojVvCzvy5et6eWDMRfGLgq7GaFTfEGKJ70RmHhVNtn5c81N3Tzq7kb4/tk?=
 =?us-ascii?Q?KYNI3F/wTnuppjmmy/F5lobeHJc6zG/IxMtxjmJ2hY9Bhn1xUA2/XkqMmlqc?=
 =?us-ascii?Q?yMzW/EBGvgIKJgUpxrN0nSsXyNU3zZi6Sb/9VqiXKeYXBrI7hBAOD/Wruvkj?=
 =?us-ascii?Q?WVxsHGKaHdJBcNDjfvZ2lui3SowrI/U0+nXZ5qBCy/V31qBbZFlhd9f/PSOQ?=
 =?us-ascii?Q?o5QAQNpweda949yztdMh0w3ZJNC5zG6i6nsVMQ+NqfOUttlQXew4lLgv9JU6?=
 =?us-ascii?Q?4XE72dc6Uys1r/ULej/x3yy+XjQNTBSoLlbVMJgcVo7GkXVcjPaaaSRy4eDm?=
 =?us-ascii?Q?6HdMRAnfeyOfyJqaSGJxF/7LC+SByFhNqkIe6amYGxKibCsgOsiX357tadTb?=
 =?us-ascii?Q?3bPLLgDX2A9pHLr9reVDWB6xtZY0NC9g1h7Bs1peolT1zM8tnIIJRlbBIZVm?=
 =?us-ascii?Q?+3ARga61ygqlxZjSqJlxT2W3V7iQTPGo9P0EaQ5AJ/NnQBrwm6QAw0AePzYa?=
 =?us-ascii?Q?HwpUNvb907DkPeiqJDLnl3BKT9jc5JzZCKa4wBAMCCUNA8LxVjjr0nN0StS6?=
 =?us-ascii?Q?vK57MYT3yeDs3ujPL6IWKEFnKvgXDIoQYMSSsIY+0bqZSPn34Ukn/dF3gy5e?=
 =?us-ascii?Q?hAlSeT49W5dtMq2PypT5Sx7vLiPKElYisg+6X9tR?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a202fe1-cfa5-477e-f483-08dd8316e175
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3728.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:00:45.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9tx79BPcIsKSYiKM5KoF6JSpP+/GO5XlFw4G7LVVCGNF05cytrAYC28g+zo8k93FSqMQTO3flDJ8iPNRjbKfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6763

Define vqmmc regulator-gpio for usdhc2 with vin-supply
coming from LDO5.

Without this definition LDO5 will be powered down, disabling
SD card after bootup. This has been introduced in commit
f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Tested-by: Manuel Traut <manuel.traut@mt.com>
Reviewed-by: Philippe Schenker <philippe.schenker@impulsing.ch>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
 - define gpio regulator for LDO5 vin controlled by vselect signal
v2 -> v3: https://lore.kernel.org/all/20250422130127.GA238494@francesco-nb/
 - specify vselect as gpio
v3 -> v4: https://lore.kernel.org/all/84dc6fdf295902044d49cafc4479eb75477bba5c.camel@impulsing.ch/
 - add reviewed and tested by tags and changed fixes
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


