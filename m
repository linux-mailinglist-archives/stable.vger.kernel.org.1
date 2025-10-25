Return-Path: <stable+bounces-189269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AAC08E53
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 11:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12723B55A3
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789621DD525;
	Sat, 25 Oct 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ju9uRyzg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BAA3bgdl"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337626FA56;
	Sat, 25 Oct 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383928; cv=fail; b=OXkxfEmKg716XXdK1u1CLf4IQyZIaD81al3ym75Ljoolikjh8Sh24dNF7j1zTeVv9LLc//Y3MGe3XHaB7llava+ewU6uOayJFGMKEJ52RQDfspv9FoFVrU0HDTTNn/78bzPBV6r5u+siyITOzmKWyJLLQonQbNZKU6MKHhKXEYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383928; c=relaxed/simple;
	bh=6yuA6MtEypvjvSt2JD8x4PFVAklbrdC4W7qnjEeu3KA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFPy2Yj0zTd9Qo6tcU9ss7fsP9+yKlUlMAuR0LGND7KOPN5BFecCBHIhPoRB3lZ9bTProrApfmOtdtBxAzUzmP/vaboWb2cvWZFLU9whaYU/98hpq4ULig3iObrd/hQ8Sst/JvSqo03X74Ml6XWxJI4QSspcZOffGsHl8oMB0fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ju9uRyzg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BAA3bgdl; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95874c24b18311f0b33aeb1e7f16c2b6-20251025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6yuA6MtEypvjvSt2JD8x4PFVAklbrdC4W7qnjEeu3KA=;
	b=Ju9uRyzgQsYRLz+C/4YVs/hom3rsR+NuIZN33HrJIkoZitKqcLfJdNWSYzQrnmb8dQHoZvwJyZCek8vHKvEgbNrRbWcG4T8oXuweG6b+huAARW8NoI0GPV8d8a3APlbDHHl9wXCh8m9TKkG5XC2KzFai/glhSiKetO0kmhrNGEo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2b5ccbbb-caa5-408b-b293-877c19ff8a45,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4a6ace58-98d8-4d0a-b903-bc96efd77f78,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95874c24b18311f0b33aeb1e7f16c2b6-20251025
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 386159878; Sat, 25 Oct 2025 17:18:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 25 Oct 2025 17:18:33 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 25 Oct 2025 17:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb4LLLZ1HmgsolNdSzuE2qDOPWufU8Z9hCWG5GBE1+wqAZS6wpgxzTHnGKRzRBgUDTo8vMZWvvWwao9CGJRVuhYpeX1W9b6G5G0pQunnnnxgpkmaXGJikkeJXdYOGmM8DKX2Eb6p2Qw1b+mNeRdZUWgQkIuZpX8Usgdh1KDFONHAQD0FUq1ogN2UkEsis1OQuQ5d70RpnVXZVdvc/Cso1nMck6YuT4XBo+Is/KcMsK7CyjYvxwc3CV0t+NR/e89wx6I+amX9+MghVpgkhEeVdvD3Dby8sNwMH8ZUnv15zIJF4ylWZ7IUIuCzFkUb5jr3TET4VjleUXd5IF7TqCuHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yuA6MtEypvjvSt2JD8x4PFVAklbrdC4W7qnjEeu3KA=;
 b=qUGMNvKO4kjHHWNDjj7l3L5xGtnCmPyMS677ZQhWxw1cTC9HokchTuQBIfnGf2KhGVeKW+sHcgKaufg5OA3fxQtex4Nke8rj1a7l9yWv6u2m8JIJXUipz2hW4bA+vafTgcIMJWLb0Hi2DAGp7uXEcz4oDoruTakxUfqz0ts4x6GnQ5+CN8mdRrv0QeKng2OpmnL62MpH50vYwRmVjsv1/ZSiguP8wagSGduhM9SCKhUlw0blaUiJ6Uj4ceqLNtLxQpE8m1shnfbsvHqZ3wF2O3j0l+V22qCpuaPUt2jdxtQSsE+ufIfqFQuYSCsRH1IEFUgMrgfTP05TCoTbJozcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yuA6MtEypvjvSt2JD8x4PFVAklbrdC4W7qnjEeu3KA=;
 b=BAA3bgdlblpjB/RrHkFdJVdNRq8lN1JIBz8ke1fWvvpsE2q1wLPUb2PSIcY/zuebRB7IF076QdAhPJ0zUiIMj5pk02PJrQ7QW1Wgt/5tdmIr7JW4KkjZqArnvVfjvam/5ldzgTt9MstSnj4liKlhwpUlJ2FsxUYccC/RSfcJ/Rc=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6766.apcprd03.prod.outlook.com (2603:1096:400:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 09:18:31 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 09:18:30 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"johan@kernel.org" <johan@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j@jannau.net" <j@jannau.net>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "wens@csie.org" <wens@csie.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"sven@kernel.org" <sven@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 06/14] iommu/mediatek: fix use-after-free on probe
 deferral
Thread-Topic: [PATCH v3 06/14] iommu/mediatek: fix use-after-free on probe
 deferral
Thread-Index: AQHcQX4K5/AUWCz4X0S+LMu+GDv4FrTSnasA
Date: Sat, 25 Oct 2025 09:18:30 +0000
Message-ID: <7eb3fd3a200396ab5cd5b9227b31eeddab41db80.camel@mediatek.com>
References: <20251020045318.30690-1-johan@kernel.org>
	 <20251020045318.30690-7-johan@kernel.org>
In-Reply-To: <20251020045318.30690-7-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6766:EE_
x-ms-office365-filtering-correlation-id: c53e8755-937a-4c57-fb3a-08de13a776b9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eGprcmhhbHdJTFUvcHBHd1M2b1ZZNkNSSlo5eW5hM1lZOU9UZFp0a2xLbTdx?=
 =?utf-8?B?REZGZ3pteldlQTBMWHFPc3hNZDF1TnplWnZ4Zlo2dFk4ZlNqcXVzcGRXczJa?=
 =?utf-8?B?bmo1QnFsSXRHNllxZDBxVzZZZG1XS0ZZeVNrOEp0VkhrRXhEcjBnU1FyN1lx?=
 =?utf-8?B?TWN3c05xcmVnYlRTVTYxVzdIN3NvMUR6SXNOUzF1Njh5aTNKcitGcDFQWGNu?=
 =?utf-8?B?M0tyRVVIUzI0Q09OanZKN0xJbERmT3RKdDJBSWViRXQ2THVxY0lyeElZU0hv?=
 =?utf-8?B?RVhvZXl4cmVOWHVETkc2RjZQZmkzazhUVXZTMFlLWGpyL1lmN3dkeTJEd3U3?=
 =?utf-8?B?UlhKVCtVU0l5aFM1QU5WVHJQWkR0eTN2Qk9NaUtHS0x3VTRFbFQvWnoycFkz?=
 =?utf-8?B?aWdEblFKVCtBcWdtNXRBQm5DaEZnTEVNeEhPeTJoNmdMR1QwMjY3RWxLSG9y?=
 =?utf-8?B?YUxFT3MvOFBKYmxRTHVpSU5GWFo3b0NCRGZ3anQwU2kzY3lZRDJQbDRkRVZw?=
 =?utf-8?B?L0w1STBWWEQraEJsbUUxSkNldzJoOHdOMVArYUxyZVNYaThmOVY4dnZJdE05?=
 =?utf-8?B?SHVHOEl3emczMHNiOVY2b1JkTjlVRHhnZmZVS3RuY0ZCL09uNnFkd2lON3Ax?=
 =?utf-8?B?M2JMUWZMOVV6RDV6emh3ZVI0SEc3L3BBYU5UZUw2VEovdCtRRzhWR01lZmtm?=
 =?utf-8?B?TjdhSFl4NHdqeXhHY2Ftd2t1T24rbS9uK05yS0JWQlhPREp6Q0ZqMVhmMHYr?=
 =?utf-8?B?N1VZTUMva2RQY2JBRWlaVWZGQ0Vtek90L3lkTjJKd1JzeUFKSTY0MEdJSDhi?=
 =?utf-8?B?eW1yS3RjeFNhOEtaT2dlZHd4bGg1QWVSbjJnWHhBcW92WHNyVFJrTFVncFVG?=
 =?utf-8?B?QjFlNXdOOVJlMzNKbnpGdEM3WWF1UWd3ZlFZRm9hUlo0WkFaUG1EbkhvUlQv?=
 =?utf-8?B?YU9icklEaUJVa2ZjOGJWeVZhM1hud1lSZk1NL0U3RzlKdFVKbEJMTHpsTlpy?=
 =?utf-8?B?bWNVdXZpS3JWRVo0SzNueWQ1NXRSSmIxZDNabTNiYlBPZ1VqZ0dHNDVaQ0JW?=
 =?utf-8?B?WC9qYmZpM21JRkRPNSs5dkRKcnM2dHRqb21NYWFwa282V0RUWmd3bUppMkgr?=
 =?utf-8?B?czhRNzJWU3dKR1VSSVhnRHJpYlZGWTF3aVZrS3JzeVJQa0xGaEJSblFIOWEw?=
 =?utf-8?B?QzloTlE2T0h6c1hHd0VMR2hac2NFWWlWZ25jczJpa1NjTFdPdGxNR2JreVQ1?=
 =?utf-8?B?aHpZZVFzYllEQTZLbzM3eklSS3FVMEtmTWczcXRHWUdDeUxCRjVjd3dTb2xJ?=
 =?utf-8?B?RktTc3NiQ1pnMU1DSlpPSEx6d2N3VkJsbXI4TVlxSk5sbW80eE1yYm9LeDRL?=
 =?utf-8?B?TUNpVFo1cFJUVDF2bCtHeGJwR1FMU2owS1A2dkFoZEVYeVNIbC9rMDlJZENR?=
 =?utf-8?B?NUd3R3B4THlJdWorcDVQYndEd2NwZG9BeHBFd1dSRkE0aVVqbnNmb1FJRTBD?=
 =?utf-8?B?aUJ3V1VHZkNNYlJDY0NrVUhXTE1oOC9UeGwyWGhNRno5SFV5aTV1UHBuNGJT?=
 =?utf-8?B?b1NjR0ltYS92UjNuTTlZNzQwbHhRandsdzgrdmVNRzl1OGQvS2ptblFVdGFO?=
 =?utf-8?B?MGF3c3k0VzFoTG9TMTEzbCtCcVhsWHlheGVkQmtNOW5Xc0N5SSt0YUlDMVpL?=
 =?utf-8?B?VzlVOUFGVXNGb2VDa0dud08xNlNITEplVDNNejFkdzRzMWdTbnQ2Z1pJM0RE?=
 =?utf-8?B?WmV3VnZNZkxyd1lOY0wvdUJoZGE5U2lQTC83U2xyQ2gvbTVyVUNHcGZNNkVU?=
 =?utf-8?B?cTBPZDFXd1d2YVB2RTlsZXlsMDIvS255bVhLaXF4SEQzc1FjcFVOTFc5aFNL?=
 =?utf-8?B?Zm9zbkpFeEliWEI2cW5ROHZzQ0s4a3ZFUER2cjlTa1FEZStXTWlTcVE1ckpv?=
 =?utf-8?B?Zis3VWlSUmRWc3l4RGF4ZUliS2lKa29XbUVIS1FhS1NMQUU1S1hxbkVESEpj?=
 =?utf-8?B?OVIrNjBucEU4WnZHemtoUklPdjRwSUVvVHExMyt4bDFpWkNFUFRhQ203Kzlz?=
 =?utf-8?Q?m8Iupw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGoxNmhXTFlIOVpZQkhDMk9XSmFOUEx5Mm5hR29MUWV6WHRhcE84Tm1OQ1ZH?=
 =?utf-8?B?em44OUFHYnJsQ2lnUnYwdHhGSjZLeUc2QjNYa1NFL2pDeTc1ZTA1MXBxTy9n?=
 =?utf-8?B?b1UzVWVVS3BwWVVNajh1NTdFK1hIVEVYcXdFbEUvVDUzS2lONktrdGZGY29B?=
 =?utf-8?B?ZU5pRGdPcUplTnkzakJ2aXFlRXNUSkpHZEUvMGFuT3RmTmNyV0JueWhnNVVD?=
 =?utf-8?B?bG56Q2k0VTYvTDBvZWZJa3laYzF4eTl4T203MGp1aEQ1V1E5VWwybms5b2Jq?=
 =?utf-8?B?eS9zUmRVVWpyS0llcEc5QlJCdkc2S3p3aGdxTUl5VHczTXp1bk9ZWlFzbnhI?=
 =?utf-8?B?NGIydEk4VlIwMU1xdzBrNlhVazhXanR5ZXZhY1V4SFU1QlZLTjRPcytHclZ3?=
 =?utf-8?B?UlhsZWVKZG9NdDlYTGpUcHFJS1dhWXl1TEhPWVhyRmwwMWxoVmxoekdkRXM0?=
 =?utf-8?B?aGlzZ2JDRzZRb25ZQkg3VlUyTkNubHI2YnB6bHFLRUtZdVZLYnp1Qlk5SHVJ?=
 =?utf-8?B?TmVKNTdTVlZNYnI3ODRrL2s1eXo3RW15N2RqZU1GVW1NQSswNEtFcVNDN1dO?=
 =?utf-8?B?NVhQWVE1YWowQUJUa1hra0UwV0ZqbEttcVhLWWRkR3NtdnpJMkhsWmZCanU1?=
 =?utf-8?B?WmhPQWFYMGFBdnowS1QxRTNWVkpIUEtEZkpqc2x3dldiVDF3NktrVXVxSmpY?=
 =?utf-8?B?cTZveXpyVU1jeTZEbm5YZTZZaUpTVzgzWmpzalZwMDJicUVQWlhsL1dxUlkv?=
 =?utf-8?B?VGh4emZVSHVkeDRzU25UNERQRUN1UEM3WmNXZkdzMlJQdjBDQmtqenovbEow?=
 =?utf-8?B?dk94bmJhK0dIU0E4enYvb1A5M25wczRpZGNieWlQQmtsak1IME1EQUpBUU5X?=
 =?utf-8?B?SXI4YVVpK242a2pqWTBLeXZ1V2hWOXNVZ1pXUFd1Z0oxRkFXemVVRlk2S0RL?=
 =?utf-8?B?NFJ0eU52UjRDaUxhQi85NVZoSmtyTFEwSklMRjJSaVd0YWNydW9VN3hPc2Fa?=
 =?utf-8?B?MDgyZmRQLzN2V2tzYng4N3VOTW9iRisyZ0x0K2xVYS91UnNjMktsNXAxMURa?=
 =?utf-8?B?Qi9XdEpPeHQ4Q1RySXhWdSt2VU5NSldXWEVyTkFIbU8zOHFpbmdkQW1QQmpF?=
 =?utf-8?B?U2xXZHU1NUNTS2VWQzJzNFRPcStzdDBWL2xIdDNKYW91dGg2cHFSb3k3N0tZ?=
 =?utf-8?B?bkdwR2MyZW1YaW5pc1VKVzJMcmg3Q1RLSElXcmVkT05FS0pDejJLcXVWNFZr?=
 =?utf-8?B?NDlzZTJxLzZ2Tmw0QUtCY1NlTTQrcmpTSUd1Rkx1N2VOM0dUOXppbmpBM2wx?=
 =?utf-8?B?eVFyYjgwZitsaUp6WjEvTnpuMnNZWGdPSTgwZitmdlRmZWtjQUpEb1BzNys3?=
 =?utf-8?B?T3dTYUNvME9mdEh4NUJOK09qcE5HVGxwdGk2K1FHOFZVeTNMdysrTHRPbzlt?=
 =?utf-8?B?QXRxZnFvR29hT0ZEaG8xMm5zUlJvMG5tK1lNRUczNnprTUV2QVl5TTd5d2xL?=
 =?utf-8?B?VUJxS1Bpc0tsczhGSUxROHFKaWl3OHI3TUo2VVV5bUpIVUc0ZEdRWkxYZHRi?=
 =?utf-8?B?Q3RYV2tpN1hYejlyZWs4NGgwMkVwNGM0Zmx0SFhBKzgrZmlyNkpnZERJNzkw?=
 =?utf-8?B?UUQwRyt6V1VWRnYwMHR6b2IzL1o3TW9UTjhOYmJ2NENkcGhzdG0rT1Q2Z1N3?=
 =?utf-8?B?amIydWtlSHgzcElSbmREcWQwSkFUcXE5Z0RlNVEyT3pzUXN6TU92NExIT21l?=
 =?utf-8?B?VjNHWXpqc2JvRlJtUkRoa2RsRTlCWW1NdzRvdkF4WElOb0cwbUdadmEzb1hv?=
 =?utf-8?B?RTN0Rmd3QzRXRDZ1OE5PYVdvdG01eHc4ZURabGtUVkxva1c4UjRoYlRUTW04?=
 =?utf-8?B?ZnJMRzhycXFEUEh6Rllqc0U0VFVWbG5VVXdqYWh6SnhYYkxjU0ZWNkZBTDE3?=
 =?utf-8?B?c1h5STFTYnBJc29mQ2phdGRwUzRvUHdrdjV3aUxKSENMZllHeEI4aWtJQ1c3?=
 =?utf-8?B?MHFnN2NnYk1uelNRa3B4WWxrSWVSNytaWGZxSStuVVBOZmhUSjFFMFBzbm9S?=
 =?utf-8?B?VVdNRTAydnRDY3VhSFQ0eHgrcE1ya3hpOVUrc2JSZXkvZHZSTEtXYXpPNmgr?=
 =?utf-8?Q?vRYAI2uE7TRIlf65ZPL2DWArz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA141B9BAC759140AE084156A9BA7A00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53e8755-937a-4c57-fb3a-08de13a776b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 09:18:30.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfFrw2dtUcWoB5pcCfwvpz3sNu0KL7hrjt/OF1j7HYxvUwRLuROhE6ksvC2glcvrMQfr9XrhNb7r8MUIUOThRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6766
X-MTK: N

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDA2OjUzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gVGhlIGRyaXZlciBpcyBkcm9wcGluZyB0aGUgcmVmZXJlbmNlcyB0YWtl
biB0byB0aGUgbGFyYiBkZXZpY2VzDQo+IGR1cmluZw0KPiBwcm9iZSBhZnRlciBzdWNjZXNzZnVs
IGxvb2t1cCBhcyB3ZWxsIGFzIG9uIGVycm9ycy4gVGhpcyBjYW4NCj4gcG90ZW50aWFsbHkgbGVh
ZCB0byBhIHVzZS1hZnRlci1mcmVlIGluIGNhc2UgYSBsYXJiIGRldmljZSBoYXMgbm90DQo+IHll
dA0KPiBiZWVuIGJvdW5kIHRvIGl0cyBkcml2ZXIgc28gdGhhdCB0aGUgaW9tbXUgZHJpdmVyIHBy
b2JlIGRlZmVycy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGtlZXBpbmcgdGhlIHJlZmVyZW5jZXMgYXMg
ZXhwZWN0ZWQgd2hpbGUgdGhlIGlvbW11IGRyaXZlcg0KPiBpcw0KPiBib3VuZC4NCj4gDQo+IEZp
eGVzOiAyNjU5MzkyODU2NGMgKCJpb21tdS9tZWRpYXRlazogQWRkIGVycm9yIHBhdGggZm9yIGxv
b3Agb2YNCj4gbW1fZHRzX3BhcnNlIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiBBY2tlZC1ieTogUm9iaW4gTXVy
cGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xk
IDxqb2hhbkBrZXJuZWwub3JnPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KDQo=

