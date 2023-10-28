Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65B7DA501
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJ1DSQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 23:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1DSP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 23:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6949C
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 20:18:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A8CC433C8;
        Sat, 28 Oct 2023 03:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698463090;
        bh=d/Vb6DNmTEBIIjqjO5hkSt8UwYYghPzG/0GkjApsIVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TcXwIpdJHA9nIFKmtJNWNLw1daZ7qiOc+Mhes/nR86coS9F9wUOwYUK+OKywcMFoy
         Ur+QR/k5pLehHfbF6OM15xrEF/OcjooKzJWsJXjVOf1BTRt5vw4ne25G4rFQNykinG
         VT9wDrUMu16ughKkWxLABC7mGkZ/b5FFTO3L/dZ6W9DPPIMhopoaTX3xJ7vy0Fj3T7
         hnpuaYFiVFlHJ7O8QLyETjFpYbBlFwA0fUikiUFlsHgBuWDRWXnAYwXWzAN4mMpqkS
         ckhuXVDFXnrMvzYiB0zTCtjgLb4ctjTMMLaxADBVN1NiHQ0HnhvPBDwUYRWDTNXTQI
         xNzmCvR9/ENNg==
Date:   Sat, 28 Oct 2023 12:18:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        <stable@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028121805.d156c41fa75cfdcf91550c33@kernel.org>
In-Reply-To: <20231028104144.de23c2287281e9228ce92508@kernel.org>
References: <20231027233126.2073148-1-andrii@kernel.org>
        <20231028104144.de23c2287281e9228ce92508@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 28 Oct 2023 10:41:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Fri, 27 Oct 2023 16:31:26 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> > 
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> > 
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> This fixes "BPF" kprobe event, but not ftrace kprobe events.
> ftrace kprobe events only checks this if it is in the vmlinux not
> modules and that's why my selftest passed the original one.

Ah, my bad. ftrace kprobe event should accept the target symbol without
module name. Yes, in that case it missed the count.

> Hmm, I need another enhancement like this for the events on offline
> modules.

Also, I need to add another test case update without module name.
(this one should be another fix)

Thank you,

> 
> Thank you,
> 
> > ---
> >  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index effcaede4759..1efb27f35963 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
> >  	return 0;
> >  }
> >  
> > +struct sym_count_ctx {
> > +	unsigned int count;
> > +	const char *name;
> > +};
> > +
> > +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> > +{
> > +	struct sym_count_ctx *ctx = data;
> > +
> > +	if (strcmp(name, ctx->name) == 0)
> > +		ctx->count++;
> > +
> > +	return 0;
> > +}
> > +
> >  static unsigned int number_of_same_symbols(char *func_name)
> >  {
> > -	unsigned int count;
> > +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> > +
> > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> >  
> > -	count = 0;
> > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> >  
> > -	return count;
> > +	return ctx.count;
> >  }
> >  
> >  static int __trace_kprobe_create(int argc, const char *argv[])
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
