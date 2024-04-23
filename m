Return-Path: <stable+bounces-40765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7C78AF814
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 22:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77E0B21713
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34D142E65;
	Tue, 23 Apr 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGcpfzFY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB41F95E
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904651; cv=none; b=qhbSAg1qsza0j6YJz153o0UQ3xiwmC9k3y8dldAwCqdy5mgcRz1o/4UfswtzmBfHGcPLRqK72MiWlPKlAUhl8hq1Sq7qQbbEFUM9dAzh/yAWHHZL8k6rxJJaJOkpPIU7DRg99VpAodKfP9qb3bZFzXrimemZg+MZmsgfD841BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904651; c=relaxed/simple;
	bh=rfhmOs1XODOFJs1l4DWhrD2bkxios+soWFbzgeUP8Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOHzLb8WuT0PMjDtNdfQL+Ub31o6wXIVEMkIc7bJ08JOMOiq8mKQ0xAYYxPrLAPWEv86537FlB0oIAryekvfhH/lviOHbmQpTZnk+grt8t4YmN6JaAS+kONQe/A5PhEWlej9tMMcJ3qZb59rHT/LUf/r8gNnOWlSKZRfvPd+HMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GGcpfzFY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f049ddd7dso455085685a.1
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713904648; x=1714509448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Z4Xephtak0B6Z0C10bXQoxaaScZEGJ8HuSBBJAqAk=;
        b=GGcpfzFYUJLBQnGwSWyhreb9yGqz7lbtwpIgktXrvLVkfuvg7TR1hSgevNYM5o8fSw
         0hWI/PJImoPnWf2/NEzwsFT0YHTJiRw/BFgL2TB/VOCic+WezZ9A3mrJCzMSUH3jkSOo
         PbeqMME/OMN0P1zVcHGsRElSpFyiIuJj75cIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904648; x=1714509448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Z4Xephtak0B6Z0C10bXQoxaaScZEGJ8HuSBBJAqAk=;
        b=hoA43/7DIlEXTELVBjYYmCCFqogDnREbv/yztbewk5aCEg/EpOn7eXoX9t8BupcEAx
         pTIsKvVwsEVwbtl69lvt/eUAY/SFXEKP+LW8wEx+uZyDq0qbvjQfgt0J/1v4N5xxXlDb
         QBvY5FVOoVsCSj6dMtur8CuLs3sUOVSVXSfhANMxUoeWzjjrKZkiiqbYmh8fVE62Mmpx
         K0Srao3T8cwxk19zm+Kso9xJxesAthkpGNE++Z2rG/eYw7kgXzdOC6CtD56JR6nH+Mlz
         qT7QvdsaNYDepueVIihPkQ/pNIArR/f9Ngu4mIdzRTScWF4YPBVZ7dXHkiLKyQ/YitCi
         WSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnaor52GU+54m97CkIEYeFYT/vlwENWQLs06pIo8svj99T+Xb7Lfp/PhTomKJ0N6BBVhvf8SmqSpC6Ca8oFn0Y6NNT7qTf
X-Gm-Message-State: AOJu0Yx5hB/zxOCYANgceEPnm0TuPWbYuTUAnN7+267kqSXVFnSPboTj
	zlCgdM4R+m4xBtC7ScYzkhbbKJPsIsi8g4TmHvJKwbkmaNmLHrg4CCCuY2zzlMPnOUoqYiJIlBR
	fnn+e
X-Google-Smtp-Source: AGHT+IEuAz8izIo93fGSSBoOGx35+Ysi0PGVtQZ0Fc1R4M+u3P4XiFD4Dx9g1AKleXYM4aMyj4lHQg==
X-Received: by 2002:a05:620a:1a9e:b0:790:64f6:e34a with SMTP id bl30-20020a05620a1a9e00b0079064f6e34amr892103qkb.35.1713904647831;
        Tue, 23 Apr 2024 13:37:27 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05620a45a700b007905f0d28c8sm3976209qkb.30.2024.04.23.13.37.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 13:37:27 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434ffc2b520so45891cf.0
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFx51yntT9qOJHb2p3C/rzbUaM8I2TnK7NOrrWGTsgnlKvvtZakg9HRrpLd+C2roChQFcxIS+sH1ozoaWaJ9e/zkVQ1pb6
X-Received: by 2002:ac8:48c5:0:b0:439:9aa4:41ed with SMTP id
 l5-20020ac848c5000000b004399aa441edmr71354qtr.16.1713904646630; Tue, 23 Apr
 2024 13:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134611.31979-1-johan+linaro@kernel.org> <20240423134611.31979-5-johan+linaro@kernel.org>
In-Reply-To: <20240423134611.31979-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 13:37:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
Message-ID: <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 6:46=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> @@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_client *=
client)
>         ihid_elan->ops.power_up =3D elan_i2c_hid_power_up;
>         ihid_elan->ops.power_down =3D elan_i2c_hid_power_down;
>
> -       /* Start out with reset asserted */
> -       ihid_elan->reset_gpio =3D
> -               devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_=
HIGH);
> +       ihid_elan->reset_gpio =3D devm_gpiod_get_optional(&client->dev, "=
reset",
> +                                                       GPIOD_ASIS);

I'm not a huge fan of this part of the change. It feels like the GPIO
state should be initialized by the probe function. Right before we
call i2c_hid_core_probe() we should be in the state of "powered off"
and the reset line should be in a consistent state. If
"no_reset_on_power_off" then it should be de-asserted. Else it should
be asserted.

I think GPIOD_ASIS doesn't actually do anything useful for you, right?
i2c_hid_core_probe() will power on and the first thing that'll happen
there is that the reset line will be unconditionally asserted.

Having this as "GPIOD_ASIS" makes it feel like the kernel is somehow
able to maintain continuity of this GPIO line from the BIOS state to
the kernel, but I don't think it can. I've looked at the "GPIOD_ASIS"
property before because I've always wanted the ability to have GPIOs
that could more seamlessly transition their firmware state to their
kernel state. I don't think the API actually allows it. The fact that
GPIO regulators don't support this seamless transition (even though it
would be an obvious feature to add) supports my theory that the API
doesn't currently allow it. It may be possible to make something work
on some implementations but I think it's not guaranteed.

Specifically, the docs say:

* GPIOD_ASIS or 0 to not initialize the GPIO at all. The direction must be =
set
  later with one of the dedicated functions.

So that means that you can't read the pin without making it an input
(which might change the state if it was previously driving a value)
and you can't write the pin without making it an output and choosing a
value to set it to. Basically grabbing a pin with "asis" doesn't allow
you to do anything with it--it just claims it and doesn't let anyone
else have it.

-Doug

