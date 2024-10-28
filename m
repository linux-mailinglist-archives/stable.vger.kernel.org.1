Return-Path: <stable+bounces-88258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F239B22F5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889C5281B96
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A618734F;
	Mon, 28 Oct 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d8tqElBG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MNMvAU8d"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F118C03D;
	Mon, 28 Oct 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083142; cv=fail; b=OBfG5qtALUUNb3bayMXbCsErrm+4VzwqvDxuSOksMunxkKZsUZ9PN4WQ7SoCuFp/wMvZ5KhLc6LFNYqJIrISufK2aAZZ0i3cHoPFEQdWoB1Jf6Y83+cee6RcJ0g2IF+8y/2WbjY//ikJAK4rrUYPylX9QYXge8i3eEhZGnV/zXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083142; c=relaxed/simple;
	bh=Q4KVbjU/wYCy8KQ0P1zudCeYjL61uwbLBdeIZNsxwqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DEnfMEP+IBv0IZBmx6UW+eNrr2OhQZYmdEi3lyy+vSe90j4yFQ9DJQykyvyROqvI6lKh6G/zVw9ejw6mBY9Hs1B5AfYmniUQ4FAK1uCBlljUbKpBqPHWjmTQrI9grX0snCEmmrAIVeqMcxs/2B/f6LBJOuSNPoQlSC6V98MUWQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d8tqElBG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MNMvAU8d; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c5d3126c94d511efb88477ffae1fc7a5-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q4KVbjU/wYCy8KQ0P1zudCeYjL61uwbLBdeIZNsxwqI=;
	b=d8tqElBGxa9zivHTZVZPTdt+Jaw8jzObGRdzb+MH32n0NuWrzj04TK+B9K+dkUV741s4CkkpKLHz5Rm3LsAH4jiYPyZnJCBytTiXee1uP42tNvY8zjiUQVkySsSCIj/E11ixzy3TgXI8fe56tezQHV+6OVDUfnxJSVEO35aCvnE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:b1926a18-db82-4bb4-bd53-d30024f0623b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:9b0c322e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c5d3126c94d511efb88477ffae1fc7a5-20241028
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1906700258; Mon, 28 Oct 2024 10:38:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 27 Oct 2024 19:38:52 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 10:38:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj+RpnfKGKEuAlevhw56Us4eDKhiCjQRhTOy2shZApoqhi7iv6FQtSPqkt8o9xAChCABsXXhGqr1seJnnOdLlYHCaCmaFiK0oEy42fxj60qQy5byskWXN9C/defQWBhhrWluHQtLRZuEDAnxd1lVcz4kBEox2xzf0IDwyVxpSWIn0f5UiNCUY3JtFheHNCIHsXbePCjsOms/m96KUdm17x5RxSQRTaAZyKbY4pBmUDmu4PWtPoV3E/MggXpRj5YNPvC2kFC6Z1dBRq7RDIhf41ByxiX+DY4yqo9NuNqUJPc0XL3LwHPY3EktPcHhv/namqftzC8Lie0EJ8ghStQ49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4KVbjU/wYCy8KQ0P1zudCeYjL61uwbLBdeIZNsxwqI=;
 b=BiJpf06xB2OFRLME2CB5rUk0LM7a9vSp5F1x9huWhdTMQ1m9WEKjaOduNOxz8idPgv1F1IoBB4qh5347HJT5x7KPERSUZawDN6RVbDkLPnVWlToCJHEY3FPtTR/CFZNwtUbs0eskLB3IQXLJCD6Za6exFYkadT/dlgDk2gf7G7SaczCWbUUbBMCyufZllD+H166tTItXTUrvRnwVw3ACDScRPcTtPidwDdTx6FzLiVL1nnJKbIywVCqlkXwXSSickPpdfbW0d1WnHhsbh9bESSA6bytQlU8P7dxQ9j5q32xTW27Gu24iJf8OnflDF4m4Rcr3acCqptX3WtB0lbtDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4KVbjU/wYCy8KQ0P1zudCeYjL61uwbLBdeIZNsxwqI=;
 b=MNMvAU8diT88goK/zpDaq9DosOph2zzaG4oqeiCyA1QEl6z6iQ6uqx9Ru4nlhGhMAAtaCF8xzYUnZcEwP3HoyzCqgWa49vD052cHR8HPzfG+Y0Ma183LjSFVTEWZ/iePbXvXNkZYdTcOoqgX1J4pBt4BDLK8ktdke3FPVzBMtMA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8659.apcprd03.prod.outlook.com (2603:1096:405:b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:38:50 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 02:38:50 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJfiKpGmIlcb1JUuto1yu1g4WFbKVp3wAgAAKRQKABcdVAA==
Date: Mon, 28 Oct 2024 02:38:49 +0000
Message-ID: <ddc5f179dfa8445e2b25ae0c6e382550d45bbbd3.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
	 <2024102406-shore-refurbish-767a@gregkh>
	 <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>
	 <2024102411-handgrip-repayment-f149@gregkh>
In-Reply-To: <2024102411-handgrip-repayment-f149@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8659:EE_
x-ms-office365-filtering-correlation-id: f32a9dfc-a70b-4352-3937-08dcf6f9a7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2FTSk00WlNpTVJuSnZHUDJqWWQxank1em1IU3pYa3RxLzd2eW5aU3J2V05s?=
 =?utf-8?B?Rm9IUHhFMDlOdjVBbnFiT3YzS1B1TnlrMU1KdlJKSEtxcmxDUWdhM2N2TSs3?=
 =?utf-8?B?cFFlVFJpZ2FmVDJjK1BYa1dHYlpTRml6ZWhkaTA4VjNoc3FwRHJGK0IwQ21o?=
 =?utf-8?B?Q2p1Y05uekR4dkZ3Qld4L0wvd3huQVRBdDVIdVBmZWt5NlJmYUtmTE9OZ0ht?=
 =?utf-8?B?UTFVbGlKeS9va1dRVkRMcmM1SGRnM09FMDhnWWc5N1F6TEZoZiswV09ab2Zo?=
 =?utf-8?B?d0JHbndtN2lqdmlVelI3VlpVV3BWbWpBN0dqR3pxZDJSVDU1L3JibEJWUGNz?=
 =?utf-8?B?Myt4Q0tMY05VTUJvNGM1T085YlhMRFlyU0tDQ0F2OVBNQ0lFcm1PaitEc3gr?=
 =?utf-8?B?RGtwenUzWFpib1ZvOXdXYjZOM2paSmVGR3RtTWhBSVlLcUVrODkyU3pEeVlm?=
 =?utf-8?B?Qk9kMVNoNzlNQTlRbFluN1VVRkxERmp6eHFtRjFTVnQwTlJEbmdGcTRTTjdO?=
 =?utf-8?B?T2tPVENWNllQanV3b0YyMGJ4TGUrRVNtaUhjbFhsbkZGT0pxazIyYmhVc1hR?=
 =?utf-8?B?b1RSRGVNeFIveDBSVzRmNDRiK2kyT00vTVhtUmVIR2pXbUx3S2h0V2lnWnhQ?=
 =?utf-8?B?blBZb0k3c1p4MFN6TnljMDd6R2pFaGcxS3luUEJDMEZVQTlOTWs2ZlJ5dWlj?=
 =?utf-8?B?MjU5cy9BUmFIWk1NaUdIbU9Ba0FHRkt4SWtuenlwc01kZUZDS2Mwc2VTOEJj?=
 =?utf-8?B?emdKQWUyeWZXVjN2TVZhQmtSUW5CWC91V3JNY0V5cXhGYzNUWHVsNW1SbjB3?=
 =?utf-8?B?V1pQMmdNSWtULy9lVzN4WVdJM0NMMXdkb0FsUEFBYXpSN3JPaGMzSldUcGZQ?=
 =?utf-8?B?cWk4Nm85QkpRNVlrTHhjY09KYUxTYWlKL2dmSnNvZS9kdldhbmY2NWhNcmNY?=
 =?utf-8?B?alUwcmgvV2hsN2F5Q2xFcVZiMjhFQ2lNT2U4T3JKK3VIOENOb2tzcmpQREh5?=
 =?utf-8?B?dHRpbmJCYjBXMEhxbytLUVNoL2daaU5rbnJwZ3ZubHJwa2NNYmc1SS9hQTJY?=
 =?utf-8?B?My9aUjlXampMZ3hzNXozbmZ6VGw4UnQ2ZWlqYmVoRk0xSVkzSkJmajdyM2NY?=
 =?utf-8?B?bXkwNjZpL3FxRld4VG1VOVUydlQrSnNCVHFLdzlaUE5qeDcwSXE3Q1k2RVZB?=
 =?utf-8?B?WXV0MUJOL3ZsMHcrNUh4V2dRbEwrQ2hLQkxvcVlhTkN4cUV6R0VVRXdVYVBC?=
 =?utf-8?B?aXNudVNnRStYWEEvSXdjYlRqam9xQmtBR2lNZFEzbm0wQlVGWkx6b0o4MW9v?=
 =?utf-8?B?QnlRZzZYSHhjV3BPcXk1T1pqWEZyb05FOTE3L05RblpFTHJnTXRWZmkyZkds?=
 =?utf-8?B?dWdxWUZ4OUUxZ2NCUG8rUUVPWDN2bTQ4cDA5Vzk1N1ZUVEZnVmRoWitKRzB0?=
 =?utf-8?B?ZUtVRmJkTHY0UkNjLzlQR2hIOUZIdlBqNnJJdmtlUnI2UHpUV2ljMjFHQzZx?=
 =?utf-8?B?NWd5REMydytlb2xucCtmeWRVekJkakMrNDFidVpVYVlkUTBHOEhIbmJKN1lk?=
 =?utf-8?B?NXU3ZndNdDdIR2VaUXJxYTFTTGJwRWJpaHVqbWxmNWVWYlBiTi9abVdoS0t2?=
 =?utf-8?B?b2M1eWxheFdvUFVKVFpJSmI5bFFRK0VwQkI3L2c3NjhsQ2J2WHBlRWNncXp4?=
 =?utf-8?B?RUNTQXE5eHpwUkgyWjdiMkJxZENnc1pQc3pKNTBreGFYYXBjdnU1dDNFb2cr?=
 =?utf-8?B?RGdnSnd2QkN2RGhSMHFlVWhYZFFocXFiVFlFVnpWQ3NoeGxjaVZBNXJHUk1k?=
 =?utf-8?B?d0R2RjErOTNTblBaS0xhTzVONlpPNFp0enozcE96Y012bStUQ0piQnFtdElD?=
 =?utf-8?Q?xd2KATgS7yuyM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpZNGR0Tmk4TGxuOHJieG9Fb0FzZ3NBaWpaWVZIc1dqa2FFZ3dBUlRhbFJ0?=
 =?utf-8?B?U1hVOWdTbjgwWC9YWk1ORmRrUG9qQU1ITGV5ckZSUnlacDNVNGhobUx3MDVC?=
 =?utf-8?B?R2I3VmNLNUx4KzFGL0lSQ05nNG5kM2xoRzRMTTN0RGJ5aVNJRFNGa2U2dUx6?=
 =?utf-8?B?bGVnVldDZkJ6YWtyTjZtYm5BYXBVRjhTbFhxcHBrTG9FUkd1VmJybVBKT0Zv?=
 =?utf-8?B?VUd0L0trSnMzYUpRcE5Lc3NUYlQyV0hrbWcrc212U003YStPZldhbGZVQTZu?=
 =?utf-8?B?UzBjSjhIbFVDTzBTV2tYbnhUMXk1WHJZb1RZRWZ5L3NINHBiQ0pFbDlxbHd0?=
 =?utf-8?B?SnlmZ0YzN2ZuUURPVDhzSi9uemVpeGE0bkZRUjFKOU50ZEFrMkdZVTJza0l2?=
 =?utf-8?B?cVVpQTJwUW1YTnRMdzZaRm9Qb2hBcDQ5VFN4OCtJNTdDd3J4QWluZHVoWEYx?=
 =?utf-8?B?RFpQY2lndDdEbHg4UXAvYi9janlYK3RBL1ByYzVwR3k0aHRkVytpa2JHMXJB?=
 =?utf-8?B?SUI5dzF3VGk1NHBNQ0NQVkhDYk1jRStFQkZlcXQ4aWV2SENOZUo3TjdzRThw?=
 =?utf-8?B?cUZZNzA0eTBRZ2dzbC9rMkN5ckgrY241TWNtLytYcWVlc0FoZEdDSStmSWVa?=
 =?utf-8?B?SVBHTENYSEMvclM2MnpvOE1ya2tCYlpZQjdsSXJXYWxQWDlNTFNTRm1jbGJS?=
 =?utf-8?B?MEU1K0doR0Y2dCt0djFaVFVwTlBXZzlvSDU3Y1Y0c2tyR1pTa1B2K2RQL3p6?=
 =?utf-8?B?ci8xUThJK1dnTmlPYlM0QWR5NkhYUVMrT1hhS2lwN2JtWGRZcWRYOUR6MzY2?=
 =?utf-8?B?RGtSOVY1aGZDcmw2VmJCM1JwV1duZnJTQndDQ1pCKy9NZmJTUjZNR1BVV2xC?=
 =?utf-8?B?ZkZITFVodXJ1Q3NhaE5oRGYvUkNaSFBpeUtObjZtQ0xTejZBYzNBR3JrcVVH?=
 =?utf-8?B?UGRDRWsxOGtEQzQvcmY5THRmZ0RlRVhjcmdFTmtad2NnVGxMMjV2Z2thNEZH?=
 =?utf-8?B?QW92NmpXQ083bUNtTlduSlVDUXJSVTVlVHNWTEdjaENHNCt6Q2ZQVVFRTTlJ?=
 =?utf-8?B?OWh6K2JZOEJubHVFZGkzQyt0VGNYbEZDWlEyRjdkd0E2enF5VzRSMDdTSUNx?=
 =?utf-8?B?VGZ3alRrcFdrWWRGWFpsWEtaaS9MS3RYY0VDSUNTdGV3YWJoSTQveFZUUThj?=
 =?utf-8?B?ZUN0eU8vUmplekFraXJSdlRUc1RPeDZXNkZJdVpJSEZ0K1JvYUxEZjVwL0h0?=
 =?utf-8?B?U0Q3eFZic3cyb2xINVBIUEJBd1J4ZGxzalIyRmwxK1MwRE1rbFprZHpOL0wy?=
 =?utf-8?B?RlpXMDhkZHpiNU92ZG8yTTRCWGRoN0R6U21iLzZaYSszTCtrS2NOSThFNXdx?=
 =?utf-8?B?ZEo3YzRzVCszTEQ0T2JEa2RpT3plUnh5Rm9WcEhwRGlzclliVUdid2dGS0xB?=
 =?utf-8?B?VGtuck0vSG1aN0tiUjF2R05WUFBvY0ZSM1FvK0Q5eXRKSEkrRGRiY1BVMFN3?=
 =?utf-8?B?TmFqVTQ1dDFlTDVPcDU4Tkw1ayszR3QwamsySndXS0t0UFE5dzdWemFCZXY5?=
 =?utf-8?B?aDlXcnlwZml6QjBIY2NLbTNBVGxCd3JPa05SSWZzYXBJeU83dHlHUkozNkNY?=
 =?utf-8?B?d1ZndVhYOWsvMmxlNThsQis4ZzZPYTNWY1RHbzRidkpBa3ZJVlQ4R2lUZWdE?=
 =?utf-8?B?TzlGOXcwT0FCZkcrLytlUkNtQzUwZDN6cTFOVHAvK2ttRkxSc1BvbnAwdnZD?=
 =?utf-8?B?MmpBOGtKRW02K3BHRlVja2dyTXFQb2pJQ2szVlZlS3ZmOXEwSURkR05uRjV2?=
 =?utf-8?B?OGRqc2N5bEdrVm1lS0hkOTBQcXlWd25pSEdodFNEbUVMWUdPbzlpYmc1L0Vk?=
 =?utf-8?B?cEUvQ2lUbFRYcWVCRUpxdVlVaWxMQTk0NTBPbFpzamd6L25tRlhtRU5odkZT?=
 =?utf-8?B?cC9SRW82cjB1WGh0NmliZ1h1U09VZ0FUaldVLytmYkV2K2l3dlYwYTBMM0FG?=
 =?utf-8?B?ZGpScEJ2WnA5ZHpmajhDRTZCZ2pTNGF6WHJxdnM1UVA1MkFDVjJkeFVuNjll?=
 =?utf-8?B?azdYV1pZQlJRNHkyMmhiaGQvY2NrMXZBeDRqRTZycndXc21wem9NOVlsRHAx?=
 =?utf-8?B?Y2N5QW4wYUxvOWc2SXBYekh2Z2M3TGpRclo3NXM1clQ4OVpmNlgrMWZYTXpz?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA661FDF648EC4BA3D2CDBFC3B801B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32a9dfc-a70b-4352-3937-08dcf6f9a7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:38:49.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qYDPaRxf5gQYLs1KWH4Sru4tgx3aXlpGzc0Rl9MM/uO8js0DkK1fw8j4S/79fbLksN94qSGIFg0iChdfkwaYSH0eqZYfjVXz4yEtq0ZqUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8659

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDEyOjIzICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBUaHUsIE9jdCAyNCwgMjAyNCBhdCAxMDox
NjowNUFNICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gSGkgR3Jl
ZywNCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gT24g
VGh1LCAyMDI0LTEwLTI0IGF0IDExOjQ3ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gICAN
Cj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gIE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDA1OjM3OjEz
UE0gKzA4MDAsIEphc29uLUpILkxpbiB2aWEgQjQNCj4gUmVsYXkNCj4gPiA+IHdyb3RlOg0KPiA+
ID4gPiBGcm9tOiAiSmFzb24tSkguTGluIiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYWM4OGExZjQxZjkzNDk5ZGY2ZjUw
ZmQxOGVhODM1ZTZmZjRmMzIwMC4NCj4gPiA+ID4gDQo+ID4gPiA+IFJlYXNvbiBmb3IgcmV2ZXJ0
Og0KPiA+ID4gPiAxLiBUaGUgY29tbWl0IFsxXSBkb2VzIG5vdCBsYW5kIG9uIGxpbnV4LTUuMTUs
IHNvIHRoaXMgcGF0Y2gNCj4gZG9lcw0KPiA+ID4gbm90DQo+ID4gPiA+IGZpeCBhbnl0aGluZy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IDIuIFNpbmNlIHRoZSBmd19kZXZpY2UgaW1wcm92ZW1lbnRzIHNl
cmllcyBbMl0gZG9lcyBub3QgbGFuZCBvbg0KPiA+ID4gPiBsaW51eC01LjE1LCB1c2luZyBkZXZp
Y2Vfc2V0X2Z3bm9kZSgpIGNhdXNlcyB0aGUgcGFuZWwgdG8gZmxhc2gNCj4gPiA+IGR1cmluZw0K
PiA+ID4gPiBib290dXAuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbmNvcnJlY3QgbGluayBtYW5hZ2Vt
ZW50IG1heSBsZWFkIHRvIGluY29ycmVjdCBkZXZpY2UNCj4gPiA+IGluaXRpYWxpemF0aW9uLA0K
PiA+ID4gPiBhZmZlY3RpbmcgZmlybXdhcmUgbm9kZSBsaW5rcyBhbmQgY29uc3VtZXIgcmVsYXRp
b25zaGlwcy4NCj4gPiA+ID4gVGhlIGZ3bm9kZSBzZXR0aW5nIG9mIHBhbmVsIHRvIHRoZSBEU0kg
ZGV2aWNlIHdvdWxkIGNhdXNlIGEgRFNJDQo+ID4gPiA+IGluaXRpYWxpemF0aW9uIGVycm9yIHdp
dGhvdXQgc2VyaWVzWzJdLCBzbyB0aGlzIHBhdGNoIHdhcw0KPiByZXZlcnRlZA0KPiA+ID4gdG8N
Cj4gPiA+ID4gYXZvaWQgdXNpbmcgdGhlIGluY29tcGxldGUgZndfZGV2bGluayBmdW5jdGlvbmFs
aXR5Lg0KPiA+ID4gPiANCj4gPiA+ID4gWzFdIGNvbW1pdCAzZmIxNjg2NmI1MWQgKCJkcml2ZXIg
Y29yZTogZndfZGV2bGluazogTWFrZSBjeWNsZQ0KPiA+ID4gZGV0ZWN0aW9uIG1vcmUgcm9idXN0
IikNCj4gPiA+ID4gWzJdIExpbms6IA0KPiA+ID4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIzMDIwNzAxNDIwNy4xNjc4NzE1LTEtc2FyYXZhbmFrQGdvb2dsZS5jb20NCj4gPiA+
ID4gDQo+ID4gDQo+ID4gUGxlYXNlIGRvbid0IG1pbmQgbWUgbWFrZSBhIGNvbmZpcm1hdGlvbi4N
Cj4gPiBJIGp1c3QgbmVlZCB0byBhZGQgdGhpcyBsaW5lIGhlcmUgYW5kIHNlbmQgaXQgYWdhaW4s
IHJpZ2h0Pw0KPiA+IA0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIzUuMTUuMTY5
DQo+IA0KPiBZZXMuDQoNCkhpIEdyZWcsDQoNClRoYW5rcyBmb3IgeW91ciBjb25maXJtYXRpb24h
DQoNCkkndmUgc2VudCB0aGUgcGF0Y2ggYWdhaW4gd2l0aG91dCBhZGRpbmcgYHYyYCBhZnRlciB0
aGUgW1BBVENIXToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAyNC1maXh1cC01
LTE1LXYxLTEtNjJmMjFhMzJiNWE1QG1lZGlhdGVrLmNvbQ0KV291bGQgdGhhdCBiZSBmaW5lIHdp
dGggeW91Pw0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCg==

