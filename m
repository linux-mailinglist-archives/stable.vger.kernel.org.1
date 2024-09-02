Return-Path: <stable+bounces-72714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D4968638
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC5E1F21503
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC813185939;
	Mon,  2 Sep 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XL0T/xV/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ERbO4eiX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8A185924;
	Mon,  2 Sep 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276568; cv=fail; b=ZYPKq76sTy2QCmbQQ0BcIORAs6JBfMgoUIm5NbObJkSiLjnPUlGe1biiPPUxyG0ZPd0lVTJxenILLVjrMnhfswrYlrEMpbqZzIVPrYgpguDJR/lAA7MgsonlSHnfDhOikNZVeXm8fDGtoU4+anKcUjllgYfXRkcCeqKQm3AFUrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276568; c=relaxed/simple;
	bh=CJBlChoTJ2PUiU6NULQuXWht8p4fxDkKlSMwGynbCck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVzuUBfC5QyaQD2wuIvpV9GDDJot48jPQKcxyfX1BXlfxXZIfcieicOBv8avdPsqm1NfxZ6kxaQ8+qktnBVVjI1PqZT5BnXKE+60jbA5/q9G4F+xmQcz9M76wWigFrPjdqR66y5tj7VQSLgU+9ZgEPJLsG/W7kRwu+1K29AFXRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XL0T/xV/; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ERbO4eiX; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482AqM61002876;
	Mon, 2 Sep 2024 04:09:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=CJBlChoTJ2PUiU6NULQuXWht8p4fxDkKlSMwGynbCck=; b=XL0T/xV/98aY
	NhRjlB41KX5a+2jwbdOSULLvacz4XrX99fYyNwTpMhb7q0gLG/a7I/EVBXlcmiaK
	RsOLNMNcKcUV3KuC3EvynjOCbomYHQUbM/bPbw6fDg8VNNb+qvDMP6rr8MaG0jpp
	nF71jaB3BRgBMq/NHD6TVyrd97q39hnmg1O6Ey8Sx6/nYz9Xd1nEWXK0Qae4UFPP
	DfOfrSdod3NEYvoR64k0PeXGmT9hQd1jENa9CnuXuvBg549BU/4tAi1nWTQp5G15
	dXiVsk3HDHrgBuSjTc9xD9KnBwe3PiSroJ2/ZsU2jhqOoiPXzkT54Sv5sVgd6dqm
	/jmw7j6bZA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 41bxrv4r18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 04:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1133TNz9oR+lmO+tO1CXpTpdnoAI0KWsyFGDh9zZlofy1yciJgkJe5edPZjl8YpPH5HRJFOaWseGuD+O6GGU8ojNt7cNNSbj9TGA22Ca4xTUaz7Y4uzv/gcB1ZZeKdhCH1qjGcL7fd+J30YN7m0gzy8P+N0J8fwsGPz0dI9OxJYc2Hlz1K3BThVRsU42gniJrwx7pAv/MMA0ioHAUL6YHV8VxD4dt89hDdWpfB4nLMM4ng09Wg0RVStsmPoZGoSJceOSbTKzqeAKo83oCLENJ4ZDAMOwgYn9Kd4LIGK03kopQ1D6Dw0pL7eOh8Pu/x3wJm7iDyIcyGZFfvh7wsQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJBlChoTJ2PUiU6NULQuXWht8p4fxDkKlSMwGynbCck=;
 b=QvsOwWkuTlEny4ZldTrPAYsfkLJYMWtMK8jHmiJ3Zlo116NELLzks/IBF5yVnNQ2tUwmmLdw6noSwiLwHnxKGswuhm0DZ9UrLWe8RCeNNBuJnIsXG6143a17AxAzXXpMwlc6xNiy9kMYRMTpJoJnIokykWIditywzYqVJFHwH8lo5hHDdvIn1roZtpDIBkpuQ4nB0QK5rdwyQ/WzijeWtmXLNKlurABst2zjhLcBjF0OgMU9YM8RYD6fcJZpKHhzElzqORPkpq4Dz8QCHH28cbxiECQotEG0K0N0uv8rBStJWTPB4xLsix5Nrdz9sirC8+khqEr84Bq/FeWW2sSgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJBlChoTJ2PUiU6NULQuXWht8p4fxDkKlSMwGynbCck=;
 b=ERbO4eiXFbl+byXPLimYMghpcRZwh6eoZAZCtiTrG6AHtodvsQDrllB7kRfLRDSqugHYenJTvo3PAGxioHweDLFYO4XFaOkjyRgIN0aGSL46jTEXmLskm+I8UW+3JS650sXA85G1nUrBnF04ubJ7HhU+YVcN/FN1mi41bSftZWQ=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BL4PR07MB10452.namprd07.prod.outlook.com (2603:10b6:208:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 2 Sep
 2024 11:09:17 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 11:09:16 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdns2: Fix controller reset issue
Thread-Topic: [PATCH] usb: cdns2: Fix controller reset issue
Thread-Index: AQHa/Sf9GoZsP2bLJ0yREBk1yvkY8rJEVeVA
Date: Mon, 2 Sep 2024 11:09:16 +0000
Message-ID:
 <PH7PR07MB9538D56D75F1F399D0BB96F0DD922@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240902110422.157569-1-pawell@cadence.com>
In-Reply-To: <20240902110422.157569-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWM5ODQ3OGRkLTY5MWItMTFlZi1hOGI0LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxjOTg0NzhkZi02OTFiLTExZWYtYThiNC02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjQ4NDAiIHQ9IjEzMzY5NzQ4OTU0Nzg0NzIyMCIgaD0iSGRsc2FTWUNjbXo5azZTQktqUHNDT1o3WlVjPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BL4PR07MB10452:EE_
x-ms-office365-filtering-correlation-id: 1a577e9d-7b58-4b73-1397-08dccb3faf5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c20wdUpqTXhCeTRQOWhKT1o5SHU4clFzcURLdUpjWjhORGlmbXQrS3UzYmFG?=
 =?utf-8?B?M0lPbmdlU29EQWhmM3JwYmZIUW4xS3dLZy9Tcjdmd01mOGlIOThiZ2VLQWVw?=
 =?utf-8?B?b0pDSWRtYlM5YzlBc2NZZHZDZEZHb3Q2UW4zTURKT3hjejBhaGgxbTZxZ01H?=
 =?utf-8?B?b0t4dE02RVdRYk5JNGZ3Tnd3RS9STTg1VUVjc0hmd3RrSVdzWTRvanZrVk9k?=
 =?utf-8?B?M2cvQ0NNZlVLZEZwb2pZWWlzREFMT0h4REhkYnVNR2dJODQvQXJsQmpwNDUy?=
 =?utf-8?B?cHNFUmJTeXRRWUk3UjhHS1llc05lTnJVNmVEQnlIdHFXaTE4VW9WRjZyeDIr?=
 =?utf-8?B?V0VYcUUyR0t2SXhSNTUzSnd0YlhzZ3FzczlrdXVpL0NWMHZDaTc2SWFuazB1?=
 =?utf-8?B?bTM5YmMzU3BLWlJ2bm9qdWJDLzFzaDd6bFlBd0V2YWpPaVZIdGVuNk12bWM4?=
 =?utf-8?B?WWx4R3RXMW93ZUNQbi95cDhSVzJNRzNreTB3ZEk0V1JWdlQ1MEgvVktxQWsr?=
 =?utf-8?B?aEk2blQ2emc3M0VLcGRFUXQzNjE5eS9KN0l6eGFHV0RUV2RyZXVva3h3MkJu?=
 =?utf-8?B?UHRHMnZ0LzNNOHp1VDJIR0wrL3pHdFhoWkRXNDY0cktVNUlPRWxhNFJ6QjFk?=
 =?utf-8?B?MnRkR3RDZnNjaGFmNStTQkIwcUJCYzZ2ZUg5Y3IvMXc5b2MrSTU5K1BDZkd4?=
 =?utf-8?B?OS9xTXdKcFdET05MM3pBTm9oNFNSTWcweDBrYjRyV2hRckZYQytQcVFid0g5?=
 =?utf-8?B?S2lsaGdjZVFiYXlERG5RTWJZWmVqOWwzTUorTHRINllZUU05VjRUaW53Uk1X?=
 =?utf-8?B?U20wT0VMbWNYMjVWSXEwUERFRTdqdTk1amlkbXBGRXJnWDJnNmxvcHdRSWZq?=
 =?utf-8?B?TVh0a2I1Z3lGM3R4R2JjTE05RWdkbkRjblZRL3FVd0hmeHNsbFFnUjYzVHZ0?=
 =?utf-8?B?bTlhTk1WRGJzNlZ2MXRhd3dFNzh4VHJFd3JzVnZnTjRRcVQ5emR4MVlTdXdN?=
 =?utf-8?B?cTdLVmNNalhLWHRvdXBQSm5SUVkwQTFQU3g1Vkk4RzA1ajZzb0tiTkxRanpW?=
 =?utf-8?B?K1Q3bTBYT1FBb3k0WHY4QTNPcEJtM0NqT29UemJqYXFuTjdUSTNtMDA4K2li?=
 =?utf-8?B?RnBPeCsvaGxwMjJtUFdlYUgzaEJ0RFhuS0tHMUc0dU84ZEJELy9temtyS0do?=
 =?utf-8?B?US94OWljM1ZkdlBVa2Y5WlBVRlNWTThZZFBCZzRkUy83bDNBcFp6V0xtdHlB?=
 =?utf-8?B?M09zM1pxUTRpM204cjlVRXFQNDJ4OFVkYzg0OVFkL0xNMEJ1czVLb2o3RlRM?=
 =?utf-8?B?bkZwWXBvRjVCVzg3Sy9jR1pGL1hVVEgyOXI3UmM1TEVZeVNYODVjQ3lKTjlO?=
 =?utf-8?B?QU0zbE5vOHVpWTY1eC9sVTdMWWVSUnBGTUZ5T1IrSWtaMEtFK01COXJRdXd5?=
 =?utf-8?B?WGdmeGVZTWZDQkhmeXJqTXhwQ2t4UWFzVFBCaGJQU3ZoWFlsYnNCSmdhUUxj?=
 =?utf-8?B?SXZ0QUxFQUVvNDAvKzhEVk43dkNnQjh0dTJybW9jampmREZlczdXaGdwd2lE?=
 =?utf-8?B?U2YrdThFY0FKZnpzTzZ5RjhlaS9JRTh5MFAyd2JsQmlFZDUyZ24rOGhZaG9S?=
 =?utf-8?B?blF1bGozZzROeXd5N3RNa3ZnbUVWeWNOV0JLNTBKQldFK3loV1JJdHo0VnRs?=
 =?utf-8?B?MVFjRlBzTGYrdUZmaEo0OFROQjVtY0VYY3BVbEV2MlVEOVBUS0UrejcrNjE5?=
 =?utf-8?B?NXI2V0lJT0t3dll2cTc2TElXWHF3WFN1enk2RTNIMjRJdURUQ3ZBSDhvY1Fj?=
 =?utf-8?B?bHd5UWJaR2JXcVMzWWFmcEhNWWdqaTZBc0VJMWtzTjRDYjRwdzJ1TldkYVlz?=
 =?utf-8?B?Q0M3Sk9PUkFzUFlTZURmQzBoVHM5L2hCL1VYVXdPcUxpdHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGJ2YWZQcDVZVDBhUWJPTE1KdWpBLzdYNjJ5dTU4YmZuMk5Za21VS1RyN2sr?=
 =?utf-8?B?MngyUWNpTDdWRXNwVFlrWGhoRDYvbnM2anVxVUdaQU1tdlpKdmRVbDlJM09I?=
 =?utf-8?B?OFBOd2EwMTFlODVkeER6YkgvdVcxVlpQUnRsS1NEOU8rRndXT1BianE0TUdD?=
 =?utf-8?B?Z2JkeWQ0Z1JyUlU2VWpFa0Z0RUozOGVjYlU3SCtoSGRzcWJhOTF0NWZKcEZS?=
 =?utf-8?B?bWlPVkVMMWhNem9yS3VhRWtzN29ubEVOaW1CTkhXcmU4Q0lHZ0IzOS9NOGdV?=
 =?utf-8?B?UURweDJPM1ZkcDFWTExacDVoUUNhd3cvSm02U2F1WDl6WnBtY3dDcDZ0RHdu?=
 =?utf-8?B?RHNXMDJRcnZ4bkNsalRlTjk4cDlUMGtWZUJ2UHB4SkQxOGIyTFY2TkJxVzZB?=
 =?utf-8?B?VHhVL3NGa1VkT2F1N3htaFFEQk02ZEVibzlEQU9ML1QrcEJocVVUa1ZsSVZu?=
 =?utf-8?B?bDlkVDBJR2xOOG5wdGo2YW0yS3FBUXRDRHV6aFVsVVA1WWE4dTJWT0NDNzhV?=
 =?utf-8?B?d3JpZ3IwTkhiV0hxYUVXUUk5REI2MXJJMUczRE91V2FwcFNNcEJkUC8wU3Ez?=
 =?utf-8?B?TTRXenBSOXRXdHhqRktYalZ4LzFnVVovY0xmWWQ3THE0eS92bXV5YXhnOHlw?=
 =?utf-8?B?Z09NbDcxTThiV2VqOGYxUjZJSUJNK0p0TThkeFYzeDRMbTNNK2FlVkN5SUhS?=
 =?utf-8?B?aDlvNVdIREZaRUFldDZZdVl2RkVUclJRaGNDUTk3bklNMU5HK2JsUzNzRHFs?=
 =?utf-8?B?MTBva24wR0hFUFlsTmY4QW83OHBKVUJJbFNXVFRjUzRRclhxYmdDZTlFbTQ5?=
 =?utf-8?B?Z1FhbTZLYjFRelBFQlNSWVR3UjZsSVdROHVYK01KYi9YbzVJc0ZBWW9IUkp1?=
 =?utf-8?B?MFVhUGxveDBobWduekxQUnJXaGF2ZzZUT3Y5TDQyTGQ1Y3NENVVXN09vUGVk?=
 =?utf-8?B?MnhuWkI5eFlHSHhXWXNwUFlvY0hLdk8ydnk4YWdtV052azlEODI3N045d09z?=
 =?utf-8?B?MG9XMUxtM1k1a1VrMktiZkUvckZaeXk0ZFBlSkNCTkhuTUJpb29ScU5GU1N4?=
 =?utf-8?B?UVM5U1BuaDV0S3lQajZucDZhQkVBTmlvV1F2Ly9nOHMraHBlMEczeXdXeUNN?=
 =?utf-8?B?bUNGbG1WdGNzNE9reXpJVHA4ZmNISkFFOTU1RUpPSXBFOUxwQ1hCbFFDeEVD?=
 =?utf-8?B?TnNlZzlFNTg4MTRIeEdidDdFYm82WHNLdy9US2ltaWZrQWU5RWNKS0p5dXpk?=
 =?utf-8?B?amZWdzFXRjk2NlRTb3BuUXF2TUgrV3FobWJBWXVKM1dIS2ZWZjJUTmVCaVZv?=
 =?utf-8?B?Y0ZrWnBiOGM2dFhWRC94V0dFajhSNTVWVVZ4OFVlT3dMTFMrblczR2lzWGhj?=
 =?utf-8?B?QlhRM0J5bFVsT2F2cXpuZnFWZGxkN21mNzBGQjluNU5FdFQzZW1OOTFZZDN1?=
 =?utf-8?B?M0IzZ1I2WW90SGNRUmp6WUwyNEdHbUM3UlRaVlhmQy92MFNxR1VYKzdMM1E5?=
 =?utf-8?B?Y0NXVnBteWs2S2xmV3NnNjlwSFRqY1pjdzJkMkEzb1ZYaEtCa1dIbzAyTjJ2?=
 =?utf-8?B?QkpVRHRnY2VRY3hKcEZSU2JQU1lIc2w2RTFwOG55ck9ISHB4K1lTdnZJUDd3?=
 =?utf-8?B?Z2VkSGg4OU5CRktpY09rakx0bVduNjhRRVYrS041ODRyMU82UEZSUnNUSFpy?=
 =?utf-8?B?dm92NXNiWFp3VHZ2bmVHbTlna0l5WldPclU0eVJOR2c3UWhzaTZWdW50MThu?=
 =?utf-8?B?Wnh5VDJaSThBZHF4UDdBZTFMeUZmYkdCa0RzU2lTZ3crd3QwaFBEOFg2OGlU?=
 =?utf-8?B?dE1TUWVjUFpvZTJFakQ0TXU1V2xDb0R3RVZIRlg2dGNyWnZHaHhZR2FSR3Nu?=
 =?utf-8?B?SFlrMTNGckNFS1EwOU85RGxTd1pvenBvMy9QUGlNd1dEek9BejBlZklPVEcy?=
 =?utf-8?B?cXdtUmJacjJoSHVzOXJKQy9YZ3RJMGNjZmVWQ3d5MEJoTzVMOERYMXNIR0gw?=
 =?utf-8?B?Zndva0lIalhBbERCRDdEZlk2SnNJNHRGYUhzVEZobGZhZDJSeHhlL3R3MVN5?=
 =?utf-8?B?Q1pFb3B4L2JISE5hWVc0eDdCaG1vdk5xVnM0UlhwQ0I1a3F0ZGFZWVVkRG5V?=
 =?utf-8?Q?ImySWu5u+kEJqe2g0wI8snhzg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a577e9d-7b58-4b73-1397-08dccb3faf5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 11:09:16.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25peatHR878TT45zZ5ZVifECbKW3aow3JOAVkP9l3e4HXSHKfZCVltQWGk5rl+aOZwetgoCzCL/3Qzs3gxvqIZv/rT2m2mdUelD7JYvlrFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR07MB10452
X-Proofpoint-ORIG-GUID: HPgo6-44D6NLfut-tcb6I6yukxAt5OWU
X-Proofpoint-GUID: HPgo6-44D6NLfut-tcb6I6yukxAt5OWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=406 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409020090

UGF0Y2ggZml4ZXMgdGhlIHByb2NlZHVyZSBvZiByZXNldHRpbmcgY29udHJvbGxlci4NClRoZSBD
UFVDVFJMIHJlZ2lzdGVyIGlzIHdyaXRlIG9ubHkgYW5kIHJlYWRpbmcgcmV0dXJucyAwLg0KV2Fp
dGluZyBmb3IgcmVzZXQgdG8gY29tcGxpdGUgaXMgaW5jb3JyZWN0Lg0KDQpGaXhlczogM2ViMWYx
ZWZlMjA0ICgidXNiOiBjZG5zMjogQWRkIG1haW4gcGFydCBvZiBDYWRlbmNlIFVTQkhTIGRyaXZl
ciIpDQpjYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBQYXdlbCBM
YXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9jZG5zMi9jZG5zMi1nYWRnZXQuYyB8IDEyICsrKy0tLS0tLS0tLQ0KIGRyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvY2RuczIvY2RuczItZ2FkZ2V0LmggfCAgOSArKysrKysrKysNCiAyIGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL2NkbnMyLWdhZGdldC5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9jZG5zMi9jZG5zMi1nYWRnZXQuYw0KaW5kZXggMGVlZDBlMDM4NDJjLi5kMzk0
YWZmYjcwNzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL2NkbnMy
LWdhZGdldC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL2NkbnMyLWdhZGdl
dC5jDQpAQCAtMjI1MSw3ICsyMjUxLDYgQEAgc3RhdGljIGludCBjZG5zMl9nYWRnZXRfc3RhcnQo
c3RydWN0IGNkbnMyX2RldmljZSAqcGRldikNCiB7DQogCXUzMiBtYXhfc3BlZWQ7DQogCXZvaWQg
KmJ1ZjsNCi0JaW50IHZhbDsNCiAJaW50IHJldDsNCiANCiAJcGRldi0+dXNiX3JlZ3MgPSBwZGV2
LT5yZWdzOw0KQEAgLTIyNjEsMTQgKzIyNjAsOSBAQCBzdGF0aWMgaW50IGNkbnMyX2dhZGdldF9z
dGFydChzdHJ1Y3QgY2RuczJfZGV2aWNlICpwZGV2KQ0KIAlwZGV2LT5hZG1hX3JlZ3MgPSBwZGV2
LT5yZWdzICsgQ0ROUzJfQURNQV9SRUdTX09GRlNFVDsNCiANCiAJLyogUmVzZXQgY29udHJvbGxl
ci4gKi8NCi0Jc2V0X3JlZ19iaXRfOCgmcGRldi0+dXNiX3JlZ3MtPmNwdWN0cmwsIENQVUNUUkxf
U1dfUlNUKTsNCi0NCi0JcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygmcGRldi0+dXNi
X3JlZ3MtPmNwdWN0cmwsIHZhbCwNCi0JCQkJCSEodmFsICYgQ1BVQ1RSTF9TV19SU1QpLCAxLCAx
MDAwMCk7DQotCWlmIChyZXQpIHsNCi0JCWRldl9lcnIocGRldi0+ZGV2LCAiRXJyb3I6IHJlc2V0
IGNvbnRyb2xsZXIgdGltZW91dFxuIik7DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0JfQ0KKwl3cml0
ZWIoQ1BVQ1RSTF9TV19SU1QgfCBDUFVDVFJMX1VQQ0xLIHwgQ1BVQ1RSTF9XVUVOLA0KKwkgICAg
ICAgJnBkZXYtPnVzYl9yZWdzLT5jcHVjdHJsKTsNCisJdXNsZWVwX3JhbmdlKDUsIDEwKTsNCiAN
CiAJdXNiX2luaXRpYWxpemVfZ2FkZ2V0KHBkZXYtPmRldiwgJnBkZXYtPmdhZGdldCwgTlVMTCk7
DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9jZG5zMi1nYWRn
ZXQuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY2RuczIvY2RuczItZ2FkZ2V0LmgNCmluZGV4
IDcxZTJmNjJkNjUzYS4uYjVkNWVjMTJlOTg2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9jZG5zMi9jZG5zMi1nYWRnZXQuaA0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9jZG5zMi9jZG5zMi1nYWRnZXQuaA0KQEAgLTI5Miw4ICsyOTIsMTcgQEAgc3RydWN0IGNkbnMy
X3VzYl9yZWdzIHsNCiAjZGVmaW5lIFNQRUVEQ1RSTF9IU0RJU0FCTEUJQklUKDcpDQogDQogLyog
Q1BVQ1RSTC0gYml0bWFza3MuICovDQorLyogVVAgY2xvY2sgZW5hYmxlICovDQorI2RlZmluZSBD
UFVDVFJMX1VQQ0xLCQlCSVQoMCkNCiAvKiBDb250cm9sbGVyIHJlc2V0IGJpdC4gKi8NCiAjZGVm
aW5lIENQVUNUUkxfU1dfUlNUCQlCSVQoMSkNCisvKioNCisgKiBJZiB0aGUgd3VlbiBiaXQgaXMg
4oCYMeKAmSwgdGhlIHVwY2xrZW4gaXMgYXV0b21hdGljYWxseSBzZXQgdG8g4oCYMeKAmSBhZnRl
cg0KKyAqIGRldGVjdGluZyByaXNpbmcgZWRnZSBvZiB3dWludGVyZXEgaW50ZXJydXB0LiBJZiB0
aGUgd3VlbiBiaXQgaXMg4oCYMOKAmSwNCisgKiB0aGUgd3VpbnRlcmVxIGludGVycnVwdCBpcyBp
Z25vcmVkLg0KKyAqLw0KKyNkZWZpbmUgQ1BVQ1RSTF9XVUVOCQlCSVQoNykNCisNCiANCiAvKioN
CiAgKiBzdHJ1Y3QgY2RuczJfYWRtYV9yZWdzIC0gQURNQSBjb250cm9sbGVyIHJlZ2lzdGVycy4N
Ci0tIA0KMi40My4wDQoNCg==

