Return-Path: <stable+bounces-135235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D78A97E74
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D361189FD9F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4B1C8633;
	Wed, 23 Apr 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="n7BgAoKe"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED014900B;
	Wed, 23 Apr 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388066; cv=fail; b=u2Eh8YjeHRKQk85X6sxcQtpVjf93xrp7qM/uJgBEemIlbLt63hhke+2Lh3QqUI5aJTMpbDPW6I9OdXWMcHLzzqdHkBW8gEdbNt1kgDqfhp7OKLDKtNEPTOUE5c27gfKAJVpheGAWB3/atCkAK3CYFh9CxqTvnUtGNKGnv78HGnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388066; c=relaxed/simple;
	bh=RwBUrqeMXtMvB0QYTAzRgPi5hXmLNAG/xi4mnz6tUHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZMgQo6okdKkMk0Yj2ZivAtFulxSZXTQEAKp+gm9DgqzoWBvNfWVPG6ivFWP+6LPGz2kq7Nvl7kX9VZq19CdWP155TBvBOa95QUAs10XIt9ECsUCd5eMirYG6LIaxB1dgy/lkSOON93UTkYTvmK102oNaoJ8iVGG4hZCOxHTjJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=n7BgAoKe; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ6/VhrIYLT0uRDuDola8O1oMEda1WiaDC28xJay6bIRXc9BGpuuld0E4BNXMf2gDn9pMIBDF2dDwrrH8cRim1JN+8iv/Dxx7wL8frWKxiVJYoL0hJXWEIJ4RD1Qej4dfyN4WIgkIiAHHbfm3gLL1pDpIaZmkqPqgt8IybiwCNUJlALBJB4079qTiFq0WVJwT9VltUo/sTvX2Q9ZtlngBKCFrINjzOkX/dJl3dv21EdF1Mdzhj1kSkAU/CSPGCiAgWnxBW1EySpr9ZHMY7ll4u1ZNi+PTeeKy22o+iUR7ech8v6BNX2hYfpXOYDcFIM4eAid5NSOkeUxtzfik1WOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOIErQcTHIUGPfsVxlKHMSiQuY0fKSigbmGkcwNYrh4=;
 b=wGXRUzwvQOMC14ZMnTjgz10XTHY6mJvGaPrQDuFE2mutEUABN0QOzM+VOtfU+srYL7+NtvZdWd/1uNDz0R69G4gsg+M72QvDKUp4Jrod693geLOq+m5Uc3/i2sIYrC+MK0EQ9UQTxo6gLbFt5e3XM/BaE4iEJI6CH0iKRCz3WY94r0JOQaZwm38d7qTq6K3LA545A0FmOZXy4cwG5WEgjCElMOR6Qmsfcx1kWTW7MF3PWajDFDTLrxq8Gv+5waeZbgJvPPbMwEyAoKgAkiWskT0bbosETps5GCtPu3Mh61A/OL1rzt7ic9H7nfoOhEH8IHcqYxcJck/b/xUg8sCErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOIErQcTHIUGPfsVxlKHMSiQuY0fKSigbmGkcwNYrh4=;
 b=n7BgAoKePkpqDciHNPD15dsU4CkM0fI/002ln8ts2ieBVDiCFuAUU7JX6/UoOoNlAyvrVyE439YOpaag7Tf+vJECNI6+gVZqwpZ6diSMKSMADJqnT3NV7WEP2c1AzBR13DYAAf4zArJuQNY14Trw+ldATNcj+nccWSBlAt9/fUZq9+OUi9j8qfYL4LXESr7+J+0ByEHnHo3iV+6Kjf6wDSwu3l48CMwaGU6iB3wTlYCaifKY2XUotK6OSuUlQsCdvsHFhn4YaLJJSWIxLEwAgl3XfE4OtjyIfzFsr0ITbVCnm0/hz+3Gv9qkeHj2S/Saq4qbWJIObV685Oix0WvMcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16)
 by AM9PR03MB6963.eurprd03.prod.outlook.com (2603:10a6:20b:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Wed, 23 Apr
 2025 06:01:01 +0000
Received: from AS8PR03MB6775.eurprd03.prod.outlook.com
 ([fe80::8a03:2bdb:89c5:32e8]) by AS8PR03MB6775.eurprd03.prod.outlook.com
 ([fe80::8a03:2bdb:89c5:32e8%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:01:01 +0000
Date: Wed, 23 Apr 2025 08:00:47 +0200
From: Manuel Traut <manuel.traut@mt.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Message-ID: <aAiCDzWBG4APvF_H@mt.com>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
X-ClientProxiedBy: BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::24) To AS8PR03MB6775.eurprd03.prod.outlook.com
 (2603:10a6:20b:29d::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_|AM9PR03MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fd2739-9268-449e-ad64-08dd822c39a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59e4I/hZ9p7Eov6cSrRCiZPiqbnGRztyyk1zL82EKQBqEXKW4quOCp9GZGPH?=
 =?us-ascii?Q?6P4aJmmQkhnwwfT2+Lsx0vIZ/5vGH4IoBYZiDIQLR3phQDY4qM8/pczjRzWb?=
 =?us-ascii?Q?wJggYY3Ow4k37TmocZb5mV3/r0Wc0fJ40fGSnQqad4ifXqQ0axkMJg14gW+S?=
 =?us-ascii?Q?aVTwuxvC5yrzpkc9c1oHz5Tc7Tdd3DqbWNbCW5nj7ABxWx6/1IPVhoMWyBMr?=
 =?us-ascii?Q?jPmMa3eev68f+mG8iy+mnJdKcwYd+dZd+O1M0wOZvkcxM2fVmoObvfL6BMYX?=
 =?us-ascii?Q?kOCqqKRGCUj6eO0aPtPemNFNapUl0MXexq/4t5j2VdSEsjCdRKSolLnGJjwz?=
 =?us-ascii?Q?QzG2Cjaky/v0Mh+EHOgpKmCl6kLRosXrGyxk4qs82BvoP1Fmi8jYarUuphYZ?=
 =?us-ascii?Q?rFgPSG6pQx9FXRi4Bnlda4Lia9I/s89jL9o5DOH9aAR3j1rztOC6qfgprp6R?=
 =?us-ascii?Q?OIGqF0EhI/hU2waVheCSmmvRMWbn90vyb9IVJgeph6rBuJbY7o+UQtTMBAJf?=
 =?us-ascii?Q?qxF/IxGmU7vQxRBlrBxCAdphV3fAf8ydEbeVXpsQ1WRHETaK/td94oLrlX4r?=
 =?us-ascii?Q?lDs0u7QTkxJWAJIh3H9u548P0ujqAiAi0tz3enpnmsr2WyswnbVqu8NAdrxJ?=
 =?us-ascii?Q?COL8DAUvCMg6RT30TM/OI+8MVNjmdRNvVKkQAZty6nXQT4Xu80/yNtmQ4WMk?=
 =?us-ascii?Q?onGWkB1yMLj6uHPjkzpDRKDjJbpMiAOniw2uWcYWn1wSv7HnL47UMbzNenxW?=
 =?us-ascii?Q?MYVptOLFKfHMEJLWIEt91gob6KJFsvxXYZ7IsTOzeWuVzcoboMBNsDyF0xQx?=
 =?us-ascii?Q?3z4m7WxjE9++rxxq3TTqnaond9uWZQvYOPqiw1+Oa12V38weJ+sFDhOo0A6S?=
 =?us-ascii?Q?Blzl3WH5ail+FG2L9E1iPMF+aIzONT6R0u0CoocNT4ZVtThnSzpBGmqBMs1Y?=
 =?us-ascii?Q?lht6W314vHMUau1SMDfvYR1rrrtDpvNIFnO5lUChXBlMobVWfLpyohubw08k?=
 =?us-ascii?Q?HurDcgkR5+ttZc+22rN4JVWryn25/0ukZI2ujonCX2D2lBgWeT7U/ZrsjPSM?=
 =?us-ascii?Q?3U75aSzhlFcIC7/EKtoJcHT/p48ChUUtxTDuRk77RTpMCXnIgUXUBVeLZ49X?=
 =?us-ascii?Q?bvumKHyqRcdPpjQamfZ4sGz9RvE55wE9I23S8DFGS1X47n4V9/wi2XxZPJKC?=
 =?us-ascii?Q?ByXjKZ1Sh07VYJoNmmTFAx0XZhc3PZT8grFlWVyhDT6u1JC4WUEmNshuupsN?=
 =?us-ascii?Q?BAktpxg6snB0kG2Dn/CR7UZDjxo9YYd6BA2ESblRDqT9n/N6XZg2b1Bns64X?=
 =?us-ascii?Q?rkyaOU0pR9wqV/bI4BZLrBNiAur+mLYd6mvi326aFrwte7zrs0nizLZUFYoY?=
 =?us-ascii?Q?6ONN7BhgiGKUj0L5rASNdfZs14bVcRB7+KIn2h9ePUt0XILzdisuPuWEgXP8?=
 =?us-ascii?Q?HcxOk1CsLcJMRLpQ7K1PzVVZNIfSl9X2bUPWhYf3WBhbc5X7lmSOnwKkJve/?=
 =?us-ascii?Q?AztLIxi1c7NjMZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB6775.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6L0HDo3rk/kP6F6/l6zfjsIgmml9ytfNeByUadPWf+4Z6ZVT/IxhITDABGM?=
 =?us-ascii?Q?L1cVucQKK8kdXeoW6H/Awxuc9ZtMOtVP0jVtaxhVE5dlNk4B8DMMYAePPm9Z?=
 =?us-ascii?Q?1Lse4rB1IbB2aPGP1OLeyEjNekAHXBWzmSrS2jqedm5kUC5zQ8kwLFdf234i?=
 =?us-ascii?Q?qMxl886qjzM9jyAyQp2Lt/QeriMohSQbvZNEvy/h9BhvXfyve+gjooyFQ8yL?=
 =?us-ascii?Q?NTlL5LzGsvLb+488tma1pnxWYf0WQUqss85vFXIAPZPXR/8Lh3aTc7zC99tV?=
 =?us-ascii?Q?UNW21Fo5QZEylvFU2l5fN/BUxAYxnTgZtjM1alRicQD31naNfSBVX6Ii53/Z?=
 =?us-ascii?Q?oa1Q2kMwNCVPJ4MPj0t1R+XM976jnktJiTjifqjG9509+lfuzP+fNYTb9ryz?=
 =?us-ascii?Q?g7AXLRE4WI+XU8Ob3gcWIbQHIdmZlWkxpCImIa0mPG/7K2dCtnBqT3+djb2E?=
 =?us-ascii?Q?zKJziBn36/7kqTYDv9MgWZUzk0mL1EEbXexkjobSdwaa3OXiWpkbIPsh14w4?=
 =?us-ascii?Q?X7hj7xZqeHqnsqCeg45fI9c/zkEwqgQfwl0YqNooyGImuXeua0HaFcFW4oqY?=
 =?us-ascii?Q?eYl9QcYwZKen4+YPFiTJ7m2F1vVUqACI9CxZFIq3el1HtDC9Bvy4jV9HzAaE?=
 =?us-ascii?Q?z3fxt82VKFyE6Y5I8oVjUnDwIrFAzJ666gjFqfnnPOb36Y/LpFqMIxC+ERos?=
 =?us-ascii?Q?TVz2rO7evIHH+s1klIEpXnMitzndklpqvMEfTlkl10+hAcKwSbOzsXVrz61h?=
 =?us-ascii?Q?QVMklYbluYw9RhZB2okKT15Kca0AacfBXXPkmSAVocXYNOWzF7vX1Zugsx59?=
 =?us-ascii?Q?9foM5vMVDVtOU5f2Yq+pkN3eJAsM1WudNMhkvv8egrk2CCLNol3JGJbLeLlL?=
 =?us-ascii?Q?3tZA06DSbHNseEOrJG/LVnLU7BNdKib75hCKhXCJzwOwqtun9S1kqT4Di9Rx?=
 =?us-ascii?Q?Tx/S9zOskzKxXsd8c8ywbsDXG0mOHhwY73TQcLCG+YluOSiC3IxThWo6aK/g?=
 =?us-ascii?Q?wuey9B5ZO6lKtr7cPxGgGyLwh1aDBgp+2YlMgYDzT6RWSDOn+1wSMEuGKw4X?=
 =?us-ascii?Q?2t+FvaYyGqfk1dVLKaFZug1RVM/uK6mSlb17WenpGrlgO4KrKp/QJS0897HY?=
 =?us-ascii?Q?ZAholiMj13xZWhfm3oMqsqw10ZwolI7qoKWtv8nFZsMM+Xzo7TZzzp2Knkan?=
 =?us-ascii?Q?lVX6OWhDbk3x5PktTrNpjrfzcQBfWWVFLHZErSPIkhZEFP4cnzLnlTH1JDLa?=
 =?us-ascii?Q?qdbNT15t4rb/40o7Yp59xIv4i8efzMd+tR0vjhC0Pc3ZgVFpDiApCXh7lHmc?=
 =?us-ascii?Q?xevvIM+Ah+1A44aItoWmswQL57ih5inFZ23EgMuC0VkFdtNRVbqoTOfC6O8o?=
 =?us-ascii?Q?37zLVGgy46wEPG7xBzTtu+V7D8kpGTUbE0qCll3YqwUq4ThTqOzvAJi1bJZg?=
 =?us-ascii?Q?0i6vdJplFt91d+0tj+YqyKiHXSazC3Wxa1l33n41peuFx7Rs3d6/5H1GZuxr?=
 =?us-ascii?Q?JtfoPJ26Ftn2/3JeVpkcDGX0hCrMbA9V8nkwtuJur8ygWOWRnXe0pEn+MAnA?=
 =?us-ascii?Q?/k+X0ziq6G1yGbatHuXKnH9iEorgZRKdJ3RiWje6?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd2739-9268-449e-ad64-08dd822c39a6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB6775.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:01:01.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLRacJz7yXy8yE0xvJDno/JdfFWSsVUjDC0LV/aW5NFykH8puHyQA1mS1TzTPrP1Eww3sqgd6lALCSaJR4uvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6963

On Tue, Apr 22, 2025 at 04:01:57PM +0200, Wojciech Dubowik wrote:
> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> coming from LDO5.
> 
> Without this definition LDO5 will be powered down, disabling
> SD card after bootup. This has been introduced in commit
> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> 
> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")

Tested on 6.15-rc2. SDCard stays present now. It also fixes the issue
for >=6.12.23

> Cc: stable@vger.kernel.org
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>

> ---
> v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
>  - define gpio regulator for LDO5 vin controlled by vselect signal
> v2 -> v3: https://lore.kernel.org/all/20250422130127.GA238494@francesco-nb/
>  - specify vselect as gpio
> ---
>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 7251ad3a0017..b46566f3ce20 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -144,6 +144,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		startup-delay-us = <20000>;
>  	};
>  
> +	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
> +		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <1800000>;
> +		states = <1800000 0x1>,
> +			 <3300000 0x0>;
> +		regulator-name = "PMIC_USDHC_VSELECT";
> +		vin-supply = <&reg_nvcc_sd>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -269,7 +282,7 @@ &gpio1 {
>  			  "SODIMM_19",
>  			  "",
>  			  "",
> -			  "",
> +			  "PMIC_USDHC_VSELECT",
>  			  "",
>  			  "",
>  			  "",
> @@ -785,6 +798,7 @@ &usdhc2 {
>  	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
>  	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
>  	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	vqmmc-supply = <&reg_usdhc2_vqmmc>;
>  };
>  
>  &wdog1 {
> @@ -1206,13 +1220,17 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
>  			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
>  	};
>  
> +	pinctrl_usdhc2_vsel: usdhc2vselgrp {
> +		fsl,pins =
> +			<MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x10>; /* PMIC_USDHC_VSELECT */
> +	};
> +
>  	/*
>  	 * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
>  	 * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
>  	 */
>  	pinctrl_usdhc2: usdhc2grp {
>  		fsl,pins =
> -			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
>  			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x90>,	/* SODIMM 78 */
>  			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x90>,	/* SODIMM 74 */
>  			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x90>,	/* SODIMM 80 */
> @@ -1223,7 +1241,6 @@ pinctrl_usdhc2: usdhc2grp {
>  
>  	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
>  		fsl,pins =
> -			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
>  			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x94>,
>  			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x94>,
>  			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x94>,
> @@ -1234,7 +1251,6 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
>  
>  	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
>  		fsl,pins =
> -			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
>  			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x96>,
>  			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x96>,
>  			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x96>,
> @@ -1246,7 +1262,6 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
>  	/* Avoid backfeeding with removed card power */
>  	pinctrl_usdhc2_sleep: usdhc2slpgrp {
>  		fsl,pins =
> -			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x0>,
>  			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x0>,
>  			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x0>,
>  			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0>,
> -- 
> 2.47.2
> 

