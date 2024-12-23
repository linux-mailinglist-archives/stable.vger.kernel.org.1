Return-Path: <stable+bounces-105638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95879FB0F2
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CEF166385
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD61AF0AF;
	Mon, 23 Dec 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PS4x2B+2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E41A8F84
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969445; cv=none; b=TJ03kYuEKPlHknsvA8Lac1jaFkea/WMmGxPpmbJPx9dwNvbFBV0pCCpvasFOwwJOTEQW1qXpzdkN0b4iw9FCvvanyFWfO+OheBDNqLPFtst2Y+9K60JSV/PDhFZWqDwcD9gEH6/Q7lDjvtDA+9im6YatGZuCMmVWvz57uCimX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969445; c=relaxed/simple;
	bh=aAPMb8+64G9x61uzph+9QuQsubOjCofvBvlqFR2lLh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvmBfCd/SkoBySYd3k2m2pZwN8nwce5x3s2yOQ+hqC86J2bs3aSSi4yRQ9eg2qAotsE7adggNXzFkxIighzQAGWB6l8swpah26KR+8zR6sgayoKXrVmLa6RX4JMIiiSahv1Rp9l+rtjja6u319NIcbUM22traM4A97EXb5HEAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PS4x2B+2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so4640267e87.3
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734969442; x=1735574242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHNh6xaotAcDhMoavkjLsKkfYgn6RRMW6uLTCVB7138=;
        b=PS4x2B+2miF8gOZD6q0NN3jCc5+WOgYCCFtCLdLjouJvhZO3owlIVvZG6i/n7rUztL
         T/mZpA44v8q9dCD4UDi96jY3+XGklSn4RBj0l69UeMDpdKyqNHFKbqLpF8Iv23dLdIbT
         PHOPQsnroE1HJOH7poh6uI6IGLQ/1iumhoPas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734969442; x=1735574242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHNh6xaotAcDhMoavkjLsKkfYgn6RRMW6uLTCVB7138=;
        b=kXsUfG3O/VpYcUS6jEY3R33pMRPTT307+WhFNm3sHTJLPHF4SReXwYuZqyAFzlwrb+
         5R6wW4mdMhnoULfzfToPeAW0K+xqldlLoSMpbwnvNP2Jmxcz4l9z2Cf7b1aM3r8Vdsb/
         /5tmncwiGpVmh6swozBN2RHgN0Yg01T5NiwRyGZi5DuXlQMNnvjPpKOTsQ8xWSCO30Ij
         5kt68qwA58kBhChAXJZGEihmfxQ1llIBNrr0ZFZp+MDpNE9A5Yi0akE6NTowOJAOlD/u
         QXIkhX5QCHRMwtaLDzUL76BOqI4znGBJtx8hnb/uJHrqhl9Z7au7ep3pJk3LBPj3Hvf2
         QMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtC7BiAgEEv0GdhWI+/D8b4loHFAlq2kXIkFjC1UYl84cEMkKsDi5uYKj1kaBhGsi+twhjhts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdvmzchkkIDPDEMyyrSnbc9izB6ouo2xuwm+fchVpPllY/U1h
	K4eOSPHluqoTqEvtvlEpfBkqyXE4fDGl7bwNVsXmtqFB0DAHjr4/Ln4BHLhjki5lVgiNB29mBzW
	zEbf8KoJLgcAZqUuDuQXlJ0z4DGty0d/zDlb8
X-Gm-Gg: ASbGncurTYgo/yklVGL33TCn7BNAmMruKG6nnASQ3CwV+ciDaa4GbRQLlVl/+JaEbgk
	f2LbVzsAkNEJ0Ff/RAo+6+nVXKgNdmcVAb6UJXxW5vywkefVaOa9gKBexN+4M3ZV8tt30
X-Google-Smtp-Source: AGHT+IHTk73CF3J9qpxOzp/CqtNyBOpJFRPOv7NC03ghiS4H+MWUanEiEeuA9ExDqorhspKiS3iAgAIzB0xD0pfy6TY=
X-Received: by 2002:a05:6512:33cd:b0:540:358d:d9b7 with SMTP id
 2adb3069b0e04-5422957ac6cmr4243801e87.52.1734969442045; Mon, 23 Dec 2024
 07:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223100648.2166754-1-wenst@chromium.org> <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
 <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com> <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com>
In-Reply-To: <bbc6aa2a-fe48-4e06-b070-fd66dbd00e15@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 23 Dec 2024 23:57:10 +0800
Message-ID: <CAGXv+5FoOM=ZUCWigdCaPbc4FCBtLVX2xnUJnVnVsBH=7yoZ=Q@mail.gmail.com>
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 7:43=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/12/24 12:24, Chen-Yu Tsai ha scritto:
> > On Mon, Dec 23, 2024 at 7:11=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
> >>> Like the MT8186, the MT8188 stores GPU speed binning data in its efus=
e.
> >>> The data needs post-processing into a format that the OPP framework c=
an
> >>> use.
> >>>
> >>> Add a compatible match for MT8188 efuse with post-processing enabled.
> >>>
> >>
> >> Let's just change the MT8188 compatible list to
> >>
> >> compatible =3D "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
> >
> > That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediat=
ek,efuse"
> > then?
> >
>
> No, we're dropping the generic "mediatek,efuse".

That means we also drop it for MT8186?

Thinking about it more, I think it's stretching things a bit. The hardware
is clearly backwards compatible, or we wouldn't even be reading values
out correctly. The only difference now with MT8186 and MT8188 is that
they have a speed-bin field with a value that we want passed to the OPP
framework, and the interpretation of that value is not really part of
the efuse's hardware. We chose to do the conversion in the efuse driver,
but we could also have done it in the GPU driver.

What I'm saying is that we should not need to change the compatible strings
to make this work.


ChenYu

> Cheers!
>
> > Fine by me. :D
> >
> > ChenYu
> >
> >> instead :-)
> >>
> >> Cheers,
> >> Angelo
> >>
> >>> Cc: <stable@vger.kernel.org>
> >>> Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add suppor=
t for MT8188")
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> ---
> >>>
> >>> I'm not exactly sure about pointing to the dt bindings commit for the
> >>> fixes tag.
> >>> ---
> >>>    drivers/nvmem/mtk-efuse.c | 1 +
> >>>    1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> >>> index af953e1d9230..e8409e1e7fac 100644
> >>> --- a/drivers/nvmem/mtk-efuse.c
> >>> +++ b/drivers/nvmem/mtk-efuse.c
> >>> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pda=
ta =3D {
> >>>    static const struct of_device_id mtk_efuse_of_match[] =3D {
> >>>        { .compatible =3D "mediatek,mt8173-efuse", .data =3D &mtk_efus=
e_pdata },
> >>>        { .compatible =3D "mediatek,mt8186-efuse", .data =3D &mtk_mt81=
86_efuse_pdata },
> >>> +     { .compatible =3D "mediatek,mt8188-efuse", .data =3D &mtk_mt818=
6_efuse_pdata },
> >>>        { .compatible =3D "mediatek,efuse", .data =3D &mtk_efuse_pdata=
 },
> >>>        {/* sentinel */},
> >>>    };
> >>
>
>

