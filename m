Return-Path: <stable+bounces-154739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB5ADFD9E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B544A7AD546
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27024677E;
	Thu, 19 Jun 2025 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="g+AyxAAE"
X-Original-To: stable@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9B1DDC3F;
	Thu, 19 Jun 2025 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750314285; cv=none; b=dbC4qjhf1+hD2yEsXbxUA1ydwRWCSiwjDQwfAg7pFHllBns1Cmo4qSUA5HTTyyl/uAMvg9uSjy7fHI1HinIsZsoUvrX4aAaOcYpI6INhDNVCLF7FgEJDdm3T4aYHVALwUHdBhEL/89FfRr+OCUAfLRsw2ycSePHhKlixrvXoYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750314285; c=relaxed/simple;
	bh=BTaOj/LFHTMXn10NykK+I7b2lnQO1XQBlwEzd6mhsbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bdotNHj85Kg7ZNeg6XNYJjr4YIMmF6lusSeruqDkqowpPdngBcR6tFBEnm85ERMrEdz8jElmNaAT4oYQDc2a8lcGCEU9hLg9V71iF4nI/nf2mdOv2NHhyXIJpvbgpxmHhWCp+6toDLdLDo+VgHu40FjZpfHJtP6RuGLKyn3kToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=g+AyxAAE; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:fa8:0:640:af01:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id F14FD61928;
	Thu, 19 Jun 2025 09:24:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZOHeSc7LkuQ0-FOPo2JK0;
	Thu, 19 Jun 2025 09:24:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750314277; bh=VRVnFeiyhbRv73uj9rSI67sI0wNTtfrHx8orLwgEf74=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=g+AyxAAEaCirn5q+0Uun1b5tVU1z1O3Mf/DtIobilq1NbupX9MUh0oukS/nU9aUYB
	 vKTyvZ8+PxbDNJi1SsIREtdbomBiR8QEOgpJ6qodfVjHeWD1Sco7f/gAsWFv2jOT8l
	 hdTUY04VBpOjl1pnPF1B6Z+ulc0hAVmApnP+NSDI=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c5180008b4611f61866b216eb20f8db2e7ef429e.camel@yandex.ru>
Subject: Re: [PATCH] Revert "platform/x86: alienware-wmi-wmax: Add G-Mode
 support to Alienware m16 R1"
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
 <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	linux-kernel@vger.kernel.org, Cihan Ozakca <cozakca@outlook.com>, 
	stable@vger.kernel.org
Date: Thu, 19 Jun 2025 09:24:34 +0300
In-Reply-To: <20250611-m16-rev-v1-1-72d13bad03c9@gmail.com>
References: <20250611-m16-rev-v1-1-72d13bad03c9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 18:30 -0300, Kurt Borja wrote:
> This reverts commit 5ff79cabb23a2f14d2ed29e9596aec908905a0e6.
>=20
> Although the Alienware m16 R1 AMD model supports G-Mode, it actually
> has
> a lower power ceiling than plain "performance" profile, which results
> in
> lower performance.
>=20
> Reported-by: Cihan Ozakca <cozakca@outlook.com>
> Cc: stable@vger.kernel.org=C2=A0# 6.15.x
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
>=20
> Contrary to (my) intuition, imitating Windows behavior actually
> results
> in LOWER performance.
>=20
> I was having second thoughts about this revert because users will
> notice
> that "performance" not longer turns on the G-Mode key found in this
> laptop. Some users may think this is actually a regression, but IMO
> lower performance is worse.
> ---
> =C2=A0drivers/platform/x86/dell/alienware-wmi-wmax.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> index
> c42f9228b0b255fe962b735ac96486824e83945f..20ec122a9fe0571a1ecd2ccf630
> 615564ab30481 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -119,7 +119,7 @@ static const struct dmi_system_id
> awcc_dmi_table[] __initconst =3D {
> =C2=A0			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> =C2=A0			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16
> R1 AMD"),
> =C2=A0		},
> -		.driver_data =3D &g_series_quirks,
> +		.driver_data =3D &generic_quirks,
> =C2=A0	},
> =C2=A0	{
> =C2=A0		.ident =3D "Alienware m16 R2",

I think, at least a code comment explaining the situation is warranted
(or maybe even a print on keypress or both), because otherwise sometime
in the future other people may try to add the functional back, and then
yet other people may again revert it, regressing things back and forth.

