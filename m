Return-Path: <stable+bounces-166685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A0B1C11B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 09:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B343B2CB7
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFA218821;
	Wed,  6 Aug 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="trmzz5ce";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h6NZRIcC"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A021423C;
	Wed,  6 Aug 2025 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464439; cv=fail; b=CCUmFUYH/k8NqI1D8NlZxUfR/O5uabKgYDOiO2DTCty0X+YdxArS9hQgKzRKADMtZfNPbhddikzo6Vv4hM9279rCdpzFVKQKtNOdbdFZlU8M0ka7nZQsEF9FezSAArN+7yNim1ZrON3aCVsGET2nUa1fe4UoBzZT8kUvj02NoOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464439; c=relaxed/simple;
	bh=xr23LeaeAu7gsiGKlS+VN0ANC1nArpBoVMbNa6y5Yfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ft6SLoUFDUpAd03/cvjgY2LobA6Qs//tigHqbhK9K081PXYLEurGp0KiZyW+hoNA0J3lNAps+sI4xxoNBt156kVrEfaSRB9Zd/9vYzd+88TPFCH+XL6W8Law27jw3ZzD4TE1YC/FjATRB2CV2X88aDkgWXRTxajNxLzeWuG76FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=trmzz5ce; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=h6NZRIcC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e6ad2124729411f08871991801538c65-20250806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xr23LeaeAu7gsiGKlS+VN0ANC1nArpBoVMbNa6y5Yfs=;
	b=trmzz5celSkl5oOQstndR2G4QxmMiuJnSltKORJaHhqjnVLGI3Aa6e463fkX7J9vXFqqcyjTu2nJbIYALREmSL1Q863wrRNnVXki/mEz1hVuqWYkXnE3rYbOOQZEiTrKhAAY9eq24fvOgKpyFS8oUAnx4KpKMiJwZsPVQu1CD+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:9e21233d-faf0-409f-8938-dbc7425748d8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:2393a350-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e6ad2124729411f08871991801538c65-20250806
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1031165875; Wed, 06 Aug 2025 15:13:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 6 Aug 2025 15:13:48 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 6 Aug 2025 15:13:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqBtGDt9mzy+aAj/SckyEU6zzSw/PiI/D5IQssCyLnd8ndf1W8nYrFT3kqmxBELMg+GxLNqClAYxYMlHuy+bk4GoQjDpizTM/GPaRunVEfF8WnKgZTRKINe6hVqAKKMWFi/Ghhi+ehqG/WiBa0v+uCu7vD0A4D3GVFJn4w4V+cothA/3MbrNXnQtUyA8FkRilJuMEZT0Yo/eH7Nx7bg9bWq0Lvf5q/ysOqmixnG2CdttoJqCTqI6mf7xPS+uN54zbQjCeUrkKEGqI3zWR7AtU86MMaE+hsrD7rN39RhPoi6YO6y7OASuDh3EzbcPkc4UVVOmdwH+iI6uFfCQ5967TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr23LeaeAu7gsiGKlS+VN0ANC1nArpBoVMbNa6y5Yfs=;
 b=UpigEr3pLVX6lSTOovR8H2smMWAGhd9/+/L/Y97iOYGIIPUjh8Vu8FRuu1GdVbSxrk1DZrxMalVj0yMW18YN486DDB+JK90eq1RywwN24SRQ0Q6QvPBw5z2GPcq8CncoZhCoOc1bf6OFzgxmEEY5wah8axaCnIiVBgiegXxY8xMCN0DjjLMTzRDdiRbXguc+dioJSoyspCuijExSG9B9enm0I+MQieIaToBdLZpYJD4ezgfFMO1F+L6dCE9b5Ua3tOjoikQiRFjFV0fx62RwEjuMFBSNQvDDKNJvyoTPPXzm1wcKKvq4dWwkVosICj5u0cDseTgZ6ymvlpytQ/9OAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr23LeaeAu7gsiGKlS+VN0ANC1nArpBoVMbNa6y5Yfs=;
 b=h6NZRIcCQEkCio4whfPTb/czXjU/yIHBP+HjdsTqWtdBWrrLQxQvYFthTS+azFXrRWFEgMAe6Q1EO/MPoi1j5KKS82NWk3bwO2jniqLQMthAVvs5rvjT7btFds2EP0El0cnohdZfJhaUZXGSD8n7jGXWaXSHO7ppZ3ihqfmfLPo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8727.apcprd03.prod.outlook.com (2603:1096:405:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 07:13:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 07:13:45 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "johan@kernel.org"
	<johan@kernel.org>
CC: =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: fix device leaks at bind
Thread-Topic: [PATCH] drm/mediatek: fix device leaks at bind
Thread-Index: AQHb+ur3SafGF0s/f0and4MQ7kY3CrRVTXMA
Date: Wed, 6 Aug 2025 07:13:45 +0000
Message-ID: <bc3eb7e9118143214760ec240bcd339ee38adf68.camel@mediatek.com>
References: <20250722092722.425-1-johan@kernel.org>
In-Reply-To: <20250722092722.425-1-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8727:EE_
x-ms-office365-filtering-correlation-id: 5bbe0ba5-de55-49b0-4f21-08ddd4b8c836
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|42112799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K2ZuV083aHFUZFY4ZEJGbFhtL01sV0I0amcxZit1Q0JYNXo4K05ld2VjR2tC?=
 =?utf-8?B?TkpVOWJ1b1p0Y1phRDFxUGkwOVBXMzUwbHJLZVRKcXZLcUpYRXAvV0ttUmR1?=
 =?utf-8?B?d3NMakZNVGw3cmZ2b3Q5WVlZYXlLOSt6emdJazNxdEZmK0x2ZGJrd1hyMjl0?=
 =?utf-8?B?MzMyMHBvY0c0NnBBR2I1YytJZy9WL3F0RkxRY2h2eUt6cmhjdWhvUjhIZ0Zl?=
 =?utf-8?B?Z1VsVDBnNHB1dFVyaWp5a296d0lXWFF2YVJhMmJoVWFYcExSdTRqc3VuZW5z?=
 =?utf-8?B?bStUdWh6N3h5Mk42SmdVSm14c3NnbzZTdldRMHBZSVdodVFabG1nZWNlc0JB?=
 =?utf-8?B?WlozNnFaamtwWHk3NTNBeEpPaTBNMjFya3ZpSWQwQlp2ZTBmanZiNloreUxr?=
 =?utf-8?B?cW5QWWRrY2JJUlJKQTI0NlMxc0ZQeGg4UEl2RmZ1aFcvdzBIakFyMFNoWnN2?=
 =?utf-8?B?cjJGZEVjMWxBc2xsbjJmMThyQlNYNkd3Y2hheEx4ZHJXRXRvNzAyWDFKZFFE?=
 =?utf-8?B?a000cmZ6OG5nTUtDVVlTaGFmUnZ3VGNRVVE2SVNMaysyLzNXeGhPWVRnVlVh?=
 =?utf-8?B?NEx1WlUwVVRncjlTMTA4RnA3NTJwUVNlZUM2WXNmY3o1WnpiYlovV2tycWNz?=
 =?utf-8?B?QTJBQVo2TE5UMDVaRDV5K2Z0SzBFazhjK3VYNEl5RDdwckRTNFU4aFdxMFJ1?=
 =?utf-8?B?MGZUQXlpc1VpNWhSRkk3MkJGbHI5MW8zS0dwb2dhRFdZVFl0NmVCL1Nac05U?=
 =?utf-8?B?NkZCZEZpNHNyU2QxcU1IU29FbCtzVHd3N1R3UE5jbExZZytib1lTenpwbzBH?=
 =?utf-8?B?YjJzaHNEYlMvTTd3MG5jWTdKRXZIMW13bUtMZ21GaHBpazhDcG52VVEwczA1?=
 =?utf-8?B?KzdscSsvNW9CSitaTllNY3AzZG1TK0FQb3A4UjE0NDFkVHZzL2dRQjY1d1hP?=
 =?utf-8?B?SlJLMWF3MjJaNnJkME5iaC91UFZjQVNiMnQzMkRGTHdsbjZGeDZTWnZJQk9X?=
 =?utf-8?B?QjJ3TXhjbDBjZnZSQ3hhbFk2akdxaVYrVWFSb1BQSStTVTlRdFVxMmdLTDhi?=
 =?utf-8?B?UGRObVBoQlZ3aTBwYzdGVVdYZHNLaEdIUlpKTTBQeFRQMWZ2UWhLcEROZ0x3?=
 =?utf-8?B?Q2J3ekdwVGZVTWI4cU1Rb3AzSmRQNVl3aUVaVFFhL3EwUEF4QWNGZEdCbjZk?=
 =?utf-8?B?UFRNRlZyVUNqSWpURXFaQXNJRExsdlkxZ1UzNGxXWmlEWUN0RGxLMXFSenZW?=
 =?utf-8?B?NjVnU09SMVJjaG9aZHo0eWd5SExnNE5LZGZFL1N6cU52eEtUMW1lQWhVR00w?=
 =?utf-8?B?U1U2ZHVoR1VwWXVUK1pORXRTak9YdFdyNTFnUktLYUNEZHAraGphNGd0OVZQ?=
 =?utf-8?B?bDFVRFl2WnhuRGkvRGR4a29BKzlsWUEyeFhaRldqUXl3WDNVZThRWm9NbFF2?=
 =?utf-8?B?Tkh0WGhpZHlvM3JjZE5ZMVNXY0pvUk4xNFoyaHo0aU81RTg5SkNQZG9mbVhx?=
 =?utf-8?B?MC9qZFJERUQ1ZlVhZzY5Q3E5L3ZUZW0xSW5nTW90bDJ0azRnQlJ2cEJrZ3FK?=
 =?utf-8?B?NS85Wm9QN0lQLy9PVkZqcHJLb3hZclY5aTErMER5cHUzMVM2eHp6c0o5T1BJ?=
 =?utf-8?B?WnZsRlRyM2QyQ1NzcURvNmxmcnpWMFVybHdTTytQL1hQSlZBdUIxVVpsTDRI?=
 =?utf-8?B?Um8xb25aRFZXNG8xYjd2c1VDV0VrQ1JQN2luNHdFdURPWW1pQXhLUnJzVUNF?=
 =?utf-8?B?SEpqaTlJWHlzdmhrcE51b1EyUDR4cS9hODB1eDBwUy9HQk5XRktRL0NZL1V4?=
 =?utf-8?B?MDVPUkhZU295VTM5WUtiL0xBdHR5VkR4WHNxbW5ma3NzQnM2ZjBpYVJMSkx0?=
 =?utf-8?B?RVpWVlpVZ0JjQzRXOXU1RVd0SjErSWdXckhqQ1VPanUzelhGdlFKYmIwdHI5?=
 =?utf-8?B?Y1JVUG1ZRXpXSEIzWEUzMHNSRDlQTTV3Q3dmYysvb1gxQVVzNDZoNFJhRTBI?=
 =?utf-8?B?MU9KZnpUdnZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVFWWE1jN1c3SEFQR2VKanNyN0FDcWkvbTZ0SzVCbXR0OFUrWkRQRFprM1d5?=
 =?utf-8?B?SkxmbUxjSHpSelZmcEtmQ1NyZmFlbnlId3Rnc3daTVN6WnZnTlpTenBITklL?=
 =?utf-8?B?WGxGeG9NSlAvUjIvSGZwcC94bWZzQ3NUdG1kR2kvM1JUcG5VVUhPS2FjTDFR?=
 =?utf-8?B?T0NYbkhINHpGbFh3UUQya0d3MUdXWWZJaTdTZ0dSdHRUWjdkVFUwa2ZscTla?=
 =?utf-8?B?SU5GdU94WjdzNHg3bE1aeC9jM3p5UkUrdEFHOVlQN2xDZENsMEJmUGFMandD?=
 =?utf-8?B?dGk0SytUWlpNK2xFdTAwTytZZXlqZmNwZjFtMzFEb0RpLzR2RHUrOENYTHdP?=
 =?utf-8?B?TTBVMGNmOTZyUURKZzA5ekR2bDh4RXArZkJ2c1paT1VaaFZBSUFLVmhBbDh0?=
 =?utf-8?B?TEM5NTRsU0dkc045c2NNR1BwZUo1TThGVUwrMWc5U0FuLzUyZHRLcnV0aCtH?=
 =?utf-8?B?RDRoRks2aml6Ris5dllxTG4rNHR4cWRUZjN5NXluQ3FhVndNNjJyTG9jZ3ly?=
 =?utf-8?B?LzYzVlkvNlRTa3B2MklCOVdlcElqcXJQYmRyRTVoQklqOGViMEdnaWNjb1Ix?=
 =?utf-8?B?aUZTZy9Sem44dTVwVFZIWmZCOXRlQkVORCs4UU1VTmE2UVMyWUdSeXB2TERP?=
 =?utf-8?B?R2wrTG9pNDFxYU9IZWNHaUZ4dHBmSWVjbHlKdWdjUVFGR2lMZVlOeXptMFRF?=
 =?utf-8?B?TkdZY0ZvUHdWOEZQL3pTd2FwTEhwYUdwSFltQ1pWYi9PNTVGZ1pCOHY1cEtC?=
 =?utf-8?B?Ry8xU1hjQkhEbTZ6TDZ5VVVvcW53UjMzNXl6TUxiYVJJM3RjcElhUlJ0K0pL?=
 =?utf-8?B?dXlteVRtUUNXZEN5RVE5ak9Cck92TFpPQytHSFVlaXB0SlJML0djeWVzMVRt?=
 =?utf-8?B?YXpJSnEyNG1oZTlyUExIa1QrM29naWxwVGFlM3pUTEZkb29tT1RjY2VSOE1O?=
 =?utf-8?B?YWFVVzBCekpuQ2luN3VtMnpJQnVjT3BJSEtPa2gwQjZWUHdYeHFOM2Y3SVBa?=
 =?utf-8?B?cmlHcElvRXV6bjg5eFNKSmJScmsvOFd1MlNOaW05M0VBKzJqWC8wS0twTEg0?=
 =?utf-8?B?M0pGSGtQNXYreWxpRHVFR01PVGN5WitlZmZiQmZRMVBydk90MkVzdmxSRmVC?=
 =?utf-8?B?WkptMGUyRlFjQ2lpd005THMyWVhCdkYxOEZnQW50R3JCRzdmY3RPYi9pSXlw?=
 =?utf-8?B?clZ0bmxxYTFDY3dHRXowYmpPYXE5OWN3eG1ObDd2dkNBT08vSmZUWlhOV21y?=
 =?utf-8?B?UTNiNG0reHJqRFdOcHBPNkFCQ205dXlWazY4VmRXc1RFYWZVQVRmcFNscStt?=
 =?utf-8?B?UEFWRTQ0cFJQbS9ZYUo3NW8yV3JFZ1V6K2xKS3VNbWM0UktvbHdiZnNWSmJo?=
 =?utf-8?B?SlZYR1JLV2ZmSHk0VllaSzllN2RVVzlVT1JVNGUxYS9SOFluc0lMbHdsT0tE?=
 =?utf-8?B?SWdLeVN6TmU2OVJaY3A0L293SW9oY1djU1VWQ202RWQ1cTk4Q2hwbERLSEpF?=
 =?utf-8?B?eDJSKzU5OXhzTG5lK0tDUkpEWmN0b2NvTk9yVENCczFPN2V5R0h6Y3FldzNo?=
 =?utf-8?B?V0hIMHg3YW9mSGJtUFo1OHFrRXlZM0I2NjFadjYxMVVNampuWlNaOTJLOTJj?=
 =?utf-8?B?eDRQYWVrQzNpcGdTcC96czIxR0R5ZXlqQ05TSTJSSi92OEc2WjJoaDdPdFE2?=
 =?utf-8?B?b0Q1d1l5SXU3VSt4aUY0TXlXNDBRUG52Tlp0R3FHR1lIbFFTOGhwZkpPTlpP?=
 =?utf-8?B?ZUxJYWFETndXOHlTeVYyR2d1ODU3bmNwaC9rTUF5L0V6MG12VG55WmxBaWgz?=
 =?utf-8?B?elBlS0gxNjlHNysyd3lIMlpxcEtUZHp4NVNnZWZDS1cxREhtQ3NHQ3loaC9D?=
 =?utf-8?B?TE9PRnFoRHdEVEhkbkdNR3hSL0lEcm4xTGV6b2l0aW5PWmhUeVlwbU1OWEhp?=
 =?utf-8?B?M0hCbkFmbFRFeTU2UGVRTFMyTlpUVW1FODdOYWxXUG5qTzh6WlRuOCtEWGJl?=
 =?utf-8?B?alVZRHkxZ0x0dy9LOThlajF4SXAvRjZ4V09vU3hFeXRzTnA4cmhqaG5idWpR?=
 =?utf-8?B?aEs3L3pLZnNUNDgrM3FDaXk3Z3ZpbnZVdTk5UzY5eStPSTEyNVpFeFJaTGlK?=
 =?utf-8?Q?cThujI8Qs5+tAN8VZlE9ml4xC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76082C41B849CB4CAC311144D944349C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbe0ba5-de55-49b0-4f21-08ddd4b8c836
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 07:13:45.3975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFmCymHlXRswJT/u399GZl02YkXhTftWCxFkZGAiAw1DfknGtZmduyiwpQmQjX/OX0MRJCJ0j0j8spqSpcbiLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8727

T24gVHVlLCAyMDI1LTA3LTIyIGF0IDExOjI3ICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gTWFrZSBzdXJlIHRvIGRyb3AgdGhlIHJlZmVyZW5jZXMgdG8gdGhlIHNpYmxp
bmcgcGxhdGZvcm0gZGV2aWNlcyBhbmQNCj4gdGhlaXIgY2hpbGQgZHJtIGRldmljZXMgdGFrZW4g
Ynkgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIGFuZA0KPiBkZXZpY2VfZmluZF9jaGlsZCgpIHdo
ZW4gaW5pdGlhbGlzaW5nIHRoZSBkcml2ZXIgZGF0YSBkdXJpbmcgYmluZCgpLg0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDFlZjdlZDQ4
MzU2YyAoImRybS9tZWRpYXRlazogTW9kaWZ5IG1lZGlhdGVrLWRybSBmb3IgbXQ4MTk1IG11bHRp
IG1tc3lzIHN1cHBvcnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAgICAgICMgNi40
DQo+IENjOiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
DQo+IGluZGV4IDdjMGMxMmRkZTQ4OC4uMzNiODM1NzZhZjdlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtMzk1LDEwICszOTUsMTIgQEAgc3RhdGlj
IGJvb2wgbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiAgICAgICAgICAgICAgICAgZHJt
X2RldiA9IGRldmljZV9maW5kX2NoaWxkKCZwZGV2LT5kZXYsIE5VTEwsIG10a19kcm1fbWF0Y2gp
Ow0KPiArICAgICAgICAgICAgICAgcHV0X2RldmljZSgmcGRldi0+ZGV2KTsNCj4gICAgICAgICAg
ICAgICAgIGlmICghZHJtX2RldikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
DQo+IA0KPiAgICAgICAgICAgICAgICAgdGVtcF9kcm1fcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShk
cm1fZGV2KTsNCj4gKyAgICAgICAgICAgICAgIHB1dF9kZXZpY2UoZHJtX2Rldik7DQo+ICAgICAg
ICAgICAgICAgICBpZiAoIXRlbXBfZHJtX3ByaXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPiANCj4gLS0NCj4gMi40OS4xDQo+IA0KDQo=

