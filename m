Return-Path: <stable+bounces-58920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA092C1A5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC5028982C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35361B3F12;
	Tue,  9 Jul 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fbHwYGoU"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E419FA8D;
	Tue,  9 Jul 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542949; cv=none; b=sM6VdIwRnvq0B7OPqflrvsYAEPp/B8CqTy7fcD88or5cgsCwG0mnGtM4Jw2gtdmj22TRZvwhfpkEP6KFOBehauFB7KsOGQSJXngLseQVXsleTY7070HGvG8YAf/YZjyYrVGfHc4qmdzNvWrWtyaMn976LYrtyhuP5sbOm2wofyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542949; c=relaxed/simple;
	bh=Gw/swpVYPz7OwYfD3NNPQuTrT+NZADREw+Cba18ZKA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ok135lZpzrDbTD94B8IbKDraQ1XJ+kHABOm1iuGUrD3H8c7yvMPZecMmDJEtztmTJZTWlbhreWaSP+QsymmKWFhGfVGBT7dR4MgTBGhfFwCl3VXfuDfA3Bb5EPgy2F8ps2W933TiaFSxYE26sI3MfPVUzs8jwo7w1DDuKM8wOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fbHwYGoU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720542936; x=1721147736; i=w_armin@gmx.de;
	bh=laA0/vQWdfsDbYkWBNLtY88xuyn4mMAAgZ5pBpRaVKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fbHwYGoUF6HhJ+GDTzsAa6AGTZiIDkG8JdLkD3AIVbDEBPiS0eo+I5Ek0F/P9iKw
	 LejVI3LMlJDHmSTGuGg/AZs4NcFSUWBtt9ewgRVOItxCwV3GvsEdCrnPykDmpiy4u
	 iIwLwbEdQIV0QfSsl4rSf9Niilgx/Vq5NElzzWYYVjdCp6yKty4wXmudRPOrWZwy2
	 CNtBEK4Y5wFCtK1uC6nVgKwWebeKHsk5hdxhOp4QxltlrZ+nXK9PrevqfP8gixYTT
	 eL8oERIkxz0YVpCRadG4w0V12nFToUJV5FvhFcNhu+GCzyUlfD6siW3MIGP6/jwjy
	 P0WOqvvTLD7J/r4WMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1s3hR43IR0-00iWuw; Tue, 09
 Jul 2024 18:35:36 +0200
Message-ID: <4d5e5d39-d53c-4650-8729-01cf0bf478c6@gmx.de>
Date: Tue, 9 Jul 2024 18:35:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.4 08/11] platform/x86: lg-laptop: Remove
 LGEX0815 hotkey handling
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Agathe Boutmy <agathe@boutmy.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <20240709162654.33343-1-sashal@kernel.org>
 <20240709162654.33343-8-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240709162654.33343-8-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DDdSYBCxZPgYZonYx76qtgvXQMXWosWR5NG7JPElX18kq/McZbo
 rBgAP8wo0jU2GMkQ6JydVWgrmMbfmfRggP7jrdFhEtWSY00a9/dogG2889ccDodxaitgP75
 sI9Ip5cph0fVFyyb9K7OJM2VrdsPLHfU/8NKcnfHE2UNYBjIEn/GqNZqfJarGR8vf0ePqqx
 y09oGxqnLvemzzfDYSY/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bbGt+JBk4B0=;keODTWxn/JkVzdJgjNuGRiB9E+0
 Vu0o1hA1/P8xLnb7pCWrNFFI9IUAEXp6TgaLdVXNX+DIToNb6DmGLXgcPAzQItEXgd9W9HjuJ
 82uDRDJn1S/GK8M2p/a6BfJIcF6EmryNfc+sXERCu9+LVE1OutLhsBpVzWYFzgyvEaDXfxiCf
 iGIfuVYnPJCZKmSJ3dVaG5l+tajslKttXcRklImmn7GOEtXV0+1JXB42ArVFBvgQZ+Nmmkk1u
 HJqOwELLbqPI00v9jFexSZh0ELH868a4if+JKJWRJYnNYzTpnd52E6EJ5IGy0XyPIDkhyDx1Q
 Y/KZa1bQijSCCcN6iwVuMQs7qvFOgHNj5SzUOqMuowvgCHGKxcGvlM12HvY7MZhth0CtPf9rx
 q5h1095eVaHcx0chAxrR1brmNxqxzuVwUuSE/a1HXQUZkg+/+/gM2Cd7w+Beyw6d4t6+aVBqd
 nFHFogWCWTuwx5AgxIyHQ65dGs3gpJqtlALoypVtQniOPB/miL2ysnS2PM7FWIiRbnTjw3TXI
 Rt/vOVmWUHM4MfZ1I7MgnowwPqhw9V8esEcBNaGHv6eDgbBgJMhPPLUCAbVVazGKU5rq214T0
 3Jx3E7UFB0iyFX71R0lRRmCTjQw2Fpnb19LMAJJZyXxv3lSh889f+X6JLeW0ohmJ48HjnFkiz
 zBi0+3ovhaJEYRIfDofWT955XUBuf1Rex2leB9ocAHwj1yB9QqMU2zKhB3HBg8cPpO37JP8l3
 dVDCfWD+Ot2EAwinroHkGWCw/xObEr0Qxp/4GTya5aI2aKZC49Dg0k0yDK8pDISwRHHKYUpUO
 xNsCOMxpKjqLUcsJmQWqId1yGHYaeQmMpuR2GV4nvmBJI=

Am 09.07.24 um 18:26 schrieb Sasha Levin:

> From: Armin Wolf <W_Armin@gmx.de>
>
> [ Upstream commit 413c204595ca98a4f33414a948c18d7314087342 ]
>
> The rfkill hotkey handling is already provided by the wireless-hotkey
> driver. Remove the now unnecessary rfkill hotkey handling to avoid
> duplicating functionality.
>
> The ACPI notify handler still prints debugging information when
> receiving ACPI notifications to aid in reverse-engineering.

Hi,

this depends on other patches not in kernel 5.4, please do not use this
patch for kernel 5.4.

Thanks,
Armin Wolf

> Tested-by: Agathe Boutmy <agathe@boutmy.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/20240606233540.9774-3-W_Armin@gmx.de
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/platform/x86/lg-laptop.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-=
laptop.c
> index c0bb1f864dfeb..27c456b517850 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -79,7 +79,6 @@ static const struct key_entry wmi_keymap[] =3D {
>   					  * this key both sends an event and
>   					  * changes backlight level.
>   					  */
> -	{KE_KEY, 0x80, {KEY_RFKILL} },
>   	{KE_END, 0}
>   };
>
> @@ -261,14 +260,7 @@ static void wmi_input_setup(void)
>
>   static void acpi_notify(struct acpi_device *device, u32 event)
>   {
> -	struct key_entry *key;
> -
>   	acpi_handle_debug(device->handle, "notify: %d\n", event);
> -	if (inited & INIT_SPARSE_KEYMAP) {
> -		key =3D sparse_keymap_entry_from_scancode(wmi_input_dev, 0x80);
> -		if (key && key->type =3D=3D KE_KEY)
> -			sparse_keymap_report_entry(wmi_input_dev, key, 1, true);
> -	}
>   }
>
>   static ssize_t fan_mode_store(struct device *dev,

