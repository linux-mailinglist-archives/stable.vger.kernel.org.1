Return-Path: <stable+bounces-223038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDCiCG8bqGmYoAAAu9opvQ
	(envelope-from <stable+bounces-223038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:45:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8497B1FF373
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EFEB31AE98E
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1F372ED3;
	Wed,  4 Mar 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDDCweWt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672036827B
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624417; cv=none; b=sEOBWi120k1InvummB2PUpBqOvntlkGt1KTGwav/bN+Pw+s29bXZYBCcqbWt71ADkeDGnw1GqY31umDYO5NeOcDOwkQxsHzJ8/PSIL4uu1f6hdx+rwyVzClHlXRjgywHTy2sgq20IjyLPhvboFmAhwvSG4lVe6A23obKgUyRVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624417; c=relaxed/simple;
	bh=hhJHUnyXzwi/Kx5IBoqabTPd6BRuf0miytj3h2lUkH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R8LPY1+lU8p6RV/nWNLkJEi4bHFDwAGeUTeZRNz5rGEdeqQjwfa1ZUOVTwJob8ATt3ZJ7QCPPSFjQdbYkVBebv8uixBO6Lj6NOwH1ATA/bEiwXYPfhreK9XwZtYxOYVOywU0LRO1S1QostD456qlO37ubXxchH6Ma7U/UTyu4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDDCweWt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so79048465e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624414; x=1773229214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbtOTZEyDRKjxabRC490eCkoRx0H/oDiCdXHd+Ic+XI=;
        b=KDDCweWtOzYn4I/UH+CnwrDkMnXZazShDwi08VF9ggh15bE7cTjWoFeFIOotFgPSys
         iGigzH8R+EmSMzB2LZJ0Htgk3yGr4BNCAE1xdwkfVfBBVAfzh8pogKL/8JyYdEQ25vsX
         QtN00GWsaOwfU4Z8z1yfbE8Ab9XWIP1x9V+xrniWhDDznok2gKneHAv7Z07NX2cDmHHE
         p/Mc7giKtIqbtm30dUfkhRQCPOKiVDl9M1Q2Br9gt0xAk1uFbOtSe0PChAblVJJzJ++e
         tXTLbuQdav7rgX3dVTFWc9PC5UOCfgv2WsgZKco6ZDwi8Yei4k8XXW8mW3/vCPWLfL+N
         vaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624414; x=1773229214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbtOTZEyDRKjxabRC490eCkoRx0H/oDiCdXHd+Ic+XI=;
        b=uZKBHzqt6v8luRQ0MJ+Iiwhs6qDHkSespqHMOFLVuY6oqUDRNxvdcZE5W/0sXM9pNR
         lNgYFFPsqyvY04ZPbOag26H1Y4oK+2dDkn6KsNPhZx8ktXKDxRIyGC2nHP8JFHzbxjdC
         rxPSeKpuUxZeOkj4Q6yDmLXMCHJkLmKU3WWGT/6F2lF7/mK5EeUadEdu0c78Rbu5qhZs
         ooxpesXjTdBncs+NVfFM2Jeog4AMjdhUKZbTTIUqtvdZc8JnUkIIzR6L6T5TBo4ipjex
         zdU2wY/wXK/kG38tuyjOwOOm7GmhTjUPtfdiDUenvnEg+zZfkvN7Jx9qcU/HbUkVuNFQ
         YmCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjofkTpIjLc0r+Yursg+yiwCHb1maCjF11aMrx5NJdur8q1dVROW+VAPklRWXhMFx4JTvG4nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvT/+n8neYUmn1zw9nizJuC2NxZFrwoZ+o0BYd2vxu8Ift0VVP
	YfFkrQkicNiGnDRo5W0GoQX5arJByW34uSW/DuGs6D/bhGp7gXIkPLC3
X-Gm-Gg: ATEYQzxqGXdb/OUK9bwkIAtN5kJjCBQygqT7vg9ExhS3XtoaroKXcBuFSh3EjXZq03c
	AtqJFzKdBeiV9Hvb+wiiFat7X7DHx9tYrsy2hGeFXS76Fn04NnfiBpAUsckNfM6l4ooPF/jqf0y
	ViYOK70f2VJhdDpcNP7ZzaRWoOmsyg3kak4+w739pFdMo7BdE9wl1TR5K4dLz5JrMDRzZy6FTcb
	KTIYc9nOLRHwc/OJY0A8Ke8LLnOqIHTnLPQvWy3NfeZ9l1JENaJfeTeX60BXkTBKYATUbEYBFH/
	mGHrpj0GbNRZZCLWYCz5ayL5Wl3yYl+BIBZgaK4/i8E0Uyf3gpZ5fT1/wjoaReC0qlZgTRIhLoZ
	Vat3S+r8BtYZureUODuOnbDglqLMAphJ2/r7PLcQIOi1+XYWjFae2yk9zd8J11uAYq+ZZ2LiQuq
	B42E2Wiy+TiWOOVfUwxqOswwsN8smorIk=
X-Received: by 2002:a05:600c:a51:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-48519889928mr26061705e9.25.1772624414000;
        Wed, 04 Mar 2026 03:40:14 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm47072305e9.6.2026.03.04.03.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:40:13 -0800 (PST)
Message-ID: <7888782857fca26d6562c5cf1807fc7488c9dde8.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>, 
	jic23@kernel.org
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	michal.simek@amd.com, victor.jonsson@guidelinegeo.com,
 linux-iio@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Wed, 04 Mar 2026 11:40:58 +0000
In-Reply-To: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8497B1FF373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223038-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,guidelinegeo.com:email,analog.com:email]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 10:07 +0100, Christofer Jonason wrote:
> xadc_postdisable() unconditionally sets the sequencer to continuous
> mode. For dual external multiplexer configurations this is incorrect:
> simultaneous sampling mode is required so that ADC-A samples through
> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> VAUX[8-15] channels return incorrect data.
>=20
> Since postdisable is also called from xadc_probe() to set the initial
> idle state, the wrong sequencer mode is active from the moment the
> driver loads.
>=20
> The preenable path already uses xadc_get_seq_mode() which returns
> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
>=20
> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>
> ---

From a code standpoint:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> =C2=A0 - Align continuation line to opening parenthesis (Andy)
> =C2=A0drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-=
xadc-core.c
> index e257c1b94..3980dfacb 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev=
)
> =C2=A0{
> =C2=A0	struct xadc *xadc =3D iio_priv(indio_dev);
> =C2=A0	unsigned long scan_mask;
> +	int seq_mode;
> =C2=A0	int ret;
> =C2=A0	int i;
> =C2=A0
> @@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_de=
v)
> =C2=A0	for (i =3D 0; i < indio_dev->num_channels; i++)
> =C2=A0		scan_mask |=3D BIT(indio_dev->channels[i].scan_index);
> =C2=A0
> +	/*
> +	 * Use the correct sequencer mode for the idle state: simultaneous
> +	 * mode for dual external mux configurations, continuous otherwise.
> +	 */
> +	seq_mode =3D xadc_get_seq_mode(xadc, scan_mask);
> +
> =C2=A0	/* Enable all channels and calibration */
> =C2=A0	ret =3D xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xff=
ff);
> =C2=A0	if (ret)
> @@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_d=
ev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	ret =3D xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_M=
ASK,
> -		XADC_CONF1_SEQ_CONTINUOUS);
> +				=C2=A0 seq_mode);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
> +	return xadc_power_adc_b(xadc, seq_mode);
> =C2=A0}
> =C2=A0
> =C2=A0static int xadc_preenable(struct iio_dev *indio_dev)

