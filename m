Return-Path: <stable+bounces-109243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB05A1385D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FB31886770
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560EF1DE2B8;
	Thu, 16 Jan 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WL9UGmiD"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22F1DDC2C;
	Thu, 16 Jan 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025011; cv=none; b=lul3pTa8lnzKDYQnIwwODoMbM4HyzveO1qUPHNnp3gKx/9aI3w2f/6nROgOqnYymI+E47rniSW5u2iVynLsHEORK75MIRLoY8k6wZCVn3yE3h8wqBo/XTNvP8+o5iVaFkYhOGcQDv4sHKI6MgGmDYY0vCxznMRj1FFbKwmm27WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025011; c=relaxed/simple;
	bh=86bVCqfkXJI62WunGP1NY9fDz8tmN2FCiKXtuw5Z7aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd4GZODBD/Wm+pOWDUUmUg7B4LK+OzekzdtXKLk3F7ozvMVgyHtIfChI8fo8cRJoCuqyUSqE0dS7d6GMYa2PPiB+wuxx9ZPILqGmvUTrBgnyk3IouD2YUToDJPYCYKl2HBCD+Wd5BLb+EZkz3huyfD77BmXQ+qi64Db1pYIj2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WL9UGmiD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 681B540E0289;
	Thu, 16 Jan 2025 10:56:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z989hrLCcXTq; Thu, 16 Jan 2025 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737025003; bh=K5DAI6tHOhGhZjr4j++NPDRTbMto3Zf8gyS7ajM2VXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WL9UGmiDXSctaEqfBLxl+UA9Ww5MDaR1wizpNnZfm2g6uY5GZMT3XjhHJ5Ygd+DBP
	 HImr0jfUu8W7ktBA4tgrFzleofMdJb21oIP0tfqb+OLVDwfyui6m8Op1MZ0bsLsR0l
	 H58UrIAKZxMZU/yV+l2ZxCzo+gPnYz1FRmairqrdcOeaBi9OOjWEJUoCwQEr8jX9d3
	 Edw9nwi5pZBhFACvHX83chqDNs0SVoAONnfOLxGiGPfQXx7Dh7HqS8aVInDEOvzTsY
	 oPyUYRoB7DNWTjXNR3FqWVu/2tYSaeMoGnX9egmLCofAk0TmTtyPNAkDzuY8aCrAyO
	 JjZjIbfnQ13LEhlnRhGLOae2GrQ5bQe3hdDofAsmUQo6tFSCV6OSI2JLXCGFjqwjpO
	 6juFvrAf1+cEUnLXBg66ZLlnfSFbVTJwX1INtvxgkbxzkzQ+Y9jYVByYI4YmbgWduc
	 pNugmVxyV/BfYKZcDOkeDn4maH5WrDWMLsNYNYNfW+tyA+588MFiNtYVWjSYpnFht4
	 ikhPQlHmWFp8U9S/FSzv95eM7HY7F8Q2NRgDNL2MRLJwmvzI1DyAiazecU8sndAXzC
	 56qq0gzhwyX4C4WZeTxtPuKoUolbgAB/bDEhqAV9gmGYMBEXiTxh+LHk1EyOGdztlV
	 cRaDzgVi9PRfdUedFa5dv2IU=
Received: from zn.tnic (p200300EA971f934f329C23fFfeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:934f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 256B440E0269;
	Thu, 16 Jan 2025 10:56:37 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:56:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Koichiro Den <koichiro.den@canonical.com>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] hrtimers: Handle CPU state correctly on
 hotplug
Message-ID: <20250116105630.GBZ4jl3mrK8UcHOVpr@fat_crate.local>
References: <20241220134421.3809834-1-koichiro.den@canonical.com>
 <173702103889.31546.3399575954102921129.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <173702103889.31546.3399575954102921129.tip-bot2@tip-bot2>

On Thu, Jan 16, 2025 at 09:50:38AM -0000, tip-bot2 for Koichiro Den wrote:
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     e00954d8b0a2d54075131fbad4a11b2b7355eee1
> Gitweb:        https://git.kernel.org/tip/e00954d8b0a2d54075131fbad4a11b2b7355eee1
> Author:        Koichiro Den <koichiro.den@canonical.com>
> AuthorDate:    Fri, 20 Dec 2024 22:44:21 +09:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 16 Jan 2025 10:39:25 +01:00
> 
> hrtimers: Handle CPU state correctly on hotplug
> 
> Consider a scenario where a CPU transitions from CPUHP_ONLINE to halfway
> through a CPU hotunplug down to CPUHP_HRTIMERS_PREPARE, and then back to
> CPUHP_ONLINE:
> 
> Since hrtimers_prepare_cpu() does not run, cpu_base.hres_active remains set
> to 1 throughout. However, during a CPU unplug operation, the tick and the
> clockevents are shut down at CPUHP_AP_TICK_DYING. On return to the online
> state, for instance CFS incorrectly assumes that the hrtick is already
> active, and the chance of the clockevent device to transition to oneshot
> mode is also lost forever for the CPU, unless it goes back to a lower state
> than CPUHP_HRTIMERS_PREPARE once.
> 
> This round-trip reveals another issue; cpu_base.online is not set to 1
> after the transition, which appears as a WARN_ON_ONCE in enqueue_hrtimer().
> 
> Aside of that, the bulk of the per CPU state is not reset either, which
> means there are dangling pointers in the worst case.
> 
> Address this by adding a corresponding startup() callback, which resets the
> stale per CPU state and sets the online flag.
> 
> [ tglx: Make the new callback unconditionally available, remove the online
>   	modification in the prepare() callback and clear the remaining
>   	state in the starting callback instead of the prepare callback ]
> 
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20241220134421.3809834-1-koichiro.den@canonical.com
> ---
>  include/linux/hrtimer.h |  1 +
>  kernel/cpu.c            |  2 +-
>  kernel/time/hrtimer.c   | 10 +++++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

This causes the below. Lemme zap it.

[    0.324444] ------------[ cut here ]------------
[    0.325783] WARNING: CPU: 0 PID: 0 at kernel/time/hrtimer.c:1076 enqueue_hrtimer+0x77/0x80
[    0.325783] Modules linked in:
[    0.325783] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc7+ #1
[    0.325783] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
[    0.325783] RIP: 0010:enqueue_hrtimer+0x77/0x80
[    0.325783] Code: cb 7e 48 8b 05 42 8c b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 39 c1 ff ff 65 ff 0d 9a 42 cb 7e 75 9f 0f 1f 44 00 00 eb 98 <0f> 0b eb 9d 0f 1f 44 00 00 0f 1f 44 00 00 41 57 41 56 49 89 ce 41
[    0.325783] RSP: 0000:ffffffff82603c28 EFLAGS: 00010046
[    0.325783] RAX: ff11000074225e80 RBX: ff11000074225ec0 RCX: 00000000448b22fc
[    0.325783] RDX: 0000000000000008 RSI: ff11000074225ec0 RDI: ff110000742349c0
[    0.325783] RBP: ff110000742349c0 R08: 000000390fc0a600 R09: fffffffffffffffe
[    0.325783] R10: 0000000000000000 R11: 0000000000000000 R12: ff11000074225e80
[    0.325783] R13: ff11000074225ec0 R14: ff11000074225ec0 R15: 0000000000000040
[    0.325783] FS:  0000000000000000(0000) GS:ff11000074200000(0000) knlGS:0000000000000000
[    0.325783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.325783] CR2: ff11000004601000 CR3: 0000000002e22001 CR4: 0000000000771ef0
[    0.325783] PKRU: 55555554
[    0.325783] Call Trace:
[    0.325783]  <TASK>
[    0.325783]  ? __warn+0x89/0x130
[    0.325783]  ? enqueue_hrtimer+0x77/0x80
[    0.325783]  ? report_bug+0x164/0x190
[    0.325783]  ? handle_bug+0x58/0x90
[    0.325783]  ? exc_invalid_op+0x17/0x70
[    0.325783]  ? asm_exc_invalid_op+0x1a/0x20
[    0.325783]  ? enqueue_hrtimer+0x77/0x80
[    0.325783]  hrtimer_start_range_ns+0x258/0x370
[    0.325783]  start_dl_timer+0xa6/0x130
[    0.325783]  enqueue_dl_entity+0x43d/0xa60
[    0.325783]  dl_server_start+0x42/0x190
[    0.325783]  enqueue_task_fair+0x22f/0x5e0
[    0.325783]  enqueue_task+0x32/0x150
[    0.325783]  ? post_init_entity_util_avg+0x29/0x160
[    0.325783]  wake_up_new_task+0x19b/0x300
[    0.325783]  kernel_clone+0x126/0x430
[    0.325783]  user_mode_thread+0x5f/0x90
[    0.325783]  ? rest_init+0xd0/0xd0
[    0.325783]  rest_init+0x1e/0xd0
[    0.325783]  start_kernel+0x5fc/0x870
[    0.325783]  x86_64_start_reservations+0x18/0x30
[    0.325783]  x86_64_start_kernel+0x96/0xa0
[    0.325783]  common_startup_64+0x13e/0x141
[    0.325783]  </TASK>
[    0.325783] ---[ end trace 0000000000000000 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

