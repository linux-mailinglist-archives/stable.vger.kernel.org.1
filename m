Return-Path: <stable+bounces-189196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25437C0466F
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D9A3AA32B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A082144C9;
	Fri, 24 Oct 2025 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lToeua0w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FA224FA
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284049; cv=none; b=kYcPEyzJ959XgOwfoTDBSHCb2prgbv0L2FuNz1plWGGqx7Qjfd0h7tKum8UJ3+mnlhs4g4wCA9PwtX0sOU5TWcXTPUnVpHQC1cO9lJ9WE1k30/60GClUXzEwvobPrmQzbTA6FqU6GGFKOLUHKPjd2Hhwadkc9XvA1vxoUKFmpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284049; c=relaxed/simple;
	bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DjfT8bTCmxH5xOd7mvsRpUhVf8Axw3dW5mCHyS9EGHidlQOX5tfNRwLV0mEPIKrxLkBRJA4sTUw1Jb/YjUCFhwyXXogTvlCszkZ9bjxajUK+YtTKmerkjFxPONJ1srzR8+5aLbnBddlusAifFdvJow1BMDm6Fqm2Jgj7UDN+xFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lToeua0w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1043325f8f.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761284046; x=1761888846; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
        b=lToeua0wnKy2uWrwkX5USdh1nEn/oAy11qnt10CzODHFR4WFIyj+1M5dtM9SEyGn1g
         18FTsudsX19Pw6HnPlgp/UDE7U2O6SzjpPfbDOyfD1kiUjCYeFj6NzgMapxSh/OTIJRB
         J/Kzg5N5eEGrQARQvqBcvPFn9Y4OXL0iF68eum/7Gz8pMtxhddoBH+KYH7k65ioIvQht
         TTOhlCMiFXdRG/V7ofqDO5WO8nx4HhbISKEAN/UQ7gDqWMeNQrVvqsLQnZMsltRRQv96
         zeo9IjwlcBnGxRHMnDp5XeCHIaF73weNLJMF4V7Q+J4+km6KgVQOiGUtCHBuO0SNTdjt
         bY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761284046; x=1761888846;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdeClZXIUWVGOl1GLOaOrjFt7x8K2F6/WYmVgfCof5o=;
        b=K8We25K9ZQ/ZT2sx1+rxMT7nISz0LEIayul3+uN9cy74K7a5pK6JTRjoaKpg8QwcIW
         jyLWfS7zOoJXSLF77kNda4t1bnQnd5b0UtmGFkWlfeDzd+s1DlOGYE9C3XLmth907sj7
         Wbnz0J2GM+Vvv0SYGHXWrd/p7JtO13Qr0ef2WaE2Oh6q2ybBcdU5K51N//pO27hRJOjs
         qCLhAUY2ukrMUw20PcZ/bY/uyNhBO/257GCiZsQnTonV2IapKvMC7DjRQTF/THsGfisU
         jPMM0lPkKHkaSGU7mDftWVYyqDaG6E70Ea82Po0KpPbDNl5aG+UepfemvBOaOtc2hhiR
         JOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT24ps8fX+hSAvhnRBnXFvRvS7LLM4zcUQXCUCNwMpiGA28bwKLgOQBx8obdPXL4JCehJo5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZCeTwJgd3z9dtgroyB32NsnZsG8t1xaAxRsdeuey6JgrPnJ4
	mqH4mtV4PqCdWyVehUUthGTPBy2xzZ43xoPz5XS9xNvAvHWDLSmGZKQ=
X-Gm-Gg: ASbGncuIAYIquzaYUBpJdXCpCt3+GAnJWKhL0tjDQi+zSBvcrehDO2Qg7traZvSccMJ
	V7QjD4nSubHFvDhckcT+0xJCaaUx7O+CkkOXlNQ/WiCPcUoRHRVhiNxFaZd3Zq6ICvU647bZKhX
	2SaNLfnJ8yPxTAdI5uP4VaLGOFbSNhs0Q7/92OnHTOR9XMBkd7GQZzg5OYtbcrG0hKgzeplvesU
	zK0NobOJ4YJ7lA8j/eU0ueVh9E/KtOr1abug2gA9Z5wdhX/pgTXTU0Jm/RopuzZkIsa5v3s0qXE
	NUZIjCmkYxwVBjVy7qMSdSg+Nf8pa5SooT7aqVVbquoRFV7Wn6IKJRYL/neDrCbZ/vRusf/jCrV
	twoAcpdtLcf1N8BIBusmOMLuwROmXEZHhECMGSAQq44T1G/bV1IpvRL0HXrh1Cryl7dOKZy8nYT
	iNpbKptp3cXravLnMSX7Tulldy1SQ80Eh7HpeZCb0Tbiujf6dXM/TWxc2Yh12h99Y=
X-Google-Smtp-Source: AGHT+IGTb0BhNtLXZjL89zHnvhnrIYZlTtJyn9gLCubUjapXa+451SyphIYoQs9g+1Ce4F+c0arbCA==
X-Received: by 2002:a05:6000:4011:b0:427:9d7:870f with SMTP id ffacd0b85a97d-4299070199dmr708125f8f.5.1761284045381;
        Thu, 23 Oct 2025 22:34:05 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41b7.dip0.t-ipconnect.de. [91.43.65.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm7417423f8f.27.2025.10.23.22.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 22:34:04 -0700 (PDT)
Message-ID: <045e6362-01db-47f3-9a4f-8a86b2c15d00@googlemail.com>
Date: Fri, 24 Oct 2025 07:34:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
 <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
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
In-Reply-To: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------krXW3u9GCz73FBYeJPBWkLil"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------krXW3u9GCz73FBYeJPBWkLil
Content-Type: multipart/mixed; boundary="------------sW3anxa1r6YezvSATKrGS7PM";
 protected-headers="v1"
From: Peter Schneider <pschneider1968@googlemail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <045e6362-01db-47f3-9a4f-8a86b2c15d00@googlemail.com>
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
 <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
In-Reply-To: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>

--------------sW3anxa1r6YezvSATKrGS7PM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVGhvbWFzLA0KDQoNCkFtIDIzLjEwLjIwMjUgdW0gMjE6MTEgc2NocmllYiBQZXRlciBT
Y2huZWlkZXI6DQo+IEhpIFRob21hcywNCj4gDQo+IEFtIDIzLjEwLjIwMjUgdW0gMTQ6NDYg
c2NocmllYiBUaG9tYXMgWmltbWVybWFubjoNCj4gWy4uLl0NCj4+IEkndmUgYmVlbiBhYmxl
IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSB3aXRoIGFuIEFTVDIzMDAgdGVzdCBzeXN0ZW0u
IFRoZSBhdHRhY2hlZCBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSBmb3IgbWUuIENhbiANCj4+
IHlvdSBwbGVhc2UgdGVzdCBhbmQgcmVwb3J0IG9uIHRoZSByZXN1bHRzPw0KPiANCj4gR3Jl
YXQhIC0gdGhpcyBwYXRjaCBvbiB0b3Agb2YgNi4xOC1yYzIgZml4ZXMgdGhlIGlzc3VlIGZv
ciBtZSwgdG9vLiBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9ydCENCj4gDQo+IFRl
c3RlZC1ieTogUGV0ZXIgU2NobmVpZGVyIDxwc2NobmVpZGVyMTk2OEBnb29nbGVtYWlsLmNv
bT4NCg0KTWVhbndoaWxlLCBJIGhhdmUgYWxzbyB0ZXN0ZWQgdGhpcyBhZ2FpbnN0IHN0YWJs
ZSA2LjEyLjU1IGFuZCA2LjE3LjUsIHdoZXJlIGluIC1yYzIsIEdyZWcgZHJvcHBlZCB5b3Vy
IG9yaWdpbmFsIHBhdGNoIA0Kd2l0aCB1cHN0cmVhbSBjb21taXQtaWQgNmY3MTkzNzNiOTQz
YTk1NWZlZTZmYzIwMTJhZWQyMDdiNjVlMjg1NCBiZWZvcmUgdGhlIGZpbmFsIHJlbGVhc2Ug
YmVjYXVzZSBvZiBteSByZXBvcnQuDQoNClNvIGZvciBib3RoLCBJIGJ1aWx0IHRoZW0sIG1h
ZGUgc3VyZSBpdCB3b3JrZWQgb2suIFRoZW4gSSBkaWQgImdpdCBjaGVycnktcGljayA2Zjcx
OTM3M2I5NDNhOTU1ZmVlNmZjMjAxMmFlZDIwN2I2NWUyODU0IiANCmFuZCB0ZXN0ZWQgdGhh
dCBpdCBpcyBicm9rZW4gYWdhaW4uIFRoZW4gSSBhcHBsaWVkIHlvdXIgbGFzdCBwYXRjaCBv
biB0b3Agb2YgaXQsIGFuZCBpdCB3b3JrZWQgZmluZSwgc28gd2l0aCB0aGF0IHRoZSANCmlz
c3VlIGlzIGZpeGVkIGluIGJvdGggc3RhYmxlIHZlcnNpb25zLCB0b28uDQoNCklmIHlvdSBz
ZW5kIGEgY29tYmluZWQgcGF0Y2ggdG8gR3JlZyBmb3Igc3RhYmxlLCBwbGVhc2UgZmVlbCBm
cmVlIHRvIGFkZCBteQ0KDQpUZXN0ZWQtYnk6IFBldGVyIFNjaG5laWRlciA8cHNjaG5laWRl
cjE5NjhAZ29vZ2xlbWFpbC5jb20+DQoNCg0KVGhhbmtzIGFnYWluIQ0KDQpCZXN0ZSBHcsO8
w59lLA0KUGV0ZXIgU2NobmVpZGVyDQoNCi0tIA0KQ2xpbWIgdGhlIG1vdW50YWluIG5vdCB0
byBwbGFudCB5b3VyIGZsYWcsIGJ1dCB0byBlbWJyYWNlIHRoZSBjaGFsbGVuZ2UsDQplbmpv
eSB0aGUgYWlyIGFuZCBiZWhvbGQgdGhlIHZpZXcuIENsaW1iIGl0IHNvIHlvdSBjYW4gc2Vl
IHRoZSB3b3JsZCwNCm5vdCBzbyB0aGUgd29ybGQgY2FuIHNlZSB5b3UuICAgICAgICAgICAg
ICAgICAgICAtLSBEYXZpZCBNY0N1bGxvdWdoIEpyLg0KDQpPcGVuUEdQOiAgMHhBMzgyOEJE
Nzk2Q0NFMTFBOENBREU4ODY2RTNBOTJDOTJDM0ZGMjQ0DQpEb3dubG9hZDogaHR0cHM6Ly93
d3cucGV0ZXJzLW5ldHpwbGF0ei5kZS9kb3dubG9hZC9wc2NobmVpZGVyMTk2OF9wdWIuYXNj
DQpodHRwczovL2tleXMubWFpbHZlbG9wZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNo
PXBzY2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tDQpodHRwczovL2tleXMubWFpbHZlbG9w
ZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNoPXBzY2huZWlkZXIxOTY4QGdtYWlsLmNv
bQ0KDQo=

--------------sW3anxa1r6YezvSATKrGS7PM--

--------------krXW3u9GCz73FBYeJPBWkLil
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSjgovXlszhGoyt6IZuOpLJLD/yRAUCaPsPywUDAAAAAAAKCRBuOpLJLD/yRMTK
AQDvnxYz2SoIs89+Y3maGD8FqHLRNa/qNgyLwgJi8LTPgAEAz53/dKzJ2V6mQEzWOU1q434RwUzW
ArPxnqW9ZjujIwc=
=oSt3
-----END PGP SIGNATURE-----

--------------krXW3u9GCz73FBYeJPBWkLil--

