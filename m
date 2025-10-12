Return-Path: <stable+bounces-184118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C3BD085F
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C743188DB17
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6318FC80;
	Sun, 12 Oct 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KUX2Jsh7"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0D28E59E;
	Sun, 12 Oct 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760289381; cv=none; b=Ejc8qF/Qc3Mm4qE5j16QPSr4inB7DzliiFScDFAZcaake9MeX0ogXVzb2hNrFdYUZV6vmqUiAvcxBBXjcNE9O8L/MjK78b2iuz5T31Ttn7OKJv7o1j3JxEuXeiQa7XaVaOXujqznuDXZWDOy9qgSzGQm+yuTSVHWgotGBdc/OTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760289381; c=relaxed/simple;
	bh=pVxdOaIHWzcPmKNyVn3Do6N1fn+JU3YXVNV/4S+Zdd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtWdVdD7EPqV3Q0WpIUMKKgQAhqjVXjzPQo+S5HwOlxGae8HUAsp+WQ4FU1CNfb3VxtE41JmIUreQR1jmkKILHgMNfZyCNACgxQ5iQHGzVtyCoVbpK2TlrUueKoCd0+9G4TQeHteGDTmTyBED36eI5ia6noBVWPwnooeXJXC7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KUX2Jsh7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A4BFF40E01C9;
	Sun, 12 Oct 2025 17:16:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Go3UW1Q9FCRe; Sun, 12 Oct 2025 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760289368; bh=vaCBfOCy0QkUe7pv8PrCZw3GFNaYZJqKUhITngbIbHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUX2Jsh7Zk2uCSXJmguYKeHL3qS2z9uNQxDFLzRPc6z8UDMJd2+R6pqdlnMbx73uD
	 bMB7vmheROkBbcsKKhYyras9m58AZOhF7yndodsjtThFWOFs9cjMMckD1O+6tcL2mr
	 KT+RAiRWKcixvzyoL4T4PgzjcML77JfIY6YuQGjvqsYhKrIDnTqEFhuQxRjC/POMWX
	 +Fo6RlbzKH3m2E52lhP7zkDqPtUx0OVWVataQy1SElgShdN9hdKwKVtiuSKXYoY1wp
	 4cf97NbF5I13Fv9TsbfrGlAxXmnfak+QeZKDs9Cmf8vzAQk+Svh3EdP5Rzvl/LKV5j
	 NVaAWk2r4Ku2ALJoPQAozybOrKZWz9yAnDdO06jwoKE/Ph5EvyhxNjtQYbb/+spKyr
	 zoHTGPbieSqOiwbwwJQulhJYMC86KLMPEibsufJc7leK+cJInyVTG2tq1denMSNPvb
	 1glqTAPcrHrgKhx3Ly2R5Aa7SqZnj7qvUz+p/PSVS8fTvADeL0ebhETrkNYL9nLyT/
	 0RmhNtvHhzj5gPihaMNeLkvyu4TyuKN/RuWLBNT+wJOWLHjzHB34e07SDTbVHYaq66
	 SkE4PFSqS6EsuKyHWUpZXaXNIkWq9DQnv4ipZNQ/cAAMHs6LLOiTWj05NldDrwR53D
	 fzQ8zdWrODt1L+Xi0vPInLqs=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4271940E019B;
	Sun, 12 Oct 2025 17:15:59 +0000 (UTC)
Date: Sun, 12 Oct 2025 19:15:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: Patch "x86/vdso: Fix output operand size of RDPID" has been
 added to the 6.16-stable tree
Message-ID: <20251012171553.GBaOviScvp-9gtgwnk@fat_crate.local>
References: <20251012142017.2901623-1-sashal@kernel.org>
 <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
 <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com>
 <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com>
 <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local>
 <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com>

On Sun, Oct 12, 2025 at 09:21:44AM -0700, H. Peter Anvin wrote:
> MSR_TSC_AUX is a 32-bit register,

Every MSR is 64-bit. This one has bits [63:32] reserved. :-P :-P But yeah,
TscAux is [31:0]...

> so the two actions are *exactly identical*. This seems like
> a misunderstanding that has propagated through multiple texts, or perhaps
> someone thought it was more "future proof" this way.
> 
> I think the Intel documentation is even crazier and says "the low 32 bits of
> IA32_TSC_AUX"...

Well, funny you should mention that - this raises a good question: what
happens in the future if we want to put the whole u64 into the destination reg
of RDPID?

Should we extend the insn now, while the high u32 is reserved and is a don't
care?

Because I can already see the CPUID bits and such saying: "this RDPID flavor
reads the whole u64 MSR, yadda yadda..."

If we fix it now, there's no need for any of that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

