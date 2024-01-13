Return-Path: <stable+bounces-10823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23E82CE5D
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EAB282A35
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E4A6AB7;
	Sat, 13 Jan 2024 20:08:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp716.webpack.hosteurope.de (wp716.webpack.hosteurope.de [80.237.130.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A552CA6;
	Sat, 13 Jan 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=alumni.tu-berlin.de
Received: from dynamic-2a02-3100-10c4-3e00-053d-d55c-62f6-3b3b.310.pool.telefonica.de ([2a02:3100:10c4:3e00:53d:d55c:62f6:3b3b] helo=jt-2.fritz.box); authenticated
	by wp716.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rOjdk-0004tY-1V; Sat, 13 Jan 2024 20:25:56 +0100
Message-ID: <05c4daebeaefa571e224560a36b1d86850d9e156.camel@alumni.tu-berlin.de>
Subject: Re: [PATCH 5.4 04/38] net: Implement missing
 getsockopt(SO_TIMESTAMPING_NEW)
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <j-t.hinz@alumni.tu-berlin.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Willem de Bruijn <willemb@google.com>, "David
	S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>
Date: Sat, 13 Jan 2024 20:25:55 +0100
In-Reply-To: <20240113094206.585928230@linuxfoundation.org>
References: <20240113094206.455533180@linuxfoundation.org>
	 <20240113094206.585928230@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-bounce-key: webpack.hosteurope.de;j-t.hinz@alumni.tu-berlin.de;1705176511;570efaa6;
X-HE-SMSGID: 1rOjdk-0004tY-1V

SGkgR3JlZywKCnRoaXMgcGF0Y2ggaXMgYXBwbGllZCBpbiB0aGUgd3JvbmcgcGxhY2UgKHRoZSB3
cm9uZyBjYXNlKSBoZXJlIGluCnNvY2tfZ2V0c29ja29wdCgpLiBUaGUgZnVuY3Rpb24gc2VlbXMg
dG8gaGF2ZSBjaGFuZ2VkIGluIGEgbnVtYmVyIG9mCnBsYWNlcyBhZnRlciA1LjQsIGFwcGFyZW50
bHkgdG9vIG11Y2ggZm9yIGFuIGF1dG9tYXRpYyg/ISkgbWVyZ2UuCgpPbiBTYXQsIDIwMjQtMDEt
MTMgYXQgMTA6NDkgKzAxMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPiA1LjQtc3RhYmxl
IHJldmlldyBwYXRjaC7CoCBJZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0
IG1lCj4ga25vdy4KPiAKPiAtLS0tLS0tLS0tLS0tLS0tLS0KPiAKPiBGcm9tOiBKw7Zybi1UaG9y
YmVuIEhpbnogPGp0aGluekBtYWlsYm94LnR1LWJlcmxpbi5kZT4KPiAKPiBbIFVwc3RyZWFtIGNv
bW1pdCA3ZjZjYTk1ZDE2Yjk2NTY3Y2U0Y2Y0NThhMjc5MGZmMTdmYTYyMGMzIF0KPiAKPiBDb21t
aXQgOTcxODQ3NWU2OTA4ICgic29ja2V0OiBBZGQgU09fVElNRVNUQU1QSU5HX05FVyIpIGFkZGVk
IHRoZSBuZXcKPiBzb2NrZXQgb3B0aW9uIFNPX1RJTUVTVEFNUElOR19ORVcuIFNldHRpbmcgdGhl
IG9wdGlvbiBpcyBoYW5kbGVkIGluCj4gc2tfc2V0c29ja29wdCgpLCBxdWVyeWluZyBpdCB3YXMg
bm90IGhhbmRsZWQgaW4gc2tfZ2V0c29ja29wdCgpLAo+IHRob3VnaC4KPiAKPiBGb2xsb3dpbmcg
cmVtYXJrcyBvbiBhbiBlYXJsaWVyIHN1Ym1pc3Npb24gb2YgdGhpcyBwYXRjaCwga2VlcCB0aGUK
PiBvbGQKPiBiZWhhdmlvciBvZiBnZXRzb2Nrb3B0KFNPX1RJTUVTVEFNUElOR19PTEQpIHdoaWNo
IHJldHVybnMgdGhlIGFjdGl2ZQo+IGZsYWdzIGV2ZW4gaWYgdGhleSBhY3R1YWxseSBoYXZlIGJl
ZW4gc2V0IHRocm91Z2gKPiBTT19USU1FU1RBTVBJTkdfTkVXLgo+IAo+IFRoZSBuZXcgZ2V0c29j
a29wdChTT19USU1FU1RBTVBJTkdfTkVXKSBpcyBzdHJpY3RlciwgcmV0dXJuaW5nIGZsYWdzCj4g
b25seSBpZiB0aGV5IGhhdmUgYmVlbiBzZXQgdGhyb3VnaCB0aGUgc2FtZSBvcHRpb24uCj4gCj4g
Rml4ZXM6IDk3MTg0NzVlNjkwOCAoInNvY2tldDogQWRkIFNPX1RJTUVTVEFNUElOR19ORVciKQo+
IExpbms6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDcwMzE3NTA0OC4xNTE2
ODMtMS1qdGhpbnpAbWFpbGJveC50dS1iZXJsaW4uZGUvCj4gTGluazoKPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9uZXRkZXYvMGQ3Y2RkYzktMDNmYS00M2RiLWE1NzktMTRmM2U4MjI2MTViQGFw
cC5mYXN0bWFpbC5jb20vCj4gU2lnbmVkLW9mZi1ieTogSsO2cm4tVGhvcmJlbiBIaW56IDxqdGhp
bnpAbWFpbGJveC50dS1iZXJsaW4uZGU+Cj4gUmV2aWV3ZWQtYnk6IFdpbGxlbSBkZSBCcnVpam4g
PHdpbGxlbWJAZ29vZ2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+Cj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBr
ZXJuZWwub3JnPgo+IC0tLQo+IMKgbmV0L2NvcmUvc29jay5jIHwgMTEgKysrKysrKysrLS0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL25ldC9jb3JlL3NvY2suYyBiL25ldC9jb3JlL3NvY2suYwo+IGluZGV4IDJjM2M1
ZGYxMzkzNDUuLmEzY2E1MjI0MzRhNmUgMTAwNjQ0Cj4gLS0tIGEvbmV0L2NvcmUvc29jay5jCj4g
KysrIGIvbmV0L2NvcmUvc29jay5jCj4gQEAgLTEzMDksOSArMTMwOSwxNiBAQCBpbnQgc29ja19n
ZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludAo+IGxldmVsLCBpbnQgb3B0bmFtZSwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGNhc2UgU09fTElOR0VSOgo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgU09fVElNRVNUQU1Q
SU5HX05FVzoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGx2wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoD0gc2l6ZW9mKHYubGluZyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHYubGluZy5sX29ub2ZmwqDCoD0gc29ja19mbGFnKHNrLCBTT0NLX0xJTkdFUik7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHYubGluZy5sX2xpbmdlcsKgPSBzay0+
c2tfbGluZ2VydGltZSAvIEhaOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBG
b3IgdGhlIGxhdGVyLWFkZGVkIGNhc2UgU09fVElNRVNUQU1QSU5HX05FVzogQmUKPiBzdHJpY3Qg
YWJvdXQgb25seQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXR1cm5pbmcg
dGhlIGZsYWdzIHdoZW4gdGhleSB3ZXJlIHNldCB0aHJvdWdoIHRoZQo+IHNhbWUgb3B0aW9uLgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBEb24ndCBjaGFuZ2UgdGhlIGJldmlv
dXIgZm9yIHRoZSBvbGQgY2FzZQo+IFNPX1RJTUVTVEFNUElOR19PTEQuCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAob3B0bmFtZSA9PSBTT19USU1FU1RBTVBJTkdfT0xEIHx8IHNvY2tfZmxhZyhzaywKPiBTT0NL
X1RTVEFNUF9ORVcpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB2LmxpbmcubF9vbm9mZsKgwqA9IHNvY2tfZmxhZyhzaywgU09DS19MSU5HRVIpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdi5saW5nLmxf
bGluZ2VywqA9IHNrLT5za19saW5nZXJ0aW1lIC8gSFo7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgU09fQlNEQ09NUEFUOgoK


