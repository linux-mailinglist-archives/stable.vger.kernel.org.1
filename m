Return-Path: <stable+bounces-35883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4B897D64
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9631C21BB9
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9358F48;
	Thu,  4 Apr 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="H/kDrtog"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F48C06
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712194137; cv=none; b=ELNOTWK8/N3clMywgMAwdCsGw3ForNrGZNKC3uFVCOnVkyC3EKn+I50cJyKcbBQUxT2wEvOnqt9OiU23EQeLQEjcm24au+73jvU/vVk0MyOoXViGHMjB4xJCFcqJ0sb2EmWb08Q8tGsuIrJJTTx2tMYUCNdXA+7EH+782jYfR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712194137; c=relaxed/simple;
	bh=WxWNh+sc4v9QZUU1EDHH1IL8hDn08GVaO5J5rAmEk/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q9v72chLiEeJE+CDeRW7YxDzM2bR4c0Aolj8E6fuXDAkG3YTV4iR55R/7aJJu0ChuXiDLKopfeXRVQZRDIzyI/fxiwecaDSt3Xm3s4POIEc/j69qhTQAU5YXRmPV0Y7rAhC5dOrKEDiJcwpYlzuT6urWMm0rXYvNZKWXyjJh8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=H/kDrtog; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1712193607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaIurQnn68e9LF+oXUqMpsCRQHBW2H0fFRuDzAYJGsA=;
	b=H/kDrtogdWyz9aMMUWY5mLVvHg8Qc/3nkrVg+phFXQFVHAFkMPe3jD6nljIYJZY+imrbr8
	YK3ByT9plAQwBWBA==
Message-ID: <af4781a8-b55b-4699-aa49-6245eb5accbc@hardfalcon.net>
Date: Thu, 4 Apr 2024 03:20:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "gpio: cdev: sanitize the label before requesting the
 interrupt" has been added to the 6.1-sta
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024040339-anatomy-multitude-01a8 () gregkh>
Content-Language: en-US
Cc: Sasha Levin <sashal@kernel.org>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <2024040339-anatomy-multitude-01a8 () gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-04-03 19:58] gregkh linuxfoundation ! org:
> This is a note to let you know that I've just added the patch titled
> 
>      gpio: cdev: sanitize the label before requesting the interrupt
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
>  From b34490879baa847d16fc529c8ea6e6d34f004b38 Mon Sep 17 00:00:00 2001
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Date: Mon, 25 Mar 2024 10:02:42 +0100
> Subject: gpio: cdev: sanitize the label before requesting the interrupt
> 
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.
> 
> When an interrupt is requested, a procfs directory is created under
> "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> the request_irq() variants.
> 
> What follows is that the string must not contain the "/" character or
> the procfs mkdir operation will fail. We don't have such constraints for
> GPIO consumer labels which are used verbatim as interrupt labels for
> GPIO irqs. We must therefore sanitize the consumer string before
> requesting the interrupt.
> 
> Let's replace all "/" with ":".
> 
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/gpio/gpiolib-cdev.c |   38 ++++++++++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 6 deletions(-)
> 
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -999,10 +999,20 @@ static u32 gpio_v2_line_config_debounce_
>   	return 0;
>   }
>   
> +static inline char *make_irq_label(const char *orig)
> +{
> +	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +}
> +
> +static inline void free_irq_label(const char *label)
> +{
> +	kfree(label);
> +}
> +
>   static void edge_detector_stop(struct line *line)
>   {
>   	if (line->irq) {
> -		free_irq(line->irq, line);
> +		free_irq_label(free_irq(line->irq, line));
>   		line->irq = 0;
>   	}
>   
> @@ -1027,6 +1037,7 @@ static int edge_detector_setup(struct li
>   	unsigned long irqflags = 0;
>   	u64 eflags;
>   	int irq, ret;
> +	char *label;
>   
>   	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
>   	if (eflags && !kfifo_initialized(&line->req->events)) {
> @@ -1063,11 +1074,17 @@ static int edge_detector_setup(struct li
>   			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>   	irqflags |= IRQF_ONESHOT;
>   
> +	label = make_irq_label(line->req->label);
> +	if (!label)
> +		return -ENOMEM;
> +
>   	/* Request a thread to read the events */
>   	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
> -				   irqflags, line->req->label, line);
> -	if (ret)
> +				   irqflags, label, line);
> +	if (ret) {
> +		free_irq_label(label);
>   		return ret;
> +	}
>   
>   	line->irq = irq;
>   	return 0;
> @@ -1910,7 +1927,7 @@ static ssize_t lineevent_read(struct fil
>   static void lineevent_free(struct lineevent_state *le)
>   {
>   	if (le->irq)
> -		free_irq(le->irq, le);
> +		free_irq_label(free_irq(le->irq, le));
>   	if (le->desc)
>   		gpiod_free(le->desc);
>   	kfree(le->label);
> @@ -2058,6 +2075,7 @@ static int lineevent_create(struct gpio_
>   	int fd;
>   	int ret;
>   	int irq, irqflags = 0;
> +	char *label;
>   
>   	if (copy_from_user(&eventreq, ip, sizeof(eventreq)))
>   		return -EFAULT;
> @@ -2138,15 +2156,23 @@ static int lineevent_create(struct gpio_
>   	INIT_KFIFO(le->events);
>   	init_waitqueue_head(&le->wait);
>   
> +	label = make_irq_label(le->label);
> +	if (!label) {
> +		ret = -ENOMEM;
> +		goto out_free_le;
> +	}
> +
>   	/* Request a thread to read the events */
>   	ret = request_threaded_irq(irq,
>   				   lineevent_irq_handler,
>   				   lineevent_irq_thread,
>   				   irqflags,
> -				   le->label,
> +				   label,
>   				   le);
> -	if (ret)
> +	if (ret) {
> +		free_irq_label(label);
>   		goto out_free_le;
> +	}
>   
>   	le->irq = irq;
>   
> 
> 
> Patches currently in stable-queue which might be from bartosz.golaszewski@linaro.org are
> 
> queue-6.1/gpio-cdev-sanitize-the-label-before-requesting-the-interrupt.patch


Hi,


this breaks the build because kstrdup_and_replace() does not exist in 
version branch 6.1.


Regards
Pascal

