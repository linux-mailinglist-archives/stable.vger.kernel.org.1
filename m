Return-Path: <stable+bounces-10822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881082CE4E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D7E1C210F2
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA263B3;
	Sat, 13 Jan 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="hFoxloZe"
X-Original-To: stable@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59F63A6
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=4114; s=dkim-tub; t=1705174028;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b9fJikpYCnNONhCw+bFmkc7caL8HTLEf1EylWV7eMBU=;
  b=hFoxloZexVz43l1pyiav1sKpiiDp1+XTjdftzw1Pn8hH/2+nES94ujb0
   qVS02bTEjrYbKdNCW6OdQVaTGBKKu8x0ThiAgWikFNgUmy8KawmNRWX8z
   7Nb6gGYJdMdBcFix6xxm4AEmcXW3VEmQ7aHg4EciZEUf7NENoqEV3k5sK
   w=;
X-CSE-ConnectionGUID: sJ3GttmKSb6Vxxt3O/P9bw==
X-CSE-MsgGUID: R8Xq9vUnRsWE43VV4R1wKQ==
X-IronPort-AV: E=Sophos;i="6.04,192,1695679200"; 
   d="scan'208";a="16301829"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 13 Jan 2024 20:25:56 +0100
Message-ID: <27f5543f5c6023ce0d9bc6161aef9e37cc720a02.camel@mailbox.tu-berlin.de>
Subject: Re: [PATCH 5.10 09/43] net: Implement missing
 getsockopt(SO_TIMESTAMPING_NEW)
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, Willem de Bruijn <willemb@google.com>, "David
	S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>
Date: Sat, 13 Jan 2024 20:25:54 +0100
In-Reply-To: <20240113094207.231546964@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
	 <20240113094207.231546964@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgR3JlZywKCnRoaXMgcGF0Y2ggaXMgYXBwbGllZCBpbiB0aGUgd3JvbmcgcGxhY2UgKHRoZSB3
cm9uZyBjYXNlKSBoZXJlIGluCnNvY2tfZ2V0c29ja29wdCgpLiBUaGUgZnVuY3Rpb24gc2VlbXMg
dG8gaGF2ZSBjaGFuZ2VkIGluIGEgbnVtYmVyIG9mCnBsYWNlcyBhZnRlciA1LjEwLCBhcHBhcmVu
dGx5IHRvbyBtdWNoIGZvciBhbiBhdXRvbWF0aWMoPyEpIG1lcmdlLgoKT24gU2F0LCAyMDI0LTAx
LTEzIGF0IDEwOjQ5ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gNS4xMC1zdGFi
bGUgcmV2aWV3IHBhdGNoLsKgIElmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBs
ZXQKPiBtZSBrbm93Lgo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IEZyb206IErDtnJuLVRo
b3JiZW4gSGlueiA8anRoaW56QG1haWxib3gudHUtYmVybGluLmRlPgo+IAo+IFsgVXBzdHJlYW0g
Y29tbWl0IDdmNmNhOTVkMTZiOTY1NjdjZTRjZjQ1OGEyNzkwZmYxN2ZhNjIwYzMgXQo+IAo+IENv
bW1pdCA5NzE4NDc1ZTY5MDggKCJzb2NrZXQ6IEFkZCBTT19USU1FU1RBTVBJTkdfTkVXIikgYWRk
ZWQgdGhlIG5ldwo+IHNvY2tldCBvcHRpb24gU09fVElNRVNUQU1QSU5HX05FVy4gU2V0dGluZyB0
aGUgb3B0aW9uIGlzIGhhbmRsZWQgaW4KPiBza19zZXRzb2Nrb3B0KCksIHF1ZXJ5aW5nIGl0IHdh
cyBub3QgaGFuZGxlZCBpbiBza19nZXRzb2Nrb3B0KCksCj4gdGhvdWdoLgo+IAo+IEZvbGxvd2lu
ZyByZW1hcmtzIG9uIGFuIGVhcmxpZXIgc3VibWlzc2lvbiBvZiB0aGlzIHBhdGNoLCBrZWVwIHRo
ZQo+IG9sZAo+IGJlaGF2aW9yIG9mIGdldHNvY2tvcHQoU09fVElNRVNUQU1QSU5HX09MRCkgd2hp
Y2ggcmV0dXJucyB0aGUgYWN0aXZlCj4gZmxhZ3MgZXZlbiBpZiB0aGV5IGFjdHVhbGx5IGhhdmUg
YmVlbiBzZXQgdGhyb3VnaAo+IFNPX1RJTUVTVEFNUElOR19ORVcuCj4gCj4gVGhlIG5ldyBnZXRz
b2Nrb3B0KFNPX1RJTUVTVEFNUElOR19ORVcpIGlzIHN0cmljdGVyLCByZXR1cm5pbmcgZmxhZ3MK
PiBvbmx5IGlmIHRoZXkgaGF2ZSBiZWVuIHNldCB0aHJvdWdoIHRoZSBzYW1lIG9wdGlvbi4KPiAK
PiBGaXhlczogOTcxODQ3NWU2OTA4ICgic29ja2V0OiBBZGQgU09fVElNRVNUQU1QSU5HX05FVyIp
Cj4gTGluazoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNzAzMTc1MDQ4LjE1
MTY4My0xLWp0aGluekBtYWlsYm94LnR1LWJlcmxpbi5kZS8KPiBMaW5rOgo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL25ldGRldi8wZDdjZGRjOS0wM2ZhLTQzZGItYTU3OS0xNGYzZTgyMjYxNWJA
YXBwLmZhc3RtYWlsLmNvbS8KPiBTaWduZWQtb2ZmLWJ5OiBKw7Zybi1UaG9yYmVuIEhpbnogPGp0
aGluekBtYWlsYm94LnR1LWJlcmxpbi5kZT4KPiBSZXZpZXdlZC1ieTogV2lsbGVtIGRlIEJydWlq
biA8d2lsbGVtYkBnb29nbGUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFMuIE1pbGxlciA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFs
QGtlcm5lbC5vcmc+Cj4gLS0tCj4gwqBuZXQvY29yZS9zb2NrLmMgfCAxMSArKysrKysrKystLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvc29jay5jIGIvbmV0L2NvcmUvc29jay5jCj4gaW5kZXggYTA2
OWI1NDc2ZGY0Ni4uOWMzYmMyNGJmZGQxZiAxMDA2NDQKPiAtLS0gYS9uZXQvY29yZS9zb2NrLmMK
PiArKysgYi9uZXQvY29yZS9zb2NrLmMKPiBAQCAtMTM4Myw5ICsxMzgzLDE2IEBAIGludCBzb2Nr
X2dldHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50Cj4gbGV2ZWwsIGludCBvcHRuYW1l
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgY2FzZSBTT19MSU5HRVI6Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBTT19USU1FU1RB
TVBJTkdfTkVXOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbHbCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPSBzaXplb2Yodi5saW5nKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdi5saW5nLmxfb25vZmbCoMKgPSBzb2NrX2ZsYWcoc2ssIFNPQ0tfTElOR0VS
KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdi5saW5nLmxfbGluZ2VywqA9IHNr
LT5za19saW5nZXJ0aW1lIC8gSFo7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IEZvciB0aGUgbGF0ZXItYWRkZWQgY2FzZSBTT19USU1FU1RBTVBJTkdfTkVXOiBCZQo+IHN0cmlj
dCBhYm91dCBvbmx5Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJldHVybmlu
ZyB0aGUgZmxhZ3Mgd2hlbiB0aGV5IHdlcmUgc2V0IHRocm91Z2ggdGhlCj4gc2FtZSBvcHRpb24u
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIERvbid0IGNoYW5nZSB0aGUgYmV2
aW91ciBmb3IgdGhlIG9sZCBjYXNlCj4gU09fVElNRVNUQU1QSU5HX09MRC4KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChvcHRuYW1lID09IFNPX1RJTUVTVEFNUElOR19PTEQgfHwgc29ja19mbGFnKHNrLAo+IFNP
Q0tfVFNUQU1QX05FVykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHYubGluZy5sX29ub2ZmwqDCoD0gc29ja19mbGFnKHNrLCBTT0NLX0xJTkdFUik7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2Lmxpbmcu
bF9saW5nZXLCoD0gc2stPnNrX2xpbmdlcnRpbWUgLyBIWjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBTT19CU0RDT01QQVQ6Cgo=


