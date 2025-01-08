Return-Path: <stable+bounces-107971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D2A0533E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 07:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1549A3A28B9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292401A7255;
	Wed,  8 Jan 2025 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UlSpvOb0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307019EEBF
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318219; cv=none; b=B/vTjjaHsPbx0ayI7SmzHhP02j3xI5+rUoLz04rFxtY3+5mDsk/XqhO6Ne5/qZUMjpxRV7XHZ82mk0DhbctmxP1Jd5JeuuTmbuD3vSyPv+qF349xhmgJusZtnY2Vrmna17gpmeStxIBYRH91ZS5vni8F//wbfGW/AwheFJWXBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318219; c=relaxed/simple;
	bh=X6nvoo7zuqVM8JAr3Jye57IG+Y8Xrf+0remfx0tmywo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBR7KybcMpgnKm4B54CBSj7OisYnsG6pwdcCdW5XqXZE5y5V9w7HSA1ScZU9p8wmcr0FL6uezVm/pGJtoTxQ5omZ9en4r++uCNCJRI7mxibLz7EUKYVd9kL8vjZpPJIyn2T1ja7dmUNt90mf1eDbuj8Uko2NEGyKUuB7R6QNiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UlSpvOb0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so182391551fa.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 22:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736318216; x=1736923016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Nc1mY/MdHNTD26dunvUUor60YcWZhxt/SzPCNrCbBU=;
        b=UlSpvOb0JgddXjrrp1FrvA4jsIC5lb/4hrOK63GoiWSXA5OvjoqhjP4MStCUA9AtP+
         VfTFU9Hs0Dt92VZkRBTu1fveb8zU3Bln0xOtKiE20rNYxnvyt0w+BO7PwOv7BTQKGl2h
         uuXlk0A7LIa3SV5zTpwyuOWQEBL9W1BSJB8fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736318216; x=1736923016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Nc1mY/MdHNTD26dunvUUor60YcWZhxt/SzPCNrCbBU=;
        b=KiNmvDS846qRnlmcLLL8EispCO4WYqhZrGEHdLmytfbQTcObt12XvORG2bGjwNBEYc
         V/4mqNf9IOqFWnxhgoiFSzegTyxHO2H4UrOBrzTGIdW3fd3kRvfjmvcofIy5Ctx3fjzz
         OvLgQeRcIJxlT2sTPYOm57qroKvVGOB0rsmffx0cBlBRqNjl6ms1RNuZvRqhtDvrKxVF
         p9YqMtkvpkFabNmK/zV68DquD3ium3jVNa8OSKRpbhhiJFxwnTVpZoU05nyOySsckQw+
         HtgQHf46e78LoCevCvhG2CKrVZLVOpeWYggjb/9kh98r0RaGpi9iDe1M15NkI1Vm1KLh
         eLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0SEtbgezukDxYbDZa0h+DVaVm3u25jGFM0xGiuje1+OCpjDfpsvSL2+zOxDFP5JoCf7iz5NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwejLwMiPIPd7JbLOgZJ3R2YxGlI3yh6SZ/uPSuhIFZMRcVAr5I
	twGjYrOU6LXOoncHVa3Ye5CH5fXMJzgAx1CfY8xsTFrFebL58mtnFJlkWqctgE0QejJDeJAHZ0f
	O0Fv1JMKFWNjqhqsmca9N5EGLX1sT3HjRPAwAvUG1wfTrog9AgA==
X-Gm-Gg: ASbGncuyKSJqrXJvDVcp6XiEtTJMcH9ywqat6G6pWX6udsqAuBmtmxeBQT9SOS4XIFC
	dAYQmqX53ar/czKSlFCV/66urJsy7IJvbBqHrDzuYX1M8HikwSBHoNuTnXPhDNixRpw==
X-Google-Smtp-Source: AGHT+IGHVkym1t/Pb1hcHJ4RbcQBDkTuC3OWyRXgFvvWFc+8sjFU+XQFXPNW+BW5Ozs5wI3/m0uRHByMTrGZF+sWK7w=
X-Received: by 2002:a05:6512:31d2:b0:53e:3a73:6ddc with SMTP id
 2adb3069b0e04-542845c55f0mr421253e87.33.1736318215416; Tue, 07 Jan 2025
 22:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223100648.2166754-1-wenst@chromium.org> <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
 <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com>
 <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com> <CAGXv+5FoOM=ZUCWigdCaPbc4FCBtLVX2xnUJnVnVsBH=7yoZ=Q@mail.gmail.com>
 <efb88dd0-3b66-49fe-b279-e66c4574cf9d@collabora.com> <CAGXv+5HWcYrCzWJD4e=WP1WVNfqG5Y2_z+_oetWZq2ZKjXP75g@mail.gmail.com>
 <eda10efe-a301-45d3-9bf6-088275db7af5@collabora.com>
In-Reply-To: <eda10efe-a301-45d3-9bf6-088275db7af5@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 8 Jan 2025 14:36:44 +0800
X-Gm-Features: AbW1kvbDKrbFQjU6XyUH5Hc8L3tHpZUYKW41Cjn0PmEo8btxf4x5xJJU_HtXlkg
Message-ID: <CAGXv+5EdU-8__5uTpcX2JT0Lw=kXraVpnMLjgcJS1jrN_zwAww@mail.gmail.com>
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:12=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/12/24 17:15, Chen-Yu Tsai ha scritto:
> > On Tue, Dec 24, 2024 at 12:08=E2=80=AFAM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 23/12/24 16:57, Chen-Yu Tsai ha scritto:
> >>> On Mon, Dec 23, 2024 at 7:43=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
> >>>>> On Mon, Dec 23, 2024 at 7:11=E2=80=AFPM AngeloGioacchino Del Regno
> >>>>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>>>
> >>>>>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
> >>>>>>> Like the MT8186, the MT8188 stores GPU speed binning data in its =
efuse.
> >>>>>>> The data needs post-processing into a format that the OPP framewo=
rk can
> >>>>>>> use.
> >>>>>>>
> >>>>>>> Add a compatible match for MT8188 efuse with post-processing enab=
led.
> >>>>>>>
> >>>>>>
> >>>>>> Let's just change the MT8188 compatible list to
> >>>>>>
> >>>>>> compatible =3D "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
> >>>>>
> >>>>> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "me=
diatek,efuse"
> >>>>> then?
> >>>>>
> >>>>
> >>>> No, we're dropping the generic "mediatek,efuse".
> >>>
> >>> That means we also drop it for MT8186?
> >>>
> >>> Thinking about it more, I think it's stretching things a bit. The har=
dware
> >>> is clearly backwards compatible, or we wouldn't even be reading value=
s
> >>> out correctly. The only difference now with MT8186 and MT8188 is that
> >>> they have a speed-bin field with a value that we want passed to the O=
PP
> >>> framework, and the interpretation of that value is not really part of
> >>> the efuse's hardware. We chose to do the conversion in the efuse driv=
er,
> >>> but we could also have done it in the GPU driver.
> >>>
> >>> What I'm saying is that we should not need to change the compatible s=
trings
> >>> to make this work.
> >>>
> >>
> >> No we don't forcefully have to drop it from MT8186, and doing so would=
 be kind
> >> of hard and actually producing unnecessary breakages with (very) old k=
ernels.
> >>
> >> Just add a `deprecated: true` to the binding that wants `mediatek,efus=
e` and
> >> start with MT8188, where 8188 is in enum and 8186 is const.
> >>
> >> We can do MT8188 because that'll still work even with old kernels (sin=
ce MT8186
> >> is there since before MT8188 was introduced), and it's something to en=
able a new
> >> feature.
> >> This means that there's not going to be any breakage with new DT and o=
ld kernel.
> >>
> >> I want the mediatek,efuse binding to be like the majority of the other=
s across
> >> the kernel, so, no generic compatible.
> >
> > In that case shouldn't the fallback be the oldest SoC in the list?
> > Maybe MT8173, which is currently marked as deprecated, so we undeprecat=
e it?
> >
> > Certainly not the MT8186.
> >
>
> MT8173 doesn't have the post processing enabled.... if you can test that =
the code
> actually works for MT8173 as well, giving meaningful results, then we can=
 just use
> the MT8173 compatible :-)

What I'm saying is (and hopefully I regenerated my thoughts correctly)
that if we want to get rid of the generic compatible string, then we
need a base fallback string. The MT8173 one would be the one.

The MT8186 efuse at the hardware level AFAIK is no different to the
MT8173 one. They simply store bits. How the bits are allocated is
defined by the layout. How the bits are interpreted is also not
a property of the hardware.

In the current design the need for post-processing does not depend on
the SoC itself, but rather the node name being "gpu-speedbin". Even
if we turned on post processing for all models, it wouldn't matter
for the other SoCs.

And the reason the conversion is in the nvmem driver (the provider)
rather than panfrost (the consumer) has nothing to do with the
hardware. IIRC you simply wanted to provide a generic implementation.
If the conversion were in the GPU driver, we wouldn't special case
MT8186 here. If the speedbin value were split into two or more
cells, we probably would have stuck the conversion in the GPU
driver.

So, we could have "mediatek,mt8173-efuse" replace "mediatek,efuse"
as the fallback compatible, and turn on post processing for it,
and things would be the same as before, and also work for MT8188.
How does that sound?


Interestingly, the new "fixed layout" description actually allows
for compatible strings in the NVMEM cells. That would allow matching
against a cell's compatible string instead of its name.


Thanks
ChenYu

> >> Cheers,
> >> Angelo
> >>
> >>>
> >>> ChenYu
> >>>
> >>>> Cheers!
> >>>>
> >>>>> Fine by me. :D
> >>>>>
> >>>>> ChenYu
> >>>>>
> >>>>>> instead :-)
> >>>>>>
> >>>>>> Cheers,
> >>>>>> Angelo
> >>>>>>
> >>>>>>> Cc: <stable@vger.kernel.org>
> >>>>>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add su=
pport for MT8188")
> >>>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> I'm not exactly sure about pointing to the dt bindings commit for=
 the
> >>>>>>> fixes tag.
> >>>>>>> ---
> >>>>>>>      drivers/nvmem/mtk-efuse.c | 1 +
> >>>>>>>      1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.=
c
> >>>>>>> index af953e1d9230..e8409e1e7fac 100644
> >>>>>>> --- a/drivers/nvmem/mtk-efuse.c
> >>>>>>> +++ b/drivers/nvmem/mtk-efuse.c
> >>>>>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse=
_pdata =3D {
> >>>>>>>      static const struct of_device_id mtk_efuse_of_match[] =3D {
> >>>>>>>          { .compatible =3D "mediatek,mt8173-efuse", .data =3D &mt=
k_efuse_pdata },
> >>>>>>>          { .compatible =3D "mediatek,mt8186-efuse", .data =3D &mt=
k_mt8186_efuse_pdata },
> >>>>>>> +     { .compatible =3D "mediatek,mt8188-efuse", .data =3D &mtk_m=
t8186_efuse_pdata },
> >>>>>>>          { .compatible =3D "mediatek,efuse", .data =3D &mtk_efuse=
_pdata },
> >>>>>>>          {/* sentinel */},
> >>>>>>>      };
> >>>>>>
> >>>>
>
>

