Return-Path: <stable+bounces-132697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13222A89408
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58160189C78C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 06:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB9275847;
	Tue, 15 Apr 2025 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PK2irhTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE31990B7
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699100; cv=none; b=r+h9PfpiC8o8Es9AgIh7h61EjcMpLKRgN0DoH8tRofIBQ1HZaN84Z03DQAyjo6CKwY3eZzYITXlCxjEiuxpD9K4dhy47YSfy8ub0zvn7lNShYDW1NBP0b1C86Jsi3iZfYOLagshWmGTlMCUdMpgH/DDgNNFXON85zZIVeTeeoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699100; c=relaxed/simple;
	bh=fw2gJMhMHTU1+M7mqh4VeGPSNCVMaiAly3sa97mQiUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtRQd1na+BQcjMyxYrfOIrNhFthyqZ2naT67GNIG2Ggsbhw+ffS1FSrMtNEfdrqCTPn3UkE+WZABJu6LBmE+TxpWYe+MW/uk7lPP5fIpDkH9wzUyzolNUrkl3MRKyuRT70GHEifCnJaa1+SxtM4XWnbYepIk5hvsXDsct9PkLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PK2irhTA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf680d351so35430015e9.0
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744699096; x=1745303896; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fw2gJMhMHTU1+M7mqh4VeGPSNCVMaiAly3sa97mQiUw=;
        b=PK2irhTAesX1Lh6mW+LiRWFIb2EsIrXOPnfSNwqqhudajonwSYHWDE+YL1qd4qu9Cg
         serzu75iCMYayL40hpFnLoNcZ9n79BC7LqebTku3qozmOe+sa5qqjMg4ZD+2wWcphSx5
         vG4497WLJ9itr5LRI9tM45KZ3rrNHTi94gdh6AkjJ/FtdQ+VhvoiSNVwLxE5Su5R5Xgd
         JG9jViAjJ6M6vVzAe92p4qqAcj9L+Y30o4PDKMzNtJglr7ZjL6YU/+yLocU8a0HYp7wM
         V2uIrwQTqe189YufWJjJQ+LHJeKKuFGgygEMrAvI1yGVtdcGqaGUXD/BJDMY8neNl76l
         WxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744699096; x=1745303896;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw2gJMhMHTU1+M7mqh4VeGPSNCVMaiAly3sa97mQiUw=;
        b=pUNrku9Hpt66PMd3Wug9uWGHmfmseAkbI+WgnULKgjkdy5qJDZW0lMpZsUWz1W2cX2
         +JMGfzkqd7e68xWv3gEKkncF73XOBUr+kEENWKNYlP61lXU4KLTlsMG49y4aSiejCh3p
         zxoG1FMgFQRJSMevFnCaxNc614yoAmJocR7HqbXkz+wGpcd/Au8eD/r/qW6d8DPVQvui
         JEE1dMFtYYTn+0xIGrLsaKizlCuGftgNmfQy+qAQHoSkizUJiHy4qOBxbA/mPsidUjDx
         ZGxZwXuJssysLoNBDgAJc3NxKFZ672BOhXwTRrrd1N28ngNoMLidWD5XRra9LWWfpv16
         FMaQ==
X-Gm-Message-State: AOJu0YxOu6P2hPnR5KVcvfDtO9ImVYjQMgTmH5ugGklJvRW2wHz4VBwo
	UE3qCUTmfKLZK16+ghxKj+4pcEhVmap9L3r2PD8fn0qBN0lWfyTT4A2rvLaSLKaRVWsqOdkKoM6
	zcgQ=
X-Gm-Gg: ASbGncszR0n1yLgK3CGa14zIBTbT+C7a51Q/hIQnA9fwBgTnV8Aa+hblfoaStQ0TqHF
	DKU4dYX+d1Jp9Jl8IwLoYbJYTxUTXBuIl9iB0G2gfTt6qOCsVt1r/73NT+sEB2Ihm0HilxbeBFY
	Ik2R47GX+9n93pAt3Urs91Roe3vr3q7Vn2Ugr2asMcpyi4Nor8M6jKv68uzZI4l3MaAoKBs3aKL
	hjrQLqRoGvVgSPwFkvOT/jLAyJi6/OzOJWcEWA5AUP0/XmZ+wlMnN9145iN1vO+eGDnq5koHgoP
	o0eKZU1Q9mpD52ECzR/J9RjTSssjRFQnPLncW81QtlhMqZY8o7s+0Fq67SWIwbylTXdWo0Cw/q6
	iLWvhja/ifbMnRMLLOWLtvaYVVyHBy+rEF6dKmXDLbqzjMQUR5/ksJ4ewXGTP4cgaQg==
X-Google-Smtp-Source: AGHT+IHXmLtcsyVMX5fANN441LMGoN5udG5W4BHDDlPXaICFN/YR7eIKY5W/cJsxXETFoO89Y7w16w==
X-Received: by 2002:a05:600c:58d7:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43f9988a8b5mr13103605e9.5.1744699095872;
        Mon, 14 Apr 2025 23:38:15 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23158849sm202985365e9.0.2025.04.14.23.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 23:38:15 -0700 (PDT)
Message-ID: <59eb2546-98c8-47e6-95e3-c7b4825cd86a@suse.com>
Date: Tue, 15 Apr 2025 08:38:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 051/198] Xen/swiotlb: mark xen_swiotlb_fixup() __init
To: Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Jan Beulich <jbeulich@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250325122156.633329074@linuxfoundation.org>
 <20250325122157.975417185@linuxfoundation.org>
 <20250407181218.GA737271@ax162>
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
In-Reply-To: <20250407181218.GA737271@ax162>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4KkuCdOdtHm0ySML9ScWgG7L"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4KkuCdOdtHm0ySML9ScWgG7L
Content-Type: multipart/mixed; boundary="------------ps2WDxgzTfXPMuIWNtaho8dQ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Jan Beulich <jbeulich@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Sasha Levin <sashal@kernel.org>
Message-ID: <59eb2546-98c8-47e6-95e3-c7b4825cd86a@suse.com>
Subject: Re: [PATCH 6.1 051/198] Xen/swiotlb: mark xen_swiotlb_fixup() __init
References: <20250325122156.633329074@linuxfoundation.org>
 <20250325122157.975417185@linuxfoundation.org>
 <20250407181218.GA737271@ax162>
In-Reply-To: <20250407181218.GA737271@ax162>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------ps2WDxgzTfXPMuIWNtaho8dQ
Content-Type: multipart/mixed; boundary="------------AqF7XIJ00O5zdqXgWGFGFkgk"

--------------AqF7XIJ00O5zdqXgWGFGFkgk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDQuMjUgMjA6MTIsIE5hdGhhbiBDaGFuY2VsbG9yIHdyb3RlOg0KPiBIaSBHcmVn
LA0KPiANCj4gT24gVHVlLCBNYXIgMjUsIDIwMjUgYXQgMDg6MjA6MTNBTSAtMDQwMCwgR3Jl
ZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPj4gNi4xLXN0YWJsZSByZXZpZXcgcGF0Y2guICBJ
ZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+Pg0K
Pj4gLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPj4gRnJvbTogSmFuIEJldWxpY2ggPGpiZXVs
aWNoQHN1c2UuY29tPg0KPj4NCj4+IFsgVXBzdHJlYW0gY29tbWl0IDc1YWQwMjMxOGFmMmU0
YWU2NjllMjZhNzlmMDAxYmQ1ZTFmOTc0NzIgXQ0KPj4NCj4+IEl0J3Mgc29sZSB1c2VyIChw
Y2lfeGVuX3N3aW90bGJfaW5pdCgpKSBpcyBfX2luaXQsIHRvby4NCj4gDQo+IFRoaXMgaXMg
bm90IHRydWUgaW4gNi4xIHRob3VnaC4uLiB3aGljaCByZXN1bHRzIGluOg0KPiANCj4gICAg
V0FSTklORzogbW9kcG9zdDogdm1saW51eC5vOiBzZWN0aW9uIG1pc21hdGNoIGluIHJlZmVy
ZW5jZTogcGNpX3hlbl9zd2lvdGxiX2luaXRfbGF0ZSAoc2VjdGlvbjogLnRleHQpIC0+IHhl
bl9zd2lvdGxiX2ZpeHVwIChzZWN0aW9uOiAuaW5pdC50ZXh0KQ0KPiANCj4gUGVyaGFwcyBj
b21taXQgZjlhMzhlYTUxNzJhICgieDg2OiBhbHdheXMgaW5pdGlhbGl6ZSB4ZW4tc3dpb3Rs
YiB3aGVuDQo+IHhlbi1wY2lmcm9udCBpcyBlbmFibGluZyIpIGFuZCBpdHMgZGVwZW5kZW5j
eSAzNThjZDlhZmQwNjkgKCJ4ZW4vcGNpOg0KPiBhZGQgZmxhZyBmb3IgUENJIHBhc3N0aHJv
dWdoIGJlaW5nIHBvc3NpYmxlIikgc2hvdWxkIGJlIGFkZGVkIChJIGRpZCBub3QNCj4gdGVz
dCBpZiB0aGV5IGFwcGxpZWQgY2xlYW5seSB0aG91Z2gpIGJ1dCBpdCBzZWVtcyBsaWtlIGEg
cmV2ZXJ0IHdvdWxkIGJlDQo+IG1vcmUgYXBwcm9wcmlhdGUuIEkgZG9uJ3Qgc2VlIHRoaXMg
Y2hhbmdlIGFzIGEgZGVwZW5kZW5jeSBvZiBhbm90aGVyIG9uZQ0KPiBhbmQgdGhlIHJlYXNv
biBpdCBleGlzdHMgdXBzdHJlYW0gZG9lcyBub3QgYXBwbHkgaW4gdGhpcyB0cmVlIHNvIHdo
eQ0KPiBzaG91bGQgaXQgYmUgaGVyZT8NCg0KUmlnaHQuDQoNCkdyZWcsIGNvdWxkIHlvdSBw
bGVhc2UgcmVtb3ZlIHRoaXMgcGF0Y2ggZnJvbSB0aGUgc3RhYmxlIHRyZWVzIGFnYWluPw0K
DQoNCkp1ZXJnZW4NCg==
--------------AqF7XIJ00O5zdqXgWGFGFkgk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------AqF7XIJ00O5zdqXgWGFGFkgk--

--------------ps2WDxgzTfXPMuIWNtaho8dQ--

--------------4KkuCdOdtHm0ySML9ScWgG7L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmf9/tYFAwAAAAAACgkQsN6d1ii/Ey+W
Mgf+MMozg1EV5lt6weff1wicJA2mHHlYl9eVVXyoUxik6QswEqIJNp0ra2nKHJ/U+zAV8pHQtmJt
EkilWxT/3NCQ/IAvTWRsqXbnka5tSHgM1vQW+COKWtvuvxf+q7Bxp4tsZuMmeVvTUBR9ShxDFbSK
K0cd0mmLCvajCMunFQFbdf2/xBgpRBR2qO/ehCKdhPmwO82XtmV9rhaYO2sQKG/OwzmIjUZHjd63
rJZrgCoPrWM8tntDob5C5za/oX+uRg99FlrMIH6Nm/bfopJBb5jera3VplnhMCfpY9XnZWIa9xDR
xSvMXa96aXzmw8kr7mVlU5yRdJblw3wf7GhpRnXyrw==
=gRvs
-----END PGP SIGNATURE-----

--------------4KkuCdOdtHm0ySML9ScWgG7L--

