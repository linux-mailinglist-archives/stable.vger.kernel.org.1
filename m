Return-Path: <stable+bounces-225416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCyHBvROtWm8zAAAu9opvQ
	(envelope-from <stable+bounces-225416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:05:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6B28CFB9
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEB4302DA1C
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7312C1585;
	Sat, 14 Mar 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YruHKUV5";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YruHKUV5"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020139.outbound.protection.outlook.com [52.101.69.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA25A640;
	Sat, 14 Mar 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.139
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489903; cv=fail; b=e1FBdxfzJq57csUMfc8v0bRyQOlaBaKycDoqabX61Chzk4XW2gbLwcjIEtPwJHd7r61qv4uE4Xd5uK5EVQSVCW1F3poQ8DBqRw0b2q7tgx+dzN7Wc+THgim1p67kOun7hkJK6D2AV1DqEPBf/cEmDvoqboKIjTqMskjDo7DPAg0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489903; c=relaxed/simple;
	bh=TnWG1he4SGd9pvdJWfu3okbYrWdrlP4vPrmDAiBxYKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeEQAwcC6oOGXa4h9gxOx0GmiAvosuWh/cb4lrICU4zIYfoi+iQq/Y3lQTNfQ4cXVp7wXWbGY/FBAR7t+uXSTqGqiIBT/fckvjyoGzTVwjZcDp5++uOyWkb5jAR6mzlugZfa3i+7D7PC/E/J+Jg+Xmdljk25j74IKmWsAorjhiA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YruHKUV5; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YruHKUV5; arc=fail smtp.client-ip=52.101.69.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gmW1ugyMtx54aP6bi/GY8eIsgl40B8nCj9k7EaxMllhQ4pom2OOFNuVnMiK2jovlEydWyjFqNQ8sH2XCBhkAKbxF/urVfVt5oD/+7MXH1G8rP6xvwChZ9dVwDWi4kn8FmIBEjAlXYU5o3hZzyFPleNu0HjcFkEHusARKMD5AdpSQoE7dwmzWhOaJYPzdKdbqO9IGEyd08QBxQmZd/6UBvGcCUPASvzUklyNwk47oZ3f5UMNrpxGrYYwVpeuv2k2T+PxK8ohimP4BrBoaIhQcEK41mCA14SOrhiTTiSpZf40Zp59Og7cPppC17d5ovsl5U2geV78uZqIJK9Oq27oWoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnWG1he4SGd9pvdJWfu3okbYrWdrlP4vPrmDAiBxYKk=;
 b=UsQpTkU/Vs/LnCJ8YrX4MNDRX+Vm5efto/N7lvHzQ4QkSlWYnM0xxX0uy82NVhMLfqmr506+viE7lDLbYvVYgqKBuQ5Zyo1c+7qeSXTO21/jbcCXp8a1oSpQiTcnaHW1io9Ve365fOBfwiAxM4SVCiebjCOX3tZQU3z6C/5R+9/6n8sH3XaTLbMlkwhFhUfgZPd4fHLM7daWCuUJPaN3AjIlFbtQeR1UcSCtDG1UQaOGeFljJceRf71U+lT1leSq3BHL3q/RzjRlghBVtH0txMSHyd1SYtfkERDgy3OMz+JlBGGlqGmmgea6yqD7ZXdSYO6VXDE2wyNU/iSRWgl5Sw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnWG1he4SGd9pvdJWfu3okbYrWdrlP4vPrmDAiBxYKk=;
 b=YruHKUV57hbPc+ozqn9BRW3E/0ogq6ihyUQIOK58PL8ZD98KIbelb+NwK7SDLc8qXVQTikCrkb7TK6v/mvES2YJYW4sNDtc7Ad9HFlUVsTNthfRHxEHmn4O4RRQTaXcI9N5tiJRtNyCkfgLHrHj9xpYdvzUNS5xZuY6KgmhUSho=
Received: from DUZPR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::11) by DU4PR04MB11792.eurprd04.prod.outlook.com
 (2603:10a6:10:624::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Sat, 14 Mar
 2026 12:04:46 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::95) by DUZPR01CA0084.outlook.office365.com
 (2603:10a6:10:46a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.19 via Frontend Transport; Sat,
 14 Mar 2026 12:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via
 Frontend Transport; Sat, 14 Mar 2026 12:04:58 +0000
Received: from emails-4525761-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-17.eu-west-1.compute.internal [10.20.6.17])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E6AA07FF28;
	Sat, 14 Mar 2026 12:04:57 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sat Mar 14 12:04:52 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwGrZagrNJdhueUakU5MUfoCD+3GEILorSiX1PwSGcGEGCU5RIn0tINK6oQJM0D2xRZtjlF4kl4NwrwKlrXJIUPM8Tiesra0AHbyJYVkuhZdue2F/+aYzBum2biOamdjm4QF2wyCFwcKPa2N9Bo3kqKT81VdxVdZGA/HzZ1eNUyxfohdIGi/HX4Yvh5g4/2W4k/41o2xmUBMIm0PAAfljukYni8f4EtwnTiH8hFL5JUh8pS7sGUvrjzDLLsfyfO353sQqWeIi91rpYo+YbJ9TmWAi9Wt7uAcVqyYZcHTKm8xr/sEnSx3QAxRsYXFKksB4Usq8YfN5thmF2kxO+8wPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnWG1he4SGd9pvdJWfu3okbYrWdrlP4vPrmDAiBxYKk=;
 b=YGCzQ10RcKG+pPk6GGlqEcTbI5PHhJjKErINvxAXbvtwzATdnBaQ63tE0sbWvzLcFa70a2wrlgqnCgGAOS+o11Cp0/KDNoA0Abfut847HDvkvaEYSudJmnT5/jdtmyplkRDlBAt0gtJJzb4hCh0xR/64XNA5Y9Ets1SYe3amFJJRTjfjq6zUjO6TZ9P0buab8aYhoBptIpM8jJO8eXoeDv0Fa323+OUKMXzzR+mOg4BxrfCLkU7psu9YSI97VUYK3PJrgeh3rEbGqcQOFUYae3EQlKU1E1jH6H50x+cm8IR8dQ+/RlCDD05zbW4Og3x5SqlDpmbHUqCZkOnBEm3WoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnWG1he4SGd9pvdJWfu3okbYrWdrlP4vPrmDAiBxYKk=;
 b=YruHKUV57hbPc+ozqn9BRW3E/0ogq6ihyUQIOK58PL8ZD98KIbelb+NwK7SDLc8qXVQTikCrkb7TK6v/mvES2YJYW4sNDtc7Ad9HFlUVsTNthfRHxEHmn4O4RRQTaXcI9N5tiJRtNyCkfgLHrHj9xpYdvzUNS5xZuY6KgmhUSho=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 12:04:32 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Sat, 14 Mar 2026
 12:04:32 +0000
From: Josua Mayer <josua@solid-run.com>
To: Frank Li <Frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Carlos
 Song <carlos.song@nxp.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Topic: [PATCH v4 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Index: AQHcsvSPNzFfxljBGUOcmi0OwyrMwbWs1ZwAgAEZ/oA=
Date: Sat, 14 Mar 2026 12:04:32 +0000
Message-ID: <251667eb-7d51-4a36-800d-558aa62dbf77@solid-run.com>
References: <20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com>
 <20260313-lx2160-sd-cd-v4-1-aabcf230fbff@solid-run.com>
 <abRiVBgaYg72avcX@lizhi-Precision-Tower-5810>
In-Reply-To: <abRiVBgaYg72avcX@lizhi-Precision-Tower-5810>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AM7PR04MB6805:EE_|DU2PEPF0001E9C1:EE_|DU4PR04MB11792:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab867da-07f3-41d4-96c5-08de81c1e997
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 c6O1iVlSkrUh8NnB8KhOeHMhgM/rc71RfWxQtmoZf3Ic/DSbYQL5ZcVNPnzJt2kkJ7JduCLl2Fq8AiR0wWYeHlF3smVg6HEv085HQpQVJiAh/NAdqH/BB+vhZ34o0A0eCWy4OAGLUBnirto7njLdgeIaFEljS6UzGaYuvaQJRvek4nZxMqcNLa0bLfPeeXIoB6+v+9CbpkDuZ3ToasPgllKEKqc4k8BHONJvBEzNRrRmVoUCKvbNCgY0f/5onHyCMRZLw2KwPDgXP9eZLEtSP5X+//pKCPlTuQ1O+nuBzIvNQLpaQ1Za9IVKq14rwJ0lozMssGkzfW/nNkJEJFnFRj3S3Jo9AUefD5n3z/yo3I+LuYxSDx+0jMNpeZwRM7CiVq/NPoSYJkfBaJdMVRIvObEMq4umqB4XQPjCVhIvcdnKc1JxzdgMqloZVVUv7o4vtTpwfNJOQiL+ycgiz1/ZAIGhjFIb74BJ49g6fEWnao/6ZbrRn5UJD44naeZtB20HkUQeFGHBEQwQuUeTyYDC3fXmlcU9uXYhJFpZse8JsfY1l3og1cIn/1YV7Nffo+X/iDRbB+oxpgX955SSLa5PaB3hRHZ/FH/NvHGdMKFk/0vLtcz23Ij6tU8LA6HLiIAzwwpRUqU83Q51YP+Aq+xYaH8kZzfO75uGFO2smHe8+BmOh1d1kvDo6w20qjCeUBYhlCQdV7aRb37xwH3aW0l5j//vgH3OrRD8yHBdkeRPmaBmOqjAfala4WwUSJ9Z/uVCzZ6GDi+Gkb32LCmvd4+n4xK1aPJ6hwWMcks1uGI958A=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B41569B209C7D2448E1CBC46510D4320@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 DS/mgJr6+DcUxictOBr/11FEctd+3Jg5UsZFNBslgdRZUbABuRZIg/CjlDziKYZaqXn88RZi0IPe+AfJhgsbvX2Ic9Y+8dGhJmr02RH0kWERpYg97gaSORpSd1hdI4to/BPsLdoKU1OocF3KxLc72kIBGNdpoCc7aJKGmQVXj/XimkVLptZv5rF+FZ9W231L+Y7a1NEhFxHcP4PwQC3P7xj3dgIjN3JjB8QQjjvwf0Wkathx+2M5W8eH63LRODFtKAXnu+dzH2RFMqXwfne4PTcVF/scVAwbhITl2zHG6IgaZ13vYtGPYB7xpyq1re0X4gP7MKNxQ8LsJ8C6il4y4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c4dcc6a428a64c9f8b44d819cd14bf2b:solidrun,office365_emails,sent,inline:6944135e326fbdddd5ffbc447fe47131
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a34f6c77-ee33-451c-a232-08de81c1da6c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700016|82310400026|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MYFpwxQqznuDiwHF49vGtx9ibRoMUPEnNdAlyPWsDUmINal35UjFaxj19TsbkPJdRD7ZXmegiiAnH6JEZ5rYQ/AIcljedCs+2eiB4cwW6+FmB14FtT2+xC75fgPvxu7xpBIIcI2oy64rwoXXc4rPrxPmKRPjnS/Bis16p0klDBnTmBYBdrctyhdqLqUVZu4LynaancnN7YyUpYii6crw7kbFi5pQfX1cV6r9Y1zpZOX9Kz+dM8SSYQJOMNbtuJQzEAnIHNAQBwLedU6X0NZejb8iJh4hnHMCA/f2HszrlGisPwXn7KUXldMzIvSvpmmpibDVXe/OTKiUk84Z0UzKBY4VU8ChYcmLMTE6j/KfrR+eDZ4B+NFxMWMKpaFUaesInMLOHq8UmCA6BajjPQcZLRDLzFgFmZDxqce+D59zHXntOvQKwXjaRLqSBZdbbPIaIDm4Heuq6VUD7rSucabSv12PjMGTQGJ5JxGLS9aXmcT35+IH9woianWqbHJcWT0K7hVAGmdVKBNVKewg7pc4eGV0IlxCMpy8ncfxhLbw6DMKMCWbEdCk9gL0/mLWeailTgOjbll+4dQ7tQ2WoddPHKGpuCC5Z9ilKL5h45h0ZUrIHGPr1tBBbTe0GTQvafVAT2HHj3u8ZLk7vUzNwLplkGTZ6jdKgsvfr12O4e3seaETsAbqIDjZJINd/KN6QMv1r7XJuIEKdZlKFJMzsep8Cr44CTdkPzAid0JXz5uJpAbN+ROC1S3N/KC9pNb192Tf6JJ72X0fLDmu0YHDZVj14Q==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700016)(82310400026)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PlsPkt/l3+WJqu0Iy7r587DyPgkc0m8h3ybYgoA0TBlUYnhAj97Hu9xLloEfROOJqm3FpV67R6gUe7JX/39kBCF0UBvdHptcyY5/GA44Rd6v+zKzAbPRHcVfx/UVGZE8NBJOQ4qZnewWa2oFKxeYEIJ6S0lZcTQnA0wTR0FNEa+vLuoXFmjkmrx1BqpNoahtvikub16XzisIQzZXrY2Dznn1wcvoM+4Ygspc1iaoMlNCYT6xQILBgKYTg84+A+pa+8xUUdZVD+CVTh0LwlZ4FLWfJiyrx/RXRAiqFY3X/irIg+4bOXJSuCeBmZxB1u34RSFB91EEWsvYShXaJKnROG+z1uPEr3L5/WVkhX5iGFCUyXeEMPpKSITN0pT2UiQMACEKmF0XK6UHceMXdlR3aJVpcZNfTGEUCLWju+m64fsh0KJPi4+v4VCeo8OzpIcx
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:04:58.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab867da-07f3-41d4-96c5-08de81c1e997
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11792
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225416-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6f:email,0.0.0.0:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.51:email,0.0.0.15:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6AF6B28CFB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

QW0gMTMuMDMuMjYgdW0gMjA6MTUgc2NocmllYiBGcmFuayBMaToNCj4gT24gRnJpLCBNYXIgMTMs
IDIwMjYgYXQgMDM6MjA6NDJQTSArMDEwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBDb21taXQg
OGExMzY1YzdiYmMxICgiYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHBpbm11eCBhbmQgaTJjIGdw
aW8gdG8NCj4+IHN1cHBvcnQgYnVzIHJlY292ZXJ5IikgaW50cm9kdWNlZCBwaW5tdXggbm9kZXMg
Zm9yIGx4MjE2MCBpMmMNCj4+IGludGVyZmFjZXMsIGFsbG93aW5nIHJ1bnRpbWUgY2hhbmdlIGJl
dHdlZW4gaTJjIGFuZCBncGlvIGZ1bmN0aW9ucw0KPj4gaW1wbGVtZW50aW5nIGJ1cyByZWNvdmVy
eS4NCj4+DQo+PiBUaGlzIGhhcyBjYXVzZWQgdW5pbnRlbmRlZCBzaWRlLWVmZmVjdHMgb24gU29s
aWRSdW4gYm9hcmRzIHdoZXJlIHRoZQ0KPj4gZmlyc3QgYXBwbGljYXRpb24gb2YgYSBwaW5tdXgg
bm9kZSBjbGVhcmVkIGFsbCBiaXRzIGluIGEgMzItYml0IHdvcmQsDQo+PiBjb3JydXB0aW5nIHRo
ZSBjb25maWd1cmF0aW9uIHByZXZpb3VzbHkgc2V0IGJ5IGJvb3Rsb2FkZXIuDQo+Pg0KPj4gVGhl
IExYMjE2MCBTb0MgaXMgY29uZmlndXJlZCBhdCBwb3dlci1vbiBmcm9tIFJDVyAoUmVzZXQNCj4+
IENvbmZpZ3VyYXRpb24gV29yZCkgdHlwaWNhbGx5IGxvY2F0ZWQgaW4gdGhlIGZpcnN0IDRrIG9m
IGJvb3QgbWVkaWEuDQo+PiBUaGlzIGJsb2IgY29uZmlndXJlcyB2YXJpb3VzIGNsb2NrIHJhdGVz
IGFuZCBwaW4gZnVuY3Rpb25zLg0KPj4gVGhlIHBpbm11eCBmb3IgaTJjIHNwZWNpZmljYWxseSBp
cyBwYXJ0IG9mIGNvbmZpZ3VyYXRpb24gd29yZHMgUkNXU1IxMiwNCj4+IFJDV1NSMTMgYW5kIFJD
V1NSMTQgc2l6ZSAzMiBiaXQgZWFjaC4NCj4+IFRoZXNlIHZhbHVlcyBhcmUgYWNjZXNzaWJsZSBh
dCByZWFkLW9ubHkgYWRkcmVzc2VzIDB4MDFlMDAxMmMgZm9sbG93aW5nLg0KPj4NCj4+IEZvciBy
dW50aW1lIChyZS0pY29uZmlndXJhdGlvbiB0aGUgU29DIGhhcyBhIGR5bmFtaWMgY29uZmlndXJh
dGlvbiBhcmVhDQo+PiB3aGVyZSBhbHRlcm5hdGl2ZSBzZXR0aW5ncyBjYW4gYmUgYXBwbGllZC4g
VGhlIGNvdW50ZXJwYXJ0cyBvZg0KPj4gUkNXU1JbMTItMTRdIGNhbiBiZSBvdmVycmlkZGVuIGF0
IDB4NzAwMTAwMTJjIGZvbGxvd2luZy4NCj4+DQo+PiBUaGUgY29tbWl0IGluIHF1ZXN0aW9uIHVz
ZWQgdGhpcyBhcmVhIHRvIHN3aXRjaCBpMmMgcGlucyBiZXR3ZWVuIGkyYyBhbmQNCj4+IGdwaW8g
ZnVuY3Rpb24gYXQgcnVudGltZSB1c2luZyB0aGUgcGluY3RybC1zaW5nbGUgZHJpdmVyIC0gd2hp
Y2ggcmVhZHMgYQ0KPj4gMzItYml0IHZhbHVlLCBtYWtlcyBwYXJ0aWN1bGFyIGNoYW5nZXMgYnkg
Yml0bWFzayBhbmQgd3JpdGVzIGJhY2sgdGhlDQo+PiBuZXcgdmFsdWUuDQo+Pg0KPj4gU29saWRS
dW4gaGF2ZSBvYnNlcnZlZCB0aGF0IGlmIHRoZSBkeW5hbWljIGNvbmZpZ3VyYXRpb24gaXMgcmVh
ZCBmaXJzdA0KPj4gKGJlZm9yZSBhIHdyaXRlKSwgaXQgcmVhZHMgYXMgemVybyByZWdhcmRsZXNz
IHRoZSBpbml0aWFsIHZhbHVlcyBzZXQgYnkNCj4+IFJDVy4gQWZ0ZXIgdGhlIGZpcnN0IHdyaXRl
IGNvbnNlY3V0aXZlIHJlYWRzIHJlZmxlY3QgdGhlIHdyaXR0ZW4gdmFsdWUuDQo+Pg0KPj4gQmVj
YXVzZSBtdWx0aXBsZSBwaW5zIGFyZSBjb25maWd1cmVkIGZyb20gYSBzaW5nbGUgMzItYml0IHZh
bHVlLCB0aGlzDQo+PiBjYXVzZXMgdW5pbnRlbnRpb25hbCBjaGFuZ2Ugb2YgYWxsIGJpdHMgKGV4
Y2VwdCB0aG9zZSBmb3IgaTJjKSBiZWluZyBzZXQNCj4+IHRvIHplcm8gd2hlbiB0aGUgcGluY3Ry
bCBkcml2ZXIgYXBwbGllcyB0aGUgZmlyc3QgY29uZmlndXJhdGlvbi4NCj4+DQo+PiBTZWUgYmVs
b3cgYSBzaG9ydCBsaXN0IG9mIHdoaWNoIGZ1bmN0aW9ucyBSQ1dTUjEyIGFsb25lIGNvbnRyb2xz
Og0KPj4NCj4+IExYMjE2Mi1DRiBSQ1dTUjEyOiAwYjAwMDAxMDAwMDAwMDAwMDAgMDAwMDAwMDAw
MDAwMDExMA0KPj4gSUlDMl9QTVVYICAgICAgICAgICAgICB8fHwgICB8fHwgICB8fCB8ICAgfHx8
ICAgfHx8WFhYIDogSTJDL0dQSU8vQ0QtV1ANCj4+IElJQzNfUE1VWCAgICAgICAgICAgICAgfHx8
ICAgfHx8ICAgfHwgfCAgIHx8fCAgIFhYWCAgICA6IEkyQy9HUElPL0NBTi9FVlQNCj4+IElJQzRf
UE1VWCAgICAgICAgICAgICAgfHx8ICAgfHx8ICAgfHwgfCAgIHx8fFhYWHx8fCAgICA6IEkyQy9H
UElPL0NBTi9FVlQNCj4+IElJQzVfUE1VWCAgICAgICAgICAgICAgfHx8ICAgfHx8ICAgfHwgfCAg
IFhYWCAgIHx8fCAgICA6IEkyQy9HUElPL1NESEMtQ0xLDQo+PiBJSUM2X1BNVVggICAgICAgICAg
ICAgIHx8fCAgIHx8fCAgIHx8IHxYWFh8fHwgICB8fHwgICAgOiBJMkMvR1BJTy9TREhDLUNMSw0K
Pj4gWFNQSTFfQV9EQVRBNzRfUE1VWCAgICB8fHwgICB8fHwgICBYWCBYICAgfHx8ICAgfHx8ICAg
IDogWFNQSS9HUElPDQo+PiBYU1BJMV9BX0RBVEEzMF9QTVVYICAgIHx8fCAgIHx8fFhYWHx8IHwg
ICB8fHwgICB8fHwgICAgOiBYU1BJL0dQSU8NCj4+IFhTUEkxX0FfQkFTRV9QTVVYICAgICAgfHx8
ICAgWFhYICAgfHwgfCAgIHx8fCAgIHx8fCAgICA6IFhTUEkvR1BJTw0KPj4gU0RIQzFfQkFTRV9Q
TVVYICAgICAgICB8fHxYWFh8fHwgICB8fCB8ICAgfHx8ICAgfHx8ICAgIDogU0RIQy9HUElPL1NQ
SQ0KPj4gU0RIQzFfRElSX1BNVVggICAgICAgICBYWFggICB8fHwgICB8fCB8ICAgfHx8ICAgfHx8
ICAgIDogU0RIQy9HUElPL1NQSQ0KPj4gUkVTRVJWRUQgICAgICAgICAgICAgWFh8fHwgICB8fHwg
ICB8fCB8ICAgfHx8ICAgfHx8ICAgIDoNCj4gTGlzdCB0d28gSUlDMl9QTVVYIGFuZCBTREhDMV9E
SVJfUE1VWCBzaG91bGQgYmUgZW5vdWdoLg0KPg0KPj4gT24gTFgyMTYyQSBDbGVhcmZvZyB0aGUg
aW5pdGlhbCAoYW5kIGludGVuZGVkKSB2YWx1ZSBpcyAweDA4MDAwMDA2IC0NCj4+IGVuYWJsaW5n
IGNhcmQtZGV0ZWN0IG9uIElJQzJfUE1VWCBhbmQgY29udHJvbCBHUElPcyBvbiBTREhDMV9ESVJf
UE1VWC4NCj4+IEV2ZXJ5dGhpbmcgZWxzZSBpcyBpbnRlbnRpb25hbCB6ZXJvIChlbmFibGluZyBJ
MkMgJiBYU1BJKS4NCj4+DQo+PiBCeSByZWFkaW5nIHplcm8gZnJvbSBkeW5hbWljIGNvbmZpZ3Vy
YXRpb24gYXJlYSwgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbg0KPj4gY2hhbmdlcyBJSUMyX1BNVVgg
dG8gdmFsdWUgMCAoSTJDIGZ1bmN0aW9uKSwgYW5kIFNESEMxX0RJUl9QTVVYIHRvIDANCj4+IChT
REhDIGRhdGEgZGlyZWN0aW9uIGZ1bmN0aW9uKSAtIGJyZWFraW5nIGNhcmQtZGV0ZWN0IGFuZCBs
ZWQgZ3Bpb3MuDQo+Pg0KPj4gVGhpcyBpc3N1ZSBzaG91bGQgYWZmZWN0IGFueSBib2FyZCBiYXNl
ZCBvbiBMWDIxNjAgU29DIHRoYXQgaXMgdXNpbmcgdGhlDQo+PiBzYW1lIG9yIGVhcmxpZXIgdmVy
c2lvbnMgb2YgTlhQIGJvb3Rsb2FkZXIgYXMgU29saWRSdW4gaGF2ZSB0ZXN0ZWQsIGluDQo+PiBw
YXJ0aWN1bGFyOiBMU0RLLTIxLjA4IGFuZCBMUy01LjE1LjcxLTIuMi4wLg0KPj4NCj4+IFdoZXRo
ZXIgTlhQIGFkZGVkIHNvbWUgZXh0cmEgaW5pdGlhbGlzYXRpb24gaW4gdGhlIGJvb3Rsb2FkZXIg
b24gbGF0ZXINCj4+IHJlbGVhc2VzIHdhcyBub3QgaW52ZXN0aWdhdGVkLiBIb3dldmVyIGJvb3Rs
b2FkZXIgdXBncmFkZSBzaG91bGQgbm90IGJlDQo+PiBuZWNlc3NhcnkgdG8gcnVuIGEgbmV3ZXIg
TGludXgga2VybmVsLg0KPj4NCj4+IFRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWUgaXQgaXMgcG9z
c2libGUgdG8gZXhwbGljaXRseSBkZWZpbmUgQUxMIHBpbnMNCj4+IGNvbnRyb2xsZWQgYnkgYW55
IDMyLWJpdCB2YWx1ZSBzbyB0aGF0IGdyYWR1YWxseSBhZnRlciBwcm9jZXNzaW5nIGFsbA0KPj4g
cGluY3RybCBub2RlcyB0aGUgY29ycmVjdCB2YWx1ZSBpcyByZWFjaGVkIG9uIGFsbCBiaXRzLg0K
Pj4NCj4+IFRoaXMgaXMgYSBsYXJnZSB0YXNrIHRoYXQgc2hvdWxkIGJlIGRvbmUgY2FyZWZ1bGx5
IG9uIGEgcGVyLWJvYXJkIGJhc2lzDQo+PiBhbmQgbm90IGdsb2JhbGx5IHRocm91Z2ggdGhlIFNv
QyBkdHNpLg0KPj4gVGhlcmVmb3JlIHJldmVydGluZyB0aGUgY29tbWl0IGluIHF1ZXN0aW9uIGFs
dG9nZXRoZXIgd2FzIGNvbnNpZGVyZWQsDQo+PiBidXQgcmVjZWl2ZWQgcHVzaGJhY2sgaW4gcmV2
aWV3IHdpdGggdGhlIGFyZ3VtZW50IHRoYXQgYnVzIHJlY292ZXJ5IHdhcw0KPj4gaW1wb3J0YW50
Lg0KPj4NCj4+IEluc3RlYWQgYWRkIHBpbm11eCBub2RlcyBmb3IgYWxsIGZpZWxkcyBvZiByY3dz
cjEyIGFzIHVzZWQgYnkgYWZmZWN0ZWQNCj4+IFNvbGlkUnVuIExYMjE2MEEgQ2xlYXJmb2ctQ1gg
JiBIb25leWNvbWIsIGFuZCBMWDIxNjJBIENsZWFyZm9nIGJvYXJkcy4NCj4gVGhhbmtzIHlvdSB2
ZXJ5IG11Y2guIFRoaXMgd2F5IGlzIHRoZSBnb29kLiBCdXQgY29tbWl0IG1lc3NhZ2UgdG8gdG9v
IGxvbmcNCj4NCj4gQmFzaWNhbGx5IHRoZSBkZWZhdWx0IHZhbHVlIG9mIG92ZXJ3cml0ZSBNVVgg
aXMgMCwgd2hpY2ggaGF2ZSBub3QgcmVmbGFjdA0KPiBoYXJkd2FyZSByZWFsIHN0YXR1cywgd2hp
Y2ggc2V0IGJ5IFJDVy4gc28gdXBkYXRlIHNvbWUgZmllbGQgb2YgbXV4IGltcGFjdA0KPiBvdGhl
ciBwZXJpcGhlcmlhbC4NClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBJIHNpbXBsaWZ5IHRo
ZSBjb21taXQgZGVzY3JpcHRpb24gZm9yIHY1LA0KYW5kIHRoYXQgaW4gcGF0Y2ggNyB0b28uDQo+
DQo+IEZyYW5rDQo+DQo+PiBGaXhlczogOGExMzY1YzdiYmMxICgiYXJtNjQ6IGR0czogbHgyMTYw
YTogYWRkIHBpbm11eCBhbmQgaTJjIGdwaW8gdG8gc3VwcG9ydCBidXMgcmVjb3ZlcnkiKQ0KPj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVy
IDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gLS0tDQo+PiAgLi4uL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS1jZXg3LmR0c2kgfCAgNyArKysrKysrDQo+PiAgLi4uL2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kgICAgfCAgMiArKw0KPj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgICAgIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MmEtY2xlYXJmb2cuZHRzICAgIHwgIDIgKysNCj4+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1seDIxNjJhLXNyLXNvbS5kdHNpICAgICB8ICA3ICsrKysrKysNCj4+ICA1IGZpbGVzIGNoYW5n
ZWQsIDQyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpDQo+PiBpbmRleCBlZWMyY2Q2YzZkMzJh
Li43ZjZlMzllMjdjZTVjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpDQo+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1jZXg3LmR0c2kNCj4+IEBAIC0xNjIsNiArMTYyLDggQEAg
cnRjQDUxIHsNCj4+ICB9Ow0KPj4NCj4+ICAmZnNwaSB7DQo+PiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+PiArCXBpbmN0cmwtMCA9IDwmZnNwaV9kYXRhNzRfcGlucz4sIDwmZnNwaV9k
YXRhMzBfcGlucz4sIDwmZnNwaV9kcXNfc2NrX2NzMTBfcGlucz47DQo+PiAgCXN0YXR1cyA9ICJv
a2F5IjsNCj4+DQo+PiAgCWZsYXNoQDAgew0KPj4gQEAgLTE3Nyw2ICsxNzksMTEgQEAgZmxhc2hA
MCB7DQo+PiAgCX07DQo+PiAgfTsNCj4+DQo+PiArJnBpbm11eF9pMmNydiB7DQo+PiArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArCXBpbmN0cmwtMCA9IDwmZ3BpbzBfMTRfMTJfcGlu
cz47DQo+PiArfTsNCj4+ICsNCj4+ICAmdXNiMCB7DQo+PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4+
ICB9Ow0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
eDIxNjBhLWNsZWFyZm9nLWl0eC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kNCj4+IGluZGV4IGFmNjI1OGIyZmU4MjYuLjU4
MGVlOWIzMDI2ZTMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHgyMTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kNCj4+IEBAIC04OSw2
ICs4OSw4IEBAICZlbWRpbzIgew0KPj4gIH07DQo+Pg0KPj4gICZlc2RoYzAgew0KPj4gKwlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKwlwaW5jdHJsLTAgPSA8JmVzZGhjMF9jZF93cF9w
aW5zPiwgPCZlc2RoYzBfY21kX2RhdGEzMF9jbGtfdnNlbF9waW5zPjsNCj4+ICAJc2QtdWhzLXNk
cjEwNDsNCj4+ICAJc2QtdWhzLXNkcjUwOw0KPj4gIAlzZC11aHMtc2RyMjU7DQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+IGluZGV4IDg1
M2IwMTQ1MjgxM2EuLmFmNzRlNzdlZmFiYzUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiBAQCAtMTcyMSw2ICsxNzIxLDEw
IEBAIGkyYzFfc2NsX2dwaW86IGkyYzEtc2NsLWdwaW8tcGlucyB7DQo+PiAgCQkJCXBpbmN0cmwt
c2luZ2xlLGJpdHMgPSA8MHgwIDB4MSAweDc+Ow0KPj4gIAkJCX07DQo+Pg0KPj4gKwkJCWVzZGhj
MF9jZF93cF9waW5zOiBpaWMyLXNkaGMtcGlucyB7DQo+PiArCQkJCXBpbmN0cmwtc2luZ2xlLGJp
dHMgPSA8MHgwIDB4NiAweDc+Ow0KPj4gKwkJCX07DQo+PiArDQo+PiAgCQkJaTJjMl9zY2w6IGky
YzItc2NsLXBpbnMgew0KPj4gIAkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAwICgweDcg
PDwgMyk+Ow0KPj4gIAkJCX07DQo+PiBAQCAtMTc1Myw2ICsxNzU3LDI2IEBAIGkyYzVfc2NsX2dw
aW86IGkyYzUtc2NsLWdwaW8tcGlucyB7DQo+PiAgCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8
MHgwICgweDEgPDwgMTIpICgweDcgPDwgMTIpPjsNCj4+ICAJCQl9Ow0KPj4NCj4+ICsJCQlmc3Bp
X2RhdGE3NF9waW5zOiB4c3BpMS1kYXRhNzQtcGlucyB7DQo+PiArCQkJCXBpbmN0cmwtc2luZ2xl
LGJpdHMgPSA8MHgwIDB4MCAoMHg3IDw8IDE1KT47DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQlm
c3BpX2RhdGEzMF9waW5zOiB4c3BpMS1kYXRhMzAtcGlucyB7DQo+PiArCQkJCXBpbmN0cmwtc2lu
Z2xlLGJpdHMgPSA8MHgwIDB4MCAoMHg3IDw8IDE4KT47DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJ
CQlmc3BpX2Rxc19zY2tfY3MxMF9waW5zOiB4c3BpMS1iYXNlLXBpbnMgew0KPj4gKwkJCQlwaW5j
dHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDAgKDB4NyA8PCAyMSk+Ow0KPj4gKwkJCX07DQo+PiAr
DQo+PiArCQkJZXNkaGMwX2NtZF9kYXRhMzBfY2xrX3ZzZWxfcGluczogc2RoYzEtYmFzZS1zZGhj
LXZzZWwtcGlucyB7DQo+PiArCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDB4MCAoMHg3
IDw8IDI0KT47DQo+PiArCQkJfTsNCj4+ICsNCj4+ICsJCQlncGlvMF8xNF8xMl9waW5zOiBzZGhj
MS1kaXItZ3Bpby1waW5zIHsNCj4+ICsJCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgKDB4
MSA8PCAyNykgKDB4NyA8PCAyNyk+Ow0KPj4gKwkJCX07DQo+PiArDQo+PiAgCQkJaTJjNl9zY2w6
IGkyYzYtc2NsLXBpbnMgew0KPj4gIAkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4NCAweDIg
MHg3PjsNCj4+ICAJCQl9Ow0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cw0KPj4gaW5kZXggZWFmZWY4NzE4YTBmZS4u
ODkyMDMyNmEwNjczNSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cw0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cuZHRzDQo+PiBAQCAtMjIzLDYgKzIyMyw4
IEBAIGV0aGVybmV0X3BoeTg6IGV0aGVybmV0LXBoeUAxNSB7DQo+PiAgfTsNCj4+DQo+PiAgJmVz
ZGhjMCB7DQo+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArCXBpbmN0cmwtMCA9
IDwmZXNkaGMwX2NkX3dwX3BpbnM+LCA8JmVzZGhjMF9jbWRfZGF0YTMwX2Nsa192c2VsX3BpbnM+
Ow0KPj4gIAlzZC11aHMtc2RyMTA0Ow0KPj4gIAlzZC11aHMtc2RyNTA7DQo+PiAgCXNkLXVocy1z
ZHIyNTsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHgyMTYyYS1zci1zb20uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
eDIxNjJhLXNyLXNvbS5kdHNpDQo+PiBpbmRleCBlOTE0MjkxZTYzYTFhLi5lMTM0NDk0MmVhYWVl
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MmEtc3Itc29tLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1seDIxNjJhLXNyLXNvbS5kdHNpDQo+PiBAQCAtMzAsNiArMzAsOCBAQCAmZXNkaGMxIHsNCj4+
ICB9Ow0KPj4NCj4+ICAmZnNwaSB7DQo+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
PiArCXBpbmN0cmwtMCA9IDwmZnNwaV9kYXRhNzRfcGlucz4sIDwmZnNwaV9kYXRhMzBfcGlucz4s
IDwmZnNwaV9kcXNfc2NrX2NzMTBfcGlucz47DQo+PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4+DQo+
PiAgCWZsYXNoQDAgew0KPj4gQEAgLTgwLDMgKzgyLDggQEAgcnRjQDZmIHsNCj4+ICAJCXJlZyA9
IDwweDZmPjsNCj4+ICAJfTsNCj4+ICB9Ow0KPj4gKw0KPj4gKyZwaW5tdXhfaTJjcnYgew0KPj4g
KwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKwlwaW5jdHJsLTAgPSA8JmdwaW8wXzE0
XzEyX3BpbnM+Ow0KPj4gK307DQo+Pg0KPj4gLS0NCj4+IDIuNTEuMA0KPj4=

