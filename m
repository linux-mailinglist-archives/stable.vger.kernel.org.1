Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D9702D3D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjEOM5d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbjEOM5B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197D18F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D06D4623CB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE161C433D2;
        Mon, 15 May 2023 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684155406;
        bh=pTmqVCoVVAd1QgjekfktsMQChX+h1KsaXLWHnF/vNhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FV5hU/TIKaBlvZoMfqAbVdCSTbXBF06JsM6pjj/UoQiRvgg3SKWo12250s1PvXDSL
         Ts0AUmSpb5rviX40Q3K7l34ecnwtClcQniUcwYtq4Zzn9ups6vOBesHzMkQ8fHv1iP
         GLO8vv+ptZcHsFYlhRWf4rrYtCHUAA6aQqxQzmO4=
Date:   Mon, 15 May 2023 14:56:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 5.10.y] printk: declare printk_deferred_{enter,safe}() in
 include/linux/printk.h
Message-ID: <2023051537-embargo-scouting-a849@gregkh>
References: <2023042446-gills-morality-d566@gregkh>
 <767ab028-d946-98d5-4a13-d6ed6df77763@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767ab028-d946-98d5-4a13-d6ed6df77763@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 14, 2023 at 01:41:27PM +0900, Tetsuo Handa wrote:
> commit 85e3e7fbbb720b9897fba9a99659e31cbd1c082e upstream.
> 
> [This patch implements subset of original commit 85e3e7fbbb72 ("printk:
> remove NMI tracking") where commit 1007843a9190 ("mm/page_alloc: fix
> potential deadlock on zonelist_update_seq seqlock") depends on, for
> commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
> build_all_zonelists and page allocation") was backported to stable.]
> 
> All NMI contexts are handled the same as the safe context: store the
> message and defer printing. There is no need to have special NMI
> context tracking for this. Using in_nmi() is enough.
> 
> There are several parts of the kernel that are manually calling into
> the printk NMI context tracking in order to cause general printk
> deferred printing:
> 
>     arch/arm/kernel/smp.c
>     arch/powerpc/kexec/crash.c
>     kernel/trace/trace.c
> 
> For arm/kernel/smp.c and powerpc/kexec/crash.c, provide a new
> function pair printk_deferred_enter/exit that explicitly achieves the
> same objective.
> 
> For ftrace, remove the printk context manipulation completely. It was
> added in commit 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when
> accessing the main log buffer in NMI"). The purpose was to enforce
> storing messages directly into the ring buffer even in NMI context.
> It really should have only modified the behavior in NMI context.
> There is no need for a special behavior any longer. All messages are
> always stored directly now. The console deferring is handled
> transparently in vprintk().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> [pmladek@suse.com: Remove special handling in ftrace.c completely.
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/20210715193359.25946-5-john.ogness@linutronix.de
> [penguin-kernel: Copy only printk_deferred_{enter,safe}() definition ]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/printk.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fe7eb2351610..344f6da3d4c3 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -623,4 +623,23 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
>  #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
>  	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
>  
> +#ifdef CONFIG_PRINTK
> +extern void __printk_safe_enter(void);
> +extern void __printk_safe_exit(void);
> +/*
> + * The printk_deferred_enter/exit macros are available only as a hack for
> + * some code paths that need to defer all printk console printing. Interrupts
> + * must be disabled for the deferred duration.
> + */
> +#define printk_deferred_enter __printk_safe_enter
> +#define printk_deferred_exit __printk_safe_exit
> +#else
> +static inline void printk_deferred_enter(void)
> +{
> +}
> +static inline void printk_deferred_exit(void)
> +{
> +}
> +#endif
> +
>  #endif
> -- 
> 2.34.1
> 
> 

All now queued up, thanks.

greg k-h
