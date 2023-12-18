Return-Path: <stable+bounces-6988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BE5816BD6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 12:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2181C22F45
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFE182D5;
	Mon, 18 Dec 2023 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/6tJhhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3521B273
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 11:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E73C433C7;
	Mon, 18 Dec 2023 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702897552;
	bh=tLlIfC2a3neFEzwxH223OeKz1xxLNHJaqaYBYGCmJp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/6tJhhM5qoLbgiTOZeugGEzpRmZRLTiEUaBRHZORpY+P5lQiqUKwfxYhhaRfi91H
	 IwD5XxHQ9+0BKso6+mVPKSIz21jp74YxuBPmTRp+P4JTOGB8U+kxev3i3KTyN9Kk7T
	 5pOV3deZeFDf5dVm3WhbBKiDMnZDonH1CG1FaQd0=
Date: Mon, 18 Dec 2023 12:05:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5.15.y 1/2] powerpc/ftrace: Create a dummy stackframe to
 fix stack unwind
Message-ID: <2023121842-vertebrae-sedative-4e9e@gregkh>
References: <2023080733-wife-elope-de1b@gregkh>
 <20231215111433.2362641-1-naveen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111433.2362641-1-naveen@kernel.org>

On Fri, Dec 15, 2023 at 04:44:32PM +0530, Naveen N Rao wrote:
> commit 41a506ef71eb38d94fe133f565c87c3e06ccc072 upstream.
> 
> With ppc64 -mprofile-kernel and ppc32 -pg, profiling instructions to
> call into ftrace are emitted right at function entry. The instruction
> sequence used is minimal to reduce overhead. Crucially, a stackframe is
> not created for the function being traced. This breaks stack unwinding
> since the function being traced does not have a stackframe for itself.
> As such, it never shows up in the backtrace:
> 
> /sys/kernel/debug/tracing # echo 1 > /proc/sys/kernel/stack_tracer_enabled
> /sys/kernel/debug/tracing # cat stack_trace
>         Depth    Size   Location    (17 entries)
>         -----    ----   --------
>   0)     4144      32   ftrace_call+0x4/0x44
>   1)     4112     432   get_page_from_freelist+0x26c/0x1ad0
>   2)     3680     496   __alloc_pages+0x290/0x1280
>   3)     3184     336   __folio_alloc+0x34/0x90
>   4)     2848     176   vma_alloc_folio+0xd8/0x540
>   5)     2672     272   __handle_mm_fault+0x700/0x1cc0
>   6)     2400     208   handle_mm_fault+0xf0/0x3f0
>   7)     2192      80   ___do_page_fault+0x3e4/0xbe0
>   8)     2112     160   do_page_fault+0x30/0xc0
>   9)     1952     256   data_access_common_virt+0x210/0x220
>  10)     1696     400   0xc00000000f16b100
>  11)     1296     384   load_elf_binary+0x804/0x1b80
>  12)      912     208   bprm_execve+0x2d8/0x7e0
>  13)      704      64   do_execveat_common+0x1d0/0x2f0
>  14)      640     160   sys_execve+0x54/0x70
>  15)      480      64   system_call_exception+0x138/0x350
>  16)      416     416   system_call_common+0x160/0x2c4
> 
> Fix this by having ftrace create a dummy stackframe for the function
> being traced. With this, backtraces now capture the function being
> traced:
> 
> /sys/kernel/debug/tracing # cat stack_trace
>         Depth    Size   Location    (17 entries)
>         -----    ----   --------
>   0)     3888      32   _raw_spin_trylock+0x8/0x70
>   1)     3856     576   get_page_from_freelist+0x26c/0x1ad0
>   2)     3280      64   __alloc_pages+0x290/0x1280
>   3)     3216     336   __folio_alloc+0x34/0x90
>   4)     2880     176   vma_alloc_folio+0xd8/0x540
>   5)     2704     416   __handle_mm_fault+0x700/0x1cc0
>   6)     2288      96   handle_mm_fault+0xf0/0x3f0
>   7)     2192      48   ___do_page_fault+0x3e4/0xbe0
>   8)     2144     192   do_page_fault+0x30/0xc0
>   9)     1952     608   data_access_common_virt+0x210/0x220
>  10)     1344      16   0xc0000000334bbb50
>  11)     1328     416   load_elf_binary+0x804/0x1b80
>  12)      912      64   bprm_execve+0x2d8/0x7e0
>  13)      848     176   do_execveat_common+0x1d0/0x2f0
>  14)      672     192   sys_execve+0x54/0x70
>  15)      480      64   system_call_exception+0x138/0x350
>  16)      416     416   system_call_common+0x160/0x2c4
> 
> This results in two additional stores in the ftrace entry code, but
> produces reliable backtraces.
> 
> Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20230621051349.759567-1-naveen@kernel.org
> ---
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

All now queued up, thanks.

greg k-h

