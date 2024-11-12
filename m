Return-Path: <stable+bounces-92383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C971E9C54A0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC56B316ED
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05842212D13;
	Tue, 12 Nov 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="rxlpVCYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019842144A8
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407480; cv=none; b=BfLNLLNF6PGBsnqsZvbK+4M7hrVZmP+Quhfp/Y5XD5CqPuFLHTLfbzgm8VcKU7stfv2vuGO3qJLWz0q4dGf1wDfJgJzuZH7tbuPY7Uxz2SrgatsJFkVPQ1XmUC1G3FhQL1K5QW2x1Q9BDNnR4Lzk3Fwm0qYCnE41js5YegSun7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407480; c=relaxed/simple;
	bh=GcA//cEz6bcyx71FVu62Jgi7XMSfc1OxRnd3mTLUxXA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UqR9KYBKLvchyUwy6HwNrHynuf1EsXMmdmX1QGjMmPkbkY5MJpgOnYpewC23joFdJWMXT6Ce0bl5fRICDgHyLQ4o3hJrMJr/Igp1OggtC1d7Jw9wAzcBW11TEfdtdxWz1DrOQm4BukmJM5gzrJFZW+nysRL0aQCozGWfCRa0B3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=rxlpVCYN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1731407479; x=1762943479;
  h=from:to:subject:date:message-id:content-id:mime-version:
   content-transfer-encoding;
  bh=GcA//cEz6bcyx71FVu62Jgi7XMSfc1OxRnd3mTLUxXA=;
  b=rxlpVCYN+CIFmbhtRw6Kf4grREPaot/Qr67UEpwbjo2EBSVrrOuMJSk9
   +PZhRkhsS0PPZE9fimbGhZu0vvqmItskrMKBPvweSzwsuHSofHAXx2Fiv
   VzsInUvuxOR9NR3koAxEtyf0G+SjnImpC3BprNqN1bVdFdWOJ0N3wlXsW
   k=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="246577699"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 10:31:15 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:62026]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.109:2525] with esmtp (Farcaster)
 id f31ec6b1-da3a-4e61-8c9c-8eb714f662e7; Tue, 12 Nov 2024 10:31:13 +0000 (UTC)
X-Farcaster-Flow-ID: f31ec6b1-da3a-4e61-8c9c-8eb714f662e7
Received: from EX19D015EUB002.ant.amazon.com (10.252.51.123) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 10:31:13 +0000
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19D015EUB002.ant.amazon.com (10.252.51.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 10:31:13 +0000
Received: from EX19D015EUB003.ant.amazon.com ([fe80::c0b7:2320:49e3:8444]) by
 EX19D015EUB003.ant.amazon.com ([fe80::c0b7:2320:49e3:8444%3]) with mapi id
 15.02.1258.034; Tue, 12 Nov 2024 10:31:13 +0000
From: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Backport request
Thread-Topic: Backport request
Thread-Index: AQHbNO3/VLeohoefdkGRLCfeJu0B0Q==
Date: Tue, 12 Nov 2024 10:31:12 +0000
Message-ID: <F7DEAB0E-AFE7-487E-9472-7675D9A75747@amazon.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F9E1652D0D7E4F909FDD9ADDED5B77@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

IEhpLA0KDQpQbGVhc2UgYmFja3BvcnQgY29tbWl0Og0KDQo1OWY4ZjBiNTRjOGYgKCJtZC9yYWlk
MTA6IGltcHJvdmUgY29kZSBvZiBtcmRldiBpbiByYWlkMTBfc3luY19yZXF1ZXN0IikNCg0KdG8g
c3RhYmxlIHRyZWVzIDUuNC55LCA1LjEwLnksIDUuMTUueSwgNi4xLnkuIFRoaXMgY29tbWl0IGZp
eGVzIERlcmVmZXJlbmNlIGFmdGVyDQpudWxsIGNoZWNrIG9mICImbXJkZXYtPm5yX3BlbmRpbmci
IGluIHJhaWQxMF9zeW5jX3JlcXVlc3QoKS4NCg0KVGhpcyBidWcgd2FzIGRpc2NvdmVyZWQgYW5k
IHJlc29sdmVkIHVzaW5nIENvdmVyaXR5IFN0YXRpYyBBbmFseXNpcw0KU2VjdXJpdHkgVGVzdGlu
ZyAoU0FTVCkgYnkgU3lub3BzeXMsIEluYy4NCg0KDQoNCgoKCkFtYXpvbiBXZWIgU2VydmljZXMg
RGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlz
cwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3
NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


