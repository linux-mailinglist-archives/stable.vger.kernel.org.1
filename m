Return-Path: <stable+bounces-28130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700AF87BA8B
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267731F23310
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AB6CDD3;
	Thu, 14 Mar 2024 09:36:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C636BFAC;
	Thu, 14 Mar 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408970; cv=none; b=gC+CqA9BVgvZIOgC8dhrPY3fIc2WWDZUTrqOP8q61N5FyV83/rjHyqrpn6CPFqB+YRfb0Ylxw5AmYFnRD4OXqnaHoG8RHaHpyKClBtSYkpphxIk6PSNodTJns+W55I90pyS+YJd5OdKUx2b+AxjGu9Sxk2goIFim0552fk83OtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408970; c=relaxed/simple;
	bh=Qcl1blVSnSRz1idRFGTxtnYrVglAakLoz0XoHSP6hkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MtdAV5nRSeMWfVdXTmXdz1Tio6KZ07IrLwdK1KSgOpJsMR+BymC/27dXt7BoG6r+0a0Q85gp1T7o0Qf5t/kHMo1ECXYrwmfDNjvVss6ANvwHb/iJnFn9xSyU+SWZx9hdWswg2YEN7QrBgrMpr3CV8ezRv2L35xEs+Fpcfe1ailE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4TwMKg3BqfzcXYv8;
	Thu, 14 Mar 2024 17:20:07 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 17:20:26 +0800
Received: from w025.hihonor.com (10.68.28.69) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 17:20:25 +0800
Received: from w025.hihonor.com ([fe80::5770:e914:c15d:4346]) by
 w025.hihonor.com ([fe80::5770:e914:c15d:4346%14]) with mapi id
 15.02.1258.025; Thu, 14 Mar 2024 17:20:25 +0800
From: yuanlinyu <yuanlinyu@hihonor.com>
To: Oliver Neukum <oneukum@suse.com>, Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable ep
Thread-Topic: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable
 ep
Thread-Index: AQHadd1DBEawBTTN7U63+22niyjmfrE2V6OAgACK6iCAABJd8A==
Date: Thu, 14 Mar 2024 09:20:25 +0000
Message-ID: <fd1200d4a72840acbb09e1d91ccd30c4@hihonor.com>
References: <20240314065949.2627778-1-yuanlinyu@hihonor.com>
 <2233fe16-ca3e-4a5e-bc69-a2447ddd2e82@suse.com>
 <ee024edfcb4447fb884878b15fe202f0@hihonor.com>
In-Reply-To: <ee024edfcb4447fb884878b15fe202f0@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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

PiBGcm9tOiB5dWFubGlueXUNCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE0LCAyMDI0IDQ6MTQg
UE0NCj4gVG86ICdPbGl2ZXIgTmV1a3VtJyA8b25ldWt1bUBzdXNlLmNvbT47IEFsYW4gU3Rlcm4N
Cj4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9y
Zzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxXSB1c2I6
IGZfbWFzc19zdG9yYWdlOiByZWR1Y2UgY2hhbmNlIHRvIHF1ZXVlIGRpc2FibGUgZXANCj4gDQo+
ID4gRnJvbTogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4NCj4gPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMTQsIDIwMjQgMzo1NCBQTQ0KPiA+DQo+ID4NCj4gPiBTb3JyeSwgbm93IGZv
ciB0aGUgbG9uZ2VyIGV4cGxhbmF0aW9uLiBZb3UnZCBpbnRyb2R1Y2UgYSBkZWFkbG9jay4NCj4g
PiBZb3UganVzdCBjYW5ub3Qgc2xlZXAgd2l0aCBhIHNwaW5sb2NrIGhlbGQuIEl0IHNlZW1zIHRv
IG1lIHRoYXQNCj4gDQo+IEkgZGlkbid0IHJldmlldyB1c2JfZXBfcXVldWUoKSBjbGVhcmx5LCBp
biBteSB0ZXN0LCBJIGRpZG4ndCBoaXQgc2xlZXAuDQo+IEJ1dCB0aGUgY29uY2VybiBpcyBnb29k
LCB3aWxsIGZpbmQgYmV0dGVyIHdheSB0byBhdm9pZCBpdC4NCg0KT2xpdmVyLCBjb3VsZCB5b3Ug
c2hhcmUgb25lIGV4YW1wbGUgd2hpY2ggY2FuIHNsZWVwID8NCg0KSSBjaGVjayBzZXZlcmFsIFVE
QyBkcml2ZXJzLCBsaWtlIGR3YzMsIGNkbnNwLCBjZG5zMywgDQpCb3RoIGRpc2FibGUvcXVldWUg
ZnVuY3Rpb24gaGF2ZSBzcGlubG9jaywgdGhpcyBtZWFucyBubyBzbGVlcCwgcmlnaHQgPw0KDQo+
IA0KPiA+IGlmIHlvdSB3YW50IHRvIGRvIHRoaXMgY2xlYW5seSwgeW91IG5lZWQgdG8gcmV2aXNp
dCB0aGUgbG9ja2luZw0KPiA+IHRvIHVzZSBsb2NrcyB5b3UgY2FuIHNsZWVwIHVuZGVyLg0KPiA+
DQo+ID4gCUhUSA0KPiA+IAkJT2xpdmVyDQo=

