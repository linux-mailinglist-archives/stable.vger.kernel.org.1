Return-Path: <stable+bounces-127522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8DA7A381
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4845D174BD6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342F1F3FDD;
	Thu,  3 Apr 2025 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LXxZIWSm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E709D529
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686139; cv=none; b=sCgu0GabqUCJcdmS8INiUT0RNr1tGHEk4Gm0GRsn1CIeiyf+4IeNScsRt+mnIBGvmC/CMrABi/E9ZG1FWSwIDDbUKGE5ylqSRPzSt73v87bWoka5bRJ9zHOxXMH6rJ5sJdk3AKfLHLIg30KuuIReIinMPxuSspxPlJmaVLGVobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686139; c=relaxed/simple;
	bh=v5/vFsT4X/OYHsDASWHy37nUuFGeHtgL+VBSXgCnvQE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ptIz9mU0ew8iGHEW/kwgGkLfCnKXAbWJagcHqBNIuijIDZzPUG89qzdsfGrzrZizcZ0jCg9il/9wVGCtQpgL1I8+twnVWWleJ1omqwfuzTQXfOKB8X7edNnyCTjfE7pfSz8u4Be/++P3cfBOuTZ/ZM27FKZ+PePZUhO5WrIDteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=LXxZIWSm; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743686136; x=1775222136;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=v5/vFsT4X/OYHsDASWHy37nUuFGeHtgL+VBSXgCnvQE=;
  b=LXxZIWSmZnyvcuGYmNbWZsYNBsRG7JQpSTp5+Cd//xT4ACvg0rhTC2j8
   NViLuasNp84o85dz6RtHtAGlXNnMDQ16IaO8jxXKBXxm1saHgKaEFgEox
   W4u54qDC3sz86Ktgau+njIEWK7Tb1HDcjs2dR4laRa63pIeslg9gIrTvs
   o=;
X-IronPort-AV: E=Sophos;i="6.15,184,1739836800"; 
   d="scan'208";a="486294477"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 13:15:31 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:58212]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.242:2525] with esmtp (Farcaster)
 id 2df2d897-c7ac-4fb0-925a-3849a49992d2; Thu, 3 Apr 2025 13:15:29 +0000 (UTC)
X-Farcaster-Flow-ID: 2df2d897-c7ac-4fb0-925a-3849a49992d2
Received: from EX19D002EUC001.ant.amazon.com (10.252.51.219) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 13:15:28 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D002EUC001.ant.amazon.com (10.252.51.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 13:15:28 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.1544.014; Thu, 3 Apr 2025 13:15:28 +0000
From: "Manthey, Norbert" <nmanthey@amazon.de>
To: "sashal@kernel.org" <sashal@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Improving Linux Commit Backporting
Thread-Topic: Improving Linux Commit Backporting
Thread-Index: AQHbpJp4W90ZmhIoH0q53tI0rXR67Q==
Date: Thu, 3 Apr 2025 13:15:28 +0000
Message-ID: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D02749E31C8FA4F84275102B7EFB768@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RGVhciBMaW51eCBTdGFibGUgTWFpbnRhaW5lcnMsDQoNCndoaWxlIG1haW50YWluaW5nIGRvd25z
dHJlYW0gTGludXggcmVsZWFzZXMsIHdlIG5vdGljZWQgdGhhdCB3ZSBoYXZlIHRvDQpiYWNrcG9y
dCBzb21lIHBhdGNoZXMgbWFudWFsbHksIGJlY2F1c2UgdGhleSBhcmUgbm90IHBpY2tlZCB1cCBi
eSB5b3VyDQphdXRvbWF0ZWQgYmFja3BvcnRpbmcuIFNvbWUgb2YgdGhlc2UgYmFja3BvcnRzIGNh
biBiZSBkb25lIHdpdGgNCmltcHJvdmVkIGNoZXJyeS1waWNrIHRvb2xpbmcuIFdlIGhhdmUgaW1w
bGVtZW50ZWQgYSBzY3JpcHQvdG9vbCAiZ2l0LQ0KZnV6enktcGljayIgd2hpY2ggd2Ugd291bGQg
bGlrZSB0byBzaGFyZS4gQmVzaWRlcyBwaWNraW5nIG1vcmUgY29tbWl0cywNCnRoZSB0b29sIGFs
c28gc3VwcG9ydHMgZXhlY3V0aW5nIGEgdmFsaWRhdGlvbiBzY3JpcHQgcmlnaHQgYWZ0ZXINCnBp
Y2tpbmcsIGUuZy4gY29tcGlsaW5nIHRoZSBtb2RpZmllZCBzb3VyY2UgZmlsZS4gUGlja2luZyBz
dGF0cyBhbmQNCmRldGFpbHMgYXJlIHByZXNlbnRlZCBiZWxvdy4NCg0KV2Ugd291bGQgbGlrZSB0
byBkaXNjdXNzIHdoZXRoZXIgeW91IGNhbiBpbnRlZ3JhdGUgdGhpcyBpbXByb3ZlZCB0b29sDQpp
bnRvIGludG8geW91ciBkYWlseSB3b3JrZmxvd3MuIFdlIGFscmVhZHkgZm91bmQgdGhlIHN0YWJs
ZS10b29scw0KcmVwb3NpdG9yeSBbMV0gd2l0aCBzb21lIHNjcmlwdHMgdGhhdCBoZWxwIGF1dG9t
YXRlIGJhY2twb3J0aW5nLiBUbw0KY29udHJpYnV0ZSBnaXQtZnV6enktcGljayB0aGVyZSwgd2Ug
d291bGQgbmVlZCB5b3UgdG8gZGVjbGFyZSBhIGxpY2Vuc2UNCmZvciB0aGUgY3VycmVudCBzdGF0
ZSBvZiB0aGlzIHJlcG9zaXRvcnkuDQoNClRvIHRlc3QgYmFja3BvcnRpbmcgcGVyZm9ybWFuY2Us
IHdlIHRyaWVkIHRvIGJhY2twb3J0IHN0YWJsZS1jYW5kaWRhdGUNCnBhdGNoZXMgZnJvbSA2LjEy
IHRvIDYuMS4gU3BlY2lmaWNhbGx5LCBvbiB0YWcgNi4xLjEyNSB3ZSBleGVjdXRlZCB0aGUNCmNv
bW1hbmQgc3RhYmxlIHNob3ctbWlzc2luZy1zdGFibGUgdjYuMTIuMTIuLnY2LjEyLjE3IHRvIGNv
bGxlY3QNCnBhdGNoZXMgY29uc2lkZXJlZCBmb3IgYmFja3BvcnRpbmcuIFRoaXMgcmVzdWx0cyBp
biA0MzEgYmFja3BvcnQNCmNhbmRpZGF0ZXMuIFdoZW4gdXNpbmcgZ2l0LWZ1enp5LXBpY2ssIHdl
IGNhbiBwaWNrIDkgcGF0Y2hlcyBtb3JlIHRoYW4NCndpdGggZGVmYXVsdCBjaGVycnktcGlja2lu
Zy4gQWxsIG1vZGlmaWNhdGlvbnMgaGF2ZSBiZWVuIHZhbGlkYXRlZCBieQ0KYXR0ZW1wdGluZyB0
byBidWlsZCB0aGUNCm9iamVjdCBmaWxlcyBvZiB0aGUgbW9kaWZpZWQgQyBzb3VyY2UgZmlsZXMg
d2l0aCBtYWtlIHVzaW5nIHRoZSBrZXJuZWxzDQrigJxhbGx5ZXNjb25maWfigJ0gY29uZmlndXJh
dGlvbi4NCg0KMTk2IENoZXJyeS1waWNrZWQgd2l0aCAtLXN0cmF0ZWd5PXJlY3Vyc2l2ZSAtLVhw
YXRpZW5jZSAteA0KICAxIEFwcGxpZWQgd2l0aCBwYXRjaCAtcDEgLi4uIC0tZnV6ej0xDQogIDgg
QXBwbGllZCB3aXRoIHBhdGNoIC1wMSAuLi4gLS1mdXp6PTINCg0KUGxlYXNlIGxldCB1cyBrbm93
IGhvdyB0byBiZXN0IHNoYXJlIHRoZSB0b29sIHdpdGggeW91ISBMb25nIHRlcm0sIHdlDQp3b3Vs
ZCBsaWtlIHRvIGludGVncmF0ZSBpdCBpbnRvIHlvdXIgYmFja3BvcnRpbmcgd29ya2Zsb3csIHNv
IHRoYXQgbW9yZQ0Ka2VybmVsIGNvbW1pdHMgY2FuIGJlIGFwcGxpZWQgYXV0b21hdGljYWxseS4N
Cg0KQmVzdCwNCk5vcmJlcnQNCg0KDQpbMV0NCmh0dHBzOi8va2VybmVsLmdvb2dsZXNvdXJjZS5j
b20vcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Nhc2hhbC9zdGFibGUtdG9vbHMvDQoNCg==

