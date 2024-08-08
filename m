Return-Path: <stable+bounces-66038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A898F94BE3E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DC288A48
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74618CC05;
	Thu,  8 Aug 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4rOdd4M"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064B18C929
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122707; cv=none; b=ba/uoxbHshyg66FLG8cKslFIKptKi5e1wKwfDNuAxwyJvfbHjx/uP1xQPMSeCXYV6KEzMUEF7teSujj8iv0t52EOyU51FtSJzWc8MYoUPd4JzuPCz2mvA1Kucf159xD1qow9JbwbwLl2yZaHSVVu2kwphzMY7Ah2rJ6P26FSz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122707; c=relaxed/simple;
	bh=DrgjKLIkUGC5VCWlbTYwcCK2pFWtrCGmlMM3BVytejU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoAFgRa9/sC5mWmmsfSRqco6pP4ntEEaHg8YVGn8QrVRIqs1qTJI6lQ2uLk+ycVBcGzCq06UEBoeKr2ChJgyDUg+ox/cy8eOm2iQWD6Uqojz8iUE5jSDU3r4rvpyAoRiTFhVbWBBp5APgS/HPTtMTAK9h0cRQdvnHDvl7iuK9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4rOdd4M; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so11434a12.1
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723122704; x=1723727504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m9f3TQzcN26+bk9XTrt9XIneWl3bipSeBzkknpmfNI=;
        b=h4rOdd4MQUBLeMnqQlmXZn+e20tbfQbhpUJRZkD/R6vBaAymMXvh/4OFKmgW/8FLID
         Ey5DpGv17dcV7fu8Yw/7Tq2kL6/jjhoCuve0ewOyxkYpAppv7yrHrT72c1M+wBcYPZG0
         QCx7ZDDrSM86dQTRgPOKK9vcvI5sVwBE+3gHnC2jU2pDupcHr5DcqZGwRJqTxv1Pd+Tr
         HnIW1a9TAKSAQbUpbwantV/362eYT3pz9EaqMNR4fvkYA2WBG2F9+Oxi/4BT0eUABNfe
         D8u5M/8FTtUauZ8oJ7JAPbP8KFikI5fbTD4HAjIx99gNRAwC9FbL9zGsvZfyMHA+8QHJ
         +Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723122704; x=1723727504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m9f3TQzcN26+bk9XTrt9XIneWl3bipSeBzkknpmfNI=;
        b=SbfRkMi0pDcQeHa6KqrMSaH678YKXLeFb7PhFcXYhTAtWaz6ZVqTnb0mVujpQ7QEPC
         d8ldGomG+8YGZXnd3qQvph+F50GDrsYZE3biLqlwvy/TJXdK/tzgUv//CEQRdyjDmxwk
         CDRum1xmuP8PYRkzN7t5zZyExjfQ0c9inZdUeVzMTnqRGBvt5OT2kDg0eLAQY3LaJOwY
         dCAHgyrKSIiAfIJ1KOstydW6uRvLQ6+0RjS2MBkvjMYQ6cQJzoTLYwgzzlSQAqZ4b+E8
         Lq1nz8KH+KPByo2gkKf3BWQJiq70osA2PcYmdEV8e3HjlPTteOOFvvZHJUQxqAkC+OTJ
         35Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXqtvDnkrP7di8ZUQA8zhxgUbgD02CFKmdwZR9noBF0Ok6SBjBxvxUZtgFlBAPLTTgDHMYqVVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZ8cE7s7Mm+VE9c4VROkfJYvEtJH7boac5JvFIB0aKHfEggq+
	6yWjxjubRH0MZzvwblxarzYNt/2Se1bedcUx4urlD+Q4/qoxpRCBCgeg+BKRJFR1ZMKRITpj9P8
	PNzZq8c5FJamyxepTCeLCM5b+tpAyaLCm/WYh
X-Google-Smtp-Source: AGHT+IEay4v7AJgP7g9A/mBfRKZRMCl5lRjrlHyS/Ik2On5ugyyYjO0nvnoTooDqDIPKhGMSjLmZOojqHy2nGYyAHA8=
X-Received: by 2002:a05:6402:3587:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbaff2fa9fmr192809a12.2.1723122703235; Thu, 08 Aug 2024
 06:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804084612.2561230-1-kyletso@google.com> <20240806232836.52rkn7u3g5uiotn3@synopsys.com>
 <CAGZ6i=1v6+Jt3Jecd3euNnumVK781U9DQvRz7cHWnxi8Ga6W=g@mail.gmail.com> <20240808013743.tgvfjqgdtxluz52i@synopsys.com>
In-Reply-To: <20240808013743.tgvfjqgdtxluz52i@synopsys.com>
From: Kyle Tso <kyletso@google.com>
Date: Thu, 8 Aug 2024 21:11:25 +0800
Message-ID: <CAGZ6i=3aLx2h_cqes+=EN8JCCgiJVjRKHHXvA54gcq5WKhUnCg@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: Runtime get and put usb power_supply handle
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "raychi@google.com" <raychi@google.com>, 
	"badhri@google.com" <badhri@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "royluo@google.com" <royluo@google.com>, 
	"bvanassche@acm.org" <bvanassche@acm.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:38=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Wed, Aug 07, 2024, Kyle Tso wrote:
> > On Wed, Aug 7, 2024 at 7:29=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synop=
sys.com> wrote:
> > >
> > > On Sun, Aug 04, 2024, Kyle Tso wrote:
> > > > It is possible that the usb power_supply is registered after the pr=
obe
> > >
> > > Should we defer the dwc3 probe until the power_supply is registered
> > > then?
> > >
> >
> > We can do that, but getting the power_supply reference just before
> > using the power_supply APIs is safer because we don't risk waiting for
> > the registration of the usb power_supply. If vbus_draw is being called
>
> I'm a bit confused, wouldn't we need the power_supply to be registered
> before you can get the reference. Can you clarify the risk here?
>

I know it's weird, but usb power_supply module is not guaranteed to be
loaded while dwc3 is being probed. What if, for example, it requires
userspace to manually load the usb power_supply module. If we defer
the probe just to wait for the usb power_supply, it might be waiting
for a long time.

> > but the usb power_supply is still not ready, just let it fail without
> > doing anything (only print the error logs). The usb gadget function
> > still works. And once the usb power_supply is ready, the vbus_draw
> > will be fine in following usb state changes.
> >
> > Moreover, all drivers using power_supply_get_by_name in the source
> > tree adopt this way. IMO it should be okay.
> >
> > > > of dwc3. In this case, trying to get the usb power_supply during th=
e
> > > > probe will fail and there is no chance to try again. Also the usb
> > > > power_supply might be unregistered at anytime so that the handle of=
 it
> > >
> > > This is problematic... If the power_supply is unregistered, the devic=
e
> > > is no longer usable.
> > >
> > > > in dwc3 would become invalid. To fix this, get the handle right bef=
ore
> > > > calling to power_supply functions and put it afterward.
> > >
> > > Shouldn't the life-cycle of the dwc3 match with the power_supply? How
> > > can we maintain function without the proper power_supply?
> > >
> > > BR,
> > > Thinh
> > >
> >
> > usb power_supply is controlled by "another" driver which can be
> > unloaded without notifying other drivers using it (such as dwc3).
> > Unless there is a notification mechanism for the (un)registration of
> > the power_supply class, getting/putting the reference right
> > before/after calling the power_supply api is the best we can do for
> > now.
> >
>
> The power_supply driver should not be able to unload while the dwc3
> holds the power_supply handle due to dependency between the two. Why
> would we want to release the handle while dwc3 still needs it.
>

It is possible. Calling power_supply_unregister only results in
WARN_ON if the use_cnt is not equal to 1.

/**
 * power_supply_unregister() - Remove this power supply from system
 * @psy: Pointer to power supply to unregister
 *
 * Remove this power supply from the system. The resources of power supply
 * will be freed here or on last power_supply_put() call.
 */
void power_supply_unregister(struct power_supply *psy)
{
    WARN_ON(atomic_dec_return(&psy->use_cnt));
...


> This creates an unpredictable behavior where sometime vbus can be drawn
> and sometime it can't. Your specific gadget function may work for its
> specific purpose, some other may not as its vbus_draw may be essential
> for its application.
>
> BR,
> Thinh

I agree that it might be unpredictable. But If we rely on the
power_supply class to control the vbus_draw, it is the risk that we
need to take. I believe most of the time the usb power_supply would be
there until some specific timing such as shutdown/reboot. This patch
is only to handle the small chances that the usb power_supply is
unregistered for some weird reason. It is better to give up the
vbus_draw than dwc3 accessing an invalid reference.

Kyle

