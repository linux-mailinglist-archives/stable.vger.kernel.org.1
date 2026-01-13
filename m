Return-Path: <stable+bounces-208256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F07D17C89
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21BDC3011A9D
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474923168E4;
	Tue, 13 Jan 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7N7XFqQ"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464134BA56;
	Tue, 13 Jan 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298023; cv=fail; b=dOs5Q9kG5flYnljqcvUwR5lAbsgD3mEvm1brQIuNLYjgKRVqgeycRb0yiEjaX9iDMpXK2CAr2wHvND4K3AD5sgzR110WU5gqfoyLisl1aWdKwkSgUcUfeRrxK3zuOrclmHZ1sHZYNWYnRynpeYLMcD1CuT+tXcDp1v1CoeJnD7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298023; c=relaxed/simple;
	bh=+PYUkv5HwAmDWSYLtyw0947qQ+Mnc44KrDDFXDWbs/U=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J8AqDApOWRVO7nqJ6O9OqYJC5kKvDif3EnJgRULSQg7pqz1BCNYGqg2KOWmJfTZNVZNKfI1IUHDO2x6GVvLTLjIFKNWkA4h2fKGDXU7UDfpN8PNI3BjITEGpHktm1oJ6NF2Is9TXIGY2dWjXIxlqCU3+dNs9C3ibeXtviNRKEXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7N7XFqQ; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG7D3ufGPPutpe4i3DppXdmF4dVpmAsd4Yn2hzv9LOkdCrp8rVqYDVVy8lFGTA2XY5t+GUhBP+qtSQFIyxvWw/yiNlRJITo2hgEbf03TndXDLVHk3g9mMxo9FR/I/Oa+BZN8kwJWz0o6ZgHSPNTOxa4ND7H1ndfHGBSaaYyhYOcnJEIetslzWA7QjNxfegdeKELn8n4v2OD05QvUj51LPCiKd+DUaEV43Cnbb3+uPEIJ0QA49arDL8muUcinECR/SqWh27ryepFdi8CbmWrjW4P45x1s/OzIGNaBLI1G7+Yx7PJs04pf6HcGgzmADKnvTmZjHmz1/aRmQnPZc4+UZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlsRSGcjlFK4HwYYYeV54CEnnOGlNYHnRqvC9KKvYGM=;
 b=CvuxcC8r34gOWy7gTTRwRarZM+eXw4wTPfOJA/k+1CPaQBd1qbi3KCFzBDXdZwisvs9FxaI4Irq2ED2nw4I5Hk0iWGfqmuVF6xXYK3rRJIugzpF7mi4UT1B7NgLlOu9m7kjiRUWXPXs2hZUNCgvS54Fg60i0mnotRS8DbxKgrm942fblHjlQbybuTn1mClZVkczT9yLllihHlNrf8wKrUGSEuEtH7IhI/Nhhc9m1D21+Qe8n6eK2HHQifGqZZLgDEZ/EBiJWy8jRwBO4ZVLUXAGId2kbqPh5xXn0rUwwFlh6G58BUeIpJJAfWTHwYHV+hYGcMYR2iXquMexobFmCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlsRSGcjlFK4HwYYYeV54CEnnOGlNYHnRqvC9KKvYGM=;
 b=B7N7XFqQF8Q2wOPXIJaTwCISMK++YHqdGt+7ZYsp0hq5MfIPVMPxfO0QBcaJbSYODVbV6bELssg2upKG0bSSXPZJ80tjstTcL8InezGk61tWsV27fddBF9CvajHI+uzNthwX+8vUWFBSOH/omv7t/f1JO9E4KjP5jHhgBcUJ+zOQ1B/IqQcsbQQ1EbGY7E4aVqxa5p2ylcuc1yc+f5o7eciN6YkLk8/puDrZxUc9AHUnI5ES0F51zg3KiwwzEHIuO2P45dlY11VoYrkmiqUMd7aUdiut5X/CJWxn97GRwTge4FSxyLRmZsGyd0EZhRermDBJ+X7RVpFPs3mAahFggg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:53:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 09:53:38 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v2 0/4] Some fix patches for uvc gadget function
Date: Tue, 13 Jan 2026 17:53:06 +0800
Message-Id: <20260113-uvc-gadget-fix-patch-v2-0-62950ef5bcb5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIWZmkC/4WNTQ6DIBSEr2Leuq/hJ1jtyns0LgBfhUXRACU2x
 ruXeoEuv5nMNzskip4S3JsdIhWf/BIqiEsD1ukwE/qpMggmWsZZh+9icdbTTBmffsNVZ+tQa9X
 3rZTCGAV1ukaq5al9jJWdT3mJn/Ol8F/6R1g4MuyMunFSTEprh7CtV7u8YDyO4wuNNanCtgAAA
 A==
X-Change-ID: 20260108-uvc-gadget-fix-patch-aa5996332bb5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768298011; l=1325;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=+PYUkv5HwAmDWSYLtyw0947qQ+Mnc44KrDDFXDWbs/U=;
 b=W9jpQXw7+xUO0zbPfrdQXKZ2g07ZOWX64b3XE6BSE/sEznkj+wX4N5i9PYyfhtCZm76Pjyj7W
 2Kqa+rRLp/sBix4n3Kfr3wHA0aHMvtKfuWupK1BXngBJxIPW5/LDf1j
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc403c9-90b5-4f3a-fdfc-08de52899fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk5iS1U4cjVtcUIyRWhYdjFNTU4xdi91Yi9EK1lsNFZQL1JaYnp4d0h2eFd3?=
 =?utf-8?B?UG5Sbi94dkdHOGl2c1JKV0hOWS8wZ0ppMWFUUzhZSmUzY2xxL1A0alUwMHRp?=
 =?utf-8?B?eGRDTnBGTWJqVmlXVmV6ZU8zWmVzNmgramYyM0FOVSs1UEROWnhXak4rbXhn?=
 =?utf-8?B?S1VGTmR3a0JTUWJOSk90ZURZRlplZ2QvYjZuS2xnMEdpc0xZaWdjUmtVeGhj?=
 =?utf-8?B?UXdqelF0M3lOa2VzenRWM1B0V1ZhalpDY25xQTVwT1hhbnNnelVGeGc4UlNi?=
 =?utf-8?B?RHFzNzRCd1FHb3VDL2p6VDV5N3pjKzVaa2RUS3F3cTBrOXl1SmRRR3N2a3pB?=
 =?utf-8?B?YmE2UDZKVEpBNDRKaHg0akZLZkRuaDdKVDRTandGU214WStFQkU0UjVyNW8w?=
 =?utf-8?B?SE9BdTRtMkE4ZmxIVmRKbHN3QWdEQU5Vbk15M1BSZXdpYTBlMkJPTDdlZTNt?=
 =?utf-8?B?YTFkK0h6T211eHZHYkplZ29mMENoSU8zMmpSZGFZSG1oRlMvSSs1Y1g0Vjdk?=
 =?utf-8?B?UEpVenFVTGdHV2c1eUcyTEJDYVhDNFQyTWpoNlpSRWN3VHJMeU9wS21Scyt1?=
 =?utf-8?B?ei9XcFVNS2k1OXM2WWk4eFJwamhqR0R0ZTA0djd6OUJNeU9WQUlxSkxkRGwx?=
 =?utf-8?B?K3AxSGphSHZaOFJlcm5teEQxOXBmOFRESE1WYmNFUjI5QzlCbzR3bHBWdkxy?=
 =?utf-8?B?N1Rpb2R5M3Vpc05halU2SWYvZUxYQ3B6SnJKQ2xJNzJJbFU3RXlTQmJ0RXNt?=
 =?utf-8?B?NVhndzZDOHZVM2piOWxrSnB3UUl0K3hQR0N3QWY1em5IU1BVbVdtQ1BLYVB2?=
 =?utf-8?B?MlRIbXkxNFp5NG52T3o2MXVKNlBuWWJxMEhyN1RqUEZ4QzFBRkdsVTdPSnhw?=
 =?utf-8?B?Y1VyWkp2TGY2RmtyeDFIU25LaTVOOUp4Y0FZeGZOdG5IU3hRa0dsMGhuLzll?=
 =?utf-8?B?RHJ3WmFpTGE0bnpuSWkrVWJxUzA0c1NrNGVpb3NHdnVhZlNDYTkxMTFQc0V0?=
 =?utf-8?B?VnU4RUN0dzQ2V1VrczBaYVA0ZUNyRTVMMzhaRGliOWlDMjBuWXhXdUNBK3Q2?=
 =?utf-8?B?UWJnMWdReDhlL3EybGkxWXI3bUlpY090eTFVb3Y5V0FOSWt6R1NzSFYrR3Nq?=
 =?utf-8?B?ZVUxZUZWRng0VHdkcURrWm9mcnp0NHA5cVJqWkk0VklENTNlYkhvUTlXSkJI?=
 =?utf-8?B?TUcxQlpCbTlHYTg4K2xnSmZqalg4V2Z1ZTE5Ti9qQWpRaUIyd1l1ZHBBZmkz?=
 =?utf-8?B?UDJ1cWRoMU0vcnJEQlN0MnJTSVFhL1VObDBoeDFSQ1hpYTUwNjVzV2krN1Vk?=
 =?utf-8?B?TVo0cTJkZzdlY2VCNU5hOWFDcTdZWktSNmtzajl6VEhRdGswVEloZCtENk5E?=
 =?utf-8?B?amZHUmFxbU4zb3VadDdKVzk4ZFNseWNJeENxaTF6Y2xqTWxjZTZvMEk0Y2pq?=
 =?utf-8?B?dEdhSm5GL2hrU0x0NXVIOW1UZHlObXluVFJ6b09JVXdxWkhSWlY4a1NCK3l0?=
 =?utf-8?B?d0xOZCtqNURqdDZIWDZqZnhKVWQ2RmFiSnc5UTIrQW55a000Rmw0NDZsd0tP?=
 =?utf-8?B?dWlabEthMk1KcG1aaFpXUitFOFV3bFYxcS9HWFlXdkt0WjdrbElKa2k0QVZ2?=
 =?utf-8?B?Z3I3cVo1TXQ0ZFVsZzVSQzZ0eURYTitoUXRvb2NSb2FwU0R6YWVPbFRsTHdG?=
 =?utf-8?B?RkUrMVFuUlQvVWxVVGlwNnI4UWJWaDRxbk1URXVyVU9BdFhsdk9lVFNYOWF5?=
 =?utf-8?B?VjkwMGpMNnZRbzF1UlF6TEJJSHpXN2NTMGxOQWxVQlNreHZucVRRcndMQ25s?=
 =?utf-8?B?OXJkR0VMVDFiNkYzYTlycTQyeXJ0cUdmcFBRMDZQMzl1SGY0bng3VkZvdmY2?=
 =?utf-8?B?RFJxamFWM3QzNXEySTVBRU9VYUFMb0p5OUhpanRxaExkYnlRQU1PMU1ESndo?=
 =?utf-8?B?b0RVQkNHdkRoT3BRRk5WeW9NL1NLVmh3UmJubDNvVnlHeUhRZlMwaEFtbXkr?=
 =?utf-8?B?bTcwS3hHQjFJSHluTXNvdGpBTjRoNC94clNXUXJ6UzRRdTY5Y0tKOGhxdmJ3?=
 =?utf-8?Q?tm+/Nn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JuYWNKYnJBK2xHOFdTZ25uNUxwaFlhZU5Gc2NlVkN2RHdpYWp4RHp2YjFi?=
 =?utf-8?B?R01uR09YZ2xmTGo2LzBRdWR6clBRT3BDR2tCNk10R01JMEh5QWd6akVSY2sr?=
 =?utf-8?B?RjZvY0xtWDRDTXJvbnNKSUczRFpaUkQ4aTRZSnVEVnUrM2hrRUJYV0dmMSth?=
 =?utf-8?B?QnFxS1kyc3A1QmFJd052Yk1XL3VvY2N5Y0pIMXkrRE1YSDhzWWRXZzQ2MENt?=
 =?utf-8?B?REU5NlE1K2psNk1aNEFrVXNIOVpySStrYTdhdGFsRHVFM25JeStEaEZVc3BS?=
 =?utf-8?B?d2NiQUp2TlY2emFMdGh4ZEhOeEpqUU9pM3dUV0dHbysySG5RS0FDWVFTNEdR?=
 =?utf-8?B?cHJUUisvKytRckdVTFFHOU5WR05hTnR5THNvSlVrYkU1SVhUbHBFT1hONU0w?=
 =?utf-8?B?VDl5UHF0VUJ3M3pKNlZVbFdsaDBodDVJTUszZWMwOWhZcnNvOUhhUFcxdUxh?=
 =?utf-8?B?QXlhQzBnK2F4Z1V1V2RNWlRvYkYyMzg4K3ZDTmdJM1Era2E4OUNQdGdyb2Jp?=
 =?utf-8?B?eGpQVDdvRThBSktlcDBYSnFmdnl1dklPVTBDQmlHckRkMTZsWlZEcHdlZ3Bx?=
 =?utf-8?B?L0RjMERXRWY0bllwdGZvdGxhcW1rRGlPSmlCMWNwajZaVWRiODQvemtqR2Ir?=
 =?utf-8?B?dUVuZmhrZTEwRmFvS091NUVaMmtJd0NSemQ4VjVYTFI4ZnhMZUxMWElodjlO?=
 =?utf-8?B?MWZRUHltVFhMQTVGTFc5UUlOcDQ1U2NqWThIUWtQK1BHVVFhRGVUYkY3YThE?=
 =?utf-8?B?WDNlRnkyTmtJSWw4VVBBakhYL0tSOEs1NVZBSmRpTllscTZabm5iNllJTEk4?=
 =?utf-8?B?dXZuVUhHV1ZFdGtZV2hiYzdIUDZiLzFNVFFZY1lEdm5CWTFrNFd3RGhMdlE0?=
 =?utf-8?B?cFlPUGR3L3g2YjZGNjVjdUc3NWFWSHhuNmp1aHI1RWMvd0xpMTdkUzFhT1dF?=
 =?utf-8?B?NEJrTkFZbTQwWTNaL1pzejFJQU0xUTBJblJGYXBiTVhJckptR2hDUE41d29n?=
 =?utf-8?B?U21DRVZHRWsyQ0l6L1Qzd3c3RkRHK3c5eXBFRmZ5L09XS3UrOThPTjlsNVQ5?=
 =?utf-8?B?NkZleDNxaC9hQlJmMVFQeXBlSFpMazNVVE83L1hrcXE1d0hvZVNleFFOU3Fr?=
 =?utf-8?B?SHRXU0xDS2gwenlHSTlwd3B2dnBLRUllZDFyL09VWjJjZnpXQlhzbkU2V05m?=
 =?utf-8?B?Nk9xV0RMa2VMam9BSzY3T1lsQklDTVYzUzArT2F0V2txYlN3TXFzMWE1dktH?=
 =?utf-8?B?N080ckwyQVI4aXg4TTArTzk5eVpzZEUvM0xDbWRTYUdDSXFOMjJwcUNsVC9t?=
 =?utf-8?B?UTc4aXVPV0hmRDc3Nmw4aWdUdDhId2N6dkJJY3VQVUtMUEFBenZ6WktCVklL?=
 =?utf-8?B?REszN0lmQU5UVzFPZkM4ZUx0dUhVYS9yZUwxLzlreVVJYVFMajVoM2ZRMmFq?=
 =?utf-8?B?TkF2NEd0L2JkTzN0aVpvZ1dvU2xkNEdCMlNWclg3T2t4WVlsYUU1Szd4VHBa?=
 =?utf-8?B?UGMwWEpGN0JqdHJPam95enY4ZytZS2V0aUFBWlRodDVvV2VSQnpZeSs4TUNX?=
 =?utf-8?B?cnRGNEhTRWxuT1YvMXpOMno3VkVURW9lL1BtdDlIc0NRTkpMQzU4aTZibGZ0?=
 =?utf-8?B?dTJ4aWxkOUpUb1VueGdSMHQzMlVXZXU1dFdlSTVsNi90MVFwdFB4cFRKRUxM?=
 =?utf-8?B?eldFcE42Z2Q0S0RMSk1rOFJJbWR4MHpoN096cEdMQXhRRmtud29aOFloK3FX?=
 =?utf-8?B?Sy9GbTE2OHI4dEE4MEVBckl1bFgwblYrMmc5MUYrRzQ4ckhzRWE4QXpiVDdF?=
 =?utf-8?B?bzM3TTdITzVIcWQzQ1Q4ajRSWm9JczgzZ0tFQnhFMzZVSGZHdHV2U3RDdHUr?=
 =?utf-8?B?amxRMW8xdGNXQWVJOERNd0xnZ0QxdkxpMm1nRk1YYjVIRjd5KzNqSFVqVVhN?=
 =?utf-8?B?NUJ5V0JpZDl1TGtkUTV5SXpDb2c5a0VKbFQzaFVlcjJUNjA1R1dMSW9HODY3?=
 =?utf-8?B?Y20wYXp4WU5GUEpNU2ZoWHZ5QXFJN1R5TnFWcUg0TWlzYlplSGwvVklOQi95?=
 =?utf-8?B?R3FacmdOOWtINGMwRmZaOXdxdjlWZUZUWkJtSkljeUw3YUk4ZDZvUGp0MStS?=
 =?utf-8?B?UDg0dUQ1UnNxeW5JYitjQnNGU25UbDlwTTV1RGVySkpOSytsdDlnRWFsdXlN?=
 =?utf-8?B?Nzc2OUM5VW1RQVFUb0dZbFFhY01uRkg4MEtsRm13dC9qTHNUSnFGZktKbk02?=
 =?utf-8?B?YVRVUHUzM3pxcjc4MXRLcDdNZ3Y5ZUtNbTVqVndISnd0WEp2SEtvVkQ0MzRO?=
 =?utf-8?B?TnFrVHZrMmdzZkJBak5xK2duQ2s1SWVRMEYvMWM3MzVCWW56K1BZQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc403c9-90b5-4f3a-fdfc-08de52899fd1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:53:37.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/5fG3dI6AXEP7Xd/28JLYYTTJcegPFCacz9cERz1oD61IKOVMaY3P5MaAb9MstAixhtUHkHtHWthF/X5GNb/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798

Recenly when test uvc gadget function I find some YUYV pixel format
720p and 1080p stream can't output normally. However, small resulution
and MJPEG format stream works fine. The first patch#1 is to fix the issue.

Patch#2 and #3 are small fix or improvement.

For patch#4: it's a workaround for a long-term issue in videobuf2. With
it, many device can work well and not solely based on the SG allocation
method.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com

---
Xu Yang (4):
      usb: gadget: uvc: fix req_payload_size calculation
      usb: gadget: uvc: fix interval_duration calculation
      usb: gadget: uvc: return error from uvcg_queue_init()
      usb: gadget: uvc: retry vb2_reqbufs() with vb_vmalloc_memops if use_sg fail

 drivers/usb/gadget/function/f_uvc.c     |  4 ++++
 drivers/usb/gadget/function/uvc.h       |  3 ++-
 drivers/usb/gadget/function/uvc_queue.c | 23 +++++++++++++++++++----
 drivers/usb/gadget/function/uvc_video.c | 14 +++++++-------
 4 files changed, 32 insertions(+), 12 deletions(-)
---
base-commit: 56a512a9b4107079f68701e7d55da8507eb963d9
change-id: 20260108-uvc-gadget-fix-patch-aa5996332bb5

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


