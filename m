Return-Path: <stable+bounces-76579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C258497AF43
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0B28754A
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973715CD41;
	Tue, 17 Sep 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CJQRTeot"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5015C126;
	Tue, 17 Sep 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571298; cv=fail; b=V5Q4Wzr939iyk2OMEtnzbVcYb/I4RJ6dBITHvrMfJq8icAK7ZB/V236EJMpeVuTQAG/W3F+ntvfgeCT0UBTyE8qrcxAMcVTGM0WzNHKoNTb/1bYpnsJ0DhROX+js/a9KcE58k4hvVfQEJt3lifwNHGzmpVrObR8AqHRxBVNeQRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571298; c=relaxed/simple;
	bh=Q/2J7XRLRe/JvUh0uRXqadyyMuseecsd+8UZ523fs0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcpMNYlKUeFCgHk/5qQ2jFgw4ro3P1YaNinMMCbQmslqNXpnpr+1o7qCuny01lvLOO9p9JtOf2BCrTNd2lOmZjShGzaQSr6lp2AxIBR+aE7mNvmptk25N0JDa5m3cctfy3RLcL8CCl0+CEeFyiDqUv3SbERNnB7lY1ef13qGamw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CJQRTeot; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJIfc0rG/D59vfqn5lqItx4W4DL3+EX4ldARhmTLh/4vEqvNJAOTT4CRINzAKyYinz/CXliAaZb77Ux0xlFXrdnQLAAHZTO9wvUsAq5a8PfDdLVM8/QwuRXzr+WBZyE/Xy2gKos3nseYDiuFNH5NXsRlPFPVI7XGatThuS9BfVY+f5QkdzZd7KMj4OPiPNw5+0tzvjFT0bioYmR12XFUsFsuWVTroFCjgsSgiz2S504uLCE8AYZ4uJ4Q1Guv+7N05SxPm0h6E+kz28TddaQJgKadfQFM69rzmg6glZ4T5xJlHKsp/vkenQowcpUP62ln5bpkIpJ5eATEQC5hNixsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/2J7XRLRe/JvUh0uRXqadyyMuseecsd+8UZ523fs0g=;
 b=WX6ma3C60hxfV1aYfWdzcqSoCU/Ez2CCGCbnaeSwBByqj0IWI4O+3a2WTxUjC4W+vWXsta0TYwryK0rsQzBRaT8nP6+9lpiv72bSpYD/kloaGqqvNoGd3oSVSj20sJr9tSyu8ynGBx2El3mIvr5gfAm98TYELH2soN1wQEKmcjVBVIaDPI73k5DHF1YFVr0yNO0lquGKLsISZNiyHGsZXXEGVKUbHBRJA61+sR2VAlX/YU4Jf2PYz1dr6xn3XT3sIjF2QwyhfjiXlQaTJze1uaiP2/F5DYVPkZmKEk+aYJGF7Oy18ntveE+JL948cBlVmJdYDQ9m0hg90V3wNeihNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/2J7XRLRe/JvUh0uRXqadyyMuseecsd+8UZ523fs0g=;
 b=CJQRTeotxsTME7yQpX4S6AYaXKO6nB4OgBTSodxPLtnfX9KJw+PLsN+gGcNowQaZfKsESCHLj7nEms3VolBWNzYwov3bqUzMW7cZI6kQWoMsEMndOTNKWI1VuEOPi9F/Cl5iLZwq95ErNFcy5AeBRhjlPWeYRJccpEIsXXc8GyAwYuBmSRC2/PPk/DEFQ/8y1ip/P4TcLhXV8/XQWthtJ09MFt9CSxWaGraSqt5IoAPe2QlYzIWDrtYU6dYI6Dbm5c9MW5N5LM9Q5X18AMT0ciaiMJCS8RYSMVV+Nl5VxM76znGGNH5euS555i2prZVeKjZjhx7G+uFqlp3BvA1sxw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB9137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 11:08:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 11:08:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "gur.stavi@huawei.com" <gur.stavi@huawei.com>
CC: "Mark-MC.Lee@mediatek.com" <Mark-MC.Lee@mediatek.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>, "dqfext@gmail.com"
	<dqfext@gmail.com>, "nbd@nbd.name" <nbd@nbd.name>, "davem@davemloft.net"
	<davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "arinc.unal@arinc9.com"
	<arinc.unal@arinc9.com>, "edumazet@google.com" <edumazet@google.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "razor@blackwall.org"
	<razor@blackwall.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
	<roopa@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"sean.wang@mediatek.com" <sean.wang@mediatek.com>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Topic: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Index: AQHbA4Hagboir6ZjOEqxQ/L/+DWWZ7JbqzoAgAAEBACAACMIgIAACnYA
Date: Tue, 17 Sep 2024 11:08:09 +0000
Message-ID: <36b492b1d880e8956f9ff63431e713f290e5526d.camel@siemens.com>
References: <c7a52a818c1ae49ad7e44bb82fcea53d7f53d6e0.camel@siemens.com>
	 <20240917103041.1645536-1-gur.stavi@huawei.com>
In-Reply-To: <20240917103041.1645536-1-gur.stavi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB9137:EE_
x-ms-office365-filtering-correlation-id: 44855e27-57a2-4e53-439a-08dcd7090395
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGpRZ2RiSlZtMU5MZDN1UEFweWJmTGtLa3A2TVl5bUlrOHhBTEl4NEFtL0xw?=
 =?utf-8?B?Z0J5dmNVTWIrbm55am5yRnR3amlocGtMU0I0ZFRPa2VFV0p1SUpiL21rYVBY?=
 =?utf-8?B?dVdmNWVUMlJ2YTlqRVpUemZmQjZSY2N6aEVmTHFYTWNpOEFpajBCWXlTSGI3?=
 =?utf-8?B?QlZ6alVNK3JOcXVaSkdSdmxZVisxMFRoY2wwRzdiK3Z3U2IwdnlkdE1FWW91?=
 =?utf-8?B?c0c1dkF2c2pqSUtmNkxyTDVuR1pUYWc3RVJDR2VMRWsrK1NaRGYvUjBjb29p?=
 =?utf-8?B?bmpQWEFQak1PN0Fhek8za1M0YmZpTzRBUmt3blNQM3JsRnIrbUp1RTA1UUFx?=
 =?utf-8?B?aWxpczBIbGNSa3l6U3VoMzN2b1l2bEJFYTJDSnowZUUvUjExRHNoOG1kaFJq?=
 =?utf-8?B?aTlvZFlrV3RuUktZZk1vaHFDcC9sL2RJcWhmOXB3RFJLUjYxaWppMDMwNUZI?=
 =?utf-8?B?bUx2T0FDWDhrZEdsZWoxWVNsNllCZDdyYjBWV045KzYwNlF5SU4rd0lSK2kz?=
 =?utf-8?B?dmQ0ZmZJazloKzJscXExUXBBdXN2MkNpWUorVEhiS0s3YXpSMEFFbEJtZFVQ?=
 =?utf-8?B?bU9FMFowbEI2eEFvVkJzcmpFSWc5bzRQNStWVTB1NHZocGtzVTFKYis3bDhX?=
 =?utf-8?B?cWlWTTZXYk9Gb2JZU0h2R0hzM1FlQTdZek1PcHhtZEJkOWNNVzFxdFhpUzE1?=
 =?utf-8?B?KzMzc1A3T0RyWHFyck0xbWZsdHhJWUlDMVNSOVdjYWxvRG9ua3ZjY1RVNGs3?=
 =?utf-8?B?YmcrZERrQkx4WURYMlRqUmlkZFlGalBYNWZDdDlYenRhbFUvQjBLK3hXZ2F2?=
 =?utf-8?B?eUJYcnVwN0xTMzVsbkp3czRnUjYzUGdnV0lLM3VjVndMK0RyN3hGK1ovc0ZH?=
 =?utf-8?B?Z044ZWVVY0hmNlZqb0kzWEZ0YVU5Vm9YVE1TUWlCQ2UzNFgrd2E1N2k5cWY4?=
 =?utf-8?B?SG84RmczOFhnTU5UMHg4Q1E1aWdFNVBqMVBXWXNEUDNZR1FUWkhHbmZ5Si9O?=
 =?utf-8?B?YVhDZXJDaFVpNUd1LzFQV2h0TVp5WVpXZTdZeXpVNXNnRjdkMjFTbEdkYks4?=
 =?utf-8?B?ZklQTHJLU1l4RHlsYmlvOCtMcFF4cURVKzdaYXFuVW5iNisyU3h0NlpSSnRu?=
 =?utf-8?B?eGdEbWJrTnQxR0hvWklSR3p2Rm01aUw4MVA3STZ0OFFIdVVHUVRFd2hqOUdF?=
 =?utf-8?B?ck92aGh1bk1yOGpseHYyZ2p0RmdJTHpnLzMvWlpTL1d3U2NENkM3bUNEMXRM?=
 =?utf-8?B?R1FBOFJzemRJNllHdWRYUTdFSDAxa0lKRnNPUEZkU0VUL0N5OWczSHMxaVgy?=
 =?utf-8?B?ZzJlMkxEOUVrdUNjQWtDVnR0YzkrRy83VVlIRFNydC95MGR2NnVBVzR2OWY5?=
 =?utf-8?B?N2h0cDdyNklEaE14Wk9lSmU2bDI0RktGWVRXSmhiemkzancvYkNNM05FNzd2?=
 =?utf-8?B?alp0YlRVNVJud3MyL2VBLzlYbzJMY0FCb0R5TWVlUGdwWDZ1REVHNm0wYzh4?=
 =?utf-8?B?SXgwVStJOVNCdDRHM3J1VW42ZG1aK1NINFNjNjNXMFFHVWpKc0pZMVJDY0hl?=
 =?utf-8?B?YWN6WEkrckcyQjFobnRPNnlOTDM2NnpBS0JTeWFGcGZxdXZBZFdpbHgwYTRL?=
 =?utf-8?B?V2JrMTNuZkZOZVhUWVFQNURkVWdoMEcxb09GTm1MM1VBRDlnMHFEOWErczht?=
 =?utf-8?B?RVl5WmFaZU5OS3U1OUlJNHU1cHdYT2RkNFRyUXNlSHh1NmN2WUFBUkx5Wmxt?=
 =?utf-8?B?Q1JxNk1WZUJDVEdSMC90Q3Rjd3lwejlYcytMRHY4V0pPMlhhRzltWHJWQVRO?=
 =?utf-8?Q?Pr2wYBPh7JkqysKMUINTzuBQegKMxXqGslxgg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3hsKzYyWkhjOGwwcmorclAwRGF1dDZmY1JOSTg2dzVnMUh5a0Jwblp6bDRu?=
 =?utf-8?B?UHAvK050aDlMSTlaUkY5dEEyVk4rMXg1NEtMWDR4MGhGOXlPcmUrSEpvMjdD?=
 =?utf-8?B?R1dGRklFT2UyYjBTV2hRWkJsYThXeDBxeHVBR1cycXRzZVlpN1FMTmtaaXlF?=
 =?utf-8?B?WnhEMXRoNjVyNDNUMDh0MEhVL08yMkp4a1ErTG8wOVZuZG1ZVlJ5RCtoZmFy?=
 =?utf-8?B?OUpHcmFKbVhiRDFxeFhlaExQNTNsNjIyS0RJZWx0UVBpZ3hteVBhV2RmUmY3?=
 =?utf-8?B?OTQyQkdoL3pOcC9QVngrWTBnZGpPZTBiemxzd1VtVHRubXgrZkpPZzd6bHI5?=
 =?utf-8?B?VktWRFc5LytTdlVoRGd4NTYvTnFrR05wSXVreXVWbnFKR09aSVhGZDhNWTds?=
 =?utf-8?B?TmcvYjFlNm5ya2NqM0ZuNmVYeE1zNzY3QlF6K2p0TFR3SUNBRlZhUDNrMXU5?=
 =?utf-8?B?MUNjczRmYXM5QnJZakxWcHR0N1NIWFhIMFZOVXlVUlNPRFd3amVSM3ZMNzEx?=
 =?utf-8?B?K1phWDVZYlc3aHh3TXcrMVo5YkI2R1YwSTVuTFZhaW9ra0RmaDF4NUpxMThp?=
 =?utf-8?B?T0RuZlZHZ1VaWVdXRG1obHl1cGt3YjEzOTVOMTVuYTNZTnZrRDE4RTdNbXBt?=
 =?utf-8?B?T0FIMUh3d2hrN3lQdlVkZmNGZXdhakxlY0RlY3dFeHpGVzE5Q2ZiMUoxQW82?=
 =?utf-8?B?NTJkVkpzRGh4S2VRakRuemNDUmxFcTZPdWR5Q3hYYmxmUVRzMVhHcDh6WWRr?=
 =?utf-8?B?YzNmZ1pQclNWQ3ZGMlNiNGtLcXB4bUhtQTV2ZXFKVVBtRk52QzFaNFF1Ujls?=
 =?utf-8?B?N1puR3dqUEZhMVdSMDZZajN0czVBRnh4SWkrYkNDU1c0SlMwV0IvaXhlVlNC?=
 =?utf-8?B?cUI1WGt3R1NVRjBxWFlobStFdmpDT240WmdTck50YjBpcDllK1g1dk1meDJX?=
 =?utf-8?B?V0dvWitLZ0M1RFFIVnZjT1RGa0NyQU4vZi85NXJsRWdXT3c4TjJPTUkzQ1c0?=
 =?utf-8?B?SDd6b0Q4SUlTMVQ3M2ZlMUtCeDdlN1RONUtsYmZqaFlZd3U2eGkvbEhpVWQy?=
 =?utf-8?B?M1U3cXVsSHZUMXZ0Wlp3Tzl6Q2ZZT2FYc3ovS1pxbFI5U05WKzZ2QlRmMFpG?=
 =?utf-8?B?NDZwMnBueUZQVFY0dFA3TTN4ZGxMTHJ4M1VXQjNqNk5zYzdjSVJQVXhVblY3?=
 =?utf-8?B?WVUvdDZ5SDlodUloZmRQTmpxd01iZlJuOWRYK2FRZ0I5Wno1VVJHa1NpNWRM?=
 =?utf-8?B?Y3NrdHU4ZWdUaGhTSzF5RmN0OGYzOUZyRmRFaWU2OGFUeHMvU25QQ0VZbTdV?=
 =?utf-8?B?clZxQ2ZJblJBeTQxaUpESGdQS2hZVVBkcHhsOFFueEtYNWVQOEh6eDEvWWpG?=
 =?utf-8?B?NDErYlFmRng3SG5lUDVmZlpxcldiNnVyd1N1L3N5aGtadzVQblN4aUNVcW9t?=
 =?utf-8?B?MGNCNUdyWGNCRk0rM1kvSVBENmZEdlZlSHRuYXFvUnB1L3ByUUEyZEs2emcr?=
 =?utf-8?B?bHlsamN3dVlFRER4TmNvbjN2N0lHQXkzdEhYbHhLS1QxNkdBeXJVaitWNEJ1?=
 =?utf-8?B?VEJVb2U2Y2JVcHM5WUtQcFlWbVVJZGJPRDN3N3pYTUFvbHVKbE1PR1MzL0Q2?=
 =?utf-8?B?Y0VhazMvMHErWGI2N08zNHhlTUxXTVJVRThEazAxeGNnMTlGOTVqdDM5TTZ3?=
 =?utf-8?B?eThBU0FFZkplKy9lWmNhcGZuRzZiOEFkU294d1hHWUhZUm15Q0xIU1pMNVpo?=
 =?utf-8?B?blVURFFHZXNTSWRmbG85UGlXT3NWRzQ5aVhQUys4VUJqeUtPcHpHc1MwNTdJ?=
 =?utf-8?B?NnBocmdobDlYdWI5WE1DQ2xKMUtPYjRBZGNMTXhyR3VFTlB2RHNxMzNaeEtB?=
 =?utf-8?B?aVdXQmFXZm9uemMwTFhZSGRkMytWcGJvLzlLQjQ5YlU2bmx5RVdCQmdpaXhx?=
 =?utf-8?B?aWw1bHdrUmQ0ZTN3bHBIQno1UHdZVExKNGlSUVFrbmkyNkxTdGYvb2ZEV2gy?=
 =?utf-8?B?Umc0STNnY2s0eDlBRXBiVUFiNm9sTDhnR2NyVXp5RkRjNEthMTdQNmI2SVo5?=
 =?utf-8?B?NTVyMURZWlVsdWVyK2RFa3R2TUVUOGJDbmF1eVlyNjlKWVlCVk9zWm5QTXZD?=
 =?utf-8?B?SDNsQmpDQVNpdXBCcjVTQ0FEZ3BjbkVwOU1EdHVBeDU5N2IxY2V4cms2YkJ4?=
 =?utf-8?Q?dDnzFyQwRcNB8GLgSaaduXM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D146FF552533244AB34135CADFE8E832@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44855e27-57a2-4e53-439a-08dcd7090395
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 11:08:09.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gE3V+6tckF7j6WmkYuJdGHhfVp37yFYyxwrseAgpOE9607oz0+lSuWp6SBwwaACInvGqC3dnlfJPjgcf/jWAvl6zlu3aNLbQvBhutB3cXLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9137

SGkgR3VyLA0KDQpPbiBUdWUsIDIwMjQtMDktMTcgYXQgMTM6MzAgKzAzMDAsIEd1ciBTdGF2aSB3
cm90ZToNCj4gPiA+ID4gQEAgLTE1OTQsMTAgKzE1OTIsMTEgQEAgdm9pZCBkc2Ffc3dpdGNoX3No
dXRkb3duKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gPiA+ID4gwqDCoMKgCX0NCj4gPiA+ID4g
DQo+ID4gPiA+IMKgwqDCoAkvKiBEaXNjb25uZWN0IGZyb20gZnVydGhlciBuZXRkZXZpY2Ugbm90
aWZpZXJzIG9uIHRoZSBjb25kdWl0LA0KPiA+ID4gPiAtCSAqIHNpbmNlIG5ldGRldl91c2VzX2Rz
YSgpIHdpbGwgbm93IHJldHVybiBmYWxzZS4NCj4gPiA+ID4gKwkgKiBmcm9tIG5vdyBvbiwgbmV0
ZGV2X3VzZXNfZHNhX2N1cnJlbnRseSgpIHdpbGwgcmV0dXJuIGZhbHNlLg0KPiA+ID4gPiDCoMKg
wqAJICovDQo+ID4gPiA+IMKgwqDCoAlkc2Ffc3dpdGNoX2Zvcl9lYWNoX2NwdV9wb3J0KGRwLCBk
cykNCj4gPiA+ID4gLQkJZHAtPmNvbmR1aXQtPmRzYV9wdHIgPSBOVUxMOw0KPiA+ID4gPiArCQly
Y3VfYXNzaWduX3BvaW50ZXIoZHAtPmNvbmR1aXQtPmRzYV9wdHIsIE5VTEwpOw0KPiA+ID4gPiAr
CXN5bmNocm9uaXplX3JjdSgpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgCXJ0bmxfdW5sb2Nr
KCk7DQo+ID4gPiA+IMKgwqAgb3V0Og0KPiA+ID4gDQo+ID4gPiBIaSwgSSBhbSBhIG5ld2JpZSBo
ZXJlLiBUaGFua3MgZm9yIHRoZSBvcHBvcnR1bml0eSBmb3IgbGVhcm5pbmcgbW9yZQ0KPiA+ID4g
YWJvdXQgcmN1Lg0KPiA+ID4gV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGNhbGwgc3lu
Y2hyb25pemVfcmN1IGFmdGVyIHJ0bmxfdW5sb2NrPw0KPiA+IA0KPiA+IFRoaXMgaXMgaW5kZWVk
IGEgcXVlc3Rpb24gd2hpY2ggaXMgdXN1YWxseSByZXNvbHZlZCBvdGhlciB3YXkgYXJvdW5kDQo+
ID4gKG1ha2luZyBsb2NrZWQgc2VjdGlvbiBzaG9ydGVyKSwgYnV0IGluIHRoaXMgcGFydGljdWxh
ciBjYXNlIEkgdGhvdWdodCB0aGF0Og0KPiA+IC0gd2UgYWN0dWFsbHkgZG9uJ3QgbmVlZCBnaXZp
bmcgcnRubCBsb2NrIHNvb25lciwgd2hpY2ggd291bGQgcG90ZW50aWFsbHkNCj4gPiDCoMKgIG1h
a2Ugc3luY2hyb25pemVfcmN1KCkgY2FsbCBsb25nZXIgKGlmIGFub3RoZXIgdGhyZWFkIG1hbmFn
ZXMgdG8gd2FrZSB1cA0KPiA+IMKgwqAgYW5kIGNsYWltIHRoZSBydG5sIGxvY2sgYmVmb3JlIHN5
bmNocm9uaXplX3JjdSgpKQ0KPiA+IC0gd2UgYXJlIGluIHNodXRkb3duIHBoYXNlLCB3ZSBkb24n
dCBuZWVkIHRvIG1pbmltaXplIGxvY2sgY29udGVudGlvbiwgd2UNCj4gPiDCoMKgIG5lZWQgdG8g
bWluaW1pemUgdGhlIG92ZXJhbGwgc2h1dGRvd24gdGltZQ0KPiANCj4gQnV0IGlzbid0IHNodXRk
b3duIHN0aWxsIG11bHRpdGhyZWFkZWQ/DQo+IDEwIHRocmVhZHMgbWF5IGhhdmUgc2ltaWxhciBz
aHV0ZG93biB0YXNrOiByZW1vdmUgb2JqZWN0cyBmcm9tIGRpZmZlcmVudA0KPiByY3UgcHJvdGVj
dGVkIGRhdGEgc3RydWN0dXJlcyB3aGlsZSBob2xkaW5nIHJ0bmwuIFRoZW4gc3luY2hyb25pemUg
UkNVDQo+IGFuZCByZWxlYXNlIHRoZSBvYmplY3RzLg0KPiBTeW5jaHJvbml6aW5nIFJDVSBmcm9t
IHdpdGhpbiB0aGUgbG9jayB3aWxsIGNvbXBsZXRlbHkgc2VyaWFsaXplIGFsbA0KPiB0aHJlYWRz
IGFuZCBwb3N0cG9uZSBzaHV0ZG93biB3aGVyZWFzIG91dHNpZGUgdGhlIGxvY2sgbXVsdGlwbGUN
Cj4gc3luY2hyb25pemVfcmN1IGNvdWxkIHJ1biBpbiBwYXJhbGxlbC4NCg0KbXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IGFsbCBvdGhlciBSVE5MLXByb3RlY3RlZCByZWFkZXJzIG9mIGRzYV9wdHIg
YXJlDQphY3R1YWxseSBvbmx5IHVubmVjZXNzYXJ5IG92ZXJoZWFkIGFmdGVyIHNodXRkb3duIGNh
bGxiYWNrIGhhcyBiZWVuIGNhbGxlZA0Kb25jZSAoZXZlbnR1YWwgbmV0d29yayBjb25maWd1cmF0
aW9uIHJ1bm5pbmcgaW4gcGFyYWxsZWwgYXQgdGhlIHRpbWUgb2YNCnNodXRkb3duKS4NCg0KQWxs
IG9mIHRoZW0gY2FuIGJlIGlnbm9yZWQgKG9yIGxvd2VyLXByaW9yaXRpemVkKSBhZnRlciBzaHV0
ZG93biwgd2UNCm5lZWQgdG8gc3luY2hyb25pemVfcmN1KCkgYW5kIGZyZWUvY2xvc2Ugd2hhdCB3
ZSBoYXZlIHRvIGRvIGFmdGVyd2FyZHMNCmFuZCBqdXN0IHBvd2Vyb2ZmL3JlYm9vdC4NCg0KU28g
dGhlIG9ubHkgZWZmZWN0IHN3aXRjaGluZyBzeW5jaHJvbml6ZV9yY3UoKSBhbmQgcnRubF91bmxv
Y2soKSBhcm91bmQNCndvdWxkIGJlIHRoYXQNCi0gaXQgbG9va3MgbW9yZSBsb2dpY2FsDQotIGl0
IHJlcXVpcmVzIGxvbmdlciB0byByZWJvb3Qvc2h1dGRvd24NCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

