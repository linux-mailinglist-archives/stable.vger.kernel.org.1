Return-Path: <stable+bounces-184116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67552BD07E8
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4918972F2
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7D2EC56F;
	Sun, 12 Oct 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IA07oY/9"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58052EC0AC;
	Sun, 12 Oct 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287511; cv=none; b=slFQKD+XtA3eKfAqItWAXAgcIB0p1gofsk01Il5nJg1ZviUseq50m8WJ6v64NW9SHvkWH51d4xvshxOvHXpDGL+Hnao7NV8LnXqIk8R+u96X5oF2Npxc+maTaDYvIMhx1Oszl9qbATxW2nHeNy5syN7wnMujERIgL9qUa7j101A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287511; c=relaxed/simple;
	bh=Lc3epc2zXqizYd9yb/Jq7BusoWmOx0s4ilWTklH51pI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PAGSAw6IPV7/bbwClqQRIAf8ZgHkd4ndLtITmQoF/PgsaPqRXCNyj4QF3Ze/a1gS+w31eTE1SnDhPYNYhnqrlDEfxV2tCuhlSinoLyogKoUlT0k3SnwDovCM6vc+8JgOTDthplyfnwLwu2wJyo8Tr/rFRPOaL90zZhKb9olSGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IA07oY/9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59CGidsN800974
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 12 Oct 2025 09:44:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59CGidsN800974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760287480;
	bh=Lc3epc2zXqizYd9yb/Jq7BusoWmOx0s4ilWTklH51pI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IA07oY/9LQQu9yZwkLGLq8/5g766DCSCKM1LQMNGY62mfdceMGIk1vH1vzGDs067z
	 FE6FoLCsQCKijTmqphR7G0i7yR8m81YCWMYz6V39rN/YA/JHtpSulXuCmUkg56V3cl
	 z4+Hk0r0gBNwYvNZqHc9iTxvFS8P8xMn7MUGnSr9uK9jT4jbhMuZoXqUNRLvs58/G0
	 UPXhcy8kV+1ubnV+7xQQm7fMz6sL191nOfbsFFh7XqrZS8rZ5MPLfhNcxOGlqhPStY
	 Npo9LNeKD0f6ONzrP1H1u479B97Lmy+IrGqx1oufqT/pNQmHFy4jr3x8CehIqFuz+L
	 w/0XeQiIddRDw==
Date: Sun, 12 Oct 2025 09:44:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_Patch_=22x86/vdso=3A_Fix_output_operand_size_o?=
 =?US-ASCII?Q?f_RDPID=22_has_been_added_to_the_6=2E16-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4Zn=NkmX248bL25jz9MvRw1kJMiEASDSyvgh73j8zHjvQ@mail.gmail.com>
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com> <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com> <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com> <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local> <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com> <CAFULd4Zn=NkmX248bL25jz9MvRw1kJMiEASDSyvgh73j8zHjvQ@mail.gmail.com>
Message-ID: <8CFBBC66-8B78-45B9-93FF-37D0492912CF@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 12, 2025 9:24:33 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote=
:
>On Sun, Oct 12, 2025 at 6:21=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On October 12, 2025 9:17:33 AM PDT, Borislav Petkov <bp@alien8=2Ede> wr=
ote:
>> >On Sun, Oct 12, 2025 at 09:10:13AM -0700, H=2E Peter Anvin wrote:
>> >> Ok, that's just gas being stupid and overinterpreting the fuzzy lang=
uage in
>> >> the SDM, then=2E It would have been a very good thing to put in the =
commit or,
>> >> even better, a comment=2E
>> >
>> >The APM says:
>> >
>> >"RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction i=
nto the
>> >specified destination register=2E Normal operand size prefixes do not =
apply and
>> >the update is either 32 bit or 64 bit based on the current mode=2E"
>> >
>> >so I interpret this as
>> >
>> >dst_reg =3D MSR_TSC_AUX
>> >
>> >which is a full u64 write=2E Not a sign-extended 32-bit thing=2E
>> >
>> >Now if the machine does something else, I'm all ears=2E But we can ver=
ify
>> >that very easily=2E=2E=2E
>> >
>>
>> MSR_TSC_AUX is a 32-bit register, so the two actions are *exactly ident=
ical*=2E This seems like a misunderstanding that has propagated through mul=
tiple texts, or perhaps someone thought it was more "future proof" this way=
=2E
>>
>> I think the Intel documentation is even crazier and says "the low 32 bi=
ts of IA32_TSC_AUX"=2E=2E=2E
>
>Intel SDM says:
>
>Reads the value of the IA32_TSC_AUX MSR (address C0000103H) into the
>destination register=2E The value of CS=2ED and operand-size prefixes (66=
H
>and REX=2EW) do not affect the behavior of the RDPID instruction=2E
>
>Uros=2E
>

Yes, because there is nothing to affect=2E Anyway, it's clearly a document=
ation issue that has propagated into toolchains and so on=2E It's harmless =
but confusing=2E

