Return-Path: <stable+bounces-92212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DB9C50B3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DA3B29701
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DC20C004;
	Tue, 12 Nov 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Is6jik8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1D20B7FA
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400310; cv=none; b=rdmQ2tR1ED5N1iOrbKNh8+wD+dQOb9faxyIPB291quxcJyisfcT6NS2NubAv0k4ujmXF4fRbjgAgkz5RX0MqyguIOCCa4iLckFc5TjJTjaSaIwuX1Qp/TcOtFPM43sJxg/Jwnt6ALVB++TECo15niLwHKD3/ZpXOO67CeFNEn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400310; c=relaxed/simple;
	bh=FeQ4kH0eNpZ45C617+e47mtDVp/DfwpPakWOgOFhFV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt0/t5cH1Q0181yaYYKb8aEnwWfr7RY4dU3z5JYGe7tg86TevZu1P1smgdUUAvO8btKxANL+mfCKGXJoyWln6AmtiCBanuaPuA1yKj5XRzm2H8Zxe0N6pX+TG6VnLUnREYiKiRmOhnqbH5i72urAg1AkiL+9Mq10AaXIvvCp5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Is6jik8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E745C4CECD;
	Tue, 12 Nov 2024 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731400310;
	bh=FeQ4kH0eNpZ45C617+e47mtDVp/DfwpPakWOgOFhFV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Is6jik8LWxw4HlNPrICwgzO4t64SIoo+LEOj6iqZZCgBqAlrWiS9YRbY7FT2glijd
	 dpzShOSTwXTpsatr4TNF/RDBSFAMeJZxPBJYtQG+UOF5nRkAruAC9saqK8HXo/aaBe
	 mz4qJFL54YDf3HzyxY6MFFq4y6HtGsmQ5Bawj03U=
Date: Tue, 12 Nov 2024 09:31:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Zheng Yejian <zhengyejian1@huawei.com>,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5.4] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <2024111239-remodeler-autism-3502@gregkh>
References: <20241111144445.27428-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111144445.27428-1-hagarhem@amazon.com>

On Mon, Nov 11, 2024 at 02:44:45PM +0000, Hagar Hemdan wrote:
> From: Zheng Yejian <zhengyejian1@huawei.com>
> 
> commit e60b613df8b6253def41215402f72986fee3fc8d upstream.
> 
> KASAN reports a bug:
> 
>   BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
>   Read of size 8 at addr ffff888141d40010 by task insmod/424
>   CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+
>   [...]
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x68/0xa0
>    print_report+0xcf/0x610
>    kasan_report+0xb5/0xe0
>    ftrace_location+0x90/0x120
>    register_kprobe+0x14b/0xa40
>    kprobe_init+0x2d/0xff0 [kprobe_example]
>    do_one_initcall+0x8f/0x2d0
>    do_init_module+0x13a/0x3c0
>    load_module+0x3082/0x33d0
>    init_module_from_file+0xd2/0x130
>    __x64_sys_finit_module+0x306/0x440
>    do_syscall_64+0x68/0x140
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> The root cause is that, in ftrace_location_range(), ftrace record of some address
> is being searched in ftrace pages of some module, but those ftrace pages
> at the same time is being freed in ftrace_release_mod() as the
> corresponding module is being deleted:
> 
>            CPU1                       |      CPU2
>   register_kprobes() {                | delete_module() {
>     check_kprobe_address_safe() {     |
>       arch_check_ftrace_location() {  |
>         ftrace_location() {           |
>           lookup_rec() // USE!        |   ftrace_release_mod() // Free!
> 
> To fix this issue:
>   1. Hold rcu lock as accessing ftrace pages in ftrace_location_range();
>   2. Use ftrace_location_range() instead of lookup_rec() in
>      ftrace_location();
>   3. Call synchronize_rcu() before freeing any ftrace pages both in
>      ftrace_process_locs()/ftrace_release_mod()/ftrace_free_mem().
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240509192859.1273558-1-zhengyejian1@huawei.com
> 
> Cc: stable@vger.kernel.org
> Cc: <mhiramat@kernel.org>
> Cc: <mark.rutland@arm.com>
> Cc: <mathieu.desnoyers@efficios.com>
> Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> [Hagar: Modified to apply on v5.4.y]
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> ---
> only compile tested.
> ---
>  kernel/trace/ftrace.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Now queued up, thanks.

greg k-h

