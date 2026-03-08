Return-Path: <stable+bounces-223445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHw4Adw5rWndzgEAu9opvQ
	(envelope-from <stable+bounces-223445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 09:57:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51722F188
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2864D3006698
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9E2F361F;
	Sun,  8 Mar 2026 08:56:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA214A8E;
	Sun,  8 Mar 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772960216; cv=none; b=IuhQE3R0dVQosteNQ2M6+Cyi/H40QmG34AsZ197Zoa1G3M7NlJwk0oZ36G6mcHt/iW2zWRNPg9nDX8fBlMnWus5w+sqkR78PxeidhNoYVwZLivu1GBUWsTbT5JO5BgiRtTURV+0c1oDS4BHunogPJIA2kkDO6OUwv/ECT9y58Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772960216; c=relaxed/simple;
	bh=F1zjlA/klZlSHnIVdLeEaaV4ufSsDSYcjiWhkuDStlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=p35HR3uFkZ6SH5s+Sw3rK/2EwyGpI6B77w/z6aXqTJP6QK3yna4t9ZXfr57CueFVj5Ya5LLBXzM5Cbj7zainCcFm8LNh2WvVBAfjlvT1ocSXTw4q+qqxnBz0N31uu2yTpyJuV2uX/+Ut56uQt5o8aJSPo7q97rGsWh0YiQf2Ocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.130.78])
	by mtasvr (Coremail) with SMTP id _____wB3LryoOa1pXPYbAQ--.12670S3;
	Sun, 08 Mar 2026 16:56:09 +0800 (CST)
Received: from 12321260$zju.edu.cn ( [10.190.130.78] ) by
 ajax-webmail-mail-app1 (Coremail) ; Sun, 8 Mar 2026 16:56:08 +0800
 (GMT+08:00)
Date: Sun, 8 Mar 2026 16:56:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5ZC05Yeh?= <12321260@zju.edu.cn>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	heiko@sntech.de, romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: Re: [PATCH] net: ethernet: arc: fix use-after-free in probe
 error path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <b6ac1471-e33a-41d3-9e67-e6463612f05b@lunn.ch>
References: <20260304025303.145493-1-fanwu01@zju.edu.cn>
 <b6ac1471-e33a-41d3-9e67-e6463612f05b@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <54c76f66.7eea7.19ccca93975.Coremail.12321260@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yy_KCgAHo92oOa1pWuiGBg--.30391W
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/1tbiAhIDDWmrLgoMEQADsm
X-CM-DELIVERINFO: =?B?gEDuYgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnavhLs56Y63gVsH20GwZZ/AGh8Wv4MBZHO6jCuJQoOblPSuqe12vv9oeen2DneSXRdoI
	7tVbAR91em3WWX0heT2vHM8yIkrmq1SNzgYBL9NM1zZZwJgA5uvlZHJ5sOtPkQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw4kCryDXr4DXFyUZr4kXwc_yoW8Kryxpa
	yDXF9YkrWDGF10qw4DGas7uFW8X3yxGws8CasYy39xuw15JFyftry7KrWY9r15urWUGw15
	XrWqy34DZa4DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24l
	FcxC0VAYjxAxZF0Ex2IqxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8zMNUUUUUU==
X-Rspamd-Queue-Id: 3E51722F188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[12321260@zju.edu.cn,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,lunn.ch,sntech.de,gmail.com,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable,netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,zju.edu.cn:mid,zju.edu.cn:email]
X-Rspamd-Action: no action

WW91IGFyZSByaWdodCB0aGF0IG5vcm1hbCBkZXZpY2UgaW50ZXJydXB0IGdlbmVyYXRpb24gaXMg
ZW5hYmxlZCBpbiBhcmNfZW1hY19vcGVuKCkgdmlhIFJfRU5BQkxFLCBzbyB3ZSBjZXJ0YWlubHkg
ZG9uJ3QgZXhwZWN0IHJlZ3VsYXIgUlgvVFggdHJhZmZpYyBpbnRlcnJ1cHRzIGR1cmluZyBwcm9i
ZS4KCk15IG1haW4gY29uY2VybiBoZXJlIGlzIHRoZSBsaWZldGltZSBvcmRlcmluZyBpbiB0aGUg
ZXJyb3IgcGF0aC4gYXJjX2VtYWNfcHJvYmUoKSBpbnN0YWxscyB0aGUgSVJRIGhhbmRsZXIgdmlh
IGRldm1fcmVxdWVzdF9pcnEoLi4uLCBuZGV2KSwgYnV0IGlmIGVtYWNfcm9ja2NoaXBfcHJvYmUo
KSBmYWlscyBsYXRlciwgaXQgZXhwbGljaXRseSBjYWxscyBmcmVlX25ldGRldihuZGV2KSB3ZWxs
IGJlZm9yZSB0aGUgZGV2cmVzIGNsZWFudXAgcm91dGluZSBydW5zLgoKSW4gdGhhdCBzcGVjaWZp
YyBnYXAsIGlmIGFuIElSUSBpcyBzb21laG93IGRlbGl2ZXJlZOKAlHBlcmhhcHMgZnJvbSBhIHBl
bmRpbmcvbGF0Y2hlZCBsaW5lIGxlZnQgYnkgdGhlIGZpcm13YXJlL2Jvb3Rsb2FkZXIsIG9yIG90
aGVyIG5vbi10cmFmZmljIGFub21hbGllc+KAlGFyY19lbWFjX2ludHIoKSB3aWxsIGltbWVkaWF0
ZWx5IGRlcmVmZXJlbmNlIGRldl9pZCBhcyBhIHN0cnVjdCBuZXRfZGV2aWNlICouIFNpbmNlIG5k
ZXYgaGFzIGFscmVhZHkgYmVlbiBtYW51YWxseSBmcmVlZCwgdGhpcyByZXN1bHRzIGluIGEgVUFG
LgoKU28gd2hpbGUgSSBjb21wbGV0ZWx5IGFncmVlIHRoaXMgaXNuJ3QgYSBub3JtYWwgcHJlLW9w
ZW4gdHJhZmZpYyBwYXRoLCB0aGUgbWl4ZWQgbGlmZXRpbWUgbWFuYWdlbWVudCAobWFuYWdlZCBJ
UlEgdnMuIG1hbnVhbCBuZXRkZXYgZnJlZSkgc3RpbGwgY3JlYXRlcyBhIHJlYWwgcmFjZSB3aW5k
b3cuCgpTd2l0Y2hpbmcgdG8gZGV2bV9hbGxvY19ldGhlcmRldigpIHB1dHMgYm90aCByZXNvdXJj
ZXMgdW5kZXIgZGV2cmVzIG1hbmFnZW1lbnQsIHBlcm1hbmVudGx5IGZpeGluZyB0aGlzIHRlYXJk
b3duIG9yZGVyaW5nIGlzc3VlLiBJIHdvdWxkIGJlIGhhcHB5IHRvIHNlbmQgYSB2MiBhbmQgcmV3
b3JkIHRoZSBjb21taXQgbG9nIHRvIGVtcGhhc2l6ZSB0aGlzIGFzIGEgcG90ZW50aWFsIHJhY2Ug
d2luZG93IGFuZCBhIGhhcmRlbmluZyBmaXguIExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLgoK
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJvbTogIkFuZHJldyBMdW5uIiA8YW5k
cmV3QGx1bm4uY2g+Cj4gU2VuZCB0aW1lOlRodXJzZGF5LCAwNS8wMy8yMDI2IDA2OjI5OjA1Cj4g
VG86ICJGYW4gV3UiIDxmYW53dTAxQHpqdS5lZHUuY24+Cj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmcsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGt1YmFAa2VybmVsLm9yZywgZWR1bWF6ZXRAZ29v
Z2xlLmNvbSwgcGFiZW5pQHJlZGhhdC5jb20sIGFuZHJldytuZXRkZXZAbHVubi5jaCwgaGVpa29A
c250ZWNoLmRlLCByb21haW4ucGVyaWVyQGdtYWlsLmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnLCBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnLCBzdGFi
bGVAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0OiBldGhlcm5ldDog
YXJjOiBmaXggdXNlLWFmdGVyLWZyZWUgaW4gcHJvYmUgZXJyb3IgcGF0aAo+IAo+IE9uIFdlZCwg
TWFyIDA0LCAyMDI2IGF0IDAyOjUzOjAzQU0gKzAwMDAsIEZhbiBXdSB3cm90ZToKPiA+IFRoZSBh
cmNfZW1hY19wcm9iZSgpIGZ1bmN0aW9uIGNhbGxzIGRldm1fcmVxdWVzdF9pcnEoKSB3aXRoIHRo
ZQo+ID4gbmV0X2RldmljZSBhcyB0aGUgZGV2X2lkLiBIb3dldmVyLCBpbiB0aGUgZXJyb3IgcGF0
aCBvZgo+ID4gZW1hY19yb2NrY2hpcF9wcm9iZSgpLCBmcmVlX25ldGRldihuZGV2KSBpcyBjYWxs
ZWQgYmVmb3JlIHRoZSBkZXZtCj4gPiBjbGVhbnVwIGhhcHBlbnMuIFRoaXMgY3JlYXRlcyBhIHJh
Y2Ugd2luZG93IHdoZXJlIGFuIGludGVycnVwdCBjYW4KPiA+IGZpcmUgYW5kIHRoZSBJU1IgKGFy
Y19lbWFjX2ludHIpIHdpbGwgYWNjZXNzIHRoZSBhbHJlYWR5IGZyZWVkCj4gPiBuZXRfZGV2aWNl
IHN0cnVjdHVyZS4KPiAKPiBJdCBsb29rcyBsaWtlIGludGVycnVwdHMgYXJlIG9ubHkgZW5hYmxl
ZCBpbiBhcmNfZW1hY19vcGVuKCkuIEhhdmUgeW91Cj4gc2VlbiBpbnRlcnJ1cHRzIGJlZm9yZSB0
aGlzPwo+IAo+ICAgICAgQW5kcmV3Cg==


