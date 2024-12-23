Return-Path: <stable+bounces-105598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33309FADA8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028371884299
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46C1993B6;
	Mon, 23 Dec 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEyC5oP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96E192D84
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734953102; cv=none; b=RE7MkT8yQV8crHcRik7sE7iOxk08dCZj5BIuH6WtLzznrZvdoJ4nzmcAnggfCD3MH5GkU/YjbVifJGDM+amKj+jYAbbzFYyy7YiVSoI+d3soD1oZP4L61QJJUtxUL8TNMNkPvvSdz2ujB+fp2sbAFxoFDMggNb/x1BdTNtajYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734953102; c=relaxed/simple;
	bh=s5l2k46EeloYyylKfxdPzqeiZewTDl5wr++ebpvjtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+A+WfHsaQ8Wqdi1neT5haOKCwoo4+L3rek5X4PJ1jaqtYAOs4/vnIj+v2EkhBzzatBz51pySbiIWFRidAc9rZTYcMB4AOMHQ224uFHbalAXAKvB0VFi2nOSKvJ/kAukWualqbt3+GkzUyhfnZ2EUQ9vFc0nal9cVpX9/7XvHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LEyC5oP+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so4378760e87.3
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734953099; x=1735557899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNXt+kf59YlZewLAOuaeZQ47PN1syAYwU8o51h1QyTI=;
        b=LEyC5oP+TtpVy2OI3QzNRalFzapiFvDqGFtm+2DJPETVtOOuRu0ANpc4GAte/TUAQx
         +qDgYk8AniPBGMnXNKHPjdztqAsg+N158epxBEoFycvdqpz4FRo9UlP/jO7mCEoOAP9G
         kzuAvC3fQsEkCFzWQDWmYQPxyzfYg4o6nRMmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734953099; x=1735557899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNXt+kf59YlZewLAOuaeZQ47PN1syAYwU8o51h1QyTI=;
        b=NTBRU0S17mtvRgIqYMwSGjjvcYZzGsSA1HGhk90/onCCYPFK80XM2CZfYnDkG4YvAK
         0+O0X6x393imD37/9qkih15nowunHyfOsCQCevFqNo8FpSFGvqNO2/jpfwUFIFsrrHnx
         lXKCiMWwxyvdMiBsQdix6RcwUpRncE5MV0fFz2ntP6pmFYXTjqXOgKUj9fMwKzvXVpHm
         uh4Vw9dZq6hwAQ8dwKurfl0qnehc58+9jOESWldeJ/0j4tWMD7F7g5XokWwzx1GjhGiA
         VV+ifJLeFldKg5W/mbDpjxwyONSaERAzN8x6DvbHLXn1EHE9UE85GOKIsRptFDm/29t/
         aOvA==
X-Forwarded-Encrypted: i=1; AJvYcCXdFl8gt0r/oCuIyvQFK1/U5SIscPu545r5JDubsdxxxc4WyZ47PYwgurJmVhZjU+oOM+Y3o6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKSRaKUb9J+0nkLljfJzq2ejJ1fnw8nO6NX6B7im/TKXChNDz
	WAh/w3VuizNnDFMTgF7fEiPasOeU2rEtWVg44c6JNltanXzKLgtrnHN7BheBnk2FsmTv5fmzlv0
	N6UUo674mhNbmKQaIwscfbuLcl3Vy7hiBr6BB
X-Gm-Gg: ASbGncsp78Burfy0r/RSkE3rLper5rn2MmJpcrS9tLROrha09GGJMqZy2uAK0LBJMSU
	U5RNkIhdr2c15gO9R9boVIMnJ0MRGApKsG/Gd6Sj0IA8HaU9gkKqRSoCkyg+zYbYh7g==
X-Google-Smtp-Source: AGHT+IHKIcSztKoWb+jH58qNH+TWPshkyeN6Su2LSC+DPVvCbFU5vLIrm5cDbfMBjckzf10FFbvnuzfTNvTJtyiueig=
X-Received: by 2002:a05:6512:2349:b0:540:271f:adef with SMTP id
 2adb3069b0e04-5422953c3efmr4278421e87.24.1734953098810; Mon, 23 Dec 2024
 03:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223100648.2166754-1-wenst@chromium.org> <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
In-Reply-To: <481a6eec-c428-45cd-98a6-5a91f3ceb187@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 23 Dec 2024 19:24:47 +0800
Message-ID: <CAGXv+5Fj5s9FUyaxmEkGimxjEcS6OEfm4_5Zso+YocSi+Vt4pg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing
 for MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 7:11=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/12/24 11:06, Chen-Yu Tsai ha scritto:
> > Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
> > The data needs post-processing into a format that the OPP framework can
> > use.
> >
> > Add a compatible match for MT8188 efuse with post-processing enabled.
> >
>
> Let's just change the MT8188 compatible list to
>
> compatible =3D "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";

That would be "mediatek,mt8188-efuse", "mediatek,mt8186-efuse", "mediatek,e=
fuse"
then?

Fine by me. :D

ChenYu

> instead :-)
>
> Cheers,
> Angelo
>
> > Cc: <stable@vger.kernel.org>
> > Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support =
for MT8188")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >
> > I'm not exactly sure about pointing to the dt bindings commit for the
> > fixes tag.
> > ---
> >   drivers/nvmem/mtk-efuse.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> > index af953e1d9230..e8409e1e7fac 100644
> > --- a/drivers/nvmem/mtk-efuse.c
> > +++ b/drivers/nvmem/mtk-efuse.c
> > @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata=
 =3D {
> >   static const struct of_device_id mtk_efuse_of_match[] =3D {
> >       { .compatible =3D "mediatek,mt8173-efuse", .data =3D &mtk_efuse_p=
data },
> >       { .compatible =3D "mediatek,mt8186-efuse", .data =3D &mtk_mt8186_=
efuse_pdata },
> > +     { .compatible =3D "mediatek,mt8188-efuse", .data =3D &mtk_mt8186_=
efuse_pdata },
> >       { .compatible =3D "mediatek,efuse", .data =3D &mtk_efuse_pdata },
> >       {/* sentinel */},
> >   };
>

