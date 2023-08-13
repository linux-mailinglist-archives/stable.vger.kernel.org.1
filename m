Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F077AA16
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHMQem (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjHMQe3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 12:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B329B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 09:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A4660E09
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 16:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF194C433C7;
        Sun, 13 Aug 2023 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691944470;
        bh=6VQsg8amGdzxg0k8xaQXgYi2CJnMQ7ZZeNOSh6cM1Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r181lDbXAjKfXJajWOpmnEiYhVGBxogoXC7V4Gm5kCqIS5R9D6FTodWQM4zVL74c0
         YtwD9WtSWLd8BmPsF21b2USsJq+LhjLrb17aYn7JNuN2tGQPiMLfJIAGUTqyuUkX87
         vIGmbbaxU6Rb5gWkXCgfAM0jifhAHocKI8cxwtkE=
Date:   Sun, 13 Aug 2023 18:34:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5.10 1/3] torture: Fix hang during kthread shutdown phase
Message-ID: <2023081349-widely-trousers-4ef1@gregkh>
References: <20230813031536.2166337-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813031536.2166337-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 03:15:34AM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
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

Any hint as to what the git commit id in Linus's tree for this, and the
other patches you just sent, are?  I kind of need that to keep track of
things...

thanks,

greg k-h
