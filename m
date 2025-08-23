Return-Path: <stable+bounces-172616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9106B3297B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21971B64462
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524B2E7BB8;
	Sat, 23 Aug 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rJnu75jl";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rJnu75jl"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023119.outbound.protection.outlook.com [52.101.72.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6342D5A07;
	Sat, 23 Aug 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.119
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961871; cv=fail; b=PXcsylGe8XJxFvMqBt1KK3tZAJwA6WBiJqh6yv3sEqkDiV3KWLYGp4OR3FLa3wYm9otpO6ABeOqg4yydTq6NRS21VKIye92Ghu+AguiU7glWy06mtBry5j8MrwjgrnLMwMDNaVhx93qzed58kNLZdyXB40QHDh2ospPM07s65oQ=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961871; c=relaxed/simple;
	bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqBIIaSFcc2kcRbQaAtQdeOCBTZCR2jdCwdA8v7WjArSwVSwzQxEhmdj+3Lc317uPeptQN4RAVoZrO4opYzADCzhWreHgTvLc+MpcW7vF/bk6lKVIPbhKhd6ttG1YIx/r7yo0Ru90juM4mcPO1/VezM0U9V4YkO9BX9Xr/sVvCk=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rJnu75jl; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rJnu75jl; arc=fail smtp.client-ip=52.101.72.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xnh46oPfx7xbqS8fhdkhGL6HtFv0E6sxYX8hn6ywCUJ7OQVxvpuh0fMBXCGKMFYFsaTO2igCAemgKL/XkA8itf3o95gMGoCmAewtzX7vV/EfUHmDgzNafEsrYNVjGXeg6ZoosZyvNFjVItsqfbEqT5TaPtQRGc23z2oWWcqC08ivYgpl6zKp2OwL5TbDKs0jBvVe9gOgXt3YU48G9BAE8BCPcCrRZ5e8VYbPZwKUjQO41WbJ3Hy1jiIPKaYORVSYM2kM/a/O/qX+xPXxuc8tk4J9BhSaoh3bKfmahl2B0cEKI82Cy0GjhGVy5DZ/UO0fLuGtzIcSkqm+klGltsZ7dg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
 b=MC9DRvWQ9KHCAlm6tgna720qmXKADxMjUlT0YMqW0KOwNagGII3UtHYRk1YDcVAZrbs6jC7cDTY7hRZGGKQZG97hhawGWDiVEdSvZK5acGqMPJp+EnswF2jSO1xIyXWnhHYJlmF8pSP59z+Ay1JuuicXf5y/COyxsGFRozZP6/OhNCh3rHIl5cIObNp+RTHtW5OFgZ8i2f6PwVw4p/I8/J8XGtUE2QRxMsSE1vVqI6M4vVKWFQNnXq+i52i0nHB1h70NvEApS8xAotLBNIITkHWOzX7aoWJp9oXFDG3kbi4SF1Ypm6Ozlf5c8yIz5eUfObYLh3WynIs1YN3BMsZ+Tg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
 b=rJnu75jlyWJcwgDRwNTjCoOQHthtsdYO/GLa27e644ynkSooL/FI4JlVXb00PHz/p3qWqTy0Nj4Do6xxwK3MDcqTO6TOBc2vSQzX2WuxrNRfNy02ZBnNJEAHxRF5yRN658UCpdvtyivobXUXfntYnE/fxDmvAXTwQdwo86RttdU=
Received: from AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 15:11:05 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:150:cafe::42) by AM0PR10CA0044.outlook.office365.com
 (2603:10a6:20b:150::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 15:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Sat, 23 Aug 2025 15:11:04 +0000
Received: from emails-9742345-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B45CE800D0;
	Sat, 23 Aug 2025 15:11:04 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755961864; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
 b=TN2y+2go0apkg0htguto1u7Q+voKPyhhlu6m+CnWSvTdX1jCKIUN6K+GlfsvcnLfosTcm
 ww74OxjhbRc28msh5BL/nfcH2R4MpL0pDz0U84Ctj6NKdNnKbgIAJwEiJi9yUzRGmu2l2yB
 0RG7e0iFx+Kos+MNJtlQk3aoKEoVG1o=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755961864;
 b=p3tBwvgFZf0Kp6hjht/PQksoVGdVqkLnzvikBBNeF0QGYcQdmmMyrQtqkf0Q+4fAqKxxl
 OvyUdEAw8+EdIEV4U2JXooQ5Si2Ek7nyTWW2guThMyswRhKzFbYDjWlKePlh01ohWC3ouSd
 T57/OYTgfZbMgPnyKEdI/VlzYmhdP0s=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrgKahJ7ew8LBt3ameTFwZ/wW2MSDmHDOUeLmZ1mz0QMZ9UPY1Y8gl6uIwhWsiBWSgtVb1hZ0nMVhCR1Z03vO3pfHfLVpf2OI1+TGi6knxyrApAbIJ1FGhQWHQ0eDT3d1ZvCkrfTfGTE9E3GHj4f2HeN1hkALJfKgAfo0djyj+0mufaI8s81P5crgbaCygJkBC7wrqgtvub38UFocK2Cx0AJufuM92zY0IjQPfWeKzi+udrbHYy+nQzGOq5zF0pR0rfS9bjsYNc3jjXwi0L3pmH6CUxV9Of6kH7TznPvrM6Ewr3YgJuK9wkrQYyMWTvZmdYss7yB8kU6FsBcb0a4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
 b=sSQ+2QKxk2qzsOSCoEVrTDdP6ryhmLdOh1ELvwKD7cw5o/5Iah5ftEWU4m7ToBlp8ySQLndg1UIOfyvMpIpbmZ7O0tR//vIcZie55s+oUrjXQmup1ily0tcqRGYIHZwNDx02zl9RmfzB3wGeedP+MD8OdeJl2XZ/3b4ByUyEXbAwR0W8j8GSG6y51jrRO6ZaiFAet4Lo3X7Tmge5WIeIrV+GUmWlXhL5xfLVPbE9SgXSuMAFv5MWY5JkOC92QSyx7qJR2FGwc+abR/gg6R3Hhtd2JBKJxl5+DpuvZ4lEYOBN5LnTkZbKa3BnBD6JcWdo/GfGQgfiy7ch2Ynnagae7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nykBdvyD4IYsP+2aCh/2QritSB97Jfduo71O+B+N+zw=;
 b=rJnu75jlyWJcwgDRwNTjCoOQHthtsdYO/GLa27e644ynkSooL/FI4JlVXb00PHz/p3qWqTy0Nj4Do6xxwK3MDcqTO6TOBc2vSQzX2WuxrNRfNy02ZBnNJEAHxRF5yRN658UCpdvtyivobXUXfntYnE/fxDmvAXTwQdwo86RttdU=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAWPR04MB9719.eurprd04.prod.outlook.com (2603:10a6:102:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Sat, 23 Aug
 2025 15:10:53 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 15:10:53 +0000
From: Josua Mayer <josua@solid-run.com>
To: Frank Li <Frank.li@nxp.com>
CC: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carlos
 Song <carlos.song@nxp.com>, Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio
 to support bus recovery"
Thread-Topic: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio
 to support bus recovery"
Thread-Index: AQHb9JMaZj87L0MKoka7H2mzuoDVlLQxr6eAgD7nb4A=
Date: Sat, 23 Aug 2025 15:10:53 +0000
Message-ID: <e17bc38d-6f72-445b-b3cd-0a3ca140b5b5@solid-run.com>
References: <20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com>
 <aHUVc5SV3yzhDBf6@lizhi-Precision-Tower-5810>
In-Reply-To: <aHUVc5SV3yzhDBf6@lizhi-Precision-Tower-5810>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PAWPR04MB9719:EE_|AMS0EPF000001A9:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d49d020-e965-4cd1-bcce-08dde25747c5
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ekZBS2FhMlMwNndFWWNnZG9objFneVlWc1oySnAwQkhaRjEvd1krMUpLeGZh?=
 =?utf-8?B?VFdLKzlmRXRFZWp2aDZIV0NZTVF3U2I0UW1qM2VNT3FCTitMR1gwNHpESm1S?=
 =?utf-8?B?bXZKNDVYU2lEVHRpNGJNR2h0aWlTT2xpcS9ZcmpmUVBQcXlBTlBXZ2JSMHh4?=
 =?utf-8?B?ZCsrVGgwR3ZLV1ZGeUExdXpFb0EvZ1VlbVBuOFptU2dtZVp0R1JzL2hIVnJh?=
 =?utf-8?B?MWpibUljVWlNWXBZZ0JoOFk3OHVKRU90cU9DazBhS3BCV1hDeGxmNC9NUFBy?=
 =?utf-8?B?YTJBbkNrTFRzL2M5S1NNQXkrNWZZVXhNd0FRbnZza1lIWkNKNlVCQlhJdDdx?=
 =?utf-8?B?dGpqUVVsSEpFaStLNUFPTTRsRmJNUEhxbTBOWGZUZ1M4NE1CeThGNjg4UEhB?=
 =?utf-8?B?MGJZVWRHWFV3ZEYvWXVHMFI4Rk1jb1ZvaGtLMGhUZy9QNG9CN1RjS2JwYnJU?=
 =?utf-8?B?aEVUY0NLSjJnc2tCYmxDb1l4dWdHckgzYlJXcmVTL0hEVGNrQXJ0aVJXaloy?=
 =?utf-8?B?VUkrVVlpZ1hrUEsrOFVpbDlzSGFaSFhhL3oyQkJ1ZmpYN0xJNGYyVUpOcGQ3?=
 =?utf-8?B?dEFOb2ZQR2FJazZDa0k1cTBpVVJ2TlNESUZZeUN6L2NWdytiQ1VaM2ZtN3RC?=
 =?utf-8?B?SnpDVmxyT3VObzJyU1c2RnlUejFjMzkzOTBOUWlLL1pNbTMwakZQb1BWaUI0?=
 =?utf-8?B?N2RBbGN0NytQYXB3eUpLcjAzQXBtRDd3NHkrclM1QXRtcUY4NXo4YXdyOEhv?=
 =?utf-8?B?MGNWRnBQZlI5ektXTU1HMm5nQ1YxVXppSEVyR1NILzBoazA0akk0OE9VbW9y?=
 =?utf-8?B?cDA5V21SNlJ4YzFnZnRZNkErem5pUFRrd01JZmVjOUx1QkNxSUxkSDdtTERE?=
 =?utf-8?B?U0FPMm1hNDlML3U1ajAvNVRwOXJKUFJlZ2hEeHlWYzdBNjlGK3NMdVgzTE8r?=
 =?utf-8?B?TW5NdUt0Unh0ZEVsSEkyZFJJZmlnaTlkVnVuRkFlYXRTek5xZDRrNUNBemJY?=
 =?utf-8?B?VERjUHBIcHFpUFp2REU2MmpuTWplMUYyMEFqTmJ3TjNaTllmOE1UanBSQk05?=
 =?utf-8?B?SCtjaDAyZFBFMHFDNXdSWmVFSkRGeUwwRDJLVVZzUUNaaElyZEJiSjE0RFVv?=
 =?utf-8?B?WW9lQTRWVytMWmpBMFZJV05wL25pZlg5WG5xYzdhNXZCMlVZbzhIUFV1a2dQ?=
 =?utf-8?B?VXFQUDFpSlhybXUzTmVTQVNKL1ovbktXYUNuYUxrUkQyWkFKUnhHeE53VU1y?=
 =?utf-8?B?VUNRWUtCNnJkdlUyK3lqd0l5eVdGWXVDbFZKY0l4M2NacjZCV1ZKcEFGZ2Ja?=
 =?utf-8?B?THJ5aXBRalJOMjFPRWZmamlmZVNQQ3laRkRjYXAzTHVPN3VHRFpxVmdadThk?=
 =?utf-8?B?d0VyZ29xb0h5VTNjTXpjdm5oUlk4aVIwb0RleUYxd09uY2JOZGE3c3g5a3ZP?=
 =?utf-8?B?aVJINVppdnZZVUhFWHFJTElnKzBiTVduZFBFYXNCY3pzMmlOa1JhVXFzZDZk?=
 =?utf-8?B?NUx0Wkpyc3ZlUXhSYUdkZVlhYWNsbnlacmowZ0NOeFp1bm1NblMyNHFnTW45?=
 =?utf-8?B?Y29HTG9jUTVieWN6THgxeTZZSG9qNWZSZXFCcm5mUm5hV3pMbkZSZ3RYVnNs?=
 =?utf-8?B?eEoyUmFDYzFxN1E1Zk14ejVQZUpMS3hQOTJxOUhLVXhDVDlRREJqK3FFaHZY?=
 =?utf-8?B?NXFnZUF4WjlkWDFMdE5aVW1jL0dqdFRDSWNUQitVN3RJZ1NMSU8vQzhuUk1q?=
 =?utf-8?B?V3ptQXBKTVJJTmJ4SURUU1lNMUI3OFJaNTd3M3I0clpwSlNaL3hMWEdrVXNt?=
 =?utf-8?B?NVJDdjVBcnpKQlYrV0pJdUswNFE0ajBmbzJLejBNTEdYbTNBWG9SSXJlWHhP?=
 =?utf-8?B?YkpFVmxycDRGbHltOWZ4c3Z0UW9CN1hGbTFYcENjanU0OGpKWXdwcVBNRU9Q?=
 =?utf-8?B?bFhYeksxRVdXait6Y1B6R2w5TE9aWno5U0pRQXpxeDVqVFRMMUdNenVHQXlX?=
 =?utf-8?B?MStKcHUzcTR3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <32DBAFEF627C1D4997E85D2A65380AEB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9719
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3299eb39808e4ccb898670187befd6ac:solidrun,office365_emails,sent,inline:4f06c975cb88c0f0e943428de9b595b6
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b732f8f6-dc00-4e66-2124-08dde25740c9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azdiT29IcDh2UW9tZXdwMWJZWW1QUDBOKzBlQzlTbndiSCtSSHc5cVlTeW1E?=
 =?utf-8?B?b2xCV2wzcGRsRFZlWmV4bWNrR1JZL0M2ZXJRalFFRU9nbVFWYVBUUTdRdmds?=
 =?utf-8?B?azFQcjNNVHpMNDNjNGJJMjF3Sk15UUl3bkFpV3c5WTE1K05teE52b2JpWk51?=
 =?utf-8?B?QWIxa0tHTE1tMTRLSWdkRDJObDM3ZDRaWWNwZGpGYkdJTGZCbytuZnNIWUFm?=
 =?utf-8?B?ZGViTWVINTE2UmgvVkxFR2NKek4vb3pwRmdwMW84ek5VNmZTV3JSNDVJWVBV?=
 =?utf-8?B?VEFrK1hTeVNoK0Rlb1M0ekNhbVhjdm5DeWFhdzM2Nk5lNHQvN0Zjd1NSQ1V5?=
 =?utf-8?B?MVd5MENyN1lRdE9oekdQMnhVTXV5WWFMWUhZQVV4V3JGRGtraE9FdmlRZUJj?=
 =?utf-8?B?cGt3WmZ2WWlFNDBFTGt2ZXltT0FDUG9PWTdxeldXQzhrWTdneWNsZnZHcWFO?=
 =?utf-8?B?bkRVMjNRd25LSFk1Ynp6OW5lTnBhZVprTVVTTkdHc0gvb01pOHdDR3piRjdw?=
 =?utf-8?B?N0lEOUxWeTJmL0dQc3dsNW1ZT0hKdFd5MVRnYkk3KzhRQTJqM0luRHViNlFs?=
 =?utf-8?B?Ykpkb0s1Q3Y4TEU1OVVnSGNmSWg5Q1RHdjBMYldqaGhIOC9rZmIrTEhUWGdB?=
 =?utf-8?B?Y0grRGhxUnlzVVFkUnJtdjRFMGVJWEN5OU5BK0s5YWVXSC9PMDI0TXY3RnVO?=
 =?utf-8?B?bWxERUlsREk1UW9nK0hBVGw5WUNVZTlLdXZXUEw1TFdTeWhYTGRDd2xzTkZ1?=
 =?utf-8?B?bkJtVkZGY05vYlVrTXVUalBlZnc1Wjh1Zjc0dEhhUjE5RnZ2YlR1QkU1UHds?=
 =?utf-8?B?TmsrMW9lQVl6TDVxbEhhVmpjOEdBRVgzekpNK1NHd3dZVWxsOE1JNU9TY3g1?=
 =?utf-8?B?OTA1Q0granhvSi8vdDVPcUlERmExWVdoSjJXVzlCTUtPaTYweGdwTXFsLzd6?=
 =?utf-8?B?MjNocDFvZG5uTHpld2liNHk4NnZFN09mTVJJQWJjbUdQd212cTRUb09EMVAv?=
 =?utf-8?B?ZlJaa21HNmx4amFCbnBFQjZpTFZ4T3ZUanBjQkg5eENaTkNjZWI5bW53UmRu?=
 =?utf-8?B?MEdwTXp5ODNkWHdIOVkrT0lhTk1vTDZJemN1bm9icTRCMEdueUFacFFxZEVP?=
 =?utf-8?B?ZG1hU1AvZW9VQ3VVY3RGVWJ4bU9JSzVJam9MUTE3dDIwLzRCenNWd1M4N2VR?=
 =?utf-8?B?QnJIbjlhN28xWldlUVphUVp6eEFxcGZiVWFzU1Rydy9HQWVER29abElGUWFW?=
 =?utf-8?B?WnB2MlZqR1RKREZPbTM3RjR3SDdaY3E1OTZLNjZwdmpqNm1MTWlOcXZxVTJ4?=
 =?utf-8?B?QlJrNjhVUDVnZHk3bDRmWXA0dXl1KzVvaHEzUVJOYUNNWkZrcGxEUFdOWDQr?=
 =?utf-8?B?UlByOTI2K3czbEVIRlpId1VjeFJCbndMRStzYkZ1citDeUZKL0hSNmg5Z2lo?=
 =?utf-8?B?ZEdLNUxYV1FyVzc3Q3FFUXNkYWl4QitiV0dlSjg3RnpvN2NGOTFtWFJtNFFv?=
 =?utf-8?B?M0xZdFdGQ3gyYzIvR201cUdZUGw0aFdRb3JkUk45a05tQUJKSlVScHVZRnl3?=
 =?utf-8?B?amt2L21NUHorQUN0b3RGbDZBcWtZY2xuVTVCbnMzUlJIZzZqY2U3eG5HYk5t?=
 =?utf-8?B?cTNwSjAyVEdqc0ZvZjI5YWJNbHp5TGZMTlVtRzRINW5EQjF6VE1JVHFrYXlV?=
 =?utf-8?B?WEVraWR2SExTV0hoRnlmVE5lOHZCUWpEcXRRVE1tT29aRGNDTWFjejVqWUxy?=
 =?utf-8?B?aHpGZ0hCWmZVcC9sbm9Dek1iUFl5N25QQ1hOTXdFamxmbEtWYnIvT2x5Tlpy?=
 =?utf-8?B?VHQycm1EVFQ3MGNnQ21CaFlNaHhDTFNyTlhENE16YU5VcXJRM0w2cnArdUZC?=
 =?utf-8?B?RHQ2enZUWnd3SnJUalFEUXJ2QXFURGdXQmVMN0ZTM2g4bkYrekljN2Z2WUJP?=
 =?utf-8?B?UXIxSEdoOVBOcVJlVGxoR1Vtdys5UkczdVR6Nmh3SWZoZTl0NlNLNkw5M2VD?=
 =?utf-8?B?aGpKS3lZUjNlTXdIUXNSbW9BOGl1SzBmeGM0bml5c3VHR1greTl5VWlzNFN6?=
 =?utf-8?Q?nK0v98?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 15:11:04.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d49d020-e965-4cd1-bcce-08dde25747c5
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

QW0gMTQuMDcuMjUgdW0gMTY6MzQgc2NocmllYiBGcmFuayBMaToNCj4gT24gTW9uLCBKdWwgMTQs
IDIwMjUgYXQgMTA6NDQ6MTNBTSArMDMwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBUaGlzIHJl
dmVydHMgY29tbWl0IDhhMTM2NWM3YmJjMTIyYmQ4NDMwOTZmMDAwOGQyNTllN2E4YWZjNjEuDQo+
Pg0KPj4gVGhlIGNvbW1pdCBpbiBxdWVzdGlvbnMgbW9zdCBub3RhYmx5IGJyZWFrcyBTRC1DYXJk
IG9uIFNvbGlkUnVuDQo+PiBMWDIxNjJBIENsZWFyZm9nIGJ5IGNvcnJ1cHRpbmcgdGhlIHBpbm11
eCBpbiBkeW5hbWljIGNvbmZpZ3VyYXRpb24gYXJlYQ0KPj4gZm9yIG5vbi1pMmMgcGlucyB3aXRo
b3V0IHBpbm11eCBub2RlLg0KPj4gSXQgaXMgZnVydGhlciBleHBlY3RlZCB0aGF0IGl0IGJyZWFr
cyBTRCBDYXJkLURldGVjdCwgYXMgd2VsbCBhcyBDQU4sDQo+PiBEU1BJIGFuZCBHUElPcyBvbiBh
bnkgYm9hcmQgYmFzZWQgb24gTFgyMTYwIFNvQy4NCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNo
LiBJIHJlbWVtYmVyIHdlIG1ldCBzaW1pbGFyIGlzc3VlIGJlZm9yZS4gTGV0J3MNCj4gd2FpdCBm
b3IgY2FybG9zIGlzIGJhY2sgYWJvdXQgaW4gbmV4dCB3ZWVrLg0KQnVtcCAuLi4NCj4NCj4gSSBy
ZW1lbWJlciB1Ym9vdCBzaG91bGQgY29weSBSQ1dTUiB0byAweDcwMDEwMDEyYy4NClVuZm9ydXRu
YXRlbHkgYm9vdGxvYWRlciBpcyBub3QgdXBkYXRlZCBpbiB0YW5kZW0gd2l0aCBrZXJuZWwNCm9u
IGdlbmVyYWwtcHVycG9zZSBkaXN0cm9zLg0KPiBJMkMgcmVjb3ZlciBhbHNvIGlzDQo+IGltcG9y
dGFudCBmZWF0dXJlLg0KDQpJIHdvdWxkIHJhbmsgcGlubXV4IGFib3ZlIGJ1cyByZWNvdmVyeS4N
Cg0KUmV2ZXJ0IGlzIHRoZSBzaW1wbGVzdCBvcHRpb24sIGFuZCBJIHN0aWxsIGJlbGlldmUgbWFu
eSBib2FyZHMgYXJlIGFmZmVjdGVkLg0KDQpTb2xpZFJ1biBoYXZlIHN0cm9uZyBpbnRlcmVzdCB0
byByZXNvbHZlIHRoaXMgZm9yIHRoZWlyIHBsYXRmb3Jtcw0KKHRvIGZpeCBvdXIgYm9hcmRzIGN1
cnJlbnRseSBicm9rZW4gaW4gRGViaWFuIDEzKS4NCg0KSWYgcmV2ZXJ0IGlzIG5vdCBhY2NlcHRh
YmxlIEkgY2FuIGltcGxlbWVudCBteSBkZXNjcmliZWQgd29ya2Fyb3VuZCBvZg0KZGVzY3JpYmlu
ZyAqKmFsbCBwaW5zKiogaW4gZGV2aWNlLXRyZWUgaW5zdGVhZCwgZm9yIFNSIGJvYXJkcyBvbmx5
DQood2hpY2ggaXMgYSBtdWNoIGxhcmdlciB0YXNrKS4NCg0KPg0KPiBGcmFuaw0KPj4gQmFja2dy
b3VuZDoNCj4+DQo+PiBUaGUgTFgyMTYwIFNvQyBpcyBjb25maWd1cmVkIGF0IHBvd2VyLW9uIGZy
b20gUkNXIChSZXNldA0KPj4gQ29uZmlndXJhdGlvbiBXb3JkKSB0eXBpY2FsbHkgbG9jYXRlZCBp
biB0aGUgZmlyc3QgNGsgb2YgYm9vdCBtZWRpYS4NCj4+IFRoaXMgYmxvYiBjb25maWd1cmVzIHZh
cmlvdXMgY2xvY2sgcmF0ZXMgYW5kIHBpbiBmdW5jdGlvbnMuDQo+PiBUaGUgcGlubXV4IGZvciBp
MmMgc3BlY2lmaWNhbGx5IGlzIHBhcnQgb2YgY29uZmlndXJhdGlvbiB3b3JkcyBSQ1dTUjEyLA0K
Pj4gUkNXU1IxMyBhbmQgUkNXU1IxNCBzaXplIDMyIGJpdCBlYWNoLg0KPj4gVGhlc2UgdmFsdWVz
IGFyZSBhY2Nlc3NpYmxlIGF0IHJlYWQtb25seSBhZGRyZXNzZXMgMHgwMWUwMDEyYyBmb2xsb3dp
bmcuDQo+Pg0KPj4gRm9yIHJ1bnRpbWUgKHJlLSljb25maWd1cmF0aW9uIHRoZSBTb0MgaGFzIGEg
ZHluYW1pYyBjb25maWd1cmF0aW9uIGFyZWENCj4+IHdoZXJlIGFsdGVybmF0aXZlIHNldHRpbmdz
IGNhbiBiZSBhcHBsaWVkLiBUaGUgY291bnRlcnBhcnRzIG9mDQo+PiBSQ1dTUlsxMi0xNF0gY2Fu
IGJlIG92ZXJyaWRkZW4gYXQgMHg3MDAxMDAxMmMgZm9sbG93aW5nLg0KPj4NCj4+IFRoZSBjb21t
aXQgaW4gcXVlc3Rpb24gdXNlZCB0aGlzIGFyZWEgdG8gc3dpdGNoIGkyYyBwaW5zIGJldHdlZW4g
aTJjIGFuZA0KPj4gZ3BpbyBmdW5jdGlvbiBhdCBydW50aW1lIHVzaW5nIHRoZSBwaW5jdHJsLXNp
bmdsZSBkcml2ZXIgLSB3aGljaCByZWFkcyBhDQo+PiAzMi1iaXQgdmFsdWUsIG1ha2VzIHBhcnRp
Y3VsYXIgY2hhbmdlcyBieSBiaXRtYXNrIGFuZCB3cml0ZXMgYmFjayB0aGUNCj4+IG5ldyB2YWx1
ZS4NCj4+DQo+PiBTb2xpZFJ1biBoYXZlIG9ic2VydmVkIHRoYXQgaWYgdGhlIGR5bmFtaWMgY29u
ZmlndXJhdGlvbiBpcyByZWFkIGZpcnN0DQo+PiAoYmVmb3JlIGEgd3JpdGUpLCBpdCByZWFkcyBh
cyB6ZXJvIHJlZ2FyZGxlc3MgdGhlIGluaXRpYWwgdmFsdWVzIHNldCBieQ0KPj4gUkNXLiBBZnRl
ciB0aGUgZmlyc3Qgd3JpdGUgY29uc2VjdXRpdmUgcmVhZHMgcmVmbGVjdCB0aGUgd3JpdHRlbiB2
YWx1ZS4NCj4+DQo+PiBCZWNhdXNlIG11bHRpcGxlIHBpbnMgYXJlIGNvbmZpZ3VyZWQgZnJvbSBh
IHNpbmdsZSAzMi1iaXQgdmFsdWUsIHRoaXMNCj4+IGNhdXNlcyB1bmludGVudGlvbmFsIGNoYW5n
ZSBvZiBhbGwgYml0cyAoZXhjZXB0IHRob3NlIGZvciBpMmMpIGJlaW5nIHNldA0KPj4gdG8gemVy
byB3aGVuIHRoZSBwaW5jdHJsIGRyaXZlciBhcHBsaWVzIHRoZSBmaXJzdCBjb25maWd1cmF0aW9u
Lg0KPj4NCj4+IFNlZSBiZWxvdyBhIHNob3J0IGxpc3Qgb2Ygd2hpY2ggZnVuY3Rpb25zIFJDV1NS
MTIgYWxvbmUgY29udHJvbHM6DQo+Pg0KPj4gTFgyMTYyLUNGIFJDV1NSMTI6IDBiMDAwMDEwMDAw
MDAwMDAwMCAwMDAwMDAwMDAwMDAwMTEwDQo+PiBJSUMyX1BNVVggICAgICAgICAgICAgIHx8fCAg
IHx8fCAgIHx8IHwgICB8fHwgICB8fHxYWFggOiBJMkMvR1BJTy9DRC1XUA0KPj4gSUlDM19QTVVY
ICAgICAgICAgICAgICB8fHwgICB8fHwgICB8fCB8ICAgfHx8ICAgWFhYICAgIDogSTJDL0dQSU8v
Q0FOL0VWVA0KPj4gSUlDNF9QTVVYICAgICAgICAgICAgICB8fHwgICB8fHwgICB8fCB8ICAgfHx8
WFhYfHx8ICAgIDogSTJDL0dQSU8vQ0FOL0VWVA0KPj4gSUlDNV9QTVVYICAgICAgICAgICAgICB8
fHwgICB8fHwgICB8fCB8ICAgWFhYICAgfHx8ICAgIDogSTJDL0dQSU8vU0RIQy1DTEsNCj4+IElJ
QzZfUE1VWCAgICAgICAgICAgICAgfHx8ICAgfHx8ICAgfHwgfFhYWHx8fCAgIHx8fCAgICA6IEky
Qy9HUElPL1NESEMtQ0xLDQo+PiBYU1BJMV9BX0RBVEE3NF9QTVVYICAgIHx8fCAgIHx8fCAgIFhY
IFggICB8fHwgICB8fHwgICAgOiBYU1BJL0dQSU8NCj4+IFhTUEkxX0FfREFUQTMwX1BNVVggICAg
fHx8ICAgfHx8WFhYfHwgfCAgIHx8fCAgIHx8fCAgICA6IFhTUEkvR1BJTw0KPj4gWFNQSTFfQV9C
QVNFX1BNVVggICAgICB8fHwgICBYWFggICB8fCB8ICAgfHx8ICAgfHx8ICAgIDogWFNQSS9HUElP
DQo+PiBTREhDMV9CQVNFX1BNVVggICAgICAgIHx8fFhYWHx8fCAgIHx8IHwgICB8fHwgICB8fHwg
ICAgOiBTREhDL0dQSU8vU1BJDQo+PiBTREhDMV9ESVJfUE1VWCAgICAgICAgIFhYWCAgIHx8fCAg
IHx8IHwgICB8fHwgICB8fHwgICAgOiBTREhDL0dQSU8vU1BJDQo+PiBSRVNFUlZFRCAgICAgICAg
ICAgICBYWHx8fCAgIHx8fCAgIHx8IHwgICB8fHwgICB8fHwgICAgOg0KPj4NCj4+IE9uIExYMjE2
MkEgQ2xlYXJmb2cgdGhlIGluaXRpYWwgKGFudCBpbnRlbmRlZCkgdmFsdWUgaXMgMHgwODAwMDAw
NiAtDQo+PiBlbmFibGluZyBjYXJkLWRldGVjdCBvbiBJSUMyX1BNVVggYW5kIHNvbWUgTEVEcyBv
biBTREhDMV9ESVJfUE1VWC4NCj4+IEV2ZXJ5dGhpbmcgZWxzZSBpcyBpbnRlbnRpb25hbCB6ZXJv
IChlbmFibGluZyBJMkMgJiBYU1BJKS4NCj4+DQo+PiBCeSByZWFkaW5nIHplcm8gZnJvbSBkeW5h
bWljIGNvbmZpZ3VyYXRpb24gYXJlYSwgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbg0KPj4gY2hhbmdl
cyBJSUMyX1BNVVggdG8gdmFsdWUgMCAoSTJDIGZ1bmN0aW9uKSwgYW5kIFNESEMxX0RJUl9QTVVY
IHRvIDANCj4+IChTREhDIGRhdGEgZGlyZWN0aW9uIGZ1bmN0aW9uKSAtIGJyZWFraW5nIGNhcmQt
ZGV0ZWN0IGFuZCBsZWQgZ3Bpb3MuDQo+Pg0KPj4gVGhpcyBpc3N1ZSBzaG91bGQgYWZmZWN0IGFu
eSBib2FyZCBiYXNlZCBvbiBMWDIxNjAgU29DIHRoYXQgaXMgdXNpbmcgdGhlDQo+PiBzYW1lIG9y
IGVhcmxpZXIgdmVyc2lvbnMgb2YgTlhQIGJvb3Rsb2FkZXIgYXMgU29saWRSdW4gaGF2ZSB0ZXN0
ZWQsIGluDQo+PiBwYXJ0aWN1bGFyOiBMU0RLLTIxLjA4IGFuZCBMUy01LjE1LjcxLTIuMi4wLg0K
Pj4NCj4+IFdoZXRoZXIgTlhQIGFkZGVkIHNvbWUgZXh0cmEgaW5pdGlhbGlzYXRpb24gaW4gdGhl
IGJvb3Rsb2FkZXIgb24gbGF0ZXINCj4+IHJlbGVhc2VzIHdhcyBub3QgaW52ZXN0aWdhdGVkLiBI
b3dldmVyIGJvb3Rsb2FkZXIgdXBncmFkZSBzaG91bGQgbm90IGJlDQo+PiBuZWNlc3NhcnkgdG8g
cnVuIGEgbmV3ZXIgTGludXgga2VybmVsLg0KPj4NCj4+IFRvIHdvcmsgYXJvdW5kIHRoaXMgaXNz
dWUgaXQgaXMgcG9zc2libGUgdG8gZXhwbGljaXRseSBkZWZpbmUgQUxMIHBpbnMNCj4+IGNvbnRy
b2xsZWQgYnkgYW55IDMyLWJpdCB2YWx1ZSBzbyB0aGF0IGdyYWR1YWxseSBhZnRlciBwcm9jZXNz
aW5nIGFsbA0KPj4gcGluY3RybCBub2RlcyB0aGUgY29ycmVjdCB2YWx1ZSBpcyByZWFjaGVkIG9u
IGFsbCBiaXRzLg0KPj4NCj4+IFRoaXMgaXMgYSBsYXJnZSB0YXNrIHRoYXQgc2hvdWxkIGJlIGRv
bmUgY2FyZWZ1bGx5IG9uIGEgcGVyLWJvYXJkIGJhc2lzDQo+PiBhbmQgbm90IGdsb2JhbGx5IHRo
cm91Z2ggdGhlIFNvQyBkdHNpLg0KPj4gVGhlcmVmb3JlIHRoZSBjb21taXQgaW4gcXVlc3Rpb24g
aXMgcmV2ZXJ0ZWQuDQo+Pg0KPj4gRml4ZXM6IDhhMTM2NWM3YmJjMSAoImFybTY0OiBkdHM6IGx4
MjE2MGE6IGFkZCBwaW5tdXggYW5kIGkyYyBncGlvIHRvIHN1cHBvcnQgYnVzIHJlY292ZXJ5IikN
Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBN
YXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+
IC0gY2hhbmdlZCB0byByZXZlcnQgcHJvYmxlbWF0aWMgY29tbWl0LCB3b3JrYXJvdW5kIGlzIGxh
cmdlIGVmZm9ydA0KPj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2Yz
MmM1NTI1LTMxNjItNGFjZC04ODBjLTk5ZmM0NmQzYTYzZEBzb2xpZC1ydW4uY29tDQo+PiAtLS0N
Cj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpIHwgMTA2
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTA2IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHgyMTYwYS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4
MjE2MGEuZHRzaQ0KPj4gaW5kZXggYzk1NDE0MDNiY2Q4Li5lYjFiNGU2MDdlMmIgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+
PiBAQCAtNzQ5LDEwICs3NDksNiBAQCBpMmMwOiBpMmNAMjAwMDAwMCB7DQo+PiAgCQkJY2xvY2st
bmFtZXMgPSAiaXBnIjsNCj4+ICAJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIFFPUklRX0NMS19QTEFU
Rk9STV9QTEwNCj4+ICAJCQkJCSAgICBRT1JJUV9DTEtfUExMX0RJVigxNik+Ow0KPj4gLQkJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4+IC0JCQlwaW5jdHJsLTAgPSA8Jmky
YzBfc2NsPjsNCj4+IC0JCQlwaW5jdHJsLTEgPSA8JmkyYzBfc2NsX2dwaW8+Ow0KPj4gLQkJCXNj
bC1ncGlvcyA9IDwmZ3BpbzAgMyAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJTik+
Ow0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC03NjUs
MTAgKzc2MSw2IEBAIGkyYzE6IGkyY0AyMDEwMDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9ICJp
cGciOw0KPj4gIAkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BMTA0K
Pj4gIAkJCQkJICAgIFFPUklRX0NMS19QTExfRElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPj4gLQkJCXBpbmN0cmwtMCA9IDwmaTJjMV9zY2w+Ow0K
Pj4gLQkJCXBpbmN0cmwtMSA9IDwmaTJjMV9zY2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9zID0g
PCZncGlvMCAzMSAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJTik+Ow0KPj4gIAkJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC03ODEsMTAgKzc3Myw2
IEBAIGkyYzI6IGkyY0AyMDIwMDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPj4g
IAkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BMTA0KPj4gIAkJCQkJ
ICAgIFFPUklRX0NMS19QTExfRElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IiwgImdwaW8iOw0KPj4gLQkJCXBpbmN0cmwtMCA9IDwmaTJjMl9zY2w+Ow0KPj4gLQkJCXBp
bmN0cmwtMSA9IDwmaTJjMl9zY2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9zID0gPCZncGlvMCAy
OSAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJTik+Ow0KPj4gIAkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC03OTcsMTAgKzc4NSw2IEBAIGkyYzM6
IGkyY0AyMDMwMDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPj4gIAkJCWNsb2Nr
cyA9IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BMTA0KPj4gIAkJCQkJICAgIFFPUklR
X0NMS19QTExfRElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdw
aW8iOw0KPj4gLQkJCXBpbmN0cmwtMCA9IDwmaTJjM19zY2w+Ow0KPj4gLQkJCXBpbmN0cmwtMSA9
IDwmaTJjM19zY2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9zID0gPCZncGlvMCAyNyAoR1BJT19B
Q1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJTik+Ow0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC04MTMsMTAgKzc5Nyw2IEBAIGkyYzQ6IGkyY0AyMDQw
MDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPj4gIAkJCWNsb2NrcyA9IDwmY2xv
Y2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BMTA0KPj4gIAkJCQkJICAgIFFPUklRX0NMS19QTExf
RElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPj4g
LQkJCXBpbmN0cmwtMCA9IDwmaTJjNF9zY2w+Ow0KPj4gLQkJCXBpbmN0cmwtMSA9IDwmaTJjNF9z
Y2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9zID0gPCZncGlvMCAyNSAoR1BJT19BQ1RJVkVfSElH
SCB8IEdQSU9fT1BFTl9EUkFJTik+Ow0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAg
CQl9Ow0KPj4NCj4+IEBAIC04MjksMTAgKzgwOSw2IEBAIGkyYzU6IGkyY0AyMDUwMDAwIHsNCj4+
ICAJCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPj4gIAkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gUU9S
SVFfQ0xLX1BMQVRGT1JNX1BMTA0KPj4gIAkJCQkJICAgIFFPUklRX0NMS19QTExfRElWKDE2KT47
DQo+PiAtCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPj4gLQkJCXBpbmN0
cmwtMCA9IDwmaTJjNV9zY2w+Ow0KPj4gLQkJCXBpbmN0cmwtMSA9IDwmaTJjNV9zY2xfZ3Bpbz47
DQo+PiAtCQkJc2NsLWdwaW9zID0gPCZncGlvMCAyMyAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9f
T1BFTl9EUkFJTik+Ow0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4N
Cj4+IEBAIC04NDUsMTAgKzgyMSw2IEBAIGkyYzY6IGkyY0AyMDYwMDAwIHsNCj4+ICAJCQljbG9j
ay1uYW1lcyA9ICJpcGciOw0KPj4gIAkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BM
QVRGT1JNX1BMTA0KPj4gIAkJCQkJICAgIFFPUklRX0NMS19QTExfRElWKDE2KT47DQo+PiAtCQkJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPj4gLQkJCXBpbmN0cmwtMCA9IDwm
aTJjNl9zY2w+Ow0KPj4gLQkJCXBpbmN0cmwtMSA9IDwmaTJjNl9zY2xfZ3Bpbz47DQo+PiAtCQkJ
c2NsLWdwaW9zID0gPCZncGlvMSAxNiAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJ
Tik+Ow0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC04
NjEsMTAgKzgzMyw2IEBAIGkyYzc6IGkyY0AyMDcwMDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9
ICJpcGciOw0KPj4gIAkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BM
TA0KPj4gIAkJCQkJICAgIFFPUklRX0NMS19QTExfRElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPj4gLQkJCXBpbmN0cmwtMCA9IDwmaTJjN19zY2w+
Ow0KPj4gLQkJCXBpbmN0cmwtMSA9IDwmaTJjN19zY2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9z
ID0gPCZncGlvMSAxOCAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJTik+Ow0KPj4g
IAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAgCQl9Ow0KPj4NCj4+IEBAIC0xNzAwLDgwICsx
NjY4LDYgQEAgcGNzMTg6IGV0aGVybmV0LXBoeUAwIHsNCj4+ICAJCQl9Ow0KPj4gIAkJfTsNCj4+
DQo+PiAtCQlwaW5tdXhfaTJjcnY6IHBpbm11eEA3MDAxMDAxMmMgew0KPj4gLQkJCWNvbXBhdGli
bGUgPSAicGluY3RybC1zaW5nbGUiOw0KPj4gLQkJCXJlZyA9IDwweDAwMDAwMDA3IDB4MDAxMDAx
MmMgMHgwIDB4Yz47DQo+PiAtCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiAtCQkJI3NpemUt
Y2VsbHMgPSA8MD47DQo+PiAtCQkJcGluY3RybC1zaW5nbGUsYml0LXBlci1tdXg7DQo+PiAtCQkJ
cGluY3RybC1zaW5nbGUscmVnaXN0ZXItd2lkdGggPSA8MzI+Ow0KPj4gLQkJCXBpbmN0cmwtc2lu
Z2xlLGZ1bmN0aW9uLW1hc2sgPSA8MHg3PjsNCj4+IC0NCj4+IC0JCQlpMmMxX3NjbDogaTJjMS1z
Y2wtcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDAgMHg3PjsNCj4+
IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzFfc2NsX2dwaW86IGkyYzEtc2NsLWdwaW8tcGlucyB7
DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDB4MSAweDc+Ow0KPj4gLQkJCX07
DQo+PiAtDQo+PiAtCQkJaTJjMl9zY2w6IGkyYzItc2NsLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJs
LXNpbmdsZSxiaXRzID0gPDB4MCAwICgweDcgPDwgMyk+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAt
CQkJaTJjMl9zY2xfZ3BpbzogaTJjMi1zY2wtZ3Bpby1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1z
aW5nbGUsYml0cyA9IDwweDAgKDB4MSA8PCAzKSAoMHg3IDw8IDMpPjsNCj4+IC0JCQl9Ow0KPj4g
LQ0KPj4gLQkJCWkyYzNfc2NsOiBpMmMzLXNjbC1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1zaW5n
bGUsYml0cyA9IDwweDAgMCAoMHg3IDw8IDYpPjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWky
YzNfc2NsX2dwaW86IGkyYzMtc2NsLWdwaW8tcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xl
LGJpdHMgPSA8MHgwICgweDEgPDwgNikgKDB4NyA8PCA2KT47DQo+PiAtCQkJfTsNCj4+IC0NCj4+
IC0JCQlpMmM0X3NjbDogaTJjNC1zY2wtcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJp
dHMgPSA8MHgwIDAgKDB4NyA8PCA5KT47DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmM0X3Nj
bF9ncGlvOiBpMmM0LXNjbC1ncGlvLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRz
ID0gPDB4MCAoMHgxIDw8IDkpICgweDcgPDwgOSk+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJ
aTJjNV9zY2w6IGkyYzUtc2NsLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0g
PDB4MCAwICgweDcgPDwgMTIpPjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzVfc2NsX2dw
aW86IGkyYzUtc2NsLWdwaW8tcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8
MHgwICgweDEgPDwgMTIpICgweDcgPDwgMTIpPjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWky
YzZfc2NsOiBpMmM2LXNjbC1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDww
eDQgMHgyIDB4Nz47DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmM2X3NjbF9ncGlvOiBpMmM2
LXNjbC1ncGlvLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4NCAweDEg
MHg3PjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzdfc2NsOiBpMmM3LXNjbC1waW5zIHsN
Cj4+IC0JCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDQgMHgyIDB4Nz47DQo+PiAtCQkJfTsN
Cj4+IC0NCj4+IC0JCQlpMmM3X3NjbF9ncGlvOiBpMmM3LXNjbC1ncGlvLXBpbnMgew0KPj4gLQkJ
CQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4NCAweDEgMHg3PjsNCj4+IC0JCQl9Ow0KPj4gLQ0K
Pj4gLQkJCWkyYzBfc2NsOiBpMmMwLXNjbC1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1zaW5nbGUs
Yml0cyA9IDwweDggMCAoMHg3IDw8IDEwKT47DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmMw
X3NjbF9ncGlvOiBpMmMwLXNjbC1ncGlvLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxi
aXRzID0gPDB4OCAoMHgxIDw8IDEwKSAoMHg3IDw8IDEwKT47DQo+PiAtCQkJfTsNCj4+IC0JCX07
DQo+PiAtDQo+PiAgCQlmc2xfbWM6IGZzbC1tY0A4MGMwMDAwMDAgew0KPj4gIAkJCWNvbXBhdGli
bGUgPSAiZnNsLHFvcmlxLW1jIjsNCj4+ICAJCQlyZWcgPSA8MHgwMDAwMDAwOCAweDBjMDAwMDAw
IDAgMHg0MD4sDQo+Pg0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDogMTkyNzJiMzdhYTRmODNjYTUy
YmRmOWMxNmQ1ZDgxYmRkMTM1NDQ5NA0KPj4gY2hhbmdlLWlkOiAyMDI1MDcxMC1seDIxNjAtc2Qt
Y2QtMDBiZjM4YWUxNjllDQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4gLS0NCj4+IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4NCg==

