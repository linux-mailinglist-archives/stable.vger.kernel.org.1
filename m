Return-Path: <stable+bounces-41372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EA8B0FA7
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB781F25AAD
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D6165FBB;
	Wed, 24 Apr 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRio9Mca"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F38161B4D
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975895; cv=none; b=U4RSPbUXiBVuVpDj3PlqgJqGQZv8p/qK/E34tN076egdZcufSR8UmxAvSz10D657IlHylAuzBNbEYcBKZURbCbi/DvVS8vEoyRQNjGSd9HPpLWHICuUiimsSkpmQVRFE6PMhwqGLdJhTmcH5VRMDXqb/rfbIfvGdQn8Dg/6RgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975895; c=relaxed/simple;
	bh=cND1PE1vSAdhfk2CRs7RXl5CX9byI+l280+lm5j+WZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQsltwYd1XrvVdCOkrErDj75JNZNuwwi81wG5578kUb0tsV2EOUzXZmROg7F8xp9x0mbk6zmay9bGPZkfU+FENRayNE1kPAcfS4Fa5hwcHkvdrDvMg86e+32fIiqd9xnMbEHbxfNrth1YaMjcLp9q66PC/WH0dkptE3VFk8Qp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LRio9Mca; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43a317135a5so998711cf.0
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713975891; x=1714580691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TxYW0LPM0T5UqY1oRd1cuem+oFb+5LidVbsapA3pB4=;
        b=LRio9McanT5qsAfv8GtMZo4kdHMb3Is30CWRUz3lHoatihdsjZzZS1FSe/ZH8YxU9s
         Sd5gpaAbw45ledP7R7Xgpg5ZWfAaDFTjoCrVT677r/j3yMameL4rhZ3kk3u1oYar9GHc
         eiHwxl6JPCiicIw9G43TPYBmzUbyIQeoAeptE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975891; x=1714580691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TxYW0LPM0T5UqY1oRd1cuem+oFb+5LidVbsapA3pB4=;
        b=T5tGEjL+lj35cRfy87ORbO6wa0t1OxqjkkDmdZW4pvDn4g8Br66ilkqIxzBr65970t
         BK6cFZUn41ECh/P+3lBK4MkTRNcBdHlfYDw59ByeJaPWJ7z8hBMTcuM4bgpK1q9aysqo
         sqYASRtCvlSBngHUYNb8jd4oJ6vH7eMH9bRI5eujRxdBb/O+aLteiSYyidVavGmI6/Uo
         vQowTmmgwLjSEYLO70MXtR1jN5VfAbKovDL5C7o3m0B400Ze5GSYHayC1yT4tziuhpta
         xtwUx+iZrsPSaRnc9/5qm49eukf144TvqWXVatNSa65YoL/s4qfxHk8cfsDzcweTNFH0
         SQDw==
X-Forwarded-Encrypted: i=1; AJvYcCWY8580BlQPZ9QOonGycEiprpbcvH7EBIT2rLMb1CBoZnRJi4TfH2VfFTs75A5Fd0j1vx7mAuHLNHmKN3HzbhJlNORfufa8
X-Gm-Message-State: AOJu0YzhyduhZDclDFmyXNhLw5TpAfiKA0vFKymdT7bM2dLBfe2g8bX+
	9u0k6UYh2UB0I82U/jEhqITNRQ6BvxyTb8IZwzWlPcOqWvAm46qP/6CvRp4Ytnh54sd/o8FgOzg
	=
X-Google-Smtp-Source: AGHT+IHwwxXHQZOJDWA79h4kpTrFXlqy3o97odBpLnUw+EVYwBm7Y8JYkBe1X0XcAelmfdZkiokisg==
X-Received: by 2002:a05:622a:64c:b0:439:81f5:efa6 with SMTP id a12-20020a05622a064c00b0043981f5efa6mr162258qtb.31.1713975891041;
        Wed, 24 Apr 2024 09:24:51 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id o24-20020ac86998000000b00437acb8a6basm5788845qtq.6.2024.04.24.09.24.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:24:49 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so594771cf.1
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 09:24:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVboiEb2e6IWL2gmi1HSqxtSkp3/WZpgYqGb5msuG1LBq5lVO6lzFZ6FjxUIZ3rT7so6Q9Wfih7azCVyPInp3NAi8IPSGhQ
X-Received: by 2002:ac8:48c5:0:b0:439:9aa4:41ed with SMTP id
 l5-20020ac848c5000000b004399aa441edmr389310qtr.16.1713975889167; Wed, 24 Apr
 2024 09:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-5-johan+linaro@kernel.org> <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
 <ZijlZw6zm4R9ULBU@hovoldconsulting.com>
In-Reply-To: <ZijlZw6zm4R9ULBU@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Apr 2024 09:24:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vxgu==8Cv3sDydFpEdd6ws2stkZvxvajE1OAFm2BgmXw@mail.gmail.com>
Message-ID: <CAD=FV=Vxgu==8Cv3sDydFpEdd6ws2stkZvxvajE1OAFm2BgmXw@mail.gmail.com>
Subject: Re: [PATCH 4/6] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2024 at 3:56=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Apr 23, 2024 at 01:37:14PM -0700, Doug Anderson wrote:
> > On Tue, Apr 23, 2024 at 6:46=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
>
> > > @@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_clie=
nt *client)
> > >         ihid_elan->ops.power_up =3D elan_i2c_hid_power_up;
> > >         ihid_elan->ops.power_down =3D elan_i2c_hid_power_down;
> > >
> > > -       /* Start out with reset asserted */
> > > -       ihid_elan->reset_gpio =3D
> > > -               devm_gpiod_get_optional(&client->dev, "reset", GPIOD_=
OUT_HIGH);
> > > +       ihid_elan->reset_gpio =3D devm_gpiod_get_optional(&client->de=
v, "reset",
> > > +                                                       GPIOD_ASIS);
> >
> > I'm not a huge fan of this part of the change. It feels like the GPIO
> > state should be initialized by the probe function. Right before we
> > call i2c_hid_core_probe() we should be in the state of "powered off"
> > and the reset line should be in a consistent state. If
> > "no_reset_on_power_off" then it should be de-asserted. Else it should
> > be asserted.
>
> First, the reset gpio will be set before probe() returns, just not
> immediately when it is requested.
>
> [ Sure, your panel follower implementation may defer the actual probe of
> the touchscreen even further but I think that's a design flaw in the
> current implementation. ]
>
> Second, the device is not necessarily in the "powered off" state

Logically, the driver treats it as being in "powered off" state,
though. That's why the i2c-hid core makes the call to power it on. IMO
we should strive to make it more of a consistent state, not less of
one.


> as the
> driver leaves the power supplies in whatever state that the boot
> firmware left them in.

I guess it depends on the regulator. ;-) For GPIO-regulators they
aren't in whatever state the boot firmware left them in. For non-GPIO
regulators we (usually) do preserve the state that the boot firmware
left them in.


> Not immediately asserting reset and instead leaving it in the state that
> the boot firmware left it in is also no different from what happens when
> a probe function bails out before requesting the reset line.
>
> > I think GPIOD_ASIS doesn't actually do anything useful for you, right?
> > i2c_hid_core_probe() will power on and the first thing that'll happen
> > there is that the reset line will be unconditionally asserted.
>
> It avoids asserting reset before we need to and thus also avoid the need
> to deassert it on early probe failures (e.g. if one of the regulator
> lookups fails).

I guess so, though I'm of the opinion that we should be robust against
the state that firmware left things in. The firmware's job is to boot
the kernel and make sure that the system is running in a safe/reliable
way, not to optimize the power consumption of the board. If the
firmware left the line configured as "output low" then you'd let that
stand. If it's important for the line to be left in a certain state,
isn't it better to make that explicit?

Also note: if we really end up keeping GPIOD_ASIS, which I'm still not
convinced is the right move, the docs seem to imply that you need to
explicitly set a direction before using it. Your current patch doesn't
do that.

-Doug

