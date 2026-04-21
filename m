Return-Path: <stable+bounces-240136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH/zIThq52ke8AEAu9opvQ
	(envelope-from <stable+bounces-240136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801143A7E7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60AF9300BE1E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570223B774B;
	Tue, 21 Apr 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrn/jb2/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8536213D
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773680; cv=none; b=Su8mGXm3l7JROQlExPdaWqqZG+iTxJJCTVuvV3N8aCBhDV72VEiNRoPYSAL4AKkv7pFvGgbSen8cxixNRZiqQmAO4vfapHLwMgIVr+p1wJPR6tapc3UL035mgik/xY/8SlTbsVyrVuLMrl6x44ySOro2fbTKWWrHYwEZE7ePXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773680; c=relaxed/simple;
	bh=Bv+R7Nlw0Py7FhxUwoX/vlCZjeMnCS+6Bzvx8OBVidc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbGyqnU9FHfTBMH8itrN7XNZLaqvPkhi+nen+8IUB/3pdap9CH0rCH42k8iIQ5RBsdC9q9X1GxTjngwSSMFvI7EPc4tghIgeC+V05c3iFjOArq/ee6QDzICUzCn4s0cmKMAGXYJ1BF9aiYCYRXgAwGW7tXO2jt1Uew4N5jC1Nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrn/jb2/; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c15849aa2cso5647302eec.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773678; x=1777378478; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv+R7Nlw0Py7FhxUwoX/vlCZjeMnCS+6Bzvx8OBVidc=;
        b=Xrn/jb2/yecwN+DBDoo3lImw2LpECH2vgFfJV3znJdetRdvS9PalD2A4h2Xbja54hQ
         BidHXxq8LtTATQoes1LKdD3j7ZKs9VfnuRIsGtuxjvwwiInFHFo4n2uutfKXdNUKqfDv
         eNdPyQU9/2UK0c4S9mvY6NFMpzAJINV7Olr7D0bclobmQfX4/gqpbJsYjexleVcevsGu
         EzvddQR00sSE1UcWJ0pQbEzdmVR6mNEr984GnmTvIDEF7j8oxIwVlDEk2eejMbunUUM7
         jxPi1E60HeJPzbRG9uVZUiFqxmH7odTOtNzRV4Q5umhFy7TipWx+Cf58jLclay1lBItb
         gObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773678; x=1777378478;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv+R7Nlw0Py7FhxUwoX/vlCZjeMnCS+6Bzvx8OBVidc=;
        b=aid75Mji9kJwqrDlJztqxHHBFFeRnWBfuY806P4rQvAU/oTpaobPWTtSGH60TUbqNg
         7rDoxBf0SEumHW5HVUs67FE9TS0IhjNJ3C4gS1fyZgDD90jZi5UfRk4agRQKFMVFNhcF
         s3Fs61sBtoxyqSvZf8glmzQm2EuY+vR58Z5UxzTgZXwOIwTuXXz2l8xCfWLq+I1qwoZJ
         EZYUtzFguWWK1bQsRO0Ovsf2EJKLHxojhcuqkGxBA+eGVUBOkQbuXEhmI8i8aBZIw6wu
         PqLl6OvBzJpQ+Zq+z6bqpICpMk89FyTgjr/iI5zcW6WZsIGE0bCf0A3dzXtuq6bhz2bm
         COxw==
X-Forwarded-Encrypted: i=1; AFNElJ9rJROfckn4V/7QMvveAOU1/msu/eNE9duAowdoFkSqLdOS9NcoaEx9tO6H7j5nawGm54hOT0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WDy2RpK33SE/JeAHF8Gm8/kmwvwzEgMalpp6t1GkXKmlN/gH
	GE9TgLoS6w2LwE8tjLjBQekKzAwgZscUwzojOf2Ycz9iWV9BjKleaw7Z
X-Gm-Gg: AeBDieseogYdc66sbhFIhkhI3i/5gUd1FQau7OZkCbbQpTq5RZzB2lgmnHeSz500gVA
	hqjvddvuaD9C6aMtbBGJlmtzHkrhQU05/3PrOHr5/LH7g+Ehi3CtBOE5e1P3W1YP7CgKy+Sy2P7
	iQKCIf+PCCO1lQ1/4eg7NzNwpbjxg5BEyfIgFaBOO3YApBs/q2bkaDqNZWhFKEpOopBYlZL6ECM
	aLJpkeMTBF6ZsaTyElRkGX0+6BCWw8Vbp93WHLnSJSu17G7feeCcmh10odD4pFSfrX2Vrs4QcoY
	J2rOWz6kvh/GWBIN5XfLCdm1I3CZGTf//ymj98fLNxZ3Uk8aE7ljH19fxSdfDu+mMGeAXND7Jy1
	hzobdpHvlRd9jWjPSbWkGQfeHV+J1sgSo2mdFwErJfjr+MLTt88xsHpySy/KkHPSqlcEafygBy1
	F2H9JulPA/TpM4aATzTrVPmBjBt+KEyBejgPF1Y0P1+dfzsrOcD0asS4PjyOGodcx+yMuu54g/Z
	LhPoJlJ99ko
X-Received: by 2002:a05:7300:cd94:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-2ea4228ab6amr1691332eec.3.1776773677571;
        Tue, 21 Apr 2026 05:14:37 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm19204952eec.3.2026.04.21.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 05:14:36 -0700 (PDT)
Message-ID: <8168eb7f-2e07-4f77-9b3a-38ee25bfa9e5@gmail.com>
Date: Tue, 21 Apr 2026 09:14:31 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] usb-audio: fix mixer write failure handling
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Chris J Arges
 <chris.j.arges@canonical.com>, Detlef Urban <onkel@paraair.de>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
 <87v7dkag5r.wl-tiwai@suse.de>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <87v7dkag5r.wl-tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4wcrJbl104l9Fi56M44Fkzr0"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-240136-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8801143A7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4wcrJbl104l9Fi56M44Fkzr0
Content-Type: multipart/mixed; boundary="------------YQJlNMRd4p3DuOd5v6KIUDvX";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Chris J Arges
 <chris.j.arges@canonical.com>, Detlef Urban <onkel@paraair.de>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <8168eb7f-2e07-4f77-9b3a-38ee25bfa9e5@gmail.com>
Subject: Re: [PATCH 0/4] usb-audio: fix mixer write failure handling
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
 <87v7dkag5r.wl-tiwai@suse.de>
In-Reply-To: <87v7dkag5r.wl-tiwai@suse.de>

--------------YQJlNMRd4p3DuOd5v6KIUDvX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/21/26 05:09, Takashi Iwai wrote:
> On Sun, 19 Apr 2026 22:30:28 +0200,
> C=C3=A1ssio Gabriel wrote:
>>
>> This series fixes usb-audio mixer put() paths that currently report
>> success even when the underlying device write fails.
>>
>> The issue exists in the generic mixer core callbacks, the Scarlett
>> Gen1 enum path, and several Tascam US-16x08 put() callbacks.
>>
>> The US-16x08 EQ and compressor callbacks have an additional bug: they
>> update their software shadow state before sending the USB write, so a
>> failed transfer can leave later get() results out of sync with the
>> hardware state.
>>
>> The series is split into four patches:
>> - propagate write failures in the generic mixer core callbacks
>> - fix the Scarlett Gen1 enum callback
>> - propagate write failures in the simple US-16x08 put() callbacks
>> - commit the US-16x08 EQ and compressor shadow state only after a
>> successful write
>>
>> Successful writes are unchanged. Failed writes are now reported
>> correctly, and the US-16x08 shadow state remains coherent with the
>> hardware after write errors.
>>
>> Signed-off-by: C=C3=A1ssio Gabriel <cassiogabrielcontato@gmail.com>
>=20
> As this might influence on the actual device behavior significantly,
> and it's in a merge window, I postpone the series for 7.2.

Thanks for the feedback.
=20
> thanks,
>=20
> Takashi

--=20
Thanks,
C=C3=A1ssio


--------------YQJlNMRd4p3DuOd5v6KIUDvX--

--------------4wcrJbl104l9Fi56M44Fkzr0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCaedqJwUDAAAAAAAKCRDQXT8aWv/ug/qM
AQCavMbleHfa2Thh7teKJhptqTC7AULyPLDMHDF8+3CS4QEAyNEGvZdT930ozr8ywVtukBNoxadT
itI46VedOLyKPgw=
=C2ec
-----END PGP SIGNATURE-----

--------------4wcrJbl104l9Fi56M44Fkzr0--

