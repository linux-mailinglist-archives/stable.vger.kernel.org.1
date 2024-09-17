Return-Path: <stable+bounces-76587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDBE97B0CF
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC91F2349E
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62526175D2A;
	Tue, 17 Sep 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FYwadpim"
X-Original-To: stable@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2090.outbound.protection.outlook.com [40.107.121.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263417335E;
	Tue, 17 Sep 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579961; cv=fail; b=NVHeVzy4tn4kx07vS346696f17Svwvq2Zg8t8PJDQMyQi6gVbVLMPLtiKGKnoQVvkGUhu8V+9rjenZiJZnQBuPplrjVmRf/C2UTqSxgr5amKvUAcDG/Ua/UxeLhJtSrf9pGc9F9TifgL21sWbGMUnJHSXeuboNXy2Tl0GfCia5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579961; c=relaxed/simple;
	bh=2OrKskkr++VoPjkambW5d1i2o3TKDtzya8kLlLous5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FD5Gxm4Vhkx9TNSomEiPTqVwmK++ijTeWX+sWyam3QOP1yfjyN+8cdS6ar9wpbAWc9l+9yX4Qul++wsiKtiz/3M5rk0Er4Afk7tDvK4D0DNenQtFlpVfM+/fuGGe1WttzsLDNCc0rVq6U6pSy3WNxu50y9aq9QIvilmw9rFzWzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FYwadpim; arc=fail smtp.client-ip=40.107.121.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9Gp+oKlCTEqRUEVtxJKxGFbT2D40fQZ5P13q62nix5cSspre0yCEBhQzt+VyPb9A3g4wyzKsTG1tF6xrC2Md9JvvoUPWriG37z9UB/OlF3Z6QJINyQcmlPTFX0WNUSkBS9Yd5kSY7zrfv8gOn6cP+7ZuSQbIyhZ9SHJQXEkt21Lh15wKlLUQqzKJ0N5FqmkG2fIQKzvlLrRxeg0b6l3SPAemm3xl36YR8TFc7EQcAx2MPL9yIQ2iXKwwFQ50avBIo5H9J99O6WB3LY+1JKhl5z9mvvKPnWbcNG0nv0QQFcP4oqSxFQnMHVPPy+5IH0quESMWWnJXtnqaI5EauFdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC9IopL3tN9pMCZbGTUtfB0Uvbt5qvw3/lUplWcBiso=;
 b=OQRkr5uZ5vB9v8z3u3YA1UG+vI9Qjn+MjuT5LXOcMU711BTNXBnaeYtMlmvvdk+gm7qLKTbBjytcTF2Bk90wC2lI7xm7wncM7ycD7n0BlSNg31YiX5PYnCGoEr/Na5ioznnPuDNIKKpyfC9Z91g1DYduJdkU9j9SD3/CcYXgKzzyTnDY7x5a64cqGEbyrV9lvuTEcrhdORqNjtK2XGX06apQrflhpLehcpiDcH81vEY3Pu/GlVRDHTOGLPDSxJBRAtBlv/IEItLCgbPRes7BMj268xVxf5kEu5jfpZDexVciIkfrJrz+xarXQFfsl4UBRHFXMhAetSJHKBqXwE2JjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC9IopL3tN9pMCZbGTUtfB0Uvbt5qvw3/lUplWcBiso=;
 b=FYwadpim4nyprUY+1XO3iR87s6Oa7IRkapRqfbM4osqceUCxLHm33uqGBC+HqJucTT13K9IGAbqhPwV1BCdCFRQRGRvkQtetD9o54p6lAbXnR01N/58U4y8XlT6E5eg2BUNv6pCZ2DLYQoYk6l2sVBJhOWS5WckHairTH9NGt3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB3613.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 13:32:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 13:32:36 +0000
Date: Tue, 17 Sep 2024 14:32:34 +0100
From: Gary Guo <gary@garyguo.net>
To: Jason Montleon <jmontleo@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 aliceryhl@google.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
Message-ID: <20240917143234.4b213175@eugeo>
In-Reply-To: <20240917000848.720765-2-jmontleo@redhat.com>
References: <20240917000848.720765-1-jmontleo@redhat.com>
	<20240917000848.720765-2-jmontleo@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0418.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB3613:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f0d797-5658-4931-4af3-08dcd71d3151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqDCNKDeU5SYztwZ2tq6fgdDgr7tFQFOIJWGrhp3EpjqR7QCk2g4atGVKvE/?=
 =?us-ascii?Q?gj3ny4dFbo35oMWkPNVDYHvYIx/eN1yIIfHXa4MJyyioqsSuNMi08ZULiImn?=
 =?us-ascii?Q?ZoP0s49t7LuDOXMleDMJkH/ZH0UPXiml0qLEtgHu0/sydGUSb/HpOwkQaN3X?=
 =?us-ascii?Q?/iqplDP4ltrxrzaL72xjQbZ2GT33Kuf9rCiUnX8GLp0+dCItcWKBqifDB2LF?=
 =?us-ascii?Q?IZyX/3V2p51Zp6+WPUlDq//nQ1uL+Tz8E99lTiLuajerB5RhRy1cKvwInqwQ?=
 =?us-ascii?Q?1BSHsZHKUJQZ0XhBMLLYwordA3w3KeCvZ7SoAuDOYW1h1zo9FYwHmvi1NI2O?=
 =?us-ascii?Q?u8a5SpYBHpCViLWabLxEC+FUdOAPnG7u51qGK3CuXHigeZFdg7qdCfWPhWnq?=
 =?us-ascii?Q?0EZoo0xgCdFHQXs2K4/O0+VQOxGeyGbm34aZHhrTjoE1xPMbd/+Bi6yjWP1d?=
 =?us-ascii?Q?pf/DWlmH5iNSOzLELDysSYEwwFKlnp4Bc01/o9OkHGx5s2MGC4xEn3F9+ksW?=
 =?us-ascii?Q?JZazWOqDyrkQvPpSPPA4d8D1OOiWjUOOi0X0Z9hg/OG6pwicfyQuQ0a/kIaq?=
 =?us-ascii?Q?Q2AGz0HIsVjYhmDAFeH6sLf9FvOwoZEZIBSH/LeCWO7LomqqVIB3pHlm9aSh?=
 =?us-ascii?Q?NyyEqlDteDSGeWmARXM56rMAiSm8DgtNsYKYiDvxPoHOakyZzrmPIvKMgANz?=
 =?us-ascii?Q?DUg2trFg+RdYxWlSSfEgMBdRhAtUK0mZvCm0G4sNJTQNz060JstsslJK0yKv?=
 =?us-ascii?Q?f8JeXGMTGW0G7sojmiA/YmwJYLSvG/Qq6t85Y8nePjU60tjrT/wwniUAOuLe?=
 =?us-ascii?Q?9bTKmO6sh/pDjiJ3dfIXJhoWDj0xN4+nXNw6HhsZbazffpMHsALbPvOIyhe5?=
 =?us-ascii?Q?GK6vuC0AheSgiq4pNDMl2Dm0qBRcjew/wLvsb5DlSriYcvDOYI/bufoplgBZ?=
 =?us-ascii?Q?v+01IUzYVd50zMta3uaE7CevZE+8nbtx6eQyvE7Upoo8JVboW15KIeU4BwVs?=
 =?us-ascii?Q?Us8CufG4EWEhUNRRXCBJWpOw2dCvqgS2qmS34Xu95dcKTYix82WQ2vM8IpSt?=
 =?us-ascii?Q?PAtfo2qJoUFFNB7pOlR/x+bmxW2fkhKis68Dvd2URot3uf4zshNKgmq36ArC?=
 =?us-ascii?Q?UZtwGhK2RBXPo5nMz112R3MA8IxT/VTOh3ltBJucUWA7FKV/EmMGYSoIbcGM?=
 =?us-ascii?Q?7VFQ36n6ra96LY80otnDnvnV1/hjvaX+MtWP4LV3Bk4hLim/z8i5tJ9mmHJS?=
 =?us-ascii?Q?8UiFDNwVtsz4FbCd6d6XbBNCLaU6KGYom7ArYPQVUdu+ce2LmPLJMnzsdIEH?=
 =?us-ascii?Q?cBYvMchT7pvlOPTWOrNh8CnFUXAX/JzIfKJgHZDjfx6P0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tfBNjbd88HXqoXagD2231LHOIaH9dhWh9neTvMLn6hGmoUMRAMDzchbCGYB?=
 =?us-ascii?Q?4NtAKYSDmXsSaxChWf7g8KH+nVq3HUOHfEEoEJrk7zQJcHudz17wjq6S9Hi7?=
 =?us-ascii?Q?I7wLmJdIXjlDqgr1Yjzy7QQ6LJzBDjHov/drZKVSURwk+kAzcDZMl/LHWq2c?=
 =?us-ascii?Q?G123IOP6PHUDxDvRkFcUWfBVFQOPf5fFFFDBmOOl9XdAPra9eYKcqVVvQnMj?=
 =?us-ascii?Q?MkOLsyQNFQcyWP97hAUoedrx+kUXNghtdGqX8g/mXoD62mBsDC0suCPSgCpy?=
 =?us-ascii?Q?00ah0rIHnTcn2bc+cJs3TxMylqL1XQOKfxhsS2TO7bIYgjtjq1zbtEO5m86Q?=
 =?us-ascii?Q?HOTIVNRFri9M5yn94vDn00y0z5QQQ/Y9YF21jXCeTd3e36sXRDFaJ/CFCBve?=
 =?us-ascii?Q?TM1AFTpbUZBzJ3nsUe8z9VuQAmN97W9xJU7KuUpyK/AW2pggFfOPjhDvGW1H?=
 =?us-ascii?Q?sku4tbL1iBJ3bzZ4PrIEt+u2AoQNvA8ZCVzZB7PPOQBjKdTLEr5EmOWptizY?=
 =?us-ascii?Q?yXfCte2LQ3H+OV6EoiE7eMH9bHcfa2+rFxFof/pKvQVLX89jnErLNxA95Sy1?=
 =?us-ascii?Q?4BHOFXQlX97YLUzewEAAkLgun6zSEnCnsrN5CyNe3qW5tLMCmBrgSLnISVxg?=
 =?us-ascii?Q?J3zo6tYOTBx22Y0/i3ZaoJYti07LHNHvh74zE1MWJShwn46uJOowkXO4dEF4?=
 =?us-ascii?Q?/GEHbjC4n29dkqBGgciTvle8h2zbf8YdyfV2e3QFy3gSF+3xW8hcNfU4MlB4?=
 =?us-ascii?Q?ix6JkVX4N4WsAQ/BKiYOKNVHugqZHy7uwecQlfUdr6vx7KK7pEDUh2zcakdI?=
 =?us-ascii?Q?NYRSIuWgaTVpMQ8vNn2PgqtrEAFEAGVhDtIOnjF6Ntz541zDbEhi4P+d3UGq?=
 =?us-ascii?Q?7cLmKmrCHXvh9Y/aDHIaN1UcAvmDhZbuuKM+qGjsP0PESYXFCorajIDEKQpN?=
 =?us-ascii?Q?zIp7K9zW2IdIAHcBpvKdXIMgvYRoV/M3QfWelmC7pjkxu6vRxZSmwqBIsDeJ?=
 =?us-ascii?Q?doS8cbwU/aPRhqoLB8BCArA/ZdMCSrD5+Y03GBJzKs4QAGl5oDbYNsG8Irxd?=
 =?us-ascii?Q?XfMnJ6+NHdAEA4Xg7XJdolltxDzIOiv4B4eO7sXoGvufa6LXX7cz31wfiywh?=
 =?us-ascii?Q?hEF1jZdqI3d59l147pyzvn/FM/cFhZcL8uE6jI7NvXrfgZr5/VpRbSP2o1QJ?=
 =?us-ascii?Q?/ihZl+3P1uslT2tT2oArPhDFb0cy7ZDAEhcRWI3M0LTbMYTzkz/fn/CsuRR8?=
 =?us-ascii?Q?lO1VAffMAL2V9HxK2J13f8DUdrrwBso92taRcEEzsKkC3HQuAzQirRTwkLB/?=
 =?us-ascii?Q?ALGOeg4zUfmw/OGFJjgoKR+joOcH+DHcqwccSKChks2ihN9xVjqzlgHYFYSF?=
 =?us-ascii?Q?BzEympxtSxvgn7iAIx0ZxEjHWmpigGA4flypIB9CkFj4PEfL3I4Jf6Bf5eyx?=
 =?us-ascii?Q?WV9IgJ7LD8H9iNc6Ro6TI29FviHACv3rytXwNDB4xpbpNtjYoa7PLlA+6JA8?=
 =?us-ascii?Q?ux8r9AYPQpg2txI2GJY59ZwjxLfm8U2DHmrDT/olTxA+TNawrFYgb6MKiaBE?=
 =?us-ascii?Q?wwUPO/11WkuqBulmvVk0J/zntTLFs+IWoXyTxEpc?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f0d797-5658-4931-4af3-08dcd71d3151
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 13:32:36.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHavrdG+prcaVgCaBvIj/xL67ADWJHUWF7iS53g50EU7Aa+4L6ZdjpjYEYAP26WwbWGyyqC5q0FTgSuUJJ4dFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3613

On Mon, 16 Sep 2024 20:08:48 -0400
Jason Montleon <jmontleo@redhat.com> wrote:

> Clang does not support '-mno-riscv-attribute' resulting in the error
> error: unknown argument: '-mno-riscv-attribute'
> 
> Not setting BINDGEN_TARGET_riscv results in the in the error
> error: unsupported argument 'medany' to option '-mcmodel=' for target \
> 'unknown'
> error: unknown target triple 'unknown'
> 
> Signed-off-by: Jason Montleon <jmontleo@redhat.com>
> Cc: stable@vger.kernel.org

I also carry a similar patch locally (haven't get around to submit it
yet), so I can confirm

Tested-by: Gary Guo <garyguo.net>

As Conor points out, the commit message could be improved. Perhaps add
a bit of context about the flag filtering.

Best,
Gary

> ---
>  rust/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index f168d2c98a15..73eceaaae61e 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -228,11 +228,12 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>  	-fzero-call-used-regs=% -fno-stack-clash-protection \
>  	-fno-inline-functions-called-once -fsanitize=bounds-strict \
>  	-fstrict-flex-arrays=% -fmin-function-alignment=% \
> -	--param=% --param asan-%
> +	--param=% --param asan-% -mno-riscv-attribute
>  
>  # Derived from `scripts/Makefile.clang`.
>  BINDGEN_TARGET_x86	:= x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
> +BINDGEN_TARGET_riscv	:= riscv64-linux-gnu
>  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  
>  # All warnings are inhibited since GCC builds are very experimental,
> 
> base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8


