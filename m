Return-Path: <stable+bounces-212796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNEyEWiRe2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:57:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4212B2899
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5DE83077CDE
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF1346A10;
	Thu, 29 Jan 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSfbmvwD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10F346798
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705626; cv=none; b=L8gEiJKi/xPzqxoC1RiJuAFbuOycC9HHT0BhF1tEHzdc+vVzp9MZVjq8eaKuB3Dc2E2ABWr9ZaWxMSmu1XVSq5UkBOAeoeQKVQdXci2iZrbvS+LGF3sWIdbSo0dk+PXBSkohQPX88ojwi5ZHgOb2hGEiOvbTYv0LrDFFb2rNa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705626; c=relaxed/simple;
	bh=o6HUZ0vsKlr36JUVf55MpSe40f88GtRTuipwm+8RSPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmG/AHFuqCUWeAR9xpoLs+8PNd2y3LuDzJwKlO4w46oOHFF4RhojTSr+OJo1sply0pZ0BgEUITXOMsB2jE69ly9s1L1c8klqbBhSh7Q4TfsF4+NRZ1a75ZyBzIApnwYmxlL7SuTphDrR5ycfSYgVJKt5xYpJldzx9DNUb/K1rcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSfbmvwD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65812261842so3440057a12.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769705623; x=1770310423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6HUZ0vsKlr36JUVf55MpSe40f88GtRTuipwm+8RSPA=;
        b=GSfbmvwD2CbDBTLqQG48yWYZT/CZe1TJOEU37E2zwn4uDTKIi9VnIj3cBwcGLkWk9c
         9rekFho/oIkGP7rV88bdh69fDZeabgNCtR5H81jkzTqL1UFDg1aI1IdMFaOyuXLQlMgA
         DQCte+9Xfrv0hbdSlnNLaXophV3IGsrMzNDMvuFQhx5jebHjjwMjalIkxc1UrJ8to+9/
         9qXLd3XK+77D/jRmwRS9LRkDx47HvKDMpx4rJeblA9U3tKD1GXdDoKDf7XWhuEKQGFOb
         +DyzGL3oFwk7YLPKkN2ZP4PsZK0zG7kVtHZKYmHl+l06l1WAELtvykCTLCg84hy1GESI
         mUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705623; x=1770310423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6HUZ0vsKlr36JUVf55MpSe40f88GtRTuipwm+8RSPA=;
        b=sy55WhIon6bqJ1bl35eO9FA3Hq4qquHuzO/yPHTXAYi4g6EqYWAU0pwKKuOEYK8aDz
         f4yHfCpxo6yPYER+149Rl5tdspqc5bkoRSgn8qsUoqo8fRbKOL3mUlw3VW/vduhqnoTj
         yii0nXfTFPabKstMwX7FX+qxHQII1OBJJcE4cS2fE0RaN1G85ViPtWW4NjJelGClMUZ7
         aWsmuIVLXzK9y4W5xOQ2bDBiFAVy5EjIrla32rvD0VOtV0KbLz5ypHH0lYDZviBe5EZ2
         z/WhCZNtEiOesKb0/r6zLrv5g9HNW+ZclqRK5poJbSGfqhpDS70PCwPaKxyaj3w7S/EK
         L9lg==
X-Forwarded-Encrypted: i=1; AJvYcCXiCj/dcMDVjDizOIdMIA84UgK20fkp7+RyzN7gj3F4xubU7HyMFMAoRstwwAe2c8aZB2vo28U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TralUf5b0A+0MbwKoxhaKKC/Gk3W80LxFtyS+HkPttzdHzyQ
	I50kMhydq0zdwv+iuTFL3QYOtkGuoUzzWiuusqDwRD54ca1tD1Ik/bUoJEZBJAGz
X-Gm-Gg: AZuq6aKYKRhqY8DoE3e8jonSl07F+YUJXpU03+O9I7mlFhGFlkYt/24GsYmYMr/OPeD
	qz+f2nOeOgMnCm/eqrbu7Kop7X9e4pVfvj8JYmrgvQ4zlzinN8gEJARaLTk5qAWytIgS1GXafz7
	kMGoL8AqsAgq6D9xv44EnPp5+TnbBvG6LLS9Dtctk1skZtK+HS2/oZX1oZyaqYZPqI1fdUzgEX/
	gadS3Mq0rO0J+97YLyVB8Hhol95zAINdzC684zDBeqoJ6vLjr+s2iGGf5XGd0BbgOP9qmOswfbZ
	c5QD1aFtydFOcPZQYWNVQMMVsT6SbmjzMBg3I4TBy6BHUMP72hQgIUEHxEkTnFt9u/j87P52YY5
	jaPBV28jNuf1fW8hCfVZXpqVzjs8ntlI28qg4q0y2/ibX9KOV7GA+kcUrBx6wSDY9ENGvgs3TND
	NglcyMJ3rMZEpOpA==
X-Received: by 2002:a17:907:da2:b0:b84:3fab:4251 with SMTP id a640c23a62f3a-b8ddf86f5f8mr262260266b.15.1769705622989;
        Thu, 29 Jan 2026 08:53:42 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6f8sm280177966b.65.2026.01.29.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 08:53:42 -0800 (PST)
Message-ID: <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
From: Bean Huo <huobean@gmail.com>
To: Alexey Charkov <alchark@flipper.net>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Avri Altman <avri.altman@wdc.com>, Bart Van
 Assche <bvanassche@acm.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, Can Guo
 <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 29 Jan 2026 17:53:41 +0100
In-Reply-To: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-212796-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E4212B2899
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTI5IGF0IDExOjM4ICswNDAwLCBBbGV4ZXkgQ2hhcmtvdiB3cm90ZToK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGhiYS0+ZGV2
X2luZm8ucnBtYl9yZWdpb25fc2l6ZVswXSA9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ2V0X3VuYWxpZ25lZF9iZTY0KGRl
c2NfYnVmCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCsKPiBSUE1CX1VOSVRfREVTQ19QQVJBTV9M
T0dJQ0FMX0JMS19DT1VOVCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8PAo+IGRlc2NfYnVmW1JQTUJfVU5JVF9ERVNDX1BB
UkFNX0xPR0lDQUxfQkxLX1NJWkVdCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPj4gMTc7IC8qIGNvbnZlcnQgdG8gMTI4IGtC
eXRlcyB1bml0cyAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKg
wqDCoMKgwqDCoH0KCkhpIEFsZXhleSwgCgp0aGFua3MgZm9yIHlvdXIgZml4LCBJIGRpZG4ndCBu
b3RpY2UgdGhlcmUgaXMgVUZTIDIueCBvbiB0aGUgbWFya2V0IHdoaWNoIHdpbGwKdXNlIFVGUyBP
UC1URUUgUlBNQiBmcmFtZXdvcmsuCgoKaGVyZSBpcyBwb3RlbnRpYWwgdTggT3ZlcmZsb3csIHNp
bmNlIGZvciB0aGUgVUZTMy54KywgaXQgaXMgdTggaW4gdW5pdApkZXNjcmlwdG9yLCBidXQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCgpUaGUg
Y2FsY3VsYXRpb24gY2FuIG92ZXJmbG93IGZvciBsYXJnZXIgUlBNQiByZWdpb25zICg+MzJNQik6
ICAgICAgICAgICAgICAgICAgCiAgLSBBIHU4IGNhbiBvbmx5IHJlcHJlc2VudCB1cCB0byAyNTUg
w5cgMTI4S0IgPSB+MzJNQiAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgLSBUaGUgc2hpZnQg
cmVzdWx0IGlzIGFzc2lnbmVkIGRpcmVjdGx5IHdpdGhvdXQgYm91bmRzIGNoZWNraW5nCgoKS2lu
ZCByZWdhcmRzLApCZWFuICAgICAgICAgICAgICAgICAK


