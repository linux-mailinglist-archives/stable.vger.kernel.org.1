Return-Path: <stable+bounces-195370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0BC7597A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C51952C126
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377836BCFA;
	Thu, 20 Nov 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0IPZ+bE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3636BCF1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658818; cv=none; b=pfPaDHL9T01k+IabsLGNSDoIxsxKKdgo5941xI14sHXhNlugLFyqjb71SP7q8mttwi3wIAlJ5EeBSZG7raI1NT0kqKug/Sedr9BMdl+r6DCKgqj+OQfl5fCI9cJZ7DCx2Nl3lb8jBeE5iNidC9KblVjX3MnHmLtLvfOd1B6kk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658818; c=relaxed/simple;
	bh=dA+X3frohUmiN42sQXCsXtWK/UJo0Tcfbir9/CzOXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8u6V7nTbGfi68LLMVBHsD1u7yjWK71Cudp71gsrF/l6lwXXy2uLUmXLw86ngFgUMYRqWVeK0zIkKc3DtnepuXI3SK6WHf61zm2MO9s0owwADmCWQdwm8xRxrNcrCB20D2fX0C2Koa8AaAtwus54zG58LYXCwE7ptLhE12cCPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B0IPZ+bE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so1811471a12.0
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763658801; x=1764263601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71+jWtBg7d1iYRAZRUfunCs8pFBPFzAnVW06bSqsOgk=;
        b=B0IPZ+bEOJBe9qbZc8/hzmMYp7upSLg7MTHv6CKgsB78eF/SzR7TLR9cw16aRnLSoz
         qUKeI3wBxuE7nQFAOuw8Fr6rffu14Ok2DmYeTNzIIYeTZ/aG/KVFWjlEYFGIL6LTaBRW
         bXnPliLh/rHYdSlv82A0T4Jr2pC49T2QphR3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763658801; x=1764263601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71+jWtBg7d1iYRAZRUfunCs8pFBPFzAnVW06bSqsOgk=;
        b=bgTDG3e8rvsFqFD0RhIQXQlWDfK1TaeLPRV0QhwFi7SeSH/YGQen4PJhmObmSz+sSe
         bLkdD0eGWo4kV5+Og1NC1JVGp4e8ZXNjdQvTQoq/O8s0ofUChXzVUBaeDXqV0eD5fYpb
         7ygwg6bccAkDxYjjfPZJ2p7zTl0He1qsL+GtVBdPB7tRxYDiAjGGPXn0ciusJfA8IQ2a
         XZRIy5mFqGau3xIMWkCmumuutD1eDz2XotSNuuYW+EyUCQcLvW39FTjK0JRnGDxIOee7
         KGRpUgf3qFIeePUZTTEVpSb6YvfoC+b9pfT4zfnEp5iXWqocr+PzGvuRIDmzyxnr71NJ
         LKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0YYM0Bh2Xk0a1gptqGm+Z4sE3ith4qO8hcu22N8wMSjLetTfb/5rCjoGHXNP266lAoB+UFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfxznp1sAXZJSIPSeGpP3HB02lFeNwaGKt5O3Hj+arHbTpj27
	FvxT4AbFrT4FgRX2XNA6PMZy1a8fUQbdiW5v4yN6166lLQFQpdgAHfuSKAvLBpAq23gaLXGjkZ7
	CMDa+lo2d
X-Gm-Gg: ASbGncvEJC/BtdFH5iULaH1r4S9lbs71TuPRk4f+rh+uVfjG5LgUHaGIb9HPNG8jfxA
	JPz1l+VJIwT2bg0hQwX7iu8X1X75O987DkfDw4Jsk+RABqUGCzszOzxqU4l09HemSCZtY/RWPZA
	UN3ymVA3jArye3qFIrm2gCyAPmtLBbVJno7l9+nDYzmdii4sPBDm5rb94ziDWfIu34sN+4PRhMm
	mBHq8jzIbkPZyejYgdeqbLcQmmxHvQ/z1TzH0ZagUzaDb/37xHB0OwCT9DMj5go7UtL6qnoNeVu
	Jm7AI7yqewSo1hXTjhOMttuGCgRg4licLeKyHZ0sc5cIhWLrxAp1iyFRIZnBFiZ/0u21OgfINk5
	bhNnwv7CgmKf/FY3vZ5hOLRuxLAn1lsBYxkhEf7Y3Jp1W/mcQsVXxtdYJI2R/UFisvGmukLfKzz
	dpKC55YFZz9sVEkFj52kE74kqk9w62c1ASDo/UJBp0dwvTwNuwKTAWuXKCblvoL2FUblnVgf8=
X-Google-Smtp-Source: AGHT+IFTiUZ3P/delUFcpX1909NvnwG8bd3iNLltST5PYF6IaD0GbIZhFveK0nZ8M9sA0lohhhDMpQ==
X-Received: by 2002:a05:6402:1d4b:b0:634:5381:530b with SMTP id 4fb4d7f45d1cf-6453d964436mr2348520a12.13.1763658801272;
        Thu, 20 Nov 2025 09:13:21 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d307sm2533409a12.19.2025.11.20.09.13.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 09:13:19 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736ffc531fso177381766b.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp03WhP0jER1KWU1W31rtUs8JM7QuwMPexP1bwlEEXOrL2lNKCH4/ffG4KV0+cKdIJsa5qAY8=@vger.kernel.org
X-Received: by 2002:a17:907:84a:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b765869343emr280912466b.4.1763658799257; Thu, 20 Nov 2025
 09:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
 <be1cbae6-f868-4939-a1c1-fd66e2c6b23e@molgen.mpg.de>
In-Reply-To: <be1cbae6-f868-4939-a1c1-fd66e2c6b23e@molgen.mpg.de>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Nov 2025 09:13:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W1D7ksbS-q1c6cHQSxx3=Z5yfC8duiBGh8S01NhLPLUg@mail.gmail.com>
X-Gm-Features: AWmQ_bk3aT3ZuUmLknvARxMmblGOEsNctHWpwZyyDwMRW7H291WIp2zvCdFNcjo
Message-ID: <CAD=FV=W1D7ksbS-q1c6cHQSxx3=Z5yfC8duiBGh8S01NhLPLUg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	incogcyberpunk@proton.me, johan.hedberg@gmail.com, sean.wang@mediatek.com, 
	stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 20, 2025 at 9:04=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index fcc62e2fb641..683ac02e964b 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2751,6 +2751,11 @@ static void btusb_mtk_claim_iso_intf(struct btus=
b_data *data)
> >       if (!btmtk_data)
> >               return;
> >
> > +     if (!btmtk_data->isopkt_intf) {
> > +             bt_dev_err(data->hdev, "Can't claim NULL iso interface");
>
> As an error is printed now,

An error was also printed before commit e9087e828827 ("Bluetooth:
btusb: mediatek: Add locks for usb_driver_claim_interface()") too, it
was just a different error message. Previously the NULL would have
been noticed by usb_driver_claim_interface(), which would have
returned -ENODEV. That error would have been noticed and the message
printed would have been:

Failed to claim iso interface: -19

So that error is merely changed into:

Can't claim NULL iso interface

> what should be done about? Do drivers need
> fixing? Is it broken hardware?

Personally, I have no idea. I was mostly trying to get the regression
fixed and, after looking at the code, I was convinced that this would
get us back to working at least as well as we did before commit
e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()"), plus we'd still have the device_lock()
in place to avoid the problems I noticed earlier. It sounds as if,
even with the error printed, things were working well enough for
IncogCyberpunk.

If someone wants to analyze how / why `btmtk_data->isopkt_intf` would
be NULL in this case and if we should do something better to handle
it, I'd certainly support it!


> > +             return;
> > +     }
> > +
> >       /*
> >        * The function usb_driver_claim_interface() is documented to nee=
d
> >        * locks held if it's not called from a probe routine. The code h=
ere
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks!

-Doug

