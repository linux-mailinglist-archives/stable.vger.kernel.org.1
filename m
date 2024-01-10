Return-Path: <stable+bounces-10038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7182721F
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123FA1F22CCA
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB4487A7;
	Mon,  8 Jan 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rk7qSS+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735A4C3A9;
	Mon,  8 Jan 2024 15:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6DC433C7;
	Mon,  8 Jan 2024 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726516;
	bh=02L8hpTjzezo9Oz2cpR3Buql9cPDka1bFiHwuFfTdAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk7qSS+HxmB6iqsTnnAJcQaGYEISchJu7IIZcKNCNb75azOlMMOk2gi6FOrqU/RK3
	 12uwYQx1/AsYooiYBvBJ3nYydm51lXOxFQO1xphBlE6BWZ9HTE3v1XMUJjaUhU5Ewt
	 RIpOwHJRVuxn7DWR9F8RvIyNlVpAih9khjpku3dM=
Date: Mon, 8 Jan 2024 16:08:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.4 062/165] net: usb: lan78xx: reorder cleanup
 operations to avoid UAF bugs
Message-ID: <2024010807-fantasy-species-3607@gregkh>
References: <20230809103642.720851262@linuxfoundation.org>
 <20230809103644.851543936@linuxfoundation.org>
 <20240108145224.GA641998@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108145224.GA641998@google.com>

On Mon, Jan 08, 2024 at 02:52:24PM +0000, Lee Jones wrote:
> On Wed, 09 Aug 2023, Greg Kroah-Hartman wrote:
> 
> > From: Duoming Zhou <duoming@zju.edu.cn>
> > 
> > [ Upstream commit 1e7417c188d0a83fb385ba2dbe35fd2563f2b6f3 ]
> > 
> > The timer dev->stat_monitor can schedule the delayed work dev->wq and
> > the delayed work dev->wq can also arm the dev->stat_monitor timer.
> > 
> > When the device is detaching, the net_device will be deallocated. but
> > the net_device private data could still be dereferenced in delayed work
> > or timer handler. As a result, the UAF bugs will happen.
> > 
> > One racy situation is shown below:
> > 
> >       (Thread 1)                 |      (Thread 2)
> > lan78xx_stat_monitor()           |
> >  ...                             |  lan78xx_disconnect()
> >  lan78xx_defer_kevent()          |    ...
> >   ...                            |    cancel_delayed_work_sync(&dev->wq);
> >   schedule_delayed_work()        |    ...
> >   (wait some time)               |    free_netdev(net); //free net_device
> >   lan78xx_delayedwork()          |
> >   //use net_device private data  |
> >   dev-> //use                    |
> > 
> > Although we use cancel_delayed_work_sync() to cancel the delayed work
> > in lan78xx_disconnect(), it could still be scheduled in timer handler
> > lan78xx_stat_monitor().
> > 
> > Another racy situation is shown below:
> > 
> >       (Thread 1)                |      (Thread 2)
> > lan78xx_delayedwork             |
> >  mod_timer()                    |  lan78xx_disconnect()
> >                                 |   cancel_delayed_work_sync()
> >  (wait some time)               |   if (timer_pending(&dev->stat_monitor))
> >              	                |       del_timer_sync(&dev->stat_monitor);
> >  lan78xx_stat_monitor()         |   ...
> >   lan78xx_defer_kevent()        |   free_netdev(net); //free
> >    //use net_device private data|
> >    dev-> //use                  |
> > 
> > Although we use del_timer_sync() to delete the timer, the function
> > timer_pending() returns 0 when the timer is activated. As a result,
> > the del_timer_sync() will not be executed and the timer could be
> > re-armed.
> > 
> > In order to mitigate this bug, We use timer_shutdown_sync() to shutdown
> > the timer and then use cancel_delayed_work_sync() to cancel the delayed
> > work. As a result, the net_device could be deallocated safely.
> > 
> > What's more, the dev->flags is set to EVENT_DEV_DISCONNECT in
> > lan78xx_disconnect(). But it could still be set to EVENT_STAT_UPDATE
> > in lan78xx_stat_monitor(). So this patch put the set_bit() behind
> > timer_shutdown_sync().
> > 
> > Fixes: 77dfff5bb7e2 ("lan78xx: Fix race condition in disconnect handling")
> 
> Any idea why this stopped at linux-6.4.y?  The aforementioned Fixes:
> commit also exists in linux-6.1.y and linux-5.15.y.  I don't see any
> earlier backport attempts or failure reports that would otherwise
> explain this.

Did you try to build it:

	drivers/net/usb/lan78xx.c: In function ‘lan78xx_disconnect’:
	drivers/net/usb/lan78xx.c:4234:9: error: implicit declaration of function ‘timer_shutdown_sync’ [-Werror=implicit-function-declaration]
	 4234 |         timer_shutdown_sync(&dev->stat_monitor);
	      |         ^~~~~~~~~~~~~~~~~~~
	cc1: all warnings being treated as errors

That's a good reason to not include it...

Also, is it really an issue or just showing up on a CVE-checker
somewhere?  (odds on the latter, based on the author of this commit...)

If anyone really cares about it, I figured they would submit a working
patch :)

thanks,

greg k-h

