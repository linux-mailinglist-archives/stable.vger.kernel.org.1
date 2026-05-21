Return-Path: <stable+bounces-253557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH5WKHsKD2omEgYAu9opvQ
	(envelope-from <stable+bounces-253557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:36:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913375A603E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDC732B5B31
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7993E1712;
	Thu, 21 May 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UxJRVosp"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FC3DB318;
	Thu, 21 May 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369235; cv=none; b=HDKKn3OTqqpPbEBryNwl+X6XpGSruLq1pxH5muF2hv/4d06kqJDqpMu8A80fgCV5Kux7RKor2IgeDQGFov9MyTH6Z1oiXa2b0dW8khXal8OvSZ8MqU1kM+yotNq+pXGPXtdbLuZ9XgeWyE/Z4IDR1EuvGV9VIvFSsFIlf9or57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369235; c=relaxed/simple;
	bh=68K++VHTZNynhrRM/dCu5n6ucdedCbWyaLyp29QCAzw=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=HTuhDHsCXeUvToVS8i3pVLq5toUWXk3FzZ3XAPENihdm7q/3EFgwESLyilAj11QFaVO+iDuRflygrYgpnXSv1sOUkmE9tJQSRvKH2K5Nvj8s2ecOeT0/d4I9f/dMdtapkUF82fF0T4PikkSWdU8hxqQM0BIy1PYSNHX63Vi9R/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UxJRVosp; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779369209;
	bh=68K++VHTZNynhrRM/dCu5n6ucdedCbWyaLyp29QCAzw=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=UxJRVospi7J/b3XY47FlwLtMEMlSnnPbdD4QxMh6He5BgsSQGPvRYojIXsAeGSbVc
	 IAOXk1+kzzyD36naMez594ZYwnSFfwh+I0+S3jdVo5e5o/Gfj5/+z7dskBqnGqu3II
	 XdGbL14aDyNhO6kXPLvqDzqoLhmeWTuadpz/UgDI=
X-QQ-mid: zesmtpsz4t1779369200tb62852e2
X-QQ-Originating-IP: lW8mg4gRaaz3/0T85ijHdttNqk9n9OK3iYiv0i6XsHI=
Received: from PEN002676 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 21:13:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3165683158295094582
Date: Thu, 21 May 2026 21:13:19 +0800
From: =?GB2312?B?1dS98MP3?= <zhaojinming@uniontech.com>
To: ilpo.jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: srinivas.pandruvada <srinivas.pandruvada@linux.intel.com>, 
	hansg <hansg@kernel.org>, 
	platform-driver-x86 <platform-driver-x86@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Subject: Re: Re: [PATCH 1/2] platform/x86/intel/tpmi: use cleanup helpers in mem_write()
References: <9de7a91f-2dfa-7a99-9580-378c7a044bce@linux.intel.com>, 
	<20260521035623.1426374-1-zhaojinming@uniontech.com>, 
	<20260521035623.1426374-2-zhaojinming@uniontech.com>, 
	<35a143db-461b-7d2a-2641-4d526bcb4af4@linux.intel.com>
X-Priority: 3
X-GUID: A9BBB1C6-C6FF-4617-80A2-8BD1B93FB183
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <A3B52F4C6600D94E+2026052121131812291323@uniontech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OKkKo7I1HxIeyaBlqlzqbxV3g37/WTkBNgjE9N9lXN2BU4sMuT3ILdC+
	CYv88EtfZxKdJUJM03Ocf6SVAMqiRTLk4xlud6P4UdNcyva/RVZi+0hz1sfp+hpwttyVIvQ
	kZsIc10dhGZctqHpiDAxELYTv5yKhdhQdmh8PD6C8eJSV/RR0/zns524JJ01Uts3PRpqix2
	FnN/W0nrpYeVd2ZSBgqNaVInClAl6f9+1D4jKtui/fjf0AqH98MhFQ5XW1vD/38Iudsjnp2
	q3CHCbFtx0SMmskJqySd1j3eGSOY2tScF1oWZyF3ueKCDbnaiZXJNk6TiT1WqYVeO5OHgID
	fNw2WdXOGTdXqSkEILLJVI8APFkpeKVH14et/i4sS1v0PScqfRZjwGhkmUR54zDf+RGEnIQ
	E2PYd2jaagA1hkHomasgA7wzzZt0NeKlOfOB15TvA7+XhQ8m0xfBxKl9O7mvKki8uBJqbNg
	+oWroExoDt5NHzredIE1ojcSW+I/NCf52mG36jkx9a44mYB644BklEgeCuXvj0CZFT6jtM1
	3PYMLzKRD7dQDU6HbytEU2zYhkAdhsoe5B/Yb0qnopTYeuFKDwRQj9gPbTjpEB+gmpnzqEO
	NxBAcsaWRzICKmD42xoEUCX1tD2P29yky3WUJ4IXPoNrW7TbDe1Ms2NKsN/DCHmFa3yXpd2
	V1iiZ68b9tzrYnOoy/lq6bcCieDOp9a26OUj8+rKGNhgubeQTNLxwvLhYOxzYiis1A27Y/M
	M2LzAu8Vibg4hKM8tiDC3dpQrsjSAxGhsVRQzp/vDBo8n/3BcntIeGz3IFy3DTbqyHHVglQ
	hcUtVXfjqEeybXEO41q8Suk8v9+03l+X9aaCNUUxhqDCag3Wt0GUqZ/VkboKYvUrPhSqLbo
	Sj+J+RNF46HkfNclMBp5ccViJwjQ156sSWIw898fbSIVdJFGG6tQgoN/9Bpzz0ubntnL1D8
	SxdbBQgvCqim6gEh5wAAZ13lCslviZcm9OoZ8DD+4eyeFQ1iA6CtzuhlT7aXFIL7pohf2J2
	l0zs53HB3e03lZZRfrJHMuyW/E1PpXTLqjGnVe4w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253557-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: 913375A603E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgoKCj5PbiBUaHUsIDIxIE1heSAyMDI2LCBaaGFvSmlubWluZyB3cm90ZToKCgoKPgoKCgo+PiBJ
biBtZW1fd3JpdGUoKSwgdGhlIHRlbXBvcmFyeSBhcnJheSByZXR1cm5lZCBieQoKCgo+PiBwYXJz
ZV9pbnRfYXJyYXlfdXNlcigpIG11c3QgYmUgcmVsZWFzZWQgb24gYWxsIGV4aXQgcGF0aHMuCgoK
Cj4+IENvbnZlcnQgdGhlIGFycmF5IHZhcmlhYmxlIHRvIHVzZSBjbGVhbnVwLmggc2NvcGUtYmFz
ZWQKCgoKPj4gY2xlYW51cCBzbyBpdCBpcyBmcmVlZCBhdXRvbWF0aWNhbGx5IG9uIHJldHVybi4K
CgoKPj4gCgoKCj4+IFRoaXMgYWxzbyBtb3ZlcyB0aGUgYXJyYXkgZGVjbGFyYXRpb24gbmV4dCB0
bwoKCgo+PiBwYXJzZV9pbnRfYXJyYXlfdXNlcigpIGFzIHJlcXVpcmVkIGJ5IGNsZWFudXAuaCB1
c2FnZQoKCgo+PiBndWlkZWxpbmVzLgoKCgo+CgoKCj5Ob3cgeW91IG1hZGUgdGhlc2UgbXVjaCBz
aG9ydGVyIHRoYW4gNzIgY2hhcnMuIDotKAoKCgo+CgoKCj4+IEZpeGVzOiA4ZTBhMmZjNjhlYzMg
KCJwbGF0Zm9ybS94ODYvaW50ZWwvdHBtaTogVXNlIDMyIGJpdCBhbGlnbmVkIGFkZHJlc3MgZm9y
IGRlYnVnZnMgbWVtIHdyaXRlIikKCgoKPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKCgoK
Pj4gU2lnbmVkLW9mZi1ieTogWmhhb0ppbm1pbmcgPHpoYW9qaW5taW5nQHVuaW9udGVjaC5jb20+
CgoKCj4+IC0tLQoKCgo+Pj8gZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvdnNlY190cG1pLmMg
fCAyNSArKysrKysrKystLS0tLS0tLS0tLS0tLS0tCgoKCj4+PyAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCgoKPj4gCgoKCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92c2VjX3RwbWkuYyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL3ZzZWNfdHBtaS5jCgoKCj4+IGluZGV4IDE2ZmQ3YWE0MWYyMC4uODhmMTRkMGFk
NDEwIDEwMDY0NAoKCgo+PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92c2VjX3Rw
bWkuYwoKCgo+PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92c2VjX3RwbWkuYwoK
Cgo+PiBAQCAtNTAsNiArNTAsNyBAQAoKCgo+Pj8gI2luY2x1ZGUgPGxpbnV4L2F1eGlsaWFyeV9i
dXMuaD4KCgoKPj4/ICNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPgoKCgo+Pj8gI2luY2x1ZGUg
PGxpbnV4L2RlYnVnZnMuaD4KCgoKPj4gKyNpbmNsdWRlIDxsaW51eC9jbGVhbnVwLmg+CgoKCj4+
PyAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KCgoKPj4/ICNpbmNsdWRlIDxsaW51eC9pbnRlbF90
cG1pLmg+CgoKCj4+PyAjaW5jbHVkZSA8bGludXgvaW50ZWxfdnNlYy5oPgoKCgo+PiBAQCAtNDcz
LDcgKzQ3NCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1lbV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y29uc3QgY2hhciBfX3VzZXIgKnVzZXJidWYsIHNpemVfdCBsCgoKCj4+PyAJc3RydWN0IHNlcV9m
aWxlICptID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwoKCgo+Pj8gCXN0cnVjdCBpbnRlbF90cG1pX3Bt
X2ZlYXR1cmUgKnBmcyA9IG0tPnByaXZhdGU7CgoKCj4+PyAJdTMyIGFkZHIsIHZhbHVlLCBwdW5p
dCwgc2l6ZTsKCgoKPj4gLQl1MzIgbnVtX2VsZW1zLCAqYXJyYXk7CgoKCj4+ICsJdTMyIG51bV9l
bGVtczsKCgoKPj4/IAl2b2lkIF9faW9tZW0gKm1lbTsKCgoKPj4/IAlpbnQgcmV0OwoKCgo+Pj8g
CgoKCj4+IEBAIC00ODEsMTUgKzQ4MiwxNCBAQCBzdGF0aWMgc3NpemVfdCBtZW1fd3JpdGUoc3Ry
dWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICp1c2VyYnVmLCBzaXplX3QgbAoKCgo+
Pj8gCWlmICghc2l6ZSkKCgoKPj4/IAkJcmV0dXJuIC1FSU87CgoKCj4+PyAKCgoKPj4gKwl1MzIg
KmFycmF5IF9fZnJlZShrZnJlZSkgPSBOVUxMOwoKCgo+Pj8gCXJldCA9IHBhcnNlX2ludF9hcnJh
eV91c2VyKHVzZXJidWYsIGxlbiwgKGludCAqKikmYXJyYXkpOwoKCgo+Pj8gCWlmIChyZXQgPCAw
KQoKCgo+Pj8gCQlyZXR1cm4gcmV0OwoKCgo+Pj8gCgoKCj4+PyAJbnVtX2VsZW1zID0gKmFycmF5
OwoKCgo+PiAtCWlmIChudW1fZWxlbXMgIT0gMykgewoKCgo+PiAtCQlyZXQgPSAtRUlOVkFMOwoK
Cgo+PiAtCQlnb3RvIGV4aXRfd3JpdGU7CgoKCj4+IC0JfQoKCgo+PiArCWlmIChudW1fZWxlbXMg
IT0gMykKCgoKPj4gKwkJcmV0dXJuIC1FSU5WQUw7CgoKCj4+PyAKCgoKPj4/IAlwdW5pdCA9IGFy
cmF5WzFdOwoKCgo+Pj8gCWFkZHIgPSBhcnJheVsyXTsKCgoKPj4gQEAgLTQ5OCwxNSArNDk4LDEx
IEBAIHN0YXRpYyBzc2l6ZV90IG1lbV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hh
ciBfX3VzZXIgKnVzZXJidWYsIHNpemVfdCBsCgoKCj4+PyAJaWYgKCFJU19BTElHTkVEKGFkZHIs
IHNpemVvZih1MzIpKSkKCgoKPj4/IAkJcmV0dXJuIC1FSU5WQUw7CgoKCj4+PyAKCgoKPj4gLQlp
ZiAocHVuaXQgPj0gcGZzLT5wZnNfaGVhZGVyLm51bV9lbnRyaWVzKSB7CgoKCj4+IC0JCXJldCA9
IC1FSU5WQUw7CgoKCj4+IC0JCWdvdG8gZXhpdF93cml0ZTsKCgoKPj4gLQl9CgoKCj4+ICsJaWYg
KHB1bml0ID49IHBmcy0+cGZzX2hlYWRlci5udW1fZW50cmllcykKCgoKPj4gKwkJcmV0dXJuIC1F
SU5WQUw7CgoKCj4+PyAKCgoKPj4gLQlpZiAoYWRkciA+PSBzaXplKSB7CgoKCj4+IC0JCXJldCA9
IC1FSU5WQUw7CgoKCj4+IC0JCWdvdG8gZXhpdF93cml0ZTsKCgoKPj4gLQl9CgoKCj4+ICsJaWYg
KGFkZHIgPj0gc2l6ZSkKCgoKPj4gKwkJcmV0dXJuIC1FSU5WQUw7CgoKCj4+PyAKCgoKPj4/IAlt
dXRleF9sb2NrKCZ0cG1pX2Rldl9sb2NrKTsKCgoKPj4/IAoKCgo+PiBAQCAtNTI1LDkgKzUyMSw2
IEBAIHN0YXRpYyBzc2l6ZV90IG1lbV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hh
ciBfX3VzZXIgKnVzZXJidWYsIHNpemVfdCBsCgoKCj4+PyB1bmxvY2tfbWVtX3dyaXRlOgoKCgo+
Pj8gCW11dGV4X3VubG9jaygmdHBtaV9kZXZfbG9jayk7CgoKCj4+PyAKCgoKPj4gLWV4aXRfd3Jp
dGU6CgoKCj4+IC0Ja2ZyZWUoYXJyYXkpOwoKCgo+PiAtCgoKCj4+PyAJcmV0dXJuIHJldDsKCgoK
Pj4/IH0KCgoKPj4/IAoKCgo+PiAKCgoKPgoKCgo+VGhlIGNvZGUgY2hhbmdlIGxvb2tzIG9rYXkg
bm93LgoKCgo+CgoKCj5CVVQsIHBsZWFzZSBzZW5kIHRoZSBuZXh0IHZlcnNpb24gcHJvcGVybHkg
dmVyc2lvbmVkIChpdCAidjQiIG9yIHNvIGluIAoKCgo+aXQncyBzdWJqZWN0LCBJIHRoaW5rKSBh
bmQgaW4gYSBmcmVzaCB0aHJlYWQuIEFzIGlzLCBiNCBnZXRzIGNvbmZ1c2VkIAoKCgo+d2hpY2gg
cGF0Y2hlcyBhcmUgdGhlIGxhdGVzdCB2ZXJzaW9uIHNvIEkgY2Fubm90IGFwcGx5IHRoZXNlIHdp
dGggbXkgCgoKCj5tYWludGFpbmVyIHRvb2xzLgoKCgo+CgpUaGFua3MgZm9yIHlvdXIgcmVwbHku
CkkndmUgc2VudCB0aGUgdjQgcGF0Y2hlcyBpbiBhIG5ldyB0aHJlYWQuCgoKPi0tIAoKCgo+IGku
CgoKCj4KCgoKPgoKCg==


