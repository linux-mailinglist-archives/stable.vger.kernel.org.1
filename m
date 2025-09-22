Return-Path: <stable+bounces-180881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72172B8F116
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C413B6961
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43C2367B5;
	Mon, 22 Sep 2025 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ILlNhMs1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135A80C02
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521192; cv=none; b=ZfhvV/lxkTrrXtEYMZj9MuTDsYRo2hssmyH6UMHmFRLb5stjtRWsNNKFeO6xFLeLU1XzpBeJA6RYmmnzA/TJQgX10uneJNcP8S03VLpyktkHUUYWH2y25AckSUnO/bZo1mMlQfu2dQYhd+5IQ7dhSdxQeQUttAD3P+KYBNf844M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521192; c=relaxed/simple;
	bh=S33tBRFGEL/DOZHvKhG7BtJTvv1OFtfAiwgB5Qbf6Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYtpk0ZsJ/Vrke8fz2v9NhBzvy2WQMCSbtfrkajEH5qnWFPmweNh1vFnzoeKkr4Oa66Phg+MMgNIrARleT4ryx4viirGHMnhEMiUw0fTsSMQnUovyDMK1QCsp4s/dlORW6HzdJWbF3w2I4p0Jjx2QY7KoAwbuGyiR8o+x987pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ILlNhMs1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46cf7bbfda8so3988655e9.2
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758521188; x=1759125988; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S33tBRFGEL/DOZHvKhG7BtJTvv1OFtfAiwgB5Qbf6Z0=;
        b=ILlNhMs15BSfDnseL/1yifXrft70cgJX91TMnKYKV0CJH2omIIKQPyJNHDCidWsWsT
         SDdgCNGAnVxHTgOxG5PenBY/4uYJdWpfVeLpdXWhdMbFvaJTpXghN8JRcj4DL3vxzpzx
         JvRP7V6xAIzjtUXKaB6Vfyj+aOf9NkdJzdD39QUxmnD+AbXPvOQ2mFQZvt6AuihHKy8B
         35/KPihtTTkaTeIVrGrrvftdyc4O7ngIi7YIveo5pldAyfT8h5KCP1pLjPR52a5gVuDA
         m7tN+K2qDiVAeS3niyBBP3VHKLJZZ7MjnZexm2wZBiZEPGcr/7+NFa5nNjd/mkvIF0V0
         1rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758521188; x=1759125988;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S33tBRFGEL/DOZHvKhG7BtJTvv1OFtfAiwgB5Qbf6Z0=;
        b=uWA7ShB4AQMipKft5ro8NpXoA1utmBVN5xSXAGcte4a/9Yz7KdZavmfc0LIjkmR/mB
         +t0bPP4DPI8hgGG0AUqLGHAOwR/nhJcZVkTBZo8bReaafGaOmCwwVmSetzYcpKMTUORK
         0Q7N4UNSYG99qaMcrfLrEj7wQpQQP/XKi84wDnT/U7DALf/WkZhVJwhghjvhomRjsqlM
         KqfcpkULSooAeVh3g4XsrhowymCF0gcRoM6NMj7kH/ctS7jHKGurFsHVzPHJNPHs3gcu
         vvhBibSncUIrdmbZgz5Su/ZI/BPGl7O/FvOybw3PYP9icYbP/Xir2Ug2cNyjeYsWjnaH
         69XA==
X-Gm-Message-State: AOJu0YyOLw6KO11+6b6+yIJdvKUaZ0ybzRJZ6wUDLAEXnQOrNy/PX1PF
	wDkOEBxPvqWEtHMAK6CQRhbjxC379MTNzGdSMWz3yex5dht9hpXIPW4Niv40ZVUngWo=
X-Gm-Gg: ASbGncsfyLYgjoT3yDqxUivziuzAfRBRXnRTUY8jK6TdO84CYaCsY6llsWj5+IOPU8N
	cZ0DkK7EtRLRYtV60A1HwV61fyHMQVMeN/YU1J7gKtkzASyl/bmHjWMKG1DpoFQYlmL7O2qFLc+
	IYSiYP+W9W8CnbupQlTJa9UvrOcmtWVZijj1B+fEV1+QuoqxSKGYHNUVKMu9ynAo7LgCNs0nU4O
	2jKd/6hLqAsQjwbXeXxnkQlA3LMrMeSxwaenEQw8bN0L9kaLjmOLP7hvuDHZFmyCHFZaijp1WGe
	C+puMQV6BcozkvO/Tv/QEJpYdG3WWj+L0Dx1t4R2BOZUdZgwBoe7/dOe7yakqM/Pii7JSEVwksA
	BGquyO3u12J/oEfwKBim5lDNR05ZOURju1uep7HY0qSxzZk3xIdldOsFECoCGZelYuEqqovSYpp
	wRJfmwJkFg5D37Av6uyOanfzhJl8cwfN4A4S/jWUzjRYrN
X-Google-Smtp-Source: AGHT+IFD2CfjVpWeDi5iUTryBGhtdm4ngYLxtc/glzzILx3/6SMLU91M4jq7nuc4Yswkou5ELKp8EQ==
X-Received: by 2002:a05:600c:1f95:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-467e75ea470mr106925685e9.7.1758521188377;
        Sun, 21 Sep 2025 23:06:28 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:be00:c26:b971:1ba7:9d8b? (p200300e5873dbe000c26b9711ba79d8b.dip0.t-ipconnect.de. [2003:e5:873d:be00:c26:b971:1ba7:9d8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074106f4sm18265990f8f.25.2025.09.21.23.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 23:06:27 -0700 (PDT)
Message-ID: <a8d1d076-81b0-424e-b281-dfbd49130d38@suse.com>
Date: Mon, 22 Sep 2025 08:06:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: take system_transition_mutex on suspend
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
References: <20250921162853.223116-1-marmarek@invisiblethingslab.com>
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
In-Reply-To: <20250921162853.223116-1-marmarek@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------whziD4bI9vuk0vBNxNwWgLTF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------whziD4bI9vuk0vBNxNwWgLTF
Content-Type: multipart/mixed; boundary="------------MI4OlWCfs6VtvyAFMm5tUoqt";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <a8d1d076-81b0-424e-b281-dfbd49130d38@suse.com>
Subject: Re: [PATCH] xen: take system_transition_mutex on suspend
References: <20250921162853.223116-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20250921162853.223116-1-marmarek@invisiblethingslab.com>

--------------MI4OlWCfs6VtvyAFMm5tUoqt
Content-Type: multipart/mixed; boundary="------------xxNp610sdXCe0SVU03qz4z0d"

--------------xxNp610sdXCe0SVU03qz4z0d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDkuMjUgMTg6MjgsIE1hcmVrIE1hcmN6eWtvd3NraS1Hw7NyZWNraSB3cm90ZToN
Cj4gWGVuJ3MgZG9fc3VzcGVuZCgpIGNhbGxzIGRwbV9zdXNwZW5kX3N0YXJ0KCkgd2l0aG91
dCB0YWtpbmcgcmVxdWlyZWQNCj4gc3lzdGVtX3RyYW5zaXRpb25fbXV0ZXguIFNpbmNlIDEy
ZmZjM2IxNTEzZWIgbW92ZWQgdGhlDQo+IHBtX3Jlc3RyaWN0X2dmcF9tYXNrKCkgY2FsbCwg
bm90IHRha2luZyB0aGF0IG11dGV4IHJlc3VsdHMgaW4gYSBXQVJOLg0KPiANCj4gVGFrZSB0
aGUgbXV0ZXggaW4gZG9fc3VzcGVuZCgpLCBhbmQgdXNlIG11dGV4X3RyeWxvY2soKSB0byBm
b2xsb3cNCj4gaG93IGVudGVyX3N0YXRlKCkgZG9lcyB0aGlzLg0KPiANCj4gU3VnZ2VzdGVk
LWJ5OiBKw7xyZ2VuIEdyb8OfIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IEZpeGVzOiAxMmZmYzNi
MTUxM2ViICJQTTogUmVzdHJpY3Qgc3dhcCB1c2UgdG8gbGF0ZXIgaW4gdGhlIHN1c3BlbmQg
c2VxdWVuY2UiDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3hlbi1kZXZlbC9h
S2lCSmVxc1l4XzRUb3A1QG1haWwtaXRsLw0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBNYXJj
enlrb3dza2ktR8OzcmVja2kgPG1hcm1hcmVrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+DQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjYuMTYrDQoNClJldmlld2VkLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------xxNp610sdXCe0SVU03qz4z0d
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------xxNp610sdXCe0SVU03qz4z0d--

--------------MI4OlWCfs6VtvyAFMm5tUoqt--

--------------whziD4bI9vuk0vBNxNwWgLTF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjQ52MFAwAAAAAACgkQsN6d1ii/Ey9w
agf9EtF5ZEwY40ioARPpA3Uwj6TmMhq+8ONvmTy9b+fBkH3hLDun1yrAO5SQQ1tp8t9FeBvUOr4H
jWKH8/4iHaxFOzoN43TVAptMm5oNw7DnXEzKdC6yGx/nin0LkRt5zRfVhBMNhHH6DBBFpNm1lrjx
vOm8UKVYRL//GcM4cko+d5TnTKzuagPcyaNe45Jy3PK9mOKn0FKrM3q2NRd2J6Zi1u7xR5cMJjyy
PsIKZNFTbqjIPrsMb5HPRQGVY/nr4dLSj91tLO8D7kBHKH6OFOgDHyE0kIWwa+05p61f5u9moNBu
AuZmlWg1NNmmQkZobKf8bjg/9V2aTnvgwsSPSIcTPw==
=TmYL
-----END PGP SIGNATURE-----

--------------whziD4bI9vuk0vBNxNwWgLTF--

