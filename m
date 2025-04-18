Return-Path: <stable+bounces-134649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A317A93E27
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDBA444234
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7E224AE8;
	Fri, 18 Apr 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DxKsGxaU"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048C208A7;
	Fri, 18 Apr 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003578; cv=none; b=Uh6I0tB0AKzBZm4rNuTvXEUF1+G5k14Y/6rCh9EwA4R0PW4J4QObDOqrJFI4lYz/AuCp9BafGpRkgU+42XXajB6HKZI/3tFwo/ruX3LBf2DngU6Ar9kPfAfWAOckWr0owg7O0uNjRQu+cCOgbPutjQz4qPjH7/Ov8qgNnSpCWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003578; c=relaxed/simple;
	bh=heWZB3ttpotaCwOLggR7a3xPYSXNHPSD4GYh+irvlio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/qNyuLNBb3bjYzM7sd7Wfw2aDu6kZHlPNYh0hAeomD2aJia2F86Oezy8MkqRQYTFpYZbDsVtooLqUL62kRlVQc2ZMqeZEjfULPTzIHqNQuu2s9xn8zcBik876/kdioRkPHin3HX5/x5z3i3fIqufA1wI0PzSHOd6O4qZFYWXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DxKsGxaU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A7D840E0242;
	Fri, 18 Apr 2025 19:12:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fyg-1JqDRXFt; Fri, 18 Apr 2025 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745003568; bh=vqs5bEYDx2rK7w9nakwEETZdrDS+pQNjh6rv5r2rEOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxKsGxaUFmC38C2fmAjgpvedGBqaRRaOPChVhL5ECbdU0lKZmfwTNGKdnFJGLMkvH
	 DvSlEXOTSyXwLD/f/7iAQpV8tZ+jMjOwy+xcB2G0ZUkB91t+Kd2uWafQlaVSSvNGzR
	 c9TlQJc1z2mFLcCFNI+a5k+L+PFnXmn5y7Y1CabrxhyNroBxc/+mlDpl2wHDfZ+W4N
	 Qxf03CLJMYvfuSTkDOd/iotXQqSF9gVU+PQef9Smt4/1TAnzqyU+3FHHO7gt4byCpu
	 xQfAYwvG7F+I2pyqmn7Md5ADkCi33APLaPQ8cqJuujOrUfjk1dg606kMxSRYZIgFBb
	 RySOZfosXsGWYjeG5U/PFTH45A6jFPb37qVD6vKKv9aMGs4ILTW3ZtOtdEHg2aksFJ
	 sJRWrbnPycJaBMtgHJ/cQtu1SrQrMpx7p9XmzYYNyqdr6OlGSLh8xsCUHSuoN3Ffxs
	 RhQS3OoKIgfmYuZrephXiThTJlr0+PzCi3VF7zkXmE6anbvbkGFogHbTGcKI6cSJmV
	 hlTovOqEQcDnOgwc03UUBu3/nJ/c9X2h322xTu54c86ffwGb4mU+VRtf16fDs0Zfjq
	 uXIFxxS9gZOlNeDdA9NIVdeGAUwJ0UA252GhwbioYBCoEjA/rBsOM2yd7HQnyDcHwF
	 eM8Ba45dgzbSK0eWn3ICaprs=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15EB340E0200;
	Fri, 18 Apr 2025 19:12:31 +0000 (UTC)
Date: Fri, 18 Apr 2025 21:12:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	darwi@linutronix.de
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear
 X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual
 machine
Message-ID: <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAKaf1liTsIA81r_@google.com>

On Fri, Apr 18, 2025 at 11:31:27AM -0700, Sean Christopherson wrote:
> IMO, this is blatantly a QEMU bug (I verified the behavior when using "kvm64" on AMD).
> As per QEMU commit d1cd4bf419 ("introduce kvm64 CPU"), the vendor + FMS enumerates
> an Intel P4:
> 
>         .name = "kvm64",
>         .level = 0xd,
>         .vendor = CPUID_VENDOR_INTEL,
>         .family = 15,
>         .model = 6,
> 
> Per x86_cpu_load_model(), QEMU overrides the vendor when using KVM (at a glance,
> I can't find the code that actually overrides the vendor, gotta love QEMU's object
> model):

LOL, I thought I was the only one who thought this is madness. :-P

> 
>     /*
>      * vendor property is set here but then overloaded with the
>      * host cpu vendor for KVM and HVF.
>      */
>     object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
> 
> Overriding the vendor but using Intel's P4 FMS is flat out wrong.  IMO, QEMU
> should use the same FMS as qemu64 for kvm64 when running on AMD.
> 
>         .name = "qemu64",
>         .level = 0xd,
>         .vendor = CPUID_VENDOR_AMD,
>         .family = 15,
>         .model = 107,
>         .stepping = 1,
> 
> Yeah, scraping FMS information is a bad idea, but what QEMU is doing is arguably
> far worse.

Ok, let's fix qemu. I don't have a clue, though, how to go about that so I'd
rely on your guidance here.

Because I really hate wagging the dog and "fixing" the kernel because something
else can't be bothered. I didn't object stronger to that fix because it is
meh, more of those "if I'm a guest" gunk which we sprinkle nowadays and that's
apparently not that awful-ish...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

