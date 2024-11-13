Return-Path: <stable+bounces-92928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23559C74C9
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D711F228AB
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080C13AA2D;
	Wed, 13 Nov 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ma2QXgHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA214A4DE
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509444; cv=none; b=fQeNIw9wQ5KYCVPQq7IEB4Jbp/m5GKyyBv8kibEMhHO3d+DgnonlXz6GeWqB2EqajWKWDYeM9bXqg7WU/GVey3hLUcAGFvzfIRiYJlA3cBRoG4Vq76ncvtebyUH/cFY2b0v1a5iapBjLXBgC3Yv2zF8P5yOkn0ULNxqGNM5Sg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509444; c=relaxed/simple;
	bh=GfcJKPlJaexN7qKOmAAhjcdKoEbrjo0SGnTJrySikp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCwQSTkm7ly7+3kZwx6OkqGsNdM/DkAWobpm4Xf/ElDKtFFmXXKxnK9tfTAMCyjnw7a6St9JtTquPMiCvCs9V2ELhPL2nRhz/7lO6iPP/ZZPBkfqq7MvitP5ar6WsEzymK04Wf5AwGxkQxmua4JzuYPZv7FaBhv7C7zx7SGEmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ma2QXgHI; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731509443; x=1763045443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WZXxmXHeX0K6eypw1h1xUanL4UR0EiR6FP3PUSHo+y0=;
  b=Ma2QXgHIvSjV8KmfDU2tHB/u3czRncjRseJ33HP9xM8+QguqWrDqOe02
   nE3bsRGGPDS+M3oirHRSbxCnnGBD4Z5GeiSUMwxyWAPo4kbj3LWPcJLxd
   26rvDWi/8wZ346OUKsFuoqIfZUD0TAlfFgVPWrvoU24bROLXJIMpteWc9
   4=;
X-IronPort-AV: E=Sophos;i="6.12,151,1728950400"; 
   d="scan'208";a="673700998"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:50:40 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:30355]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.85:2525] with esmtp (Farcaster)
 id b9699113-ea46-4fa7-82a2-a930dbd49a2e; Wed, 13 Nov 2024 14:50:38 +0000 (UTC)
X-Farcaster-Flow-ID: b9699113-ea46-4fa7-82a2-a930dbd49a2e
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 13 Nov 2024 14:50:38 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 13 Nov 2024 14:50:38 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id 9C36E404FD;
	Wed, 13 Nov 2024 14:50:37 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 51CF022471; Wed, 13 Nov 2024 14:50:37 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:50:37 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <stable@vger.kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
	<mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 5.4] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <20241113145037.GA7895@amazon.com>
References: <20241111144445.27428-1-hagarhem@amazon.com>
 <20241112104618.4f2720d8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112104618.4f2720d8@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 12, 2024 at 10:46:18AM -0500, Steven Rostedt wrote:
> On Mon, 11 Nov 2024 14:44:45 +0000
> Hagar Hemdan <hagarhem@amazon.com> wrote:
> 
> > From: Zheng Yejian <zhengyejian1@huawei.com>
> > 
> > commit e60b613df8b6253def41215402f72986fee3fc8d upstream.
> > 
> > KASAN reports a bug:
> > 
> >   BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
> >   Read of size 8 at addr ffff888141d40010 by task insmod/424
> >   CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+
> >   [...]
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x68/0xa0
> >    print_report+0xcf/0x610
> >    kasan_report+0xb5/0xe0
> >    ftrace_location+0x90/0x120
> >    register_kprobe+0x14b/0xa40
> >    kprobe_init+0x2d/0xff0 [kprobe_example]
> >    do_one_initcall+0x8f/0x2d0
> >    do_init_module+0x13a/0x3c0
> >    load_module+0x3082/0x33d0
> >    init_module_from_file+0xd2/0x130
> >    __x64_sys_finit_module+0x306/0x440
> >    do_syscall_64+0x68/0x140
> >    entry_SYSCALL_64_after_hwframe+0x71/0x79
> > 
> > The root cause is that, in ftrace_location_range(), ftrace record of some address
> > is being searched in ftrace pages of some module, but those ftrace pages
> > at the same time is being freed in ftrace_release_mod() as the
> > corresponding module is being deleted:
> > 
> >            CPU1                       |      CPU2
> >   register_kprobes() {                | delete_module() {
> >     check_kprobe_address_safe() {     |
> >       arch_check_ftrace_location() {  |
> >         ftrace_location() {           |
> >           lookup_rec() // USE!        |   ftrace_release_mod() // Free!
> > 
> > To fix this issue:
> >   1. Hold rcu lock as accessing ftrace pages in ftrace_location_range();
> >   2. Use ftrace_location_range() instead of lookup_rec() in
> >      ftrace_location();
> >   3. Call synchronize_rcu() before freeing any ftrace pages both in
> >      ftrace_process_locs()/ftrace_release_mod()/ftrace_free_mem().
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20240509192859.1273558-1-zhengyejian1@huawei.com
> > 
> > Cc: stable@vger.kernel.org
> > Cc: <mhiramat@kernel.org>
> > Cc: <mark.rutland@arm.com>
> > Cc: <mathieu.desnoyers@efficios.com>
> > Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > [Hagar: Modified to apply on v5.4.y]
> > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> > ---
> > only compile tested.
> 
> You should do more than that. At least run the ftrace selftests.
ok, tested v2 and will send it soon.
> 
> > ---
> >  kernel/trace/ftrace.c | 30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 412505d94865..60bf8a6d55ce 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1552,7 +1552,9 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> >  	struct ftrace_page *pg;
> >  	struct dyn_ftrace *rec;
> >  	struct dyn_ftrace key;
> > +	unsigned long ip = 0;
> >  
> > +	rcu_read_lock();
> >  	key.ip = start;
> >  	key.flags = end;	/* overload flags, as it is unsigned long */
> >  
> > @@ -1565,10 +1567,13 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> >  			      sizeof(struct dyn_ftrace),
> >  			      ftrace_cmp_recs);
> >  		if (rec)
> > -			return rec->ip;
> > +		{
> > +			ip = rec->ip;
> > +			break;
> > +		}
> 
> The above breaks Linux coding style. It should be:
> 
> 		if (rec) {
> 			ip = rec->ip;
> 			break;
> 		}
> 
> -- Steve
ok, updated in v2, thanks!
> 
> 
> >  	}
> > -
> > -	return 0;
> > +	rcu_read_unlock();
> > +	return ip;
> >  }
> >  
> >  /**
> > @@ -5736,6 +5741,8 @@ static int ftrace_process_locs(struct module *mod,
> >  	/* We should have used all pages unless we skipped some */
> >  	if (pg_unuse) {
> >  		WARN_ON(!skipped);
> > +		/* Need to synchronize with ftrace_location_range() */
> > +		synchronize_rcu();
> >  		ftrace_free_pages(pg_unuse);
> >  	}
> >  	return ret;
> > @@ -5889,6 +5896,9 @@ void ftrace_release_mod(struct module *mod)
> >   out_unlock:
> >  	mutex_unlock(&ftrace_lock);
> >  
> > +	/* Need to synchronize with ftrace_location_range() */
> > +	if (tmp_page)
> > +		synchronize_rcu();
> >  	for (pg = tmp_page; pg; pg = tmp_page) {
> >  
> >  		/* Needs to be called outside of ftrace_lock */
> > @@ -6196,6 +6206,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
> >  	unsigned long start = (unsigned long)(start_ptr);
> >  	unsigned long end = (unsigned long)(end_ptr);
> >  	struct ftrace_page **last_pg = &ftrace_pages_start;
> > +	struct ftrace_page *tmp_page = NULL;
> >  	struct ftrace_page *pg;
> >  	struct dyn_ftrace *rec;
> >  	struct dyn_ftrace key;
> > @@ -6239,12 +6250,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
> >  		ftrace_update_tot_cnt--;
> >  		if (!pg->index) {
> >  			*last_pg = pg->next;
> > -			if (pg->records) {
> > -				free_pages((unsigned long)pg->records, pg->order);
> > -				ftrace_number_of_pages -= 1 << pg->order;
> > -			}
> > -			ftrace_number_of_groups--;
> > -			kfree(pg);
> > +			pg->next = tmp_page;
> > +			tmp_page = pg;
> >  			pg = container_of(last_pg, struct ftrace_page, next);
> >  			if (!(*last_pg))
> >  				ftrace_pages = pg;
> > @@ -6261,6 +6268,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
> >  		clear_func_from_hashes(func);
> >  		kfree(func);
> >  	}
> > +	/* Need to synchronize with ftrace_location_range() */
> > +	if (tmp_page) {
> > +		synchronize_rcu();
> > +		ftrace_free_pages(tmp_page);
> > +	}
> >  }
> >  
> >  void __init ftrace_free_init_mem(void)
> 

