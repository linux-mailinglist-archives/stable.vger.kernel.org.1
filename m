Return-Path: <stable+bounces-120262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF6A4E6EA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12788A1323
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BB296D79;
	Tue,  4 Mar 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cdJ5A5+g"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614327814A
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104265; cv=fail; b=tskn9CLw9gMIYrcSQfg0i7dcAup/A3+WBesP84tu4IiQkjNbbs/3IFebJDTDqc74ZZQJoz+Ad+EAem248n7yXT4pg1sr4U7vsthH6juFXhsf8mHxiMzaL2uQvoRRK6VTeudgspzgdO8LF19d4WIcqnEsdohbGzX380q3ZEIEX7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104265; c=relaxed/simple;
	bh=Gq/jzah0vEn5AaoYxztVD+4nJo6Uk6ZUtzD3te8b5wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcY0lPKMzw+noWWYps3Xv05YoKDwhEOQCNMBp7CKJU8yKvmcsQ3bVgq6nNR9Yux7FVWybM2DUVCpbHe4X0b60i1QmCcQrf06hWYm1u8/+kkXWCzBZ4AUTH5OTDXg1HghQMztrB8H/VGnXTqBr2bRlofpFcacSWDPakg1f854q4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cdJ5A5+g; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLvHg9Gu03NEv+6n2kmu5MBjInrIXjUo/Uzs1FGdIcZk1lUs5t6nAyIjUbBNh1owmSpw8vjq5FenPvkyjETIiqqwFRBP1x+RWUntYQBLpR9vgcHmJZngn5hC3bWE7ejpAdWNRcMKUcH/BXe0qYy5HHLsLKisO6ZPnaJ4xLC5q2UwmU3rYokBwufxWRRGoAEYweo1RkpfHufFsQJ9hD0MG0Y/LtjiRwPCTDoaKaj9lScYNub8YKNXIeUSqejJMMV3SJBAjtYMS/6p7vUB5sLXlHjzFcdDeUFYJUC5zxdkMqdgzKurnCYrdGWJ+5BWj2TBCzs7KzaZiSDbNhIsVXmAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JSG1Gr7hJBuQyCMBRcFjJXiEuLP8ilp1foJQdLgOas=;
 b=SppgHOgvNoI+kaYri7C5ew7wJad9XW8K3xPrTNtitSTZHWmwC/yR8torIP31kPZ05MdtthQBihuLzx2z1XchuPZA3tZXA4MvgJiYAVONwiLVtl6tOQMDWPBFj7IRvev/9An6zuDhy7pMEPEeUWNiLKr+SWh7pFcWSzQrJy6XHT0U9tMkkDsi3fWo7js073ZzUXyCEY0DE5BVrY8UDI2itQ/LcJguYE48w/KW6AKqg4Ke4Du9VlSSJhspnK6EjKv3gLLkPmJP/3vkWA2aiW+RutBWfBDgavp2fUrmkEdeEXnmP/xyVpCGKc3mwH++nljGLwEcz8rzW/Eiv8uVAmx17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JSG1Gr7hJBuQyCMBRcFjJXiEuLP8ilp1foJQdLgOas=;
 b=cdJ5A5+gzNu7x6cUrV17Y0H9kbhtSNslMiCanll4jklw1sddK5pofvq8Tpvdyf3pEANy9LhklJdnpqQZr/Hsb4/9WctFbBwdQkRJi19TtR+2zXkVm1zUN0p5qol/nf+h89DI8XVO4WE8KefvMAPjaord0ox9XtCYpjLNecAa/34bg4PyJ02WF0W2KGo0ivpvIgQGF1mdn7dsTp/vYJPgFbwtzePJLS+YhkJCarl0bZNSjqG6kDDovCP0cVfOkuopTH1vQ3Qhsr2Ck393JTBlQlYN4iN1AjrtqPJ1Jm2uH6J/pTsmkrQ3WgtfWseNqwhGnAhmduOubHAwGKvT0djuXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:04:18 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:04:18 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: andrei.botila@nxp.com
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
Date: Tue,  4 Mar 2025 18:04:00 +0200
Message-ID: <20250304160402.180548-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304160402.180548-1-andrei.botila@oss.nxp.com>
References: <20250304160402.180548-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AM8PR04MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: d886005a-cb69-4cc7-dbdb-08dd5b363831
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDg1bWxtTjRnc3llSjd4clhvQlNRaTdFTnhuWWVEMk45MCtjMlZhZTRtNVlh?=
 =?utf-8?B?bGM1NTVaNjJxSHlaM2xUQllwTXZVaktEdVVKMXczTndvaHFnUDZJRTlZbkd4?=
 =?utf-8?B?blJIWTJWRDVhSytoQWhyRlRmK2JpODdmVDJpaDVFMkxBcGtuUExLeTJQMVdj?=
 =?utf-8?B?aHR3Y2hzQVNNYXY3VnVlRUVzVTBKaFZsODlURHZqRWc5Qlh6Umx1dWZSc3l5?=
 =?utf-8?B?cGtwbVdJSzhqSUpzMFgyQXk5WGgwVmd5OU1Xb3QvcDd3dTllSTZ1ZVVFbEph?=
 =?utf-8?B?Mkp5U0ZxTkxTVEdmd3p0aUttRkdEQUtKU2xsWWc5Y2NVRVVLZ3dzVkpucHUr?=
 =?utf-8?B?aHQxdGtOTW1NeVpyS1NQTXEwaHNMdEJMbnc1MFFJVjhqViszcThqQ2UrRnYw?=
 =?utf-8?B?VVdhbTJwQ2xwWmZIZHdsbjRyNkM3bldJREdyM3ZzcXZnK0JNUzIxUlN5VWhk?=
 =?utf-8?B?NENuUGVQVGNqQTVmd2Nsb3VmUE1McG9UVnAyMW1ad3Q1c3pleFhmYUM3a2s2?=
 =?utf-8?B?UXM0WUtkM29FbkUySmdndUE0RkcxcFlwYzkvNEJZa1RTcmFNWFdnUkd5UEJa?=
 =?utf-8?B?bllhVlNxa3JIcm8rbHBLY1hpMzV2WTVIc1kvUVlFdllpNkVqYXRoY0xVcmx6?=
 =?utf-8?B?NXUwL3J6Q0NjNHgrNEpndThGUkhWZ1k3ZHV3RzhwZFJuSFZOSlR6NWVrQmQ1?=
 =?utf-8?B?blV6NHhTc1JBTStMa1dHTkFxdm51L0NXMWpIZEhNMjBmcDFvTFZOSmJvVGhH?=
 =?utf-8?B?L3d3QUora3k0K3licDJ2d09Vc3FmTFBsa3hDdXZlLzNzdDdhZVljRCt5VkFK?=
 =?utf-8?B?NE84TWZDRGZ4TmIzNlFWZC94cGJobGFtTUJ3Q2J4RUtCc01nM2JXQllvSjJk?=
 =?utf-8?B?OWt1bG02Z1NaWU5aSy91dXZ6TU9oVnpmTW9FL1M5cFpGZ3d0cDNiWnlObThq?=
 =?utf-8?B?VGtCVnpmVDhEK2VZc2grZXpUUm9lLyt2cm5wK0NxVmQyeTMrWWlWMUlLaEVu?=
 =?utf-8?B?NXFicTlBMDNwRzN2d1UzdlJNeURySWRHcVpXTmFLb2xsMzVlYThVZ0EvdDkw?=
 =?utf-8?B?UXVSbXRpRFlZU1BFZWFQVU5CNjNmZDE4VzZaYmhOdXp6R1pUblFwdTYvL3VI?=
 =?utf-8?B?YVpZUWt1WnU1OENPd09lczhNV0o3SXlCQ0ZBUkw0WjJMbGtVWnR5eVVzS2ts?=
 =?utf-8?B?R00yb1RTby8wRVNCcGhlM1pwWkdVcGFTUUlvTnc5TXIrZGhEZUZmMFZQcDhi?=
 =?utf-8?B?TVd4QXVZTnQ2SzhyOUZsSnM0NTE2eUxLRXVHZHhmMHlicHU3czlKRnZRODZY?=
 =?utf-8?B?SlVmTFQ1Y2RobnRwMWNDMGdhSVVXSXlocEtPdWFRNjd3WWNueDkvRy9TWis5?=
 =?utf-8?B?T3ExcVpUK1NNek82K1hpWkVUVTQ0Y2JHV3VUb3BtOUovYWxweGNJN1dJZVJZ?=
 =?utf-8?B?ckRkaDFvWFVhRTRzOWpLZ004SUxlb1N0LzZKbGVtOEFhbitYYmtFZHo5L0NK?=
 =?utf-8?B?MWd4bFF5blloc2o2SWxNZ2c1cnFzMi9jOGpnUkM4Y3FUT011L29ueGRkVXpT?=
 =?utf-8?B?Y2tJRlpwVTB5bXR6QlNlcjBaM1hqcXV5MHVycFJPNEQwanpUa0RxbDlTRTI2?=
 =?utf-8?B?TGRMTjVMMGlLd0kxeU9IV2JaWlVmS0J5YlZOY241RkxrUVJiWTk2RUgxYzlK?=
 =?utf-8?B?WlVTeU9tMUxzWDZlS0VEdU1YSFZmQTBVaU1WKy8xVkIzcHhNOFdWWlpVMVB0?=
 =?utf-8?B?ekNubk1PUDlMQmhiY1VOWTNlT2hpemdXaFl6SGJJd3p5VURYQng0bnVVR2lv?=
 =?utf-8?B?ZnBuTmhIWFdpTCs2S1J2bi95Y0dLanJQR0doTEhlMk5FYjZ6S0NuZ1VDR2JF?=
 =?utf-8?Q?AneYZDRV8TaT2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEZ5dDVVeWV3b2w1K1pkUDMzOWxtZENwMlR1dzF6SUVaUzIyRklJeUVWSGxt?=
 =?utf-8?B?M0xxckVqNHhZMHRYZFVzbHVWMy9aclRzZzB6SXhrNy9zOEEzV01SdHhoUW52?=
 =?utf-8?B?c0Y2YXkvQTFQTkJBbmk4UjFsQk4zdytSVm11Zzk0K2RNSDVxUkFTZUpNNXE0?=
 =?utf-8?B?UHBUM2RlNmV6VFArSWdydnUxYWRmcSt2TUd3WS9iQmJYaldOTmJvcTRVWHUw?=
 =?utf-8?B?R2toa2tTdVBTb245UHVhL1FyTnRwWnFTRUY4a2xpU2o3cTdhcXp3QTBma2Fo?=
 =?utf-8?B?L3cvbzBKY1Yxb3BrSWU3Qk0wd3YydVRaVGR6WUdrYmVuSmV1ZE9kYWNxNFlQ?=
 =?utf-8?B?ZHBKazYvVnFYY2lTTlE5R2ZlRmk2dWFQajJkWlRYL05wYXVyR09nTExNTWhQ?=
 =?utf-8?B?UUxmbFdJb1JuUTJ4TTdQQi9BY1Y0cFhIQzNkdTNTZkJsNS9WVkFXZnpVZHlh?=
 =?utf-8?B?cUFFaUlTMzhHNisxL2VBZmZ2ZWR1YzZ3ZWdrQ1NndDNGMTl5dThiSFlKVHZ0?=
 =?utf-8?B?VUNUQTFZWDN3KzltaUhrYkkxZGJBUHhzeXhIQmFPamI1S0FueG5STHVwUW85?=
 =?utf-8?B?cWdTaUJZdXhnWnBCWk4vZFZjVXJ3RVZaazlXdFpJRVNwdFpPNkxhQXpyRjRo?=
 =?utf-8?B?WW9JdW5tZ0dhTG0wbG00VXUwZGVoMHdpeHcwVXRMTTRHOXRQNDd4cHVsRmtK?=
 =?utf-8?B?Z1FrY2wvYkFxSm16TFk3U0ROZURIckd1cHpaN2VWaldXYlY3OEhkaGI5UW5C?=
 =?utf-8?B?bnpuLzhOSWQzNXJjV3VYeE0zQ0crdU9vWUwzYS92Z2kyN0I4ZlZYbmtCczNO?=
 =?utf-8?B?b1N3R05aTUh0QnEyOG5kb1FtTW1QNEkybDZyblFNK2k5NUdhYkdhdVZlaENO?=
 =?utf-8?B?cDNtOWU3dVJqeEw0aTU5VHkyT2dTWnNPL1NEdkdPNmdJSFAvTlJwRVdNRlFL?=
 =?utf-8?B?TmhqNlg4UmhVS2xVTlJTSEFDZUlnei9xZkRHaTd5anFLZ2JIbndvcXBNQmhD?=
 =?utf-8?B?VnFPNzlZTTBPNmlHVWU0YnVkdzRwMXVaWFVRNENuVXRSeEZjMDkxVFVBS3lU?=
 =?utf-8?B?dVkwNjJtZkdZMnY5bm1vZGJVZ3dyOC9Xa3lvZjFiK1VBUTRORWdmSkRyMmNk?=
 =?utf-8?B?d0tWNjdkLzhQb3JQUEl3YUpxN00vUm44dHFCMm1iSnpHREhNeFlGN2l4ZVR0?=
 =?utf-8?B?K0trNVc5WlZrMFNKYzR0RGs1dklGcW5nc2NrMjZIdG9vNnZYYW5udE8zMmc1?=
 =?utf-8?B?eG9lVk9vZTZacU1VSmE2a014L1pvVklMRm16a2p3aXZjMkpqRzhxY3hkbGJP?=
 =?utf-8?B?QkhDYUcyaVRnVFZVWjBnQ1VFY3hUalBjcjdKLzhFMk5NZVRNQnR2MzUxeUtJ?=
 =?utf-8?B?eEJJQ3hkd1FaWTI1VXhNZWxzZkRSTXpqTi95aWdERncybDYzSUpubzA2T3lF?=
 =?utf-8?B?L3ZvZUhPMnZaMlEra1ZpeXBEeDVtRUs0Ky9BOC9DTzNEbXZDeTNYbVJ5MjRJ?=
 =?utf-8?B?MEhCVVBIQlI1ZlVrU3lENTNyZ2loRG4zSnZ5Mm9QUzVidGMwdXpYQUFGT2l1?=
 =?utf-8?B?NUw3UXRzdjYzNEl3RXJuemRUbFIyN3lxSnFWQWI4ZjR4VWdBa3VsWnJVVjBy?=
 =?utf-8?B?a1hOUjVKM1lUS1MraE9TbS9SKzBoaFI1T21FMU1OZVVMSVNQWDc2VnRVUWhs?=
 =?utf-8?B?K2pxekJjTlhqRFJwR1B1RW84Ymw2WCt2NFY2V0dSa0RXQTN5SVF4b3Y2YlpC?=
 =?utf-8?B?bkRTUlNEbFhHSHRhK3haenE3SHlnSkgvMTBTSFF2N0V5Zkhzb3lWaVBTam9T?=
 =?utf-8?B?bHJEZUdVUzd0VHE3Mi91YnFSd3RBVVJFaTlrUUVSYXpDV01SWG5TYVlnQWsr?=
 =?utf-8?B?QXNnenM3ZGx1YlBFdUMxL2hYeXQvQVdFVzl4SUZFcUY4cnBwVC9OM0tCNUNq?=
 =?utf-8?B?ejNlRTIvUUkxeU92eHl1ZzQ2VHl4MExwemZDZUV2bkR2aVpnKzZNSkZySVRp?=
 =?utf-8?B?Z0VFT1NqN0FMSFR6c2R4NjJ5R2hhRXFhV2xrdHRKdXZzZkhWYkNBRGtYOEZr?=
 =?utf-8?B?QnJpSzR3S0Npdk5kUTRLM28yeGV4Q3Vya0o2NGJML1RFZjBOMUxLa2hPSlpw?=
 =?utf-8?Q?4eM24v0VXpmZkfsFVDFZHnjKA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d886005a-cb69-4cc7-dbdb-08dd5b363831
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:04:18.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WspMrW603GLTwrVxjFnFdpmbJpaHWnsg01hWGYSDoIlIxPF7gg3KtnNfCsKvBxvAukDJl8GZAiaJLE/mAnYMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7874

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply these PHY writes before link gets established.
Application of this fix is required after restart of device and wakeup
from sleep.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..709d6c9f7cba 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,11 @@
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply PHY writes sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, GENMASK(31, 4)))
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-- 
2.48.1


