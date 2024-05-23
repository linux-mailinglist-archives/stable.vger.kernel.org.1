Return-Path: <stable+bounces-45672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBA8CD1D0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E540283191
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CF13D25A;
	Thu, 23 May 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="APM+UX4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C713D256
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466194; cv=none; b=leOBckyXQD99+YVGP1QkoBGbkfMm2oXzGpLJVvnT6jMrAiwaxCNQC4+4l7wNjOPoOsnzcPe6EPRJSRH5GEzmYBShUPdI2gXmDk66DPzVGaMGZXG+5XHFiDJcjOfkXa2JvnfBYLM4Irfks2Wf6SzHNX8FNKE1Z0SUPXWuQ5XdFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466194; c=relaxed/simple;
	bh=k4wNR5MNn7Gdxu7TjUF06SGg5A8Lq545kY8s4hYasv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/guuq+YjIm1c8S8Fb97/ZDrU/ueXxv4khOFyDE9l+c8IfFko7amABgJEn0nbiCg+3VxyWcU6g0r8Mch65JI13ljb5ng1ZervPSEH0CtMR6uO5NVxeIvAT199znFbnVqXVImcIzbR2UbqRL2HenQVlXB+hdl936lAISexEC2f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=APM+UX4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF680C2BD10;
	Thu, 23 May 2024 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716466194;
	bh=k4wNR5MNn7Gdxu7TjUF06SGg5A8Lq545kY8s4hYasv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APM+UX4P/YGwD/GmDIvWatz5H7OsuBwHCjuhZA8bUEn6OdVzZxClOVWOQKvZV2frC
	 s7plBdicN7VfLVPCPn4LL1t3qvvPr2pyzO8798Fj+W9dWE5l6peTqorV3oeujoo9p0
	 1ERAxvpdfj2SKq9k4oJf97HvBxOVTOunR4fA9bj0=
Date: Thu, 23 May 2024 14:09:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, tom.zanussi@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.19.y 00/13] fix double-free bug causing by
 destroy_hist_field(data->onmax.var, 0)
Message-ID: <2024052333-disregard-disorder-774d@gregkh>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>

On Thu, May 09, 2024 at 10:29:18AM +0800, George Guo wrote:
> Hi,
>  
> There are 3 points about this bug:
> 
> 1)
> The onmax_destroy() destroyed the onmax var, casusing a double-free error
> flagged by KASAN.
> 
> This is tested via "./ftracetest test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc".
> 
> ==================================================================
> BUG: KASAN: use-after-free in destroy_hist_field+0x1c2/0x200
> Read of size 8 at addr ffff88800a4ad100 by task ftracetest/4731
> 
> CPU: 0 PID: 4731 Comm: ftracetest Kdump: loaded Tainted: GE 4.19.90-89 #77
> Source Version: Unknown
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0
> Call Trace:
>  dump_stack+0xcb/0x10b
>  print_address_description.cold+0x54/0x249
>  kasan_report_error.cold+0x63/0xab
>  ? destroy_hist_field+0x1c2/0x200
>  ? hist_trigger_elt_data_alloc+0x5a0/0x5a0
>  __asan_report_load8_noabort+0x8d/0xa0
>  ? destroy_hist_field+0x1c2/0x200
>  destroy_hist_field+0x1c2/0x200
>  onmax_destroy+0x72/0x1e0
>  ? hist_trigger_elt_data_alloc+0x5a0/0x5a0
>  destroy_hist_data+0x236/0xa40
>  event_hist_trigger_free+0x212/0x2f0
>  ? update_cond_flag+0x128/0x170
>  ? event_hist_trigger_func+0x2880/0x2880
>  hist_unregister_trigger+0x2f2/0x4f0
>  event_hist_trigger_func+0x168c/0x2880
>  ? tracing_map_cmp_u64+0xa0/0xa0
>  ? onmatch_create.constprop.0+0xf50/0xf50
>  ? __mutex_lock_slowpath+0x10/0x10
>  event_trigger_write+0x2f4/0x490
>  ? trigger_start+0x180/0x180
>  ? __fget_light+0x369/0x5d0
>  ? count_memcg_event_mm+0x104/0x2b0
>  ? trigger_start+0x180/0x180
>  __vfs_write+0x81/0x100
>  vfs_write+0x1e1/0x540
>  ksys_write+0x12a/0x290
>  ? __ia32_sys_read+0xb0/0xb0
>  ? __close_fd+0x1d3/0x280
>  do_syscall_64+0xe3/0x2d0
>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> RIP: 0033:0x7fd7f4c44e04
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 
> 48 8d 05 39 34 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 
> f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
> RSP: 002b:00007fff10370df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000010f RCX: 00007fd7f4c44e04
> RDX: 000000000000010f RSI: 000055fa765df650 RDI: 0000000000000001
> RBP: 000055fa765df650 R08: 000000000000000a R09: 0000000000000000
> R10: 000000000000000a R11: 0000000000000246 R12: 00007fd7f4d035c0
> R13: 000000000000010f R14: 00007fd7f4d037c0 R15: 000000000000010f
> ==================================================================
> 
> 2)
> So remove the onmax_destroy() destroy_hist_field() call for that var.
> 
> just like this demo patch:
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 7dcb96305e56..58b8a2575b8c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3489,7 +3488,6 @@ static void onmax_destroy(struct action_data *data)
>  	unsigned int i;
>  
>  	destroy_hist_field(data->onmax.max_var, 0);
> -	destroy_hist_field(data->onmax.var, 0);
>  
>  	kfree(data->onmax.var_str);
>  	kfree(data->onmax.fn_name);
> -- 
> 
> 3) 
> And I found it has been fixed by upstream commit ff9d31d0d466.
> So I am backporting these patches to linux-4.19.y.
> 
> 
> Masami Hiramatsu (4):
>   tracing: Simplify creation and deletion of synthetic events
>   tracing: Add unified dynamic event framework
>   tracing: Use dyn_event framework for synthetic events
>   tracing: Remove unneeded synth_event_mutex
> 
> Steven Rostedt (VMware) (5):
>   tracing: Consolidate trace_add/remove_event_call back to the nolock
>     functions
>   string.h: Add str_has_prefix() helper function
>   tracing: Use str_has_prefix() helper for histogram code
>   tracing: Use str_has_prefix() instead of using fixed sizes
>   tracing: Have the historgram use the result of str_has_prefix() for
>     len of prefix
> 
> Tom Zanussi (4):
>   tracing: Refactor hist trigger action code
>   tracing: Split up onmatch action data
>   tracing: Generalize hist trigger onmax and save action
>   tracing: Remove unnecessary var_ref destroy in track_data_destroy()
> 
>  include/linux/string.h           |   20 +
>  include/linux/trace_events.h     |    2 -
>  kernel/trace/Kconfig             |    4 +
>  kernel/trace/Makefile            |    1 +
>  kernel/trace/trace.c             |   26 +-
>  kernel/trace/trace_dynevent.c    |  210 ++++++
>  kernel/trace/trace_dynevent.h    |  119 ++++
>  kernel/trace/trace_events.c      |   32 +-
>  kernel/trace/trace_events_hist.c | 1048 ++++++++++++++++++------------
>  kernel/trace/trace_probe.c       |    2 +-
>  kernel/trace/trace_stack.c       |    2 +-
>  11 files changed, 1008 insertions(+), 458 deletions(-)
>  create mode 100644 kernel/trace/trace_dynevent.c
>  create mode 100644 kernel/trace/trace_dynevent.h
> 
> -- 
> 2.34.1
> 
> 

Thanks for the backports, all now queued up.

greg k-h

