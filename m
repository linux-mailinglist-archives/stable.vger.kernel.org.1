Return-Path: <stable+bounces-118506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75309A3E513
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B387421EE7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927B2641E3;
	Thu, 20 Feb 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaHRufLS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF92116F6
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079897; cv=none; b=qg8YlmLwZO6iLyS/Pfrl1DiQakUKj9n5T/r65uRQXHDE1JAT5KJgRqqZstYxD2P5FLSdXV4z1S88Cw7R5jHeglUQW/tLSp7B91FbcnaWqGfPKj3NqWqFLrX+APk+CRH/mU+P+D6eRoOgHRrLHXirsJzosWqHYSKqk2N2lmmgkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079897; c=relaxed/simple;
	bh=MVq0rSd2W/rQ4EG/nAQY+fo+iAlMg/MrYiWZeK0fCbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NspO7jNXqr5W/2pDRnpst4YqhEdSk0h+AjEu5J/kC3swqpqAuyy1WFkONx4xXiM+ingXeqYSop9oMRhnhkvWZcvjFMThAfpdGvpR+RuGT27O65NACuOvWH4pUO+NMN7cpHpZd/b7y/Qvvtf7q5J+HstgFFDHtI3yyFJ4M7EUPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaHRufLS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22114b800f7so25532645ad.2
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740079894; x=1740684694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNqMwP45iYYk0uj0DcAs+5VuYjHL2HKpybnKvS9Q0Q8=;
        b=IaHRufLSvQZngqQVwGbV25xIjHyZZLiFvtUFLBLJadlw9vGU6dZydzT+myueiN4GJt
         8woU0VnpwUs2vAQOM8QUB5XTC6Nahh1rbiWia12oKzDVG3jzeJ4N80pAL7kOgR4CA1dl
         +3fJNxWtmpkPG/cMcguZCKfwATQNiqCJ9KueVF45xt9WyzTqeSxOBAz0ulKDAsl2tuKq
         pfCW3N6X8B9lgWss4+buWuOT61r7j4I0XIwKPANQ5ylyJRq7iZtX50+5jfYUGj8LxkGI
         HDV1e7ZPt8n1hEVXNiBJuQsXqs1uTbUQk+vryHy3zk5R6J2iAk1GSPbUYetNL7O5dfXy
         boag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079894; x=1740684694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNqMwP45iYYk0uj0DcAs+5VuYjHL2HKpybnKvS9Q0Q8=;
        b=VeJMQx9KZ+/3qDqRzjXUb0dqsLuso6ov4t1npGhB4F5QeX+uhN8uyC/7WbdI0uFG89
         5m9phoIIvoyJuFSw2AoaoYZ+ilMQaDvcX596tu0i2jaAnVXpZMIrkoKrqKVLsN4ygnsz
         w8ONVbiTaRRut9gh5lHNuuLkH4XEDpkMZ2edh07wUcfPCdI/PDoGnONq2YcWVeYTrF8F
         sXuoSUtsJRXZjiXxReowBcxIY4HrVb+DUp9KmTVPYwjB/74+gZdpNyBpjs2fdXNJwSvy
         oPu55sBwGOEXvQZm8Jo6aUgAm7ABk5SB9eOMmaCSCsU/O70HBU6RB7JaxGv/0fvHpEqT
         UxXg==
X-Forwarded-Encrypted: i=1; AJvYcCVwQnpE5N4GWv5Z8JntyayVV+S0HwFmrJEStKL/VRI3L2v64cjIOVBXzD3RWix0Vw5Ic4tHOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPoJl/McQxlFH9+vGhFSi8ZH73epPznA3fvbvvfEyzV2Xuzau
	9IAVoqBaJ6XEqytl16hASLuuF1iqsk7+i8688IRiacPHalo/vAO6kjRYs3ymdA==
X-Gm-Gg: ASbGnctZlo+NNnw4VxPeev1tbbjxXlAplLCaBWlFLpS1kzdcZIOVuIkC0RKSJ2BJ7os
	/9yK8ewd6bMoJx5Ijbjay/U18oFM6BnUlD0yocyC5QoHwhnJ1QKlqsKjJnY1m54e5zhuW9VTola
	p2rS6EsprfBBXQN+sfB7jxUegmyKfHAkk+sVpz9v/awkA1Y22fRHDoTL9AROeXfRnGh0De2BlpE
	xJacAmZ3bgjzO9k+uRDpAX8/Muhj9HT9Ho6TsNUXkBXs5Q1pOHbfLTbQcPlotv09TryBSj+pRJt
	l/2icfRfUNw6FM5Ex41LyLHj2ouuZ3k4PQWhIDE08RrYA9VWuhGlLeDo
X-Google-Smtp-Source: AGHT+IGm0mMkDx5+higAvQTvJgGM6Q5QWoVBcT94T2De4H3OUSImBFKF4r5go8AQeAfrxEm5a+S3bw==
X-Received: by 2002:a17:903:230f:b0:216:4883:fb43 with SMTP id d9443c01a7336-2219ffd2718mr6024575ad.32.1740079892529;
        Thu, 20 Feb 2025 11:31:32 -0800 (PST)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba5f27sm14323197a91.43.2025.02.20.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:31:31 -0800 (PST)
Date: Thu, 20 Feb 2025 11:31:27 -0800
From: William McVicker <willmcvicker@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prashanth K <prashanth.k@oss.qualcomm.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
Message-ID: <Z7eDD1PsBYVIYWMY@google.com>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
 <Z7dv4rEILkC9yRwX@google.com>
 <2025022032-cruelness-framing-2a10@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022032-cruelness-framing-2a10@gregkh>

On 02/20/2025, Greg Kroah-Hartman wrote:
> On Thu, Feb 20, 2025 at 10:09:38AM -0800, William McVicker wrote:
> > Hi Prashanth,
> > 
> > On 02/17/2025, Prashanth K wrote:
> > > Currently the USB gadget will be set as bus-powered based solely
> > > on whether its bMaxPower is greater than 100mA, but this may miss
> > > devices that may legitimately draw less than 100mA but still want
> > > to report as bus-powered. Similarly during suspend & resume, USB
> > > gadget is incorrectly marked as bus/self powered without checking
> > > the bmAttributes field. Fix these by configuring the USB gadget
> > > as self or bus powered based on bmAttributes, and explicitly set
> > > it as bus-powered if it draws more than 100mA.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> > > Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> > > ---
> > > Changes in v2:
> > > - Didn't change anything from RFC.
> > > - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/
> > > 
> > >  drivers/usb/gadget/composite.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > > index bdda8c74602d..1fb28bbf6c45 100644
> > > --- a/drivers/usb/gadget/composite.c
> > > +++ b/drivers/usb/gadget/composite.c
> > > @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
> > >  	else
> > >  		usb_gadget_set_remote_wakeup(gadget, 0);
> > >  done:
> > > -	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
> > > -		usb_gadget_set_selfpowered(gadget);
> > > -	else
> > > +	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> > > +	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> > >  		usb_gadget_clear_selfpowered(gadget);
> > > +	else
> > > +		usb_gadget_set_selfpowered(gadget);
> > >  
> > >  	usb_gadget_vbus_draw(gadget, power);
> > >  	if (result >= 0 && cdev->delayed_status)
> > > @@ -2615,7 +2616,9 @@ void composite_suspend(struct usb_gadget *gadget)
> > >  
> > >  	cdev->suspended = 1;
> > >  
> > > -	usb_gadget_set_selfpowered(gadget);
> > > +	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
> > > +		usb_gadget_set_selfpowered(gadget);
> > 
> > I'm hitting a null pointer derefence here on my Pixel 6 device on suspend.  I
> > haven't dug deep into it how we get here, but in my case `cdev->config` is
> > NULL. This happens immediate after booting my device. I verified that just
> > adding a NULL check fixes the issue and dwc3 gadget can successfully suspend.
> 
> This was just fixed in my tree today with this commit:
> 	https://lore.kernel.org/r/20250220120314.3614330-1-m.szyprowski@samsung.com
> 
> Hope this helps,
> 
> greg k-h

Yup, works for me. Thanks!

--Will

