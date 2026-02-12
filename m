Return-Path: <stable+bounces-215989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDzEAqFHjmm9BQEAu9opvQ
	(envelope-from <stable+bounces-215989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:35:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28413145C
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 092BA300BB8D
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA929318BA2;
	Thu, 12 Feb 2026 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MbEM/hd7"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670728BAB9;
	Thu, 12 Feb 2026 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932126; cv=none; b=AWDNGzpL2CwBK254w9HuKYfJiIIdF3KO4VIM92haFPGLh3KoHgxPKJkxgu+1JexiqnvOPm7RytiJQR29hNeJwN4uI/5RltE8xKWtw8uqznB4Bq5uC2U6a6Qmt1/O69ETt32pVp2xfHgu0jVr0+iFjI80ojS3u0w+Ny8Co8rkQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932126; c=relaxed/simple;
	bh=H2Qjavq2x54sxEG9DBKfVkYKYrseHCJ4szWVg2giO7Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DBQrb/zGe58TFDsnHHKWuUDPkS83rZtzU+MKnGZHeENS+UBjPMg7UHsHtaiJ2PdnsAArgFKYYC+9SWrkpvylOB0yHs0feNRk7fvVZ5nCYd0toLZlb5469AGQjUV1w24xRcrqO8ogpQ04DzkDpy/7HSQP9a/s/frEmT9ay4+UNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MbEM/hd7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61CLYcX7447043
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Feb 2026 13:34:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61CLYcX7447043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770932080;
	bh=M0XZJZmReOIXKFSVRFdjebpQ8fNluvfjE/S3RhFu6ks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MbEM/hd77HiKrRxrTEv/l+tVBrtQE184+X4M1A+fAexQIoKmwZhRxmlMU1RAsdOtO
	 MBxJ38OLub+g8ixEUKIi+me+D3FsjsQLv4v0/UbFvImmxPo8y4wR6FTKXYGH/CpsbT
	 enajsEknD2PWSlimYgC6fPLasD8V3lL0JAGzpfSwfaA46bIbN8lp3gV9UGsKBDBnQO
	 T2jewEFLXC7ZAZHKFTE5Kv//KQLjDvl4Uwe5VlQlBhibXWOSRK9KRDbwMkp24jFFTW
	 hFtkLumPK/hLYYcBwo5cQyrp1oPgVd8e9tSpQLQ5hkYqn8urZvHXXRMlFtiXXbTojh
	 zmmEPTF57mEbQ==
Date: Thu, 12 Feb 2026 13:34:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
        Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        pawel.chmielewski@linux.intel.com, Farrah Chen <farrah.chen@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/3=5D_x86/cpu=3A_Clear_f?=
 =?US-ASCII?Q?eature_bits_disabled_at_compile-time?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
References: <cover.1770908783.git.m.wieczorretman@pm.me> <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me> <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local> <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
Message-ID: <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215989-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim,intel.com:email,pm.me:email]
X-Rspamd-Queue-Id: 9B28413145C
X-Rspamd-Action: no action

On February 12, 2026 8:23:58 AM PST, Maciej Wieczor-Retman <m=2Ewieczorretm=
an@pm=2Eme> wrote:
>On 2026-02-12 at 16:58:08 +0100, Borislav Petkov wrote:
>>On Thu, Feb 12, 2026 at 03:34:38PM +0000, Maciej Wieczor-Retman wrote:
>>> From: Maciej Wieczor-Retman <maciej=2Ewieczor-retman@intel=2Ecom>
>>>
>>> If some config options are disabled during compile time, they still ar=
e
>>> enumerated in macros that use the x86_capability bitmask - cpu_has() o=
r
>>> this_cpu_has()=2E
>>>
>>> The features are also visible in /proc/cpuinfo even though they are no=
t
>>> enabled - which is contrary to what the documentation states about the
>>> file=2E Examples of such feature flags are lam, fred, sgx, ibrs_enhanc=
ed,
>>> split_lock_detect, user_shstk, avx_vnni and enqcmd=2E
>>
>>I'm still unclear as to when did we break this? Did it ever work as
>>documented?
>
>I went as far back as the stable kernels go, to test separate backports a=
nd I'm
>pretty sure this behavior was always there=2E At one point it was just do=
cumented
>that is should work in a specific way which right now it doesn't=2E
>
>>I wanna say yes, I've seen this turning off a feature removes it from
>>/proc/cpuinfo but I don't remember any details=2E=2E=2E
>
>I believe, previously, the only affected features were the ones that were
>specifically listed with their complementary CONFIG options in the
>disabled-features=2Eh=2E But most of the older ones are locked behind EXP=
ERT config
>option if one would want to compile-time disable them=2E When looking at =
5=2E15=2Ex I
>noticed SGX was there when it was not compiled for example=2E But at 5=2E=
10=2Ex there
>were no non-EXPERT features (at least none visible on the machine I was u=
sing to
>test)=2E
>
>>> Through the cpufeaturemasks=2Eawk script add a DISABLED_MASK_INITIALIZ=
ER
>>> macro that creates an initializer list filled with DISABLED_MASKx
>>> bitmasks=2E
>>>
>>> At the same time add a REQUIRED_MASK_INITIALIZER that can be used for =
a
>>> sanity check of whether all the required feature bits are set at the e=
nd
>>> of cpu identification=2E
>>>
>>> Initialize the cpu_caps_cleared array with the autogenerated disabled
>>> bitmask=2E apply_forced_caps() will clear the corresponding bits in
>>> boot_cpu_data=2Ex86_capability[] and other secondary cpus'
>>> cpu_data=2Ex86_capability[]=2E Thus features disabled at compile time =
won't
>>> show up in /proc/cpuinfo=2E
>>
>>Can you please stop explaining the diff? I can read the diff=2E Put in t=
he
>>commit message non-obvious text which is important=2E Not what you're do=
ing=2E
>>
>>Check all your commit messages pls=2E
>
>Sure, I'll revise these=2E
>
>>
>>Thx=2E
>>
>>--
>>Regards/Gruss,
>>    Boris=2E
>>
>>https://people=2Ekernel=2Eorg/tglx/notes-about-netiquette
>

As the original author of the code I'm pretty sure that bug was always the=
re=2E

