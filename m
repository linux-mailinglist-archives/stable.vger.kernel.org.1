Return-Path: <stable+bounces-240210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMNANtqs52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:59:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905F43DADB
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 779923016489
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E9314A6F;
	Tue, 21 Apr 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CBfOzmMT"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231A382370;
	Tue, 21 Apr 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790739; cv=none; b=TdbSt9o7Z4B53RybzxqLL6Gk8KFQHRRc/1I/8pFMXrD5Y9NhyS3Th5mxg5IygdWjHPVVnTwR1BXyQlRl4bG9QZW9uMVW6+DM/W6bqSlWDQnXOJ8TZkxKjBQt1Yix8/IYF/kKsrg3l55Hrpiyo7EBtWICu4CbI1H42Gc4OW3VGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790739; c=relaxed/simple;
	bh=u/TpoA7M8fHQVF3GHnJ0MxRqHMzHx7O0kFgdqk3yZBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh5WXZ/GM9Ttn8zc8iA4BCtosN2SBaIo78kpjF+05JbN5PakpafczNmuj25ppqKjgkTcsgumtZuBDAFm6OxErdy4oCDbzAONUWv8J3S75Y7/AH0phta4nIVJlT8BOL8tB1vi/Ng1DpDJckQm8WcfyCIywScxHvHbZgaTdVCHjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CBfOzmMT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3517B40E0032;
	Tue, 21 Apr 2026 16:58:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n4_kUGCYMJad; Tue, 21 Apr 2026 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1776790722; bh=X3AVfNG+RUCrP//XDBUl3HU2ECqpZ+bLQ8PcNN80ZX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBfOzmMTNmtDz/+tZrB7X7TWVIB/ysfw6Qn6rgHlgEJh9Cr9jhPPcu8x2eicQf3Zl
	 o56BIonEQ94FNCbTgVyZwna9KSQt6uXjdzYk4n2pgCrWFUKMRVDxwT9uCUKZ26Wvwo
	 8ER68nvSkjh+jLuej1oyIr1ftghKWBmSSXvmK5FxqDY4/fvNPxhJ1aKwlICqKZDT8c
	 xU3u4+7tpDRAJbKzjuGGPL4Kgw9Hb+kSuDYEc4TysA8uU/fkLJ63xsw8BSuP8YPuH9
	 rdvOrBXwWuq//cNdybfj4CJvz6E0EVQRbYOFkbXcKyeMWx8ilwrcVOYlco4Wzl6v4m
	 UYbc/RC9wHtfXAll4syG659IRkPZlkwEh1pe5H22uetkSVekae0i11m+KBset0+AZY
	 UcdqKak/uv1zeoYdw02cSYOxoly9UrxMS+gTRunkR9gF8GqKhF9FjStvcXgTTcbem2
	 4hiP3Ss/Fxo6UNypHR3Q2iYc3t0faz8SnqF9YqHgXx09VkRWCvLRs4HH4d6WmUKwFx
	 +iJDI0OaN/OV/IYz9+AFyXeWeWrkBqDHlwyAQ6k3p/TDCsK7RdsM4yFPNfQB2Iu/hN
	 i5l3cSAGGMPOC1ClCpTpMsf3ccxpzt9Jgt9eeANGWAAwo1dsZ2oJm8oDatAcd7W/N8
	 HM9A99y7J4bTVTigQuIjDgIc=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 032F440E00DC;
	Tue, 21 Apr 2026 16:58:31 +0000 (UTC)
Date: Tue, 21 Apr 2026 18:58:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Gayatri Kammela <Gayatri.Kammela@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Disable FRED when PTI is forced on
Message-ID: <20260421165825.GDaeessUjk976tr5Cg@fat_crate.local>
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240210-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,zytor.com:email,intel.com:email,amd.com:email,alien8.de:dkim,alien8.de:email]
X-Rspamd-Queue-Id: 5905F43DADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 09:31:36AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> FRED and PTI were never intended to work together. No FRED hardware is
> vulnerable to Meltdown and all of it should have LASS anyway.
> Nevertheless, if you boot a system with pti=on and fred=on, the kernel
> tries to do what is asked of it and dies a horrible death on the first
> attempt to run userspace (since it never switches to the user page
> tables).
> 
> Disable FRED when PTI is forced on, and print a warning about it.
> 
> A quick brain dump about what a FRED+PTI implementation would look like
> is below. I'm not sure it would make any sense to do it, but never say
> never. All I know is that it's way too complicated to be worth it today.

... and if anyone attempts it, they better justify the effort and overhead.

> <brain dump>
> The SWITCH_TO_USER/KERNEL_CR3 bits are simple to fix (or at least we
> have the assembly tools to do it already), as is sticking the FRED entry
> text in .entry.text (it's not in there today).
> 
> The nasty part is the stacks. Today, the CPU pops into the kernel on
> MSR_IA32_FRED_RSP0 which is normal old kernel memory and not mapped to
> userspace. The hardware pushes gunk on to MSR_IA32_FRED_RSP0, which is
> currently the task stacks. MSR_IA32_FRED_RSP0 would need to point
> elsewhere, probably cpu_entry_stack(). Then, start playing games with
> stacks on entry/exit, including copying gunk to and from the task stack.
> 
> While I'd *like* to have PTI everywhere, I'm not sure it's worth mucking
> up the FRED code with PTI kludges. If a user wants fast entry/exit, they
> use FRED. If you want PTI (and sekuritay), you certainly don't care
> about fast entry and FRED isn't going to help you *all* that much, so
> you can just stay with the IDT.
> 
> Plus, FRED hardware should have LASS which gives you a similar security
> profile to PTI without the CR3 munging.
> </brain dump>
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reported-by: Gayatri Kammela <Gayatri.Kammela@amd.com>
> Cc: stable@vger.kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---

Yap, let's do the simplest thing first.

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

