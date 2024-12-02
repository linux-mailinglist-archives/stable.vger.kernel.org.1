Return-Path: <stable+bounces-95915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8F9DF9A8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EC4162581
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BD1F8AC8;
	Mon,  2 Dec 2024 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/ELWUHa"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63526AE4
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110608; cv=none; b=t+Ri1/NkQU9WTwkIR5fVVEMj+gICJkuzM/edKcSeqTA7vZQ2A4M9Vi2dAPN+GM85RGytkHqaDQSRRwPe+Zx7SwQcxdpTO1/xGe6Kd+PdPZR83Rp3nY8pDj42j1ZxiHZXo6c7ODuYC7cxnAJ8otMVAVkwZK3vNhBIWbCMmu/iG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110608; c=relaxed/simple;
	bh=2jBD/uZXcIrJWj/AsLy0SMDMwbJZPy6iF6sClcdbIYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWRNbdoF39c4VFu7RS/ZoixD3yIt47YinYutuNkejoQtzbsXCR/lUJ7ogmv/beptC6XZHc023BvmPjjoNnlq/5ufSUisyG523PE8vExrbAmgX+GOVHfTR7ffKLgK+r2E8mckd6Hr1yzpxBpfdcWDDseSr9R2EN000e9YmV5CFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z/ELWUHa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df6322ea7so6045586e87.0
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 19:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733110604; x=1733715404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrgce2qiFSU/JFEkYP36ZDdUmL9iplM1yk9wLSbjfZI=;
        b=Z/ELWUHav6wPxoakhEj8sloAjdfrX2yI3Vpord/+/uQZN7ZQr9NhmVlBYQ4zRNE+Hy
         JCx3Lg8URdL56gK+4+Qdmsf5cZNlsXHTt9h56y1MUaR8QfgcSlez+vrC+ow1GQWjdUG+
         LehKLwa7odIWNOtM+9P5En/MlHw0IMe+qB2I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110604; x=1733715404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrgce2qiFSU/JFEkYP36ZDdUmL9iplM1yk9wLSbjfZI=;
        b=At84SPDevpAhHs3yaBlYhVDHdno3ZZ62iPQCTtLX4p0/6wy621JBzgCKYvz7VKEkT7
         frPA70KP+MHAhHZu1P4oX0bw0GBQld3WK772AiNebq9ULFFoA/JBz+6pFqxdmsnKGUR0
         3/eYWm4DaPBy3Z3cDHCCUoOQaseeJoUjr9FFRlZ2hi/M1/wpFFuBoS7/oWOSGqe6S0dr
         uT/T/TyvM8AOpmqAKjTOG2ko9+smAfzY5SSjRNeho7i+1LhTXERt7KXnq6hnKV+eprU8
         fZna6JgOc5ndbCC5jDtrwzu5LVxOaz1P/jhcLc/gVpIASMszpe7xjUkUeSDMpEackNbl
         ObLg==
X-Forwarded-Encrypted: i=1; AJvYcCUADKhdQ81benP4oPsZeMnN4PIbwT1zulBVxV8saMEPyouzefBeaOKY+k+UiD4Ny54/rSqW+Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mChAE8F//66ptYYnjB7bkMpUZJlq/uHqS/7qRa0eC17AwCI3
	ATODhIJJJ4ZpwznEzXYpK3aineDws8AcJiVUNspIiTiLPm+mUetCvVormqXyl7si3on/XRLksJe
	nRyYD+ZMldj5bkUsLZpUHEXmyfrYU4HnFp8X0
X-Gm-Gg: ASbGncv/p8L3143xkZ2TeTtJpx1nmAHucgMjUiebqbQztI6gxaiPvJU/3fkn1MWD37i
	R3gH303KRQ+snh762RfOKQhJ08IoejgvzVO62upFk4JNlnq9CTCxePSXrAAI=
X-Google-Smtp-Source: AGHT+IG+n+IbNxgV8Tb4D5spZsXT8Q2Rbz7/qOi/HyU92FrP9YcYlv63Ovsu1rgy+PNggue+e0PzoWYUhP9YNEUuBIU=
X-Received: by 2002:a05:6512:3b96:b0:53d:ed19:d25a with SMTP id
 2adb3069b0e04-53df00d9d71mr15366736e87.32.1733110604050; Sun, 01 Dec 2024
 19:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125751.964700919@linuxfoundation.org> <20241002125809.530901902@linuxfoundation.org>
 <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
In-Reply-To: <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 2 Dec 2024 11:36:33 +0800
Message-ID: <CAGXv+5G4uBmrxNKi_ftRdWu55v2+kt13en5u6M6fDiHZCgJOJg@mail.gmail.com>
Subject: Re: [PATCH 6.6 433/538] arm64: dts: mediatek: mt8195-cherry: Mark USB
 3.0 on xhci1 as disabled
To: Koichiro Den <koichiro.den@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 8:15=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> On Wed, Oct 02, 2024 at 03:01:12PM +0200, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me k=
now.
> >
> > ------------------
> >
> > From: Chen-Yu Tsai <wenst@chromium.org>
> >
> > commit 09d385679487c58f0859c1ad4f404ba3df2f8830 upstream.
> >
> > USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
> > pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
> > design.
> >
> > Mark USB 3.0 as disabled on this controller using the
> > "mediatek,u3p-dis-msk" property.
> >
> > Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Ker=
nelCI
> > Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec5=
1@notapiano/
> > Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and U=
SB XHCI controllers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.=
org
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > @@ -1312,6 +1312,7 @@
> >       usb2-lpm-disable;
> >       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> >       vbus-supply =3D <&usb_vbus>;
> > +     mediatek,u3p-dis-msk =3D <1>;
> >  };
> >
> >  #include <arm/cros-ec-keyboard.dtsi>
> >
> >
>
> It looks like this change is applied to xhci3 instead of xhci1. The same
> appears in the backport for linux-6.1.y. Could you take a look?

Agree that it's applied to the wrong node. It won't cause any issues
since xhci3 is USB 2.0 only, but we should we fix it regardless.

ChenYu

