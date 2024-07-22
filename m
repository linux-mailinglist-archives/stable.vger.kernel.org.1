Return-Path: <stable+bounces-60700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAAD938FFD
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FC71F21B77
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49E16D9AE;
	Mon, 22 Jul 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="TmICzQAh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC1D696
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655536; cv=none; b=PGL9o9S1VdUy5tUYVlQCWGRTQTT6USxShltkgxb27oYED/02J/e42xKaa6C7pqw53kYoItvMrEKMZ4p+fFj88jTualoGFH3fR58/mQDRLq7YOu5grfX5J5XcatvUAjte58x5qHdvAtKKBehb5vjEWl9bu5ZCbXBFFQxff/QyM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655536; c=relaxed/simple;
	bh=EsCYzEpYzqKrSa5mU2oZ92LFXsRklqRrGu5dlu2E17s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxx2fNs+VdnkMQjh0OaXgIQYD4GX9MTDZxI9mC++coCwgVI7FEbFCxch6T71odyMUc7t3qPFcRXE1UjqzxADkHgELrIuz2/TzAEq0B7EvAgZsfB42xgDpfkm7umSt7PGZhoy6Z7GjCQs+TUDV1gJmgrtyqXueKLG+hBqtV0TIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=TmICzQAh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so24847456d6.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721655532; x=1722260332; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+AsODRpLyxGEYBH8qQZNZibMcAK7VAjI4KRKdmAQhc=;
        b=TmICzQAhNJwkKDZdjysmD5FK0p4cfiwedn/Wg9SYSQg/27zAVA3tuEmgGErSkWd2jO
         QZJGoG+mf268yvkns+GFl252lk5eLPifQNKerrBzSnszE3q5bYcE0eJb+EfxLSw978hU
         hDfPAtNLbHOnWWoSM+7CF5UpFv+TL3OW4K7jlT7jZdqpibmIQq1U3nDHxuLkHwTzLzQh
         xhKz4BR5ytV3SXnmJsygP8lmqU0O+xe/oKeWDAenVqA+kQSlGJ6nCWBv0Py9d1eHPeY4
         fDh/YYtKx147ybBRChkRBGtCdNuh/feLpCphYoPk69ZLMM5uM3+cR8ZuVblj9LLlHG6J
         Cq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721655532; x=1722260332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+AsODRpLyxGEYBH8qQZNZibMcAK7VAjI4KRKdmAQhc=;
        b=kYHWkJs8bvU6ymIAZsiwGG3azYFsvERBeqZlSBjUPORWM1mT/EsC1d4AM6xvYgYuPF
         AUlCWBQMYSJhNWAgcs/9OMETyq0k2ZhbyC9SDL/PzCLikrrmtl6SCTuCj5FYBeTmFth/
         5bgruY3e26/N6EK/OTegIVQp+n2MehzAw/qNpnfWN06xnArIqjSZmDhtY4p7f8tV7Wwi
         9H/BfCLC3zSfJYMEk/udJCCz9qJRUU2moRkQ5pEGnZumYBMZa/uyJeX+T8UCUN3K2mgg
         FG6BlHpuGd7eakxU9eJJfn/+piB4XJ4H1zP5kdbpF3XN03LsClJIEChutfFpirQ+l/JU
         UK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDQ59FYzlKCZT098KoIVnTTa5Y/I5vg8KXUaBdH+7qkRZJtrd1p7RBKRjf16Ai1LL97bqXbAZt0Fiqv1yoNtrH1ra/hMle
X-Gm-Message-State: AOJu0YwZ7gxsTVSVlifOjb5QlciL0X8mXJ0ibwn0NVxPB85rSnBmzdG2
	bNhlgv5RQXu0mAytBPmPjShb2c1PV1jfvtEsVEjJNJPYIgcYd+VcNiiZ3u4lTw==
X-Google-Smtp-Source: AGHT+IFjmr9AGaxyCdW/ULLLd3RGSItSvMoVfohtw51VAdmu35qfNZz3hxlPQvLclwvVcL5Do8abfw==
X-Received: by 2002:ad4:5be8:0:b0:6b7:a32b:4427 with SMTP id 6a1803df08f44-6b95a79cf41mr107303956d6.52.1721655532070;
        Mon, 22 Jul 2024 06:38:52 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acaf1de1sm35688816d6.123.2024.07.22.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 06:38:51 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:38:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chris Wulff <crwulff@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
Message-ID: <b35e043d-a371-4cf9-b414-34ba72df1ccc@rowland.harvard.edu>
References: <20240721192048.3530097-2-crwulff@gmail.com>
 <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
 <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com>

On Mon, Jul 22, 2024 at 09:00:07AM -0400, Chris Wulff wrote:
> On Sun, Jul 21, 2024 at 9:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> > > From: Chris Wulff <crwulff@gmail.com>
> > >
> > > Make sure the descriptor has been set before looking at maxpacket.
> > > This fixes a null pointer panic in this case.
> > >
> > > This may happen if the gadget doesn't properly set up the endpoint
> > > for the current speed, or the gadget descriptors are malformed and
> > > the descriptor for the speed/endpoint are not found.
> >
> > If that happens, doesn't it mean there's a bug in the gadget driver?
> > And if there's a bug, don't we want to be told about it by a big
> > impossible-to-miss error message, so the bug can be fixed?
> 
> Yes, this is an indicator of a problem in a gadget driver as was the
> previous check for a zero max packet size. In this case, the panic
> is in an interrupt context and it doesn't make it out to the console.
> This just results in a system freeze without this fix.
> 
> >
> > > Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > > ---
> > >  drivers/usb/gadget/udc/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > > index 2dfae7a17b3f..36a5d5935889 100644
> > > --- a/drivers/usb/gadget/udc/core.c
> > > +++ b/drivers/usb/gadget/udc/core.c
> > > @@ -118,7 +118,7 @@ int usb_ep_enable(struct usb_ep *ep)
> > >               goto out;
> > >
> > >       /* UDC drivers can't handle endpoints with maxpacket size 0 */
> > > -     if (usb_endpoint_maxp(ep->desc) == 0) {
> > > +     if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
> > >               /*
> > >                * We should log an error message here, but we can't call
> > >                * dev_err() because there's no way to find the gadget
> >
> > This will just hide the error.  That's not good.
> 
> The previous check was also hiding the error, and introduced a panic.
> I could add a printk to that error case, though it would be unassociated
> with the gadget that caused the problem. This function does also return
> an error code when it fails, so the calling function can check that and
> print an error.

Okay.  It wouldn't hurt to print out an error message, even if there's 
no way to tell which gadget it refers to.  A dump_stack() would help in 
that regard, but it won't be needed if the guilty party will always be 
pretty obvious.

By the way, how did you manage to trigger this error?  None of the 
in-kernel gadget drivers are known to have this bug, and both the 
gadgetfs and raw_gadget drivers prevent userspace from doing it.  Were 
you testing a gadget driver that was under development?

Alan Stern

