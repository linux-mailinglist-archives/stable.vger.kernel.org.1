Return-Path: <stable+bounces-131242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D6A80913
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BF4C5C62
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CA26FA46;
	Tue,  8 Apr 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF/V9+Bw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982026F47B;
	Tue,  8 Apr 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115871; cv=none; b=iENnp1CJiHoiqz020YJXJInicBrSpC3+sO7fOe1ZYr/f+lU4gXp2O8T7b3yvcdIqs6hOuLQqzsLHx+cCkNPV9c+yKvlV9/xejZObnIaSY808eQPX+xGXVj6XTSAkTQGRcuAg491pHkwJaySRjeVOv75gj8llOalbXZj/Bh4xBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115871; c=relaxed/simple;
	bh=n5yY3c/M7DGrAou208VOkwvsGsTS780Xs0GL0+1p0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px5KRGZs5AO3AThCgL27vJUQr/Zthi83/gLRdXUIlNsigjxho6Y9n5Bg/ScFW395oaXqAGRKKeW1yfU9QVcMt/TOwUG9jFmrlE/h18bMuy4gQwH50huuP7KW/eAPupxCcpM6p8Ksebcye0OQtd5Tb394IObORclc5Xji6prN+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF/V9+Bw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf3d64849dso926631766b.3;
        Tue, 08 Apr 2025 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744115868; x=1744720668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XDdHAFVrIm9VYmfrBSLGHN4jyk7mQe9dLRJj0l1S2A=;
        b=lF/V9+BwRAOFAsIhJ2sIxEGKRozk+mIVrIByvlPskSAM2CNejjJsr+5FsfH1tm6L+F
         fyh5nTTPvlBoFZeh3a1Jcxs8Twben75KA91Xc+AicyTGj18GePv4ckyi+6ELGpaM7hsm
         gpmeD0G0dKXA1pMT3RYDv0U9SQR+SWVRS6sRzmVekaWqAloDWzjhTLRAFHff37MG4HzP
         u98kxmyCKgEpf3kt8KRRCQ69Ng3AmSgLW3AJfHAwYKHKVYT1HNDhiaeCBb8nlawN7fMb
         UqPE+GNB3wdpPDA9h7oxyNKLUIoU1RCb6O7kzLLOwikefgz8WRmlXLYQmysYH7lk4bTI
         42Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744115868; x=1744720668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XDdHAFVrIm9VYmfrBSLGHN4jyk7mQe9dLRJj0l1S2A=;
        b=hsWdf/AmFMNAI1N1GffhirBhBSnzyP2N1yyHGdO/H/OKHGdBuRm+ZLj1NL8G+nLnz9
         eSM9IalwwsV3zKDO9n9Glq7e6SZEyPS73gWROj79ZspetZwvP4RHah3Gc976yLRLhi1a
         SMWXn3V7Xyf8WFd/R2WSwpMUuCVWHr3JPfHRTT0zMVLqt/6+lwcvJYTmJKXkF6kz/e4w
         0VFAHoSRtmJ/w2snogTM2j4GwdaZjaZVUhxnM76kumlrhX6nJhEDiLiIbTL16AdCknEu
         I/l7s+Faq1+S7/eL+fYhe3e629WEpAZzOKzfRqm2Ops58BhGw9VE96aKeSh4zFq9alfc
         H9fA==
X-Forwarded-Encrypted: i=1; AJvYcCXKB8gd1xlrPBDJER4Ooac+kLkd941cFjf+iyhHtOKX+/aknzZwLvqo1YjMI8IIJG1W81JulOyk@vger.kernel.org, AJvYcCXoDunpni8meECEYMAJVIuj77pH8ZU2Aasmjuy4ZgwAiqB2a8mkZKGtd0l6ZSl3dNai05VVjcs2/2w7OuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBo/ghPk7tUrYiTbypkHYzYzdL+E/nRIt3qBs9U2XgFihMbGku
	vyx5KgOLCEUEx2hprbCW+VB24lnvFi17jw7azQ9yU9jiKy1UJD3PcMyCLk2UHs74VigCT4ayE8y
	gExuryjoWeQJDxxvao83B119Ie70=
X-Gm-Gg: ASbGncsoDgY5xH9TPfXQ0Rf+IvOt/NH+ktsvX47BVaWt+jK9lRqefMP/8VsT0dpTE7Y
	+82HrnxjSIEeu4LPd+4J79St7dp77OT5wnxlQt5oG3ml4Y7TUkvygQ0x6us7F/c3FAJ1MawimU6
	9T4KKOhBFoj2zx1ExI1YCAzVXV1KKQ800lo9vPXQ==
X-Google-Smtp-Source: AGHT+IFnh++FCRpnlhvrWegLUR+La0yffyAijO55u8NHyZxWVOF15mHkPKXDFhuFgNXjtR3SujjYNEfhlW/FnTHrSHE=
X-Received: by 2002:a17:907:3d87:b0:abf:6aa4:924c with SMTP id
 a640c23a62f3a-ac7d17747cfmr1453840866b.17.1744115868044; Tue, 08 Apr 2025
 05:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402092500.514305-1-chenhuacai@loongson.cn>
 <87jz81uty3.ffs@tglx> <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
 <87bjt9wq3b.ffs@tglx> <CAAhV-H6r_iiKauPB=7eWhyTetvsTvxt5O9HtmmKb72y62yvXnA@mail.gmail.com>
 <875xjhwewg.ffs@tglx>
In-Reply-To: <875xjhwewg.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 8 Apr 2025 20:37:36 +0800
X-Gm-Features: ATxdqUFI9fVaIwXUxf1Igx0gCLAe6stGaO29HAebgaBrjAmfEMADUOm1aVbUZ1k
Message-ID: <CAAhV-H6tUvwN9UejTRf0zKXdhGG4o5X4ZOppE+1oQhL-rADFHg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set IRQ_TYPE_EDGE_BOTH
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 10:20=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Apr 06 2025 at 20:46, Huacai Chen wrote:
> > On Sun, Apr 6, 2025 at 6:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> On Sun, Apr 06 2025 at 17:46, Huacai Chen wrote:
> >> > On Thu, Apr 3, 2025 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> >> >> But it won't trigger on both. So no, you cannot claim that this fix=
es
> >> >> anything.
> >> > Yes, it won't trigger on both (not perfect), but it allows drivers
> >> > that request "both" work (better than fail to request), and there ar=
e
> >>
> >> By some definition of 'work'. There is probably a good technical reaso=
n
> >> why those drivers expect EDGE_BOTH to work correctly and otherwise fai=
l
> >> to load.
> > The real problem we encounter is the MMC driver. In
> > drivers/mmc/core/slot-gpio.c there is
> > devm_request_threaded_irq(host->parent, irq,
> >                         NULL, ctx->cd_gpio_isr,
> >                         IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> > IRQF_ONESHOT,
> >                         ctx->cd_label, host);
> >
> > "IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING" is an alias of
> > "IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING", and
> > "IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING" is
> > "IRQ_TYPE_EDGE_BOTH".
>
> I know that.
>
> > Except MMC, "grep IRQ_TYPE_EDGE_BOTH drivers" can give some more exampl=
es.
>
> Sure, but you still do not explain why this works even when the driver
> is obviously depending on EDGE_BOTH. If it does not then the driver is
> bogus.
>
> Looking at it, there is obviously a reason for this particular driver to
> request BOTH. Why?
>
> This is the card change detection and it uses a GPIO. Insert raises one
> edge and remove the opposite one.
>
> Which means whatever edge you chose randomly the detection will only
> work in one direction. Please don't tell me that this is correct by any
> meaning of correct. It's not.
From experiments, either setting to EDGE_RISING or EDGE_FALLING, card
detection (inserting and removing) works. Maybe the driver request
"BOTH", but it really need "ANY"? I've searched git log, but I haven't
get any useful information.


Huacai

>
> The driver is perfectly fine, when the request fails. It then does the
> obvious right thing to poll the card detection pin.
>
> So your change makes it worse as it screws up the detection mechanism.
>
> What are you actually making "work"?
>
> Thanks,
>
>         tglx

