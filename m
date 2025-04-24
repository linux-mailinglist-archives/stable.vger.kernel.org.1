Return-Path: <stable+bounces-136536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8EA9A5CE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190293B568D
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6920B808;
	Thu, 24 Apr 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="LyPY06uS"
X-Original-To: stable@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020121.outbound.protection.outlook.com [52.101.186.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BF208961;
	Thu, 24 Apr 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483208; cv=fail; b=kIOE6owtRixIkXs3H8UaUTWWpnrUh7y1gheVn8JPfg/jgOrF8IGIgqUvE1wrSrqmpOU6dYh8MmLfdwNtjHGwdV1qOnD0mnnEch5w6G7UPYXf0zm0npklvJWVC25hmqebKHzH4Fl95vz8r3V6iIBqAGWthal14m7CWnFGOx5rNr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483208; c=relaxed/simple;
	bh=VjLe20Qj3DD34gckz1R8d4+L8DKOULZGfHkYY3P/8ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZPJ5tggOjMBL5G5uLziYFZHvfHT15Jn62bRH2P2GYJvtp97oCxDSNqDT36F/9QLyeGhomzqqDmcW5kHAHoEBVUcS/0ZCsHwYtaxovjQmRz67Sp5rP2ZMLoT3hiFzxpCELw0CF/QGBI8yu8hET7k5w9eqwbwWxDSiWRMd+Hn5iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=LyPY06uS; arc=fail smtp.client-ip=52.101.186.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGDPwGCqln2XtG3bLWx9G1thQxX1rppRjHMrN3VN/M766eNL8RZb1ncwoSI7sSfm3U/2YhW4EMPISuOile1++43b1BhsmCaTUlYNOALU1T4kaZQd9X8k9OtmN6tX5rHzF6PHCfnM1R0n+zU9OcXarHaB9ICnZ0RR+Qj8jEaMbdWqI/EEKjkgJPK9tUVmwb5kREUVQBVGEA/L+0VKa0QpiB0bmFC3V32Fh2KVgSnOZVvZ1k6J5ijztMXXDlFgFCx3ikgWGvLVEzTg001UGCvTx0P/GiyoluUXfxZU3z2S+pZIdNMXmVOuGh4zW3+gFmGZZcFMBJjQjCZsVs2rxOAScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjLe20Qj3DD34gckz1R8d4+L8DKOULZGfHkYY3P/8ns=;
 b=LVdc+uuIZZQKrWJTa6qfgKod/Tu8ebZpn/Ka6hRyJkxQ1jVBdZuoRptiDrKtiwWWGYZK4gFbyb5yT5ngmShk9PU+UmQnH4aJ4/CLGraaloUdqE0NFrjdpo3i4RZg5mRpwKQ1P/bxrOgwNjBJYjtMFhc+I4kQ/SBsaroEA+H5JqnrYdgCzbwvfn86wNxzn3Q2m5kJU7cViCZT8WjySYQsp2PEDVd/WJOpS4hONsy0z25CfNqSU5+v2QK8Qu6tDZd5zwlIEHsjOOmB1XGuH9jvIEX70y5w6OES6nwbqP/Ouh5K5FTUoMeXuGDPrFh38COoYWL2WoERlXpSjk5PZJ7CBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjLe20Qj3DD34gckz1R8d4+L8DKOULZGfHkYY3P/8ns=;
 b=LyPY06uSLh3svB2e9eq4I2L8w2007oTdJhnK3rvTGrLBOkw/hcJ6W+SwWdqNh5juEr/J2V4hxh4n+bxjm0PC+LYKmx52PRl1/7kuLcKEe8R4/yeFeS1DzmrOy2PpgIUtf5SwGVrb7qoVvfFCtGVgdqKXbIqiE4X2wK7J5E6wL/6vejY2wUPtgqToDmZb0pHpsEc/g8MeSz0Spy4gS3V01c8NYON5ilFEBvE72Diwt8NgPfnU5dtGUe7TxYfBBOi2Yw85llKjttPk2c0oUDDfxM7gGWtcoz/mvYXK7mP+ZA9QIhWEdIClwdJNiiV2SphdkjsgCghYxGCOCfK/D0RaWA==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 ZR0P278MB1352.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:82::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.10; Thu, 24 Apr 2025 08:26:41 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:26:41 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Francesco Dolcini
	<francesco@dolcini.it>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Index: AQHbs48w0QwgOvbFxkuKoITcJDMRw7OyfhEA
Date: Thu, 24 Apr 2025 08:26:40 +0000
Message-ID: <ad6b0ea2d9111625557aa884639b7707f71056b7.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
In-Reply-To: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|ZR0P278MB1352:EE_
x-ms-office365-filtering-correlation-id: e73396f7-1d13-4b30-c5cc-08dd8309bd42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2ZhekxEMG16Q24xVjFrMzlYUlNsVW9uSVBEWXlyN1pQZ01VWURQWmhndC9Q?=
 =?utf-8?B?UTV5Ym1QTGFiZ3lUblAzR2RSTGEvT01OVGJHWjB5R2tjc09aaXpXK0RFak1X?=
 =?utf-8?B?dno5YW1sYlV0S3ZJdU9XTy81dSttT1NkS29WNjVLOC91OWMrcnMzUlFOTG9z?=
 =?utf-8?B?VGs5SjJuUDQvT1M2UVl5V3RiU3h1bTFvWWVHNWhKMkY0WE80UzgyNm5EWGlG?=
 =?utf-8?B?SlkrdTdqYkJOREVxWnlDUG5DUm9vcDdzUTNuUTU5STQyTm5FU1VaWDRDT1Aw?=
 =?utf-8?B?RDNzZm1nWUFkS3RIRVFxamRUZGdWUHBoK1BIN2d6aDJlZHd2TjBSVENDaEp0?=
 =?utf-8?B?MklXYU5iUU1naGtiRzFqMmFaT0JEc3RoTTNEa1pNbmMyeDhqVEhjbWpYK2Y1?=
 =?utf-8?B?MHpYMlZpNjlDYlptdm4xU09KQlVQYXpNb0gwc0VaWVhnRFowNjB3b1g0Q21M?=
 =?utf-8?B?NjNwcVFNS2hZdlRzdjZtQ0pqOVJLMlFHNm96anJVVy9GcTlYR1JqYlFOWEV6?=
 =?utf-8?B?RkxDMnZVbXF6UDdSN3BCNW81Z3pXZnV5UW85RjRrL2NPQ2RKOUNRZGVFQlZu?=
 =?utf-8?B?T3hKTXV3SUNKelNtZGlrYTV5bHBSbXNyUUhNczBNUjdZT1dneEcrRGZ1TTJV?=
 =?utf-8?B?R29EZXFWU0tnMVFMZXpjMWpFNkNKcmF4TjdZUWdBVHdJV2RaMElJYS9ZKzg2?=
 =?utf-8?B?NGp4SHQxVk9QQkFqVEpPNWZXOE9MTGNEZlNaeUppMEdiZVF2NS8za3lJclUz?=
 =?utf-8?B?eVplQU5XWlpYVGs0MGdOV0EvWmlvTXc2dXJWZTZvUFVNZHV2b2dGODljdThq?=
 =?utf-8?B?SFVlR0xxL1I4dllFQ2ovSlIrWVVsNGp6OCtrRmRISUNvWmJXT2pDSVZpMWxV?=
 =?utf-8?B?a3h3ME9xUlZyWVFFdzQ4SVM2NGo0UTNOby9FZnVDaTJjbmRvejJnejdHZmxi?=
 =?utf-8?B?WVpzeUcyTkEwdDcyaElhQzRtN0RZdlpNVjB3TXZQRFFUTWo2Mmd6OGw5Sm1F?=
 =?utf-8?B?K0M3L1krUDluWGpRQWJsam54ZGZIaWhUMnA4QzFjYWtPTGg2TzNxMnVzUXgx?=
 =?utf-8?B?dzRVQmtIM2h0UVlKOVF6TlBnOWVzWFE4d1p3SDdiMW5MdDgwWTJKdi8zOGoy?=
 =?utf-8?B?eFFhSXpSbkkvUlhZaUhUYWdjakhDVExuZFpvdnpzbnFFWlFCWU5iZHhKWnpO?=
 =?utf-8?B?NHF6bkhkTTBOZDdwb09hbE1SV09XRW4rdEhORldRMkNySXNlS2ZQSlE1OXpn?=
 =?utf-8?B?dzNmU2hsRDFiSXVkTzVyWGh0a1h6RSsraytLYlBsTkR2Q0FMME8vTmNXRVp6?=
 =?utf-8?B?YlpMV0VFQ2ppRWdST0VTYlN3bnV0aS9WZG1uNUlZK3R5UStLSjNDbTcySi9k?=
 =?utf-8?B?NzByL3B2OVlmODRSdWxwaG9EYzVEREVJZ2pFOUhvd2xpcHhBTHVaMFVBeXox?=
 =?utf-8?B?V0lDV0Z6WFJhb2FZMkRMdU55MnBQQWk5V1JjNUIyRlh6TkFjUHNYNktxT2hF?=
 =?utf-8?B?T2FoamdLOXIrTWhyVHZQRkFsQVNhbUtyazJhWnlTQU94QVd5ZUQ5Qi8wWnRU?=
 =?utf-8?B?VHloYytsQmNtQTMvL2JZVmgyOU1YTUNMVUZuMG5pMzBVZHFNMzJtdVpVbHAx?=
 =?utf-8?B?bDhNL2xNTmtIdkxDZ0hON3pHRnBIN1Jrb0NFanVLTEQvWkZVeCt0aCsrb2VJ?=
 =?utf-8?B?cHRSVkZKTTd3bXR0VExTRllqU1RHcFJYc1FseEkwaXZVK3habVM4aW1BVFUy?=
 =?utf-8?B?eWFPRFNxUmVvSHNoeHNHYzJrYmxUZEFGdWh1OUorcXdaRjZsSW1PRFMvZkNE?=
 =?utf-8?B?cCsvbnduWE11ZHM5cXd0UWIxVWlRU3h1ei9TNU9qQ2dERGdzUXc2MEdNUHZJ?=
 =?utf-8?B?amF5bEd3alZHakFUdTQ1RG14RTRkTitydXJTckxQUVFTZnVqTTRIV3FpWVF1?=
 =?utf-8?B?OUZiQ2ZIOVpEeEdIYUZrTndJdE43aVduOXNWNnhERTFNWHNhTE5rTC8xRlpR?=
 =?utf-8?Q?chnz1n/+vOa8J5bldt6J+uj5HF3pVU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmI4cFdZL3VnY1BBY25zV0NaVHJXamc5dVUySEYyS21HL0JrZWhsRUo5VVFF?=
 =?utf-8?B?ZWJ3c3BCM0JZYmRNSnNhK21Xd3ZscTBSdXU5VTJ2aGY5aDJUYnY4aVk0RVFE?=
 =?utf-8?B?b3JaL3g2VnZhNHYxZmRZS0hiMlg3WmxkZmloajVQR3J6KzNrbkdGc0RzeDBn?=
 =?utf-8?B?SlhDWmRGQ2JTWUFmajN6NEo2eXFobktRbE5UMXdUR3Z2SFhoa1M2dGd2ZjQx?=
 =?utf-8?B?QW9JV25MOEt0ZGtQWHd0YVRoeW5TWkJHTnlBZGNlVGdvbWp5VU4yQW9Xb3U3?=
 =?utf-8?B?RDZmVXRHTDRTbXI5K1kvazZsVjdVQ2lsZlhROFViQ3VRem8zclh5UWdTM2Ux?=
 =?utf-8?B?aituQVFBMXJVMVpCbitWNmQ2MENiRHFHS01aQVpSY3o3R1N1MkJXK2c5UC80?=
 =?utf-8?B?WjlqY3ZTYjhzaTRTSUFVK3VMeVRaK0QzNXdlQ2ZIaG5VV0dRT3dweGF6Q0F6?=
 =?utf-8?B?VGhrd0ZYQlkrcS9LSEFNbDFidVdxemdrTHVGNDBrQXpjUlB5b2JOOTIzeWx5?=
 =?utf-8?B?NUMrbms3MzdiMm1vbWdFdk1UWXZDQVpMcTFrd2VIdjkxa3hUOWVERHpaNy9B?=
 =?utf-8?B?WElrS2Z2ajJiMFBhNVg3WVpORzZVRXJEbGZqTExIUVRSMy85ME1LT0tmdjNt?=
 =?utf-8?B?MnE5RTdmcm0vZ3ExQmFDQVVDZVY4eE56K1RUSVhNc29IeEMvbDlKSzE3N3U2?=
 =?utf-8?B?MzJSUGZ4KzM2TGgxOE5Bajl3TkxIRkF1L3ZMVWxWa3BoWWZDRHM5bXpQNDNT?=
 =?utf-8?B?b0JTbkN4SDFTTUdzSnl0RU5LUUlJanNDWkxtZXhMcXlBRlplYUd6d3lOQ3F1?=
 =?utf-8?B?NUVYaVcrSEpLQ1FCRC96cGgxSzdRK0xHakJtZlRIcGRBeHhFeWh3YllPV0RI?=
 =?utf-8?B?b0o2NjR5WkJhZmlDdVF5SjdEU0R5K1hxK0Q1QUlySklHY0hQVUs4Zk11T0tE?=
 =?utf-8?B?T0RkU280MVZQallUeHpOdlk4ZGFJUkZtVDJWUWpvNEhzQ09OSHpEVmgyT3JS?=
 =?utf-8?B?cHZrQk5hd1U5b3FEWWU4c2dPRmROQnNxT29PWFVSM2w5V3NPUWFKSGRxSldE?=
 =?utf-8?B?UXBMckh5MTZyOWdaNGdZdnZlaXcrWU5sQUwvVnZveG5oMzBpWGN6dG9sbjh5?=
 =?utf-8?B?TWxKY1ppcm43Tk80MjVuMGFZNXFZUURLS0ZCdW44cUFPZ00wYWhzNWZaeVZ2?=
 =?utf-8?B?cFdsWUM3dUxUYWRkR1NZUUljSTQwOE1KSlBJUnJPYlFmSkVncGZrKy9xYUhs?=
 =?utf-8?B?ZEE5SFZEZmVFUnJkcUxPK1gybS8rWXJKeHFYNUxUYlQvazlhUFFCV29yQitj?=
 =?utf-8?B?RFoxc3pERjhVSUc3UDJUaStBL1Y2TEVJcWxFWUJXV2ZPZ0lDaGJ0Tk80TTkx?=
 =?utf-8?B?dkh6K1dQRXRFcllnNHQwSklsdVpsSjdxNCtjNlJMbURMODkvZUVlTzg4TzNT?=
 =?utf-8?B?V3RFcnlWMGZ0cGNXS2R4ZTlJK3p1ZzJ3V2YwbVFCZmcwelR1VFVaKzBOUzRo?=
 =?utf-8?B?enZSR01ZSXB2RTdjM3M4NEZsZG81em4xV1ZvMU90eVFPN1FsdkFTak9XcGNn?=
 =?utf-8?B?dXhiSTN2SzB2WkZQbEpwQjlON3Z0OGhyclY3TFhJYzA4eWdDQmtoU1Y4WWtB?=
 =?utf-8?B?ZENwYkhTTjRZM2ppMkd5bVRDdVZJVWNlcjY0elRDa1Y0amcwYkwzRjJ1ejRi?=
 =?utf-8?B?ZzZkRHhBS0VwcW11U1EzbXpYK2pqdTJiMnZodUFIVlQ3S0pRNXlJKzVxTDl1?=
 =?utf-8?B?SzlKN1ozM3NQaEc0VWsrS3BRdjZqTERxZW5GT2lEdXkzcEVtTjR2TFNiQ1FV?=
 =?utf-8?B?WjREOTFjRVhnejJJT3FQRnZyKzVYZXdPSGwxVlFEYm1nSyt2UUtqb0p1WUZa?=
 =?utf-8?B?enBPdXdvMFZaVlBzNkRwQkNiM3VSMEY4bUs0NlhwWllxLzJ3RGNWWXFvdEZx?=
 =?utf-8?B?UFczZmtKaFFsaDYwd3Z4MVg1Uk4rLzZBWkJhZ2JoaG1yVDFsV0dqaHNybnQy?=
 =?utf-8?B?bkhsTWZOT2Z5Slg5R042d1l0VGhPbkh2Y3luaEc1dVdOUkNxZlp4dHI4eGNa?=
 =?utf-8?B?a3p1VjhyWmF1WUc5MUxaOWc0Wm9rVXBBSk1SbXZpSVpZYkZnb1JpNXREYlJ1?=
 =?utf-8?B?WURraG1DOW5QT0hkUHJBaFNGMnZTck9Hbnk4bDZiTzJtVDhMYXhYWVViNmVR?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC5B113C6468544CA37D2CEED3E00FBE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e73396f7-1d13-4b30-c5cc-08dd8309bd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 08:26:40.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRmwqJMVFsthJiQW7H3iu/aWtrMQPG/0nvIXuWIJtrJwRcOYAqbtamoIakxeCPfN8m3jQcjGABIX38hnEVSc0Q2HSlrU1Du93UOYM+BJ/ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1352

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDE2OjAxICswMjAwLCBXb2pjaWVjaCBEdWJvd2lrIHdyb3Rl
Ogo+IERlZmluZSB2cW1tYyByZWd1bGF0b3ItZ3BpbyBmb3IgdXNkaGMyIHdpdGggdmluLXN1cHBs
eQo+IGNvbWluZyBmcm9tIExETzUuCj4gCj4gV2l0aG91dCB0aGlzIGRlZmluaXRpb24gTERPNSB3
aWxsIGJlIHBvd2VyZWQgZG93biwgZGlzYWJsaW5nCj4gU0QgY2FyZCBhZnRlciBib290dXAuIFRo
aXMgaGFzIGJlZW4gaW50cm9kdWNlZCBpbiBjb21taXQKPiBmNWFhYjA0MzhlZjEgKCJyZWd1bGF0
b3I6IHBjYTk0NTA6IEZpeCBlbmFibGUgcmVnaXN0ZXIgZm9yIExETzUiKS4KPiAKPiBGaXhlczog
ZjVhYWIwNDM4ZWYxICgicmVndWxhdG9yOiBwY2E5NDUwOiBGaXggZW5hYmxlIHJlZ2lzdGVyIGZv
cgo+IExETzUiKQo+IAo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1i
eTogV29qY2llY2ggRHVib3dpayA8V29qY2llY2guRHVib3dpa0BtdC5jb20+CgpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQGltcHVsc2luZy5jaD4KCj4g
LS0tCj4gdjEgLT4gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDQxNzExMjAx
Mi43ODU0MjAtMS0KPiBXb2pjaWVjaC5EdWJvd2lrQG10LmNvbS8KPiDCoC0gZGVmaW5lIGdwaW8g
cmVndWxhdG9yIGZvciBMRE81IHZpbiBjb250cm9sbGVkIGJ5IHZzZWxlY3Qgc2lnbmFsCj4gdjIg
LT4gdjM6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNDIyMTMwMTI3LkdBMjM4
NDk0QGZyYW5jZXNjby1uYi8KPiDCoC0gc3BlY2lmeSB2c2VsZWN0IGFzIGdwaW8KPiAtLS0KPiDC
oC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpwqDCoMKgwqAgfCAyNSAr
KysrKysrKysrKysrKystLQo+IC0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0tdmVyZGluLmR0c2kKPiBpbmRleCA3MjUxYWQzYTAwMTcuLmI0NjU2NmYzY2Uy
MCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVy
ZGluLmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVy
ZGluLmR0c2kKPiBAQCAtMTQ0LDYgKzE0NCwxOSBAQCByZWdfdXNkaGMyX3ZtbWM6IHJlZ3VsYXRv
ci11c2RoYzIgewo+IMKgIHN0YXJ0dXAtZGVsYXktdXMgPSA8MjAwMDA+Owo+IMKgIH07Cj4gwqAK
PiArIHJlZ191c2RoYzJfdnFtbWM6IHJlZ3VsYXRvci11c2RoYzItdnFtbWMgewo+ICsgY29tcGF0
aWJsZSA9ICJyZWd1bGF0b3ItZ3BpbyI7Cj4gKyBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+
ICsgcGluY3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMl92c2VsPjsKPiArIGdwaW9zID0gPCZncGlv
MSA0IEdQSU9fQUNUSVZFX0hJR0g+Owo+ICsgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMw
MDAwMD47Cj4gKyByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKPiArIHN0YXRl
cyA9IDwxODAwMDAwIDB4MT4sCj4gKyA8MzMwMDAwMCAweDA+Owo+ICsgcmVndWxhdG9yLW5hbWUg
PSAiUE1JQ19VU0RIQ19WU0VMRUNUIjsKPiArIHZpbi1zdXBwbHkgPSA8JnJlZ19udmNjX3NkPjsK
PiArIH07Cj4gKwo+IMKgIHJlc2VydmVkLW1lbW9yeSB7Cj4gwqAgI2FkZHJlc3MtY2VsbHMgPSA8
Mj47Cj4gwqAgI3NpemUtY2VsbHMgPSA8Mj47Cj4gQEAgLTI2OSw3ICsyODIsNyBAQCAmZ3BpbzEg
ewo+IMKgIMKgICJTT0RJTU1fMTkiLAo+IMKgIMKgICIiLAo+IMKgIMKgICIiLAo+IC0gwqAgIiIs
Cj4gKyDCoCAiUE1JQ19VU0RIQ19WU0VMRUNUIiwKPiDCoCDCoCAiIiwKPiDCoCDCoCAiIiwKPiDC
oCDCoCAiIiwKPiBAQCAtNzg1LDYgKzc5OCw3IEBAICZ1c2RoYzIgewo+IMKgIHBpbmN0cmwtMiA9
IDwmcGluY3RybF91c2RoYzJfMjAwbWh6PiwgPCZwaW5jdHJsX3VzZGhjMl9jZD47Cj4gwqAgcGlu
Y3RybC0zID0gPCZwaW5jdHJsX3VzZGhjMl9zbGVlcD4sIDwmcGluY3RybF91c2RoYzJfY2Rfc2xl
ZXA+Owo+IMKgIHZtbWMtc3VwcGx5ID0gPCZyZWdfdXNkaGMyX3ZtbWM+Owo+ICsgdnFtbWMtc3Vw
cGx5ID0gPCZyZWdfdXNkaGMyX3ZxbW1jPjsKPiDCoH07Cj4gwqAKPiDCoCZ3ZG9nMSB7Cj4gQEAg
LTEyMDYsMTMgKzEyMjAsMTcgQEAgcGluY3RybF91c2RoYzJfcHdyX2VuOiB1c2RoYzJwd3Jlbmdy
cCB7Cj4gwqAgPE1YOE1NX0lPTVVYQ19OQU5EX0NMRV9HUElPM19JTzUgMHg2PjsgLyogU09ESU1N
IDc2ICovCj4gwqAgfTsKPiDCoAo+ICsgcGluY3RybF91c2RoYzJfdnNlbDogdXNkaGMydnNlbGdy
cCB7Cj4gKyBmc2wscGlucyA9Cj4gKyA8TVg4TU1fSU9NVVhDX0dQSU8xX0lPMDRfR1BJTzFfSU80
IDB4MTA+OyAvKiBQTUlDX1VTREhDX1ZTRUxFQ1QgKi8KPiArIH07Cj4gKwo+IMKgIC8qCj4gwqAg
KiBOb3RlOiBEdWUgdG8gRVJSMDUwMDgwIHdlIHVzZSBkaXNjcmV0ZSBleHRlcm5hbCBvbi1tb2R1
bGUKPiByZXNpc3RvcnMgcHVsbGluZy11cCB0byB0aGUKPiDCoCAqIG9uLW1vZHVsZSArVjMuM18x
LjhfU0QgKExETzUpIHJhaWwgYW5kIGV4cGxpY2l0bHkgZGlzYWJsZSB0aGUKPiBpbnRlcm5hbCBw
dWxsLXVwcyBoZXJlLgo+IMKgICovCj4gwqAgcGluY3RybF91c2RoYzI6IHVzZGhjMmdycCB7Cj4g
wqAgZnNsLHBpbnMgPQo+IC0gPE1YOE1NX0lPTVVYQ19HUElPMV9JTzA0X1VTREhDMl9WU0VMRUNU
IDB4MTA+LAo+IMKgIDxNWDhNTV9JT01VWENfU0QyX0NMS19VU0RIQzJfQ0xLIDB4OTA+LCAvKiBT
T0RJTU0gNzggKi8KPiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9DTURfVVNESEMyX0NNRCAweDkwPiwg
LyogU09ESU1NIDc0ICovCj4gwqAgPE1YOE1NX0lPTVVYQ19TRDJfREFUQTBfVVNESEMyX0RBVEEw
IDB4OTA+LCAvKiBTT0RJTU0gODAgKi8KPiBAQCAtMTIyMyw3ICsxMjQxLDYgQEAgcGluY3RybF91
c2RoYzI6IHVzZGhjMmdycCB7Cj4gwqAKPiDCoCBwaW5jdHJsX3VzZGhjMl8xMDBtaHo6IHVzZGhj
Mi0xMDBtaHpncnAgewo+IMKgIGZzbCxwaW5zID0KPiAtIDxNWDhNTV9JT01VWENfR1BJTzFfSU8w
NF9VU0RIQzJfVlNFTEVDVCAweDEwPiwKPiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9DTEtfVVNESEMy
X0NMSyAweDk0PiwKPiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9DTURfVVNESEMyX0NNRCAweDk0PiwK
PiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9EQVRBMF9VU0RIQzJfREFUQTAgMHg5ND4sCj4gQEAgLTEy
MzQsNyArMTI1MSw2IEBAIHBpbmN0cmxfdXNkaGMyXzEwMG1oejogdXNkaGMyLTEwMG1oemdycCB7
Cj4gwqAKPiDCoCBwaW5jdHJsX3VzZGhjMl8yMDBtaHo6IHVzZGhjMi0yMDBtaHpncnAgewo+IMKg
IGZzbCxwaW5zID0KPiAtIDxNWDhNTV9JT01VWENfR1BJTzFfSU8wNF9VU0RIQzJfVlNFTEVDVCAw
eDEwPiwKPiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9DTEtfVVNESEMyX0NMSyAweDk2PiwKPiDCoCA8
TVg4TU1fSU9NVVhDX1NEMl9DTURfVVNESEMyX0NNRCAweDk2PiwKPiDCoCA8TVg4TU1fSU9NVVhD
X1NEMl9EQVRBMF9VU0RIQzJfREFUQTAgMHg5Nj4sCj4gQEAgLTEyNDYsNyArMTI2Miw2IEBAIHBp
bmN0cmxfdXNkaGMyXzIwMG1oejogdXNkaGMyLTIwMG1oemdycCB7Cj4gwqAgLyogQXZvaWQgYmFj
a2ZlZWRpbmcgd2l0aCByZW1vdmVkIGNhcmQgcG93ZXIgKi8KPiDCoCBwaW5jdHJsX3VzZGhjMl9z
bGVlcDogdXNkaGMyc2xwZ3JwIHsKPiDCoCBmc2wscGlucyA9Cj4gLSA8TVg4TU1fSU9NVVhDX0dQ
SU8xX0lPMDRfVVNESEMyX1ZTRUxFQ1QgMHgwPiwKPiDCoCA8TVg4TU1fSU9NVVhDX1NEMl9DTEtf
VVNESEMyX0NMSyAweDA+LAo+IMKgIDxNWDhNTV9JT01VWENfU0QyX0NNRF9VU0RIQzJfQ01EIDB4
MD4sCj4gwqAgPE1YOE1NX0lPTVVYQ19TRDJfREFUQTBfVVNESEMyX0RBVEEwIDB4MD4sCg==

