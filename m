Return-Path: <stable+bounces-28335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AA87E43D
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 08:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8D1F212D9
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175E22F02;
	Mon, 18 Mar 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Naz3hhwt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="toxrNnAG"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D8224CC
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747988; cv=fail; b=AZAFo/2AjZExSVBCdfikJZ5bEQZX5lfzpWlo5KdjxYb1HWUlV609bvpQhyLIpoP3wkZ+/79Uk6Gihed4stCk+8JqD3rlh+4nU96OmUvQKxsG+4Vf3kYBUC0Puz9zqILLWkXwOLv5/tQLdP1lKgbwvtOFz00X3Z+EpWQiGKv944M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747988; c=relaxed/simple;
	bh=Y2obXPXNtRz8bMZFAz/5U8OI9NxWjo/mJhesJd7jwW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lix06b/FVS8rzFxc50/bKQv1k7AETjUSdgbN36pKpIXlTHM1TJQfm/OjsKv+gitaqsGgmsRXf8M7fzayDBypFNPvyE9k4YyHKsQMIe1hP+UyLyOiHwm+gm2tn30eddGNXqbRHHX/PTN8+fyNP4nBF2EZ/AQHBVPj/eJl8CLjTEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Naz3hhwt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=toxrNnAG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9af4cc32e4fb11eeb8927bc1f75efef4-20240318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y2obXPXNtRz8bMZFAz/5U8OI9NxWjo/mJhesJd7jwW8=;
	b=Naz3hhwtIUI7E0Ht0h0kJG/DIvLAw0uzoNiSjy+qWsUwvGFGq2e8uvVIOPsqJcOFJRKYxQHlhx/JAPAR6Cq46Ny7a1y7bqrMFVMD3ylJGh/D1Wop6ySzqhg1dVz4YS5MjMvo/4TZro0c+n7gXD5ldtJgR7wwm0WcR/mHRhbFnOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8afdb1d9-b276-4c65-baec-802bf2cb495d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:14770400-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9af4cc32e4fb11eeb8927bc1f75efef4-20240318
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <lin.gui@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1450887472; Mon, 18 Mar 2024 15:46:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Mar 2024 15:46:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Mar 2024 15:46:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHA6hzWkg1OLNPfOVoxoJEQoybSmTdJawsFI9SJYUTrSo59uB357JyDdp5b7HOMwOuDTMPB/CS1ux11zlvIBups4Y/eHY8YHWPkQXrljnHxz+D2gPZOrQzK3AS5Xb54oj7hBM8BBj3RkVAntnTsgxN8IqSR7ZIKIAw3Yo+OQqe91KX/HxYsb7fpXeGaiwNnVbEBLn/a131NTUakljkeQ9+dVBGjmPntfex9GYj25UrjHKFcJ+hBQT3l44JHV4srOODA6v4AggsccqZ2nYb4anD70Vo4JClPZZL8D2+DTzrd/GPNRpTRGyjsW7gWorUCXrbqSva/GqNwgw7GhMt6EtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2obXPXNtRz8bMZFAz/5U8OI9NxWjo/mJhesJd7jwW8=;
 b=JlCk1cXu/DyPnv7VU6qQa3UgYjEaNMDXCrbk8xD/QNSR0oDoIIlJMFUQPAZfIQUGeCa8czPSeYxBgpAUGYTaZhlM9N1Tc8aPpx609fTlhCk8GuSVycAKsaYN1DGLr3juMbUJiDjYOpHlcdCUm9W80RUHhx4o6Cfu9/AQzPyA2oC31bDeYn3+651e1dHsMN7vEansu2CzidrpbiBL3FX7cGARDLJVoBx9XFbw0AUEIr/u6UH7sLsyoPV+Nv84nzU++pz2cKaEvv7zwGrIx10/s8IpSHu3ZQAdQezsrN7to+8RDuZqSHaJM8edNHmaDDlOlLee0h5dJ3zG7bOV4CMGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2obXPXNtRz8bMZFAz/5U8OI9NxWjo/mJhesJd7jwW8=;
 b=toxrNnAGqHxjVQt9H/bFohbSpJya+KKthgVSoIJncrkKqNk2GaHe1vbSVHxIKfHpNHPqyYORcryZDfJrtPS1oz8nVfpt+ACUmCZ38bLfk1h6L7E1q6PPr1+J/Uyws0vmrHeKzZw2cvYgpELxo7XttRi/FiJlWUNq+B7j5QqCZ7I=
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9)
 by SI6PR03MB9029.apcprd03.prod.outlook.com (2603:1096:4:230::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 07:46:15 +0000
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::dc82:7aa5:b2f8:2fea]) by PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::dc82:7aa5:b2f8:2fea%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 07:46:15 +0000
From: =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>
To: Sasha Levin <sashal@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?Qm8gWWUgKOWPtuazoik=?=
	<Bo.Ye@mediatek.com>, =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?=
	<Qilin.Tan@mediatek.com>, =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?=
	<Lin.Gui@mediatek.com>
Subject: =?utf-8?B?5Zue5aSNOiBiYWNrcG9ydCBhIHBhdGNoIGZvciBMaW51eCBrZXJuZWwtNS4x?=
 =?utf-8?Q?0_and_6.6_stable_tree?=
Thread-Topic: backport a patch for Linux kernel-5.10 and 6.6 stable tree
Thread-Index: Adp3eTWrkYSO8E82RRe9kg2KOgLeiwAAECPQAAJ3hwAAYQ92gA==
Date: Mon, 18 Mar 2024 07:46:15 +0000
Message-ID: <PSAPR03MB565334F399C37B0711F0ACB4952D2@PSAPR03MB5653.apcprd03.prod.outlook.com>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <ZfVkmm5-Ja8ub-i8@sashalap>
In-Reply-To: <ZfVkmm5-Ja8ub-i8@sashalap>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-Mentions: sashal@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrNTQyMzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05NTc4NTc0Ny1lNGZiLTExZWUtYjczMy1hNGY5MzMyZDU2ZjhcYW1lLXRlc3RcOTU3ODU3NDgtZTRmYi0xMWVlLWI3MzMtYTRmOTMzMmQ1NmY4Ym9keS50eHQiIHN6PSIzNjc4IiB0PSIxMzM1NTIyMTU3MDE5NDUzOTgiIGg9ImpyMVRlRlRwQXVhWE9wR2tRbjJ3bndjSWlCUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5653:EE_|SI6PR03MB9029:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XZeOrkkq4ZhjsHQx1PRbxR/id3vE/1yZg+Hfj4SzsisSaWk4ZShuqnLns1Lzux7ht7jIXPTxROuaW2hO8NAcmCMr/Y8+jW1hBZ0BtNPmZPmERZ/YdtQU4J57UtMLLLKY12G7h1i95mPjbqFFsWJeXSu/J/ycfKMuJeduSc8Hhe/b4URZz+/VQkBmScWMSu+z1OppNESbgZPQx2SFWj8QuzsjBKcCVqy4H7Iu26iPoj4GtUnuwOJ6sWjQ7V6KwB6iHFkIe5lY9VgX4RGL8Zr1wgz0SYCsHVwwt82Fbi38clISmx/9DRyZiwrzd/TY/ZBwcgRRrP2BWPvbrhDKIZV5O5rSv6/kYqGj1H16m8DH0HhTjH2qOWAFAJhiEwcqqY9aD7GH26i6Ke2kjfuoHuG/L31CaLTy+3crDrd01r7p4wnYS+T+SFfadQnq5k1jJNUH2Rh2N0SDE3GukB9QQcJZLbOrEWWx0QIHVyS/SwNQ53v1GlqnOHUWhBdA/U9E8jgXKfgYRsuHE5iTGzbtSTNU40WG6wQkfgnMDAx3xdtp2tkcCY50CoW6TRlttMTptNDrYUj4GEEgSBShmbnFqNZDqhMNR+T0NWRO62MdZyHzx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5653.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnVIRldDOTlJTGNoZS90N3B1cU1nbHFLenVibEEwOG14cDZCa2tMS0EvcnI4?=
 =?utf-8?B?bEZxcUVlMVBlbjQyUXpyY3h6eDRGKzllZWMrUzFVbTYzampTVjMvemtLTW9m?=
 =?utf-8?B?MXUzQ012WDFmVlAwWkJtZzl0ejhCZFRsdktvaHlIRVF0a1pQdGtNRUdVWW43?=
 =?utf-8?B?V1RobCs5Y0k2YlBkeWN2ZkxEWnkwUjFKYXVlU3lHeGxwejhNSmVrcW1yTVI0?=
 =?utf-8?B?bnlOWUY1eVdsUHJGTElTN01zQ0FFdmZGd2xYS2xiK1FFbzFYeUF6cmVpOFhB?=
 =?utf-8?B?Z3Q2aUt0ZVhmY1o4Q0F2VFFobFZsaXN2VWJ4SDNjTWNlaXQ4UXBYMFE2bDFO?=
 =?utf-8?B?N2lTZzduVnBkb1RsRWFaVE1sb3hjUURFTFRWS0xFSEl3K0xSSzgrempOM2Na?=
 =?utf-8?B?MExoZ3hDTEFxVXJQWmtzTjdpb2J0WXIyN1lGcFp0M2pLL2R5SkZYSkhkczVq?=
 =?utf-8?B?YWg5Vks4cVdzU1oxNjFVZE56UTRqRnEyRTY3UmsxODBoNDFDQnZINlZtb3p5?=
 =?utf-8?B?QnlNUGtUUER2djVQWnozRUE0TWVKbUlYb3RSbDlnMFZEV0VLSFpmYjFrdHVJ?=
 =?utf-8?B?YU1keXRPbkRoVjU5MGZQV0diVG16Y04vUmpibThiSlI2UnhTWVA5eHVFQmpt?=
 =?utf-8?B?djVBelh6Syt6MStQSmNnNjZpSmZCZWRDOE44WWx2ckFkUVdCT2NFMm14VFZw?=
 =?utf-8?B?cGplaU5CbStpZXgvR21MeTZOTWVMWVlTNFM5bk5YSUlzUUpnWDVrcjdJWXVk?=
 =?utf-8?B?L0tKUnM0TER3czYxOE5DTndzUldIQXh3QlRJRGpuYVJjSTNYYUhWN2F1RXMx?=
 =?utf-8?B?a2g3NmNOSk1WRGF2V0NtdkFjZHRiNVdZUjhlNCtLN0F4NjFuUGIxbW9uR2Q4?=
 =?utf-8?B?NGRnaWIzMHdKYncrQVBkMDdvc2VKUVhTYXYvZTNsTXo5TnhYQlltN01iaVkr?=
 =?utf-8?B?K3dhN1d1c1V2V0ZSdkp5b2JkVU8wN0pWT2lFR1hFVGRDWUtyTFI5ak1hMGpE?=
 =?utf-8?B?OGkrRFpBMXdaR3JqNzAvUjVIMU4yRmdKbTlpZWg1cGs0NWRDS0R0RURBZEhK?=
 =?utf-8?B?UVZGeWdpbWxBSGh2emxBbVY5amFNYmtDZ1JiTktUTDJyN3NEWjNmbDZEV0xF?=
 =?utf-8?B?NlNUSGZ0aWtiMTdoUlN1eTlsZGNGSnlGOU5yb1pnMmJSanJFcFBxSW5nL3BQ?=
 =?utf-8?B?aXdGcE9YM2NBZm43c1FienM5Rmw4YW5uYlkvejd3b1JNQlR2V2pqQytWV2x1?=
 =?utf-8?B?eEd2WDRUOU5uWkZPSWs4NnNPM3o0MEw3TVY0STNGWktJYnBWcnQ0NWMxU2dl?=
 =?utf-8?B?NmQrMDZXVnZtSWlrQ1RiWGYzYWYxemVmL2grdlRuQkdWUHhIZWVqQ2hvMmRi?=
 =?utf-8?B?ZlZKTmNpdkg0QWJYZTZBZ2JtVzhndlNWb1lQOGE0QzlQODNlQ2M1bERHaitl?=
 =?utf-8?B?Z2pSeDBMUHJhQ0lxOE9ydGRDeHFRd2JTWkZvckVETjBielFkbkFtMmFCRlZM?=
 =?utf-8?B?Y0NqOVJjUTIzcjkwUmdqVzFPRlhrZGVrUkhTaGNObTMvRENoQ01ONDFvWnBo?=
 =?utf-8?B?QWVlenpFZWNaTDlBUzhKUWMyZVl0YlhhSWdveGZWOFdoQzVrVWsvUjVwaEpa?=
 =?utf-8?B?ZC85UllZUkgxbEVQZnR0TnZxZHIyQUZFaWRLQ2dERHIzdG1FSWk5RTBCQW9L?=
 =?utf-8?B?ZzZQYU5vbUR0UERkQ2VGblp0RWhQOXpqT2IzQjNLYXFYa0lmZHhxNy95S3FM?=
 =?utf-8?B?Y1pZL3JpUkZxQkluaG5POWtSRnpVZld3N0g1djNBdnBGMm0xanZaMVZyVExW?=
 =?utf-8?B?dmJITXI0MSs1UzJtd2l5S3ozaThnaGk1a1hSTkhzVU1FU3AySTR4TkZCM0hV?=
 =?utf-8?B?ZE91UG93ZlNtSGlwQWdaRlVDVWc2SzVJL1RDelpLNGVZT3JnS0lRMWtrWHE1?=
 =?utf-8?B?cWNhNzlWUU5sNlZQRk9BaWovN0gvdmhaOEVrWU1lRVdoOVZuMGVEOHFCZlll?=
 =?utf-8?B?NmxDaGxFOUh0U1U2Zy8rY1ZJQnlqWlA1SWtoTUFWa1hWMFY1Z2JRSnpNb21V?=
 =?utf-8?B?WnJyQkNTNXVBRFFMdGxjTXB4WXg1VlhnMG5VOE42WG9SeHNvTm5SQkprS2NP?=
 =?utf-8?Q?h8ANSZcIueSb7SF9d4Lx3Z6AY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5653.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72366e9-31e2-48b4-c9f8-08dc471f7d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:46:15.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAkdeYgUxegKnJt2eFr9U8qA66MymSKUV+gahMvh+1oiz8go8mVyl2IftBOoX6/g/+11o1Q3V7egtIvhR32DGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9029
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.480300-8.000000
X-TMASE-MatchedRID: UWn79NfEZzYlAE3bRY0vZxlckvO1m+JcvtVce6w5+K9cKZwALwMGs9LJ
	1ud405WAIBBnNzktHGs0bM5U8R3nMIvTpuEjuIpkOjf3A4DTYuFU3K6aV1ad7Vfgf8AdlMAqmQr
	5HPMR4wXNvN3kBYt9582cSlJJpVq0RcriDaoCTGJWdBPqAOaXVV7OZ6hrwwnz8Ule2AXgYUuPaB
	WuJnN/lwhHQ/Rf450auWZmXgxTootl5bDgN7KH9kWFcscxtnzGT2iBQLD5E/QS6DTmG2utgE9y7
	Uqcy0Jrfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CyMs7LXcKBvj9p1biJhIyNRU9a6
	zfLFA1YhJ/ufappeEpGTpe1iiCJq0u+wqOGzSV26vVBUUydJCsRB0bsfrpPIFUFJm2B6H9E=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.480300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	71E3C97181D76B29B51006BAC8FB1EDC480E328A3FB5A36EE6DB83D19B7FC83F2000:8

RGVhciBtYWlsdG86c2FzaGFsQGtlcm5lbC5vcmcsDQoNClRoaXMgcGF0Y2ggaXMgbm90IGEgYnVn
IGZpeC4NClRoaXMgcGF0Y2ggaXMgdG8gYWRkIHRoZSBzeXNmcyBub2RlIG9mIG1tYzogd3JpdGUg
cHJvdGVjdGlvbiByZWxhdGVkLCANCnRoZSBkZXRhaWxlZCBkZXNjcmlwdGlvbiBpcyBhcyBmb2xs
b3dzOg0KDQptbWM6IGNvcmU6IEFkZCB3cF9ncnBfc2l6ZSBzeXNmcyBub2RlDQpUaGUgZU1NQyBj
YXJkIGNhbiBiZSBzZXQgaW50byB3cml0ZS1wcm90ZWN0ZWQgbW9kZSB0byBwcmV2ZW50IGRhdGEg
ZnJvbQ0KYmVpbmcgYWNjaWRlbnRhbGx5IG1vZGlmaWVkIG9yIGRlbGV0ZWQuIFdwX2dycF9zaXpl
IChXcml0ZSBQcm90ZWN0IEdyb3VwDQpTaXplKSByZWZlcnMgdG8gYW4gYXR0cmlidXRlIG9mIHRo
ZSBlTU1DIGNhcmQsIHVzZWQgdG8gbWFuYWdlIHdyaXRlDQpwcm90ZWN0aW9uIGFuZCBpcyB0aGUg
Q1NEIHJlZ2lzdGVyIFszNjozMl0gb2YgdGhlIGVNTUMgZGV2aWNlLiBXcF9ncnBfc2l6ZQ0KKFdy
aXRlIFByb3RlY3QgR3JvdXAgU2l6ZSkgaW5kaWNhdGVzIGhvdyBtYW55IGVNTUMgYmxvY2tzIGFy
ZSBjb250YWluZWQgaW4NCmVhY2ggd3JpdGUgcHJvdGVjdGlvbiBncm91cCBvbiB0aGUgZU1NQyBj
YXJkLg0KDQpUbyBhbGxvdyB1c2Vyc3BhY2UgZWFzeSBhY2Nlc3Mgb2YgdGhlIENTRCByZWdpc3Rl
ciBiaXRzLCBsZXQncyBhZGQgc3lzZnMNCm5vZGUgIndwX2dycF9zaXplIi4NCg0KDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3QgUmVnYXJkcyDvvIENCkd1aWxpbiAN
Cg0K5Y+R5Lu25Lq6OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+IA0K5Y+R6YCB5pe2
6Ze0OiAyMDI05bm0M+aciDE25pelIDE3OjIyDQrmlLbku7bkuro6IExpbiBHdWkgKOahguaelykg
PExpbi5HdWlAbWVkaWF0ZWsuY29tPg0K5oqE6YCBOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBZ
b25nZG9uZyBaaGFuZyAo5byg5rC45LicKSA8WW9uZ2RvbmcuWmhhbmdAbWVkaWF0ZWsuY29tPjsg
Qm8gWWUgKOWPtuazoikgPEJvLlllQG1lZGlhdGVrLmNvbT47IFFpbGluIFRhbiAo6LCt6bqS6bqf
KSA8UWlsaW4uVGFuQG1lZGlhdGVrLmNvbT4NCuS4u+mimDogUmU6IGJhY2twb3J0IGEgcGF0Y2gg
Zm9yIExpbnV4IGtlcm5lbC01LjEwIGFuZCA2LjYgc3RhYmxlIHRyZWUNCg0KDQpFeHRlcm5hbCBl
bWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRp
bCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KDQpPbiBTYXQs
IE1hciAxNiwgMjAyNCBhdCAwODoxNjozMEFNICswMDAwLCBMaW4gR3VpICjmoYLmnpcpIHdyb3Rl
Og0KPkhpIHJldmlld2VycywNCj4NCj5JIHN1Z2dlc3QgdG8gYmFja3BvcnQgYSBjb21taXQgdG8g
TGludXgga2VybmVsLTUuMTAgYW5kIDYuNiBzdGFibGUgdHJlZS4NCj4NCj7jgIDjgIBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL21tYy9jb3JlL21t
Yy5jP2g9djYuOCZpZD1lNGRmNTZhZDBiZjM1MDZjNTE4OWFiYjliZTgzZjNiZWEwNWE0YzRmX187
ISFDVFJOS0E5d01nMEFSYnchazEyRVBzbEtJOFBMNEpZNVFtbDhnNTZBNGFfNEFTejdGcHgydm1f
QkNFTGVXMUt5NmF6Y3I0dTB1Tjh1ZE9aeVFMcFRVejFFVHEyam4yWSQNCg0KV2h5PyBXaGF0IGJ1
ZyBkb2VzIHRoaXMgZml4Pw0KDQotLSANClRoYW5rcywNClNhc2hhDQo=

