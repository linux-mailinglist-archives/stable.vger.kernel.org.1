Return-Path: <stable+bounces-48228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8918FD0C4
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F11F215F8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1E19D894;
	Wed,  5 Jun 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="fR0rn0BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0623D7;
	Wed,  5 Jun 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.210.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597438; cv=none; b=FhnXJzry5bdH7Vt3Xd1UvBKrLRngQaxffRhcTgKT6X8eFXrIRabMNxxQnyjtd19mHp7Hlo9Nl46sqzU0sJBywCFrPVIo1UU7ZmyKhzk6CtNFHLewdhE5IVg6ij0i5efve7OMFkP5IEV6Ekl9ck7W34LGv3glCsHLJUjLfO2BLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597438; c=relaxed/simple;
	bh=ZF+Y57P9kdEiy4scC2Ivo4PpX3jyFJxVU8N7S098Rcg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZJWfIFd/t5SNwWtt5EUoI71oI0maLBMrCIFahNiNlsis70H8pQjX+BZDb96Gz0Go1Zuz7Ss5xuAfGkQKSlq2buKZAu4D+ZRwS/0jxiKMJq8AQNrOzB5FcztvpPsCvhadcke2rxPK+kNourustfBZuyLUxrTu8WqDEpH5zdIvzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=fR0rn0BC; arc=none smtp.client-ip=80.12.210.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1717597435; x=1749133435;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=ZF+Y57P9kdEiy4scC2Ivo4PpX3jyFJxVU8N7S098Rcg=;
  b=fR0rn0BCJEGVcaVTbBpUIJVNN5f2JL/j5C7/JFh1c1CCNSgnBPrOIeij
   ccIyGz8xnwOLfGV72ZTkfhNMnl1A2YZLb9n5X1D2iXvbylrPbSZ6R53nE
   2NOAs4CxHGQW728mCwg/14NCRYvwmiVy3asjRis+rtqonTiaMfU4ILRKV
   Jl30vd3Hc/owfahSVuHK5bpGp5Ma6U0jO/WRGL8G9YTuovWN+GMe8W85N
   6mVtjIrlIgpFq2MZcxtFSrnVsSseePgoO3h75QydQ0Fo+blzJo3AMh5A2
   TyT+sgkVm9tLby3aNw5S8l0RkM8cOrVF6oSAEOP7i4Fdtoi2Bj7JoAaDk
   w==;
Received: from unknown (HELO opfedv3rlp0d.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 16:22:45 +0200
Received: from test-mailhost.rd.francetelecom.fr (HELO l-mail-int) ([x.x.x.x]) by
 opfedv3rlp0d.nor.fr.ftgroup with ESMTP; 05 Jun 2024 16:22:45 +0200
Received: from lat6466.rd.francetelecom.fr ([x.x.x.x])	by l-mail-int with esmtp (Exim
 4.94.2)	(envelope-from <alexandre.ferrieux@orange.com>)	id 1sErX8-00CKl5-9B;
 Wed, 05 Jun 2024 16:22:43 +0200
From: alexandre.ferrieux@orange.com
X-IronPort-AV: E=Sophos;i="6.08,216,1712613600"; 
   d="scan'208";a="155592919"
Message-ID: <6df76928-be7f-483e-9685-88ee245ef1bf@orange.com>
Date: Wed, 5 Jun 2024 16:22:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Chengen Du <chengen.du@canonical.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kaber@trash.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240604054823.20649-1-chengen.du@canonical.com>
 <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
 <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com>
Content-Language: fr, en-US
In-Reply-To: <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDA1LzA2LzIwMjQgMDg6MDMsIENoZW5nZW4gRHUgd3JvdGU6DQo+IE9uIFdlZCwgSnVu
IDUsIDIwMjQgYXQgNjo1N+KAr0FNIFdpbGxlbSBkZSBCcnVpam4NCj4gPHdpbGxlbWRlYnJ1aWpu
Lmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBhZGRzIHNvbWUgcGFyc2lu
ZyBvdmVyaGVhZCBpbiB0aGUgZGF0YXBhdGguIFNPQ0tfUkFXIGRvZXMgbm90DQo+ID4gbmVlZCBp
dCwgYXMgaXQgY2FuIHNlZSB0aGUgd2hvbGUgVkxBTiB0YWcuIFBlcmhhcHMgbGltaXQgdGhlIG5l
dw0KPiA+IGJyYW5jaGVzIHRvIFNPQ0tfREdSQU0gY2FzZXM/IFRoZW4gdGhlIGFib3ZlIGNhbiBh
bHNvIGJlIHNpbXBsaWZpZWQuDQo+DQo+IEkgY29uc2lkZXJlZCB0aGlzIGFwcHJvYWNoIGJlZm9y
ZSwgYnV0IGl0IHdvdWxkIHJlc3VsdCBpbiBkaWZmZXJlbnQNCj4gbWV0YWRhdGEgZm9yIFNPQ0tf
REdSQU0gYW5kIFNPQ0tfUkFXIHNjZW5hcmlvcy4gVGhpcyBkaWZmZXJlbmNlIG1ha2VzDQo+IG1l
IGhlc2l0YXRlIGJlY2F1c2UgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIHByb3ZpZGUgY29uc2lzdGVu
dCBtZXRhZGF0YQ0KPiB0byBkZXNjcmliZSB0aGUgc2FtZSBwYWNrZXQsIHJlZ2FyZGxlc3Mgb2Yg
dGhlIHJlY2VpdmVyJ3MgYXBwcm9hY2guDQo+IFRoZXNlIGFyZSBqdXN0IG15IHRob3VnaHRzIGFu
ZCBJJ20gb3BlbiB0byBmdXJ0aGVyIGRpc2N1c3Npb24uDQoNCkZXSVcsIEkgdm90ZSBmb3IgV2ls
bGVtJ3MgYXBwcm9hY2ggaGVyZTogdGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIGhhdmluZyANCmRp
ZmZlcmVudCBtZXRhZGF0YSBpbiBTT0NLX0RHUkFNIGFuZCBTT0NLX1JBVywgYXMgdGhlIHVuZGVy
bHlpbmcgcGFyc2luZyBlZmZvcnRzIA0KYXJlIGRpZmZlcmVudCBhbnl3YXksIGFsb25nIHdpdGgg
dGhlIHN0YXJ0IG9mZnNldCBmb3IgQlBGLg0KKE5vLCBJJ20gbm90IHN1cGVyIGhhcHB5IHRvIHNl
ZSBCUEYgY29kZSByZWFjaGluZyBvdXQgdG8gb2Zmc2V0IC00MDk2IG9yIHNvIHRvIA0KZ2V0IFZM
QU4gYXMgbWV0YWRhdGEuIFRoYXQganVzdCBzbWVsbHMgbGlrZSBhIGhvcnJlbmRvdXMga2x1ZGdl
LikNClRvIG1lLCBpdCBtYWtlcyBwbGVudHkgb2Ygc2Vuc2UgdG8gaGF2ZToNCiDCoC0gU09DS19E
R1JBTSBmb3IgY29tcGF0aWJpbGl0eSAodXNlZCBieSBldmVyeW9uZSB0b2RheSksIGRvaW5nIGFs
bCBoaXN0b3JpY2FsIA0Kc2hlbmFuaWdhbnMgd2l0aCBWTEFOcyBhbmQgbWV0YWRhdGENCiDCoC0g
U09DS19SQVcgZm9yIGEgbW9kZXJuLCBuZXcgQVBJLCBtYWtpbmcgbm8gYXNzdW1wdGlvbiBvbiBl
bmNhcHN1bGF0aW9uLCBhbmQgDQpwcmVzZW50aW5nIGFuIHVudG91Y2hlZCBsaW5lYXIgZnJhbWUN
CiDCoC0geWVzIHRoaXMgbWVhbnMgZGlmZmVyZW50IEJQRiBjb2RlIGZvciB0aGUgc2FtZSBmaWx0
ZXIgYmV0d2VlbiB0aGUgdHdvIG1vZGVzDQoNCkFnYWluLCBteSAuMDJjDQoNCi1BbGV4DQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KQ2UgbWVz
c2FnZSBldCBzZXMgcGllY2VzIGpvaW50ZXMgcGV1dmVudCBjb250ZW5pciBkZXMgaW5mb3JtYXRp
b25zIGNvbmZpZGVudGllbGxlcyBvdSBwcml2aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBkb25jDQpw
YXMgZXRyZSBkaWZmdXNlcywgZXhwbG9pdGVzIG91IGNvcGllcyBzYW5zIGF1dG9yaXNhdGlvbi4g
U2kgdm91cyBhdmV6IHJlY3UgY2UgbWVzc2FnZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBsZSBzaWdu
YWxlcg0KYSBsJ2V4cGVkaXRldXIgZXQgbGUgZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBwaWVjZXMg
am9pbnRlcy4gTGVzIG1lc3NhZ2VzIGVsZWN0cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGlibGVzIGQn
YWx0ZXJhdGlvbiwNCk9yYW5nZSBkZWNsaW5lIHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNpIGNlIG1l
c3NhZ2UgYSBldGUgYWx0ZXJlLCBkZWZvcm1lIG91IGZhbHNpZmllLiBNZXJjaS4NCg0KVGhpcyBt
ZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHBy
aXZpbGVnZWQgaW5mb3JtYXRpb24gdGhhdCBtYXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsNCnRoZXkg
c2hvdWxkIG5vdCBiZSBkaXN0cmlidXRlZCwgdXNlZCBvciBjb3BpZWQgd2l0aG91dCBhdXRob3Jp
c2F0aW9uLg0KSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNo
bWVudHMuDQpBcyBlbWFpbHMgbWF5IGJlIGFsdGVyZWQsIE9yYW5nZSBpcyBub3QgbGlhYmxlIGZv
ciBtZXNzYWdlcyB0aGF0IGhhdmUgYmVlbiBtb2RpZmllZCwgY2hhbmdlZCBvciBmYWxzaWZpZWQu
DQpUaGFuayB5b3UuCg==


