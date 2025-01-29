Return-Path: <stable+bounces-111209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF73A22421
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB25E7A24F3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89851E1C02;
	Wed, 29 Jan 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bps6MkBE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A431E0E11
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176232; cv=none; b=KtT2RtIFa5yQARm2OzML/EroreanqsPsTnnHeNRQn+L18z83vqnQmAizFqM4iqu6Ol1IgD/gMHmZ5miJHfJ79nVyc5MCA7Q/SooGqfwMBNu9GyqFMPZgkSoGCeqpb0+HRWZb+VQX/J8vX2eFWfPykGWkkiPUIv33WMuCW0gwws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176232; c=relaxed/simple;
	bh=vujb+9AK4crOXTLq1PEpcebpri0tORkVUFtuFQHx3JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgJ1nUKrM6bCoXEu+4XHXr3Dm7+m/QnXwT28Qh0x1l4J698GJARAzWlWEgt4sRNCgxcyKfynv7cDWvh5EOQ1Wc6A5Tdbgvq0nommFP5mqmsPxKuUXR2gkswxmrQB9XfpHSJBkIQ87N2DcDqTQTCZK1Eq/WQJp3pXuIu6skJKpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bps6MkBE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so4051409f8f.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738176229; x=1738781029; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vujb+9AK4crOXTLq1PEpcebpri0tORkVUFtuFQHx3JA=;
        b=bps6MkBE8gghnnHKGiJuQEiExv/iXW4MQNmJPgo1Wrj2/6bFQlD+yXvGG7E5Jen1xk
         bRQ1GiTQfhl8Qy30eL9yVvr+ZKD/V/64kvg0QoY3gwe+YxVqxqDlNGCnMcuVIScwzaKU
         OiCyThgfyDMgWNqyj0z0zYuWyczUl1nJePeOhmDSyAFszjvK7adV3SztXq7gv8q6pheB
         cBTLQd+3JNrap/YUnt4XLA0G24Sop1UeJEtspNyQZBG3ogHwa2a28eyKDdTdQ3xb84SM
         SFxBnGlB7DTP+behYhdjYqZGutmyxNWPaTh3cT7r8ut5zZmW7Hh+/ayxXRQgA8WnJNAt
         H8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176229; x=1738781029;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vujb+9AK4crOXTLq1PEpcebpri0tORkVUFtuFQHx3JA=;
        b=HB2LBtft5J/wIGJSuA1VW2WAv5xgSQNOtNcv+PFIXVT7vj5HmwcRaDRw5PWUVF7WTN
         CBSKGkF/hhs1EmxtgmfX8mPX7VBCGsofw24IxxBJ2wQIR4JU5nk5cD/fj6lAhdPh/Gh0
         MMZjCcrjQLbnsfpTvhq6Lte4jFFLRMB16b0kkze2/Q1/g2nms19AaqUXH5fsZ2IjU6gk
         Ierp2xPcM0Fz6QYwRmtidLrFe2NRRx2cJTvxlp7tA7SnCG7XbkATOS6IaAxKdAl3guC3
         y209wjfCJnqWYczNC4a9x+wz4oJvaXXsEZczi/WxeBcbmqwIntTemWSXYhADr/1lJ6kR
         FkzA==
X-Forwarded-Encrypted: i=1; AJvYcCWtZ15um/KIXoKy5zBIuSdohTaWR6Pgg7DXz/onWx2yyzgLKgqg8LJ2pnY7yFmb5H4tSXTGb8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeRW6yP3BVl9TqEIq7wlCfgj4ct38HjkYgMuUppFtRE4O1IaQ
	swX4BYDFE8KOPC/n+uPfGhjKJLB7Za5LdipcyINA2BE6ElOjtsw96p4ExLV/9v4=
X-Gm-Gg: ASbGncucV7TC7opDl7kRqmmKQgqcQpA57msYoBdnLxG5RYaBbVieoOtcTzOEyJvRk7p
	EnIvdXZK/eoim8CwcC/r0svaW60Ac8IqZ2quRvvt56dyke83A50Em6JdSU7MzlnNKj4VgQmQeyT
	5cdef/fsC9wVS31d8w3VvTTbS+cNuHLL2lGQ63oVJvYQth7y7Vo1whp47fPZ1uHsz0vP7l6cjtM
	nawVGqPNIuYYivEWcHkGACHOSi+PX5TLq0Ey3G4tT3s21+Ez4HKwvAQSLbjpmTlxkmF/OQ03ElE
	m163T7Tr7AxOC9lqOwPnFTuKGmBL3sItzAaR0Rc8b3MH7O9/qkJpYkZnRAP7+lx8BcPuTZ+/uVz
	K0lOyvGiisUn0RyGx9+iyB6ZUY+Jqm7tiwWA7zhCZ
X-Google-Smtp-Source: AGHT+IHgD8Ep2OArSU5wrkaW+rK7D6rY81vY58fc9DyqNv+GloKfGvmf3h6C32qiwSQh6RhcsjvvJA==
X-Received: by 2002:a05:6000:144d:b0:386:380d:2cac with SMTP id ffacd0b85a97d-38c5195f9afmr3689253f8f.26.1738176228778;
        Wed, 29 Jan 2025 10:43:48 -0800 (PST)
Received: from ?IPV6:2003:e5:8731:2800:842d:42a0:5992:3595? (p200300e587312800842d42a059923595.dip0.t-ipconnect.de. [2003:e5:8731:2800:842d:42a0:5992:3595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb057sm18043945f8f.62.2025.01.29.10.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 10:43:48 -0800 (PST)
Message-ID: <de6912ad-3dba-4d66-8ca2-71a0aa09172c@suse.com>
Date: Wed, 29 Jan 2025 19:43:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
 <2025012919-series-chaps-856e@gregkh>
 <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>
 <2025012936-finalize-ducktail-c524@gregkh>
 <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com>
 <2025012956-jiffy-condone-3137@gregkh>
 <1f225b8d-d958-4304-829e-8798884d9b6b@oracle.com>
 <83bd90c7-8879-4462-9548-bb5b69cac39e@suse.com>
 <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>
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
In-Reply-To: <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hxwhKIYd1pkGoQAV7kXHVMQ2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hxwhKIYd1pkGoQAV7kXHVMQ2
Content-Type: multipart/mixed; boundary="------------80lROOcx70M4JuOF53eX5CJm";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
Message-ID: <de6912ad-3dba-4d66-8ca2-71a0aa09172c@suse.com>
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
 <2025012919-series-chaps-856e@gregkh>
 <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>
 <2025012936-finalize-ducktail-c524@gregkh>
 <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com>
 <2025012956-jiffy-condone-3137@gregkh>
 <1f225b8d-d958-4304-829e-8798884d9b6b@oracle.com>
 <83bd90c7-8879-4462-9548-bb5b69cac39e@suse.com>
 <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>
In-Reply-To: <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>

--------------80lROOcx70M4JuOF53eX5CJm
Content-Type: multipart/mixed; boundary="------------fbrRPcU8KCB0bqfRa42nAMbp"

--------------fbrRPcU8KCB0bqfRa42nAMbp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDEuMjUgMTk6MzUsIEhhcnNodmFyZGhhbiBKaGEgd3JvdGU6DQo+IA0KPiBPbiAy
OS8wMS8yNSA0OjUyIFBNLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMjkuMDEuMjUg
MTA6MTUsIEhhcnNodmFyZGhhbiBKaGEgd3JvdGU6DQo+Pj4NCj4+PiBPbiAyOS8wMS8yNSAy
OjM0IFBNLCBHcmVnIEtIIHdyb3RlOg0KPj4+PiBPbiBXZWQsIEphbiAyOSwgMjAyNSBhdCAw
MjoyOTo0OFBNICswNTMwLCBIYXJzaHZhcmRoYW4gSmhhIHdyb3RlOg0KPj4+Pj4gSGkgR3Jl
ZywNCj4+Pj4+DQo+Pj4+PiBPbiAyOS8wMS8yNSAyOjE4IFBNLCBHcmVnIEtIIHdyb3RlOg0K
Pj4+Pj4+IE9uIFdlZCwgSmFuIDI5LCAyMDI1IGF0IDAyOjEzOjM0UE0gKzA1MzAsIEhhcnNo
dmFyZGhhbiBKaGEgd3JvdGU6DQo+Pj4+Pj4+IEhpIHRoZXJlLA0KPj4+Pj4+Pg0KPj4+Pj4+
PiBPbiAyOS8wMS8yNSAyOjA1IFBNLCBHcmVnIEtIIHdyb3RlOg0KPj4+Pj4+Pj4gT24gV2Vk
LCBKYW4gMjksIDIwMjUgYXQgMDI6MDM6NTFQTSArMDUzMCwgSGFyc2h2YXJkaGFuIEpoYSB3
cm90ZToNCj4+Pj4+Pj4+PiBIaSBBbGwsDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiArc3RhYmxl
DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBUaGVyZSBzZWVtcyB0byBiZSBzb21lIGZvcm1hdHRp
bmcgaXNzdWVzIGluIG15IGxvZyBvdXRwdXQuIEkgaGF2ZQ0KPj4+Pj4+Pj4+IGF0dGFjaGVk
IGl0IGFzIGEgZmlsZS4NCj4+Pj4+Pj4+IENvbmZ1c2VkLCB3aGF0IGFyZSB5b3Ugd2FudGlu
ZyB1cyB0byBkbyBoZXJlIGluIHRoZSBzdGFibGUgdHJlZT8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiB0aGFua3MsDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gZ3JlZyBrLWgNCj4+Pj4+Pj4gU2luY2Us
IHRoaXMgaXMgcmVwcm9kdWNpYmxlIG9uIDUuNC55IEkgaGF2ZSBhZGRlZCBzdGFibGUuIFRo
ZQ0KPj4+Pj4+PiBjdWxwcml0DQo+Pj4+Pj4+IGNvbW1pdCB3aGljaCB1cG9uIGdldHRpbmcg
cmV2ZXJ0ZWQgZml4ZXMgdGhpcyBpc3N1ZSBpcyBhbHNvDQo+Pj4+Pj4+IHByZXNlbnQgaW4N
Cj4+Pj4+Pj4gNS40Lnkgc3RhYmxlLg0KPj4+Pj4+IFdoYXQgY3VscHJpdCBjb21taXQ/wqAg
SSBzZWUgbm8gaW5mb3JtYXRpb24gaGVyZSA6KA0KPj4+Pj4+DQo+Pj4+Pj4gUmVtZW1iZXIs
IHRvcC1wb3N0aW5nIGlzIGV2aWwuLi4NCj4+Pj4+IE15IGFwb2xvZ2llcywNCj4+Pj4+DQo+
Pj4+PiBUaGUgc3RhYmxlIHRhZyB2NS40LjI4OSBzZWVtcyB0byBmYWlsIHRvIGJvb3Qgd2l0
aCB0aGUgZm9sbG93aW5nDQo+Pj4+PiBwcm9tcHQgaW4gYW4gaW5maW5pdGUgbG9vcDoNCj4+
Pj4+IFvCoMKgIDI0LjQyNzIxN10gbWVnYXJhaWRfc2FzIDAwMDA6NjU6MDAuMDogbWVnYXNh
c19idWlsZF9pb19mdXNpb24NCj4+Pj4+IDMyNzMgc2dlX2NvdW50ICgtMTIpIGlzIG91dCBv
ZiByYW5nZS4gUmFuZ2UgaXM6wqAgMC0yNTYNCj4+Pj4+DQo+Pj4+PiBSZXZlcnRpbmcgdGhl
IGZvbGxvd2luZyBwYXRjaCBzZWVtcyB0byBmaXggdGhlIGlzc3VlOg0KPj4+Pj4NCj4+Pj4+
IHN0YWJsZS01LjTCoMKgwqDCoMKgIDogdjUuNC4yODXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSA1ZGYyOWE0NDVmM2EgeGVuL3N3aW90bGI6IGFkZA0KPj4+Pj4gYWxpZ25tZW50IGNo
ZWNrIGZvciBkbWEgYnVmZmVycw0KPj4+Pj4NCj4+Pj4+IEkgdHJpZWQgY2hhbmdpbmcgc3dp
b3RsYiBncnViIGNvbW1hbmQgbGluZSBhcmd1bWVudHMgYnV0IHRoYXQgZGlkbid0DQo+Pj4+
PiBzZWVtIHRvIGhlbHAgbXVjaCB1bmZvcnR1bmF0ZWx5IGFuZCB0aGUgZXJyb3Igd2FzIHNl
ZW4gYWdhaW4uDQo+Pj4+Pg0KPj4+PiBPaywgY2FuIHlvdSBzdWJtaXQgdGhpcyByZXZlcnQg
d2l0aCB0aGUgaW5mb3JtYXRpb24gYWJvdXQgd2h5IGl0IHNob3VsZA0KPj4+PiBub3QgYmUg
aW5jbHVkZWQgaW4gdGhlIDUuNC55IHRyZWUgYW5kIGNjOiBldmVyeW9uZSBpbnZvbHZlZCBh
bmQgdGhlbiB3ZQ0KPj4+PiB3aWxsIGJlIGdsYWQgdG8gcXVldWUgaXQgdXAuDQo+Pj4+DQo+
Pj4+IHRoYW5rcywNCj4+Pj4NCj4+Pj4gZ3JlZyBrLWgNCj4+Pg0KPj4+IFRoaXMgbWlnaHQg
YmUgcmVwcm9kdWNpYmxlIG9uIG90aGVyIHN0YWJsZSB0cmVlcyBhbmQgbWFpbmxpbmUgYXMg
d2VsbCBzbw0KPj4+IHdlIHdpbGwgZ2V0IGl0IGZpeGVkIHRoZXJlIGFuZCBJIHdpbGwgc3Vi
bWl0IHRoZSBuZWNlc3NhcnkgZml4IHRvIHN0YWJsZQ0KPj4+IHdoZW4gZXZlcnl0aGluZyBp
cyBzb3J0ZWQgb3V0IG9uIG1haW5saW5lLg0KPj4NCj4+IFJpZ2h0LiBKdXN0IHJldmVydGlu
ZyBteSBwYXRjaCB3aWxsIHRyYWRlIG9uZSBlcnJvciB3aXRoIGFub3RoZXIgb25lICh0aGUN
Cj4+IG9uZSB3aGljaCB0cmlnZ2VyZWQgbWUgdG8gd3JpdGUgdGhlIHBhdGNoKS4NCj4+DQo+
PiBUaGVyZSBhcmUgdHdvIHBvc3NpYmxlIHdheXMgdG8gZml4IHRoZSBpc3N1ZToNCj4+DQo+
PiAtIGFsbG93IGxhcmdlciBETUEgYnVmZmVycyBpbiB4ZW4vc3dpb3RsYiAodG9kYXkgMk1C
IGFyZSB0aGUgbWF4Lg0KPj4gc3VwcG9ydGVkDQo+PiAgwqAgc2l6ZSwgdGhlIG1lZ2FyYWlk
X3NhcyBkcml2ZXIgc2VlbXMgdG8gZWZmZWN0aXZlbHkgcmVxdWVzdCA0TUIpDQo+IA0KPiBU
aGlzIHNlZW1zIHJlbGF0aXZlbHkgc2ltcGxlciB0byBpbXBsZW1lbnQgYnV0IEknbSBub3Qg
c3VyZSB3aGV0aGVyIGl0J3MNCj4gdGhlIG1vc3Qgb3B0aW1hbCBhcHByb2FjaA0KDQpKdXN0
IG1ha2luZyB0aGUgc3RhdGljIGFycmF5IGxhcmdlciB1c2VkIHRvIGhvbGQgdGhlIGZyYW1l
IG51bWJlcnMgZm9yIHRoZQ0KYnVmZmVyIHNlZW1zIHRvIGJlIGEgd2FzdGUgb2YgbWVtb3J5
IGZvciBtb3N0IGNvbmZpZ3VyYXRpb25zLg0KDQpJJ20gdGhpbmtpbmcgb2YgYW4gYWxsb2Nh
dGVkIGFycmF5IHVzaW5nIHRoZSBtYXggbmVlZGVkIHNpemUgKHJlcGxhY2UgYQ0KZm9ybWVy
IGJ1ZmZlciB3aXRoIGEgbGFyZ2VyIG9uZSBpZiBuZWVkZWQpLg0KDQoNCkp1ZXJnZW4NCg0K
SnVlcmdlbg0K
--------------fbrRPcU8KCB0bqfRa42nAMbp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------fbrRPcU8KCB0bqfRa42nAMbp--

--------------80lROOcx70M4JuOF53eX5CJm--

--------------hxwhKIYd1pkGoQAV7kXHVMQ2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmeaduMFAwAAAAAACgkQsN6d1ii/Ey+P
mQf/aC4bQU+adCDHWz6U4lrd09wekr6XsxNQaxZaunJ7qs4fj6FUwEk0mNv2mR5mJI1tbfGCu1j3
YyYihiDYzWbOdu8raVpF+rP7lOswGqqumpgkTaj6Y4z4TEy6zVWK7xGwDzVaMQB1ogLxv5rVUx+R
XnNaAI5SteZpFDfzyWwmE6/t0Ahn0juC544A8X4EY/DPVmmcpdIOeek8Sfz4kMeJSdYUlsRFoNH3
BleJDVvgmObfwjI+LKyVwm1qSkIvv9587D3lD30p6XHOyS3XKFtSWkDhRPSNhFXoIE4DFk+I1elw
2YCEPbWAlSVfg18hFa9bJt8XzC2i4nA9INpYatVaWA==
=KLOL
-----END PGP SIGNATURE-----

--------------hxwhKIYd1pkGoQAV7kXHVMQ2--

