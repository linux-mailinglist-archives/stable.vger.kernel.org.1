Return-Path: <stable+bounces-133031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E1A91A94
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5810019E563D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190523BCE0;
	Thu, 17 Apr 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="E2Kc/MbB"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5A23A99F;
	Thu, 17 Apr 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888825; cv=fail; b=HMZR8pB7gh9i6CmP4AVOzo4r9K1LsH7hFeGifZLBKuRTTSDwhfP+zSo9F985u0tt3SjFUipXGVAfN+2Kpj08EFytWtBaJLY37NYXGZl90afNkL74o8C7L2m5jMfBExpkNuVM3TnAZkILeQAYfM5tXzDRxq4KYMQrgYATwCiJTQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888825; c=relaxed/simple;
	bh=1BtJdlnf856PBfW3iduXogCa9KKrykjXGy3WW/39/0M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CNbeWYcRYoTlI2xoDovAfvk5414pj73DEiQuRiOG8tOATZC9wfrFJY6+/IuaY/kXa8j7PaXUqL0T1IY4ChXA0bpo+v7ICDPOYTQC6p2eNf2zZej9rTmixejw9MHzAf305lWjkfhZ6UCDMQ99fh+ZJM3Rm/WSVUVc0PGy9lH0uxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=E2Kc/MbB; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkrr/DhJiiMvPoJoveXy5Isi14Lrx+kPtua3n19LvzQsp//77QBnmmmJrUlFoSzzZPzpfk+jC29DyIQUNVleKbekIF2ZOlEP8RH4PlnO2mHZNEPjT5jYMftY+ecEogu8ESsgWgAUIHtKbPXNIKfekAAs/wE7GyAxO87S17hjdUdb6zaPTH1VJOCz8yv3lKlj3/ZA4ETNMNnPxoJ9clDQGV0z9OrfwfntE3KdYkUDBPMqrc+BIqf7MBJGiK7hsWxQU9MRHq4sIp9gnLRGOK3VcKfW+IijjuxnUCzasAX/VVXOQ5RGeQltvmGHgFlv727OCmLex3YjQTlqE67kMrBjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+mYYdBcohaCAahHoZq2ZRWdc0wZ05zf/2xANEWgAWc=;
 b=Ezqs0Fi0Qvwjo9QGa1aqD5Mfw6mKlJGLnis/FfEPQUzA7b4jpPYu+iCdfrLHpVio8j79EIZozkyBBEKu0+xv3WND434mHeEuQlsNOFDxB3rynuDRUNXv/L4hntyooa6BrcjhQEf4VgtdpAIhiVpcjWKQUzY84AvqGBI7h6ziaC5Ynabvno6BBlOcEm/vDdd9oyaQLL6rIqCdhdrl44MoR5Z6sQZbjNFnY9iuHj84wZ5E6Xkm4hTEsiWDuWfgatzxNX3wbbk96l6TDypca0tjmPgXi61wu1TCQAuAPi+lzbm2Cz1Wpga/W0ST5925gFnGZ9a3JJQ7vL9+gFW5b8AJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+mYYdBcohaCAahHoZq2ZRWdc0wZ05zf/2xANEWgAWc=;
 b=E2Kc/MbBRciqZH8Zx54MQUjssNJe8aMCIqNPvSeNitVR57KP+4385Hpny+YJlCyGXmHRlezEDHGidD0yP/Yd9S71jiIBXp2bOyecwkc49DB/5mmO5sXMUYgLyvZAWpv+5+dZv+iUc7xYNtIrjB4BcMEtt8uhnW4UyzpcezrtYFlkoy4YeTwkl4sohQF3Gv/OYPzZD/G6A1/6j2OSZaPTbirlhaOnnnpKFs46x/FgBCgVDwr+JE4+a0/TrUbEIDbtH50xJVt8g6m3stMOflMFSad7DUcygrJ3AzvY+ZDRDH8z8LQ6YCyNSCncHP6klx9464JM6tirB50ai4aUs8lJBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AM6PR0302MB3413.eurprd03.prod.outlook.com
 (2603:10a6:209:24::15) by GV2PR03MB8751.eurprd03.prod.outlook.com
 (2603:10a6:150:a8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 11:20:16 +0000
Received: from AM6PR0302MB3413.eurprd03.prod.outlook.com
 ([fe80::fd5:7b7c:3b2:8d1f]) by AM6PR0302MB3413.eurprd03.prod.outlook.com
 ([fe80::fd5:7b7c:3b2:8d1f%7]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 11:20:16 +0000
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
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Date: Thu, 17 Apr 2025 13:20:11 +0200
Message-ID: <20250417112012.785420-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To AM6PR0302MB3413.eurprd03.prod.outlook.com
 (2603:10a6:209:24::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3413:EE_|GV2PR03MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da6ad8f-1e95-4dae-3a9f-08dd7da1d438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9u/8JQAhNFENgKxgoRMGG1ROrR4a6KVsp26p9OaryuL/sc/DhY7JzKK504p?=
 =?us-ascii?Q?Y1+Tzc07q1wH5Aewn0KPwJP/NI2STRKmfHZuDFJXz/Qa3RPCz4AymWNG/OlF?=
 =?us-ascii?Q?3Ka7Al0IF4DyKf/HTy0zevsV8zC47SUNZfPQcob3pAj3UbieVsb+TkOhFuMc?=
 =?us-ascii?Q?WVO5a4JVfAkpR2sr4KzWJit5J3vX8FhgLH7uG4GBprfAxtaxf8oZ1ZMd51OX?=
 =?us-ascii?Q?NxootJ+w5AUkApl+IIkRwcuytudn/Mk0WEiXpBqG5quYAtCffeybTWrRdNGl?=
 =?us-ascii?Q?7WQLvG2FApxU/amYkTapCdplwBIsH2/LkhoRjHQpocRKxXDNBLB5EvQ4JDiR?=
 =?us-ascii?Q?hS5vSHm22nBpZMSudVt6mULdM52HOxmAEkJgBtZldA+lcV17zjU+86o0UUlZ?=
 =?us-ascii?Q?bB1OWpB1HXDwMFxEK9LX/rKxvY7YYW6ewwt5MIgrmMKrgRZWPdWsDqsIA91C?=
 =?us-ascii?Q?QkU48XLas5M/v8tR6sQ5jPXZaltOjiRhqklRvnAKwcG0Hfe/r6XjI1IQHKvn?=
 =?us-ascii?Q?wwVXYM4Pb9yD3XEmE81HhTgzGhMMQo1tTVMojeBJd/hZ1ihnXdfnd+AOZwHs?=
 =?us-ascii?Q?gMfQpBJboGJCzADh/nVbXWWHz73i1e62GHWEtgDw0U6PwV8XTFLEL2KLmQez?=
 =?us-ascii?Q?QIAWkBaju/OvQV9uRBjx3oQZodp/AH+wGJt10w4ugOIX/7UAzey+k84qfHV2?=
 =?us-ascii?Q?SjU2Zgvnx9/4MD6VlORWbj/ZiTl11O/QcXSuuQlSVZtCXBW+eYbEJY4bLnfS?=
 =?us-ascii?Q?IRIBW123DqrBssFaxxlUS4qSR5hBhMiyRwXF3VsN/A3z0FCPqQfGL3oU5HYI?=
 =?us-ascii?Q?BcJPmgNEu67k1vM2Oa1LHho7jUuwzHeMPcmu+tC+2949E0cIV0OUdMdiu+9b?=
 =?us-ascii?Q?ZWZudcW9+UhcL4gB5MKtEr6YFLE2zAB/iLSl0g5L5f5+crv2++anyzYaRyxC?=
 =?us-ascii?Q?EGOtxmlafgw+9zuhgA3k2J+EiqPuN4inY1klBBCXI0KoJ2HJdEP/iAiKopZe?=
 =?us-ascii?Q?0yJgoNZDvbXT3NvM1Eagz9XqkhK+fFdPrdY0fude0mq37cIGHA2D1FJ7bcbO?=
 =?us-ascii?Q?R7bMHuuYogLX6at6k9RkGuvbcAh6CGE5aap9PK8YcheCundeVOYxSHHBMVa3?=
 =?us-ascii?Q?QVMN4QjIkSX+mMnyns5mzFlR0MRywY/+//Fb6b5Su150azzE70IL3L4TPbGT?=
 =?us-ascii?Q?NDe8q12kbV2M7HjzmaR/fdPVTTX70w5Fg/VDoOhSZmLkxNilbxi+R9VDjcsM?=
 =?us-ascii?Q?/t4/A5mUkj18j2CADFF98hCLbWS0r4YVFYuiFN7iVQf6geBkkwG7fBtSRwwk?=
 =?us-ascii?Q?WiBuMrrC37tVqF6HPtE4VjK7vfN1YlgEm+whaFIXFvu0BTVQYmvTXfqVCqUP?=
 =?us-ascii?Q?qxi9WwkTsoyG5syNEyqEnIKVWjWm0tFR7GQx32966F3o9pT5IeIiT7TiwGUf?=
 =?us-ascii?Q?SMgvYxhjocR7dgnncePhVJ5IWRPXf2NgWBIUqOwbFyeQ8UdphrWRaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0302MB3413.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZxd4PmIIKNVSMFtdo7EY6wIL2ZXqM++RopoPdXpyuQADWnOS2hVbanEfq8O?=
 =?us-ascii?Q?iVvzcv2rMuoRFnz+vZ58w/uxmplC6oEoH2jN4TXJkEeZL54wyBZxSSFeDH7a?=
 =?us-ascii?Q?7xM+ChHg3sm9ZkgQo7lxBwkU0mXgK3P6zFzaQqMfaqvp1UDCoFxGb6s6CGT1?=
 =?us-ascii?Q?817q8OuPHu+GYqN6PZ6ebhcRdB/WRvDlopia6i8x97wNXlguymnr2yA3fLe0?=
 =?us-ascii?Q?tIuMtMJr3QuoGXBArfChdoaTi7j+OhVuFYq8s93Z6o8xu4B1CgA3PHtfhrvY?=
 =?us-ascii?Q?pXKElsbnt6A8RUuGd541poeojJ0bKyPTHXTyBvH2yA8KIB9DVaG5MKR1WNHP?=
 =?us-ascii?Q?8KLL8xi7kJiR3agJaVzke926GOCOJFCvZhQsKN6+nkLkp2NgF8o+oGHxf5qz?=
 =?us-ascii?Q?AaVOgCkP1phi9e+bNMqA1C0wn7yORZPSQ0VKVhpZSHePMqMovpPL0+DWIiav?=
 =?us-ascii?Q?uRGGjbELsZ8RuRsYyGOPzFF3s6MoAmYrVEUhgFVY9LjxtsKMIR0NOL+T4ef/?=
 =?us-ascii?Q?XdMb4jM+nYGMkdwbPWByH0EL6Q57wVORN1iAHho6y1N69sbR+kJhcDv8JCer?=
 =?us-ascii?Q?z9z+yRlyiY8DHWngaqajsefRSbEvQWs57tOT5ZMCCcA5La/EI/wnq17OJnNt?=
 =?us-ascii?Q?ZpgKQUJWBFCCN70LTbZfBnoy7EF/aFGLYfiYpb0kfja8UHZFCFS0CKcaMfU/?=
 =?us-ascii?Q?HUHtXfysUJ6ACD9ReSm8ttXhLR1QWz92jv1NB9BZKgSjzJ/VBAWfHRbuJTC2?=
 =?us-ascii?Q?Kw5IhNkfQu3sLvwNIMHa01nfZEj70UOEnCTq4mYA/FMMMteNo9TAhLauIqaE?=
 =?us-ascii?Q?HwplWbvDmmN9AKi22u1rcrNmL3l5fydPGIXkfeGgq4YYkls6QqqL4718I/0Z?=
 =?us-ascii?Q?rW475dt9YQ3iW9B4JYGmUDN58/Dy/t/KxFwCG7QeCYmuS215Sof5SA6dXsGU?=
 =?us-ascii?Q?56IX4DA5BAVnNeP4PBFHb9m6fluZO0CT+ElfWAZkYeane7QPvrZl2irvF7sZ?=
 =?us-ascii?Q?BdtDfyiBVpsKp43croTSbia+iaAZBApv0TslMEu6XU6AD5istHDnzz0BJ+aH?=
 =?us-ascii?Q?JQa9OKQQVnGRGuk9/VR0RbljY0cnpzdHggf/qldWRVyHgPCJkIVVMu9J9zLm?=
 =?us-ascii?Q?cotXlR7L8h2ep5eTE0m2kveFbWH8fQ0Xulm31J3+uhGjFpu46adoy7OIcKWG?=
 =?us-ascii?Q?ZD7p/nEFEzfJ/1O7JC11C+H/5sZ3TcwT2MrEoYBhJKiYxMF0q5DuTEthTFdE?=
 =?us-ascii?Q?/UVR3RKjhEnc6RqBbmugBULSargcO5QRNX1Z8atTvrjv/kOfQ6/1Pp+U71sN?=
 =?us-ascii?Q?4mqU+HefiXzxkSXrmvkqW9enZHg4EDY6H+pfMWdAC1aumuIoRCeiwMSUXfZX?=
 =?us-ascii?Q?S6bzd7SXSdBFcf6qhPu4GaHX/UBgiKeAWBMlZ6intjHOPLlGUSdbw+Df2PmH?=
 =?us-ascii?Q?pmeCP3Bc0dmBkC4IKoxNXSw83QKHjrrhkhOcIpptrXnZLk4d+qv0tAGpMdoY?=
 =?us-ascii?Q?mLNUSokqEt0E0jtJuuzZSqDhViCW0tCMPahLxVK3pa4In+b6U4ZnjT90M+X/?=
 =?us-ascii?Q?8Ix9JR5MTxU8c6A0l1Sjb1S9M96WN0/o/D2jUT4Z?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6ad8f-1e95-4dae-3a9f-08dd7da1d438
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0302MB3413.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:20:16.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x69/jfnkgZ1JLnUgAWBT1+qJtmngiTsgueFkfE+c5JfQjVETZf6XBWV+cBKA48GdCXWwoxSQOn7Q/CEDlIAPYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8751

Link LDO5 labeled reg_nvcc_sd from PMIC to align with
hardware configuration specified in the datasheet.

Without this definition LDO5 will be powered down, disabling
SD card after bootup. This has been introduced in commit
f5aab0438ef1 (regulator: pca9450: Fix enable register for LDO5).

Fixes: f5aab0438ef1 (regulator: pca9450: Fix enable register for LDO5)
Cc: stable@vger.kernel.org

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 7251ad3a0017..6307c5caf3bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -785,6 +785,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_nvcc_sd>;
 };
 
 &wdog1 {
-- 
2.47.2


