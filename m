Return-Path: <stable+bounces-93635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F09CFE62
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17B92844A0
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B119046E;
	Sat, 16 Nov 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iO9gL/DV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEF79D0
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731755286; cv=none; b=Sk187XToEVeUOz/caQ/3Y3CbsWL7mZQCgaidl0G2+jYtMOh7MbggY+BeV9ow6sYK0rbRblPZcSr6gy5X5EuwTV8zRfv+qu5j6I6yDvUdSWs79S00NMtk/qey8OByU7S7G9HSjxdUne5V9Zs1nQaE4rBf3pkeWZxxaXyCvHg98j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731755286; c=relaxed/simple;
	bh=aGFZT3LexnXwNnduyFroiIDDEcUkQ5Sjn3Fq8FzAa/4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t9G0U5vFEETYI7DN9t3aqDE3xXKaK0frRNYjI2U0GYkXKH6S8KZciQ18KKWPHd8Y/udW+wLgp708UoKPpl4vFAKh2rSUFlHfC5peGeaIV2rQWug22JwHUwSOmjJOfDXaSBhIYZ8v+nHjSvQVaINZHAiVgR+E1II/bhUU+fw9NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=iO9gL/DV; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1731755285; x=1763291285;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=aGFZT3LexnXwNnduyFroiIDDEcUkQ5Sjn3Fq8FzAa/4=;
  b=iO9gL/DVvednVlIGJrCKMoRhTZCTd5oBsSdW2fZfFDBkHwR/DN1iS3hI
   9/ki6jkXEB81SmGlLaBH2eGaqBXMEjamP8UW1V3EAJ8kMlCxg+JZV3yD0
   fdwrl+01csFW7T15PK6c+dOn1DwUvV4+5lh0ogvo+76orMiKuAXBgsFmJ
   k=;
X-IronPort-AV: E=Sophos;i="6.12,159,1728950400"; 
   d="scan'208";a="247545868"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:08:03 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:3408]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.11:2525] with esmtp (Farcaster)
 id 65a8eb73-ee7e-4fc8-8637-6625c64c5591; Sat, 16 Nov 2024 11:08:01 +0000 (UTC)
X-Farcaster-Flow-ID: 65a8eb73-ee7e-4fc8-8637-6625c64c5591
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 16 Nov 2024 11:08:00 +0000
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19D015EUB004.ant.amazon.com (10.252.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 16 Nov 2024 11:08:00 +0000
Received: from EX19D015EUB003.ant.amazon.com ([fe80::c0b7:2320:49e3:8444]) by
 EX19D015EUB003.ant.amazon.com ([fe80::c0b7:2320:49e3:8444%3]) with mapi id
 15.02.1258.034; Sat, 16 Nov 2024 11:08:00 +0000
From: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Subject: Backport request
Thread-Topic: Backport request
Thread-Index: AQHbOBfMnEWgrb0Sm0W8tFX/tKaqHw==
Date: Sat, 16 Nov 2024 11:08:00 +0000
Message-ID: <E15AA884-690F-495C-BFFA-612DD4177952@amazon.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3C9A9727B375A458DDEDEC3633B824B@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSBiYWNrcG9ydCBjb21taXQ6DQoNCjBmYWY4NGNhZWU2MyAoImNwdWZyZXE6
IFJlcGxhY2UgZGVwcmVjYXRlZCBzdHJuY3B5KCkgd2l0aCBzdHJzY3B5KCkiKQ0KDQp0byBzdGFi
bGUgdHJlZXMgNS4xMC55LCA1LjE1LnksIDYuMS55IGFuZCA2LjYueS4gVGhpcyBjb21taXQgZml4
ZXMgcG9zc2libGUNCkJ1ZmZlciBub3QgbnVsbCB0ZXJtaW5hdGVkIG9mICJwb2xpY3ktPmxhc3Rf
Z292ZXJub3IiIGFuZCAiZGVmYXVsdF9nb3Zlcm5vciINCmluIF9fY3B1ZnJlcV9vZmZsaW5lKCkg
YW5kIGNwdWZyZXFfY29yZV9pbml0KCkuDQoNClRoaXMgYnVnIHdhcyBkaXNjb3ZlcmVkIGFuZCBy
ZXNvbHZlZCB1c2luZyBDb3Zlcml0eSBTdGF0aWMgQW5hbHlzaXMNClNlY3VyaXR5IFRlc3Rpbmcg
KFNBU1QpIGJ5IFN5bm9wc3lzLCBJbmMuDQoNCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2Vz
Y2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIK
U2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


