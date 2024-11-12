Return-Path: <stable+bounces-92807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40819C5E2F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B64EB2FDA1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019BA2022F0;
	Tue, 12 Nov 2024 15:46:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBD2022E2
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426362; cv=none; b=crC1bmy1AKRRgJWcSSnQM91eQ+Cilddrc+piUWeL3rWStyTWF9otK2oWMHdnTC87TEVW4S8KSGZuhaNqwqDgSlNYgcIt8BXEoxO33E71Vys9MZcJ76k08RPgldzxPPz4K8yFTk2CKSrZIKe2k6uTiPNOCHLhcY18bxgEPt93XVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426362; c=relaxed/simple;
	bh=D0tZMOvBLoVhfhHe3jLsuH35yZBZ1CzceTWytEH+f20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvuJ2JcW9m/Vt8F6sXdY7xjbSFnefDWN4wGJu1BlnZwebihgncDI13GRZAvQp6LvqL9flnCqhB74lQ//zNGzTXT34Ws0Va1pliUOYQG26bxCBnGABSb2lJ1n0zG0xQ6OKrMI6bJWN1fuN7kL6YndwHaKy5cea6PyfD+HrxuZrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD06C4CECD;
	Tue, 12 Nov 2024 15:46:01 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:46:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: <stable@vger.kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
 <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 5.4] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <20241112104618.4f2720d8@gandalf.local.home>
In-Reply-To: <20241111144445.27428-1-hagarhem@amazon.com>
References: <20241111144445.27428-1-hagarhem@amazon.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:44:45 +0000
Hagar Hemdan <hagarhem@amazon.com> wrote:

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

You should do more than that. At least run the ftrace selftests.

> ---
>  kernel/trace/ftrace.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 412505d94865..60bf8a6d55ce 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1552,7 +1552,9 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  	struct dyn_ftrace key;
> +	unsigned long ip = 0;
>  
> +	rcu_read_lock();
>  	key.ip = start;
>  	key.flags = end;	/* overload flags, as it is unsigned long */
>  
> @@ -1565,10 +1567,13 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  			      sizeof(struct dyn_ftrace),
>  			      ftrace_cmp_recs);
>  		if (rec)
> -			return rec->ip;
> +		{
> +			ip = rec->ip;
> +			break;
> +		}

The above breaks Linux coding style. It should be:

		if (rec) {
			ip = rec->ip;
			break;
		}

-- Steve


>  	}
> -
> -	return 0;
> +	rcu_read_unlock();
> +	return ip;
>  }
>  
>  /**
> @@ -5736,6 +5741,8 @@ static int ftrace_process_locs(struct module *mod,
>  	/* We should have used all pages unless we skipped some */
>  	if (pg_unuse) {
>  		WARN_ON(!skipped);
> +		/* Need to synchronize with ftrace_location_range() */
> +		synchronize_rcu();
>  		ftrace_free_pages(pg_unuse);
>  	}
>  	return ret;
> @@ -5889,6 +5896,9 @@ void ftrace_release_mod(struct module *mod)
>   out_unlock:
>  	mutex_unlock(&ftrace_lock);
>  
> +	/* Need to synchronize with ftrace_location_range() */
> +	if (tmp_page)
> +		synchronize_rcu();
>  	for (pg = tmp_page; pg; pg = tmp_page) {
>  
>  		/* Needs to be called outside of ftrace_lock */
> @@ -6196,6 +6206,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  	unsigned long start = (unsigned long)(start_ptr);
>  	unsigned long end = (unsigned long)(end_ptr);
>  	struct ftrace_page **last_pg = &ftrace_pages_start;
> +	struct ftrace_page *tmp_page = NULL;
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  	struct dyn_ftrace key;
> @@ -6239,12 +6250,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  		ftrace_update_tot_cnt--;
>  		if (!pg->index) {
>  			*last_pg = pg->next;
> -			if (pg->records) {
> -				free_pages((unsigned long)pg->records, pg->order);
> -				ftrace_number_of_pages -= 1 << pg->order;
> -			}
> -			ftrace_number_of_groups--;
> -			kfree(pg);
> +			pg->next = tmp_page;
> +			tmp_page = pg;
>  			pg = container_of(last_pg, struct ftrace_page, next);
>  			if (!(*last_pg))
>  				ftrace_pages = pg;
> @@ -6261,6 +6268,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  		clear_func_from_hashes(func);
>  		kfree(func);
>  	}
> +	/* Need to synchronize with ftrace_location_range() */
> +	if (tmp_page) {
> +		synchronize_rcu();
> +		ftrace_free_pages(tmp_page);
> +	}
>  }
>  
>  void __init ftrace_free_init_mem(void)


