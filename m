Return-Path: <stable+bounces-66007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290894B81B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A9B288B7B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CC187FE7;
	Thu,  8 Aug 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6mAJzVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7947464;
	Thu,  8 Aug 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103079; cv=none; b=bduzUX5m5OJDYlvO2wpWM/0xAEEKfQBnMLumtrSwzHYNQfkBamfhLYZKWyAT30MDh7hhuCMFIB0oixrtxGXOiSvNvcxZeIC8Ow8ABiu4GrHXn5AVJpNubEVXv+EAKKLBVzFcPR0zMv86J1BHusmSsa1/P6Z8oBWGbEg8Sf/21G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103079; c=relaxed/simple;
	bh=VAvWFHxpcgWFSDTYhztSYMvkTVjjB54ETcFQOz7vJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amLEz+t5XM+GSHxZCFdgTBS76MBjRRagHvSj5TVgEAr6Hlr+nElFfAlah+kQ5dWolLVaipgoDL64tO18S7+mRoaoi7qgc2Qh9FtNHzMf3vHGMS4hQYTQu9b5K/gdL4IaqHbbWvODbJwqelZW/N6E+8a3DigBHS7xV9kCDNOhAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6mAJzVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F2AC32782;
	Thu,  8 Aug 2024 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723103078;
	bh=VAvWFHxpcgWFSDTYhztSYMvkTVjjB54ETcFQOz7vJoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6mAJzVPxwZOV506cetSEsRHLEaWzaC44Od7M1tvGTqdiNgMgw4J2N/iAYM2HaqA6
	 1Ktl95BzrstGB5UoNB1I7s7mZ/xX6/t32bG6RAMYoDKrfO3Fz96SjU82QDRV25h7Lt
	 kiVBQFXyDLPe85JtgOz+mvmVUlKvKS/PMUi2YUUY=
Date: Thu, 8 Aug 2024 09:44:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in
 uart_poll_init()
Message-ID: <2024080817-perm-resolved-34a0@gregkh>
References: <20240805102046.307511-1-jirislaby@kernel.org>
 <20240805102046.307511-4-jirislaby@kernel.org>
 <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
 <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
 <c4c01c01-e926-49fb-8704-90a69662254d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c01c01-e926-49fb-8704-90a69662254d@kernel.org>

On Thu, Aug 08, 2024 at 09:34:33AM +0200, Jiri Slaby wrote:
> On 05. 08. 24, 17:46, Doug Anderson wrote:
> > > > @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
> > > >                ret = uart_set_options(port, NULL, baud, parity, bits, flow);
> > > >                console_list_unlock();
> > > >        }
> > > > -out:
> > > > +
> > > >        if (ret)
> > > >                uart_change_pm(state, pm_state);
> > > > -     mutex_unlock(&tport->mutex);
> > > > +
> > > >        return ret;
> > > >   }
> > > 
> > > This too needs #include.
> > 
> > Why? I see in "mutex.h" (which is already included by serial_core.c):
> > 
> > DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> > 
> > ...so we're using the mutex guard and including the header file that
> > defines the mutex guard. Seems like it's all legit to me.
> 
> The patches got merged. But I can post a fix on top, of course. But, what is
> the consensus here -- include or not to include? I assume mutex.h includes
> cleanup.h already due to the above guard definition.

Leave it as-is, it's not breaking the build anywhere, so not a problem.

thanks,

greg k-h

