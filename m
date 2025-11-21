Return-Path: <stable+bounces-195487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A104FC784FE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FF9B4E9580
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4553343216;
	Fri, 21 Nov 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nfnz7tzj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A9339B47
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718956; cv=none; b=fK0ZW7NMnfltSzD1iI6Ur27XevhgziQMlGhW7iM+VzJXbEltVLm5Ls8Py+61SvfG4aFCqjLiAkmOEWRW/mktAtC/gB7ALqIPM3U23zaiSJLOSaaGFvgdGa+LZv5iJsswESLZttSF1b0lsEk5OPhzZWhWaDcDYUNO1Z2MsIowJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718956; c=relaxed/simple;
	bh=/Vk5Jy6zeZc1kCPoFMTUFW9mx7bysYqmLXgbecHZg2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXfFBw4TqMgQ9NjirpPkDX7MFM7Va+bpsQRw7uiOvx3OxjeofSeBxRRODERdgyHXdE4EWrE1ErLEsbJGXlAJvvkVYgqY2Ti2E7Fm8Opgn1uUWTv14yJ0x/nIT/svwe+iYf+tkvQajHfB7MgcP68XXVjIKD2gLTS8RDjC3Q+PrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nfnz7tzj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso2832984a12.1
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763718952; x=1764323752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQJgMG2cvt08IwUbZSYBQLychsn2HaV7mtISHsSpv4s=;
        b=Nfnz7tzjXln7mhAav1914chfpBJDUjnWHpHJIgWNRmphCGNFeehET079gNQvt9ND+I
         ZMYzdgUsxvho+faND+gg6rZXgsnWWLA0vBsA00wV8NM2m2P/4oyGYg8BFxMRFxntTjS4
         f61dnaCaeGNLU30RcMeJl1QZ9rnflmfDwnOkdmzSK08ytPFk/mdsNirA80yd2Ldfs2Cr
         yfEMI0HGyX5sxtlC8vY1OqUrqiTzEmwIF27fvLfhIeJDlmrY94HBHDvPAt1e1SGPSfre
         jAUzAdZtWXxqCMTtPjP+iIIqID9RjNXShHi5OOvfcvi/yfqEZ4xVy7a6VN1GIjxaF1yq
         35bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763718952; x=1764323752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQJgMG2cvt08IwUbZSYBQLychsn2HaV7mtISHsSpv4s=;
        b=tFkLc45qJvXG3/FUMIXdVlVqYepS/K2OanBc5gki+EvAGaFeJ7SrP9ixcPxBd7Pk1f
         9qGmwHTkKn5d06I22UPg/F/sP3VtRU21D70VvWZV5Ao2q9x38XZ0AMWkKis7G8Ln9J3i
         Q5YcOhZoTaoTsuHgdqqbq+010YMzp8UolaS/rHsSGC6+Bd+aXA7VpqUQ5jEk8LDuDBSI
         ryGbJTDzmHJrPWV+IGxp+XJOsI2c2hkl/4CB8mvLEf968TMKoSHA3rxy8Jf/fhVIq8tn
         JAph+veVBsWyWtu45I5lBGsMTVF5xov+hsQvPKU35c8AGyUdoZ8/xBXsMctiodd/OVWx
         ftzA==
X-Forwarded-Encrypted: i=1; AJvYcCXqv6KPVhXnZpFM86Pf6Kicsq8Q9RSTSRYnptwEQn0wuM/0sdDtgMdXd0PZGWZogvCPWe5uFNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQKt4Up/BTgTjaj6LAlyFjIJ1k7y6p7s1JgG8HVV2ACFj1DhM
	AYoRGS1SkUloIMC84oDuMN7TiLtaKQyiNpDATgm1rnkMxVnsWVsrOb2oFgYu35rUJns=
X-Gm-Gg: ASbGncsRGNafb9eYDC9c4BYBKEJifeWVsYBa8p8P4lIZ91BU289PVumnuIuELPnRX2S
	ckH/6cdoqc8nu6/1fxETtj/Oxbw2PScCIWch2Hr9pcMO0YVbX6ZWym96XtJYzKrrwLDFG1CXdhG
	MYj4qsnh3lXheCbRikVke++A2B/3IRRPH3wUafSEcyXyMRNZpIH8O9fnZYKYm2+KXBz/hx+QF+Z
	1VBHpo8BldAnKK2TPrWYJ2oIuAakk5Df3lcFM9Hw4nefY16iapqu+C04SkmzW6N4UUbZtOXqObI
	0A+CP5sbtTqeGnk9rVdn59X58KriQbSNydCXUiCSOtwXbn3BNruizNve2u9OrqpX/0fhg621YY0
	s3QmqPFgahfiM+rbo1IwTpdEncoXvHypLy15a+DcNWbfIRR0DjD2jcLiWx0CisBu3OGY211y3kP
	j9TUCXm/xhTuiQjQ==
X-Google-Smtp-Source: AGHT+IHXXujdBqAxtzoDuFb3/nS9YMWZCA/zc4at6UIJJi0+b3zkKypi+gvPdtqe+zTM3uaqm02tyQ==
X-Received: by 2002:a05:6402:2692:b0:640:abd5:8642 with SMTP id 4fb4d7f45d1cf-645546659d7mr1520015a12.21.1763718952288;
        Fri, 21 Nov 2025 01:55:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363ac8e3sm4227167a12.2.2025.11.21.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:55:51 -0800 (PST)
Date: Fri, 21 Nov 2025 10:55:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v2 0/2] Fix reported suspend failures
Message-ID: <aSA3JqKNTUSkPEY1@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <aR3imvWPagv1pwcK@pathway.suse.cz>
 <87fra90xv4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fra90xv4.fsf@jogness.linutronix.de>

On Thu 2025-11-20 12:09:43, John Ogness wrote:
> Hi Petr,
> 
> On 2025-11-19, Petr Mladek <pmladek@suse.com> wrote:
> > JFYI, the patchset has been committed into printk/linux.git,
> > branch rework/suspend-fixes.
> 
> While doing more testing I hit the new WARN_ON_ONCE() in
> __wake_up_klogd():
> 
> [  125.306075][   T92] Timekeeping suspended for 9.749 seconds
> [  125.306093][   T92] ------------[ cut here ]------------
> [  125.306108][   T92] WARNING: CPU: 0 PID: 92 at kernel/printk/printk.c:4539 vprintk_emit+0x134/0x2e8
> [  125.306151][   T92] Modules linked in: pm33xx ti_emif_sram wkup_m3_ipc wkup_m3_rproc omap_mailbox rtc_omap
> [  125.306249][   T92] CPU: 0 UID: 0 PID: 92 Comm: rtcwake Not tainted 6.18.0-rc5-00005-g3d7d27fc1b14 #162 PREEMPT
> [  125.306276][   T92] Hardware name: Generic AM33XX (Flattened Device Tree)
> [  125.306290][   T92] Call trace:
> [  125.306308][   T92]  unwind_backtrace from show_stack+0x18/0x1c
> [  125.306356][   T92]  show_stack from dump_stack_lvl+0x50/0x64
> [  125.306398][   T92]  dump_stack_lvl from __warn+0x7c/0x160
> [  125.306433][   T92]  __warn from warn_slowpath_fmt+0x158/0x1f0
> [  125.306459][   T92]  warn_slowpath_fmt from vprintk_emit+0x134/0x2e8
> [  125.306487][   T92]  vprintk_emit from _printk_deferred+0x44/0x84
> [  125.306520][   T92]  _printk_deferred from tk_debug_account_sleep_time+0x78/0x88
> [  125.306574][   T92]  tk_debug_account_sleep_time from timekeeping_inject_sleeptime64+0x3c/0x6c
> [  125.306624][   T92]  timekeeping_inject_sleeptime64 from rtc_resume.part.0+0x158/0x178
> [  125.306666][   T92]  rtc_resume.part.0 from rtc_resume+0x54/0x64
> [  125.306705][   T92]  rtc_resume from dpm_run_callback+0x68/0x1d4
> [  125.306747][   T92]  dpm_run_callback from device_resume+0xc8/0x200
> [  125.306779][   T92]  device_resume from dpm_resume+0x208/0x304
> [  125.306813][   T92]  dpm_resume from dpm_resume_end+0x14/0x24
> [  125.306846][   T92]  dpm_resume_end from suspend_devices_and_enter+0x1e8/0x8a4
> [  125.306892][   T92]  suspend_devices_and_enter from pm_suspend+0x328/0x3c0
> [  125.306924][   T92]  pm_suspend from state_store+0x70/0xd0
> [  125.306955][   T92]  state_store from kernfs_fop_write_iter+0x124/0x1e4
> [  125.307001][   T92]  kernfs_fop_write_iter from vfs_write+0x1f0/0x2bc
> [  125.307049][   T92]  vfs_write from ksys_write+0x68/0xe8
> [  125.307085][   T92]  ksys_write from ret_fast_syscall+0x0/0x58
> [  125.307113][   T92] Exception stack(0xd025dfa8 to 0xd025dff0)
> [  125.307137][   T92] dfa0:                   00000004 bed09f71 00000004 bed09f71 00000003 00000001
> [  125.307157][   T92] dfc0: 00000004 bed09f71 00000003 00000004 00510bd4 00000000 00000000 0050e634
> [  125.307172][   T92] dfe0: 00000004 bed09bd8 b6ebc20b b6e35616
> [  125.307185][   T92] ---[ end trace 0000000000000000 ]---
> 
> It is due to a use of printk_deferred(). This goes through the special
> case of "level == LOGLEVEL_SCHED" in vprintk_emit(). Originally I had
> patched this code as well, but then later removed it thinking that it
> was not needed. But it is needed. :-/ Something like:

Great catch!

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b1c0d35cf3ca..c27fc7fc64eb 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2393,7 +2393,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	/* If called from the scheduler, we can not call up(). */
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
> -		ft.legacy_offload |= ft.legacy_direct;
> +		ft.legacy_offload |= ft.legacy_direct && !console_irqwork_blocked;
>  		ft.legacy_direct = false;
>  	}
>  
> Is this solution ok for you? Do you prefer a follow-up patch or a v3?

Nothing better comes to my mind ;-) A follow-up patch would be
lovely. Please, go ahead.

Best Regards,
Petr


