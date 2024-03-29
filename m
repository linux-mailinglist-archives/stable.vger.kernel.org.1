Return-Path: <stable+bounces-33136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E157D891633
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4595CB2164F
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B140BF2;
	Fri, 29 Mar 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ev6x6gSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387103BBE7
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705244; cv=none; b=leGGEmC5/+NLSHgR0gFd8mNk8KCJxAQw4HNuN1XdfhDKuaiPcgjdXS/Mu0FDe21t/6cMLMnl7lOCJgX8hLMJUAv3+dlpaHVgFJaP9NHaABYxkeq0RoGavnmQ6k6QZVNQaU25cOVVAOviUDBMGD9zTwCVRU0x+ld56N0P7VB2eGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705244; c=relaxed/simple;
	bh=6+LRhLWCDGgK3cCk8d5/FDuKeHbiMR5tH8z5glJKQmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB0tMCiOdpODd1bPrdjBleW0Xamq9+R4JCF1AiLgt8R9BnzHHrtcOzYx97yAcQdSRszMZZfl9I/K8COfsxePm14NMR9rxQ9Zenr4qAmVmrFGED9NJF3bL3pltx536esyUHsOTUeK6XSKYRgWCoe5Duww3U7FQ7mmRfUgoyy8O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ev6x6gSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6FEC433F1;
	Fri, 29 Mar 2024 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711705244;
	bh=6+LRhLWCDGgK3cCk8d5/FDuKeHbiMR5tH8z5glJKQmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev6x6gSUKjKIw9puYJpswcsVdJtFqnLevi6DXWeIL4ROwJiUV/cXmWp4EGIEBn+lC
	 +oP/eu9lvZp+GhXTjg7x/1F3uZSDJuz8pz4UHE5AaFmYVNy9bAde0RLW0Ap3kiKQIk
	 o3E/Kqx4oMMPDIhfxQAFjm2seUoA/RrPxUj8HFqU=
Date: Fri, 29 Mar 2024 10:40:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: George Guo <guodongtai@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Remove unnecessary var destroy in
 onmax_destroy()
Message-ID: <2024032924-rewire-broken-5b90@gregkh>
References: <20240312094233.445337-1-dongtai.guo@linux.dev>
 <20240312094233.445337-3-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312094233.445337-3-dongtai.guo@linux.dev>

On Tue, Mar 12, 2024 at 05:42:33PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> The onmax_destroy() destroyed the onmax var, casusing a double-free error
> flagged by KASAN.
> 
> This is tested via "./ftracetest test.d/trigger/inter-event/
> trigger-onmatch-onmax-action-hist.tc".
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
> So remove the onmax_destroy() destroy_hist_field() call for that var.
> 
> Fixes: 50450603ec9c("tracing: Add 'onmax' hist trigger action support")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/trace/trace_events_hist.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 7dcb96305e56..58b8a2575b8c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -337,7 +337,6 @@ struct action_data {
>  			char			*fn_name;
>  			unsigned int		max_var_ref_idx;
>  			struct hist_field	*max_var;
> -			struct hist_field	*var;
>  		} onmax;
>  	};
>  };
> @@ -3489,7 +3488,6 @@ static void onmax_destroy(struct action_data *data)
>  	unsigned int i;
>  
>  	destroy_hist_field(data->onmax.max_var, 0);
> -	destroy_hist_field(data->onmax.var, 0);
>  
>  	kfree(data->onmax.var_str);
>  	kfree(data->onmax.fn_name);
> @@ -3528,8 +3526,6 @@ static int onmax_create(struct hist_trigger_data *hist_data,
>  	if (!ref_field)
>  		return -ENOMEM;
>  
> -	data->onmax.var = ref_field;
> -
>  	data->fn = onmax_save;
>  	data->onmax.max_var_ref_idx = var_ref_idx;
>  	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
> -- 
> 2.34.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

