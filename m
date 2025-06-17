Return-Path: <stable+bounces-152764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 651FAADC7F3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336F37A1F97
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA312BEC35;
	Tue, 17 Jun 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrUoAQzM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6652BEFF3
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155655; cv=none; b=im8g+TYDjPmCmdE6te5bwLtp7DpIAvAmaq4J5aVaoXObY00eJ0ezDOTYBiPI/eJpKD12t4C6LMR5HxWQSpJ8kg8ok48/n1odgTJ451J3fL2/pspRHpkZvfbhhCBEmyd/uI+TLw7epjp2gcBfoq0CCEG447YbYkWkWov4Wtd0zOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155655; c=relaxed/simple;
	bh=l7pANxE6LlWJZaBuB+f/YFijKcmcnXNlJid6eycwsdw=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=rk+/Mu62HUjUljYbLFDzV2y0WejUtZGIlTppfzOfpVw2W5HFfWCjTaGOdzDrAbjqzwXLm9RCV0vaSmWmR+3/0Lf0kauPNofj2jg6vT3oDAFHpn10z/K33f2Fo3nzoKmwA+71vAASqz1tzmAYOUSyG+YOM2LrQpK6QrpBBEtvPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrUoAQzM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so860579066b.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750155651; x=1750760451; darn=vger.kernel.org;
        h=to:autocrypt:subject:from:cc:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7pANxE6LlWJZaBuB+f/YFijKcmcnXNlJid6eycwsdw=;
        b=YrUoAQzMANQ4U1UGCJHnPCnd3eMCeLkjAsaf3bsx+43Wb5/DgbMLN7oLW5sO33n1Cb
         w2cE+8pf2NgtHTyMMWJdj8gdCXKsxWdi0fg3iHCbZxldXEt4vsALECGAtmPsK2W5sxHP
         IMDsd59MiyAX7M/gGxPIfIrDltwaU0zej2copXleVWS408xFme9DWzFxzcs2LeNdfK5d
         IhofMs/hO71bgwUTADVu8Z73eS597q7d++4GDPkEi0eX1Vq6KNRY3eRsBnjKOxSffK82
         Kv8H2xGX3KItf8Y7gcGoVb5Pdr0Th+UOHbai5XciFLhuj0FYQPTnI43bVw7FGxnq3lEs
         Welw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750155651; x=1750760451;
        h=to:autocrypt:subject:from:cc:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7pANxE6LlWJZaBuB+f/YFijKcmcnXNlJid6eycwsdw=;
        b=bgpL2T8G6tnvaIe3KrE3mp+v+VE/8Y5LRSxhUPjpFp30c0Zxfl9Nrx80SaaXyi3Sj7
         2EqCE0ABKlpk1hzMFfBySBI6ml01EID0Fus7i/NS/qgBDS0YS8qF23W7YnQ1hQcooFn1
         sTVXp4MuY2Da5XHBuRSF3bf2RwoPZuedmgBIvrf7mdLcgUIC9Yzr2vz3l+v0s7fjj82o
         EpmboZuPxIgKJUbn3hqJVg5BniAgpEhe8lqythsal+trq7+u7tly+KEtFW0jNI+hG76m
         RJbZo20eoxhhhXPr5HGjvo3IVOM7AswOqvo0/HgpGpx97cZXZYkjuYJkPdnLaN5yLr9V
         Kvew==
X-Gm-Message-State: AOJu0Yyz0Q/fZE4Yuz0HJ1dpmnInwH60uhb9WcM//xvwaeFFtRgvzsDA
	nRalNsVyBme9w8cBnoHVv8l2DWBIgknrfCSGg1stXubBFhhno5w3sNuvnRTbGrqa
X-Gm-Gg: ASbGncvv4VnPUVihm7OBpAYZa6I9AGGJnjD7IIz0a38++0uogeepVt9ElkzzquVGdD8
	PD6q15gvyGjGfkKdT0zP1FD0RWLabiNNdNWfJScXqv4SAuEfwqDC6aAoQpaJG9tNwEG13/NFpoG
	+W+Q7BAF241T3ooYPEV4ctszIyir+sXG5/6O15sPLfUfaNxnaIoByxuei+c2x1BCR3Mxxznb7RO
	SgAGQvyGaMazDOXnkUTI64kpkEhjlby8T2ys8XGtVgEjNdMuQgBkWOPtW1llxORRVQqkjqy+r25
	RgsutWTSdEzzS7ryV3Ouh9F2+W+6Az61VRxwTNUiurlGM2ffaPRM9uwtu+NBrfeBPK5MyyIsEyO
	bH65jPGxVrdKsFLTjju2elvgWpmPu/PPq7wGBZx3GL+3P
X-Google-Smtp-Source: AGHT+IF5Div275DdVcYXw4eL4u8BbQ2uaKPyNT/RQD6hY71nr028vCI7aTDPq7CiVCKtgtNgWIv7mg==
X-Received: by 2002:a17:907:d78a:b0:adb:3509:b459 with SMTP id a640c23a62f3a-adfad329678mr1393821066b.19.1750155650517;
        Tue, 17 Jun 2025 03:20:50 -0700 (PDT)
Received: from [192.168.75.93] (217-122-252-220.cable.dynamic.v4.ziggo.nl. [217.122.252.220])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-adec8929371sm844397166b.117.2025.06.17.03.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 03:20:49 -0700 (PDT)
Message-ID: <8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com>
Date: Tue, 17 Jun 2025 12:20:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl-NL, en-US
Cc: regressions@lists.linux.dev, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>, Jani Nikula
 <jani.nikula@intel.com>, Khaled Almahallawy <khaled.almahallawy@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
From: Vas Novikov <vasya.novikov@gmail.com>
Subject: [REGRESSION][BISECTED] intel iGPU with HDMI PLL stopped working at
 1080p@120Hz 1efd5384
Autocrypt: addr=vasya.novikov@gmail.com; keydata=
 xjMEYrX2ChYJKwYBBAHaRw8BAQdAf/bzdTDerOW5j+qrayMzPOCKthCx8KYKZo20cty68aPN
 KFZhc2lsaSBOb3Zpa292IDx2YXN5YS5ub3Zpa292QGdtYWlsLmNvbT7CjwQTFggANxYhBLKE
 QxE9sGxECbI4ubmfrsbg1d9tBQJitfYKBQkJZgGAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQ
 uZ+uxuDV321klwEAm5+HyBecp+ofMZ6Ors+OvrETLFQU2B9wCd/d/i2NjJABAIssTvgdxlqF
 I6GjehRMPURi6W1uFMPzzp9gM1yeYXEGzjgEYrX2ChIKKwYBBAGXVQEFAQEHQODm5qV0UQrP
 hcJkaZVbhtVmb90gN6rIuN0Q/xTmhqJ4AwEIB8J+BBgWCAAmFiEEsoRDET2wbEQJsji5uZ+u
 xuDV320FAmK19goFCQlmAYACGwwACgkQuZ+uxuDV322trQEA1Yj4GvOlEPfyuhMfX8P0Ah/8
 QXCqgdMQH7PaNgIFFokA/1DgWcc1XGFNRHpOGrJNnF4Ese1hWjYoqo2iBlURPQwP
To: stable@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dtb1s0ai873eTd9PpSOnx5UG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dtb1s0ai873eTd9PpSOnx5UG
Content-Type: multipart/mixed; boundary="------------Uc0vBnG4YG2ZGkz04pGupL9t";
 protected-headers="v1"
From: Vas Novikov <vasya.novikov@gmail.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>, Jani Nikula
 <jani.nikula@intel.com>, Khaled Almahallawy <khaled.almahallawy@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Message-ID: <8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com>
Subject: [REGRESSION][BISECTED] intel iGPU with HDMI PLL stopped working at
 1080p@120Hz 1efd5384

--------------Uc0vBnG4YG2ZGkz04pGupL9t
Content-Type: multipart/mixed; boundary="------------RS0LcFpFyMC1IIVh4SODTdRL"

--------------RS0LcFpFyMC1IIVh4SODTdRL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgZGVhciBMS01MIGFuZCBjb21tdW5pdHksIHRoaXMgaXMgbXkgZmlyc3QgcG9zdCBoZXJl
LCBzbyBJJ2QgDQphcHByZWNpYXRlIGFueSBndWlkYW5jZSBvciByZWRpcmVjdGlvbiBpZiBp
dCdzIGR1ZS4NCg0KU3RhcnRpbmcgZnJvbSBjb21taXQgDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD0xZWZkNTM4NDI3N2ViNzFmY2UyMDkyMjU3OTA2MWNkM2FjZGIwN2NmLA0KSERNSSBo
YW5kbGluZyBmb3IgY2VydGFpbiByZWZyZXNoIHJhdGVzIG9uIG15IGludGVsIGlHUFUgaXMg
YnJva2VuLg0KDQpUaGUgZXJyb3IgaXMgc3RpbGwgcHJlc2VudCBpbiA2LjE2cmMxLg0KDQpT
cGVjaWZpY2FsbHksIHRoaXMgaXMgdGhlIGNvbW1hbmQgdGhhdCBkaXNhbWJpZ3VhdGVzIHRo
ZSBuZXdlciBicm9rZW4gDQprZXJuZWxzOg0KDQogICAgICAgICB4cmFuZHIgLS1vdXRwdXQg
SERNSS0xIC0tYXV0byAtLXNjYWxlIDF4MSAtLW1vZGUgMTkyMHgxMDgwIA0KLS1yYXRlIDEy
MCAtLXBvcyAweDAgLS1vdXRwdXQgZURQLTEgLS1vZmYNCg0KVGhlIGltcG9ydGFudCBwYXJ0
cyBhcmUgMTkyMHgxMDgwIGFuZCAxMjBIei4gV2hlbiBydW4gb24gY29tbWl0cyBwcmlvciAN
CnRvIHRoZSBiaXNlY3RlZCBhYm92ZSwgaXQgYmVoYXZlcyBhcyBleHBlY3RlZCwgZGVsaXZl
cmluZyAxOTIweDEwODAgQCANCjEyMEh6LiBXaGVuIHJ1biBvbiBrZXJuZWwgYnVpbGRzIHdp
dGggdGhlIGFib3ZlIGNvbW1pdCBpbmNsdWRlZCAodGhhdCANCmNvbW1pdCBvciBsYXRlciks
IHRoZSBtb25pdG9yIGdvZXMgY29tcGxldGVseSBibGFuay4gQWZ0ZXIgYWJvdXQgMzAgDQpz
ZWNvbmRzLCBpdCBzaHV0cyBkb3duIGVudGlyZWx5ICh3aGljaCBJIGFzc3VtZSBtZWFucyB0
aGF0IGZyb20gdGhlIA0KbW9uaXRvcidzIHBlcnNwZWN0aXZlLCBIRE1JIGdvdCAiZGlzY29u
bmVjdGVkIikuDQoNCk9uIHRoaXMgbGluayB5b3UgY2FuIHNlZSBteSBvcmlnaW5hbCByZXBv
cnQgaW4gdGhlIEFyY2hMaW51eCBjb21tdW5pdHksIA0Kd2hlcmUgQ2hyaXN0aWFuIEhldXNl
bCAoQGdyb21pdCkga2luZGx5IGd1aWRlZCBtZSB0aHJvdWdoIHRoZSBiaXNlY3Rpb24gDQpw
cm9jZXNzIGFuZCBidWlsdCB0aGUgYmlzZWN0aW9uIGltYWdlcyBmb3IgbWUgdG8gdHJ5OiAN
Cmh0dHBzOi8vZ2l0bGFiLmFyY2hsaW51eC5vcmcvYXJjaGxpbnV4L3BhY2thZ2luZy9wYWNr
YWdlcy9saW51eC8tL2lzc3Vlcy8xNDUjbm90ZV8yNzc0ODIgDQogIFRoaXMgbGluayBhbHNv
IGNvbnRhaW5zIHRoZSBiaXNlY3Rpb24gaGlzdG9yeS4NCg0KQWRkaXRpb25hbCBpbmZvOg0K
DQoqIFRoZSBtb25pdG9yIGFuZCB0aGUgbm90ZWJvb2sgYXJlIGNvbm5lY3RlZCB2aWEgYW4g
SERNSSBjYWJsZSwgdGhlIA0KbW9uaXRvciBpdHNlbGYgaXMgYSA0a0AxMjBIeiBtb25pdG9y
Lg0KDQoqIEFjY29yZGluZyB0byBgbHNtb2QgfCBncmVwIC1FICIoaTkxNXxYZSkiYCwgSSdt
IHVzaW5nIHRoZSBpOTE1IGtlcm5lbCANCmRyaXZlciBmb3IgdGhlIEdQVS4NCg0KKiBUaGUg
R1BVIGlzIGFuIGlHUFUgZnJvbSBpbnRlbCwgc3BlY2lmaWNhbGx5IGBJbnRlbCBDb3JlIFVs
dHJhIDcgMTU1SGAuDQoNCiogT25lIHN5bXB0b20gdGhhdCBkaXNhbWJpZ3VhdGVzIHRoZSB3
b3JraW5nIGFuZCBub24td29ya2luZyBrZXJuZWxzLCANCmJlc2lkZXMgd2hldGhlciB0aGV5
IGFjdHVhbGx5IGhhdmUgdGhlIGJ1ZywgaXMgdGhhdCB0aGUgYnJva2VuIGtlcm5lbHMgDQpj
YXVzZSB4cmFuZHIgdG8gYWRkaXRpb25hbGx5IHJlcG9ydCB0aGUgMTQ0LjA1IHJlZnJlc2gg
cmF0ZSBhcyBwb3NzaWJsZSANCmZvciB0aGUgbW9uaXRvciwgd2hlcmVhcyB0aGUgbm9uLWJy
b2tlbiBrZXJuZWxzIGNvbnNpc3RlbnRseSBjYXVzZSANCnhyYW5kciB0byBvbmx5IGxpc3Qg
cmVmcmVzaCByYXRlIDEyMCBhbmQgYmVsb3cgYXMgcG9zc2libGUuIEknbSBvbmx5IA0KZXZl
ciB0ZXN0aW5nIHRoZSByZWZyZXNoIHJhdGUgb2YgMTIwLCBidXQgdGhlIHByZXNlbmNlIG9m
IHRoZSAxNDQuMDUgDQpyYXRlIGlzIGNvcnJlbGF0ZWQuDQoNCklmIGFueSBvdGhlciBpbmZv
cm1hdGlvbiBvciBhbnl0aGluZyBpcyBuZWVkZWQsIHBsZWFzZSB3cml0ZS4NCg0KDQpUaGFu
ayB5b3UsDQpWYXMNCg0KLS0tLQ0KDQojcmVnemJvdCBpbnRyb2R1Y2VkOiAxZWZkNTM4NDI3
N2ViNzFmY2UyMDkyMjU3OTA2MWNkM2FjZGIwN2NmDQojcmVnemJvdCB0aXRsZTogaW50ZWwg
aUdQVSB3aXRoIEhETUkgUExMIHN0b3BwZWQgd29ya2luZyBhdCAxMDgwcEAxMjBIeiANCjFl
ZmQ1Mzg0DQojcmVnemJvdCBsaW5rOiANCmh0dHBzOi8vZ2l0bGFiLmFyY2hsaW51eC5vcmcv
YXJjaGxpbnV4L3BhY2thZ2luZy9wYWNrYWdlcy9saW51eC8tL2lzc3Vlcy8xNDUNCg0K
--------------RS0LcFpFyMC1IIVh4SODTdRL
Content-Type: application/pgp-keys; name="OpenPGP_0xB99FAEC6E0D5DF6D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB99FAEC6E0D5DF6D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYrX2ChYJKwYBBAHaRw8BAQdAf/bzdTDerOW5j+qrayMzPOCKthCx8KYKZo20
cty68aPNKFZhc2lsaSBOb3Zpa292IDx2YXN5YS5ub3Zpa292QGdtYWlsLmNvbT7C
jwQTFggANxYhBLKEQxE9sGxECbI4ubmfrsbg1d9tBQJitfYKBQkJZgGAAhsDBAsJ
CAcFFQgJCgsFFgIDAQAACgkQuZ+uxuDV321klwEAm5+HyBecp+ofMZ6Ors+OvrET
LFQU2B9wCd/d/i2NjJABAIssTvgdxlqFI6GjehRMPURi6W1uFMPzzp9gM1yeYXEG
zjgEYrX2ChIKKwYBBAGXVQEFAQEHQODm5qV0UQrPhcJkaZVbhtVmb90gN6rIuN0Q
/xTmhqJ4AwEIB8J+BBgWCAAmFiEEsoRDET2wbEQJsji5uZ+uxuDV320FAmK19goF
CQlmAYACGwwACgkQuZ+uxuDV322trQEA1Yj4GvOlEPfyuhMfX8P0Ah/8QXCqgdMQ
H7PaNgIFFokA/1DgWcc1XGFNRHpOGrJNnF4Ese1hWjYoqo2iBlURPQwP
=3DhvG9
-----END PGP PUBLIC KEY BLOCK-----

--------------RS0LcFpFyMC1IIVh4SODTdRL--

--------------Uc0vBnG4YG2ZGkz04pGupL9t--

--------------dtb1s0ai873eTd9PpSOnx5UG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSyhEMRPbBsRAmyOLm5n67G4NXfbQUCaFFBgQUDAAAAAAAKCRC5n67G4NXfbf5D
AP9371ShOE4XL3p8s7b7jy/gYQYItA57SbyUgoMIVtSSwAD/Rln07IIIAVHqnUX6DS0uZ8+X9UUq
YSDiN3aEMCuTpw8=
=FiZd
-----END PGP SIGNATURE-----

--------------dtb1s0ai873eTd9PpSOnx5UG--

