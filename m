Return-Path: <stable+bounces-187817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEBBEC8CC
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 08:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C60735164E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958132836AF;
	Sat, 18 Oct 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="flMqtCIQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fFNkFynF"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883C282EB;
	Sat, 18 Oct 2025 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770277; cv=fail; b=eAmyaYoLA0Iryxrop6GD6GFf/5JVCP0ci3RtFUYl2OGzYElXq6sHi+JUn6hfYCktHUQQlhLj7MGR9dcAqEIjhcMp7syOT14QS3uTeg61lD6wyNaVqCdmzDNlPa9128ZzILc6mFb3358VP6eXfFCa/t4se7i1x09UN9Gqp/LjA6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770277; c=relaxed/simple;
	bh=hql044h8NmfeTrbKCB8ezkmAKfPKReg69Gg3esd7xlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/U64dbvRPoo7/rZIlJQnOin7rk1WBN8LfzVLnwazMC0OBFlRr9XLLFJhmtZI6q9C5de7Jhj6f0E7exywqOzQOGW8UK3LNU4PtwtbYZg9RmMJmH/qHiUpIF97WikA4ofRy4lT+wEQW5b3/PMQi/b5vcN2etf4RAZ5o/Yz6vVgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=flMqtCIQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fFNkFynF; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0ab0bd2abee11f0b33aeb1e7f16c2b6-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hql044h8NmfeTrbKCB8ezkmAKfPKReg69Gg3esd7xlg=;
	b=flMqtCIQIT9Ly3VheSSJc707FXk4qO8MsncNQrH676C823S1IZHlP+3BKovNn2Hd4yEPc26rRjGchmiryQz/2owI/YoBNKwTzsze1vxIJmQwrJ+dUUL8YJnnNNXcpYxaj7/QtwjQ4RHf1xyodE8ndvkwyd8qHnoh1IO1hRLR0Ek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:860e735a-637f-43c2-95c2-63f02ecd0cdc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:a3073151-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0ab0bd2abee11f0b33aeb1e7f16c2b6-20251018
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 481451635; Sat, 18 Oct 2025 14:51:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 14:51:00 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 14:51:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssTmtfSE0LhYDUg7Vad5lxSVlHSbTnyAm7tRzAOaTw1NWakJz51Ehv15Vqfx6WIcyp/r3XW4Uag5V2/vD8uYIFsjxO3shkoRy6Z95oHzilc/l/+aiQfYueT06oZy/KksdENP4l+0kNTj7SZv/x3NmMe4UZYOQP9Impa5W/f8DMRVfltS1M2slvljJZsC9nHYpOem+hAX0F4+oBN4n6ohUQ2GWXZ8uT0AxTIKT0jFDpgON9iLqjG9wqhKbtJ+zbyl8MG6MmdWqI0yDQNXHNuRsOknW2JqwcIEzpaDUKTogMsFkaGYdCG2rVyDMCiLLin8rG98HkvVc+CidtDn8A0dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hql044h8NmfeTrbKCB8ezkmAKfPKReg69Gg3esd7xlg=;
 b=f9JmGtooLZlVhxW9xFb+q9Ed3Gs/RkpMYX/op/HK4PbUkj1S2BS+xiuOsIwzhTg8k84n/Kl8AUZHA3VC88S7/LVAf+R1vRPZyhY0Evsd3iiMvZQxrJiNSvBjKLhVeS3CSqzF9P+jDBoqCIR8elYYwHHAYQY4XSodu16xjcLrJSJJdDfOXORd0VebHVufDOtIiuMpcJ1F18XzRCtKJwpUyZp+KFrSzqsWLqetbUUMiu01IboJbktl9DuPjvqIqdz3RTQpiCPB/0whIS4aavGMVcNadAVBhOsm3xtfbdPw2rMJMov2zkfkSHpfaXwb64DzYFEjVHZ4BRVVETxnLFL2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hql044h8NmfeTrbKCB8ezkmAKfPKReg69Gg3esd7xlg=;
 b=fFNkFynFLajfk9BiZ06KFEjIlaESP6iwPtzTOyupiEd7ICrZgHPUG3hu1Aq2lQBfpSphV6pJ+5DGmKuW3tcgEeYwvc875NBYEi45H/Y4kFF/lO5izY3pf9ecKpH0cUQLaS0Qf35C/o/dU1MQkkPoxjZyGcoPz7OFhQVheW7a/64=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 KU2PPFDD2810A4B.apcprd03.prod.outlook.com (2603:1096:d18::42b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Sat, 18 Oct 2025 06:50:53 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 06:50:51 +0000
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
Subject: Re: [PATCH v2 05/14] iommu/mediatek: fix device leak on of_xlate()
Thread-Topic: [PATCH v2 05/14] iommu/mediatek: fix device leak on of_xlate()
Thread-Index: AQHcN28iFU69ChUVJ0iQxYFiyPYrLrTHiDSA
Date: Sat, 18 Oct 2025 06:50:50 +0000
Message-ID: <c8827d23c3f2b580cef9ad137673351073e2ed68.camel@mediatek.com>
References: <20251007094327.11734-1-johan@kernel.org>
	 <20251007094327.11734-6-johan@kernel.org>
In-Reply-To: <20251007094327.11734-6-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|KU2PPFDD2810A4B:EE_
x-ms-office365-filtering-correlation-id: d7fe2df7-d664-4aaa-7a15-08de0e12acc5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?akxiMkRBOTdwYWExOE5rZW9NNk5acmx4QlF5YStKTTZMR1dBSnRGMGk1bGdV?=
 =?utf-8?B?WHhzM3JKckc4M3lDYmQ3SVMrTVRKZFhtL3NGUVFzczMxUUhYcXJvR1NyWmtv?=
 =?utf-8?B?NmZQbjdSb0N2NkVpQjRidHk3aWtFN3RqblJqZ2NDOUZkU0FxQXU5V2V5cDY0?=
 =?utf-8?B?LzBlVXZLSTIzQXNBMUpIRWp1UnBCczFEMlRCSFBxSUdERnNFR0w5c2NmdXhE?=
 =?utf-8?B?UkVBYkN4ekZtcmxyR1J5dnpPa1BCSDREd0x3MmRTYTVDcUMwbWwrUGY1dnZO?=
 =?utf-8?B?VzlXTTc3aXZXZnhHVE9Rb1BhZkdKbldzQWVuRk1CeUpGK0ZXdGFqS0RwYmY4?=
 =?utf-8?B?TEQ2TmRhQUhsUHB2QitsdDJPTjRKcFlTV0Y3VW1BWk43aUFVMUJqR2h4QUNZ?=
 =?utf-8?B?MXYyQTNPelc0dFo4cjc3U3l3d3hZRmpWWitoMEZmcUloUFVaQTZlNUFvUmhY?=
 =?utf-8?B?NzVmVzFHZCtnNTZKb0FCanRTKzQxb1J2THZaQkVHckVoaFFXVS9zRlR4aTlx?=
 =?utf-8?B?N29tamZ2L1BTeXJrZGwxcjR0TklHZk9NMUpVN0wyNXRVT092cnVTNVpQcEF3?=
 =?utf-8?B?OHMyTjBRVm11S0xERUJPVVhQRnVkcnViMEt0cWtoTXRpQkRpa3dsakdhd2Ey?=
 =?utf-8?B?WGZBS0Izdy84MzRDZVlyQW91dkM5OVJkbUNOV3ZMTlMrcTVKMkYxT0U5YnJq?=
 =?utf-8?B?eEY5VEx0YllxTzdmRUx6T1dmV0FuQzdISEdwZlRYc1NaV2NORjJQV1MwaFFx?=
 =?utf-8?B?bEhJSTFUanFRZ1JqM25jZUtSYVViZU1TWGV5RXY0SEhMUWVoU0pBZFZFQzB2?=
 =?utf-8?B?ejdOUzJvTHQxWXh6ZU0wb3ljeTVMSzdzV1duTGV5ZmpmSmg1bEl0aHBoMTVG?=
 =?utf-8?B?SGtSdUtoZVg1QXlWNWZHN2pRMGhKKzZYWEx4enFhZ0lna0lqWEJBek9WRHhj?=
 =?utf-8?B?V0lQNGVpUVMwbkdPZHc2cm1qdE41QWo1YW1XL0NtMWxQTEt2Q1Q1NWpHL3hw?=
 =?utf-8?B?eEM0bTBSaWFJN2dldFdac3lrUUVUSGltZXpTOGk0VVYvTDJvdzkyTi85WG5E?=
 =?utf-8?B?MW5QRnhKbFRBTGxSaFVRTE50NHlnTGtTd0luL1VZUkNKV2FUUWtuMGEvenN2?=
 =?utf-8?B?MzJsUFlSRUNsdmNDYjlGTDRSd2R5VHVVU05ZcXRpVE5yZUZXQUk5QUh5ZXVi?=
 =?utf-8?B?T2d1bmwwcUdHQTUvdU4wM1g3OG5BcDNLQStocWE2a0xCWEZiLzRZeUU3TE9N?=
 =?utf-8?B?UlVQWEVaL1FKZXNNSVlIU0FLTnhHT2ZlMjBNSm1yWHVlOUE0ZTBkczVmU0tT?=
 =?utf-8?B?eFJZKzBuWXFqMXJia2IvQStMTkZNcVdQc1FweUYrOFY1Z3hxZytaRm1hMk13?=
 =?utf-8?B?Q0tKNU13NjI2V1N2ZUF5QVFJYXNDWklhK0tTYzQ4Y1FrcHhLRE10SkJEV1d2?=
 =?utf-8?B?R2RXREZIMGoyalRtUzVHaHQrTlp1czRMc2YvbjNKOFdUTGVkSzhKeU9BSEFs?=
 =?utf-8?B?UXVYTjZ3bHlKWmFJbHlqc2lwWWMwUm15WXRZNTUxNCtnM3dMQUFDQTV0T2wx?=
 =?utf-8?B?Nzh5cWF4dzk2c3hHc2R0aVB4blZEcW40OVZOT1hhb2hqcTNsLyt0a0xCbnBw?=
 =?utf-8?B?VlVPQTNFMHprVUlJZmVYcFowR0h4eWd4WnNrQTVxOWdVVUhNc2lJaCtIdE5V?=
 =?utf-8?B?RC95Qk1kcXRwTllhWlkvdXM3QTh3YktKNXV4ZVI0cW5makwrZW1FN3FxUDZB?=
 =?utf-8?B?eFkyVU1IZVhvVW5EM2lrUkZoNDYyV2RPOWR4WE5CWTh4YTZqYTNMMFMrTkM5?=
 =?utf-8?B?aXZ5VUdEQ0dMb3lEZVlDTEpxTVpQMkthc0FvRnIvSHVzUVNSaXpPVmUwRmpr?=
 =?utf-8?B?WlhMTFBNYjUrbG9QdGp2MHh1QXpXQWVuaTV2ZE1Ha3FpNTREME5WaSt0WXJ5?=
 =?utf-8?B?OEM0OXZYd3NYVmdKVnVPaWMyVGRiUGJ5M1ZvVTZxUUVnNTJJUFRwMDMvdVZr?=
 =?utf-8?B?NmtDZ0lReFdFbkwwc1Z3WnJub1RZUkM3VXc1QU4yY0xPa3VMTEllSWdWeHl5?=
 =?utf-8?Q?0vvsta?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1oxQkp3eFQ4bEovSGxlUHZDZE1ISklKK3JCUW43UGVVY3VaVHpHMStwNGtN?=
 =?utf-8?B?c284ZEtKcHJRUENhdFVrSFZZdVNjZ2Vva3dERWhseEpQcUFCMFJjbXFhRTVH?=
 =?utf-8?B?cDNWOWVQVGp0SnNMS0xWb1VqVVpLdXN4SnJEYktlS2FYVVRDMDl0VTZlNVlP?=
 =?utf-8?B?NFNlR3JVTmRXQmNDOHo5RmRJemFPOEJQSXlwMVZZdVhHNGlrN3FJYXFicjI2?=
 =?utf-8?B?dlpZOXllV2pOVkR0WmNldmQrZ3Y1T0dGSEJDT1g5RDZjY3BwMHZFTklqcEZi?=
 =?utf-8?B?cGRrOW5ZMW1ERXQrbkFpL1EwWnlLYWl1d3Q3Qm81ZjNGUDBZdUkxSU5kUDRn?=
 =?utf-8?B?VDVhRUhqb0M1NWRhcVZxL0ZHUWFuRGxjZm1rRTZxY053Z1gyMG1GVml4TlBJ?=
 =?utf-8?B?QWUrbjBWZmFKWkRtekl4bDRhbTlraUkvVWpjS3VtRENqbDVIcVpRbUU0N2dN?=
 =?utf-8?B?REt0QzJhczRFOUJ3M1NuQm1ESE82SkFvWU9VRTA1dks1RTJrQ1doTUQ5c1hZ?=
 =?utf-8?B?bXBmd3I4R2JxZTJGMkRhWHl1TXpWaytuVGZiaW1rZW0vY0NGdDhHKzEyUzkv?=
 =?utf-8?B?a3JzeXNqTlFZdG5NLzBwTWpaQTh4N1pxSVovNFpJZ2NTNFpSTHlvQ1BCKzNB?=
 =?utf-8?B?Y0VNWGxEaG5Nc0FCNmd3OFJDZk9PcWVsbUlaVDZTNlBlaXAwbSt0R3VpNVpQ?=
 =?utf-8?B?WUFaQ1VDcUE1TGVKM0U4d2NUb2VVcXE1S0psRWJJNWxaZFk3eEQ2UFJkQXJS?=
 =?utf-8?B?N1BBMnJFWkVRYUZaZWdSZW42ZzJpa0N4TzFhVzV6TCtNUFVma0pvaGdJOTZP?=
 =?utf-8?B?TFpqakhRZmVlOTVyU1NhdHBKY2VTL0tIVTRpU0R0QjYxOUJzU290RUh0R20r?=
 =?utf-8?B?QS9EUEFaYWZsV25uMC82cWp1ZlZKU2ZWbEFrY3VzaG9OVVEyR0dTaW4xdTJ1?=
 =?utf-8?B?U1FYMlhCVXFyUzI2c0dncHV5R3ZNL3ZTQnVWZFpFemdCZ0hOSHd0anF2dDJj?=
 =?utf-8?B?djEvNURwZEFlSEFpQTNIZ1JhTTFDdmdaV1B0enJxdGo2VGZIT3ZUMFRjNkNs?=
 =?utf-8?B?TG00eVFQalFkTC9GVTNUOHBGYk9KZm5UNjBpbDZaT2FEUjRubGo1K1RnRHRo?=
 =?utf-8?B?VWd1SndKVXNsbVY2c3VYMmFnK2hYVUVKOC9sTVZRcTllNXBrazNHdm9aZFFV?=
 =?utf-8?B?VmN6SVFTYk1ZL3gvZkF4VGxTcXQ1QldSakhxMFpNblhWTjVySmxBRUtiNlE4?=
 =?utf-8?B?TDd6ME1odm5vd2JOSUUzQnZRV1cxTml4TVhvdVZ1MXg2WEF6TjFDWUl6U3FV?=
 =?utf-8?B?ejMvU21WRGUybVYyT2dVdUlRek9YcDZqZVBHb1lrLzNkckR5WVBEOVFuSnpz?=
 =?utf-8?B?eVo2TmNuc2ZrcHBsQ0pJU3Y3N3hSOGltV054d1pOdGNZQm83cjlEdHlGZVVy?=
 =?utf-8?B?NmduSnRuWFVyNG96T1QraDJqcDRCZGhHZDJCbUQ3bTdpUC9FZnBNOTFMUEFW?=
 =?utf-8?B?V1Y2WkI0MXpqd3IxTjdHbEcvOXlSdmxtTFR1UUdXN1hCUlUwQUZub2JBUG1F?=
 =?utf-8?B?cHFTY2JmaEE1TTkxYjRDZk10aE05Ymk3S21OT3cxMlNLVTc4dzNtOTVQWStp?=
 =?utf-8?B?bmxxVnkrUW1UTWFZQlFVQzVSdkM5WHpCbU9LRy9aSGN5M29Qa1krb2I1clJ4?=
 =?utf-8?B?SVk4T2ZNNmtCTFNCejhIVDA5VnlQYnVtL3ppTCtObml5Rlh3aW5wTXhjb2J1?=
 =?utf-8?B?b0VjTFcrR2hPZ1Yvb1hJNGtjLzQrVy9rendKRWwvc2F2eVFjL2JhN0ZsNFBH?=
 =?utf-8?B?RXRIbVBremJZcC90T3JqNWVPajJsZ0dwQTZqTmUwK20wTDQxRXkwaWJpUGJ5?=
 =?utf-8?B?NVFkSmU0WCtCSk1Ub0lpV05wbWhuYk9ZbStFcHJxQ3FyQTFvNFpwb1NmTDJF?=
 =?utf-8?B?ZnloUzlQVDI3bFVrNGpBMXgrQ2dOUExkdDV5YWJhUnRUcEZQQk94VXVKbjFx?=
 =?utf-8?B?Y2ZQWVMzZGZFYTdUN0NKNU1FNzF6UDA0am9uSGcwSC9KUUpvSFpFOWZwMmtq?=
 =?utf-8?B?b0tJTE9HeXZOVmY4YTRPaE9la2dRKzljTHhDaWo4TWtkbEtEenRML2FqajF4?=
 =?utf-8?B?UEFHMm9mbXRkbTlaU0NyMnBwbnBiTmhwUjB2WmhKYVhyaDFyWlorYkdvRjM2?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C8E0BFF317D8E4F90745B7490BA7657@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fe2df7-d664-4aaa-7a15-08de0e12acc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 06:50:50.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVk/skkPCpHPdK50xHlzeAX6nNM0leQ2y2FSnb9oDa4JvaE+NKxRADNf4DHzwHELJvwf6xd5OH78P1Toh7e64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDD2810A4B
X-MTK: N

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDExOjQzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gTWFrZSBzdXJlIHRvIGRyb3AgdGhlIHJlZmVyZW5jZSB0YWtlbiB0byB0
aGUgaW9tbXUgcGxhdGZvcm0gZGV2aWNlDQo+IHdoZW4NCj4gbG9va2luZyB1cCBpdHMgZHJpdmVy
IGRhdGEgZHVyaW5nIG9mX3hsYXRlKCkuDQo+IA0KPiBGaXhlczogMGRmNGZhYmUyMDhkICgiaW9t
bXUvbWVkaWF0ZWs6IEFkZCBtdDgxNzMgSU9NTVUgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcgICAgICAjIDQuNg0KPiBDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQo+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+DQoNClJldmlld2Vk
LWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg==

