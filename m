Return-Path: <stable+bounces-61785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F293C84C
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2821F21EB9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F429414;
	Thu, 25 Jul 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="joz9LKTP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC52210FB
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931811; cv=none; b=UHN07dRHQYk9GBax0BTJkUNQI2QtUcZ36PHYKDPY9kHVV4YRFcEP0L1rJEZ+Jcla8hTm6hjocm2QC9thkyf/0NoZrQF34mvj0bCSajCE+QU+kd6Pv6Mt+p4Y5HiZg1T8RsBbed6aRGALl4l3yJ25yCmlB7UB9J53mkaNjG/xwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931811; c=relaxed/simple;
	bh=EgEtuaM1w9SIxRjRrGQqJpo1WaJB9BUCujCEJzAr99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC7FcOKCrallm11a5N/T841STvYJ2QHbCR019zbNXg53NWCZZOosrF3PnLcGO5UGFhgnqyRJpjmh6sKt1I0VSrY50hW61y7ABzozhLX2WjQNJfHLBk7P5GUNnjDkvx2TRC7wrFlwnMowzCWb8tR1tAOb3Uh3uKxpBiE0bOccaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=joz9LKTP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d81dc0beso60320185a.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721931808; x=1722536608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyvNjjqobDzo2nVAxqnhjliyH8DNl57hvC/5geRPhII=;
        b=joz9LKTPe27qKHQmOUzHt34AK2cvzZotNlU/91GswfS+nQxwVMheNF/jNgpitSe/IZ
         VoW0uh00uqgoITWimH3eB4s4h811fuMrSbXLy65tBooeK0iqnI83z0isxzpHJjUmpTpy
         gVq35OWEwRUZzU2Nat6Hh47VE0pHfS6RUqTGCVuNOVHQXmi4Rc7QrYPrbqv0u+oShA/w
         LR0MrwqH/F5heo1OyWVIoSVA9w9uB40uOkPyv2ZztJC1j7zIT54HudNeEty96sr4koi0
         nX2HH/EUWcic4JwKf+jLYYrdDybzls4eG3tyBH2YnSHi3F21iIMrE0wpWEIlyCrXzv/d
         OuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931808; x=1722536608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyvNjjqobDzo2nVAxqnhjliyH8DNl57hvC/5geRPhII=;
        b=UuI+6X6L1aQ0ia94oTmspcseYnvhnZ2865/Z1Xs0rEfFeJiN2CXgU61Ciqwb7KK0vL
         Q+Ka7gD3kFkZnmz+l81NwExmXm+xTDGqj51kzp8EuzxYgwJWLWljEeXw0l6Gn3/Ebpk6
         cqoyD7SPZxqj+tjWm/e5IXfKWHTmxvogTMwlbT1sNggJzcIxTclXP9KorPUQSL0SaH08
         3YVGTVqiCn0sZyLJxf5/8zQN7zSPqdNSnm7fyZYYZtHNwucpFUoXHpQRPLPKqwWm1dDv
         0U6mHXJs02kf3WK9cZxM4XTUizuOkN56EhTxyF3fimrjo/j0j6yh4b8a13aNvKH0p+Q0
         lU9A==
X-Forwarded-Encrypted: i=1; AJvYcCV0fnJzyR9wTpldA3WWZm9RKKr7iKE5ZnO+fcbh85L+CnXEd90Wz1sZZR8Boi8dFEKbZmTzO6s241AYUZogzKESVNKw36Cv
X-Gm-Message-State: AOJu0YyS9dDCi92QURhDrqSiOM1UBM9dC8VYaBeYczOYznkB2+t60i97
	fKunFfb/vCY6uyOFEiPpyruANMsL8fmWAuUgRTDRTC64yzW5Ya9OZptBblfaHQ==
X-Google-Smtp-Source: AGHT+IEM5Pm5c6CfZSOAnNl7b0CiQM8WJGV7l2L9UCEWETuR+l2rd0k3fr8sk+NF2+488kFRGVVLKg==
X-Received: by 2002:a05:620a:1a9f:b0:7a1:d08d:e2fa with SMTP id af79cd13be357-7a1d455dce1mr540124285a.1.1721931808130;
        Thu, 25 Jul 2024 11:23:28 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1e6csm106939985a.32.2024.07.25.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:23:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:23:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: crwulff@gmail.com, linux-usb@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: Check for unset descriptor
Message-ID: <d24a4b7f-0d3a-4c24-9de3-5f14297b0904@rowland.harvard.edu>
References: <20240725010419.314430-2-crwulff@gmail.com>
 <2024072512-arguably-creole-a017@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072512-arguably-creole-a017@gregkh>

On Thu, Jul 25, 2024 at 06:56:19AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2024 at 09:04:20PM -0400, crwulff@gmail.com wrote:
> > From: Chris Wulff <crwulff@gmail.com>
> > 
> > Make sure the descriptor has been set before looking at maxpacket.
> > This fixes a null pointer panic in this case.
> > 
> > This may happen if the gadget doesn't properly set up the endpoint
> > for the current speed, or the gadget descriptors are malformed and
> > the descriptor for the speed/endpoint are not found.
> > 
> > No current gadget driver is known to have this problem, but this
> > may cause a hard-to-find bug during development of new gadgets.
> > 
> > Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > ---
> > v2: Added WARN_ONCE message & clarification on causes
> > v1: https://lore.kernel.org/all/20240721192048.3530097-2-crwulff@gmail.com/
> > ---
> >  drivers/usb/gadget/udc/core.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index 2dfae7a17b3f..81f9140f3681 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -118,12 +118,10 @@ int usb_ep_enable(struct usb_ep *ep)
> >  		goto out;
> >  
> >  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> > -	if (usb_endpoint_maxp(ep->desc) == 0) {
> > -		/*
> > -		 * We should log an error message here, but we can't call
> > -		 * dev_err() because there's no way to find the gadget
> > -		 * given only ep.
> > -		 */
> > +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
> > +		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
> > +			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
> 
> So you just rebooted a machine that hit this, that's not good at all.
> Please log the error and recover, don't crash a system (remember,
> panic-on-warn is enabled in billions of Linux systems.)

That should not be a problem.  This WARN_ONCE is expected never to be 
triggered except by a buggy gadget driver.  It's a debugging tool; the 
developer will get an indication in the kernel log of where the problem 
is instead of just a panic.

However, if you feel strongly about this, Chris probably won't mind 
changing it to pr_err() plus dump_stack() instead of WARN_ONCE().

Alan Stern

