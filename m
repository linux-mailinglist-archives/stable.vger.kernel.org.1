Return-Path: <stable+bounces-240535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFveOqV06mlAzgIAu9opvQ
	(envelope-from <stable+bounces-240535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:36:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A2456D74
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFB6D300491E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFD314D0D;
	Thu, 23 Apr 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8PBWYqr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE393033C0
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972961; cv=none; b=LBBlxL9/GDc2RqNoeRdL0m/4hhyAjIHULiTafKyTkXUsjGmSwCYBXckS323Lh6npVjwf3LQS5rt7E7RkMFrRgIt8ppaKz4r+I9IUmABhdHvkKNoNKU4Vhr16qu58+UKBMhbZcbp5lK/iNienAUdwDdfM49VWeVvbKh5KLUVsq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972961; c=relaxed/simple;
	bh=+ROQYDUPR3KaBdvxioUxfURKPK2CiZkWQqklVW22WfA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntyj0SONb50f2mzCFXtVPhGK91au5gURfvz+0wdq/eSOIk4O/G/2P5isRI3zBK/iE400cDd+8ujUOrJaRHuCKj3+RsfiN+s4CiohKEUgpeYBEFDlflX9a95BNBReJ5TTa/GtxV7PYSd/Lzap5NWPznOUUaBWY6tlE6KToqOhCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8PBWYqr; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12db63c6df4so4170057c88.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776972959; x=1777577759; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/qPcMgZ+YR+uvy+PQQIty7E7QSzK0iXUhqFNtXYgWA=;
        b=i8PBWYqrmrreRuj2aOxJSEfDMDtFSMdYOhsVdFxSlfUBGZwlH9hEh3+Jc3rePqkYD9
         SHKvuDptCdtOme4yt3+XKD4OUKR9Jci5vmxaJdP1lqd/IcBMrzSE+nAhp8kgjjjVFdRQ
         T6rcNgTPzJfwG7HvsxrhAnLpJofuBkI1qWkYkOk7WO7EDp4a9t5yqxhQzax5hX84lfr9
         D4F4pdue3FD5I5o5RP+ahiazhxM0B2WUIOsTH9lh/RvZ4XZuetTJTa0xeSCSYBT2S8eQ
         ufEg94Zfo1HJWPY7UYcSvVK4Bz0aj54H0vCwqUnAU0iVd7pteIWmE8o4+eaBa8wUWI7w
         zyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972959; x=1777577759;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/qPcMgZ+YR+uvy+PQQIty7E7QSzK0iXUhqFNtXYgWA=;
        b=V0j3Y/0GStuvOy5V+WrzJYWNPttQkdPjda+Wurk0fy7puPQbgTpUY0Fiv+hYtHYTF9
         8IugzWuMkPFqcWgtP+t0zZHaAJFABR42T2QnuCZFtQ3sSe+C1wjCv0PNJ7orim1XxeLo
         hswAEeGKJLEUWhRXTZUCUhXoo9s+1lxTtcnAo2GwdnepZF1av9EiGkx7RHxWfupxxvlT
         W8pPk6fwmmKuRCWWdjoNWVMtQSA61yyDcIgyoeGbad5e6QQz9Yyk8nAmcdedFDu7olVS
         OK2vzbK41stslZktmb6E2XR9WJybaVeu6JWQU+lKEiGcCNjFrTKYlYu5db0kWBBvcSXl
         QKcw==
X-Forwarded-Encrypted: i=1; AFNElJ8X83fAdusDWmsHeeSP9vZkEd+Gl13sibFC+EsMV/a33/ce2AHJUxddxHLP/OIX5e/Vr3JtOhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfves7UPW7KoRzsg9o90b6dFWokNuoTx/mQWYtyZgN3peCBAO
	YDNgkryIL9db0EH7BAJifOTOXiGXu6+XHFvIGxPYqKYzcY3sKXLwWBYQ
X-Gm-Gg: AeBDievGAXeeNb/vfsMf5RaJDZA3Fuii0Gbnq7+SoORBF8TRnDkmw03Zvukv35dz0Wc
	aG9r8EGI3IfVsdwW2llGpkcKzO9kHUD3z9JMEpif8fsqzfCQvuUa8Ht5m4D7QRsj5aRNYH2oETI
	R/8Z76Nqx+lFit1QPQF3paAtval/3Rd0dBeIUug2uxHAwd1PQVqWiVZtHzoYSG3DOJECFjLtbxV
	uvwpD6DC+ZYlRauCQbSrU/z5DiN2sTUZ68XIDXr0CqjpX30+g/c9fspOV7mlFSjRtYt4/tTKZsN
	yWvrdSXs/QZrESwSRO2CFBQsDIakL+9sv+/hqWTKFeRJabWergisQOImsdLI5BSnYd8UinftgmT
	DtTzDURCWaSJClEyT89ai0jGfHRIJgNPYkpPmwlomKH5wjw+pfdHhtUAA0B75O6J1U7k1/icY7P
	Wj1nV/7A/M5kkfrB6vjJttyGg1cyFL+asfBv1pHUXQjpBeuibDKMMZhopiJi5T09VkHm0MakZvp
	aoRoM+tH34NS+YNBFrGbZI=
X-Received: by 2002:a05:7022:383:b0:128:d4db:447a with SMTP id a92af1059eb24-12c73fa73e6mr15582618c88.29.1776972958642;
        Thu, 23 Apr 2026 12:35:58 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm22518055c88.1.2026.04.23.12.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 12:35:57 -0700 (PDT)
Message-ID: <29ae429c-59af-4360-ad79-7fa2f2e02212@gmail.com>
Date: Thu, 23 Apr 2026 16:35:51 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control
 errors
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Takashi Iwai <tiwai@suse.com>, David Rhodes <david.rhodes@cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com>
 <876d2550-751c-4299-a090-fb7f4d264bde@opensource.cirrus.com>
 <e6d5bdfd-6d65-43d6-b14c-b0d5e949b969@gmail.com>
Content-Language: en-US
In-Reply-To: <e6d5bdfd-6d65-43d6-b14c-b0d5e949b969@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wi5Bv0za0GaPJa4oGOIiKLhM"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-240535-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,p:email]
X-Rspamd-Queue-Id: 609A2456D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wi5Bv0za0GaPJa4oGOIiKLhM
Content-Type: multipart/mixed; boundary="------------erjYu2Nt1UmDLV0W1e7mz71H";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Takashi Iwai <tiwai@suse.com>, David Rhodes <david.rhodes@cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <29ae429c-59af-4360-ad79-7fa2f2e02212@gmail.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control
 errors
References: <20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com>
 <876d2550-751c-4299-a090-fb7f4d264bde@opensource.cirrus.com>
 <e6d5bdfd-6d65-43d6-b14c-b0d5e949b969@gmail.com>
In-Reply-To: <e6d5bdfd-6d65-43d6-b14c-b0d5e949b969@gmail.com>
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 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
Autocrypt-Gossip: addr=broonie@kernel.org; keydata=
 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

--------------erjYu2Nt1UmDLV0W1e7mz71H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/23/26 11:09, C=C3=A1ssio Gabriel Monteiro Pires wrote:
> On 4/23/26 10:32, Richard Fitzgerald wrote:
>> On 23/04/2026 2:11 pm, C=C3=A1ssio Gabriel wrote:
>>> cs35l56_hda_mixer_get() ignores regmap_read() and
>>> cs35l56_hda_mixer_put() ignores regmap_update_bits_check().
>>>
>>> This makes the ASP TX source controls report success when a regmap
>>> access fails. The write path returns no change instead of an error,
>>> and the read path continues after a failed read instead of aborting
>>> the control callback.
>>
>> Are you seeing a problem on hardware? Or is this a static analysis
>> warning?
>=20
> This was found by code inspection, then checked with a focused
> Coccinelle rule (I do not have the hardware to check it).
>=20
> Rule:
>=20
> @ignored_regmap_read@
> position p;
> expression map, reg, val;
> @@
>=20
> regmap_read@p(map, reg, val);
>=20
> @script:python depends on ignored_regmap_read@
> p << ignored_regmap_read.p;
> @@
>=20
> coccilib.report.print_report(p[0], "ignored regmap_read() return value"=
)
>=20
> @ignored_regmap_update_bits_check@
> position p;
> expression map, reg, mask, val, change;
> @@
>=20
> regmap_update_bits_check@p(map, reg, mask, val, change);
>=20
> @script:python depends on ignored_regmap_update_bits_check@
> p << ignored_regmap_update_bits_check.p;
> @@
>=20
> coccilib.report.print_report(p[0], "ignored regmap_update_bits_check() =
return value")
>=20
>=20
>=20
> Before the patch:
> $ spatch --very-quiet --cocci-file /tmp/ignored-regmap-access.cocci /tm=
p/cs35l56_hda-before.c
> /tmp/cs35l56_hda-before.c:187:1-12: ignored regmap_read() return value
> /tmp/cs35l56_hda-before.c:212:1-25: ignored regmap_update_bits_check() =
return value
>=20
> After the patch:
> $ spatch --very-quiet --cocci-file /tmp/ignored-regmap-access.cocci sou=
nd/hda/codecs/side-
> codecs/cs35l56_hda.c
>=20
> No matches.

Hello,

Sorry for bothering you guys with this minor fix.

After further analysis checking the callback contract in the current tree=
:

ALSA propagates negative errors from control callbacks:

sound/core/control.c
ret =3D kctl->get(kctl, control);
if (ret < 0)
        return ret;

sound/core/control.c
result =3D snd_ctl_put(card, kctl, control, vd->access);
if (result < 0)
        return result;

regmap_update_bits_check() also sets *change =3D false before attempting
the access and returns an error if the read/write fails:

drivers/base/regmap/regmap.c
if (change)
        *change =3D false;
=2E..
ret =3D _regmap_read(map, reg, &orig);
if (ret !=3D 0)
        return ret;

Before the patch, cs35l56_hda_mixer_get() ignored regmap_read() and
cs35l56_hda_mixer_put() ignored regmap_update_bits_check(), so a real
regmap failure was being converted into a successful ALSA callback
return. In the put path that can become return 0, i.e. "success, no
change".

The sibling posture/volume callbacks in the same file already propagate
the regmap errors, so this brings the ASP TX source controls in line
with the rest of the driver.

Looking forward to know what you think.
Thanks!

--------------erjYu2Nt1UmDLV0W1e7mz71H--

--------------Wi5Bv0za0GaPJa4oGOIiKLhM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCaep0lwUDAAAAAAAKCRDQXT8aWv/ug4oP
AQCmEMC37bdu2iKEbQXmNS5pYVdMDzMMZXdRFPlS/CqsxQD/WpVE2pV3k9TJcm0P3w0rz4eLxcKA
53F25wWzN12eugc=
=LFZa
-----END PGP SIGNATURE-----

--------------Wi5Bv0za0GaPJa4oGOIiKLhM--

