Return-Path: <stable+bounces-33923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3604893AEB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943D41F211A8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481213716F;
	Mon,  1 Apr 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEPjh0hR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8F383A4
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974276; cv=none; b=GuUUBYdHWxpgQl9YryNZW9TUg/v4txvhMvos3Rcryoh9+dnpCdSkvMywbHiXtTFIfdreHiSGLnZGIy7fkIeAdcxaUHXHRAHOpkSYRK5hRVANXE8IFvzfjjV3hY3ohnjKGfXv/7aS529cruQXZzvw1S5pWJoTTySM6lSCpulMQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974276; c=relaxed/simple;
	bh=7uKE0K8Hz9PBQjbh3DshQrL5kB/kVNCH5csvyFZhlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIvMS8/ejP2wYoq6PemB0VIqVOCf04iDSAD5QLIN0Q/wzu+wNwPMbxW+uUPoY8q7s5LP4K4JgvH4ZKhxBAiM0MQshMQtba4HqjZIB5F/9GSgJjXjnU4NgC1TFgZPslkXfL2S7jqlHR1VbeqDpGPgZrgvmRUHy3uoYVnXISYTI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEPjh0hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986AC433C7;
	Mon,  1 Apr 2024 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711974275;
	bh=7uKE0K8Hz9PBQjbh3DshQrL5kB/kVNCH5csvyFZhlbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEPjh0hRZpTZyl7Fwodn+ZhBUKHzEA1RuSnFqzzyM+rX+AuScFvq/h+qi0N9g61g5
	 yXTVYFrL1mZ0R7bFJpAjUU8s2FL1nLUYXUV/GGDTUmN4Qu875v8O1HUo++nWeidsUD
	 cYdn09pQQIGz17CdIELKBD+Ee0+OOXJ4r0EzyPAk=
Date: Mon, 1 Apr 2024 14:24:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: stable@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 4.19 2/2] tracing: Remove unnecessary var destroy in
 onmax_destroy()
Message-ID: <2024040106-shirt-announcer-e9bb@gregkh>
References: <20240401075049.2655077-1-dongtai.guo@linux.dev>
 <20240401075049.2655077-3-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075049.2655077-3-dongtai.guo@linux.dev>

On Mon, Apr 01, 2024 at 03:50:49PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> commit ff9d31d0d46672e201fc9ff59c42f1eef5f00c77 upstream.
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
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Again, Fixes: line is incorrect and you lost all of the correct
authorship and review information.

thanks,

greg k-h

