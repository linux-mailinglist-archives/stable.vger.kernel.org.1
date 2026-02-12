Return-Path: <stable+bounces-215979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFtIIJX/jWm0+AAAu9opvQ
	(envelope-from <stable+bounces-215979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 17:28:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77A12F673
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 17:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BC2730FA251
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271635DCF3;
	Thu, 12 Feb 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kAs4FvmW"
X-Original-To: stable@vger.kernel.org
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555F35EDA7
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913452; cv=none; b=LjMMawFP/KB9SmgEhPAdTzc4Z5P2yOKf0Q+YSW1VPnnm2ALgNTxxKLYO+mc3u3HxUDGzKlpOk+tnVRP/6RsrjZHiMG+1vcpKCOO60EFy40F2w9ijdCbuxh2tBV/VO7AZaOH6xnrdENVih5NmgOSRvWTi+vt3/vN5ne9ioJb4wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913452; c=relaxed/simple;
	bh=DENH52bP/QSW7fSxPRgIu+Jql4IWk5tjul76TccaIYs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CynpXuUP3zNBDH2WR+QHk+5DYFkmOlXHKmbRLeS33Y4+D3J1M1uhJW4p49lKHWi9Uw7J0QqWrJtWYEoCd4jmd3Bj+rwMLMDe7W3gQ2QEy9SLrWmTX+AISuVchzKiBf7N+Fploiee8HTGk/GBiCFv/SnMIQm/TLyyZjsvKqoWe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kAs4FvmW; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770913441; x=1771172641;
	bh=1TqWVgI3lqOSkL7FlG9Th6uTtuToAO3RspPqNwDLBNk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kAs4FvmWOyEzR28QyQjNbDWk679xAfQaAlsSCjr2ne84O+NDCitSGYvV8pspHMzec
	 ihEkxzKyp5kKT8qWAhBhXedpW6mQBUbGZ1uu01Ebm/deb4MeFB9TSSokYE5Jas1R7r
	 +Bjo4CMo7W6Yd465oV/IiaHI6uHUhaPwFPpWCP0As2qXGfxxt9/F/VgHUrwB+ZOP9k
	 B7tz8qVJqbACuOV7pS0TNHwFT99GzonvVrgWBU8By0uXX7Zh67J0xKFeyQdaNrskck
	 FiHwAVMdhy2L3UMgHZZHHNvB6JVJ0eCgYACH2+fk3re/Ni0RUsaT27sQj12zian9gU
	 nXR7ic3Gptxhw==
Date: Thu, 12 Feb 2026 16:23:58 +0000
To: Borislav Petkov <bp@alien8.de>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, pawel.chmielewski@linux.intel.com, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
In-Reply-To: <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
References: <cover.1770908783.git.m.wieczorretman@pm.me> <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me> <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 9a9af1cdc1bfc15b77b7b41d9e2f9c00251b15b0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215979-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wieczorr-mobl1.localdomain:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pm.me:+]
X-Rspamd-Queue-Id: ED77A12F673
X-Rspamd-Action: no action

On 2026-02-12 at 16:58:08 +0100, Borislav Petkov wrote:
>On Thu, Feb 12, 2026 at 03:34:38PM +0000, Maciej Wieczor-Retman wrote:
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
>> If some config options are disabled during compile time, they still are
>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>> this_cpu_has().
>>
>> The features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>
>I'm still unclear as to when did we break this? Did it ever work as
>documented?

I went as far back as the stable kernels go, to test separate backports and=
 I'm
pretty sure this behavior was always there. At one point it was just docume=
nted
that is should work in a specific way which right now it doesn't.

>I wanna say yes, I've seen this turning off a feature removes it from
>/proc/cpuinfo but I don't remember any details...

I believe, previously, the only affected features were the ones that were
specifically listed with their complementary CONFIG options in the
disabled-features.h. But most of the older ones are locked behind EXPERT co=
nfig
option if one would want to compile-time disable them. When looking at 5.15=
.x I
noticed SGX was there when it was not compiled for example. But at 5.10.x t=
here
were no non-EXPERT features (at least none visible on the machine I was usi=
ng to
test).

>> Through the cpufeaturemasks.awk script add a DISABLED_MASK_INITIALIZER
>> macro that creates an initializer list filled with DISABLED_MASKx
>> bitmasks.
>>
>> At the same time add a REQUIRED_MASK_INITIALIZER that can be used for a
>> sanity check of whether all the required feature bits are set at the end
>> of cpu identification.
>>
>> Initialize the cpu_caps_cleared array with the autogenerated disabled
>> bitmask. apply_forced_caps() will clear the corresponding bits in
>> boot_cpu_data.x86_capability[] and other secondary cpus'
>> cpu_data.x86_capability[]. Thus features disabled at compile time won't
>> show up in /proc/cpuinfo.
>
>Can you please stop explaining the diff? I can read the diff. Put in the
>commit message non-obvious text which is important. Not what you're doing.
>
>Check all your commit messages pls.

Sure, I'll revise these.

>
>Thx.
>
>--
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


