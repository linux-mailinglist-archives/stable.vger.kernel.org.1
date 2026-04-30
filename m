Return-Path: <stable+bounces-242135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDf6Mlht82lf2gEAu9opvQ
	(envelope-from <stable+bounces-242135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:55:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 587484A44C1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1E0301E6F8
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85052428851;
	Thu, 30 Apr 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adp4deEV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB342EED9
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560862; cv=none; b=JD1nh0urx1nbQpQQWJpB2dt1QGo8/u9CbsMsMpjFK1O5YaALN/ccgUw5ImxD5AkzdhYh1nWkZjbGe+Al+FZXLhpsQtdsvzDkgHh7ydNm3dlt4fkTVIgzCas23uSKtIFbcrZas9orZU+WV35NfpTXrh2qmIs0EBgjgDh/dpv4PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560862; c=relaxed/simple;
	bh=VZTJlq5QRnx6a9s3PldKAGp1z8FlIxwAHjB+OU32d30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbcRz9B7JRcMy/SChL4LIetUe28w4sXeFpyKrWIlet8qAw4e4IePjnrb0BXFPxgRYqHn0aKptG8Y+88eIIVi3PzevqAcOm/Q+mo2XFnXvr4fuuhLrcr0nAr6d41tTN/6+6Uq9h2g0WrtWVBFOYnBtS3GHTtoWZmNKPRn9Qbr4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adp4deEV; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6121f20650dso372350137.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777560860; x=1778165660; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPxbjoeeqwnnH+MxEDiX8q4Zku2etTK1rWCxOeGm53A=;
        b=Adp4deEVzmvxUH16KOjj79onMo7/E2fjC53SdcACj9rQL9a9VGZaN38/zzP3Fm5099
         NRSbehOCD3u0itphHVBijxG693SxvRTdKiKdHdbTeMtn15dJJFY2jbzj5035rQfVSXVl
         uQRz12T0YSdSm6K+xpwwgMXPh0aoqhPAC/TEDwvWV/IpslylTzZuNDEe8rBeiJC4ZAYH
         Y9EE05OOPhIUFJ9QBwQrCO9afzqV+wodN9GrYMkZrE537SVUWJm+ABhB5i/l8boaKl8M
         tChV4HJwqd3U/pBoVqihxEAMeBpHuSZUmu3kjzGjNPpBQaRevuPNru8z/pFAT9Wlr68q
         /L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777560860; x=1778165660;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPxbjoeeqwnnH+MxEDiX8q4Zku2etTK1rWCxOeGm53A=;
        b=b09TtadsMuU7c0DZTZg45D6D80ywp5q1YzejFeeJt12ORSgRg7KVJABWA7Dap9LFjb
         ILcuzAmQxHLAlbXJuYYm0LegIdZ0L4RtgcQQiGUrXOSEhzjCzSGphd7VeLnGcF+2Ikko
         FWlHOm8AutNckxVe7/qvs/ZiH09VI1uggcTYZNCr/lbYjTIw6DczDFMobqaLnH3F0OdZ
         NbBHDktubvjuF9jtADQKU9EuQSrqvFwOokhi06qQlO+Vta2WYvN0nKemt3R9/UjBmiOD
         zUvH9hp8QmxRGP+NcJcXuUKL0tRKiH1x7DL8/9j/Igt3NSWQVip3blOdxoTGvFKQDQ/F
         Ub5A==
X-Forwarded-Encrypted: i=1; AFNElJ/E39x3OJLqN1eekTZxjaCz5PxPS186DG73g3v/sSpfr1tdECROa9/6eN0xfy0+QvT11axu5nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIB29YlrnSkkYYGaDYtAibnx95vJkVG+401xjZ2EkFKmej7BAc
	fPnuWaehqYfcAaZH9Y2Y5mGnW0GUaSlqkUEm3+QE0DMZqOKsYbmJE0Er
X-Gm-Gg: AeBDieu++7e3ECoCJ0vFbs2Cm3j+QXHgyPs+DjOOdapT17Hv6VMAgiCjylt40qvuPd5
	mVNlMtFH1YKaaSSlzC1f5fLUg+i45EO/6fmyQdzjTWibnjNHFnU9iaDAibwTG3x1ztU/C1DzGj6
	k2bs6BFZVBS3VIwlwXKIU+H9X4ndFepo0seO/pgm59h9GoiSd5qZdKOH7+Zs+JtYaU88/Z4lDoV
	K9mIYrbE3wy81FKvMwSQTBjW0Bl/R9ykIaW5CdwdiKazGB9MJ3auU0brjtX/56ZVZlIQiUjLPeS
	4FiKuTFik7ILdCW6CMdqb4QBorKlAB0SL/ftesGQHGGmKVG81rogliarnz5zv8njHASSMOzqTdG
	1x/S6mF8BTI23P8+LeknrsBYcgX4TMGJRPqOiqvFNwHgUO6bRJiaFRPnJ+qih8Td6DCm4+t1Me/
	+Ou4GnIkLBODk1lzgjXDbgwJPXQWATLlSJd3uHHYqPGg00YIgyg3oGWr+vTj8UYgsFcDSAxDUk6
	zm5kwQZg3zN
X-Received: by 2002:a05:6102:2b82:b0:607:97ef:4dae with SMTP id ada2fe7eead31-62ad384adb2mr1634824137.16.1777560859763;
        Thu, 30 Apr 2026 07:54:19 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6298433531bsm2947616137.9.2026.04.30.07.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 07:54:19 -0700 (PDT)
Message-ID: <6b19445f-d684-47cf-890c-82217a941cf0@gmail.com>
Date: Thu, 30 Apr 2026 11:54:13 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/tas2781: Wait for async firmware callback at
 unbind
To: Takashi Iwai <tiwai@suse.de>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com>
 <87y0i4mu22.wl-tiwai@suse.de> <87wlxomshl.wl-tiwai@suse.de>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <87wlxomshl.wl-tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------op0KNBokqrHZZ5pVmcRKqSL6"
X-Rspamd-Queue-Id: 587484A44C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-242135-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------op0KNBokqrHZZ5pVmcRKqSL6
Content-Type: multipart/mixed; boundary="------------JK5HSCf5sfRfgTrkkCUWy2Ma";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <6b19445f-d684-47cf-890c-82217a941cf0@gmail.com>
Subject: Re: [PATCH] ALSA: hda/tas2781: Wait for async firmware callback at
 unbind
References: <20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com>
 <87y0i4mu22.wl-tiwai@suse.de> <87wlxomshl.wl-tiwai@suse.de>
In-Reply-To: <87wlxomshl.wl-tiwai@suse.de>
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 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

--------------JK5HSCf5sfRfgTrkkCUWy2Ma
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/30/26 11:29, Takashi Iwai wrote:
> On Thu, 30 Apr 2026 15:55:33 +0200,
> Takashi Iwai wrote:
>>
>> On Thu, 30 Apr 2026 06:02:02 +0200,
>> C=C3=A1ssio Gabriel wrote:
>>>
>>> The TAS2781 HDA I2C and SPI side-codec drivers queue the RCA
>>> firmware load with request_firmware_nowait() from component bind. The=

>>> firmware loader keeps a device reference and pins the callback module=
,
>>> but it does not protect the driver's HDA private state from component=

>>> unbind.
>>>
>>> The callback dereferences tas_hda/tas_priv, takes codec_lock,
>>> creates ALSA controls, updates RCA/DSP state, runs runtime PM, and ma=
y
>>> load DSP and calibration data. Component unbind currently removes
>>> controls and DSP state immediately, and the later device remove destr=
oys
>>> codec_lock through tasdevice_remove(). A delayed callback can therefo=
re
>>> run after the HDA component state has been torn down.
>>>
>>> Track the pending HDA RCA request with a completion. Mark it cancelle=
d
>>> at unbind, let a callback that observes cancellation exit before pars=
ing
>>> firmware or creating controls, and wait for any already-running callb=
ack
>>> before tearing down HDA controls and DSP state.
>>>
>>> Clear cached kcontrol pointers as controls are removed, and when
>>> snd_ctl_add() rejects them, so a later cancelled or failed bind canno=
t
>>> remove stale controls from an earlier bind.
>>>
>>> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
>>> Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")=

>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: C=C3=A1ssio Gabriel <cassiogabrielcontato@gmail.com>
>>
>> Hmm, this looks too complex than needed.  Basically what we want is a
>> simple cancel or sync for async firmware loading work.  Once when such=

>> a helper is provided, the rest in the HD-audio side will be just a
>> call of it at the remove or unbind.  And, I guess we can implement the=

>> helper in the f/w loader with a help of devres or such.
>=20
> I meant something like below (caution: totally untested)
>=20
>=20
> Takashi
>=20
> -- 8< --
>=20
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
> index a11b30dda23b..bd99c5417be8 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -1140,6 +1140,20 @@ struct firmware_work {
>  	u32 opt_flags;
>  };
> =20
> +static void firmware_devres_release(struct device *dev, void *res)
> +{
> +	struct firmware_work *fw_work =3D res;
> +
> +	module_put(fw_work->module);
> +	kfree_const(fw_work->name);
> +	put_device(fw_work->device); /* taken in request_firmware_nowait() */=

> +}
> +
> +static int firmware_devres_match(struct device *dev, void *res, void *=
data)
> +{
> +	return res =3D=3D data;
> +}
> +
>  static void request_firmware_work_func(struct work_struct *work)
>  {
>  	struct firmware_work *fw_work;
> @@ -1150,14 +1164,10 @@ static void request_firmware_work_func(struct w=
ork_struct *work)
>  	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
>  			  fw_work->opt_flags);
>  	fw_work->cont(fw, fw_work->context);
> -	put_device(fw_work->device); /* taken in request_firmware_nowait() */=

> -
> -	module_put(fw_work->module);
> -	kfree_const(fw_work->name);
> -	kfree(fw_work);
> +	devres_release(fw_work->device, firmware_devres_release,
> +		       firmware_devres_match, fw_work);
>  }
> =20
> -
>  static int _request_firmware_nowait(
>  	struct module *module, bool uevent,
>  	const char *name, struct device *device, gfp_t gfp, void *context,
> @@ -1165,14 +1175,14 @@ static int _request_firmware_nowait(
>  {
>  	struct firmware_work *fw_work;
> =20
> -	fw_work =3D kzalloc_obj(struct firmware_work, gfp);
> +	fw_work =3D devres_alloc(firmware_devres_release, sizeof(*fw_work), g=
fp);
>  	if (!fw_work)
>  		return -ENOMEM;
> =20
>  	fw_work->module =3D module;
>  	fw_work->name =3D kstrdup_const(name, gfp);
>  	if (!fw_work->name) {
> -		kfree(fw_work);
> +		devres_free(fw_work);
>  		return -ENOMEM;
>  	}
>  	fw_work->device =3D device;
> @@ -1184,18 +1194,19 @@ static int _request_firmware_nowait(
> =20
>  	if (!uevent && fw_cache_is_setup(device, name)) {
>  		kfree_const(fw_work->name);
> -		kfree(fw_work);
> +		devres_free(fw_work);
>  		return -EOPNOTSUPP;
>  	}
> =20
>  	if (!try_module_get(module)) {
>  		kfree_const(fw_work->name);
> -		kfree(fw_work);
> +		devres_free(fw_work);
>  		return -EFAULT;
>  	}
> =20
>  	get_device(fw_work->device);
>  	INIT_WORK(&fw_work->work, request_firmware_work_func);
> +	devres_add(device, fw_work);
>  	schedule_work(&fw_work->work);
>  	return 0;
>  }
> @@ -1259,6 +1270,28 @@ int firmware_request_nowait_nowarn(
>  }
>  EXPORT_SYMBOL_GPL(firmware_request_nowait_nowarn);
> =20
> +static int firmware_devres_cont_match(struct device *dev, void *res, v=
oid *data)
> +{
> +	struct firmware_work *fw_work =3D res;
> +
> +	return fw_work->cont =3D=3D data;
> +}
> +
> +void request_firmware_nowait_cancel(
> +	struct device *device,
> +	void (*cont)(const struct firmware *fw, void *context))
> +{
> +	struct firmware_work *fw_work;
> +
> +	fw_work =3D devres_remove(device, firmware_devres_release,
> +				firmware_devres_cont_match, cont);
> +	if (!fw_work)
> +		return;
> +	cancel_work_sync(&fw_work->work);
> +	firmware_devres_release(fw_work->device, fw_work);
> +	devres_free(fw_work);
> +}
> +
>  #ifdef CONFIG_FW_CACHE
>  static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
> =20
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index aae1b85ffc10..f7a80ed9c825 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -110,6 +110,9 @@ int request_firmware_nowait(
>  	struct module *module, bool uevent,
>  	const char *name, struct device *device, gfp_t gfp, void *context,
>  	void (*cont)(const struct firmware *fw, void *context));
> +void request_firmware_nowait_cancel(
> +	struct device *device,
> +	void (*cont)(const struct firmware *fw, void *context));
>  int request_firmware_direct(const struct firmware **fw, const char *na=
me,
>  			    struct device *device);
>  int request_firmware_into_buf(const struct firmware **firmware_p,
> @@ -157,6 +160,12 @@ static inline int request_firmware_nowait(
>  	return -EINVAL;
>  }
> =20
> +static inline void request_firmware_nowait_cancel(
> +	struct device *device,
> +	void (*cont)(const struct firmware *fw, void *context))
> +{
> +}
> +
>  static inline void release_firmware(const struct firmware *fw)
>  {
>  }

Hmm, I see. Thanks for the ideas.

Ok, so that's what I thought:
=20
1. add a firmware-loader cancel/sync helper for request_firmware_nowait()=
,
then use it from the TAS2781 HDA I2C/SPI unbind paths before controls/DSP=
 teardown.

2. make the core helper handle the devres teardown case carefully,
so automatic devres release cannot free the firmware_work while the queue=
d
work can still run, and document that the helper cancels a not-yet-runnin=
g
callback or waits for an already-running callback to return.

I'll send a v2 two-patch series, because of the a generic firmware-loader=
 API/contract
change in drivers/base/firmware_loader/ and include/linux/firmware.h

--=20
Thanks,
C=C3=A1ssio


--------------JK5HSCf5sfRfgTrkkCUWy2Ma--

--------------op0KNBokqrHZZ5pVmcRKqSL6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCafNtFQUDAAAAAAAKCRDQXT8aWv/ugySs
AQCeUdvKQqEfFQ99J/pVHwir01Vnn0Jg5c+7PmuAhMzYngD/VfQSuJImiRmRDxM4Lq0Hhg2OWSDU
n0HTiCRq8Dqolgg=
=uUqd
-----END PGP SIGNATURE-----

--------------op0KNBokqrHZZ5pVmcRKqSL6--

