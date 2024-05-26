Return-Path: <stable+bounces-46267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE958CF699
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 01:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38221C20DAF
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 23:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABC13A249;
	Sun, 26 May 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Z0cAbTfu"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DE8BE7;
	Sun, 26 May 2024 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764487; cv=none; b=mmgfglSpfT/jK+SRF6rb8Nt+9i+D+tHorgisItRFkgnJkbF/0stBynqI5yXhSRpW8CUoMNmj0nNYmnUnnrqQHyYJKMhpwsPVmywCS/rSO8m1yfxmsSTb4g59caOHaHf9dapxd59YsE5vcSXK6GQOTu8XUC/yQJT6tYLU5qssJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764487; c=relaxed/simple;
	bh=UdiX13aBCJ6JK0lMebOQzLQD4aUfgWr0XV/+fAtP4ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrvfIXtCpc0SJDamIQFnnGx0hP8qnldT53HDnDmT17ZTFCeaw8ggn8jZJbYk2JiTujzObyS/kl3Ev/v/+QR2on0n/UfQMr70jNUjXhDcWYuure8fVVB7ehDm3zxoFsfwJ7HMJ/h7m5YPhtVY889J8P8YJJAhlBIYvpSYaXmbOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Z0cAbTfu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716764476; x=1717369276; i=w_armin@gmx.de;
	bh=P5XKCrcACz3TJmn89IhZloNTj9kPqeiccxUgq66mKvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z0cAbTfuKyzTmn9ZtCbgNCIpuKtxn5yYFkIKLBMUVgDbY6yTt6BVCIGwS6zy0TWN
	 lo39rWmR3eLSeM7yuUwDA0Iqj6Qmo9UBD7NksXBq9RQrI7bPlr4eLnsEz/2kMPNiy
	 ymO11IivA/I/haZviZ66iUPSRk/SnGyb6muzAzSzwE+cr6SlzE4VoTW5hQPNBRRNU
	 YvM1lc6D1lqKI5NZyZtNlDQZEm5CXZAOAdPPqfTJ/ZNtmgrk8591ihsRUCuhe1nIk
	 KCx6semR3/yvxcIGasHpVflAlNfBj+HQ0HiIvJzoO6gbVEkTnBbm0Citn9aLfakTL
	 5IC9MN5+kQKeikAzrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1slFRh2han-00akQz; Mon, 27
 May 2024 01:01:16 +0200
Message-ID: <07a90693-980b-4bfa-afbb-95a98e04371a@gmx.de>
Date: Mon, 27 May 2024 01:01:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 5.10-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240526201420.3528366-1-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240526201420.3528366-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:baoU9oKAHFpZRlq6uhG5Vs+3rDrQsJE5CjSH59rehFx9I9Zfq1z
 HW6YM9vwliIbBiDQfK9eBN+4E8xY37VqmorgWKn3VPAbqezjikw0ipB4hqkaRTQ+SlCCyA3
 pjDVCBLJ11/v3gPZC2+I5m2/pEXquGOe7tA7Vi0ObHF+kNb7k03UQu5KdfVVeajHvi3cToj
 +mo8EZojQpvFcI/0u/2Xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ia25sJgR3Dc=;8lRgBlwp0Y2QTVFhzcJ/B6ufy41
 4TEVMnLYOtPZs2tmU+1s4MvSLfVU6KcTQeFgOuqvZXj+kjkg2qFgK7NraWNE3l/ZVS62UZR96
 EGqHbKbcwyOMrH/2ArsyD2B5uAKyTNbC3YuPVUhXSiQQdSIWsbtaHJsOYd7sEfLVz34vg+ENE
 H5m7+wl/4oAap5wQnbs5bJn3IISaqe/vFCHhHR/apc/pWTpvaNYTgrtCUURR+b0izenwHir1D
 x5x7nD6HmUDK17fzZchDCA+aHaEO+Vh7FbPybLMdNCeZaBov4LEJLlqvzY5lcch+ZzLvViyg2
 ZR+X+zD2LZIOXMPwDnzVjFTezfECPVZt/50dUCZYUHv1RzbUIHsgBJgZaMHghjv2+R1Bz5xtL
 zTK4QRXL0LHIwigdVLsAwj03Wn+Ij3t0rbO5hq0/pLP1pC1Ad2uJn+IU0tZKkcD2HlOuaCZwx
 OAwNFPpkVHkfntwwYkwEwyW00vh1qOV304cftWLnhEo4RtJx+fWMnOK9W7wlrp6NXkayMmohF
 Df30SGDx6F4N9PHjQm1BMr3OLs1MKJ0tnFjvJlUf2VFHpU4f7gHVomItNzrswOICQyOSqMJEX
 VmQk0CqTmYnXsnuHzuJuq9uw3gUNjL0cfdPBODoMei8ptDrhqxps0INkMxwS7MRYntECFBkAg
 ED3PSTQnudfaMnYelTC+yU+bxXlHjBlppKvYObHVCHJCeHONaCTinvn7duMvuBq1roMa/tWUS
 x3oSwe0IV0uIl1xQbDVsSicbhpKtRkhyQ5TiTpi/thH9pP9dNsQ+9qcq0Gk06nMfNx0d5SuMI
 If9fu82TkuuXLr8siNdtFzmpwrHLnn+XoWriKoIpSAuEg=

Am 26.05.24 um 22:14 schrieb Sasha Levin:

> This is a note to let you know that I've just added the patch titled
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
> to the 5.10-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> and it can be found in the queue-5.10 subdirectory.
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
> commit 6f4e7901c3ed3c0bd3da7af5854dbb765fad2e00
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

