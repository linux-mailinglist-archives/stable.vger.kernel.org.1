Return-Path: <stable+bounces-191392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAEC1310E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0373B1F89
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB52BD586;
	Tue, 28 Oct 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Iml8U79F";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IGMIAXJX"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DE29BD9B;
	Tue, 28 Oct 2025 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631604; cv=fail; b=Bs0e3Ew6Au+/X1PUkgj0WvIkWSJLV94+NhVkV963vXfpwBZv3aQ5ybxLBZqqlTAiWPzNDZJl6vGa9hkv2+JHjlikjzAHdtq8nINM8BlXwDn1dZaT0BSnLZ7tlDhNwsXkJgzSxKQipVF//AbDr4SFtkZZ/1j2DlUAmJPvIIazAg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631604; c=relaxed/simple;
	bh=bQq57a9VWvRCDTLQcYM+Xv0TzUnX4Jtc6DcS/NRJF6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iaLnaOmG8s+XCKj4XSqWkYH6Eg1d6L6MedVlxOZFYE7JsaJdIq+UP11sqzXlRccYU20eAcHQC8I+DXgMSu+jIr9w4U+hryMN7+s01IdUtlRbAiYkLFh5QAzwaIBgpknc2Fj4muVZ0wX3z7dcJaVI5y86qZGytUYsppLKWz8Q9v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Iml8U79F; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IGMIAXJX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 425a3c44b3c411f0ae1e63ff8927bad3-20251028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bQq57a9VWvRCDTLQcYM+Xv0TzUnX4Jtc6DcS/NRJF6I=;
	b=Iml8U79F/uyUZ/xezAih7bzYKl6v6HCxEdlCVSoz73if0y+JVcB6uuwo7fDb54YPkb+A059/j849CvK+c1Q5BU9ayzgcaUe+/9sm4VDjh7bL+5ZECJO0J/xxR2zqQxKe17L9PwSa0KF+NCdDc8OS7OhbUQGNxZPyeNJcXb6Er5w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:72666382-8495-4eac-b41b-09a145c4bcd1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:29491bf1-31a8-43f5-8f31-9f9994fcc06e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 425a3c44b3c411f0ae1e63ff8927bad3-20251028
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 944505347; Tue, 28 Oct 2025 14:06:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 28 Oct 2025 14:06:33 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 28 Oct 2025 14:06:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+OhNS9ONlvgEl1N7e3xHJjQtY0Zq9IrjMSCCUbxKjII+o2Ciy/XT/Z8XUA82WP1C7QdqMuu2wsl/qekP866mwosgJ6HKR0rsvWm+lUWi62Gs+daiDCzdOQ8/4yQGCCpRXlrKPJWXN05FkGRtT5iqkFeLKK7bruSsHQBhoOzFDzVmyj9nyIoUqe5zJUsLvVhQ7L6ksfZEWRDqoLxliElB1k2ha5KxviPVmkSWzEZayUUEhVeR6QiXCi8C6oo3sKWkwxuzJdebZjHH26ZB1xByx7vbz6Mn9zfU2agLH5xS+W1Qs7H5Z85FqU3bUWkykp9unfo3rdNjHPaEE9SF03AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQq57a9VWvRCDTLQcYM+Xv0TzUnX4Jtc6DcS/NRJF6I=;
 b=BBpXeMaaQDrp82El3nH7UIsqqcxghIiLQrCXLra5up55g3p1qHw/fJoFFo9MBOsZl/8daDFjV5DNn3RAx4y6UEn47qy6P0PaAC5A4ecNdqjgq2AQZ2H/y/C97Ig7DnWMl1Rf7b9YYx5AwzrS8JB7rUHLniX4UA+m8lLSl3IEN7zbUcaYtq03g6utoaqY6zSvxpj6uC3wYn4ksDxik1QRX2oz4ZKTABroRxZEMdG+gagfq23fnlaAkLTzQ7P4HymTEu40gdhsROAlyF75NjvZKTwNDBXZInCbiSDmfUXDSXmW2yzJJsPLGc2rtz8R2rOx/fR32q4rGqj/VvhB+z/Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQq57a9VWvRCDTLQcYM+Xv0TzUnX4Jtc6DcS/NRJF6I=;
 b=IGMIAXJX6kErQk8OOmMh/Z22tQIXyGhRt3WlrwcDPAAtlUvQ0q/mRFYVuk/A0dEze6AQGF9Jcb3OsfBLEIZLK3dgZrdJNXa8mthWozNzS1yaJNwkEdkIPtHDMsQUqROIfsx1Z8BfuhtsOJVP5aoDGNxkBmV/IpHIPqGrZxqkIcM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7523.apcprd03.prod.outlook.com (2603:1096:400:42a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 06:06:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 06:06:30 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "johan@kernel.org"
	<johan@kernel.org>
CC: Sjoerd Simons <sjoerd@collabora.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"make24@iscas.ac.cn" <make24@iscas.ac.cn>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: fix device use-after-free on unbind
Thread-Topic: [PATCH] drm/mediatek: fix device use-after-free on unbind
Thread-Index: AQHcNqZsUN/IJC6uc0qdkyKfGvqxLrTXNLQA
Date: Tue, 28 Oct 2025 06:06:30 +0000
Message-ID: <41377239ecbc420abec0cff55e0409a04b55f01a.camel@mediatek.com>
References: <20251006093937.27869-1-johan@kernel.org>
In-Reply-To: <20251006093937.27869-1-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7523:EE_
x-ms-office365-filtering-correlation-id: 32f38a6e-a891-444c-d383-08de15e823a9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cGVtamtYd3IvaGlBcDJFaVgxMU4zbldYNWhlWmNKR1ZYQnJFWG5SSzhOb0dr?=
 =?utf-8?B?NTJoSFdSb0E5UStKU00zTTRldlRjQkFEY1IrbjNpeHkrZjFPVk5aLzh3L0R0?=
 =?utf-8?B?T1NOMVFPeGprMzhFdVpzdnplR0FhZm8ycndScGRIcDIvdDRWSzdzSFJCYXBF?=
 =?utf-8?B?ckdMQTA4dVNtMldPK3ZUMFpPUlJvK2R2VHlWRjdtNEFzSzlrMjZBS3g3NDNh?=
 =?utf-8?B?ckZFbkVvSnFLamdPNTRYdE9Db3hobDZlV1l4SDJhQjRIOUE0aEY1N3A2MXZ3?=
 =?utf-8?B?N2ZSNCtCRkROWXpSOStzY2NYbkRsRFo0aVg4dDdDNDFTL1JMSUVWSGlZM3Uv?=
 =?utf-8?B?TmhNMjhXNFZmekNoTUJEdG5Ldmw1QWp1YXdXRzF4S3BraXBtalpUZkg2ZUhi?=
 =?utf-8?B?VVhnNXgyc01NSnZqUHJsbjUwdmgwWjZEOWYzWWFaSXdZUjlaekordklUTmpR?=
 =?utf-8?B?TnR2L2pmZGFkaXJ4WXdVNk1ZSWJ5akNqN2dBRG5pTVdEMVFDMGJSdE5nRFdh?=
 =?utf-8?B?em4rSW5icUpNdk9kS01kZTQ5N3UxSnhnaWRkZGJSWlNHbmhvQWhTQ1M0MjlW?=
 =?utf-8?B?bWRQdWpaL0QzZVVLbm8xWEVmTXFRTWIwYW5GSFBwby93NTVNRGI4UGVZMHVw?=
 =?utf-8?B?Njh3enJOcTFubnJYNVdNRWIrVDlYNnJYU0srT0VyeTZuVmxnc0Z2bm9pUFZJ?=
 =?utf-8?B?cnpzY1ZSdk9USHlKcEVTNGN3MkUyelJPMVFTdWJpaTNXYXorQk81bWtvazhV?=
 =?utf-8?B?WkFoa2hMbllycFJyb1NaSUdwa1JYbmkrWjBpaER5WllVenZRWlROSkhLNTUr?=
 =?utf-8?B?TlJGMmQwMXlhZW9pSFlQRzRDVTFIWW9adzZHY0lyREl6YXpBbTNjc2E1bzNY?=
 =?utf-8?B?OHhPRGRpVGdQRE5scFhuV0psTFFVSXRXT1dkMU5uZ3p6MllGdWx1cHIxeDZq?=
 =?utf-8?B?bEdkVTQxSHJVcEJyenJHNjF5YlNIQjJtVmo2UlhWK1d2STFLaFpYazRsbDFm?=
 =?utf-8?B?WXZPNkxxcHU3dDAxOXNWTWNGSFFnWUhIajcrR2RYK1NKV0gxemxiOWJEV0Zo?=
 =?utf-8?B?enNDWDdDUThtcE9ZSmRyeEI5YloxT01xUlJCYlJYNFVOb2lIWlQrZ1BIU2Fh?=
 =?utf-8?B?QXQ3eEh0NWdQOW0vc0ljVWQxV1VoUDBMV0Y0ZEhxYmlQZUVTYjlXYjIvOHZG?=
 =?utf-8?B?R1o2aVhSc0R3VVVyY2wxUktIdm9LRVNCR0luZ0xCbFNpVUNHaWJhdGFmR3ln?=
 =?utf-8?B?amo2NzB3SlRTRnBEeHE5STVkTE14RUtVNjJiMVBWeENNUVUvdGRGcjdaZE5M?=
 =?utf-8?B?K3hLc0s1QzBDMlhONFc0dmE4VW5NSjNCV0ZJSG1rdzA2aTBHbUx4ekdtS25v?=
 =?utf-8?B?bG5Pb2M1TzU2ZTVDY2tDQ3BhQ0VRTXBCOGJkWTl5WEZya1lCZU1SY2RwWW1J?=
 =?utf-8?B?bDlSVy9IS2lFY3JiWlptNkFra0FqV0l6OSsvWFlYV0hYT0ZxZDdrTEc5MWZm?=
 =?utf-8?B?d0F6TFZSZ0RKUFRFRTArNVZFY3FQdFlBT3MySVUrV2xGWloxL2lNUStYZit5?=
 =?utf-8?B?MGU2QURQYnlMdWNRMGVzWFNhSFY0U3RpS001NXFPdGdKVUg3NmYxMjRodDM0?=
 =?utf-8?B?L2l3OHRVTk5aSmoyeEYvTkc2YS9GMklvTWRDZFM0UWNYOXFDNmRQT3dud25E?=
 =?utf-8?B?UkhrUFFDSFJEbHg2OHNSTlRGUFl2V2RWNEM0VS8weE9uUGJwV2xkNU9vTXcx?=
 =?utf-8?B?U0NudndMcXg0Z2hnVzN6K2NjUGF0dWFsZnJjUWJkSlR3RTVGM1ZWS3VCMGtL?=
 =?utf-8?B?dHN4WFVkS3Bib0dJL0Vwa1ZiazlBZVY3WlZzL0JEWGhNWTl5dkFDQ2IyNnBD?=
 =?utf-8?B?NHB6TlBSSE1CZ2ZhdXBTZGIxeTkzcWVhajZnSGp3TTRXUFBFWmswVytOUVpU?=
 =?utf-8?B?N0g5KytyWjJjT1BCY0kraEd1a0gzRCtsQWVIMDVsUnpjbEtYN2hweHgwSGd3?=
 =?utf-8?B?czhSdmVFckNVVjQ4L0cwQ00zRFlYdWJBOHFPSDRVS084M0VWT1M4L3BWWjJL?=
 =?utf-8?Q?dHB4KZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE5iOVd6bXdSWjRPMkJLZ0VnOU9aU3RLVW52SkxnY1pSWXhoSDdrVHRCMEow?=
 =?utf-8?B?L1l6a0dvbHFZd0VFRDZsck1jUEh1Wk8rWnpjaEVEdks3dmg2bFlLdkxCeGNO?=
 =?utf-8?B?Z1ZuY1pWOWUzM2FyUHlFM2FTTUlNb21rZDRlTGRIeXYyWUVMYzdpNWUwbkF2?=
 =?utf-8?B?T2VvdVdKWUk3Sk9rZmlGVjc1UXRucHpkNmlzSG1pVGVaakNBQ3o3NDM3WnNl?=
 =?utf-8?B?ZU56ZlZNTUVJZVA2Y0lROEF3Unl4L2VUMW16NStWY2ZXQ1BPS29nSVdoZTZC?=
 =?utf-8?B?bFhBRG1LK1J1OE5wL2xzbThIcHZDUjQrZmNONWZIM01Ebjl1cnNxUnlCUDhC?=
 =?utf-8?B?S0xtWURpSFJDNHNBQ3RJUG95eXd6UUxuOGdVNjZBbys5eWdwV3ZwY2h3TzM4?=
 =?utf-8?B?NlZVV1ZPVWxrZUs3WWFsUlVra1R1WmxGVVFtVzRieFFQWFFlOW9FZWFCVDhD?=
 =?utf-8?B?Nk5LVDRWVUUvK1plNThjbE0zWlhYVy94bWplZlk0U3N2bjhyamhxWVl2OFVm?=
 =?utf-8?B?MmdPWjExWlFkYkxGNHZnOFR1Qzc5ZEVvMWdqL05ZbzRrN0p1SURvU2dKanEv?=
 =?utf-8?B?bjB6NnF2NW1YSEFMWHlvMmN2WDBOaGFyWlk0SS9oMEhsVnBKdWRGL2Vza3ZV?=
 =?utf-8?B?SFdrRW9xbnJreWpCUkh6a1hZdWt6SGxBWDhmUlZla25wNk94cmlDWGh3Y3NT?=
 =?utf-8?B?aXM2aHFqSitaU1B4VGRLL2k3VXVxM2hCL3NwR3VwbDhocE9MYkU4WHVHbytX?=
 =?utf-8?B?WHh1ei96OGd0M0lKb3p4RnlsY2VLTEJoWEhRalRhemc4NmQzdmJRdVYxbjFY?=
 =?utf-8?B?NnJRZmxBcm1pU1l1T3dNUjZBd00vNWJ3enBuRzl1UzhCcEc1QXpWMDFaL1BX?=
 =?utf-8?B?SkRSWExReUk1dUtBWndyV0tQZXR2VjhiWjR0ZlZRbHl0akFvaVMva2EwZjdQ?=
 =?utf-8?B?TGlzTFBjNklSU2wwZHRONS9ZNVJGMnNEdVkxNWRhZ28wNHJDUGQ4YXJmN1Ir?=
 =?utf-8?B?WDlwVURiVnROdWNROWlIcUwwSlhyQ2VBdndYTkJnUTZzMmQ5dk1kVUd1Mlc4?=
 =?utf-8?B?akF0WmNhN1JCTDBsOFl5VW42dW1icVVtamFRTTkwRmF2dDlrbmJEclZia1BX?=
 =?utf-8?B?T3RkcnFyS1dqRVRMREYvK1BIZmdKMDJpWUpVeEhEa0c1djFEMWJPYVJwQ3Nt?=
 =?utf-8?B?M3FsQkxUZ3J0NUN4REViMDlQZE5qVUJGWXpLWEdxbEtOQ1lSS0JtOXhDeWZs?=
 =?utf-8?B?NDlDeHNGalZ1RVNXODJtdU5QYi96Q2JBenpjVHQ5WnZQbEdqakVqd3BhbzY0?=
 =?utf-8?B?SHJEclFwcXRBY0VkVHR2UVpzZkZ6a2NnUlN3eXRmMENFZ25qbFVCK1lyeHUv?=
 =?utf-8?B?bVJFMTh2NW0rdkY4MHRkdlB6Nzl3N2NZN0U0Um9xZWNqQkkrR0NpdUx1djk3?=
 =?utf-8?B?NTBHeTJ4ZlhJMStRSFVWN0pNMFlveVZNTm0yME5Ec1VhQ3dsZ3BWRldVUmpz?=
 =?utf-8?B?YmFuTHdva0wzamxDMHd3cys4QTdhMTZBYXpyZ1AxU2NUUm56cjRSOWZGTFpr?=
 =?utf-8?B?Zm1yWUZrbld2dC9qMDJXeXU3ZHpqS1IwSERrUThLRTJpRjkrSkNtY2taNEJT?=
 =?utf-8?B?YWpYZ28wcENjVmRzQ0psd1lDRTJzcW9VTXV0dkM2U3ZJa1MyY2I0NldXa1lu?=
 =?utf-8?B?N3VTQlVjVlIxblFFdXJma1VHVWcxUjY4Rkp4ZXJPbXY3Mm11VjZhSEtYTHpi?=
 =?utf-8?B?TkFnenNwQjExS0VDSmJVTjhsaTZpWVoybVYrbmNlR2V1ZTRKMUtRRFpsb0ZJ?=
 =?utf-8?B?Zmh3aUpUbVFDSVQwNnhyVCs1VnFrNCsxN2l3US9SdUgvYUlPa3NyTUVxcHlX?=
 =?utf-8?B?eElDK0J5NWJRZEx2YW1LWWtQY1VneVdiTDhyZ2x2bC9DeE5iNElBQmF4YThP?=
 =?utf-8?B?YmREaDZlajBsMTRNTEI4SlA5U1crMmpmSXZqaVM4bnZhVXdSRkNPV1BLMlZo?=
 =?utf-8?B?UFRGYUNUSEdWZEx6OU16OVBlT0xUbDhQclRsTXo5YnpXOS9pcEY0aUJGUlRY?=
 =?utf-8?B?WUduS1VhQmVDQUptSVZ0TnBYNHFFSWJ1MGFwVk56UEJMbldnZkZFdFVta0F2?=
 =?utf-8?Q?yyLalUUsVIxyOLyiJOt19AKNa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22CB1186A7C70D4F82A589BBD151E064@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f38a6e-a891-444c-d383-08de15e823a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 06:06:30.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gq9ChE3sxcrc5rygAa3851Dasfy/dToZ/10//JNrQCRTbGdBq33xoUG5pBleoQYGTZ6fn7yJPfWJIlzeXYHVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7523

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDExOjM5ICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gQSByZWNlbnQgY2hhbmdlIGZpeGVkIGRldmljZSByZWZlcmVuY2UgbGVha3Mg
d2hlbiBsb29raW5nIHVwIGRybQ0KPiBwbGF0Zm9ybSBkZXZpY2UgZHJpdmVyIGRhdGEgZHVyaW5n
IGJpbmQoKSBidXQgZmFpbGVkIHRvIHJlbW92ZSBhIHBhcnRpYWwNCj4gZml4IHdoaWNoIGhhZCBi
ZWVuIGFkZGVkIGJ5IGNvbW1pdCA4MDgwNWI2MmVhNWIgKCJkcm0vbWVkaWF0ZWs6IEZpeA0KPiBr
b2JqZWN0IHB1dCBmb3IgY29tcG9uZW50IHN1Yi1kcml2ZXJzIikuDQo+IA0KPiBUaGlzIHJlc3Vs
dHMgaW4gYSByZWZlcmVuY2UgaW1iYWxhbmNlIG9uIGNvbXBvbmVudCBiaW5kKCkgZmFpbHVyZXMg
YW5kDQo+IG9uIHVuYmluZCgpIHdoaWNoIGNvdWxkIGxlYWQgdG8gYSB1c2VyLWFmdGVyLWZyZWUu
DQo+IA0KPiBNYWtlIHN1cmUgdG8gb25seSBkcm9wIHRoZSByZWZlcmVuY2VzIGFmdGVyIHJldHJp
ZXZpbmcgdGhlIGRyaXZlciBkYXRhDQo+IGJ5IGVmZmVjdGl2ZWx5IHJldmVydGluZyB0aGUgcHJl
dmlvdXMgcGFydGlhbCBmaXguDQo+IA0KPiBOb3RlIHRoYXQgaG9sZGluZyBhIHJlZmVyZW5jZSB0
byBhIGRldmljZSBkb2VzIG5vdCBwcmV2ZW50IGl0cyBkcml2ZXINCj4gZGF0YSBmcm9tIGdvaW5n
IGF3YXkgc28gdGhlcmUgaXMgbm8gcG9pbnQgaW4ga2VlcGluZyB0aGUgcmVmZXJlbmNlLg0KDQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDFm
NDAzNjk5YzQwZiAoImRybS9tZWRpYXRlazogRml4IGRldmljZS9ub2RlIHJlZmVyZW5jZSBjb3Vu
dCBsZWFrcyBpbiBtdGtfZHJtX2dldF9hbGxfZHJtX3ByaXYiKQ0KPiBSZXBvcnRlZC1ieTogU2pv
ZXJkIFNpbW9ucyA8c2pvZXJkQGNvbGxhYm9yYS5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTEwMDMtbXRrLWRybS1yZWZjb3VudC12MS0xLTNiM2YyODEzYjBkYkBj
b2xsYWJvcmEuY29tDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNYSBLZSA8
bWFrZTI0QGlzY2FzLmFjLmNuPg0KPiBDYzogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
Sm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMTAgLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gaW5kZXggMzg0YjA1MTAyNzJjLi5hOTRjNTFhODMyNjEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC02ODYsMTAgKzY4Niw2IEBAIHN0
YXRpYyBpbnQgbXRrX2RybV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgcHJpdmF0ZS0+ZGF0YS0+bW1zeXNfZGV2X251bTsgaSsrKQ0KPiAgICAgICAg
ICAgICAgICAgcHJpdmF0ZS0+YWxsX2RybV9wcml2YXRlW2ldLT5kcm0gPSBOVUxMOw0KPiAgZXJy
X3B1dF9kZXY6DQo+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IHByaXZhdGUtPmRhdGEtPm1tc3lz
X2Rldl9udW07IGkrKykgew0KPiAtICAgICAgICAgICAgICAgLyogRm9yIGRldmljZV9maW5kX2No
aWxkIGluIG10a19kcm1fZ2V0X2FsbF9wcml2KCkgKi8NCj4gLSAgICAgICAgICAgICAgIHB1dF9k
ZXZpY2UocHJpdmF0ZS0+YWxsX2RybV9wcml2YXRlW2ldLT5kZXYpOw0KPiAtICAgICAgIH0NCj4g
ICAgICAgICBwdXRfZGV2aWNlKHByaXZhdGUtPm11dGV4X2Rldik7DQo+ICAgICAgICAgcmV0dXJu
IHJldDsNCj4gIH0NCj4gQEAgLTY5NywxOCArNjkzLDEyIEBAIHN0YXRpYyBpbnQgbXRrX2RybV9i
aW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHN0YXRpYyB2b2lkIG10a19kcm1fdW5iaW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RybV9wcml2YXRl
ICpwcml2YXRlID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IC0gICAgICAgaW50IGk7DQo+IA0K
PiAgICAgICAgIC8qIGZvciBtdWx0aSBtbXN5cyBkZXYsIHVucmVnaXN0ZXIgZHJtIGRldiBpbiBt
bXN5cyBtYXN0ZXIgKi8NCj4gICAgICAgICBpZiAocHJpdmF0ZS0+ZHJtX21hc3Rlcikgew0KPiAg
ICAgICAgICAgICAgICAgZHJtX2Rldl91bnJlZ2lzdGVyKHByaXZhdGUtPmRybSk7DQo+ICAgICAg
ICAgICAgICAgICBtdGtfZHJtX2ttc19kZWluaXQocHJpdmF0ZS0+ZHJtKTsNCj4gICAgICAgICAg
ICAgICAgIGRybV9kZXZfcHV0KHByaXZhdGUtPmRybSk7DQo+IC0NCj4gLSAgICAgICAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBwcml2YXRlLT5kYXRhLT5tbXN5c19kZXZfbnVtOyBpKyspIHsNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgLyogRm9yIGRldmljZV9maW5kX2NoaWxkIGluIG10a19k
cm1fZ2V0X2FsbF9wcml2KCkgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcHV0X2Rldmlj
ZShwcml2YXRlLT5hbGxfZHJtX3ByaXZhdGVbaV0tPmRldik7DQo+IC0gICAgICAgICAgICAgICB9
DQo+ICAgICAgICAgICAgICAgICBwdXRfZGV2aWNlKHByaXZhdGUtPm11dGV4X2Rldik7DQo+ICAg
ICAgICAgfQ0KPiAgICAgICAgIHByaXZhdGUtPm10a19kcm1fYm91bmQgPSBmYWxzZTsNCj4gLS0N
Cj4gMi40OS4xDQo+IA0KDQo=

