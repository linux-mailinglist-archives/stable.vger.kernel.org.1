Return-Path: <stable+bounces-119849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29AA482DE
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09F73A9243
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1A26B2A9;
	Thu, 27 Feb 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="do8n4Qwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887B23AE7B
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669913; cv=none; b=sptxX/HCm4IxX4M3/i0UhvODiV45eDf16oM+EMXjPV0+XB+RjRNaMyS+cPGpEmpVKSxB7o7Eb27PYCFMetTeg6vWrnM9zvqQabjEL7+vPC4OXlamK8zPRFY/XX+fjLKa99vS34PCx1+NJfQh6+dFJaS/aimwM+MQeX4qZXu6QKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669913; c=relaxed/simple;
	bh=f6QuUlsJO5EavQ615P1dm75xNEjHa3B8icXTtEL81yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBgqO+jGafnmOBbXkBsewbjX7kKVkkbjyRe4a1O9wQNQ5kGlqyXfM/8+67JR2aUxgdyfBzpqsq9FruiA814fXvL/H9eVwQ8eCsItO6RKCJXGPjVE5NF77UzN0BAU1WyKeW9DIrbNNFOOhsQ/2Ef4myAQR0t8er/D3Om+KW9sJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=do8n4Qwm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abee50621ecso150313766b.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740669909; x=1741274709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdsbZ0O9rNvWpaRBZOvH4VUbvmX1z/wUXfYquuZ2G5w=;
        b=do8n4QwmHg5vq2L3nQpU7SBx3ig8SsQZ3uAlfvomJa5NVA6qxZBm1TnM3jggupsmDV
         UQysMUYAy8vS2pGQ0wSh/E8Kno2Ajmb5W1VBTYScQvXPm28XYPrj7hJEiux7SojRO/FA
         TnkeTXDnS4aDchbkOVuLUcPBNV651X+cPPY/C+M8HKEH4pqYu0Smb3xiIYqIxWmKUXJR
         pCKg427Ce62zYBYhaTNwppppX+hK0sAemNNo1Vdd1R0maN5gM5eQ4Yqem3hlG4eqan6R
         V8nCjThA5PCMS/PyKSoj5asOvMr17Pd1xl821O73TTW5GhIm6i0y+r3GlFMCeEpxKk9x
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669909; x=1741274709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdsbZ0O9rNvWpaRBZOvH4VUbvmX1z/wUXfYquuZ2G5w=;
        b=iR39EOWK2eaJFEeTpE+VqAB5b+d2HAws5hpHIm9bbt/Yc4QVOVfKO+hKThv+t/tOZe
         g2+uYIBOA4eg+ZFj65xedR8ZKL5aKYh1gOey6kXw70B2+ipM+QcyEbx2sg+6MNDjM4nB
         5GCIsi6rOvDJEY43gEM76Q0+r+7PGDG7Y0lwiGp4dnTzuoZBkUw2+MFBulUHswDTV9sw
         q2upcOe9niDDDgf8ORc+BbhEhSm+isF9zJXCFP9uQbDkAXiCnIn1yVWQO12hCSGizBGR
         uyrWcv/VUXDAOQtknk7A4GE5uOYdZr0IHyDCeCN8HqYS6cCVaAVbdEaE8S2N+VzW4xDu
         9yeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJE1M9bHH18piYOuClAlUj3o+8C+v1Fs1c92/gQxFuSXlT8Zm9/WYjT8Rl9d0uTSiniS6yYEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0yXvanyyiSik5gYYSQI2fyX4SPX/+3QIbvsNoLPJXQNRFX0q
	D7XLcS7z+9XzLuAS8u2vmgn+LzhbT9JgH8SSr3DqKmFtnyHfQynHhERv+1o/9NA=
X-Gm-Gg: ASbGncs3SvubPX9glmYYGRiLDlPIgbOiAJjR4h33TO78gh4z7zTmk5Jv1eSVMIm0mNn
	LQOIZFSUTfoH49PpXISrFMGsXRroHfVpd+hhoX8UvJvzjBUCj0JeMrkjaKgw6xZ+RB6uVITN3xN
	g6ts7EOG43eF5Zwm5vUJzM5h6/OQ2G3kmQvKLLYvcQQ+T2OW22+snV9GgMpsdOuNqx0EyyABP8Q
	ZeueNBx0TxEkFKbten70Rf7yq30mt22UGGC/46BNMbizZDQkY+HTfe5QW2LwfI3JDIcBsCYvqo9
	nlzonFICjID9sXSelwaFaioVCNelkbxoUL+D6L2jK27i7LEb3ZLiy53NSMN5QWHH
X-Google-Smtp-Source: AGHT+IGlOP3J6f8+xzlhNX9BevDd6dvNU3/M+JOcn2rWwP1nIbOsExrBr5y6pgGxUl6w3XcyhhMoxg==
X-Received: by 2002:a17:906:c00f:b0:ab7:eaf7:2bd6 with SMTP id a640c23a62f3a-abeeefc7ea9mr912180366b.49.1740669908808;
        Thu, 27 Feb 2025 07:25:08 -0800 (PST)
Received: from localhost (p200300f65f2c000400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c:4::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6e9c25sm138704366b.108.2025.02.27.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:25:08 -0800 (PST)
Date: Thu, 27 Feb 2025 16:25:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Anjelique Melendez <quic_amelende@quicinc.com>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
Message-ID: <j55de6bbipoavqx25w2s6qr7n6fv6w7bj3lrgyag4dlvvddbqv@shn22aqcqeci>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
 <Z7zVgeM+7P7SLWIu@linaro.org>
 <vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w>
 <Z7161SzdxhLITsW3@linaro.org>
 <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>
 <Z8B2Bl/9uD3jPvQi@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ffqffvsr3k7r6y5"
Content-Disposition: inline
In-Reply-To: <Z8B2Bl/9uD3jPvQi@linaro.org>


--2ffqffvsr3k7r6y5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
MIME-Version: 1.0

Hello Abel,

On Thu, Feb 27, 2025 at 04:26:14PM +0200, Abel Vesa wrote:
> On 25-02-27 10:58:47, Uwe Kleine-K=F6nig wrote:
> > Can you please enable CONFIG_PWM_DEBUG, enable pwm tracing (
> >=20
> > 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> >=20
> > ) then reproduce the problem and provide the output of
> >=20
> > 	cat /sys/kernel/debug/tracing/trace
> >=20
> > .
>=20
> $ cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 13/13   #P:12
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>         modprobe-203     [000] .....     0.938668: pwm_get: pwmchip0.0: p=
eriod=3D1066407 duty_cycle=3D533334 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.938775: pwm_apply: pwmchip0.0:=
 period=3D5000000 duty_cycle=3D0 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.938821: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D0 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.938936: pwm_apply: pwmchip0.0:=
 period=3D4266537 duty_cycle=3D0 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.938982: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D0 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.939274: pwm_apply: pwmchip0.0:=
 period=3D5000000 duty_cycle=3D921458 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.939320: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D921355 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.939434: pwm_apply: pwmchip0.0:=
 period=3D4266537 duty_cycle=3D921355 polarity=3D0 enabled=3D1 err=3D0
>         modprobe-203     [000] .....     0.939480: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D921355 polarity=3D0 enabled=3D1 err=3D0
>  systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0:=
 period=3D5000000 duty_cycle=3D5000000 polarity=3D0 enabled=3D1 err=3D0
>  systemd-backlig-724     [006] .....     9.079585: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D4266537 polarity=3D0 enabled=3D1 err=3D0
>  systemd-backlig-724     [006] .....     9.079698: pwm_apply: pwmchip0.0:=
 period=3D4266537 duty_cycle=3D4266537 polarity=3D0 enabled=3D1 err=3D0
>  systemd-backlig-724     [006] .....     9.079750: pwm_get: pwmchip0.0: p=
eriod=3D4266537 duty_cycle=3D4266537 polarity=3D0 enabled=3D1 err=3D0
> $
>=20
> >=20
> > I didn't take a deeper dive in this driver combination, but here is a
> > description about what *should* happen:
> >=20
> > You're talking about period in MHz, the PWM abstraction uses
> > nanoseconds. So your summary translated to the PWM wording is (to the
> > best of my understanding):
> >=20
> >   1. PWM backlight driver requests PWM with .period =3D 200 ns and
> >      .duty_cycle =3D 200 ns.
> >=20
> >   2. leds-qcom-lpg cannot pick 200 ns exactly and then chooses .period =
=3D
> >      1000000000 / 4.26666 MHz =3D 234.375 ns
> >     =20
> >   3. leds-qcom-lpg then determines setting for requested .duty_cycle
> >      based on .period =3D 200 ns which then ends up with something bogu=
s.

The trace looks better than what I expected. 2. is fine here because it
seems when Sebastian wrote "driver requests PWM with 5 MHz period" that
meant period =3D 5000000 ns. That was then rounded down to 4266537 ns. And
the request for period =3D 5000000 ns + duty_cycle =3D 5000000 ns was
serviced by configuring period =3D 4266537 ns + duty_cycle =3D 4266537 ns.
So that's a 100 % relative duty configuration as intended.

So just from the traces I don't spot a problem. Do these logs not match
what actually happens on the signal?

Best regards
Uwe

--2ffqffvsr3k7r6y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfAg9AACgkQj4D7WH0S
/k6aTwf/UY7HrGHI2eHNeklwiifJTjYtJhm0it3sytvIMvxePtaTTEpa1H7RkcFc
b26ly9fz8Gyrk6z+JhaWYmRSU+1ri0No1RGbbB50OLqTU/UUAUH3i2aQdwT0RcH3
Ebjo86u4WAnUk9bvh9RlV9qjbWKMEgh+Wi1IedLsyLyuNwO4a0Dll4qO2dH8BJ3K
AsIEhv8oCcpsw0GVSFiRPDqq0LbPWr+jBsgUEL30HSZ+MmH4zT0xVLerTnINfenr
vYUi3COLiFiPktANgpXGxeu+5a0cshZ/9Barp++PZGbdS08PQI3MHvhZFdNgJUgW
nd0wfc5oGd70fSzHlfmJ6CNN//fezw==
=i4U7
-----END PGP SIGNATURE-----

--2ffqffvsr3k7r6y5--

