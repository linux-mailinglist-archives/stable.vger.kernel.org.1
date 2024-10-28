Return-Path: <stable+bounces-88371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3C9B25A0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB1D1C21008
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C718E04F;
	Mon, 28 Oct 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MdeOuvXu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GssLyL9c"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59118E34E
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097182; cv=fail; b=FuvZ0FwNCCaiIIpxrpVbqqLzAgwK+agMDhRNif5opOyLo4slOFQ5MN7z5/h73NDT8Ju4nt2cu90G3YPoL+64ECxS9M5fQ0pLOKnDwX+f8F0LS71BAUTgrTziUUXfxyL5FHdBZ3L4hgFgK0X43DVtSqBxe3GUwIVPfUgk19H5gBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097182; c=relaxed/simple;
	bh=0xmtXTbDAY/1rejllIdytA7Jz8UoHDw41dxTIjl1JtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J72r5Okn01JQiEkvhBvcvJti3x9jgT4VxsLORhczJ0AODAdx8nas69DH3sxF7EDbdXd2UjtLN7BFnHcw3ALPCAlqr6lWP92mfp5SciDcbR/TpKSrrsGfR8XrpDmVk8vUu/F6XgstJ6PWOOUPeoBf+UUPrC6wkguNQwpIBlY4q7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MdeOuvXu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GssLyL9c; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 759c7efc94f611efbd192953cf12861f-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0xmtXTbDAY/1rejllIdytA7Jz8UoHDw41dxTIjl1JtQ=;
	b=MdeOuvXus5TLpj4uiCREKcr2GGoMv5wiFGmdzUNJ2Y9QDQXtQJcqkc0cjBFjqMRT5+NoAmh6fAZkTvmuYdRoQFtRyEGVKy0S/z0a3OB0yTYKBPdWm0B8QmfqyBbOzvGbsvJv00pkflckvOh+PKgp7tHzc+01dKVdob6lRW4R2LQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:a2c3d81a-aec6-4d73-a0d2-23779beff8d3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:479fee41-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 759c7efc94f611efbd192953cf12861f-20241028
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 539333699; Mon, 28 Oct 2024 14:32:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 14:32:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 14:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl9gc5Y2TAEF+XWvseTcNXYyYorjxeCFiadvzBYlHoTQGi6FeQnhoRXQrm1yg4hO6D8UUscmuyLGuiFUyxApQwRZFJuKIT5fRPobJOou8QVdCVMstcXAwlQ7fcyUJOasPqFcPPp8N3cUqzf9t+YfI48i/dLe5WxsukUvG42r6sDuD630bVI9iAWZLBcRCFSYoe//ax0VxvvPVpjyu9WFGlm9gUVEUfDL8VLOodFHbmW+vk1x5pQi1k96Doqzsx3BHMLPNiBI8Qi6USzfyWyZB0fnTHD8sEPZTN9201JmzKLD/R5qDtnOIzq/gU9+EFmuR9QhU8EPGdTDx4IBTfzyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xmtXTbDAY/1rejllIdytA7Jz8UoHDw41dxTIjl1JtQ=;
 b=f16hvozJyskwyb0L6kx7u4fPPu+tF4KrVkVbFPgiXRl+szVZijwT8xBwrW7riR4kX2zOCguEzoI2phyIKx6oNIBsD+e9i5keBABUgfBWjsAsh+bwB8fhhzrgeVRkYT2uudJAsRzXfl4IDjVGWCWFtBfifCoc10hfPJFK0WvC7vxWQAnhZL37OYLqahNTfI4RMPvzL2qJV8Z8ZuO1QF2Xajo0LTs5qPmC2+FGUIBZaprOUwBS4husiQhe9LOhACoR12qN41pWFaoFg2gSTe0PBsORvYAs6ly74Vse2k4I189ZTMfXQAChYO1+8dth8BDavHJkzF2SH55etCpalpkLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xmtXTbDAY/1rejllIdytA7Jz8UoHDw41dxTIjl1JtQ=;
 b=GssLyL9cWZS3TCv+W5dcm2VRNIGXYATqUAh7IL+EOOq0PN2iYcN7K5qygM3nrsuAiT5C5CNcJBlniVgOkgFf6jinanwHtXccrbog3D+TnBykK15SvEjFVS6iv8KSizGb2e6TB+g2l/7hKt+Ufsl90f/SBtlHqBrFv7BOBu5CNF4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7321.apcprd03.prod.outlook.com (2603:1096:990:15::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:32:49 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 06:32:49 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJf/SXPr1B+Q5Zk+EOWAsF0zUXw==
Date: Mon, 28 Oct 2024 06:32:48 +0000
Message-ID: <e0d1712a56b8456bfe7514532f8b975201a585a9.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
	 <2024102847-enrage-cavalier-77e2@gregkh>
	 <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>
In-Reply-To: <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7321:EE_
x-ms-office365-filtering-correlation-id: 6edb983f-8c70-4d27-b2e4-08dcf71a5786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGNCeCs1cFFrWDV1SWpzN1huYWpud3FyZFVZOG01cWZzL1hwUjNIeUtCTjAy?=
 =?utf-8?B?SUJROVhocnBDRDBVZEFwSVQreVJMU0hVZDkvMEtZY2hhMk1lNVA4UXRqUE0x?=
 =?utf-8?B?MW1XRlpsNkM1a1ZnWHgrbFlYVFVxaWJkbVpxZW12TCtrczFTSnA5NC8rM1dk?=
 =?utf-8?B?dVNUMVN2N1RZYXF5Z0E1L2FRcmo5WldnVzg3WkpDV2d2Z0gwRmtWb1ZBeklv?=
 =?utf-8?B?WlJxYjdVOVI5Q01DSkw0Y3RLc25EZGxRYzMzM0VPV1ZMdHhCRm42NTQ2MXRx?=
 =?utf-8?B?cHpIV2MvWFZROXVrcjhCL3F2VTl2S1ZRV0R1NlRnaVA4Mkg5Y2dnU0x1ejJM?=
 =?utf-8?B?Y0N3Z2FFL2k1SWNpUkJWUVNUcVhXUFUvbkQ2YS9peVorTlYwbHBOSjJzdEgv?=
 =?utf-8?B?TG5KQlYzYjhTT1dwZkpQcnd2eWVzL1ZhMEVHODNHS1hIMXU0bkNhdCs4WXN3?=
 =?utf-8?B?VVBrNjBXalhZVGVzdk5TOEdtaXFhU29ERHRZdzdyakYzcVFnbXorR0ZNMllh?=
 =?utf-8?B?RTREaWpKMVNxcjM4SUVOT2w1U0hLMm93REVrTURXbXY3UjU3VlpWSHRwZTlI?=
 =?utf-8?B?RFVVYVFIREVBWEZIbTJSTStSVTJRWTVWV0o0aEhTUVhKUkxXbEFXRi90dU9x?=
 =?utf-8?B?Ui9yM0s1MFM4Mmp3YTNwUGMvUUlING0rZkxjenlFM2htcEFUdEVTU2JrbjlQ?=
 =?utf-8?B?ZzdxZzBrT0Q3cCtlTys5ODhxTFRIcXk0em40ZmxTZnVwVmZ4d0VMYytYeTVG?=
 =?utf-8?B?TXhFaXRyLzRrQ2dWWXZoTVdLQ0UvRGFoS1ZJZmhhaUl0Mm0yUkxvTThjcnVU?=
 =?utf-8?B?a0E0NlRWVHZWaXBQSXRjUmlUWU5sY3E2TW9kd0NER1g3bzUwMjJ5YVpJbWY3?=
 =?utf-8?B?cTVhMVUrenhXcW14eC85NXZabi83c0hyQmU2Q3BlNGMyQXNsWTBMVkVnTzhw?=
 =?utf-8?B?TFE2TE1TeFIwbllRZG8rd0V1M29TeFVSUHJDazBYSzF0QytuNCtjS2poc0xJ?=
 =?utf-8?B?d2hrNnROUDlRV2tGV2FHMzJxRWtTYnJmYjdzUkMya0NwamJwT1daM2pydzVG?=
 =?utf-8?B?eWovTEJKQmZCRCtPWTFNa1dYd0VvVkFtUmoxVzI3UnJFZjJJNHdGcm8rRUR6?=
 =?utf-8?B?dDNJaWJWNU9DM1VYT2ZDR1ZoRFBDejZ6Zng3aTZmMFVVTWZERlBGTkNQRHZV?=
 =?utf-8?B?UlB5QUdzTFVtbEd1dXdpeHppbW1LM0RpR2Rsbm5KNGIyelhaQm5iZHlTMFBO?=
 =?utf-8?B?K3pZeWlhNVNkSDZ2ZG5vSWZhMlNWVTdTZHFIWlZWNGFyNERWL2UwWnh3K0pK?=
 =?utf-8?B?WERLTjdBTzlZL01rejVleGo1ZEtRaWFGck53eVRyV0dpTlNIZTJWeGx4TC9K?=
 =?utf-8?B?RmVBdUx0c0NuQy9KRk5iSURWMDdNdFN6Zmw0MWFmK1pmSW5TTk1RRlNiTng5?=
 =?utf-8?B?U2praXdkWkpVdmk5NnE1N0dBd0RtcTBFWHpnczZXZ1ZIWTNGYndOOTdLdlJu?=
 =?utf-8?B?UU9hR00xTDlTWEJXQTBDbldhaW9kMjJKMDgvSFNqN2FVZlUyV0t1NEhCbk9S?=
 =?utf-8?B?TU5IdGFOTXRsQXp3VjNSVEFKN3BHemUwdUFWbDM4Vzhlb3dienVMemFzTlQ2?=
 =?utf-8?B?bUdzS0xpd0ttc2NjeDBjWGV0VXpoem5XRUNaUzFXUTRqK21BMGJ6d1BlRjVt?=
 =?utf-8?B?eE9pRkY0Z1pETENnVXlqWWNsT3NnRWZJWllvRGQyK21lN2FsT2NVWkxvbnVM?=
 =?utf-8?B?clVnbThQZHJPKzBmVUNyd1p5WGpYMCtrdWY1ODdpcVRVbHN4YS9iQnFEOEFJ?=
 =?utf-8?Q?84WtvXG605Ui6ZRhBVTbtCLone3XO/IxxLMPM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTA3UzNKZVRvcXZwak5yU0FtNWNtWnNCaWhRSmNlaEdMVmJCazZqMXNmTWlJ?=
 =?utf-8?B?MWdnK1IweTMyYkM3bjhkMmN5dmhpYmlQOUd0bDQ0R2VNOEpjSnNYSVNBTkVH?=
 =?utf-8?B?TlBBbSs2L3pHVUVEUENUbG5wK2JVdGVmZU1KTUg2TXZRM3NQMFI3Z1k3ZERk?=
 =?utf-8?B?bkliVVhsOEJCNzRoZVZkaFlONG5qdzNqK2tDZEJucUowc0ZoT0pOSVkwT0Q4?=
 =?utf-8?B?RWVZTDc4OCtQSlkxdTRlVlM5S21SUUxUYVVRZ0tmb0tFVnQ3NDNXa3lQWjJI?=
 =?utf-8?B?d1ZaL2JTd0tkVnZxeEdqL1NUMGwyRnRzYVdOTEVSYXZhY3NjK3dHaW4wSzA1?=
 =?utf-8?B?eUozdXNZbEUvbTZ2cjRxdEZEQ2hTOFQvMzFSMm9ZeGg2cUpqdmRKSGhjWS9D?=
 =?utf-8?B?NHZJaWNtMmd4RUgyYkZJQTYwcDVBcm9mMjROQnR3eHY5cE4vaUR6d1lCYVpr?=
 =?utf-8?B?bmpFQ3lCWGF4Tnk5ZmdhcDBySHZMUFF4RUZsem5qWUYwRXN3cGhzYlptZTVM?=
 =?utf-8?B?RnNyeGdGMFlieTIxejRDaTZrMWZTemdOMHJZRTFobm13SkJEN3ptL0ZtVHEw?=
 =?utf-8?B?TmRpeEtQSi96eisyRjdHUVhieU13am00QzV6aWNZRlJ2Mzg2eFJwNHlSRFU5?=
 =?utf-8?B?VnR4ZWRUcUdKZTZ6Y09ad1gvQ2xtcEM3dHN1a2hOTkRGTWhqV2NkT3ZuS2NY?=
 =?utf-8?B?TmdKNkVWS25mTlByMkRlbHJBZlN3emg1a1I4VS9ITGJjTlRGNnRUSlFGeXpa?=
 =?utf-8?B?Tnd3ZDVRRTZXdjhybDU4b282Q0pxa29YdjJYbW85QkVJWS9oN3Vkc1Y5d05M?=
 =?utf-8?B?eFRIZ3VuM2Zjb2dzK1JIYnJzM281b2pKc1lMWDJsOTBOcmN5R3p5bVBzQnpu?=
 =?utf-8?B?dWo2RE5zTER5Q1psZ2M4Ly81Z2ZYMGdsQk1FZFRPSTNoZGlCcXlIRzRMUFox?=
 =?utf-8?B?UEp5Sys4RXFrTUZEdTRmK243Q1dUU2dxcVpEdTRkUHhxL1VsMGVDNFc0clNx?=
 =?utf-8?B?VUVnaTdwbUFmV2lPUjBScDNHU3NqVU1nTFNtcGtDVGFTYjZ6djFzYjMyWitP?=
 =?utf-8?B?NlI1L1FJTkhyc2JNYm5jK1VWL2tGQXFiQmU5ZWlpcExEbTA4NXd1aXl5MDFU?=
 =?utf-8?B?ZUZSUWRSWWtHdVNmTWdYd1RTNW1ENDRDUVB0UXovdEp0S21vUFRqL0tUV28x?=
 =?utf-8?B?NEF3aWVJQS82SDRZdHpzdklzQjhBbWVKNG8ySjdUSXVlMVdRenpRSzNQUmR3?=
 =?utf-8?B?WnV2UkFFYytJeUF3blkyZkh4V0FQWGo2TDF1T0Rlejg5V2w1bmZGdjVhUk1z?=
 =?utf-8?B?TjZ1RlpQMUZ1eWxwUXRvT1RwNkdpRWk0VWptd1pDT1huRXJIM3M1UENtSjE5?=
 =?utf-8?B?djFSWklweVFSc3pyWnJGTzJGNVExdjFRRlQyVTc5K1NIUnlqcFFHeHA0eXp1?=
 =?utf-8?B?ZzVVdkRBbWs0VzJyQm9ML0QrTDJPU2hBY1UzUFlqOTdWaU1NOUpIM3VVSSth?=
 =?utf-8?B?Ri80KysvN0x4TDhaTDBOQXhLTksydE5LbjZEc2ZaQ2NHa0U0eERnZGlaL0VL?=
 =?utf-8?B?N2NkTTUyMFRLS2FGVDRod1VQcmUxQkVjcFhHYTYzbkFYVXB4RzVVc01XU1lz?=
 =?utf-8?B?dTcwRExvL2tGT2xpWEF0bG5IcVpMbHZGSnpMRHRyK296RjRjcWQ1K2lZWlpS?=
 =?utf-8?B?dUtSbURvZEdaV1RIU01SWU5IbEpoWnp6QmtSYTNTV2d4cUgzak5VK01BRWNH?=
 =?utf-8?B?aGVqL2RVcGpSdCtBeURaQWNNWXRJTzFDRldONldSK1VIOTUvd1FjQ0c2YS81?=
 =?utf-8?B?MkRCem10NWRWZU9WSFJjN2M5UHo2am11aVEwaG1kbFhQYTJndU1jNlVIdlpa?=
 =?utf-8?B?L0xzVXBCRzV4QmpmMFRVbXNUNXlyL3FsUzgydnBDSHFTKzJaRWFDdW1tVkpJ?=
 =?utf-8?B?elVlL2VkZS9XWVh0YWVENHBlQ2FIc1R1NmhMYVBGbW53UzAzdWt4OGdqa1Fu?=
 =?utf-8?B?VW56K3dxdmxKOUZzMURiSHREc05uRmR4bCtpU2lrU05ScFkwdWFIUjFyWkEv?=
 =?utf-8?B?bUlNTm9VV1NZRVdIWU9uQmRJemFoTS9XZmhKYmc0YTBYbzRJWDB3ZWx2SFVG?=
 =?utf-8?B?WkUycGMwYS9IQ0xSQ3J4TUV0SVBuN1ZUOWRrdTQyR05aV1RxNlM3RlMzbGk1?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA031BC2AC7E6C41AAE7CE57FBCF0C00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb983f-8c70-4d27-b2e4-08dcf71a5786
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:32:48.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp7i0T6BY7pEkVarIxr4NAwYnS4KCCqv7h8GiCOqYI7No6FkHk/Wlu3rnzdtBU342PLlflA4lulo9tzjlUBgSjXju3soamXdeGXX7tDiN3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7321

W3NuaXBdDQo+ID4gPiANCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xNS4x
NjkNCj4gPiANCj4gPiBXaGF0IGFib3V0IDUuMTAueSBhbmQgNS40LnkgYXMgd2VsbD8gIEFyZW4n
dCB0aG9zZSBhbHNvIGFmZmVjdGVkPw0KPiANCj4gT2gsIFllcy4NCj4gDQo+IEknbGwgc2VuZCB2
MyBmb3IgdGhlc2UgdmVyc2lvbnMgYXMgd2VsbC4NCj4gDQo+IEJUVywgaG93IGNhbiBJIGtub3cg
d2hhdCBvdGhlciBicmFuY2hlcyBzaG91bGQgSSByZXZlcnQgdGhlIHBhdGNoIGFzDQo+IHdlbGw/
IEp1c3QgaW4gY2FzZSBJIG1pc3NlZCBpdCBpbiBhbm90aGVyIGJyYW5jaC4NCj4gDQoNCkkgdGhp
bmsgSSBmb3VuZCB0aGF0IGluIHRoZSBsb25ndGVybSByZWxlYXNlIGtlcm5lbCB2ZXJzaW9uOg0K
aHR0cHM6Ly9rZXJuZWwub3JnL2NhdGVnb3J5L3JlbGVhc2VzLmh0bWwNCg0KSSdsbCBzZW5kIHRo
ZSB2MyBzb29uLg0KVGhhbmtzIQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gUmVnYXJk
cywNCj4gSmFzb24tSkguTGluDQo+IA0KPiA+IA0KPiA+IHRoYW5rcywNCj4gPiANCj4gPiBncmVn
IGstaA0K

