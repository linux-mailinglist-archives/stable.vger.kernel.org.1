Return-Path: <stable+bounces-89852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD69BD134
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A88281F40
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C914E2D8;
	Tue,  5 Nov 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UTbf4NQE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B9824BD
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822202; cv=none; b=DoYicjtkfsXgi3q+fBowUwczrQs1uqXF5omB48T927HZPTc33/tgdMBmX3TJnPunPG0bCzcQPdHixo+oj5uwb+m4CcjsPWlVvcmobhIPygbypdCMeLZq0PCmBWfrLkhdZVZfo92O99LDODjhPaVy+IfZtokNQpu/qZYqWiL4WZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822202; c=relaxed/simple;
	bh=bz3e7dP1KeYuebRZGkFKNHi29d8JijMB5urnbXUCkJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnv/xDvWY/gYAGI60005s+CN9XTB33b7ztaC+gvz7YizfGJiNdQdB3iINeRWkarC9k2aZPwLVduGuc+NqyZbOqvv9Ei/QFQBUpXJLb8UzPOwZhBWDcax5wXN1R+qJcoz7sOQt93gqjr71DKhs36TEPn43DO2doayHY5PEo8L3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UTbf4NQE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316cce103dso66518335e9.3
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730822199; x=1731426999; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bz3e7dP1KeYuebRZGkFKNHi29d8JijMB5urnbXUCkJg=;
        b=UTbf4NQEc1qZN2uZkn/UbHYreyzJ+l2H90X3T1ztJ5sny1wnL690Mlt5Rge3WrHiJo
         WXmLsxUa4uP2B57/VlRirU3ZrGu8iFlg6mTLNV4/FOvhLXfypnCC5fn3NJcMyGtf+0T8
         QUWIGLQ5wn33unIvDqhX0ZcaV2nY32+dIvLIGW2TT+NkrScuUY1cLtmmfcIrlNGUKFWn
         Pq1m7qUqe/n9j5XFr7tShanKV9oTUp4ICfMLY+7cTQmnBRMTcthQMLnbwoZ5alk3C0xe
         qPXbMQoHSKm/Cs7Rp/vONSWb2NxP8pDvTXcs3KLECGmApTPPnI3dKklGUtvjuucEXwGW
         sLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822199; x=1731426999;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz3e7dP1KeYuebRZGkFKNHi29d8JijMB5urnbXUCkJg=;
        b=t/B9T7EyI4ooLYI78vvz9MEJRwu03oN3nkwsX1gWVhsIGbcbFHBH2Og+h13FdJ+8cv
         qN4nTQ0Y3dlEzT499NvHPb5wK3TdSQeAbSlh3ka/eHD8Z7AEQwZEzS22lfjz0BtWB03i
         tYnPyUTeNCFDZF45L9pK7vrljF9139nXa0fsEETeUNZVm110m9K3XBV+k6m/2Co9+iaD
         UIXySvMz8Vyia6qWg0hw1pOqD0MdRNK4cz8FkCeC9zngY8Nf5UQ5+zH/VEoX9aSej5W/
         1VctHO4b55Ii5DdaF2XyE1EbUy0iR9/NsSQbyfmNEEymaVOGG/iQmVzcLCni7x0aloee
         FryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8Q+ZttSztDkF0U6H5QvTtbkZBtxNG0sBid7YHvgvXgBRmEs4kTQ5Yk2aEaN7/OGuhL6IHvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDc/nO+rqUK3ms8/PIxe6vFDa+o4VgTAqlETjUWRuHqwTFy7UV
	Le4V+Kga6NM3EDn4Emp9FjLDkD/XBraK/W+d42BPYmW/Q89TAwxaV+FDB6z5CnM=
X-Google-Smtp-Source: AGHT+IEScPUofJaERY2yiZU967o6GxVCJasBuDqbrT9wmPNg0fIR0y3JxAZ2piRjiLQoHXIs/cDqjQ==
X-Received: by 2002:adf:e199:0:b0:37d:4eeb:7370 with SMTP id ffacd0b85a97d-381c7ae14bdmr17673662f8f.56.1730822198751;
        Tue, 05 Nov 2024 07:56:38 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb18140a6sm150564266b.195.2024.11.05.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:56:38 -0800 (PST)
Message-ID: <79984ce2-98a2-42f4-85f8-fd53d71f10c7@suse.com>
Date: Tue, 5 Nov 2024 16:56:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Fix the issue of resource not being properly
 released in xenbus_dev_probe()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, gregkh@linuxfoundation.org,
 sumit.garg@linaro.org, xin.wang2@amd.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20241105130919.4621-1-chenqiuji666@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20241105130919.4621-1-chenqiuji666@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eTdyGz0k450u4KZEC4Cbyb0S"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eTdyGz0k450u4KZEC4Cbyb0S
Content-Type: multipart/mixed; boundary="------------FTEVxyFrAV4twIPuT6CjSaEj";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, gregkh@linuxfoundation.org,
 sumit.garg@linaro.org, xin.wang2@amd.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
Message-ID: <79984ce2-98a2-42f4-85f8-fd53d71f10c7@suse.com>
Subject: Re: [PATCH] xen: Fix the issue of resource not being properly
 released in xenbus_dev_probe()
References: <20241105130919.4621-1-chenqiuji666@gmail.com>
In-Reply-To: <20241105130919.4621-1-chenqiuji666@gmail.com>

--------------FTEVxyFrAV4twIPuT6CjSaEj
Content-Type: multipart/mixed; boundary="------------PI0x0UKMcbQZcGfSxIk646iX"

--------------PI0x0UKMcbQZcGfSxIk646iX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMTEuMjQgMTQ6MDksIFFpdS1qaSBDaGVuIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGZp
eGVzIGFuIGlzc3VlIGluIHRoZSBmdW5jdGlvbiB4ZW5idXNfZGV2X3Byb2JlKCkuIEluIHRo
ZQ0KPiB4ZW5idXNfZGV2X3Byb2JlKCkgZnVuY3Rpb24sIHdpdGhpbiB0aGUgaWYgKGVycikg
YnJhbmNoIGF0IGxpbmUgMzEzLCB0aGUNCj4gcHJvZ3JhbSBpbmNvcnJlY3RseSByZXR1cm5z
IGVyciBkaXJlY3RseSB3aXRob3V0IHJlbGVhc2luZyB0aGUgcmVzb3VyY2VzDQo+IGFsbG9j
YXRlZCBieSBlcnIgPSBkcnYtPnByb2JlKGRldiwgaWQpLiBBcyB0aGUgcmV0dXJuIHZhbHVl
IGlzIG5vbi16ZXJvLA0KPiB0aGUgdXBwZXIgbGF5ZXJzIGFzc3VtZSB0aGUgcHJvY2Vzc2lu
ZyBsb2dpYyBoYXMgZmFpbGVkLiBIb3dldmVyLCB0aGUgcHJvYmUNCj4gb3BlcmF0aW9uIHdh
cyBwZXJmb3JtZWQgZWFybGllciB3aXRob3V0IGEgY29ycmVzcG9uZGluZyByZW1vdmUgb3Bl
cmF0aW9uLg0KPiBTaW5jZSB0aGUgcHJvYmUgYWN0dWFsbHkgYWxsb2NhdGVzIHJlc291cmNl
cywgZmFpbGluZyB0byBwZXJmb3JtIHRoZSByZW1vdmUNCj4gb3BlcmF0aW9uIGNvdWxkIGxl
YWQgdG8gcHJvYmxlbXMuDQo+IA0KPiBUbyBmaXggdGhpcyBpc3N1ZSwgd2UgZm9sbG93ZWQg
dGhlIHJlc291cmNlIHJlbGVhc2UgbG9naWMgb2YgdGhlDQo+IHhlbmJ1c19kZXZfcmVtb3Zl
KCkgZnVuY3Rpb24gYnkgYWRkaW5nIGEgbmV3IGJsb2NrIGZhaWxfcmVtb3ZlIGJlZm9yZSB0
aGUNCj4gZmFpbF9wdXQgYmxvY2suIEFmdGVyIGVudGVyaW5nIHRoZSBicmFuY2ggaWYgKGVy
cikgYXQgbGluZSAzMTMsIHRoZQ0KPiBmdW5jdGlvbiB3aWxsIHVzZSBhIGdvdG8gc3RhdGVt
ZW50IHRvIGp1bXAgdG8gdGhlIGZhaWxfcmVtb3ZlIGJsb2NrLA0KPiBlbnN1cmluZyB0aGF0
IHRoZSBwcmV2aW91c2x5IGFjcXVpcmVkIHJlc291cmNlcyBhcmUgY29ycmVjdGx5IHJlbGVh
c2VkLA0KPiB0aHVzIHByZXZlbnRpbmcgdGhlIHJlZmVyZW5jZSBjb3VudCBsZWFrLg0KPiAN
Cj4gVGhpcyBidWcgd2FzIGlkZW50aWZpZWQgYnkgYW4gZXhwZXJpbWVudGFsIHN0YXRpYyBh
bmFseXNpcyB0b29sIGRldmVsb3BlZA0KPiBieSBvdXIgdGVhbS4gVGhlIHRvb2wgc3BlY2lh
bGl6ZXMgaW4gYW5hbHl6aW5nIHJlZmVyZW5jZSBjb3VudCBvcGVyYXRpb25zDQo+IGFuZCBk
ZXRlY3RpbmcgcG90ZW50aWFsIGlzc3VlcyB3aGVyZSByZXNvdXJjZXMgYXJlIG5vdCBwcm9w
ZXJseSBtYW5hZ2VkLg0KPiBJbiB0aGlzIGNhc2UsIHRoZSB0b29sIGZsYWdnZWQgdGhlIG1p
c3NpbmcgcmVsZWFzZSBvcGVyYXRpb24gYXMgYQ0KPiBwb3RlbnRpYWwgcHJvYmxlbSwgd2hp
Y2ggbGVkIHRvIHRoZSBkZXZlbG9wbWVudCBvZiB0aGlzIHBhdGNoLg0KPiANCj4gRml4ZXM6
IDRiYWMwN2M5OTNkMCAoInhlbjogYWRkIHRoZSBYZW5idXMgc3lzZnMgYW5kIHZpcnR1YWwg
ZGV2aWNlIGhvdHBsdWcgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU2lnbmVkLW9mZi1ieTogUWl1LWppIENoZW4gPGNoZW5xaXVqaTY2NkBnbWFpbC5jb20+
DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0K
SnVlcmdlbg0K
--------------PI0x0UKMcbQZcGfSxIk646iX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------PI0x0UKMcbQZcGfSxIk646iX--

--------------FTEVxyFrAV4twIPuT6CjSaEj--

--------------eTdyGz0k450u4KZEC4Cbyb0S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmcqQDUFAwAAAAAACgkQsN6d1ii/Ey98
oQf9G78mT3vg32/jkgPBfk3e87JtKYp0xwTMxC3WIEreRnKl5wfUPW4pOQqRyKj3NcoRy4hncQ5w
Ez3viiQAAEOUokVzlsqR8pyBjw2QN3SN+/A32jc4VoCADjfGaPaV/OvkfXiSCF51yP4EO8Pso+1y
h7p7EI+wG6Dh9iAEAf6AA6wj9rsuXvFIsdmJZEz8e3ObcUjAzyB96m7+JTm1lfuajvrrWu/HQJiU
2G3TBJtluqKgbXcVp82pXPmMMBP2BUJgYYMtLBdIsSM4WLn35AJH/HSPJ5GbxmoVRu4uRZutSsJD
JNGTUno81aAL1118XaOPfUW/EUC0bLqWOFAzkXZ9hA==
=PTAO
-----END PGP SIGNATURE-----

--------------eTdyGz0k450u4KZEC4Cbyb0S--

