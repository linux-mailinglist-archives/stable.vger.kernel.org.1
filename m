Return-Path: <stable+bounces-56122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C17491CDB2
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1A1F22279
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACB37E772;
	Sat, 29 Jun 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b="eTw7zdeO";
	dkim=pass (1024-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b="WuliFMmc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002cfd01.pphosted.com (mx0a-002cfd01.pphosted.com [148.163.151.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAC29CEB;
	Sat, 29 Jun 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673323; cv=fail; b=PGq8GKzSslEzHDCY5RE5yWcnpnTk1/ctSyZUd3tlXYPvQ4ji+6ocZGGZRVK1nrjG8qhsqaI0PcklVjF4347n0RqB4H0Dyo85KyyKCimdszIJHrw+hOQwY9HliuMvbGJ6n1GWjjPeKU7YHAd9iflxvRRaeVKThvWh82Y14Eb55E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673323; c=relaxed/simple;
	bh=oo3i/bxg4zQdxmywiTq8gSs4M/U1930Z+i14cEq0ZKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCybmWKgnmtfYqXCh08DBjJNhkf2jSWSHrlQ7o8iEB1BExBJfXYLl7cysr/YvIZ9oxAUJJuMIPCT6Kf57Xt2g825nDJV7BLCvqLLKyqj9QtXCuBZ7GkNOfpFbg1KNgsFrfUFrbj/RF0rGuv0x3uc1N3Vz86KRBZmXqyDqcmQ/GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buckeyemail.osu.edu; spf=pass smtp.mailfrom=buckeyemail.osu.edu; dkim=pass (2048-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b=eTw7zdeO; dkim=pass (1024-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b=WuliFMmc; arc=fail smtp.client-ip=148.163.151.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buckeyemail.osu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buckeyemail.osu.edu
Received: from pps.filterd (m0300657.ppops.net [127.0.0.1])
	by mx0a-002cfd01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T8qhSH017459;
	Sat, 29 Jun 2024 11:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	buckeyemail.osu.edu; h=from:to:cc:subject:date:message-id
	:references:in-reply-to:content-type:content-transfer-encoding
	:mime-version; s=pps1; bh=oo3i/bxg4zQdxmywiTq8gSs4M/U1930Z+i14cE
	q0ZKI=; b=eTw7zdeO2nhiZTHG9/FFsrv6GXMWcW1S75GcEjpVavvqpbGwGG4YLo
	kkPnxhBQ1g9KaQUoIWHLn8iWKKIOsxqdFHzI7rwQf4R5istxtXBn5xHwwRw9ubcq
	/sasqBgzCogYn5+ZuFPmKbMlaq8VISc74rUcyEOdM45hpuQwu4OK3hCM3Pwm2cBR
	kUPuFvPq9N5eW2j9S5fvVKILNENptepGCrwPEOGmTch0W2+3eWDMhRhJjNM+TE7y
	8T7431kJgbmMhi+Ie4F/O6YOKJHhFMXjyobWKheXqJYvzvcaAebZ3hgiCfjOXZy8
	mfvjhiVA2YDnmfH0FfgaM9Bno3uQt7Qw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-002cfd01.pphosted.com (PPS) with ESMTPS id 402d0t9kqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 11:01:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkqMB6Y/hAwhEO4d2trfR8axyFD5hwkrVvzbq6L2ypdtELJWhl81BLzAR/YULpneS6/mvDaM6xPtIQrakjr2h0mfIGl7lOfEWSm7zNCivsKBWRt1ccDBFJorqmQub1nRVhe5aepUgjqSxl3sgf1PgKEGECA2uxmlMa6MtNTbFPOHcoeTyq/qFgDYHJvKFgc+EkfpZ4fxHYIgqMqajqs8vw2+rLHtLWGwDDF6P1ylLoKAqaJ5mqpoTO5M9FaHEAkZFwngE8a2/cYqNWovkns9DLfQLMooswE/ZX+nTx5g+Qw6n2uZf0Kyge/RcgYTC7JxsfMguIulU3/edRwS7ZdKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo3i/bxg4zQdxmywiTq8gSs4M/U1930Z+i14cEq0ZKI=;
 b=ijRNfY44Z26+vNlfQPp1zvg5RaLBECm4i7+K3WOY4z2z6yhYYlTPPcpEGtVIEJsyDuknhVIhXttBFarAu6tHmzHI9wKcCeC8lmwJqtVVxWQuoIsYlgQ5UEWPZuNoGV0qstwSgrtc2SZ2wDaMwq6vCUXaxltghY/2ckqnX1CGBQY+krfItzZOgYq11OuBlmCgPwZ2YHJ5MkEIEOWsu8khEbiaEfqD0Inc9H70RXkfWoit0hoc00fV+GIwW6VWvdP42HxeIrBIkZ2nVztUEpyit8t6Dvs2OQo8DSbyNXVHkEPKsf2yjEh67ad09cbr1Q0VF5/eHeCa2l2b3pfzH65Xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=buckeyemail.osu.edu; dmarc=pass action=none
 header.from=buckeyemail.osu.edu; dkim=pass header.d=buckeyemail.osu.edu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buckeyemail.osu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo3i/bxg4zQdxmywiTq8gSs4M/U1930Z+i14cEq0ZKI=;
 b=WuliFMmcFuZ07tlaCxlxaNw3Ix3fFj4YhCgXBpe4WygDQekMGKcirnSlLgl5agS9WFcb1Dg+3vnQbVgn1as3uI6cDqxJ7r5VaPaOmonDP1caNeLTi+CkP4UYEQxEWfcA9CAUWjCBBwgNU62VB0RIR0fcsIqbt/z5EL1XcdcDqNs=
Received: from DM6PR01MB5804.prod.exchangelabs.com (2603:10b6:5:1da::13) by
 LV2PR01MB7718.prod.exchangelabs.com (2603:10b6:408:174::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sat, 29 Jun 2024 15:01:14 +0000
Received: from DM6PR01MB5804.prod.exchangelabs.com
 ([fe80::acf3:583e:e776:4462]) by DM6PR01MB5804.prod.exchangelabs.com
 ([fe80::acf3:583e:e776:4462%7]) with mapi id 15.20.7698.033; Sat, 29 Jun 2024
 15:01:13 +0000
From: "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu>
To: Frank Oltmanns <frank@oltmanns.dev>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland
	<samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
CC: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw
 without common
Thread-Topic: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw
 without common
Thread-Index: AQHaxUnWJMXEsjySWk+RtO0QDt/fG7He27Sg
Date: Sat, 29 Jun 2024 15:01:13 +0000
Message-ID: 
 <DM6PR01MB5804880B59E868864F309EA5F7D12@DM6PR01MB5804.prod.exchangelabs.com>
References: 
 <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
In-Reply-To: 
 <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR01MB5804:EE_|LV2PR01MB7718:EE_
x-ms-office365-filtering-correlation-id: cfe74cd8-fd35-43eb-e7eb-08dc984c51be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YXdnRzQzUFRBZFVKL3k2SGFqM0RCTEU0dzZtd1luSE90WjJQTnV5THJpSGtP?=
 =?utf-8?B?SGIrTGh2VXhVamNSY2ZSc0d0SE5MS0kzNWxaT3R1SUJEVUZjNFRoY2NIbmxx?=
 =?utf-8?B?ZFBUdVJiNW5XM1JmcXRrOFdaVkZQMllCMDJBNlRYUVZyNHN4OTFZS0JBMEJl?=
 =?utf-8?B?bENFemZIdTRZTWpvNVVzVDhhSUlVd25CRGhrRGJEMEtHWGVFSWRXM3BwQnBB?=
 =?utf-8?B?bytvR1MxYzgrYnNxVHlVM2FDdlZKUFFPVGkzVTJMMjFGSVFXV2hOU0xNcU9G?=
 =?utf-8?B?Q3VFbFloRnNXUFVXWGFlWXJkZDRmdGpKK1pLbHkrV2tWM3UyOXhhZW9pUjJm?=
 =?utf-8?B?b3hoQ3RSR050M0FOYmp6SHBmbjNCazl3UUJNNjVPZ0dvSEF2c1FVTzRHTDJk?=
 =?utf-8?B?Mll5UDBIdXkyRjJ1dXM5d2pqbEwzcjlsZm9UaFc0RWJzRmFaN1BnOW1PcEk4?=
 =?utf-8?B?RFVkSmRUL3JCVGVZbW84b2ZEZTh1MFJuWlV5M1dnSC9Xd2hIVVRZMW1lVG52?=
 =?utf-8?B?RDd3TmNicnBJdGlzbTQ3eCs3S29KOERLMUoxWUVlVnRTT3dISC9iU1p6ODho?=
 =?utf-8?B?SkJhbVFGZEpJdmY2RVpsVzczNjFwT3cyaVFuNVFNVzRBTHhpbjMzbm1oRUhy?=
 =?utf-8?B?dVBIWW1XeWhxVE9GckpKY2xCMFBsVTdvQ2ZhOU9KUlByZ0JsUGQyRHVlNjR4?=
 =?utf-8?B?QUEvWnNpWklDbkFBNnZ5anZFallOaVUzK0V5L2J6MCsrOTB0TElZTllXTVlm?=
 =?utf-8?B?NFBaRGdjb1NXaUlVQmdMaXQvTHBPUkVkVTZndWUrUU5tL1N3QkhtaEF2WmtB?=
 =?utf-8?B?bk1YQTU2Ui9zN3hOV2R2MWV2akp3TXowK3RiRzNQSC9wWXhjckgwenpTdC9I?=
 =?utf-8?B?UWJHTlVOemVIZEYxY1NYZVVSYmJTWUp3UjY4K0Z3VEFhTFNEc05SRHozTlow?=
 =?utf-8?B?dTEyekxuOEVsWVAvVXFhZjlLNWNDYTc1VlFKeUN3a0ViTFZxRHJXQ3hBUGFO?=
 =?utf-8?B?akp3bkpmZjNTU2wxWXdLaEV6RlBDKzZRbjZNRktRM0lndXdZVkRURk9VZVZz?=
 =?utf-8?B?UGN1TjYxMWs0RVZ2MmpzNTkxaXp6R1pqY1NCRGR5bk1hMHBlUUpZVE5VVDlL?=
 =?utf-8?B?N0VXV3lQdVB5UVZCSEo3bnYwMEhOWllEVEU0MFZxYUNmaFd3S1U0NlZoWTg0?=
 =?utf-8?B?cE5SeXIyU3F0OGc1VzN2Q2FLa3V6ekQrQit1SEFKR29sVDAydnBVSDVaZEZy?=
 =?utf-8?B?VnREOS9mVkJEQzd2TmFOeXRSY1Ruc1F5UUQzMmRIUnE2R1Yrck5MMXB0czJW?=
 =?utf-8?B?NTI1Y1lwWDlzRU9GZ3c5RGZRRUVPS05Sa0lCT29GeTlNcC9YTjhYajQ4RnI3?=
 =?utf-8?B?TThRNTlhV01DMjlNVThYVCs5UzV4SVVrQVZFQ1ExTXowak53amkyQW1ENVEy?=
 =?utf-8?B?MDROWHF2ZlFnVVk1N1lqdWw0Ukk2VmxXeDhSNTZpQlpTYTd2OVNKbmtFTGJL?=
 =?utf-8?B?c0lRS08rODVmZXVmdEdIWnI4VVdZOGNLcTREWVI1cjJnTGJQTUpsM1J1SVVP?=
 =?utf-8?B?MlZORmJPVWxnWllJdG9BK01OQnUveGMyTmpqZ2dITytTUHBSU0I2SFkyd1I1?=
 =?utf-8?B?TDIzQXBVNVhiY1pwMkdDSDYwZ0tmN1AvTzNpYmhCVlo2eUs1YkQrMGU3dUlU?=
 =?utf-8?B?VFhEK0JIY0dqNmQvWWhOSDAvazZvZGF3ZXVMWHdKdGtMcTFaMEd5dmRMd0ZK?=
 =?utf-8?B?dmxGVFVDVThxWVFLWjBYQlNSSlB2ZGRUL3dYeGl6TEpJOUxTV2NsY3I1QWpQ?=
 =?utf-8?Q?s3RykorNm2u0QhjmN7UsZbGrKZnlaMJVJ/MWs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5804.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RkV3cHlWdlN4ckhodHJYckM3WHUvWVRmRm9tbkl1YTAxWnlVek9uTXErYzZk?=
 =?utf-8?B?QmhHQWdRMy9XeGhsMk1aTXQ1UjNhcVM1ZHRKb0x4cjJ6MXl5UzBRQW50ME0x?=
 =?utf-8?B?MlROMlJpZjg5K1B5VU1KSG5qT3F1T2V3dkVmakExREVTSmMrazVXT3d4U0hD?=
 =?utf-8?B?NFVkdGsvT1lXVzY0dEtyMjRLZy96dUcwMlhYZ1hBWU0rdnBFU2UwY0lqK0dr?=
 =?utf-8?B?bUxFQ0pORnJlRnBNRGp2YmpodzdPRzRxcjlYcmtLQVpGR1R5L3poRnArOVpW?=
 =?utf-8?B?Q3p3OEdySXhGWFlINGNCazdkaDRmM3FtNGtldVZTTmlXNVQ4WlBZeGEwZ1JT?=
 =?utf-8?B?bDgxSnFhcTl4T2JNR3FIbEpGcWlqdyt0TkEzVGczaFMxN1N2Nld4V3VTVGly?=
 =?utf-8?B?NXpUMm1jVWJhT0JnQ0RjVkorNTJUZTRXUGhDSVlRQnJNT1hpaFFhaXVxTmxG?=
 =?utf-8?B?NlRaenZMSWhNR1ZKTlozcngwVEVpSDFLdFRUNm9FRHlmb3BTUlVHdmVNWVV1?=
 =?utf-8?B?UVdIZHVXSnVyNmdtYTJnN0ZuT0tna1F1MWlHOFFpK0o4TElhZWJqQkNaYnhx?=
 =?utf-8?B?ek15MXJjU3U4YmxoTWsrbWwyd1dJSW5sSnBnZGZvZzJpUUhKZ3FzY2g4MHZo?=
 =?utf-8?B?K1hXT3I5bDBQMXpQNE5memVNMG9Gb0NCWFFrNWU2RE1Xcmw4QjYrODF0SlE5?=
 =?utf-8?B?SWFyVURjNkRMQzdBaDd4Yit5MEJxdWVlb1FyUDJPMkxzYW9zNnRDbUV0MFNz?=
 =?utf-8?B?NlRTTUJaaEc5NHhjTGZqZ3V4ZXEvVENZdnczcDRDK01Cb3Y4MGxnMTFRK0ZZ?=
 =?utf-8?B?WUxEZFp0Z21IZlRnYmtWd0NxWlliVTFkWVp3REgxZTg3YTd6RzNYRVhrb2Uv?=
 =?utf-8?B?VzIxWU1vMjNhdGhhL05vOUZRcS91eUxucXgyb09nN1B6cGFGNGh0MW9xWERr?=
 =?utf-8?B?bGgvQ05QcFdIZDVrcVZFMk5ibjZwN0FGMnQ3cnZ2Q0RlcGVMR3l6c2xrZklo?=
 =?utf-8?B?bzhzMEdJUkVxVVgvVHg3aUxPeU8yemN2eG1Ualc1azNoTm1wNlFWQkhTMmNP?=
 =?utf-8?B?RitwclR5eWpoaVRRcmtzdnIxUjZuVzlsSHRheWZydkQ3UXVvaFJ6bzR6UHJ5?=
 =?utf-8?B?VHpmajd4Y1gwSk92SldFTzVtR2NUUlJrV24zVWJUN2kzNXFZZzMyK1ltQysw?=
 =?utf-8?B?bVdLTys1bzNPcVpubGV5YS9QTkgveXlyK09kWnlrMUtWYWtqN2JFbXYyMkpr?=
 =?utf-8?B?ZDhKSmlUUVRSSGdMajNCYTNIOGpYY1UvczQvR2grU2RPVldPOXVVeDY1c3Nr?=
 =?utf-8?B?Z2RYdmtNalRSZ1VMMWVaQ2hKNW5aKzB6aVppbFJGbXR0UzVHcU8vSURWYUJB?=
 =?utf-8?B?bFptVHN3M1Uvd0ttK3F2UFBkdHlpdzlqUm9VaTBtWC9hMGFiR3V1TDhka0N4?=
 =?utf-8?B?cHdHRzF6UWRyZGdFV2Q5OVlYcVJTNDN4aUN4ZmFyeVFSZkRkbEZveDl6Z0F0?=
 =?utf-8?B?K1QzR0FkVG00aDdmVjBRdFFRZWU5aC9tU1BWaHZ3YXdiQmFXSjIveDVzMEVu?=
 =?utf-8?B?ZjA1NmppWGdBelpiaEZJSVpGZmJtTTdkK2g2a2RCQ1VzVU5tWHNKK1lvWUJa?=
 =?utf-8?B?WmoxOWdJUVF3R2txUFdvWTA0eit2Q2FVa3REaWV5YlVnbkJiMG5xV3U2aEtp?=
 =?utf-8?B?eERUY1pIY0lYSGxwZjdIbEJUSGdFOVlvcCt0U3hqSlhpamwyc1hDRlhwL0p3?=
 =?utf-8?B?Um9MWHJTV0FCM1pkZUEvMXAvTFpUeEszdEVXRWthZUxFTmdRdGVRaUR3M0FR?=
 =?utf-8?B?ZDBmamdYdWROd0UvdWpGZDNTbmpxYTlKTE1yeUZ2SDZJcURNeEtUdzA3TDdU?=
 =?utf-8?B?NWo4NncrbXE0ODN0aTRsTlhwSERMaVJIT3NWNExxUWV3UDhJWmZlNWJFbUJ5?=
 =?utf-8?B?L3RxRzFZOFVkejk1QU4xbGsweTk0UDE3T1o1V0JmUjJpSjV5ZGVOVEFpeHp4?=
 =?utf-8?B?K3l4YmdscnBFMWxwcUswRUdiZXMxZVI2Y2pLSHZHcTlKYmNucXZuY0RRTzB3?=
 =?utf-8?B?ZEIrbURWM2x3dDBkNzM2UkRSUG9PbzA1R0Z0NnFPc2tKTW1RRTJ3U0p6SkdB?=
 =?utf-8?B?amFHUWUxQjF2emxUOFU1THBPWVZadkZ6bjJTZXFvQXFsRDlkcERMQmMrdHl1?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: buckeyemail.osu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5804.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe74cd8-fd35-43eb-e7eb-08dc984c51be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 15:01:13.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb095636-1052-4895-952b-1ff9df1d1121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4kE5BVpiRa1YOFCm7/5ik8Yv80voaWc+XakXA352olprrrWGShiUtPadmphtg7Bif3N+ZQge3ODPRIU5pkBcdcQf6J3rUeYOybNSeGHddc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7718
X-Proofpoint-ORIG-GUID: g6OOtpQI5p1w34QKtJjxBysrwF8bfOmV
X-Proofpoint-GUID: g6OOtpQI5p1w34QKtJjxBysrwF8bfOmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290105

RnJhbmsgT2x0bWFubnMgPGZyYW5rQG9sdG1hbm5zLmRldj4gd3JpdGVzOg0KDQo+IEluIG9yZGVy
IHRvIHNldCB0aGUgcmF0ZSByYW5nZSBvZiBhIGh3IHN1bnhpX2NjdV9wcm9iZSBjYWxscw0KPiBo
d190b19jY3VfY29tbW9uKCkgYXNzdW1pbmcgYWxsIGVudHJpZXMgaW4gZGVzYy0+Y2N1X2Nsa3Mg
YXJlIGNvbnRhaW5lZA0KPiBpbiBhIGNjdV9jb21tb24gc3RydWN0LiBUaGlzIGFzc3VtcHRpb24g
aXMgaW5jb3JyZWN0IGFuZCwgaW4NCj4gY29uc2VxdWVuY2UsIGNhdXNlcyBpbnZhbGlkIHBvaW50
ZXIgZGUtcmVmZXJlbmNlcy4NCj4NCj4gUmVtb3ZlIHRoZSBmYXVsdHkgY2FsbC4gSW5zdGVhZCwg
YWRkIG9uZSBtb3JlIGxvb3AgdGhhdCBpdGVyYXRlcyBvdmVyDQo+IHRoZSBjY3VfY2xrcyBhbmQg
c2V0cyB0aGUgcmF0ZSByYW5nZSwgaWYgcmVxdWlyZWQuDQo+DQo+IEZpeGVzOiBiOTE0ZWMzM2Iz
OTEgKCJjbGs6IHN1bnhpLW5nOiBjb21tb246IFN1cHBvcnQgbWluaW11bSBhbmQgbWF4aW11bSBy
YXRlIikNCj4gUmVwb3J0ZWQtYnk6IFJvYmVydCBKLiBQYWZmb3JkIDxwYWZmb3JkLjlAYnVja2V5
ZW1haWwub3N1LmVkdT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0RN
NlBSMDFNQjU4MDQ3QzgxMERERDVEMEFFMzk3Q0FERkY3QzIyQERNNlBSMDFNQjU4MDQucHJvZC5l
eGNoYW5nZWxhYnMuY29tLw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQt
b2ZmLWJ5OiBGcmFuayBPbHRtYW5ucyA8ZnJhbmtAb2x0bWFubnMuZGV2Pg0KVGVzdGVkLWJ5OiBS
b2JlcnQgSi4gUGFmZm9yZCA8cGFmZm9yZC45QGJ1Y2tleWVtYWlsLm9zdS5lZHU+DQoNCj4gLS0t
DQo+IFJvYmVydCwgY291bGQgeW91IHBsZWFzZSB0ZXN0IGlmIHRoaXMgZml4ZXMgdGhlIGlzc3Vl
IHlvdSByZXBvcnRlZC4NCg0KSSBqdXN0IGFwcGxpZWQgdGhpcyBwYXRjaCB0byBteSBib2FyZCdz
IGtlcm5lbCwgYW5kIGl0IGZpeGVzIHRoZSBpc3N1ZS4NCg0KPg0KPiBJJ20gQ0MnaW5nIE3DpW5z
IGhlcmUsIGJlY2F1c2UgaGUgb2JzZXJ2ZWQgc29tZSBzdHJhbmdlIGJlaGF2aW9yIFsxXSB3aXRo
DQo+IHRoZSBvcmlnaW5hbCBwYXRjaC4gSXMgaXQgcG9zc2libGUgZm9yIHlvdSB0byBsb29rIGlu
dG8gaWYgdGhpcyBwYXRjaA0KPiBmaXhlcyB5b3VyIGlzc3VlIHdpdGhvdXQgdGhlIG5lZWQgZm9y
IHRoZSBmb2xsb3dpbmcgKHNlZW1pbmdseQ0KPiB1bnJlbGF0ZWQpIHBhdGNoZXM6DQo+ICAgICAg
IGNlZGI3ZGQxOTNmNiAiZHJtL3N1bjRpOiBoZG1pOiBDb252ZXJ0IGVuY29kZXIgdG8gYXRvbWlj
Ig0KPiAgICAgICA5Y2E2YmMyNDYwMzUgImRybS9zdW40aTogaGRtaTogTW92ZSBtb2RlX3NldCBp
bnRvIGVuYWJsZSINCj4gVGhhbmtzLA0KPiAgIEZyYW5rDQo+DQo+IFsxXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC95dzF4bzc4ejhlejAuZnNmQG1hbnNyLmNvbS8gDQo+IC0tLQ0KPiAg
ZHJpdmVycy9jbGsvc3VueGktbmcvY2N1X2NvbW1vbi5jIHwgMTggKysrKysrKysrKysrLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3N1bnhpLW5nL2NjdV9jb21tb24uYyBiL2RyaXZl
cnMvY2xrL3N1bnhpLW5nL2NjdV9jb21tb24uYw0KPiBpbmRleCBhYzAwOTFiNGNlMjQuLmJlMzc1
Y2UwMTQ5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvc3VueGktbmcvY2N1X2NvbW1vbi5j
DQo+ICsrKyBiL2RyaXZlcnMvY2xrL3N1bnhpLW5nL2NjdV9jb21tb24uYw0KPiBAQCAtMTMyLDcg
KzEzMiw2IEBAIHN0YXRpYyBpbnQgc3VueGlfY2N1X3Byb2JlKHN0cnVjdCBzdW54aV9jY3UgKmNj
dSwgc3RydWN0IGRldmljZSAqZGV2LA0KPg0KPiAgCWZvciAoaSA9IDA7IGkgPCBkZXNjLT5od19j
bGtzLT5udW0gOyBpKyspIHsNCj4gIAkJc3RydWN0IGNsa19odyAqaHcgPSBkZXNjLT5od19jbGtz
LT5od3NbaV07DQo+IC0JCXN0cnVjdCBjY3VfY29tbW9uICpjb21tb24gPSBod190b19jY3VfY29t
bW9uKGh3KTsNCj4gIAkJY29uc3QgY2hhciAqbmFtZTsNCj4NCj4gIAkJaWYgKCFodykNCj4gQEAg
LTE0NywxNCArMTQ2LDIxIEBAIHN0YXRpYyBpbnQgc3VueGlfY2N1X3Byb2JlKHN0cnVjdCBzdW54
aV9jY3UgKmNjdSwgc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJcHJfZXJyKCJDb3VsZG4ndCBy
ZWdpc3RlciBjbG9jayAlZCAtICVzXG4iLCBpLCBuYW1lKTsNCj4gIAkJCWdvdG8gZXJyX2Nsa191
bnJlZzsNCj4gIAkJfQ0KPiArCX0NCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBkZXNjLT5udW1f
Y2N1X2Nsa3M7IGkrKykgew0KPiArCQlzdHJ1Y3QgY2N1X2NvbW1vbiAqY2NsayA9IGRlc2MtPmNj
dV9jbGtzW2ldOw0KPiArDQo+ICsJCWlmICghY2NsaykNCj4gKwkJCWNvbnRpbnVlOw0KPg0KPiAt
CQlpZiAoY29tbW9uLT5tYXhfcmF0ZSkNCj4gLQkJCWNsa19od19zZXRfcmF0ZV9yYW5nZShodywg
Y29tbW9uLT5taW5fcmF0ZSwNCj4gLQkJCQkJICAgICAgY29tbW9uLT5tYXhfcmF0ZSk7DQo+ICsJ
CWlmIChjY2xrLT5tYXhfcmF0ZSkNCj4gKwkJCWNsa19od19zZXRfcmF0ZV9yYW5nZSgmY2Nsay0+
aHcsIGNjbGstPm1pbl9yYXRlLA0KPiArCQkJCQkgICAgICBjY2xrLT5tYXhfcmF0ZSk7DQo+ICAJ
CWVsc2UNCj4gLQkJCVdBUk4oY29tbW9uLT5taW5fcmF0ZSwNCj4gKwkJCVdBUk4oY2Nsay0+bWlu
X3JhdGUsDQo+ICAJCQkgICAgICJObyBtYXhfcmF0ZSwgaWdub3JpbmcgbWluX3JhdGUgb2YgY2xv
Y2sgJWQgLSAlc1xuIiwNCj4gLQkJCSAgICAgaSwgbmFtZSk7DQo+ICsJCQkgICAgIGksIGNsa19o
d19nZXRfbmFtZSgmY2Nsay0+aHcpKTsNCj4gIAl9DQo+DQo+ICAJcmV0ID0gb2ZfY2xrX2FkZF9o
d19wcm92aWRlcihub2RlLCBvZl9jbGtfaHdfb25lY2VsbF9nZXQsDQo+DQo+IC0tLQ0KPiBiYXNl
LWNvbW1pdDogMjYwNzEzMzE5NmMzNWYzMTg5MmVlMTk5Y2U3ZmZhNzE3YmVhNGFkMQ0KPiBjaGFu
Z2UtaWQ6IDIwMjQwNjIyLXN1bnhpLW5nX2ZpeF9jb21tb25fcHJvYmUtNTY3N2MzZTQ4N2ZjDQo+
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gDQo+DQo+IEZyYW5rIE9sdG1hbm5zIDxmcmFua0BvbHRt
YW5ucy5kZXY+DQo+DQoNClRoYW5rIHlvdSwNClJvYmVydCBQYWZmb3JkIDxwYWZmb3JkLjlAYnVj
a2V5ZW1haWwub3N1LmVkdT4NCg==

