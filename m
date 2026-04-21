Return-Path: <stable+bounces-240256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG7SE+ME6Gl2EQIAu9opvQ
	(envelope-from <stable+bounces-240256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:14:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1244077E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B4930CBD2E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873573806AD;
	Tue, 21 Apr 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XYVxmFvt"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769723A0B13;
	Tue, 21 Apr 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813188; cv=none; b=XgATH0ZlKMNFpSOnZVTa3MlBKO35oriSBnIoYGvmc1uBLKR0FR1fHZaopjgWh4RUzhba34yf/xwnSKCMEFWuOpKrH3faYQ5n8ucjKjq+hBztPuzJeufN5ISGmWg2HooLZFgV2lWEkfcO5UVkPa6ziPe/HlWlm63k8i4bOLmaeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813188; c=relaxed/simple;
	bh=TcLXkd2I/ZvLX7dVlkAIZjnxaPXjjf0UY9RNvYinQeM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PAkn6zIJRFpDz6BNqnIM9TOt8Z/OEiEPdKaR2ewbWN1g90tHDN0iNTrUw11wK9edRAb15Jk4l5UZukfKgai2OV4b7SOCr/kHCjMrtXB5EGTu1V3977dkiXrJUZm8jUiqbVgnzOwdUSo8gevqGM0w6fpPLaUAF+yqHEdQ0jF0/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XYVxmFvt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 63LNCFcT1363037
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 21 Apr 2026 16:12:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 63LNCFcT1363037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1776813137;
	bh=LaJcDYtG7/5Kt21btLCyRMXVdK5jUtXJyiF0SqSRq3U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XYVxmFvtyTNj3K0hBIsWLcdu84nhUl8BrQaHFpeew1ezrfFokOuVlmgq2EYlZsmH4
	 umP9C7iDZESStEQHSiqbrPRqKmzZk84XpZ3YvHhqurfNKTknXc8NePtfj+TtbZKohY
	 grB4o+ocLd7j14VC1ZXIgQFVVyId9NKFXpRiJaLbNEsQHCSpLPEWikEAkLmN2kcbvr
	 aYEty37/cr8dKPbbmQ+T10mkREnYcHZ9VbxycA1VJ4U1Ws1qHaCjOOf7W51IVSjcfM
	 B8qsKL3vIhpTEDey2Kbcf2/sJH+1ZJsspZn1ix8pSQJ9F887ntHWWfKqGK27txC0IC
	 pvz8y+1sGo0Cw==
Date: Tue, 21 Apr 2026 16:12:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
CC: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Gayatri Kammela <Gayatri.Kammela@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Disable FRED when PTI is forced on
User-Agent: K-9 Mail for Android
In-Reply-To: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Message-ID: <BE6E847D-371B-4C46-8104-725C5E71E162@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026032601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240256-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:email,zytor.com:dkim,zytor.com:mid,infradead.org:email,alien8.de:email]
X-Rspamd-Queue-Id: 9BA1244077E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 21, 2026 9:31:36 AM PDT, Dave Hansen <dave=2Ehansen@linux=2Eintel=
=2Ecom> wrote:
>
>From: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>
>FRED and PTI were never intended to work together=2E No FRED hardware is
>vulnerable to Meltdown and all of it should have LASS anyway=2E
>Nevertheless, if you boot a system with pti=3Don and fred=3Don, the kerne=
l
>tries to do what is asked of it and dies a horrible death on the first
>attempt to run userspace (since it never switches to the user page
>tables)=2E
>
>Disable FRED when PTI is forced on, and print a warning about it=2E
>
>A quick brain dump about what a FRED+PTI implementation would look like
>is below=2E I'm not sure it would make any sense to do it, but never say
>never=2E All I know is that it's way too complicated to be worth it today=
=2E
>
><brain dump>
>The SWITCH_TO_USER/KERNEL_CR3 bits are simple to fix (or at least we
>have the assembly tools to do it already), as is sticking the FRED entry
>text in =2Eentry=2Etext (it's not in there today)=2E
>
>The nasty part is the stacks=2E Today, the CPU pops into the kernel on
>MSR_IA32_FRED_RSP0 which is normal old kernel memory and not mapped to
>userspace=2E The hardware pushes gunk on to MSR_IA32_FRED_RSP0, which is
>currently the task stacks=2E MSR_IA32_FRED_RSP0 would need to point
>elsewhere, probably cpu_entry_stack()=2E Then, start playing games with
>stacks on entry/exit, including copying gunk to and from the task stack=
=2E
>
>While I'd *like* to have PTI everywhere, I'm not sure it's worth mucking
>up the FRED code with PTI kludges=2E If a user wants fast entry/exit, the=
y
>use FRED=2E If you want PTI (and sekuritay), you certainly don't care
>about fast entry and FRED isn't going to help you *all* that much, so
>you can just stay with the IDT=2E
>
>Plus, FRED hardware should have LASS which gives you a similar security
>profile to PTI without the CR3 munging=2E
></brain dump>
>
>Signed-off-by: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Reported-by: Gayatri Kammela <Gayatri=2EKammela@amd=2Ecom>
>Cc: stable@vger=2Ekernel=2Eorg
>Cc: Andy Lutomirski <luto@kernel=2Eorg>
>Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>Cc: Thomas Gleixner <tglx@kernel=2Eorg>
>Cc: Ingo Molnar <mingo@redhat=2Ecom>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: x86@kernel=2Eorg
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
>
> b/arch/x86/mm/pti=2Ec |    5 +++++
> 1 file changed, 5 insertions(+)
>
>diff -puN arch/x86/mm/pti=2Ec~fred-vs-kpti arch/x86/mm/pti=2Ec
>--- a/arch/x86/mm/pti=2Ec~fred-vs-kpti	2026-04-21 08:37:01=2E124709928 -0=
700
>+++ b/arch/x86/mm/pti=2Ec	2026-04-21 08:41:11=2E219700206 -0700
>@@ -105,6 +105,11 @@ void __init pti_check_boottime_disable(v
> 		pr_debug("PTI enabled, disabling INVLPGB\n");
> 		setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
> 	}
>+
>+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>+		pr_debug("PTI enabled, disabling FRED\n");
>+		setup_clear_cpu_cap(X86_FEATURE_FRED);
>+	}
> }
>=20
> static int __init pti_parse_cmdline(char *arg)
>_

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

