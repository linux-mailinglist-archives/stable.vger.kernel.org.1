Return-Path: <stable+bounces-214616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEapMLejhWmSEQQAu9opvQ
	(envelope-from <stable+bounces-214616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31302FB5DD
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FE873030997
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74B347BC7;
	Fri,  6 Feb 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vNvca40M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326B30ACEE
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365866; cv=none; b=lQbN2h1IgLubcwueZgKcLMqzzMtavM8tksDfdgJdYM+LVNVirwpl9mwTcLPzHI5si8a8ekIrCHxIX5IwVreqQeA9o6HUUKKLaKa9/96Rr6wyHN6ao2zzK9JL3id1fMVfuUTtlGh+lJBirkwaqBGI5PVFeVbl+V1qTEJCf3FJIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365866; c=relaxed/simple;
	bh=Kjfri+drppMwAz5RgjQPZflMK34bPLpJOOUZ8SpxV7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nycz7SG9TssX4/kmLz8NKrfN3pwZDhagt7DKOYC6aFfLGhQzebIGPzjfHngzIXwIJd2+Qjf7GJaP7cXFAp2PdeiNGH7aypAXk8i2FMejT+bOGFZrQwyqHE2vKzNmfptedunuwFYBTWzQxCfwK1Qu8LBHI6TJ04ExNaMmkAYBmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vNvca40M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso4514075e9.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 00:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770365864; x=1770970664; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kjfri+drppMwAz5RgjQPZflMK34bPLpJOOUZ8SpxV7s=;
        b=vNvca40MaDjPNU/UwdOEVvnMgdgpT9JCSlMww1vsDODknPYBvYT7TzFlGy6GcMVJlW
         FhRB3ECky8dsHxYv+cyFQLNnSEiTGMk7slkjTNYoYoCzUFzth8yzkqiGn6fXCSHykIb4
         rlVaPaMIJL23OpvjVNGWDkJRqf9LU0mX1QIM4sz+2Bbt/MjIybH4nd8KZwvg/2RZ1Vr+
         YfYrcOCsQoF6yUbsTAp+H5p/s21/9kUv0JE6Pl3OL6R6At1BBhZPqsFP554tLx3gtu/N
         YWKYyCyKCRhUU1s0HGA55e0mbfEi3PvJxs8be5BBslEGv1rz35zjqhz0ybgzVBAWgM+l
         HMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365864; x=1770970664;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjfri+drppMwAz5RgjQPZflMK34bPLpJOOUZ8SpxV7s=;
        b=TbNdqdtFiFoyEZUOzoChK4na5/sDPZBU7cJo9GJKXoDXFaSY6iaw0Lm/LyBdt7kLjJ
         b2OA6p6CdG4GpawyZiKa3WhBBCa8afEqFzTAjiB4cS99zuvuy9k3dJmjSh5JYvOMoOX5
         FP7N87kYkKyB9moYfNK/BB0zlRy2Mpr94D2PPL0i2tzQ5b9Roe8GX40DbAG4P42+qkXo
         NcM6gPRfFOw3FZZQWYxPwLVkze+vAnAIMtLO7NrGsq/f88gKpiKobpsE5nciu22NiE5L
         RsKoOPXEZbZXrvSTbWWpmWVysYgdC8QD2bPa1XETbXRliNCots6UmVdtiNLdvjZXmesG
         zPfA==
X-Forwarded-Encrypted: i=1; AJvYcCXHQNbhhUDZ2LPbzunQJeiR+JglZ37IrXJPxvYkQeWxli4S3QweMNKokSGVJANH3XQTROZ0I1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cQgLNZobqECnMCMlKAw3he/Wumj1mRu7Abg6fI4tLsQc3i1u
	n8JrCrBnNxSBrB38knrIHTeuF6ZHchoNAAF66OPVSKQSikqahbl/wWair9NP6AotQsD5sYO73vY
	nMzVj33Y=
X-Gm-Gg: AZuq6aKn8Tl36/0nPiFaQXhzY7My2649kOiYy9PSOJefOrDj3KiEgeaNbDJGr2JJQgX
	SxBs65xS+VKT7BO3tZPiv2kSQJXEAG25H+lGaUMEvyPiWjktA1YQFKwcEVXVvOrr8iVknxwvALy
	yBfhB/0eG2hIMLfjr85LOMvLrOjInn/wuhPNfAktzLfz4iRBbEE7MvHXBaNcnS9kJfjUdAmkDlb
	2lIdg7VF6DpC1gjk4Yvt9FOPNyvV0qL6hk70l4g1Yswvb8DyDKX1FZ9KHTOQv93bwNY1E0dJqCx
	23kD3EiU3Zv5Zdm5NogL3INi0XHkTKSAv3x/6klMNLZkZPmz21AA2GJiU4zVgGviXg3bdfV5TjR
	LvVG2gRVdaJ3/Dv95M6EnPLFllmO/1+o7U8fRB9wV+gZdTAg9hDj01ZDhOqvHAlqJyKzor0lEDs
	1o/roh1vyEagniX5LCgv4n7OGCQiQKxXy4CCfPeXFu+HNcuY6KWtfbRAUFCw==
X-Received: by 2002:a05:600c:1390:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483201dc4bamr28137285e9.3.1770365864192;
        Fri, 06 Feb 2026 00:17:44 -0800 (PST)
Received: from [10.203.83.147] (mob-176-247-2-76.net.vodafone.it. [176.247.2.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209eeef0sm11981065e9.20.2026.02.06.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:17:43 -0800 (PST)
Message-ID: <b5f8757ebd48c3a11591a68e8b97017f7b9d7e31.camel@baylibre.com>
Subject: Re: [PATCH 5.10 070/161] iio: imu: st_lsm6dsx: fix iio_chan_spec
 for sensors without event detection
From: Francesco Lavra <flavra@baylibre.com>
To: Ben Hutchings <ben@decadent.org.uk>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Fri, 06 Feb 2026 09:17:38 +0100
In-Reply-To: <eb892614c9cd28aa03922567f8a6d75ed2f594bc.camel@decadent.org.uk>
References: <20260204143851.755002596@linuxfoundation.org>
	 <20260204143854.274769162@linuxfoundation.org>
	 <eb892614c9cd28aa03922567f8a6d75ed2f594bc.camel@decadent.org.uk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NFvMVEynZQs+voLGOa2j"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.66 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[flavra@baylibre.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 31302FB5DD
X-Rspamd-Action: no action


--=-NFvMVEynZQs+voLGOa2j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTAyLTA1IGF0IDIzOjQ0ICswMTAwLCBCZW4gSHV0Y2hpbmdzIHdyb3RlOgo+
IE9uIFdlZCwgMjAyNi0wMi0wNCBhdCAxNTozOCArMDEwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdy
b3RlOgo+ID4gNS4xMC1zdGFibGUgcmV2aWV3IHBhdGNoLsKgIElmIGFueW9uZSBoYXMgYW55IG9i
amVjdGlvbnMsIHBsZWFzZSBsZXQgbWUKPiA+IGtub3cuCj4gPiAKPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLQo+ID4gCj4gPiBGcm9tOiBGcmFuY2VzY28gTGF2cmEgPGZsYXZyYUBiYXlsaWJyZS5jb20+
Cj4gPiAKPiA+IGNvbW1pdCBjMzRlMmUyZDY3YjNiYjhkNWE2ZDA5YjBkNmRhYzg0NWNkZDEzZmIz
IHVwc3RyZWFtLgo+ID4gCj4gPiBUaGUgc3RfbHNtNmRzeF9hY2NfY2hhbm5lbHMgYXJyYXkgb2Yg
c3RydWN0IGlpb19jaGFuX3NwZWMgaGFzIGEgbm9uLQo+ID4gTlVMTAo+ID4gZXZlbnRfc3BlYyBm
aWVsZCwgaW5kaWNhdGluZyBzdXBwb3J0IGZvciBJSU8gZXZlbnRzLiBIb3dldmVyLCBldmVudAo+
ID4gZGV0ZWN0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgZm9yIGFsbCBzZW5zb3JzLCBhbmQgaWYgdXNl
cnNwYWNlIHRyaWVzIHRvCj4gPiBjb25maWd1cmUgYWNjZWxlcm9tZXRlciB3YWtldXAgZXZlbnRz
IG9uIGEgc2Vuc29yIGRldmljZSB0aGF0IGRvZXMgbm90Cj4gPiBzdXBwb3J0IHRoZW0gKGUuZy4g
TFNNNkRTMCksIHN0X2xzbTZkc3hfd3JpdGVfZXZlbnQoKSBkZXJlZmVyZW5jZXMgYQo+ID4gTlVM
TAo+ID4gcG9pbnRlciB3aGVuIHRyeWluZyB0byB3cml0ZSB0byB0aGUgd2FrZXVwIHJlZ2lzdGVy
Lgo+ID4gRGVmaW5lIGFuIGFkZGl0aW9uYWwgc3RydWN0IGlpb19jaGFuX3NwZWMgYXJyYXkgd2hv
c2UgbWVtYmVycyBoYXZlIGEKPiA+IE5VTEwKPiA+IGV2ZW50X3NwZWMgZmllbGQsIGFuZCB1c2Ug
dGhpcyBhcnJheSBpbnN0ZWFkIG9mIHN0X2xzbTZkc3hfYWNjX2NoYW5uZWxzCj4gPiBmb3IKPiA+
IHNlbnNvcnMgd2l0aG91dCBldmVudCBkZXRlY3Rpb24gY2FwYWJpbGl0eS4KPiBbLi4uXQo+ID4g
QEAgLTExNzAsOCArMTE3Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3RfbHNtNmRzeF9zZXR0
aW5ncwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9LAo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuY2hhbm5lbHMgPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbU1RfTFNNNkRTWF9JRF9BQ0NdID0gewo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmNoYW4gPSBzdF9sc202ZHN4X2FjY19jaGFubmVscywKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5sZW4g
PQo+ID4gQVJSQVlfU0laRShzdF9sc202ZHN4X2FjY19jaGFubmVscyksCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuY2hh
biA9IHN0X2xzbTZkczBfYWNjX2NoYW5uZWxzLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmxlbiA9Cj4gPiBBUlJBWV9T
SVpFKHN0X2xzbTZkczBfYWNjX2NoYW5uZWxzKSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbU1RfTFNNNkRTWF9JRF9HWVJPXSA9IHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuY2hhbiA9IHN0X2xzbTZkc3hfZ3lyb19jaGFubmVscywKPiAKPiBJbiB0aGUgdXBzdHJlYW0g
Y29tbWl0IHRoZSAzcmQgaHVuayBjaGFuZ2VkIHRoZSBlbnRyeSBmb3IgaGFyZHdhcmUgSURzCj4g
U1RfTFNNNkRTTzE2SVNfSUQgYW5kIFNUX0lTTTMzMElTX0lELgo+IAo+IFRoYXQgZW50cnkgd2Fz
IGFkZGVkIGJ5IGNvbW1pdCBmMzVlMWVlOWNiNWQgImlpbzogaW11OiBzdF9sc202ZHN4OiBhZGQK
PiBzdXBwb3J0IHRvIExTTTZEU08xNklTIiBpbiA2LjIuwqAgU28gaW4gdGhpcyBiYWNrcG9ydCB0
aGUgM3JkIGh1bmsgaXMKPiBjaGFuZ2luZyBjb25maWd1cmF0aW9uIGZvciBvdGhlciBkZXZpY2Vz
Lgo+IAo+IEkgdGhpbmsgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGZvciB0aGUgNS4xMC02LjEgYnJh
bmNoZXMgaXMgdG8gb25seSBhcHBseQo+IHRoZSBmaXJzdCAyIGh1bmtzLgoKR29vZCBjYXRjaC4g
SW4gdGhlIDUuMTAgYnJhbmNoLCB0aGUgdGhpcmQgaHVuayBpcyBjaGFuZ2luZyBjb25maWd1cmF0
aW9uCmZvciBTVF9MU002RFNSX0lELCBTVF9JU00zMzBESENYX0lELCBhbmQgU1RfTFNNNkRTUlhf
SUQsIG5vbmUgb2Ygd2hpY2gKc2hvdWxkIGhhdmUgdGhlaXIgY29uZmlndXJhdGlvbiBjaGFuZ2Vk
OyBzbyBvbmx5IHRoZSBmaXJzdCB0d28gaHVua3Mgc2hvdWxkCmJlIGFwcGxpZWQuCg==


--=-NFvMVEynZQs+voLGOa2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmmFo6IACgkQ7fE7c86U
Nl9bTwv+JNn6JenrkIjmvCsGXya7H0lGVBCyQqMH1J0EPqCS85zVDkTDcBJ8O38o
Em2QRrZpxAAHCeSJP9KrQ3Y/xXTjAw7PXuLaGE++I2UzpPOZEMHnkWrDDcVKrlwD
cd/pDtLiisAovwZtAqc6sPEoA1Fi4x9OqLcxOEb44WnqCX12oe4m2PGfpHB0iQkj
n+GCJhuC8YJcPsrrNzrffeeUZfdyB5/uvU9GCYGvvMcqQSN5wg/PbzVDONo0s4an
nHhh5Hs1q5cJXFEx3srTBJIdXhMPmZ2y6neHCskKsq+v9NVMxdjyNF/1hyxW9eAf
T8lWH4h8JFKAtxFR/zTzL7Da4CvyeexBo9+0BdLJc/ElKhIK4DDfgLkLtk7nMEZm
A8DBo1Qx7Ks/OguVfK0ENmZT6njWH1Z3axz+5mFdu7AQhSs8NXfEBIIBEdEaTVst
9ItGjofhMxVFiEnbQuNa88XuZseQWehCAim8ppotfQJJksq1S3JdS9CbsdT8Wfdx
qJ8TsHmq
=iBpQ
-----END PGP SIGNATURE-----

--=-NFvMVEynZQs+voLGOa2j--

