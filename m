Return-Path: <stable+bounces-253506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPyaEh/kDmrACwYAu9opvQ
	(envelope-from <stable+bounces-253506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE645A39EF
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B889301485D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871093A6F05;
	Thu, 21 May 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uhztOERo"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F033A5E61;
	Thu, 21 May 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360692; cv=fail; b=IWseM/1mhkMn/Qz5fDaEUz4JQOuKuippqnU4wWpBOwQF6xD81TqHLrdcA56Vw0jQpOpISU2As4NPAeetgM+fXtX/ubgcw++RWLAxKlzWu9/WxRL7hPon+hcmgiOVOE0BM4swtjl1fcANiS9oHgjz4mt1VGj5h38J9SzKCXA95lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360692; c=relaxed/simple;
	bh=PX0pXJa81u9se2zdtoP+J1+wqs99/lHbB48EN+0sW0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWVASu3vUOd4qw7GXKxieXPODoK8bsPZbKE2DyCMZR2vUs5fkXI8aWWOcp/FgAbMR+MMejSoxuIH13aKcZTBOqsdzlSdoUY8uZgF5O3gZEP7eFUimhlOyuxyjWDxKKcjUSNQ8Su+6IWuMY2VO5SWQFCDw/hjRfnGZxG+1ewnLmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uhztOERo; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS7D8Il78o2RgikqPrAJMGGIaONaf2jUQPYOd5/uQ52dzXaYZG8W3jKjAbt/up8rSTdTc9Lfif86EskJOqVZAKaU6RCrWw9z1nXVa4UedEOKGd5k4aEXg4UCH03MLpA6kpxbpByFrySoNsatuHfYbIMZ3Vfhap+Cw4nK8OcSzSbt0Xnm8hjyXCg1QXDiHDHnMn0a77wRoPsr4W6Kmte/VhCgwK/yOqzBYnK4QzNHJ4s+LoYICoka8K/VbsS41ncStQDT+v3x7pZuosQH6NreqALYwvZgrhwxwvFZclcI8QiSa4R62/vSP9/apOhx3jQGxUWsobpOeWwkeUkRde2Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX0pXJa81u9se2zdtoP+J1+wqs99/lHbB48EN+0sW0g=;
 b=waZ12hM8Rei+CT8DG6XWLRCqFikZ9u/uJNBpgY7tfbsZr7yMe3ChKjrIhw+urIpxKkjDfkRn7Jub6HJcuh0mrwVEI/uKSusZA+iM96RLGI7dzY7NdGieO/wR2jxgS2qEHr52oqpjn6ld9uCH4UfqkpjAL+lIMb2gaOZVB3+AuMataBl0IYcztCIdh7UOCEjZnGX8o0ilaFLuqiQE0E318D129dXnHWPFyXDfGllr3EdJSyf7KbL+4SEyPDIE76ekv3BL0NuxKxA8adZUbsQf+PndIX7mC/493hrE6oOS6X1hs6IKm5WdkQH5MIGXc+IU0AbocEtQI3ein2BFja65/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX0pXJa81u9se2zdtoP+J1+wqs99/lHbB48EN+0sW0g=;
 b=uhztOERoHefo4HmDb4fYyrVTtfnmi2YYra08C/qrlALn++3alcptpkXXyp8VtSqCdk9+U6BkzzO+zyJ0LT5TxYNyPlwnmvNJL84BPf0IHfnjdP78vNNGJ6M4eO0zYiywIs6wgyh+BXQvXNMXLL/FAKR53yedXCcbHkWaQq1CIJXIzViL+BQKR0mdvKG1Sc9LVS/S58hkyTEgb4zJ2MvNoFJ9LMBpew7M6aLjnxy9ieGO4soxW6Le0FnVEPcmCceIO4CdPykeL45s7gMAwZ4WafaQl+2V7AQGzRRd9tHxRqr9nNfHTFXU63G1pvj7kxoS0A4iR2XW7o0PgLBu9OmvSg==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by VI2PR04MB11169.eurprd04.prod.outlook.com (2603:10a6:800:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Thu, 21 May
 2026 10:51:22 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:51:22 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, "Carlos Song (OSS)"
	<carlos.song@oss.nxp.com>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Carlos Song <carlos.song@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
Thread-Topic: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
Thread-Index: AQHc6Q/DHFUS3S5g/kKU3e24F//cAQ==
Date: Thu, 21 May 2026 10:51:22 +0000
Message-ID:
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
In-Reply-To: <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|VI2PR04MB11169:EE_
x-ms-office365-filtering-correlation-id: 4b0236a4-16b0-4177-f163-08deb726e5e0
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014|38070700021|20046099003|921020|13003099007|18002099003|22082099003|56012099003|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info:
 BA/OjXZMWHoLBlRwabsOvNgiia6aNLMeiHEorkcO/TTjTnG6FUmupVVfST1zAK3LbEXPai8cRA7Ph4UECtNW080VAVUmLQzRAL0IZjoCvuU6YRZMqqbfPAgySupJA2xpmEBhGtbu23MVWBzxMegvtB4ZfhosvDJiC7CIfHUgfZUtpUu0p6KCxMOcYnHqaq33lYmRYOAOHBriMKpYCXT+5Cb1M33kq7aPqZ1eRtDRuD5nSi+ux3Z1xUttK1lhElhNBE/pwb9QDx6yNUOMv91XyTN0fCnoHOu9oES0qL85uEBuf83o+TugSwOs7NdZMsPUcVJ2I8zLusG6h8yIY0VEbEsX1eIO0f3vtcuA1uNIlEdl4PCJtUSdTljXZMmIjHZKTupH3mC9Si0c5mHdKwQdOnWQi4xhgNkPx9lpZsgIP84PC0dhKivw+IE0WP8spMYb/T0mXzfdNyq0joAUmmezTt680QhDCKGllQVrWLpyVdInYeImdronYHLuEIG7E/TbOWpfQBd/uRoz9/p0pjRQt7lCdvpJlf7Um/xqH/z6BsvG6T8fWyZqCjZxZFutEHuYtZ/nqSedvb1DNl4AYbRnPInPBw658vqZ8xR/A9fmrWTsOrk+Td/Y/xESfldtxL2DTyEAKxFi+5zqVvO+LtXdqBA4n8DnQbGyGS1uxgA+vsmwqA2BlcmNan2WJEVewRwPm/1VmMt4mkABgmnvcM1HrGd6GkJZXglfS3yczZexGS059VTfcll9UHQ//Gk2UiZWAS5HfWbabow0uaPeZ6tFIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014)(38070700021)(20046099003)(921020)(13003099007)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnRZZWNRb2lEdThYQktDUkFXWXNDZ21XaEJuRnAwcmpyYUcybWZUNGVieTFW?=
 =?utf-8?B?aWFyZ1RwNjFXZS9RWkFSTyttL2o2QmxpSUxWWVV6djVITjcwVDNpRFVzWXYz?=
 =?utf-8?B?LzZ2a045MmgxUGVZVktHWGpJa2RnT2s4dGlHbWVzSWdMR0MzRm11NDFKdklr?=
 =?utf-8?B?UGhaYzdGdGxqQUZjNC9nRUxWR1I0VmlLamNFRFBkZFVrald4Tk52L0p6ck1U?=
 =?utf-8?B?K3B1NEZVRzNrUldqYWZ0T3VhL3NUNzc5UnRUWW5NZHBFNHoyTThSZzdlNjZ1?=
 =?utf-8?B?Rk1RUzBPNjZDckRQYmpaQzF1cjBNVUZQQld4QVVOVCt3U3ZMeWVldWxTbDdI?=
 =?utf-8?B?N1RuYW9tRGVQVkNGMFNMYndCZ1J1VGdJNUJZeTFuS0hOZWRlbWNQNSs5a2E3?=
 =?utf-8?B?c1JtS3lOL0tvK2xTaTdvS3F5VkpLWGFKbjVaSldUd0N3ZFZ5Wk1BcEIvcGhn?=
 =?utf-8?B?OFhua0FSVHZwbEI2NmFGN2VuN3hnTVJ1N01pdXFnR2ppU1RGTkFVVGxoekhU?=
 =?utf-8?B?NktHaFlUc3Y4NkhtNTFaTFhYNE9KWFJORmpubkJHc1RwL3huWkJUWjVEYitm?=
 =?utf-8?B?MSsvRFR5VlZNZnZWLzl1RUFrNUFWTDFBc3pwb2p3RjlvK3luS1djaDhHcm5n?=
 =?utf-8?B?bDV2MUN1Yno0QlBXYlhtWUhpTzVBRDQvS0wrSzIwK1ljR3NpdDE2em1sZHZ4?=
 =?utf-8?B?NTNieDdqWGVyUGlhZUhBU3hHUmZQV21HV1gya3V2blFRbU1FdllreFBxZGNq?=
 =?utf-8?B?NkwvMDBnZFJaUEZrR0NPRzJVd2JYY1AxM1o2TUszenNRVEQzbW1kWU96OTdM?=
 =?utf-8?B?UUpoR0ZmVnczOSttSDlZWWhWOW1SN2lPQWc5aDZONjI3bUdKWmEvTHV2MWI2?=
 =?utf-8?B?Q0VCMXNEMnNiWDN3MWFRV1lSNXo1YStENjRZekNma01NR0ZyLzE0YTlSSUtI?=
 =?utf-8?B?ZWJlMEgyQkNzM01raG1iN3NsRDRBUWVLR3lNWG54NUlTcXJBNjJkQ0RQd1hL?=
 =?utf-8?B?K3dxSG5qbkdBN0k3RVNzajNHNEd6NHI0Wk45ckFKU1JYMkhwSmI4ZGs4T0Mr?=
 =?utf-8?B?R0RLRitaTFlzTFhQY2lidjRpT0g5OVpjL0pqaFhNNXRrMHRzZ2tPY3ZPYUxl?=
 =?utf-8?B?dDZ6Tk5Mb284MzUyV244czcxN1htRFNjWHNpbUY2TU9GUnhwQjFvdldrVkpp?=
 =?utf-8?B?cDZ6VENycW1LWVJNNngrYkNnblNsYXY3ODRNZWMvOVcrWkF5ZnBSVGtjMVJr?=
 =?utf-8?B?U0g0SjRtL3J2amE5c0hHSndITjQxZXVEVnFVUWxJZXJocVZVcGpUanlzazFz?=
 =?utf-8?B?WkY5VEVzd2FKK29KSXJIRWZKV3M1aVpsYWNIZG1Jajc4V05meVJsdjcvbW0r?=
 =?utf-8?B?a2ZQZmJ6d1FYdHZ6Zm5PU1JDby9QNlhCamJQUHp5ZTUrWnJaVWpRazRmODcy?=
 =?utf-8?B?bXEvZVZiQnp2S3dwcVZCU2dRTzYreFRXZEI4Mk9RQXpmeFdWdmQyZkF0Rkp2?=
 =?utf-8?B?YlpSMHU4aGxjTFVheE9Ccnc5cmZxYU1yNnNZUjZzSFpldGx3UDViVHFXMzVD?=
 =?utf-8?B?L3diNS8yYzFwdUtSN3k0MG5iVzhTNjV2OUFuV0FiNEcxb1hFOEp2d1pGMDhn?=
 =?utf-8?B?MktnbURrclU5M3NrRzhURHBMdTJtMmljZHpLbzZMcmhHMEVBU2w4eDZzbmM5?=
 =?utf-8?B?RVNPTHFoc2hZWmRFdi91Y2o0WmZ1c2tXdmZ4NmhBTDhIVnZpc2R6RzJBeGl4?=
 =?utf-8?B?RmM4d2h3OUsvVnAyRzB5U3Y0OCtQR1NGaFVGOXByRHVJTHNoOGtXU3J2Sm03?=
 =?utf-8?B?d0s1M3ZiSEgzajdlVForalpsNms5NWNMbFJ4RkVobm80R0srV2dXT2dTRnVK?=
 =?utf-8?B?NElzK3pDQTl1WFZhRjFOcnlET2lHaGdpaUtXc2tiWDBxeDErQlBaMmpZc1Fr?=
 =?utf-8?B?d3VFa2FFZzhzbmFFU0ZSNEppSE5SZlpBTGdxcVg3VXZlNTFoYy9zcEx2NE1T?=
 =?utf-8?B?SWxPUlNpNGRYd3ozOUVwVG14Y0pMbithU1VOT21aZmx1Uy9VWnZOZk1HODUz?=
 =?utf-8?B?clJjS1hSRUR5VzArTGVNT2xDZ1BkeW5TRHBVMldXcUxBZ1VNYUk4Qmk2ZGI2?=
 =?utf-8?B?MjhXQ3NTM0VWK2NNMlFFNGIwcU1xbFRsbFV6MUlvd0M3cGJsNEgwOU5JWWNa?=
 =?utf-8?B?c2hEREYyU3Q0NU5HN0V3SkxXUTM5ejdnSHpxQzNJSlM4S3hpcmZGSmhjNXlU?=
 =?utf-8?B?dmRsSFFycWlxV002Kys3cSt1NWdYbzF6VnFyeEw5R3VhVm5CWEFYNlR2bmxu?=
 =?utf-8?Q?5malZ+a5iVGp1wGTcj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0236a4-16b0-4177-f163-08deb726e5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 10:51:22.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fgbl59t6McbZaHyc1NX73BwXv3XurmWCvrZBqf7cTgVAQjFJw7qWEmGStd9hmc97UqU67q/nJo/z2CND1PqOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11169
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-253506-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AFE645A39EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTXVrZXNoIFNhdmFsaXlh
IDxtdWtlc2guc2F2YWxpeWFAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
eSAyMSwgMjAyNiA2OjE3IFBNDQo+IFRvOiBDYXJsb3MgU29uZyAoT1NTKSA8Y2FybG9zLnNvbmdA
b3NzLm54cC5jb20+OyBNdWtlc2ggU2F2YWxpeWENCj4gPG11a2VzaC5zYXZhbGl5YUBvc3MucXVh
bGNvbW0uY29tPjsgby5yZW1wZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgYW5kaS5zaHl0aUBrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgQ2FybG9zIFNv
bmcNCj4gPGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+IENjOiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gaTJjOiBpbXg6IG1hcmsgSTJDIGFkYXB0ZXIgd2hlbiBoYXJkd2FyZSBpcyBw
b3dlcmVkDQo+IGRvd24NCj4gDQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbXVr
ZXNoLnNhdmFsaXlhQG9zcy5xdWFsY29tbS5jb20uIExlYXJuDQo+IHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
PiANCj4gVGhhbmtzIENhcmxvcyAhDQo+IA0KPiBPbiA1LzIxLzIwMjYgMTo1NyBQTSwgQ2FybG9z
IFNvbmcgKE9TUykgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBNdWtlc2ggU2F2YWxpeWEgPG11a2VzaC5zYXZhbGl5YUBvc3MucXVh
bGNvbW0uY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWF5IDIxLCAyMDI2IDM6NDAgUE0NCj4g
Pj4gVG86IENhcmxvcyBTb25nIChPU1MpIDxjYXJsb3Muc29uZ0Bvc3MubnhwLmNvbT47DQo+ID4+
IG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4+IGFu
ZGkuc2h5dGlAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiA+PiBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IENhcmxvcyBTb25nDQo+
ID4+IDxjYXJsb3Muc29uZ0BueHAuY29tPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
Pg0KPiA+PiBDYzogbGludXgtaTJjQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRl
djsNCj4gPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGkyYzogaW14OiBtYXJrIEkyQyBhZGFwdGVyIHdoZW4gaGFy
ZHdhcmUgaXMNCj4gPj4gcG93ZXJlZCBkb3duDQo+ID4+DQo+ID4+IFtZb3UgZG9uJ3Qgb2Z0ZW4g
Z2V0IGVtYWlsIGZyb20gbXVrZXNoLnNhdmFsaXlhQG9zcy5xdWFsY29tbS5jb20uDQo+ID4+IExl
YXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiA+PiBodHRwczovL2FrYS5tcy9MZWFybkFi
b3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiA+Pg0KPiA+PiBIaSBDYXJsb3MsDQo+ID4+DQo+
ID4+IE9uIDUvMjAvMjAyNiAzOjQ1IFBNLCBDYXJsb3MgU29uZyAoT1NTKSB3cm90ZToNCj4gPj4+
IEZyb206IENhcmxvcyBTb25nIDxjYXJsb3Muc29uZ0BueHAuY29tPg0KPiA+Pj4NCj4gPj4+IE1h
cmsgdGhlIEkyQyBhZGFwdGVyIGFzIHN1c3BlbmRlZCBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgdG8g
YmxvY2sNCj4gPj4+IGZ1cnRoZXIgdHJhbnNmZXJzLCBhbmQgcmVzdW1lIGl0IG9uIHN5c3RlbSBy
ZXN1bWUuIFRoaXMgcHJldmVudHMNCj4gPj4+IHBvdGVudGlhbCBoYW5ncyB3aGVuIHRoZSBoYXJk
d2FyZSBpcyBwb3dlcmVkIGRvd24gYnV0IGNsaWVudHMgc3RpbGwNCj4gPj4+IGF0dGVtcHQNCj4g
Pj4gSTJDIHRyYW5zZmVycy4NCj4gPj4+DQo+IHdoYXQgd2FzIHRoZSByZWFzb24gb2YgdGhpcyBo
YW5nID8gSSB3YXMgdGhpbmtpbmcgeW91IGRvbid0IGhhdmUgaW50ZXJydXB0cw0KPiB3b3JraW5n
IHdoZW4gY2xpZW50IHJlcXVlc3RlZCB0cmFuc2ZlciBidXQgYWRhcHRlciB3YXMgc3VzcGVuZGVk
LiBQbGVhc2UNCj4gY29ycmVjdCBtZSBpZiB3cm9uZy4NCj4gDQo+IEFuZCBpdCB3b3VsZCBiZSBn
b29kIHRvIG1lbnRpb24gdGhlIGFjdHVhbCBwcm9ibGVtIGFuZCB3aHkvaG93IGl0IG9jY3VycmVk
Lg0KPiA+PiBDb2RlIGNoYW5nZXMgbG9va3MgZmluZSB0byBtZSBidXQgaGF2ZSBjb21tZW50IG9u
IGNvbW1pdCBsb2cuDQo+ID4+DQo+ID4+IEl0IHNlZW1zLCB5b3UgYXJlIGFkZGluZyBzdXBwb3J0
IG9mIF9ub2lycSgpIGNhbGxiYWNrcyB0byBhbGxvdw0KPiA+PiB0cmFuc2ZlcnMgZHVyaW5nIHN1
c3BlbmQvcmVzdW1lIG5vaXJxIHBoYXNlIG9mIFBNLg0KPiA+Pg0KPiA+PiBXb3VsZCBpdCBtYWtl
IHNlbnNlIGlmIHlvdSBjYW4gd3JpdGUgIlJlcGxhY2Ugc3lzdGVtIFBNIGNhbGxiYWNrcw0KPiA+
PiB3aXRoIG5vaXJxIFBNIGNhbGxiYWNrcyIgT1IgIkFsbG93IHRyYW5zZmVycyBkdXJpbmcgX25v
aXJxIHBoYXNlIG9mDQo+ID4+IHRoZSBQTSBvcHMiIGluc3RlYWQgb2YgIm1hcmsgSTJDIGFkYXB0
ZXIgd2hlbiBoYXJkd2FyZSBpcyBwb3dlcmVkDQo+IGRvd24iID8NCj4gPj4NCj4gPg0KPiA+IEhp
LA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzIQ0KPiA+DQo+ID4gQnV0IHRo
aXMgcGF0Y2ggaXMgYWRkZWQgaXMgbm90IGZvciBzdXBwb3J0IG5vaXJxIFBNIGNhbGxiYWNrIG9y
IHRyYW5zZmVyIGluIG5vaXJxDQo+IHBoYXNlLg0KPiA+DQo+IE9rYXksIG1heSBiZSBhY3R1YWwg
cHJvYmxlbSBkZXNjcmlwdGlvbiBjYW4gaGVscCBtZS4NCj4gPiBJbiBmYWN0LCB0aGlzIGZpeCBp
cyB0byBtYXJrIHRoZSBJMkMgYWRhcHRlciBhcyBzdXNwZW5kZWQgZHVyaW5nDQo+ID4gc3lzdGVt
IG5vaXJxIHN1c3BlbmQgdG8gYmxvY2sgZnVydGhlciB0cmFuc2ZlcnMsIGFuZCByZXN1bWUgaXQg
b24NCj4gPiBzeXN0ZW0gbm9pcnEgcmVzdW1lLiBUaGlzIGlzIHRvIHByb2hpYml0IEkyQyBkZXZp
Y2UgY2FsbGluZyB0aGUgSTJDDQo+ID4gY29udHJvbGxlciBhZnRlciB0aGUgc3lzdGVtIG5vaXJx
IHN1c3BlbmQgYW5kIGJlZm9yZSBub2lycSByZXN1bWUsIGJlY2F1c2UgYXQNCj4gdGhpcyB0aW1l
IHRoZSBJMkMgaW5zdGFuY2UgaXMgcG93ZXJlZCBvZmYgb3IgdGhlIGNsb2NrIGlzIGRpc2FibGVk
IC4uLiBTbyBJIHdhbnQgdG8NCj4ga2VlcCBjdXJyZW50IGNvbW1pdC4gSG93IGRvIHlvdSB0aGlu
az8NCj4gY29tcGxldGVseSBNYWtlcyBzZW5zZS4gUGxlYXNlIGhlbHAgYWRkIGhvdyB0aGlzIHBy
b2JsZW0gb2NjdXJyZWQgYW5kIHdoeSA/DQo+IFNvIHRoZSBjaGFuZ2UvZml4IHdpbGwgYmUgZ29v
ZCB0byB1bmRlcnN0YW5kIGFnYWluc3QgaXQuDQoNCkhpLA0KDQpJbiBzb21lIEkuTVggcGxhdGZv
cm0sIHNvbWUgSTJDIGRldmljZXMgd2lsbCBrZWVwIGEgd29yayBxdWV1ZSBhbGwgdGltZSwgdGhl
IHdvcmsgcXVldWUgd2lsbA0KdHJpZ2dlciBJMkMgeGZlciBldmVyeSBvbmNlIGluIGEgd2hpbGUs
IGJ1dCB0aGUgd29yayBxdWV1ZSBzaG91bGRuJ3QgYmUgZnJlZSBpbiBzeXN0ZW0gc3VzcGVuZC4N
Cg0KV2l0aGluIGEgdmVyeSBzaG9ydCB0aW1lIHdpbmRvdywgcG9zc2libHkgZnJvbSBub2lycV9z
dXNwZW5kIHRvIHRoZSBzeXN0ZW0gYWN0dWFsbHkgYmVpbmcgc3VzcGVuZGVkLA0Kb3IgcG9zc2li
bHkgZnJvbSB0aGUgc3lzdGVtIHN0YXJ0aW5nIHRvIHJlc3VtZSB0byBiZWZvcmUgbm9pcnFfcmVz
dW1lLCB0aGlzIHdvcmsgcXVldWUgd2lsbCB0cmlnZ2VyIGFuDQpJMkMgdHJhbnNmZXIsIGFuZCBh
dCB0aGlzIHRpbWUgdGhlIEkyQyBjb250cm9sbGVyJ3MgY2xrIGFuZCBwaW5jdHJsIGhhdmUgbm90
IHlldCBiZWVuIHJlc3RvcmVkLCByZWFkaW5nIGFuZA0Kd3JpdGluZyBJMkMgcmVnaXN0ZXJzIGNh
dXNlcyB0aGUgc3lzdGVtIHRvIGhhbmcuIFRoaXMgcGF0Y2ggbWFrZSBhbGwgSTJDIG9wZXJhdGlv
bnMgYXJlIHBlcmZvcm1lZCBpbiBhIHNhZmUNCmhhcmR3YXJlIHN0YXRlLg0KDQpJcyBpdCBiZXR0
ZXIgaWYgSSBhZGQgdGhlc2UgY29tbWVudCB0byBwYXRjaCBjb21taXQgbG9nPyANCj4gPg0KPiA+
IENhcmxvcyBTb25nDQo+IA0KDQo=

