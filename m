Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C7789C06
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjH0IEv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjH0IEd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B5812E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB9260B34
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F508C433C8;
        Sun, 27 Aug 2023 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693123469;
        bh=msoldE/EM8IhgzkHqR+P3hH+vTRffVC7M0jKIkCt7cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3pK00SU2bjaCoos3tuqjwOb6NzvF04MUco0Z2pDYTMstBfN9tufMKWwc7oVx+PW5
         ha4H2+jHGpiYNoOtGFQIVWzrDuPIpbfIgThvF2dBAJV/TLYqXIsS1gxSjWIZIxkBty
         xPrj8CYQ4QMsYKGW1M7aRugwh9Smuk8CmPsFyHmY=
Date:   Sun, 27 Aug 2023 10:04:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5.10 1/3] torture: Fix hang during kthread shutdown phase
Message-ID: <2023082704-removed-rectified-8501@gregkh>
References: <20230814033934.1165010-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814033934.1165010-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 03:39:31AM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
> [ Upstream commit d52d3a2bf408ff86f3a79560b5cce80efb340239 ]

> During shutdown of rcutorture, the shutdown thread in
> rcu_torture_cleanup() calls torture_cleanup_begin() which sets fullstop
> to FULLSTOP_RMMOD. This is enough to cause the rcutorture threads for
> readers and fakewriters to breakout of their main while loop and start
> shutting down.
> 
> Once out of their main loop, they then call torture_kthread_stopping()
> which in turn waits for kthread_stop() to be called, however
> rcu_torture_cleanup() has not even called kthread_stop() on those
> threads yet, it does that a bit later.  However, before it gets a chance
> to do so, torture_kthread_stopping() calls
> schedule_timeout_interruptible(1) in a tight loop. Tracing confirmed
> this makes the timer softirq constantly execute timer callbacks, while
> never returning back to the softirq exit path and is essentially "locked
> up" because of that. If the softirq preempts the shutdown thread,
> kthread_stop() may never be called.
> 
> This commit improves the situation dramatically, by increasing timeout
> passed to schedule_timeout_interruptible() 1/20th of a second. This
> causes the timer softirq to not lock up a CPU and everything works fine.
> Testing has shown 100 runs of TREE07 passing reliably, which was not the
> case before because of RCU stalls.
> 
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Cc: <stable@vger.kernel.org> # 6.0.x
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  kernel/torture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 1061492f14bd..477d9b601438 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -788,7 +788,7 @@ void torture_kthread_stopping(char *title)
>  	VERBOSE_TOROUT_STRING(buf);
>  	while (!kthread_should_stop()) {
>  		torture_shutdown_absorb(title);
> -		schedule_timeout_uninterruptible(1);
> +		schedule_timeout_uninterruptible(HZ/20);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(torture_kthread_stopping);
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

All now queued up, thanks.

greg k-h
