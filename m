Return-Path: <stable+bounces-120045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B9A4BB55
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 10:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0321189548E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9C1F2C3B;
	Mon,  3 Mar 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DfL3huHZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C21F2360
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995677; cv=none; b=mGb7AQbm5Qa7Zesz/zMYOulNIHmtjImSREB00CsTyft/a6jag/77D8C3YWroLk4Xwonv4+IRYo5SWqtwe8Fa6agVvqKLWPkNCf7n6w9e+ZpU7g6ALMZiCv/RMzvWq//Ljd/9DnRHxVZGzynqHA87DqHuRdbfcFTeL4LjJJr9HFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995677; c=relaxed/simple;
	bh=A58wzXqspOCF7y1nRcqMkTGPyro87VFDTZ78HorgFs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijEHTWBkiQhstzcue9v46rMuLSVR1tcBR13zug4Iskj8dpQR+ZeglYpX1H3zcL9c6QjLPVdhYten6Kaw8cNpfQPUGhrI4GuT/TZdSBdDOOy399lnYQP7F4KBlyRPCBOXKcA8uqyI0/SoZne+OzkEW9ZJLdlJQ1H7pBd7OpftHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DfL3huHZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso6629218a12.2
        for <stable@vger.kernel.org>; Mon, 03 Mar 2025 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740995672; x=1741600472; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A58wzXqspOCF7y1nRcqMkTGPyro87VFDTZ78HorgFs8=;
        b=DfL3huHZey2tUhWrSKQsKqyYBKRR79luWnjcdQZrChl5tZoQAcQ6HLmo4lCr2PiAAZ
         p/Jx25u47+Qi+8mWE5nRlV4FNRcSg1inW7I4SSbIvXCP0b/1tKaeaeVC+y3Xnuv+4c7F
         xhDzSy8ZzPdjyqv3tXyO01BGFWrvSny0mAMFztmzxbojg8ScBvxgITEMLvnI/w8icMGN
         +q1IW5tmbUWpUxypCchDXcMsD/pqvhzWi0YaH+w9Y2Il+mcgZP3crOOf9GIdX+yA8lzO
         pAxG7m5XPyno9NvRHGnG6h5yqXgPHdmMRrmm6jcjTAFlx5dntaoOtJdrQRemtgIDnyo0
         ZqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995672; x=1741600472;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A58wzXqspOCF7y1nRcqMkTGPyro87VFDTZ78HorgFs8=;
        b=svatpF+WEMNCV20ovnUmxRDuQyKI5ac6JuIqUYfvpdkQYuO0xVqmrCs4QaLzF1WF9U
         Whx/owKAjmANsrnv3N0zK3PgpF1W2pyb+3kLqOYFb/ZSiht849shQYjN/6FxGVFuR27C
         e6rRMW0UIIssiQRc29RuoM5u7YRBICAKfi04XT/Q6NuF/doxVNcKAe5wFq2qLXtNqgB7
         bP1PQcfSgUcK2XL9au2NNYo8dyMDlt8tYLTkOugMc0HywxeVhp2vs+JGb9hqHx2iP0tz
         7YILhbInGuiuPV1qCdw+z7d7b5nSScNDgjLkbbHnRp47cBd4Hbhm4IhvUSPAECNakInZ
         hcMg==
X-Forwarded-Encrypted: i=1; AJvYcCWZNYga6x9hA7Er2i5M54ToH5oMiAD5b1uoGTkbVIQoqvvXC/x8tXTiWAay5sAJEkjFW7LPgEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjHGD1+HInNFjW8Ndb+yyxGvzuawi96BUw247SAieLUWlXouN
	dTP4ubT028LX1JKfqkVDcPPnFny7+VhOf+YYhp3pLJXQ+Ei+OOw0aCHMfKfqoFc=
X-Gm-Gg: ASbGncuXJtEatxQN3TkCg8yDaDRedlCme+S3XiHCkxGnoVe6dd/q7JJRSs5/1iI9H46
	qxn55zNr9MCxgPfEwPX7aw7KtBcmad0+qLkXFc6rWQoXstEM4gQrRGdj1BUXhno1Iw4H4C0OFk3
	FXUXnN7JBQch2wHzY4rwYPZRObWlgO/W8bodCNWl9RYMsptJN8i1K8YSziCih4lj45Av6d+EFlC
	ObsrpmHRzA+7cQuTPGkyUlAkggvD/GydvJxXk4ZLLD0qOt2S+d1GyJGlP1cBN/y9ze/4I+IOTXb
	B8/6lmCl6LsbD/K48NVBgD44J01L3QOp+6PAqOyUORMr6UM+luTy14XVuytmgcQFmuA2JsjGDih
	ElgyBZFmk8FqRzUfZxlQauh+XjqnW1qaWPSgdQB6QqVbxKHVq2JTkUB3wR8PaVkZOMBU=
X-Google-Smtp-Source: AGHT+IGW4m97/5Z6mzGE+FtM7OG3AsUThkKvGu7Efn6SS4sBYUvLGkxkFKD9S/u/8MdUzBtxBFwR1w==
X-Received: by 2002:a05:6402:26c9:b0:5e0:34b5:13c0 with SMTP id 4fb4d7f45d1cf-5e4d6b05015mr11608759a12.19.1740995672489;
        Mon, 03 Mar 2025 01:54:32 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a6ab7sm6603426a12.74.2025.03.03.01.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:54:32 -0800 (PST)
Message-ID: <e49c22e8-04df-4a1b-b68e-378f73a861f9@suse.com>
Date: Mon, 3 Mar 2025 10:54:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com,
 erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com,
 sagis@google.com, oupton@google.com, pgonda@google.com,
 kirill@shutemov.name, dave.hansen@linux.intel.com,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, ajay.kaher@broadcom.com,
 alexey.amakhalov@broadcom.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com>
 <Z8IvDeIJH2EJuPo-@char.us.oracle.com>
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
In-Reply-To: <Z8IvDeIJH2EJuPo-@char.us.oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5LLYudiyGxvk0eCeMC0cD70G"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5LLYudiyGxvk0eCeMC0cD70G
Content-Type: multipart/mixed; boundary="------------Uen3bzhHMfNu8u1d60iDkUwy";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com,
 erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com,
 sagis@google.com, oupton@google.com, pgonda@google.com,
 kirill@shutemov.name, dave.hansen@linux.intel.com,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, ajay.kaher@broadcom.com,
 alexey.amakhalov@broadcom.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
Message-ID: <e49c22e8-04df-4a1b-b68e-378f73a861f9@suse.com>
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com>
 <Z8IvDeIJH2EJuPo-@char.us.oracle.com>
In-Reply-To: <Z8IvDeIJH2EJuPo-@char.us.oracle.com>

--------------Uen3bzhHMfNu8u1d60iDkUwy
Content-Type: multipart/mixed; boundary="------------jshMhZZ1nAInseKi0TepNMrO"

--------------jshMhZZ1nAInseKi0TepNMrO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDIuMjUgMjI6NDcsIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToNCj4gT24g
VGh1LCBGZWIgMjAsIDIwMjUgYXQgMDk6MTY6MjVQTSArMDAwMCwgVmlzaGFsIEFubmFwdXJ2
ZSB3cm90ZToNCj4+IEZyb206ICJLaXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVt
b3ZAbGludXguaW50ZWwuY29tPg0KPj4NCj4+IENPTkZJR19QQVJBVklSVF9YWEwgaXMgbWFp
bmx5IGRlZmluZWQvdXNlZCBieSBYRU4gUFYgZ3Vlc3RzLiBGb3INCj4+IG90aGVyIFZNIGd1
ZXN0IHR5cGVzLCBmZWF0dXJlcyBzdXBwb3J0ZWQgdW5kZXIgQ09ORklHX1BBUkFWSVJUDQo+
PiBhcmUgc2VsZiBzdWZmaWNpZW50LiBDT05GSUdfUEFSQVZJUlQgbWFpbmx5IHByb3ZpZGVz
IHN1cHBvcnQgZm9yDQo+PiBUTEIgZmx1c2ggb3BlcmF0aW9ucyBhbmQgdGltZSByZWxhdGVk
IG9wZXJhdGlvbnMuDQo+Pg0KPj4gRm9yIFREWCBndWVzdCBhcyB3ZWxsLCBwYXJhdmlydCBj
YWxscyB1bmRlciBDT05GSUdfUEFSVklSVCBtZWV0cw0KPj4gbW9zdCBvZiBpdHMgcmVxdWly
ZW1lbnQgZXhjZXB0IHRoZSBuZWVkIG9mIEhMVCBhbmQgU0FGRV9ITFQNCj4+IHBhcmF2aXJ0
IGNhbGxzLCB3aGljaCBpcyBjdXJyZW50bHkgZGVmaW5lZCB1bmRlcg0KPj4gQ09ORklHX1BB
UkFWSVJUX1hYTC4NCj4+DQo+PiBTaW5jZSBlbmFibGluZyBDT05GSUdfUEFSQVZJUlRfWFhM
IGlzIHRvbyBibG9hdGVkIGZvciBURFggZ3Vlc3QNCj4+IGxpa2UgcGxhdGZvcm1zLCBtb3Zl
IEhMVCBhbmQgU0FGRV9ITFQgcGFyYXZpcnQgY2FsbHMgdW5kZXINCj4+IENPTkZJR19QQVJB
VklSVC4NCj4gDQo+IENvdWxkIHlvdSB1c2UgdGhlIGJsb2F0LW8tbWV0ZXIgdG8gZ2l2ZSBh
biBpZGVhIG9mIHRoZSBzYXZpbmdzPw0KPiANCj4gQWxzbyAuLiBhcmVuJ3QgbW9zdCBkaXN0
cm9zIGJ1aWxkaW5nIHdpdGggWGVuIHN1cHBvcnQgc28gdGhleSB3aWxsDQo+IGFsd2F5cyBo
YXZlIHRoZSBmdWxsIHBhcmF2aXJ0IHN1cHBvcnQ/DQoNCkFkZGluZyBQQVJBVklSVF9YWEwg
dXNlcnMgc2hvdWxkIGJlIGF2b2lkZWQgaWYgcG9zc2libGUuDQoNCk1haW4gcmVhc29uIGlz
IHRoYXQgdGhlIHdvcmsgdG8gbWFrZSBQVkggZG9tMCBmdWxseSBmdW5jdGlvbmFsIGNvbXBh
cmVkDQp0byBQViBkb20wIHdpbGwgbWFrZSBpdCBwb3NzaWJsZSB0byBkZXByZWNhdGUgUFYg
bW9kZSBpbiB0aGUgbG9uZyBydW4uDQoNCg0KSnVlcmdlbg0K
--------------jshMhZZ1nAInseKi0TepNMrO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------jshMhZZ1nAInseKi0TepNMrO--

--------------Uen3bzhHMfNu8u1d60iDkUwy--

--------------5LLYudiyGxvk0eCeMC0cD70G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfFfFcFAwAAAAAACgkQsN6d1ii/Ey+4
gwgAjrMMPRApBqvCdhGtxXLUvaKbrAWmodQYmqbOQ/crvyMlpszoJIjIfkMV7jL1OQBvz9E42wrP
gt5UqElNT/CGt/teMeWGqvX8fmR25Yy6QAInCAa788M+g3qjxnbgBNF4kdstU4ejihHuEdfCNW7f
aPudvRQk32GnVtYjLZX82MuHTHziub5ySmuuDY8AVNIVDm5f4Sj49dGDdC1WuaYl927Gc0iNCOJy
mO+nmJ++ysZHqYhCtMReG75fPLnjrRkXHERjOAOxSXm+dFMRJCp5RNF0Jvd7nd8HAdFhDxpzOP0j
QPWONYei2pGbVzafpTgjHSTnwqGxp9iIMUdmVbV0gA==
=QRkL
-----END PGP SIGNATURE-----

--------------5LLYudiyGxvk0eCeMC0cD70G--

