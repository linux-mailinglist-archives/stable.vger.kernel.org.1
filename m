Return-Path: <stable+bounces-109423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD3A15B63
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 05:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D05E3A92BE
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D981732;
	Sat, 18 Jan 2025 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SDPf6zj6"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8817D2;
	Sat, 18 Jan 2025 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737173397; cv=none; b=JXvy9FcxcOKGK2tDmGymanufL/JAgmkfy7e6ymO2gPHNBr9dMXSY7d3FHpuqwyYQHquQokIAvk0AxTZl6orBEJx004B1cbAwNujbLwbMmyZB8hnvlGw0skul0RNURCEgk2ioDyfY0h/PdtapnlGE+n5ZTdAFrYo3OufE+/aPKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737173397; c=relaxed/simple;
	bh=MaeCtd6ihJ0UO89ok68ZBcUiNSyJSbARrN9XpG0w6H8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PjZJif2nDjGdG4isfjv8hLaN33u5tVq5D06VsqVRO8zzXFvYLT3VE2jqVBmZCDteS11nZl54OGFGpRr4zD2y0iO8WnzHBUtJzmeAcLcdAr2Cr1ToHxYRv+kuYIZOY1fQ/B9O+Klm9E20HWQVZ/j64sbb7yoRxY+ds7fPuEAATQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SDPf6zj6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50I49NZH254798
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 20:09:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50I49NZH254798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737173364;
	bh=VOTJQpkJ//jn1sT4mnGuyaKEibSXtmQgGoYkj9K3nDg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SDPf6zj6Ot0W/EtSF3c1LcbHWyOroCF9wtDnRKnBeJGjqWjvFJ09Od3iUSVAUacN+
	 tCGmOX2g+Hk4Aszz4aeJ9wFF5AFlJeBNsZhf6ghMLq6So6I7TJKO5DmA1PeofsWP3G
	 +sRayx0bdRRmN3yAVyMZSAx5cYneGI5EV+5Pvwyd/bcB36i+D0lEjv3JaRFs7/w1QD
	 AzS8hpr4Y23VvD5GQPKIg97JlvzthN+2nvkT+Gks9SocjN+x0uK04QT6SeC89FlUIs
	 wbYW0I2oyow/AEyMJ/8ocjiDyQ4J5f6ekS22ItcURX6mRVJ2i7bJofOuEEH6Jm6KUR
	 gRuurQ7FBSzbg==
Date: Fri, 17 Jan 2025 20:09:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ethan Zhao <etzhao@outlook.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
CC: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/fred=3A_Optimize_the_FRED_entry_by?=
 =?US-ASCII?Q?_prioritizing_high-probability_event_dispatching?=
User-Agent: K-9 Mail for Android
In-Reply-To: <TYZPR03MB88015FA45675DD73D8570834D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com> <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com> <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com> <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com> <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com> <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com> <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com> <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com> <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com> <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com> <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com> <C3BA43FA-06BA-416A-B8C2-0E56F2638D80@zytor.com> <TYZPR03MB88015FA45675DD73D8570834D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Message-ID: <F6B47DBD-0350-4966-9C82-3B252A6D8224@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 17, 2025 8:06:27 PM PST, Ethan Zhao <etzhao@outlook=2Ecom> wrote=
:
>On 1/18/2025 11:41 AM, H=2E Peter Anvin wrote:
>> On January 17, 2025 7:29:36 PM PST, Ethan Zhao <etzhao@outlook=2Ecom> w=
rote:
>>> On 1/18/2025 12:24 AM, H=2E Peter Anvin wrote:
>>>>> In short, seems that __builtin_expect not work with switch(), at lea=
st for
>>>>>  =C2=A0=C2=A0gcc version 8=2E5=2E0 20210514(RHEL)=2E
>>>>>=20
>>>> For forward-facing optimizations, please don't use an ancient version=
 of gcc as the benchmark=2E
>>> Even there is a latest Gcc built-in feature could work for this case, =
it is highly unlikely that Linus would adopt such trick into upstream kerne=
l (only works for specific ver compiler)=2E the same resultto those downstr=
eam vendors/LTS kernels=2E thus, making an optimization with latest only Gc=
c would construct an impractical benchmark-only performance barrier=2E As t=
o the __builtin_expect(), my understanding, it was designed to only work fo=
r if(bool value) {
>>> }
>>> else if(bool value) {
>>> } The value of the condition expression returned by __builtin_expect()=
 is a bool const=2E while switch(variable) expects a variable=2E so it is n=
ormal for Gcc that it doesn't work with it=2E
>>>=20
>>> If I got something wrong, please let me know=2E
>>>=20
>>> Thanks,
>>> Ethan
>>>=20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0-hpa
>>>>=20
>> That is not true at all; we do that pretty much *all the time*=2E The r=
eason is that the new compiler versions will become mainstream on a much sh=
orter time scale than the lifespan of kernel code=2E
>
>Yup, time walks forward=2E=2E=2E
>But it is very painful to backporting like jobs to make those things in p=
osition for eager/no-waiting customers=2E
>
>Thanks,
>Ethan
>
>>=20
>> We do care about not making the code for the current mainstream compile=
rs *worse* in the process, and we care about not *breaking* the backrev com=
pilers=2E

As I said, it is OK for an ancient compiler (gcc 8 is the oldest compiler =
still supported) to *not have an improvement* as long as it doesn't make it=
 worse=2E

