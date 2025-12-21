Return-Path: <stable+bounces-203176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23503CD47A3
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 00:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3163130057E5
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2542DF6F8;
	Sun, 21 Dec 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov9VM3ol"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7C2DF128
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766361060; cv=none; b=PSgGLIltuTK3k0ZG/6F+7AoafjtvfTGvEp+95AYPckgFrgZN5ERAMlrTmrWSBvKN5vRx7OC/RCDWoqZapcUR2YdjUkfLmDUC5r56VfNqrUYKQIT0bu0+93hJMq5C8X6szu2F9OFBoyJQdHjoq5dMgr0kxzj6VDU10c7QC89/FbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766361060; c=relaxed/simple;
	bh=UHUSk6IlQkgaPX0gSqu9fEXMfnJ5VOTMeH/+8DAFLYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=sPTOlV+TE//LZxquIjficdo5OA2vjDtvidZz+LsAlKJGNBPjLXCsZl9wDFBnbdLgi97kVR6BLbrbX8vYoFmGYcLb2kJyzAUiL375vLl2NU9siy1U4+3tFPhAPXqg3ptstFoGZWhxfSG7Np64t28gbnK6trLQyZmJdX6JbuEVbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov9VM3ol; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4ed82ee9e57so44653491cf.0
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766361057; x=1766965857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z2S2s+uKqhgB3zsJAyAhxwuX4Wuy3l8oX0/z7zKD3Q=;
        b=Ov9VM3ol6haYc2K1upysWo04RSLM7kjG1TspXaAiFDyUef9CI0QrnQM1/OzUE82SwP
         94gOALnJZQCaq/hOScFHj8TRty3HYy6WZxsVkWyZq8k/txWsoRO55NWkBQVGf6qTqAdb
         u81pMkw/0042N2X7V8+B1VjvPgluJ37wk+r9tyvm1cfi9kCcZGOPkDKPzpDtlIlGroyT
         zCeGNXGOsmcDvKVRuLXWB6zcXPtqtZO3L9Ty3eGlrsdNvnF7XgnheMxTbtAPmQodDDNF
         xUGcwsDJqahd7auPc5ve/tOO7Wb2E/xq0yzM3mbUVh/USeM0GejnhlWXwekSji5VF0YX
         O/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766361057; x=1766965857;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4z2S2s+uKqhgB3zsJAyAhxwuX4Wuy3l8oX0/z7zKD3Q=;
        b=Gi8pk9F/8g31DW4bkLRVbkOHPEAIGIFaux96qPzybNghx6Hr3nLT2djcsOf7OI5SSG
         Oh0jfwiaN36hzIQS71uI8jWQBQ7ehYeCA6FpzI5nElYWZMdey4TIhiRbVDlYuQWP7sRn
         nZNddffgdBCvLUXcw2GzjkRUt4XJkKteX3A1CzMPoK/mJSs1qrgAeh3Sjq3IWslvAzSJ
         3Px+Yob4IHQnaF+8IaokteDQT4K27XgW4BaQKYwjYLwIzG5jgaFyfIlRmJbFRlMaJk4O
         raeBeej5s+5KskheI+1uzw8ENBefv0cK5jlEeqxOG5wP+M0rsyPv8oe9DKkxMnEaqTkS
         BSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhsQOEOlwlLpv7NucCuaICwrdVp7Lh1uLIeU9a65vFwf6s/wfYt/lF39Z3SGsgETR440+ue+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIhWx5ez73/6b16VnY9313qonTU+fYqPT/WltaMtLPjwWC6nN
	SH34aMwLO2RfRDvhXESqpxo98P6c/+MoFFqtWbAMvvr6YxJT17gsIhaa3ugu48xXpTYW4Qst5DY
	YjP5G8bxi1VlYumPwmavrlYnplkDsXYw=
X-Gm-Gg: AY/fxX40kPUL79tutYANB7XQEARy6q9e7DxjegjPcM+MYGjCtZB31OpVGH3Ws5Zd1/r
	mSjztplQQPjXq+XErIwn1pJfkNMeswmFwjuMf2iM3DW+KI6/soBI6LDqN7Qv0Ss2/Hv0uzzh0Ln
	FNsuzXNuY4ZdD+ZARh9R9WxFpZ9NAutEXcuLRhrFJIcVpNDBmhkaBgyYjPAqwphM94EyboBnAs6
	wulpaZ4GEeGU3uA1ELzxqM7OLh6cWywwNaRE0QAf72OJQSQKneW5OgSCPcam1S1K8rYuQAfk747
	m0Bl8HYDINUe8ChHBKPc837GSdnYb3/Mo7c23x5ZsevWlPTfzj6KDzhrS4HONNLvghLX
X-Received: by 2002:ac8:5c81:0:b0:4ed:44a7:cf78 with SMTP id
 d75a77b69052e-4f4abcfc08cmt159003411cf.34.1766361056666; Sun, 21 Dec 2025
 15:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221082400.50688-1-enelsonmoore@gmail.com> <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
In-Reply-To: <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 21 Dec 2025 15:50:45 -0800
X-Gm-Features: AQt7F2pXNxOlIsQWNGzsoeXHoTrwDKsapHLuZqv309p4Ul6_qfoeSkBW-saZodQ
Message-ID: <CADkSEUgX5FN6kgs5FSZGRoF6icXmUyp67y55=sRAXzWnsHGzEQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

The other two are correct because they intend to write multiple
registers - they are used with a length parameter.

Ethan

On Sun, Dec 21, 2025 at 4:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Dec 21, 2025 at 12:24:00AM -0800, Ethan Nelson-Moore wrote:
> > This fixes the device failing to initialize with "error reading MAC
> > address" for me, probably because the incorrect write of NCR_RST to
> > SR_NCR is not actually resetting the device.
> >
> > Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : On=
e chip USB 1.1 USB2NET SR9700Device Driver Support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> > ---
> >  drivers/net/usb/sr9700.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> > index 091bc2aca7e8..5d97e95a17b0 100644
> > --- a/drivers/net/usb/sr9700.c
> > +++ b/drivers/net/usb/sr9700.c
> > @@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8=
 *value)
> >
> >  static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
> >  {
> > -     return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
> > +     return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
> >                               value, reg, NULL, 0);
> >  }
> >
> > @@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg=
, u16 length,
> >
> >  static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
> >  {
> > -     usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
> > +     usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
> >                              value, reg, NULL, 0);
> >  }
>
> I don't know anything about this hardware, but there are four calls using=
 SR_WR_REG:
>
> https://elixir.bootlin.com/linux/v6.18.2/source/drivers/net/usb/sr9700.h#=
L157
>
> You only change two here? Are the other two correct?
>
> It might be worth while also changing the name of one of these:
>
> #define SR_WR_REGS              0x01
> #define SR_WR_REG               0x03
>
> to make it clearer what each is actually used for, so they don't get
> used wrongly again.
>
>         Andrew

