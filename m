Return-Path: <stable+bounces-95924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163C9DFAEC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FD162CE9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89C1F8F09;
	Mon,  2 Dec 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTa4u17f"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04991F8AFE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122444; cv=none; b=mx9OGqXnXl8OUL9o+KRSu6H+VVUQVbzr7YfodWzQ3+yZ4gpQBbl/XuYwGs0Z/pwb/EGFoIB3WmqP6yi+qW95UVhb4WzhTuCQUSi89wUXHODuIZNz07N1b/YvSK2M+YZ/bHSsadHUpRc2CTCn/8ZrV/2vqcEk6colG8zpFcjeTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122444; c=relaxed/simple;
	bh=UCNB2xgbM//AH9+5DFmq+rbS7YsPfeO9OXLh197WfOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCNNGar3Mbq7jCpt5Q+RR2QDqcjFxL6Em8enuIOxs5TM2Vtfs1ZdeY3g9DvOe6srrDQZopksnj+L0gNxY7dAOc+OeIIx1pP5Y/cPer0nmpIgQqBfx4abmRPrXlll8XM9fPKgVUxENhcgsNCPRinkmVSdajdMP5sRxocRdKRPdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DTa4u17f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso4049813e87.1
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 22:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733122441; x=1733727241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1Uqn32BF/FbfwJi4xGuXZvJLwbcwXNLOzJxdEmKSrU=;
        b=DTa4u17fp0vnETqco5IBEBHJVlbte/a/nzPfShhMZsPIdXj4IfcDdzgjodZ4rnpjXz
         78TSLmWj5spa/gUBf7yAo2eqvuLa1jwzGXpi1nbpq4AugrUE1ZBfndJ0JKjClgJcodTj
         +A9xyJDDrKTNPvjRYKKrmt4x7LsqMhYKLA++8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122441; x=1733727241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Uqn32BF/FbfwJi4xGuXZvJLwbcwXNLOzJxdEmKSrU=;
        b=G9tviH3HM1Sof2qplx9haX5kvchc4406SK3AyZoNfwvex/YBUiaHsasC2bbcG+XsdW
         OpFdvaPh9iibb3YYt0896tffuhjv3XC/jHA8ka0DIsXqGURW8Hy0Q40pprPQgPkGCnwg
         eAiuwlPszhJ2tHczwGjfDljfVQFNQCRbrO0ELrbNzxe9I4ZAuMLGnH4MjVlZVPEyc6VJ
         +98Z3Qe4q6vrYI2nkC/9WGjNSlCCHwmiVONqhZ8eoibx8NkYnh59HoN8w7SbyEWTTyq+
         Jq47Urv6ff3ed/z77hbysslOmnf+b3vy4rldC6kc92pYb0RIIX2j0uUI5k/BRUeXYn/j
         mgNg==
X-Forwarded-Encrypted: i=1; AJvYcCVQL/d5bQaEwC9b1SWOGH67h/55aKn4NTe2Wtld6FsJaNhojZqPc2PHB4mDSEtCDwFnRcmXmeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso31r7C7Yerh9FNH7U8Vw/PVjuacB8R1AScktvRAmdiMf3GYw
	GiPAIRXVMdbD2spH9uzRU4JC2RfXOFxQMZVG4zrp8eA5zYD1NFR8rZMIuQqwtOAVxBndgoUrc9O
	w8xcARDfjut5kXfnFSUH966qPONaVy7iwcLUVrifXdSQ+eyg=
X-Gm-Gg: ASbGncu5ClpDCvfb0bYeA06YY1wyg37U88dckklBnpv9I4eTcehq/CInNR8BR8P8GrJ
	hg9WBYRezQV0hJ52In/taay6E+UgUti+escXPERT+2ghDc/RyvCprZYfhOCc=
X-Google-Smtp-Source: AGHT+IEjD7FG5di7PCLQoRC032iMBA3SKyupNQ5HUxwfhvbbkcHpSx5wUkI8wG2gbm/C5nI5/ujuxsE+6kOOO9VERhY=
X-Received: by 2002:a05:6512:2244:b0:539:f748:b568 with SMTP id
 2adb3069b0e04-53df00d9cafmr11982759e87.32.1733122440374; Sun, 01 Dec 2024
 22:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125751.964700919@linuxfoundation.org> <20241002125809.530901902@linuxfoundation.org>
 <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
 <CAGXv+5G4uBmrxNKi_ftRdWu55v2+kt13en5u6M6fDiHZCgJOJg@mail.gmail.com> <2024120210-discolor-saloon-a47a@gregkh>
In-Reply-To: <2024120210-discolor-saloon-a47a@gregkh>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 2 Dec 2024 14:53:49 +0800
Message-ID: <CAGXv+5G4GMv-_pt+SzwF8H+pP3VZne4=Nc18mzmxZzY5wJ8q7g@mail.gmail.com>
Subject: Re: [PATCH 6.6 433/538] arm64: dts: mediatek: mt8195-cherry: Mark USB
 3.0 on xhci1 as disabled
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, stable@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 02, 2024 at 11:36:33AM +0800, Chen-Yu Tsai wrote:
> > On Sun, Dec 1, 2024 at 8:15=E2=80=AFPM Koichiro Den <koichiro.den@canon=
ical.com> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 03:01:12PM +0200, Greg Kroah-Hartman wrote:
> > > > 6.6-stable review patch.  If anyone has any objections, please let =
me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Chen-Yu Tsai <wenst@chromium.org>
> > > >
> > > > commit 09d385679487c58f0859c1ad4f404ba3df2f8830 upstream.
> > > >
> > > > USB 3.0 on xhci1 is not used, as the controller shares the same PHY=
 as
> > > > pcie1. The latter is enabled to support the M.2 PCIe WLAN card on t=
his
> > > > design.
> > > >
> > > > Mark USB 3.0 as disabled on this controller using the
> > > > "mediatek,u3p-dis-msk" property.
> > > >
> > > > Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> =
#KernelCI
> > > > Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb=
0ec51@notapiano/
> > > > Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs a=
nd USB XHCI controllers")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chrom=
ium.org
> > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregn=
o@collabora.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |    1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > > @@ -1312,6 +1312,7 @@
> > > >       usb2-lpm-disable;
> > > >       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > > >       vbus-supply =3D <&usb_vbus>;
> > > > +     mediatek,u3p-dis-msk =3D <1>;
> > > >  };
> > > >
> > > >  #include <arm/cros-ec-keyboard.dtsi>
> > > >
> > > >
> > >
> > > It looks like this change is applied to xhci3 instead of xhci1. The s=
ame
> > > appears in the backport for linux-6.1.y. Could you take a look?
> >
> > Agree that it's applied to the wrong node. It won't cause any issues
> > since xhci3 is USB 2.0 only, but we should we fix it regardless.
>
> Great, can someone please send a patch so that we get this correct?

Would you like a revert plus a correct backport, or just a fixup?

ChenYu

> thanks,
>
> greg k-h

