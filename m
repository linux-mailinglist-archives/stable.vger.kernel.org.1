Return-Path: <stable+bounces-195276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C24C7455C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09134F5479
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763533C1A2;
	Thu, 20 Nov 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY/hJQ+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8E19C54F
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645617; cv=none; b=tFLQoGANJJ6QUaCq3gIEEB5rLgjov4H5/OFsnzqYL1ZagtmpZs4fD0ezb572ePZKQ3lZa7x1WFllb60m+Brqt/SE5iV3g5L95GC3FM3FV26l6isOLJZbJ+C46nk/WeMBTyAexOQDLSZecDm6xyfDnf1cUfCWC0vcUq83/GHcdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645617; c=relaxed/simple;
	bh=NAVLVFVkvizD+YB9av0s+yGaMrcSYdUi8bPC82XvmBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4VgziQhGw+7Rs63vYHUxJlLhq6l8POb+8vrFM4LsZwLrUXDbULV3ZeWkOHAu+MeqtLjKP4dE5su8OGvunMblerl3c+47qJUfOEmvuo5OAr5ykddZF+7Y5ZJJGAknd24y1kc5mdSNHmVafAdmnloCDJA0UKQ81jv94ZFKTnRmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY/hJQ+Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so8064925e9.2
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763645612; x=1764250412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgUbW47+wbGW3tV+MdihXsK8HHZOyOtNqUDX0v8QhqM=;
        b=IY/hJQ+Yy0EDwHhuygJuA077I8YjAs8KOhrBDiMDY5ODYaFvEv2n/+RE7YnXhzBDA6
         WcvJAOo03Sk5urzYvgtJ8mqJKCxP64Oc8Iet3OP+EU/msIqZAULb2mUu2YdAmOBnWFW9
         Wle80Vb8TnVW4HiDzBrOQLH+Cfme5ZoNU9OApTIRoo8RGlBz6xXT3UAUftWBSxSspKWx
         SXXEZgezgVXEcI0pEQxd6hXs+qUYeVjJbXxk9Apt5EXbqlwh/c4sDDctxP8Wx/0RwYCQ
         PouqPorkBEEUNuhKwuxOJjg2ZqiTQstAJVVtdca2KtJgUHSHx19pJPmEL6tbtgsEvCic
         /ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645612; x=1764250412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgUbW47+wbGW3tV+MdihXsK8HHZOyOtNqUDX0v8QhqM=;
        b=uwet8FpTQhTGpRHhzOXSn7deKXSFR6G/djS9EpF6Dn0AhLVtk9D7I7vd+3bOWr7qew
         kEj0iEDxamDCWK1DlXDRpgQ7yz3vWoNlSADYT04jFZye45ntk/KchYn6NnA+ejjnqZSW
         pOQ+/tq3Of1ROkPQXzllf8q6wZl2kDKHeLG9zAUjrTdvoVAofbNpmDygW2ssIf98kNmX
         EhVdeUaB63UFjCNS7PiXAKxVfz33ESRRSBNhuiOYhd0cJuhoEESfyg/aXqfdClf5j9c4
         FHKtJ00hG7qdcNOoHDjJc7FTqRICcY4pZqCunBEvFVzk8jKr0fdc7L+JcHHSPHwIC9a4
         r5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVnPCJXn0D4eMdoepV+7vMZOfiTSxA6oBAAmcDLoKp03sjMK/1YTbAZ8LLshuYUP1CME+qYfhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdMA3+boCNYxQwwEyIL07FEeDSON1LhbZ218+0+CFelK6m0Pl
	9CfKdPVbJ56Yq7zuCDegDJpTjhj5C6h2t4I5ScKDeL7ZWu2KAV8iTIpk
X-Gm-Gg: ASbGncs1LinKkIKaUaQc3+NmBvfLRlsG7V5CDOzDdL9+OIPZptBAB7+vwU0ZSM52mPj
	tu7o04pXCB3sSP9W/DhNPX3HFK9SdNBSPD2SnaWZmmTolHPmyPrvDe91dVnY2O8KoVzmdkeip4W
	59CI1ECrpyaLz5tUsVNwM0nl4TNP3/YoMrsFzhV8w+BahCpEvWMnNCWjGg25BGjMjdmoVV9xKXW
	RlaqZ44QpFwoVQMbyvpzI7D8zBapHJ8hWYyaET9sV+oX16HHttOkI9XRyjE4IOgiR7xFhLZ3fkH
	xpYZKDu7T/4HYldjHu2gmXlVkZrwDboh2X1LuprrX6w+v4+ExaHBLtXJuJ7Pqm2+s65B3Eb2AI6
	kVm/l5ykr+mk0oEt3M0OQhx4AmJ37bx77fGrZyLk3PpT+GkdapWiy4GrfcTj/FByZLI6nfaH4rB
	MMfwNuRRiLXMJMFvnxQO+sRUQOa1gVIwOZpLsOqLTr5qLnU61TW5zu+wyTclZ3pKDlKBP6/aV7G
	Q==
X-Google-Smtp-Source: AGHT+IFCC5hFvuLAj/GrnPY9NAl8PTgxcBMoBdVgpQUcWKcFBRqXDFLHoEodXujQZRJeyM405qbmkg==
X-Received: by 2002:a05:600c:1550:b0:477:b0b9:3131 with SMTP id 5b1f17b1804b1-477b8951fe9mr30945445e9.8.1763645611863;
        Thu, 20 Nov 2025 05:33:31 -0800 (PST)
Received: from orome (p200300e41f1abc00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1a:bc00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm5496603f8f.12.2025.11.20.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:33:30 -0800 (PST)
Date: Thu, 20 Nov 2025 14:33:28 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 0/2] Fix reported suspend failures
Message-ID: <6q34fzfxhoxflgfidgy7zgqwmj6vtjumqz63ons4e2ugwy455v@ejckeuiicnrx>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tkj33rmhc6ruzxgy"
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-1-john.ogness@linutronix.de>


--tkj33rmhc6ruzxgy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH printk v2 0/2] Fix reported suspend failures
MIME-Version: 1.0

On Thu, Nov 13, 2025 at 05:09:46PM +0106, John Ogness wrote:
> This is v2 of a series to address multiple reports [0][1]
> (+ 2 offlist) of suspend failing when NBCON console drivers are
> in use. With the help of NXP and NVIDIA we were able to isolate
> the problem and verify the fix.
>=20
> v1 is here [2].
>=20
> The first NBCON drivers appeared in 6.13, so currently there is
> no LTS kernel that requires this series. But it should go into
> 6.17.x and 6.18.
>=20
> The changes since v1:
>=20
> - For printk_trigger_flush() add support for all flush types
>   that are available. This will prevent printk_trigger_flush()
>   from trying to inappropriately queue irq_work after this
>   series is applied.
>=20
> - Add WARN_ON_ONCE() to the printk irq_work queueing functions
>   in case they are called when irq_work is blocked. There
>   should never be (and currently are no) such callers, but
>   these functions are externally available.
>=20
> John Ogness
>=20
> [0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvi=
dia.com
> [1] https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@D=
B9PR04MB8429.eurprd04.prod.outlook.com
> [2] https://lore.kernel.org/lkml/20251111144328.887159-1-john.ogness@linu=
tronix.de
>=20
> John Ogness (2):
>   printk: Allow printk_trigger_flush() to flush all types
>   printk: Avoid scheduling irq_work on suspend
>=20
>  kernel/printk/internal.h |  8 ++--
>  kernel/printk/nbcon.c    |  9 ++++-
>  kernel/printk/printk.c   | 81 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 78 insertions(+), 20 deletions(-)

Sorry, I'm a bit late, but this seems to solve all the issues we were
seeing on Tegra boards, so for the record:

Tested-by: Thierry Reding <treding@nvidia.com>

--tkj33rmhc6ruzxgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkfGKUACgkQ3SOs138+
s6ExxhAAhYCxVSeWwfZkMObBYP+sk+A2trb7b5vg53AF/LvPg5UbWUqIt+8veMHO
1s07dOYXkLckkCIz+xFCT47SH/WFp0Re8lul5FurKwzFFFXBptE/E4IifO2+VoHf
dE1SsHrNpw4gSvM1tuCpWgu5MkfE0htPGYT5ysObFX2nPZuRdI5QPG7icsMUgAMz
T2koDWeaUsA8CwgiIe07iNbhM+8hB94g7/f/crQEQClOXth9+oLBG+DwK1Vhdm8y
rg3ejZdFT4gLlzkxDiPzU7RnaxRGEFz8Rgwzj8TGNbtNKSgDOoHLieE8ncWNPFEA
KrbJSroY497+hUXJQBdOlRU/oYdnuiHgaLPl9r4QARLWivzd5h/yU7jPZq5lsMTC
7CZTDreP+Fqj/BJANJacPKuOj7S/UHBAR3f/kYOyGwTyiN4hK3YF8aBq5V0vIeDC
MSw7w6RWNrdZDgb94rAxUkcuiq/vXJV3UpWOf8sPPsHYHH+0HB0Ze7nXv0LLAyPl
Gmyd/1n8oIvSdBhOn+t9uneRS4Fwt7vH43Klh7//NP8N3D34iX01aV9Er3J7IaTZ
t93jAzZEnqWCcZl8xWnxU5yLl1s5FRAChGyRPVYFFUbGeFY22qh5xvN+3HyHAhKX
MUZg6P1f7gQEx2QwQJPuOqf4lkRM+Y9KPDdakoG3ap/iKqW6I5Q=
=U9IE
-----END PGP SIGNATURE-----

--tkj33rmhc6ruzxgy--

