Return-Path: <stable+bounces-125866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07367A6D730
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7986D16B4EE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202025D8E7;
	Mon, 24 Mar 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="FSuKGQL+"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC818FC80;
	Mon, 24 Mar 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808194; cv=fail; b=nF6Jav3CrURjirbBUnh1ijr89ewHQ9KL9sTv4R5+AARFjONXPVgvazwo2k5LPZALhBSmZGpkYdN+GJSADQGbtCowuhh15pkYo3qdUFMdLf0P0vlwKXwLvDz75K+VzOHdIV87/zdeJPIjK549hujq4RiUfHlTYvj/hqYxtNwFN3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808194; c=relaxed/simple;
	bh=wUbdWaKgdi4nYmUT/IFvt91lbqpUGpSzZlIu+Ht7CxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=li30Wga8xMxMQKnquo/RT7DPDtEPMsEMoeFWfAzENnm2GRWeDe4pJvqyvSi3n5QzdRXEC87kN7CY7GAXSdcSaOBS/LkPYCnpqxxAxndbH0zqUq2u8woyMd4Mh1CW5pDpL4g7vuaJ5wRtjiHApHsVNGLy2DmznTHjc+QSw7JD+pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=FSuKGQL+; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP3KlrY5KIGcy3vf2fhitK1uiSnwqIzGYvEo3wpo85QO/MJHIeGJu5ZuHtEbRQB2boE/47Jy+d3rMbAxU0rhaYXSOt3SegoDpCNpUztqNeA+xWNHu3O7fIiE0X6sLQYEjplvdygx8O9GNWAaLbx1YKk7anPdfGUKPo19MWx+5mK4Ddt88P7lNPX+EeIAA5Jd01EGhmmixY3ZeIaGS1ai1eZCOIbItSX37JIfxqTovRp2NeD7ZqeRNxRQi3DgTt9+YMVJCIX9n58uQz96g2J2kLNvSDSrQsVpif7rAgnQ9MPyoUy9LpigG0IRedDhfcjonv0zCEOBhcohj/YqpiCqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zceYDfKsgKfFDKb00eSSV0lXSMpbeL+YgKnu0L/z7A8=;
 b=G18gs0wjCmNMJFw4fznLq3b0UbRoRsGihuZarwBT1roAN7aeJzynEiAZ2k+Q/jix8z5d3siuLD8r8v5rtGxzzs5hH83pNN1900E9zenLU29wdPWuMwEOBVsgYG6lPiHZd7DuLS23v9MBR6Qeu39V57sjzW20k37BDhBgt8M6xPHv4cFJeveFDgBjqbDAc5vPfs5xUBQyYD3foD7fxBBwVnSlKObvVENUn7t2BUXfBzVb66UnJk8kn5pg2zQqCf273RB/2/NhS4yM+KQ3f+P624tV4qXCCxsFjrWHEO84tK8f2XZU3RsAW3KSg5IPBSxwGOLBCrONCweU80Yct5XKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zceYDfKsgKfFDKb00eSSV0lXSMpbeL+YgKnu0L/z7A8=;
 b=FSuKGQL+oVqu9Dex6WM9f8ZCztQLHRlCT2N2FiadhYJ+YbNBjHaev0Xrp2heFdbcv4uj7rk3IIJsPX/R5ZPKtcMaoeTYYYt3nu9nmfUvJcUuErSJwzEoK8T+qq5FO6bQ/SuzlvNgEjZbmsuoFgTMvsdLozESklic98anm+TS2Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:23:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:23:06 +0000
Message-ID: <2ece5cca-50ea-4ec9-927e-e757c9c10c18@cherry.de>
Date: Mon, 24 Mar 2025 10:23:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org,
 Alexey Charkov <alchark@gmail.com>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
 <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
 <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b007707-f870-45f4-87cf-08dd6ab57b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEFweCtDcUJqa0FGbVQxNWF2UWQvYjEwOFVSMDRSL3hvWXZJNldzSHdoSkJR?=
 =?utf-8?B?cmNSUVUvaDJRUTdGdThXNThLbXJ0aHBQaEFVTkhRVndDbS9hVHVIV25kV1pG?=
 =?utf-8?B?c2ZmNFBLN3FLMVlES2pUMXpicFRkSks4cmd2RDY3VjI0OXJIK3UzV2VBcHdX?=
 =?utf-8?B?UGVWNTJxQU1mUHR4UlUycUJoNG9veE42U0ZVcjRScDRhSFdiQnlMNksyQTdQ?=
 =?utf-8?B?bDREMzFGQnQ3UHAwWkV2QWE2cGplL1J0WjE3REZZNktLS2lZUUl2NmpRRHNL?=
 =?utf-8?B?WGVBS3BvWS9nR29sTXpGL0pybnUzcE16K2xJeXczd3pld1huSTJFVm9nQzRz?=
 =?utf-8?B?US84VlllVG5lZEdQTkNiSDBHbnBIVVAraXhGTjl3TTRzbnNYMWtZS3VDMld4?=
 =?utf-8?B?TGhqbWJnVTcwQ1FOUHRJK2toVGNQb3RiZ2JiSmhLcEd1eXdhL2I2MnJlajZn?=
 =?utf-8?B?Z1VIdzBpUElYRjl1NjA3eWZIVFlyOTRTSGIxdi81c2p6a1pjRHZtMStpOUVv?=
 =?utf-8?B?aFZDays5dVJQQ1Rjdmc2NXNYYkdLc0c0czhacElFUGNKQ0ZlbSswSENhTklY?=
 =?utf-8?B?eUFYbFlIK0Fvb2VVdytuVzVTSW9NTnMwSUQ1Y2huL011RllhTDhVcG1aVC80?=
 =?utf-8?B?akhrR2JML01qbnliclU2Tm5lditPYjRad284Wjk3UFJuWk5CZHRWYkpqMita?=
 =?utf-8?B?WnF4VzdmZno2ZEM2ZmJNaHlweWU0NjBOdmxRaTdqbG9VVVpDc2dXNVFldGNq?=
 =?utf-8?B?NjNMYzhQVzY4b3BzS1lid3pUcFg4TlVBMk5YS0IzMlIySnRGZlM3dlQ1Tkp5?=
 =?utf-8?B?bXYvemFKeGRYclJ4VzN4OFpVZFR4WFJHRWwzcmZJUUpxcXRJUHk3UlU3eWta?=
 =?utf-8?B?U3hmWHYvZHdIeFRjT0JwQ2ZBMFZOOTRpNFprMXpwNUJaNnIzckQ4Y2hhTTZL?=
 =?utf-8?B?RmN5blFZc1VRWmpTbHhSQm1oODRSaHlDU2xRbmpDUEhQYkZkdThFMXhaRUM4?=
 =?utf-8?B?dU5OWVZTNGMwZ3Nhalg1cFBnblJUcFEySytGUDJDZjdCVWpvQ1FmbHh6Mkh4?=
 =?utf-8?B?N3hnN3AzYWZEZkNBdnZ1UE15TXlmV0lraGhlWVcxNnQxdzdqNGlvRllPMXN6?=
 =?utf-8?B?MlZEa2N4TmtlbWg1RmdZMnF1dEUvVTdTejlac0V1czcwbEFBVEFTQjlnY3p3?=
 =?utf-8?B?NlJtUUhVVytIVThRSG5MYWhrMkxkS3FxUHk1ZU01WWlnRk50ZktiVENGKzRZ?=
 =?utf-8?B?OXBFaGpCSC90WGcyNERMOEF0Y0FmdVZ3R3ZKeVJGK0FmNFQ3OTFrM2owd2J2?=
 =?utf-8?B?U0p0cXBwR0JRbUhCSFV0dWFlc0pvb1hMdVovclh0REp4YnF1Z2tOK1p5bkk4?=
 =?utf-8?B?K3pzLzMrdUJ0WXJMci9BOXh4N1l6VVdKY3dsQzNuMlh1Z2hOZVhMZk9zbHpQ?=
 =?utf-8?B?ZytlakpmRWE5RHVKK0NsdmNWNzRacW5seHlKQUU0d1JrRUVmMy9NLzl5aHBZ?=
 =?utf-8?B?bkpaTW8zVXBoUzMrWFZ0WDdNb0F5alV4cm1JeG5ENTdhcjh3b2lJSUViK21M?=
 =?utf-8?B?Tkl1emFDdlBUbTRJQ0xFZ2s3VzFUY1BUMmNMVk1LMlBKbmRNbjBIbG5oUWVZ?=
 =?utf-8?B?V1hBbWRYendGSUNnRFprc2JIWWVPNUJURWFKR0w4aXNmT01BTUdzNVdpVEIz?=
 =?utf-8?B?djk3QXBVSTJHU21HTmpwUHBJVXZDZFNsaUlSODdkZUJUTis2akxLYkIxeStm?=
 =?utf-8?B?OHc5N0dydzRMaE9CUi9xMWkvSkZiTFYvdEkxbWdjcnVFNkZ1aEU5NE5QVjQ2?=
 =?utf-8?B?Q0JTajJHWDVuZjYzTFY1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpBNHJUd0g0eEc2MExCSSt6VWlPTDlDVmJKaTgyT3VRRnZtd1MzeCswaTRP?=
 =?utf-8?B?ekVWNENKdGh6a3dIS3ZycjQ5ekJxOUdaSHVsT2g4aTM2cXlLNWcxTVpWM2U2?=
 =?utf-8?B?blFMR3ZxUUczTFpzd0lHdDJNNlJqS1ljaWljb0dVQTFZRUJoU2YvbW5FQXhX?=
 =?utf-8?B?OTJxeGhlVnlhS09SMjB5K2svdGUwU01vYjdVTUVleG5lODAya1Byc0lLblhx?=
 =?utf-8?B?Lys3QzdadkVMdXpPZ1dGMGZmdGd0cUR2TE5hdDlKcGlnWVBoenV3L2tkZEJs?=
 =?utf-8?B?Uy80ajROVnlyemJiSjVsTVlzTXVpN2NhVXE3Z3dacmwxdmJiWDlOOXpvVTVH?=
 =?utf-8?B?ZTY3dHhhRDNkZmFXeWd5c0w5elo0dnNkd2Zhemx1YkhoNnVSTzFGOFRmeU43?=
 =?utf-8?B?aGEvR0o5UDhBcWZ2L2t4bHdrU2VxaWFIVEExU1NYZm56eWljN2I5NUFOWER5?=
 =?utf-8?B?eU8xYzVPNXhsUzhyaEFMdmpqMnhMazdWTEY4aWtTVW5ESjBuU0x3K1NSRUNY?=
 =?utf-8?B?VVRnMm1aSkRLZm9rV0k2VWkwZ1dUODJBM3dDVFVmSDBCak95ZElnbWVSRU5v?=
 =?utf-8?B?ZEJtazdnMTNibDV2Zm90WVNjS3RMR2N1dEpzRE5rcjhyaEVRZ0pKTzJIUXky?=
 =?utf-8?B?dTRvbGJuNmc1dmVOdU1ZcG9Yd0ZOckVsYWdBaTFGZTVFRDk4R1poRk5UZUlN?=
 =?utf-8?B?MXhxeHhFSlZZR1UrY2FRdEo5YnM5cXg3WmVDV1RvMkRkdzJKVzhLVzB5dnhX?=
 =?utf-8?B?M0RoQ3RxdHVQVTVtWnB6RHgxT3pTR1dwNkY1TmN4OWs3eWFOcFN1VTYxZzEy?=
 =?utf-8?B?Yit1aXFsVVpTZFFMdDlsa0hzampsNDBVSTJyUEkzRTBUNTkrT0R1dWxTTDdk?=
 =?utf-8?B?UUJRV0I1SzAvRkp5RUVIU25EKzVpaE10VUVrQjhiazVxeEFVSVg1U0xxWTdt?=
 =?utf-8?B?czhkeGpJK1V4WEs2UGlQNUxOYnVuTWR6eVJ4UnhBQkZXRGNLV25QRDdTSmtH?=
 =?utf-8?B?N1pIZU1Kb1l5RE90dnE2cXhtOFd2THpKRU5jUGhPa2JtMWRoc1FIaXZ1ZlZY?=
 =?utf-8?B?c0hnYVUrYVVRMXA0bmoyU1cwTmZhQUdLS0JwUW41a0t6RkxEbERIY3ZVY1hL?=
 =?utf-8?B?Z2cyM253VXlWZjdzRUV1RUEyUHc3NUFVR0ZBYmw1TDJYOUcyVnJJMEhxS3dt?=
 =?utf-8?B?d0tSNnBwQnphUmJKaGZOeUNOQjI0R3VXemIwblYwMGw1VWIreEtaUVFxZ0N3?=
 =?utf-8?B?UjRvREtMYjdxZU5HTmEreWhsdHZwaXpwbDZaSDlWNDNyL0hMQmNDQjQzMFFJ?=
 =?utf-8?B?emZZd0o3d3ozVHZndTZpQ0RCaEQxOVByNUs5S3p2TVZCNkMyR3FsOXJBVXZM?=
 =?utf-8?B?M01xK2tVbzd5NTBSNDFjK3F5Zm5HVVU0bG10emtXSUllVEJ4bG8xcm10aUxo?=
 =?utf-8?B?cVE3OVkwUzJvK3lFWks0azVQQTBCYkZvaldMczZCb0t1Ujc1ckpPdFc3amZX?=
 =?utf-8?B?N3dFZDgxbG1iVUx3U1lBek9qeFUzbk1uT2xTWDd6V1FBalcrQnZhQkg1TnV0?=
 =?utf-8?B?M2NXMFhmQXlWSDN1MEc2Ui9jTkZzaHcwMll5bnI4bk5ENnMzaFRPM1Q0K2tS?=
 =?utf-8?B?ZnFUZ01JTjJ3aU56ZXJhTUN6dmVyUFlGSXVMbnJDaDd1RENtd1d1YlFLaVZ6?=
 =?utf-8?B?aXMwZHZydHdUYzU1YXlFeGZvNzhGSyt0UWxrdE96MmxTK2pBZUdWRmthbHVv?=
 =?utf-8?B?SDhuZldWc000b2RFLzlLT2pBMEVkSDZIb2U4V0UzUE8xVDFLR0tYQm5xaG1l?=
 =?utf-8?B?MWRhY3dFL1VKUGt4dWtmd3ZkMG1PbzBNa3JpRFUxZUFOb05zUjY0S0ZZTWk1?=
 =?utf-8?B?djZMTUVEVDRPQS9MTkZvV20wSFUwY0ppRERJV2tDVzVNVnl3YlpCSnNNTEFB?=
 =?utf-8?B?ckxQY04xbzJyU1B6L2xLY0tmRHdqdGVoMUtMZmt3MFhWaWpKU25xZnEzMjRY?=
 =?utf-8?B?eUNzUEROcmpKZmRYS1FXdEdUb0ZvejZ6NU9TL1lCU01iK0xQWk1Eb2dOdC9O?=
 =?utf-8?B?V2Q2c0RkaUNSQkRLYjBhQ3JNTUxwRVZISUVrenVFQWxDVURObVNkdjBtd3VI?=
 =?utf-8?B?QWJlVTVlc0NGSXg1MW5SYktDeHIyYng3aHdoTGVweTFnUkIzNWtKNHovT0Zn?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b007707-f870-45f4-87cf-08dd6ab57b98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:23:06.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iARXRMWjn4pzbN/LsA1EMaSdHaFe5PXkyA4OI2YqwGpyYwRKUi47bT9WT6QSxZoonRXFUUa3sOgWp+PwUmZAdtl0E4jqp1T774+J2eqx3jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045

Hi Dragan,

On 3/23/25 11:19 AM, Dragan Simic wrote:
> Hello Quentin,
> 
> Thanks for your comments!  Please see some responses below.
> 
> On 2025-03-21 10:53, Quentin Schulz wrote:
>> On 3/21/25 4:28 AM, Dragan Simic wrote:
>>> The differences in the vendor-approved CPU and GPU OPPs for the standard
>>> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J 
>>> variant [2]
>>> come from the latter, presumably, supporting an extended temperature 
>>> range
>>> that's usually associated with industrial applications, despite the 
>>> two SoC
>>> variant datasheets specifying the same upper limit for the allowed 
>>> ambient
>>> temperature for both variants.  However, the lower temperature limit is
>>
>> RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended
>> Operating Conditions, Table 3-2, Ambient Operating Temperature.
> 
> Indeed, which is why I specifically wrote "specifying the same upper
> limit", because having a lower negative temperature limit could hardly
> put the RK3588J in danger of overheating or running hotter. :)
> 

"""
despite the two SoC variant datasheets specifying the same upper limit 
for the allowed temperature for both variants
"""

is incorrect. The whole range is different, yes it's only a 5°C 
difference for the upper limit, but they still are different.

>>> specified much lower for the RK3588J variant. [1][2]
>>>
>>> To be on the safe side and to ensure maximum longevity of the RK3588J 
>>> SoCs,
>>> only the CPU and GPU OPPs that are declared by the vendor to be 
>>> always safe
>>> for this SoC variant may be provided.  As explained by the vendor [3] 
>>> and
>>> according to its datasheet, [2] the RK3588J variant can actually run 
>>> safely
>>> at higher CPU and GPU OPPs as well, but only when not enjoying the 
>>> assumed
>>> extended temperature range that the RK3588J, as an SoC variant targeted
>>
>> "only when not enjoying the assumed extended temperature range" is
>> extrapolated by me/us and not confirmed by Rockchip themselves. I've
>> asked for a statement on what "industrial environment" they specify in
>> the Normal Mode explanation means since it's the only time they use
>> the term. I've yet to receive an answer. The only thing Rockchip in
>> their datasheet is that the overdrive mode will shorten lifetime when
>> used for a long time, especially in high temperature conditions. It's
>> not clear whether we can use the overdrive mode even within the RK3588
>> typical range of operation.
> 
> True.  I'll see to rephrase the patch description a bit in the v2,
> to avoid this kind of speculation.  I mean, perhaps the speculation
> is right, but it hasn't been confirmed officially by Rockchip.
> 

Speculation is fine, but it should be worded as such.

[...]

>>> The provided RK3588J CPU OPPs follow the slightly debatable "provide 
>>> only
>>> the highest-frequency OPP from the same-voltage group" approach 
>>> that's been
>>
>> Interesting that we went for a different strategy for the GPU OPPs :)
> 
> Good point, and I'm fully aware of that. :)  Actually, I'm rather
> sure that omitting the additional CPU OPPs does no good to us, but
> I didn't want to argue about that when they were dropped originally,
> before I can have some hard numbers to prove it in a repeatable way.
> 

I assume we'll have some patch in the future with those added and those 
hard numbers you're talking about, so looking forward to seeing it on 
the ML :)

[...]

>>> Helped-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Reported-by/Suggested-by?
>>
>> I don't see Helped-by in
>> https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fsubmitting-patches.html%23using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdc754791b6844506b11c08dd69f444a7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638783220330058516%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4bv9pUh6aSD0GVLJ4Zvuyvox1K0xxwf83KXX86QsvMo%3D&reserved=0
>>
>> I see 2496b2aaacf137250f4ca449f465e2cadaabb0e8 got the Helped-by
>> replaced by a Suggested-by for example, but I see other patches with
>> Helped-by... if that is a standard trailer for kernel patches, then
>> maybe we should add it to that doc?
> 
> Actually, I already tried to get the Helped-by tag added to the
> kernel documentation, by submitting a small patch series. [*]
> Unfortunately, it got rejected. :/
> 
> However, Heiko accepts Helped-by tags and nobody higher up the
> tree seems to complain, so we should be fine. :)  It isn't the
> case with all maintainers, though.
> 
> [*] https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flore.kernel.org%2Fall%2Fcover.1730874296.git.dsimic%40manjaro.org%2FT%2F%23u&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdc754791b6844506b11c08dd69f444a7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638783220330070422%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3dZgSG%2FBT6f%2Ffqs7D30HvEl18SzqYPwNeUGWBZfMAqM%3D&reserved=0
> 

Are you trying to up the numbers of Helped-by in commit logs to make it 
a reasonable request to add the trailer in the documentation :) ?

Cheers,
Quentin

