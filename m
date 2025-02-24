Return-Path: <stable+bounces-118722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE0A41990
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3756716E174
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6F24A064;
	Mon, 24 Feb 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUQI6feA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A424A05B;
	Mon, 24 Feb 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390671; cv=none; b=CVjK7cMngSuEKvmIs00HW393xU1dnPMOtbaXK9N7pgp4EyAjxKghaI8fJ9VEWKLrlYqqXfSoFpfnoqSznUqf3BhgVrVOZMcM03d7OYRnYHj15bj/tJHz+k7399mcNB28R75mQy7T+DGvAFOrSkxml9y3tqA986cpWykCkMTKzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390671; c=relaxed/simple;
	bh=a1cc70jbOv5CCjNK84m5TgpuPadBsPl0xnYC/NRZ3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1boUKKuBThcXw2/sHTMyW8EntcHEwgZxY1GaXK3A7ocBVxHQJqheqrG0zlaPcveAIBSSeC8VLgU3qJPuXvCcTx1CdINyUQMgUdIEsMhy8mXnkuRyuJ8xewGfhCEwasmn18N3yzluvgAIclZW182sF6FYUxUXCldXrGyPzjy0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUQI6feA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4489DC4CED6;
	Mon, 24 Feb 2025 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740390667;
	bh=a1cc70jbOv5CCjNK84m5TgpuPadBsPl0xnYC/NRZ3Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUQI6feAoboadIqs+ta8SLxF0sQs43hw9TsAaTYvAYof2a8ud2gC5z9NT0l70y2YJ
	 Pv+e10CRD9Y0ovyTZIP8kL8mUsL6CofD5RLqxJuZhBh33tPOEwYQ2TyXdNnipk0KQI
	 n9TCaTEwNWaxQ07pdtSvUpvFqkksDrRXATOqzubE=
Date: Mon, 24 Feb 2025 10:51:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Kees Bakker <kees@ijzerbout.nl>,
	William McVicker <willmcvicker@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Check bmAttributes only if configuration is
 valid
Message-ID: <2025022446-reliable-snugly-84e6@gregkh>
References: <20250224085604.417327-1-prashanth.k@oss.qualcomm.com>
 <2025022434-unveiling-handbook-6fc3@gregkh>
 <63c3b650-c3cf-49bc-973a-c5fe025a22f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c3b650-c3cf-49bc-973a-c5fe025a22f6@oss.qualcomm.com>

On Mon, Feb 24, 2025 at 02:53:59PM +0530, Prashanth K wrote:
> 
> 
> On 24-02-25 02:36 pm, Greg Kroah-Hartman wrote:
> > On Mon, Feb 24, 2025 at 02:26:04PM +0530, Prashanth K wrote:
> >> If the USB configuration is not valid, then avoid checking for
> >> bmAttributes to prevent null pointer deference.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 40e89ff5750f ("usb: gadget: Set self-powered based on MaxPower and bmAttributes")
> >> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> >> ---
> >>  drivers/usb/gadget/composite.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> >> index 4bcf73bae761..869ad99afb48 100644
> >> --- a/drivers/usb/gadget/composite.c
> >> +++ b/drivers/usb/gadget/composite.c
> >> @@ -1051,7 +1051,7 @@ static int set_config(struct usb_composite_dev *cdev,
> >>  		usb_gadget_set_remote_wakeup(gadget, 0);
> >>  done:
> >>  	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> >> -	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> >> +	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
> >>  		usb_gadget_clear_selfpowered(gadget);
> >>  	else
> >>  		usb_gadget_set_selfpowered(gadget);
> >> -- 
> >> 2.25.1
> >>
> >>
> > 
> > Have you checked linux-next yet for this fix that was posted last week?
> > Does that not resolve the issue for you?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I hope you are mentioning this one -
> https://lore.kernel.org/all/20250220120314.3614330-1-m.szyprowski@samsung.com/

Yes.

> The above patch fixes null pointer in composite_suspend(), I'm trying to
> address a similar bug which is present in set_config(), it gets exposed
> if the requested configuration is not present in cdev->configs.

Ah, missed that, sorry.  I'll go queue this up too.

thanks,

greg k-h

