Return-Path: <stable+bounces-195151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C46C6CD99
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 07:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A53CE2BF8A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82663101A0;
	Wed, 19 Nov 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UAYZ5czU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XF4Y17VN"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DD2F5B;
	Wed, 19 Nov 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532169; cv=fail; b=kRDf13ZAK7T558dKPu6xAqooQNA4Tj8fOWjycYQypqPllD+XSIm+ipXiVxnkPbCVqQJAjniKjUq2HjH38tRjuZQPkVpPFU9gO7Td8h+nOpZfnwR5H2NN5bDIG+j1J4d2Y42LEKPzoGA3gEXms9ztDtyBSpW1vxYHwhaKBjSi0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532169; c=relaxed/simple;
	bh=tjLNNMdMzk1Rcwa8pv1QZ84/Cf+BtxwArCUEMuYaKzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soKZb2n6Qi9mJdmavUsZ3pUVV6S+vFS5gDN5k3okI6T9SNMd+6ugsxNXp7etJvSa2HtHijNKraAQ5QnJeWJePD62KICYxyXBDlqzjjPoSOTBI3/bzqXeKIRK+znaWUoeehkMoGGNDDu1XfJ10thoYc5wtN52MLuUOZiDm4+FK9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UAYZ5czU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XF4Y17VN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5c4b6fcec50d11f08ac0a938fc7cd336-20251119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tjLNNMdMzk1Rcwa8pv1QZ84/Cf+BtxwArCUEMuYaKzg=;
	b=UAYZ5czUcPUO8wNYv4OEmr5kPq+M/agZ5gxQuVKWzkpDyAMhr2AUPYADw0CEM1ia1zG0EKJKcsCDC83JfSiFyg8hfop0krNGUWJzILXVD69nmrBbujNk5XfdnD9NL+twsYnJsUZ0zS/+PQERKK7FqaQ9jm2QHt8zHkTUqt6KCrY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:321e13a3-3721-4a0f-8e5a-299c32077748,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3220cf82-b6af-4b29-9981-6bf838f9504d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c4b6fcec50d11f08ac0a938fc7cd336-20251119
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 962899813; Wed, 19 Nov 2025 14:02:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 19 Nov 2025 14:02:40 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 19 Nov 2025 14:02:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9+4Opfo1IfAXAXhsUBieOEGR1cIiMElxhdskwbwyWLkfAIc0/zSAzw8gJHcUaBKzIf+P4D/wAEntQWhBgaKEnJCz3mlWwzdsSKSasLXmpknPzKbU4fSowY7oywXlnbyl6wfM99nyTO2Chv720CMxaHC5+ADM3/LOzFv/TM5kVSLu7tQ1+EKcmFogomCM1YSO8zSoM6DVhQyz+gec/8B4KRpo3CniPKbPwN+H9Fam3fpp2zXgbnnj9ezySNvHoZW9f52izDIAuJP2d6i1v455aX8kZuH9wgQftcWks3ZNqRdVIvT0ZPVTZ6uh7Gel0OejWJV/8JH2GroskupLE10+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjLNNMdMzk1Rcwa8pv1QZ84/Cf+BtxwArCUEMuYaKzg=;
 b=WmtzY1T5iXJ563AAmQL/hIWv0GZ/9LPjQFhLg89WE7Hqbvg8+25D69Wb+hOdpOULjYLyf7QXPVxy0BBn+C41qGak84/ZTJs2b+KCxQffzf+0kuXBhr+xvH9I19EoipLlHzNQF9WutsAyVamXfOb2KoIBS82/0muQCSwXw3Ve7YltjYBY3tGw8NytTtFubW0R7du1c/eBMUqJyFydP84EE9sCsrgGhmKRBTOytzTlOjYdm7d0/pF7gdVurj9ikdP8rLjwY4cb5BwGPkNgeX4Yijpr9zJz/uikAYi61bHvRcULcxKJN7wMWBxySdEztkMuP1s9Rc6B8/DMBqDJ+KUE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLNNMdMzk1Rcwa8pv1QZ84/Cf+BtxwArCUEMuYaKzg=;
 b=XF4Y17VNcDnycYQZzD92EErfDOkVdZIrWg9OwaIhK4LpdOsHe5a+j/a26Y2lcqDrN5jwaA4EHzWV6Ne0kuI596761u94ZGUkTm1MfRhYN6roLBahO95qIxrN7PLk7KSqgJNx+E8uUHlYWoeziVR3NA9VNAny7bsCHt1aIdJrBEQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6793.apcprd03.prod.outlook.com (2603:1096:101:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 06:02:36 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 06:02:36 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"linmq006@gmail.com" <linmq006@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "msp@baylibre.com"
	<msp@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"granquet@baylibre.com" <granquet@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Fix device node reference leak in
 mtk_dp_dt_parse()
Thread-Topic: [PATCH] drm/mediatek: Fix device node reference leak in
 mtk_dp_dt_parse()
Thread-Index: AQHcSKTun0xc51eevEW3zw0LP0A8MrT5ougA
Date: Wed, 19 Nov 2025 06:02:35 +0000
Message-ID: <3f51d21db8d91957ffb618856635595ef959049d.camel@mediatek.com>
References: <20251029072307.10955-1-linmq006@gmail.com>
In-Reply-To: <20251029072307.10955-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6793:EE_
x-ms-office365-filtering-correlation-id: 70174532-ef0d-4fc6-6fc2-08de27313cda
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|42112799006|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?R1dtZkhYTFVVZkZTeHVUN3l2c1ZqTFZvL1h4eWlVNXB0WkZEM211TWRPa1pa?=
 =?utf-8?B?alZOQWR5b1doYjJwYk1HeGpMVjc1UVBaa01vZ2V6YW5hSzR3Um0zQzJrVmZK?=
 =?utf-8?B?Tm9pSkNWRkpFOEcxUlFuZXpSQ2pRaTFxR25LMmNGUEFmS0htejFsY1Fnci9X?=
 =?utf-8?B?bFBQQXFsOVZIajRZTTR6VVMvSENpWXY2MUYxTkNLV2ZyS3JnUnpuQTZFejdO?=
 =?utf-8?B?QlJSellLVU12aWVjRGdxSFJNQlZDV01iV0N2c1NsS2E2ZHZnQ2hxbGl6WTlq?=
 =?utf-8?B?cVE5a29XMjBsWWpyUlJHa0VQVHp6bDkySk5YcGl1WDFMU0FYckR6RG1Ea2V4?=
 =?utf-8?B?eDV0bUNPRTQ1Ri80R0tuZUtQMUxISVREelpYTUlxNk4zSm1DZzU5bzFVQjdF?=
 =?utf-8?B?MjRMQ1o2QnQ1ODRiTG9WNms2cW9DUWdEUU9IUUlZOE5pZFJwZDIzVnFta0cy?=
 =?utf-8?B?MzVjN1ZJblQxNkMxVGx1OEVodFZqS2Vlbm1ZYkRvNDl3a1doY2pDdFUyNU02?=
 =?utf-8?B?NVUrbEJUMFA3UlNIc0Vqc2ZMeFBpRWlzN0hXMXhGOFphTDlGdm0xOEJ5SlEw?=
 =?utf-8?B?dHZvMVNwNUlDRVprMUZsdzlPcGJQdkdBNlBQMG9IUGhicWZnWUwrMG1rUFhC?=
 =?utf-8?B?Uk1pZGsxU0xOd3pPZzd5UWlqYWJIUGtzZlc1Z01oZHhkQUkvVjZnMk0zUFFG?=
 =?utf-8?B?VG9lQzAzanRiZjVDUy9IUVZySVVSZ3U0dWJXZWpXMzNRcElzeW00ZXpBSDlv?=
 =?utf-8?B?T1p6Y3JLSU8rc0JSVFp4NnNXUmdncldlM1hLV1M5ZmUxdlZDbmRmNWl6Q2gx?=
 =?utf-8?B?UGRkNjNVbGs2eHFBSWZOUXkxVHhZc2VtemRqbUsxS1hOZStQcnN5ZzRIbnJI?=
 =?utf-8?B?eDNNRUk4UzRzMFQwcm5YY05MN0ZHMDMyWVdNMmFEbExwalc3RFZsU1VyVEZZ?=
 =?utf-8?B?VXVHOXdYV2hRcitVbmd0WDdML29ibjNqTEZ0Rjc3Z0M4cDVNUUgyNDh4azJt?=
 =?utf-8?B?ZXhId2NZM2p5Szd0V0FhcEZFdlVNLzUrVFZJeDBQSXIxbUxlZmxFcWw2RExZ?=
 =?utf-8?B?bDVWS21mWTZ0bEYwWGZRaWpsTHpwUFoyZGxCYTNjTW1Da1ZYK29NdFl2VVZM?=
 =?utf-8?B?cVRzQlZlZDdKNmRwYTRram5DVnloN1JteWNBbGQ3cjNTenZWcW5ZTk1BazFZ?=
 =?utf-8?B?ZE1kQTY1M3phTFV0NGk1VW9taEM2YmRJVHZxL3ppVUFWdVlwRXV0S3l6RGRm?=
 =?utf-8?B?aUZPcnUzWDd2V3FxSkx0YWtuRnJBRGdGZ3hmSFVoOThpWDRxc1VtSlo4WU9S?=
 =?utf-8?B?OFk0ZVMyQXdyQkxYR0o5MWRmSU45aUxTVFhYWmJOWjQvQzlWb09mL2Y0aU5o?=
 =?utf-8?B?emNtaHAyNitCNHlzdnNobnAwMHVaelBWMGRZbXM1NVlUZE9oR2hIL216SVMz?=
 =?utf-8?B?Y0VkZ2JxNWxHazhKV3dXcEJRK3FFSStjTjE0SlNWL25UNDZCKzZ2OGdaZS91?=
 =?utf-8?B?UndDSk5NdFZaMS9tMDJVTFRPSnlzb1ZnWU1XbEZLZy9rNGU5QjF4dUg4SFNt?=
 =?utf-8?B?UVEvanludW1LSjJWUzRXRXJvVjYzMDdheWo1QnRrTnpCcU9YQVdwN3cxYU9o?=
 =?utf-8?B?STdoUitscEdDZnJEVWo2UFE4dThnemdOdkF1VFhtMm9QdVg3T1d0UnY0RnM1?=
 =?utf-8?B?eHBCZjdUbkhXQUJtaUxsUDhnYTFkSXljYU5hSG53RGs5Q25ka3FERS9tZ1ZO?=
 =?utf-8?B?Qm16K0Eza096aEpRdFBCZEQ5RGVhYjlSdjBWbnlJMUdqeXkwTFBlRkp6Nzlt?=
 =?utf-8?B?SGtEbUU0eC9EQjQ2L0NVY0VHcGFYOWVLNUh0Um9vSEg5dlNnR0FFK2M3THhT?=
 =?utf-8?B?ZmNRVERSV3N6WlNhVEZxUWZPcENKRmpVUjVldE1QbHRLYjN4UllFQTRoUVhO?=
 =?utf-8?B?bEZINlM0VDdBMXBDd1AxbUk5WEtzbjBUVXJZNlEwTHF4c2k1SDRXNEFCZVA2?=
 =?utf-8?B?RGMyc2ZiTTgwMUxxRUwwNDJ4Q01oSUo5S21NR0dGa0YveUYycnJjYzFYL0kz?=
 =?utf-8?B?SG4zeUZFYkZXYXhVRkpOekM5Mk9iMFR2bEI4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(42112799006)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjM0S2JKVkppdktXU2VNV3pyaGkxZXl5eXhubmNLaXJnOVcyNUJIVGdXOEhz?=
 =?utf-8?B?Z3EzN3FGMHAzdjJhTWZPcS83MTQ0c21EQ2VJRFhpcFJSSWZmaXN0RFRKaENq?=
 =?utf-8?B?anUwYmhKQ2RIWm15c2dJVzhhbVU1MFR3V09wZ1NIUGxsMVh0MmhVbTY1c0dQ?=
 =?utf-8?B?SlJVbE0rUWIyQzlPcnlXZmppUG0rNUtrTnpXTCsvdTJQZzQ4TTJWYVMzakxn?=
 =?utf-8?B?Wk1GZXEyQW10STVhaWNhM1pDREk4NksyeGIvNlY4NDVKbDZSZERsTitYUGQ5?=
 =?utf-8?B?QUxqeUNjK2VaN0FVSWlPR2VwbmtOR3VpbTY1QkRhd0NRb3NkcGZwWVJZZHE4?=
 =?utf-8?B?c0NkRjU0Q0l4SmxreitCZlJjeUlDdFVTcmJEbnF3blliMURRN0VIL0dCaFd1?=
 =?utf-8?B?UEF6SjIvRnd2V1QvQllkYUUrbTNya29XQlFFNU9BSTVVZlprWjFZa0dHTlY0?=
 =?utf-8?B?S214K25nU3R0MzBUQTlRVmdISTRJNmN6WHQybzFhUkNZeHVyTk15dmJrdXdC?=
 =?utf-8?B?anM0V3NsUGJvNENveWd0NzZkVUN0eVVMZVliMHFRZW43dS9rOVh5UjczbTR6?=
 =?utf-8?B?N1VET09yRXBMbkVhcmRObzlXRDZBT3BpblZMQnZrY0ZVY0pKTjhPdk9nSWtD?=
 =?utf-8?B?NzgyM1ZrY1V6NENoamlNd1JRNVhnU2dCczlBUlpjQVlZNS9GcEswb29ITk1Q?=
 =?utf-8?B?VjBLT29jcVdraUVlQngzRmdqa3FWUCtSa2Y0ZzBmQkp3TzE5R0tlWVVoTHNZ?=
 =?utf-8?B?Si9BTEkxNnU0NzlBZ0NzNVF4cW5QVE16TVhaZ1Y5MWxnUU9GTjkyM21KZUMv?=
 =?utf-8?B?WDk0dUY1My9KL01rdDlmM3poV28xbDdsaXJ6Z3VlYWZuZytPNHQ3Y2NjaVgr?=
 =?utf-8?B?M1owNGRhME8waGkySER3bTVVVGlzY1ozUFlWaXdUK3QrV1VHb2NFSEZqTUJv?=
 =?utf-8?B?ZmNsRGZMalk2ZktONURjQ2IyUk9JWVNHRE1XREhxRHBkdG12VVZxWVlLaERh?=
 =?utf-8?B?UmN4UHNFa2RyS2cyd0tidnlTeHVITlRWeWNvb1BGZnJyU1QyODdpektRVWJy?=
 =?utf-8?B?ampaOXZZK0txdXlhMXlEUHBUWnBZMUhWOUF4TE5LNThVazVIcGNoSE12SEF2?=
 =?utf-8?B?emUxdWRMWEVSRUdGejhrb0xYUjZQRGJ5SlZOT29FM2k2TTVneENmQTdQekl4?=
 =?utf-8?B?UXo0OGpPQnY2OGd4QWV0aFlPV1N1OTFYTXQ2dWpyeGk2YTNxc3RTMVJFNFdB?=
 =?utf-8?B?VU1QOEFMKzI4RWVPVHdsbkhqWWU2TDE3Zlp5MVFuRmZQSENDTmZMdGlrcXlJ?=
 =?utf-8?B?UEJGbVlFVWszMWlwbHlmSmI5OWNiWDA3dUFReXI2dTNwaTFwZDBucVlOSnpS?=
 =?utf-8?B?ZkNiK2MwdnhqOUtvWDBYZUZRQWd2RnNIbk5WRDhRTUwyUHFSNnhZaC9YNjBs?=
 =?utf-8?B?Q2p0aktwakRXU1lIdUJPeVB2L3dWSkRmbE9ENVpScWxMNDVXbmRrWDFpSDBv?=
 =?utf-8?B?TnZ0RTNuV1dtTHVSM0NDOTI1WWxYczloY3k0c2QxMzhMSEwzRTN2QlBHWnJK?=
 =?utf-8?B?THEvMGZXSHpocTNqVTI2MmNKUU1wdlhNOFNsdlBTWG5qVDJ4YVBoRjdMSHcw?=
 =?utf-8?B?S1RQM3NJNXIzVGdNYXRxYTBRUElvNXIyd0tVU1lvanY2cmtTaWFjOFZFVXJU?=
 =?utf-8?B?SEJRUUpCcHlIMmZIODVhTFJNbHp5SnFlbmJGTktuNThpWW9yU2ZjcldSVDV3?=
 =?utf-8?B?OE1qSDRpdVFRK0ZjSlVvSjM2am53TUpjbmZLcW52blVoSDVxMTNCSmNOMld0?=
 =?utf-8?B?R05yUjZONnRsTWRoUE1HSXNjcnk5blBZRjVVS3Jyenh0bHNVbTdWWmZWelBr?=
 =?utf-8?B?clVJTkszWjZubE9oaEM4ci83aHBGblNzeHAxRHFNZXJKcUpMODRmdGpmUnlO?=
 =?utf-8?B?VzVhREZRTTR4REgvQ3NpdFBQWHBnc09KUkp3R29tdCtLYWJxOUp4ZStOeThj?=
 =?utf-8?B?a3krSnlQOXlZT1BQdGRxQ3dHbEk4V2NPRVh0aDRjQXpXL05DaGs3MWFBc0hr?=
 =?utf-8?B?cElQVlNEZ2JxQXVLbW8xT2VvRGpOYjFGTGg5Q0lDZ2pIUzhSaDZhUzBWWXoy?=
 =?utf-8?Q?VzDDNYDZNm1sdzRAReO1sut4g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3862BA8266376498E6DD959A9C5D130@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70174532-ef0d-4fc6-6fc2-08de27313cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 06:02:36.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JksbqizUOlhE/1qnQbbCgI5nohLijkk9BmuPwcWDESTybKHCRWzDTERxHVCfYL+/5NseAokg9dADaWriq6vWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6793

T24gV2VkLCAyMDI1LTEwLTI5IGF0IDE1OjIzICswODAwLCBNaWFvcWlhbiBMaW4gd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gVGhlIGZ1bmN0aW9uIG10a19kcF9kdF9wYXJzZSgpIGNhbGxzIG9mX2dyYXBo
X2dldF9lbmRwb2ludF9ieV9yZWdzKCkNCj4gdG8gZ2V0IHRoZSBlbmRwb2ludCBkZXZpY2Ugbm9k
ZSwgYnV0IGZhaWxzIHRvIGNhbGwgb2Zfbm9kZV9wdXQoKSB0byByZWxlYXNlDQo+IHRoZSByZWZl
cmVuY2Ugd2hlbiB0aGUgZnVuY3Rpb24gcmV0dXJucy4gVGhpcyByZXN1bHRzIGluIGEgZGV2aWNl
IG5vZGUNCj4gcmVmZXJlbmNlIGxlYWsuDQo+IA0KPiBGaXggdGhpcyBieSBhZGRpbmcgdGhlIG1p
c3Npbmcgb2Zfbm9kZV9wdXQoKSBjYWxsIGJlZm9yZSByZXR1cm5pbmcgZnJvbQ0KPiB0aGUgZnVu
Y3Rpb24uDQo+IA0KPiBGb3VuZCB2aWEgc3RhdGljIGFuYWx5c2lzIGFuZCBjb2RlIHJldmlldy4N
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVz
OiBmNzBhYzA5N2EyY2YgKCJkcm0vbWVkaWF0ZWs6IEFkZCBNVDgxOTUgRW1iZWRkZWQgRGlzcGxh
eVBvcnQgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9m
Zi1ieTogTWlhb3FpYW4gTGluIDxsaW5tcTAwNkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggYmVm
NmVlYjMwZDNlLi5iMGIxZTE1ODYwMGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
LmMNCj4gQEAgLTIwODcsNiArMjA4Nyw3IEBAIHN0YXRpYyBpbnQgbXRrX2RwX2R0X3BhcnNlKHN0
cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gICAgICAgICBlbmRwb2ludCA9IG9mX2dyYXBoX2dldF9l
bmRwb2ludF9ieV9yZWdzKHBkZXYtPmRldi5vZl9ub2RlLCAxLCAtMSk7DQo+ICAgICAgICAgbGVu
ID0gb2ZfcHJvcGVydHlfY291bnRfZWxlbXNfb2Zfc2l6ZShlbmRwb2ludCwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJkYXRhLWxhbmVzIiwgc2l6ZW9m
KHUzMikpOw0KPiArICAgICAgIG9mX25vZGVfcHV0KGVuZHBvaW50KTsNCj4gICAgICAgICBpZiAo
bGVuIDwgMCB8fCBsZW4gPiA0IHx8IGxlbiA9PSAzKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgImludmFsaWQgZGF0YSBsYW5lIHNpemU6ICVkXG4iLCBsZW4pOw0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IC0tDQo+IDIuMzkuNSAoQXBwbGUgR2l0LTE1NCkN
Cj4gDQoNCg==

