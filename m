Return-Path: <stable+bounces-191565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12000C181A0
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9683AA64C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 02:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85B2D593E;
	Wed, 29 Oct 2025 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J2mgfgNV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Gfksjw64"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD104204E;
	Wed, 29 Oct 2025 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706439; cv=fail; b=eJd4vz5PtVzbTRspANwRp2sKDbdUCdvQScFcPpyL/cb7tFjJF/z9fKODI8+A9e3U3XW+8LxIQkc0dTcFsmyedfUf3NvETHyvjrYjrDNEdZEu1j3zaMSPpVtkyhb1thebtIcHkz+NRkpH9kNf+VMVvwFEzo+vY9emVfqfwWj0Wqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706439; c=relaxed/simple;
	bh=Bl9HrEqeTJ3xCFrmv6oqhcIGEcHHTM55D4ZHb99A75M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tSUyQeZnCczY3yC0ogp7sIfon56RX3eQ7xnBEuSrT/m7dXbiUw73JDBUd1KTvPlbwv863D5U3DV1T5ieQOpMx34y4ohRnsCD98Fe1B/NQhOCJn7fh4EiisSSqcw/uFrvi35+qfAk2K5p0k/rlFeZmYJV/8S68ooIMsS48x6kRaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J2mgfgNV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Gfksjw64; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a5bba9cb47211f0ae1e63ff8927bad3-20251029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Bl9HrEqeTJ3xCFrmv6oqhcIGEcHHTM55D4ZHb99A75M=;
	b=J2mgfgNVX4G7Wy/p8m+z3EfkigdsmKpei6Rg8N492X+RZxV1oANGRXi43BoAKa+0+YlEZOmktnIkWiOCl99WjxbFgSnRSfqlENn2CYfkAXF+ujng8D3cL0sZtwz6GOu+Xy6v+0T+5Tmq5VCWGgsqX+bmp7S36k5hQPz+no1C1cI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7157097f-fe7a-4fb2-906b-d254ad8b43f9,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:ce716a84-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|51,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a5bba9cb47211f0ae1e63ff8927bad3-20251029
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1180361834; Wed, 29 Oct 2025 10:53:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 29 Oct 2025 10:53:40 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 29 Oct 2025 10:53:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6JpG5CiOg68dhjFk+qr/qDR8aTsMD28DqGXLhSMAw+/1xWic2kZoJMoH6Tmj1s1tm6hQlIn99bu3DBy1zddhaEZPNVrHK31VUr+hIFDF8lTGeCeoGmZpN7+RtWnXoDwjTxBU6HZxxaNeTuzHHZIoHlHPKabQDsnXERVdOiVGKUvQ3XQ0IxLCG2wgHGOscRTkpYfSRDcRHw4HSDVwHpvxtur1nJ7z3YMkRtc0GXb0Gua/Z39edG5UP0jOIcsGVppkZOsRYiQZ9R1Z2WYY28LxN/+hZqY7/vfzDnUKdiweLMd/ZqDq+YxzS1gVrANXUmhZvlGdF0DO3CCJsj2l1Gt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl9HrEqeTJ3xCFrmv6oqhcIGEcHHTM55D4ZHb99A75M=;
 b=LX8j/3bM2bonUVk2gmRfyrXsaGuDKXhMhvAFPgPGge071sNsm+yIeHu5UXgGuYPk7cEFUDGCczoZ+FFLph8xCQWAimP9PH/HGRzh1aJS3OQR9Gg2PVIC8RdMdI0dZ7H7sUEgoQEpcvs8Mygjfo3AzHzg8hZsMM3Saa8xFgj6h5HL+Kg5LJ3fof8RHNExY7fdW6t3mV1UiMhO++bHP5pgof+D3ZL6t6KqStf4ho93U41iuO0LBiTMiSpoyxjurkBptyFugx0MGAynhfQ6iorbMzY7dO8hdhaF7ARGt+3y/vLaLqTvTzO2CvV12tk/zzYvOqGW0FNFF9ibQ9a6qtKrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl9HrEqeTJ3xCFrmv6oqhcIGEcHHTM55D4ZHb99A75M=;
 b=Gfksjw64EplSQESd1ameEtMhquzv00VMOGjhgCQV6KQibue9vKomRuyQiGDEgHb4T2CBlgqWodKP51B/fDMOzPsQZrmjKZt7FwL7CAe0MFBOiRuAudJ6UEqHEWBFXPwemOtVMQA9oVk46e1DBh8yxWMO0JN5vUPMlCYQh89R/RU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7134.apcprd03.prod.outlook.com (2603:1096:301:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 02:53:32 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 02:53:32 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, Sjoerd Simons
	<sjoerd@collabora.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"simona@ffwll.ch" <simona@ffwll.ch>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "greenjustin@chromium.org"
	<greenjustin@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	Tzu-Hsien Kao <tzu-hsien.kao@canonical.com>,
	=?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jian Hui Lee
	<jianhui.lee@canonical.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM driver
Thread-Topic: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM
 driver
Thread-Index: AQHcRSTP8aynjdybb0+869rbUSjgaLTXZmuAgAENtoA=
Date: Wed, 29 Oct 2025 02:53:32 +0000
Message-ID: <7d83e90baa93b8858ccd2fea351e006a3e361226.camel@mediatek.com>
References: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
	 <6a13caa9f566951df8fad7ce79460ef35760e798.camel@mediatek.com>
In-Reply-To: <6a13caa9f566951df8fad7ce79460ef35760e798.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7134:EE_
x-ms-office365-filtering-correlation-id: 6172016c-b025-4baa-6aa2-08de169658df
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|42112799006|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MHlpZjhXaTAvTjdaSlUrMjVzY0l5K3dDeW1QTFltQlppekNySDJTOWFwZklo?=
 =?utf-8?B?REFDTGlBK3lMQXZSNnphQlRBZSt3c050M3NhcFFIZlRiSFo5WktWZGZReHBi?=
 =?utf-8?B?cHBlNy9LL0wyblFCMEIyenk1RjJQZzQxYmVQQXRtRzhFT2M5cy9hMHZRVEY0?=
 =?utf-8?B?WHB5M2pkMGpFNWYyVVg4cDZ2R0R4djcwQ3U2QWdOQXpGZFJZbGVkaVAzdS9t?=
 =?utf-8?B?aGZUbk81NmpOZXRFY2hLaW1GbUtZRnIvVDl1d2ZGa1RBTHlpN3FQOFhFRlZM?=
 =?utf-8?B?Q1RQQ2hpandQQ2IyMmdoM1VWM3RGb3BuZnArRmxsQ2FsOFIrSUJGOGFHbTRu?=
 =?utf-8?B?c3BjMU5nUGFxZ09JbC9yeWc2UStEMmFYaFNad1EvdjdGVURzYUMrUXBQeVc3?=
 =?utf-8?B?S0tlc3RlMDBkVE9uUjdzSENmMUM5QlJSRlBIdy9HZ3Z0QXdkV3ZuWmNNMW5I?=
 =?utf-8?B?ejMxQ29kUys0SnlSa2FSUUowRndvbWpzOGVnRXF0WEdaNTdrZzMyUktrQzhn?=
 =?utf-8?B?NTJYUTFSUDl4VTRtd09GVmZyS21aSng1TzFUYUpha05xSWlBRjJIVThqOVRu?=
 =?utf-8?B?U21Wa0lIK2UxSnorVDdyVWgyK2hSVUVNb0VrYnVObHQrRTV4NVg1bmsvMjFY?=
 =?utf-8?B?c1Q3Y29lcUVjek9aWWJUU01hbGJ4UGRVOUZQeERkcFc2a0VxQjFmeURCNFJL?=
 =?utf-8?B?NnpjRkczRkpTMDJaMk1EMkd0bXp5YXRROGQ2S1Z1VmhidlJDY255UlNPSE1B?=
 =?utf-8?B?dStWYW02R2tFOVpXamxxejFzbnZuTEdIaXQyY1Y1U1F3Nm95SlF6ZTNNanh4?=
 =?utf-8?B?Rkxhd2lOMnNMTGsrS01KbnNhd2Mwb05qODBNQzJ5aWU3TFE3WURFNk4xMUVo?=
 =?utf-8?B?eGxzZUxKclpObXQ2dnpWd0VkbG40L1ZPbnVZM3VIUHQzbjFwRG5mWUhDZzla?=
 =?utf-8?B?bHBHS1RlMXJTeGRUVzdOTndldFBKNGFBelJzbkNvd2RLbVJ1amFuV2t1SzJG?=
 =?utf-8?B?R0haRVQyMHNPZUlodnBJNmJPcUpoNHNXc2pBY2s5dkRISE9GOFNNSjhTbmNR?=
 =?utf-8?B?Qm9rdWFyN2NoMmQyZWw5UVRac3ZlYVdYeG4vWnhFY211SG5GU1NxN0VuQUs4?=
 =?utf-8?B?QjZWRjJDTHJkSjZST2RmdjJzVVg5MDFGSFhGVmhVS1hFZVgwSFA1dEc3VHZt?=
 =?utf-8?B?WDh4MGdSMDNiUTFPYjhaN2lnTkVlejhrd2NZdGJkUVVCeGdXeFM2TWVSU0Vp?=
 =?utf-8?B?OVNqLzhYVEE1b1hGekswdENsZ0NvRWxWMHhtWjljQ1hVSWhnMlA2bkp2V01h?=
 =?utf-8?B?VjBqeEhFN3JjUFFNTEFiME1XRUN1YWZKY0M3cDdtR2hxY3pYZTJpMHEvbEtM?=
 =?utf-8?B?d01OakFueDlGN0RhbEhCZHNiaWZISi83RlgwYmJKdmIzZXN2a01xZkdmOXg3?=
 =?utf-8?B?SkFTcGNiM05EeWxYY0ZSekFLbCtIUkdaUGJURHA5eXI2SlZBR1RyNGRnRmVU?=
 =?utf-8?B?MVJLYlRESzNhMFQ5Q3Q5T3NmRHlVN1g1eHNDd284cHBYVFlIRGR1bVlHV05T?=
 =?utf-8?B?Vk5CeXRPVUN4dkZmUWFQQlhzeHlLY2Jna2FOS3JBVmxMNnNxaUlYRlBEL1pD?=
 =?utf-8?B?V3NQbnpDVjlYdnhGYVNma0VPR0M2djhocW81cWF2aC9zVWczS0xIQVBNNnRO?=
 =?utf-8?B?dEsxbXQ0aHk2TVRpTmRoTE1xQW1Gd0NmMEdaZjQwejJYc25IUzkrMU52MFdE?=
 =?utf-8?B?Z1k3K0RhMWd6N1lWcEtQcnNnVHVIb1A5STFrRHUrYld2cHhTVWxxU0NrR3Yz?=
 =?utf-8?B?ZlVhN1RITzdjRzVROTI2cTVQYWNlZXhFRWxXRHVxTTFUNCtDdjI0VVgxbFIz?=
 =?utf-8?B?R1pQQlhsMU9jbjZaL1VjOWFpUUlqc2xhb1lIZmlBem5Qclc4eVd2ZGNWMEdC?=
 =?utf-8?B?QzJNMThkSWVkWHJPT0gxMFlVQW1YRHNoNGRuZDVDOWwzN1EzeUp3ajhRSVgz?=
 =?utf-8?B?NlVuaTFvbVBzQjFWNWs2VmpscitWbHNJVE9HZ2pWWGV5N2JTMmdkOElFR096?=
 =?utf-8?B?U0htYjdPZlRSL3BELzBmYmlrT1g5VE9Xc3I0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzArdFJGaElIaU0rUU5hdVc5OVVnR1dNMmxraVZQWWJaZXI1Wk1LNzdQbUpk?=
 =?utf-8?B?U0tBU3gwcXlKbUhTNGpnVGRReWIzenJVWllWenVUbWdSWFZvM0ZCRXNZQUZB?=
 =?utf-8?B?U0VxUC9CRWlIdi9rZ0xWN3YyNmREdzFZZzBESDNSYjlRSjN6dTFnK1ZkbUZx?=
 =?utf-8?B?WjQwUHdmajE4UW44WmVsQ2MrcGd4UFlGRFZZcGNGcTVYQXp1T3FnSEJqY2Zv?=
 =?utf-8?B?cEdYL0J4emdiM0RwYWwyUWJ3MnhtV1pRUWgybnZWZloxcTRRL2owbnFkVXhP?=
 =?utf-8?B?ZzVrYUVrbWVSaGFWS2M3d29jSWpjc1JOaVRPUDErN05ORG1ibnFHeHBHM1Qy?=
 =?utf-8?B?a0tOWmVHNkx6Vm9ZdllSRjBRbjdyd1JRWVdIRmFOTUNhY3M4VWd6Q2doMTll?=
 =?utf-8?B?OThrMjNsMWJkVFBvaElQTllJU0lIN2N5MWRlREY0QmtQM1I0ajRsZHVCeUZu?=
 =?utf-8?B?S3Z3dlZvK05yS2tLbjRFSHdiMFRTbkt4TU56WE54YUlwQjV0RExUTkdmaC9U?=
 =?utf-8?B?VzJ4NWdGdW1JbjlaU0VwdTBiTDFJT043RkdWVWI5b0VTQ3l4VzZKS0VWR2RL?=
 =?utf-8?B?ekhyYk0zOUVzZXh0WXg5cUZ4WVNlVEFldS9VeVY3SURTK3dPUXNPRGwzaVF0?=
 =?utf-8?B?cFl1OWxkYW5lN3ROUDB0VkREWW55MTNBTW43SFFXemtMbm1lM2VQRXh3a2pQ?=
 =?utf-8?B?Qkp1YlNwSUxSUGo0aC9LOFh0ajlWeGhtaGZndDVtUDhCRGRrMXIxTENsaEtw?=
 =?utf-8?B?Q2NsdHIwaEVwbzdkWEJJaE1qZEFTQjRkbDJNYytvUXhVS3B1ckpTd3hLUVZV?=
 =?utf-8?B?aDJKMDFnSzJFaEtSZms2Mk5VZC9Wb3kwVWFtN0MxZkFRQzhCckV5MHhCU3k5?=
 =?utf-8?B?RDI1ejAycEFyTnRIeFc4ME5DRUNSdTdoc3M3V2k1NnVSRitBKy9kTWh1VDQ0?=
 =?utf-8?B?QlBMZjdDMks2YzhEU1U2Tms3TlpLTnhwUXhxUXNqdmoxV3VjWkU3UUg4RVV2?=
 =?utf-8?B?WWViRnVaTTZMNFl2clhuSmUxUURaU0lrc2RVeklxdXlDV1plRGw2eWV1eHBT?=
 =?utf-8?B?T2RsaU96OEpLZEhYQ3VtT2lqZGhRMXJJakFzbE5QUWw0N3hCTjhJRnI0VStw?=
 =?utf-8?B?eDN2SG1iUFljWmQ1WmhUQkQyVE85OXlnVU53NGt0MHdmdTJvUEhTcHc4THpI?=
 =?utf-8?B?VytoWlRDOGJUVnpzMEdHY0dkRS83VUhjZTRTUEN1NkZTZy9YeGFiTkowOFFj?=
 =?utf-8?B?ajBMR0lnd0Ntczc1RlFkNzRDTTdsTmxwUVp3TEhRVktVc0x6VFBIM1ZXMGQ4?=
 =?utf-8?B?aThQOC9hZk5FMDhyRFN1TW1RbjJwVmR0R1JISDZ1MTRHODhnTjUyTm1EbEdp?=
 =?utf-8?B?Mmk1SmkrWW5zWFNJSENpWmsyM2QyVVhpY2lyRGN5bXpyeVRuODdKS2dLQ1ds?=
 =?utf-8?B?NnVZYWlWSlNaVzBqY1hZelp5M2trb1A2REJ2WlQ0Qlp3OE9vYXVZR0w4bDll?=
 =?utf-8?B?QlN0eStlaTNBdytLZDIvdERqcnU3bkcvT1g3Mk9IN3RrdWNubk9DZGt5RFF0?=
 =?utf-8?B?dU5iMDlPRnFCMFlzbUNOYkJ1UStuN3ZsTkFWNFhYbXhMRmsraytKOGE5K3pa?=
 =?utf-8?B?RktIb1Vzb0F6WFRUUkNUNUF3cXNMYlA5STkrYTIrWUFEZ3AvRXlkR3ZXSms1?=
 =?utf-8?B?UU8xUGx6dG1SakpTQ3dZNDRhNVNKZUV1VDNlUTVJN205YlNPS2syMFA4a2ZJ?=
 =?utf-8?B?SHBpUCthYnJyQktSeFY1VlBXcTJxWkl6bGFrdFlCREZGY3RNUThValMrSStp?=
 =?utf-8?B?WTFrM09JdFRKa0pEdkdzZFpBdUVsVk15b3JGL3MzSlY0bVhSOGs1bzc0MzFy?=
 =?utf-8?B?RDV0dmFpZ1A3aEdUNlhhZmZTQjYyUHhtOFl3ejdDbURoM3UvTnBFazlldlA3?=
 =?utf-8?B?cWx2R2pPeDc5QWhOa2VqMzJKTzNJdGZsQWZwYXk2NEYrUmVIc2ljb1pHbkd1?=
 =?utf-8?B?NlcyaStFMElJc2xvR0E1Zm5XMHlMcm40QmZia2R4b2ZldFpaUTd1bldOMlJm?=
 =?utf-8?B?UkdUSGZOQ1d4VzJ0VU1hOHhWcElkN1pFQmpBTmpKNHBUcEREYXhweWhJUkpR?=
 =?utf-8?Q?QEaxSW7Esw8tdgQO7REJLFxyH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FC5BDBF471B2A4F949F1A84E581A5CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6172016c-b025-4baa-6aa2-08de169658df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 02:53:32.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHqc5si8zaXKu3rnJvfoKtDpEOA0VH7vyslHDVUO2I3oGt0sldx0ybIgjGm6W+wu6cTx9xbqVFQ03Z1q49zOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7134

SGksIEp1c3RpbjoNCg0KQUZCQyBqdXN0IGltcHJvdmUgRFJBTSBiYW5kd2lkdGggcGVyZm9ybWFu
Y2UsIHNvIEkgZGVjaWRlIHRvIGJhY2twb3J0IHRoaXMgZGlzYWJsZSBwYXRjaC4NCk9uY2UgZml4
dXAgcGF0Y2ggZXhpc3QsIHRoZW4gYmFja3BvcnQgZml4dXAgcGF0Y2guDQoNClJlZ2FyZHMsDQpD
Sw0KDQpPbiBUdWUsIDIwMjUtMTAtMjggYXQgMTA6NDggKzAwMDAsIE1hY3BhdWwgTGluICjmnpfm
mbrmlowpIHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI1LTEwLTI0IGF0IDE3OjI3IC0wMzAwLCBB
cmllbCBEJ0FsZXNzYW5kcm8gd3JvdGU6DQo+ID4gDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVh
c2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4gPiB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+IA0KPiA+IA0KPiA+
IENvbW1pdCBjNDEwZmE5YjA3YzMyICgiZHJtL21lZGlhdGVrOiBBZGQgQUZCQyBzdXBwb3J0IHRv
IE1lZGlhdGVrIERSTQ0KPiA+IGRyaXZlciIpIGFkZGVkIEFGQkMgc3VwcG9ydCB0byBNZWRpYXRl
ayBEUk0gYW5kIGVuYWJsZWQgdGhlDQo+ID4gMzJ4OC9zcGxpdC9zcGFyc2UgbW9kaWZpZXIuDQo+
ID4gDQo+ID4gSG93ZXZlciwgdGhpcyBpcyBjdXJyZW50bHkgYnJva2VuIG9uIE1lZGlhdGVrIE1U
ODE4OCAoR2VuaW8gNzAwIEVWSw0KPiA+IHBsYXRmb3JtKTsgdGVzdGVkIHVzaW5nIHVwc3RyZWFt
IEtlcm5lbCBhbmQgTWVzYSAodjI1LjIuMSksIEFGQkMgaXMNCj4gPiB1c2VkIGJ5DQo+ID4gZGVm
YXVsdCBzaW5jZSBNZXNhIHYyNS4wLg0KPiA+IA0KPiA+IEtlcm5lbCB0cmFjZSByZXBvcnRzIHZi
bGFuayB0aW1lb3V0cyBjb25zdGFudGx5LCBhbmQgdGhlIHJlbmRlciBpcw0KPiA+IGdhcmJsZWQ6
DQo+ID4gDQo+ID4gYGBgDQo+ID4gW0NSVEM6NjI6Y3J0Yy0wXSB2Ymxhbmsgd2FpdCB0aW1lZCBv
dXQNCj4gPiBXQVJOSU5HOiBDUFU6IDcgUElEOiA3MCBhdCBkcml2ZXJzL2dwdS9kcm0vZHJtX2F0
b21pY19oZWxwZXIuYzoxODM1DQo+ID4gZHJtX2F0b21pY19oZWxwZXJfd2FpdF9mb3JfdmJsYW5r
cy5wYXJ0LjArMHgyNGMvMHgyN2MNCj4gPiBbLi4uXQ0KPiA+IEhhcmR3YXJlIG5hbWU6IE1lZGlh
VGVrIEdlbmlvLTcwMCBFVksgKERUKQ0KPiA+IFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgY29t
bWl0X3dvcmsNCj4gPiBwc3RhdGU6IDYwNDAwMDA5IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08g
LURJVCAtU1NCUyBCVFlQRT0tLSkNCj4gPiBwYyA6IGRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9y
X3ZibGFua3MucGFydC4wKzB4MjRjLzB4MjdjDQo+ID4gbHIgOiBkcm1fYXRvbWljX2hlbHBlcl93
YWl0X2Zvcl92YmxhbmtzLnBhcnQuMCsweDI0Yy8weDI3Yw0KPiA+IHNwIDogZmZmZjgwMDA4MzM3
YmNhMA0KPiA+IHgyOTogZmZmZjgwMDA4MzM3YmNkMCB4Mjg6IDAwMDAwMDAwMDAwMDAwNjEgeDI3
OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4geDI2OiAwMDAwMDAwMDAwMDAwMDAxIHgyNTogMDAwMDAw
MDAwMDAwMDAwMCB4MjQ6IGZmZmYwMDAwYzlkY2MwMDANCj4gPiB4MjM6IDAwMDAwMDAwMDAwMDAw
MDEgeDIyOiAwMDAwMDAwMDAwMDAwMDAwIHgyMTogZmZmZjAwMDBjNjZmMmY4MA0KPiA+IHgyMDog
ZmZmZjAwMDBjMGQ3ZDg4MCB4MTk6IDAwMDAwMDAwMDAwMDAwMDAgeDE4OiAwMDAwMDAwMDAwMDAw
MDBhDQo+ID4geDE3OiAwMDAwMDAwNDAwNDRmZmZmIHgxNjogMDA1MDAwZjJiNTUwMzUxMCB4MTU6
IDAwMDAwMDAwMDAwMDAwMDANCj4gPiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiA3NDc1NmYy
MDY0NjU2ZDY5IHgxMjogNzQyMDc0Njk2MTc3MjA2Yg0KPiA+IHgxMTogMDAwMDAwMDAwMDAwMDA1
OCB4MTA6IDAwMDAwMDAwMDAwMDAwMTggeDkgOiBmZmZmODAwMDgyMzk2YTcwDQo+ID4geDggOiAw
MDAwMDAwMDAwMDU3ZmE4IHg3IDogMDAwMDAwMDAwMDAwMGNjZSB4NiA6IGZmZmY4MDAwODIzZWVh
NzANCj4gPiB4NSA6IGZmZmYwMDAxZmVmNWY0MDggeDQgOiBmZmZmODAwMTdjY2VlMDAwIHgzIDog
ZmZmZjAwMDBjMTJjYjQ4MA0KPiA+IHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAw
MDAwMDAwMDAgeDAgOiBmZmZmMDAwMGMxMmNiNDgwDQo+ID4gQ2FsbCB0cmFjZToNCj4gPiDCoGRy
bV9hdG9taWNfaGVscGVyX3dhaXRfZm9yX3ZibGFua3MucGFydC4wKzB4MjRjLzB4MjdjIChQKQ0K
PiA+IMKgZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X3RhaWxfcnBtKzB4NjQvMHg4MA0KPiA+IMKg
Y29tbWl0X3RhaWwrMHhhNC8weDFhNA0KPiA+IMKgY29tbWl0X3dvcmsrMHgxNC8weDIwDQo+ID4g
wqBwcm9jZXNzX29uZV93b3JrKzB4MTUwLzB4MjkwDQo+ID4gwqB3b3JrZXJfdGhyZWFkKzB4MmQw
LzB4M2VjDQo+ID4gwqBrdGhyZWFkKzB4MTJjLzB4MjEwDQo+ID4gwqByZXRfZnJvbV9mb3JrKzB4
MTAvMHgyMA0KPiA+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+IGBg
YA0KPiA+IA0KPiA+IFVudGlsIHRoaXMgZ2V0cyBmaXhlZCB1cHN0cmVhbSwgZGlzYWJsZSBBRkJD
IHN1cHBvcnQgb24gdGhpcw0KPiA+IHBsYXRmb3JtLCBhcw0KPiA+IGl0J3MgY3VycmVudGx5IGJy
b2tlbiB3aXRoIHVwc3RyZWFtIE1lc2EuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQXJpZWwg
RCdBbGVzc2FuZHJvIDxhcmllbC5kYWxlc3NhbmRyb0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0K
PiA+IMKgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jIHwgMjQgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIz
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX3BsYW5lLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxh
bmUuYw0KPiA+IGluZGV4IDAyMzQ5YmQ0NDAwMTcuLjc4OGI1MmMxZDEwYzUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+ID4gQEAgLTIxLDkgKzIxLDYgQEAN
Cj4gPiANCj4gPiDCoHN0YXRpYyBjb25zdCB1NjQgbW9kaWZpZXJzW10gPSB7DQo+ID4gwqDCoMKg
wqDCoMKgwqAgRFJNX0ZPUk1BVF9NT0RfTElORUFSLA0KPiA+IC3CoMKgwqDCoMKgwqAgRFJNX0ZP
Uk1BVF9NT0RfQVJNX0FGQkMoQUZCQ19GT1JNQVRfTU9EX0JMT0NLX1NJWkVfMzJ4OCB8DQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBRkJDX0ZPUk1BVF9NT0RfU1BMSVQgfA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQUZCQ19GT1JNQVRfTU9EX1NQ
QVJTRSksDQo+ID4gwqDCoMKgwqDCoMKgwqAgRFJNX0ZPUk1BVF9NT0RfSU5WQUxJRCwNCj4gPiDC
oH07DQo+ID4gDQo+ID4gQEAgLTcxLDI2ICs2OCw3IEBAIHN0YXRpYyBib29sIG10a19wbGFuZV9m
b3JtYXRfbW9kX3N1cHBvcnRlZChzdHJ1Y3QNCj4gPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBmb3JtYXQsDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IG1vZGlmaWVyKQ0KPiA+IMKgew0KPiA+IC3CoMKg
wqDCoMKgwqAgaWYgKG1vZGlmaWVyID09IERSTV9GT1JNQVRfTU9EX0xJTkVBUikNCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gPiAtDQo+ID4gLcKgwqDC
oMKgwqDCoCBpZiAobW9kaWZpZXIgIT0gRFJNX0ZPUk1BVF9NT0RfQVJNX0FGQkMoDQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBBRkJDX0ZPUk1BVF9NT0RfQkxPQ0tfU0laRV8zMng4IHwNCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFGQkNfRk9STUFU
X01PRF9TUExJVCB8DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBRkJDX0ZPUk1BVF9NT0RfU1BBUlNFKSkNCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gLQ0KPiA+IC3CoMKg
wqDCoMKgwqAgaWYgKGZvcm1hdCAhPSBEUk1fRk9STUFUX1hSR0I4ODg4ICYmDQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0FSR0I4ODg4ICYmDQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0JHUlg4ODg4ICYmDQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0JHUkE4ODg4ICYmDQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0FCR1I4ODg4ICYm
DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX1hCR1I4ODg4
ICYmDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcm1hdCAhPSBEUk1fRk9STUFUX1JHQjg4
OCAmJg0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3JtYXQgIT0gRFJNX0ZPUk1BVF9CR1I4
ODgpDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+
IC0NCj4gPiAtwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiA+ICvCoMKgwqDCoMKgwqAgcmV0
dXJuIG1vZGlmaWVyID09IERSTV9GT1JNQVRfTU9EX0xJTkVBUjsNCj4gPiDCoH0NCj4gPiANCj4g
PiDCoHN0YXRpYyB2b2lkIG10a19wbGFuZV9kZXN0cm95X3N0YXRlKHN0cnVjdCBkcm1fcGxhbmUg
KnBsYW5lLA0KPiA+IA0KPiANCj4gR3JlYXQhIFRoYW5rcyBmb3IgdGhpcyBwYXRjaC4NCj4gSSd2
ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBhZ2FpbnN0IGs2LjE3LjUgb24gbXQ4Mzk1LWdlbmlvLTEyMDAt
ZXZrIGJvYXJkLA0KPiBhbmQgaXQgaXMgd29ya2luZy4NCj4gSSd2ZSBhbHNvIHRlc3RlZCB0aGlz
IHBhdGNoIHdpdGggJ21vZGV0ZXN0IC1NIG1lZGlhdGVrIC1zDQo+IDM0QDU5OjEyMDB4MTI5MCcg
aXMgd29ya2luZyBhcyB3ZWxsLg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIGl0IGlzIHBvc3NpYmxl
IHRvIGFkZCBhICJGaXhlczoiIHRhZyB0byB0aGlzIHBhdGNoPw0KPiBNYXliZSBhZGQgdGhpcyBw
YXRjaCB3aXRoICdDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjNi4xNycgYXQgbGVhc3Q/DQo+
IFNvbWUgTGludXggZGlzdHJvcyBhcmUgY3VycmVudGx5IHVzaW5nIDYuMTcgZm9yIHRlc3Rpbmcu
DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNv
bT4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hY3BhdWwgTGluDQo+IA0KPiANCj4gKioqKioqKioqKioq
KiBNRURJQVRFSyBDb25maWRlbnRpYWxpdHkgTm90aWNlDQo+IMKgKioqKioqKioqKioqKioqKioq
KioNCj4gVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChp
bmNsdWRpbmcgYW55IA0KPiBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJp
ZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZQ0KPiBleGVtcHQgZnJvbSBkaXNjbG9zdXJl
IHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgDQo+IGNvbnZleWVk
IG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0
aW9uLCANCj4gZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2Yg
dGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgDQo+IGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVk
IHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgDQo+IGJlIHVubGF3
ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBlLW1haWws
IG9yIGJlbGlldmUNCj4gwqANCj4gdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KPiBpbW1lZGlhdGVseSAoYnkgcmVw
bHlpbmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIA0KPiB0
aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwg
YW5kIGRvIG5vdA0KPiBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkg
b3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQoNCg==

