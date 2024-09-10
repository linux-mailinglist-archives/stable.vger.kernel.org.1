Return-Path: <stable+bounces-75757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE4B97442B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 22:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97055288170
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DF1AAE08;
	Tue, 10 Sep 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QUSrTBB/"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769C1AB50E;
	Tue, 10 Sep 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000831; cv=fail; b=jHvjJKblEnomPrav24Vx/0InvZnDQTl5C4dKfWCPGAJv4G62avcSTmCzBBNwit4iFc22GgzQRYJ3rCbl/ZevJS1Y0SLlEyqQEUQw27DztAGlu1Y9dk0GRJtgeANQ5VK4hXtCFaVxHeCJeJzg5kqRc56YWRtnydWNb0/VJ2OgwVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000831; c=relaxed/simple;
	bh=97vxCdXLwuFduqUhtXr004SNCY2o21oib/qXwi4Ht/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uX9bKmVERQspdH0Bx2WViqdsWvGDTtleUv1g93qwKl2E6+BrVp1YGNPptzMMatXzrPLDSg0fdKwKZzKhhzT41dhkxX5dgp3OsA54/m0Pj57h87wRkAn0o6/I1HkIlp69sec0LM9tiC/mdisAFswEHK2PL1nfOu8/q7lW6GU6RIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QUSrTBB/; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/XeDoGWpR7GKiVYZke5hx2CkxvAbk2dLjnkUoQ0Lw9pvFtT4ra7DQSn7f8/E2/5fpW7Z1oukrttUtre1voMVLtTC/djOmE37kmMc7arBtHbaJUc9qd0ciYSRjzyh8SkCiPb9RCUCQsikocj6GMYrprT+F29O3H1hMT1ftuKHFiEahrKBBa+KNmF5dHNujE+/iqLlVNc8tuIsMp/cMY9cgS8K9MciuZ/Xc86sApTcfkA1AHh6whsZfqnGQBF6Ivurii6cAqfpFKo7kaIA2W21+TOLYlh2frVB4GtfQ6khCTPPM7wqHlJ28oOjPNqU/Grk0d6ysBwXKIpbDjFNwpl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97vxCdXLwuFduqUhtXr004SNCY2o21oib/qXwi4Ht/g=;
 b=QAlY9095kGWwxdMA31tlZ772Xxsc5VY1VcVGqjyS9u/llsfPPbxzmewr3y+GWX3dDWz1pb3q8JQgJyMr7Jga99pN0Puc7r10TFFOiKI/x7SsAzp4GChrucB4g1Su7sOeOEBOK0rTEiSS/A88PA8pkRhgRh0NP407tiZOQWt9fXjpC90NAO2yt1IbtjGvvxqh5kzwv0MZEI4XwGT7FlN2BNbpsEdgp6Va/szBr17uvjfNX+8vB8AValG1pJaIKGgEFMmjWOmft5Qn7g/HlWAVfsoRqXw0yXbcoYBNMiS0UMx8lLxI9na0py7XZutM8h77Z9kCpBnfw0gPbEVZxUxfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97vxCdXLwuFduqUhtXr004SNCY2o21oib/qXwi4Ht/g=;
 b=QUSrTBB/iFQBf3tgH7eYk5oWP5BqmJXDNazuItd9pejZn0/I0yD39HQSbrkQjiP28zkyi80XineUSIbik0PnFwgELWaQjUXHd21R6G81akFWSOf+tN2xDAGi+IB+4KT11CdGVAzvtrarsTdNp1of4YMZ35OyXYXQPif/ddNbMZWJJ+Z2h+xbIC7MpFcSo4g6MbbaegMRimSyMYQiO8ukIvViYJ4mxuxCZyMDS3qgqMzyO9XTZ/JHlhMO/NfAcUGaSnlyvmhILjlnUe2nSyIG1VOCzclUGErNNRW/ObMXusWMv9jLvFdX/NcjeCfCFqs04q4wU7tL3mfZ9VpUGnj7AQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 20:40:26 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 20:40:26 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>, "dqfext@gmail.com"
	<dqfext@gmail.com>, "nbd@nbd.name" <nbd@nbd.name>, "davem@davemloft.net"
	<davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "Mark-MC.Lee@mediatek.com"
	<Mark-MC.Lee@mediatek.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "razor@blackwall.org" <razor@blackwall.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>, "roopa@nvidia.com" <roopa@nvidia.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Topic: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Index: AQHbA4Hagboir6ZjOEqxQ/L/+DWWZ7JRShcAgAAyOIA=
Date: Tue, 10 Sep 2024 20:40:26 +0000
Message-ID: <a89dfb1524d9592a5077d2a7a34dceed579e7d3d.camel@siemens.com>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
	 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
	 <b6604e07-9add-4e93-ad6b-f1efc336e3bf@broadcom.com>
In-Reply-To: <b6604e07-9add-4e93-ad6b-f1efc336e3bf@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3644:EE_
x-ms-office365-filtering-correlation-id: 2413772b-8326-4fe9-c6a9-08dcd1d8ccfb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWlBWDJ5UWc0RVNpUUd1MkJBVzVzY3lmNWoza0IzMVhXSmpFNFBLNHZKUldk?=
 =?utf-8?B?cnI1bEZFa1NSNkhkYzNOcUs0U1doaEJ2Y3Y5Z3RTaWthMFQ1KzRzQkZFbVd1?=
 =?utf-8?B?cU01UG1RbHB1azNJNlhKN2Qxa3RKNHVOb0k5QzJsRmJIWG5iU2JnUWhwVW8w?=
 =?utf-8?B?OVg5NVBoK2IwVUt3ZDBPSFppdzFQWnlMSDI4dTRUaXNUdVlkM2VkNVlVdFVN?=
 =?utf-8?B?RXB0dnVYWTd0emR4aVpEdEs4dnFsaXNUeTFjRVM5SFY2VEFCN1BiK1hXMTl6?=
 =?utf-8?B?MW5TSEZ0bk01RXhMRzZxQkhCWGZyUEhJbGFwR1RhZysycVh3eCt4aVhvRTJu?=
 =?utf-8?B?V1dVVndmZ3BjaDYxV3d1QXprejJYaUNQTEFIeDdzR3A2U3lCOWxoRnJuQmdL?=
 =?utf-8?B?Tjd4c3JZS01USDQ3eS9mK29KMytwUXF2d3RhWjUxMHh5alBrYnlpZVpmblBZ?=
 =?utf-8?B?UzFTUXBOWmtpazJCU0kvcTFXL0RoOTc2bkJSS1BpRTc1SzFkT1BoMmFPOVFC?=
 =?utf-8?B?WlhjS0RmS2JxSkVaVVQvekpFZGJWZmN5L0lqamJRYUNjMlB1c2VBcndIOXhU?=
 =?utf-8?B?Yk1zWkIrSiswWG53RTlSaVA1b1dlQ25TTzU1SlJ2TjZNV2Y0Mk5SZGluMnR2?=
 =?utf-8?B?ZGhQdHZQMnk5Ykw0VVNqSEtmZHBUeGZSQnl4b1hXRlNJN1A3eG1FcUIzRldB?=
 =?utf-8?B?eEJlZ2V3b3FxU1pIYzZWQjBoeWU4WGp6TmhETHU0ZE5QZzNyNFBoQkRwc0lp?=
 =?utf-8?B?dEYxa2VxbzFlWTZ2WDlSczRCM3EvS0hCVkNhYmRHdHM1OTFUODk2UVE4WXJM?=
 =?utf-8?B?bGdpbDJVUGdaNzh4anRWYWF2QTBTTFpwd251dWpqSTkrSFRmNHd4eGFQOEsr?=
 =?utf-8?B?OUhjTDM1SGg4elhuOVFXd3VDM0xVZmxjYlhHRy9CdHlmT3dyeXVGM2VUVmNX?=
 =?utf-8?B?T0pPUGtNWVYvdVpwdE5FSXFQUUw4YzBOVjVlc1o0Tlp3dXVYZFlMTGNYdjZT?=
 =?utf-8?B?SkVlZ1JqZWRYVUJRQ2ZLTVltSGc5SEhRY0haQStyNnV6MWwzREJEZGlvc3RB?=
 =?utf-8?B?VjZ0cm1JWjFGRVFQMFhIT2F0bWdLZTNZQktqNWJmdC9kWVMzSktWdjVLOWxt?=
 =?utf-8?B?WThVYmRmMkpJcXd5bVRGZUhwbi9LODZ5UkJqMy9sbXcwWGs5Z1RWbitoWE9q?=
 =?utf-8?B?OHZORUdaUThiMDJEYzNMR0krRjNudUttc0NHSjFhWEpSRzhFVWJqaDJOc0NE?=
 =?utf-8?B?MWJiakZJbUVwVEpUZTkyc1NNTmFMSmVHWW84bGM5N1lKMHFtV0tGbEFYOTNS?=
 =?utf-8?B?N1FRMmlQL3ZxalJyZjliNkNhNzRyeGpvRGdTbytJVFcrZURXbytTa0VkL3Vv?=
 =?utf-8?B?eWpRZXp0VHMvUmtoblhkbEVRNzN1cTBpbUVuaVVDWWVXUTNEYVk3K2U5c2JO?=
 =?utf-8?B?Snl4M2cvczF2N2owYlRYMUM1NVVyN2lUNXUxQXR0cGg4NVM3cDhOMEUwRDEy?=
 =?utf-8?B?cmV0ZWtaQ3BwK2YxNmhLZm0wT2JoNjNJdWZuNU1OT2luUG1rTHRBWGxjemNk?=
 =?utf-8?B?dlVyVkxBTHlMN0lTeHhEdHIwV00zNG5MV2tOZCsvL2lvMzg0Zmh3V0VsVGlI?=
 =?utf-8?B?K2R3ZWFSLy91VjN6eEczOGRNMnBXYW56YU9TMlNIRjlHM29yQzhuVVFYQ293?=
 =?utf-8?B?NVlGM2ZMc2g5dVlmWHdMVEIwbnMzUm04VHNHYi9FcjhLVjVQTVdINXhsMzFv?=
 =?utf-8?B?bnlQeGJtM2xpR29VcDVSWFBlczVhQmUzMkRHRWZKaEJPOXpKNy94M1RKaGxz?=
 =?utf-8?Q?4+EmaZlGJ44m93B38u4K3QxQTXMCDpPbanrjw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWtLM2M2UHpTSyt2K1hrT1lycVk3dUxGekxkNUQwb2hCR1ZnUWpLaGh5SlVU?=
 =?utf-8?B?SG1ZYk9hbHpPU00yZ0VTTXhFS1NmOFFwOGgwT1BHbit1TUFYU0NIS0d2bUND?=
 =?utf-8?B?RGVIZUlwZk5GZGFqUjJKRDNGRkVyNWtaOVpzVzdySmRsVmZXUmFpRHkxVFFD?=
 =?utf-8?B?cEZJdXQyNm4vRG1nT0p1Mi9JTDVIZzdtMXh0cW0rOTJmNVh1dkVMRGZleXhT?=
 =?utf-8?B?NmNHZjl5OWFzbEFmQTJ2eit4ZDM5Q2xITkJBWlUrVWllNTd6enFJQzVtUnFD?=
 =?utf-8?B?bExlQkJRdkZKUGNTOEFIVzBvTzJqeXJJMWROUDZsQWp2Z3IzMEtscGU0dTE1?=
 =?utf-8?B?Q1dia3pkMlBhMDhCWjJiSlVmMHpsOGJGZWFBWVQ0Um1COGNva2J3T2UzNUdK?=
 =?utf-8?B?YnpJUmszLy83K0N2eHpocHdDaWMyR09FOUVMOXM4V0JlS0lJUUFUQjZpaWtH?=
 =?utf-8?B?d1FVdld3Z20zVGlPUHVHMWFEWGtDRGdYRGZYZXlRK0pJbjdxejdMbjdpYXh6?=
 =?utf-8?B?RVFvbVJ4aGF3Mk5XTkxpZDlmdUpkV0JQSDFSRW1ReGs0ZEZFSU5DRU51Rklh?=
 =?utf-8?B?ODd4SWs2YnVwU09sYlRhQ1prSUZ6WUV0bEpGWUs0TCt0YmpiQ3pyZTUrbXJw?=
 =?utf-8?B?RlVMcktUNjRoTnZzNi9hbTRFZlFENmRwc3pwUjRYbktMcFN0SkRvOWx1MGJa?=
 =?utf-8?B?cG0rTGpnVzRNZTNNdlJIRWh3MndTakUwZm94Q1Z4UWdkN0E2MnZuTEY3TU1B?=
 =?utf-8?B?T0ZpM1p5Tk9FbnJpOFBiY0dYZng2QUZxUis1TnJ3Lytva1dyVUVYS2RKeElS?=
 =?utf-8?B?YW1BUkkyMk1GMXI5UXJOa1RFUXZ2dmdudTlJRy9ZcVg2WGpIbmthVXBYQ1hv?=
 =?utf-8?B?ZC9xNTIwL0RoSUJOVmwxcDU1cXIwWWw1N2VQdXRSSFdjN2cxSXFIS1YzODFO?=
 =?utf-8?B?NHBqQjh5dm5CMm10K2IxTFgxbkNiSnlpMnpUaCsxc1E1S0RiT3V3T0szQjB3?=
 =?utf-8?B?RTQ2bnhBNEhkRWhTMUdkWUJZczZCdEhMVm5QaW95U0JRL21oUGRIUFNwWnhR?=
 =?utf-8?B?RW50UzlSdkhyNkF5a2dSR3F3aDVLckFEa3lMNWovdEg2TnZsdVZrRk9URFN2?=
 =?utf-8?B?MDNXRXc1WjNsN2tTQVM3QjJqK2VGL0I0WmxjbStIY0h5akxoZkVUL3oySTlC?=
 =?utf-8?B?ZFpsZUh5RFFMYUlNWTV2NGovVHdWdXZ3bGlFUmo5a0pvMVlzSldKd3p2eUhj?=
 =?utf-8?B?WlpWSWY5aWl1NEM1N21oQWZGdUc0Q042QXp1aDVtQWZoN0p6c1dnN2lWeHZF?=
 =?utf-8?B?S2V2d0VteGZZbXBNRCtQM0l3cWEybVdpMlh5amViUExHWndQdzQrazdBQUJD?=
 =?utf-8?B?MnRNcWRqSGt1dmpvRFFZb0cyMlVsaWhRYnltUnFJVnBLNkVZUjZQT1Nmaitq?=
 =?utf-8?B?QTlVUTZMY3hVRlNqblV1SDZlN0hKNGdJZlFhaE1CMGxHV28xdmMxNlNLNksv?=
 =?utf-8?B?RVNjS0lsWTBqakp2dmRUcVRYV2llMDk0TEJPNVBKQlNCaXFvajhVbW5JYXFu?=
 =?utf-8?B?bC9EOTVUdGphSHBwbmlmMGlsZmowQ3JmY3lpdFJOY2J1T1hVSEt5RkhRdmpl?=
 =?utf-8?B?dGlwci9seXgrQU94Nkt2dUJ3TjRzcjA2ZjA1ZUxrNi9aV1pxZW85Q1B1Nk5U?=
 =?utf-8?B?Vjh3TGdsbko1djlTbGdNaVZOS3JlRlkxb2tZQzFUTDBzVzhER1Q2K0xTV2J2?=
 =?utf-8?B?T2JXSjladXRqRkVhWWREakN1SkliL1VDdDJva2JpOHBpUllkcGRPWTJWd2ho?=
 =?utf-8?B?MkNkVjRwaGpCdDdEZmlUbndPcmJXQVdpWFNoTVlPMU5LczhVNm1mTlRLcnlu?=
 =?utf-8?B?S3MxRmNnSFFrVXM4VW5HMjVOOGxNZ3dHM3BpTFc0L1g2MnRrYVdKQmNtVjJZ?=
 =?utf-8?B?YWY5SGNqK1luWHVOa1VHeGxsa1pKVmpra29sVEtQbzZkdWx1d0JWWURDS1Fs?=
 =?utf-8?B?MFJqNFREYk0xK1grb0hibjNlUU8zclJhQlQvM29Wa2JtS3NCOU83QzBiUFFI?=
 =?utf-8?B?RHFsQnNreERrY3VnTW5ibnZPMHhkSWpFR2Y4aFp6UTBPWUQzeStzZ3JWYmxH?=
 =?utf-8?B?c2kxWmJHdTVDb0l1R2J4QTBkNlQ1WEZ3QjJXNzBVZmtNcGJOSkF1anJOT05h?=
 =?utf-8?Q?LqvL+Siyz91ZgDv5m9rj+oY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42AA87166BB4B1448644FE8ABF440EC1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2413772b-8326-4fe9-c6a9-08dcd1d8ccfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 20:40:26.1391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzaiXCbzrBoRNxSh2vbvzDC8VxMxzcHaQ3tmf/hM8dZoHVchL6DvJftw6L9F8FlTWZpOQZnhU4yhTScPY42eRsHAnFoTlQiUWUEDaSuGvLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3644

SGkgRmxvcmlhbiENCg0KT24gVHVlLCAyMDI0LTA5LTEwIGF0IDEwOjQwIC0wNzAwLCBGbG9yaWFu
IEZhaW5lbGxpIHdyb3RlOg0KPiA+IFJDVS1wcm90ZWN0IGRzYV9wdHIgYW5kIHVzZSByY3VfZGVy
ZWZlcmVuY2UoKSBvciBydG5sX2RlcmVmZXJlbmNlKCkNCj4gPiBkZXBlbmRpbmcgb24gdGhlIGNh
bGxpbmcgY29udGV4dC4NCj4gPiANCj4gPiBSZW5hbWUgbmV0ZGV2X3VzZXNfZHNhKCkgaW50byBf
X25ldGRldl91c2VzX2RzYV9jdXJyZW50bHkoKQ0KPiA+IChhc3N1bWVzIGV0aGVyIFJDVSBvciBS
VE5MIGxvY2sgaGVsZCkgYW5kIG5ldGRldl91c2VzX2RzYV9jdXJyZW50bHkoKQ0KPiA+IHZhcmlh
bnRzIHdoaWNoIGJldHRlciByZWZsZWN0IHRoZSB1c2VsZXNzbmVzcyBvZiB0aGUgZnVuY3Rpb24n
cw0KPiA+IHJldHVybiB2YWx1ZSwgd2hpY2ggYmVjb21lcyBvdXRkYXRlZCByaWdodCBhZnRlciB0
aGUgY2FsbC4NCj4gPiANCj4gPiBGaXhlczogZWU1MzQzNzhmMDA1ICgibmV0OiBkc2E6IGZpeCBw
YW5pYyB3aGVuIERTQSBtYXN0ZXIgZGV2aWNlIHVuYmluZHMgb24gc2h1dGRvd24iKQ0KPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2
ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IA0KPiBUaGFua3MgZm9y
IGRvaW5nIHRoaXMgd29yaywganVzdCBhIGZldyBuaXRzIGJlbG93LiBUaGlzIGlzIGxpa2VseSB0
byBiZSANCj4gZGlmZmljdWx0IHRvIGJhY2twb3J0IHRvIHN0YWJsZSB0cmVlcy4NCg0KVGhhbmtz
IGZvciB0aGUgcXVpY2sgZmVlZGJhY2shDQpBcyBJJ3ZlIG1lbnRpb25lZCBpbiB0aGUgY292ZXIg
bGV0dGVyLCBJJ3ZlIHY2LjEgYmFja3BvcnQgYWxyZWFkeSBhdmFpbGFibGUNCmFuZCBJJ20gcmVh
ZHkgdG8gYmFja3BvcnQgdG8gdjYuOCBhcyBzb29uIGFzIHdlIGFncmVlIG9uIHRoZSBmaW5hbCBm
b3JtIGZvcg0KdjYuMTEuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3
d3cuc2llbWVucy5jb20NCg==

