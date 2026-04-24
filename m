Return-Path: <stable+bounces-240646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBBnEbBe62lGLwAAu9opvQ
	(envelope-from <stable+bounces-240646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5845E42E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BC8300F9CD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C391363C75;
	Fri, 24 Apr 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqtOIbWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F853921CD
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032848; cv=none; b=l0TND4F2jLshKBwx9xriWYHUMoLUt/JGxJKfsdG060YYanUmgugBtIX3tNWV1kQz61sXqd6KO20SqwO19uWytupQK6hjI9y6nqAUpqlVaPxKmpfjXqKuZaq0fVC92pPQexZYL17FADi8XMBpqEhYSLXEvPhn60rd2CIP+KIV5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032848; c=relaxed/simple;
	bh=8/QJJryqSynahyRQJJbCZN0D78VrKq8FeMiVcDhoi+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJmLbMXIyCwr8xuCuoIhh9DAJ7OtFZe0talBsu571iO5fGolgDfS/M5Qh89tPqKX5lQybPTP7/n1VRdEpviylEG3FKzqpGVDRKmIPcst0k13a8jDmHvCI516N+IQ6bWBHjtGq5WJrVvyt7va0Lxjx3uS1qgLZOqtjVdEn9pFnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqtOIbWI; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dbd0f8063so351034c88.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777032847; x=1777637647; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfoLqhKpXj85wR6vWN9s9RLklGMx26Zw0qrL+AcJXdY=;
        b=WqtOIbWIR6nvm2m+csWXFF7IhWMdV2rnij0CU4w03Xlnyfh6PM3a5N1NPV/kYbKDHO
         f08E+GjecpJ19+R7GeXP1KDfcsqZgo9hRFUz8Up0oxLV38fvmkcCQGCOk1eemJku4Z50
         NCcR611QjCOcd4Gt4QadIAPzRhqJ8LoKKKNyUt7HMqpc5Fajtc6eG0ejfuWfWcEnkc4x
         Mqxw8fgD0lw/jpo9MtQgS17dbpEYKH7GyZOFHZx1gceM+Ep3NP9qGDzQZJmMQihgyExL
         BQhEdiYqyAePb/l82X85s/3ZD61BMRreZMknvaHbCU+jUdAK7z21FE/0q4+Tr/1NOwa/
         qNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777032847; x=1777637647;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfoLqhKpXj85wR6vWN9s9RLklGMx26Zw0qrL+AcJXdY=;
        b=gu7Phh7tVgCeVECINGEdJmiEqHrVb3lov2jo79nm57nZvAsQEeiTCKh2h14DTvRqyM
         9HmiDAb1RqHVE8dF4nKmi8e7msXzn4JIlc9+BLO3mXgTctGzVT4S7lh8Qf01+XUqydVy
         fLRmwswoe3SfnWrIM436jpKrsfROWP324FwNJYWlh54+XRNbFMJXGMJ6FojxudXUCP3a
         k1/tVXAMjfaBQU0hQLCiR0zJnitW4reHV2/amKRB7ogNPNn6ZYznXim74vFqV+rcq8Xa
         Da0J5xEnuEdsQ/OxicPbwHHj7pYj/tIBNmwHODwwR1t09iTgQsPe9GkciuEHk5C3byUt
         jV5g==
X-Forwarded-Encrypted: i=1; AFNElJ/XS72sF1kaBIlSHv9Se/RSwe4oDH5+dH7rMeq0+3hTw1tnLjbaS+isQ8eznmNaZujUhjZE5fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySsoVVd2ZsJNojcVFHe/H53LeHQcXt9VKp7NdzmwrhfMhX2T9T
	qdko9n+yhslk3QxfnUmcIOcjuZZMvh3pHPQfnekt6qMRSm51J/SEZQL7
X-Gm-Gg: AeBDiettPv35j1yOly1fMkwYhaNMCFgeIy9XFgVC0VMY0doyB+Lk6Og2qt+D9PTP563
	FZKfvHpNjh/oR3qhiBQgc0IJuXLLY2VtERBprrQwSINrogH1WTmxjtjHZMRamKgUAmPwXgRr8Ak
	y8g4K3RbwsAVi827kb65xK9gbkAxrhAavq9J9swbf2DFCBlnwu+LGb0SYEK+YNIgmhTbnku93gf
	fEqlZCtmDUGwMrntQiceCoOpulsgi3btrIZ70gbAjzcJYtfGZdhw/yy6O1+g1WBWalDLxtZnrmt
	/5rzM8DKbA0JuX0nRg0p1o1DFYV/51k3wWKjod6lM+Z4+wyCUtLT64GV8TFzAukx9yySmCulS90
	QJ8852kzB/y5rEDpcwf50qfPff0M3PLJhZIhxED54d+x3Ke9SCKOTWyW65fd8wABfbStAYYnnwc
	6RnXbGuPwNOhvu0gbE5sOkUsR5re754z0XzXvOhH93JFuit1ljlQjVCYZbrwkVSOvn2/Ofi8xts
	kHfRAa4WJ3f+DnKtIJJeWo=
X-Received: by 2002:a05:7022:388f:b0:12c:f77:f0a0 with SMTP id a92af1059eb24-12c73f73440mr19370421c88.13.1777032846310;
        Fri, 24 Apr 2026 05:14:06 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c8e837beasm24410043c88.11.2026.04.24.05.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 05:14:05 -0700 (PDT)
Message-ID: <87797cae-2716-48e2-b0ba-47cdfb34645f@gmail.com>
Date: Fri, 24 Apr 2026 09:14:00 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: aloop: Fix peer runtime UAF during format-change
 stop
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com>
 <87se8k1ugc.wl-tiwai@suse.de>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <87se8k1ugc.wl-tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bzN3VwiHVvH0SN3pB5H2yyYv"
X-Rspamd-Queue-Id: BFE5845E42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240646-lists,stable=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fa95c41eafbc9d2ff6f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bzN3VwiHVvH0SN3pB5H2yyYv
Content-Type: multipart/mixed; boundary="------------10n2GPumHEzMlOIESxT5WexW";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com, stable@vger.kernel.org
Message-ID: <87797cae-2716-48e2-b0ba-47cdfb34645f@gmail.com>
Subject: Re: [PATCH] ALSA: aloop: Fix peer runtime UAF during format-change
 stop
References: <20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com>
 <87se8k1ugc.wl-tiwai@suse.de>
In-Reply-To: <87se8k1ugc.wl-tiwai@suse.de>
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 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

--------------10n2GPumHEzMlOIESxT5WexW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/24/26 08:14, Takashi Iwai wrote:=20
> Do we need to complicate this handling?  IOW, can it be simply be like
> below?
>=20
> 	if (stop_capture) {
> 		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
> 		if (atomic_dec_and_test(&cable->stop_count))
> 			wake_up(&cable->stop_wait);
> 	}

That makes sense.

The lifetime fix only needs the stop_count/stop_wait
serialization, so I can simplify the stop path as you suggested.

I'll respin and send a v2 patch.=20

--=20
Thanks,
C=C3=A1ssio


--------------10n2GPumHEzMlOIESxT5WexW--

--------------bzN3VwiHVvH0SN3pB5H2yyYv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCaeteiAUDAAAAAAAKCRDQXT8aWv/ug2iT
AP0X/ZNOWh5f2N2Fmo23q2Y88xT52Ml+kNwydxlmScVMoAEA/W23y48fC9MVXJEcBMn/i3U5Lkc1
4wiaC5RJSFk+0AM=
=+C0T
-----END PGP SIGNATURE-----

--------------bzN3VwiHVvH0SN3pB5H2yyYv--

