Return-Path: <stable+bounces-106842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C865A0265B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2333A4369
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E681F5E6;
	Mon,  6 Jan 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bleNyzdt"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245E23A6;
	Mon,  6 Jan 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169527; cv=none; b=SNqpIkUK9YiwBV88z/xxvi/0RrBoi0lBhEA1oqAlz1b+9g2XGVDYLmx98EJPrqRPLfehlrB1RuZom4rye/FVo4/K/U+S8SQo1xleNtrHt5WS5y0EidhuqBYIBfg32yYjrHLAOfEjsqOTEShIfv4mmJTHHig8YPUzwr5KD2iR1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169527; c=relaxed/simple;
	bh=W4BDmqmJ9PozrQK7DKfY37cULx8hNl3vN55ZfwaSmfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UAux77iGS+BuC2gCrCk8tOX9SlX73UBfZ7yIfi/WLq5oaJHGcYhB3LuL+YoH5zdNnlypE9iJTbStCUW7LPrtMs39iON1sDu4ZLjxNJRDICkk8wrACQVR6ZUkm6S/slJu6NC6y0UJdlxDGyF/YT7nPXR1yOOwu4zQQpsVK1v6cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bleNyzdt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0352340E0264;
	Mon,  6 Jan 2025 13:18:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xIXHXCgpuURJ; Mon,  6 Jan 2025 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736169511; bh=GWYthY8YuSjedyiFPCoHIKYRq8nXpqOqPggDkul6uek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bleNyzdtrhuLB28SoH/FZ/cOoMZRdVSrW9h7H/88Umy1+kz+5fKrdgZ3indrt8gRc
	 q5ooVoLq/Xe484t89vUoHqAbR1YD0jWrEZFJN8oz8O/cB5WpOTf+0YdRNP6pmc3TSa
	 iyAVzostj7bXgPspIG1gS7mL6iO68/5InE7vr9k8fpZ2m9KK03ZgqawWlQ0ajJsev/
	 H7BjbfaQ//jHimcg40sbN8Qu7w5CQl675DnjyWfCgat1CaU5FSJYbHHkS3jKQJT3bJ
	 /FFUbKjbwGh+HrFT6I2u/9EEgAf5WKa2RHkicuQlpj1C1dotIUQAzQ/jpxggcxYMfm
	 9BWtBMraW9Uuhc2gE5Tz1wt/mUEmXayUMosYb3q6Am2jTN28h1Cvv3xX3HrvMlrIEA
	 HkD6JdXwaKQu6ylFqpa8ZkUIFmeiP2qdDI2H8+EK794/hNENKzHQkYRCTb7TYee1Fx
	 YbjugFSD2bNN6GUi+QDJzxg96ITjoI5VQXHu9JVJMGdnp6suD1UrqZerP73cBJMEMQ
	 e10DFHlNqXCcBXRStJ7stp5VXgMtEuglNE9WtNSMpnbZtfA2xvznhoQf11IGmJGzrQ
	 tPiW6d4TAE0zDLEkemQJy/7eNeCm53yzl/Euo7aL2Uong5ZunSwWPHzUXs7gmNVQsN
	 nDTgKb6NPh5pKBKrWrEWAkwo=
Received: from zn.tnic (p200300ea971F93E8329c23ffFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93e8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BF3A40E0163;
	Mon,  6 Jan 2025 13:18:25 +0000 (UTC)
Date: Mon, 6 Jan 2025 14:18:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Koichiro Den <koichiro.den@canonical.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>

On Sun, Jan 05, 2025 at 02:20:54PM -0800, Linus Torvalds wrote:
> So we had a slight pickup in commits this last week, but as expected
> and hoped for, things were still pretty quiet. About twice as many
> commits as the holiday week, but that's still not all that many.
> 
> I expect things will start becoming more normal now that people are
> back from the holidays and are starting to recover and wake up from
> their food comas.
> 
> In the meantime, below is the shortlog for the last week. Nothing
> particularly stands out, the changes are dominated by various driver
> updates (gpu, rdma and networking), with a random smattering of fixes
> elsewhere.

Something not well baked managed to sneak in and it is tagged for stable:

adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()")

Reverting it fixes the warn splat below.

[    0.310373] smpboot: x86: Booting SMP configuration:
[    0.311074] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.313798] ------------[ cut here ]------------
[    0.317530] workqueue: work disable count underflowed
[    0.317530] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:4317 enable_work+0xa4/0xb0
[    0.317530] Modules linked in:
[    0.317530] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #11
[    0.317530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
[    0.317530] RIP: 0010:enable_work+0xa4/0xb0
[    0.317530] Code: c0 48 83 c4 18 5b 5d e9 ca 25 9f 00 80 3d 0a c7 48 08 00 75 b3 c6 05 01 c7 48 08 01 90 48 c7 c7 c8 eb 1d 82 e8 5d 77 fd ff 90 <0f> 0b 90 90 eb 98 90 0f 0b 90 eb b1 90 90 90 90 90 90 90 90 90 90
[    0.317530] RSP: 0018:ffffc90000137e18 EFLAGS: 00010082
[    0.317530] RAX: 0000000000000029 RBX: ffff88807d66dda0 RCX: 00000000ffefffff
[    0.317530] RDX: 0000000000000001 RSI: ffffc90000137ce0 RDI: 0000000000000001
[    0.317530] RBP: 0000000000000000 R08: 00000000ffefffff R09: 0000000000000058
[    0.317530] R10: 0000000000000000 R11: ffffffff8244df00 R12: 0000000000000000
[    0.317530] R13: ffff88807d6604e0 R14: ffffffff812439f0 R15: ffff88807d660508
[    0.317530] FS:  0000000000000000(0000) GS:ffff88807d640000(0000) knlGS:0000000000000000
[    0.317530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.317530] CR2: 0000000000000000 CR3: 0000000002c1a000 CR4: 00000000003506f0
[    0.317530] Call Trace:
[    0.317530]  <TASK>
[    0.317530]  ? __warn+0xa0/0x160
[    0.317530]  ? enable_work+0xa4/0xb0
[    0.317530]  ? report_bug+0x18c/0x1c0
[    0.317530]  ? handle_bug+0x54/0x90
[    0.317530]  ? exc_invalid_op+0x1b/0x80
[    0.317530]  ? asm_exc_invalid_op+0x1a/0x20
[    0.317530]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    0.317530]  ? enable_work+0xa4/0xb0
[    0.317530]  ? enable_work+0xa3/0xb0
[    0.317530]  vmstat_cpu_online+0x61/0x80
[    0.317530]  cpuhp_invoke_callback+0x10f/0x480
[    0.317530]  ? srso_return_thunk+0x5/0x5f
[    0.317530]  cpuhp_thread_fun+0xd4/0x160
[    0.317530]  smpboot_thread_fn+0xdd/0x1f0
[    0.317530]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    0.317530]  kthread+0xca/0xf0
[    0.317530]  ? __pfx_kthread+0x10/0x10
[    0.317530]  ret_from_fork+0x50/0x60
[    0.317530]  ? __pfx_kthread+0x10/0x10
[    0.317530]  ret_from_fork_asm+0x1a/0x30
[    0.317530]  </TASK>
[    0.317530] ---[ end trace 0000000000000000 ]---
[    0.377680] smp: Brought up 1 node, 16 CPUs
[    0.378345] smpboot: Total of 16 processors activated (118393.24 BogoMIPS)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

