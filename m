Return-Path: <stable+bounces-114476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58620A2E412
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 07:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98D4188758E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AA1A08A8;
	Mon, 10 Feb 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp+eEI40"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA976192B7D;
	Mon, 10 Feb 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739168328; cv=none; b=rDzpUeJkgeUYmibXSM/dSnZm5zsjLutbtY9+86BlQRDVZgV2HJghE2OyAkc2EvIFGgu6Vcp8o149S7VW9gvO7cslM8vEu/9LB7wz+PqKaUt3rSIlubeeL44Yhy3OfxoDG1al0L+QK1WRqNEuSfCJGwmQ4/1uuBp4n6VrGhgReNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739168328; c=relaxed/simple;
	bh=2xmwt+vliB7hjVoaIaM8KIv+pEZjI3VqvpWU4ypw13A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3wNPW5t/s5Zd3mOyQQdMNhv8paRriT54oOUk7BFWENgRC//uq1s5mX50zAggqJdGj1Eq6s7RD4Rxbr1zPezwh8xOPGHKKxb4BEe19pckaVfQ2pnTb7PzcS+mck3yR9l1Fbk9lFYR8FUIBOVU8wNZkoz5zD30He8o7TUWf7vZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp+eEI40; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2a01bcd0143so3178665fac.2;
        Sun, 09 Feb 2025 22:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739168326; x=1739773126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56lsSnDRjq7IcAM0xSC3DxXg9ZT8VtXhp/+nHY+SLcs=;
        b=Hp+eEI40iK9SSvGAg9IjlTkZq1z0uHw4JGw0iFcfZmAI23WHEGpjVNsMI3IUug/cdH
         WcDGBG1+dctEWsL0OGLMNkwPZYnAh/AEbCS9MK4hehup5GLsNrjKYcFqJvOZzyT7nesN
         pt+LDh4XhpTrBdbkUGzNYpLCa6s2WipzlsFfnZWwvMpcJvg2CdbGCK/jqTn9VbWdqsUD
         NUUcS4gcSM1Kl/OLIfhSazLeu+GiAYf7kMEHtlbRWrsn5yNbw8gAu2NkSFyFvW2EvyiB
         wwfNUXO2fLHQyc0oLMN5zHXjQItzvu5d91lOEcezJtNVEDdw+OSdIqb3cMc/W0kwISq+
         eIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739168326; x=1739773126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56lsSnDRjq7IcAM0xSC3DxXg9ZT8VtXhp/+nHY+SLcs=;
        b=wVmElpR3WyrNFxDU6MHYYOrx+slHAwZx5Svl/7jB8rX/fBiCG1TiPj5lyEuMPJCDwr
         z7bLhYggynGKktNHdWGKpQytPtmXqqABjn5Mw9pIJrV2A6P58ry0LUHMpI+X7u5ZwV4W
         xtkJv2qJAB235pxteeIySkJ42M9YO342fDuIO0xkYIm9LnXy1gqQwfTJixb0f1Q5s/Ut
         HuwBUgBwa3NSzL3nliAd6ZPl+9p3GWBURfi1nZFG+bUQ1shBL2XLqt+of3WyX2K6izng
         C8jcXlRCLfPu/QxVTti3ty5zVd/ncZQ0quCDXFx+jYZZ4vWP+3v+MAXyfaNeyQlZruD2
         CTOw==
X-Forwarded-Encrypted: i=1; AJvYcCUMUkBy5SxBgS90EIE39CHXRxXvQjVAcPP6GCj1Wwg5+q4j/G/sGxBSkm9qrDH693QpmZ684j86ZObUYJQ=@vger.kernel.org, AJvYcCX2YwXEkImNEUhLyetLS1NaxOMWu9mptpFfa6kzco9XWPz86w8E7pie6z2cYu9BdI9Xyo6I9EnbGQ0l@vger.kernel.org, AJvYcCXaE1b9bmdRQ7REOk5W9OaOEHg+FyLqLb/27BWji3KbEZ8fIlNSm5I5zwNThv5wMwDZAAKq5gQM@vger.kernel.org
X-Gm-Message-State: AOJu0YwirkhafyFA05++aRUwgAj92ytTWn/EpWZrNNVjUxmP7mRY9F8U
	GtqCNHpF8icdGgPAtIGniVmeI18EUnNUUFgjPrmyQs5G5h2rAn5FFHZG+fhqYVOGvRm0nPCV0KF
	7fhrOhFmHF4rjiiJrexYv5kvAgz0=
X-Gm-Gg: ASbGncvkrVRTEoMTiQw84vIo4p17slFb+EvmDtKcsnQzaAZpZdgiBn/eqHzpaRNEYpp
	vlbiEn0c2zvAwhI96Iek3ckLgwqpkhI3Qlf6Q/nSVeZK6YGprW5OSqduoDU7KvdAsxIV135t/6u
	8=
X-Google-Smtp-Source: AGHT+IG1bvnSRmkTIX2ou7gO3+SqQlMqKUDrvEsbPmi0zKi/118gvRG5giYAq2HwszcZSkY03rhvkrF3zOicG6JFle0=
X-Received: by 2002:a05:6870:d623:b0:29e:526a:eeef with SMTP id
 586e51a60fabf-2b83ef6b1e7mr8184935fac.34.1739168325834; Sun, 09 Feb 2025
 22:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205053750.28251-2-ki.chiang65@gmail.com> <20250205224511.00e52a44@foxbook>
 <CAHN5xi1HoTHx5bye6v24eRWzuKLXcyp6zc4wVpYDyHcR4yu99A@mail.gmail.com> <20250207105124.3cb2e6ae@foxbook>
In-Reply-To: <20250207105124.3cb2e6ae@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Mon, 10 Feb 2025 14:18:37 +0800
X-Gm-Features: AWEUYZnY7fBOdPr0vosiXO7rHw6zB60OwW1JCAgXv8Wey5w7AqwxqinOpS0JHf0
Message-ID: <CAHN5xi3K3jXLZew5=4PwH8OUWeCMMcJSm5tpNgm3k1vw7LGe-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, 7 Feb 2025 14:59:25 +0800, Kuangyi Chiang wrote:
> > >
> > > >       case COMP_STOPPED:
> > > > +             /* Think of it as the final event if TD had an error =
*/
> > > > +             if (td->error_mid_td)
> > > > +                     td->error_mid_td =3D false;
> > > >               sum_trbs_for_length =3D true;
> > > >               break;
> > >
> > > What was the reason for this part?
> >
> > To prevent the driver from printing the following debug message twice:
> >
> > "Error mid isoc TD, wait for final completion event"
> >
> > This can happen if the driver queues a Stop Endpoint command after
> > mid isoc TD error occurred, see my debug messages below:
>
> I see. Not sure if it's a big problem, dynamic debug is disabled by
> default and anyone using it needs to read the code anyway to understand
> what those messages mean. And when you read the code it becomes obvious
> why the message can show up twice (or even more, in fact).
>
> I would even say that it is helpful, because it shows that control flow
> passes exactly as expected when the Stopped event is handled. And it's
> nothing new, this debug code always worked like that on all HCs.

Got it, thanks for your suggestion.

>
> Regards,
> Michal

Thanks,
Kuangyi Chiang

