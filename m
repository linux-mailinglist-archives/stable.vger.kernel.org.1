Return-Path: <stable+bounces-230404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPLPCeiJxGn50AQAu9opvQ
	(envelope-from <stable+bounces-230404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:20:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621B32DCC2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49505300729D
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98765375ADD;
	Thu, 26 Mar 2026 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SwAHEFu7"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57436494D;
	Thu, 26 Mar 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488033; cv=fail; b=KaWrSpkovkqiZMxhQBYwSpxs76dozqTeECeI1a0bUvVMKtqYapxvS5cb+KvUvpNgxuUWubrLn/SfXC3XOuXIc5dtxeTA1QT1pGJBeXGLV80/IahqgHpSdc0JKjLYBwEO1mQIkoK8v/Q8AHUCxseRTUS1fOw/UT+WanSJikojIjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488033; c=relaxed/simple;
	bh=Jb7pMYsrkdQgmJTI2svq021PuHzvaFbIPwoaj/zr1YI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BX+tC11SdTEPk30R8TweLdOJLC0BqQSZlpYb3SqVYwog5rNDE0w2SpWhWBsZqCDDFhZ+1Re6IFvi61pnF3hkinHsNCYOJHNoWeZKDEhrkhQORhGZsAaUzdnyjDVSz4uqry/rQU5mi0ohQeW9rKywH4WSW2zdatIPwo9pG5WMkFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SwAHEFu7; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4phisthDyu6NOMERx8KAEKXTiL2Qq5h+AZdjCdZn7RaD4o7bU1h+9i2yYzr6joNBN4N2oawfhczlyA7qUgyw1mDiPzExWKsCr/YCxm3sk/3E89coFD4LVmmcnze/0pnxQ4YnMTYBqDxjmSbUMzjk2E7HXOTBecMkM9w7VBCS9Qxj+LF964ues+f5Y8XTgNxnj6AOlyhjwm9E6f/9AFdTh6ivAAtOmsuWgBXB0msy81CjhstQL1mK77R8mpHT8qqJwtN7C5nZIf7nbN+ogrYHGc6H8HkAMvzQAvHjMqrXlshdxEm1rFJMZschDyABJYWpiNrcYC4K2I1/oIOWTBe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb7pMYsrkdQgmJTI2svq021PuHzvaFbIPwoaj/zr1YI=;
 b=Nu45W7e2WMSvstRk5FQw+7MIcJL95mlCtIF31K9weQde7YOw2yNBh/mE/H6nJQvYahxLWoPgAtho1AqLWKb4raaiESwCXeRRUCus4Wmf5Qbnj+fD50bjEzdFhVnx6zRl7JmVwJV6kAWdKG4WXMbrCPb2FWtwsnz85UItXIEWRgMNNed+gUL8+laraL8ei/kdn16J/AsRx5kycbj9V9J8jfALhcb/rHfyQ+ozkpC+6W0nFDZdfFRM4FHqDjg+6Y4gLWrqaSsA2GwVcEbzkocUR/UWyka6P20jQMIt7KROYAFTQczPzV/bIKjRiAh8FUt5fVdzJcgR4qqxez1YxAPvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb7pMYsrkdQgmJTI2svq021PuHzvaFbIPwoaj/zr1YI=;
 b=SwAHEFu74bIQHaeFSg/QhWIYsF6/JpAW1V77g5tA6PVM5Cb+F2N/tj9veJipgX3TsQwLXEjXUu3NqCgwYFjvBPkKrx1xshRX7ECY8XrcRHOeS3vVAJCw0UMr2lrsH5iZ7H3/PCXeT1ESJ+SeGViistgPxsOeK+AiXfaPfTIgobIdwPdiy+ptttNxo5apTIGhwQytPLQAKqo+i2k2kvcu12TSXp7h6zKK6a+PJ7cb68hYOUKyLpU/49RykKELD3juvOFUTc1vJJKq5UEGOasxplUdVkR79MqjvdHSGpOqr4iHNVgDIhRdxuZ3wZAytZ+Ms9jwqKcHyw6uXDdRM613oA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI2PR04MB10954.eurprd04.prod.outlook.com (2603:10a6:800:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 26 Mar
 2026 01:20:21 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 01:20:20 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>, Lucas Stach
	<l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Franz Schnyder <franz.schnyder@toradex.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Fix reference clock source selection
Thread-Topic: [PATCH v1] PCI: imx6: Fix reference clock source selection
Thread-Index: AQHcvDpAhX77nZBBQkStXX/rfA9WerXAA6ag
Date: Thu, 26 Mar 2026 01:20:20 +0000
Message-ID:
 <AS8PR04MB8833941DBCDF040D2E7186978C56A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260325093118.684142-1-fra.schnyder@gmail.com>
In-Reply-To: <20260325093118.684142-1-fra.schnyder@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI2PR04MB10954:EE_
x-ms-office365-filtering-correlation-id: eab38e33-d652-4b14-89ae-08de8ad5d900
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|18002099003|56012099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 9frP5O7DzHaPfq8kTDDcgfjKj08hj2UY5cjbOjl4aqUchTIkMRLYQGJSTKBtMAFdT8kZ4JnSGDr+xk9wpDuS1XcDCKEJJvcnoYAt1kWLYpjq87RKxoJ9ELe+fviBUUt2tVcVMDPsLGlJP579ZENsJYp5E3XfYS2z/xBe7y9NwS50dUArTv+TdVUoc0KAWAWYeIq+hl44exB7FX7GxJMHOAY6Pvgz8gKJhNvbAauuEaGbsmM3xgZOfcSGj8LTI49eDU0egqLs/eFOpNd4Ls6TyuhNfj8D0Fci17pJEQ5KiUsAq9v1yvXHZJVVmqse9iy2umBv9FAlNsVWu3OW+Q5VUqpJoMG5oNfh4AJTv4YE2FW/JWxp2e72peCA8hdRRJN7TuqBw236PSYNAfU4X6WYpVkSqTgSduk6dCpTmcXteU8rCDh/L+zerKAr/aXGrstP1+K12VmKP52iD1P+cMdTflP6nmPxaknfP4Hn1FqB2lRS5/3JypnfxYA3Y31jQNwXnFV8tHRgFP+jhAkdYHeOSB20F1fQnM50ZrxgSbTKi//aTEReR7B2BNX3FIt4S6sEBbNK6X4kg31aMHnwBqN2w++efWPa/nhhd1p9IUrUCEEVNNKiclYarHk42J/zo5ATjj1MIzU1KtBtYYOrgAEvknRtZ7wkNcAAmJY5LrAm80lrOYjZ22LiHi9njF8zUDrFY2joOJeJPTr9XqN4m7vDDLrHS1n1QbGML6qeDhLsGeMdkh+i294hcfBlEAicuCstnCrfmRsLhGFqZF41cbov+dVwayT4ZP7pk6tb1eug16Dm0LYwg9c0J8dYeP7MWMX7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VHVwSWtTU0FKR0NsaUxUOVJSamNJckNSSDRxb05aOHd6eDRJSW45ajJDbUNk?=
 =?gb2312?B?MmRlSXFwTVllZFZucTdPaUVXT0MvMVFMVUpYbGtPeGY5QWRPeU55QUM2NnFl?=
 =?gb2312?B?a1dwbTBraFNLcExDRWVFa0RnaDNCeTB6QXV6YnBBbEpiQXZWcFNGcHZLTlJn?=
 =?gb2312?B?dVFsdFgyOTFGUVVVbUlpcy9MMnVzbzNqanVZcmpITzgzRXdidk5Xb1Z5bDQ4?=
 =?gb2312?B?eTFteUhnVFkxZ0VnOXNPcEVoNWlvUi8rbzR4NndmOXFNM3lScjRwSDltQ1Z4?=
 =?gb2312?B?Wi82R2RZL2hGZmN3WCtLcjRhbmFveFNLYTJKbjIvbWpSRHB0QmJqaWZpZ29I?=
 =?gb2312?B?eVIxSEZ4SFQ3ZE0rS2NDdEd6S0tVei8wQXN0ZjQ0VmU0RUdBdXYxL1ZoK0xU?=
 =?gb2312?B?WFk4YzJIL0dCY2dsVjZnL2JkNU5TNkhWL2ltVzB3bVVFd3lkaHFTMHRGTTF5?=
 =?gb2312?B?ZTIrbEtqVzNPbHJUTlJoM2ZSdzhzNUZRTU8rc3UzWWF6aXhkZWJ1d054T0Zr?=
 =?gb2312?B?ZHRBYnhJR2tUL0sxcmxURlVkenEwZXJRSGt5ZmkzR3B5ako5dnMwMlVQd3di?=
 =?gb2312?B?eFd0V2ZDRTlCMFE2VTYvVTBuQlhyd04yUGV2WS82cndnN1hFeGxKbng4OEU5?=
 =?gb2312?B?K1lTYzM3dmpKQXhINE8vSUJ5S0E4b21JNXphalpwNTFHZ1JwQk5CVzBzKzNJ?=
 =?gb2312?B?aURyWlowUXYyM2pkQkllOEt0VXBTVjkxT2tNSTcycS93MXhpdUI4TzY5SG1O?=
 =?gb2312?B?bS9EU29xK0NTU25VMHFEcElyRkdwNTdLSkVlYmhsL0oyVGNhdXNzMjJ1b2Uv?=
 =?gb2312?B?S0Z0MCtoV0Y2ZktzKzltUURZSVE2ZUpad0JieEVGM0o1NVBUNkZZRERRMmdN?=
 =?gb2312?B?dmFWdUx2REpWS1lNY3RNaTlXWk13Q0h0TEtQelRSYzlPeHN1YTRHUVJUUHZi?=
 =?gb2312?B?aUVxOWR4VzFLQ01ETFp5QktKa0RRc1BiektPVUFKcXVGZ05vVXVzRkNwOTlQ?=
 =?gb2312?B?TGxidDhyM29YRlNnM1pIV2pleW5PN0RHbytUaGVtaGRqTWJjZDhYYk05eDNZ?=
 =?gb2312?B?SHZLVjlpWmJGYVlIejRmNERlQkFPdzZtUHZYUExIMW13MFV6SU9sdlpkaVpV?=
 =?gb2312?B?K0NDWEl3RHVaR1NQaUQrWlZ1NFpiZzBQU0h5bUhrZnJKWVJUYTR2WkttRmVr?=
 =?gb2312?B?aGI3R2FtMlZqNkIwcCtJS1FQeHBPdWwrWW1VbUFDenBVUnRJbE5wekRKNnVi?=
 =?gb2312?B?TFJZWmRGSTZwdmZiUWFNUXE1Qmo1aFZscUV1YjJ1QVAyT3Bab1VTWFpSSXIv?=
 =?gb2312?B?cE1hd2dGMWpuRUV4YnA5NlVZc1NzUTQ1OEsvM3FGamNrKzJrZVRQamdkeTNw?=
 =?gb2312?B?c2pCVVVEYjJhZTg0S2tXekh3L0RUcTE1WmJTTTJDSm5LdWFTZWZkSzM4Q0RB?=
 =?gb2312?B?OWgrcUZpV3ZtWEliQjJpc2lNSU16YzRpblkxVFEvWGJ3Q1U4cWw2NWNBeDNB?=
 =?gb2312?B?b0J3U01NbHVLTWNTZ0F4ZUtGcy9kbS9uZ2w5L1F5c0pmeTFScUdCNjVSb0Q5?=
 =?gb2312?B?WXZkcTFIWUJHSjdWNzE1aGZLWnFkaWkwYW5TNlB3WGZ4VmFzZ0txNkNaYk1Z?=
 =?gb2312?B?K0gvVVJ4MHd1N001bkJvSzRUM0ptYkxvNmZyMGxaQVgydGppSW0xSyt5eXUx?=
 =?gb2312?B?Y2VTbDcwdW1ldUx1eWYxaUtncVpGWXlwMGtKZnVTNERIc0NVUmpTRzFnYUVu?=
 =?gb2312?B?UTljOERsK3NjQk5tMTNITG5tSEJaamdRdEdGTStldUdiME9iWXJvUmlhbE8v?=
 =?gb2312?B?WGpaTVRoSWl1K2F0bGlBTGYvdWwvN0JCOWNoTUFjOHhRYUl4ZUhzVkU0bWND?=
 =?gb2312?B?NzRkUTBKeVBVeUxzR3lGbkoyKytMTlNyTGlSZ1BJUnJ5aDBjeEFWd2tIQjNC?=
 =?gb2312?B?NDNjcXl1b0FOajRsak5HbE04aVJWbWpZZkVFRWRGWTE0NURjV245aThYN1pL?=
 =?gb2312?B?VUZqcTVXT2d3UFRmRGlGd3BDcm8vaGJvbmZYZ2oxR1VYVS9QUWIvR3BCQklQ?=
 =?gb2312?B?RHdndmtqUFdwanJhcHJtaWI4dG5yZnB2dm5nNnJZaGJhUG1NWWRSQitEdTZE?=
 =?gb2312?B?cVdNbjlMUVpsbVpyNm5wdE1NNGp6ZlFSV0JhY3Z4RVhJMWNxL3NmUnZObncw?=
 =?gb2312?B?M1VEajlhbm9hbnN1L01ZeVdaeDdUNWlxbUpTd0svVkthZXNyZjZ1dVpzSWtL?=
 =?gb2312?B?WkptbUMvYU52TDh6NHpyOURZNmp0RmpKWG9JeUNXY3hRMXVZcWhZUkFpM2JS?=
 =?gb2312?Q?XpaRNcG4IHiHa1itdM?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab38e33-d652-4b14-89ae-08de8ad5d900
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 01:20:20.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0Wh0bo1Be65vnmkoqAHYlE2palgJySlj+XQ1JzPN/Cvcriain/wb+xdd3MLjhm062fBHdN6vbhLDED9q88luQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10954
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-230404-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,kernel.org,google.com,nxp.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3621B32DCC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFueiBTY2hueWRlciA8ZnJh
LnNjaG55ZGVyQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNsTqM9TCMjXI1SAxNzozMQ0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVs
Lm9yZz47DQo+IEtyenlzenRvZiBXaWxjenmovXNraSA8a3dpbGN6eW5za2lAa2VybmVsLm9yZz47
IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcg
PHJvYmhAa2VybmVsLm9yZz47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+
OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiBGcmFu
eiBTY2hueWRlciA8ZnJhbnouc2NobnlkZXJAdG9yYWRleC5jb20+Ow0KPiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlt
eEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5jZXNj
byBEb2xjaW5pDQo+IDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYxXSBQQ0k6IGlteDY6IEZpeCByZWZlcmVu
Y2UgY2xvY2sgc291cmNlIHNlbGVjdGlvbg0KPiANCj4gRnJvbTogRnJhbnogU2NobnlkZXIgPGZy
YW56LnNjaG55ZGVyQHRvcmFkZXguY29tPg0KPiANCj4gSW4gdGhlIFBDSWUgUEhZIGluaXQgZm9y
IHRoZSBpTVg5NSwgdGhlIHJlZmVyZW5jZSBjbG9jayBzb3VyY2Ugc2VsZWN0aW9uIHVzZXMNCj4g
YSBjb25kaXRpb25hbCBpbnN0ZWFkIG9mIGFsd2F5cyBwYXNzaW5nIHRoZSBtYXNrLiBUaGlzIGN1
cnJlbnRseSBicmVha3MNCj4gZnVuY3Rpb25hbGl0eSBpZiB0aGUgaW50ZXJuYWwgcmVmY2xrIGlz
IHVzZWQuDQo+IA0KPiBQYXNzIGFsd2F5cyBJTVg5NV9QQ0lFX1JFRl9VU0VfUEFEIGFzIHRoZSBt
YXNrIGFuZCBjbGVhciB0aGUgYml0IGlmDQo+IGV4dGVybmFsIHJlZmNsayBpcyBub3QgdXNlZC4N
Cj4gDQo+IEZpeGVzOiBkODU3NGNlNTdkNzYgKCJQQ0k6IGlteDY6IEFkZCBleHRlcm5hbCByZWZl
cmVuY2UgY2xvY2sgaW5wdXQgbW9kZQ0KPiBzdXBwb3J0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogRnJhbnogU2NobnlkZXIgPGZyYW56LnNjaG55ZGVy
QHRvcmFkZXguY29tPg0KQXBvbG9naWVzLCBJIG1hZGUgYW4gZXJyb3Igd2hlbiBvcmdhbml6aW5n
IHRoZSBjb2RlLg0KVGhpcyBidWcgd2FzIG5vdCBjYXVnaHQgZHVyaW5nIGxvY2FsIHRlc3Rpbmcg
YmVjYXVzZSB0aGUgZXh0ZXJuYWwgT1NDIGNsb2NrDQogaW5wdXQgaXMgcGVybWFuZW50bHkgZW5h
YmxlZCBvbiB0aGUgRVZLIGJvYXJkLg0KDQpBY2tlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBpbmRleCA4MWE3MDkzNDk0YzguLmUwNTgwZDZl
ZmE1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC0y
NjgsOCArMjY4LDggQEAgc3RhdGljIGludCBpbXg5NV9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXhf
cGNpZQ0KPiAqaW14X3BjaWUpDQo+ICAJCQlJTVg5NV9QQ0lFX1BIWV9DUl9QQVJBX1NFTCk7DQo+
IA0KPiAgCXJlZ21hcF91cGRhdGVfYml0cyhpbXhfcGNpZS0+aW9tdXhjX2dwciwNCj4gSU1YOTVf
UENJRV9QSFlfR0VOX0NUUkwsDQo+IC0JCQkgICBleHQgPyBJTVg5NV9QQ0lFX1JFRl9VU0VfUEFE
IDogMCwNCj4gLQkJCSAgIElNWDk1X1BDSUVfUkVGX1VTRV9QQUQpOw0KPiArCQkJICAgSU1YOTVf
UENJRV9SRUZfVVNFX1BBRCwNCj4gKwkJCSAgIGV4dCA/IElNWDk1X1BDSUVfUkVGX1VTRV9QQUQg
OiAwKTsNCj4gIAlyZWdtYXBfdXBkYXRlX2JpdHMoaW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1
X1BDSUVfU1NfUldfUkVHXzAsDQo+ICAJCQkgICBJTVg5NV9QQ0lFX1JFRl9DTEtFTiwNCj4gIAkJ
CSAgIGV4dCA/IDAgOiBJTVg5NV9QQ0lFX1JFRl9DTEtFTik7DQo+IC0tDQo+IDIuNDMuMA0KDQo=

