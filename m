Return-Path: <stable+bounces-87796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0779ABBDC
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7845B234BE
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC383CF73;
	Wed, 23 Oct 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kBqt/zbu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ePejkL69"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A17F7;
	Wed, 23 Oct 2024 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651777; cv=fail; b=lKTvrIKOoEA4gSvzxCSy6TXMN+kbO9WMuwPktH/jAYsimitChNJZWs14uWOcSaNCT3PpzxYl3FFAbgIk/Icq6XH8Br5WSNP7Jdeq2uNZwoin8zEE3ML6P6iJP5sbSGGM2dTdGEf+xAg4EO4J/j+OlSkddPxB/HTaJg+jD3Uj9VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651777; c=relaxed/simple;
	bh=f5IBxaQI7DdO0pOFuf/fEPC19M5q1Cp0/kPqRr5V7h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/BGZ8k+s/Zw4NgvW4B2nlIOXcfQxAYU0FKJdkLnaDKoxS/szFwnm6hFMsv12F+bIuKimWfwMkQX4bSQmqRkrH1GbuIsfuqBYRRNh1axTsyTqL69p1vzs+Av5AjvzEJr47Nx4/x0EP9a877rCMc6XyXj9kE3q0P1ilCUL+FiVGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kBqt/zbu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ePejkL69; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 699d25ea90e911efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f5IBxaQI7DdO0pOFuf/fEPC19M5q1Cp0/kPqRr5V7h0=;
	b=kBqt/zbuPxYSYdY+7WnR8Vn2iLd6J8BkNROLZPsBmGXy0syTmVlwwghr/r5DjpXznwmuZvChPbMWyaufhQJVXmuwy5N3XZTZwFgpoU1KiK9/esKS7usB3+F1pfCfco30ZrQo/P4n9c8gqyTnkMreQ50emmgDojIcNbEdCVYBNX0=;
X-CID-CACHE: Type:Local,Time:202410231049+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8e4644b2-d3fc-4307-944e-18169cc4463f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d72bf62d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 699d25ea90e911efb88477ffae1fc7a5-20241023
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1258065374; Wed, 23 Oct 2024 10:49:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 10:49:23 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 10:49:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4FNVmIgKZyyRnnupx1DAoqB2gaFVZqF1cx11N6QXT1w9i0IKk1jeMOKk8Dnb3I9LRFxt1VRRW0S9V+zHJHjNf0DZ8IWBNwuNEB0wHW+y9R9ZjPnM7jzPcVtarJd4A8TQUb5VOrc9rJGKSLyW/gYJjSwBnHOFJrwFbfqWEAa3unfL69T2ISHQ77SSu3Z9ZlL+lMbx4zqGogksYXzQycyaKCMvbEbDoUaUaK2sShcS4xGeAa2gUrbWR5dd+Psfpbcuxq/J/gA0Gs1Pr+m07z8vuwtFanx2ft4/RLns4Z0rs97igGizwIwJ3OC9ziGLDKHDWeVBtciZB9sM62GkgravQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5IBxaQI7DdO0pOFuf/fEPC19M5q1Cp0/kPqRr5V7h0=;
 b=aR8eCnqtJd7rJsv+KFH7ipWWGvTM7NZVQOjyH/7Z6mNW3ySdjWN+OiCEjqV2Cg6NJk5sJ8hDyGux2HjdueKpUtNNSU0x8JNBPFuSTwzk2ngoxlzWXlFwRKF8Y7KUULw35k3OZScekyBACc6+1dUT+dEtvIYd0l6gvJELfY+jO1JjrkpztmshTyYnEP7VInKJ3N4uEpxdN4/OFn98LNnRzLdsq2Dg/kwIQ8WVg5s9+jd+6j9IyE3dOm6rlZYfuCItTeHcVt3JbzNfnwfMsK0OiPp6fyjCJOddraVhLqmthV5HU2jfJtVlX/lTEfw/fSQ6M9MY2pUJ6Z1O1yvHCL+ywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5IBxaQI7DdO0pOFuf/fEPC19M5q1Cp0/kPqRr5V7h0=;
 b=ePejkL69craCXQpw2/TcPvvPkWZYWAKvYle7Sr2jlg8SYPVozmFLjwlDZT1KQjr3kO17zQLbXw4cnW5z+HmHUakJOJhcHhy6wmcG6LyoJ7/rY+1URGO0EUR44Mp+z+xqTVr2V7C8YnT1z+rDClDZz5UgQm/kQb6l1qaWU/s8BZo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6595.apcprd03.prod.outlook.com (2603:1096:101:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 02:49:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 02:49:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Alexandre Mergnat <amergnat@baylibre.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
Thread-Topic: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
Thread-Index: AQHbHBLxqSXSJ37t0UygXVj3zPjzx7KTtCqA
Date: Wed, 23 Oct 2024 02:49:20 +0000
Message-ID: <f77bbe7a264b0e51904c0e3cf9acc2d8a54bb5d0.camel@mediatek.com>
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
	 <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6595:EE_
x-ms-office365-filtering-correlation-id: 6c64f4f6-d4d5-4f18-b01b-08dcf30d4b36
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dW5ZMlYrZm9kckpXTkVIYit5RmpkQTlHaElXaHZ2S2RVRnpGZVBXMUFvc3U0?=
 =?utf-8?B?ZWx6NGVMTzZuZnZjdThRS2JVN0NGOVRVaXZLMUI1R1VHYURVYkxiL2gyTlFR?=
 =?utf-8?B?Sy96UzVYUlBIa2ptK1pJSGk1N2xOVHJBeERvL0RhSzFwNk9zN0l3MFBwdS9j?=
 =?utf-8?B?OHNqNHZMQ2ROa2hhK2tvbW9NMDRwRCsrSHdkMXBYYkRPcWhmZkRSWHI2SUdm?=
 =?utf-8?B?QXEyb3B0dldzMzNGWTBKaGRzdGRlckxJWitrRDJlbDl3MUhvN0VTayt5VWpK?=
 =?utf-8?B?VTlNbFZnelhpZkNFQUVVTGpiT1RKZUcxUkg2SWR2MHZyRHdjaEprclQ0YkxZ?=
 =?utf-8?B?MGxSd3hZVjE1enNPZlR2N3ZKaE5BaUxoRWN2Qk1FWGFOVk5OcVkrZW85RFdI?=
 =?utf-8?B?YXo1bmZYT3dyU3NaYTFOYXNJTzVqR0E3blFENE5pdGUzMFNQaEpwOHV2R0s5?=
 =?utf-8?B?OWEwTmVoWWpnZWZkYytIbWYzekI4QVZPejJuQ0NzYm5rVnhxNHBheXFhZ0ty?=
 =?utf-8?B?c0ZjVVpTWU9kMlIyY2d0RFl2MFA2STlBZ294dmM4SlRrODFtMU9NdndkbU5S?=
 =?utf-8?B?NDNJaTRYTko5cElWZmNFSmlVUlJCMHZFSFVsN1dtaGZWVVg4NXlFTWlvWE15?=
 =?utf-8?B?Y2FGb3M1RGtwMG9wNlRVanBHTWN1WXAxVTZsRTA4SVZHRkJFRkRyMkN2R2wx?=
 =?utf-8?B?eUsyYnU3YmZ3MXlNQ0dKTlptQmtKZ2wxMUU1OEhNMDRmVnRtNWFEOWg5ZXhW?=
 =?utf-8?B?dzBGZmdjTzJMSmVLTFVicEZPV1FSWjFHa1g3aldoRUFhQTRZbERsczljalRB?=
 =?utf-8?B?ZTR0NEdiS1ozUHcweENmcjE1MHNwVkI4WnRaN3dRUFVuRXF5OHprc3R3Tk9F?=
 =?utf-8?B?N3lNUTdXV1YvMHRvKys4UTJoK0Z1YTlOd3BSUjBmaHhUeTdqRk1mUkNPdlBG?=
 =?utf-8?B?Ym9KSWREZ1l1aE5xc2FYZnpDdVVaUXRvU3BJakZ4OW93WmhyckpDd3M3V3J6?=
 =?utf-8?B?VWQyRDFNT2NRNUduOGV4ek5SWHNIMnlpblZFMjk4UnZjSnJQZ0xjcTNzN0pa?=
 =?utf-8?B?TEVTQzNwTkIrVG9GNHMrQXl5T3BNekdwWTdzcndrcW56clNUVFNpMWhJNFFW?=
 =?utf-8?B?LytIeDVxdDMxY090V0h4eGJuVlFQOEdLbDlHU3M0ME1Uem5Vd0o4c2VncDk5?=
 =?utf-8?B?NS9aQmlqL1BBcDZRcm1MUzFPY1EwZU83NmVPakhOSFdrR1ExeEVGTllJRDRP?=
 =?utf-8?B?dlN1YUh0RGtDbzc2aHViSDQrY0VlYWMxWkNUYmVldDk1QnZoUU9Ya1FDS1pT?=
 =?utf-8?B?TkgxcnpoUXpuaVpKRGFaUWxTdytFa01ITWJpaVZyZWdJMUhoTjJCcUJsT1cr?=
 =?utf-8?B?d25SZXcyc0RpRWI2NWF4NTA1cHpGZWs3dEtTZUE0VFI0RFNTODZLcEV5VEdi?=
 =?utf-8?B?SHV0Ly91WFJaN2hIZ0EzU1B6REhpOEE4dFRDcnVXNTRLd3g1SFVRb2NoNmNI?=
 =?utf-8?B?OVdVWk44di91OHpTaGJRYXgvdFRLaFMrcCtwSWpCTDBmYWdGNk56MW5zN3g4?=
 =?utf-8?B?dXRSTWkxbSs5cnFMczlBRGFCRWR6Tk9BZE1YMjR4MHdCelAzQUYvV3dDZ2lh?=
 =?utf-8?B?blRqeTRCeHgvYUg1TkhqdC8xRGxwZ2JhRjFuMzloT28zcXUyZUxzQ2lPZDFR?=
 =?utf-8?B?Zlg0UVVwQjY1Zi9LZDhKRkZJNDc1RlVneExtTzdjWG9ETnUyU3l0eDdHK0Nz?=
 =?utf-8?B?UXF1b0duRnJmUUJ2eVA0c05hckw0OG1qd1VaeVYwbkNNUmhkdDVlQ1UwRkEy?=
 =?utf-8?Q?grvjEY8pxR07vTBdaNfWFcgc6+5Y5hM9mqTcA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhoRXNsZFJEV3hMeENRQ0FDUUZOZmlOMTBsaTc0VTE0WDliNW95V3NaTFV0?=
 =?utf-8?B?M0xSQU9INkliUmRENjI5OEh5NFlTUkorS1czZ05qZ2RPOW54d3JjRWxKQlA0?=
 =?utf-8?B?WFlNYWVVQngwVnRDa3lFMGRZSmJLRERjU0hBd3hCbHJtbTY1TnRaVGpRcjF4?=
 =?utf-8?B?Q1JVQ3NzMU1FbXlqTVBUT3FyWmpVZERwQ3gzRWl4cUFjeFUwVVFPRGNSazcv?=
 =?utf-8?B?dzBPSWhRQVEvY0hxck9GYVNRalErZVEyZ05ubUxjc2FKWXc2T1JBTHYrOEFS?=
 =?utf-8?B?S1JFYzlkOEhMWlJQdlNDZFpJZ2QrNjRzTm81YmtqOVpxNzFKdGlIeU1iY3ph?=
 =?utf-8?B?UktkUE1DZVRkd29Yd3hGcWxDN2thbXhZM2VFbXd0UGhBaVFmZDM3U0lUTFA1?=
 =?utf-8?B?Sk44ZWR1Y1Vkb3JSMnpySzZtbXkwZFFzRFQzekxJckx2UlVJdHNJRWd6SjVl?=
 =?utf-8?B?c3hjeTV3U0oweDhDeGhUVWdRcTE4eUhGeHJHaWVHVlJzb3d0UnQ3a0dWUHJV?=
 =?utf-8?B?TE9pMGh0NUQvdjBpNGJKWElCYm52UjlUSS9LL1p6b2ZNdFhNKzliOGM4dkNT?=
 =?utf-8?B?eFNrd25CVnd2Vy9UcWtqdmViWTlYNGxaYlhPaGlZL1ZXQU5ya2toaXA3OEJR?=
 =?utf-8?B?MllNTVlWNHpmbkczckNteWZ4TWdKS3NUTzRiM0dnRUd2TjBVQ0tnRnNvZkNv?=
 =?utf-8?B?QTRiaFhEWXc5RHdFZXN6NUlTK21zQ1RTYnlWQ3BPWlh3TWUwcHRUenh0NlRL?=
 =?utf-8?B?RXdKa1pGeXVVVURTWTI3c3ZDTTFxYjR5d3dOdXc3dnhyRlZNem9QZkxySEhv?=
 =?utf-8?B?TXZ1R3h2b2VtNlpLVVdWUURvMXJkWFJuVksvbjQ5WlJQV1ZUZUdMVFB2ZHlS?=
 =?utf-8?B?aFB5K2dKL3NzNnlhdVdjU1pGTjBJZW02RU4yN3I3OGk0Tjh6Wk5EbEV1M2Uy?=
 =?utf-8?B?cExGaU90dkFsUEFlTE91OExILzl2bzg0OUNxbUxObnErYU50VzVwakJ3OVh1?=
 =?utf-8?B?a2VMRlppeXYvMmVrMzlXTjJwZUE3Qnk2SjYzU1lIbTVYdHJObjFhMHgzalk4?=
 =?utf-8?B?a2tXdHA3b05mNHRyV2cvano5K3BEOTU5YVdiekR3YUxXNFBGTG9reFgvcjNI?=
 =?utf-8?B?cnhoK1JMS2dYNFo0ZytNVSs2djA2dmY4SkExYlpOTDMramlidFFqVURwRU5K?=
 =?utf-8?B?VDBwVlZGdy96eXIxOHlwMitBQURVT3ZnY1FSYUZOL2JQdUU4dDZqWWYvRmNo?=
 =?utf-8?B?ZEUyZjRUSU5Xb2V4bzdNdEhHVnVkT283T2tBUzlUL3JRU0lOMkM2bkNsU2tK?=
 =?utf-8?B?bE1WdVJVSzVabmxzcCthQ3ExeUhOeEV1QlhnVHBSdU56ajN4TmVaUUFYUzJs?=
 =?utf-8?B?R2h2bWZuYmlYT1dwZTRLdHFvNWp3bDdHUWJWbmE5dDVoQWxLTWdVWUpNRHBw?=
 =?utf-8?B?Z0pXN0N0NGhNQThsVmRKcFpzNTB4Y1JEeHNoeDFOanRkYkU3WGZkMVFkeGNz?=
 =?utf-8?B?VW1Ob1pCbFhUc25NVmc0V0VKVkM3N1BRNVhTeUk0ek9Hd1FCL2RERmpoUUJU?=
 =?utf-8?B?WWNuRWNabGlYNTJhY25MYzBmVGdhUEorNnNSRW9vYmtVWTVzZVNyb3FlZU1K?=
 =?utf-8?B?KzJXVGdUYVJYbWZ5Qm44WlhyWnNVK1hIWFpnZy9wSFIxVDdiVXZvS0VqYUhQ?=
 =?utf-8?B?bWtLZ1NhdnpzQUliM0FzYVZ5QTlxdDhhT3kyMCtreFo1NXJidHgyUHNzajEz?=
 =?utf-8?B?aGVaS0EyNkowUGRwNHY1YW5ZbEt6K1dCUWtjeENwWmNwSk9ZTXNreFFzMTVN?=
 =?utf-8?B?T2VVWVd2Z1hrWFN2R1NvWEFtcjZtZU5CSmp2bUJ4QndXdTMrRkk2TFJwNmtC?=
 =?utf-8?B?cytBcExTdUdtTnBIbVcrOHB6eTJwVmxycVBvWG9VZGFLTm1leHJVY0oyZk5J?=
 =?utf-8?B?V1J5aUFRZUc5WTRNTzBjTVNQdlIvb2lPL2hCNFZWRys0Z2pSeTVVeG9BTmJi?=
 =?utf-8?B?NFo1dDFmeFNQYWN0bmhKSnNhamlucmtwZ2VTdFl0dm1pVGgzSWl5a1MvVi9C?=
 =?utf-8?B?d0NUcEdvdWl1V3lPZ2FTWW9OajAzVWFzQU5ra2M4VkVudWpZdm9kRmZrWld6?=
 =?utf-8?Q?hTrMGo74YASjMAtetZBq5dMXV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B0A148294CA6F4AA0F6B8EF1F788D03@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c64f4f6-d4d5-4f18-b01b-08dcf30d4b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:49:20.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmWVWm1mHFEbiOYSS5+Amuh2DM3/l1oEDvpcxWhPzYm38Lf8lNFmyeGSwxRmqXXLEj3XTHLspYFTIkRBiGZBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6595
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.974900-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/u9VmuE3O2T8ya1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCktr2/0YfvSFF6z9HGHKwNsxmbT6wQT2azhgoAzehG32mh9
	FxhVbvTDdbRD8u/M+WKLYJXbChS8QWbvYSwAXzZAD2WXLXdz+Ae3+iQEtoSj4fmHrLgoJIlxB1a
	iBo8t8crlK18H/cd3he/6aYxCz7bJC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07Qsfa
	qMZktsdCKfsB9qdPti8/RcP3bXufi2E5ToGT3YEfQGr8EVb81k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.974900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4E3ECC1450616034D43F3A72077DA32DEC593090DBA75DD6C7139CDB9AF0926B2000:8

SGksIEphdmllcjoNCg0KT24gRnJpLCAyMDI0LTEwLTExIGF0IDIxOjIxICswMjAwLCBKYXZpZXIg
Q2FycmFzY28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgRWFybHkgZXhpdHMgKGdvdG8sIGJyZWFrLCBy
ZXR1cm4pIGZyb20gZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZSgpIHJlcXVpcmVkDQo+IGFuIGV4cGxp
Y2l0IGNhbGwgdG8gb2Zfbm9kZV9wdXQoKSwgd2hpY2ggd2FzIG5vdCBpbnRyb2R1Y2VkIHdpdGgg
dGhlDQo+IGJyZWFrIGlmIGNudCA9PSBNQVhfQ1JUQy4NCj4gDQo+IEFkZCB0aGUgbWlzc2luZyBv
Zl9ub2RlX3B1dCgpIGJlZm9yZSB0aGUgYnJlYWsuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBG
aXhlczogZDc2MWI5NDUwZTMxICgiZHJtL21lZGlhdGVrOiBBZGQgY250IGNoZWNraW5nIGZvciBj
b3Zlcml0eSBpc3N1ZSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgQ2FycmFzY28gPGph
dmllci5jYXJyYXNjby5jcnV6QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gaW5kZXggYTQ1OTRmODg3M2Q1Li4wODc4ZGY4MzI4NTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC00MDYsOCArNDA2LDEw
IEBAIHN0YXRpYyBib29sIG10a19kcm1fZ2V0X2FsbF9kcm1fcHJpdihzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICBpZiAodGVtcF9kcm1fcHJpdi0+bXRrX2RybV9ib3VuZCkNCj4gIGNudCsrOw0KPiAg
DQo+IC1pZiAoY250ID09IE1BWF9DUlRDKQ0KPiAraWYgKGNudCA9PSBNQVhfQ1JUQykgew0KPiAr
b2Zfbm9kZV9wdXQobm9kZSk7DQo+ICBicmVhazsNCj4gK30NCj4gIH0NCj4gIA0KPiAgaWYgKGRy
bV9wcml2LT5kYXRhLT5tbXN5c19kZXZfbnVtID09IGNudCkgew0KPiANCj4gLS0gDQo+IDIuNDMu
MA0KPiANCg==

