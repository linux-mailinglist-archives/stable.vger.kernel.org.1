Return-Path: <stable+bounces-145076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8139ABD943
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A03BA822
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6C242D8E;
	Tue, 20 May 2025 13:22:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE92417C3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747334; cv=none; b=m1q+BcWFzT3M9R38kFaazLDkNP+y3wPthVNjHNJpR/LXXudw+vcRYUEUBW0+ze6Qivq+G1BIqBkhSzqSdHsZ+uk/vSEI0ace7kXFqVoHxlmmlHEOX6h8a5NHAKTScnaYf/WcsuBdQI4rdMBBX5Oy+MdFwyurC2oRNxCF7Av4s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747334; c=relaxed/simple;
	bh=8oC6S2aKoaZZgv4kOOTBYo5lLsWoOK+1M3gZrjjU3fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=m28d2H/oxKHGMPxqdws9RnI5fKz2lSpsOIWC4EO4KtdH9+/iauGO+cOy0yYl4n/konQBeAyb94uP+HxTWHY1xG+MsPsFR1sQUAf2dw1Il/YjB2HxkC1ECrk5HYn/AxZRWpgJnMvPDbA5pT66jWliy2zt+VmSkiTyB924ENBVBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from lizy04$hust.edu.cn ( [10.12.190.56] ) by ajax-webmail-app2
 (Coremail) ; Tue, 20 May 2025 21:21:12 +0800 (GMT+08:00)
Date: Tue, 20 May 2025 21:21:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5pyd6Ziz?= <lizy04@hust.edu.cn>
To: "greg kh" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, dzm91@hust.edu.cn, 
	"frederic weisbecker" <frederic@kernel.org>, 
	"vlad poenaru" <vlad.wing@gmail.com>, 
	"usama arif" <usamaarif642@gmail.com>, 
	"paul e . mckenney" <paulmck@kernel.org>, 
	"thomas gleixner" <tglx@linutronix.de>
Subject: Re: Re: [PATCH 6.1.y] hrtimers: Force migrate away hrtimers queued
 after CPUHP_AP_HRTIMERS_DYING
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2025 www.mailtech.cn hust
In-Reply-To: <2025052041-slobbery-slum-3b74@gregkh>
References: <2025021053-unranked-silt-0282@gregkh>
 <20250513060430.378468-1-lizy04@hust.edu.cn>
 <2025052041-slobbery-slum-3b74@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <48e7c69f.56a10.196eddaf807.Coremail.lizy04@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:HwEQrABHG3jIgSxofOxbAQ--.15003W
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgIB2gr+2I6ygAAss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gU3ViamVjdDogUmU6IFtQQVRDSCA2LjEueV0gaHJ0aW1lcnM6IEZvcmNlIG1pZ3JhdGUgYXdh
eSBocnRpbWVycyBxdWV1ZWQgYWZ0ZXIgQ1BVSFBfQVBfSFJUSU1FUlNfRFlJTkcKPiAKPiBPbiBU
dWUsIE1heSAxMywgMjAyNSBhdCAwMjowNDozMFBNICswODAwLCBaaGFveWFuZyBMaSB3cm90ZToK
PiA+IEZyb206IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+Cj4gPiAK
PiA+IFsgVXBzdHJlYW0gY29tbWl0IDUzZGFjMzQ1Mzk1YzBkMjQ5M2NiYzJmNGM4NWZlMzhhZWY1
YjYzZjUgXQo+ID4gCj4gPiBocnRpbWVycyBhcmUgbWlncmF0ZWQgYXdheSBmcm9tIHRoZSBkeWlu
ZyBDUFUgdG8gYW55IG9ubGluZSB0YXJnZXQgYXQKPiA+IHRoZSBDUFVIUF9BUF9IUlRJTUVSU19E
WUlORyBzdGFnZSBpbiBvcmRlciBub3QgdG8gZGVsYXkgYmFuZHdpZHRoIHRpbWVycwo+ID4gaGFu
ZGxpbmcgdGFza3MgaW52b2x2ZWQgaW4gdGhlIENQVSBob3RwbHVnIGZvcndhcmQgcHJvZ3Jlc3Mu
Cj4gPiAKPiA+IEhvd2V2ZXIgd2FrZXVwcyBjYW4gc3RpbGwgYmUgcGVyZm9ybWVkIGJ5IHRoZSBv
dXRnb2luZyBDUFUgYWZ0ZXIKPiA+IENQVUhQX0FQX0hSVElNRVJTX0RZSU5HLiBUaG9zZSBjYW4g
cmVzdWx0IGFnYWluIGluIGJhbmR3aWR0aCB0aW1lcnMgYmVpbmcKPiA+IGFybWVkLiBEZXBlbmRp
bmcgb24gc2V2ZXJhbCBjb25zaWRlcmF0aW9ucyAoY3J5c3RhbCBiYWxsIHBvd2VyIG1hbmFnZW1l
bnQKPiA+IGJhc2VkIGVsZWN0aW9uLCBlYXJsaWVzdCB0aW1lciBhbHJlYWR5IGVucXVldWVkLCB0
aW1lciBtaWdyYXRpb24gZW5hYmxlZCBvcgo+ID4gbm90KSwgdGhlIHRhcmdldCBtYXkgZXZlbnR1
YWxseSBiZSB0aGUgY3VycmVudCBDUFUgZXZlbiBpZiBvZmZsaW5lLiBJZiB0aGF0Cj4gPiBoYXBw
ZW5zLCB0aGUgdGltZXIgaXMgZXZlbnR1YWxseSBpZ25vcmVkLgo+ID4gCj4gPiBUaGUgbW9zdCBu
b3RhYmxlIGV4YW1wbGUgaXMgUkNVIHdoaWNoIGhhZCB0byBkZWFsIHdpdGggZWFjaCBhbmQgZXZl
cnkgb2YKPiA+IHRob3NlIHdha2UtdXBzIGJ5IGRlZmVycmluZyB0aGVtIHRvIGFuIG9ubGluZSBD
UFUsIGFsb25nIHdpdGggcmVsYXRlZAo+ID4gd29ya2Fyb3VuZHM6Cj4gPiAKPiA+IF8gZTc4NzY0
NGNhZjc2IChyY3U6IERlZmVyIFJDVSBrdGhyZWFkcyB3YWtldXAgd2hlbiBDUFUgaXMgZHlpbmcp
Cj4gPiBfIDkxMzlmOTMyMDlkMSAocmN1L25vY2I6IEZpeCBSVCB0aHJvdHRsaW5nIGhydGltZXIg
YXJtZWQgZnJvbSBvZmZsaW5lIENQVSkKPiA+IF8gZjczNDVjY2M2MmE0IChyY3Uvbm9jYjogRml4
IHJjdW9nIHdha2UtdXAgZnJvbSBvZmZsaW5lIHNvZnRpcnEpCj4gPiAKPiA+IFRoZSBwcm9ibGVt
IGlzbid0IGNvbmZpbmVkIHRvIFJDVSB0aG91Z2ggYXMgdGhlIHN0b3AgbWFjaGluZSBrdGhyZWFk
Cj4gPiAod2hpY2ggcnVucyBDUFVIUF9BUF9IUlRJTUVSU19EWUlORykgcmVwb3J0cyBpdHMgY29t
cGxldGlvbiBhdCB0aGUgZW5kCj4gPiBvZiBpdHMgd29yayB0aHJvdWdoIGNwdV9zdG9wX3NpZ25h
bF9kb25lKCkgYW5kIHBlcmZvcm1zIGEgd2FrZSB1cCB0aGF0Cj4gPiBldmVudHVhbGx5IGFybXMg
dGhlIGRlYWRsaW5lIHNlcnZlciB0aW1lcjoKPiA+IAo+ID4gICAgV0FSTklORzogQ1BVOiA5NCBQ
SUQ6IDU4OCBhdCBrZXJuZWwvdGltZS9ocnRpbWVyLmM6MTA4NiBocnRpbWVyX3N0YXJ0X3Jhbmdl
X25zKzB4Mjg5LzB4MmQwCj4gPiAgICBDUFU6IDk0IFVJRDogMCBQSUQ6IDU4OCBDb21tOiBtaWdy
YXRpb24vOTQgTm90IHRhaW50ZWQKPiA+ICAgIFN0b3BwZXI6IG11bHRpX2NwdV9zdG9wKzB4MC8w
eDEyMCA8LSBzdG9wX21hY2hpbmVfY3B1c2xvY2tlZCsweDY2LzB4YzAKPiA+ICAgIFJJUDogMDAx
MDpocnRpbWVyX3N0YXJ0X3JhbmdlX25zKzB4Mjg5LzB4MmQwCj4gPiAgICBDYWxsIFRyYWNlOgo+
ID4gICAgPFRBU0s+Cj4gPiAgICAgIHN0YXJ0X2RsX3RpbWVyCj4gPiAgICAgIGVucXVldWVfZGxf
ZW50aXR5Cj4gPiAgICAgIGRsX3NlcnZlcl9zdGFydAo+ID4gICAgICBlbnF1ZXVlX3Rhc2tfZmFp
cgo+ID4gICAgICBlbnF1ZXVlX3Rhc2sKPiA+ICAgICAgdHR3dV9kb19hY3RpdmF0ZQo+ID4gICAg
ICB0cnlfdG9fd2FrZV91cAo+ID4gICAgICBjb21wbGV0ZQo+ID4gICAgICBjcHVfc3RvcHBlcl90
aHJlYWQKPiA+IAo+ID4gSW5zdGVhZCBvZiBwcm92aWRpbmcgeWV0IGFub3RoZXIgYmFuZGFpZCB0
byB3b3JrIGFyb3VuZCB0aGUgc2l0dWF0aW9uLCBmaXgKPiA+IGl0IGluIHRoZSBocnRpbWVycyBp
bmZyYXN0cnVjdHVyZSBpbnN0ZWFkOiBhbHdheXMgbWlncmF0ZSBhd2F5IGEgdGltZXIgdG8KPiA+
IGFuIG9ubGluZSB0YXJnZXQgd2hlbmV2ZXIgaXQgaXMgZW5xdWV1ZWQgZnJvbSBhbiBvZmZsaW5l
IENQVS4KPiA+IAo+ID4gVGhpcyB3aWxsIGFsc28gYWxsb3cgdG8gcmV2ZXJ0IGFsbCB0aGUgYWJv
dmUgUkNVIGRpc2dyYWNlZnVsIGhhY2tzLgo+ID4gCj4gPiBGaXhlczogNWMwOTMwY2NhYWQ1ICgi
aHJ0aW1lcnM6IFB1c2ggcGVuZGluZyBocnRpbWVycyBhd2F5IGZyb20gb3V0Z29pbmcgQ1BVIGVh
cmxpZXIiKQo+ID4gUmVwb3J0ZWQtYnk6IFZsYWQgUG9lbmFydSA8dmxhZC53aW5nQGdtYWlsLmNv
bT4KPiA+IFJlcG9ydGVkLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+
ID4gU2lnbmVkLW9mZi1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9y
Zz4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9y
Zz4KPiA+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRl
Pgo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFRlc3RlZC1ieTogUGF1bCBFLiBN
Y0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjUwMTE3MjMyNDMzLjI0MDI3LTEtZnJlZGVyaWNAa2VybmVsLm9yZwo+ID4g
Q2xvc2VzOiAyMDI0MTIxMzIwMzczOS4xNTE5ODAxLTEtdXNhbWFhcmlmNjQyQGdtYWlsLmNvbQo+
ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFveWFuZyBMaSA8bGl6eTA0QGh1c3QuZWR1LmNuPgo+
ID4gLS0tCj4gCj4gWW91IGZvcmdvdCB0byBzZW5kIGEgNi42LnkgdmVyc2lvbiBhcyB3ZWxsIDoo
Cj4gCj4gTm93IGRyb3BwZWQgZnJvbSBteSBxdWV1ZSwgcGxlYXNlIHJlc2VuZCBib3RoLgo+IAo+
IHRoYW5rcywKPiAKPiBncmVnIGstaAoKVGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuIEkgd2ls
bCB0cnkgdG8gcG9ydCBpdCB0byA2LjYueSBhbmQgdGhlbiByZXNlbmQgdGhlIHR3byBwYXRjaGVz
LgotLQpCZXN0IHJlZ2FyZHMsClpoYW95YW5nIExp

