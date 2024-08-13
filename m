Return-Path: <stable+bounces-67555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8B951065
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 01:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A464C1F216F7
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933E1AAE0A;
	Tue, 13 Aug 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TJ6QPqCc";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VT0sS+fx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tAY+UTEW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA1153BF6;
	Tue, 13 Aug 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591095; cv=fail; b=A9uhkPnVc/wuo8NCdxSxZMarh8QNYxDnUU3/dWYhuRp3fuLvwKJPlaFYCQp0apVCHDfED2YA75AwJ7OKFhABNR45RS6JNdblDE6kb5yGqngc5wIEUOetnDYGuF5dJlmzrHbKov6VIKE3wPpo5Bg04uztLDXpThZTP5KrkxGG11k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591095; c=relaxed/simple;
	bh=cRZOhVFhqV26JduyaDaq/ZvNaEok/KkXEf9Y6IIVaa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4i44Tts0B4ID7Q1IF2dKXiKBINWORWendBmyuS5J30GZ+GcH0o0anm5Plm06xTuVSuvk1pt9KcE7L7xXYXNDxv50gJwPCFmfCGCj2J/ODGonM2PV2YT3O7nyncPE7AGaIravYnnOUxrU5DvO+7ivdrss9qgU+ZhZwXEA1mjfbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TJ6QPqCc; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VT0sS+fx; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tAY+UTEW reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DN6vls007520;
	Tue, 13 Aug 2024 16:18:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=cRZOhVFhqV26JduyaDaq/ZvNaEok/KkXEf9Y6IIVaa0=; b=
	TJ6QPqCcQtV3GtEYN0TVZ9z6we5I5w49YoBt/PzKrLpjmSVCrBWVY3XjVTrkCzSd
	8HokfWs9ztrHI+jeio9B7pnO1+T9zpCTCmXChyarIsbMWfUUr2zVVnse3ESnOJEc
	7sSnQrsq7rIAthCjiJ6Y5tsoFDBe1zHyLSsWYADg2vTfsHdIDeYIH8wntoabgpqd
	/0/bnhY+F6sws8TcXItFkSHKvobG+9VSkyMqyQHQQyaJCPXyHKFf5kyxu39qhtY5
	PfFV5e549+dRFezPrV/UGVdb/EaL30gVqAihVn0+ZqIaSLEUsjFY4FCersRPj6k+
	sSRLz6PvQX6p9Jp5ajkdvg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40x77jyuse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723591082; bh=cRZOhVFhqV26JduyaDaq/ZvNaEok/KkXEf9Y6IIVaa0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VT0sS+fxVnb3Bo1/htSDZPnNK03W1gtAS4a7OTgxwOoWED477yPerE1BUIyg9FpzE
	 wkNIU+21tcyin1+2YMxOV9Bp3CE4s9/7IEWRYb6EpLZnWNyG18BA5XSpzti9M0Z9am
	 m6jqenCf8MD8DqH4UrpvGk0HFXByiQRredWNpbsYsEji/3WG8Gq0brZvPOdJvMD3ch
	 ixpKq/2bUDx3UsQv8TSIGRvJ/3ilUVcgT1DmM4g3RGesdJnh19ko9QSN3ZUxWlMs2I
	 pDordCldPhESeUAuAqBAIneJPgEtGa7fHenJzzGCqHNjevBPFdXIBqRgJQiK+iUFe3
	 xclykL+xdy6SQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BE36740175;
	Tue, 13 Aug 2024 23:18:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5EE03A00AC;
	Tue, 13 Aug 2024 23:18:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tAY+UTEW;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 20B3D40351;
	Tue, 13 Aug 2024 23:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeV8yRH4q3Juc4z6Kdab5/BdmOGkaYeRjcqWFCF0drmtxbCWMk24Lnkj2uNsZJY45oNhUAQxuY+z+mvfzayYJC4yyKX8ta3EQz/HArkb7RBe7QgbWqJbaPUykRQXreKyWQjTWf43BKeAId/TI2APvsuUyq1uvsAYjqsifAfCngp9kX8p/V/hFQeaEv0rFMG2+mdCDxpsoKDPZ2NuQAw4EUGFAFYccDeeO8d8lOsLf9y3ICx5YqoUOpFqYvV4HaDYglXDEVzLGR2XqUOLuFtDXOQ91It6YUYYShIElCDQO5myqDspsfYxb0KAMYMV0/PpPrsASxca4w4v+oaxiw9HmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRZOhVFhqV26JduyaDaq/ZvNaEok/KkXEf9Y6IIVaa0=;
 b=lXIw26EZPiSkcA+mvBhbqfLi2pD2GFJWEwsAQ7N28dFiUot2HOdM9UssHuauukS74EW8ZDc/Hrjtsa4F6sMAOGBg8pH01HSYUd9wwjoc5lmw1Zb0kOmGCHH060u0UAyVmgEy2Y8m6nYxlP9SBggUkYunFFEFRFW/Hr0TdNrYQErQPIFNZrrcKBnR/0UoFsJNqEO27P009mZCc6NreMhPPRx3xkHEr+xr8wAbAPGFuLn7DJDrlp6hcdH/Nn1vazgrD95wGvwaSaZwn9S4Bh5CLu272a9yXflN7M1MQawYvhueB+EKcxqyEilSneqZJpnna16/XlL7XKr4KS15Gx0QlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRZOhVFhqV26JduyaDaq/ZvNaEok/KkXEf9Y6IIVaa0=;
 b=tAY+UTEW+5iI58KuvtKrttKCTsaPg5JsN/A1hyophSE4VVODPjxCyxta8XqXCDCmH2jhznCC/WeZ9BnVO65HWN1+yXunrbJOQCJ8Y4u4PvgYQAvH6VMwTZiVHYTKXENLblE4jMZiH48wPB+Rz7DJZVraF0NgPrCD9W0qQp/4kj8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:17:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 23:17:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Thread-Index: AQHa6YuP+qYtFRYGC02uoJ+XT4o4f7IflHkAgAEHAoCABT9uAA==
Date: Tue, 13 Aug 2024 23:17:56 +0000
Message-ID: <20240813231744.p4hd4kbhlotjzgmz@synopsys.com>
References:
 <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
 <20240808120507.1464-1-selvarasu.g@samsung.com>
 <20240809232804.or5kccyf7yebbqm6@synopsys.com>
 <98e0cf35-f729-43e2-97f2-06120052a1cc@samsung.com>
In-Reply-To: <98e0cf35-f729-43e2-97f2-06120052a1cc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB9446:EE_
x-ms-office365-filtering-correlation-id: ad858e87-066b-413d-d651-08dcbbee29f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bERvTDROUmZjSnlUc3VlTUVkU1dEeElmSVBieHN5amtsdzlaMit2MlN2bEIx?=
 =?utf-8?B?NnpaY0xoVG8xS1lobFVkOENSMXIwejR3cGxxZERjaGxXZ3cwcTN4RHcvM29W?=
 =?utf-8?B?WjF6UnRxaXB1ZGNNV1hLZGF0TDF0Qm43U3IzcUwwcDJoRm1NWmpGOEZXYnh0?=
 =?utf-8?B?bjR1cjlySnFtUnhQUmpQdVZaTEhnUHlqeTY2ekNlRW95bFNwWG9UTExnVzJo?=
 =?utf-8?B?UitpV0FrUXlIM0MzV1lLeXo1SHc1Mkh2RXc0ck1Gd1ZocUp5YnVod2dqNXJH?=
 =?utf-8?B?bEtoQURPZUNWV25ZRndBc0NCZnhxR1UrY002YnhaUFJBMUxjOXo0SDBaL0JJ?=
 =?utf-8?B?aE0wZ3JlejdtK1E1ZVJOYkNRUUx3aVBscXhkRlcxWWovMUE2OG11Ui9Yb1g0?=
 =?utf-8?B?MmZsS0F4dDh1QTVjdnF2VEJGUm9NcDFpMUZSelBSRGRDdGdPQ1B1UCtaVVpS?=
 =?utf-8?B?TkZVdjkwVmlMODBXcCt4eXY5RWhiZVpES2xGeEdyVlhLTmt2Sy9NQUpJbHpE?=
 =?utf-8?B?RlROeVpNRkdDRXZseWt6SVJCSzJtbXhuNHRiUjlMbjBYTEx3NEtvdFBXMmk0?=
 =?utf-8?B?TmRLSzhKMFBLejJlbVREK3owQURnVnVoV1dKUmMwZGZwTGU2VUNLeWFxaXkw?=
 =?utf-8?B?UlYrallUcUNKckE5TVlldVFQRVV0blJwQWVtaU01Wjh1ekY0bENUL3RTQlVI?=
 =?utf-8?B?WjQ4M2tudWFVclFhaVVMeFA1K1J5aE80akczUWkxaHlwUXVGUlV2T1hyb1JL?=
 =?utf-8?B?RUlvSkFmdUtWcEdCVUhubmtWb253RURQVmlKdE1FS2VzdE81NEs5MG1FNHhD?=
 =?utf-8?B?VFBEWjR2TjlQLzU3OVVpVmo5RG9wSkRCVDdTSHBvQ3RSYyt0TXNhWGtBdkRF?=
 =?utf-8?B?eTN6MG0rZGQvKzRuQXBCK0RzL1JhOERVVTZaVWowSlVLSWYvWitwRFRvTkVX?=
 =?utf-8?B?MU51MlNRYkMwcWMvQ0Fzd3JPR1hXS3lzUW5wUm1rempDZVVHNk1vU1FZVUto?=
 =?utf-8?B?S1hSRzMrZ2RHb2dlRVhkeXY4S0YxYmV6UUhhZ3Y5d09uZHJ1dENmNXFjWmls?=
 =?utf-8?B?SlFhc0c1UzAvN3JpNE5kUW4xWUtxa0V6R0l5SWlhanJ5eTljY3pvNFBQMHZM?=
 =?utf-8?B?YVlMY1g1akR4dDE5QkJSMHNUbEJBRDlMdVY3WTE2eXlOTnVSc2FjRXU0QjMx?=
 =?utf-8?B?NitKT0p4bVdJb2dQUWdCN0EwVzBJS1RaSzBvMi9nUGJPQmJ2aUFuNVQ4ZXdz?=
 =?utf-8?B?aWFXQk1FUFFiei9xb01qYnVBMTZLQUo1Tk1UOUhMcWpuSS9HMVFjNFZ6bW5j?=
 =?utf-8?B?emVuYkMvdUgxL3BNRlhGYlJHTDdFN1ZYVFR2UXIyYlFMZlY0UU9QQXVldHRl?=
 =?utf-8?B?M2lKSVFxd3NBZWVEbmlrdk12R2lNTmFzT2xWYWdKb25Bc2lSUnR4NDI0VHR4?=
 =?utf-8?B?QjRNc2w4by9EODdXckgzWjJZalAyVUNWMUVxM3Y3V1lFT0cwY1JWNzUvWmpp?=
 =?utf-8?B?UUIxdkd0VVpucTRqeUNIak9Zd0ZKbXpnUTZBN3FSVVUzNG1xZGNzYmVrNy9o?=
 =?utf-8?B?YWloZjkvVVVUTGVjTVZwR28zall6WEdqVDVtYm1HQXg4Y016NkJpMFp1THZK?=
 =?utf-8?B?UzNtRHRJWGVtclVmUEo5b1VnaENUY1VWVDl4L0EyU1dyMWVCYnA4bno0bXF3?=
 =?utf-8?B?ekcrbE1jeUdOWmV5UzQ2UzQzR25oYy9tcnM0SG4xNVoyOXQvVGNEbmlYbWZK?=
 =?utf-8?Q?beoRHCMxTVX0LmZoFFaWFGZAlthF79GCX22kFVA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1RsdzZEaGNVYU1xdEU1bThPZU1UQVRBQ0NuTERXbUJ2WmJtQTBjN24vbWRX?=
 =?utf-8?B?N2Z4elZpMkhHTi9ibHlpSmVqY2UwR0dBTmdnNit1b1gyWmlXNXJ5cUxNVEV0?=
 =?utf-8?B?T1dEa3pQVlBzeGpEQTEwRlBCUXpPVFNxK1ZjS2ppNld3U3JSekxJTHBDUXNt?=
 =?utf-8?B?djRNTHJBZGtWa1E2YTdoRjc3VFJpKzRhTVpZYkZrSE00S2l5bldzdmJobFNL?=
 =?utf-8?B?U0NlUWxNaFUzM283L0Z6NjR3REltQ055cDRQeXdhRWg2eEszdWZETTE1VXBn?=
 =?utf-8?B?UnlyTVY1MXZhZmdvbEtmMXYyYVFCdElUZDlYdXRIR1gzcUoyanIrdHdhMkp6?=
 =?utf-8?B?Ny91bnN4Rk0xMnpBTkNlNFU3cGtsVmxxczEvUnBWRTRlZWx3V0dNL0grdjNC?=
 =?utf-8?B?SVNBRFFEdklYRGRrQWlYYXY1WkZhbkp4UGRFZXdlT2d6SUYxd2ZRc3o2ZXkw?=
 =?utf-8?B?YkJVVlZkdU9UQnFIT3hDMnF6bnNRZEhsSlh3UnJaRFlma29JNjM4dFBaNlpH?=
 =?utf-8?B?YzUvS0FNUFRveElJQlpxZzBwUUJqc1FOTmVaWHRPbGtKTFNMa1J5L0tneWpY?=
 =?utf-8?B?Wkl1RWZ0MDZhdUM2WDloRURkanZ6aDBOMk9ueWxLRUFBNDRXKzNSaWJCNTJ5?=
 =?utf-8?B?YzlNWmloRUdEQ2N2b3NEYVpLb2xYaVJuMHE1emo5QzU5clgxc3M3UHRnOHVO?=
 =?utf-8?B?WnJuOEhyWFVZOXFpenRyS3U1ak83RElRcjRrYmNPV1NENUpYcWF5RW00ZTY5?=
 =?utf-8?B?MG90RFRyclRkSDNQK3cvemduU2VVL0JJc1BYYUgrNzJBY3NQT0J1OVRvQ1lV?=
 =?utf-8?B?Z05VM2kxazlkVG9hL2k3cmFoeXo0RXh1ZkRDVFRIUUF4cXVIbjFxTUQ3SHdz?=
 =?utf-8?B?Q2NyNDUrNzdmMmFKUlRrT01lTDhQK2hPUktXUENEM3MyV2lKZGliMW41eUhC?=
 =?utf-8?B?TUwyVmtjQTF5RDZoUDBxUm1sczNpcWY2eldUK01RVGkrMkpZZlk2SjUxQmpT?=
 =?utf-8?B?SUlzSkxmRktsWGxySmdOL2FFWVJ1R3ZEVitNRVIwdGJ3VXdQWDNkL0poTzA4?=
 =?utf-8?B?VTRsZklBcHVNTVRVV0hJZ0wxTjFOaWNQempMMjZVK3JaQW1rVnVrVzgvWXZv?=
 =?utf-8?B?SzgvN3JHR3VoeS9JdEdoQm0zdXowb3hTbCtpY1ZRc3EzVHRUK3RCeTlKNFQv?=
 =?utf-8?B?M08vcTgrc1NpdWlVREU1T1lSaWl2UjZwUlg3dzN6OXM5RzY4UFU5ZnNnN2ZV?=
 =?utf-8?B?bVpRUU1RWUFjc3FIRUVFZndackhZNmw3OFUrbGVoZ0s5dGFNZUNUVTk2ZXAv?=
 =?utf-8?B?ZFBmcXFkMHNJdkJJa1R4WXJTWmE1elV6dHYwaE5aN1FjRHVUOTJKVS9wVHBh?=
 =?utf-8?B?UldjallkbnN5NlRkd3pEVkh5VWNESGVHU2dRQnk3WWozd2JWZHFLUlpZRHBQ?=
 =?utf-8?B?SzJLT0VJQ21KdURVT09seU1QN1I5TlozOEZHd0ZJaG9jTC9WOEcya3l2WVZT?=
 =?utf-8?B?eS9RQTJHZDc4UXJCamNqMUlZUkRVWTROVFVjWUhTZjhFdlAxUW5ueGJNbjFW?=
 =?utf-8?B?aE4rbTZHNlAxamJCUHZQOVk2YWNuVWVEUVAvV3VyNU1MUEFKUG9HOWdPOHhk?=
 =?utf-8?B?N1ppeVVrR2huVmx4RENZUlFqSWxjR1RDaVN6OVVPTXRBWlE4NUFMSDNWQUwx?=
 =?utf-8?B?aUVOR05CRUdzZzE3WGx4b0lscHFiLzVXdmpKRDJzb0tnZUVnZmNrY3hibjVw?=
 =?utf-8?B?T1dGNU5TNWMvYkdkL0d6WkY3ZVU5cEtkMWowUWk1UEIzRzZhdGo5Vk9KK2Rp?=
 =?utf-8?B?UzhZVXlKMW9hTG1BQlZid0ZOOFd5a21VOGt0RVE4RlgrdzZHVFN0K3FOS1dS?=
 =?utf-8?B?Qjl0T0pYa1RvbHVzS0dRY0lRL2graG50VXFrdDZXdEZOVmtGR2V6WmhYM0Nx?=
 =?utf-8?B?QW1xTTdFeDNjclNqQkFobWpaU3o4dWNBY2JkK29yTUgzTGpHQVJNY09ZYVAz?=
 =?utf-8?B?d0ZCcEMxd2srU216Z1JFN3JBdis2WU1XOGFidWxpemdlTnhYZmRwWVF6eWlK?=
 =?utf-8?B?RVJKRTMwUlE0V095SkNXckN6SGwrbG9IdzhrUXpqc2dtcVkwWGpoSjNwdGpp?=
 =?utf-8?Q?i5hlSDlqpA3YvO09f82gUDtu3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAB6E94E419A7E4B96391E4BE229518C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iq9tgANT0yMCQ5nPmnZ4jQ1+WgR4C6xduZwio9nEAp9K9fUQ+AgBjlbjlakKy5UOIvlOPaDT0KdCWXJREQWw2JDiJhW1eHOrhs7oT2X+tjN0uoxf6MJDVaG9V+DrDa4UG32KcGAFl3b8ZFVjLXhJcYSrEVxZMi30pHzFXMiNp/0SsrgUQ3TrEZNGjx4GPWHRXheKCelXWVMvjghcOj6VTfAWoO/RvwM3ot45auotfBxIR1nnJCyGmIsdupRWrmvMf0/y4Po8b9suqa1rvX2PjwJeU02soRbYckz7z7LHvmCxo5BKxGC5FXWqC5zoWQM/O5FP4VB0iD/Bh2ubTbppn2t7Lw6+IE6dtPHnHij7vOqzGLbPCWOJyi94EdJDU6GvPIFkoqFvYMsyfe3aZzqKirPgv4PABTg9KpfU8VXHDSpqc0l5egQaAijyzHKxGWlpfcQ8Deid/RE6fpSw0IECOgiqzCrA2TvQiXGFvoTdrIXrMYeTC2B+bZ6JB2nUhDNbLG6hHPBlsyQVG1ZRqCDIfOgsRF63LbGWBmRudpXAd+wusXI2KMO29s+sgTKnGDsBomt6NfYzDUNs6TYW8vLa07EpYkarramTFsH+IZvJhq4IfRd+ZnmKNKleQjx93WjYc5Tzt42A7XVtr4xsCSXMBg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad858e87-066b-413d-d651-08dcbbee29f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:17:56.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65dRAH95RfWG1tIOPnugwVN10HhRSSF+xwHpkqg29ItnzLfqfLIph3NlrJr3uhtMSCKeSSI3ZScaX2iGVbySoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
X-Proofpoint-ORIG-GUID: 3M-oQ3EKcCRhXLAfFui5ypTITrZNUign
X-Proofpoint-GUID: 3M-oQ3EKcCRhXLAfFui5ypTITrZNUign
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130168

T24gU2F0LCBBdWcgMTAsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC8xMC8yMDI0IDQ6NTggQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUaHUsIEF1ZyAw
OCwgMjAyNCwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+IFRoaXMgY29tbWl0IGFkZHJl
c3NlcyBhbiBpc3N1ZSB3aGVyZSB0aGUgVVNCIGNvcmUgY291bGQgYWNjZXNzIGFuDQo+ID4+IGlu
dmFsaWQgZXZlbnQgYnVmZmVyIGFkZHJlc3MgZHVyaW5nIHJ1bnRpbWUgc3VzcGVuZCwgcG90ZW50
aWFsbHkgY2F1c2luZw0KPiA+PiBTTU1VIGZhdWx0cyBhbmQgb3RoZXIgbWVtb3J5IGlzc3Vlcy4g
VGhlIHByb2JsZW0gYXJpc2VzIGZyb20gdGhlDQo+ID4+IGZvbGxvd2luZyBzZXF1ZW5jZS4NCj4g
Pj4gICAgICAgICAgMS4gSW4gZHdjM19nYWRnZXRfc3VzcGVuZCwgdGhlcmUgaXMgYSBjaGFuY2Ug
b2YgYSB0aW1lb3V0IHdoZW4NCj4gPj4gICAgICAgICAgbW92aW5nIHRoZSBVU0IgY29yZSB0byB0
aGUgaGFsdCBzdGF0ZSBhZnRlciBjbGVhcmluZyB0aGUNCj4gPj4gICAgICAgICAgcnVuL3N0b3Ag
Yml0IGJ5IHNvZnR3YXJlLg0KPiA+PiAgICAgICAgICAyLiBJbiBkd2MzX2NvcmVfZXhpdCwgdGhl
IGV2ZW50IGJ1ZmZlciBpcyBjbGVhcmVkIHJlZ2FyZGxlc3Mgb2YNCj4gPj4gICAgICAgICAgdGhl
IFVTQiBjb3JlJ3Mgc3RhdHVzLCB3aGljaCBtYXkgbGVhZCB0byBhbiBTTU1VIGZhdWx0cyBhbmQN
Cj4gPiBUaGlzIGlzIGEgd29ya2Fyb3VuZCB0byB5b3VyIHNwZWNpZmljIHNldHVwIGJlaGF2aW9y
LiBQbGVhc2UgZG9jdW1lbnQgaW4NCj4gPiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2hpY2ggcGxhdGZv
cm1zIGFyZSBpbXBhY3RlZC4NCg0KPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBpIGFtIHdyb25nLiBJ
IGRvbnQgdGhpbmsgdGhpcyB3b3JrYXJvdW5kIG9ubHkgDQo+IGFwcGxpY2FibGUgb3VyIHNwZWNp
ZmljIHNldHVwLiBJdCBjb3VsZCBiZSBhIGNvbW1vbiBpc3N1ZSBhY3Jvc3MgYWxsIA0KPiBvdGhl
ciB2ZW5kb3IgcGxhdGZvcm1zLCBhbmQgaXQncyByZXF1aXJlZCB0byBtdXN0IGNoZWNrIHRoZSBj
b250cm9sbGVyIA0KPiBzdGF0dXMgYmVmb3JlIGNsZWFyIHRoZSBldmVudCBidWZmZXJzIGFkZHJl
c3MuwqAgV2hhdCB5b3UgdGhpbmsgaXMgaXQgDQo+IHJlYWxseSByZXF1aXJlZCB0byBtZW50aW9u
IHRoZSBwbGF0Zm9ybSBkZXRhaWxzIGluIGNvbW1pdCBtZXNzYWdlPw0KDQpIb3cgY2FuIGl0IGJl
IGEgY29tbW9uIGlzc3VlLCB0aGUgc3VzcGVuZCBzZXF1ZW5jZSBoYXNuJ3QgY29tcGxldGVkIGlu
DQp0aGUgZHdjMyBkcml2ZXIgYnV0IHlldCB0aGUgYnVmZmVyIGlzIG5vIGxvbmdlciBhY2Nlc3Np
YmxlPyBBbHNvLCBhcyB5b3UNCm5vdGVkLCB3ZSBkb24ndCBrbm93IHRoZSBleGFjdCBjb25kaXRp
b24gZm9yIHRoZSBTTU1VIGZhdWx0LCBhbmQgdGhpcw0KaXNuJ3QgcmVwcm9kdWNpYmxlIGFsbCB0
aGUgdGltZS4NCg0KPiA+DQo+ID4+ICAgICAgICAgIG90aGVyIG1lbW9yeSBpc3N1ZXMuIGlmIHRo
ZSBVU0IgY29yZSB0cmllcyB0byBhY2Nlc3MgdGhlIGV2ZW50DQo+ID4+ICAgICAgICAgIGJ1ZmZl
ciBhZGRyZXNzLg0KPiA+Pg0KPiA+PiBUbyBwcmV2ZW50IHRoaXMgaXNzdWUsIHRoaXMgY29tbWl0
IGVuc3VyZXMgdGhhdCB0aGUgZXZlbnQgYnVmZmVyIGFkZHJlc3MNCj4gPj4gaXMgbm90IGNsZWFy
ZWQgYnkgc29mdHdhcmUgIHdoZW4gdGhlIFVTQiBjb3JlIGlzIGFjdGl2ZSBkdXJpbmcgcnVudGlt
ZQ0KPiA+PiBzdXNwZW5kIGJ5IGNoZWNraW5nIGl0cyBzdGF0dXMgYmVmb3JlIGNsZWFyaW5nIHRo
ZSBidWZmZXIgYWRkcmVzcy4NCj4gPj4NCj4gPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBXZSBjYW4ga2VlcCB0aGUgc3RhYmxlIHRhZywgYnV0IHRoZXJlJ3Mgbm8gaXNzdWUgd2l0
aCB0aGUgY29tbWl0IGJlbG93Lg0KPiANCj4gDQo+IEJ5IG1pc3Rha2VuIEkgbWVudGlvbmVkIHdy
b25nIGNvbW1pdCBJRC4gVGhlIGNvcnJlY3QgY29tbWl0IGlkIHdvdWxkIGJlIA0KPiA2NjBlOWJk
ZTc0ZDY5ICgidXNiOiBkd2MzOiByZW1vdmUgbnVtX2V2ZW50X2J1ZmZlcnMiKS4NCg0KVGhlIGFi
b3ZlIGNvbW1pdCBpc24ndCB0aGUgaXNzdWUgZWl0aGVyLiBJZiBpdCBpcywgdGhlbiB0aGUgcHJv
YmxlbQ0Kc2hvdWxkIHN0aWxsIGV4aXN0IHByaW9yIHRvIHRoYXQuDQoNCj4gPg0KPiA+PiBGaXhl
czogODlkN2Y5NjI5OTQ2ICgidXNiOiBkd2MzOiBjb3JlOiBTa2lwIHNldHRpbmcgZXZlbnQgYnVm
ZmVycyBmb3IgaG9zdCBvbmx5IGNvbnRyb2xsZXJzIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogU2Vs
dmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiA+PiAtLS0NCj4gPj4N
Cj4gPj4gQ2hhbmdlcyBpbiB2MjoNCj4gPj4gLSBBZGRlZCBzZXBhcmF0ZSBjaGVjayBmb3IgVVNC
IGNvbnRyb2xsZXIgc3RhdHVzIGJlZm9yZSBjbGVhbmluZyB0aGUNCj4gPj4gICAgZXZlbnQgYnVm
ZmVyLg0KPiA+PiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNzIyMTQ1NjE3LjUzNy0xLXNlbHZhcmFzdS5n
QHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFjdlptbmF4VFd0SktSNFpEUlpEYS04bXZ4cHZr
ZjVLUHg1N0l3U1hUU0V0RUZJVmtQdWxsUjdzVFlQMEFNOWRlMHhGYkhMS2RNXzVqekJVaUJMM2Y5
U3Vpb1lFJA0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDUgKysr
KysNCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4+IGluZGV4IDczNGRlMmE4YmQyMS4uNWI2N2Q5YmNhNzFiIDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiA+PiBAQCAtNTY0LDEwICs1NjQsMTUgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVy
c19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+PiAgIHZvaWQgZHdjM19ldmVudF9idWZmZXJz
X2NsZWFudXAoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4gICB7DQo+ID4+ICAgCXN0cnVjdCBkd2Mz
X2V2ZW50X2J1ZmZlcgkqZXZ0Ow0KPiA+PiArCXUzMgkJCQlyZWc7DQo+ID4+ICAgDQo+ID4+ICAg
CWlmICghZHdjLT5ldl9idWYpDQo+ID4+ICAgCQlyZXR1cm47DQo+ID4+ICAgDQo+ID4gUGxlYXNl
IGFkZCBjb21tZW50IGhlcmUgd2h5IHdlIG5lZWQgdGhpcyBhbmQgd2hpY2ggcGxhdGZvcm0gaXMg
aW1wYWN0ZWQNCj4gPiBzaG91bGQgd2UgbmVlZCB0byBnbyBiYWNrIGFuZCB0ZXN0Lg0KPiANCj4g
RG8geW91IHdhbnQgYWRkIGNvbW1lbnQgYXMgbGlrZSBiZWxvdz8uIElmIHllcywgQXMgaSBzYWlk
IGVhcmxpZXIgbm90IA0KPiByZXF1aXJlZCB0byBtZW50aW9uIG91ciBwbGF0Zm9ybSBuYW1lIGFz
IGl0IGNvdWxkIGJlIGEgY29tbW9uIGlzc3VlIA0KPiBhY3Jvc3MgYWxsIHRoZSBvdGhlciB2ZW5k
b3IgcGxhdGZvcm1zLg0KDQpTZWUgbm90ZSBhYm92ZS4NCg0KPiANCj4gLypQcmV2ZW50IFVTQiBj
b250cm9sbGVyIGludmFsaWQgZXZlbnQgYnVmZmVyIGFkZHJlc3MgYWNjZXNzDQo+IGluIEV4eW5v
cyBwbGF0Zm9ybSBpZiBVU0IgY29udHJvbGxlciBzdGlsbCBpbiBhY3RpdmUuKi8NCg0KUGVyaGFw
cyB0aGlzOg0KDQovKg0KICogRXh5bm9zIHBsYXRmb3JtcyBtYXkgbm90IGJlIGFibGUgdG8gYWNj
ZXNzIGV2ZW50IGJ1ZmZlciBpZiB0aGUNCiAqIGNvbnRyb2xsZXIgZmFpbGVkIHRvIGhhbHQgb24g
ZHdjM19jb3JlX2V4aXQoKS4NCiAqLw0KDQogQlIsDQogVGhpbmgNCg0KPiA+DQo+ID4+ICsJcmVn
ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+ID4+ICsJaWYgKCEocmVnICYg
RFdDM19EU1RTX0RFVkNUUkxITFQpKQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gICAJ
ZXZ0ID0gZHdjLT5ldl9idWY7DQo+ID4+ICAgDQo+ID4+ICAgCWV2dC0+bHBvcyA9IDA7DQo+ID4+
IC0tIA0KPiA+PiAyLjE3LjENCj4gPj4NCj4gPiBUaGFua3MsDQo+ID4gVGhpbmg=

