Return-Path: <stable+bounces-105911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD19FB245
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF8F7A1E65
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B481A4AAA;
	Mon, 23 Dec 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QShK+YCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BA12C544
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970559; cv=none; b=mGj1E7tuo+O4Spokv+dmbG/SKoMTCAQ0/4YwiV50HmkMuHOKGHIAjrQR0Hi9SeyxmWUQasOFMWGWe+knSplDtdRINapO8Tyhe+6zHQSBH0yGUp+8vCAoYyGnusJ+YLYI8EXW8ciSr8JdqoRBLxly8FlJYVxEVr9Nql06h/7TlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970559; c=relaxed/simple;
	bh=IADWIcU/S1Kw7mv5bQL+l0rFryqq5ETkS9UcF5m44m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5wlaOOZ+yJEcVoN4RJBDAVLcM7zkAZ7iadt5aduJ6TUoogadIRdRoclPLSqWDxLxbv1WPZPyl1uglBzHUQ1MO7psRqpp4A74/RIvFJ/u9mHH5Aw2xlQXGh1+3MbhZpX/3etOeUpK88j2e6ePwHUXBRJme/FRb03/KVRMlnHfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QShK+YCp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53f22fd6887so4133122e87.2
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734970556; x=1735575356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB7tBCInQIuUM3AQKKx7Fq1FBL6zOEzrOCuvM2+REq4=;
        b=QShK+YCpMNEm/lpfwdfdollP3054Os3NBRAWbWFZ2BkHA2r8o+O8maW/MLMPcAzond
         e8UaTMh0sVXokA6DiPlQGHOqtoLbhAhn0RDXosmU5P2IoeTCZJ5Q0zkJuTsW9Eredqw7
         sjdBqq6PI4RHBLSltmwRfvY4tXCC3QBu/+AI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734970556; x=1735575356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB7tBCInQIuUM3AQKKx7Fq1FBL6zOEzrOCuvM2+REq4=;
        b=TrqxRQegf0dixeJQ4u0ubw4hlxmRCQXU2H5ykNKSE2YvoOjVU7mxs8YtgxrPLKxB95
         +LLWjRIj2/TCCAXALue5EjMX7aMd1GDNy5f7FLTQyRHXp+Qn45UaBlWtJGfA+tmBJ3sE
         2gPFwUn0Bn4+wwdfNGoBeGVvPj+zmhuUffasWASagyeTsUQwNL2LBxQmymoUkf4xArbn
         hPDHuHMSUzs8QWwIOQwkMcTD1cCrNrcuckdO7CK1sGs/04BtRkmbGCwoUiVmlniP4qnn
         Z0RI9sk1j2Qy1zqHX0EyeSPp7/iqKXPWhN7fNqvht9OcvxVwgbEfePArOs2nqyzEv4qN
         KnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9dEEqoEaeEPHG2GoeyaG0iLwsXLZ42Uy6kJVTS1py1k3JtbLN6Y7AiTfu0krKQRAEmRPwQOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5mGAbTT93xbA5h1ePY3Zxiq91d30ObFe+joWPY9/Xreo7UNs
	Xa0G1NV49jl4TpkW29NJ4qO4Edt0iJ3YlDEhEhw8gBM9d2EEmN/j0AS42t9fbH9gS3QRVkuiNa5
	BDpVP7V6Kt6u1STQOAFFuM7QznymAzXbCh0HSmYTM5/hVoUI=
X-Gm-Gg: ASbGncsWLr6UnwwT4AVn8EtWcMpzd3LODIA7JMwn0LGoo6bOIy7Y8yxwv8cmYJMD4oh
	Uj3FeeJyuQr+mi4NuShKl/oHUgAfyBa54lCvfjoq4t7unHJECaSdMxKOE8hBvRG5MpmC4
X-Google-Smtp-Source: AGHT+IFBH1qJ5o3N2eKaN46asXp1SlHPERioAIxyZn9uGOni0fB6RlslgaSbmNkUTXINnjQKSbGfbaJdE8Qdm+6COjE=
X-Received: by 2002:a05:6512:234d:b0:540:30df:b3ea with SMTP id
 2adb3069b0e04-54229533d4emr4290450e87.15.1734970555005; Mon, 23 Dec 2024
 08:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223100648.2166754-1-wenst@chromium.org> <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
 <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com>
 <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com> <CAGXv+5FoOM=ZUCWigdCaPbc4FCBtLVX2xnUJnVnVsBH=7yoZ=Q@mail.gmail.com>
 <efb88dd0-3b66-49fe-b279-e66c4574cf9d@collabora.com>
In-Reply-To: <efb88dd0-3b66-49fe-b279-e66c4574cf9d@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Dec 2024 00:15:43 +0800
Message-ID: <CAGXv+5HWcYrCzWJD4e=WP1WVNfqG5Y2_z+_oetWZq2ZKjXP75g@mail.gmail.com>
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 12:08=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/12/24 16:57, Chen-Yu Tsai ha scritto:
> > On Mon, Dec 23, 2024 at 7:43=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
> >>> On Mon, Dec 23, 2024 at 7:11=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
> >>>>> Like the MT8186, the MT8188 stores GPU speed binning data in its ef=
use.
> >>>>> The data needs post-processing into a format that the OPP framework=
 can
> >>>>> use.
> >>>>>
> >>>>> Add a compatible match for MT8188 efuse with post-processing enable=
d.
> >>>>>
> >>>>
> >>>> Let's just change the MT8188 compatible list to
> >>>>
> >>>> compatible =3D "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
> >>>
> >>> That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "medi=
atek,efuse"
> >>> then?
> >>>
> >>
> >> No, we're dropping the generic "mediatek,efuse".
> >
> > That means we also drop it for MT8186?
> >
> > Thinking about it more, I think it's stretching things a bit. The hardw=
are
> > is clearly backwards compatible, or we wouldn't even be reading values
> > out correctly. The only difference now with MT8186 and MT8188 is that
> > they have a speed-bin field with a value that we want passed to the OPP
> > framework, and the interpretation of that value is not really part of
> > the efuse's hardware. We chose to do the conversion in the efuse driver=
,
> > but we could also have done it in the GPU driver.
> >
> > What I'm saying is that we should not need to change the compatible str=
ings
> > to make this work.
> >
>
> No we don't forcefully have to drop it from MT8186, and doing so would be=
 kind
> of hard and actually producing unnecessary breakages with (very) old kern=
els.
>
> Just add a `deprecated: true` to the binding that wants `mediatek,efuse` =
and
> start with MT8188, where 8188 is in enum and 8186 is const.
>
> We can do MT8188 because that'll still work even with old kernels (since =
MT8186
> is there since before MT8188 was introduced), and it's something to enabl=
e a new
> feature.
> This means that there's not going to be any breakage with new DT and old =
kernel.
>
> I want the mediatek,efuse binding to be like the majority of the others a=
cross
> the kernel, so, no generic compatible.

In that case shouldn't the fallback be the oldest SoC in the list?
Maybe MT8173, which is currently marked as deprecated, so we undeprecate it=
?

Certainly not the MT8186.

> Cheers,
> Angelo
>
> >
> > ChenYu
> >
> >> Cheers!
> >>
> >>> Fine by me. :D
> >>>
> >>> ChenYu
> >>>
> >>>> instead :-)
> >>>>
> >>>> Cheers,
> >>>> Angelo
> >>>>
> >>>>> Cc: <stable@vger.kernel.org>
> >>>>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add supp=
ort for MT8188")
> >>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>>> ---
> >>>>>
> >>>>> I'm not exactly sure about pointing to the dt bindings commit for t=
he
> >>>>> fixes tag.
> >>>>> ---
> >>>>>     drivers/nvmem/mtk-efuse.c | 1 +
> >>>>>     1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> >>>>> index af953e1d9230..e8409e1e7fac 100644
> >>>>> --- a/drivers/nvmem/mtk-efuse.c
> >>>>> +++ b/drivers/nvmem/mtk-efuse.c
> >>>>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_p=
data =3D {
> >>>>>     static const struct of_device_id mtk_efuse_of_match[] =3D {
> >>>>>         { .compatible =3D "mediatek,mt8173-efuse", .data =3D &mtk_e=
fuse_pdata },
> >>>>>         { .compatible =3D "mediatek,mt8186-efuse", .data =3D &mtk_m=
t8186_efuse_pdata },
> >>>>> +     { .compatible =3D "mediatek,mt8188-efuse", .data =3D &mtk_mt8=
186_efuse_pdata },
> >>>>>         { .compatible =3D "mediatek,efuse", .data =3D &mtk_efuse_pd=
ata },
> >>>>>         {/* sentinel */},
> >>>>>     };
> >>>>
> >>

