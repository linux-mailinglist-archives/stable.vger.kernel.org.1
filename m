Return-Path: <stable+bounces-182079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D898BAD42E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10A5161B1B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BD303CBF;
	Tue, 30 Sep 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VMs7XbKh"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52942FFDFC;
	Tue, 30 Sep 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243762; cv=none; b=TjjzAN+IWQ/ZLki5rbv8leCyx8qZZxY1WPOBL0BKOV4/DYt3kuZwntx5bylin20ljBwCmntbbpmdALORJdX0aw9hSJ+RHw1P9kV9DV8pqme8gqijAfAMD7xNwQVWWNCUkwMG9J4/DiA0x4rTBNPon1c1zCBtKPFhW/sDa1dwgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243762; c=relaxed/simple;
	bh=irRuUltKVSnnrNHOmLeyFZEszqH/mlmSu40RSrgHLSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8ELj6fY5kcR5ujow4RENt5cyicL1HJ64e7lv4mqiU5glaWETfOcgE5QbxGpbXaDotqg66D4zr3XkKL+rkttAFUWAowTWCdUPj9C3nriy7/D9WzKEaKNfKnmfftIJpYtImoKYhh908tn/JDZWSxgRyLFnWRfaPPxo7/Hatf1puY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VMs7XbKh; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759243760; x=1790779760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irRuUltKVSnnrNHOmLeyFZEszqH/mlmSu40RSrgHLSc=;
  b=VMs7XbKh1qFiO2lkUZNujyXyEKqhIj/cis2duiUHoHT0aTprk65v/bBx
   AVmvct9xFi81fgLtWeXAoKX1eAr9YwWPXXfvVxj0fdvVxpzagtXgs4eW+
   dVEGNhOzmLLx1g1M+xtxgEkvtl1yf4Pjbg9jFY0RcJ7gwk6QBgzkOzFFY
   Vwbre9iSKz/c2Ds0kjh0tUqAS8IGSlvD7kzjla53WnpOFN3k5cL3A5W6R
   d7toO9K8uDou5mqlNRJhAjX+iemFE5ZWkCV21zV/9/Ih/+au1PKIpheK6
   +R8DfavQ4kEme65FuGs/qNkjpGoLT7luZT+wZj0qWp7MeIhjp2oMHjEOC
   Q==;
X-CSE-ConnectionGUID: Q5maVK6GRDujV6cMtANavg==
X-CSE-MsgGUID: XXqg2IsbTXONmiFKzi673Q==
X-IronPort-AV: E=Sophos;i="6.18,304,1751241600"; 
   d="scan'208";a="2789428"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 14:49:08 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:30779]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.4.140:2525] with esmtp (Farcaster)
 id 06d0cbc9-3440-47db-988e-9b6f40e7a021; Tue, 30 Sep 2025 14:49:08 +0000 (UTC)
X-Farcaster-Flow-ID: 06d0cbc9-3440-47db-988e-9b6f40e7a021
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 30 Sep 2025 14:49:07 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 30 Sep 2025 14:49:07 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Tue, 30 Sep 2025 14:49:07 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "sashal@kernel.org" <sashal@kernel.org>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "lijo.lazar@amd.com" <lijo.lazar@amd.com>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>, "arnd@kernel.org"
	<arnd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Farber, Eliav"
	<farbere@amazon.com>
Subject: RE: [PATCH v2 03/13 6.1.y] minmax: simplify min()/max()/clamp()
 implementation
Thread-Topic: [PATCH v2 03/13 6.1.y] minmax: simplify min()/max()/clamp()
 implementation
Thread-Index: AQHcMhlf02jGRE+LJEGMf1nzwpSOjA==
Date: Tue, 30 Sep 2025 14:49:07 +0000
Message-ID: <705cb94d16234e44b9bfd33b6e87471d@amazon.com>
References: <20250929183358.18982-1-farbere@amazon.com>
 <20250929183358.18982-4-farbere@amazon.com>
 <2025093026-gutter-avert-7f16@gregkh>
In-Reply-To: <2025093026-gutter-avert-7f16@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiBNb24sIFNlcCAyOSwgMjAyNSBhdCAwNjozMzo0OFBNICswMDAwLCBFbGlhdiBGYXJiZXIg
d3JvdGU6DQo+ID4gRnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KPiA+DQo+ID4gWyBVcHN0cmVhbSBjb21taXQgZGMxYzgwMzRlMzFiMTRhMmU1ZTIx
MjEwNGVjNTA4YWVjNDRjZTFiOSBdDQo+ID4NCj4gPiBOb3cgdGhhdCB3ZSBubyBsb25nZXIgaGF2
ZSBhbnkgQyBjb25zdGFudCBleHByZXNzaW9uIGNvbnRleHRzIChpZSBhcnJheQ0KPiA+IHNpemUg
ZGVjbGFyYXRpb25zIG9yIHN0YXRpYyBpbml0aWFsaXplcnMpIHRoYXQgdXNlIG1pbigpIG9yIG1h
eCgpLCB3ZQ0KPiA+IGNhbiBzaW1waWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiBieSBub3QgaGF2aW5n
IHRvIHdvcnJ5IGFib3V0IHRoZSByZXN1bHQNCj4gPiBzdGF5aW5nIGFzIGEgQyBjb25zdGFudCBl
eHByZXNzaW9uLg0KPiA+DQo+ID4gU28gbm93IHdlIGNhbiB1bmNvbmRpdGlvbmFsbHkganVzdCB1
c2UgdGVtcG9yYXJ5IHZhcmlhYmxlcyBvZiB0aGUgcmlnaHQNCj4gPiB0eXBlLCBhbmQgZ2V0IHJp
ZCBvZiB0aGUgZXhjZXNzaXZlIGV4cGFuc2lvbiB0aGF0IHVzZWQgdG8gY29tZSBmcm9tIHRoZQ0K
PiA+IHVzZSBvZg0KPiA+DQo+ID4gICAgX19idWlsdGluX2Nob29zZV9leHByKF9faXNfY29uc3Rl
eHByKC4uLiksIC4uDQo+ID4NCj4gPiB0byBwaWNrIHRoZSBzcGVjaWFsaXplZCBjb2RlIGZvciBj
b25zdGFudCBleHByZXNzaW9ucy4NCj4gPg0KPiA+IEFub3RoZXIgZXhwYW5zaW9uIHNpbXBsaWZp
Y2F0aW9uIGlzIHRvIHBhc3MgdGhlIHRlbXBvcmFyeSB2YXJpYWJsZXMgKGluDQo+ID4gYWRkaXRp
b24gdG8gdGhlIG9yaWdpbmFsIGV4cHJlc3Npb24pIHRvIG91ciBfX3R5cGVzX29rKCkgbWFjcm8u
ICBUaGF0DQo+ID4gbWF5IHN1cGVyZmljaWFsbHkgbG9vayBsaWtlIGl0IGNvbXBsaWNhdGVzIHRo
ZSBtYWNybywgYnV0IHdoZW4gd2Ugb25seQ0KPiA+IHdhbnQgdGhlIHR5cGUgb2YgdGhlIGV4cHJl
c3Npb24sIGV4cGFuZGluZyB0aGUgdGVtcG9yYXJ5IHZhcmlhYmxlIG5hbWVzDQo+ID4gaXMgbXVj
aCBzaW1wbGVyIGFuZCBzbWFsbGVyIHRoYW4gZXhwYW5kaW5nIHRoZSBwb3RlbnRpYWxseSBjb21w
bGljYXRlZA0KPiA+IG9yaWdpbmFsIGV4cHJlc3Npb24uDQo+ID4NCj4gPiBBcyBhIHJlc3VsdCwg
b24gbXkgbWFjaGluZSwgZG9pbmcgYQ0KPiA+DQo+ID4gICAkIHRpbWUgbWFrZSBkcml2ZXJzL3N0
YWdpbmcvbWVkaWEvYXRvbWlzcC9wY2kvaXNwL2tlcm5lbHMveW5yL3lucl8xLjAvaWFfY3NzX3lu
ci5ob3N0LmkNCj4gPg0KPiA+IGdvZXMgZnJvbQ0KPiA+DQo+ID4gICAgICAgcmVhbCAgICAwbTE2
LjYyMXMNCj4gPiAgICAgICB1c2VyICAgIDBtMTUuMzYwcw0KPiA+ICAgICAgIHN5cyAgICAgMG0x
LjIyMXMNCj4gPg0KPiA+IHRvDQo+ID4NCj4gPiAgICAgICByZWFsICAgIDBtMi41MzJzDQo+ID4g
ICAgICAgdXNlciAgICAwbTIuMDkxcw0KPiA+ICAgICAgIHN5cyAgICAgMG0wLjQ1MnMNCj4gPg0K
PiA+IGJlY2F1c2UgdGhlIHRva2VuIGV4cGFuc2lvbiBnb2VzIGRvd24gZHJhbWF0aWNhbGx5Lg0K
PiA+DQo+ID4gSW4gcGFydGljdWxhciwgdGhlIGxvbmdlc3QgbGluZSBleHBhbnNpb24gKHdoaWNo
IHdhcyBsaW5lIDcxIG9mIHRoYXQNCj4gPiAnaWFfY3NzX3luci5ob3N0LmMnIGZpbGUpIHNocmlu
a3MgZnJvbSAyMywzMzhrQiAoeWVzLCAyM01CIGZvciBvbmUNCj4gPiBzaW5nbGUgbGluZSkgdG8g
Imp1c3QiIDEsNDQ0a0IgKG5vdyAib25seSIgMS40TUIpLg0KPiA+DQo+ID4gQW5kIHllcywgdGhh
dCBsaW5lIGlzIHN0aWxsIHRoZSBsaW5lIGZyb20gaGVsbCwgYmVjYXVzZSBpdCdzIGRvaW5nDQo+
ID4gbXVsdGlwbGUgbGV2ZWxzIG9mICJtaW4oKS9tYXgoKSIgZXhwYW5zaW9uIHRoYW5rcyB0byBz
b21lIG9mIHRoZW0gYmVpbmcNCj4gPiBoaWRkZW4gaW5zaWRlIHRoZSB1RElHSVRfRklUVElORygp
IG1hY3JvLg0KPiA+DQo+ID4gTG9yZW56byBoYXMgYSBuaWNlIGNsZWFudXAgcGF0Y2ggdGhhdCBt
YWtlcyB0aGF0IGRyaXZlciB1c2UgaW5saW5lDQo+ID4gZnVuY3Rpb25zIGluc3RlYWQgb2YgbWFj
cm9zIGZvciBzRElHSVRfRklUVElORygpIGFuZCB1RElHSVRfRklUVElORygpLA0KPiA+IHdoaWNo
IHdpbGwgZml4IHRoYXQgbGluZSBvbmNlIGFuZCBmb3IgYWxsLCBidXQgdGhlIDE2LWZvbGQgcmVk
dWN0aW9uIGluDQo+ID4gdGhpcyBjYXNlIGRvZXMgc2hvdyB3aHkgd2UgbmVlZCB0byBzaW1wbGlm
eSB0aGVzZSBoZWxwZXJzLg0KPiA+DQo+ID4gQ2M6IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+DQo+ID4gQ2M6IExvcmVuem8gU3RvYWtlcyA8bG9yZW56by5zdG9ha2VzQG9y
YWNsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVsaWF2IEZhcmJlciA8ZmFy
YmVyZUBhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21pbm1heC5oIHwg
NDMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4NCj4gVGhpcyBj
aGFuZ2UgYnJlYWtzIHRoZSBidWlsZCBpbiBkcml2ZXJzL21kLyA6DQo+DQo+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvY29udGFpbmVyX29mLmg6NSwNCj4gICAgICAgICAg
ICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9saXN0Lmg6NSwNCj4gICAgICAgICAgICAgICAg
ICBmcm9tIC4vaW5jbHVkZS9saW51eC93YWl0Lmg6NywNCj4gICAgICAgICAgICAgICAgICBmcm9t
IC4vaW5jbHVkZS9saW51eC9tZW1wb29sLmg6OCwNCj4gICAgICAgICAgICAgICAgICBmcm9tIC4v
aW5jbHVkZS9saW51eC9iaW8uaDo4LA0KPiAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9t
ZC9kbS1iaW8tcmVjb3JkLmg6MTAsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL21k
L2RtLWludGVncml0eS5jOjk6DQo+IGRyaXZlcnMvbWQvZG0taW50ZWdyaXR5LmM6IEluIGZ1bmN0
aW9uIOKAmGludGVncml0eV9tZXRhZGF0YeKAmToNCj4gZHJpdmVycy9tZC9kbS1pbnRlZ3JpdHku
YzoxMzE6MTA1OiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIHZhcmlhYmxlIGxlbmd0aCBhcnJheSDi
gJhjaGVja3N1bXNfb25zdGFja+KAmSBbLVdlcnJvcj12bGFdDQo+ICAgMTMxIHwgI2RlZmluZSBN
QVhfVEFHX1NJWkUgICAgICAgICAgICAgICAgICAgIChKT1VSTkFMX1NFQ1RPUl9EQVRBIC0gSk9V
Uk5BTF9NQUNfUEVSX1NFQ1RPUiAtIG9mZnNldG9mKHN0cnVjdCBqb3VybmFsX2VudHJ5LCBsYXN0
X2J5dGVzW01BWF9TRUNUT1JTX1BFUl9CTE9DS10pKQ0KPiAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fg0KPi4vaW5jbHVk
ZS9saW51eC9idWlsZF9idWcuaDo3ODo1Njogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDi
gJhfX3N0YXRpY19hc3NlcnTigJkNCj4gICAgNzggfCAjZGVmaW5lIF9fc3RhdGljX2Fzc2VydChl
eHByLCBtc2csIC4uLikgX1N0YXRpY19hc3NlcnQoZXhwciwgbXNnKQ0KPiAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+DQo+
Li9pbmNsdWRlL2xpbnV4L21pbm1heC5oOjU2Ojk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNy
byDigJhzdGF0aWNfYXNzZXJ04oCZDQo+ICAgIDU2IHwgICAgICAgICBzdGF0aWNfYXNzZXJ0KF9f
dHlwZXNfb2soeCwgeSwgdXgsIHV5KSwgICAgICAgICBcDQo+ICAgICAgIHwgICAgICAgICBefn5+
fn5+fn5+fn5+DQo+Li9pbmNsdWRlL2xpbnV4L21pbm1heC5oOjQxOjMxOiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8g4oCYX19pc19ub25lZ19pbnTigJkNCj4gICAgNDEgfCAgICAgICAgICBf
X2lzX25vbmVnX2ludCh4KSB8fCBfX2lzX25vbmVnX2ludCh5KSkNCj4gICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPi4vaW5jbHVkZS9saW51eC9t
aW5tYXguaDo1NjoyMzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fdHlwZXNfb2vi
gJkNCj4gICAgNTYgfCAgICAgICAgIHN0YXRpY19hc3NlcnQoX190eXBlc19vayh4LCB5LCB1eCwg
dXkpLCAgICAgICAgIFwNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fg0KPi4vaW5jbHVkZS9saW51eC9taW5tYXguaDo2MTo5OiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYX19jYXJlZnVsX2NtcF9vbmNl4oCZDQo+ICAgIDYxIHwgICAgICAgICBfX2NhcmVm
dWxfY21wX29uY2Uob3AsIHgsIHksIF9fVU5JUVVFX0lEKHhfKSwgX19VTklRVUVfSUQoeV8pKQ0K
PiAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+Li9pbmNsdWRlL2xpbnV4L21p
bm1heC5oOjkyOjI1OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYX19jYXJlZnVsX2Nt
cOKAmQ0KPiAgICA5MiB8ICNkZWZpbmUgbWF4KHgsIHkpICAgICAgIF9fY2FyZWZ1bF9jbXAobWF4
LCB4LCB5KQ0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4N
Cj4gZHJpdmVycy9tZC9kbS1pbnRlZ3JpdHkuYzoxNzk3OjQwOiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8g4oCYbWF44oCZDQo+ICAxNzk3IHwgICAgICAgICAgICAgICAgIGNoYXIgY2hlY2tz
dW1zX29uc3RhY2tbbWF4KChzaXplX3QpSEFTSF9NQVhfRElHRVNUU0laRSwgTUFYX1RBR19TSVpF
KV07DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
DQo+IGRyaXZlcnMvbWQvZG0taW50ZWdyaXR5LmM6MTMxOjg5OiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8g4oCYb2Zmc2V0b2bigJkNCj4gICAxMzEgfCAjZGVmaW5lIE1BWF9UQUdfU0laRSAg
ICAgICAgICAgICAgICAgICAgKEpPVVJOQUxfU0VDVE9SX0RBVEEgLSBKT1VSTkFMX01BQ19QRVJf
U0VDVE9SIC0gb2Zmc2V0b2Yoc3RydWN0IGpvdXJuYWxfZW50cnksIGxhc3RfYnl0ZXNbTUFYX1NF
Q1RPUlNfUEVSX0JMT0NLXSkpDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+DQo+IGRyaXZlcnMvbWQvZG0taW50ZWdyaXR5LmM6MTc5Nzo3Mzogbm90ZTog
aW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmE1BWF9UQUdfU0laReKAmQ0KPiAgMTc5NyB8ICAgICAg
ICAgICAgICAgICBjaGFyIGNoZWNrc3Vtc19vbnN0YWNrW21heCgoc2l6ZV90KUhBU0hfTUFYX0RJ
R0VTVFNJWkUsIE1BWF9UQUdfU0laRSldOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fg0KPg0KPg0KPiBTbyBJJ2xsIHN0b3AgaGVyZSBvbiB0aGlzIHNlcmllcy4NCj4NCj4g
QWZ0ZXIgdGhlIG5leHQgcmVsZWFzZSwgY2FuIHlvdSByZWJhc2UgdGhlIHNlcmllcyBhbmQgcmVz
ZW5kIHRoZSByZW1haW5pbmcgb25lcyBhZnRlciB0aGV5IGFyZSBmaXhlZCB1cCB0byBidWlsZCBw
cm9wZXJseT8NCg0KU3VyZS4NCkkgc2VlIHRoZSBwcm9ibGVtLg0KSW4gdGhlIGludGVncml0eV9t
ZXRhZGF0YSgpIGZ1bmN0aW9uIGl0IHNob3VsZCBiZToNCiAgY2hhciBjaGVja3N1bXNfb25zdGFj
a1tNQVgoSEFTSF9NQVhfRElHRVNUU0laRSwgTUFYX1RBR19TSVpFKV07DQppbnN0ZWFkIG9mOg0K
ICBjaGFyIGNoZWNrc3Vtc19vbnN0YWNrW21heCgoc2l6ZV90KUhBU0hfTUFYX0RJR0VTVFNJWkUs
IE1BWF9UQUdfU0laRSldOw0KDQotLS0NClJlZ2FyZHMsIEVsaWF2DQo=

