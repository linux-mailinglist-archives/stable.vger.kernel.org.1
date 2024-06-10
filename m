Return-Path: <stable+bounces-50118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9E902A6A
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 23:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79951F24830
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E54F211;
	Mon, 10 Jun 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeWdNYH4"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C711879;
	Mon, 10 Jun 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053720; cv=fail; b=Z1hclXEdiTnVvMOrRYAdhy5Mv26Xd7PvQIydWcD6DSMuiGDLFOcWzP0ugD8TgvJPE3pAIq/8RgOKCmwM/Uz2Rl7X64jsKPmSDy/wGBPnVn925aYb5Ar3BidDhvdYbLSzwrAOMZWW9mA7BrY5zTiYQWl5affhnSPWRshb0UYwMhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053720; c=relaxed/simple;
	bh=JwW2okuqLQbup4WJls4b5pJrrhr1SudW1AQcmy6NqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BO6QtGSOf2v7islqIK6f7MQG2FI2ZLSIFBZ2O93goeJ5SG9NGwdx4tYmJ8Ao7S9yK0sFvV8G/ek0DywiPsfKWQMSaOoseniGMn4Y/ae7FbDT4jmowt+oRbVy/MmMwFyBJNzcQLHnT1LX/ipn0sQDi/Te2CCcbsE32T+FVmy+CJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IeWdNYH4; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzcvEq7h6uLkAppYjmBSM88IaM9SJiwdsHd8pHiQpJsFlkHFSxNIcy+ODuvH+k42RVBJ5aKnllgAMVcnN5xhbtrcRP9LtfpyFE3GgFSeYqJdySgvBq5VBmin86ChYn9U5iPyI6yoQ0B2SmFQUxbpV48DLtE/q3x05/geM5zjGcgV2eaG3hrZ4Grwkaao2OS4Nlqc45E96/zU3lRMhrUxebzFzQ8xIqqZ+bbKnSXoDnNZ1c3PBnN24TGfgsCxDRkSy5RkfdPO1wxBFMLoJhf4IzeK4O8Ilx9Crlx2SaHlDEsbbNMUFMH44/nedrmaAllr1XEBw8lEH/wHFhXd4270Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHyRb2eXVKIGDk9LZUffkwr9kewERTI1JtMuI1W/mLM=;
 b=RdmbWrWVh4ODYS2H6oVVH37mRsRGnnkXPUtLOGvw+NYhmiOuJMHuAF4mjzGVwZcZN2MMtvXmvgPu5pooD52/kzbZYtXjat4jHKw6VFuaLcJg7b1Nfg8JCMYnbANCtJTIdwnWYu5yyexRn0aSdyF2qw81w6ns9zu7LGjbk5MA/wVq0ufjPMjkq+BA+hkDBFJcLH2dseKzPkUab1NV1p36lqL1aiA998W2FiVG7C1G/GAP4mB6LEekexF3S//6NrXP+hUZZ6Fat3Rg2IBUVlLKGOhlapbwx+DaCfENCP0ISdDToCc9iS980B4QpcD1SxxY8LsEqjxHXTFfA83jFBgfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHyRb2eXVKIGDk9LZUffkwr9kewERTI1JtMuI1W/mLM=;
 b=IeWdNYH47M+/1PJWu8e0ozuZeKv8sDlI0AnANgD5vROYA5ScVoXp6C+9zSkZ8PILHxCjZwCFhilxUQJ7avCprTYOMq+igbJbXSD9+PwkVropHJhmbK6Pk6xuITOQTZU6FbQbjkgEI9F1K8TUhxERt7gI0udFn2VcL5D4J/+SPRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9827.eurprd04.prod.outlook.com (2603:10a6:20b:652::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:08:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:08:35 +0000
Date: Mon, 10 Jun 2024 17:08:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/9] arm64: dts: imx8qm: add subsystem lvds and mipi
Message-ID: <ZmdrSpVfZr5sjPOO@lizhi-Precision-Tower-5810>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 5240c707-ebc1-4120-25ef-08dc89917dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|52116005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bt7I9jq6xOM32YQFKcvJNgXnXTFVRfHeoJyig+6d7LYn3nLjggOhOvT/qfNp?=
 =?us-ascii?Q?U0aayIQw86MOWs/tIr4BfeT2y/mjysAlcM1X7BPh6Txxw/JUahdhITituXRk?=
 =?us-ascii?Q?o2ynb6TgnATHzUwr4WBUQ3yHLG2MT/w4DkTbAxPDXvjmSl74w2NaF+6gfvlL?=
 =?us-ascii?Q?jddMCupd7b59lz/WHQwUjb7OuNcOvRjO3pKwh2NYpErmMYmWK4PxCd+/KGco?=
 =?us-ascii?Q?62PO1h1W2zqKUfacIkGDBgSqaTk2DFB8kMLl95gyc4nqiPLHx1AxR/DREUaT?=
 =?us-ascii?Q?x5SHapwM3y5I6Us5tp0tQMJ7DMBZ24+PDoe/8peQ989nlWyvhWc8PFEyu/V5?=
 =?us-ascii?Q?Q3+8drLn9hljsgqfe9ORip7VP8KeoLV0YUm1cMxxTrahRhqtrd9k8w8fOd08?=
 =?us-ascii?Q?cCoukVTmu5tpQ5YrTW5FyJTg9zPuBWZebarqdTGigNp6qSFban2bT4gXGh2P?=
 =?us-ascii?Q?wUX7eugW0W2A7FKdo/Oht1dm378SF2DoD07jiH0S9BS/E2AjkaC74cv9b1o/?=
 =?us-ascii?Q?H9665oFUPeynR6wEOfpeVxumRSe14BDA2ZtO8a60U+hnDSRZByn2bsTT7RPI?=
 =?us-ascii?Q?Ch5hEpsh5xNLZ8QRbE/5RXLzF85jRb+GWSgHozP2coFsOktuKBD0eT8R6rVY?=
 =?us-ascii?Q?DHLnJlj3aLi7JYdKzsqVD5JeX9TzDzMzfpownntqNgnFxVSrqdilIsJ7GZeX?=
 =?us-ascii?Q?X29f8wN8cKUsQrppWlKMbjgrS/vybMcTdjKYd0yopQwKhQ24o+Fce3VxXu/9?=
 =?us-ascii?Q?2n8VpLaS7apKTHJnLHTMwBYVRKf8PWBtKC6L/QaiWClzq3ZpEd8GfaPcr+D0?=
 =?us-ascii?Q?rrdpf3KleauNwmO6X7FQ4s6RWM1xu1UC2M0hr8BrnuO5PqgU7RsvhJcmeFre?=
 =?us-ascii?Q?nY+A0mSYCJTU+lgHYkbFu1zW7dgx4SAqZr4JxlqnCVvLhGif5mJR5p4E916I?=
 =?us-ascii?Q?I4Q6evo2P1TN4W2BMf+NUK/7HKzemWD8CKKf7YgzYxXZvVOAKFzTjzZlcZ6B?=
 =?us-ascii?Q?BKXKYKye5eJ6nM8Tqr+yaMtzPf9oTYXTN6AgsNRJH4ikgtwMXLFD0Lk5a33o?=
 =?us-ascii?Q?xfxvn2U/Yc0zfPppeU3qu9N2im/LRBY4xzdGISyLfpyqx3dbObP1rTpFms/6?=
 =?us-ascii?Q?pCdieyKFwpeEE2Qk0B7K07msD0LJnteiylqYC8XD/nrHdXo+s91ERadPnQZE?=
 =?us-ascii?Q?ze2+ija+hYCWAKvk6Ja6+ftWAhCl2vslRZ7I4k289Ef0q/7kPZdMBqa59sC4?=
 =?us-ascii?Q?QnxulYVCJsbzGOqHvZpusxkCDnTDD697f+vhHjsy+eMDARl3Jdeyepx6xN3w?=
 =?us-ascii?Q?3wvxuxfZWeOhH3f9brhT39zN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZYR5f02K4TGN0RIU+btvbOK3SvqVuxVrdghZqAPI4fMG42JCy+6W2nnqX9hX?=
 =?us-ascii?Q?gmVIzz+wxSqFRHe3lgk0qLhbf8LSJhqgGew+dVo6uHZ0NEu236uLIvtusVbj?=
 =?us-ascii?Q?Mqh+VFC+wgA9FTVfsngSc0Kbc3n0BmCat/pq+6XLHIBPsRYkqR0WTZrA7+6w?=
 =?us-ascii?Q?NcsNCWxx0kLyPrO68vGatNZY2xZKUwmzmK+rcMVSLWTBdua7cO9sjYlqR568?=
 =?us-ascii?Q?BQPtXIayQ0R27lIs5T/jbfwG2t3prjb8DK807VQGZGhkPmX+6qtRoS+STAQ0?=
 =?us-ascii?Q?XyTIuBMEJikC0uHSXi592Jk8wOZvgBHijfd8zzKmlOE0M6SKhDsvYqHLse28?=
 =?us-ascii?Q?B5aGkd1v7Lxsx3lfRd1nsQpaxafkln2hV5CYjrh0RNHg3K1kexua2ryii+zQ?=
 =?us-ascii?Q?kqPsF57gcalR3E2r+X2p+yLcR3Kq3YxgLolZrRJIH1BZ1gFSxoFCSLPj5rC2?=
 =?us-ascii?Q?n5hUMM0EVpChJTVObuILTqLVC1uuPF2x6pkMB5dT8UU/2FfJmH51/FTpiFG9?=
 =?us-ascii?Q?nQMTzLhLpksWSlIhKAcTzw+1qzaJ7UEJWcih7QpDLUZVRlaRuxcYW4Lo3Z7Z?=
 =?us-ascii?Q?/UxnJl3wr2qpIvnu/rQ+/nVw3AmCZJt7TQK5C933+hS1CDLJI2dPrjlupgy5?=
 =?us-ascii?Q?v1U8bFmYsoccfgd1cYNovwz1Wn4SfVyfsBxL24eG7YEHzAeXJ8zrmLg+AHr4?=
 =?us-ascii?Q?BVPlQxTd7ipB+w0uXNZkg9Y8oD8Ct4Nhwo3B/c7LZKB6op71laI0QlH992oh?=
 =?us-ascii?Q?LVQY9k18UJRiCkXVL5udEVsipdVJ6Z7FkIniMBDdACVnMw82tck2PXeBW0sZ?=
 =?us-ascii?Q?tyNteuZVd9mkYauE9UE5Iz7cwcXrFVXhEwY714e+276DWcipb+LP+fWQSZLa?=
 =?us-ascii?Q?SChQdovWQWQ5siLujEGAypbsncHMTPvs/q0ZemI0z8Vk+2Swf9Ye8TKGNJPK?=
 =?us-ascii?Q?SOm7+TpP6vD1v61pbXRjSGGZtPEQz4cXggTjnxtlGugPecHeply/HB2ZAF9w?=
 =?us-ascii?Q?juKOKUMSPIqWZpNEno8hbHZqmQldmM2ndISLPhBqcCRldBixX8R2Rbq3do/i?=
 =?us-ascii?Q?Sspr9xXIevKWa1VA4Y7Tki4ZeIqcaztlAdZmkRPKe5+Et4UYJ8OM2SiwoG4h?=
 =?us-ascii?Q?iJrbdsC+B11IU6ElQ/CLYminu9VwCjeGr/oT4TDXS1gol55xmHFXPwAl+i6N?=
 =?us-ascii?Q?ViuMcJ2gmtDYYhtYZ0cdDg8ugGFLx4202tjPdVEC6/lrU3xMDqcW5M1+g5uk?=
 =?us-ascii?Q?ke9VJ7ZZa8rOCvt3rF9vuce+NUYmIH/E4hbe8dkEriva5gw41CD0OZSVVnsM?=
 =?us-ascii?Q?Qp6+P2LsKtbL2qz5Qc29Vi5VGknQdPQZGo8txJTBci/Izjt+DtwHkwyNdeSV?=
 =?us-ascii?Q?Z7wq2t4uWzmFucA3p15QTnuVyW98mEaQtkEl4hixZFusvyXbXUerPjbT202m?=
 =?us-ascii?Q?VaHYp0938p+YrWos5b4gb7E/a5J072Ph27ZPKQ1oPoTQUwPZLpIOwRc4rZcR?=
 =?us-ascii?Q?rG0YGAyt81TmFBho0W7EgIy953Rv53MZpYsuYdv6tFHI+QArTUE4sTyHmK6d?=
 =?us-ascii?Q?EFDRrbFvSSz1jbPAHes=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5240c707-ebc1-4120-25ef-08dc89917dc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:08:35.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpfe13HIwlvu14lyoOqmNjGmvvIklEBHmo7qMtcsfDxyp2iTwCBAqfwXmi2BLroUmW28xy5k5uWyZetPJSPevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9827

On Mon, Jun 10, 2024 at 04:46:17PM -0400, Frank Li wrote:
> Add subsystem lvds and mipi. Add pwm and i2c in lvds and mipi.
> imx8qm-mek:
> - add remove-proc
> - fixed gpio number error for vmmc
> - add usb3 and typec
> - add pwm and i2c in lvds and mipi

Sorry, please forget these, a file missed to add.

Frank

> 
> DTB_CHECK warning fixed by seperate patches.
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#
> 
> ** binding fix patch:  https://lore.kernel.org/imx/20240606161509.3201080-1-Frank.Li@nxp.com/T/#u
> 
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: interrupt-controller@56240000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
> 
> ** binding fix patch: https://lore.kernel.org/imx/20240528071141.92003-1-alexander.stein@ew.tq-group.com/T/#me3425d580ba9a086866c3053ef854810ac7a0ef6
> 
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pwm@56244000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	from schema $id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#
> 
> ** binding fix patch: https://lore.kernel.org/imx/dc9accba-78af-45ec-a516-b89f2d4f4b03@kernel.org/T/#t 
> 
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-0: power-domains: [[15, 278], [15, 297]] is too short
> 	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-1: power-domains: [[15, 298], [15, 317]] is too short
> 
> ** binding fix patch: https://lore.kernel.org/imx/20240606150030.3067015-1-Frank.Li@nxp.com/T/#u
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
>     Changes in v2:
>     - split common lvds and mipi part to seperate dtsi file.
>     - num-interpolated-steps = <100>
>     - irq-steer add "fsl,imx8qm-irqsteer"
>     - using mux-controller
>     - move address-cells common dtsi
> - Link to v1: https://lore.kernel.org/r/20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com
> 
> ---
> Frank Li (9):
>       arm64: dts: imx8: add basic lvds and lvds2 subsystem
>       arm64: dts: imx8qm: add lvds subsystem
>       arm64: dts: imx8: add basic mipi subsystem
>       arm64: dts: imx8qm: add mipi subsystem
>       arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
>       arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
>       arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
>       arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
>       arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes
> 
>  arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi  |  63 +++++
>  arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi  | 114 +++++++++
>  arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi  | 138 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi  | 138 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 280 +++++++++++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi |  77 ++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi         |  27 +++
>  7 files changed, 836 insertions(+), 1 deletion(-)
> ---
> base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
> change-id: 20240606-imx8qm-dts-usb-9c55d2bfe526
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

