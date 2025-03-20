Return-Path: <stable+bounces-125691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A7A6AEDA
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A03B3921
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738D22A80A;
	Thu, 20 Mar 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1AcRJMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBC339A1;
	Thu, 20 Mar 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499993; cv=none; b=A6VSZ5pSSPZCp+bKyQb1t7v/svZ9whm8QkHPa2Okh6dE5DXvQ1pgAewJ17oSFWG95lUx+Kam8WbWULbki+z7BxTQdu34nEYjFz8WDanGm92K5SVJFfTIlYGabZi83hTaVPMiQIRsrgeJ4Vioc8gbq3KbHaoodwZy15EWbVtHZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499993; c=relaxed/simple;
	bh=y1hi90lmIW5K9dWq/8tO6hbCMeI7ecFLZqvyBIlBrq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctLXPPMDuck+zSYcKSbj/yZICsPy3YMvI8VqPuPtCopBTGYFIzqfYInbIVNxkHRUHAy6YEe3ESmz3LAzuBr7qJ7wIDGfBiDsWRxj81cHv9qSR4Y9fkiK2Lkjt4u3UfqpLVkM12x7xYZV5olUKkQZRaYodyUQL1LX0NlGr5yNHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1AcRJMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78231C4CEDD;
	Thu, 20 Mar 2025 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742499992;
	bh=y1hi90lmIW5K9dWq/8tO6hbCMeI7ecFLZqvyBIlBrq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1AcRJMCziXEP1EmpWN5VxZ+XXyU/ZNLBqRzRF6vR72jdtXxw06JvZo5x7TwVyNT4
	 A/EtHmWQhJf91QB1X1Qsm4hkp0SHihx3CiieQuy4MxCMsw/Htad6RggOA/uj8x16dz
	 vkmeElCZ/N1+HmJcoZDZiN4z8wmWc3+/NpR5EqKn254fw6cPidratZejyDlTdMwVqG
	 uxogq3buaujfJVihLoFXSYT8AqFFJj6WlYcRwcE/+/o9NUmRtZxSrZ5Wb/Wluko4lr
	 oZaqByKdD2y7dysT7WgwJ4Ey6N3Kccz4pCPjOHhlFFGJEt2OnVjtXRuQIupxrrdlkC
	 7PMpaK8QKaJ/A==
Date: Thu, 20 Mar 2025 20:46:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Akihiro Suda <suda.gitsendemail@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	stable@vger.kernel.org, suda.kyoto@gmail.com,
	regressions@lists.linux.dev, aruna.ramakrishna@oracle.com,
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
Message-ID: <Z9xwk9v5gSfEHZCZ@gmail.com>
References: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
 <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp>
 <Z9s5lam2QzWCOOKi@gmail.com>
 <20250320151120.GCZ9wwGJZQMLKKm5fT@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320151120.GCZ9wwGJZQMLKKm5fT@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Mar 19, 2025 at 10:39:33PM +0100, Ingo Molnar wrote:
> > Note that silent quirks are counterproductive, as they don't give VM 
> > vendors any incentives to fix their VM for such bugs.
> > 
> > So I changed your quirk to be:
> 
> This fires on my Zen3 now :-P
> 
> [    2.411315] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    2.415307] ------------[ cut here ]------------
> [    2.419306] [Firmware Bug]: Invalid XFEATURE_PKRU configuration.
> [    2.423307] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/common.c:530 identify_cpu+0x82a/0x840
> [    2.427306] Modules linked in:
> [    2.431307] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.14.0-rc7+ #1 PREEMPT(full) 
> [    2.435306] Hardware name: Micro-Star International Co., Ltd. MS-7A38/B450M PRO-VDH MAX (MS-7A38), BIOS B.G0 07/26/2022
> [    2.439306] RIP: 0010:identify_cpu+0x82a/0x840
> [    2.443306] Code: e8 bb f2 ff ff e9 4f ff ff ff 80 3d 07 4e 7b 01 00 0f 85 af fb ff ff 48 c7 c7 a8 fd f0 81 c6 05 f3 4d 7b 01 01 e8 e6 49 04 00 <0f> 0b e9 95 fb ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
> [    2.447306] RSP: 0000:ffffffff82203ec8 EFLAGS: 00010296
> [    2.451306] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
> [    2.455306] RDX: 0000000080000003 RSI: 00000000ffffffea RDI: 0000000000000001
> [    2.459306] RBP: ffffffff82a09f40 R08: ffff88883e1fafe8 R09: 000000000027fffb
> [    2.463306] R10: 00000000000000ee R11: ffff88883d5fb000 R12: 0000000000000000
> [    2.467306] R13: ffff88883f373180 R14: ffffffff8220ba78 R15: 000000000008b000
> [    2.471306] FS:  0000000000000000(0000) GS:ffff88889742b000(0000) knlGS:0000000000000000
> [    2.475306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.479306] CR2: ffff88883f1ff000 CR3: 000000000221a000 CR4: 00000000003108b0
> [    2.483306] Call Trace:
> [    2.487307]  <TASK>
> [    2.489459]  ? __warn+0x85/0x150
> [    2.491306]  ? identify_cpu+0x82a/0x840
> [    2.495306]  ? report_bug+0x1c3/0x1d0
> [    2.499306]  ? identify_cpu+0x82a/0x840
> [    2.503306]  ? identify_cpu+0x82c/0x840
> [    2.507306]  ? handle_bug+0xec/0x120
> [    2.511306]  ? exc_invalid_op+0x14/0x70
> [    2.515306]  ? asm_exc_invalid_op+0x16/0x20
> [    2.519306]  ? identify_cpu+0x82a/0x840
> [    2.523306]  ? identify_cpu+0x82a/0x840
> [    2.527306]  arch_cpu_finalize_init+0x23/0x150
> [    2.531307]  start_kernel+0x40a/0x720
> [    2.535306]  x86_64_start_reservations+0x14/0x30
> [    2.539306]  x86_64_start_kernel+0xa8/0xc0
> [    2.543306]  common_startup_64+0x12c/0x138
> [    2.547307]  </TASK>
> [    2.551306] ---[ end trace 0000000000000000 ]---
> 
> Zapping it for the time being.

Thanks!

	Ingo

