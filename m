Return-Path: <stable+bounces-125727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60263A6B232
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0846019C470D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7E1EA84;
	Fri, 21 Mar 2025 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ULfE02wD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581466DCE1;
	Fri, 21 Mar 2025 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516329; cv=none; b=p3YKUCwvn+V7b0uSOfp4JFOUIF2JCkPSatenmnNH0QpWAAdLtr8ZK3Pl8S/fF3lq48nLQWEAEIBNy3WBd9fEhsgKe3MQEq3oBP8pFK85IPUmfSLhYGIfCBCQSnFtBK5AqhspzaR3Tvfk0hrMQq6ziEepGn4/VPX0AkEbLIQ91Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516329; c=relaxed/simple;
	bh=G+KCr6b9iBYvUh+Gs9chBaKMdu9TpyJ7FtKvEVhxKaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W3LkPd4G/af6WewLaBYn+p+40+snsWKvSOrtQ1neTp4ubHv/4lzZdyU46GHWvZlElCLZPmRS56UnVax9Q6IpYBwHdHBtl17ONxvFibOlyRpr5PcmkqZzlqJ25TEQ3wHpz6qKf/Qkx1aG1zkgkFHkER4oGVWBuAcqAUTxlXujBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ULfE02wD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so15045935e9.3;
        Thu, 20 Mar 2025 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742516324; x=1743121124; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+KCr6b9iBYvUh+Gs9chBaKMdu9TpyJ7FtKvEVhxKaA=;
        b=ULfE02wDYdQ2ti2eiIW6OxOsfmM0rgoQyASRWdvyfP9U+Zt+cL1KKU9M7U5r3ueti0
         BoLgIEWmCIVmaoZI7eDJn9FqxQYX6rE9rJcD7M3x3d87P86RtGG4/hexuB7vV2/y+bTu
         4psTl17e0xDChN5J8BVof7LonUEaUsdhwP87zh+UUCmeuT+eiLYiQVv2ijyEpSLzvpnd
         h7696vVo7wftlu0OZbVSgAhrxTykSrv+lTAHaLgVIK0CUyBZLqIcUJksav1l8tvLnNA5
         XmBa+IF+Onfe48ueCiYQ+yXc2tMzJ4A75I+/6Gsesm7UHO+rDD/T2irgS39tFrfGqMMn
         GlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516324; x=1743121124;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+KCr6b9iBYvUh+Gs9chBaKMdu9TpyJ7FtKvEVhxKaA=;
        b=Az8zUM6ThI9ow9/zsUca5/gXc0kkx6nOKTIvvVVvVJbYIKikA97Fg1Gv/4r28wcixL
         m44ds+Da7msmGh3rThkseILfmu6490XGp0FehEGKEL8lXM1Eb75NXR7RRA6mUCTyL6mo
         NRwA/03quBVnGISW+GkFe14eeppLfHff922HvFTh5xv+8TwLdzsxV5LnUpJWO/JHi7Oj
         tNFZWDFXaAIR9xOJ4gsT2GBG5MEARq2T7CG4/ZX9zhmzabSlnyg1qLAizkCmHNQVE0m7
         J7lmik5HK43hwhHh6FJ4eJG/LpG4SF1HZbVLq/HJLmnVyy8jJGhmH/88XnIHSRNkgE8Q
         z22A==
X-Forwarded-Encrypted: i=1; AJvYcCU6XBlZm5kU2X0f/ftpD+mwDKSZEwBa8SNlIyFZZo89cZ+O3EvVa/UkREwOstSjcY+ya+4o9qvDtOWMZlM=@vger.kernel.org, AJvYcCXILQGY7OnU38k6tcSWyFBbaCjSaQVXXYpzcXiTpKeXJQN/lNgWBH9zezhgce/pmfRchNxMhFtV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Zwx0AESSXQrzZqVv2QRw5KmvmHbb0ZARyknEnai277fG2cLQ
	jLPFw/XoKqYcFh9xyKktd4o2qjYj4eEJPhYoWngNC2tbbSp5oxw=
X-Gm-Gg: ASbGncuw9zPg1+xNzJ1XVymj8Q65UUWDp2mNK6BUzwSDJgMBnax9BpVg2bl8jNikcOn
	XLK5U3T+Hd/Yh43WKnqmEl8nbnEAMQrDQY+6ilbYHQHtUzITgfj/UMqJL4QJLAz+UlrrJQ8V7K6
	JASc6sh8yjk7H2iKT0UVdZwJ4lBy18MLKcDUhMvhfhYkFU/apVsNOOzaKVLHz1UREqT0znnSTZR
	0UTFCb8/EvPED1I270plOmYWjdUVw7GUM7cy++Hz3EaV7JDL4NH62CTtLYGTXFalWEoqbgykM0f
	Y1ieowE5KuaMDIN/1buSmP5xWyvtpvXyphR/P9tg/RGk05mg6xVZbOaUAL0qXU/tIQuVPy5tWiv
	rk2oh/IWmPmhVSOmgiBoiWQ==
X-Google-Smtp-Source: AGHT+IGNrgOeZ6prDJ/LUfmohnbZfxxbDYqiCf7c4GSiOpDEYR+DR8SIaEQUs8baleySKzWiGy1Irw==
X-Received: by 2002:a05:600c:3489:b0:43c:efae:a73 with SMTP id 5b1f17b1804b1-43d509ea0f8mr10195015e9.10.1742516324260;
        Thu, 20 Mar 2025 17:18:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b0579be.dip0.t-ipconnect.de. [91.5.121.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d7c6a5sm62892405e9.0.2025.03.20.17.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:18:42 -0700 (PDT)
Message-ID: <a883c829-17c0-446f-8c24-16208f29d878@googlemail.com>
Date: Fri, 21 Mar 2025 01:18:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170447.729440535@linuxfoundation.org>
 <03cc622d-3a64-4e3d-baaf-8628f1bf9811@googlemail.com>
Autocrypt: addr=pschneider1968@googlemail.com; keydata=
 xjMEY58biBYJKwYBBAHaRw8BAQdADPnoGTrfCUCyH7SZVkFtnlzsFpeKANckofR4WVLMtMzN
 L1BldGVyIFNjaG5laWRlciA8cHNjaG5laWRlcjE5NjhAZ29vZ2xlbWFpbC5jb20+wpwEExYK
 AEQCGyMFCQW15qgFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSjgovXlszhGoyt6IZu
 OpLJLD/yRAUCY58b8AIZAQAKCRBuOpLJLD/yRIeIAQD0+/LMdKHM6AJdPCt+e9Z92BMybfnN
 RtGqkdZWtvdhDQD9FJkGh/3PFtDinimB8UOB7Gi6AGxt9Nu9ne7PvHa0KQXOOARjnxuIEgor
 BgEEAZdVAQUBAQdAw2GRwTf5HJlO6CCigzqH6GUKOjqR1xJ+3nR5EbBze0sDAQgHwn4EGBYK
 ACYWIQSjgovXlszhGoyt6IZuOpLJLD/yRAUCY58biAIbDAUJBbXmqAAKCRBuOpLJLD/yRONS
 AQCwB9qiEQoSnxHodu8kRuvUxXKIqN7701W+INXtFGtJygEAyPZH3/vSBJ4A7GUG7BZyQRcr
 ryS0CUq77B7ZkcI1Nwo=
In-Reply-To: <03cc622d-3a64-4e3d-baaf-8628f1bf9811@googlemail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LmutZqYMPJAdacN31cVTaI9D"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LmutZqYMPJAdacN31cVTaI9D
Content-Type: multipart/mixed; boundary="------------X0Sk1X9zQ02Juz6hiReCtefK";
 protected-headers="v1"
From: Peter Schneider <pschneider1968@googlemail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Message-ID: <a883c829-17c0-446f-8c24-16208f29d878@googlemail.com>
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
References: <20250310170447.729440535@linuxfoundation.org>
 <03cc622d-3a64-4e3d-baaf-8628f1bf9811@googlemail.com>
In-Reply-To: <03cc622d-3a64-4e3d-baaf-8628f1bf9811@googlemail.com>

--------------X0Sk1X9zQ02Juz6hiReCtefK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29ycnksIHBsZWFzZSBkaXNyZWdhcmQgbXkgbWFpbC4gSSBhY2NpZGVudGFsbHkgcmVwbGll
ZCB0byB0aGUgd3JvbmcsIG9sZGVyIHRocmVhZC4gSSANCm1lYW50IHRvIHJlcGx5IHRvIHRo
ZSA2LjEzLXJjOCByZXZpZXcgdGhyZWFkLiBNeSBiYWQuLi4g8J+ZhA0KDQpCZXN0ZSBHcsO8
w59lLA0KUGV0ZXIgU2NobmVpZGVyDQoNCi0tIA0KQ2xpbWIgdGhlIG1vdW50YWluIG5vdCB0
byBwbGFudCB5b3VyIGZsYWcsIGJ1dCB0byBlbWJyYWNlIHRoZSBjaGFsbGVuZ2UsDQplbmpv
eSB0aGUgYWlyIGFuZCBiZWhvbGQgdGhlIHZpZXcuIENsaW1iIGl0IHNvIHlvdSBjYW4gc2Vl
IHRoZSB3b3JsZCwNCm5vdCBzbyB0aGUgd29ybGQgY2FuIHNlZSB5b3UuICAgICAgICAgICAg
ICAgICAgICAtLSBEYXZpZCBNY0N1bGxvdWdoIEpyLg0KDQpQZXRlciBTY2huZWlkZXINClTD
tmx6ZXIgU3RyLiAxDQpELTgyNTQ5IEvDtm5pZ3Nkb3JmDQoNCk9wZW5QR1A6ICAweEEzODI4
QkQ3OTZDQ0UxMUE4Q0FERTg4NjZFM0E5MkM5MkMzRkYyNDQNCkRvd25sb2FkOiBodHRwczov
L3d3dy5wZXRlcnMtbmV0enBsYXR6LmRlL2Rvd25sb2FkL3BzY2huZWlkZXIxOTY4X3B1Yi5h
c2MNCmh0dHBzOi8va2V5cy5tYWlsdmVsb3BlLmNvbS9wa3MvbG9va3VwP29wPWdldCZzZWFy
Y2g9cHNjaG5laWRlcjE5NjhAZ29vZ2xlbWFpbC5jb20NCmh0dHBzOi8va2V5cy5tYWlsdmVs
b3BlLmNvbS9wa3MvbG9va3VwP29wPWdldCZzZWFyY2g9cHNjaG5laWRlcjE5NjhAZ21haWwu
Y29tDQoNCk06IHBzY2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tDQpNOiBwc2NobmVpZGVy
MTk2OEBnbWFpbC5jb20NClA6ICs0OSA4MTc5IDkyOTE2NA0KUDogKzQ5IDE3MSA0NTY4NjM3
DQpGOiArNDkgODE3OSA5OTc2ODAwDQoNCkFtIDIxLjAzLjIwMjUgdW0gMDE6MTUgc2Nocmll
YiBQZXRlciBTY2huZWlkZXI6DQo+IEFtIDEwLjAzLjIwMjUgdW0gMTg6MDMgc2NocmllYiBH
cmVnIEtyb2FoLUhhcnRtYW46DQo+PiBUaGlzIGlzIHRoZSBzdGFydCBvZiB0aGUgc3RhYmxl
IHJldmlldyBjeWNsZSBmb3IgdGhlIDYuMTMuNyByZWxlYXNlLg0KPj4gVGhlcmUgYXJlIDIw
NyBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBhbGwgd2lsbCBiZSBwb3N0ZWQgYXMgYSByZXNw
b25zZQ0KPj4gdG8gdGhpcyBvbmUuwqAgSWYgYW55b25lIGhhcyBhbnkgaXNzdWVzIHdpdGgg
dGhlc2UgYmVpbmcgYXBwbGllZCwgcGxlYXNlDQo+PiBsZXQgbWUga25vdy4NCj4gDQo+IEJ1
aWxkcywgYm9vdHMgYW5kIHdvcmtzIG9uIG15IDItc29ja2V0IEl2eSBCcmlkZ2UgWGVvbiBF
NS0yNjk3IHYyIHNlcnZlci4gTm8gZG1lc2cgDQo+IG9kZGl0aWVzIG9yIHJlZ3Jlc3Npb25z
IGZvdW5kLg0KPiANCj4gVGVzdGVkLWJ5OiBQZXRlciBTY2huZWlkZXIgPHBzY2huZWlkZXIx
OTY4QGdvb2dsZW1haWwuY29tPg0KPiANCj4gDQo+IEJlc3RlIEdyw7zDn2UsDQo+IFBldGVy
IFNjaG5laWRlcg0KPiANCg0K

--------------X0Sk1X9zQ02Juz6hiReCtefK--

--------------LmutZqYMPJAdacN31cVTaI9D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSjgovXlszhGoyt6IZuOpLJLD/yRAUCZ9ywYQUDAAAAAAAKCRBuOpLJLD/yRFuK
AP475KrkEheOP10STaM2YuBQ6YGorvpuQMoiC46uquApyAD/QB3R08BQbawD0uXFS5zyUg9zlfSz
4594NDLRvIuJ1w8=
=RP3s
-----END PGP SIGNATURE-----

--------------LmutZqYMPJAdacN31cVTaI9D--

