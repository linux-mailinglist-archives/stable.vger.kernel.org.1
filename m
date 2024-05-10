Return-Path: <stable+bounces-43552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD88C2DA7
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445821C20C47
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C59174EED;
	Fri, 10 May 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jy30VooN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BB13D25B
	for <stable@vger.kernel.org>; Fri, 10 May 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715384190; cv=none; b=bI7zrQFkYF2qu0RDx/H2GT3sm9D1aYF9UM3RSfUvwUpNzFTnS66m/mPzCTK8jbc3/rvfyEIno3ZUhn0OFK6UaNkbN1+zzBPRMtvG3BQZIVMZPWojV1VcxcLcXWgM68ojgrt+D3sgGRwus+6IjMhFAEEq7b2Snhf2D0ObFVQi92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715384190; c=relaxed/simple;
	bh=tdd3mEPr8R8mB7AxgVNrZK4bwy+sTsONs5ChPMw/qCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac79UzfPYvgir5qRILQC1a/e7t3pr1MjZJZ7dfRgdH8qyITuiA8aQg9NPX3kExRjtj6OLPg2cQBtvEADELtnRfnZEYrdmHDMxu0TGroTF1XfQaybITP9LZbcH3dbhWFWQakT6Y9YQI/wSauAviLgYggagvGETjtRUGsIBs3qtHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jy30VooN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78ef9ce897bso177740285a.0
        for <stable@vger.kernel.org>; Fri, 10 May 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715384185; x=1715988985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUDP9S9qW3rGQGeBPladTmxRNiWuw5gzHHPdJQsB0VM=;
        b=Jy30VooN56yH0fJ4Eu4aoQZ/8j3N4ivVebbh04MwZCHgQhS2b2qBGi5szYFw9tXX2J
         yyjoDYKG/EkietQROs+KRjx/4P/Q016ecSByT18qGMSBzhM5DEb8fiIeKFt0foohYnX2
         xezmW0iQLl76Q4v/pqPLXnLHm3Oa+DsjCZR0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715384185; x=1715988985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUDP9S9qW3rGQGeBPladTmxRNiWuw5gzHHPdJQsB0VM=;
        b=oAxsSPpPN14pQNI1zLfYFDl1DCJlMW5hn2hDUB/dQA1kgxQyES5Clp4SJGwWqt7ILJ
         XT1+8lzrZMlTPyGAJExOOBtxlASSPE6NFdIuvLtwkaNd7tLHSvQQXrZsGPmVe9NjycBT
         36Na0XT9kVKTcGg0rj6adIJ13FXv+NUpMtC3R4jC3ipdxzKfXUjnE/wZI1X0M6dPB9u0
         p3lXg0EiS+QPH9ppBE9p69mvkD95tX4wsVx8wIJ5S2ip1oP5IeUnhBukLHFj7QTB1YIl
         jsZRnHc7k6s39IosTtYf+FU+XeP5DoWSxZ/srHvDWvVpyhgZ/guVMoPp7840YxTgmejQ
         8VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx8D8kMACi/651oSMcXs8EpnClsk+7q8f1XYpYPoT8Okw5MdmLjtaVkZ0iHA+T29hQ/qKFcJ29cmtsqZqIq6XOWRPPYmoZ
X-Gm-Message-State: AOJu0Yz9dvqTaaqJAEVmxyc6UnwzOM4sFOZ7mEBp/EqRp3202shgLZ8f
	J6WfP6oVPE30yaXbRbb3rMj61FxHNhhjDbZ3vrMxsp1RXPv5e+P8JS/s1P2WWfcqNMXRoBU0XFw
	=
X-Google-Smtp-Source: AGHT+IGG5VyIZliRKObHcGIoyLYe/pqrvs/XUd+qW/59pk4/yU30bj5A6e7cMrGZp+Mn5AxSPGpEFw==
X-Received: by 2002:a05:620a:e86:b0:78e:e8ae:c15d with SMTP id af79cd13be357-792c75ffc9bmr425186585a.63.1715384184783;
        Fri, 10 May 2024 16:36:24 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf31179csm224501385a.105.2024.05.10.16.36.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 16:36:24 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43dfe020675so178391cf.0
        for <stable@vger.kernel.org>; Fri, 10 May 2024 16:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSoDkI1ItRDnqPNPlbb9X/0s79/bcO1F9SZhuM5jDMs7xqbXCUM3ndGbOvm4miyAyk0YE/FH+4K33Bka2fGQ3cGbmF+iEZ
X-Received: by 2002:a05:622a:1f13:b0:43d:fce9:684f with SMTP id
 d75a77b69052e-43e094d0423mr1201921cf.10.1715384182762; Fri, 10 May 2024
 16:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144821.12275-1-johan+linaro@kernel.org> <20240507144821.12275-5-johan+linaro@kernel.org>
In-Reply-To: <20240507144821.12275-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 16:36:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
Message-ID: <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 7:48=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> @@ -40,17 +41,17 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *o=
ps)
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>         int ret;
>
> +       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);

Could probably use a comment above it saying that this is important
when we have "no_reset_on_power_off" and doesn't do anything bad when
we don't so we can just do it unconditionally.


> +
>         if (ihid_elan->vcc33) {
>                 ret =3D regulator_enable(ihid_elan->vcc33);
>                 if (ret)
> -                       return ret;
> +                       goto err_deassert_reset;
>         }
>
>         ret =3D regulator_enable(ihid_elan->vccio);
> -       if (ret) {
> -               regulator_disable(ihid_elan->vcc33);
> -               return ret;
> -       }
> +       if (ret)
> +               goto err_disable_vcc33;
>
>         if (ihid_elan->chip_data->post_power_delay_ms)
>                 msleep(ihid_elan->chip_data->post_power_delay_ms);
> @@ -60,6 +61,15 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *op=
s)
>                 msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms)=
;
>
>         return 0;
> +
> +err_disable_vcc33:
> +       if (ihid_elan->vcc33)
> +               regulator_disable(ihid_elan->vcc33);
> +err_deassert_reset:
> +       if (ihid_elan->no_reset_on_power_off)
> +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);

Small nit about the error label: it sounds as if when you go here you
_will_ deassert reset when in actuality you might or might not
(depending on no_reset_on_power_off). Personally I prefer to label
error jumps based on things I've done instead of things that the error
jump needs to do, so you could call them "err_enabled_vcc33" and
"err_asserted_reset"...

I don't feel that strongly about it, though, so if you love the label
you have then no need to change it.


> @@ -67,7 +77,14 @@ static void elan_i2c_hid_power_down(struct i2chid_ops =
*ops)
>         struct i2c_hid_of_elan *ihid_elan =3D
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>
> -       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> +       /*
> +        * Do not assert reset when the hardware allows for it to remain
> +        * deasserted regardless of the state of the (shared) power suppl=
y to
> +        * avoid wasting power when the supply is left on.
> +        */
> +       if (!ihid_elan->no_reset_on_power_off)
> +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> +
>         if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
>                 msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms=
);

Shouldn't  the above two lines be inside the "if
(!ihid_elan->no_reset_on_power_off)" test? If you're not setting the
reset GPIO then you don't need to do the delay, right?


> @@ -79,6 +96,7 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *=
ops)
>  static int i2c_hid_of_elan_probe(struct i2c_client *client)
>  {
>         struct i2c_hid_of_elan *ihid_elan;
> +       int ret;
>
>         ihid_elan =3D devm_kzalloc(&client->dev, sizeof(*ihid_elan), GFP_=
KERNEL);
>         if (!ihid_elan)
> @@ -93,21 +111,38 @@ static int i2c_hid_of_elan_probe(struct i2c_client *=
client)
>         if (IS_ERR(ihid_elan->reset_gpio))
>                 return PTR_ERR(ihid_elan->reset_gpio);
>
> +       ihid_elan->no_reset_on_power_off =3D of_property_read_bool(client=
->dev.of_node,
> +                                               "no-reset-on-power-off");

Personally, I'd rather you query for the property before you request
the GPIO and then request the GPIO in the "powered off" state just to
keep everything in the most consistent state possible.


-Doug

