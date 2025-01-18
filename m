Return-Path: <stable+bounces-109420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F5A15B42
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 04:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9AB7A3A23
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBB5789D;
	Sat, 18 Jan 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zpZHWsHf"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482352E64A;
	Sat, 18 Jan 2025 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737171694; cv=none; b=rFtZmf9/LPW3+prYUDzhsYcAWndrectS/Z52Ztx8zPqYDfco3a4dfstfKuuYYwzk9b+UrSCts7uax+xjoNgZdUWoaEYAB/PlFaWozOs0q2lwAVV8dSTVf8Hmdcs7AhskFLWvEx1PYLOtJNSee2khoP8U6IcP/pxy/Fp7DhDoZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737171694; c=relaxed/simple;
	bh=mtz09O+KNA898l6WX2TK5PvUJ4gA1bSTKs1aLPTbbi0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D/4u7p7fcksrQS1oRVTstr8+KqFkH0u3iIUPfe+/3EEX8gE/kcePxh91JxriLdKxZoqkG7I3VvV7gpGdHUi5Skx6J85OL0rIdgk0wCbwyLpXM3wAy3ss+b0svya3Xe9wnhq7Y3wm5XCHvlw8GHhkMQ2Qdi0jG/CtObuNPpbleb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=zpZHWsHf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50I3f2q7246040
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 19:41:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50I3f2q7246040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737171663;
	bh=mtz09O+KNA898l6WX2TK5PvUJ4gA1bSTKs1aLPTbbi0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=zpZHWsHf+ZNt4R0BOEYcjxqWOjTCw5Sy1JSDhUw0/2ouCQXvkhIHiUtRKpBbliVmW
	 60U3ZIXhVuaK1A/7fLytsMzhrRl9w3oWKrLE1DTY7TyveDOY8F4Fn54fEdMBVYCVLQ
	 48/bDQDnqblSIRAJKQwQnYuu0IbClyTRFZkze8yOXnM589gUgOJ5GyA8bX9H65akb6
	 lZkQZtcsBVdigHr8ZoeWVFSuFy1H2v5vdNkHlYzN94H18mqB+oStsJeyA5B++c8pMH
	 hOetmU7aSyPU/iHXA1qPqcD5RT9w7ScvOaWGOeuYLKm4N5ktGN4+NJwexMohR0L9gg
	 F65rBWxWVyupQ==
Date: Fri, 17 Jan 2025 19:41:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ethan Zhao <etzhao@outlook.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
CC: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/fred=3A_Optimize_the_FRED_entry_by?=
 =?US-ASCII?Q?_prioritizing_high-probability_event_dispatching?=
User-Agent: K-9 Mail for Android
In-Reply-To: <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com> <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com> <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com> <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com> <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com> <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com> <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com> <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com> <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com> <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com> <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Message-ID: <C3BA43FA-06BA-416A-B8C2-0E56F2638D80@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 17, 2025 7:29:36 PM PST, Ethan Zhao <etzhao@outlook=2Ecom> wrote=
:
>
>On 1/18/2025 12:24 AM, H=2E Peter Anvin wrote:
>>>=20
>>> In short, seems that __builtin_expect not work with switch(), at least=
 for
>>> =C2=A0=C2=A0gcc version 8=2E5=2E0 20210514(RHEL)=2E
>>>=20
>>=20
>> For forward-facing optimizations, please don't use an ancient version o=
f gcc as the benchmark=2E
>
>Even there is a latest Gcc built-in feature could work for this case, it =
is highly unlikely that Linus would adopt such trick into upstream kernel (=
only works for specific ver compiler)=2E the same resultto those downstream=
 vendors/LTS kernels=2E thus, making an optimization with latest only Gcc w=
ould construct an impractical benchmark-only performance barrier=2E As to t=
he __builtin_expect(), my understanding, it was designed to only work for i=
f(bool value) {
>}
>else if(bool value) {
>} The value of the condition expression returned by __builtin_expect() is=
 a bool const=2E while switch(variable) expects a variable=2E so it is norm=
al for Gcc that it doesn't work with it=2E
>
>If I got something wrong, please let me know=2E
>
>Thanks,
>Ethan
>
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0-hpa
>>=20

That is not true at all; we do that pretty much *all the time*=2E The reas=
on is that the new compiler versions will become mainstream on a much short=
er time scale than the lifespan of kernel code=2E=20

We do care about not making the code for the current mainstream compilers =
*worse* in the process, and we care about not *breaking* the backrev compil=
ers=2E

