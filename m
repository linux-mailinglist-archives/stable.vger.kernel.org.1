Return-Path: <stable+bounces-78349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B288C98B7F3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35EA1C2293F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE919CD1E;
	Tue,  1 Oct 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDM+tPEp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E919B587;
	Tue,  1 Oct 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773728; cv=none; b=oCov0LBPyg7XLFAqR7L+qA4qwqayEh+/toSbOmHGMhzAShyqNfQjRJkw/YAquhNca782n9VGxLXYkVWG6JN7dTuXeac0jI0g7TxYefeX9KIzbuYcnP7TJ233GYx+F5TOWQEVk1ZYznE1Mbvce7xDVZbS6A47NhySnJNmXVn5kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773728; c=relaxed/simple;
	bh=mRFmKg5nHs0DeMlEf3MLqntnuUHeWdIyo2L80XYY410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez1Iqw/uOkP6X/FkFJRA3ztGo9QVhihGEezQrTX4TOs2RhrGBJvfC2wlw+X1m0GL8jxO/dDGCx7iqSJk7OD6YxH6eoMAZwrQJ8uiynImsM7RsB+JaE/2GXzSGKkW5+3LrRBUqnXpN82kEFV/MnQPkVcE7uRFEyzL9Cfgd1o3iuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDM+tPEp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b1335e4e4so48160105ad.0;
        Tue, 01 Oct 2024 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727773725; x=1728378525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLWN/H7bQ56kuh5OSaul9NzT2+S1VabXLFzgkEUuO0Q=;
        b=SDM+tPEpgOGUc/WQ9xhH1v0UlzUpJbtGlwhF7Rt0QS+gPm0fat0TpH4J2sUpNMj05n
         J9c2HK0OcFEPnTrLI9Kx/lPhlk+ltSQXu6zQ9aAdh27xzLsQWfJXX6klwPyg7Q+A8msv
         l5RuLmZ23ER3mR25DeVVN4a+N5KrvC9lHx3hUuyBAq1I1iIS/k6uw5gkLpmbSph7vBuT
         VYc199YlG3N/+sYqzbM+/6RX0niH9O22IbY551PawobZj1wbMvOWk8on0VUcrSh6uYpr
         T9fVP1akkzVFvBBgXI9RNchWV+rUiWI4c9AGbP7ImOINCU5j3oAmIDwtwlaMSCXpXhLu
         9Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773725; x=1728378525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLWN/H7bQ56kuh5OSaul9NzT2+S1VabXLFzgkEUuO0Q=;
        b=py2ukBTkuhruz56nhz302fkq0/skbjkv5GEzjQy3zsxJdlvnxPJdPY6G1if7dcffah
         pnLOVsmquo81oVkdNhz23ol409jRb4mzxp001SH5Bc7DRTgxkEFYb+8e2OtBERCVsYck
         trmBlRnmr5mc1q3n0P1pDnGt8ue2za8uEAC5eit+JE6X02OSJfaK4MKxuRDDMrEhv9Z3
         snL9LcI9O2oh94svxRHN9LQGTf4Nscxpy0q69SjyZDcn5zBwmB/zDb1giDQzsP66o3H8
         r1OBmRz9kTHui3WDMwdzihrV4Ze0Rb+AIDWi/xogZfre5Vh+h1OeIo6R0MApxsfFReK5
         Xz+A==
X-Gm-Message-State: AOJu0YyHiLeUCw11RcAXJ+yg15wm5PkWe9t9jSxqvMeexJ5GVobXahY2
	QrC/ysdX33ECVnI6PFU0QsaOzSZKdinTnptQjK2BwTfTsHQiRk9Q/Qo5kEAVsZ4=
X-Google-Smtp-Source: AGHT+IGPh4OYvrUklc0B61EMDCd+FTCQMoVNN3ccrb9gh8Xt3dxwfoUoTbOCFoZdn25Knwqcv9KLtA==
X-Received: by 2002:a17:902:d2c3:b0:20b:9c9c:6eec with SMTP id d9443c01a7336-20b9c9c71e0mr59583145ad.10.1727773725159;
        Tue, 01 Oct 2024 02:08:45 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e1b7c9sm65970775ad.151.2024.10.01.02.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:08:44 -0700 (PDT)
Date: Tue, 1 Oct 2024 02:08:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <Zvu8GiY4PxqTQPD0@google.com>
References: <20241001002900.2628013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001002900.2628013-1-sashal@kernel.org>

On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

For the love of God, why? Why does this pure cleanup type of change
needs to be in stable?

> 
> 
> 
> commit 2d007ddec282076923c4d84d6b12858b9f44594a
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> Date:   Thu Sep 12 11:30:13 2024 +0800
> 
>     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
>     
>     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
>     
>     disable_irq() after request_irq() still has a time gap in which
>     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
>     disable IRQ auto-enable when request IRQ.
>     
>     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")
>     Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>     Acked-by: Danilo Krummrich <dakr@kernel.org>
>     Link: https://lore.kernel.org/r/20240912033013.2610949-1-ruanjinjie@huawei.com
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
> index 8970b49ea09a2..b0238a8b5c210 100644
> --- a/drivers/input/serio/ps2-gpio.c
> +++ b/drivers/input/serio/ps2-gpio.c
> @@ -374,16 +374,14 @@ static int ps2_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	error = devm_request_irq(dev, drvdata->irq, ps2_gpio_irq,
> -				 IRQF_NO_THREAD, DRIVER_NAME, drvdata);
> +				 IRQF_NO_THREAD | IRQF_NO_AUTOEN, DRIVER_NAME,
> +				 drvdata);
>  	if (error) {
>  		dev_err(dev, "failed to request irq %d: %d\n",
>  			drvdata->irq, error);
>  		goto err_free_serio;
>  	}
>  
> -	/* Keep irq disabled until serio->open is called. */
> -	disable_irq(drvdata->irq);
> -
>  	serio->id.type = SERIO_8042;
>  	serio->open = ps2_gpio_open;
>  	serio->close = ps2_gpio_close;

-- 
Dmitry

