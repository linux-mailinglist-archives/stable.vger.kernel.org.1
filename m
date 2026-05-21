Return-Path: <stable+bounces-253513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNt/Lc/0DmriDgYAu9opvQ
	(envelope-from <stable+bounces-253513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:04:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5F5A47A3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7C33077C04
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71784360EDA;
	Thu, 21 May 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YPIQa+mc"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F53C5857;
	Thu, 21 May 2026 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364948; cv=fail; b=Bptmqo8Hhwwwdke1OTEtjoJgYMcC4ZnyfaaqOlen8hJZ57zFyGUHBWbTE+91Hzmkgly/29yr5k0g/6FP8DAF7cAMufRmEmGoA68So+hkpbKjgecygJlxDU4IvXD2bCqm2DuUgUR62/S6fWi7BwdXx6iUITxo1+dhWhiALxQmpZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364948; c=relaxed/simple;
	bh=zt/tuj2O7i0NwDCD4C4Db26KslG49VIzIQ1vuvqOMrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=saOfii5/Zjb1Nra1LkZP5xLQZDg1UeU7cAIRZQHh4UN1oLNVHFY9aXfeh2MBtekgX3FQLgqbvxGvC36NqBz4AFAoy6WtWIRg7nJkNPaYGyIOSytz00pzudYX3hpKkBA7yqxWgAOLHb51r90wb4nAEQpVOu45KTuBZcc7qu5Dyno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YPIQa+mc; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0Pyg5m/c+8aGajV1k4c4kw1DJcjoMTr04VYWdqa1mH5sy2C6XiXhkJ0aplQODfNbCkXdiHqrQXIhQ/vD0JeEHJ0QP8NHesm4tYXV2l0F9W0617XmCXWFzOhR5wpjxiIxn/dH9e+HaOWDx11ujhiyWeGsuxxulLodllMVjazJ1RuIIfbsr+ls96yWl6J2C3t5V8Wl3l6YMQG6QKaPzfpy4wY7quSRsEt5zze7vv4rTU3SRgcqApAG99kAM7SXaw+qLJtePRAGWIjJHSzImYRmSDgiCr5mS/7igLg13owHEhs88R8g+2UqP+JjudmPZWB3ZsctOUnneVyFNcyMkOy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt/tuj2O7i0NwDCD4C4Db26KslG49VIzIQ1vuvqOMrc=;
 b=eszNZtP9zi/Dc60rf6quh03dcF84JZovBnwwlP7bBZVJqE6tCrjPkfZT41HUyf5o6B/LbFgtPXwsoJiydirEloRYmyQXH7OIEV9S+CtNz8TTcQNQaz/TVEj9pxxrYu+uuNjZ0Yh/mJaYIsESm6HuhqumLY20CEZSft3rvjsD4Y5M4by9ulon2JE34YCI13zR58c/0DsakS/YSHlYGAIG8LdInqvpl79C8kuQF9sGk9/j3bVVCVI2XBiIrloPYNlqTYs6qE9MS0KTzPPyM+Cddv2eotypdSbe3r2SWmi421SjpKpJjUe4biWjf85mz3wzylI6EyRkap5S64Xg1cuMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt/tuj2O7i0NwDCD4C4Db26KslG49VIzIQ1vuvqOMrc=;
 b=YPIQa+mccY7Up1d2BoO6rbIO7Gl/qIkFYjtyevMFotZ8hW6n6V2z1UfqRyYt8/egDLk4qcmNGjyjEU0tNoBv9+fJjlIzbU17IVhXq21v8QkhM4kUphKJTduVpDetou4C0m1OHC2139zDOMTiYS0F/JE0nEIDAzG+V6xDOofhGQe48HIM0A1dHAD8Ia/qn21H803ZUqQ5pNTFvhDOHRQ8Pz0MGqTsO9dATp83h2lCEDxNYN/mqhiBTkAW/4JFzILfbXvEyeBlhOyC/3PA127i7DG2+jn2CUIlxwpLX8nM6XmXEsyrth1IowmQ6adR/4YXgDIY76ZqZNXUGEOD2J9Msw==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by GVXPR04MB11543.eurprd04.prod.outlook.com (2603:10a6:150:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:02:20 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:02:20 +0000
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
Thread-Index: AQHc6RmteNO9/PVcNEWrLF8S7MlL6Q==
Date: Thu, 21 May 2026 12:02:20 +0000
Message-ID:
 <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
In-Reply-To: <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|GVXPR04MB11543:EE_
x-ms-office365-filtering-correlation-id: 4dbebf25-efd5-49ac-6608-08deb730cfbf
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|11063799006|56012099003|18002099003|22082099003|4143699003|6133799003|38070700021|921020;
x-microsoft-antispam-message-info:
 Opk/FYdqWFR9dlsYbr6OkPub3+5SAZK379CKJZQ+i8YknHfwY8tp1+6/w6hC5EPF2Zxjf+wu/qZEtWxTKzkOEuTdyTraNsMLun2b8vlwQdboU/+bA+xF67J0TGuh+hxGvpdAqE8jCoaukQ/bBvwVR6Bz2UseepbudZUem6kPG4Qv9Gf+wh3JeimMAn9LWb+exayG6ye50uutv4j1iGFojxRxczaBjj7Eo86Zq0CS6BRV7XAxvfGZQ4FoJmoHPGNOIqw9GcBqCdX6xQJ2xA9SL3pxR02xLpTcr+RCpkmUUcH5BmudW3ZdvlByzkvF5xAeyw7c36Gs9ESo85Ea0IK/k72KnEhU7gmjftjWMx+S/TlYlscTZ++4WOXomQ2QTS0rN11JESAiJ4GNlGWjqW9n3c8QAn0v8ipRlO4L+jIlByuLB2gla8IOVH1rVhbXEPigzsIPUe+/CJleme+c/oF9XtFQCTc+Md4Oie16Ud7oWqC/euuj5y1BTkKD6cEdy7HKSY2KBJ7Rj2CAXLFVOXvb4DheftXJjxLOUhuAiyh5xQNLWBW+7c2Oqsw2DYLrkSTeURl44i6OLoyvVD7WquNxgax41LX/+5KZ5Ic8r3ejHH0pc7lUj8Kj3n5Uyw4dFqqHqgbdj258yGKsMrmH6zVe3zW9vaHb9Ev61Mbo9EgfmAiMvJkRf3OK2mZet0KSerfcyH+Vas5WACPih6thVymIIhG2xF271jkgwpo2fgIYjDGPnaXj1IrTI+0Y68YnzlaRDRCy7ipG2Wghi26u+tiQSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTFZYkJMNk5FMTZkc0NCOHYzUWxoVTlTbVBGVjBZS0VjNjdSM0RsSVhZWENx?=
 =?utf-8?B?Q2xET2pTdE5PMGRBbVMyUW0ySkpxMGxHYzMvbVFlL1RlRlNFdEVuV09uUVlG?=
 =?utf-8?B?aHFhSXc3UjBTVVl6SVcyUElvQlNieEl0SUt5bjJSVmVhQXBkYWd6citLamtq?=
 =?utf-8?B?U0drWFM3MlN3NEJGenJoMm9QTTVOTTNJUHZCT2RKQ21IVU5lNjd2VHRHT0hR?=
 =?utf-8?B?VElhVzdoQmNqdHplUGM4VUkzbko4Q3phbGRUQnFMNGJOUWdIMzNOdE1OWkIz?=
 =?utf-8?B?elVKU1U3YVhjTzYwS25DSFdsckZJRzllbTRSaFNOZXpMUldjaWs3SEY2WlVO?=
 =?utf-8?B?R040ZE9XK2dCMjg5dW9Gd09JR3RiSFBRb0h0U2d2VFdFQWFpRm9vc3paOCsy?=
 =?utf-8?B?clBrbTJzUk5qOTlyRVNXTllFR21aVmxPNnY1SkNXanJEMFpnNlFPcFZvYzVS?=
 =?utf-8?B?TWgrYVVsQ0FYVG9tSmFQZWVhaExDZ3VndkZqRXBBRFIvVEdXUVQxNHdVTW8z?=
 =?utf-8?B?KzB5dkFPMDVaYU84RXhnb2J2ODRsQVFtNWYyeTZaN3N3SlV3bnlmdjM0MW9F?=
 =?utf-8?B?M0dVZHFsakZKcUxPZGhSeEN2N2NERkNscGM3M25pQ0U3OHJHTlF3VElIbmo4?=
 =?utf-8?B?NkdQV25VNjhWalhMbzFtNFA4ZEQ4eU9lQThlVFNKUk1vUS9KbE5KOTdMc2M0?=
 =?utf-8?B?NmJrZ21vYm1qNXd4S1kvclVnQlVJRmFmV0E1dFFMSDRCRHJSTmkwY1BUMlRQ?=
 =?utf-8?B?bHltaUVQQjY2WnNONVhFV0N6QzVSR2JFZTBva2RBTFFEOUpkVHZFdnJjZDBK?=
 =?utf-8?B?L1JlSFdoTnptcVNscFc2cUZuTlUybC93MHJ1QlU4U3FzbzFQellVR3NuK2tP?=
 =?utf-8?B?VU1PN0RLZ2hBQW9sZlJla1NEbEVFZDFNNVRqWkh3c084YmswUFJFamJnUVVm?=
 =?utf-8?B?bFNQZXVtRm42MkNqeXVOanc2TFowTXdHUVpKOUQ1bDF6bVBrRTl3MXFqSkdh?=
 =?utf-8?B?RDlpdW9jWTBxbENEQ21sQ0tzSnRpVTFLTFJ5U3B0djladVN0dUFFdEd1SEE4?=
 =?utf-8?B?Yzd0ZGE2dWdPKzVjQSsweXBsZzhBcC9mUGZ1RjBxMUw2NlYzZ1hwNlFlTEh4?=
 =?utf-8?B?dmQvMHdGa2pRZ05yblpEK0FxQlNSZzMrK0RmaXl4R2Nwb0xYNlhwRWliQUw2?=
 =?utf-8?B?aVFuNHR6YW5mUGJCcmZ4NEpsaUdNZkdkZTByUDIwUG44OVpFeklaVjJ0c1Bp?=
 =?utf-8?B?TE1ocTFWU0JMZjRMaDZXUnBnenZ6Q1JuQmlDaTVsTExON0tUdzJJS0lPaDJ5?=
 =?utf-8?B?RG8zcGxETDdYRFRTYUh6Skg4dm5FU29mME0yQzZNS095TXVGZm5nQlZqOHlo?=
 =?utf-8?B?UGpnbm5mOGVFUzQ2N1IxaGxRTHNXUjVGSnhRajBuYmxmRHBHTUVpVm5hRVNG?=
 =?utf-8?B?aytJNHdNMnZRd1pMRmpCZ0pGdlQ5V1kvOWF6R1dnYUNxTi9HNmxNUXpsNXA1?=
 =?utf-8?B?RS93UXkzV3U1UEZnZWFWUkZyeFIxS0ppRlRmTDhkRW5LTE9mUHVWWEJGN3BT?=
 =?utf-8?B?QVNjd0pqRnpZVnpWVFVUT2haOHUxSjhhMTl1eG5FalV2VkkwL3FHSFc5RW9r?=
 =?utf-8?B?eVdnTWJsWmE1MG9JRFhKUVBHa2gvL2kvSkNmYStPWFdtbEZPUHRJTytkeTE3?=
 =?utf-8?B?WDJIVHpiVmU3bmdsdzFIVG5XeENGdmJ5MHNoYUhHTlFsMXkwL01kYWg5YkFK?=
 =?utf-8?B?OHhSbUFDZ3JESGEyRWkwZ08zMkxkOTFTZHpZYU1sNnMxN2Y4bzdPWS9OR3N5?=
 =?utf-8?B?N3g2bGdXRnFEU21iWDNOa0ZCRnJibURZb1JjN21LMXpyZlpLTkcvOXZvMDBM?=
 =?utf-8?B?SUNrK1dBMjFMVVdrM01wV0NrZzhxK1VkcEM4NU9QL29pRHlXZDJER1dncWVs?=
 =?utf-8?B?anUrd0poMG1TRlVEU25aN1J2UUEySVArZDIwZ3BnVC9qNXpZNzRnL1hvUTRR?=
 =?utf-8?B?MmMvMEF5WXQ5RnpXY1JmbkEzM3QrN1JNcHhPeWJFb2NoRkZZeDZjNjFDZGZY?=
 =?utf-8?B?dkFNNS9tTHNYQVNCd0szRHBpaWlQa3lJUTdaV1ZUVm1jWjFOU0o4MzBmZUZx?=
 =?utf-8?B?U1huQ0JocHgvT29JNE9nYXExU3ZldjFpZDJTcHlIRGNEL2NxL2dPNTN0dlgv?=
 =?utf-8?B?Nk94cDhDaERiQndxWlRFeDFPcFUzTHVRaFRzaWVrbmpncjQwVnJkU3ZjMkJz?=
 =?utf-8?B?ZnliTWdiSm0xWWcvZlQrMlIrYUJEaGtTd1lkTjFhalFWZjVKelZuYXpRVUhL?=
 =?utf-8?Q?ZaJBlACebWxuUc10uI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbebf25-efd5-49ac-6608-08deb730cfbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 12:02:20.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8v3QvtdxyV57kyumTEUVSqh800FtbbSE3o76ksfxoZDp9pYzkEl265s05cMyTXj1KH85cqq5CpiB1eorfs4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11543
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253513-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BB5F5A47A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTXVrZXNoIFNhdmFsaXlh
IDxtdWtlc2guc2F2YWxpeWFAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
eSAyMSwgMjAyNiA3OjE0IFBNDQo+IFRvOiBDYXJsb3MgU29uZyAoT1NTKSA8Y2FybG9zLnNvbmdA
b3NzLm54cC5jb20+OyBNdWtlc2ggU2F2YWxpeWENCj4gPG11a2VzaC5zYXZhbGl5YUBvc3MucXVh
bGNvbW0uY29tPjsgby5yZW1wZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgYW5kaS5zaHl0aUBrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgQ2FybG9zIFNv
bmcNCj4gPGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+IENjOiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gaTJjOiBpbXg6IG1hcmsgSTJDIGFkYXB0ZXIgd2hlbiBoYXJkd2FyZSBpcyBw
b3dlcmVkDQo+IGRvd24NCj4gDQo+IA0KPiBPbiA1LzIxLzIwMjYgNDoyMSBQTSwgQ2FybG9zIFNv
bmcgKE9TUykgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IE11a2VzaCBTYXZhbGl5YSA8bXVrZXNoLnNhdmFsaXlh
QG9zcy5xdWFsY29tbS5jb20+DQo+ID4+Pj4gU2VudDogVGh1cnNkYXksIE1heSAyMSwgMjAyNiAz
OjQwIFBNDQo+ID4+Pj4gVG86IENhcmxvcyBTb25nIChPU1MpIDxjYXJsb3Muc29uZ0Bvc3Mubnhw
LmNvbT47DQo+ID4+Pj4gby5yZW1wZWxAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gPj4+PiBhbmRpLnNoeXRpQGtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsNCj4gPj4+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207IENhcmxvcyBTb25nDQo+ID4+Pj4gPGNhcmxvcy5zb25nQG54cC5jb20+OyBCb3VnaCBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4+Pj4gQ2M6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+Pj4+IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBpMmM6IGlt
eDogbWFyayBJMkMgYWRhcHRlciB3aGVuIGhhcmR3YXJlIGlzDQo+ID4+Pj4gcG93ZXJlZCBkb3du
DQo+ID4+Pj4NCj4gPj4+PiBIaSBDYXJsb3MsDQo+ID4+Pj4NCj4gPj4+PiBPbiA1LzIwLzIwMjYg
Mzo0NSBQTSwgQ2FybG9zIFNvbmcgKE9TUykgd3JvdGU6DQo+ID4+Pj4+IEZyb206IENhcmxvcyBT
b25nIDxjYXJsb3Muc29uZ0BueHAuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBNYXJrIHRoZSBJMkMg
YWRhcHRlciBhcyBzdXNwZW5kZWQgZHVyaW5nIHN5c3RlbSBzdXNwZW5kIHRvIGJsb2NrDQo+ID4+
Pj4+IGZ1cnRoZXIgdHJhbnNmZXJzLCBhbmQgcmVzdW1lIGl0IG9uIHN5c3RlbSByZXN1bWUuIFRo
aXMgcHJldmVudHMNCj4gPj4+Pj4gcG90ZW50aWFsIGhhbmdzIHdoZW4gdGhlIGhhcmR3YXJlIGlz
IHBvd2VyZWQgZG93biBidXQgY2xpZW50cw0KPiA+Pj4+PiBzdGlsbCBhdHRlbXB0DQo+ID4+Pj4g
STJDIHRyYW5zZmVycy4NCj4gPj4+Pj4NCj4gPj4gd2hhdCB3YXMgdGhlIHJlYXNvbiBvZiB0aGlz
IGhhbmcgPyBJIHdhcyB0aGlua2luZyB5b3UgZG9uJ3QgaGF2ZQ0KPiA+PiBpbnRlcnJ1cHRzIHdv
cmtpbmcgd2hlbiBjbGllbnQgcmVxdWVzdGVkIHRyYW5zZmVyIGJ1dCBhZGFwdGVyIHdhcw0KPiA+
PiBzdXNwZW5kZWQuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIHdyb25nLg0KPiA+Pg0KPiA+PiBBbmQg
aXQgd291bGQgYmUgZ29vZCB0byBtZW50aW9uIHRoZSBhY3R1YWwgcHJvYmxlbSBhbmQgd2h5L2hv
dyBpdA0KPiBvY2N1cnJlZC4NCj4gPj4+PiBDb2RlIGNoYW5nZXMgbG9va3MgZmluZSB0byBtZSBi
dXQgaGF2ZSBjb21tZW50IG9uIGNvbW1pdCBsb2cuDQo+ID4+Pj4NCj4gPj4+PiBJdCBzZWVtcywg
eW91IGFyZSBhZGRpbmcgc3VwcG9ydCBvZiBfbm9pcnEoKSBjYWxsYmFja3MgdG8gYWxsb3cNCj4g
Pj4+PiB0cmFuc2ZlcnMgZHVyaW5nIHN1c3BlbmQvcmVzdW1lIG5vaXJxIHBoYXNlIG9mIFBNLg0K
PiA+Pj4+DQo+ID4+Pj4gV291bGQgaXQgbWFrZSBzZW5zZSBpZiB5b3UgY2FuIHdyaXRlICJSZXBs
YWNlIHN5c3RlbSBQTSBjYWxsYmFja3MNCj4gPj4+PiB3aXRoIG5vaXJxIFBNIGNhbGxiYWNrcyIg
T1IgIkFsbG93IHRyYW5zZmVycyBkdXJpbmcgX25vaXJxIHBoYXNlIG9mDQo+ID4+Pj4gdGhlIFBN
IG9wcyIgaW5zdGVhZCBvZiAibWFyayBJMkMgYWRhcHRlciB3aGVuIGhhcmR3YXJlIGlzIHBvd2Vy
ZWQNCj4gPj4gZG93biIgPw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSGksDQo+ID4+Pg0KPiA+Pj4g
VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzIQ0KPiA+Pj4NCj4gPj4+IEJ1dCB0aGlzIHBhdGNo
IGlzIGFkZGVkIGlzIG5vdCBmb3Igc3VwcG9ydCBub2lycSBQTSBjYWxsYmFjayBvcg0KPiA+Pj4g
dHJhbnNmZXIgaW4gbm9pcnENCj4gPj4gcGhhc2UuDQo+ID4+Pg0KPiA+PiBPa2F5LCBtYXkgYmUg
YWN0dWFsIHByb2JsZW0gZGVzY3JpcHRpb24gY2FuIGhlbHAgbWUuDQo+ID4+PiBJbiBmYWN0LCB0
aGlzIGZpeCBpcyB0byBtYXJrIHRoZSBJMkMgYWRhcHRlciBhcyBzdXNwZW5kZWQgZHVyaW5nDQo+
ID4+PiBzeXN0ZW0gbm9pcnEgc3VzcGVuZCB0byBibG9jayBmdXJ0aGVyIHRyYW5zZmVycywgYW5k
IHJlc3VtZSBpdCBvbg0KPiA+Pj4gc3lzdGVtIG5vaXJxIHJlc3VtZS4gVGhpcyBpcyB0byBwcm9o
aWJpdCBJMkMgZGV2aWNlIGNhbGxpbmcgdGhlIEkyQw0KPiA+Pj4gY29udHJvbGxlciBhZnRlciB0
aGUgc3lzdGVtIG5vaXJxIHN1c3BlbmQgYW5kIGJlZm9yZSBub2lycSByZXN1bWUsDQo+ID4+PiBi
ZWNhdXNlIGF0DQo+ID4+IHRoaXMgdGltZSB0aGUgSTJDIGluc3RhbmNlIGlzIHBvd2VyZWQgb2Zm
IG9yIHRoZSBjbG9jayBpcyBkaXNhYmxlZA0KPiA+PiAuLi4gU28gSSB3YW50IHRvIGtlZXAgY3Vy
cmVudCBjb21taXQuIEhvdyBkbyB5b3UgdGhpbms/DQo+ID4+IGNvbXBsZXRlbHkgTWFrZXMgc2Vu
c2UuIFBsZWFzZSBoZWxwIGFkZCBob3cgdGhpcyBwcm9ibGVtIG9jY3VycmVkIGFuZA0KPiB3aHkg
Pw0KPiA+PiBTbyB0aGUgY2hhbmdlL2ZpeCB3aWxsIGJlIGdvb2QgdG8gdW5kZXJzdGFuZCBhZ2Fp
bnN0IGl0Lg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBJbiBzb21lIEkuTVggcGxhdGZvcm0sIHNv
bWUgSTJDIGRldmljZXMgd2lsbCBrZWVwIGEgd29yayBxdWV1ZSBhbGwNCj4gPiB0aW1lLCB0aGUg
d29yayBxdWV1ZSB3aWxsIHRyaWdnZXIgSTJDIHhmZXIgZXZlcnkgb25jZSBpbiBhIHdoaWxlLCBi
dXQgdGhlIHdvcmsNCj4gcXVldWUgc2hvdWxkbid0IGJlIGZyZWUgaW4gc3lzdGVtIHN1c3BlbmQu
DQo+ID4NCj4gDQo+IHdvcmsgcXVldWUgaGFzIHRyYW5zZmVycyBxdWV1ZWQgZXZlbiBpZiBzeXN0
ZW0gaXMgc3VzcGVuZGVkID8gSU1PLCB0aGUgY2xpZW50DQo+IGkyYyBkZXZpY2VzIHNob3VsZCBu
b3QgbGV0IHN5c3RlbSBnbyB0byBzdXNwZW5kLg0KPiANCg0KSGkgTXVrZXNoLA0KDQpUaGFuayB5
b3UgZm9yIHRoZSBkZXRhaWxlZCBkaXNjdXNzaW9uLg0KDQpZZXMsIEkgdG90YWxseSBhZ3JlZSB0
aGF0IEkyQyBjbGllbnQgZHJpdmVycyBzaG91bGQgaWRlYWxseSBzdG9wDQppc3N1aW5nIHRyYW5z
ZmVycyB3aGVuIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGluZy4NCg0KSG93ZXZlciwgaW4gcHJhY3Rp
Y2UgdGhlcmUgYXJlIG1hbnkgZGlmZmVyZW50IEkyQyBjbGllbnRzLCBhbmQgbm90IGFsbA0Kb2Yg
dGhlbSBzdHJpY3RseSBhZGhlcmUgdG8gdGhpcyByZXF1aXJlbWVudC4gU29tZSBjbGllbnRzIG1h
eSBzdGlsbA0KdHJpZ2dlciB0cmFuc2ZlcnMgdGhyb3VnaCB3b3JrcXVldWVzIG9yIGRlZmVycmVk
IGNvbnRleHRzIGR1cmluZyB0aGUNCnN1c3BlbmQvcmVzdW1lIHdpbmRvdy4NCg0KVGhlcmVmb3Jl
LCBhZGRpbmcgdGhpcyBwcm90ZWN0aW9uIGF0IHRoZSBJMkMgY29udHJvbGxlciBzaWRlIGhlbHBz
IHRvDQphdm9pZCB1bmV4cGVjdGVkIGFjY2Vzc2VzIHdoZW4gdGhlIGhhcmR3YXJlIHJlc291cmNl
cyBhcmUgdW5hdmFpbGFibGUsDQptYWtpbmcgdGhlIHN5c3RlbSBtb3JlIHJvYnVzdC4NCg0KPiA+
IFdpdGhpbiBhIHZlcnkgc2hvcnQgdGltZSB3aW5kb3csIHBvc3NpYmx5IGZyb20gbm9pcnFfc3Vz
cGVuZCB0byB0aGUNCj4gPiBzeXN0ZW0gYWN0dWFsbHkgYmVpbmcgc3VzcGVuZGVkLCBvciBwb3Nz
aWJseSBmcm9tIHRoZSBzeXN0ZW0gc3RhcnRpbmcNCj4gPiB0byByZXN1bWUgdG8gYmVmb3JlIG5v
aXJxX3Jlc3VtZSwgdGhpcyB3b3JrIHF1ZXVlIHdpbGwgdHJpZ2dlciBhbiBJMkMNCj4gPiB0cmFu
c2ZlciwgYW5kIGF0IHRoaXMgdGltZSB0aGUgSTJDIGNvbnRyb2xsZXIncyBjbGsgYW5kIHBpbmN0
cmwgaGF2ZQ0KPiA+IG5vdCB5ZXQgYmVlbiByZXN0b3JlZCwgcmVhZGluZyBhbmQNCj4gDQo+IFJp
Z2h0LCB0aGlzIGtpbmQgb2YgZXhwbGFpbnMgdGhlIHByb2JsZW0gdG8gbWUuIEkgdGhpbmsgeW91
IGFyZSB0cnlpbmcgdG8gc2VydmUNCj4gaTJjIHRyYW5zZmVycyB3aGVuIHlvdXIgcmVzb3VyY2Vz
KGNsaywgcGluY3RybCkgYXJlIG5vdCB0dXJuZWQgT04gYW5kIGFsc28NCj4gaW50ZXJydXB0IHJl
bWFpbnMgZGlzYWJsZWQuIEFuZCB0aGF0J3Mgd2h5IHlvdSBuZWVkIHRvIGFkZA0KPiBfbm9pcigp
IFBNIGNhbGxiYWNrcyBzdXBwb3J0cyBhbG9uZyB3aXRoIElSUUZfTk9fU1VTUEVORCB8DQo+IElS
UUZfRUFSTFlfUkVTVU1FIGZsYWdzLg0KPiANCj4gPiB3cml0aW5nIEkyQyByZWdpc3RlcnMgY2F1
c2VzIHRoZSBzeXN0ZW0gdG8gaGFuZy4gVGhpcyBwYXRjaCBtYWtlIGFsbA0KPiA+IEkyQyBvcGVy
YXRpb25zIGFyZSBwZXJmb3JtZWQgaW4gYSBzYWZlIGhhcmR3YXJlIHN0YXRlLg0KPiA+DQo+ID4g
SXMgaXQgYmV0dGVyIGlmIEkgYWRkIHRoZXNlIGNvbW1lbnQgdG8gcGF0Y2ggY29tbWl0IGxvZz8N
Cj4gPj4+DQo+IGlmIG15IGxhdGVzdCBjb21tZW50cyBtYWtlcyBzZW5zZSBhZ2FpbnN0IHRoZSBp
c3N1ZSwgeW91IG1heSB3cml0ZQ0KPiBhY2NvcmRpbmdseS4gaWYgaSBhbSB3cm9uZywgdGhlbiB5
b3VyIGV4cGxhbmF0aW9uIG1ha2VzIHNlbnNlLiBDYXVzZSBvZiB0aGUNCj4gaGFuZyBuZWVkcyB0
byBiZSBjbGVhcmx5IG1lbnRpb24gaW50IHRoZSBjb21taXQgbG9nIGluIHlvdXIgbmV4dCBwYXRj
aC4NCj4gDQoNCkJhc2VkIG9uIG91ciBkaXNjdXNzaW9uLCBJIGhhdmUgdXBkYXRlZCB0aGUgY29t
bWl0IGxvZyBhcyBiZWxvdzoNCg0KT24gc29tZSBpLk1YIHBsYXRmb3JtcywgY2VydGFpbiBJMkMg
Y2xpZW50IGRyaXZlcnMga2VlcCBhIHBlcmlvZGljDQp3b3JrcXVldWUgd2hpY2ggY29udGludWVz
IHRvIHRyaWdnZXIgSTJDIHRyYW5zZmVycy4NCg0KRHVyaW5nIHN5c3RlbSBzdXNwZW5kL3Jlc3Vt
ZSwgdGhlcmUgZXhpc3RzIGEgdGltZSB3aW5kb3cgYmV0d2VlbjoNCiAgLSBub2lycV9zdXNwZW5k
IGFuZCBmdWxsIHN1c3BlbmQNCiAgLSByZXN1bWUgc3RhcnQgYW5kIG5vaXJxX3Jlc3VtZQ0KDQpJ
biB0aGlzIHdpbmRvdywgdGhlIEkyQyBjb250cm9sbGVyIHJlc291cmNlcyBzdWNoIGFzIGNsb2Nr
IGFuZCBwaW5jdHJsDQptYXkgYWxyZWFkeSBiZSBkaXNhYmxlZCBvciBub3QgeWV0IHJlc3RvcmVk
Lg0KDQpJZiBhIHdvcmtxdWV1ZSB0cmlnZ2VycyBhbiBJMkMgdHJhbnNmZXIgaW4gdGhpcyBwZXJp
b2QsIHRoZSBkcml2ZXINCmF0dGVtcHRzIHRvIGFjY2VzcyBJMkMgcmVnaXN0ZXJzIHdoaWxlIHRo
ZSBoYXJkd2FyZSByZXNvdXJjZXMgYXJlDQp1bmF2YWlsYWJsZSwgd2hpY2ggbWF5IGxlYWQgdG8g
c3lzdGVtIGhhbmcuDQoNCk1hcmsgdGhlIEkyQyBhZGFwdGVyIGFzIHN1c3BlbmRlZCBkdXJpbmcg
bm9pcnEgc3VzcGVuZCBhbmQgYmxvY2sgbmV3DQp0cmFuc2ZlcnMgdW50aWwgcmVzdW1lLCBlbnN1
cmluZyB0aGF0IEkyQyB0cmFuc2ZlcnMgYXJlIG9ubHkgaXNzdWVkDQp3aGVuIGhhcmR3YXJlIHJl
c291cmNlcyBhcmUgYXZhaWxhYmxlLg0KDQpEb2VzIHRoaXMgbG9vayBnb29kIHRvIHlvdT8NCg0K
PiA+Pg0KPiA+DQoNCg==

