Return-Path: <stable+bounces-161850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B42B041CA
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A714A1DD7
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9521258CE8;
	Mon, 14 Jul 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ghajok1J"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5C2571B3;
	Mon, 14 Jul 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503683; cv=fail; b=JWNvbsH1WoKL4kq2ELKd+VegmwFZekTx2IBsCBrR2vcLFS3D2eWuJQ4Ps9qEEGJ9Qzgte8BbCX+Nx1PpIFGfZ6gynxIDnAT0QztXiSSoAsWCfY/BEakFw29W5ksqAM4PAvX4EtwAbx2w3djKEMP+/2wcoKmTHV+Q2McqxAmfrtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503683; c=relaxed/simple;
	bh=ScviKPgdS328urVqR/7gEebA59QzRvspT01uvnXc/BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LX5+ZGTCSK8gVzv0An2jA95ebIsiXiaQIuVSbqJhoMGL7BIYW7QS4cFxNRtU6GFHQY4QcidS58DPnjl0XkuH1ARB/e7/V9MfTeR8f2ZoGPyBQPLS1xLWRf/NMpQYBudUi/rFTbFaq7/zCK4NG8njPhRULkeXY0+4/RxLMasYkQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ghajok1J; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ2X00qECoOZhBPCYoNbLoZALaLKG0B28K3XPP6PzK30VfpVKbftiEpCS7L2mG1sbz0t9TRYI9vXWFyJ6oJkYTvdci0UfbtqExedLO7RIkUw3+v1QIyCmiUrZQNGwPrHqif31dpbK8+bqt/IrbIsBhM8w030pZ1uHk24DzqPzYYBkwtO1EcyN5pXbmG0dk6jo1nXka111qLRSyv4tH0IQjBo5Vr14I/YdNx7ketFYlxJ3+RjSVy4q+JmFAyZ9Sn9iE4Ocbr3CaV92gQN6t72ecoNzqjrNbQPA9H9hEZncAgTC3BRtlWQJaxSr5N8N8HiqNGV4lcEPjOfpsnSTcAYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9tlY/7f+8wp+KoYmt10mx7AhTj2JBt2OZu1WFyCW2M=;
 b=ZGitQ3cLmsQsbohp46SPRNWmndiKzULfksFzF1e2A4kgaQJsnb4T9SIuK0QHEANnjLicUdoK8tbAicFEBy+oW67w70JHZkJ2Gl+eiRCLAVPQpr6dqLPI4VodaBf0FGFoZ06fJp8lidNP5ZkCJxrUHKynscWlqPkjBklbzu9AlfnqdZKpJIZoqOt0wQkKRkUAHPLd0Nc23ln8eALo/kZekg6WbrnEPyP0LwGx5XXti0JC+CW8IARFTaD9Vjukws4tC0IUozVkVwKe0T7kqh6RyVQRvDNzFSXzSsfAPy6PjGW/J287ee2V7P7myeXX45M693gQG0ksT3w3o1YtCCpbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9tlY/7f+8wp+KoYmt10mx7AhTj2JBt2OZu1WFyCW2M=;
 b=Ghajok1J34oh55RWuJlX8foSqzOrREwTRu9kX+AkHAFyDklSMFcpVWLn1eVFlH+85PeletmNZQ+ZQWenPmOoMJKn4uBlc/U8TcUD0t2cHDpQe1tpf+mqf4FHdLOSrAIMNeWD7SGlsXbsYvVN9fpkap3AL/SlQWFld11eCmmWBJ2MVHwFEAwmr/KLOPuOBL6TAZwBWeyyr7D+oCaE06n1rc5lH6imJDUTjiNVNOTA6Qa9/sVE/OGZJh40g9QeUPcQBB4lfKlITiii9zRJOdsMZu6t7BQhSrAM/PMOYqf8rAX41YUg9pvFKe8HdZIbc95S8vmiEw+ld4QZ0FtVd2ySXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 14 Jul
 2025 14:34:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:34:37 +0000
Date: Mon, 14 Jul 2025 10:34:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Jon Nettleton <jon@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio
 to support bus recovery"
Message-ID: <aHUVc5SV3yzhDBf6@lizhi-Precision-Tower-5810>
References: <20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com>
X-ClientProxiedBy: AS4P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ccc78c-4f59-4a58-164d-08ddc2e38f32
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PIpXzo6vtw7Wik6LzN5k7XjwstN0GsdRjtHD50B6tSV89mbJPhdLYO/PlXdh?=
 =?us-ascii?Q?tf5Z9YtNTKqJrfql5DWIU/D1OkFQcUt9lWT2TT+2IsCLyhQIxpccK7p0DcNc?=
 =?us-ascii?Q?VG+/o2m2hx2UM0sMK8VysTEuTbf17c15fAfpNDWg/pp2g0XfPA0caYpYk2V5?=
 =?us-ascii?Q?HJJTvu7O9Vj9D43mVIajDw4Zxr5uvXdNuJwYwX5TTSk0Db7BXfM0AAPWZuws?=
 =?us-ascii?Q?9flEBJrSxVlydzn5xhaFwcG4uwnQDaA/QEtJBiAsxCFmP3fLefT1olbv0F9C?=
 =?us-ascii?Q?8FTPoQcY45w3G+UIU5d+Ao7LQaAhHuJdNTtB+b14QXnFob7pL7FysZbo0+ce?=
 =?us-ascii?Q?w0Z/L7A/nxfniyRykCNfJI2pjlUubekXVIE/8XEpMAeaqyrMJvrnaaSWTJbY?=
 =?us-ascii?Q?1BCFB9YqYEp2OSt/h+vxiYmpFL2VMb+mo3BvnFAOGOoDj5B150OE+M/OEjz2?=
 =?us-ascii?Q?P4zVzxVLJnMwMw6x2QacESTmmt0psYpjmHNn1eqan/140vASls2bdHURUfsB?=
 =?us-ascii?Q?Yo3HFr9rK+5nNbVc39uP4k+845wKnOW5E6gSbGRceF1E5903+1W7cIzamkAr?=
 =?us-ascii?Q?Z6SCpLf6VY1k0kWIwT2dcjpdu/udkb8+pIeZHpTWWqyw+5+kBQjtN9VbdJci?=
 =?us-ascii?Q?IHeFlqmRKFFQeGm03oaX9eR4KIUVIo6oko3wJUNsiviH+Jsksm2yes0fXYzH?=
 =?us-ascii?Q?NvBjPVvfmcj3tZPjNVApfkiprUFRMw013cAcNEMxKQRcEnssrVCPtgyYLqb5?=
 =?us-ascii?Q?omcCsZ4FRnK51OOjdj/IdbwmMJK1LdVLQ8iZhB/SrXJ3Ei/kEu9Tud3sS8Zl?=
 =?us-ascii?Q?WLiwtmmCArzv4/dRUgzlkuJlp1i+y3EZXRsrf4nTRTh9L4t/CpbFMQyOG5Pp?=
 =?us-ascii?Q?COE9y+W2hVprs6u/Xrt5QbnS/dAzQ2GnXgo9QalWPYhYkVvky1uxNkHqHPIU?=
 =?us-ascii?Q?+qaDbIPfDPKUgwbcHVQ+yFBiZksk31Vs/nZEckkNSuaYXG2+0PDIpQlRV8ty?=
 =?us-ascii?Q?ivDJp8beGZWlAqfJoYXMGEylV5ukqxzNi60356/4Ivrwp4OWiUDMO1tCxi5b?=
 =?us-ascii?Q?Lyt4cOp0BWyBeydxkWGdd6weTTFDjpmIEDOYcQfTdoFXRwifM2uD55NuujY5?=
 =?us-ascii?Q?zGq7qR1pTg4zl7F/bzEclzHYpc/ytfLLMBjeMUdKL4yYpc5/IFS2slDAkqlu?=
 =?us-ascii?Q?orZ2CGH4VIIzx1eyGotfdILmA4MmoOxb2nRV27PqX0ybupL+OC7jYI/AbGxZ?=
 =?us-ascii?Q?rFcnaJ1bXkbqugV0nlbFSQWC0r/4uLoRAH+ODL/34lCSz6vAw3lkY7abfPGR?=
 =?us-ascii?Q?fDLmmiHwZq6LmU3Ln05vbapaIJWSyt9+bc3+42S3BFHE8cCEeSR5Uc7ujdLN?=
 =?us-ascii?Q?s2SuKrju82ANJBoWSpem9/C8RLrLGcP4SlzMSu5eKRcvMpNV7vqLAeZPUC/s?=
 =?us-ascii?Q?9/fN6T9pcNAThQRJuczkZ/jFqvzx7Ajb/pSGuZ5mI0py1oDkjBH7Ug=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ntPh1T4vYDZaJVIrxupUZGdNmczSGWJEeo/yL8z1FGacHsMfsBnovOqob4PT?=
 =?us-ascii?Q?ds5Oux+vUZ51rNkFbkeL+0yezf9EPEG4VguYwzPvBOnTc8b7s0KGMMFN8kI8?=
 =?us-ascii?Q?0NuOfCHCfwN96c8FaQnfMcGcH7vwvKh7tjkfOX5dgxfyDfPFTOboYHPsN9pe?=
 =?us-ascii?Q?x7hY5TlaDjFt5AxiBdFaQbK19sorR0GLmAiIYzZ52JLsti7SzgHHh9vQVS2G?=
 =?us-ascii?Q?4rxmhFxEP1e5AWqI9zjKqACW178PLl2TlLTZB0DHV6/9+wRMsXxmB5vUfwu8?=
 =?us-ascii?Q?ibU49SYnqfs1jmwc8zYs8mx3Q1l8EqgDDz2PioVlPuodhfpG3Kooq5ffnToq?=
 =?us-ascii?Q?6M/pfJBkfLsEyVIrQN2tYmILkdGF80b7UpxxNYLowYhirJRQOVi6R5AkLSoS?=
 =?us-ascii?Q?iqNIQNPzhaXq9cv/pOCmEeqhHCOGB1RxR9ylpR24bplxAejAWBvwsgfwyvJj?=
 =?us-ascii?Q?3Yhb9uOUq2yCxqejTSHdZ41ey8LMr3NXptxblhya8WKtYj+4W/A8qEsjCvA+?=
 =?us-ascii?Q?Fwo0mJt81jj+RWS+alpq62UKhTvF2Q0bXP10HHhML/7CfwemR1yxtEnpI1M1?=
 =?us-ascii?Q?d38MrjMfKee7l1kpHLkRw519vvrEsOd7bcilzKegbB4eyc7tRsfYo30am60q?=
 =?us-ascii?Q?pQRSn+ERU/DmK+1SNpki+jmIDe+5pHhaQ9g+jiBYywrUawGNPPHMqT9d2/9k?=
 =?us-ascii?Q?WWlKpnYQDQhVeYTiGDryIi9LNUmrZkCTBAY3aQ2S1NEGcwt4CiIGviyhT+vO?=
 =?us-ascii?Q?kOWFjaiYPrsRJ3fsI9czArG0JBHU9/C8mfzBUvaFoHZIV2RsWZqArXAMtG9T?=
 =?us-ascii?Q?tkjndqEZv3NpTyvY8V9SK9Fmrm8YiHNidos6O0iusdjN2IV9xpD1E3ALW+rS?=
 =?us-ascii?Q?Nvo6wUmVfP7r5NBnZ3IVtJ8YwC/lM4wis9meXcrgZdxXEU+Uv1FHs/JcqCn2?=
 =?us-ascii?Q?jrEeblei4ZqUDnZwN3wDCh9YKlp8rFDDwm32u5Nmp6ojMLmwNr1qg33Nf30x?=
 =?us-ascii?Q?hsLlNPRPNNjBQW3jSVDkLNbvjTjH60EodmjGrEEQaIkdqzRFD/IKv10QNoua?=
 =?us-ascii?Q?MoHsqUoQTeMilIMF/u984CDXrzb3SPHN5qpddV4IcgU4bS7TAzKetKFpmKh0?=
 =?us-ascii?Q?AAMpmxjsX5OyzcbHYXYm6VVtC6C19+uK8AbHTeTpFjJmPIMSyKEOX4i9CtCe?=
 =?us-ascii?Q?qnHcRqyDEhcAptxov4AySqExSmMiuvqPJwmMQ6o4W/kwm7dcxFuXaKWphKjA?=
 =?us-ascii?Q?PHiBr5B6JE8E/b6dQINk6xQDhkM23HvDhXvxqz/KbDgF/lx7Fe+WU3UgHZ3A?=
 =?us-ascii?Q?pgyGuD8f/hw/pyAlYRh+smeD+Uj2P0JqQOAyXBawPy7Hh65q2RTKmXGTbeID?=
 =?us-ascii?Q?YSf0yz5BflN2DmkLnTe5oZLXYAUdEKk0ggaZ+StGjjTWoortOZpkTMham3Mk?=
 =?us-ascii?Q?obPKzIcEh0LPuQHpieLPcTq6STkLrkgb9ggH/XMMbUusJCwAptzrC04rKo3I?=
 =?us-ascii?Q?c4z17/2F8BJA2kiDbS7To0W24QCL7hzqJ0ASyqJPSajdeFPEOjR5/xD7plj0?=
 =?us-ascii?Q?o/isODQWGq0dPayT6kpa1V/s+eQ9CZJPQUMxELbG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ccc78c-4f59-4a58-164d-08ddc2e38f32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:34:37.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGkpZhVEIjNfQ7XhpELJRXznH9WbHBUX4MrRQhPoUikcmi08NnySkVfG60MNxE3pZHPOLxU+PDQ/zIlU1giVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

On Mon, Jul 14, 2025 at 10:44:13AM +0300, Josua Mayer wrote:
> This reverts commit 8a1365c7bbc122bd843096f0008d259e7a8afc61.
>
> The commit in questions most notably breaks SD-Card on SolidRun
> LX2162A Clearfog by corrupting the pinmux in dynamic configuration area
> for non-i2c pins without pinmux node.
> It is further expected that it breaks SD Card-Detect, as well as CAN,
> DSPI and GPIOs on any board based on LX2160 SoC.

Thank you for your patch. I remember we met similar issue before. Let's
wait for carlos is back about in next week.

I remember uboot should copy RCWSR to 0x70010012c. I2C recover also is
important feature.

Frank
>
> Background:
>
> The LX2160 SoC is configured at power-on from RCW (Reset
> Configuration Word) typically located in the first 4k of boot media.
> This blob configures various clock rates and pin functions.
> The pinmux for i2c specifically is part of configuration words RCWSR12,
> RCWSR13 and RCWSR14 size 32 bit each.
> These values are accessible at read-only addresses 0x01e0012c following.
>
> For runtime (re-)configuration the SoC has a dynamic configuration area
> where alternative settings can be applied. The counterparts of
> RCWSR[12-14] can be overridden at 0x70010012c following.
>
> The commit in question used this area to switch i2c pins between i2c and
> gpio function at runtime using the pinctrl-single driver - which reads a
> 32-bit value, makes particular changes by bitmask and writes back the
> new value.
>
> SolidRun have observed that if the dynamic configuration is read first
> (before a write), it reads as zero regardless the initial values set by
> RCW. After the first write consecutive reads reflect the written value.
>
> Because multiple pins are configured from a single 32-bit value, this
> causes unintentional change of all bits (except those for i2c) being set
> to zero when the pinctrl driver applies the first configuration.
>
> See below a short list of which functions RCWSR12 alone controls:
>
> LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
> IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
> IIC3_PMUX              |||   |||   || |   |||   XXX    : I2C/GPIO/CAN/EVT
> IIC4_PMUX              |||   |||   || |   |||XXX|||    : I2C/GPIO/CAN/EVT
> IIC5_PMUX              |||   |||   || |   XXX   |||    : I2C/GPIO/SDHC-CLK
> IIC6_PMUX              |||   |||   || |XXX|||   |||    : I2C/GPIO/SDHC-CLK
> XSPI1_A_DATA74_PMUX    |||   |||   XX X   |||   |||    : XSPI/GPIO
> XSPI1_A_DATA30_PMUX    |||   |||XXX|| |   |||   |||    : XSPI/GPIO
> XSPI1_A_BASE_PMUX      |||   XXX   || |   |||   |||    : XSPI/GPIO
> SDHC1_BASE_PMUX        |||XXX|||   || |   |||   |||    : SDHC/GPIO/SPI
> SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI
> RESERVED             XX|||   |||   || |   |||   |||    :
>
> On LX2162A Clearfog the initial (ant intended) value is 0x08000006 -
> enabling card-detect on IIC2_PMUX and some LEDs on SDHC1_DIR_PMUX.
> Everything else is intentional zero (enabling I2C & XSPI).
>
> By reading zero from dynamic configuration area, the commit in question
> changes IIC2_PMUX to value 0 (I2C function), and SDHC1_DIR_PMUX to 0
> (SDHC data direction function) - breaking card-detect and led gpios.
>
> This issue should affect any board based on LX2160 SoC that is using the
> same or earlier versions of NXP bootloader as SolidRun have tested, in
> particular: LSDK-21.08 and LS-5.15.71-2.2.0.
>
> Whether NXP added some extra initialisation in the bootloader on later
> releases was not investigated. However bootloader upgrade should not be
> necessary to run a newer Linux kernel.
>
> To work around this issue it is possible to explicitly define ALL pins
> controlled by any 32-bit value so that gradually after processing all
> pinctrl nodes the correct value is reached on all bits.
>
> This is a large task that should be done carefully on a per-board basis
> and not globally through the SoC dtsi.
> Therefore the commit in question is reverted.
>
> Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v2:
> - changed to revert problematic commit, workaround is large effort
> - Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 106 -------------------------
>  1 file changed, 106 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index c9541403bcd8..eb1b4e607e2b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -749,10 +749,6 @@ i2c0: i2c@2000000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c0_scl>;
> -			pinctrl-1 = <&i2c0_scl_gpio>;
> -			scl-gpios = <&gpio0 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -765,10 +761,6 @@ i2c1: i2c@2010000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c1_scl>;
> -			pinctrl-1 = <&i2c1_scl_gpio>;
> -			scl-gpios = <&gpio0 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -781,10 +773,6 @@ i2c2: i2c@2020000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c2_scl>;
> -			pinctrl-1 = <&i2c2_scl_gpio>;
> -			scl-gpios = <&gpio0 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -797,10 +785,6 @@ i2c3: i2c@2030000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c3_scl>;
> -			pinctrl-1 = <&i2c3_scl_gpio>;
> -			scl-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -813,10 +797,6 @@ i2c4: i2c@2040000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c4_scl>;
> -			pinctrl-1 = <&i2c4_scl_gpio>;
> -			scl-gpios = <&gpio0 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -829,10 +809,6 @@ i2c5: i2c@2050000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c5_scl>;
> -			pinctrl-1 = <&i2c5_scl_gpio>;
> -			scl-gpios = <&gpio0 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -845,10 +821,6 @@ i2c6: i2c@2060000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c6_scl>;
> -			pinctrl-1 = <&i2c6_scl_gpio>;
> -			scl-gpios = <&gpio1 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -861,10 +833,6 @@ i2c7: i2c@2070000 {
>  			clock-names = "ipg";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			pinctrl-names = "default", "gpio";
> -			pinctrl-0 = <&i2c7_scl>;
> -			pinctrl-1 = <&i2c7_scl_gpio>;
> -			scl-gpios = <&gpio1 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  			status = "disabled";
>  		};
>
> @@ -1700,80 +1668,6 @@ pcs18: ethernet-phy@0 {
>  			};
>  		};
>
> -		pinmux_i2crv: pinmux@70010012c {
> -			compatible = "pinctrl-single";
> -			reg = <0x00000007 0x0010012c 0x0 0xc>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			pinctrl-single,bit-per-mux;
> -			pinctrl-single,register-width = <32>;
> -			pinctrl-single,function-mask = <0x7>;
> -
> -			i2c1_scl: i2c1-scl-pins {
> -				pinctrl-single,bits = <0x0 0 0x7>;
> -			};
> -
> -			i2c1_scl_gpio: i2c1-scl-gpio-pins {
> -				pinctrl-single,bits = <0x0 0x1 0x7>;
> -			};
> -
> -			i2c2_scl: i2c2-scl-pins {
> -				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
> -			};
> -
> -			i2c2_scl_gpio: i2c2-scl-gpio-pins {
> -				pinctrl-single,bits = <0x0 (0x1 << 3) (0x7 << 3)>;
> -			};
> -
> -			i2c3_scl: i2c3-scl-pins {
> -				pinctrl-single,bits = <0x0 0 (0x7 << 6)>;
> -			};
> -
> -			i2c3_scl_gpio: i2c3-scl-gpio-pins {
> -				pinctrl-single,bits = <0x0 (0x1 << 6) (0x7 << 6)>;
> -			};
> -
> -			i2c4_scl: i2c4-scl-pins {
> -				pinctrl-single,bits = <0x0 0 (0x7 << 9)>;
> -			};
> -
> -			i2c4_scl_gpio: i2c4-scl-gpio-pins {
> -				pinctrl-single,bits = <0x0 (0x1 << 9) (0x7 << 9)>;
> -			};
> -
> -			i2c5_scl: i2c5-scl-pins {
> -				pinctrl-single,bits = <0x0 0 (0x7 << 12)>;
> -			};
> -
> -			i2c5_scl_gpio: i2c5-scl-gpio-pins {
> -				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
> -			};
> -
> -			i2c6_scl: i2c6-scl-pins {
> -				pinctrl-single,bits = <0x4 0x2 0x7>;
> -			};
> -
> -			i2c6_scl_gpio: i2c6-scl-gpio-pins {
> -				pinctrl-single,bits = <0x4 0x1 0x7>;
> -			};
> -
> -			i2c7_scl: i2c7-scl-pins {
> -				pinctrl-single,bits = <0x4 0x2 0x7>;
> -			};
> -
> -			i2c7_scl_gpio: i2c7-scl-gpio-pins {
> -				pinctrl-single,bits = <0x4 0x1 0x7>;
> -			};
> -
> -			i2c0_scl: i2c0-scl-pins {
> -				pinctrl-single,bits = <0x8 0 (0x7 << 10)>;
> -			};
> -
> -			i2c0_scl_gpio: i2c0-scl-gpio-pins {
> -				pinctrl-single,bits = <0x8 (0x1 << 10) (0x7 << 10)>;
> -			};
> -		};
> -
>  		fsl_mc: fsl-mc@80c000000 {
>  			compatible = "fsl,qoriq-mc";
>  			reg = <0x00000008 0x0c000000 0 0x40>,
>
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250710-lx2160-sd-cd-00bf38ae169e
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>

