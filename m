Return-Path: <stable+bounces-46266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5B8CF698
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EA11C20DBE
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 23:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88432139CF8;
	Sun, 26 May 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TbiTwXZ4"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE11D53F;
	Sun, 26 May 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764462; cv=none; b=Ua52OTRzj/gU881rKqT6ijkTqXoHFJhcwCkgPCSGB9WzZ68S1WFtt5Xj26DcdTRgWRjv8uRW/46ZZE9pRRpyR4QWxImp3dBPfhM44opjo6UspS/P3JC3fB+oObQjYOhPPrs0z6TJ3QF7LLDNPPSDvsgtbmUsaT15OGvxfyt5tD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764462; c=relaxed/simple;
	bh=EvC6ibCCee3TTt4zfNcqGEyB0TPvVCPpFlLaQfltyK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJV4UgpyjKWUIZrdu/Zlfvrrzecr6dVLM9aDUHhtAzRicy1E52efaNtvBzJ8BpTnbO+YtXqNgdTXys8yQQHAlN5OcQoEJlRiur/Otrd6KC23xucJj23GF7K1XE5APPzFqvKOwsZZjsAQ/FTTSTmabGQho3cYpcO7USmWVLug+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TbiTwXZ4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716764453; x=1717369253; i=w_armin@gmx.de;
	bh=4TuH7MrgTfwd/xaiBwxiq5zSzhSgv92c6sItYcg1LSI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TbiTwXZ484nT+WpGLjiwuhHjbVsP6kBKMe1BUaN6YbMKPNfEpVcVnBq2dBwSCsPz
	 +xloOcCDl91AUFHsVGRGYbjm7QNtVxSnAMi2eSoP+L+6IQeT/mAKen2XZhuth6iNt
	 hwBITXlFDKodgm0l4AxRYoppRcYuLhaQwCohKaHg+Yvr6PHm4KVm9I4Y76fXGSskG
	 gii8MGXAGUW5tSCXdg/akpRyixrpU/qsjljLznzgmwtR28YnH1ttnsJbiDFgvsf9k
	 DSzzc5livfHzaGpow9heaHLgtvH4cvbj92Rr5lTYjSQqjS5f81SpoiIT4rsXqBwfa
	 JcUWFBPZQGwGfFTyTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1snABX14xy-00dE9O; Mon, 27
 May 2024 01:00:53 +0200
Message-ID: <4b856637-2aa3-43d6-bb52-39c10d84af38@gmx.de>
Date: Mon, 27 May 2024 01:00:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 5.15-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240526200716.3522653-1-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240526200716.3522653-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IKZSSBhie5/R7i7ktpq5q0xFLXcTjC4UP6YY96S3+4OfAXZmRzg
 n7Lf9V+pb28iqW4jtwehtbo+GF7bt/ff34MATqOM17jGBlDQym83SFIVNEOr/QvCBik1GYW
 x/hpyAKdjYaTYg0SiaqvFc0pEdIMv5sX9soBWU66g18wmFBo2TLZ+aYkSNX+t8N4zNOohnY
 I7ihexnyziYilgQ4WKRbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3hWAEdJw1vA=;jo1T/8I0SMdDSGDJ7St6r8BMIwK
 F02pnOJClGW0QjtaqXK8eSim2JI6F+GUqFTjQ7uRIpCVY6MYZaI9Q0AryFg5hAr5Do7aeReqH
 h7SVCE3IV4w7xbaxnJDtunaNZV9PSDlCSJEXo66rTpzFW9YUxOkUCu2wyB2J1mfrUpa8r7Jwe
 nqGRsCTdYhJ+ZRdK952/cy/kmiYomkRBWcU4njEM6d9nzmpwVT0SOOIpUtvacQ7O7sym7bbZs
 6r/MwA0EX3RZ4/f5u3DVdamgxZDo2LDxh44zlzFV/BmUQddnGFSGqD/+YYnlAdCscw1EQWNkX
 FGA/vb9KwrvLw1KdcZRUSym5UmmwX1Sf4wZ49iHKZzaOcCL1ydmJ+XXcy3wzxp9a2Q0eDW2Ag
 SqPFaiaA8reOYNcUN8rfMOGNEMqfiMqYGusUthCdQ+GIZgOzpU1ShOtt+EqaiVffBALok/Qc3
 THff9d7ViTjuWGNS6y6PIaIVLw1CpWc9OGiIHLUf1L7lcRhrhG0Tjsay6VNgstqVAddj34Bmu
 aWHhsdXIys6KiGB3m9315izLSxHLWLNpSvSHp2HpTmaQajNedbA+Zj6sS5LzCkUJj+6w3pdSr
 7hCH2Mc1/5oe8bJHBwEuxlzbQatJueglT5pz3kildCL9r9mzuiasq6WDayjahwlbdsBdX8XA2
 RaCnGNP8TV7EejnFvxvweRa2PJ3yJ5gY2AadBGV9VuLWtE/cLzxYdQ/7mo6g9G5Oor/6mVhD/
 WizakXU+B7Mlbxkifl3JCCzqpUZJ0BSGSgSZ38WdbS5J5QC9fJ1WKAKEt6j1DRlPJq9PaRzYt
 4+CKDgPWlpx48k0VFRiJmtCUj7HM3oTNgqyJxPl/Qqyb0=

Am 26.05.24 um 22:07 schrieb Sasha Levin:

> This is a note to let you know that I've just added the patch titled
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
> to the 5.15-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> and it can be found in the queue-5.15 subdirectory.
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
> commit 1f436551dd453c28c23f800e7273136e526197cb
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

