Return-Path: <stable+bounces-135164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97AA973A1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B937189B4D1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED951B0F17;
	Tue, 22 Apr 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KderWG1s"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D021AF4C1;
	Tue, 22 Apr 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343202; cv=none; b=HGubgrhgUpZjOdPVavlQorpgbc87tJUs9BfDfPR7o8EZ4UWHvHY/KgQknRUJ7gvM+GFcEBs01lkBB3pAmv7El60cFLNOhMjLaK3FAnouGXFmZ7iZG0C/46p1KPmvMok4qs4+isQ9cut8iTcDchkH2VpvdPUQAEfGn9W8MQaIkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343202; c=relaxed/simple;
	bh=nDE0j/GNP/64EOh5+qPkXXTTWN1VYjvGYw+ExO+NfDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6/NDNeXErfFFz/F+SQeyMiT5oUnmPJWMa3fTPcL8OHvtuITzpF1On2GmP2y9yuuqNoQNlDnW0JQIJv3eULrULFfUOzfTM9BISVCx136EepENLdRTJ7TDm/zilgYhzABDW/Kf6KJ3QRSQabSFv9xTjWdHi+rS8Y1TR6658Rz4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KderWG1s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 37A7D40E01ED;
	Tue, 22 Apr 2025 17:33:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a0C3SPjvifPl; Tue, 22 Apr 2025 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745343193; bh=X8pD1Z4HEovvmoASmtZVAgGiq/rZgl9YBNbnIFcjgCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KderWG1sfdcYIovI6tf/tkMBix2EoXrvOPrS66C+BB6tv104jiJ4EX8U53mT5/n2H
	 RxkrsD3AQZvTZwjadXR7kc83f/oQdi64KlWBDqF1qqWas+LR3jAcsNa2Ky+SErm9ri
	 8hg8qSl4G1p/P4iFsUVyTtymdDt1/wkkC9ssm6CuH9STwaOpguUTV1CreWt1bs9Qqf
	 sa1f6o1KHCzCPh7yUIoyplSRuTb7nWtsBnI1fAd5PfnIO0f07CV6u/OMSSc25ERDt0
	 OLczxgE4UHhx/R4IYgmcnIgP1YIny2z5DM3i4m6YrSuCv2qz6CrFMAwhq9m0FbdtV1
	 yD4ho1hMI+rgeCYLyiE0mTJ9WmLlrq1NbYTNicdQa7C3925oRVDllnPpcJlPdBs210
	 FlWMTTNWMbaaVFFJjxo4oY86JU08jFsEK6HPMWo1OWhT4DUa03G3xZCaem1a0MO+sO
	 MkuA6nxlLqHsMonmtv4rOvTn4ZvzQc2S/+7xBZaphIi68x9g86F0sUuBR8YYQnIYmP
	 AvGiAq2yZPUq2pJUShvLpEOUX+dHlDz3oj5jpAefj9xO1c9wmhaRXSvTJ2x+q8fCA5
	 Gh9iMra3AGExLXn4hmYYlYmvq/yxwJ8YuD8OPo+qHdqspDLp4oiH4Hk7ilkqreBxa4
	 0MhVqt2eofDLjUkMffGJBgm4=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C180640E01CF;
	Tue, 22 Apr 2025 17:32:54 +0000 (UTC)
Date: Tue, 22 Apr 2025 19:33:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Subject: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu:
 Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in
 a virtual machine)
Message-ID: <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAfQbiqp_yIV3OOC@google.com>

On Tue, Apr 22, 2025 at 10:22:54AM -0700, Sean Christopherson wrote:
> > Because I really hate wagging the dog and "fixing" the kernel because something
> > else can't be bothered. I didn't object stronger to that fix because it is
> > meh, more of those "if I'm a guest" gunk which we sprinkle nowadays and that's
> > apparently not that awful-ish...
> 
> FWIW, I think splattering X86_FEATURE_HYPERVISOR everywhere is quite awful.  There
> are definitely cases where the kernel needs to know if it's running as a guest,
> because the behavior of "hardware" fundamentally changes in ways that can't be
> enumerated otherwise.  E.g. that things like the HPET are fully emulated and thus
> will be prone to significant jitter.
> 
> But when it comes to feature enumeration, IMO sprinkling HYPERVISOR everywhere is
> unnecessary because it's the hypervisor/VMM's responsibility to present a sane
> model.  And I also think it's outright dangerous, because everywhere the kernel
> does X for bare metal and Y for guest results in reduced test coverage.
> 
> E.g. things like syzkaller and other bots will largely be testing the HYPERVISOR
> code, while humans will largely be testing and using the bare metal code.

All valid points...

At least one case justifies the X86_FEATURE_HYPERVISOR check: microcode loading
and we've chewed that topic back then with Xen ad nauseam.

But I'd love to whack as many of such checks as possible.

$ git grep X86_FEATURE_HYPERVISOR | wc -l
60

I think I should start whacking at those and CC you if I'm not sure.
It'll be a long-term, low prio thing but it'll be a good cleanup.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

