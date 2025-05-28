Return-Path: <stable+bounces-147995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEDAC70CE
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07837B1CA3
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4A28DF50;
	Wed, 28 May 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WqqAoPNS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BE28A415
	for <stable@vger.kernel.org>; Wed, 28 May 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456534; cv=none; b=tbqznaceVSkqec51nCahSpAyU22joJ9/i9U5GwTyUCaUBmO/M9Ga8VLuZLKXdEw7YRPQp4zuTKuRoPMs9FROVSZorMbe32KhbZotHQOXw9Gnns8evdO1L5zJqsF0sY/m6UZHvtI7A8BfDpQe2+LxC0Uuwo0ne4LyVkqGnUGOvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456534; c=relaxed/simple;
	bh=g9Uij2wLtuQhXOCGoStG5OmI/vXOT+cSxhUXvGV0hlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMvg6NCVN0lQVV4YtIf350+ZzLMJ9uriGCAQ6H9XhqFO9sQupehcIZlOH1+4DIuiKLFQaNbes718R/8eH9zjasurYuER4yO/Jz+YMMUOfdeWdNRnGBHMrf8W+GzZEHGCJLvVOWTsthLLNjDvt+oLF0BkQlRPZECrwEVNtRn7NPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WqqAoPNS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a375888297so110512f8f.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748456530; x=1749061330; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9Uij2wLtuQhXOCGoStG5OmI/vXOT+cSxhUXvGV0hlc=;
        b=WqqAoPNSNxuAR3PqT4ij7Cq3MillF4T50EfpA5J4dOzAq33++n5/3sal6ZZZ5DeVqL
         zb/s9Tmf1X7riSw2/yzvnZKD47tD3SJh8Lj0sy2aNvNCZx5slWbWh36XEiulo4ESZhsy
         hLEFKR8wvWkzeo7JRhc/aaZiKpadqvvPYteR4rDovqiPlRQ9dHo0BYcCYpBXDaFlfbCX
         c8XYCy0qoG+alHf7JeHn8rlGxCvG6bPVt4/heAEx1p6cmuMk6ZqyWlS82rigyqUU+7ug
         PfXFF2RvRjOGcrUp1819O+WxjTJ4v86YaLS+Gv/rNuJxECBppW0hYKRiy/DzP0N6i6xT
         joIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456530; x=1749061330;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9Uij2wLtuQhXOCGoStG5OmI/vXOT+cSxhUXvGV0hlc=;
        b=ozHmV0EfFDSreW8rpEmMzacYn3nKpnfTXCRg7g5ixtF3nw4jT1xF6/Q34px9qLMnZ0
         ZYIYttBeGhj2hWyZ8QZ6mvQpvwDBEQGClzWfogCXpX7yJDNVJ4JOjhA8pz8V8ycq8RIu
         XOFZirRuz0U0O9fF8VGpYsDpB59Al+DEq3SYlOdEmdYzIEh+aYZqfieN86k4Jjeub/JE
         FXXa6pa6KGXhr6blUJxf4XZ8z/gIv7H+B+lXoooEYuU6XKBT7tRZGrCQmGctB8D0eoIm
         1ZXvFO2jTssv9y038sx2mXKPyqLqs3DUVmrwro42qx5v0MMyvvSNIPuyeQgTZXnlzL95
         qbHA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ex/gRwKOyddjyG0DTPptlmfjqYWmUFKgpn+g61T8Oh1huetbmUACRvF4KtH9S02AyQCJjcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNSjl6OQWkzrNqzbzvgFnF3fCW2rmlNhSPX7YsPkynisCq4tn
	dQdQNR1sruZimxKWbPL7AXmEbLB3Bs2h9eqeLUY6elNVv1KGHEtDNVAAIPfp2Wxsl7I=
X-Gm-Gg: ASbGncs+sOzI88aXUD4zorxXVT2tvJRaX3mMNVb9CaXmQNdqplXXa9W5cVOlXizA3R2
	QEiGgNLI7OOKuTsnIH3m3X5tFTBpv3RWL/tCQXNyT6t6YXFNVTicqevKSNrE50PfOHu+4nPwSNh
	yhI7fTUXwRWplwwnJrTjGErc023xiRsxqfRnFXRLkpJ5glUqTB8FEchE4S9cZnmU1eL+Ger5oPQ
	KWkLFJcscuzWNUKCDE86dGfURMm6fX4garnlNxojgW/UnkbYKh2zIV/FCWqOOwLrOX5JZqSDq8k
	xZbJUxde5wvQ4HEY04LYH4F0X+jtrG9glWuCl7y7qYOJI489/vO/oQ491JnLoXf1Jypql7NQGpx
	4g0POoEQsNt+yNJ1DN8H7d/3IOMyeJQVBPX5YTqgqs8m+wXI2Dih6Hetf8IgOGDiNaWT68HwvUV
	nLxg6dE3zufCw=
X-Google-Smtp-Source: AGHT+IHTOE0+PFMYz990jpg9Oe0N7CBnAi3AYUtP4/dXlixK8CwlJULu/dNKcHyCmmvXjdwh0Z/kUw==
X-Received: by 2002:a05:6000:2289:b0:3a3:7675:902 with SMTP id ffacd0b85a97d-3a4eedada59mr621835f8f.21.1748456529856;
        Wed, 28 May 2025 11:22:09 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd6f1bsm2109613f8f.80.2025.05.28.11.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 11:22:09 -0700 (PDT)
Message-ID: <137571b5-0665-4ddd-ae78-0b8530daa549@suse.com>
Date: Wed, 28 May 2025 20:22:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/execmem: don't use PAGE_KERNEL protection for
 code pages
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 stable@vger.kernel.org
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-2-jgross@suse.com> <aDdHdwf8REvdu5FF@kernel.org>
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
In-Reply-To: <aDdHdwf8REvdu5FF@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UsuyoDqOVngPVJZQPUnQdaoT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UsuyoDqOVngPVJZQPUnQdaoT
Content-Type: multipart/mixed; boundary="------------qYBFV4fxCGWNE5BE1KOr8YrG";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 stable@vger.kernel.org
Message-ID: <137571b5-0665-4ddd-ae78-0b8530daa549@suse.com>
Subject: Re: [PATCH 1/3] x86/execmem: don't use PAGE_KERNEL protection for
 code pages
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-2-jgross@suse.com> <aDdHdwf8REvdu5FF@kernel.org>
In-Reply-To: <aDdHdwf8REvdu5FF@kernel.org>

--------------qYBFV4fxCGWNE5BE1KOr8YrG
Content-Type: multipart/mixed; boundary="------------WLDyLAPat7iV2ru9hIIK7gDk"

--------------WLDyLAPat7iV2ru9hIIK7gDk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjUgMTk6MjcsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIFdlZCwgTWF5
IDI4LCAyMDI1IGF0IDAyOjM1OjU1UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
PiBJbiBjYXNlIFg4Nl9GRUFUVVJFX1BTRSBpc24ndCBhdmFpbGFibGUgKGUuZy4gd2hlbiBy
dW5uaW5nIGFzIGEgWGVuDQo+PiBQViBndWVzdCksIGV4ZWNtZW1fYXJjaF9zZXR1cCgpIHdp
bGwgZmFsbCBiYWNrIHRvIHVzZSBQQUdFX0tFUk5FTA0KPj4gcHJvdGVjdGlvbiBmb3IgdGhl
IEVYRUNNRU1fTU9EVUxFX1RFWFQgcmFuZ2UuDQo+Pg0KPj4gVGhpcyB3aWxsIHJlc3VsdCBp
biBhdHRlbXB0cyB0byBleGVjdXRlIGNvZGUgd2l0aCB0aGUgTlggYml0IHNldCBpbg0KPj4g
Y2FzZSBvZiBJVFMgbWl0aWdhdGlvbiBiZWluZyBhcHBsaWVkLg0KPj4NCj4+IEF2b2lkIHRo
aXMgcHJvYmxlbSBieSB1c2luZyBQQUdFX0tFUk5FTF9FWEVDIHByb3RlY3Rpb24gaW5zdGVh
ZCwNCj4+IHdoaWNoIHdpbGwgbm90IHNldCB0aGUgTlggYml0Lg0KPj4NCj4+IENjOiA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4NCj4+IFJlcG9ydGVkLWJ5OiBYaW4gTGkgPHhpbkB6eXRv
ci5jb20+DQo+PiBGaXhlczogNTE4NWU3ZjlmM2JkICgieDg2L21vZHVsZTogZW5hYmxlIFJP
WCBjYWNoZXMgZm9yIG1vZHVsZSB0ZXh0IG9uIDY0IGJpdCIpDQo+PiBTaWduZWQtb2ZmLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94
ODYvbW0vaW5pdC5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vaW5p
dC5jIGIvYXJjaC94ODYvbW0vaW5pdC5jDQo+PiBpbmRleCA3NDU2ZGY5ODVkOTYuLmY1MDEy
YWUzMWQ4YiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L21tL2luaXQuYw0KPj4gKysrIGIv
YXJjaC94ODYvbW0vaW5pdC5jDQo+PiBAQCAtMTA4OSw3ICsxMDg5LDcgQEAgc3RydWN0IGV4
ZWNtZW1faW5mbyBfX2luaXQgKmV4ZWNtZW1fYXJjaF9zZXR1cCh2b2lkKQ0KPj4gICAJCXBn
cHJvdCA9IFBBR0VfS0VSTkVMX1JPWDsNCj4+ICAgCQlmbGFncyA9IEVYRUNNRU1fS0FTQU5f
U0hBRE9XIHwgRVhFQ01FTV9ST1hfQ0FDSEU7DQo+PiAgIAl9IGVsc2Ugew0KPj4gLQkJcGdw
cm90ID0gUEFHRV9LRVJORUw7DQo+PiArCQlwZ3Byb3QgPSBQQUdFX0tFUk5FTF9FWEVDOw0K
PiANCj4gUGxlYXNlIGRvbid0LiBFdmVyeXRoaW5nIGV4Y2VwdCBJVFMgY2FuIHdvcmsgd2l0
aCBQQUdFX0tFTlJFTCBzbyB0aGUgZml4DQo+IHNob3VsZCBiZSBvbiBJVFMgc2lkZS4NCg0K
SG1tLCBtYXliZSBhZGRpbmcgYW5vdGhlciBlbGVtZW50IHRvIGV4ZWNtZW1faW5mb1tdIHdp
dGggdGhlIG5ldw0KdHlwZSBFWEVDTUVNX0tFUk5FTF9URVhULCBzcGVjaWZ5aW5nIFBBR0Vf
S0VSTkVMX0VYRUMgaWYgIVBTRT8NCg0KDQpKdWVyZ2VuDQo=
--------------WLDyLAPat7iV2ru9hIIK7gDk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------WLDyLAPat7iV2ru9hIIK7gDk--

--------------qYBFV4fxCGWNE5BE1KOr8YrG--

--------------UsuyoDqOVngPVJZQPUnQdaoT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmg3VFAFAwAAAAAACgkQsN6d1ii/Ey/E
cgf9HRi/AUlT/PCZ9hF6vBahfHdlNPASDJOnfCGPtL8frn28VN6qnsVsRzyX/DWDXJWwGvHmgYlp
TqZE6yodTXoUnZ1BzxoYYbp/t5Rkr+BM8iciOvvrMFXOOHnIpzxpSr1ne4LksCBNnx6jWmIvO+/H
W2NKgHagfSl/iSPHW4bzebWP7DIAUBwFsyG+RJQ6v1pGsSuDFJDrm7pHPJPOVNhlqrdTJOQBaA38
wIVku11yvIeBWX35AV0vkzo2jCvCM3KDqTtSivlmP2+YyeU1/PTKoMkUZrRm0rj74E46wUwgAxst
Art9F25zxwgKv8r0/4Q+ore+g7gWvQdcOZHs2KFnEQ==
=8AsH
-----END PGP SIGNATURE-----

--------------UsuyoDqOVngPVJZQPUnQdaoT--

