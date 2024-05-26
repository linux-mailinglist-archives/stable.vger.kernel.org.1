Return-Path: <stable+bounces-46265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C48CF697
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 01:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84F71F2180E
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37C13A249;
	Sun, 26 May 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FYvH7vut"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5F1D53F;
	Sun, 26 May 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764446; cv=none; b=is2WhQdFz1kgn3Q9/kC9za1h6BShDoucocm0w4P6Rezl2cBr8tjwQMS0DTi46w0zf66hTOP+5iAZzViwvTAWcFKrmy8ssYv7UIoovNzCaBdiHvbqYLEYch1hC8xatNKWq/RzckwhunFmYZYVNgHKCB7wEE2CRedt9PfT8rpZVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764446; c=relaxed/simple;
	bh=nVoUrABlNf/LuFfJDUCuSTIh7HhULC38XvNcQ/QKjU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxvYMGDO5PzFlRABEndJwU4YrvCE1mw6gYOVuITltEerMXep1/7dFfUGVe77+DhXsqHfy5yMvBBLMRRczg94tD55qrub1TpVAKo48mzwCkFhyt9YmRY3deZ9KuSxLxgc96ZmMYjAHuP3pwawY/Svc1B5QeRWUzqIT1XuZbpt0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FYvH7vut; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716764436; x=1717369236; i=w_armin@gmx.de;
	bh=8nhE2wxQo280RSElGBdrmA3I7Y5cWcuFJwiPUpCqagM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FYvH7vut97b4pLzXKLzZ3qe7BpHBvR0cYIyz5n8pTDqAk/231vX18uTZ5fQo3uk9
	 jQrOT9UKD46lP7cdpL3tfJP3UHxoDL0z8uhRz9Ws770HmRA7RQxN9IXlVWxhfO0Xq
	 i8uNw3JcyitZo98GKjkEysFmAff5xZNkjihL9p5ht7qI4nrFup0kfUBSQeEAiAOgi
	 40Lp1hCeiis0sAeOsbUlM5lidaJKGMmpYdzgn+GGylp4J4CFkzfUsq+lbhvY810p/
	 ho34qCskhHGd9zIgTY6EOPtFNvfjd8P7EOvpQZ72MKmpw4xRPHc/eGozLXAtwXxO5
	 huP4Yh5A+ZC42jt2uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1scl8q2oPU-010uLO; Mon, 27
 May 2024 01:00:36 +0200
Message-ID: <b5ac004d-6086-48fc-9ec1-6ebd7eed173b@gmx.de>
Date: Mon, 27 May 2024 01:00:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240526195729.3514856-1-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240526195729.3514856-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SOl2fAf09sC+QMS5nR6n2Q4WmFsVDKJMEuTg/iKRJTbEyukXZVl
 LftcOlvCqh11V3lHR1DdkAJ0P9PVWrlJYl3Jxb5asWSweMDHRzDwuGpruglcikGm9bojI3F
 twBPhFIUdkwJ2QZFyOE8LaW6/RL5cF5v2RYxxBPUzLZQmmExYR4Rx+LPGIym9P6hd/fvVFQ
 tpE4L+Qh0KHxdJEjwUF0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OR7KfQVDaoQ=;RPY+VEEznr0NvfDPd2J9fWwKZAU
 14pXOolw7TR2K88hJgpwGpo5te21lxAbXhrJP+vXsFMXmeOKskx0rNHIkfimbNLkfC5bGQOpb
 m6/1/TK0PuKui5S/iGR3Sn5fdIwxMlAwcQHLYv440QIWTXBZliX3puSANl69tr7fILKJQAnKl
 YIq0tDVeDUkh74vDww2ccjRpuFZQhF5aut/pHjDL6KaEX7iiAb4mtNV6R++BIniUatFkiDYlk
 ttss/S5tGacN/VzhNvzmAztbBZ82/75Y9xCrdWmuklIbTH3j4BgkdNDNQjg/Tlo02CHDh9vSs
 5oR26f9DnzJiWhnTnWwJmHyDxGCHHkdbe+J29Fv665Ks2YqICalhb6J9UhvXdq78OWa/tQN3x
 fHWHFdO5OASDveCezCLLapysTuWWOrDar5A+SRXqCJ6Awjdwv2u86AQrmyYyHa1+Pp4wnCttt
 Wrhj40U38kZpeoY7kFf7qCVQvk0O19FyrImshGHfc8Da+n0niTyZ+PAGhQu+2nWNOEY+ByyGn
 RKlJsKE66batseIT+ysf2cuGe4GK6HwJLtvkRBmwi3jUPcvB1o6UCWgRTr5lPYM2rjiqNDFhr
 9G45eZd9u3zNwidAbcH6i04MyAIqhqcMDLSM1EYkwfdTTs/ktUHULrRSW1HCwGJxjSsCKFo6N
 pPtBxWeoyotudjGSBKZeXif003jLF5YIHz0WkzQAww7g+v22KeN0stxz6Hsqwlz2OzNVWYbIG
 vitwNuuKM1dYp+inN6LGPZIVAd99Qm5Zjo9O5PNGQZybTuk2rO1Bf8RvFxYIv9VyEMEQV2Z4V
 R6xfS7wCsm+V/yvG+3v+TctF1cK0u+F9begG2yQ5t2iac=

Am 26.05.24 um 21:57 schrieb Sasha Levin:

> This is a note to let you know that I've just added the patch titled
>
>      platform/x86: xiaomi-wmi: Fix race condition when reporting key eve=
nts
>
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> and it can be found in the queue-6.1 subdirectory.
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
> commit 1abdef69265133db29772ed5cefea2338f8ce173
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

