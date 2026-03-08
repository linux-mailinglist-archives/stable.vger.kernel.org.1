Return-Path: <stable+bounces-223465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCaZBYvXrWl+8AEAu9opvQ
	(envelope-from <stable+bounces-223465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 21:09:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCB232149
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 21:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E092630137A1
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 20:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F93806B3;
	Sun,  8 Mar 2026 20:07:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0E33BBCD;
	Sun,  8 Mar 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000456; cv=none; b=gXTjuc6O1PoP0Mbb2Klwq9STaCCH90XWwt+TzhCSCm2uRXuK7eX17g8z/mWtDVOjReFVzdlG3gGGU13J+DN2bNHaQ2ChPtSXV4VO+taIMN1F355zai9ghg4GmlE9aC+mTYIGZhM7mSJ1Tdr4gvEJzGTwFSDPS3zftxd3wgNpgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000456; c=relaxed/simple;
	bh=fLKyKGq63ZCK3PVesUP/vodqbMzixzFiK4TbxvT27P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nzlYY0LbhGD+QzqLuEIc9uUVnycGUqWTAyFMtdtxcdn/05aohKoU6z+IW12TrLWTAAYWX62vsEgqXy46/WkPdkcmKaheHiJY9lYuJF8tdqGt2MtRsv8uv+s7lFG+c0kTploIkE2gikFdiUrWzlBmyyFWRD87bA5kLEK9qjSt8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.130.87])
	by mtasvr (Coremail) with SMTP id _____wB3Lrzf1q1pqukdAQ--.16979S3;
	Mon, 09 Mar 2026 04:06:56 +0800 (CST)
Received: from 12321260$zju.edu.cn ( [10.190.130.87] ) by
 ajax-webmail-mail-app1 (Coremail) ; Mon, 9 Mar 2026 04:06:55 +0800
 (GMT+08:00)
Date: Mon, 9 Mar 2026 04:06:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Fan Wu" <12321260@zju.edu.cn>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	heiko@sntech.de, romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: Re: Re: [PATCH] net: ethernet: arc: fix use-after-free in probe
 error path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <1bb942f0-d512-4834-bf01-49f9a9d7fd77@lunn.ch>
References: <20260304025303.145493-1-fanwu01@zju.edu.cn>
 <b6ac1471-e33a-41d3-9e67-e6463612f05b@lunn.ch>
 <54c76f66.7eea7.19ccca93975.Coremail.12321260@zju.edu.cn>
 <1bb942f0-d512-4834-bf01-49f9a9d7fd77@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25daeba9.7f281.19ccf0f59f3.Coremail.12321260@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yy_KCgBn4Nnf1q1p1fKIBg--.30948W
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/1tbiAg8EDWmsf4oVgwADsh
X-CM-DELIVERINFO: =?B?ui4qEQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnYTMMGvVyEqe86yjUAhfmuZw2WnZegpMf+SOFXz9Fe3OtH2NOZxdZRk3YOwYazlePWQx
	OfbQzA1pDniT4tK90dCAOI9aDl/2e0ak3u7pYSLUVVAK1/h6/Lh5AHiAharkZg==
X-Coremail-Antispam: 1Uk129KBj93XoWxWr4fZFy5uw1kGw13AFWkGrX_yoWrCw4DpF
	WDKasYkF4DJF10yws7Ga1FkFykA3yxJr45C3s5Jw1DZw15Xa4IkryIgrW5uFy3urWDGw1a
	qr40v34kXayDAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUHIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wACY4xI67k04243AVAKzVAKj4xx
	M4xvF2IEb7IF0Fy26I8I3I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07j1iiDUUUUU=
X-Rspamd-Queue-Id: 6BBCB232149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223465-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable,netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:mid,zju.edu.cn:email,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

SGkgQW5kcmV3LAoKVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb27igJR0aGF0IG1h
a2VzIGEgbG90IG9mIHNlbnNlLgoKSSBhZ3JlZSB0aGUgZGV2bSBjb252ZXJzaW9uIGlzIG5vdCB0
aGUgcmlnaHQgYXBwcm9hY2ggZm9yIHRoaXMgdHJlZS4gSSdsbCBwcmVwYXJlIGEgdjIgcGF0Y2gg
dGFyZ2V0aW5nIG5ldCB0aGF0IGltcGxlbWVudHMgYSBtaW5pbWFsIGhhcmR3YXJlLWxldmVsIGZp
eC4KCkZvbGxvd2luZyB5b3VyIGFkdmljZSwgSSB3aWxsIG1ha2Ugc3VyZSB0aGUgaW50ZXJydXB0
cyBhcmUgcHV0IGludG8gYSBrbm93biBkaXNhYmxlZCBhbmQgY2xlYXJlZCBzdGF0ZSBpbiBhcmNf
ZW1hY19wcm9iZSgpIGJlZm9yZSB3ZSByZXF1ZXN0IHRoZSBJUlEuIFRoaXMgd2lsbCBjb21wbGV0
ZWx5IGVsaW1pbmF0ZSB0aGUgcG9zc2liaWxpdHkgb2YgYW4gSVJRIGRlbGl2ZXJ5IGFnYWluc3Qg
YSBmcmVlZCBuZGV2IGR1cmluZyB0aGUgcHJvYmUgZXJyb3IgcGF0aCB0ZWFyZG93bi4KCkkgd2ls
bCB1cGRhdGUgdGhlIGNoYW5nZWxvZyBhY2NvcmRpbmdseSB0byBub3RlIHRoYXQgdGhpcyByYWNl
IGhhcyBiZWVuIHRoZXJlIGZyb20gdGhlIGJlZ2lubmluZyBhbmQgZW5zdXJlIHRoZSBwcm9wZXIg
Rml4ZXM6IHRhZyBpcyBhZGRlZCBmb3IgdGhlIHN0YWJsZSBiYWNrcG9ydHMuCgpUaGFua3MsIApG
YW4gV3UKCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJBbmRyZXcgTHVu
biIgPGFuZHJld0BsdW5uLmNoPgo+IFNlbmQgdGltZTpNb25kYXksIDA5LzAzLzIwMjYgMDE6NTk6
NDYKPiBUbzog5ZC05YehIDwxMjMyMTI2MEB6anUuZWR1LmNuPgo+IENjOiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnLCBkYXZlbUBkYXZlbWxvZnQubmV0LCBrdWJhQGtlcm5lbC5vcmcsIGVkdW1hemV0
QGdvb2dsZS5jb20sIHBhYmVuaUByZWRoYXQuY29tLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGhl
aWtvQHNudGVjaC5kZSwgcm9tYWluLnBlcmllckBnbWFpbC5jb20sIGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZywg
c3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBSZTogW1BBVENIXSBuZXQ6IGV0
aGVybmV0OiBhcmM6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBwcm9iZSBlcnJvciBwYXRoCj4gCj4g
T24gU3VuLCBNYXIgMDgsIDIwMjYgYXQgMDQ6NTY6MDhQTSArMDgwMCwg5ZC05YehIHdyb3RlOgo+
ID4gWW91IGFyZSByaWdodCB0aGF0IG5vcm1hbCBkZXZpY2UgaW50ZXJydXB0IGdlbmVyYXRpb24g
aXMgZW5hYmxlZCBpbiBhcmNfZW1hY19vcGVuKCkgdmlhIFJfRU5BQkxFLCBzbyB3ZSBjZXJ0YWlu
bHkgZG9uJ3QgZXhwZWN0IHJlZ3VsYXIgUlgvVFggdHJhZmZpYyBpbnRlcnJ1cHRzIGR1cmluZyBw
cm9iZS4KPiA+IAo+ID4gTXkgbWFpbiBjb25jZXJuIGhlcmUgaXMgdGhlIGxpZmV0aW1lIG9yZGVy
aW5nIGluIHRoZSBlcnJvciBwYXRoLiBhcmNfZW1hY19wcm9iZSgpIGluc3RhbGxzIHRoZSBJUlEg
aGFuZGxlciB2aWEgZGV2bV9yZXF1ZXN0X2lycSguLi4sIG5kZXYpLCBidXQgaWYgZW1hY19yb2Nr
Y2hpcF9wcm9iZSgpIGZhaWxzIGxhdGVyLCBpdCBleHBsaWNpdGx5IGNhbGxzIGZyZWVfbmV0ZGV2
KG5kZXYpIHdlbGwgYmVmb3JlIHRoZSBkZXZyZXMgY2xlYW51cCByb3V0aW5lIHJ1bnMuCj4gPiAK
PiA+IEluIHRoYXQgc3BlY2lmaWMgZ2FwLCBpZiBhbiBJUlEgaXMgc29tZWhvdyBkZWxpdmVyZWTi
gJRwZXJoYXBzIGZyb20gYSBwZW5kaW5nL2xhdGNoZWQgbGluZSBsZWZ0IGJ5IHRoZSBmaXJtd2Fy
ZS9ib290bG9hZGVyLCBvciBvdGhlciBub24tdHJhZmZpYyBhbm9tYWxpZXPigJRhcmNfZW1hY19p
bnRyKCkgd2lsbCBpbW1lZGlhdGVseSBkZXJlZmVyZW5jZSBkZXZfaWQgYXMgYSBzdHJ1Y3QgbmV0
X2RldmljZSAqLiBTaW5jZSBuZGV2IGhhcyBhbHJlYWR5IGJlZW4gbWFudWFsbHkgZnJlZWQsIHRo
aXMgcmVzdWx0cyBpbiBhIFVBRi4KPiA+IAo+ID4gU28gd2hpbGUgSSBjb21wbGV0ZWx5IGFncmVl
IHRoaXMgaXNuJ3QgYSBub3JtYWwgcHJlLW9wZW4gdHJhZmZpYyBwYXRoLCB0aGUgbWl4ZWQgbGlm
ZXRpbWUgbWFuYWdlbWVudCAobWFuYWdlZCBJUlEgdnMuIG1hbnVhbCBuZXRkZXYgZnJlZSkgc3Rp
bGwgY3JlYXRlcyBhIHJlYWwgcmFjZSB3aW5kb3cuCj4gPiAKPiA+IFN3aXRjaGluZyB0byBkZXZt
X2FsbG9jX2V0aGVyZGV2KCkgcHV0cyBib3RoIHJlc291cmNlcyB1bmRlciBkZXZyZXMgbWFuYWdl
bWVudCwgcGVybWFuZW50bHkgZml4aW5nIHRoaXMgdGVhcmRvd24gb3JkZXJpbmcgaXNzdWUuIEkg
d291bGQgYmUgaGFwcHkgdG8gc2VuZCBhIHYyIGFuZCByZXdvcmQgdGhlIGNvbW1pdCBsb2cgdG8g
ZW1waGFzaXplIHRoaXMgYXMgYSBwb3RlbnRpYWwgcmFjZSB3aW5kb3cgYW5kIGEgaGFyZGVuaW5n
IGZpeC4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCj4gCj4gaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sI2NsZWFu
LXVwLXBhdGNoZXMKPiAKPiAgIDEuNy40LiBDbGVhbi11cCBwYXRjaGVzwrYKPiAKPiAgIE5ldGRl
diBkaXNjb3VyYWdlcyBwYXRjaGVzIHdoaWNoIHBlcmZvcm0gc2ltcGxlIGNsZWFuLXVwcywgd2hp
Y2ggYXJlCj4gICBub3QgaW4gdGhlIGNvbnRleHQgb2Ygb3RoZXIgd29yay4gRm9yIGV4YW1wbGU6
Cj4gCj4gICBBZGRyZXNzaW5nIGNoZWNrcGF0Y2gucGwsIGFuZCBvdGhlciB0cml2aWFsIGNvZGlu
ZyBzdHlsZSB3YXJuaW5ncwo+IAo+ICAgQWRkcmVzc2luZyBMb2NhbCB2YXJpYWJsZSBvcmRlcmlu
ZyBpc3N1ZXMKPiAKPiAgIENvbnZlcnNpb25zIHRvIGRldmljZS1tYW5hZ2VkIEFQSXMgKGRldm1f
IGhlbHBlcnMpCj4gCj4gICBUaGlzIGlzIGJlY2F1c2UgaXQgaXMgZmVsdCB0aGF0IHRoZSBjaHVy
biB0aGF0IHN1Y2ggY2hhbmdlcyBwcm9kdWNlCj4gICBjb21lcyBhdCBhIGdyZWF0ZXIgY29zdCB0
aGFuIHRoZSB2YWx1ZSBvZiBzdWNoIGNsZWFuLXVwcy4KPiAKPiAKPiBTb21lIHBlcmNlbnRhZ2Ug
b2YgZGV2bV8gY29udmVyc2F0aW9uIHBhdGNoZXMgYnJlYWsgZHJpdmVycy4gV2UKPiBSZXZpZXdl
cnMgbmVlZCB0byBsb29rIGF0IGFsbCBzdWNoIHBhdGNoZXMgYW5kIHRyeSB0byBkZXRlY3Qgc3Vj
aAo+IGJyZWFrYWdlLiBJbiBnZW5lcmFsLCBpdCBpcyBub3Igd29ydGggaXQuIEhlbmNlIHdlIGdl
bmVyYWxseSByZWplY3QKPiBwYXRjaGVzIGxpa2UgdGhpcy4KPiAKPiBUaGlzIGlzIGhvd2V2ZXIg
c2xpZ2h0bHkgZGlmZmVyZW50LiBJdCBsb29rcyBsaWtlIHRoaXMgZHJpdmVyIHdhcwo+IGJyb2tl
biBmcm9tIHRoZSBiZWdpbm5pbmcuIFRoZSByYWNlIHlvdSBwb2ludCBvdXQgaGFzIGFsd2F5cyBi
ZWVuCj4gdGhlcmUuIFRoYXQgaXMgc29tZXRoaW5nIHdvcnRoIHBvaW50aW5nIG91dCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UuCj4gCj4gQnV0IHRha2UgYSBzdGVwIGJhY2suIFRoaW5rIGFib3V0IGlu
dGVycnVwdCBoYW5kbGluZyBpbiBnZW5lcmFsLiBEbwo+IHlvdSB0aGluayBpdCBpcyBnb29kIHBy
YWN0aWNlIHRvIHJlcXVlc3QgaW50ZXJydXB0cyBiZWZvcmUgY29uZmlndXJpbmcKPiB0aGUgaGFy
ZHdhcmUgYWJvdXQgd2hhdCBpbnRlcnJ1cHRzIGl0IHdpbGwgZGVsaXZlcj8KPiAKPiBJZiB0aGUg
ZHJpdmVyIHdyb3RlIHRvIFJfRU5BQkxFIGluIHByb2JlLCBiZWZvcmUgcmVxdWVzdGluZyB0aGUK
PiBpbnRlcnJ1cHQsIGVuYWJsZWQgdGhlIG5lZWRlZCBpbnRlcnJ1cHRzIGluIG9wZW4sIGRpc2Fi
bGVkIHRoZQo+IGludGVycnVwdHMgaW4gY2xvc2UsIHRoZSBkaWZmZXJlbnQgbGlmZXRpbWVzIHdv
dWxkIG5vdCBtYXR0ZXIuCj4gCj4gU28sIGZvciBzdGFibGUsIHBsZWFzZSBhZGQgY29kZSB0byBw
dXQgaW50ZXJydXB0cyBpbnRvIGEgd2VsbCBrbm93bgo+IHN0YXRlIGJlZm9yZSByZXF1ZXN0aW5n
IHRoZSBpbnRlcnJ1cHQuIFBsZWFzZSB1c2UgdGhlIG5ldCB0cmVlLCBhbmQKPiBhZGQgYSBGaXhl
czogdGFnLgo+IAo+IFlvdSBjYW4gc3VibWl0IHRoaXMgcGF0Y2ggdG8gbmV0LW5leHQsIGJ1dCB3
ZSBtaWdodCByZWplY3QgaXQsIGJlY2F1c2UKPiBvZiB0aGUgcG9saWN5LiBJZiB5b3UgYXJlIHdv
cmtpbmcgb24gdGhpcyBkcml2ZXIsIGFkZGluZyBvdGhlcgo+IGZlYXR1cmVzLCB0aGlzIHBhdGNo
IGlzIHBhcnQgb2YgYSBiaWdnZXIgcGF0Y2hzZXQsIHdlIGFyZSBtb3JlIGxpa2VseQo+IHRvIGFj
Y2VwdCBpdC4KPiAKPiAgICAgQW5kcmV3Cj4gCj4gLS0tCj4gcHctYm90OiBjcgo=


