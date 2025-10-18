Return-Path: <stable+bounces-187818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C3BEC8D2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC71A4E7836
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483A242D99;
	Sat, 18 Oct 2025 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GjSeDKuk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YG6XiPqB"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A826F44D;
	Sat, 18 Oct 2025 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770279; cv=fail; b=Jw/qvg+DdcB621zjUS4/q1WLxii45VwVCmkAx4E2m5Zzn5E2eNMXI2B4qpByYuhGVCdrn/JOcT6HagGksbm0O6iyKnSyZkeA4pSfcJejA4fhiVatpC80/RTCo9Nl0FoWtxU/YMmkZ1W4RIOCTT176ULsQKauTLG9TelKPRImyLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770279; c=relaxed/simple;
	bh=SuDR0TT/r4AR5tLyXKznF537GaJKSuNJRfAjEWxaXuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dT2PwnoyONOpYIjFV0ex9iRQ3JXVAF3rr/K5yowTRpTj9DSiUYhca50MeSO9CXNV8jqLXtBKHbNazBO9CAD50AIcjO1AzTTX4n2n41CueMOqK+BMM+0gKLInlqtjoEn5djpfnP4EpfNcbXNGNByh0mFSBvaWVxMOp86FNPx6n7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GjSeDKuk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YG6XiPqB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d1c1fa3aabee11f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SuDR0TT/r4AR5tLyXKznF537GaJKSuNJRfAjEWxaXuc=;
	b=GjSeDKukx7mj87jvUe1SRJD18s2CkxkvFOMnSfHPtnI4yaWiQNc6cqROdrqo0GTiJw6XLi+vPuuPu2895OhVnxH+eXDYCHc/qtNyKVUwMnoLMSqEbI7PTnreFsKVq1ieP1m7rjn7utDW0yk/yfnvPKf5GClpDMdOvXbw+MuaiC4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6761c4f9-aaf8-4b86-b6b3-825fc9865013,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:1fab5886-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d1c1fa3aabee11f0ae1e63ff8927bad3-20251018
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1610321475; Sat, 18 Oct 2025 14:51:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 14:51:02 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 14:51:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRag3M5/6kgLjUe2reNKRo1ddB7nI/JXguen2orHTJAYzW+U0jBjyzfnM6wHtn49FYmeGQHMdjrD6XAfBsI1ifFiO5yrSJlQLJRMs+dyWyqR3h8EZx/mj73Nc6pTveNFKGPC62hqj+o9STzjAyAF8MqZWjk6zhLsBAcDSd+f2jeju4/x2qfBgI8xbHFPHtbCJSlrUargm64TA801xZ1j8ihZNqT7/GWQzlBf0PmXm4yEFxswVnJwuzMpjMcjd1mldgQ2U/GluRqcgTAh6cJM+vD9ziYyjLNgZso5mbAtXSRrRX8JQezTW6IP7ZcIiH8U6uxE29qax8t0PxtOYAVosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuDR0TT/r4AR5tLyXKznF537GaJKSuNJRfAjEWxaXuc=;
 b=VgwAcIJiL5iEGOx37vVVFcp9Bfb+mXuZbJscS9CzBk20MrfBu69mLHj1yaaMCE7Stdw7vVOz7NZszP7djojR8q8Jp8pOppZrhkmRz1zXjxhOnrcpqsNuM0KTbYEWfTjfkmL2ss2pabtt6wEjmHuJnBFpsDL8oJ/npMJbzya/f5DGaPp0vEabC/Y5dkGcaD6A9ch8sEuZM4PBRGPTH4C3WQbKVRSwyHK1itv/xYrefKopCA8oafnMw6SJ7PqzrUsCUHm/VABVPvqqntBoTe4ygMJonKKBjCxs3b0IiHgj3GJdk57pcuquDnXQlenIqCuJrXxz3ZdrKGy6oSjthxJpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuDR0TT/r4AR5tLyXKznF537GaJKSuNJRfAjEWxaXuc=;
 b=YG6XiPqBNXcmv9ali7ilIBGCFTXFVdQZ7LodsIk6/SRFePO02KgMWKhOk5xhC4psC5qRbJvjAZyUBaFrjqvdQtwwl9gsx+lbFJBHxo+QcIThfjebwk41WIGYYLunoOdWPlv1Eki4MvQo5zkXyutVO55NfJfgjk7gL4IL7JdrsIU=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 KU2PPFDD2810A4B.apcprd03.prod.outlook.com (2603:1096:d18::42b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Sat, 18 Oct 2025 06:51:02 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 06:51:02 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"johan@kernel.org" <johan@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j@jannau.net" <j@jannau.net>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "wens@csie.org" <wens@csie.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "sven@kernel.org" <sven@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 08/14] iommu/mediatek-v1: fix device leak on
 probe_device()
Thread-Topic: [PATCH v2 08/14] iommu/mediatek-v1: fix device leak on
 probe_device()
Thread-Index: AQHcN28noTlHQdaXXEeNrETUyTkkYbTHiEKA
Date: Sat, 18 Oct 2025 06:51:02 +0000
Message-ID: <6522536a1fe9e6368837fba3a41c68dca1a83b34.camel@mediatek.com>
References: <20251007094327.11734-1-johan@kernel.org>
	 <20251007094327.11734-9-johan@kernel.org>
In-Reply-To: <20251007094327.11734-9-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|KU2PPFDD2810A4B:EE_
x-ms-office365-filtering-correlation-id: 75cab5ec-ca03-4fa6-7934-08de0e12b3d9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K1pYT0M5UlBSZU9nWEQvZ09uOWJFSkFRaU54TklPTktaWEMzQ1RQcHdoYzRm?=
 =?utf-8?B?NXAzRGhIWForcCtwYWI4bEQ4Q0h2QUlhbXlFTmhQTnhVVXpvY1RVY3AxYWFP?=
 =?utf-8?B?L3I2QTlpZzdmY2ErV1lxdXRWS1NhbWwrN1RUZUxyamdqMi9FZ1pHR21wdkxQ?=
 =?utf-8?B?bmRURDVabHNIN3doMGhBdFZINzFDRGY4YmgwNGVRMjhlc2l5YlA5SDgxaHFQ?=
 =?utf-8?B?bWtWTy9JMWkvM3FBZ2hGTTMwK09CVGJib0JLYklvTnd3QXY0alVNZkpiV0M2?=
 =?utf-8?B?aGJ4NHV4R3BhS2FQSXN0SjUxSEM1VmJTSkJzb0I2VGhOM2VTQU95MEp2NmtJ?=
 =?utf-8?B?TDJVTnlPaSs2MUNqR0ZOTnRjOUxjMVcvakxhUmwzdC8yQk9sdFJlVXJhbHZk?=
 =?utf-8?B?TmVsYzM3Q0FZUlMvTUpId0ZCMkZURzM5cnBPeG1XL0ZBODFRZ0RBU2g4T250?=
 =?utf-8?B?eE45c2tpODRrWmNLNEVZN253ZCtjNkIvbHhHNkVkK0JPTVhEU2RJSE9hTFdz?=
 =?utf-8?B?VGdTVzVKRHZ0Z2xmbFdqTEMwUGZvTjlaRzRrNXNPQ2wyTnJibmlLcm1Ed0NG?=
 =?utf-8?B?R1lNc2IvRXY3U0lyTXlpZXlxMVpBVFYxeEJldTRtbDlRWnd4U1BGTC9KZkZG?=
 =?utf-8?B?d0dUMW0wT0s3M2pQaFVUeUFjZWpEeW9jdy8wZ1VLRXIzTjEyd0JDQmMxN2Jj?=
 =?utf-8?B?Njd4UVZ4SGMxbGxicG80NTNpUGhla0RiK1Jad2dubEoxaVd0eHNUQ0tsczJH?=
 =?utf-8?B?TDd5QmlFR0UyOE5YVFdLM1lDaFRyMmpaV3M5Z2pSNUFxYVNGQnF0OGFxWjFO?=
 =?utf-8?B?M0MvRjI3cjBabFhMNis3cFlWU1JKaGM4Z3FxcDljampuSFRGZUtHK2ZzZ1FO?=
 =?utf-8?B?Q1pXNWxtMFMwSXhBbG5HU2ltbGpLMjZMMDNyeFdsNlBXM3NwMVN2MGNuMytT?=
 =?utf-8?B?bXFROUltUTdWSWdpT24wYzNueVNqenFoZFo1QmNhY2tJakRDQkdOdzRRQko1?=
 =?utf-8?B?WG1QYjgrN3lBMEEyUkFSa1hnaGpOMzkvOE9wSytCQm90YkVsdkZQTE54OSt6?=
 =?utf-8?B?aGs2dm1EMGc0QnVweDY3NmpIZ0RKZHgyZUNRTU9PckJxTzZyOXZRcnBwbnpV?=
 =?utf-8?B?YUM3RGY1eUY4ZU15MlB5VHV2Zkw4bkl0cWFnYzNOQUFJZk9yUlZmZ01wQWkx?=
 =?utf-8?B?eThhbjl2Q1VETWFZeHJ5YTNFWmZhcWxSQklJb2ZmaFdxSVZFNllnbHVOYXFn?=
 =?utf-8?B?bkUyOGpveEpqeWhQdG9uL0toSktYRDVDM2pxRFU2citiWS9KTjhLZTZRTms4?=
 =?utf-8?B?WTZDOE80MHRIemxreVpqNU5jb0FDVXViVWtzdDVqN2dGVkFkaFVsZHc3bVJw?=
 =?utf-8?B?bmRwZStJS2thWENmYWZTYjRickQxUG40SGZDbEtvUURCR2IrbVVYdVpVb09V?=
 =?utf-8?B?dlBBaHZrVFJhZW1yZCs2SERqOWZ3ZHVGblNqcXlPVkhkd2pnLy8vR1ZIYVUx?=
 =?utf-8?B?VXFiRE9HbEtlN2VKSVZNb1ZPSGZuc3lIY1N3elRCdzlEVGRnQzRIcnJmNjlN?=
 =?utf-8?B?VEhob1V0aEVqVFBoSUhiVEFLd25XelNEV01iK1JjWDhWd3hCaEk3czRwNFlL?=
 =?utf-8?B?VjhKNTVzM2ZOUVNrbDZxRWsyTy9nT2pvNEJ3YUZsU2JrdnF1RXJmL1AvQTM4?=
 =?utf-8?B?Ly9xYWdRMGdzM0VVM1BIZVM2RCtjRmxCS3ZvUGc2UnlUQVgzaVRLNkhwa0cr?=
 =?utf-8?B?OUpXdW1PSEg1ajVDZGdRd2Vtclhsd2p3SW1MWS9PTmVJeURjaC9RcGZ1REEx?=
 =?utf-8?B?MThyWnRmSFYxcUg2ZjJZdDY3QzNtc2dQUWRJbkN5UUh6SU9mSXZLV2p6ZDNs?=
 =?utf-8?B?LzR4ZmQ0NVg2NEF1VG14TVd0c1BWMVlLTXRWS1U2NnFOUjRlZCtySVlTczlX?=
 =?utf-8?B?b3hXZWFuUkZLN2VSdkFoTGVYdGFvYUJxZGRtMkN1ZysydzRKUE43My9GaFl6?=
 =?utf-8?B?NzF6SHVDN0JzVGdnZFNOZUtMT0M3cUdHSGhoZWFRUmdvbGI0ZE5mWVIvK2Ra?=
 =?utf-8?Q?8mwKN9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHVIa0ZEb1FGdFlpN1U2dWoyT3Z5SitrcmRMNVpMckVzS05DUW9ZNktVSDFr?=
 =?utf-8?B?ZUlWQ2VtNk82WGNNZm5FM1FsUFFQeEZaMlNpU21yZlhQelVBdEJONk9Xb0Iv?=
 =?utf-8?B?dWFnZ1E0RlBvby9hRnNsZHpGZS9na1QrUnRyZFhqOXRycHBJZ3pKUFVvaWww?=
 =?utf-8?B?UlR3aWpmSG9DYVFSTVRaVlBpYnpBNE41UEMvTXNNTUFCN1RmRnRlVEdyY21k?=
 =?utf-8?B?RS84L2RWT3c0Uk5zM3Jzc2drbEo2R1llT1pvano4UE91WFlCRjRydSt1dmNQ?=
 =?utf-8?B?Q2ZPWk5tVmg2ck51V3ZvcWJvb0lXQWJNNGJWT3REK250MlVWK3R1SDAwRHdP?=
 =?utf-8?B?OUZtbGR5YktLRTFwSFFQUFJ2N1owbnI0M21kWlMvRXNwNmlxMHRRYUprOGJ2?=
 =?utf-8?B?M2VyZWJiTXd2Y00xSXIwTzhnTDdiRHloNHdsbWc1bUFsNFNxalpuWmFuRGw1?=
 =?utf-8?B?eXltYjlUU055bHZrMVUrVE5lcWZCSGJFWDNYZVR2SVpIRE5VZ1lqalJIdUdV?=
 =?utf-8?B?MzZ4SGJmNGhZb095alBSVDVhUFVpWG1WTEVOaVBlS2VvVUFNQU9kSVBUOGpx?=
 =?utf-8?B?Ty9ab2tCUHlzdU5idDFqQjBZQUNjeitFQjQ2Mm5Ic25vTElJUDJKWTlGRm9r?=
 =?utf-8?B?WjZFU3BMbTJRcTFCK1FhUGl0V2VoTVh3eDZwTURFcTVsbjU2NEtjQzFZWXFJ?=
 =?utf-8?B?RUQwbUpBTVBwVGJKeDExK29KdmltekJPK2R4c29nTnRqemhjRjdtdVNZdVha?=
 =?utf-8?B?ZHJ5empaUWN1TW5IZ0NGWVBka0ZpckVGT3p4ZWR3WmxMSW9rRElyNGhVdk9K?=
 =?utf-8?B?QnJZZjNrMGtKRngrN2RuL3o1V0g3ZEEwY1M4cTY2bUlyYmY1N0hMRExGMXlh?=
 =?utf-8?B?M01lZG0xNUZhOS9xRkQzTHJXczZJV1RiTXUrRzBYNzZnbGJtVmovUUxUSE1x?=
 =?utf-8?B?L3AvRFppMGxQUVpEdi9rLzdYQ3grSUtRVFRBTDJUSzFrMUc4dCtvVkI4MWdm?=
 =?utf-8?B?VEpuQVVDeGZzTHA5Qk1oakxMdmRobFE0cmVZbklMd2NtYjYzbFEzNHVNWjRS?=
 =?utf-8?B?VVdYL1l3YTRNV0xhaFU4OXRrWW1UTm0xbVdBTVhRbXRIMHZZTHBGbDRBa2NG?=
 =?utf-8?B?dm9KKzFZVURtYWFRY0VmbUhiZzRVT21mZk1xdkRzTzdKYTVXL3dUdXpZYWt3?=
 =?utf-8?B?UEZqZDRQNE9XYU9LZlJSMkRlNGlqdXNPa3A1TnFoUDBSdlRwOEdYdXhhWmUw?=
 =?utf-8?B?SXFkTjRCUGREMk16aDM5c0t4dmY0QjlKa3RnUElRYmU3Nk01OVYzeTdNS0s5?=
 =?utf-8?B?b3doZXlQbENoeDNvWEF2aE1XeG5KS2plQUdoSjExYmplMnVkbDNqa2FsQVky?=
 =?utf-8?B?c0M1YnhxTUVHdEtoUjYwZmluYmpBYlVpOSt6a1JBenNXQzNGZ2FiSmJJdkhB?=
 =?utf-8?B?OWJWL29WZEVZY0w5dkVPMlhmeXYwQmg0U0luek1pSHNVem16WG9Zb1VTKzZK?=
 =?utf-8?B?cEhiVTl5S29wYmFsYk9hNGw1VHhwSlRybEp4RDd5MFQrL1VtYTF4YnZPMmJO?=
 =?utf-8?B?dHUxOFBLYVRHbStzWk4xZkxPVkl2NDFPS1lvV2NoQ1d0R1NaZ1BWNlJzVGtH?=
 =?utf-8?B?c25YWmthcGhrTWMrRlkwRTNxMXRhL3lHMSt1WUc4Z3c4TmJvSDZlMklSN1Nw?=
 =?utf-8?B?M1h4RXBxb0hTZ3F5c3BXeHZmQUh5MmtPc1ZQODNWa2x4Rm5xREM0eXE0LzdH?=
 =?utf-8?B?R0RvUFBsYnBSR0NZRVpyejZVMHh4cDBBTzJXdUJqbTBhMVo4Q2RacXBGd3pl?=
 =?utf-8?B?blkrWjU2WGRoMldET2dYMWk3MTBLS0JldlVMQkFQdVlHb21mVW1HRkh4dGRi?=
 =?utf-8?B?STlXS2hudmpuL2UzM0hEUHdZTmVTS1BEQmlUT1FNSUEzRGxJTXlCSHZxNld2?=
 =?utf-8?B?cmdCRzc1SEpKZTV6a0xrRWxPbHZnWlE2RGhOa0xQSmFDazRhR25TQzVlK0Rl?=
 =?utf-8?B?WTJKcmR5VnNGVUl5aVlFYm0weFVpSlZXRkJYcEY5cDBXQ3NURVNUV0RmQW5E?=
 =?utf-8?B?RHFPajNDYUFLc0FUWVZCMU1SUitjeUg5NE15YU1SY1lkQW10Q0pTcjB3WGdE?=
 =?utf-8?B?S3FpMWZ2eW81eWhsekN4K0o1NVYzeXJieW5sN1poaU4rMW9BaVpuMHRtS0Yr?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50597CFD6D74CD458F2CFBC34E5AFEAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cab5ec-ca03-4fa6-7934-08de0e12b3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 06:51:02.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he3v+XpNn/6vyQOpa3Zqc4MQRm467B69qIWX2JFIRowmW5gBoAR/mDYJonzqt5MmrMODRpJsWrG2V2AZVjfO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDD2810A4B
X-MTK: N

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDExOjQzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gTWFrZSBzdXJlIHRvIGRyb3AgdGhlIHJlZmVyZW5jZSB0YWtlbiB0byB0
aGUgaW9tbXUgcGxhdGZvcm0gZGV2aWNlDQo+IHdoZW4NCj4gbG9va2luZyB1cCBpdHMgZHJpdmVy
IGRhdGEgZHVyaW5nIHByb2JlX2RldmljZSgpLg0KPiANCj4gRml4ZXM6IGIxNzMzNmM1NWQ4OSAo
ImlvbW11L21lZGlhdGVrOiBhZGQgc3VwcG9ydCBmb3IgbXRrIGlvbW11DQo+IGdlbmVyYXRpb24g
b25lIEhXIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgICAgICAjIDQuOA0KPiBDYzog
SG9uZ2h1aSBaaGFuZyA8aG9uZ2h1aS56aGFuZ0BtZWRpYXRlay5jb20+DQo+IEFja2VkLWJ5OiBS
b2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hh
biBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25n
Lnd1QG1lZGlhdGVrLmNvbT4NCg==

