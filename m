Return-Path: <stable+bounces-147960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A31AC6A33
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8AB1BC5326
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617812868A5;
	Wed, 28 May 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W7OKqz5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D542279903
	for <stable@vger.kernel.org>; Wed, 28 May 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438371; cv=none; b=Q7iLqWwPR+8TIWHquggaIhKJDpuN1QHd7LXby7P+3j+sRSTpsaI9cEYIHKYLzwG7QdGdg3PkewapiUe485CP1tKWJJdi315mOsYyYmcBQkU0maROGIHJ5SiZaSekB51Vg+4YNI+XxhsYC4wwCogEg3KA3On4OyR5jf9ep2GBL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438371; c=relaxed/simple;
	bh=ra9kGNznn5FPL7pCbL0i/6dtHCz3ipBftUYBX6kmPr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj5ZUEJU48ZJGgrhAKt3qqYmRlLdaUsL1CnB2J4OrwJDrWq9c2h+880juJLqMGcd1lL78sq8gHLMHFPJlicrcl17pXLNfaNDcDBGhEpvRtcDqE3y45swS8o8keM583QyXliZkfMGE0jx5ECL0ovZoijjS+Z8X26rL4j0oc8kJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W7OKqz5R; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so6470478a12.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748438365; x=1749043165; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ra9kGNznn5FPL7pCbL0i/6dtHCz3ipBftUYBX6kmPr0=;
        b=W7OKqz5RqEELdXHOMTicwBV9zLH7M3ZcISDm52IOWzrlejHwCXkyjPQWzGER9n+9VQ
         OV8HwfMHD9qu3VHBUbSj0ufnNBqTFV13LnraWntfUA+HHf+NhSg0PJZbCfj3r2Pi6t+y
         yMzwJ0eDItu1fdfFEkXSVBQO0avj/ScmUXGasZkWpUPGVbfqWc0wxi9UbQP2gOUZrLcn
         sAaDfUvrZDQeJNL18ozjvQQJuXYpEgLUeAxepBTokJHMjID7cc24jr2fWMApXyMvBiBR
         E/sSc8jxe3Pz50H+xGLVobCmI79AxMA09gMXb4R+MbA0S6PaIP5ZUBIgXMlU8+UPdiB7
         FG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438365; x=1749043165;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ra9kGNznn5FPL7pCbL0i/6dtHCz3ipBftUYBX6kmPr0=;
        b=EJNjR/HqNU8JkjBjOLxIg7puNH0Y7lXINPQ4MGBMmkmLeHPRNsYI3aFMf6bGvxpdMJ
         Qb0eOI54fL0v7BVkIai9Q0388P0G2YaINCHgffVa8n/nnFzX0vKPlCUD2HJmSTAPI1pN
         NqymIT71WbPt1eqo6ZB4Gkndb58DIf5evycZRIeIXuSslUFWGGjieLBhU1aUexaHl8lK
         xg8jnLrQFv7QnT1ZKSfzmdhsfY1sq95V+h/9C5z64FAetrrPeq9JmaAUhSurCe4qGFYZ
         l3YZshwNf232fcGQonjlXTQZb8f/Qi0ccE+V/0AIWri0Xk7ndvAIFFHji7WSAPUxsCud
         w8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/RTbGnjgR6t1R0Cc7BloZj9v/izLV8rq496c5rRAggUup2suz9LozCwnMhfPqBrphXqRs1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt8IBxlT2zNCpFxq9BNgWsUQwM/O6FpFzsHgje3wHPirX7VDL
	wSDNphw+/5pldW4umMRTOUjFQx4s/B8EJGO7JBZFzkIISWdYDFPrwkmKlXhG/05bdeM=
X-Gm-Gg: ASbGnct8Pyj1cjrNimX2URFrDDyKCt3SOPNsFx2UhwdrAF0hkm8kv+VD9SHaMJxBbYc
	eoU5NaprqPA7MWX5V8X86HvVlJFbhacQ4nkV8t09MePkhGk9ZvyLkgqiH/5O8dfZEwpx23mWByz
	JteqYnx4xMfCXYvS8UBqVDe+ANQQBhnU3XxF//l3oSNXOxxQJamDpULqEJTKuf8Hl98GrPbaGUW
	vJ2lV3xjyyCv4GnrnrssoWB9Azvn4KSklcJV4vhk0Alu6WU+I77ebrWZqIRz2KNJ/ZmiKSbSakf
	SnBNCDyqH+9H47xJ6WpbtXC7X1B62+w4fSCKsKRMsDj7VF+7PpsluLkLUWA1NK1O1fucl8NqjiH
	4dCqJ3K3krkj5CVYClaabjQM3IlX7LChdtzlGx8Dn8nZuOB5EfthjjM8Gf/1PMPrze40/YBB1qE
	np
X-Google-Smtp-Source: AGHT+IEoIHZkDhKtCpn+u5SK67h73HcbRYyn3rxoXUr8468+Zku53ZeUuW31cQhw2Dxf8WwALXvanw==
X-Received: by 2002:a17:907:2cc3:b0:ad8:9257:5728 with SMTP id a640c23a62f3a-ad8925758ccmr590305466b.27.1748438365378;
        Wed, 28 May 2025 06:19:25 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a19acb33sm107462066b.1.2025.05.28.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:19:25 -0700 (PDT)
Message-ID: <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
Date: Wed, 28 May 2025 15:19:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L8pGC02gsWWwYfQeBk1AzooM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L8pGC02gsWWwYfQeBk1AzooM
Content-Type: multipart/mixed; boundary="------------FmWIKz2UCoukIvM9oevBOgHI";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Message-ID: <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250528131052.GZ39944@noisy.programming.kicks-ass.net>

--------------FmWIKz2UCoukIvM9oevBOgHI
Content-Type: multipart/mixed; boundary="------------Ngi5ISy4WN4v8wbJEjxC5Hnu"

--------------Ngi5ISy4WN4v8wbJEjxC5Hnu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjUgMTU6MTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAyOCwgMjAyNSBhdCAwMjozNTo1N1BNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gV2hlbiBhbGxvY2F0aW5nIG1lbW9yeSBwYWdlcyBmb3Iga2VybmVsIElUUyB0aHVua3Ms
IG1ha2UgdGhlbSByZWFkLW9ubHkNCj4+IGFmdGVyIGhhdmluZyB3cml0dGVuIHRoZSBsYXN0
IHRodW5rLg0KPj4NCj4+IFRoaXMgd2lsbCBiZSBuZWVkZWQgd2hlbiBYODZfRkVBVFVSRV9Q
U0UgaXNuJ3QgYXZhaWxhYmxlLCBhcyB0aGUgdGh1bmsNCj4+IG1lbW9yeSB3aWxsIGhhdmUg
UEFHRV9LRVJORUxfRVhFQyBwcm90ZWN0aW9uLCB3aGljaCBpcyBpbmNsdWRpbmcgdGhlDQo+
PiB3cml0ZSBwZXJtaXNzaW9uLg0KPj4NCj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4NCj4+IEZpeGVzOiA1MTg1ZTdmOWYzYmQgKCJ4ODYvbW9kdWxlOiBlbmFibGUgUk9YIGNh
Y2hlcyBmb3IgbW9kdWxlIHRleHQgb24gNjQgYml0IikNCj4+IFNpZ25lZC1vZmYtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9r
ZXJuZWwvYWx0ZXJuYXRpdmUuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2FsdGVybmF0aXZlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUu
Yw0KPj4gaW5kZXggZWNmZTdiNDk3Y2FkLi5iZDk3NGEwYWM4OGEgMTAwNjQ0DQo+PiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2FsdGVybmF0aXZlLmMNCj4+IEBAIC0yMTcsNiArMjE3LDE1IEBAIHN0YXRpYyB2b2lk
ICppdHNfYWxsb2Modm9pZCkNCj4+ICAgCXJldHVybiBub19mcmVlX3B0cihwYWdlKTsNCj4+
ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgdm9pZCBpdHNfc2V0X2tlcm5lbF9ybyh2b2lkICph
ZGRyKQ0KPj4gK3sNCj4+ICsjaWZkZWYgQ09ORklHX01PRFVMRVMNCj4+ICsJaWYgKGl0c19t
b2QpDQo+PiArCQlyZXR1cm47DQo+PiArI2VuZGlmDQo+PiArCWV4ZWNtZW1fcmVzdG9yZV9y
b3goYWRkciwgUEFHRV9TSVpFKTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkICpp
dHNfYWxsb2NhdGVfdGh1bmsoaW50IHJlZykNCj4+ICAgew0KPj4gICAJaW50IHNpemUgPSAz
ICsgKHJlZyAvIDgpOw0KPj4gQEAgLTIzNCw2ICsyNDMsOCBAQCBzdGF0aWMgdm9pZCAqaXRz
X2FsbG9jYXRlX3RodW5rKGludCByZWcpDQo+PiAgICNlbmRpZg0KPj4gICANCj4+ICAgCWlm
ICghaXRzX3BhZ2UgfHwgKGl0c19vZmZzZXQgKyBzaXplIC0gMSkgPj0gUEFHRV9TSVpFKSB7
DQo+PiArCQlpZiAoaXRzX3BhZ2UpDQo+PiArCQkJaXRzX3NldF9rZXJuZWxfcm8oaXRzX3Bh
Z2UpOw0KPj4gICAJCWl0c19wYWdlID0gaXRzX2FsbG9jKCk7DQo+PiAgIAkJaWYgKCFpdHNf
cGFnZSkgew0KPj4gICAJCQlwcl9lcnIoIklUUyBwYWdlIGFsbG9jYXRpb24gZmFpbGVkXG4i
KTsNCj4+IEBAIC0yMzM4LDYgKzIzNDksMTEgQEAgdm9pZCBfX2luaXQgYWx0ZXJuYXRpdmVf
aW5zdHJ1Y3Rpb25zKHZvaWQpDQo+PiAgIAlhcHBseV9yZXRwb2xpbmVzKF9fcmV0cG9saW5l
X3NpdGVzLCBfX3JldHBvbGluZV9zaXRlc19lbmQpOw0KPj4gICAJYXBwbHlfcmV0dXJucyhf
X3JldHVybl9zaXRlcywgX19yZXR1cm5fc2l0ZXNfZW5kKTsNCj4+ICAgDQo+PiArCS8qIE1h
a2UgcG90ZW50aWFsIGxhc3QgdGh1bmsgcGFnZSByZWFkLW9ubHkuICovDQo+PiArCWlmIChp
dHNfcGFnZSkNCj4+ICsJCWl0c19zZXRfa2VybmVsX3JvKGl0c19wYWdlKTsNCj4+ICsJaXRz
X3BhZ2UgPSBOVUxMOw0KPj4gKw0KPj4gICAJLyoNCj4+ICAgCSAqIEFkanVzdCBhbGwgQ0FM
TCBpbnN0cnVjdGlvbnMgdG8gcG9pbnQgdG8gZnVuYygpLTEwLCBpbmNsdWRpbmcNCj4+ICAg
CSAqIHRob3NlIGluIC5hbHRpbnN0cl9yZXBsYWNlbWVudC4NCj4gDQo+IE5vLCB0aGlzIGlz
IGFsbCBzb3J0cyBvZiB3cm9uZy4gRXhlY21lbSBBUEkgc2hvdWxkIGVuc3VyZSB0aGlzLg0K
DQpZb3UgYXJlIGF3YXJlIHRoYXQgdGhpcyBwYXRjaCBpcyBiYXNpY2FsbHkgbWlycm9yaW5n
IHRoZSB3b3JrIHdoaWNoIGlzDQphbHJlYWR5IGRvbmUgZm9yIG1vZHVsZXMgaW4gYWx0ZXJu
YXRpdmUuYz8NCg0KDQpKdWVyZ2VuDQo=
--------------Ngi5ISy4WN4v8wbJEjxC5Hnu
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Ngi5ISy4WN4v8wbJEjxC5Hnu--

--------------FmWIKz2UCoukIvM9oevBOgHI--

--------------L8pGC02gsWWwYfQeBk1AzooM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmg3DVwFAwAAAAAACgkQsN6d1ii/Ey8o
ywf/W7CEoAq5j23MBDnI6xxWTZ1oO0S+WG7iPgl+tco29Nfv02PLc5G1qKIqnIFjV+Nu441jB7DI
IidZY9p1SgDiK8aYzyFc48dSjcLbrKP44gk6DshbrwwcaRBwmxE+u3Xx455llJRs3XWWXPy1nM3h
Px5a4Zp6pugFBfIdZ6LAGYHxG6504mwdPQfbu/VvJcJ46Bgh8z7cVIUlqs5xZetr6KkmJ8IHbKVI
Rppm8R9sP/uR0Pdntl/N2F1jHBsHzhvDhKkEZubGJSwiHpX5OZedunOYfkZIb4U7dtMAIxsFhZHN
QHDpnyqXRgnoKXKrKlnjyrOwJFaYjU4G9FO/eCB5LA==
=PjpB
-----END PGP SIGNATURE-----

--------------L8pGC02gsWWwYfQeBk1AzooM--

