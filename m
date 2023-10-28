Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29277DA4AF
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 03:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJ1Blw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJ1Blv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 21:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A079E
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 18:41:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B761C433C8;
        Sat, 28 Oct 2023 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698457308;
        bh=culIKFe+JSj9EHA864Ou39mlvl0u+Ctl5H8IvNqq8+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXa3SL6auUCV66hDM1saY5rjnAQHKpCd8Lc86L4XaH53vvBsK1zjgNIOOgaPxfbaD
         n6dxp9BV0VEcdnYBq1iXXYjwY+iqNDkNSaBQ3hB6C4CFQLaw9uZv2LDFQAmrDgiDry
         mL8Z1QfLP0eySvoqWMCUfVG4ci2EMzCHHr6t88IbQUI+IIS52yZD28USV5XoQVRUBZ
         ZnEW/sn34XwCO/yCWGBevsb3T+toptKWHLaCFg6IYL+8ywqDjw3P3fe9Jbi2c5B6jI
         9R+gFPECRDUKtDRw1ebEFOBK5Sv+rU3kgES0M2gA3dJW4yqFnoN0m+H6XDX0QInQRa
         owC5w0ALTLbkg==
Date:   Sat, 28 Oct 2023 10:41:44 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        <stable@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028104144.de23c2287281e9228ce92508@kernel.org>
In-Reply-To: <20231027233126.2073148-1-andrii@kernel.org>
References: <20231027233126.2073148-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Fri, 27 Oct 2023 16:31:26 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
> 
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
> 
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This fixes "BPF" kprobe event, but not ftrace kprobe events.
ftrace kprobe events only checks this if it is in the vmlinux not
modules and that's why my selftest passed the original one.
Hmm, I need another enhancement like this for the events on offline
modules.

Thank you,

> ---
>  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index effcaede4759..1efb27f35963 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
>  	return 0;
>  }
>  
> +struct sym_count_ctx {
> +	unsigned int count;
> +	const char *name;
> +};
> +
> +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> +{
> +	struct sym_count_ctx *ctx = data;
> +
> +	if (strcmp(name, ctx->name) == 0)
> +		ctx->count++;
> +
> +	return 0;
> +}
> +
>  static unsigned int number_of_same_symbols(char *func_name)
>  {
> -	unsigned int count;
> +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> +
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> -	count = 0;
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
>  
> -	return count;
> +	return ctx.count;
>  }
>  
>  static int __trace_kprobe_create(int argc, const char *argv[])
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
