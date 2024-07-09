Return-Path: <stable+bounces-58912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3A92C243
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43178B27243
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB721B1500;
	Tue,  9 Jul 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TjHQtkTd"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58F1A00C2;
	Tue,  9 Jul 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542880; cv=none; b=b++YkZuB9RqQru2QCkM70zjv4vPXNUHnemYQCqXMvQ6hUPpRFaa3TW9WrDcv3p+puvE6n7t01tTCi1odqV0VE5/lHGHuQzzHkgNGw0izG1TEduvDX2Y/JqB2Otn+RxHxaLXiuj5Xlg7BWsvAHqzJuUI0XnASUdZbUeYoelFBD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542880; c=relaxed/simple;
	bh=+RzgxylUarc5vlI8oLvFK/PXwVZbBNURZCdEttKfeYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYjtYGNQN5ajbi+/VZ4qzXVeb52F237Jb77LiCiRaK0YMU0WL1bm0hJN84q5ww6tDGvHDerV3fhdt/7/2I0/g2NuoMm4z3uT9GU6ZzdBbAFaBorEzPe7zbBv6VOnMsYpK93AsvkLY9n4tUAL+B0g8O8ascsP1vLjRkf4bQcG5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TjHQtkTd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720542863; x=1721147663; i=w_armin@gmx.de;
	bh=ja0Lx4qUduId+7k9ukG8vnYpR0oyhaRyrRLQyiT2Y0A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TjHQtkTdXDdP1/C9KWnfezF/ssap+vB+ic+MnYVcSecA8+0YtJcv+b/C540xCffa
	 PN3tJCQT2XbJLv/ZUCcbr/vMEk5nmh/u0gB/14OegXB5dmKyLvHP9pXNlJUQpE089
	 XnEQ//EwBfYsYGgDB+/frMZAM3PUQMvG3xX8V4yzA/U9SEujNhGBSu43dKe13M2mD
	 0V1ZE6+X7lRneVXBMar7x0bLHbWFsrJ3oUvoKzS9tlyeyBxCi3eRscd8e0DyRP2LB
	 PH/tWgowxmSodKbm59ci59iv1sjRrrJH8sgiF+hnZFK6WvSg+uCFNB7/t28J6Nh7b
	 ej7PmFyHJV2zOSU1CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1s3xsI29VV-00m7QA; Tue, 09
 Jul 2024 18:34:23 +0200
Message-ID: <4beb8370-9d69-4f88-a1d4-feb2a5aa4746@gmx.de>
Date: Tue, 9 Jul 2024 18:34:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.10 09/14] platform/x86: lg-laptop: Remove
 LGEX0815 hotkey handling
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Agathe Boutmy <agathe@boutmy.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <20240709162612.32988-1-sashal@kernel.org>
 <20240709162612.32988-9-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240709162612.32988-9-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u+w9zpS0PcK5vTO0bazoBKe8TIHXbh3WFn2XQf3gZC0cHEyO0+n
 QeRHSyDHJUgK+9PTHwmS2gFGvzuYPTtXnHAJ53TgbsJoV50B+IqQKIZdy+60L8srhIOzqQs
 1TlYCdsGyoo5OnDSJGyTlAkH9PYnqOIt7cfGZjFwczDqJFhsaxfxJF4E6vv6z3yAWcytQZz
 Jetm6rtvWTpVRU/oXzw/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rw5zDI4YMvY=;aWHAQiAhdwprjxHEdm1kI31xeDh
 cF03QF1HFaLZoemaqT2+Nwg7oi1GIfMLHtbRQatwK4qTkSLZ2RlcaXpCv54XGqv6JacHqtOtM
 LlwmU6X0l6X8j1lcADXQzcyxNIa+xVoMwNJ2tpqdGMRKx9RBXNnrcoi4xmSAixXKfzuWyQIHi
 Zxk1akBEWC5RpGH/7+bqAED5dDwUyc6vKPLiw/ynl6fyB8oYTpnUHw9BQZUsphxWXvPZqvO1j
 wKKzmANGLytq5/SMCLNnrnkGbQ8jiytcKaQ7snyxpK5bfkhJVnZVdQwJfF02gGJf0XhLN7zu9
 SMVh3fxbbcTkHnb9M2lsJPSIQZO4+8U8RNEQ4XmyZVF9S6rncAWUyNc+uQGLGCQv3VdFe6uD5
 4o5u3dGP7sYthZxFXnt5rsgGmmMSjIvAkBBN65iR/9NetY/Bs6OUikNHKWT6acvfBkofO4YyF
 UhoBYEGxi+Eu6cFM/pCWy6QiNBPMSgK4V1JsTQOmiDUpxxOY8Zsf72ylJ8AiBWxBvTemfFv9B
 z4xKbHuq5yOxGMTPXbY2TZSFZwlqmcHxyZK3dYv4pI4cnIpEuHts3TANRCgnK69Fq4Ny9kZ3E
 k+rPheHixH3tE3fyTRdcbdElBGf/9foft79NltgRfBw4EIR7LDW7t4QFjelj/B+TZejDuvJ1k
 G7QT3JYnyHvHa//pO6y7uBCVGO5ReKtUYHkj6Gr5WqLTEz/Jf2Lz69zyMNExYlnvWTJwI7qom
 Xqi+glJg/tLf9Yk+oOFL5IgzxxxJsn1UGgVSpLPdmAQyXP+C3aVcpe618UE4vJCDzXtZ0gRIW
 +16ijjwCdhRs3b1gxhurZXDsRsl4r/ddt8irsae7rplIU=

Am 09.07.24 um 18:25 schrieb Sasha Levin:

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

this depends on other patches not in kernel 5.10, please do not use this
patch for kernel 5.10.

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
> index dd900a76d8de5..6b48e545775c0 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -77,7 +77,6 @@ static const struct key_entry wmi_keymap[] =3D {
>   					  * this key both sends an event and
>   					  * changes backlight level.
>   					  */
> -	{KE_KEY, 0x80, {KEY_RFKILL} },
>   	{KE_END, 0}
>   };
>
> @@ -259,14 +258,7 @@ static void wmi_input_setup(void)
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

