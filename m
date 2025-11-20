Return-Path: <stable+bounces-195248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0CC739E7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 539A54E9E1F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3B32FA35;
	Thu, 20 Nov 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HumTQRhZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dq1Mj92c"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F432F762;
	Thu, 20 Nov 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636629; cv=none; b=OO7+aHJS2HW7A2KVhcLErYfKxdnLDUoscBMc2eq55U28RRujCU+8nFOqkxE746uPUfV4d7NJrb15HXYauyoFrM3VJhchkAqyQ4IId4g8LShdc4AFPD/7rLhsvqNxOOL5Gx3qKt9qQxpHHi04TTPXU7NoheDC3RMf9zwVowEod5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636629; c=relaxed/simple;
	bh=YSYsjoXyWUxmPoo0UU9JDTEoLIdAnCpfmKeLRK40gFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gu9dMAN611NS9qBIHzqYZV2FJ/ymcYCCcMfFCClbe3Qs536iedZpk9U3ovnF9YCFkN5Lm8LTrR3bzBNvHD4v4eZgiGxO3BddERU49a7pjTEJFuVsaQw5AxdLCNsW3OMlp/i5yOFQ/OOGBJnRoSDZA7tlPH0UE+dul4qkl7hjjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HumTQRhZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dq1Mj92c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763636623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQJMu/RAsqHcyYZfbxlN68drpTjqqslDnStHbG6KYCM=;
	b=HumTQRhZz2s4x654qwRe6byrAJw6T9KqmikQ8CKp+dzffebDAIVw2pDh8J7cZGAHT6zR1s
	LPAAzZQ0Gy022XSNGd6w3gczMifKn+gQ8246F12hD5TM65Baz7WpOZl6DowL1+lgEjU3En
	1zbMixhcDffejLlZew9tvdN6rFJBCq7ubAAqhBfuPczwtDRzWMSsKlc+c65oU5iDINohjj
	gJbUVPhaD3mjaW4S0y2sxF94f+RPyWc0KDAroN0zu3f3SbxBuP+arR18XOwY/9Vkf0Av67
	jvSAK5Sb/87/aAVaf0G+Vy4ykBh8jmk9ylbetTCim40JICgPXlVIzItD3gAotA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763636623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQJMu/RAsqHcyYZfbxlN68drpTjqqslDnStHbG6KYCM=;
	b=Dq1Mj92cjVnUk+FFC7NtpdB1IeY72/Dx3hwCicVqHOfM8fw4ugQt0c1xLduVBG98oYC4x0
	n/kDJOh8tmkQUgDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sherry Sun <sherry.sun@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Derek Barbosa <debarbos@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 0/2] Fix reported suspend failures
In-Reply-To: <aR3imvWPagv1pwcK@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <aR3imvWPagv1pwcK@pathway.suse.cz>
Date: Thu, 20 Nov 2025 12:09:43 +0106
Message-ID: <87fra90xv4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

On 2025-11-19, Petr Mladek <pmladek@suse.com> wrote:
> JFYI, the patchset has been committed into printk/linux.git,
> branch rework/suspend-fixes.

While doing more testing I hit the new WARN_ON_ONCE() in
__wake_up_klogd():

[  125.306075][   T92] Timekeeping suspended for 9.749 seconds
[  125.306093][   T92] ------------[ cut here ]------------
[  125.306108][   T92] WARNING: CPU: 0 PID: 92 at kernel/printk/printk.c:4539 vprintk_emit+0x134/0x2e8
[  125.306151][   T92] Modules linked in: pm33xx ti_emif_sram wkup_m3_ipc wkup_m3_rproc omap_mailbox rtc_omap
[  125.306249][   T92] CPU: 0 UID: 0 PID: 92 Comm: rtcwake Not tainted 6.18.0-rc5-00005-g3d7d27fc1b14 #162 PREEMPT
[  125.306276][   T92] Hardware name: Generic AM33XX (Flattened Device Tree)
[  125.306290][   T92] Call trace:
[  125.306308][   T92]  unwind_backtrace from show_stack+0x18/0x1c
[  125.306356][   T92]  show_stack from dump_stack_lvl+0x50/0x64
[  125.306398][   T92]  dump_stack_lvl from __warn+0x7c/0x160
[  125.306433][   T92]  __warn from warn_slowpath_fmt+0x158/0x1f0
[  125.306459][   T92]  warn_slowpath_fmt from vprintk_emit+0x134/0x2e8
[  125.306487][   T92]  vprintk_emit from _printk_deferred+0x44/0x84
[  125.306520][   T92]  _printk_deferred from tk_debug_account_sleep_time+0x78/0x88
[  125.306574][   T92]  tk_debug_account_sleep_time from timekeeping_inject_sleeptime64+0x3c/0x6c
[  125.306624][   T92]  timekeeping_inject_sleeptime64 from rtc_resume.part.0+0x158/0x178
[  125.306666][   T92]  rtc_resume.part.0 from rtc_resume+0x54/0x64
[  125.306705][   T92]  rtc_resume from dpm_run_callback+0x68/0x1d4
[  125.306747][   T92]  dpm_run_callback from device_resume+0xc8/0x200
[  125.306779][   T92]  device_resume from dpm_resume+0x208/0x304
[  125.306813][   T92]  dpm_resume from dpm_resume_end+0x14/0x24
[  125.306846][   T92]  dpm_resume_end from suspend_devices_and_enter+0x1e8/0x8a4
[  125.306892][   T92]  suspend_devices_and_enter from pm_suspend+0x328/0x3c0
[  125.306924][   T92]  pm_suspend from state_store+0x70/0xd0
[  125.306955][   T92]  state_store from kernfs_fop_write_iter+0x124/0x1e4
[  125.307001][   T92]  kernfs_fop_write_iter from vfs_write+0x1f0/0x2bc
[  125.307049][   T92]  vfs_write from ksys_write+0x68/0xe8
[  125.307085][   T92]  ksys_write from ret_fast_syscall+0x0/0x58
[  125.307113][   T92] Exception stack(0xd025dfa8 to 0xd025dff0)
[  125.307137][   T92] dfa0:                   00000004 bed09f71 00000004 bed09f71 00000003 00000001
[  125.307157][   T92] dfc0: 00000004 bed09f71 00000003 00000004 00510bd4 00000000 00000000 0050e634
[  125.307172][   T92] dfe0: 00000004 bed09bd8 b6ebc20b b6e35616
[  125.307185][   T92] ---[ end trace 0000000000000000 ]---

It is due to a use of printk_deferred(). This goes through the special
case of "level == LOGLEVEL_SCHED" in vprintk_emit(). Originally I had
patched this code as well, but then later removed it thinking that it
was not needed. But it is needed. :-/ Something like:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b1c0d35cf3ca..c27fc7fc64eb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2393,7 +2393,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		ft.legacy_offload |= ft.legacy_direct;
+		ft.legacy_offload |= ft.legacy_direct && !console_irqwork_blocked;
 		ft.legacy_direct = false;
 	}
 
Is this solution ok for you? Do you prefer a follow-up patch or a v3?

John

