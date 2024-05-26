Return-Path: <stable+bounces-46268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA68CF69A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 01:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FA31C20E04
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9C13A25B;
	Sun, 26 May 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rp874z8g"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0858BE7;
	Sun, 26 May 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764501; cv=none; b=jZHrGNMjQNqGidc/01ushVjzIKE1LGkNzof3abxkGIat7kC8+wkqtM1av9MbuZMPz+TO5mmQQy7PoK1Q+oLVSLF81KcPAD0VmCGztbnseJ4qOCs22tYTPJGkg4cMSft2DURtmYRmEWFJTkEh3bGWluFUy4/+C8Zyys1J0I/GkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764501; c=relaxed/simple;
	bh=yEf6H9ASKqoe1wI0vw/m6lROI1AG6jgIqiyo1OemTRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5tFbR8DbvEWXFsXSWv7ju7FPV4iCBgeoVMKbu6CMHnDsOGvMclBdctZaFw5zbMPdRabcgKORw3muxNlgNMbF0GKdpVZjz37NBcLkalQvprIVxQp2RQsNlkIEwOr+lIT4UD/gzafx1qxLLhq/tmKBH/smEHGvOsGpPdrn2daCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rp874z8g; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716764493; x=1717369293; i=w_armin@gmx.de;
	bh=TenjI1yYTqFMTEXgi40OyMSL7VO4JIbpZTD7vRC/7Xw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rp874z8gM1QQsrSLvSNjwZMNGe04YjBNVvKiZOq0Zs/3yCP+3gcfgCC/JSaXI035
	 FMvZp9TwEPgWeiD7M5783PBMFaFk+vkeyHbaaFo/18XheVlYimHVnwWiZI0mvokHm
	 oW8ApU1GFw3qWOgj/ZdxQxEY+xpMbgtt0dg1gvYwGInSfgbULB/TnSU1EPe8qA/x+
	 XwViToRM1Ct096i2HedNH2c2M90qU+8xOn2xKQ87O5Y73U3LAZ/RR8DUZ0onF1qha
	 +TsZl9h50qpFOCU2rLo3FJ/VfSmvLFBGBv9llQpigrxNfduZ52KVkP/WMagz4DbWk
	 N0Zm2Gl3IKBGHiHmEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1s9gZv0wTm-005Guc; Mon, 27
 May 2024 01:01:33 +0200
Message-ID: <937272d2-faf4-42cb-93ef-a00386edacb8@gmx.de>
Date: Mon, 27 May 2024 01:01:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 5.4-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240526201947.3532748-1-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240526201947.3532748-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0tJL7agWguo7Vm8gRgb5CXgYmYM+2xV+k5CogMtDoeDKdJ3DUfT
 wkCck8RHvrWRr7vBgCFDs3vofyIheAr1LSevoJzyB+IqfvF2gQw40e0v88a7WKTEkx48+b2
 DLE5lKmQbn1bEx6tHZuLoRAT5nAaBnr/JFKggBx6z6h6dpxJYdVrOKwyZh9H/6ljEfgcuMT
 6Va6b5UfTHXmW7T+5A/xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fBt26L8Pe9U=;NC0AuJR9WUrheNmxxcvnKObFDeO
 mq2xY/YNlJXQwYIGekK5TV/vasw9+ZBxotOIPsfELWM44rLGrZnEo1yjH9r73bIrG4CDqOxeZ
 F06rFOP8hu21cqV0aaeO8QE02oc7JOJOj33OwklFJ4tDdNeJyfHDN6Xo40kfvrv8Sh6xH/80T
 ObJhvgYhdHpQKSTqy/U4OQJX0eERRaOyYja+tng9pmTwUAYO+x1Nh1QNk/UDByjBq/+561fbf
 jds3Zsi4Fe7U8ZhAJa4JJhWiWHlsbnfJwJXpr3uUSn+VSAdN4xthFouDyyGzZ3bVHQVTvCSB3
 nfHbR+c3MWQEet3sz/pzcA7k4PNTg/rJOlX2vO/lbNfYbcx0Q4HezEx53Q9zbj4iyRR56IFCt
 QfjrOOQElDKRT7dbuIaBH2dRVKRqQ5X8iw4F97WWPlVOhrpLA47xbtvy3TsjYNfdywaYI4JbF
 s+QdzOM0DTQblVXpCK3YjCgcWPZpgpCvF643cmsPsTfxkyn2I8tkEMzxkW7P/k0HIHZdG2z2L
 8mFbuPPMJGefAgB5sHpPOuJbx0zH3pL4RUE3Qg/2aDIwfJT2qGqf2mocyQhk2r16hv/7GDXut
 bvLL2gRJ9xnjPkSv9xoWjNSo9enncedsoz+Z254V5gtTeCC4Tqkys1obD9h67ZNqH16rX6bIU
 tvo9H70O0wU/48GQrxkSXm9DkIKAmpATTMqyy5QwCggNO7Lcx4Uuf7VnfmWUU48CN1gtg/fZo
 ZR84n/xMnK0qtTOPYbCWrAd2jqybdWM1G00TyDMRAnUzAzHsg8KwC6B1aalELTh8z5z+XGrHi
 FygmhR0tDLvuuX56qmZNTKc2IeqaAh0uGdPrnalpHzXWU=

Am 26.05.24 um 22:19 schrieb Sasha Levin:

> This is a note to let you know that I've just added the patch titled
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
> to the 5.4-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> and it can be found in the queue-5.4 subdirectory.
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
> commit 7217162b48f60edc29afbeff641b7de02076bb86
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

