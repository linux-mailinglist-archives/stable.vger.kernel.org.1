Return-Path: <stable+bounces-206437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DCBD08404
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB4E9300D410
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BB358D3B;
	Fri,  9 Jan 2026 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1S3mpbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BF3587CA
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951425; cv=none; b=fPDglg9l2kyu0TyY2u5HmZk1bzr01sOsb1UO/KU37L4Bc5x/U1/tN69tFRLn9L2QAqZhj8+fPDOKvoLbLVHuEwNRF/Uo0wtSB96jmXDbkrDFgKhOMlkcsNKobaSQjkomhig0iVC6r9ykL7PSihNIulP+yh8pVeNDDGMBEtJh2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951425; c=relaxed/simple;
	bh=lvCUtx5/2N6twY/MV8/RmcXhUWl3SJF3OjQzxVTOGEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxNudoWal0Y4LSuErAc1MB9Cg6q7rAEuxRwSljWthbQY9HBbkvyJzCQipj7Kah8fQLuWDkuYt/iYMNoGVSal5597N6DO2FKyL4rLcX1tvrvutvskYhcWiA4zMZS7+ZXSnidevkfoduyjd42RaAmP/l3+cGoHpWPrUtTYj7wIcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1S3mpbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A640C4AF0D
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951425;
	bh=lvCUtx5/2N6twY/MV8/RmcXhUWl3SJF3OjQzxVTOGEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k1S3mpbtE5aWq83pkglx9bxMuO9rIIJA40veSBfR3Ih4DhKbrF09vPpCntWkkcKqJ
	 c3tJglconk7xfWKzG78I3NbeoRpn8SoXCrd3WP8z79QqESQkt2dmu7RexgMir5cDYT
	 XhJW3TlcDFbbSZ4DEYm1d/f5uXevc5v2hez0epEcVrHtASveXcbQ3TaCqkcG32MpaY
	 dYpFd80GxfdygOSXiZBHEDD4JE7BFQvYhYNGIGDAAKt6nbgTs9t18fnmPocMbJxe0D
	 aW0PuvpwhqdCYlOm9XyhlcgkNuAds1V+1Wm4d2jidvbXgdzMA6ujScLHfERK1i4NTf
	 QHw9UmQJqOutQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38310ee9d40so11618431fa.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 01:37:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7qi5fKM/2j7wjpESBeC0Nq6/iZeoFJ/jnyEYXkavePILUZpANn1ptCcxL5e1/13sHgUVDD88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxA7+HBPuocixa2i6kUuH4ieTkuvgGKhYmsn+Y38xUOerfC0zv
	FfhQWNEkFAyEkv1KiXdq/MYIsUbZSa8ayXMYdslfqGu+JKM7kiXjvCMn4C91B/mvdBfbb6iuHEH
	iLjWPnl5eyB1gKrM2c3b632o2CaEA+61bCsgxL+8Etw==
X-Google-Smtp-Source: AGHT+IFl7lnr3xeQRc2OvTUUx0HFKlM0skfhqeLO8tp3RwjpL9OqVuzKeQVVVivvxwSKJCafm3YmaKxp+HBxFH5PPf4=
X-Received: by 2002:a05:651c:2113:b0:383:f43:ed30 with SMTP id
 38308e7fff4ca-3830f43f012mr13768501fa.12.1767951423985; Fri, 09 Jan 2026
 01:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106085253.20858-1-bartosz.golaszewski@oss.qualcomm.com> <CAD++jLmdBefq9JJrfw27Y-FkvywJ9bzJBSOo1RXmS0HjoC5h+Q@mail.gmail.com>
In-Reply-To: <CAD++jLmdBefq9JJrfw27Y-FkvywJ9bzJBSOo1RXmS0HjoC5h+Q@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 9 Jan 2026 10:36:52 +0100
X-Gmail-Original-Message-ID: <CAMRc=McuAJLXdJq+=-bjCsjrSiWrrXr=A9NT+odX+E0P16VWjA@mail.gmail.com>
X-Gm-Features: AQt7F2qWdpw_3OR4mrvwg0EsRFwrEYR_jU3XFkmlc84d4RNtw-j5Dmht-iVh7Zg
Message-ID: <CAMRc=McuAJLXdJq+=-bjCsjrSiWrrXr=A9NT+odX+E0P16VWjA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: amlogic-a4: mark the GPIO controller as sleeping
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:35=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Tue, Jan 6, 2026 at 9:53=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> > The GPIO controller is configured as non-sleeping but it uses generic
> > pinctrl helpers which use a mutex for synchronization. This will cause
> > lockdep splats when used together with shared GPIOs going through the
> > GPIO shared proxy driver.
>
> BTW it is a very *welcome* side-effect of the new shared GPIO rework
> that it just happens to find these old bugs, I'm very pleased with this :=
)
>

Actually, I was surprised I was getting so many bug reports and then
it turned out, there was a bug that caused a lot of false-positives to
turn up when scanning the devicetree for shared pins. I just queued a
fix for that so it should slow down now.

Bart

