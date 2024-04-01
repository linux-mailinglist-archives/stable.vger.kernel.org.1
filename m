Return-Path: <stable+bounces-33922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CA893AE7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5202819C8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A138DCC;
	Mon,  1 Apr 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ziybt64/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADE383AF
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974233; cv=none; b=fY6CvAh4efbjClerPM/TVrC+7185VPQTPwN3D3zo1QKIqJnbt7sX4qMkBaSUlrMJBWkpSx/yJjgZgeNXVCyPvWgwkRVDRJ8oG/41WBwAeKyjgZZnUnNLsEoSGOZb0qKnz4ZOmvg5/9XQtrR8BNeFYJGOGQIiqiQBM1UusmTbs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974233; c=relaxed/simple;
	bh=/NWOUG75EBVaRUzYfYgGI61RN79jx0JWIdmjPedLDZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoZN/Q8RyZv9cmvGgpcBCt3yKb7sCzSxLLJQ4tPDRvHXaqDDCOmTsQ65DMUxFKLNY44URJ4dw3sy2Np5Y0VwTl1WGnoJR8CkTV8xopwxbOOKnHyJFrR6SaNB3R/YWO0M0A/C2VrK6SasYY9D1QHxBYYAOM1cPdj+rT5uC+6Zywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ziybt64/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D35C433F1;
	Mon,  1 Apr 2024 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711974232;
	bh=/NWOUG75EBVaRUzYfYgGI61RN79jx0JWIdmjPedLDZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ziybt64/A4DcG/3+R3gDxSVaf/M5s0LSHp9CAfK0r4RuT3Bqxc1uYchwXlVJ38N+i
	 KXkuNMtJjWj/mIs8xD/jkxXZOcJwd4TXlCjtzNXkXoiOeFULmx4yzu3W7G29FTPrl0
	 XiYXG5dyUuS2LvrbaRUFXoVkih0V8HjE4AwPjZ5o=
Date: Mon, 1 Apr 2024 14:23:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: stable@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 4.19 v2 1/2] tracing: Remove unnecessary hist_data
 destroy in destroy_synth_var_refs()
Message-ID: <2024040153-reappoint-kick-3a28@gregkh>
References: <20240401075049.2655077-1-dongtai.guo@linux.dev>
 <20240401075049.2655077-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075049.2655077-2-dongtai.guo@linux.dev>

On Mon, Apr 01, 2024 at 03:50:48PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> commit 912201345f7c39e6b0ac283207be2b6641fa47b9 upstream.

Ok, but:

> 
> The destroy_synth_var_refs() destroyed hist_data, casusing a double-free 
> error flagged by KASAN.
> 
> This is tested via "./ftracetest test.d/trigger/inter-event/
> trigger-field-variable-support.tc"
> 
> ==================================================================
> BUG: KASAN: use-after-free in destroy_hist_field+0x115/0x140
> Read of size 4 at addr ffff888012e95318 by task ftracetest/1858
> 
> CPU: 1 PID: 1858 Comm: ftracetest Kdump: loaded Tainted: GE 4.19.90-89 #24
> Source Version: Unknown
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0
> Call Trace:
>  dump_stack+0xcb/0x10b
>  print_address_description.cold+0x54/0x249
>  kasan_report_error.cold+0x63/0xab
>  ? destroy_hist_field+0x115/0x140
>  __asan_report_load4_noabort+0x8d/0xa0
>  ? destroy_hist_field+0x115/0x140
>  destroy_hist_field+0x115/0x140
>  destroy_hist_data+0x4e4/0x9a0
>  event_hist_trigger_free+0x212/0x2f0
>  ? update_cond_flag+0x128/0x170
>  ? event_hist_trigger_func+0x2880/0x2880
>  hist_unregister_trigger+0x2f2/0x4f0
>  event_hist_trigger_func+0x168c/0x2880
>  ? tracing_map_read_var_once+0xd0/0xd0
>  ? create_key_field+0x520/0x520
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
> RIP: 0033:0x7efdd342ee04
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 
> 8d 05 39 34 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff 
> ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
> RSP: 002b:00007ffda01f5e08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000000b4 RCX: 00007efdd342ee04
> RDX: 00000000000000b4 RSI: 000055c5b41b1e90 RDI: 0000000000000001
> RBP: 000055c5b41b1e90 R08: 000000000000000a R09: 0000000000000000
> R10: 000000000000000a R11: 0000000000000246 R12: 00007efdd34ed5c0
> R13: 00000000000000b4 R14: 00007efdd34ed7c0 R15: 00000000000000b4
> ==================================================================
> 
> So remove the destroy_synth_var_refs() call for that hist_data.
> 
> Fixes: c282a386a397("tracing: Add 'onmatch' hist trigger action support")
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

The above is not the changelog for the referenced commit.

And you did not cc: any of the original developers on this commit to get
their review :(

And the Fixes: line is formatted incorrectly :(

thanks,

greg k-h

