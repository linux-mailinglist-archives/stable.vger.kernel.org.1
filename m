Return-Path: <stable+bounces-184114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56607BD072C
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F12F5347E51
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C262F25FF;
	Sun, 12 Oct 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OFg3hL18"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C402EFD90;
	Sun, 12 Oct 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286145; cv=none; b=TMSWgjf7UYRGw0jAo7MGoy9AOzp6jk4RFr1jqq94rj+g1wYJcAsUzfJF0o00hle3slPhx+2e+rDmJHVBdBgYV2/PuJa4BejXwavl727Ft87vdnjDlP+sKsNu8dmtUYVcmOIEPLz6pXPDtk/FXs+56N5Q1OOitu2ArSBNSKR1m2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286145; c=relaxed/simple;
	bh=3jbs08fNIyvNKpddwh4N14hGNazHj5pBQhYu8shc1s0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RiVXoY1f0iODqnJJNBxvzAcSvxCVwiHNePy22SxWoncKNwv1gsqRzR07YLOn/UGk+87VSQQEr973p0sSG0JMh3b1jUfMZ6BJBK90E/luUiXa6n1QsSOr0Ke+1ZIaSoZMOLdMvOJ2ymK5taQzhOA6Bz3/k7X1aa5d0FFH0hlZFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OFg3hL18; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59CGLjMT794400
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 12 Oct 2025 09:21:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59CGLjMT794400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760286105;
	bh=3jbs08fNIyvNKpddwh4N14hGNazHj5pBQhYu8shc1s0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OFg3hL18eG95T3WLOG8l1ExAO8nv9206CGkxuHxVeiUXgdfR7yB4ATkeUfcTDka5Q
	 w1DSnUHOkChjOX3ycIKGSh8ZQq6xYf8uDulQ6DFVhun3AVow/j51w3Lxt/Ypt2h/f5
	 gbP32onyflDMDgGLCAn13ZyyHPydsLEhoLnKLymSugFr3MTt+lY87mjpv7GkKiunQp
	 AnzXNGNbmxPPpb028aM5gB19NLTIY35LfD+M73Vte0YdMwXpkmMIZDEjo5R8MPZhWV
	 rJCq72y9e3vpyMaNuJsSPWfgXIJLMZFkgIe5ZlOnIbDM6PLMuUdj9AzgjzCpOl0trF
	 D6QF17k42Bw4A==
Date: Sun, 12 Oct 2025 09:21:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_Patch_=22x86/vdso=3A_Fix_output_operand_size_o?=
 =?US-ASCII?Q?f_RDPID=22_has_been_added_to_the_6=2E16-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local>
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com> <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com> <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com> <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local>
Message-ID: <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 12, 2025 9:17:33 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sun, Oct 12, 2025 at 09:10:13AM -0700, H=2E Peter Anvin wrote:
>> Ok, that's just gas being stupid and overinterpreting the fuzzy languag=
e in
>> the SDM, then=2E It would have been a very good thing to put in the com=
mit or,
>> even better, a comment=2E
>
>The APM says:
>
>"RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction into=
 the
>specified destination register=2E Normal operand size prefixes do not app=
ly and
>the update is either 32 bit or 64 bit based on the current mode=2E"
>
>so I interpret this as
>
>dst_reg =3D MSR_TSC_AUX
>
>which is a full u64 write=2E Not a sign-extended 32-bit thing=2E
>
>Now if the machine does something else, I'm all ears=2E But we can verify
>that very easily=2E=2E=2E
>

MSR_TSC_AUX is a 32-bit register, so the two actions are *exactly identica=
l*=2E This seems like a misunderstanding that has propagated through multip=
le texts, or perhaps someone thought it was more "future proof" this way=2E

I think the Intel documentation is even crazier and says "the low 32 bits =
of IA32_TSC_AUX"=2E=2E=2E

