Return-Path: <stable+bounces-41439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0DE8B24FE
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88021F23325
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490714AD19;
	Thu, 25 Apr 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUue0AZn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65F14A633
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058593; cv=none; b=auIf/0OO+ADPirxIt2fLH31T7eug4As6afgW/cxGk+cQnjXWcmkRwV0oCr6K3GRH9HxCdnqri+e/uH4vuTyNKzUziubAFVzj/apvBHDHFG9GuQBlGkpY2BV/CjCqfkT+i0+i5N5bMRdEFJX0I2s+EnhiwYyYFnJVDJ3sGHs//90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058593; c=relaxed/simple;
	bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI0gZZHFozp7kUAPfsbdXTFUhzqyLT3ZsHngriP3+m4sRFIXfHzknWE/+H6nGXwxF6uFh5afoc2sWMmGj3AR1GMuTqoD9/IZL54U2befUjoTl1ktOdw6HA/RY/7PAoOVc6Ibw3dQVe6d/cnVzpLwtPCoz9cbXAln3gc37AfaPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUue0AZn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6a06b12027cso20184076d6.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714058589; x=1714663389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=mUue0AZnE5ty6DERUkqssfyVsxShep+2qc0Pd6+0HUBtR1cBgRvCNiD9HBCOxrEVnq
         9e5vaC8oLgprfoc+0HgVrJ8Ul7OvVLC288jUPlV5MAzrQjdFqZSfZz0birXYRC62Pe3k
         +aJXOSNuZ8J7HEryfBSyVcLmEvBEAVRNDcLXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058589; x=1714663389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=Fa3OKedxmyJj8munQ4I06IsmQbDlw95u+W/cCeEvE355bChtQKXzs0mVxzJsuHTEzN
         NwMU6wRamMamjYaNVxdTLQxrpgNre2t2gSq0S73TTxsNE3rjnJcUvnKRUs4YkJW3Si63
         SCR7ialApdAQFO3DxGrzlLUtVCyepXkV6y29TJAnZisEJ3LWE/PdhsRPY3r7A9qvnDRY
         LVA2ihcTr/SoGxMMRyEe6zJ4noyhox7K/AzUdPKwNzLU+YifmvSepZL+21MnChV3qtLq
         G6189QNDb6P3qGvrIqcfpo/VIDT+A0R8x2+vllihgJb6YDhKj0SGbkyAPb07lVKxz6lU
         bJqA==
X-Forwarded-Encrypted: i=1; AJvYcCVZTvFk41k3gLnjQj4yl2xLtC2NRV11IKzseMnqQk6OVACXu1JAa8pmQDRXuU0jq5ZylJriwBrlkoIATKe5h1Vx8Ix5ql99
X-Gm-Message-State: AOJu0Yyv0oXM6+jBVqIUuSPzZuGAN5G5tQXZtB23iiGYFAj0R96+QrOk
	IugHMjAcghUR86z+pkbLokIezuWwjBXwaR65ZSmoQxzjg9t5YYpkwvtlaJLYb2a7Lz1AcxS1/RA
	=
X-Google-Smtp-Source: AGHT+IHwi82hDjcpoMo5UjpKKxftWFPztuSTjrk+o5iLyJmAh7gxPk9aW11QKO4NqWZchQp3qSdHCQ==
X-Received: by 2002:a05:6214:5298:b0:696:b01d:da51 with SMTP id kj24-20020a056214529800b00696b01dda51mr5166511qvb.10.1714058589046;
        Thu, 25 Apr 2024 08:23:09 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cf58b000000b0069b497fccaesm7110340qvm.124.2024.04.25.08.23.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:23:07 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-436ed871225so320721cf.1
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 08:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY2Yco9A77Ofh6ouAYquRxYNBs6tfuOt8Jdmk6PxhEcdEzNmDheJry2ecPDMvE1s9PfTb1JflOmkifa5JAQo3gXhiKdMIu
X-Received: by 2002:a05:622a:5097:b0:43a:381f:6b11 with SMTP id
 fp23-20020a05622a509700b0043a381f6b11mr264680qtb.19.1714058587159; Thu, 25
 Apr 2024 08:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
In-Reply-To: <ZioW9IDT7B4sas4l@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 23:22:50 +0800
X-Gmail-Original-Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 4:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> > > I assume all Trogdor boards use the same controller, WCN3991 IIUC, bu=
t
> > > if you're worried about there being devices out there using a differe=
nt
> > > address we could possibly also use the new
> > > "qcom,local-bd-address-broken" DT property as an indicator to set the
> > > bdaddr quirk.
> >
> > They all should use the same controller, but I'm just worried because
> > I don't personally know anything about how this address gets
> > programmed nor if there is any guarantee from Qualcomm that it'll be
> > consistent. There are a whole pile of boards in the field, so unless
> > we have some certainty that they all have the same address it feels
> > risky.
>
> Hopefully Janaki and Qualcomm will provide some answers soon.
>
> And otherwise we have another fall back in that we can use the
> "qcom,local-bd-address-broken" property for Trogdor.

Quick question. I haven't spent lots of time digging into the
Bluetooth subsystem, but it seems like if the device tree property is
there it should take precedence anyway, shouldn't it? In other words:
if we think there is built-in storage for the MAC address but we also
see a device tree property then we need to decide which of the two we
are going to use. Are there any instances where there's a bogus DT
property and we want the built-in storage to override it?

-Doug

