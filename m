Return-Path: <stable+bounces-169286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B1B23A54
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE0E3BBA31
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F62D5A10;
	Tue, 12 Aug 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=j-ernberg-se.20230601.gappssmtp.com header.i=@j-ernberg-se.20230601.gappssmtp.com header.b="XmX097A4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A942D0631
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032282; cv=none; b=e5wsYwqw7eaUksdFHC2lpVftiyKGhJf9Uctbz5mkOrQTSY21nfli0jDZ/8G1M1l2/2j58fgcNk9F6+81yqiMQztIYhg3U5IexjvMYl9m8aNhQQp5VT2YHsJ5ix20zneJJO9JK0cN1tmnwZYAYoaIeEwg9MDHN2/viBletd7zY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032282; c=relaxed/simple;
	bh=6Q4Oq/xbYw0awazOURcsOPsRowz4FU6cz3+FWT4ucTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEc2TWXanF8cgsTn2Idte44viTHU3uDvYRAFg1RBKnzwTO67K5NzQMMxNvOSekNIGuF0aAXD8gmlKG90lRA2fTI1w6WFxG4pF+MFVvqBFH7DmYGjlnmDorg6pWEoeTV2SrueLDQfdPOXSFGB0h2yLA8zjXrlw6g6v6v+LuCzZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=j-ernberg.se; spf=none smtp.mailfrom=j-ernberg.se; dkim=pass (2048-bit key) header.d=j-ernberg-se.20230601.gappssmtp.com header.i=@j-ernberg-se.20230601.gappssmtp.com header.b=XmX097A4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=j-ernberg.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=j-ernberg.se
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b88369530so6297064e87.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=j-ernberg-se.20230601.gappssmtp.com; s=20230601; t=1755032277; x=1755637077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1HYkWTm//0TzFaX3HirV9CEefr3/XfGLtwUTGZHPfw=;
        b=XmX097A4d4aVc/Gm/pMW5w7QcjfhJBwgREdg5Ti/XzhesoiDcPOgUqMyo1c5m/21Mf
         rP2g7nDZt1SaXpStcfjFV49zpLaBGIxXV4b3Ag6tueKayOSo/ye5ODThF8WWauv69MhY
         FpdcZpLez17cagD3kwFo77yFfwBmHlSKRWduqXGf2QdguEVGZjZ2/ZJ0vFNrVsUmZN38
         Cj04P64hya7wsM3VQHzetfGfumlQ9CvVvkqQJZJ4bsTC3kfcaxY1JzPrUYx1cfWPaFxW
         1wM+PuLZEvV0pDsJnt+GX587fxcOtks42wqnE4JkM2zFQCEgM5kpZk/8BNzG06nsBLpY
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755032277; x=1755637077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1HYkWTm//0TzFaX3HirV9CEefr3/XfGLtwUTGZHPfw=;
        b=fvJ8e2IwSM5f75QSY4cwQhwXD82dovMJ2CYOtRGclcRyHSeOL0FIXYm+llfJFvL79d
         cgS9QiX2Kp5sE3PQUvxSO8uEm9VY4mIeB2/yY+wAxv/9wfVSfYx7U7dEyxmJraVqQFYl
         9WSgjef9chFaFCMOk0DqBwaZoCsvCvxurKio/ATOoZHN2IsIp49nmu8ABCfIwuY3ZA33
         e3d+OAJ3c7cdF/oQw26Rq85CahoRf5MXcojmdwgZDMXHmNWdW0OIkUtbbSYs5qpPJgRd
         GbBMN2rw/C9VQy2pb0FBICrBLXyA6c3p8o/aseQjS2D8yGqOG7/MbCsRDhX/RK76myls
         Zheg==
X-Forwarded-Encrypted: i=1; AJvYcCXlt+9gob6wP78ciKeqHdjtjgVepOl3X5aF5SMfXQVHQpmnnXur4So4lHfiOb36mosvrFqTGn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2iYNWINyiiU5zKidngJo8/l6VK6Vjr9JIQC75mfW3Gt9fp+l
	LJ3HrZUdywq6G/Mf4ZERDInZVrEnVbGoWyDYP6RTIUTK7tcuYGLcZpB8VBDdEimuWAs=
X-Gm-Gg: ASbGncu2ve4VEeRqf5Od7lMwZWcbFau9TLKuRNEXeghqwVcYbGUwBs5yFUggMR4t4gb
	W71FcRZBJqX/52hgnGEfJEc/vZdGb1QndMz2dF8dhk6dDPIebqbMNP6GEgiR+rNQK9kjOjy0FA6
	DVEdlw4QLzlmxRqSH2XrlRMn20vN6d9uSpqLD8lYuS+BQRNuClrT6VQPSIxqjd2MKrHWilzJRC7
	8o3xlSxphlBCfAhHau0ArYBZMi0PbnTnRObiNLeHU0zqzZ46STmRdnZ3Wo6qxRKQ9oGRpYBl5yN
	5tpWQ23yqYMicw4jz6X3FdQRoBf8LspIGiZrJu+9Mo2CNytgsAZ6qLQdmUGZGwaReRqx37K4o3w
	hzLs8VRgSTyE8LVybGP+BJI/VewlTdBgzQ+L+b+t2W8QFvGgx/A==
X-Google-Smtp-Source: AGHT+IGffUI/1EXOSK/t0KV6xGplfLMgAAk2k7PICLXaMIAixPTAVPj1NMw1SVef+Ih1sVF86CbZxw==
X-Received: by 2002:a05:6512:b12:b0:55a:4f05:6e4c with SMTP id 2adb3069b0e04-55ce0404609mr162441e87.49.1755032276914;
        Tue, 12 Aug 2025 13:57:56 -0700 (PDT)
Received: from localhost (90-231-233-65-no2360.tbcn.telia.com. [90.231.233.65])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88c990f1sm4946123e87.82.2025.08.12.13.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 13:57:56 -0700 (PDT)
Date: Tue, 12 Aug 2025 22:57:55 +0200
From: John Ernberg <j@j-ernberg.se>
To: Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <aJuq00V5BD8OHGxF@nucleus>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
 <20250805164747.40e63f6d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805164747.40e63f6d@kernel.org>

Hi Jakub, Linus, Ammar,

(sorry for the delay, on vacation, wasn't paying attention to the internet)

On Tue, Aug 05, 2025 at 04:47:47PM -0700, Jakub Kicinski wrote:
> On Wed, 6 Aug 2025 01:40:37 +0300 Linus Torvalds wrote:
> > So my gut feel is that the
> > 
> >                 if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> >                         netif_carrier_on(dev->net);
> > 
> > should actually be done outside that if-statement entirely, because it
> > literally ends up changing the thing that if-statement is testing.
> 
> Right. I think it should be before the if (!netif_carrier_ok(dev->net))
> 
> Ammar, could you retest and repost that, since we haven't heard from
> John?

I can't verify the suggested change until sometime in September, after I
return to office, but it feels correct.

However... I'm almost inclined to suggest a full revert of my patch as
the testing was clearly royally botched. Booting it on the boards I
have would have shown the failure immediately.

(I did see v3 of this patch being applied)

Apologies for the mess // John Ernberg

