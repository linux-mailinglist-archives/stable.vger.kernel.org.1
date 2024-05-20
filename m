Return-Path: <stable+bounces-45447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438198C9FCD
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF9285423
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA00137750;
	Mon, 20 May 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcDWKg0s"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E27FC01
	for <stable@vger.kernel.org>; Mon, 20 May 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219522; cv=none; b=ajAJHmkYW0QeDV1ObAFqFKvigjnXdi3u/TNW/axuOWwsy65kD9VEGtVNu7ZT2KrgKOqKCqhEd4lgTE3A2xXU85gCz2Cn8GyxJKQDffRPlB+NOA4Fr/7lCRok8sT+ji5+66r1Cr43TEiZRI5cIZ35DOIoyb2tRPrF3qJVq330TI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219522; c=relaxed/simple;
	bh=xR38KVD3bbKUAoYUfwjtudqWW7AHDRaw+vcgMm2ki0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSu0xpLIZo/Y+/H3+8zAWb+Hx2T02C6QOwaMwYdwR1a41h2zXcy0rPXqkOodKiChtl10W6IHGQIKZzRuph269byh4ASzW4NkKia4U7CiNRDisZFVxj2MvMeNWUxzCbsbjEqU8BxYv6czHBTzxoP14ThrhqulL0f5GLc62gVHH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jcDWKg0s; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b730fc89bso10007246d6.1
        for <stable@vger.kernel.org>; Mon, 20 May 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716219519; x=1716824319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKPnejpOVVglMsc+d8kH/kXQPdEfmoXhhEf4Gy8y/h4=;
        b=jcDWKg0sCj9Z1di9jCbTIx5rkSsbT3LhrbMyn7yENFnTPNcxNyDJ0zf0d2CHFf34JT
         i576qs6AC94WVfmFFMgIVz3ZdnOGZ9GHmN92EktC2txstqXDkWTSK6hoWeo9Ptu8yLIa
         ZGZL21wAbxmorqAO4T1F1IZj8Gq2/r8mQeISU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219519; x=1716824319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKPnejpOVVglMsc+d8kH/kXQPdEfmoXhhEf4Gy8y/h4=;
        b=VlAkc2hqsbAuaSI27ephtJAomcW1wwTJkAFq3qTy2Bah9+FcPf8jgzILEzJ+T/yyFM
         ZrUk7tZp86JSJv02/eeSYlYYuWZzGteopJ6kr3J8W9Z9439ITBQDsU9+5lBxpn5hp5ad
         Z3iP0jH0n51JYaARAS+QaBNTKlRPySjAumdCrXGZ0m8hf34u28hml2vT7bns9H+gz6gq
         4XgrA7oq6s1MBfYNcpfQh9Tbbj3e5ca5LRlWbU8ddWUqZE/OOw+byzk/SHpm2UEorPi1
         qriY4OUdvarNvyADgrMIAVk049MetzciiluqlG80d0Bssu32RC/2ucBCUDddUGzARCdW
         AMow==
X-Forwarded-Encrypted: i=1; AJvYcCXzF9qVVA6j2cn6MWNW9izJFqAIQOFd5y2udc1RX1FZHW4gwLOsZX9eBTu3u1xE7kpS+NDYdRXXXYGKhL5+4hadaieMr5rE
X-Gm-Message-State: AOJu0YxPhdcNFtajMFBFhpG1/g5w58Mt+Kfurg8cWDtOW5ny0fF5yBIC
	wTOtemBPYEVUwPHA8PKXfZQACDelZK0rs5IpyZkKHJmFJTgqo2JTGMyKHejs7ta8HrSIUVhRRmI
	=
X-Google-Smtp-Source: AGHT+IFLMwYJxlNHuF8FRy7ZBXhOO6BqmYRdIkfbjaYMkMHsrb4j8s92uhcLLXL7cnb0AZ1oGsHFXw==
X-Received: by 2002:a05:6214:5bc5:b0:6a3:53cd:40a2 with SMTP id 6a1803df08f44-6a353cdd87emr194871576d6.50.1716219518818;
        Mon, 20 May 2024 08:38:38 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a3490f0fc2sm67720006d6.63.2024.05.20.08.38.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:38:37 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43dfe020675so648011cf.0
        for <stable@vger.kernel.org>; Mon, 20 May 2024 08:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMnC231vjKED/yLOKNHPlvTq8FDGJVSvH5Ut0XC/mGC8qJz5nU7c4xr6vsulYlX6/Tx24pmjNZxe6ZN3FWJEWBOk5O8jId
X-Received: by 2002:a05:622a:5917:b0:43e:ec2:4bb8 with SMTP id
 d75a77b69052e-43f797e0ecemr5611191cf.26.1716219516885; Mon, 20 May 2024
 08:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144821.12275-1-johan+linaro@kernel.org>
 <20240507144821.12275-5-johan+linaro@kernel.org> <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
 <Zks3hp5iUhTe3rLH@hovoldconsulting.com> <Zks5gJ7H6ZuWr_Xm@hovoldconsulting.com>
In-Reply-To: <Zks5gJ7H6ZuWr_Xm@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 May 2024 08:38:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDdc_YgZ=JGamWpdyCgAM_0szk-m_RgUnkDA9m1zbzWw@mail.gmail.com>
Message-ID: <CAD=FV=UDdc_YgZ=JGamWpdyCgAM_0szk-m_RgUnkDA9m1zbzWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 20, 2024 at 4:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, May 20, 2024 at 01:44:06PM +0200, Johan Hovold wrote:
> > On Fri, May 10, 2024 at 04:36:08PM -0700, Doug Anderson wrote:
> > > On Tue, May 7, 2024 at 7:48=E2=80=AFAM Johan Hovold <johan+linaro@ker=
nel.org> wrote:
>
> > > > @@ -67,7 +77,14 @@ static void elan_i2c_hid_power_down(struct i2chi=
d_ops *ops)
> > > >         struct i2c_hid_of_elan *ihid_elan =3D
> > > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > > >
> > > > -       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > > +       /*
> > > > +        * Do not assert reset when the hardware allows for it to r=
emain
> > > > +        * deasserted regardless of the state of the (shared) power=
 supply to
> > > > +        * avoid wasting power when the supply is left on.
> > > > +        */
> > > > +       if (!ihid_elan->no_reset_on_power_off)
> > > > +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > > +
> > > >         if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
> > > >                 msleep(ihid_elan->chip_data->post_gpio_reset_off_de=
lay_ms);
> > >
> > > Shouldn't  the above two lines be inside the "if
> > > (!ihid_elan->no_reset_on_power_off)" test? If you're not setting the
> > > reset GPIO then you don't need to do the delay, right?
> >
> > Yes, I guess you're right. The off-delay is weird and not normally used=
,
> > but apparently it is needed by some panel-follower use case. AFAICT it'=
s
> > not even related to the reset line, just a hack to add a delay before
> > the panel is reset by some other driver (see f2f43bf15d7a ("HID:
> > i2c-hid: elan: Add ili9882t timing")).
> >
> > I think that's why I just looked the other way and left this little
> > oddity here unchanged.
>
> Hit send too soon.
>
> Since this hack does not appear to be related to the reset line, I think
> it's correct to not have it depend on whether the reset line is asserted
> or not (e.g. as there could be 'panel-followers' with
> 'no_reset_on_power_off'):
>
>          The datasheet specifies there should be 60ms between touch SDA
>          sleep and panel RESX. Doug's series[1] allows panels and
>          touchscreens to power on/off together, so we can add the 65 ms
>          delay in i2c_hid_core_suspend before panel_unprepare.
>
> The power-off delay variable should probably be renamed, but that's a
> separate change.
>
> So I think v2 of this series is good to go.

Sure. As I think we've seen in the past, my choice of bikeshed paint
color seems to be quite different than yours, but nothing here seems
like it needs to block landing, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

