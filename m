Return-Path: <stable+bounces-143062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76142AB1BA0
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28781C46E3F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC11237186;
	Fri,  9 May 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HuZzubWh"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B145038;
	Fri,  9 May 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811972; cv=none; b=QLAJSlLL6CPZEmkiZCRDaj9xvgME/wXt3NAEw6cYMnPOiWVE/h1hKzB3eZUnR0jswYPVTcgpsVyGhwfJllUruV3gfwgzbXiu55GBpJGBYIPdxQY5yIh7+shtspZyMyn4GH93WdUNzH/tQ2S1vc1sXBHCiiIewzSf6WM3UMoogFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811972; c=relaxed/simple;
	bh=BYghYgLKz845p/XJUOgV5+fweGgy0oL4oXzWYAfXIGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbGeLLPk4IBESx4hWo6dcnDG+p+sXjgPRZR5FAhkX1jvj/QtBxL77a85RcD+hM+LCeKBcg1Yhb44sugpQoqXk7/HZJ2IjD0Hwui2tTTKbz8r3KReg//NiicknJp89hb/p3BmLR7JllCXz5oqUhtNUO1DO8pCWnZsYU3SvZPuE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HuZzubWh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1914640E01CF;
	Fri,  9 May 2025 17:32:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QP-XzlRqnOfZ; Fri,  9 May 2025 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746811962; bh=92FBgt9X64NNgwgndLEy21ZDonQ9gW2RlXVeTWQ7YCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuZzubWhBj+bfLZE+YRtp8iBNxxFiR2Eg98G0JtYkLbtOzksG7IyiPCeOqSbwJXJT
	 E1zyb7RSbovxsFzasq4gZluAvNeGCMO5XVm77neg5V525PpR7XULkoHwH1NpjOqgW4
	 MMA57bP5OEYUovC8rtePBK9wFDWHIQWRLP3zED04BGf1Furmj30FfQHettBLsXNKZt
	 I7mxnaW+vXqcslYDEgfw0bt0sOniuPjgXKU/WHMmvzf9pmVYJ9ez3VuFask7KJSRB6
	 HrnNTCCpQAqzSjxiqxTNHjTBt2McSg+ANrdOAPUXPep69mCtnWzKSc4D986dueIemK
	 bZIwTJC+l0UQR23Ig1WuX6U29+fEr/+QQ9icYFxKQR9QEJsgHposZRJ2DPAd6fMjkh
	 anaA9ATNvLJndcc3euJ/jIqLIHigYe2QSvXq5bfMA5djQKZc64B8+HnlPOhHkJ4x9g
	 NAyiVEMeOCx/JMAcMwpX7PUxGgn8MIZQ8IRzSsbGD93vBpDVOUFxTJ1LqBIG01hwfy
	 UjF3JmvoPEowqyt8A/4YVILdIpngBLMHD+MYO7Mh0PcoVRurByZS/Kd11zRiFkJVR7
	 dDq4BAZ1nRE30tKAbFWQY7c0t62lV+EdfRwBDw/eojza9yHgwUrg3LxC4VjaaxlxeZ
	 fQmznck9KvdSAV6aEz/PVdHA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3288C40E0222;
	Fri,  9 May 2025 17:32:31 +0000 (UTC)
Date: Fri, 9 May 2025 19:32:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
	Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed-range MTRR exists in
 mtrr_save_fixed_ranges()
Message-ID: <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local>
References: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>

On Fri, May 09, 2025 at 05:06:33PM +0000, Jiaqing Zhao wrote:
> When suspending, save_processor_state() calls mtrr_save_fixed_ranges()
> to save fixed-range MTRRs. On platforms without fixed-range MTRRs,
> accessing these MSRs will trigger unchecked MSR access error. Make
> sure fixed-range MTRRs are supported before access to prevent such
> error.
> 
> Since mtrr_state.have_fixed is only set when MTRRs are present and
> enabled, checking the CPU feature flag in mtrr_save_fixed_ranges()
> is unnecessary.
> 
> Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

Next question: this is CC:stable, meaning it'll go to Linus now.

What exactly is it fixing?

Because the patch in Fixes: is from 2007. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

