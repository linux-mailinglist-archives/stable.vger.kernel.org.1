Return-Path: <stable+bounces-46264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F56D8CF696
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 01:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3E91F217DF
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4B13A25E;
	Sun, 26 May 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="f0jxAQeU"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4313A249;
	Sun, 26 May 2024 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764401; cv=none; b=gm3WRh31S1b5aTiDClGzkop/kIOqjRn5QZ45I6WPxOxIU1/PyEKXkINuNnH4hIrC83CEC0WHaE5AikF+FfbLUPcLGrl15LgryvK6MxJ4KCSEiGTYmjXXCfZcl5OXK2AvE2vCyNyJwtJzctfxf8vjguC6yzL9WRVJXnbvXS19rew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764401; c=relaxed/simple;
	bh=DLCQLdxVgTtTGfBYNyqaHIY6PthjlQJlceu9eYDHVdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmWhSFXJjHw6NIomKd3CyM2GRNlrM/N0HlZ0ijD1JYpwGbpfVol6+5PzxmBdrasqBNAB9QIVJ++YWFvHs+dw3TNO5x6aS1S5Ane7I1jWcNbpFcNCQ0CQnXnkDgSqm8naxj+TT3S4fgkeQVwKEVcmWnI0m20NDF09cWVAQGmMQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=f0jxAQeU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716764390; x=1717369190; i=w_armin@gmx.de;
	bh=Fe1/yqMr9Vd9hkRGY5QbLhHrFxGS8m7MaTvM1j9AtSo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f0jxAQeU8S6vfpmKQAoPxinbacp6DrSz+cKpqqv13UG+H1XESnRnIXeE4OOU3RMG
	 ORaA7JbtM8grFunIS7Tm+5fvRsIDF7F+d+PW6LiIE+afGBj9jCjVhuXMgYa+vjiMP
	 70CIX4ZZcy5iAIXryYlvDKnAnTXDbcu/EvJt1A/0B/ERCjKdMFwbWpmwh0HQtE6N6
	 XrRuP4wYA5ZgL99ZESx9I3s16qtG7Kf+8u9Ma6yH2wxsGze3OvAvHNpU/pRv+IP5D
	 R4dmmXcYBXuJ/ws9jKZmoR/7hpqY4flOJpcuAo7o8ITG62vQ8DeGrVGOSCoHModVY
	 xp0AjCXehzyvwebxxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1sps3O1umy-00net0; Mon, 27
 May 2024 00:59:50 +0200
Message-ID: <d691d3c3-1cb7-44c1-85f0-ecc3c74e966f@gmx.de>
Date: Mon, 27 May 2024 00:59:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240526194314.3503546-1-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240526194314.3503546-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esSObLW599WiWNqzakeNzxbf8n553kU/Z6Fa2I4u52TVJoj8gth
 6tGIX7lyKdXOwuA7hQKVAd5p5QetPdkuSVNetgG6fOuGfcxU1S1Bx5wCyvQaR0vZJW1XwJ5
 9OYxL+kFIIANIYJtnJqFktleE52qi1HWqVkTMTuTDlQSb7U2Fx81ehqFs/HHjJ9w8sxydsa
 C9w/V2jN5znY/wPiYVE2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M6DJotIsNhE=;Nzjs4QwqI4mufpAzzY+NfO/Wno/
 XY4CmHFC4X98z3P/dzdtkeAzA2noB7BdZvnE5elhwDedDZ2Uc/85K73FtOCbZmZT8RRm+NftB
 u0H5AkYxOBDv2zGPAI67useQEZVJdgQ/dUajuAwXqHJT2pyoC0G51e0OcRLjFovMnrX4Xnasn
 mhUgs2AdahoUk7o7+pRQY9ziUT90OWvaHJXAtIwQob0vK4YW0EOpIWg/q2FuYucPVflbJEocA
 A9a1Q1PLNx2bJfByEVj+R8jGsahERStigh35kXj1rSEu5ACCSaWhWspuhmXmq93imKmtkyv3j
 81NbBcYLMTMF3IFQ0I/g/+NM4zrt0dmv6ia0N1Z58mHGX25p+yfX92KceN+XNjrOwwtE1w9Q0
 oU0+RVgvs88vNZGOUtApiLqn1ywptW/2YB+m0nEB+cT974oHDTq4Uu+J7D0a97mmLLZWKZ5ET
 +S0ZWnqSNSjI308JhXNChNcVCIiFv4Hq7+A6yi+/RpYNmLJr1z6e+P3nZqpd1NyALLBYrGf+r
 1I1IBjJEnjZMvjzOH30LBFLTzs8q0DVta7wVr1uvISCACSBI1ctiSuUxLjAiGipj84rIJCvzh
 sLf9G0JFHrAUsrMFUm7sGrgXrnMz70vSWrbKyL8AMGjvgBuNncq2sc6G6EERbSYHf0JRbIdLD
 YSHwjlsUyuqOe2eEivTsfC8RnITMk+x5Np763Kld91pxyV6hHAYnJro9RsMzj1tjOQ6h+TsoB
 WK4q605UkO66xgIJVyIeNtIP+VWlMx88ehOAsxoM0hQ2+iwEBH6SuvGTmlMrewEjwS8z0MenM
 rk+tB/ELBJ6rkmHEmSUxMNejUdlONc/6lPNvtcjlABNgs=

Am 26.05.24 um 21:43 schrieb Sasha Levin:

> This is a note to let you know that I've just added the patch titled
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
Hi,

the underlying race condition can only be triggered since
commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on all CP=
Us"), which
afaik was introduced with kernel 6.8.

Because of this, i do not think that we have to backport this commit to ke=
rnels before 6.8.

Thanks,
Armin Wolf

>
> commit 831f943a69833152081ec7393af598f0c8b415fa
> Author: Armin Wolf <W_Armin@gmx.de>
> Date:   Tue Apr 2 16:30:57 2024 +0200
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
>      [ Upstream commit 290680c2da8061e410bcaec4b21584ed951479af ]
>
>      Multiple WMI events can be received concurrently, so multiple insta=
nces
>      of xiaomi_wmi_notify() can be active at the same time. Since the in=
put
>      device is shared between those handlers, the key input sequence can=
 be
>      disturbed.
>
>      Fix this by protecting the key input sequence with a mutex.
>
>      Compile-tested only.
>
>      Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver"=
)
>      Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>      Link: https://lore.kernel.org/r/20240402143059.8456-2-W_Armin@gmx.d=
e
>      Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy=
@linux.intel.com>
>      Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>      Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xi=
aomi-wmi.c
> index 54a2546bb93bf..be80f0bda9484 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -2,8 +2,10 @@
>   /* WMI driver for Xiaomi Laptops */
>
>   #include <linux/acpi.h>
> +#include <linux/device.h>
>   #include <linux/input.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/wmi.h>
>
>   #include <uapi/linux/input-event-codes.h>
> @@ -20,12 +22,21 @@
>
>   struct xiaomi_wmi {
>   	struct input_dev *input_dev;
> +	struct mutex key_lock;	/* Protects the key event sequence */
>   	unsigned int key_code;
>   };
>
> +static void xiaomi_mutex_destroy(void *data)
> +{
> +	struct mutex *lock =3D data;
> +
> +	mutex_destroy(lock);
> +}
> +
>   static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *conte=
xt)
>   {
>   	struct xiaomi_wmi *data;
> +	int ret;
>
>   	if (wdev =3D=3D NULL || context =3D=3D NULL)
>   		return -EINVAL;
> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, =
const void *context)
>   		return -ENOMEM;
>   	dev_set_drvdata(&wdev->dev, data);
>
> +	mutex_init(&data->key_lock);
> +	ret =3D devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &da=
ta->key_lock);
> +	if (ret < 0)
> +		return ret;
> +
>   	data->input_dev =3D devm_input_allocate_device(&wdev->dev);
>   	if (data->input_dev =3D=3D NULL)
>   		return -ENOMEM;
> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wde=
v, union acpi_object *dummy)
>   	if (data =3D=3D NULL)
>   		return;
>
> +	mutex_lock(&data->key_lock);
>   	input_report_key(data->input_dev, data->key_code, 1);
>   	input_sync(data->input_dev);
>   	input_report_key(data->input_dev, data->key_code, 0);
>   	input_sync(data->input_dev);
> +	mutex_unlock(&data->key_lock);
>   }
>
>   static const struct wmi_device_id xiaomi_wmi_id_table[] =3D {

