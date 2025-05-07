Return-Path: <stable+bounces-142011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D587FAADB72
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C28E1BA88E2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC11F4CA6;
	Wed,  7 May 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LopYLVMK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C94B1E78
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610075; cv=none; b=Gr47AvGDyCbLqsJAt6XKW1a9btx/w7s35vsTtqM8rjd9r+ciFeAx1s1T6Hj9pPjX7fBEUCzQRQNYNeuQAlJd4sSoXkMdgeTYoVvJYqpuqRk+Ywf3eJ3nQZ/96bxNFtngwOIX6+eFNSyigmpowSOGNIR8xrRhRh7Xxkpn1m8+ROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610075; c=relaxed/simple;
	bh=/7Rxas92BPow8CCQK6Akkp9y9PbzBCNbZtrPFFZNBRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1oYQST0JHh7pejddS+ZHtjMHYYR8gbgP0UHEV5ftp5dpg8QOFV1P6Msz4SCOOrlSCJGrumb/roDKuX/fc2BW1nM74wKnNAmvbAXrMz0BnB/hjxezuSLll1KiSJBGx3B2LugtD3nS0RaKot4WIjphsQ4KkwsXi+beRVNEiSeQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LopYLVMK; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so37890825e9.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746610071; x=1747214871; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7Rxas92BPow8CCQK6Akkp9y9PbzBCNbZtrPFFZNBRw=;
        b=LopYLVMK4jbq7v0AQHBmf0rBCIL17ElKjfJLWK7ZZednEA8SnrUWG3NmZckSxhz8AZ
         dSTioXiuRF0DJNsU/IFqr3cPWNvLmQ8Ewzet5wwMkkAqK5CkOU1zkWHKx9D2BoIz8Tq6
         wLDvhCaTmvT3OcE+4yxontUkHalFNWQWXdpAZb2IituXQD0HBuqLjVAfl8QADY8BeffZ
         V9Wd9pKInrQoYM5SkjOqiO9YSJzKyv8nbFjG+qxGnFkl/H+cdjpILXr8joMkuCturxbT
         /fxf903OhmeJMBEyop/2OpGmHa7QL16EBGH4mqpVCCR3JfMhwkFRsbqqLGKi4UAnHHiM
         ILog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746610071; x=1747214871;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7Rxas92BPow8CCQK6Akkp9y9PbzBCNbZtrPFFZNBRw=;
        b=kkvToV6coPBUXW4g4ZqmydjMuFEFhOaHHuH3U1i8V6y+aTz4ERpPE7Il/Sw/BfSIZC
         xkQ4/8LkNiDo9NU3OpybGeuOV57FosFi/5zsY94q3MoDmYUknlo2W/dErc/OODaaygqU
         4PBGMHYswVcMUobhOqRghlaehE6gHsAG0xwW8Az9t7u8qb9sY4GHPvOx5SoVds0sYKr2
         mmzm3kF6Z+qZR8X8W6MNa988EPEw72Vs4uuOkPgTM8pIi73fjEaZRwOkQZlsO8QH9Xj+
         e98/OeFo0mJAeRWqMVpOfEJEqOAPjbJQEoNYGcofY9xEAj4aSwhlTUKs2k4PexckDoRX
         Ms+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDuErbtZomJkInuRegWgCyPVeLLN6m/iU7aVJn1TyEIZPR94GBu/0ZnY3WrAVsGeNz+itw1k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywrU4ZIXWFBTe3Tr9b2t9QsEn7sG5xoguhs/zy9L3uBB2bGvyv
	5imD2dGonZGiYtX7531IuwWGBgQy+qaZpdYUx9ETTdEV6ccXGMsMVRTFLVSeUkk=
X-Gm-Gg: ASbGncuO6Jlb+CrfRcV0PIWKqc4YpNr3aBJTJZ8UnQdG0IcU/3fD/43ftg37BnysToS
	m2ecHn/CTHBiWcr0Ichl6ycq9hdGgPIPfDboLDlxh9mCw6/mC1n3qofV8mYq1iwxpqCPvVs49mF
	AmZbE5rES3TS6a8mBml/pJEmMrxyQhPG9SH6N7HOIPrfPU1StHltPhpsNFK+t/VZZ0A1YEMaJ2I
	m7DTm4ldPWHhtO14fVjS9YOFcrlrgKp30ShbD7EuxC0ycLQOQwOsayrBbPzjHPYKo5AUtHxve4N
	F3/Kel8x2G66andj80iWiLFs2kUtQq2Addmm6xe8dD/cWWFpTaE43zjQ06WZ8t5nzAzboDkNliB
	FLzYhlmWKHB9C0UqnMVJTklWm5oVpRzQVMONp6m0PzrOHxY7XPC/HFEEEqsQg/K8cSQ==
X-Google-Smtp-Source: AGHT+IEO2XwDKF9o6Oc090Xz7Bur9+xTqXH0/t3wjlLvKXCABgqDGrh0wv0zPNgyrnZs2uoTBApJ4w==
X-Received: by 2002:a05:600c:8509:b0:43d:7413:cb3f with SMTP id 5b1f17b1804b1-441d44bb42fmr20812755e9.5.1746610070651;
        Wed, 07 May 2025 02:27:50 -0700 (PDT)
Received: from ?IPV6:2003:e5:870f:e000:6c64:75fd:2c51:3fef? (p200300e5870fe0006c6475fd2c513fef.dip0.t-ipconnect.de. [2003:e5:870f:e000:6c64:75fd:2c51:3fef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4346610sm25539295e9.12.2025.05.07.02.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 02:27:50 -0700 (PDT)
Message-ID: <6b17cb41-a4f1-4055-966a-54301493085c@suse.com>
Date: Wed, 7 May 2025 11:27:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xenbus: Use kref to track req lifetime
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250506210935.5607-1-jason.andryuk@amd.com>
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
In-Reply-To: <20250506210935.5607-1-jason.andryuk@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BYVYvOo0duQSKcgQ58Xfi0h7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BYVYvOo0duQSKcgQ58Xfi0h7
Content-Type: multipart/mixed; boundary="------------uH2EgFtkE3tRqY5rjAkv0UyF";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <6b17cb41-a4f1-4055-966a-54301493085c@suse.com>
Subject: Re: [PATCH] xenbus: Use kref to track req lifetime
References: <20250506210935.5607-1-jason.andryuk@amd.com>
In-Reply-To: <20250506210935.5607-1-jason.andryuk@amd.com>

--------------uH2EgFtkE3tRqY5rjAkv0UyF
Content-Type: multipart/mixed; boundary="------------QBRdb9fKfSWP8XEJG0WYgM7B"

--------------QBRdb9fKfSWP8XEJG0WYgM7B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDUuMjUgMjM6MDksIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IE1hcmVrIHJlcG9y
dGVkIHNlZWluZyBhIE5VTEwgcG9pbnRlciBmYXVsdCBpbiB0aGUgeGVuYnVzX3RocmVhZA0K
PiBjYWxsc3RhY2s6DQo+IEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwg
YWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMA0KPiBSSVA6IGUwMzA6X193YWtlX3VwX2NvbW1v
bisweDRjLzB4MTgwDQo+IENhbGwgVHJhY2U6DQo+ICAgPFRBU0s+DQo+ICAgX193YWtlX3Vw
X2NvbW1vbl9sb2NrKzB4ODIvMHhkMA0KPiAgIHByb2Nlc3NfbXNnKzB4MThlLzB4MmYwDQo+
ICAgeGVuYnVzX3RocmVhZCsweDE2NS8weDFjMA0KPiANCj4gcHJvY2Vzc19tc2crMHgxOGUg
aXMgcmVxLT5jYihyZXEpLiAgcmVxLT5jYiBpcyBzZXQgdG8geHNfd2FrZV91cCgpLCBhDQo+
IHRoaW4gd3JhcHBlciBhcm91bmQgd2FrZV91cCgpLCBvciB4ZW5idXNfZGV2X3F1ZXVlX3Jl
cGx5KCkuICBJdCBzZWVtcw0KPiBsaWtlIGl0IHdhcyB4c193YWtlX3VwKCkgaW4gdGhpcyBj
YXNlLg0KPiANCj4gSXQgc2VlbXMgbGlrZSByZXEgbWF5IGhhdmUgd29rZW4gdXAgdGhlIHhz
X3dhaXRfZm9yX3JlcGx5KCksIHdoaWNoDQo+IGtmcmVlKCllZCB0aGUgcmVxLiAgV2hlbiB4
ZW5idXNfdGhyZWFkIHJlc3VtZXMsIGl0IGZhdWx0cyBvbiB0aGUgemVyby1lZA0KPiBkYXRh
Lg0KPiANCj4gTGludXggRGV2aWNlIERyaXZlcnMgMm5kIGVkaXRpb24gc3RhdGVzOg0KPiAi
Tm9ybWFsbHksIGEgd2FrZV91cCBjYWxsIGNhbiBjYXVzZSBhbiBpbW1lZGlhdGUgcmVzY2hl
ZHVsZSB0byBoYXBwZW4sDQo+IG1lYW5pbmcgdGhhdCBvdGhlciBwcm9jZXNzZXMgbWlnaHQg
cnVuIGJlZm9yZSB3YWtlX3VwIHJldHVybnMuIg0KPiAuLi4gd2hpY2ggd291bGQgbWF0Y2gg
dGhlIGJlaGF2aW91ciBvYnNlcnZlZC4NCj4gDQo+IENoYW5nZSB0byBrZWVwaW5nIHR3byBr
cmVmcyBvbiBlYWNoIHJlcXVlc3QuICBPbmUgZm9yIHRoZSBjYWxsZXIsIGFuZA0KPiBvbmUg
Zm9yIHhlbmJ1c190aHJlYWQuICBFYWNoIHdpbGwga3JlZl9wdXQoKSB3aGVuIGZpbmlzaGVk
LCBhbmQgdGhlIGxhc3QNCj4gd2lsbCBmcmVlIGl0Lg0KPiANCj4gVGhpcyB1c2Ugb2Yga3Jl
ZiBtYXRjaGVzIHRoZSBkZXNjcmlwdGlvbiBpbg0KPiBEb2N1bWVudGF0aW9uL2NvcmUtYXBp
L2tyZWYucnN0DQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy94ZW4tZGV2
ZWwvWk8wV3JSNUoweHV3REl4V0BtYWlsLWl0bC8NCj4gUmVwb3J0ZWQtYnk6ICJNYXJlayBN
YXJjenlrb3dza2ktR8OzcmVja2kiIDxtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIuY29t
Pg0KPiBGaXhlczogZmQ4YWE5MDk1YTk1ICgieGVuOiBvcHRpbWl6ZSB4ZW5idXMgZHJpdmVy
IGZvciBtdWx0aXBsZSBjb25jdXJyZW50IHhlbnN0b3JlIGFjY2Vzc2VzIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQW5kcnl1ayA8
amFzb24uYW5kcnl1a0BhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8
amdyb3NzQHN1c2UuY29tPg0KDQo+IC0tLQ0KPiBLaW5kYSBSRkMtaXNoIGFzIEkgZG9uJ3Qg
a25vdyBpZiBpdCBmaXhlcyBNYXJlaydzIGlzc3VlLiAgVGhpcyBkb2VzIHNlZW0NCj4gbGlr
ZSB0aGUgY29ycmVjdCBhcHByb2FjaCBpZiB3ZSBhcmUgc2VlaW5nIHJlcSBmcmVlKCllZCBv
dXQgZnJvbSB1bmRlcg0KPiB4ZW5idXNfdGhyZWFkLg0KDQpJIHRoaW5rIHlvdXIgYW5hbHlz
aXMgaXMgY29ycmVjdC4gV2hlbiB3cml0aW5nIHRoaXMgY29kZSBJIGRpZG4ndCB0aGluaw0K
b2Ygd2FrZV91cCgpIG5lZWRpbmcgdG8gYWNjZXNzIHJlcS0+d3EgX2FmdGVyXyBoYXZpbmcg
d29rZW4gdXAgdGhlIHdhaXRlci4NCg0KDQpKdWVyZ2VuDQo=
--------------QBRdb9fKfSWP8XEJG0WYgM7B
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------QBRdb9fKfSWP8XEJG0WYgM7B--

--------------uH2EgFtkE3tRqY5rjAkv0UyF--

--------------BYVYvOo0duQSKcgQ58Xfi0h7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgbJ5UFAwAAAAAACgkQsN6d1ii/Ey9I
1AgAlSB2VBehdIvGVZwVJ1pjADKMNLEnQOBTsZTaQqS4qDUT8Cg/XrYx1rMorabHC7BlwK2bIqay
vQI0ztjYwRUf0qqFaFLb9PkbL6NtBa8Tpl3f/xzgmHHq2OuFNt5t1g9OSsBIEuhZ4TeqDosF6Fb2
BAq620NC7wRFwsbO6bRydv5kWknf5w8HZb0kQsiTEIlgpVMJyNrj51aBnvCMQUyC35tREy2nwx6W
wZhaQntVX8tprB1BM9EVsliOJnrIiXTovw3qkFgoElnWEB1jWRpdu+ZGTz198N59lq6r3AZ6nY6g
5X9eWV/FPsn4INGDSi02UyFVAzOgNvfLtxkDP/JILg==
=eyAD
-----END PGP SIGNATURE-----

--------------BYVYvOo0duQSKcgQ58Xfi0h7--

