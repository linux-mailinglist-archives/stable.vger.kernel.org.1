Return-Path: <stable+bounces-35890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0FA898193
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 08:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81A61F22AC7
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684031A8F;
	Thu,  4 Apr 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNJL3Xxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A02C870
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212942; cv=none; b=BhioHXGvhbHUNTAfj7R/l3TLW8nWbVrLXwcGNA2cQjjMXV6sDnlN+GzmUbBWOKt169b2467JEkQzBvBJ6jyG8wwxs5S7dCTLDoxpJzT6CVDFUsDIDmaa148mBttsFlPF0GdrNsoWvJXqVKmMlgvmW9K3Bmqn+K/vF8tlH1aSQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212942; c=relaxed/simple;
	bh=a05YuGmpT2XURBFgMwx38Fklc10D5KQucvxp3nph/NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJwmIzO2XEPnPWi59igAKMRO7ygcsTBDpm5Pc42hg56hzQiIQFgTJAGv3QRJLAqLs6AyjgYjb5oOXgSPeU1etW5OuirjhL+74CPGy3hFgOQ35b1B4RQbGa7gY7FG4dRtaXYeCBUYfpNw7hPhBhub6QsM8baSN5xsmQ9ej48FrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SNJL3Xxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23390C433F1;
	Thu,  4 Apr 2024 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712212941;
	bh=a05YuGmpT2XURBFgMwx38Fklc10D5KQucvxp3nph/NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNJL3XxgMtYXlQUXmTgUCwsQqpy9Xa2oN5QnmcS4odKIh+cuUa5DCwrTNVVb5wu2t
	 SsNnDRGfZi8iUqbNuW/i/TGDU1fw+R2EjjotfoKrYRCzMLcBI6FI3jFgb88QSGz9PJ
	 L3GZihkW2Uh8fV88j49K9aRS7J/8M+ZSx13GIb0A=
Date: Thu, 4 Apr 2024 08:42:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "gpio: cdev: sanitize the label before requesting the
 interrupt" has been added to the 6.1-sta
Message-ID: <2024040401-resale-disregard-c9c5@gregkh>
References: <2024040339-anatomy-multitude-01a8gregkh>
 <af4781a8-b55b-4699-aa49-6245eb5accbc@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4781a8-b55b-4699-aa49-6245eb5accbc@hardfalcon.net>

On Thu, Apr 04, 2024 at 03:20:05AM +0200, Pascal Ernster wrote:
> [2024-04-03 19:58] gregkh linuxfoundation ! org:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      gpio: cdev: sanitize the label before requesting the interrupt
> > 
> > to the 6.1-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> >  From b34490879baa847d16fc529c8ea6e6d34f004b38 Mon Sep 17 00:00:00 2001
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Date: Mon, 25 Mar 2024 10:02:42 +0100
> > Subject: gpio: cdev: sanitize the label before requesting the interrupt
> > 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.
> > 
> > When an interrupt is requested, a procfs directory is created under
> > "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> > the request_irq() variants.
> > 
> > What follows is that the string must not contain the "/" character or
> > the procfs mkdir operation will fail. We don't have such constraints for
> > GPIO consumer labels which are used verbatim as interrupt labels for
> > GPIO irqs. We must therefore sanitize the consumer string before
> > requesting the interrupt.
> > 
> > Let's replace all "/" with ":".
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Wahren <wahrenst@gmx.net>
> > Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Kent Gibson <warthog618@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/gpio/gpiolib-cdev.c |   38 ++++++++++++++++++++++++++++++++------
> >   1 file changed, 32 insertions(+), 6 deletions(-)
> > 
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -999,10 +999,20 @@ static u32 gpio_v2_line_config_debounce_
> >   	return 0;
> >   }
> > +static inline char *make_irq_label(const char *orig)
> > +{
> > +	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> > +}
> > +
> > +static inline void free_irq_label(const char *label)
> > +{
> > +	kfree(label);
> > +}
> > +
> >   static void edge_detector_stop(struct line *line)
> >   {
> >   	if (line->irq) {
> > -		free_irq(line->irq, line);
> > +		free_irq_label(free_irq(line->irq, line));
> >   		line->irq = 0;
> >   	}
> > @@ -1027,6 +1037,7 @@ static int edge_detector_setup(struct li
> >   	unsigned long irqflags = 0;
> >   	u64 eflags;
> >   	int irq, ret;
> > +	char *label;
> >   	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
> >   	if (eflags && !kfifo_initialized(&line->req->events)) {
> > @@ -1063,11 +1074,17 @@ static int edge_detector_setup(struct li
> >   			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> >   	irqflags |= IRQF_ONESHOT;
> > +	label = make_irq_label(line->req->label);
> > +	if (!label)
> > +		return -ENOMEM;
> > +
> >   	/* Request a thread to read the events */
> >   	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
> > -				   irqflags, line->req->label, line);
> > -	if (ret)
> > +				   irqflags, label, line);
> > +	if (ret) {
> > +		free_irq_label(label);
> >   		return ret;
> > +	}
> >   	line->irq = irq;
> >   	return 0;
> > @@ -1910,7 +1927,7 @@ static ssize_t lineevent_read(struct fil
> >   static void lineevent_free(struct lineevent_state *le)
> >   {
> >   	if (le->irq)
> > -		free_irq(le->irq, le);
> > +		free_irq_label(free_irq(le->irq, le));
> >   	if (le->desc)
> >   		gpiod_free(le->desc);
> >   	kfree(le->label);
> > @@ -2058,6 +2075,7 @@ static int lineevent_create(struct gpio_
> >   	int fd;
> >   	int ret;
> >   	int irq, irqflags = 0;
> > +	char *label;
> >   	if (copy_from_user(&eventreq, ip, sizeof(eventreq)))
> >   		return -EFAULT;
> > @@ -2138,15 +2156,23 @@ static int lineevent_create(struct gpio_
> >   	INIT_KFIFO(le->events);
> >   	init_waitqueue_head(&le->wait);
> > +	label = make_irq_label(le->label);
> > +	if (!label) {
> > +		ret = -ENOMEM;
> > +		goto out_free_le;
> > +	}
> > +
> >   	/* Request a thread to read the events */
> >   	ret = request_threaded_irq(irq,
> >   				   lineevent_irq_handler,
> >   				   lineevent_irq_thread,
> >   				   irqflags,
> > -				   le->label,
> > +				   label,
> >   				   le);
> > -	if (ret)
> > +	if (ret) {
> > +		free_irq_label(label);
> >   		goto out_free_le;
> > +	}
> >   	le->irq = irq;
> > 
> > 
> > Patches currently in stable-queue which might be from bartosz.golaszewski@linaro.org are
> > 
> > queue-6.1/gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch
> 
> 
> Hi,
> 
> 
> this breaks the build because kstrdup_and_replace() does not exist in
> version branch 6.1.

Yes, my fault, I committed it and then walked away from the computer as
it was a long day.  I'll go fix it up now, thanks

greg k-h

