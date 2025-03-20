Return-Path: <stable+bounces-125666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CFA6A986
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B81887DA4
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096191E2852;
	Thu, 20 Mar 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CXAoMV8u"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35A1C3BE0;
	Thu, 20 Mar 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483504; cv=none; b=j7Th0GEj6R0jsWpOp0Rxp9fqrpwCEql0TtlcWYfFu7GxvWGozEaHSjLxF4nE2SSJefvAdoCgSdfpRJzETEk/aRChAU2Ht6bsh0irP7zZKlv79tmSl27HVZWdMn4fI1r+0Wrwvhyidzc692oqokMvuzLVGzVbL9u5hTUsO1RYmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483504; c=relaxed/simple;
	bh=BjLAQEDSErfN9sPXIBj0NC15mJmGU7FYhtQ9W7EZxwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hqx4ZHJJ+xVCZMtJPBN0Gk6y6KXIgXFJli7ofB7DlTM/ZtK291/5CXB0+QxwwcUSOhVZaeAQnHKFUhmN9W9mY6HkJV3XrQbZL6kHkEgNA3JxFYpE/iFfFpH0JnMrIwU1Toka0htz3GFxqOfLaIOiNyCzV/p9l5c2hc/tAIRN4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CXAoMV8u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2DA140E021F;
	Thu, 20 Mar 2025 15:11:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RNXjYP4yihtd; Thu, 20 Mar 2025 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742483496; bh=qeM1gyjqPFAqI7hDvnbI6oljMznMz2Vvn97c6yg0h4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXAoMV8uUoMIZ0erR0gXo+BW2ihP6hKnxrRhrycZlzGIgmqXbZPcP1TIDPAe1v21i
	 OffFO5/I/be3Tl0AXwRu7cYyQdvDSKgFO/X/gitCXjwi+bXRZNIItnIEhgiugBVt6R
	 hBDTrf6BLObTCayJqzbpPuneUTaLAOWnvvqXX/Tbbhp7DL0wsr+N68wqs/YQ3Iw2GA
	 x6D7HqofSiImvT52LCSJy7WWM/1oWwmnun958NxN1Pyt8pz5WqSy7wXNfK9gSv7k/j
	 Fj1KQhUGbI02o7mpkJwvXcnSed+4sO+FXxMf3RhI+5gAGIVNdzv6ro437nvni6r2zF
	 EzXnxz41Otb97V+5wAsQ6KGZfiAIsPMMWqFGLX5+9uO0a1MDBjmEXdXJFM+cuqXp5g
	 nOE+vXn9VyVkqQeEBvgArqtfDgm7vRhWsraXkgLUlFbaF9plhp3kyAasj/iRkLXgwD
	 jryfu4EM3ussNR/C4XPZaQzGBfzNiAvv+NyOw655yMxYxOWTQN91TVix9FmONlEzDL
	 sPNMHFIdAGbb49V5PwAJK5kuoUYZKYoVM4o8DcDn/lACGMcARRWbG7uzr6kOwaeedh
	 ie9gwYogwK645B2X8fhipGwqWMn0A6yJ/fsp9ReynVfbMiIxcHnpZqHfs2Dgm74BgD
	 ms0RLiTTp8UGMPCw91iCGfds=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9363E40E015D;
	Thu, 20 Mar 2025 15:11:26 +0000 (UTC)
Date: Thu, 20 Mar 2025 16:11:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Akihiro Suda <suda.gitsendemail@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	stable@vger.kernel.org, suda.kyoto@gmail.com,
	regressions@lists.linux.dev, aruna.ramakrishna@oracle.com,
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Message-ID: <20250320151120.GCZ9wwGJZQMLKKm5fT@fat_crate.local>
References: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
 <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
 <Z9s5lam2QzWCOOKi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9s5lam2QzWCOOKi@gmail.com>

On Wed, Mar 19, 2025 at 10:39:33PM +0100, Ingo Molnar wrote:
> Note that silent quirks are counterproductive, as they don't give VM 
> vendors any incentives to fix their VM for such bugs.
> 
> So I changed your quirk to be:

This fires on my Zen3 now :-P

[    2.411315] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    2.415307] ------------[ cut here ]------------
[    2.419306] [Firmware Bug]: Invalid XFEATURE_PKRU configuration.
[    2.423307] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/common.c:530 identify_cpu+0x82a/0x840
[    2.427306] Modules linked in:
[    2.431307] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.14.0-rc7+ #1 PREEMPT(full) 
[    2.435306] Hardware name: Micro-Star International Co., Ltd. MS-7A38/B450M PRO-VDH MAX (MS-7A38), BIOS B.G0 07/26/2022
[    2.439306] RIP: 0010:identify_cpu+0x82a/0x840
[    2.443306] Code: e8 bb f2 ff ff e9 4f ff ff ff 80 3d 07 4e 7b 01 00 0f 85 af fb ff ff 48 c7 c7 a8 fd f0 81 c6 05 f3 4d 7b 01 01 e8 e6 49 04 00 <0f> 0b e9 95 fb ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
[    2.447306] RSP: 0000:ffffffff82203ec8 EFLAGS: 00010296
[    2.451306] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
[    2.455306] RDX: 0000000080000003 RSI: 00000000ffffffea RDI: 0000000000000001
[    2.459306] RBP: ffffffff82a09f40 R08: ffff88883e1fafe8 R09: 000000000027fffb
[    2.463306] R10: 00000000000000ee R11: ffff88883d5fb000 R12: 0000000000000000
[    2.467306] R13: ffff88883f373180 R14: ffffffff8220ba78 R15: 000000000008b000
[    2.471306] FS:  0000000000000000(0000) GS:ffff88889742b000(0000) knlGS:0000000000000000
[    2.475306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.479306] CR2: ffff88883f1ff000 CR3: 000000000221a000 CR4: 00000000003108b0
[    2.483306] Call Trace:
[    2.487307]  <TASK>
[    2.489459]  ? __warn+0x85/0x150
[    2.491306]  ? identify_cpu+0x82a/0x840
[    2.495306]  ? report_bug+0x1c3/0x1d0
[    2.499306]  ? identify_cpu+0x82a/0x840
[    2.503306]  ? identify_cpu+0x82c/0x840
[    2.507306]  ? handle_bug+0xec/0x120
[    2.511306]  ? exc_invalid_op+0x14/0x70
[    2.515306]  ? asm_exc_invalid_op+0x16/0x20
[    2.519306]  ? identify_cpu+0x82a/0x840
[    2.523306]  ? identify_cpu+0x82a/0x840
[    2.527306]  arch_cpu_finalize_init+0x23/0x150
[    2.531307]  start_kernel+0x40a/0x720
[    2.535306]  x86_64_start_reservations+0x14/0x30
[    2.539306]  x86_64_start_kernel+0xa8/0xc0
[    2.543306]  common_startup_64+0x12c/0x138
[    2.547307]  </TASK>
[    2.551306] ---[ end trace 0000000000000000 ]---

Zapping it for the time being.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

