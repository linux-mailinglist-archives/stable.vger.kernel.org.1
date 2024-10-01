Return-Path: <stable+bounces-78317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7C98B3EC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00F1B21BB1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279A1BBBC0;
	Tue,  1 Oct 2024 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UxEnJDbC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72936AF8
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762009; cv=none; b=Vo/v9q0Vw2okqOKFfu2KCGF8matdTIR9xkoxCjQaN8VxhcB/ADGLaLD27JFCicCUzGgy4QvHlfUj4tUo+q6/tuIuWEGrUKz0RLTamunPpnpJoYCqvqtQqAU79ta5kGGNslPmaWiduJZZpFPzBTyrrdELJcZH/KdunCoHAOVzZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762009; c=relaxed/simple;
	bh=xTRZ6PpFIx9FhtoFcP8X+65S3803CJPGPaRndpZhOS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL0XJbXigCfthh5dub+eN69P9egCqObMkF2I0hYDRmk2g9FmRNiJHHcZNpQEfd31Mt2b4ewKJVLIpt4v3EWNDPFiNSrTfhVieUzK5FARIEB1BqTHzTvypY3KU4mbI0piEMuEsdIIZwvWj/qln6wub3UUAt/SLQQInCUibyD9xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UxEnJDbC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cba8340beso36050535e9.1
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727762005; x=1728366805; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTRZ6PpFIx9FhtoFcP8X+65S3803CJPGPaRndpZhOS4=;
        b=UxEnJDbCSVxA2bV3zl9F2MNIqvFl9EkRNdHlyfzRC9SjGUDWCrm8mD+Yit2jyEc0ak
         IE+g54krVsBgSaarnkzkWfFPsMKF2sqMrofwytPh++4h1Iqy8KjnHfLaMwyeYCyxlDPW
         9KI9yesb3X1HNNxe3XSAs0yNiHX9OKHWVzASLRnJcAsidj+QqyBF8cl7GNUh7EPqfAf9
         DdnopLFkeAjvBkr+STDiPt99J722cDcrCybKtm7mIzIsV9U68Y1oERy4LkmmZe2z8COj
         UQkKFvBYEKmRO6YtvoqBpkdQV6vRbSCit3XcrbqRek6sxG5TAYIVu1UEA9WdTE49gtmS
         SXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762005; x=1728366805;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTRZ6PpFIx9FhtoFcP8X+65S3803CJPGPaRndpZhOS4=;
        b=LmYrckW0VeK0az1ZOl5rzEpRXiIWmHpDxxn9aus7fStMGdNC+s5vvL7srwJollqxVP
         RYJOf5jRlXYICNvTywE7cGZ4cYrKW6oi7KdSVO1Zm7l9DqcOLHsCax1xo45sVRD+z1OT
         VDum7hwK3uhacZnvkh9QQzfDnnI5plugeh8Ng4tBRbiC6v6dnKZuYU+M40RqH03wjIzL
         flMwMBnJF2lHD0GTzNR5m/Q878fMew9hKc89pxjoyw+gs39NYRcT4loJrV3Z3b20RAj5
         trx0Ff4r+huhx8yi7noBWcGMMusTukEAuH+SPDC8yOiv0G+U5bFV/vflFKUFfzgGWp1B
         EbLw==
X-Gm-Message-State: AOJu0YxVRy1fB2XUwDIVnverM6G/Okqv1PQ20fQu+HeM9XNCrGwunD9J
	qC2EweMsyf5L3usqloHy5NAq7ojUldfd+bXqH6eP50DEqrWFSRrHWsqeiw2FsLYz3Dz4m9pqBL4
	U
X-Google-Smtp-Source: AGHT+IH8OSSAzfdDGdkz7i2fG1vejGbat/AWOmCzMX2A2ul/Oa3qaYhC0lv4dmCIHGPJ0ieJqh3bQA==
X-Received: by 2002:a05:600c:5113:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-42f713553aamr9649605e9.11.1727762004685;
        Mon, 30 Sep 2024 22:53:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e669sm10930008f8f.34.2024.09.30.22.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 22:53:24 -0700 (PDT)
Message-ID: <25156641-8cca-4ccd-a1db-3916871929bc@suse.com>
Date: Tue, 1 Oct 2024 07:53:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory" has been added to the 6.11-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240930231559.2561833-1-sashal@kernel.org>
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
In-Reply-To: <20240930231559.2561833-1-sashal@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FbiUQb904z31QAfGvsS9MhD4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FbiUQb904z31QAfGvsS9MhD4
Content-Type: multipart/mixed; boundary="------------X01u6zZKvhria0yfy84cia8r";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <25156641-8cca-4ccd-a1db-3916871929bc@suse.com>
Subject: Re: Patch "xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory" has been added to the 6.11-stable tree
References: <20240930231559.2561833-1-sashal@kernel.org>
In-Reply-To: <20240930231559.2561833-1-sashal@kernel.org>

--------------X01u6zZKvhria0yfy84cia8r
Content-Type: multipart/mixed; boundary="------------dR9VAiZ0XY9bK0fq1hQdPAkT"

--------------dR9VAiZ0XY9bK0fq1hQdPAkT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMTAuMjQgMDE6MTUsIFNhc2hhIExldmluIHdyb3RlOg0KPiBUaGlzIGlzIGEgbm90
ZSB0byBsZXQgeW91IGtub3cgdGhhdCBJJ3ZlIGp1c3QgYWRkZWQgdGhlIHBhdGNoIHRpdGxl
ZA0KPiANCj4gICAgICB4ZW46IHRvbGVyYXRlIEFDUEkgTlZTIG1lbW9yeSBvdmVybGFwcGlu
ZyB3aXRoIFhlbiBhbGxvY2F0ZWQgbWVtb3J5DQo+IA0KPiB0byB0aGUgNi4xMS1zdGFibGUg
dHJlZSB3aGljaCBjYW4gYmUgZm91bmQgYXQ6DQo+ICAgICAgaHR0cDovL3d3dy5rZXJuZWwu
b3JnL2dpdC8/cD1saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9zdGFibGUtcXVldWUuZ2l0O2E9
c3VtbWFyeQ0KPiANCj4gVGhlIGZpbGVuYW1lIG9mIHRoZSBwYXRjaCBpczoNCj4gICAgICAg
eGVuLXRvbGVyYXRlLWFjcGktbnZzLW1lbW9yeS1vdmVybGFwcGluZy13aXRoLXhlbi1hbC5w
YXRjaA0KPiBhbmQgaXQgY2FuIGJlIGZvdW5kIGluIHRoZSBxdWV1ZS02LjExIHN1YmRpcmVj
dG9yeS4NCj4gDQo+IElmIHlvdSwgb3IgYW55b25lIGVsc2UsIGZlZWxzIGl0IHNob3VsZCBu
b3QgYmUgYWRkZWQgdG8gdGhlIHN0YWJsZSB0cmVlLA0KPiBwbGVhc2UgbGV0IDxzdGFibGVA
dmdlci5rZXJuZWwub3JnPiBrbm93IGFib3V0IGl0Lg0KPiANCj4gDQo+IA0KPiBjb21taXQg
ODMwMmFjMjAwZTNmYjJlOGI2NjliOTZkN2MzNmNkYzI2NmU0NzEzOA0KPiBBdXRob3I6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gRGF0ZTogICBGcmkgQXVnIDIgMjA6
MTQ6MjIgMjAyNCArMDIwMA0KPiANCj4gICAgICB4ZW46IHRvbGVyYXRlIEFDUEkgTlZTIG1l
bW9yeSBvdmVybGFwcGluZyB3aXRoIFhlbiBhbGxvY2F0ZWQgbWVtb3J5DQo+ICAgICAgDQo+
ICAgICAgWyBVcHN0cmVhbSBjb21taXQgYmUzNWQ5MWM4ODgwNjUwNDA0ZjNiZjgxMzU3MzIy
MmRmYjEwNjkzNSBdDQoNCkZvciB0aGlzIHBhdGNoIHRvIGhhdmUgdGhlIGRlc2lyZWQgZWZm
ZWN0IHRoZXJlIGFyZSB0aGUgZm9sbG93aW5nDQpwcmVyZXF1aXNpdGUgcGF0Y2hlcyBtaXNz
aW5nOg0KDQpjNDQ5OGFlMzE2ZGEgKCJ4ZW46IG1vdmUgY2hlY2tzIGZvciBlODIwIGNvbmZs
aWN0cyBmdXJ0aGVyIHVwIikNCjkyMjEyMjJjNzE3ZCAoInhlbjogYWxsb3cgbWFwcGluZyBB
Q1BJIGRhdGEgdXNpbmcgYSBkaWZmZXJlbnQgcGh5c2ljYWwgYWRkcmVzcyIpDQoNClBsZWFz
ZSBhZGQgdGhvc2UgdG8gdGhlIHN0YWJsZSB0cmVlcywgdG9vLg0KDQoNCkp1ZXJnZW4NCg==

--------------dR9VAiZ0XY9bK0fq1hQdPAkT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dR9VAiZ0XY9bK0fq1hQdPAkT--

--------------X01u6zZKvhria0yfy84cia8r--

--------------FbiUQb904z31QAfGvsS9MhD4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmb7jlMFAwAAAAAACgkQsN6d1ii/Ey8y
7gf+JlTLKQY+yGDX0jmjzs4xER3eYaAqXb3lLw5CmjjreLztouGRHiyspRB7TTq4D1pOdnThEmPT
AsPLf+8RKtd8zt9ZJra0UkYt1lQ4M5juvaFZ9zzoleMiNf0/eDUg/8BnLTwb8ZWqkW+7wF9e1MoU
6pnct92FcnEBQgvNn6qLeaOOzWXJpDytu8YQa1j5C4HfoSHTTtpZTV3gPUArsLvpBnf5utQT+MJj
wXgbxO4RY6OeTfJd5CXaOXItt/dld1S4h3I4QU/Or7Jlm6Guqu+WPaVSkOOkhLgyjNGN1li+/oJl
yTMe3HF9dNbQyF2l2UxBdUUUdWPf5RVHLyAbys83sw==
=73qu
-----END PGP SIGNATURE-----

--------------FbiUQb904z31QAfGvsS9MhD4--

