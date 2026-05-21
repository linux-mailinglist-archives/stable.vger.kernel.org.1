Return-Path: <stable+bounces-253471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBk1ITTDDmrXBwYAu9opvQ
	(envelope-from <stable+bounces-253471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3105A1171
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CAA73082106
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6C357CF1;
	Thu, 21 May 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kq4CNm0Q"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00535B137;
	Thu, 21 May 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352044; cv=fail; b=htspWh2z563/E0rgh3ZGMkvw5qS6Zr+E40Kssx72zp/MIhv9fLMs6ANraaHVUCdHp2BFfqIgDuE6zByY6QGZTBYnwhzCUV7dsJAw/cxVnfnoEouPUOa4ILicz6cCt661LMOaktwrNVGpDG6QdiXJNoiddNKApN+GARaN2mq8nzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352044; c=relaxed/simple;
	bh=IxWSy2gEh02nWzJahH1rkl0m3GIL5arRuACxUVtqHeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bYOgXJ3ClQOXV/F9i5Ukgb5J4Fp6revsnjL6DT920GN4HcV6wUMqCZSa6xOIEqZxpB+C4RboHtRDia0BJdaGfg5oI9/oqFjaCX4GcsyxlT+rQV/Jfqsjr+LzJuGTYFVX2rPaoK8uSIfmr6rKyDTO8Q6LQKoMqwbIhyKAxQ4oCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kq4CNm0Q; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfJB91FtDePFl+PvTmVZeo0FFZKcN5tkbEak5GOJPxF3p44kENKYyM5UbFIdLFjta7DDDQ6hmyHUsE/bSP8vsbQvDQMLkIPrbkZjNM0UCaYPz7t8bK22DOPSWH+Gm+GIco2m2y+6cUZ2xcQR4ovIiq1W8zLwVNNeJt8qasI55AJ/A/B8HUFhl5tWWWtw9TiJdAjjkEm0zzvgaVhGPwPh9v9Gw/IA7qsptCvw2Vtp51KvdAAMRGr09Q+5MxlXp3E6xdZHt5ltFdzz7s6+XzWbSrxP3YHR49S6eY4xjdebAA1xTAt4eRaSfnCs+9eJwKG2I6pUE6bYoI9Kifvd4OfJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxWSy2gEh02nWzJahH1rkl0m3GIL5arRuACxUVtqHeQ=;
 b=X0v0/bbyb2kkr0rrokf8XpgmNKblZ8OyTwgUtdGPunGnQLHDhu5S984xzFok75u2iw/VRDiUTJvkFBPB9KzzkxWPFSrYUsVHHVaC1q+lw++0DfTZwjmEdl3Q2Be84YoEeaFTaOrpQ5TkDuDR76IAE1aM2IJ7FocJ9baRbNkTj4DOlhA0rk94nz8AxQnZyvNdc3qSWOMV4tkdxUhtaqx9zAYrnOcKl8yQRndNT6kNBlWk87rLjfDh6C74VVuOUgd8kcsHJ6LUGQgnFvCpkY89bAxSxIXcYTKZUs/v7CeWxEwZoaXtXFKSlhEtfT1JMYoY5pBWLR9LFOiu+Xq5NClKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxWSy2gEh02nWzJahH1rkl0m3GIL5arRuACxUVtqHeQ=;
 b=kq4CNm0Q4Jjf4EHQx5TOfTe2eXToai4+4JvYZVYM57+e3QwS2nr4nRUgWojdqrlfjM9DShXqYt7TGtOHPu9LiBrg0LIsb4otEAHcNSEsJyAJ6FoQTqV0W875ui2iLjKiqp4E1K2L9yDk9mhDhK5ho6F5Nbp2RQmOaDUgkNyRZucnu84OnhbILD78ZAhjhNMPOg+cS7R70dLc23IjyBOQvdB3W4YCkefPUP7W7FkB4jtLYqfvtZEr1mVYtADBpNrsELzk3WS+u4l6kLaHQAjSQVyAQxgaR9LlN2QxA43vDOK9QwtTWcZNghV/5RbCUmoFCxcNyKptZ1dJos4Lr5Jm/g==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 08:27:18 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:27:18 +0000
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
Thread-Index: AQHc6PujKxK7sTnhckCh1AchNRK7Rg==
Date: Thu, 21 May 2026 08:27:18 +0000
Message-ID:
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
In-Reply-To: <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|AS8PR04MB8451:EE_
x-ms-office365-filtering-correlation-id: 15dcdc9c-8310-494d-fcea-08deb712c5bc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700021|921020|56012099003|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 QXWm7l15m55BGigqM6ICH4XBREER693OHDB8zReJObNuun0YKim2d265snyiEq5KasThkRa5igug8zoqwKIT9bJipElGXuMN/AwgIS/F7S5nUQEz2C11Cek/X6HvDxA0B72EDnLHW8AHbtHm3IFqizWXcCo5ToFCjUAf/DccBp2XSgwKlmMh7UQkcGjMkz2kejx64X/lbFnk16+NoNLYKbUGrzhqLzktk5wCmX6b+zbASH3zhrD7uOH4ICOhpE5s1I4fzLvYg4TYo028qcN9kBAbAyO2JwVW/k1E0gu61zDbCzEN6j4zTPIy6aRoyHWWIRCFhCKfWr+9GiYEW9fc6MymbmD88ckdrDV9isE1b7fVOBTi64HRdAOQmqiICoJAP7c3D6EwadADu6AhgerZ6QAE0vkexGBAW5jRx3EBjI7CSzDL1ifzzmzK4AXHcIvMYn6x+nNSQebq+khhTh+emv8OJ6+SGegSdJoTJC0Pj/2xarVaBsAALlhFkozqs3uSVcnzEw9RJreEKnAD+ZvNYnyQliiioO3JjtfxCYzOAEeMAl6KQ0BpAf0hhMoEVBmMCxVlfOsCzFtyoyeIgUYxsnAq7tF+j41RwM4wFta+MjGl5DaRjlqJ/EkJxIBlOtca8pb6qaOXomOQvVNLRTdoXLeGNn3K5xZ0kbcSS0plUNyKP0k6Jdg/PzNzL+JH5RY2QFjcBy8z5+rL/sN7eDReu9yNpYCOuNxz3Mb768+XUwFaVtsZ4oBnUQdWrGqEwOfe8Tr4bSJH7nOgOEmOFD+Vnw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SThUaWVQcCtSNFBZV2JCaFdrYmhHS1FtVVU5bWNUVjJTSk83eDFKcUNYRVZq?=
 =?utf-8?B?aGVhZ2RNUGtxMk52RCthQTBzZ0g2ZmUwUTZUL3JuTFhZOCthUHd6U0ttOFhn?=
 =?utf-8?B?cjlMdmRjN2tvMloyZlJtY1UwQmFjZWN6Qzl1elB6bmpDNkJFREJNMUNua0xF?=
 =?utf-8?B?N2tKcG9CM0VuMzVEY1ptZHY2dUpzaXFzalRjMitNM1pTMTk2d3RNSUlZTjkz?=
 =?utf-8?B?eHl1NEZUNDBZN3JpT1ZFT0tadXpGcW9SY1lSK3NWN0RKdGFXNlltUEN0VFBj?=
 =?utf-8?B?UFdQQlhhbTVLeU10UWFpRC9wS1lsQVNSRXJNbkdhN21ZYmJveW0wSE5mTkhQ?=
 =?utf-8?B?R3V5Um9mWFVSUEo1N3FENVlGYWRFZjgzZEJkd1FPSkc4bWxZcUo1Tk1adEpq?=
 =?utf-8?B?Z0Q2WnRPaVhORDZTU2VSSlR4TEJmYXdKVHBNMmJEbDFIUTZIMVd3RjhpMnlI?=
 =?utf-8?B?L3F4Nlk5emdyTWp6UitDbHhRbUZoR0c3eTc5SmVsaDNvTkdwL2pWYml3VUhN?=
 =?utf-8?B?WjhlREF0T3d5c0hkcUl1UGNYditwQWU1L1lEdlppdzdDMVZFRmFnOWNURWpQ?=
 =?utf-8?B?cndGR0NWa1grc0pMN0UvVlV3My9hcWtFVkhockJXbm84ak15NmdBdHpwYkxQ?=
 =?utf-8?B?Qzloa2c5U0x6cUtGYjVjWjdMWGFJazFXNGdKQnVXQjdQeXAzZWljSTB6bTNM?=
 =?utf-8?B?NU4wbHREdVM0ZFozTU5kZE5NcG9EZk8vQXB4bmc3dkhOZlBoNm5WM1RHdURK?=
 =?utf-8?B?ZnpnWU9zUHJxY3Fpdmh1RnpjNStQMElnNDhzNnlUM0UvTGM1M0xjeHEvNElR?=
 =?utf-8?B?cmhHWjRFOC8vQStZcHNJQTFrN0xEVDVaUm1GNnRSM2tMdFcwZkRVanZMbnE0?=
 =?utf-8?B?cmc5eXIwTWhXUUNJSG1EeG80RGwxK1BXTkU0VHVvb2FUS212R0k5OUVKdTVm?=
 =?utf-8?B?QmZFdDNQZWdkL1h5bGpKa09uQnRFUzRYdGFvUDlYcEtnSGxHcWtHSHFXKzJz?=
 =?utf-8?B?UlYzUktXR3F1OFVEV2FaRGFvdTNaNS8wd2tCUUMzMUpVNjZGcGszYWFOSjZE?=
 =?utf-8?B?dUQ2UzVCT1V6cDVDblc5VXNMcmdtZTRvZFFySmhFYTdYOEQzS3VHOS9jZkZr?=
 =?utf-8?B?ZVZGWnhUb2lwcHdQdGo5cFIweCtBWjhWMlpkZ3NHeGdHa2cyamgrUmlXV2xM?=
 =?utf-8?B?NGhIaG1Id2drQXJDUDRER0xzTDMxOWwwNVdEOHhMRU4yUE5ML1d2SmJNWnpj?=
 =?utf-8?B?UVJDVDJ2RWVYWThiU1FZNHhrTVlaRk1pSEE1MXpkdGhDMUp2d3RHb25VYUpE?=
 =?utf-8?B?a3pBT2FMM0JudTJlcVl6aFFYTnFnSVo1dDlxbmhDSXJWZFFjY2hseDhSQ1B5?=
 =?utf-8?B?SzlrVjNUT3JXYjByTTJiS1poMUVtZGgycDIwYlFzcitjeEtZcHpEUnJSTE44?=
 =?utf-8?B?SGFQUk9DSDFIcGVPQmRTYzZodEpHRkJjOUR4ZWErd09scmxET1lKZ3ZQdFps?=
 =?utf-8?B?cmt0OEZvWS9QMUErUmJLZnlJRk9SWnVIZng3VGFTRURXVW8rKzEvSUZpWnF1?=
 =?utf-8?B?R3ZuMlRST1RydG5MelV6dzdJTzFrbW1La2lhSit4NHoreEZmMkI2S3ppUXNK?=
 =?utf-8?B?Z1pVOVVyKzVyMlE2SnB6NGVJazltRTZBVXdqYXN3NEtHdXhJWlB3Yi9KalVL?=
 =?utf-8?B?V0xDb3pwemhyWS96WENZR0xIYVBwK1dBbndwUVZZLzl6WU81NnVFUE41Zmpt?=
 =?utf-8?B?NHJ1dkZCWEpyRzg3SDFOS1NVZ2NyZWFLcWNrVS9pYXJnMmIrOUNCVDA3YXUv?=
 =?utf-8?B?RkI0MzBxNmx1aXhsZ1pTcEdlLzlTcjVkUU8zdk9VUVVQUlc2TkdPZVBSbVlr?=
 =?utf-8?B?Q1MxaWdySGxJVnJHS0NmNU9MR1Z6UURrclRZeHdYYmQ3RFFNY1BVR2kzdktw?=
 =?utf-8?B?Qkt4bjNsUFQxL0xnUEpCR1NHdmFtcVRhQnJYb0hrd2V6NkJCOUhnelQwSkk3?=
 =?utf-8?B?cFpUU0ZmTTlCTmx4MXprZFhNaDR2bE5vdEd2Y2JacGFickpDd3FtQWFRdHpJ?=
 =?utf-8?B?WWhCMUVrTUVCSEdzVTFzenBmTGZuRGdTZllIRTNTS1JjejhWaTdrMmNLK3lv?=
 =?utf-8?B?RUIyRkZrK3cyTHNRUUZSelZQZU40c1JoMWNhVkFpb0JDNXZlMWhuS2Y5QldF?=
 =?utf-8?B?OVp5SFptZkRybmZIYnRzM2Y3YWxuZjdBc0t4ajZWRTNZS0J5RzFtaXRJTmdn?=
 =?utf-8?B?c2FnRGc5N0hydFI5eGV1WFZMeXR6TDdOQ091T3BLUkhGT2hTeGt1aUs4TkZq?=
 =?utf-8?B?SWhQUmFxWUNQVU53UkNSM2tjSWcyWStwcnNlUEVSd1UwVTF2aVFZQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dcdc9c-8310-494d-fcea-08deb712c5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 08:27:18.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M74r40J7qgM31aTNR+mqIV8VZvLtW4/cY7TP5XwAIPYJ2TMHWnCFcLlB6qXDFZHATzgDsyMh3TiLqIEWynfcNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-253471-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC3105A1171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTXVrZXNoIFNhdmFsaXlh
IDxtdWtlc2guc2F2YWxpeWFAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
eSAyMSwgMjAyNiAzOjQwIFBNDQo+IFRvOiBDYXJsb3MgU29uZyAoT1NTKSA8Y2FybG9zLnNvbmdA
b3NzLm54cC5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBhbmRpLnNoeXRpQGtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
PjsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBDYXJsb3Mg
U29uZw0KPiA8Y2FybG9zLnNvbmdAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT4NCj4gQ2M6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXY7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzXSBpMmM6IGlteDogbWFyayBJMkMgYWRhcHRlciB3aGVuIGhhcmR3YXJlIGlz
IHBvd2VyZWQNCj4gZG93bg0KPiANCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBt
dWtlc2guc2F2YWxpeWFAb3NzLnF1YWxjb21tLmNvbS4gTGVhcm4NCj4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBd
DQo+IA0KPiBIaSBDYXJsb3MsDQo+IA0KPiBPbiA1LzIwLzIwMjYgMzo0NSBQTSwgQ2FybG9zIFNv
bmcgKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5j
b20+DQo+ID4NCj4gPiBNYXJrIHRoZSBJMkMgYWRhcHRlciBhcyBzdXNwZW5kZWQgZHVyaW5nIHN5
c3RlbSBzdXNwZW5kIHRvIGJsb2NrDQo+ID4gZnVydGhlciB0cmFuc2ZlcnMsIGFuZCByZXN1bWUg
aXQgb24gc3lzdGVtIHJlc3VtZS4gVGhpcyBwcmV2ZW50cw0KPiA+IHBvdGVudGlhbCBoYW5ncyB3
aGVuIHRoZSBoYXJkd2FyZSBpcyBwb3dlcmVkIGRvd24gYnV0IGNsaWVudHMgc3RpbGwgYXR0ZW1w
dA0KPiBJMkMgdHJhbnNmZXJzLg0KPiA+DQo+IENvZGUgY2hhbmdlcyBsb29rcyBmaW5lIHRvIG1l
IGJ1dCBoYXZlIGNvbW1lbnQgb24gY29tbWl0IGxvZy4NCj4gDQo+IEl0IHNlZW1zLCB5b3UgYXJl
IGFkZGluZyBzdXBwb3J0IG9mIF9ub2lycSgpIGNhbGxiYWNrcyB0byBhbGxvdyB0cmFuc2ZlcnMg
ZHVyaW5nDQo+IHN1c3BlbmQvcmVzdW1lIG5vaXJxIHBoYXNlIG9mIFBNLg0KPiANCj4gV291bGQg
aXQgbWFrZSBzZW5zZSBpZiB5b3UgY2FuIHdyaXRlICJSZXBsYWNlIHN5c3RlbSBQTSBjYWxsYmFj
a3Mgd2l0aCBub2lycQ0KPiBQTSBjYWxsYmFja3MiIE9SICJBbGxvdyB0cmFuc2ZlcnMgZHVyaW5n
IF9ub2lycSBwaGFzZSBvZiB0aGUgUE0gb3BzIiBpbnN0ZWFkIG9mDQo+ICJtYXJrIEkyQyBhZGFw
dGVyIHdoZW4gaGFyZHdhcmUgaXMgcG93ZXJlZCBkb3duIiA/DQo+IA0KDQpIaSwNCg0KVGhhbmsg
eW91IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQpCdXQgdGhpcyBwYXRjaCBpcyBhZGRlZCBpcyBub3Qg
Zm9yIHN1cHBvcnQgbm9pcnEgUE0gY2FsbGJhY2sgb3IgdHJhbnNmZXIgaW4gbm9pcnEgcGhhc2Uu
DQoNCkluIGZhY3QsIHRoaXMgZml4IGlzIHRvIG1hcmsgdGhlIEkyQyBhZGFwdGVyIGFzIHN1c3Bl
bmRlZCBkdXJpbmcgc3lzdGVtIG5vaXJxIHN1c3BlbmQgdG8gYmxvY2sgZnVydGhlcg0KdHJhbnNm
ZXJzLCBhbmQgcmVzdW1lIGl0IG9uIHN5c3RlbSBub2lycSByZXN1bWUuIFRoaXMgaXMgdG8gcHJv
aGliaXQgSTJDIGRldmljZSBjYWxsaW5nIHRoZSBJMkMgY29udHJvbGxlcg0KYWZ0ZXIgdGhlIHN5
c3RlbSBub2lycSBzdXNwZW5kIGFuZCBiZWZvcmUgbm9pcnEgcmVzdW1lLCBiZWNhdXNlIGF0IHRo
aXMgdGltZSB0aGUgSTJDIGluc3RhbmNlIGlzIHBvd2VyZWQNCm9mZiBvciB0aGUgY2xvY2sgaXMg
ZGlzYWJsZWQgLi4uIFNvIEkgd2FudCB0byBrZWVwIGN1cnJlbnQgY29tbWl0LiBIb3cgZG8geW91
IHRoaW5rPw0KDQpDYXJsb3MgU29uZw0KDQo+ID4gRml4ZXM6IDM1ODAyNWFjMDkxZSAoImkyYzog
aW14OiBtYWtlIGNvbnRyb2xsZXIgYXZhaWxhYmxlIHVudGlsIHN5c3RlbQ0KPiA+IHN1c3BlbmRf
bm9pcnEoKSBhbmQgZnJvbSByZXN1bWVfbm9pcnEoKSIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgZm9yIHYzOg0KPiA+ICAgIC0gQWRkIGhydGltZXJf
Y2FuY2VsIGluIGkyY19pbXhfc3VzcGVuZF9ub2lycSB0byBjYW5jZWwgc2xhdmVfdGltZXIgZm9y
DQo+ID4gICAgICBzYWZlIHN1c3BlbmQgaW4gaTJjIHNsYXZlIG1vZGUuDQo+ID4gQ2hhbmdlIGZv
ciB2MjoNCj4gPiAgICAtIENhbGwgaTJjX21hcmtfYWRhcHRlcl9zdXNwZW5kZWQoKSBiZWZvcmUN
Cj4gcG1fcnVudGltZV9mb3JjZV9zdXNwZW5kKCkNCj4gPiAgICAgIHRvIHByZXZlbnQgcG90ZW50
aWFsIGRlYWRsb2NrIGlmIGEgdHJhbnNmZXIgaXMgYWN0aXZlIGR1cmluZyBzdXNwZW5kLg0KPiA+
ICAgIC0gUm9sbCBiYWNrIHdpdGggaTJjX21hcmtfYWRhcHRlcl9yZXN1bWVkKCkgaWYNCj4gcG1f
cnVudGltZV9mb3JjZV9zdXNwZW5kKCkNCj4gPiAgICAgIGZhaWxzLg0KPiA+IC0tLQ0KPiANCj4g
Wy4uLl0NCg0K

