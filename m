Return-Path: <stable+bounces-223123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH1zBoBxqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:53:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E1D2057C0
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DEAC301C92F
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888F35DA75;
	Wed,  4 Mar 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FrxjfPpA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8F327BFB
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646740; cv=none; b=q/vpQvHVU0tCv7H5k8S95h/1GJirl6mquA9e4DXC5aMgzDFcHgET0drCDgprF1ocCmu6e3gDYv/GySzM8osf3xb98URaQfBjulpgFpSYdQVJcrFda7yasrTfo46OG00yaWAmRijYJWxJ1JmmtrMoSBOC35V7nxCaO718HwMyfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646740; c=relaxed/simple;
	bh=6iKOUznwRxQsIlKe6k97poVXAMQnZH0Pp3txYM+lvSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B9VWfwozigo4hRePjZHZo6vJge2epsOVOVrptaV46qqUPXz84epjsZQ+JQdUXvsem1+/B+N6rbXe/EYbSZ8/u5JNFIER1l21DIk2ME67KRN+eKmtuRCGB69dwVJNz2McK5JD04ryB3A5YP1lmwGKq/3HbMwwmCWpgDQr/oQJtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FrxjfPpA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso61769255e9.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772646737; x=1773251537; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6iKOUznwRxQsIlKe6k97poVXAMQnZH0Pp3txYM+lvSM=;
        b=FrxjfPpA+R6Yy/UlverEfIuYPiw9q1kHxOMwKyCTDhoUqEhuqVml4wWUuuzI62Hk25
         2sOEXh4C6Lm45deJRaIucufNVqWiMzzp7uFGxfovNgY0Rq3JNlM5pQtRkt+h2YAod3+O
         +O2K4lks0v7/wT2boFQwXKC/jKxOYqzvx1zTlbhhoZQrXWNGpZKKJ1y0GWzrRzZ+bs8X
         T31NfhtemQt1P9hsEnHKaCv8WSYO4p9DNSSjqQJuX+aK7cX/YnVaxGI6GxIVGhdh0cgT
         JL/vKzjkqbuEUVQf6Fa7Bub7p/ZrKJycMeNvOXX/axtSNw5lAsdrG/gdkI+4aMQwctuk
         PMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646737; x=1773251537;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iKOUznwRxQsIlKe6k97poVXAMQnZH0Pp3txYM+lvSM=;
        b=X9HWt02LdQ8ZmuuXDnSwwEyt6bKBGjkj9d+ADrcjnAECwG7kUkyfYrIexqYLrNPXeI
         tYUGv9xtkpXoSf+wl8RmommTAIdHOt7iNDhnvWf4pxn1h0EfuAggcc2tHRo5LEL7J0HJ
         roerVk+C//Tp14X/t8AI3k5bVgWv50CPZlis5hyNsTYYIWFPfyYEKADnx+VKMN9f7W+h
         2qTCS7PYacNg80EnXh7VjOckj4F878P0fGI26iDN2iFJMcvsd+Esk+vYAIgxBxFxmM5w
         N+y074So2La/4YRibcfM1L49gS8L8iRjqDms6uAmChtbxmqLf1Zl+CU7AMd8Zin+KPgQ
         sO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWi+eSOKnWL7AUWSzBejUK8eAW1sHBn/ckSUJ6pqYMsdIZIRDWhkMWBCjmX49lXovowtearkek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCE6aIr3DycSc6QNRlm3WgMY0hJOn02IP0rkA48QPMBSXke4l
	KtBXM4rgazIdPid1sGj2o/eRQQ2PUJ5MjBo3XpIVEvMoQuIHhZDiDOM=
X-Gm-Gg: ATEYQzzQPsn7qo5eaLl6BRAfxCzdNqslVwChHf0YYhc+1SpH92rdHnPjni7C/ffYxar
	KV80GXHghQU+ks9AHFC5w9XYQzu7SFYgQmB1LItO5sxEaBxwZlaE8o21PxbJwvDL1Cx7kYjwojZ
	/vzm8AFIKFY1KomWh7lxY/l5rZtf+eI0znfcNcXVvf1rp3HLR3hebkTKWR44hTVJ0SsOSCwyFpD
	IxXjmO9O79Ii5ff73Yws+HYRlXm8NacSyQXu4TIFOZqEM88seYxaVZAXixpfOTBabyb6ZguQ29B
	9lZghF2C1A9fgWpVzmxYgsQEWJ7fn2s9jCkiN3dB1UFDMGAduaqwIm+5tIE6l7GmMHdybe9KC3H
	TKKkU/FVRrFUeJEYbihGQV/fPtW5loPgHzlXLleX/MWCVnEwD2tl0QNRY8Ku8d6avwy5CbwGVvE
	4Id1tffYzD778Qxmg9P4iA3c9pDxn+N/2JCY3RqlETEvvhZZOdRJH0hDVRd+ieRscVyAjG4iyW7
	w==
X-Received: by 2002:a05:600c:1e0d:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-485198c81e4mr47375825e9.33.1772646736866;
        Wed, 04 Mar 2026 09:52:16 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851c907a08sm8166915e9.0.2026.03.04.09.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 09:52:16 -0800 (PST)
Message-ID: <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
Date: Wed, 4 Mar 2026 18:52:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Linux 6.1.165
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
Autocrypt: addr=pschneider1968@googlemail.com; keydata=
 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
 IX+NNrIwDpXrzCypeM2L5WtGyw==
In-Reply-To: <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3Ed8SeoI8fS1nki2bEtPLSYx"
X-Rspamd-Queue-Id: 88E1D2057C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.15 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-223123-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linus:email,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailvelope.com:url,peters-netzplatz.de:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3Ed8SeoI8fS1nki2bEtPLSYx
Content-Type: multipart/mixed; boundary="------------YmrPl4WcpTBilexT6aLW8chE";
 protected-headers="v1"
From: Peter Schneider <pschneider1968@googlemail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Message-ID: <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
Subject: Re: Linux 6.1.165
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
In-Reply-To: <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>

--------------YmrPl4WcpTBilexT6aLW8chE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMDQuMDMuMjAyNiB1bSAxODoyNyBzY2hyaWViIFBldGVyIFNjaG5laWRlcjoNCj4gSGkg
U2FzaGEsDQo+IA0KPiANCj4gQW0gMDQuMDMuMjAyNiB1bSAxNDoxNSBzY2hyaWViIFNhc2hh
IExldmluOg0KPj4gSSdtIGFubm91bmNpbmcgdGhlIHJlbGVhc2Ugb2YgdGhlIDYuMS4xNjUg
a2VybmVsLg0KPj4NCj4+IEFsbCB1c2VycyBvZiB0aGUgNi4xIGtlcm5lbCBzZXJpZXMgbXVz
dCB1cGdyYWRlLg0KPj4NCj4+IFRoZSB1cGRhdGVkIDYuMS55IGdpdCB0cmVlIGNhbiBiZSBm
b3VuZCBhdDoNCj4+IMKgwqDCoMKgwqDCoMKgwqAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUuZ2l0IGxpbnV4LTYu
MS55DQo+PiBhbmQgY2FuIGJlIGJyb3dzZWQgYXQgdGhlIG5vcm1hbCBrZXJuZWwub3JnIGdp
dCB3ZWIgYnJvd3NlcjoNCj4+IMKgwqDCoMKgwqDCoMKgwqAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy8/cD1saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUuZ2l0O2E9c3Vt
bWFyeQ0KPj4NCj4+DQo+PiBUaGFua3MsDQo+PiBTYXNoYQ0KPiANCj4gDQo+IEluIHRoZSBu
b3cgcmVsZWFzZWQgNi4xLjE2NSwgSSBnZXQgdGhlIHNhbWUgYnVpbGQgZXJyb3IgYXMgSSBo
YXZlIHJlcG9ydGVkIGluIHRoZSAxc3QgaW5jYXJuYXRpb24gb2YgNi4xLjE2NS1yYzIgKHNl
ZSBbMV0pDQo+IA0KPiAgwqAgQ0PCoMKgwqDCoMKgIGFyY2gveDg2L2tlcm5lbC9zZXR1cC5v
DQo+IGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jOiBJbiBmdW5jdGlvbiDigJhpbWFfZ2V0X2tl
eGVjX2J1ZmZlcuKAmToNCj4gYXJjaC94ODYva2VybmVsL3NldHVwLmM6Mzg1OjE1OiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaW1hX3ZhbGlkYXRlX3Jh
bmdl4oCZIFstV2ltcGxpY2l0LWZ1bmN0aW9uLSANCj4gZGVjbGFyYXRpb25dDQo+ICDCoCAz
ODUgfMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gaW1hX3ZhbGlkYXRlX3JhbmdlKGltYV9rZXhl
Y19idWZmZXJfcGh5cywgaW1hX2tleGVjX2J1ZmZlcl9zaXplKTsNCj4gIMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+IG1h
a2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNTA6IGFyY2gveDg2L2tlcm5l
bC9zZXR1cC5vXSBGZWhsZXIgMQ0KPiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUu
YnVpbGQ6NTAzOiBhcmNoL3g4Ni9rZXJuZWxdIEZlaGxlciAyDQo+IG1ha2VbMV06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDM6IGFyY2gveDg2XSBGZWhsZXIgMg0KPiBtYWtl
OiAqKiogW01ha2VmaWxlOjIwMjU6IC5dIEZlaGxlciAyDQo+IHJvb3RAbGludXM6L3Vzci9z
cmMvbGludXgtc3RhYmxlIyBnaXQgc3RhdHVzDQo+IEhFQUQgbG9zZ2Vsw7ZzdCBiZWkgdjYu
MS4xNjUNCj4gDQo+IA0KPiBTbyB0aGUgb2ZmZW5kaW5nIHBhdGNoIHNlZW1zIHRvIGJlIHN0
aWxsIGluLCBhbHRob3VnaCBpbiB0aGUgMm5kIGluY2FybmF0aW9uIG9mIC1yYzIgd2hpY2gg
eW91IGZvcmNlIHB1c2hlZCBvdmVyIHRoZSAxc3QgDQo+IG9uZSBvZiAtcmMyLCBpdCB3YXMg
dGhlbiByZXZlcnRlZCBhZnRlciBteSByZXBvcnQgWzJdLiBXaGVuIGkgZ2l0IGJsYW1lIGFy
Y2gveDg2L2tlcm5lbC9zZXR1cC5jIGFuZCBsb29rIGF0IHRoZSANCj4gb2ZmZW5kaW5nIGxp
bmUgSSBzZWU6DQo+IA0KPiAzN2YxODkxNWEyNjFhIGFyY2gveDg2L2tlcm5lbC9zZXR1cC5j
wqDCoMKgIChIYXJzaGl0IE1vZ2FsYXBhbGxpwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjAyNS0x
Mi0zMCAyMjoxNjowOSAtMDgwMMKgIDM4NSnCoMKgwqDCoMKgwqDCoMKgIHJldCA9IA0KPiBp
bWFfdmFsaWRhdGVfcmFuZ2UoaW1hX2tleGVjX2J1ZmZlcl9waHlzLCBpbWFfa2V4ZWNfYnVm
ZmVyX3NpemUpOw0KPiAzN2YxODkxNWEyNjFhIGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jwqDC
oMKgIChIYXJzaGl0IE1vZ2FsYXBhbGxpwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjAyNS0xMi0z
MCAyMjoxNjowOSAtMDgwMMKgIDM4NinCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+IDM3
ZjE4OTE1YTI2MWEgYXJjaC94ODYva2VybmVsL3NldHVwLmPCoMKgwqAgKEhhcnNoaXQgTW9n
YWxhcGFsbGnCoMKgwqDCoMKgwqDCoMKgwqDCoCAyMDI1LTEyLTMwIDIyOjE2OjA5IC0wODAw
wqAgMzg3KSByZXR1cm4gcmV0Ow0KPiAzN2YxODkxNWEyNjFhIGFyY2gveDg2L2tlcm5lbC9z
ZXR1cC5jwqDCoMKgIChIYXJzaGl0IE1vZ2FsYXBhbGxpwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MjAyNS0xMi0zMCAyMjoxNjowOSAtMDgwMMKgIDM4OCkNCj4gDQo+IA0KPiB3aGljaCBpcyB0
aGlzLCBub3cgd2l0aCBhIGRpZmZlcmVudCBjb21taXQgU0hBMTogKCBpbiBbMV0gSSBmb3Vu
ZCBpdCB3YXMgNzNiOTdlZTA2YmQ2MzU0MzNkMWM0MjllY2RiYzkxNjdkYTVkZTU4OCApDQo+
IA0KPiANCj4gY29tbWl0IDM3ZjE4OTE1YTI2MWFmZTg0ZGFiNDYyNjI0ZWQ4MjljZGRiNzdh
OWINCj4gQXV0aG9yOiBIYXJzaGl0IE1vZ2FsYXBhbGxpIDxoYXJzaGl0Lm0ubW9nYWxhcGFs
bGlAb3JhY2xlLmNvbT4NCj4gRGF0ZTrCoMKgIFR1ZSBEZWMgMzAgMjI6MTY6MDkgMjAyNSAt
MDgwMA0KPiANCj4gIMKgwqDCoCB4ODYva2V4ZWM6IGFkZCBhIHNhbml0eSBjaGVjayBvbiBw
cmV2aW91cyBrZXJuZWwncyBpbWEga2V4ZWMgYnVmZmVyDQo+IA0KPiAgwqDCoMKgIFsgVXBz
dHJlYW0gY29tbWl0IGM1NDg5ZDA0MzM3YjQ3ZTkzYzA2MjNlODE0NWZjYmEzZjU3MzllZmQg
XQ0KPiANCj4gIMKgwqDCoCBXaGVuIHRoZSBzZWNvbmQtc3RhZ2Uga2VybmVsIGlzIGJvb3Rl
ZCB2aWEga2V4ZWMgd2l0aCBhIGxpbWl0aW5nIGNvbW1hbmQNCj4gIMKgwqDCoCBsaW5lIHN1
Y2ggYXMgIm1lbT08c2l6ZT4iLCB0aGUgcGh5c2ljYWwgcmFuZ2UgdGhhdCBjb250YWlucyB0
aGUgY2FycmllZA0KPiAgwqDCoMKgIG92ZXIgSU1BIG1lYXN1cmVtZW50IGxpc3QgbWF5IGZh
bGwgb3V0c2lkZSB0aGUgdHJ1bmNhdGVkIFJBTSBsZWFkaW5nIHRvIGENCj4gIMKgwqDCoCBr
ZXJuZWwgcGFuaWMuDQo+IA0KPiANCj4gU28sIHNvbWVob3cgdGhpcyBoYXMgY29tZSBiYWNr
IGJldHdlZW4gdGhlIG5ldyAtcmMyIGFuZCB0aGUgcmVsZWFzZT8hPyBCdXQgaG93IGFuZCB3
aHk/IERpZCB5b3UgcmV0ZXN0IHRoaXMgYmVmb3JlIHRoZSANCj4gcmVsZWFzZT8NCj4gDQo+
IA0KPiBOb3QgZ29vZC4uLg0KPiANCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9zdGFibGUvNjY0NjFjMTMtMWJiMy00NzNjLWI1N2YtYWRiYTlkYjRmNzU2QGdvb2dsZW1h
aWwuY29tLw0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlL2EwNGIxYWE2
LWJhNDYtNDM2OC05ZGZlLTYzMjBhMmRhZmE3OUBnb29nbGVtYWlsLmNvbS8NCg0KDQoNCkFu
ZCBpdCdzIGFsc28gc3RpbGwgKGFnYWluPykgaW4gYWxsIHRoZSBvdGhlciA2Lnggc3RhYmxl
IGJyYW5jaCByZWxlYXNlcyBvZiB0b2RheToNCg0KNi42LjEyOCAgMjJlNDYwYjYzMzNhNQ0K
Ni4xMi43NSAgZjhmNzNiZjBmOGE1Nw0KNi4xOC4xNiAgZDRhMTMyZjEyMWM1OQ0KNi4xOS42
ICAgNGQ3YThmNWYyODE4Nw0KDQpkZXNwaXRlIHRoYXQgeW91IHNhaWQgaW4gWzFdIHRoYXQg
eW91IGRyb3BwZWQgaXQuIFN0cmFuZ2UuLi4NCg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvc3RhYmxlL2FhWFNWYUdyd1ktazgwbTVAbGFwcy8NCg0KDQpCZXN0ZSBHcsO8w59l
LA0KUGV0ZXIgU2NobmVpZGVyDQoNCi0tIA0KQ2xpbWIgdGhlIG1vdW50YWluIG5vdCB0byBw
bGFudCB5b3VyIGZsYWcsIGJ1dCB0byBlbWJyYWNlIHRoZSBjaGFsbGVuZ2UsDQplbmpveSB0
aGUgYWlyIGFuZCBiZWhvbGQgdGhlIHZpZXcuIENsaW1iIGl0IHNvIHlvdSBjYW4gc2VlIHRo
ZSB3b3JsZCwNCm5vdCBzbyB0aGUgd29ybGQgY2FuIHNlZSB5b3UuICAgICAgICAgICAgICAg
ICAgICAtLSBEYXZpZCBNY0N1bGxvdWdoIEpyLg0KDQpPcGVuUEdQOiAgMHhBMzgyOEJENzk2
Q0NFMTFBOENBREU4ODY2RTNBOTJDOTJDM0ZGMjQ0DQpEb3dubG9hZDogaHR0cHM6Ly93d3cu
cGV0ZXJzLW5ldHpwbGF0ei5kZS9kb3dubG9hZC9wc2NobmVpZGVyMTk2OF9wdWIuYXNjDQpo
dHRwczovL2tleXMubWFpbHZlbG9wZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNoPXBz
Y2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tDQpodHRwczovL2tleXMubWFpbHZlbG9wZS5j
b20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNoPXBzY2huZWlkZXIxOTY4QGdtYWlsLmNvbQ0K


--------------YmrPl4WcpTBilexT6aLW8chE--

--------------3Ed8SeoI8fS1nki2bEtPLSYx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEJlc7Dq7rXmY041HeEaDYA0mmnLQFAmmocU8FAwAAAAAACgkQEaDYA0mmnLTN
bA//XOARMTgdKVyxjNaH50S0/XpLOMw77f2G+sFglnytKdZusDyU06Ml14HJ2WDvb7+e5RuNFD4h
S8+NDcRuUXxOi/hGW9AxJUj97RammD8bQ0W2X4nbp71rotU65jM4QpkkKvYnCyk8y+8LYqvVddRq
+ZYG7j9OfApxW8eg/WfVnkx7HXNCgbZp0mFGbE8GV/FIKYygnoDrJRQwmD8ZN2WXgadeguCspFKP
0LQxQKImQClf/vhVZu++2SOxJuH8SihzyQRcLQavexwdMVU9P2VFJ7k5RCCG1odLE8tlNkmpystA
X4WDFat3OwM9yESn9zyu0EOXiwmijkrr5NHOjYZkxtDRk2yHseFRRWwOyyudPPUyVSblINmeSj4I
fFxX7MKdfzWGzhsmp3kxmsQD4H7VrniR3H2yScKq6zWJUa0bX6X0YXUwG6Ct1GV42uqRaph+50VA
PuFiE0l5YATRD4BK1k+4T0ICMOU/wUoshNlj9k1eDweN/g+NGashw60Vo8jM15scZW+MptzrpP3V
9x+MpXQ4zepEYpU9QyTUHK9d7K+c1CWuEI7gH7un7FAmL7cWMkFWROk/U1kGXmYgU8aeUubIkoBO
LrnjC4RqvqIt/hlyxBW9zZ6JaCc2WeGyssg32uTshAIkqPL3WVo7wn8rTapwBrNPvXxvwijdv/M8
qLo=
=LtWq
-----END PGP SIGNATURE-----

--------------3Ed8SeoI8fS1nki2bEtPLSYx--

