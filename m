Return-Path: <stable+bounces-178841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3381FB482EE
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0F43AC6A1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E74214A79;
	Mon,  8 Sep 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GnlJjNJa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AhE++Orz"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06ED1DFE26;
	Mon,  8 Sep 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302919; cv=fail; b=h6202OFazAbcOALT3ByNQvRXXAHozhVowEHxKN2X7T8kDhd8FLA9VINiqTKTMDdsGVmlh2z7pmmNrwW58TIFbBQN8wpJ7SXvh7yQYhnAXqTRie6WJoN5Kjnec/GnvAYJeULftsYPsGMl2GEyMsTeXSxv3aFWrDwQoTiDwqJU5vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302919; c=relaxed/simple;
	bh=8hr/FVdszqI87ddsxTf9MK26TOnq9pIfm/4BwbRF4K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyNAN8pH1O8jrMLenx1jlrnNDPshAS3dIuOYPwTFmnyQfkhjf5zyekfnYWu4lMYXkyUGcY1gTe0ddI1Fd9aSTH1bVC5JgOhr8FwNy1Bu18NN9b1WgrsiiEtz1vRK9GhrUXEwImWjwqzz56HBSh2vBv8UKNrmMEE1YfQWpLecGQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GnlJjNJa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AhE++Orz; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c1c3875a8c6511f0bd5779446731db89-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8hr/FVdszqI87ddsxTf9MK26TOnq9pIfm/4BwbRF4K0=;
	b=GnlJjNJa7AMgLTM3NXM8OiCZMcB7sUSM2v9HVxVkY2UdkY144nwQfE9l0D0Mp1ICjRX71O1o8N4CAgMbYyOFrN0naDTkBXJHgHMKWIlOs3qRD5zW61afqAOA1WulZIZ7se37cZzUV50hSinmf4fkQ2tH1uElFn8lSvuEOM1CHzA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:0620a7d3-f4c9-4bbc-9a7f-5fe43ac6e61a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:70e54d6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1c3875a8c6511f0bd5779446731db89-20250908
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2002620110; Mon, 08 Sep 2025 11:41:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 11:41:48 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 11:41:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvX1eSafHCME+j3BFSOycx+FYD88tiFNbriapmhAkxUSBkN1QyO6jDfdJvNaaoMEMCX+loqCumhsxh831mV2+f/uxeq9dRg2qaoRR3QtCiYiSGqqv6KVCwlQw84kABiq9RNtTKCNKGg32zaJMY1bh7FhdFmtglYIU4GZfzXlNHV/P/OZA35LJwao3fgJlqorHTIER3y0vmCoUzkDEG3yi0mNaaC8svGN9WHkUtiXSrsBdnAiDmihP97BjgLshPRIujmD4wk0fE0tv+kWmmVJc5OJuw/vNkEzidPeMflURVrhl0x1MqV5Vo7454sroUKiUGla67mfG73V/kVmoNULXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hr/FVdszqI87ddsxTf9MK26TOnq9pIfm/4BwbRF4K0=;
 b=tLyu2BZQbWzEnTFrbF/lV+++Kf2C4Fy9YGy/Bb9jcla9RmwBWqB9+0Oqb9c6I1lX9Svdj7kjCaqKqb5Zw8Q4VTx7/5mt7ZbtV/HYGrtEhmIlgFxg+lP1tIZbIgBGY/HYuPeQhYn86uu8uG8RbT6nKK3mEscEf0CVTl9eM4XvU5NJ2TTXkLwjoxn05GKEmby8JVpYeLWHD32qyWNxAhJxoXXepogZbXFqElka80DktUlw5BTpsqYRHdQwl0AIBEOnw9MN70KEzdxcwOb1HEXmuSasmXCblMR/QWpl90LXQjE/atPhRfBW1EXUYbHpuIjxgkRPtIenpSoffWWkDnGAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hr/FVdszqI87ddsxTf9MK26TOnq9pIfm/4BwbRF4K0=;
 b=AhE++OrzvAZKl0AFVwJOmfcK8pc9V9pYc3V7sZfpwYv5UbzEglZ17EXttGiWuafQ5MBYBegUiLZCHKYHbxDvHNAbkcjxED4ASeDyixnAsPiEiJYkGuy/JzpMDIkdim07csFgVhAZkEGaWmCnup3cbGtzxmVNJIvEHxrRvuNjrGs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KU2PPF5FB3746AA.apcprd03.prod.outlook.com (2603:1096:d18::412) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 03:41:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 03:41:47 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "johan@kernel.org"
	<johan@kernel.org>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "make24@iscas.ac.cn"
	<make24@iscas.ac.cn>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/mediatek: fix potential OF node use-after-free
Thread-Topic: [PATCH 1/2] drm/mediatek: fix potential OF node use-after-free
Thread-Index: AQHcGMRFed7cnJPf6U+d2bDvHV2aArSIs3iA
Date: Mon, 8 Sep 2025 03:41:47 +0000
Message-ID: <741436f7fff7003aa629f8b330a248ddda592d62.camel@mediatek.com>
References: <20250829090345.21075-1-johan@kernel.org>
	 <20250829090345.21075-2-johan@kernel.org>
In-Reply-To: <20250829090345.21075-2-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KU2PPF5FB3746AA:EE_
x-ms-office365-filtering-correlation-id: 0eec5961-1815-4b8c-c52c-08ddee89a388
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|42112799006|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGxHL2VETHRoVUdBMk5QTm5hZXdoelVKR1JIaTd1Zk1aLy9qbjduQzZ1MS85?=
 =?utf-8?B?WGJTWjJwNFBzVE84OHkySC9EMjBPcVplMTFscGZLZlhubi8rbEV0TjZ5OTRz?=
 =?utf-8?B?NmZ0YjhTd0VyWmNrcTFJWkIvRUFqQlpnWE50VWJiWGRGUEZsdEovSks5a0Zl?=
 =?utf-8?B?Z2FSNU9pb0NQL2t0dS9MZitNWkhlWnJSZUlVc3FIbE1uQWtqQkJnY044WVNr?=
 =?utf-8?B?djNzd21yMXJFcFM5Y2NoZEFoNC85aXBkcXFUOFVnbFBGTkZxeEFpY0VpRkFu?=
 =?utf-8?B?amxRZjJEUGZwU0x4dTdWMjhxVFRNZi9QYm10OTI0ZEdxUVBjMnVrbU0rQTdu?=
 =?utf-8?B?TXpHNklxdEN1Q1ZJcnBIQWpsTEphbVFMZnI3cUZWZUNITEtnQTV3bGUreVV3?=
 =?utf-8?B?V2xUVFI0ZFVUUHlKd3c0dTRWd2M2SWliRk43VjBZYjNTOEJGS2Y0YTg5SS8y?=
 =?utf-8?B?Q1ViNkVNMlFlN0l1Y2NwSzd2bWx3aTNyZmppQVVPWThSbVUzSVRPMEdhd3ZK?=
 =?utf-8?B?dnp0VG94TmJKYnBwaVh1djVTcTMwdG56UmhQdzh6NnIyZkp5WGp4Wlp0enlC?=
 =?utf-8?B?eUJzNTFOby9KeERDVE13Zm9GWFllWjNsMjBxK0dWK2ZodTRmWTlXRTUxMHN0?=
 =?utf-8?B?Y2xTbnVFanFxdnQ2cmVRQUIrdlBEdzA1R25RM3N3YTBPcWR5bXRqeE5wbjNm?=
 =?utf-8?B?dytUbGtCRmtsbGZsYStUaEFGQnZ4S2dSc05PRVRLd1Q4MXdySVRJZDFhYWNK?=
 =?utf-8?B?RWVVUnpqdUdvUmdCVEtxWHRudDhuK0FQWk1SSURHUGxmVVBocEhLaDRsbmJo?=
 =?utf-8?B?aTNsRXFUQzBQdysyR1hhWkVKTXNNalJaTi9Na0ErT0Z1bStzNzM1R0I4WU5z?=
 =?utf-8?B?d1c2R2w2Q0c1VElRNmEvVG5qbVhVNzgraUpFaTNFczF0OGkwZjQ1UzQzNU1M?=
 =?utf-8?B?TkNTZ0NWc1BPTmNvZHRSUFhmNXAxZGFjWDNlQWJVYmxKZVNSR3hZNENnZzdT?=
 =?utf-8?B?TTc5MFZMbCswclN0QTJOOUhhMTk5QnVZbGMyeVpPNXNjNUhSdTNJb0JSdk55?=
 =?utf-8?B?aTJGU1l5UTNmTDd6UklaTlRnUWEyaXJBUHAvMmlOdXFwQUtsbzBydWRQaGJI?=
 =?utf-8?B?ME1iaUhhVlhHamNrWmR6UW1PWmZMVU5CYTFaa0gzdWVlb2dPUEl3YkwyVkVx?=
 =?utf-8?B?c0o0bFFaYkRxaUV2aTVaVWx2L0hva3kwOWl4OGFJb0pSNndoc0JIa1FiWlhI?=
 =?utf-8?B?T2llUEpkZkR0Zk5KTHBQK3lBNWRFek9SdnpXRUczN3NHV05LazR4R1pNVGd0?=
 =?utf-8?B?V2NkWE5MaXZhTURqS0hpTTNmbFAzWmVWakNHekdTNFNGWHN2Y1ZrN3IrN1Uy?=
 =?utf-8?B?cWRWNjlXbG1rcEl3Ui85QzE1TVJLOExkbHQzZ1lOb0VQV3RKVTNjZWtlMWVK?=
 =?utf-8?B?YThwaWRuTzdYTHlMYitDaW9CNEU2OW9BQ05oN0l0SUQzOEtSZkRkZjZjUjRO?=
 =?utf-8?B?NTJIRHlkNkJZSUpDL1U1YU5hcm42NnVZanU2a3hrem9nV3ZqOEJ1WlhPU1dS?=
 =?utf-8?B?bEdIemdXNGxmYVpuNVhhRThwbjExZVBlNzRac29aaUZKblVrZTAxT00wY0FI?=
 =?utf-8?B?L29kUWltYWdUcVBlVUN5OU9VcXNDV2YvTjJxdktjbFJSUDVJUkNRdmNLYy9u?=
 =?utf-8?B?ZE9wVThZczlRd01rckNQRmY3TkIvT3B1K0pxSmplQ216ME5oZGFTL0o2Uy95?=
 =?utf-8?B?RkdaT2hTNjIvd1kybGI0NFdobSsyOWN6eFlIaTA2OTdmQTh2ckNnTjVFVGFl?=
 =?utf-8?B?MnNydEk0VnE5ekxNellKYW9SRkdKUjNlSFdKR0RueDBZNzZEWXcvMVZzZm1t?=
 =?utf-8?B?VFMxOCtzZG5SUTBVcDN5VWlCK1VCZUtBZDlWczlwUVErZEtZNElNK0tzZTBT?=
 =?utf-8?B?elVXbmY2bUJKNTdDSTNTMW1hT2RzSU90ZTdzZWx6aXRjcHRsNUlSN2l3alZB?=
 =?utf-8?B?d1V2TG1yV1F3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(42112799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly83Z1VJUitvVWZqTnBoc0JOeGRFL0h6djJuditsREdZdGdRbldiU1cxOEdo?=
 =?utf-8?B?Qy9aaTVMK0NyK29kcjRJZzIvMExHL3Nia3dEZVNJdWdUR28wVmwzWVF4MnJJ?=
 =?utf-8?B?NHIyOXJSM3Q5bXpJeURseXdNdFhzeXl2M3dvclNHcThLRVp2K1FnTGN0dEFq?=
 =?utf-8?B?MUM1ZXhweE5UdUxBZk42TVlJUGRNNUFqbGM0STExZE9ZZW83WmJaWWVVbTZM?=
 =?utf-8?B?RFBGTlBuRzdSR25FMnR1clpqdnZyQUtYMzlVU2J5M3k3dVFYWXBFeUo2QkZw?=
 =?utf-8?B?M1dwZjRmc2NiR1lBbXgzN0dsbnd5L1RSeTdaemRicEJDcDd3V2x4aHdqQUxr?=
 =?utf-8?B?dldFZmpoRUI4Sm91N0o1S0RqbTRtRWpRTlFsSC9WSWQrQkVRbG9zbGFCbTU1?=
 =?utf-8?B?S1lLZE9PUUtDNzRLUDBENnVQWG1Jb1ZaQVJENnE5UU1SNUhXZnhiQXZOSXNN?=
 =?utf-8?B?YWo1MXpmYWRyellWOG9jNHd5LzR4THB5VVVaQjI2ekhyazdMS2lwMDZONmlo?=
 =?utf-8?B?eis1TFdzbEdWRkxGbGZ6ZERwdWd6M3B3SFRvdmtpaWNzZkZGRmI4NlQvK0RF?=
 =?utf-8?B?L1V2eVlHRC9TdDF3YndpMWg0SE02NVplOEtvZkZRbGVWTjZ5dTVSNWM5UWl5?=
 =?utf-8?B?Mzl4TjAyazlWWmJSaXc3dVhtZndUS1VkLzZqVnJDMkNNV0V3LzczSDgvSWJ2?=
 =?utf-8?B?b2tRVGFkTHhHbXhFQ2duNDFra1VLSGFGalRyazRFUlBkOXA3MWpJdjFLeE5M?=
 =?utf-8?B?S2ZNSVdRV0R0MDdaTGhlTmFxbmszditEbEZlSzRvZFZKRzczYWl2YkExRFBS?=
 =?utf-8?B?UzZKSXNJelV0cGs4RXZXZEYyOVM4RERqcnVQOE5BTE5sNytwSDF6NW4xZjFB?=
 =?utf-8?B?emtzYXRtcmQ0dEtpTzVJOTZlUEVWZVhqMTZQcnhxUG1jK1E0b29hYkhiNFdt?=
 =?utf-8?B?SzM1Uk1veGZqNFFSeXdqYWRZei9wOGYraG9DOGNhVkR4dEVPWFlTMkdycTlM?=
 =?utf-8?B?QVppeFdkZWJLY3JocjBCUjlmQUJXN3puZ1U3aFNJdFczY0lBZE0zZjdqMlNZ?=
 =?utf-8?B?aFk5ZFpSa3gzOC94YVVHWnlLaktOVkZsOVhtUFk3ekN1RlJTVXpwYU81T3lr?=
 =?utf-8?B?NWEyUzY1aHRBTFIvNFB4WmxoSWVUN3BIcHYweDJvNzVTb1M4ZElkdWt5R2Y0?=
 =?utf-8?B?dnNSTExSWWcvT0ZYOHNkRXkzalZWZVRYalI2QXhMbnZNR3B1Y2RwSGFmS3d2?=
 =?utf-8?B?OTlrUmptSm9MUEVUSFJaL01YcnRNb1hqUFN2UHJ5RGZxMnRJMUswaUE3MGs4?=
 =?utf-8?B?ODhRb0dwNXpOczdqKzBjc1dMYWpYVVRMTzVOVzJjN0FXcVQzd05OOWU2SXdF?=
 =?utf-8?B?MjJoK0lnZFhtalF1U1R4bjExemhnK2JITWRzWEhEcVlRdnNTdzBpTExub05r?=
 =?utf-8?B?UjkvTFN6dllXMzVINXV2N3pPaE9VcFkwQmZNWlhSUFlOSkQ4K0xQZ3BDMVJv?=
 =?utf-8?B?US9adlFjRG9WWFhOdXp0VnovS1RCUUNmVy9Vdm51ZW0rTDJGK0l0eTZzMEM3?=
 =?utf-8?B?ZFcweEh5ZHc1aklYeTROR0Uva1J2V2V4VDE5MlNLekt2amJ4OG5kdVo3cjdU?=
 =?utf-8?B?dFc2cXlqZXVEKzJKWW5vVDdycFc3cStpZ0FlcXRSdExVeVRobkd4ZzJLaUxu?=
 =?utf-8?B?dHRSTVVQUm95WnhEVENIem9wY3QxZ2RKTkNBMnlUTHRXV1VXN244RzAwVEl1?=
 =?utf-8?B?S2hZRG5pSTkzRlF0TnBmeWZOMXJSZEdVeTlvUzhTRmwzOEJZb3FhU1NQS20v?=
 =?utf-8?B?aXEzOWM2OTRPeVhVUUJIQ3BacnJRSWxHb3J4RTcrUEZqV1hrMGZQa1FJV3gr?=
 =?utf-8?B?endMYU12dlhNei96amhRVHVuZ29GYmliZkVCY2ttZGhSMFhrZ0VYMnF6NGM1?=
 =?utf-8?B?cGtMTjA2dDBwMDJ1TlVBSWlybGo3UXUxTEV2UTErVVFJektMRkMxYnJzRlFj?=
 =?utf-8?B?NnEvSjFreDFNY1dwKzRRT2JVcjE2ajFyMVpvOG9tMFpLeGN6K2FBNHVaUWx3?=
 =?utf-8?B?NnRJbStPVjZ4bmhvTU5vNVM5aHBlZWsrb3p1S1BkOFdjVjVTWEYxUFVGb0ZT?=
 =?utf-8?Q?XbqBbzNzdx/HyV4/ylfAVNed8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB996E3FE5BD7044AE6F7F59910DC029@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eec5961-1815-4b8c-c52c-08ddee89a388
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 03:41:47.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OUxsAdtWaG1qMjAIfAYTNEpEZ6h0jppUncZTh3RviHkIOs5ulQuL6ydEfG80cVUxejV6Hb7rn2Fv42r8qn9Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF5FB3746AA

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDExOjAzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gVGhlIGZvcl9lYWNoX2NoaWxkX29mX25vZGUoKSBoZWxwZXIgZHJvcHMgdGhl
IHJlZmVyZW5jZSBpdCB0YWtlcyB0byBlYWNoDQo+IG5vZGUgYXMgaXQgaXRlcmF0ZXMgb3ZlciBj
aGlsZHJlbiBhbmQgYW4gZXhwbGljaXQgb2Zfbm9kZV9wdXQoKSBpcyBvbmx5DQo+IG5lZWRlZCB3
aGVuIGV4aXRpbmcgdGhlIGxvb3AgZWFybHkuDQo+IA0KPiBEcm9wIHRoZSByZWNlbnRseSBpbnRy
b2R1Y2VkIGJvZ3VzIGFkZGl0aW9uYWwgcmVmZXJlbmNlIGNvdW50IGRlY3JlbWVudA0KPiBhdCBl
YWNoIGl0ZXJhdGlvbiB0aGF0IGNvdWxkIHBvdGVudGlhbGx5IGxlYWQgdG8gYSB1c2UtYWZ0ZXIt
ZnJlZS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IEZpeGVzOiAxZjQwMzY5OWM0MGYgKCJkcm0vbWVkaWF0ZWs6IEZpeCBkZXZpY2Uvbm9kZSByZWZl
cmVuY2UgY291bnQgbGVha3MgaW4gbXRrX2RybV9nZXRfYWxsX2RybV9wcml2IikNCj4gQ2M6IE1h
IEtlIDxtYWtlMjRAaXNjYXMuYWMuY24+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDExICsrKysrLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggMzQxMzFhZTJj
MjA3Li4zYjAyZWQwYTE2ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2Rydi5jDQo+IEBAIC0zODgsMTEgKzM4OCwxMSBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2dldF9h
bGxfZHJtX3ByaXYoc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gICAgICAgICAgICAgICAgIG9m
X2lkID0gb2ZfbWF0Y2hfbm9kZShtdGtfZHJtX29mX2lkcywgbm9kZSk7DQo+ICAgICAgICAgICAg
ICAgICBpZiAoIW9mX2lkKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG5leHRfcHV0
X25vZGU7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gICAgICAg
ICAgICAgICAgIHBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5vZGUpOw0KPiAgICAgICAg
ICAgICAgICAgaWYgKCFwZGV2KQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG5leHRf
cHV0X25vZGU7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gICAg
ICAgICAgICAgICAgIGRybV9kZXYgPSBkZXZpY2VfZmluZF9jaGlsZCgmcGRldi0+ZGV2LCBOVUxM
LCBtdGtfZHJtX21hdGNoKTsNCj4gICAgICAgICAgICAgICAgIGlmICghZHJtX2RldikNCj4gQEAg
LTQxOCwxMSArNDE4LDEwIEBAIHN0YXRpYyBib29sIG10a19kcm1fZ2V0X2FsbF9kcm1fcHJpdihz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICBuZXh0X3B1dF9kZXZpY2VfcGRldl9kZXY6DQo+ICAgICAg
ICAgICAgICAgICBwdXRfZGV2aWNlKCZwZGV2LT5kZXYpOw0KPiANCj4gLW5leHRfcHV0X25vZGU6
DQo+IC0gICAgICAgICAgICAgICBvZl9ub2RlX3B1dChub2RlKTsNCj4gLQ0KPiAtICAgICAgICAg
ICAgICAgaWYgKGNudCA9PSBNQVhfQ1JUQykNCj4gKyAgICAgICAgICAgICAgIGlmIChjbnQgPT0g
TUFYX0NSVEMpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobm9kZSk7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgICAgfQ0K
PiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKGRybV9wcml2LT5kYXRhLT5tbXN5c19kZXZf
bnVtID09IGNudCkgew0KPiAtLQ0KPiAyLjQ5LjENCj4gDQoNCg==

