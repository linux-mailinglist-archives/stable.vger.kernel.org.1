Return-Path: <stable+bounces-88157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719D9B049E
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330541F243B7
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F91FB8AA;
	Fri, 25 Oct 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VkbZqWIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9991632E2
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864377; cv=none; b=bTMjyA4+krebP+4d/NRmnRSFS9xtDGfgDEkqLEii9Zh+5hzgLLv0xVIBQmRpofnzTMPNxls53wM4X9NmPIMpK/f9B5sZSWXNxPi2QEc+wqR6y5i1xeTZHHxRrE0hfdwEGcywxzEO7Wp0UfYqtH/we8HKNL73T69JnL8VI53t9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864377; c=relaxed/simple;
	bh=CyhTmBGO9ZFabUSrWTgxv7yXYx4sA7pdGdr+8fFjZ+Y=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cr0u0gIO+RVZ0KAjipV17h701JdsAdrFKkizWqx/5l0XwH02DllTipASBdb9i/nZ61ZTUMFP/ZxKmoMtK2d/2xm7ZxbSDvLJXD7LOA1renuJBJ5YuoTH80kLSpMB1aPqP0mtK5BNBIssBC8PlB6KEockqjh4ksl2sGb/3Rzo0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=VkbZqWIe; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1729864374; x=1761400374;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=CyhTmBGO9ZFabUSrWTgxv7yXYx4sA7pdGdr+8fFjZ+Y=;
  b=VkbZqWIe+9ITm+qdkvWxQF8Hmp26ftT35IDxjff4hg/XISzQ08DtIgdT
   0UUqC8QpeDjgQ6dv2+o3tTLuGCmTHlRpkpf+P8cqludFChr4VL/lvoqIs
   l4lzGsgURsqxvzGyZJQWN89t1ZJtFOG/xuhZ+0Jo4JZkfYhlobjfS7kSh
   4=;
X-IronPort-AV: E=Sophos;i="6.11,231,1725321600"; 
   d="scan'208";a="36382158"
Subject: Re: [PATCH 6.1.y 5.15.y 5.10.y] driver core: bus: Fix double free in driver
 API bus_register()
Thread-Topic: [PATCH 6.1.y 5.15.y 5.10.y] driver core: bus: Fix double free in driver API
 bus_register()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 13:52:51 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:52298]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.131:2525] with esmtp (Farcaster)
 id 13fa684c-6128-4d81-b9dc-91d778feeca4; Fri, 25 Oct 2024 13:52:50 +0000 (UTC)
X-Farcaster-Flow-ID: 13fa684c-6128-4d81-b9dc-91d778feeca4
Received: from EX19D030EUC001.ant.amazon.com (10.252.61.228) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 25 Oct 2024 13:52:50 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC001.ant.amazon.com (10.252.61.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 25 Oct 2024 13:52:50 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1258.034; Fri, 25 Oct 2024 13:52:50 +0000
From: "Krcka, Tomas" <krckatom@amazon.de>
To: Tomas Krcka <tomas.krcka@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Zijun Hu
	<quic_zijuhu@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Thread-Index: AQHbJuRJI+nN9vCMFUyDzXlG+qpjtrKXfIaA
Date: Fri, 25 Oct 2024 13:52:50 +0000
Message-ID: <D499DBE4-DDA7-4DB0-B1DA-0C81301FEEE2@amazon.de>
References: <20241025134555.10272-1-krckatom@amazon.de>
In-Reply-To: <20241025134555.10272-1-krckatom@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A59063A3F5F54AA715A1887A53EC52@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SXTigJlzIG5vdCBjb3JyZWN0IHBhdGNoIC0geW91IGNhbiBkaXNjYXJkZWQuDQpTb3JyeSBmb3Ig
bm9pc2UuDQpUb21hcw0KDQo+IE9uIDI1LiBPY3QgMjAyNCwgYXQgMTU6NDUsIFRvbWFzIEtyY2th
IDx0b21hcy5rcmNrYUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBz
ZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gRnJvbTog
WmlqdW4gSHUgPHF1aWNfemlqdWh1QHF1aWNpbmMuY29tPg0KPiANCj4gWyBVcHN0cmVhbSBjb21t
aXQgYmZhNTRhNzkzYmE3N2VmNjk2NzU1YjY2ZjNhYzRlZDAwYzdkMTI0OCBdDQo+IA0KPiBGb3Ig
YnVzX3JlZ2lzdGVyKCksIGFueSBlcnJvciB3aGljaCBoYXBwZW5zIGFmdGVyIGtzZXRfcmVnaXN0
ZXIoKSB3aWxsDQo+IGNhdXNlIHRoYXQgQHByaXYgYXJlIGZyZWVkIHR3aWNlLCBmaXhlZCBieSBz
ZXR0aW5nIEBwcml2IHdpdGggTlVMTCBhZnRlcg0KPiB0aGUgZmlyc3QgZnJlZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFppanVuIEh1IDxxdWljX3ppanVodUBxdWljaW5jLmNvbT4NCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDcyNy1idXNfcmVnaXN0ZXJfZml4LXYxLTEt
ZmVkOGRkMGRiYTdhQHF1aWNpbmMuY29tDQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFRvbWFz
IEtyY2thIDxrcmNrYXRvbUBhbWF6b24uZGU+DQo+IC0tLQ0KPiBkcml2ZXJzL2Jhc2UvYnVzLmMg
fCAyICsrDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Jhc2UvYnVzLmMgYi9kcml2ZXJzL2Jhc2UvYnVzLmMNCj4gaW5kZXggMzM5
YTllZGNkZTVmLi44ZmFlN2M3MDBjYzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9idXMu
Yw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvYnVzLmMNCj4gQEAgLTg1Myw2ICs4NTMsOCBAQCBpbnQg
YnVzX3JlZ2lzdGVyKHN0cnVjdCBidXNfdHlwZSAqYnVzKQ0KPiAgICAgICAgYnVzX3JlbW92ZV9m
aWxlKGJ1cywgJmJ1c19hdHRyX3VldmVudCk7DQo+IGJ1c191ZXZlbnRfZmFpbDoNCj4gICAgICAg
IGtzZXRfdW5yZWdpc3RlcigmYnVzLT5wLT5zdWJzeXMpOw0KPiArICAgICAgIC8qIEFib3ZlIGtz
ZXRfdW5yZWdpc3RlcigpIHdpbGwga2ZyZWUgQHByaXYgKi8NCj4gKyAgICAgICBwcml2ID0gTlVM
TDsNCj4gb3V0Og0KPiAgICAgICAga2ZyZWUoYnVzLT5wKTsNCj4gICAgICAgIGJ1cy0+cCA9IE5V
TEw7DQo+IC0tDQo+IDIuNDAuMQ0KPiANCg0KCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdl
dHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpT
aXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


