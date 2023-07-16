Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3191F7550FA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGPT33 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGPT32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA9199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E1860E08
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64928C433C7;
        Sun, 16 Jul 2023 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535766;
        bh=k3NXveZ3zb/HaBSmZe3dw4n2/FgE7j88Xtyl3J33r3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxCzwx8+zulj0mUAROkImAmkg2DT1emxrDbzxzdIX65FchsoFpUgknyeR3htrehYm
         xYCcUK9eK1pyQGa+0zy3JzOGbbWQY1bxvFVlFMTYfIMv2X02JiIQZkmstriM45yjsk
         d1ajv8d4ubnl3hcr6/Qq8Y0NEQm7OPfZ8ehmvnAQ=
Date:   Sun, 16 Jul 2023 21:29:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andres Freund <andres@anarazel.de>, asml.silence@gmail.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring
 wait" failed to apply to 6.1-stable tree
Message-ID: <2023071616-flatworm-emptier-bbd0@gregkh>
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <20230716191113.waiypudo6iqwsm56@awork3.anarazel.de>
 <46c1075b-0daf-14db-cf48-5a5105b996de@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c1075b-0daf-14db-cf48-5a5105b996de@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 01:19:31PM -0600, Jens Axboe wrote:
> On 7/16/23 1:11?PM, Andres Freund wrote:
> > Hi,
> > 
> > On 2023-07-16 12:13:45 -0600, Jens Axboe wrote:
> >> Here's one for 6.1-stable.
> > 
> > Thanks for working on that!
> > 
> > 
> >> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> >> index cc35aba1e495..de117d3424b2 100644
> >> --- a/io_uring/io_uring.c
> >> +++ b/io_uring/io_uring.c
> >> @@ -2346,7 +2346,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
> >>  					  struct io_wait_queue *iowq,
> >>  					  ktime_t *timeout)
> >>  {
> >> -	int ret;
> >> +	int token, ret;
> >>  	unsigned long check_cq;
> >>  
> >>  	/* make sure we run task_work before checking for signals */
> >> @@ -2362,9 +2362,18 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
> >>  		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
> >>  			return -EBADR;
> >>  	}
> >> +
> >> +	/*
> >> +	 * Use io_schedule_prepare/finish, so cpufreq can take into account
> >> +	 * that the task is waiting for IO - turns out to be important for low
> >> +	 * QD IO.
> >> +	 */
> >> +	token = io_schedule_prepare();
> >> +	ret = 0;
> >>  	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
> >> -		return -ETIME;
> >> -	return 1;
> >> +		ret = -ETIME;
> >> +	io_schedule_finish(token);
> >> +	return ret;
> >>  }
> > 
> > To me it looks like this might have changed more than intended? Previously
> > io_cqring_wait_schedule() returned 0 in case schedule_hrtimeout() returned
> > non-zero, now io_cqring_wait_schedule() returns 1 in that case?  Am I missing
> > something?
> 
> Ah shoot yes indeed. Greg, can you drop the 5.10/5.15/6.1 ones for now?
> I'll get it sorted tomorrow. Sorry about that, and thanks for catching
> that Andres!

Sure, will go drop it now, thanks.

greg k-h
