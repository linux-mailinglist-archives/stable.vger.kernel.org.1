Return-Path: <stable+bounces-109342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A28A14A83
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268F5188CE1B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307D1F7907;
	Fri, 17 Jan 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J4Lck2FT"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE509149DF4;
	Fri, 17 Jan 2025 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100662; cv=fail; b=MjVLohL2pQGba/H+6fFyPWyHLyqUO5z8ZmAMXSFAsixjgRdVmLHiWhVPjvKDmH4B4Tn5T7HGBSIRvN2W0u96Fa0oK76lcaKTPhBYx11v3i2XCbX/7WMfQlInBYs8+cpOxe3XxGGBGCr51My3X4iH+/HvO68Gdr59E/AJairKDTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100662; c=relaxed/simple;
	bh=i16nkI1xAhvp5aFHHCoASUAt6SRqg4XmRZIK+4y2vMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D7jlZhktWquJVfFSvHnIEh0aVUKK/Plvy5N8Y9VlR6JJz78R4wUuBVPu+wNiD+dQ5PswzTaRaqW2yQPvFMFkACu8n/7XCGFvf//iHUtzK5qJQHJe+JqfRyeGh0E4Z/SNl0N6uzUJC63/1ekTkw1bdH5co0ZYdcgkIZb917SzraA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J4Lck2FT; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8MwqzveKHmpOAAXCdDlwy7cINgoINj0utd9f8v9MsOWaFOg/GuKx5s4V+HItJVqAvXYikfq/7MpmMWiFwe6UjgmjSRfud/ssX/hTsPs22ICfDlnAqsJtq43cnCAM3r0lK3oTdNVIJYPeliEG6zNkILahEymjM8ZeHI6f8IrmOn3wtffV2KdC+7RDcoqVcCM7gwLyUhPsYNvM+iN2+gmlvQA6T82jeer2PKBrttS/61rdv/Xtpsd1YfcUY7jbBNhdha56dmwj0Mde92KBLOiZENYAuKeseu0FRK/UYmaZwCho5U8iKb+spsZFgrOamWiAl3TgZ2/Vb3YsZskh0aqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey+ZYCBrabg+J3FbbElJoiXxsQAyBvrhp01MHvHoRbY=;
 b=HS03T9ljOmgSv9Jsh5/QHuSlV2ZsNZuGTOg2+nPW7AAb2mdC2xAyQnAocqW6Qd1OJYRq59M+yotDG8Rw7GiKdj4MEa6rhneBBSXXidwVDwA3FxSVsGkrM7InYrk0fI58m+81eqrvXxZUdakLhsZdu9FDLXQRUwLKHFY/i5hP0jSERbheoEWvaM3ht3/YmvLguOErZbbgtBBHMHQSwSLbe8hBh2eYwcmXvGaGuVCiiKjTe+dmEQ07z3cvYoLydriLd6RlxJrX9ErrWwJYVIXtgWnZM/MYup7gbALrFUvWsl5mtrAvJ59wlir5t7FmweQKm53cdoTTBHoqbS85tId6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey+ZYCBrabg+J3FbbElJoiXxsQAyBvrhp01MHvHoRbY=;
 b=J4Lck2FT6BKw0Xq+At+TvcG/biav9jhU91FtE+uMlpNHng55X/WskpW1WpBEM4cgqFlyVvAXKrBtb+7FO2P7wiAk+2SVYWz0AbVMxhzcrskGD99OsBY/NhYu7ZxFdDX++y/RQ7ykTkalIBbordOPyw4pzdxWk8yrQKJe32WvVV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8465.eurprd08.prod.outlook.com
 (2603:10a6:20b:569::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 07:57:35 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:57:34 +0000
Date: Fri, 17 Jan 2025 07:57:32 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: 1534428646@qq.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobe: fix an error in single stepping support
Message-ID: <Z4oNbOGSluJlwpvg@e129823.arm.com>
References: <tencent_9DCAEBDF4D9BCDB4687B502DB6B608E4FB0A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9DCAEBDF4D9BCDB4687B502DB6B608E4FB0A@qq.com>
X-ClientProxiedBy: LO4P123CA0513.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB10521:EE_|AS8PR08MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: d525c78c-eef0-4ab0-5c4d-08dd36cc9a53
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBTRkxCQs2VGUol+mMFyc13bLjqAt141F54Sf/+yqjJUSideSgM8mm2IotaN?=
 =?us-ascii?Q?EWfBllDkkTYfU4Apbdm37F/POBRKEheXrwdgw9w6hZU3t5K/mNzKYD5OvCJB?=
 =?us-ascii?Q?4L4QUUncIqb8OABxp7DT/ESfIRWTju+f9MmNy0WqfN0YmNfQsfMH04FUMFPO?=
 =?us-ascii?Q?8k8Cj6dAfcP3MD6nN5rw4kI6atW4zRBF7i7JxCuleSJcNEXPx2l4l62hRPdQ?=
 =?us-ascii?Q?D79A26ZR1cekhir276wAwHoZsj84Xh3wSvgdWbDjjpNcARp67m+FoXI7I1XN?=
 =?us-ascii?Q?d0wYkwsLtBAgSx0Mu9JAYwPj9/Et0ulLoqJ04iCx1su2AFHcbN5yP+UfxDYS?=
 =?us-ascii?Q?R3sxj5Y2ZA+/OxPbZT4bfihqTWVCuWeZDHyEpRSbRyXnjrnGX2GldukKgsyN?=
 =?us-ascii?Q?U/ekDGePKdt6upveKcE2pZpZ4bM0s0qnSTWeHiFmwxMPPXUZpLLxDUyDcaQ1?=
 =?us-ascii?Q?XBHP5CObhcldTdBV5+tbOJuN/iyL/vWICIyZ3sLIS84zNPn7G03w/VZzdNrZ?=
 =?us-ascii?Q?vbA4jsRvAL15iBmAJywUuy1VKoG0QPlmmvukLfZ/o61d6X7MjFouMmNQOrtC?=
 =?us-ascii?Q?vMqPmOJVGuia92iL2uRVXtikrDnbwkq+DnZ9Lr0l02tpm8cFoUFkJZgq3DBm?=
 =?us-ascii?Q?ovSGEPkGVdrh7RROea67MSUgtfU9wKMJ9XFTeRMHdTnHfTZL01GjVXg7rky/?=
 =?us-ascii?Q?1rd5vzZUWWfcjj0aB28qpRWPIy1EN7vQU7z/EBCqSeE/SU186AmiCH7s4U4q?=
 =?us-ascii?Q?MYRmewFrgTOordpui/UjLPRmhQwluzQNDdmfMUjA+COEumcJh81nJT34x6YV?=
 =?us-ascii?Q?6X1Nu4mouBdvIm2C7kSe1Wia0HcrYomJp7V4gwJX0mmXx36Yd9m/TtGMKDoX?=
 =?us-ascii?Q?i2ifVXQYYwdHD9ohnfZUBWSw8wb6ppjKbW3ucf4uJFpkP6ef8U2HdJK+8Etx?=
 =?us-ascii?Q?2kw48DKGWva2PZg11miJLnsG1DzgCmc/gY5dViRelAqGWWll/ihdhUzpTm82?=
 =?us-ascii?Q?1vUZaMP1qWAFedSetjWn44UHxLDyyqoujFVlRu9g54Vvy3GsYEntPR//Uw9f?=
 =?us-ascii?Q?najnG6o+WQjx5ShpSki95zFdI+4q1wTJt4s3VOrtAl6kH3NBs5pi2ATYHtAX?=
 =?us-ascii?Q?RYiA5qcHAm95v19fa/+DFTp9BKT/lc42sfiC3jT49hCcvD4AWCSjC/zfTyxJ?=
 =?us-ascii?Q?m3JKs/XvVyV7eju0jXYvsyKchNXMYOwXsldKjH/TCKhfptuXsfkiZdSzGVpz?=
 =?us-ascii?Q?GY1ZUY7jHmx9u5Gq7JmWRwehUPghZ7mzh2xISrjmKFI2FuGMyM3SPE7UsZta?=
 =?us-ascii?Q?N6QpJXDOIzTv/0o48sDBC92BR2I8Su1wI3nW0h+ql6m8MZXRc7IqhnFmwGoO?=
 =?us-ascii?Q?jNfFGGONoQ7qzoLIb0ZTlhR6CKQ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utDaCEbse5ORdZwq5j8hLLkwcMhAMLQrbYCqY5aRUjhq4ZudmyUBYm1bbG2p?=
 =?us-ascii?Q?71hqddv6+kwWZvGVXpsCOkPF/2zuPIPxiWtti7rteHfwji1BSvEnAMCzkRs4?=
 =?us-ascii?Q?Cl9s5ZH1HdO94Ybe3Dg5lKGBJbti1YaiJugeBzE+QJd13mGYdlL0TDYaVOMI?=
 =?us-ascii?Q?0MXG68YkVxCMPW/y7sy1UPiXRCMoIZ/+85nqJgDszSzMZz6AcUiIc7eqO0JG?=
 =?us-ascii?Q?ZWmbqnn1txptWKrZIoRNsRkpweyFRzS9kUffNAU0K4nc/17Q5wTI7bokyB/p?=
 =?us-ascii?Q?yg26ZFDt9wRGqzFqWBoXTnerSXUQk0tXwWwafuB98j/IOzK9G4sQlaE02UxF?=
 =?us-ascii?Q?80ZTDutZvIBzdswbgmnnBJePKISsPI0QZlti4ZDrEc7XOSJohliORwQd/WV/?=
 =?us-ascii?Q?OrahTxeKNmp86hvck406PiEFZcSo9CWFRPQdo7aYiSgtSa2prtu/ExvyaFD/?=
 =?us-ascii?Q?jaNVwLeQoO+SMfpd86D/9a6jphQZxMsBQv4ot2LpV9jrMoBIWbezCbDy9FTq?=
 =?us-ascii?Q?+o9ExV+uHobo29hD6ww2lqxyzRQK/QIckifKVP0KNEzT1B1rJayCtFAHjKi9?=
 =?us-ascii?Q?LNxHxeMSPNQ8Cy4ko939bJweKbLTom0myhCHU1iNH4u+Z3F/Wl5CzqKnNxwq?=
 =?us-ascii?Q?JXdsuMn9EjRM+dHikixyPo0pJyCckR+TLcb1tr4opujmHFvBnkWuXRepfve5?=
 =?us-ascii?Q?qVDeDTb73eOB1ssSWzvsSbJgJsUh/k7pOMKfWZ4xwGrVAZXzoNiuvvx39ZeZ?=
 =?us-ascii?Q?BRNG39cb0RG1HI3WtzrN7M66UoHnPhlDp7JjHDu/Eu6c3CBjP629Szk0E5vZ?=
 =?us-ascii?Q?fmIPJj32a1HfbrmlPgYT83tfzrsHFpdFoEr8LBjwKtTvz+5GKn+Vn7ApkJmI?=
 =?us-ascii?Q?kqjV+ZyPFJUfEZPZQsbTbmf+p8Iwdwe8Vs+qK7wLsaU3mllSUWb38jTRl1iY?=
 =?us-ascii?Q?x8E9hBKS2RIg1nCDu2SDsqHy+32y1ggk0j1d4Oo179njLPh0l5KTTpwARl+R?=
 =?us-ascii?Q?gUxZAe660lGRqhL918MqHxxFIjii25OTJxZhvoxioXIOqDR2+vF0tYrocWJF?=
 =?us-ascii?Q?s/0JsLsCivWJWwD5JdAJvs/nROtWLoNwqGkv17p6abN2+Qzq5AgBNnEIrYOL?=
 =?us-ascii?Q?YOnOrsbvv13kxq0ZVxUzKAqkz9c0lZMqnKXuWG87allTy4Qr60Dh/+giekz6?=
 =?us-ascii?Q?TazbtwesmjRW/VXfu2TOAVtb7cHJEtBakjYdP06eLRMGuN7ecE6OB8X1+fw8?=
 =?us-ascii?Q?JdfvvBXNUm5LxIaE3yS6S9Fglt7RlszC0oAFMv0cq0pBUvhFXHh90Dzdy2bE?=
 =?us-ascii?Q?h5i+yqhWQNIXNEq6mWUVX2Qp0J3AwRRqwZJlWWd90W+m82lJK+Fc+n4XGZl/?=
 =?us-ascii?Q?92eA93fc0dWzsDSG6e5SVgG7QR1TwxUbW+g6r7/gYLFhBLCyFlTZxtTuitre?=
 =?us-ascii?Q?JPdZdtfRR10Gdmcfb86bn3UbdUYzR42WKmO2yxtZzbYbBPjajoenA0zZP/TZ?=
 =?us-ascii?Q?+cXWX7Q6V2xz7kGqPANoDjD9+/kCq2zapsAlzVuUB2Uli0hJ8KUZ7/HSP+gi?=
 =?us-ascii?Q?BdIBJMVMjLrq7oQl4v10h3V7a94gY9TKdEWxb1uu?=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d525c78c-eef0-4ab0-5c4d-08dd36cc9a53
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:57:34.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqMDKt/PYi4VeHjqMVILw7cxu/XCm9NPmKB2kQ05iOASZje92YW+VhKRNQKY59bwuWs631dyC3t4gmmnR7bsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8465

Hi,

>
> It is obvious a conflict between the code and the comment.
> The function aarch64_insn_is_steppable is used to check if a mrs
> instruction can be safe in single-stepping environment, in the
> comment it says only reading DAIF bits by mrs is safe in
> single-stepping environment, and other mrs instructions are not. So
> aarch64_insn_is_steppable should returen "TRUE" if the mrs instruction
> being single stepped is reading DAIF bits.
>
> And have verified using a kprobe kernel module which reads the DAIF bits by
> function arch_local_irq_save with offset setting to 0x4, confirmed that
> without this modification, it encounters
> "kprobe_init: register_kprobe failed, returned -22" error while inserting
> the kprobe kernel module. and with this modification, it can read the DAIF
> bits in single-stepping environment.
>
> Fixes: 2dd0e8d2d2a1 ("arm64: Kprobes with single stepping support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yiren Xie <1534428646@qq.com>
> ---
>  arch/arm64/kernel/probes/decode-insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> index 6438bf62e753..22383eb1c22c 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -40,7 +40,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>  		 */
>  		if (aarch64_insn_is_mrs(insn))
>  			return aarch64_insn_extract_system_reg(insn)
> -			     != AARCH64_INSN_SPCLREG_DAIF;
> +			     == AARCH64_INSN_SPCLREG_DAIF;
>
>  		/*
>  		 * The HINT instruction is steppable only if it is in whitelist
> --
> 2.34.1
>

Thanks to correct me. yes the comments seem conflict.

However, I couldn't agree to this change.
As I mention in last, when single-step runs, all DAIF bits set,
so, the result of reading DAIF is different between before install kprobe and after.
Also, I think reading some sys_reg in single-step seems ok (i.e. SYS_MIDR_EL1).

Therefore, allowing only install kprobe on DAIF reading doesn't seem
correct.

Thanks



