Return-Path: <stable+bounces-119450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E23A43593
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 07:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC787A5410
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE059257436;
	Tue, 25 Feb 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lViuGvPN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lViuGvPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52065254AEB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465879; cv=none; b=aUA3hBY/b11sIqBW41MVaWES7hQI0g/wZgpAx+PliC7vLXLllBe48ErW9g/mf8RFzI6u5sRjJM22Q31mFktJFdMM8qTJv3o49bdiCpzMxxAqrwBI3Hm7PkmzMtqgk/B2Qoba7Yj0Qti29exaxsnK9SbjuPrxynFp9Mb3ZDwdEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465879; c=relaxed/simple;
	bh=aJ57MWWerwy8jbvz1VnuUo8jX2WAH3BouZ7bJ4EUWvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbX4KBxi7CRbLWhEfNVQWoHNYtPPWlBjzk5HjkunIwsxgwyzbDWKgz9X96kqtF32IVp7PmmRAj35u6xTehm5roA6zr2avVLJNniEKUvpmqDFBa1/+Cr8JrNgzH4u7a7mNIiCEkRHTPfalaoJsfv+x4b6jLne9C4sFCIGL6zssIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lViuGvPN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lViuGvPN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3463E1F44E;
	Tue, 25 Feb 2025 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740465874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aJ57MWWerwy8jbvz1VnuUo8jX2WAH3BouZ7bJ4EUWvg=;
	b=lViuGvPN5CdBpdWPn7XiVkDLZFOZoZtA9E4nZGJeUjYHjBZ8Z28sFFZ6U+wz92zZytMc0b
	zJsRmSK1fpNZMiLBij7ypvTHdkqOtWe5W7eTWPkQxS+jwxRXdZS7onMgpQSGquilEQQYVm
	cu7OlNvQmJjzzgDoT1muTdJTvWrYGyo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740465874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aJ57MWWerwy8jbvz1VnuUo8jX2WAH3BouZ7bJ4EUWvg=;
	b=lViuGvPN5CdBpdWPn7XiVkDLZFOZoZtA9E4nZGJeUjYHjBZ8Z28sFFZ6U+wz92zZytMc0b
	zJsRmSK1fpNZMiLBij7ypvTHdkqOtWe5W7eTWPkQxS+jwxRXdZS7onMgpQSGquilEQQYVm
	cu7OlNvQmJjzzgDoT1muTdJTvWrYGyo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5443C13A61;
	Tue, 25 Feb 2025 06:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8bLgEtFmvWcoXwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 25 Feb 2025 06:44:33 +0000
Message-ID: <9e6ee367-41c6-47b2-ac64-1bdb0794cb47@suse.com>
Date: Tue, 25 Feb 2025 07:44:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
To: Vishal Annapurve <vannapurve@google.com>, dave.hansen@linux.intel.com,
 kirill.shutemov@linux.intel.com, ajay.kaher@broadcom.com,
 ak@linux.intel.com, tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com,
 ackerleytng@google.com, jxgao@google.com, sagis@google.com,
 afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-2-vannapurve@google.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <20250225004704.603652-2-vannapurve@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pnbruyTI4GTVWPP0fmZ500Q5"
X-Spam-Score: -3.70
X-Spamd-Result: default: False [-3.70 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	HAS_ATTACHMENT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,zytor.com,google.com,intel.com,linux.intel.com,gmail.com,kernel.org,infradead.org,vger.kernel.org,lists.linux.dev,broadcom.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pnbruyTI4GTVWPP0fmZ500Q5
Content-Type: multipart/mixed; boundary="------------uC69IAV8I5aywmdzvN8W0iDw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Vishal Annapurve <vannapurve@google.com>, dave.hansen@linux.intel.com,
 kirill.shutemov@linux.intel.com, ajay.kaher@broadcom.com,
 ak@linux.intel.com, tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com,
 ackerleytng@google.com, jxgao@google.com, sagis@google.com,
 afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org
Message-ID: <9e6ee367-41c6-47b2-ac64-1bdb0794cb47@suse.com>
Subject: Re: [PATCH v6 1/3] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-2-vannapurve@google.com>
In-Reply-To: <20250225004704.603652-2-vannapurve@google.com>

--------------uC69IAV8I5aywmdzvN8W0iDw
Content-Type: multipart/mixed; boundary="------------cezvHZFFUI52uLonVBOaTcBZ"

--------------cezvHZFFUI52uLonVBOaTcBZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDIuMjUgMDE6NDcsIFZpc2hhbCBBbm5hcHVydmUgd3JvdGU6DQo+IEZyb206ICJL
aXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
PiANCj4gQ09ORklHX1BBUkFWSVJUX1hYTCBpcyBtYWlubHkgZGVmaW5lZC91c2VkIGJ5IFhF
TiBQViBndWVzdHMuIEZvcg0KPiBvdGhlciBWTSBndWVzdCB0eXBlcywgZmVhdHVyZXMgc3Vw
cG9ydGVkIHVuZGVyIENPTkZJR19QQVJBVklSVA0KPiBhcmUgc2VsZiBzdWZmaWNpZW50LiBD
T05GSUdfUEFSQVZJUlQgbWFpbmx5IHByb3ZpZGVzIHN1cHBvcnQgZm9yDQo+IFRMQiBmbHVz
aCBvcGVyYXRpb25zIGFuZCB0aW1lIHJlbGF0ZWQgb3BlcmF0aW9ucy4NCj4gDQo+IEZvciBU
RFggZ3Vlc3QgYXMgd2VsbCwgcGFyYXZpcnQgY2FsbHMgdW5kZXIgQ09ORklHX1BBUlZJUlQg
bWVldHMNCj4gbW9zdCBvZiBpdHMgcmVxdWlyZW1lbnQgZXhjZXB0IHRoZSBuZWVkIG9mIEhM
VCBhbmQgU0FGRV9ITFQNCj4gcGFyYXZpcnQgY2FsbHMsIHdoaWNoIGlzIGN1cnJlbnRseSBk
ZWZpbmVkIHVuZGVyDQo+IENPTkZJR19QQVJBVklSVF9YWEwuDQo+IA0KPiBTaW5jZSBlbmFi
bGluZyBDT05GSUdfUEFSQVZJUlRfWFhMIGlzIHRvbyBibG9hdGVkIGZvciBURFggZ3Vlc3QN
Cj4gbGlrZSBwbGF0Zm9ybXMsIG1vdmUgSExUIGFuZCBTQUZFX0hMVCBwYXJhdmlydCBjYWxs
cyB1bmRlcg0KPiBDT05GSUdfUEFSQVZJUlQuDQo+IA0KPiBNb3ZpbmcgSExUIGFuZCBTQUZF
X0hMVCBwYXJhdmlydCBjYWxscyBhcmUgbm90IGZhdGFsIGFuZCBzaG91bGQgbm90DQo+IGJy
ZWFrIGFueSBmdW5jdGlvbmFsaXR5IGZvciBjdXJyZW50IHVzZXJzIG9mIENPTkZJR19QQVJB
VklSVC4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBiZmU2
ZWQwYzY3MjcgKCJ4ODYvdGR4OiBBZGQgSExUIHN1cHBvcnQgZm9yIFREWCBndWVzdHMiKQ0K
PiBDby1kZXZlbG9wZWQtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFu
YXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2Ft
eUBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1v
diA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFu
ZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTHVj
ayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIEFubmFw
dXJ2ZSA8dmFubmFwdXJ2ZUBnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------cezvHZFFUI52uLonVBOaTcBZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------cezvHZFFUI52uLonVBOaTcBZ--

--------------uC69IAV8I5aywmdzvN8W0iDw--

--------------pnbruyTI4GTVWPP0fmZ500Q5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAme9ZtAFAwAAAAAACgkQsN6d1ii/Ey+2
Mgf+Nj1RQjrY8eSVYR+alThmNaZ8u6i77FwJyYUu2lKVh83EA9iV6KEvdDMUPunHQi2e+lqMGsKE
uEclDp0TynVXXuMNbXChM1vRHPijTnj7eDuzmnwsgaS35BDAEfSfjbu82t3rRP3MGUOxrloirHmw
OWUhRonp2UCHxnpniyzdyp6xj72bZsDtt2rO+MVLkUg2u9mHQWLXUzwawpt83t+RSD2i7B6GWYVi
Xlka3lfvBasl763PvNwZk7PwulHTleMXJyX+g77nUVxhG2DkXJbQQRwSwZOdXunvLj60wq/lxCUP
3YAOIAiEwZDHTwNI37Thu+IHy807VItItg9rTsdzeA==
=fEtj
-----END PGP SIGNATURE-----

--------------pnbruyTI4GTVWPP0fmZ500Q5--

