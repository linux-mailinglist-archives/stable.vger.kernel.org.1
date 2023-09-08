Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E6798234
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjIHGPW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 02:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjIHGPT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 02:15:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA21BF0
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 23:15:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB79C433C7;
        Fri,  8 Sep 2023 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694153709;
        bh=2Y5giuN+jQHI9iZI9e3vxs59+XG8zlkndBClLxBNl34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNgN/XW2joPTxbN/TgB8aqgxtWF+e2Ps0MD2wUMnK7gxtWgH6XHC2Zm2WQY+USm/J
         azJTO9gqgiHs81NKNO76HE9S+sG7P8jbgEmDQnkH7Vl6RTQowLktXCqICvL1p6moha
         oYzTGEbJ6tqP/tUp/DvxGgNpE6WNlvN4qLC6fu88=
Date:   Fri, 8 Sep 2023 07:15:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Denis Efremov (Oracle)" <efremov@linux.com>
Cc:     stable@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyttsp4_core - change del_timer_sync() to
 timer_shutdown_sync()
Message-ID: <2023090835-playroom-plastic-494c@gregkh>
References: <20230908014144.61151-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908014144.61151-1-efremov@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 08, 2023 at 05:41:35AM +0400, Denis Efremov (Oracle) wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
> 
> The watchdog_timer can schedule tx_timeout_task and watchdog_work
> can also arm watchdog_timer. The process is shown below:
> 
> ----------- timer schedules work ------------
> cyttsp4_watchdog_timer() //timer handler
>   schedule_work(&cd->watchdog_work)
> 
> ----------- work arms timer ------------
> cyttsp4_watchdog_work() //workqueue callback function
>   cyttsp4_start_wd_timer()
>     mod_timer(&cd->watchdog_timer, ...)
> 
> Although del_timer_sync() and cancel_work_sync() are called in
> cyttsp4_remove(), the timer and workqueue could still be rearmed.
> As a result, the possible use after free bugs could happen. The
> process is shown below:
> 
>   (cleanup routine)           |  (timer and workqueue routine)
> cyttsp4_remove()              | cyttsp4_watchdog_timer() //timer
>   cyttsp4_stop_wd_timer()     |   schedule_work()
>     del_timer_sync()          |
>                               | cyttsp4_watchdog_work() //worker
>                               |   cyttsp4_start_wd_timer()
>                               |     mod_timer()
>     cancel_work_sync()        |
>                               | cyttsp4_watchdog_timer() //timer
>                               |   schedule_work()
>     del_timer_sync()          |
>   kfree(cd) //FREE            |
>                               | cyttsp4_watchdog_work() // reschedule!
>                               |   cd-> //USE
> 
> This patch changes del_timer_sync() to timer_shutdown_sync(),
> which could prevent rearming of the timer from the workqueue.
> 
> Cc: stable@vger.kernel.org
> Fixes: CVE-2023-4134

"CVE" is not a valid Fixes tag :(

> Fixes: 17fb1563d69b ("Input: cyttsp4 - add core driver for Cypress TMA4XX touchscreen devices")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Link: https://lore.kernel.org/r/20230421082919.8471-1-duoming@zju.edu.cn
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
> ---
> 
> I've only added Cc: stable and Fixes tag.

What is the commit id in Linus's tree for this?

thanks,

greg k-h
