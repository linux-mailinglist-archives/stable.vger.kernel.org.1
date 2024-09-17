Return-Path: <stable+bounces-76585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAF97B0C5
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF71C22535
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA08174EF0;
	Tue, 17 Sep 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cflZV6mo"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021130.outbound.protection.outlook.com [52.101.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02115C14D;
	Tue, 17 Sep 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579800; cv=fail; b=ZIldJrQ4gszhxNd5we9rqaQudD9i4afu2R8iN82bWf2BwwPfApQzlePeRGmMX1nGM5mPdPxxus6F0CLUb9MphaAzULzYx23Uz6gzTAmdrte5zVIORovW8dVD+DBjnQI9Diq1TxsII1F4lkuFuuMC6fornQLRcudhh7v+gzhgnGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579800; c=relaxed/simple;
	bh=DUvWBvaBGr+iLo5Q8G5Ss3b8vJDzzqhNxRzk+1lZc9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgJV+TRoysaCMN6g9mpXiQs0ZcRHwYR3Gcu4tCF2SMbbs3lcO4sd9iHvRO1NljNC5N6B4eAhxIdfII51v0f4JcKe7g2ObOslN1DjTt4vSMRhV/c6bFirfWJRf+n1dffPJA9YR+s4xnruMU3tvcAqrTtAwcgapJRr8W+odscty4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cflZV6mo; arc=fail smtp.client-ip=52.101.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVL8W3T4BjUKY95nEHmLt2Twiqi1y5bYWgbgVVVuiM9JVklSYZSMnd8Bv888fL61NDm0OVyX4wOAk7F8GTRYOrDC65AD0CHg8mlpQaMPiCNyERxz6U/XjTArs6lhVzdyrgPKti9pJlsNAbF2NNgNluU7APD11vb1PGLpypwOEgTbHCvRVgofTZQrXq+Hf3yngZ1fG8dRUuxnNCwo2BjZX8fEnvZ8EMvAl1RfwQQzbNJeHpJBFFw1pJX/HvoeSX/pXpnwijADt0j8rqhDPanvkjEKxwN2+8EIOjmODVYNbNTkQBHp8V5DCS8J6LOcdVrte++j2rGfWultkn8modbzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUvKpgUN2x3kNzVdUfDgAnGpUENtSHsL18FKiaEXs+E=;
 b=S7WrlZJjiMEkTr1FnzM/DrUHBuM+jgqTEA0YYk2h3DPHsrGAlXZoAIe81bPRsF0ISuG7MQjaXG3syQLW3oyUUZHtdVJQ2FHeadgIv6tzKSwHpcDwggCSqTBXPL/V26u2ha3FU78ze9oHbu0SasjmMAWV9F5njsp9/m5mxvjj+mxr4/8kD8+s0aBMhii+K697s9eTxBYRDepcEx4Z3P2iO92AzyJuP5JF7ChEpQn5ZHeXIOIc2MYXK1R7PhZkto8+jkpZmfbuO8iOj518u9K3/o7Xaqp4TfD3AxeJLfxUbHUqq7911Es59ci5JtKC9Lr8Yfhgc370gGOXwVN2yC1kDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUvKpgUN2x3kNzVdUfDgAnGpUENtSHsL18FKiaEXs+E=;
 b=cflZV6moWbHrMBQ5Qb8vzd4CMxJ3IfbqxiE85qtmJt7udwUCMWGFHYn9LH3hVnJGsPv6iGaRT0JWtNOsjOcY0kIMGdvo4sgKSy/LjJBxCWwVpuHfRPWY6e46DWUYr+xIHOto5ZzdAfV4MxTGeL6idGc6BFMJFLRoIxvFQ4nFMcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5738.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Tue, 17 Sep
 2024 13:29:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 13:29:52 +0000
Date: Tue, 17 Sep 2024 14:29:50 +0100
From: Gary Guo <gary@garyguo.net>
To: Conor Dooley <conor@kernel.org>
Cc: Jason Montleon <jmontleo@redhat.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
Message-ID: <20240917142950.48d800ac@eugeo>
In-Reply-To: <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org>
References: <20240917000848.720765-1-jmontleo@redhat.com>
	<20240917000848.720765-2-jmontleo@redhat.com>
	<334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::32) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c36ccf-7dfd-4e40-4082-08dcd71ccf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QTCIpzYq3/q8Qa2SiTBHrM80FF9scQB/vn0wO963zwvPQNXd28O6pQ4MN65i?=
 =?us-ascii?Q?/Ca0wRlFsF3SgZwJTFX9O2grFqGIY4RzgQWKlnqqi2dGfZmOdByAVP/J5G7n?=
 =?us-ascii?Q?B2lzXbcuAntxorS+s1K32XEK6aVzcHijllmaRXArdQpWVouWt5ZxOwCVtOqI?=
 =?us-ascii?Q?Nprb/9L8M+5HhQbFthjr6iRu9TFVc/QcXdUVV5gCqA5TSqtFFonYdyDKJU+9?=
 =?us-ascii?Q?Qqn44mgmT6mar0tshctZwc9X6xXgKdC0qjILKezQv+8niS4IfwCg18gLLNZx?=
 =?us-ascii?Q?Pls9F170R0NXP5guvBSiVFBeTxfJBNwpxXqxHiEqAsi8lfflnOsmdLLr2sGm?=
 =?us-ascii?Q?PhF3PyWo66bdj2lsaGng4bSDO4GHP28UjLgUFD0+McMsDpDw26h6/pCbe8N1?=
 =?us-ascii?Q?o9UhtiyLvkq06FM+hm7FeemH+0ZuJ7/bPvotFvsYuLfB+YSXfitrF7+U1CnE?=
 =?us-ascii?Q?QbA7xV1Pp6LdoKCGHxfq9cB6xpW4bnTb1pNMAiDGXuq9oc4D/On7RUR4I6Ne?=
 =?us-ascii?Q?qIDMsqHLczXWVBsQfaXBTJxZd6h+SxMZdUvt0qeAdX0T298Ti0EF2RH4mKAc?=
 =?us-ascii?Q?+4/vdZk4cyhouaqCtmddy8Hc7KEtSPaFHJPtMlXB9qtNDekuL8v+ZjfTvTIF?=
 =?us-ascii?Q?dAjrsno+b0WmfZBdwlj42NEcASLNvkGsea17qKa4buNGEDff+598TYy6rB/A?=
 =?us-ascii?Q?EqSXPTG4f6+ygIZqwcYepR/op/FtTI3TZq2P9EazyeAtvN45ubXWEuPM4+Qt?=
 =?us-ascii?Q?+19Rw0ckmxmFj7YC+AiJYDkKjBBPHPWQaHaWk7toiChKv0mpSn4wFszAmZiS?=
 =?us-ascii?Q?y8rvreqxV63U1Z463thkVwKCtaNYVPMjrZ8S0n4WsbvZ1xr7yYou1WhAz/BN?=
 =?us-ascii?Q?BDr0iouWCIo3d+eRke55Go5yQS6w0yR8Pg3JnixaSjQWLAeeCk725drGZYcx?=
 =?us-ascii?Q?XKsr5njpUQscZW+DnGAND4sakUUUWpa10eP1ryE1dVVyqNSIzAIYtLU1LAb8?=
 =?us-ascii?Q?Uc4D+qW7CIm73ozlthUXKD2Jpoq6yVebsw5+PIxi6ifkkZE2FFIrMrJ8cRx4?=
 =?us-ascii?Q?+mJgxShKMvcRxQOJ8EBGaEcMriUKhQulxb3kl2Xa+89CN1+P5qTL61k6lR2s?=
 =?us-ascii?Q?PCQpqETcZXSJb3Riyegjr5w4s4c8x0yNHbWiKew7nKhwIj0fQMHBFjgiGinG?=
 =?us-ascii?Q?Ovy0ZYRgki6ZVzcqVFK/7+hwgm6zGrmLWM/bYhddrWGcZ5GGzKIHR3p3DlOa?=
 =?us-ascii?Q?vCW/QbGl5BZhZrBx11ZlwTqv025BDHINB5hZbzAO2l0BGzsDI665oyoOzYub?=
 =?us-ascii?Q?zKL9vzpF+WuvIUiQ28SYh86nPY3FGou5gixPNAetNXvNaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oybHZzfL3YLWmCKjKOGUPZ0Dydp3OkMwJtZeXNSIERodNYcd3IzuUlf1Hm+?=
 =?us-ascii?Q?1/AAGq/jsvwwk0CGhitb/fWlVNwTF3D8rQ04tq9BAG7/UTyv6sY5s5nktgLP?=
 =?us-ascii?Q?/370XdG+mUzMUYvICkLaTOr6ftj2nQPdwg1oLqIJES3HemfnKgE5evW4xo2V?=
 =?us-ascii?Q?QbhfR9L72/QXGOQb2RXi2hiIJ0hDH1PYMsW8OLcdyoCThVFILjG//c0i9wd+?=
 =?us-ascii?Q?ynbtcGuklds1VWc8x8pXd9QnjB/mi/hmd0WzY22Wth/O2bDVtlSvuSvhyWmA?=
 =?us-ascii?Q?xIcH6+6Ogq2eH0FPhQAX0SUcvjPfgBpd+48NgV411tRIdmiay7eAhz4fmP4c?=
 =?us-ascii?Q?Som2nqxSbAuEWHkXfCjXDQVxJAUnxdZ11mEdizJxkP6Bv0iUtQAFA8YX4PXy?=
 =?us-ascii?Q?p6yzUQ2XpoXl4gofe9efkrS3+OX3e8H6bzQh65EDSUvEScW+KNTTErLYTjnN?=
 =?us-ascii?Q?McDC82sRBrpYdfJjjiefoqR3z+Brr/hoBlJroQS3mdZXD0ejHDp9zQSfIThU?=
 =?us-ascii?Q?ihodQGL4gz+GbQ09Kqk6w74EdgJhyGmhOGkn1cQyKtP3g39NLjIHIu6IKVqY?=
 =?us-ascii?Q?2ms7taxvpf0PRJ1FYFOyvxhOJSa1CJczRU1JbQQJ8rLfnhKYPDqdCaqYpMEm?=
 =?us-ascii?Q?sJalW2FYpX+xwP8BSkjPLfKFy5ZEVfj6zH3vfQ19SFybGfiS0G7zb8ZGNwR9?=
 =?us-ascii?Q?93xuSSSq+IoKo4crpO/HF4nz5vhCql9R3go3ifUltZjRIZ9di1GAVnSBJE8D?=
 =?us-ascii?Q?MZ/+7n0JWADm1hS7bDgmmNH0li77OL94FBj3L09JsktobK8LpJaIqGLuEgob?=
 =?us-ascii?Q?ygxJcxOsLhm1hoQchSVFxwqQBnS3nEd8laSCeXKGk/rarel9FbazGweYQOLR?=
 =?us-ascii?Q?s4YYj3R9jLxKkPwkppnm2qA44VOw0e8rmGna15kRSz2hNR4/3LX4BBbIsofL?=
 =?us-ascii?Q?lcEpBUYKB84a//N6WZ5B1IyThLE+9+4QIQcXm+C4ZkcPj1Y/qa+g9AhbbDxL?=
 =?us-ascii?Q?ctPxP6O0X1sujo9s/lPoaAl5FBwkrgMy51FWSzm/mnFAW9ro/t6IX5Fp7Crt?=
 =?us-ascii?Q?NUQz4EQCNtvrTfPx27v1emYiRIFFUm6smMgYHXDDxohc9RwuhfaEkHnJnTn/?=
 =?us-ascii?Q?Pr0bSqoWtALowGbmFvIqU/1ZMWyf98LKjni3VUELqud6DfThxfqkT2dwQK7Z?=
 =?us-ascii?Q?+h1TwVw6t84CI0L9B4sUT74T4aYOEcY28JSAIUdFgZqNKO2OoV7h7ki2Gyhw?=
 =?us-ascii?Q?bBjzouV35KmXtEndrs9r7ehR1gu3alD1OroKegZ8UHIpeR9406TITuie1JRY?=
 =?us-ascii?Q?T3oZBaObutbPFG8XAx4mZJ6s4G/OmOqfpTuuMhzlNX/HOjldby5GaiZ1vL8b?=
 =?us-ascii?Q?KED5SPneKLW+2EYzmi4PycjouL3K+vcfXKTbchf+q+QLIpF4uH3nfoBX3cti?=
 =?us-ascii?Q?yHrQKWmV0e0lRNlD9RA3c8DmrITJYLhJ2xItF/neVTYzIz4tmwbFPsxSHCrP?=
 =?us-ascii?Q?ZnFlyYBTdNA1gt76WGbGV4LY13sOkHlq91cxJZQOZAnaWYPpMIFZMtB6QI6I?=
 =?us-ascii?Q?GfKcLBuobVDZNlPRYYGd9EtTUaFFB4QXV3Fb0lJq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c36ccf-7dfd-4e40-4082-08dcd71ccf6e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 13:29:52.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6/F1uKYig/p7RqkBPcGma3iCB42lKnVGGSdSpZnf/42R3yO03K6ve99dTgmvd+lOVgF5v/6pTE3cF9FP4zgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5738

On Tue, 17 Sep 2024 10:35:12 +0100
Conor Dooley <conor@kernel.org> wrote:

> On 17 September 2024 01:08:48 IST, Jason Montleon <jmontleo@redhat.com> wrote:
> >Clang does not support '-mno-riscv-attribute' resulting in the error
> >error: unknown argument: '-mno-riscv-attribute'  
> 
> This appears to conflict with your subject, which cities gcc, but I suspect that's due to poor wording of the body of the commit message than a mistake in the subject.
> I'd rather disable rust on riscv when building with gcc, I've never been satisfied with the interaction between gcc and rustc's libclang w.r.t. extensions.
> 
> Cheers,
> Conor.

Hi Conor,

What happens is that when building against GCC, Kbuild gathers flag
assuming CC is GCC, but bindgen uses clang instead. In this case, the
CC is GCC and all C code is built by GCC. We have a filtering mechanism
to only give bindgen (libclang) flags that it can understand.

While I do think this is a bit fragile, this is what I think all
distros that enable Rust use. They still prefer to build C code with
GCC. So I hope we can still keep that option around.

Best,
Gary


> 
> >
> >Not setting BINDGEN_TARGET_riscv results in the in the error
> >error: unsupported argument 'medany' to option '-mcmodel=' for target \
> >'unknown'
> >error: unknown target triple 'unknown'
> >
> >Signed-off-by: Jason Montleon <jmontleo@redhat.com>
> >Cc: stable@vger.kernel.org
> >---
> > rust/Makefile | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/rust/Makefile b/rust/Makefile
> >index f168d2c98a15..73eceaaae61e 100644
> >--- a/rust/Makefile
> >+++ b/rust/Makefile
> >@@ -228,11 +228,12 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
> > 	-fzero-call-used-regs=% -fno-stack-clash-protection \
> > 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
> > 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
> >-	--param=% --param asan-%
> >+	--param=% --param asan-% -mno-riscv-attribute
> > 
> > # Derived from `scripts/Makefile.clang`.
> > BINDGEN_TARGET_x86	:= x86_64-linux-gnu
> > BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
> >+BINDGEN_TARGET_riscv	:= riscv64-linux-gnu
> > BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
> > 
> > # All warnings are inhibited since GCC builds are very experimental,
> >
> >base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8  


