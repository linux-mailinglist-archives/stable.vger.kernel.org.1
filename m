Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473B57C98CA
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJOLV6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOLV6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 07:21:58 -0400
X-Greylist: delayed 1772 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 04:21:51 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B146DA
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=HqvLjp+xjsCGDhG6wgQ7WZ36jvTj8OtOsubSmVuvOyQ=; b=yZeEATys26zHLLdVMPwaLVq3Hh
        MEewVl5Yiigz+10k7gbqmJQSyf2/B1m2b29muI5mb5lwU+UWtV9fUffA326WxuG1SEQyFkYi+8RVk
        6TsF5LN3Np7JYCPNFS/n9LeYuytYx7SG+g73vbnqnFRW5T3F48OQeoiSCShvApbUg/NiQhbG5NAUP
        i1kBM9GFAmQjC1HJjxcLIPR+wDwkWCtUXbIkhQZ6k9DBIAQ7Bt89SMrJQCC4bVepXfcPAWf2VDf8L
        EV1XJt55y5JRYN6GpaUDLRhvMU71sPS2pxB5b36F0yxRgJNMH0P7P1XC5XcV7Hu/m92J2FXtzwlPZ
        u7K7D+eg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qryjI-003Y8P-N2; Sun, 15 Oct 2023 12:52:16 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.97-RC0)
        (envelope-from <aurelien@aurel32.net>)
        id 1qryjI-0000000CMcm-0t0q;
        Sun, 15 Oct 2023 12:52:16 +0200
Date:   Sun, 15 Oct 2023 12:52:16 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     stable@vger.kernel.org
Cc:     palmer@dabbelt.com, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH] riscv: signal: fix sigaltstack frame size checking
Message-ID: <ZSvEYJfg2HksQhaW@aurel32.net>
References: <20230822164904.21660-1-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822164904.21660-1-andy.chiu@sifive.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

The patch below is an important fix, as it is necessary to run rustc on riscv.
It has been merged as commit 14a270bfab7ab1c4b605c01eeca5557447ad5a2b. I have
seen that other commits from the same pull request have already been queued for
6.5, but not this one. Would it be possible to queue it for stable 6.5?

Thanks
Aurelien

On 2023-08-22 16:49, Andy Chiu wrote:
> The alternative stack checking in get_sigframe introduced by the Vector
> support is not needed and has a problem. It is not needed as we have
> already validate it at the beginning of the function if we are already
> on an altstack. If not, the size of an altstack is always validated at
> its allocation stage with sigaltstack_size_valid().
> 
> Besides, we must only regard the size of an altstack if the handler of a
> signal is registered with SA_ONSTACK. So, blindly checking overflow of
> an altstack if sas_ss_size not equals to zero will check against wrong
> signal handlers if only a subset of signals are registered with
> SA_ONSTACK.
> 
> Fixes: 8ee0b41898fa ("riscv: signal: Add sigcontext save/restore for vector")
> Reported-by: Prashanth Swaminathan <prashanthsw@google.com>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  arch/riscv/kernel/signal.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 180d951d3624..21a4d0e111bc 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -311,13 +311,6 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
>  	/* Align the stack frame. */
>  	sp &= ~0xfUL;
>  
> -	/*
> -	 * Fail if the size of the altstack is not large enough for the
> -	 * sigframe construction.
> -	 */
> -	if (current->sas_ss_size && sp < current->sas_ss_sp)
> -		return (void __user __force *)-1UL;
> -
>  	return (void __user *)sp;
>  }
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
