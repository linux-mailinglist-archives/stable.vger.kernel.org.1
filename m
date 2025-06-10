Return-Path: <stable+bounces-152254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90214AD2DA4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FC4170013
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 06:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C0926B2C4;
	Tue, 10 Jun 2025 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MlNKLTuA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1926AABE
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535243; cv=none; b=CNmxdxoQ+0navA/lGb6LY5ZwwGzXI3GcSBJkxDvgB5BFMQ84mUqmNdvkzQNc7TBXgNkUcd49tsGVfh6fDYmfklKyDCcHwdvg8bmc39m8gsjh4GiXUDXJSoVW/OOvgbqx90SMSK3aBEV87ax/d3DpH1I4zC39nnMD3PvlR+UqqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535243; c=relaxed/simple;
	bh=JJ+qKiVXU5IMhkU/LaOijUPWgU/bfAfw5pWPBlgLzOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qi3703D9IoabNY/FrRiwizts2zzsamwLXPnFijaPUhv5J1HlCUB+TSj3b5EuOFeg+U0TKl5hUYZ64HCbhtIzweL5KXCTjge+zN70dSRYn9hRRLukw4gvhRvOwRvBFga0FeSpjxEj0t6ntGMJlfbtrBwitFxN+CdTGyDa1a81PO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MlNKLTuA; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso31216345e9.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749535239; x=1750140039; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJ+qKiVXU5IMhkU/LaOijUPWgU/bfAfw5pWPBlgLzOQ=;
        b=MlNKLTuAgr736VWyHQjQhIDnoYqgv8m0yBuae2gE9Rwos5SSyIVGvQu683BWC+iYHN
         BvrpYANQW/kmd/6Mb792IAfdvkQbmFAipALRz4K0qL96SB1fdOXhCsnB56A9b/MOPDFb
         xaV/mcA8WD2yS8GOp1SJFdRIJGKPYPXdcqo9sWTqCaeKbda+kW2BNwNKWWJUswbpgJNn
         YXDnL3nOvVGzjZ0EffER/ftgq9RJ5JD9gS+amnlRCRQnTRIN8SD3eqhrv9apP3SBIONR
         LatgWAlUVTnf1kFJItL+bXkS0hy3u5n030Qck4mQ/hWCFEToVkK3BFYjtFMM8dyeAqhR
         VpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749535239; x=1750140039;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ+qKiVXU5IMhkU/LaOijUPWgU/bfAfw5pWPBlgLzOQ=;
        b=fivDLTv9sKjciDZJRP2FQ2yzlTGu+IXJ+OYgYD7s86/cXtUeXYhyYrcDsHw64D2XGq
         lej0J1dmx8ljBF/CtFhX36BmY9YEb4+YmOO8tXkRNaF7WevyT5SI5lf33+gIC2JwEfaH
         y5uf3cbEeGOUmuvV51Q0F3hj+AjKX6tshmIXx0myM0ppm4P95yCLap252mUE1jIwCCAy
         f005nfkCOuEQ31ALJ4DAKPU3S3S3nekBbEH9SLb8Oi7DfeLY5khLVCdARXSaFYH7sLpk
         uVdNFn7yFlebaJ4mcZOS+DbQhq0HKt/YwV9ExcQZvC7WAqNyDBtGxJtGrWlDV4orOUfA
         qwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CzDBDCGJx/sOTlk2StLNmzP6hFnIQRAOy6bmDnk+3klQr/SJLgkf/uHqsMnKaM6kwj8Ywjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawLV9FWjXM7EetSAM3yT4txshlGsaujrmqY7S/KddsmrJOoLu
	Ntf3yk0UQnFq8s9jDitaPctJ7qUUv0j3ggWLaa/5F2RyVuKxDsN6+bmq0MM2Cb0fOGA=
X-Gm-Gg: ASbGncsS/oURtHExtghC+0dv4CT9JXyCNLJScMa3v2lCMlynG2BqPSZLXbx9txjP0hY
	kd7QAEqUgUcxGXES8UzxxcSfPDBvUZ8nOf87+wDW8wJZhI6xXqRV7ORY7zU9IRfD6JPue9Zy/uJ
	sv5D3boHVFH5Zoz1LgxqCY8uHWaDgzvjs/cF5KVHOnodJ36J9IF7ixGdDOMIOAa+daOat/oiaPj
	yxR4dDLtj1qd+orujP77ZMhOsZ4IP1JQ6t9QgJl770uw/el9YlLHH3yLZfZqojtVDSTEDAAlCpv
	DZNrbP8Fac0BQMWev7DVgFMK+s/f6ZnE4SMbNqVB9J5stoadPHKvXX2SgELdC5zAxmspCJMby0F
	YhI+cchS9Tx0/+2bLZDn3uhuDYPGqGBwkUqkvX3pSXmlG2k6JTtdL6veGS1xU/z4/ixAe4i4T5t
	rvR7qh8hkhZ3A=
X-Google-Smtp-Source: AGHT+IHjhPfsIcOkVJQeo++ZHTbA1o6kyQSd3uIm3TiCnB+m1r7ng+POZDgVhOy5YMvH9h8NuOkXkQ==
X-Received: by 2002:a05:600c:1e8a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-452014976b1mr129051725e9.21.1749535239047;
        Mon, 09 Jun 2025 23:00:39 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45306f76ab3sm82030845e9.14.2025.06.09.23.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 23:00:38 -0700 (PDT)
Message-ID: <3faedf73-208b-4d16-9c4e-44eadafb9958@suse.com>
Date: Tue, 10 Jun 2025 08:00:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fixes for ITS mitigation and execmem
To: Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, x86@kernel.org
References: <20250603111446.2609381-1-rppt@kernel.org>
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
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0shMrVeaf0yKBkiqGl3K1GBb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0shMrVeaf0yKBkiqGl3K1GBb
Content-Type: multipart/mixed; boundary="------------CS9m6xhR40MKFBJo7e4eJ52X";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, x86@kernel.org
Message-ID: <3faedf73-208b-4d16-9c4e-44eadafb9958@suse.com>
Subject: Re: [PATCH 0/5] Fixes for ITS mitigation and execmem
References: <20250603111446.2609381-1-rppt@kernel.org>
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>

--------------CS9m6xhR40MKFBJo7e4eJ52X
Content-Type: multipart/mixed; boundary="------------AsVf9foF6r09upoD5r4BhU7P"

--------------AsVf9foF6r09upoD5r4BhU7P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDYuMjUgMTM6MTQsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IEZyb206ICJNaWtl
IFJhcG9wb3J0IChNaWNyb3NvZnQpIiA8cnBwdEBrZXJuZWwub3JnPg0KPiANCj4gSGksDQo+
IA0KPiBKw7xyZ2VuIEdyb8OfIHJlcG9ydGVkIHNvbWUgYnVncyBpbiBpbnRlcmFjdGlvbiBv
ZiBJVFMgbWl0aWdhdGlvbiB3aXRoDQo+IGV4ZWNtZW0gWzFdIHdoZW4gcnVubmluZyBvbiBh
IFhlbiBQViBndWVzdC4NCj4gDQo+IFRoZXNlIHBhdGNoZXMgZml4IHRoZSBpc3N1ZSBieSBt
b3ZpbmcgYWxsIHRoZSBwZXJtaXNzaW9ucyBtYW5hZ2VtZW50IG9mDQo+IElUUyBtZW1vcnkg
YWxsb2NhdGVkIGZyb20gZXhlY21lbSBpbnRvIElUUyBjb2RlLg0KPiANCj4gSSBkaWRuJ3Qg
dGVzdCBvbiBhIHJlYWwgWGVuIFBWIGd1ZXN0LCBidXQgSSBlbXVsYXRlZCAhUFNFIHZhcmlh
bnQgYnkNCj4gZm9yY2UtZGlzYWJsaW5nIHRoZSBST1ggY2FjaGUgaW4geDg2OjpleGVjbWVt
X2FyY2hfc2V0dXAoKS4NCj4gDQo+IFBldGVyLCBJIHRvb2sgbGliZXJ0eSB0byBwdXQgeW91
ciBTb0IgaW4gdGhlIHBhdGNoIHRoYXQgYWN0dWFsbHkNCj4gaW1wbGVtZW50cyB0aGUgZXhl
Y21lbSBwZXJtaXNzaW9ucyBtYW5hZ2VtZW50IGluIElUUywgcGxlYXNlIGxldCBtZSBrbm93
DQo+IGlmIEkgbmVlZCB0byB1cGRhdGUgc29tZXRoaW5nIGFib3V0IHRoZSBhdXRob3JzaGlw
Lg0KPiANCj4gVGhlIHBhdGNoZXMgYXJlIGFnYWluc3QgdjYuMTUuDQo+IFRoZXkgYXJlIGFs
c28gYXZhaWxhYmxlIGluIGdpdDoNCj4gaHR0cHM6Ly93ZWIuZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3JwcHQvbGludXguZ2l0L2xvZy8/aD1pdHMtZXhlY21l
bS92MQ0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDUyODEy
MzU1Ny4xMjg0Ny0yLWpncm9zc0BzdXNlLmNvbS8NCj4gDQo+IEp1ZXJnZW4gR3Jvc3MgKDEp
Og0KPiAgICB4ODYvbW0vcGF0OiBkb24ndCBjb2xsYXBzZSBwYWdlcyB3aXRob3V0IFBTRSBz
ZXQNCj4gDQo+IE1pa2UgUmFwb3BvcnQgKE1pY3Jvc29mdCkgKDMpOg0KPiAgICB4ODYvS2Nv
bmZpZzogb25seSBlbmFibGUgUk9YIGNhY2hlIGluIGV4ZWNtZW0gd2hlbiBTVFJJQ1RfTU9E
VUxFX1JXWCBpcyBzZXQNCj4gICAgeDg2L2l0czogbW92ZSBpdHNfcGFnZXMgYXJyYXkgdG8g
c3RydWN0IG1vZF9hcmNoX3NwZWNpZmljDQo+ICAgIFJldmVydCAibW0vZXhlY21lbTogVW5p
ZnkgZWFybHkgZXhlY21lbV9jYWNoZSBiZWhhdmlvdXIiDQo+IA0KPiBQZXRlciBaaWpsc3Ry
YSAoSW50ZWwpICgxKToNCj4gICAgeDg2L2l0czogZXhwbGljaXRseSBtYW5hZ2UgcGVybWlz
c2lvbnMgZm9yIElUUyBwYWdlcw0KPiANCj4gICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAg
ICAgICB8ICAyICstDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbW9kdWxlLmggfCAgOCAr
KysrDQo+ICAgYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMgfCA4OSArKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIGFyY2gveDg2L21tL2luaXRfMzIuYyAg
ICAgICAgIHwgIDMgLS0NCj4gICBhcmNoL3g4Ni9tbS9pbml0XzY0LmMgICAgICAgICB8ICAz
IC0tDQo+ICAgYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYyAgfCAgMyArKw0KPiAgIGlu
Y2x1ZGUvbGludXgvZXhlY21lbS5oICAgICAgIHwgIDggKy0tLQ0KPiAgIGluY2x1ZGUvbGlu
dXgvbW9kdWxlLmggICAgICAgIHwgIDUgLS0NCj4gICBtbS9leGVjbWVtLmMgICAgICAgICAg
ICAgICAgICB8IDQwICsrLS0tLS0tLS0tLS0tLS0NCj4gICA5IGZpbGVzIGNoYW5nZWQsIDgy
IGluc2VydGlvbnMoKyksIDc5IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0
OiAwZmY0MWRmMWNiMjY4ZmM2OWU3MDNhMDhhNTdlZTE0YWU5NjdkMGNhDQoNCkkgaGF2ZSB0
ZXN0ZWQgdGhpcyBzZXJpZXMgdG8gd29yayBpbiBhIFhlbiBQViBkb20wIHdpdGggSVRTIG1p
dGlnYXRpb24NCmJlaW5nIGFjdGl2ZS4gSSBkaWRuJ3QgYXBwbHkgYW55IG9mIFBldGVyJ3Mg
c3VnZ2VzdGVkIGFkZC1vbnMuDQoNClRlc3RlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3Nz
QHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------AsVf9foF6r09upoD5r4BhU7P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------AsVf9foF6r09upoD5r4BhU7P--

--------------CS9m6xhR40MKFBJo7e4eJ52X--

--------------0shMrVeaf0yKBkiqGl3K1GBb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmhHygUFAwAAAAAACgkQsN6d1ii/Ey8d
1AgAmbglfnWRP4XATxgqyzcJ1vxx5q+VeXTDLuV8UeNXg/hgRrV1cpuIRcNH3XjV5enGdXE1sEjz
F1n5O4KnHTBtzaJKH0lI29jDyrI1cf+V7SWavVHDYk9SdxqNayyKU6VCQvokYXF+163eC37KNB+9
cVA9f3ArFIzFWCWvccG0fQ2hpYak0VyyTGGrbiGUSt8ngIRbkRcxLOlg35vjldSn+KsWQlUlYz8o
jDX2UBb+5whXVTssr68RdnoErS5ykQ+GBxXGTSBoeLg1uQYWBjzcMYdWWVd18rePpl6x/Y39jELE
5MfnzXH+3lkWQ7ZDU9+yII21dBEm80+U9HoxZ+Sphw==
=qDha
-----END PGP SIGNATURE-----

--------------0shMrVeaf0yKBkiqGl3K1GBb--

