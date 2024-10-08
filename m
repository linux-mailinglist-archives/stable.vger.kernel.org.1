Return-Path: <stable+bounces-81558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7299451E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358B4B230C5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82214192591;
	Tue,  8 Oct 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nW0Kx50R"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8018DF65
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382480; cv=none; b=uMpPakVofuzkTY6zg+LhaWTa7NZhTLsD827rvvxqimfxxRogu8kVfi5SF6DxCnqDHgkvQ0XswBHCZRMuvtsaTFHfEB5HSzEXa3BFnY8J5OvfSS1XHutg0ayywQnXx6khQ5SNFlSd1zIXRzBJd5lBaE05VnGEOE1IL1OwdcgOzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382480; c=relaxed/simple;
	bh=gCO4pfao+ZNUNhhT62kkXLvM/cVTKwpWtZ6gWmNfst8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7T1MG/Q4QowhDm91e6KoYgG+PHXfLL7dZMVj4SwMhtIlLfv+j2TNIMb83jO6kIZZdrYSKOFma7wiqBYluWVkEq3o4QNjtHjxPclLFNgF5Cq44CS9rvi03hG8jlHlyBl+FwxNKqEMgJgeYk8KnCk3+vnNJ7ogyLdFNrEkx2EKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nW0Kx50R; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398a26b64fso5298712e87.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728382477; x=1728987277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNsu9nK1jAUO1Ldt/+9/ISvxpOMLIyS2jgvXo4aXxhQ=;
        b=nW0Kx50REKMz82b+gQxFBTUGj2P4UYXd6Vcvyo9AdcDiHmGXdbTGPoZ0rf3f33k8sV
         zqpTbNTrS2ey4VH2cXW6JUIcRXHD+Jg8KztBvZ3zT2Qii08qMlOhW1jAVpHJj0tQQeno
         Oy65oYMwlDycEazHozNqci+81Mvye2AY+r978=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382477; x=1728987277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNsu9nK1jAUO1Ldt/+9/ISvxpOMLIyS2jgvXo4aXxhQ=;
        b=h+1TfFxop0jQSH5dsX4o0CmN4xFZ42Ss1ZzZ30cN/io6TMBWExIMk+Zpa2IBVrI7az
         msdpOErgl2fiubFNaYzU3N9ExkNO5JiMHb5T8noq+yxbZjoek6ZCT3e1YUUdKOfMoLSd
         c2gc/2WNeaHSnZlnyXxOdlrpovPU7n2RWpseD29yhz/5dTekfUaCRWWP6awCjSyz14Kl
         R4UFxL67x9dKT8FK9auwWqnwI/2hijG67aZPhmqE0TWElpdYA+fPlgu/1flgO6uMflBK
         l4TwXShMilJuJ9vmfFoNwLahhmYUEnOGUOZgY3mYRBvJQwwHiWVcLcRdxgsy9UP19e2v
         5rlg==
X-Forwarded-Encrypted: i=1; AJvYcCWswqn4FSnki8qSaYjPJwotF0EfixkZS94KPAquFYyAB/yI6gliV2EvuMqlv+7AEYD4PLZXjIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYSAzWWyloNm969FaerCPG3SY0FfMr5Lot552/bSoPtrNEPty
	9O4lSo72l6DuedQ32MNa9dcAthntPJryvh9xo+v2zPd3VG5iP6atI935XhHFeKrtjWDor4ElYc3
	kQB0mRz2wEfOIjoxMNd/IW1GG+3iXeMxfu4gR
X-Google-Smtp-Source: AGHT+IGF9lC0snzvw5z5AN3DUk1MeiK5PHXImnz7s9F0EqPgF1mS/GGKJJ2oiGoWdynH8LJtt2a8fXMLMXD7PTKHv8s=
X-Received: by 2002:a05:6512:2204:b0:539:896e:46c0 with SMTP id
 2adb3069b0e04-539ab9eaddfmr7534098e87.37.1728382476550; Tue, 08 Oct 2024
 03:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008082200.4002798-1-wenst@chromium.org> <7caa85fa-7186-4f8f-8195-19325ebf06bd@collabora.com>
In-Reply-To: <7caa85fa-7186-4f8f-8195-19325ebf06bd@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Oct 2024 18:14:25 +0800
Message-ID: <CAGXv+5FgPOh4kNdrG1uN-NOWEpC5rXvsr0egTsgOw+v_E3vdRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge
 speaker codec nodes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 08/10/24 10:21, Chen-Yu Tsai ha scritto:
> > The Voltorb device uses a speaker codec different from the original
> > Corsola device. When the Voltorb device tree was first added, the new
> > codec was added as a separate node when it should have just replaced th=
e
> > existing one.
> >
> > Merge the two nodes. The only differences are the compatible string and
> > the GPIO line property name. This keeps the device node path for the
> > speaker codec the same across the MT8186 Chromebook line.
>
> Ok, I agree...
>
> But, at this point, can we rename `rt1019p` to `speaker_codec` instead?
>
> Imo, that makes a bit more sense as a phandle, as it reads generic and it=
's not
> screaming "I'm RT1019P" on dts(i) files where it's actually not.

Works for me.

> >
> > Fixes: 321ad586e607 ("arm64: dts: mediatek: Add MT8186 Voltorb Chromebo=
oks")
>  > Cc: <stable@vger.kernel.org>
>
> Well, that's not a fix - it's an improvement, so we can avoid this Fixes =
tag :-)

I'd like to see it backported though, so we minimize the different DTS file=
s.
Guess I'll add Cc stable instead? Not sure if that works without a Fixes ta=
g.

ChenYu

> Cheers,
> Angelo
>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 19 ++++--------------=
-
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b=
/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> > index 52ec58128d56..fbcd97069df9 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
> > @@ -10,12 +10,6 @@
> >
> >   / {
> >       chassis-type =3D "laptop";
> > -
> > -     max98360a: max98360a {
> > -             compatible =3D "maxim,max98360a";
> > -             sdmode-gpios =3D <&pio 150 GPIO_ACTIVE_HIGH>;
> > -             #sound-dai-cells =3D <0>;
> > -     };
> >   };
> >
> >   &cpu6 {
> > @@ -59,19 +53,14 @@ &cluster1_opp_15 {
> >       opp-hz =3D /bits/ 64 <2200000000>;
> >   };
> >
> > -&rt1019p{
> > -     status =3D "disabled";
> > +&rt1019p {
> > +     compatible =3D "maxim,max98360a";
> > +     sdmode-gpios =3D <&pio 150 GPIO_ACTIVE_HIGH>;
> > +     /delete-property/ sdb-gpios;
> >   };
> >
> >   &sound {
> >       compatible =3D "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
> > -     status =3D "okay";
> > -
> > -     spk-hdmi-playback-dai-link {
> > -             codec {
> > -                     sound-dai =3D <&it6505dptx>, <&max98360a>;
> > -             };
> > -     };
> >   };
> >
> >   &spmi {
>

