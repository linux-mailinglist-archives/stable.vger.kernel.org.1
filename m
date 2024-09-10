Return-Path: <stable+bounces-74561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2256972FF1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734C11F24F23
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B89F18C025;
	Tue, 10 Sep 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YKBa8d0z"
X-Original-To: stable@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2096.outbound.protection.outlook.com [40.107.122.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CD18C000;
	Tue, 10 Sep 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962166; cv=fail; b=IylGlx9TAkkXRVxaRqp3W/TQ3euwHPVWWyE4m5ppKckSkF2uJNz6bepRijXHt2yqetgysLrGdL1jjdq3wnYkvoovrU472NELm++E9+OpNfDRb1L9yY1iOqqAzp1hjzf7PMVZSXLXb+NXFd/LV6vqSa/ScmOSiJkZffXfGpMzTBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962166; c=relaxed/simple;
	bh=wPFekdHb2MzZtJOehEiaCui1G9mKUZuHd/2U250o9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzlvx+F6lkqX63p6SJcnasYStstlReYQzMXnMdr2Tn2wt6nLoTtnUM4biocH1BeimIQMtProw7JADxr+RBWsNb4H2MeHAMZbJFBXeTotWu199z921QPs2plvvojmY4heelCphnXChmiJzBhlzHsH5fxIh6Ba2aIiJxD7rTISA0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YKBa8d0z; arc=fail smtp.client-ip=40.107.122.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irr/+jHD8m4NtsVCdmV/iwg+umbxNjnTc7oKxsnGm6QJZfs/ioFlRvbobMp/LlWiPBDVKv5lxWfoDsGFb+jI0qne+i5w7yxY1eILpeLODX0JPvE6maMQ3nBmtzsABS7iLctbrnTE8T8xsHwgK5RsLhiwQf6tM80aWv01KkcCBx0VgT39J+k+F8mKBOdqTCAuQohpYT7e+oqzAYTZTuYNlzJMhz5bNmIHBXAZzki+t+NE+sjfMaRHgRhMddjg1kNOGn8RojMVtpuwCpPOh5Ib/Si4RRktpOIHmh4SujiH7ZoswhTLKptm4NpHETXciUgQLSXSCTl3Kzb9ZdZZUZIU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLA+sk3x99LHmCqaHi8Quky4rrKcyzA1TelSsH2i+6Y=;
 b=ACINXmBs3rrZgqlTXqCi2HoccwtM+lhxqzWagAX1nHAPOfCphyUTs8kQ0C1jekOUfMqdfE0mlEXdsYkUgjZj2d5pym8beL3LAvCObsjimAQWRZtl4j3FQMKti7PwFVkp6FC9ErJZkJNBIYMhpz9Sqwm7a5m+i6nt2ZRODuC0Yp0recnn2Xbs8X5D62n/+vx+ypxVmoKYYpnUCJqeWBNqpriAoV1MbQFYmdfaMrPVeh02/gUMuEUpha9D2p0DV7Z1b40OLCGkP6BpXV277PSIP0ewc8grI6XDT1pq0PpQ8eAO1sdxmBY+bTfPdKUA689ZOtoPnk3GDTWoddy/n3e29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLA+sk3x99LHmCqaHi8Quky4rrKcyzA1TelSsH2i+6Y=;
 b=YKBa8d0zQfgODPjyjTVe84sBXGDON+73FnDVjx1tlpWdBwoUHYk5QXJpGewuERKfvXTIL4Ydk9ARlK4bu2cmtZKVS8OxWnJtytIw20ZJsqVhcUK9esQb535PFip209NlWP3ORxRNyQiPYiGDp6B7h4FF/OvOwWC5wIhdK5rhzjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5659.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 09:56:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 09:56:00 +0000
Date: Tue, 10 Sep 2024 10:55:57 +0100
From: Gary Guo <gary@garyguo.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 boqun.feng@gmail.com, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: Patch "rust: macros: provide correct provenance when
 constructing THIS_MODULE" has been added to the 6.1-stable tree
Message-ID: <20240910105557.7ada99d1.gary@garyguo.net>
In-Reply-To: <20240909124814.1803199-1-sashal@kernel.org>
References: <20240909124814.1803199-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 499ba53e-5306-4c14-76be-08dcd17ec60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qa3c+R/goJur19SaSSfGuk3IR4YwTi/0IXyoZLzCu8jSExKR1cXs7XDu0pbg?=
 =?us-ascii?Q?b/wf+z5+Xqp/acvnZr823SU43jxg/U13u8guXuZP+cZP8yCdBTShHZLF8r4L?=
 =?us-ascii?Q?EgvR4xgYWyQi2cwk0Ef4EpuWdVdHm1CfR+/hXPJbuNBvBnDU9OHhFtws67N5?=
 =?us-ascii?Q?jm0Vxw2O6sUG4TxsH9xa9Ff4KujZisHyArAw8Tldzh7Qp22E8kVseUdbRNAT?=
 =?us-ascii?Q?gQVtGAlPIthCgUJbm587NhCi74ebFbuWtsWT3iRMF8zkQAbJ43k7oUP5NfYM?=
 =?us-ascii?Q?kc/Orfe0OPQUYxphE5Ox7XP7b8RAlH/vNLcaLlmG7TmBE8hZYL4END8GKZAx?=
 =?us-ascii?Q?xMkhOykrg2k6CccdloEdyp184jzamrXJSZO3iW23q9rYhEXEHpN5ZUwDXMyG?=
 =?us-ascii?Q?gR5+k8Uu01YGD1S8rpECtapZgjBaAdA4WOEhRDu19GgBoxhtLOUO0V87f5c0?=
 =?us-ascii?Q?ruKawPyBkAK9Q0F2GZA0ueEF0+N15qRBujq8iPBJgksw4d5UaTQpkR3WTSqK?=
 =?us-ascii?Q?xzKsBQczKce5MzFyDwmBKIH9PEp32ZByzQa54NL6xua+X8pG/HxEyA53UuQO?=
 =?us-ascii?Q?BstPuaZ14K3he4r1+zJYqaLf6R7IJ9loTAVFeB/DCDYxsPIXpTbltIcBfdJ5?=
 =?us-ascii?Q?/LRGDF+GEo9ekbxZKOPkgp9dmTcf5Eu+t7lQN3b16xjVpacqa28aANcqAAYD?=
 =?us-ascii?Q?ZPsByiQ37DJtpymxft3u3ODZgE4U3+m+t1Du3YAE9prm0SDJOQHFSZ/XFx5U?=
 =?us-ascii?Q?EVFbnEeK22Bj4jNX7ECZ4NRQTNCduvrUxmjAQJMvKgs/eQkBHoyyJLIihXZH?=
 =?us-ascii?Q?YimQstlcUz+tSTmRC3OdziJaT3GK1Yo0LCuoEGNTUSqF8a6uinlrcW+EJFXr?=
 =?us-ascii?Q?szxxk5HwOttrOEGRyLk5LtIlugyyIUN+D7JuiTN3Wu1sfxzI1ag353136GNn?=
 =?us-ascii?Q?/+K9CR0SqILXQHJ8aBf5wymzJWnYmFrw0F66hJ1wMnq5bjsZN5NN6uXrj6cx?=
 =?us-ascii?Q?fnQuxry6BQWksVT8gCyntAZk79IVHp6L90hNYVCTEPvptRZoTf2KBaPG2yRJ?=
 =?us-ascii?Q?oP58IL49gqpS19SuVi3fXvs4hLLY95iBrD2PvBEG0n0NPL+GHA5/V+i5qjek?=
 =?us-ascii?Q?wqbpjic9pBzDXrKkQWh243ibMUIaiI9Zog49Cx8vnLv7sYNAe3R8nx9OjS4A?=
 =?us-ascii?Q?pig9FrM5h5+O8ovUlcPZS0uzk1TfXfuzWmYCqiiITsE3axO3vxn0kendy/GK?=
 =?us-ascii?Q?bkB2NV5l2l5IdBcn9zDCA0jaAzIb/Rowm6OeBIqHGwcQTOGiA1sR3Yv1SjMB?=
 =?us-ascii?Q?xOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrpFYZsWJP5igEJOuQuyHT22E7+u2SDDDStecC+em0PjrJxNse6zkGBsH/72?=
 =?us-ascii?Q?oHADLskiQ9z3Fk2KJlndKO8ueLy3pP8jGES6J04v+q41VxzJ4CoIeImAXDA7?=
 =?us-ascii?Q?UseF2sGt2Ee7hbLNa9E9MB4ZUSoaKI/MuTUbXs9ZhuBrZ5PITcMCtRtqXKZ9?=
 =?us-ascii?Q?f1qe7G8oLGFhVZfaPK9uLXS70v/+tccfXN820KqYn+KOkLRevl8C25KxD+Jf?=
 =?us-ascii?Q?yleVBPqXpxa/pBQBs/HW9e5pm1PfVCyvZIqp6cLjhDDo67fzsVm514OqJday?=
 =?us-ascii?Q?O3T/3mf029W9Agnhr8Y8uSXl9VCnlWu3woWNNjNxZLo2yMxEXzQZBzucJKvA?=
 =?us-ascii?Q?+00rBJ37oIO2T9fPlU7r/oamUKPKOWYC/JazZGGf/rxRpMBqgwIkEV8MY7IA?=
 =?us-ascii?Q?yDuehHU2kXd6aL/1gVbYB3T6CyVH+Q80I0Xk4P/MhPFTSFxi0tqSE7OmDZWY?=
 =?us-ascii?Q?MNl4Xph1UD0rvsR1Cc+NOrj0ecqXYKFE49IwkJ0S8g5KMeH+wPquaiQR/NXX?=
 =?us-ascii?Q?UYSBO2bKr4qfJZVgNauE/OVy1LOFGKk8/R1ejyAIvi2nJYKJncpT2PkLJC52?=
 =?us-ascii?Q?ee2WUNPvSRX8mN4KxHUP0xOVycENan/9AnvfjZX3Wskw7Zzyg9Vnra3Jbls0?=
 =?us-ascii?Q?4vIu9plBeOSc1SG+zTmLDOgLcgO3B8dtTV15uVb056Mm5C275l/i5n/YGd+R?=
 =?us-ascii?Q?doVML0xeiQvhuk0ACpYQH++K0JMZgdgv5v2/0uIJaa/Ifh2tgQN7PV0z2jRb?=
 =?us-ascii?Q?2WIscXMBnXiRJiG9FaaOATPIGd/O4wR55uriTr89weblpkJohsamC0272Ldw?=
 =?us-ascii?Q?+mnfV1LQCOd5B7+l81CGRmEupexHtOi+v3BZ9bt8ic4Yz78rObM+D5mz7GEb?=
 =?us-ascii?Q?dlihKr4w7glRAOxPXqN/5ZhR53tv1C1hQe/ANouWUK4uHfmrCeRSuJL2l5Hm?=
 =?us-ascii?Q?bwRwOKlEQaaxRUwH6CYioObTIsngBUwcn2jXvs+XVImLiXKE2qbASKFO5iPb?=
 =?us-ascii?Q?yLP37p4yt6cA1yPCDC8uR5iX+0rHpM0c0wNmuuanf8QO5RGbWaSZQinCENsx?=
 =?us-ascii?Q?UXL9TAhfBlyvR9C5cjzRFlMd4e02PX2UQHsC5KvZwvLr34wSrTSOz+2rOuyq?=
 =?us-ascii?Q?XHzYmxd+IPY53pYgoiwjtlNwmi/9xKQRMHMVyCoCjiwpdx9NArd4gRsmzOWr?=
 =?us-ascii?Q?lFhnAPcnheIbdbYSECIIEoJYEoSjoTVou2lllsKFREhHLrDjciMDvwR++b+9?=
 =?us-ascii?Q?VfRBV0ErNNx4VYYw6hIeJRWPoNCSZyW7cBJXqvn9Hxw29CDxhL/ZDI/k/oCy?=
 =?us-ascii?Q?j3doO1q2dEivU6lfwM9GYeVzpd1XyrR9yUFCObtwh6zLffo2CFp4me0F/cMN?=
 =?us-ascii?Q?4SmexYsMFXVOohBuCC44PlYwr/9yFkfFtxKioybOlE0l/oKO5gyNV1WLus2w?=
 =?us-ascii?Q?UKeONFlzL6pP5X5u1ze/yWf9gXLlY8blSmnkIiySp7a3tiE1nrzgmBm9QPE2?=
 =?us-ascii?Q?iEDYe4fKQEGN7jk0N0+2f3Wn2uc5RZPFUrJVoVhEjOZsW/KlwiYIPDMASnMb?=
 =?us-ascii?Q?3tG0VaX4yFFsRRTTIGd0rNfOwhtabOs3twiNQONQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 499ba53e-5306-4c14-76be-08dcd17ec60f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:56:00.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O1j4m9BTnkQ8z5RKRVmuEr2DfPZWrQF/0CKv1aDUeu/LsKtGfOlKzRstOM++LQy70WT4Y7URsBsL0r9BHogZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5659

On Mon,  9 Sep 2024 08:48:14 -0400
Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     rust: macros: provide correct provenance when constructing THIS_MODULE
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      rust-macros-provide-correct-provenance-when-construc.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Hi Sasha,

The `Opaque` type doesn't exist yet in 6.1, so this patch should not be
applied to it.

Best,
Gary

> 
> commit 5b320b29ddf985d8de92c3afa9aebe13ecd5cfad
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Wed Aug 28 11:01:29 2024 -0700
> 
>     rust: macros: provide correct provenance when constructing THIS_MODULE
>     
>     [ Upstream commit a5a3c952e82c1ada12bf8c55b73af26f1a454bd2 ]
>     
>     Currently while defining `THIS_MODULE` symbol in `module!()`, the
>     pointer used to construct `ThisModule` is derived from an immutable
>     reference of `__this_module`, which means the pointer doesn't have
>     the provenance for writing, and that means any write to that pointer
>     is UB regardless of data races or not. However, the usage of
>     `THIS_MODULE` includes passing this pointer to functions that may write
>     to it (probably in unsafe code), and this will create soundness issues.
>     
>     One way to fix this is using `addr_of_mut!()` but that requires the
>     unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
>     an extern static `Opaque` is used here: since `Opaque<T>` is transparent
>     to `T`, an extern static `Opaque` will just wrap the C symbol (defined
>     in a C compile unit) in an `Opaque`, which provides a pointer with
>     writable provenance via `Opaque::get()`. This fix the potential UBs
>     because of pointer provenance unmatched.
>     
>     Reported-by: Alice Ryhl <aliceryhl@google.com>
>     Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>     Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>     Reviewed-by: Trevor Gross <tmgross@umich.edu>
>     Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>     Reviewed-by: Gary Guo <gary@garyguo.net>
>     Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/465412664
>     Fixes: 1fbde52bde73 ("rust: add `macros` crate")
>     Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make Opaque::get const")
>     Link: https://lore.kernel.org/r/20240828180129.4046355-1-boqun.feng@gmail.com
>     [ Fixed two typos, reworded title. - Miguel ]
>     Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 031028b3dc41..071b96639a2e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -183,7 +183,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              // freed until the module is unloaded.
>              #[cfg(MODULE)]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> +                extern \"C\" {{
> +                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;
> +                }}
> +
> +                kernel::ThisModule::from_ptr(__this_module.get())
>              }};
>              #[cfg(not(MODULE))]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{


