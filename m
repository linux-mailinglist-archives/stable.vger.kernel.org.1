Return-Path: <stable+bounces-45266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AF8C747E
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0301F22B69
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355F143754;
	Thu, 16 May 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="TNCCeRC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2210143874
	for <stable@vger.kernel.org>; Thu, 16 May 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854580; cv=none; b=RVi+Plk2AGgz27+EAutaf9Mz3hTrxDBfZfDLFeYVAQN4BKzTJZ4S8CHVzt8I9lVHHIaRaHT3HjehCguYJ423Cz720Ge9iXg5WxlUwvORI1vegNVWmYfT9YUD/CVTeDfO/L7VbopbEP7JaTCzQyoEuR3dTn2cxEJhXIunZGhlII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854580; c=relaxed/simple;
	bh=yGclzyRlDsM90wjhZaNTT7jnXhYBitHWcL7IOCSsNXw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gbli51aRfOuIlXlt8qOuFusTGjQ+3Sj/o8BBoyHfN+TDC/g08kSyMooDYsDSOJXsj5JEZQK5zmeauuS0OFSJJGbcQFAAyLPRdn9IRn9YZkcRQ0qQyGKNuBdkY8ONZ8x95lfeXMPRSggW3aSTOCaCoBnbOU04UGFE5jWB8V3nzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=TNCCeRC5; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1715854579; x=1747390579;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=yGclzyRlDsM90wjhZaNTT7jnXhYBitHWcL7IOCSsNXw=;
  b=TNCCeRC5P598mGwfgZ60dhgM53bt7LhArmfVdn92BaEtmtz3E1W4zeE5
   YACyAwWRPtzPcsbN6hBd8jTieQdkLs2YH8I2/15fFKyO7sqEJp/+Jv/vA
   v/W2CveMGMu4TaAUsoEev6SnYzjpHoMMl4va3owNWFHTfWILcJ8mCHA0G
   o=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; 
   d="scan'208";a="633218598"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:16:17 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:27954]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.135:2525] with esmtp (Farcaster)
 id 62e6987a-6284-40d3-a1c1-ab5177f85689; Thu, 16 May 2024 10:16:16 +0000 (UTC)
X-Farcaster-Flow-ID: 62e6987a-6284-40d3-a1c1-ab5177f85689
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 10:16:16 +0000
Received: from EX19D043EUB003.ant.amazon.com (10.252.61.69) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 10:16:15 +0000
Received: from EX19D043EUB003.ant.amazon.com ([fe80::ae8f:9ad3:ae84:18c5]) by
 EX19D043EUB003.ant.amazon.com ([fe80::ae8f:9ad3:ae84:18c5%3]) with mapi id
 15.02.1258.028; Thu, 16 May 2024 10:16:15 +0000
From: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Manthey, Norbert" <nmanthey@amazon.de>
Subject: Backport request
Thread-Topic: Backport request
Thread-Index: AQHap3oWsZZNJdAacEK5/g6Fw5mzKQ==
Date: Thu, 16 May 2024 10:16:15 +0000
Message-ID: <927F3175-7810-467F-A015-13B446248548@amazon.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E3EAEFD6A183F40BFD12314EE83416C@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSBiYWNrcG9ydCBjb21taXQ6DQoNCmVjZmU5YTAxNWQzZSAoInBpbmN0cmw6
IGNvcmU6IGhhbmRsZSByYWRpeF90cmVlX2luc2VydCgpIGVycm9ycyBpbiBwaW5jdHJsX3JlZ2lz
dGVyX29uZV9waW4oKSIpDQoNCnRvIHN0YWJsZSB0cmVlcyA1LjQueSwgNS4xMC55LCA1LjE1Lnks
IDYuMS55LiBUaGlzIGNvbW1pdCBmaXhlcyBlcnJvciBoYW5kbGluZyBvZiByYWRpeF90cmVlX2lu
c2VydCgpLg0KDQpUaGlzIGJ1ZyB3YXMgZGlzY292ZXJlZCBhbmQgcmVzb2x2ZWQgdXNpbmcgQ292
ZXJpdHkgU3RhdGljIEFuYWx5c2lzDQpTZWN1cml0eSBUZXN0aW5nIChTQVNUKSBieSBTeW5vcHN5
cywgSW5jLg0KDQpUaGFua3MsDQpIYWdhciBIZW1kYW4NCg0KIA0KDQoKCgpBbWF6b24gV2ViIFNl
cnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


