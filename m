Return-Path: <stable+bounces-161573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1663B003C0
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE7D1890ADB
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828D259CAC;
	Thu, 10 Jul 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dUaMuXP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A282594B4
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154592; cv=none; b=iIGlyaKSmeh38x0bKaz78DdGbllMTkNwspbmu59Y7Hh5CL0A6tuy4Fw0E5DI0gLKAWKqOgksSmwH7R52q32HLG8vRS5TqofBHa7OgHLvMWSXm7cWPgPChIx9WfiNVyUY8XIUbh/saAB/+jJ854Zt138W7dieeFWrgkCjWMSlMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154592; c=relaxed/simple;
	bh=NhmUTiE3h3rCFrVHLcYcafulaAWoaqa14SP/YprUk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAtVzH91rDWRBHzu5FeLPf7trU8P9U+aRuc/hKIKqx/p45c4uMuDxLCOi6ur/104qYnhsxaRbsfUIoUpPFLAAdahBo9LUuWRVDTlo5KOeiDSGeNCQimOP8eXwEbgjDvsC6b0p8IIoBOpA+kz+KzS5vxtmtuYO+qq4dLJvKpys9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dUaMuXP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC954C4CEED;
	Thu, 10 Jul 2025 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752154592;
	bh=NhmUTiE3h3rCFrVHLcYcafulaAWoaqa14SP/YprUk/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUaMuXP2O5yJtNiNA5U3Nd67zB+aD5jdoHm0ib+vx73/dsUDPOZj5QT9VoNtyDTI8
	 xN3zShIMNKZThg8wjHBxUPN+PvlLetmEdsE92mHIjuUCt2urXF3g2wdVPdmNTKvXGP
	 kXwMVKa2jSGL8AuHr2QtVgEq/WlHXYd+PjeYS6Gg=
Date: Thu, 10 Jul 2025 15:36:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Seiji Nishikawa <snishika@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in
 exit_round_robin()
Message-ID: <2025071024-move-barrette-1e52@gregkh>
References: <1750809374-29306-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750809374-29306-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>

On Wed, Jun 25, 2025 at 08:56:14AM +0900, Nobuhiro Iwamatsu wrote:
> From: Seiji Nishikawa <snishika@redhat.com>
> 
> commit 0a2ed70a549e61c5181bad5db418d223b68ae932 upstream.
> 
> The kernel occasionally crashes in cpumask_clear_cpu(), which is called
> within exit_round_robin(), because when executing clear_bit(nr, addr) with
> nr set to 0xffffffff, the address calculation may cause misalignment within
> the memory, leading to access to an invalid memory address.
> 
> ----------
> BUG: unable to handle kernel paging request at ffffffffe0740618
>         ...
> CPU: 3 PID: 2919323 Comm: acpi_pad/14 Kdump: loaded Tainted: G           OE  X --------- -  - 4.18.0-425.19.2.el8_7.x86_64 #1
>         ...
> RIP: 0010:power_saving_thread+0x313/0x411 [acpi_pad]
> Code: 89 cd 48 89 d3 eb d1 48 c7 c7 55 70 72 c0 e8 64 86 b0 e4 c6 05 0d a1 02 00 01 e9 bc fd ff ff 45 89 e4 42 8b 04 a5 20 82 72 c0 <f0> 48 0f b3 05 f4 9c 01 00 42 c7 04 a5 20 82 72 c0 ff ff ff ff 31
> RSP: 0018:ff72a5d51fa77ec8 EFLAGS: 00010202
> RAX: 00000000ffffffff RBX: ff462981e5d8cb80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
> RBP: ff46297556959d80 R08: 0000000000000382 R09: ff46297c8d0f38d8
> R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000000e
> R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000000000e
> FS:  0000000000000000(0000) GS:ff46297a800c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffe0740618 CR3: 0000007e20410004 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  ? acpi_pad_add+0x120/0x120 [acpi_pad]
>  kthread+0x10b/0x130
>  ? set_kthread_struct+0x50/0x50
>  ret_from_fork+0x1f/0x40
>         ...
> CR2: ffffffffe0740618
> 
> crash> dis -lr ffffffffc0726923
>         ...
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 114
> 0xffffffffc0726918 <power_saving_thread+776>:	mov    %r12d,%r12d
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 325
> 0xffffffffc072691b <power_saving_thread+779>:	mov    -0x3f8d7de0(,%r12,4),%eax
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./arch/x86/include/asm/bitops.h: 80
> 0xffffffffc0726923 <power_saving_thread+787>:	lock btr %rax,0x19cf4(%rip)        # 0xffffffffc0740620 <pad_busy_cpus_bits>
> 
> crash> px tsk_in_cpu[14]
> $66 = 0xffffffff
> 
> crash> px 0xffffffffc072692c+0x19cf4
> $99 = 0xffffffffc0740620
> 
> crash> sym 0xffffffffc0740620
> ffffffffc0740620 (b) pad_busy_cpus_bits [acpi_pad]
> 
> crash> px pad_busy_cpus_bits[0]
> $42 = 0xfffc0
> ----------
> 
> To fix this, ensure that tsk_in_cpu[tsk_index] != -1 before calling
> cpumask_clear_cpu() in exit_round_robin(), just as it is done in
> round_robin_cpu().
> 
> Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
> Link: https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
> [ rjw: Subject edit, avoid updates to the same value ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49935

Why did you add a nist.gov link here?

NIST is know to "enhance" cve.org reports in ways that are flat out
wrong.  Never trust them, only rely on the original cve.org report
please, as that is under our control.

Also NIST totally ignores numerous parts of the cve.org report that we
provide, making this type of link contain less information overall than
the original report.

And finally, no need to add links like this to backports.  If we were to
do that everywhere, it would be a total mess given our rate of 13 CVEs a
day we are currently running at.

thanks,

greg k-h

