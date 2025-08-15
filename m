Return-Path: <stable+bounces-169698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115DEB2771F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 05:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A585E7A8F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F90189BB0;
	Fri, 15 Aug 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Aez+WhkB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KIaa+lPA"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD441DA55;
	Fri, 15 Aug 2025 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229840; cv=fail; b=O7FmG/aGw5o7y4Jj2Ypmtahd2kbSDuN/HJak61HjpWDL58BZUKCnGW+fTBiU4GR+Aws3Xf9CNlQn8jyBFDV+h/ZutJ3WiZTbqbqkPOYDMzBY2zWq3tTg+gBdMAWRT/PTT0eGUAjGg9F/hQECGE5Fqw+iNt+YicIwDYbts82ZMzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229840; c=relaxed/simple;
	bh=B57ebUCcR15ZoW5CFqH+b13XGk8RxDUj84K+G4qDOf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcO77v3wuOFSP6p8of4JllUJ/Ijhe5L9mI1BX/lelPKpF9AaOg6P5TWk6Vt1SC5XtrSZFRVEH1pSeU2Zw67HfQ3COmQ1/UuZygGquLFWyqITxkBG2Lp0xoJng1IhoJAnUhbvq/LaYlV0PQ26Qxc5tC6tPElSohKBM4TmAB1QDUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Aez+WhkB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KIaa+lPA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fa88fe82798a11f0b33aeb1e7f16c2b6-20250815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B57ebUCcR15ZoW5CFqH+b13XGk8RxDUj84K+G4qDOf8=;
	b=Aez+WhkBKeIDYS+7ea4uvthvt5QYgtJTk4G/kluW/VN0t/MHCoxBNp4g88Lv8qMuqHcPqH/y1wu5VedGdO/GEV0/F+Ybp9yD0e/gB/3wPcM+7+/HV1GB4SaG/FBHMYAf0b8JjiV0pynEKx2AFJaBEIWPY5Q6vgl8GVxzPVgxmUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:70f9b716-2de3-4c9d-aed8-3d2a64c4ad67,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:9abb3e6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa88fe82798a11f0b33aeb1e7f16c2b6-20250815
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1945446506; Fri, 15 Aug 2025 11:50:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 15 Aug 2025 11:50:24 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 15 Aug 2025 11:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va3WLTI/yQ9PmHL3w5kU93TLNQAN1WpgDACvcfFWmBPFgR/UghJB26ZQtcOb/eGxudQRSKhOo39LsnacxeTWvIGLuXllAd+EAp+iLivZM0eQoIY0KRxGkH7aUSBDHIRakZvvr7sPEd4PoWSf8/3NLnZImV4qCgCHcYQ7YqOCxrrshJRBvPdLOesJ2vlMl6zECJmPtB9NjkftGVLYY3dKSnAfDtyFT/LGNuwQLekWqDuDuqFSR8A7AP4vLJ3MuIDS9jgEL5Nz6EYawpSr67kL32xxJN+m10wjB19BJrO6SFWVj9aSXX3xorKHxz5r4ZIoJ5khd4BepW/1uSQZC2y8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B57ebUCcR15ZoW5CFqH+b13XGk8RxDUj84K+G4qDOf8=;
 b=Ok2tZfdHtCKHsxz6vIKY6q04rDiNXQMewd+2WwIDpJSJJWVFSsx61mqZ6yejjndyLxL/VmYTgWh7lmLb4fWbu8YcGMXQv7HzKDRXUm4L9bliQRWDgH9GhSJljVwyZByux0jaCwdqyxaOmDprTQ5Lx375VyZsVcbUi3STyWOxpqdE7xznTD+bKk2rhA/GagGsBtKUnvhYQ6gXwfen8pMfyo8EVyJywzfpyvJyIg5AeVo36Tl94biVwyoh9gx7MzM5IdMFsenDA4iAbbmwh02HHv2UfVq8kDGXUZ+w8i895khKxIr7ZRr9NKZfizqkeyi7DhfsnjQ5yOlhhrG/qZcrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B57ebUCcR15ZoW5CFqH+b13XGk8RxDUj84K+G4qDOf8=;
 b=KIaa+lPAVH+l4buZG0bV/nFsjm3IrjYTjLvv0MMjOoaqQk2YwuMpD3FzPHecPRvqs6SzZx7g8VY5o30OrG3ZFWLtYuc+aGR7CM0oLZMZkPcwjEebQ9RL3QXoaEXGWuJluvPKTrwpeCH49HmYFLlFLxbLivTn7mAOlv+mKaF2yTc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8588.apcprd03.prod.outlook.com (2603:1096:405:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 03:50:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:50:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "make24@iscas.ac.cn"
	<make24@iscas.ac.cn>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v2] drm/mediatek: Fix device/node reference count leaks in
 mtk_drm_get_all_drm_priv
Thread-Topic: [PATCH v2] drm/mediatek: Fix device/node reference count leaks
 in mtk_drm_get_all_drm_priv
Thread-Index: AQHcC1mJ/xQrkDatm0Wjr91mGb9yu7RjGL+A
Date: Fri, 15 Aug 2025 03:50:22 +0000
Message-ID: <920b1b9f566471efc2438c259dca683e02c87943.camel@mediatek.com>
References: <20250812071932.471730-1-make24@iscas.ac.cn>
In-Reply-To: <20250812071932.471730-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8588:EE_
x-ms-office365-filtering-correlation-id: 8e4aba0b-f479-47ef-fe56-08dddbaedc70
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YytUeGxjMUFkYlRRei9XQnR4SkZxeEZ2RTNuM3Z5TFFjSnltRmdBUHhLUG1O?=
 =?utf-8?B?MUxSTnp0UlRySWNWUTVmY0hqcy9hRG91UjhJdGNPSXNRSXAwbFdPK0REcjBk?=
 =?utf-8?B?dTdtQ2xTM2V2UmNsU2haeEFlTlZaVDFXOFJWemZEY3Q0dzh4aWpLRlBIN0Rl?=
 =?utf-8?B?eml6U0UrcXhlcXhvRTlIblh2SVpDR3RhNnRjYUZRdGlUZDFyT1FIRVF4YmYz?=
 =?utf-8?B?d2ozUjhCMTNVZDIveS9zY2VXa3VWemkveWM5VXZGdVZYKzZnYUFpR1N1eG5N?=
 =?utf-8?B?aVgza2tFTFJuN1VESjFzbFJvWUVIK05OZGJpUTZxcDdiVXpCRGVNSVU1aVpk?=
 =?utf-8?B?TzJ6b1p1NnRFRVl4bVlUUzJhaWRzN3lDWEFpQU8zbzgxNjRSeWd2S1RxTVRx?=
 =?utf-8?B?Zm10c3dZT20yS3E2QnhjQ3Y3TzNFaG9qTC91U0V1VkFmeU1IdG9FVU5mb21D?=
 =?utf-8?B?aURXK1Zpd3dTZEZneUxGL2lVNE9STC8yR3dWV091ZzJ2ME1EdThybHIvTmR2?=
 =?utf-8?B?dVlUVnAwUERqaHdockkwbHVmdFZCYXBscEVDTW1UcjMvR2FxRGdUWkV0TmVv?=
 =?utf-8?B?M2cvQTExcmIvVENEQmJBTHdYRDcxanA1aE0vclNoOSs0cVFyVVMxOHBKbStw?=
 =?utf-8?B?KzZBMHZSRmZtOEYyeVVscEYvMDVQQjVLTGE1NVM1dmJ6UTR3Z0l2U3prTGZn?=
 =?utf-8?B?b2l4UmtreGhqWmIwRVhJejAxVXRVemlLRnFwZ1FkR0JqOWtyd0VLSzZJSzJP?=
 =?utf-8?B?NjBTdzZXckJ4Rk1kODlpUm9kVzZmditidFdUM1JJS3BvanY2ek9LRkkxakZT?=
 =?utf-8?B?aGFlRTF6a1ZUTUpiTkFvRnYvZkw2ZUIzSWRuZWlLS01FUmh4UVEzM1BMTEZv?=
 =?utf-8?B?OTNNdHV0ZFFMcUpjZ0hLSXloSy9tNTZKdWJXMHNCV2ErT1ZiZ3NZQU54Zm4x?=
 =?utf-8?B?WjR3RWVCQ1FFTHoyMHVvSFNnSnJHOEY3MzB2WisxSjNPK0pWYUtqdlhoQzJG?=
 =?utf-8?B?QkJ5VDhCVVBUSzYxM3RvK2pyUE1ncmIwaUNoU21MalBZaExNQ1JtTU9sWmgv?=
 =?utf-8?B?RTl5ZmJzd2kycDdzTk1oYXpxTndaYUNPU0ZYdmtXL3hjeDVWeGlaOFVSZzIr?=
 =?utf-8?B?aW9SNnV1RzhBOFllOFl4VGswSzR2NkNjaFpxOEJDVis0SnBkQzVmYk1Qbms5?=
 =?utf-8?B?U0g1MlgzRlNacHljQXRhazRYVm1ITHRvUVpXNkhXN3pOQUZoOWc0ZDVrN1VC?=
 =?utf-8?B?VUJ6OW1tREZEdUpxUm5FMk1lUU5IaXVBMlF3b21POFJDd2haVW9qbUJqbnNa?=
 =?utf-8?B?dEcwUGJhOWlCMVo5ZGR0TGtDc1VleEFJbnVDb0ZWamtuaHNLNDJFMWI1UlNo?=
 =?utf-8?B?aW5rS0xEWDRiQ21YbkRXQWlaM3lrK0s2TCt0WFpVNDZZb3oxcDNNK2p4TDhR?=
 =?utf-8?B?WUplUkQvdFlmL1NRUytQV3RMY2hPYlVrb0thSGJ5THRrQ04zZWtqSGMzMGJj?=
 =?utf-8?B?VmNKdnppR2lQcmtxN2xWSU1PNUVKNXAxUDE4SUdRQ1BDaWVRZDlEZkhiL2dl?=
 =?utf-8?B?RlRtRkVNcENROHNMZTF6SnY5SzJ3ZUNqclZLN0JqdGp3R3BkYnFyS3Q0bDFj?=
 =?utf-8?B?WG14d2tYcHFpUm5aNWMyYldCZHdhQTkrdlgra3VOYmphYVVZWEMzN2FWWFpS?=
 =?utf-8?B?QWhEb0hmNGpsYmF0UlB2b0ZXUVN0ZkVrUmp5NXkxSjFOVU1pVGpCYTZwQmlP?=
 =?utf-8?B?aTJHWHhYVTBNVEQ3S2h5Ym41aGYxUEQ2N0RFTzlGRWRMQUY3RDVaNEVqS3F3?=
 =?utf-8?B?dm8zWExHSVRKc0MvUEZBWTgvcVdWWktMbG5SSnNTazFWU2tJWTFMRTBMOHl0?=
 =?utf-8?B?TThqNlBWNUdBVjEzdHd1Ui9yc3VKOXNIZTlXWkJBSWwweVYxZmZwanREaUJy?=
 =?utf-8?B?OW8vdTBkazJ1cW5BalFDMkc3NDgyalJiR2dIVW5aQnBndGNUamtkek9renpH?=
 =?utf-8?Q?D8YyXKxo35sEpDaHEo/wUzOkVWuWmk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXp1V1ZIQlRabHpEMzlZak9IZ201aWZXeEhPQlBIVVNVVmtTakF0Y0w4dWNp?=
 =?utf-8?B?UDF3MjlTRVVKZHEzL1dwVGhqNEQ2Y1ZNOFlYWmRBOFJtTTRyUzI1YU5lMWtX?=
 =?utf-8?B?N21XUVBoR1lOa1J2SjlFci92K21wZE16dGZQMGxvSy9kaUtXaHYwVUpBQ09k?=
 =?utf-8?B?VWxJWWZUT1FRQW5wTWlFWW1YYWkxY1kvODErL21McGpROEFTMlZrcG5JWjdE?=
 =?utf-8?B?S3o5MWJ1ZWNndi9FME1JbjlJTmgxeitMdTlFbm5JRVZYd2R4ZmNqbUdIc0E3?=
 =?utf-8?B?a2Y2Z2FlU2owbit1VVZ4MzVOQkxjY21kK2swTlVabmN3T01CVEdPL3NkbVRD?=
 =?utf-8?B?WTBQZVB0QjErcmpITGJoa0xjVERXRlN1dkdIU3lMNzFXaGQ3S05ReUhKdVBv?=
 =?utf-8?B?Z05DVEJtUnovZzhWLzN5eGxFd1VnbXFERUpTZUlPam4vYWM1Nkh2ZnBNQ212?=
 =?utf-8?B?S2ppK2JsbUg0WTV1eEh5dmJwL2pSK002VUJkdGtaMzg3TG1zSllxemppUFdn?=
 =?utf-8?B?aHBzMjRyTk81TnpkSzBQSStRTGF1dFFNOEFOMUIwcVV5TGR3R1pQNHlPb3Bz?=
 =?utf-8?B?aTNnWFV4VWFkb1U4VExna3pwcjBhd2h0VkFwK3pxVkp3Misvd0tjK08vWlp4?=
 =?utf-8?B?WFRZNWxnWm1GVG93WXlNWGV3QXFCdFdmbytPZ0V0dTlkY01iWjNZOVc0VTds?=
 =?utf-8?B?SWkvUlNtV2Y0OFVSYnI3cm9wMGducnR6U3pGaHNaT2ZXeVFtRitsUklYMVZz?=
 =?utf-8?B?UGI4Z0NKQjQyQlVUNHVwbVJzUk1KeDNKcHhWOHIzQkNPYS9XcUFNR2FyVnhQ?=
 =?utf-8?B?VVptY3JRNGtYQXZ3bDNyM1VLWnNiY2tzbnFLSExJRm05djJLUFVEaVJiS1gz?=
 =?utf-8?B?QnVLa2hhLzhlVzRCUkU3SXA5RFNacDlCMFNBUGJ0MURIUW9MK1NJZ2paNmVa?=
 =?utf-8?B?RTdqZmNFS0hkMzgwSXF4cGxXbll6MXJBRjN5bmdranBZdHFSdFg3YmZhbUI0?=
 =?utf-8?B?N0RielVrTDBoenNNaW02UzlIaEdEZ08yODVGNlU2YTN5MG9jS2hZcVdoTnZS?=
 =?utf-8?B?SzZVM2I0N0p3VlNXTnV5ZHNKTXg4YS9TOEgreExLU2kxRjVGRXdkaUJLZHRT?=
 =?utf-8?B?bmp5WjJSeXBEdzB1SERKRUtzS28rSlZPYVFhK3pGOVFibkQxaG83ZUw1RnBL?=
 =?utf-8?B?UG9QSE1vbVdwTmdEaHJOV1dxWUtMeUErNTNnRVg0T2VLWXJvenlySUJ1QTdJ?=
 =?utf-8?B?WWZuWUNBVEhKZzFnMzZPcW9vZUNXZE54QnluZm5ZN2ROaFh0TVI0TStqc2x4?=
 =?utf-8?B?RWVyOHg2UUQyZTZ2bERoKzBtYXZPdVlNQ2dPTDYvM0d4V0lYbnMzK0t0eHZx?=
 =?utf-8?B?Q2dwUUNOdjNoL2hhWDkvVlpVQ3hQMnZXc1NqU1Zpa0svU2YxMFVoWUVrbnFr?=
 =?utf-8?B?Um56QTdqSUlSSmljWEZjRjlDbXVnY1kwK0ZqWTNTK2t5R3Y4RHJVWHJuM3Vo?=
 =?utf-8?B?UVI2YzhvWTltTXQzajFiZENSY3JmK0FzSXEySWdYdytUS2VUelA0VEdHS3dH?=
 =?utf-8?B?YkhuUW5YYWxpMFE3amkrZG5qVDVpTnNnSjYwVDU2czE3R05tMTRnSVJGMHJH?=
 =?utf-8?B?MmxFSTc1bWhqUmg1SnlneE5nOHhZay8vbVhiU05GT2RvTlRHdE12MGZYTUx2?=
 =?utf-8?B?ZDBrUGJDS1VGWU1TY3E5Z3pMMnFnVHdscmw5bXdGZ3F2R09vaXZKRmdKTkFs?=
 =?utf-8?B?NUhCdG0vOUNsaldLbTZxeDhMT0NHckNVWUszdnoxcGsvazZKT1RHcFcrVWo3?=
 =?utf-8?B?ZEJNSjcvK3haNlpUQ2lKNW94ZTZ1anRTeWxabUw1cUU0ejA5akpEWXZHM3gz?=
 =?utf-8?B?Z2NHbDNJVVVKN0h3cVBCNXVoT0VaVkNoblJZdk1udkNuUFk5SFdBTXlERmJK?=
 =?utf-8?B?c3c3bTFpN2ErcWhmMDJCS1pPVTBFZ0xwd2JjUnBSVEFwL3N5UDhKNjlZQnR4?=
 =?utf-8?B?Mmd3dDFUeWI2ZFBNSkg4aFUwNGU1WlNxanVWUTNKL0N5NG5Xb0tKMHpnSG1a?=
 =?utf-8?B?Mk8xN0dsZDlNaEswOUhoR0ZsUnhhcEJNWHR0L05CWVFtQ0x2SWJSajhLWWhx?=
 =?utf-8?B?Z2R0YVdhelh0ZkEzeTdDa2lNS3N3RHZSeVV6MGdGeko4b2I2TURnSk85MlBw?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42EA048CDDB700479C9FADD5C039B8B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4aba0b-f479-47ef-fe56-08dddbaedc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 03:50:22.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uU9SylSUJdgFByvriT0ghnGBbMhkWfziylTy7tObfp+Sne9UQvUc1bmjqEkO0WTjjYa+aEUxxSuOQV5O+Yokzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8588

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDE1OjE5ICswODAwLCBNYSBLZSB3cm90ZToNCj4gRXh0ZXJu
YWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+
IA0KPiBVc2luZyBkZXZpY2VfZmluZF9jaGlsZCgpIGFuZCBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdG8gbG9jYXRlDQo+IGRldmljZXMgY291bGQgY2F1c2UgYW4gaW1iYWxhbmNlIGluIHRoZSBk
ZXZpY2UncyByZWZlcmVuY2UgY291bnQuDQo+IGRldmljZV9maW5kX2NoaWxkKCkgYW5kIG9mX2Zp
bmRfZGV2aWNlX2J5X25vZGUoKSBib3RoIGNhbGwNCj4gZ2V0X2RldmljZSgpIHRvIGluY3JlbWVu
dCB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBmb3VuZCBkZXZpY2UNCj4gYmVmb3JlIHJldHVy
bmluZyB0aGUgcG9pbnRlci4gSW4gbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KCksIHRoZXNlDQo+
IHJlZmVyZW5jZXMgYXJlIG5ldmVyIHJlbGVhc2VkIHRocm91Z2ggcHV0X2RldmljZSgpLCByZXN1
bHRpbmcgaW4NCj4gcGVybWFuZW50IHJlZmVyZW5jZSBjb3VudCBpbmNyZW1lbnRzLiBBZGRpdGlv
bmFsbHksIHRoZQ0KPiBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKCkgaXRlcmF0b3IgZmFpbHMgdG8g
cmVsZWFzZSBub2RlIHJlZmVyZW5jZXMgaW4NCj4gYWxsIGNvZGUgcGF0aHMuIFRoaXMgbGVha3Mg
ZGV2aWNlIG5vZGUgcmVmZXJlbmNlcyB3aGVuIGxvb3ANCj4gdGVybWluYXRpb24gb2NjdXJzIGJl
Zm9yZSByZWFjaGluZyBNQVhfQ1JUQy4gVGhlc2UgcmVmZXJlbmNlIGNvdW50DQo+IGxlYWtzIG1h
eSBwcmV2ZW50IGRldmljZS9ub2RlIHJlc291cmNlcyBmcm9tIGJlaW5nIHByb3Blcmx5IHJlbGVh
c2VkDQo+IGR1cmluZyBkcml2ZXIgdW5iaW5kIG9wZXJhdGlvbnMuDQo+IA0KPiBBcyBjb21tZW50
IG9mIGRldmljZV9maW5kX2NoaWxkKCkgc2F5cywgJ05PVEU6IHlvdSB3aWxsIG5lZWQgdG8gZHJv
cA0KPiB0aGUgcmVmZXJlbmNlIHdpdGggcHV0X2RldmljZSgpIGFmdGVyIHVzZScuDQo+IA0KPiBG
b3VuZCBieSBjb2RlIHJldmlldy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRl
ay5jb20+DQoNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiAxZWY3
ZWQ0ODM1NmMgKCJkcm0vbWVkaWF0ZWs6IE1vZGlmeSBtZWRpYXRlay1kcm0gZm9yIG10ODE5NSBt
dWx0aSBtbXN5cyBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogTWEgS2UgPG1ha2UyNEBpc2Nh
cy5hYy5jbj4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gYWRkZWQgZ290byBsYWJlbHMg
YXMgc3VnZ2VzdGlvbnMuDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgfCAyMSArKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggZDVlNmJhYjM2NDE0Li5mOGE4MTc2ODllMTYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC0zODcsMTkg
KzM4NywxOSBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2dldF9hbGxfZHJtX3ByaXYoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiANCj4gICAgICAgICAgICAgICAgIG9mX2lkID0gb2ZfbWF0Y2hfbm9kZSht
dGtfZHJtX29mX2lkcywgbm9kZSk7DQo+ICAgICAgICAgICAgICAgICBpZiAoIW9mX2lkKQ0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBuZXh0X3B1dF9ub2RlOw0KPiANCj4gICAgICAgICAgICAgICAgIHBkZXYgPSBvZl9m
aW5kX2RldmljZV9ieV9ub2RlKG5vZGUpOw0KPiAgICAgICAgICAgICAgICAgaWYgKCFwZGV2KQ0K
PiAtICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBuZXh0X3B1dF9ub2RlOw0KPiANCj4gICAgICAgICAgICAgICAgIGRybV9kZXYg
PSBkZXZpY2VfZmluZF9jaGlsZCgmcGRldi0+ZGV2LCBOVUxMLCBtdGtfZHJtX21hdGNoKTsNCj4g
ICAgICAgICAgICAgICAgIGlmICghZHJtX2RldikNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmV4dF9wdXRfZGV2aWNl
X3BkZXZfZGV2Ow0KPiANCj4gICAgICAgICAgICAgICAgIHRlbXBfZHJtX3ByaXYgPSBkZXZfZ2V0
X2RydmRhdGEoZHJtX2Rldik7DQo+ICAgICAgICAgICAgICAgICBpZiAoIXRlbXBfZHJtX3ByaXYp
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIG5leHRfcHV0X2RldmljZV9kcm1fZGV2Ow0KPiANCj4gICAgICAgICAgICAg
ICAgIGlmICh0ZW1wX2RybV9wcml2LT5kYXRhLT5tYWluX2xlbikNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgYWxsX2RybV9wcml2W0NSVENfTUFJTl0gPSB0ZW1wX2RybV9wcml2Ow0KPiBAQCAt
NDExLDEwICs0MTEsMTcgQEAgc3RhdGljIGJvb2wgbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gICAgICAgICAgICAgICAgIGlmICh0ZW1wX2RybV9wcml2LT5t
dGtfZHJtX2JvdW5kKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjbnQrKzsNCj4gDQo+IC0g
ICAgICAgICAgICAgICBpZiAoY250ID09IE1BWF9DUlRDKSB7DQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgIG9mX25vZGVfcHV0KG5vZGUpOw0KPiArbmV4dF9wdXRfZGV2aWNlX2RybV9kZXY6DQo+
ICsgICAgICAgICAgICAgICBwdXRfZGV2aWNlKGRybV9kZXYpOw0KPiArDQo+ICtuZXh0X3B1dF9k
ZXZpY2VfcGRldl9kZXY6DQo+ICsgICAgICAgICAgICAgICBwdXRfZGV2aWNlKCZwZGV2LT5kZXYp
Ow0KPiArDQo+ICtuZXh0X3B1dF9ub2RlOg0KPiArICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQo
bm9kZSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGlmIChjbnQgPT0gTUFYX0NSVEMpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgICAgICAgICAgfQ0KPiAgICAg
ICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKGRybV9wcml2LT5kYXRhLT5tbXN5c19kZXZfbnVtID09
IGNudCkgew0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==

