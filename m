Return-Path: <stable+bounces-50264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A275905498
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4521C20AF3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9208181BA3;
	Wed, 12 Jun 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rg8Yf5Lm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E917DE22
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200625; cv=none; b=U3W1cvIAGb1D7ZrBQ5xBEs5PJlX0SD4kqwH47DoqppI4si/ZwRLgdmamD1eV6Y9YkFxagkw3mSutWCI/HGMVQT81XPzZV/7DNQq/siWH0EaPJ34JD6TaF7dCEXDQzU/5tebVCyQpvv7sGpQvIkvtqeQfRWGv5KGk5Cfd6KTKaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200625; c=relaxed/simple;
	bh=HSkQmRkIxoCOZAAn3rxa8koWyEn9mreYUM01Ie999iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxHR9l0x4W294i8qaWshMRidHQFDnd1FM6J/unUVnwAJkm0oua+zoePthSKErJUAv+qaOqxmbJ0dSro3/MWqbOMFlZv3+YECvgO6b8MPvD/JmK2XypnFZA9zYctwHOuUyGY6QUOxG5YJ9zCaxF7AxyviYzDC8as4DrSaiLpfRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rg8Yf5Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DE1C116B1;
	Wed, 12 Jun 2024 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718200624;
	bh=HSkQmRkIxoCOZAAn3rxa8koWyEn9mreYUM01Ie999iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rg8Yf5LmAqdHX5IL3DP7KmcBeYF8OdbyV4syUUIU0tcVR6e5nvn2oBMRKwQBSWSPG
	 b5zNqG8Me7kwiIRbW5FGqtY/gi+5Vp1EEWrfMam7kTEaLjsanVAlWqJbmbuQm1NMR2
	 /drXguWtQhEgBCkMtVZi6xyGTmOM0bm5r+x7g20U=
Date: Wed, 12 Jun 2024 15:57:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, x86@kernel.org,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH 5.10.y] x86/mm: Remove broken vsyscall emulation code
 from the page fault code
Message-ID: <2024061249-sadly-tripping-c315@gregkh>
References: <20240602152525.78730-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602152525.78730-1-gpiccoli@igalia.com>

On Sun, Jun 02, 2024 at 12:24:34PM -0300, Guilherme G. Piccoli wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit 02b670c1f88e78f42a6c5aee155c7b26960ca054 upstream.
> 
> The syzbot-reported stack trace from hell in this discussion thread
> actually has three nested page faults:
> 
>   https://lore.kernel.org/r/000000000000d5f4fc0616e816d4@google.com
> 
> ... and I think that's actually the important thing here:
> 
>  - the first page fault is from user space, and triggers the vsyscall
>    emulation.
> 
>  - the second page fault is from __do_sys_gettimeofday(), and that should
>    just have caused the exception that then sets the return value to
>    -EFAULT
> 
>  - the third nested page fault is due to _raw_spin_unlock_irqrestore() ->
>    preempt_schedule() -> trace_sched_switch(), which then causes a BPF
>    trace program to run, which does that bpf_probe_read_compat(), which
>    causes that page fault under pagefault_disable().
> 
> It's quite the nasty backtrace, and there's a lot going on.
> 
> The problem is literally the vsyscall emulation, which sets
> 
>         current->thread.sig_on_uaccess_err = 1;
> 
> and that causes the fixup_exception() code to send the signal *despite* the
> exception being caught.
> 
> And I think that is in fact completely bogus.  It's completely bogus
> exactly because it sends that signal even when it *shouldn't* be sent -
> like for the BPF user mode trace gathering.
> 
> In other words, I think the whole "sig_on_uaccess_err" thing is entirely
> broken, because it makes any nested page-faults do all the wrong things.
> 
> Now, arguably, I don't think anybody should enable vsyscall emulation any
> more, but this test case clearly does.
> 
> I think we should just make the "send SIGSEGV" be something that the
> vsyscall emulation does on its own, not this broken per-thread state for
> something that isn't actually per thread.
> 
> The x86 page fault code actually tried to deal with the "incorrect nesting"
> by having that:
> 
>                 if (in_interrupt())
>                         return;
> 
> which ignores the sig_on_uaccess_err case when it happens in interrupts,
> but as shown by this example, these nested page faults do not need to be
> about interrupts at all.
> 
> IOW, I think the only right thing is to remove that horrendously broken
> code.
> 
> The attached patch looks like the ObviouslyCorrect(tm) thing to do.
> 
> NOTE! This broken code goes back to this commit in 2011:
> 
>   4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation faults")
> 
> ... and back then the reason was to get all the siginfo details right.
> Honestly, I do not for a moment believe that it's worth getting the siginfo
> details right here, but part of the commit says:
> 
>     This fixes issues with UML when vsyscall=emulate.
> 
> ... and so my patch to remove this garbage will probably break UML in this
> situation.
> 
> I do not believe that anybody should be running with vsyscall=emulate in
> 2024 in the first place, much less if you are doing things like UML. But
> let's see if somebody screams.
> 
> Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [gpiccoli: Backport the patch due to differences in the trees. The main change
> between 5.10.y and 5.15.y is due to renaming the fixup function, by
> commit 6456a2a69ee1 ("x86/fault: Rename no_context() to kernelmode_fixup_or_oops()").
> 
> Following 2 commits cause divergence in the diffs too (in the removed lines):
> cd072dab453a ("x86/fault: Add a helper function to sanitize error code")
> d4ffd5df9d18 ("x86/fault: Fix wrong signal when vsyscall fails with pkey")
> 
> Finally, there is context adjustment in the processor.h file.]
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hi folks, this was backported by AUTOSEL up to 5.15.y; I'm manually submitting
> the backport to 5.4.y and 5.10.y. I've detailed a bit the changes necessary
> due to other nonrelated missing patches, but these are really simple and
> non-intrusive. Nevertheless, I've explicitely CCed x86 ML to be sure the
> maintainers are aware of the backport, and if anybody thinks we shouldn't
> do it for these (very) old releases, please respond here.

Both now queued up, thanks.

greg k-h

