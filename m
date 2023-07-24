Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B675EB84
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 08:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXGaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGXGaR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 02:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD25FE
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 23:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F1A60F09
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 06:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BEC433C7;
        Mon, 24 Jul 2023 06:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690180209;
        bh=UbgTViu+rLzYOjp0NGD8BQrfvAobXb85C5Ik4j1tG58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3veyKXw5jQelewKyUb3idXjsUj/OEIutNk6TwL2fsfTON6wmExLrfJQNBFGdxi0K
         5F9ztM4oPMfKeOQhGarLiQxThMyjdRQoiK3KIuPIippvLKFLLOlJxWLrhfyA/9P8xF
         cTQKuvR0wlt5MIXom8nm9DzAbNlX+Qvimx/2pGVw=
Date:   Mon, 24 Jul 2023 08:30:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     rostedt@goodmis.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.10] tracing: Fix memory leak of iter->temp when reading
 trace_pipe
Message-ID: <2023072454-policy-whomever-6ecc@gregkh>
References: <2023072128-pavilion-employer-0a22@gregkh>
 <20230724021656.3472116-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724021656.3472116-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 10:16:56AM +0800, Zheng Yejian wrote:
> commit d5a821896360cc8b93a15bd888fabc858c038dc0 upstream.
> 
> kmemleak reports:
>   unreferenced object 0xffff88814d14e200 (size 256):
>     comm "cat", pid 336, jiffies 4294871818 (age 779.490s)
>     hex dump (first 32 bytes):
>       04 00 01 03 00 00 00 00 08 00 00 00 00 00 00 00  ................
>       0c d8 c8 9b ff ff ff ff 04 5a ca 9b ff ff ff ff  .........Z......
>     backtrace:
>       [<ffffffff9bdff18f>] __kmalloc+0x4f/0x140
>       [<ffffffff9bc9238b>] trace_find_next_entry+0xbb/0x1d0
>       [<ffffffff9bc9caef>] trace_print_lat_context+0xaf/0x4e0
>       [<ffffffff9bc94490>] print_trace_line+0x3e0/0x950
>       [<ffffffff9bc95499>] tracing_read_pipe+0x2d9/0x5a0
>       [<ffffffff9bf03a43>] vfs_read+0x143/0x520
>       [<ffffffff9bf04c2d>] ksys_read+0xbd/0x160
>       [<ffffffff9d0f0edf>] do_syscall_64+0x3f/0x90
>       [<ffffffff9d2000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> when reading file 'trace_pipe', 'iter->temp' is allocated or relocated
> in trace_find_next_entry() but not freed before 'trace_pipe' is closed.
> 
> To fix it, free 'iter->temp' in tracing_release_pipe().
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230713141435.1133021-1-zhengyejian1@huawei.com
> 
> Cc: stable@vger.kernel.org
> Fixes: ff895103a84ab ("tracing: Save off entry when peeking at next entry")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> [Fix conflict due to lack of 649e72070cbbb8600eb823833e4748f5a0815116]
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 70526400e05c..8d005c7ccfae 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6250,6 +6250,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  	mutex_unlock(&trace_types_lock);
>  
>  	free_cpumask_var(iter->started);
> +	kfree(iter->temp);
>  	mutex_destroy(&iter->mutex);
>  	kfree(iter);
>  
> -- 
> 2.25.1
> 

Now queued up, thanks.

greg k-h
