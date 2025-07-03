Return-Path: <stable+bounces-159275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF59AF684A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 04:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF847A4F12
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71611CA9;
	Thu,  3 Jul 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C0CvyKWt"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0392DE6F1;
	Thu,  3 Jul 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751510968; cv=fail; b=fgV23NQpfuAiJe+OiTQwI/NtinS2U3RVymIJNMlMgfuRli2S3cEXoqpN6/8gSx6TDsryPJ3lTpQC2vNbmsZWKun7KB+/bmvx2Rq+lQNkKvLfB6B1Ds20GrX76t7a5W+d9xDaFSJXdRuDFA8kbluv2tRAGTdUrjyq3PgcbZCDcUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751510968; c=relaxed/simple;
	bh=s0PCZ0wpBE6W8fu3oYqWw1p9hRSLx+tB5eRYSPWKzw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FewM71CwuCZcb+kXN9tyKtCiMbU7qggeOo6kIE0plZbJ/QeV1sP0JDrZ4E0hEG8ui+E5E8S+mVXk10Yf/5c0W4sSVhG1V8L/HZwLQSPOMEa4fmLok+YnhBMQIRhG78GMtfBq2nQ2J3gYLY24C6E3CnqUPxW1UOqGH2+f8ezuhJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C0CvyKWt; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPqkINblgqYkDDVJU8vYmIeeurYcktWheVeSAwxm8WBE+hX1ncC+MKpN56Fj+GEXc+w+2m9DxlyqRJJMgr2x4q2PMhPOWq8ogoWIsCNOLOAnec+EhGgGO0PhqeBSCP3ehDz3Xm8yuVOhCUeC0UcXL9pKoUjEd9xVnt0m01tKY2lqkshamxgdOdYyHXXHOPof2c+P7lxCzvBIFd5ixJPuo85YM9fUhrOeaKYZ08oPVOgYl7cWxqfEp/jeWGxQIvVc4YT8iR2bXtytBE3NxNaclDMnETydSvM4u0hfzGgMUAveckqWdX1ihYZmzTxkr6wiKFq8wtR/GBT3UJ1OYERyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0PCZ0wpBE6W8fu3oYqWw1p9hRSLx+tB5eRYSPWKzw0=;
 b=ZYVrNegUJdzCDAp0DrGcwH5EX+6fq/C7InbAjLaEzhbmxFHfF+fLCkgiDiKDZ3CHTn6aEwvVL+NNxoXN97Dd3qmZ4T+7HjnxIhiIsn+bCB3UTg5V2u14Anr3Y3ApeVWGet/z5s3gt3KE71eVS7uY6sqrJ8muJEnpAsPr9+yFf5tsVvQtkemgdtM7eLIdtaNjKPR1prqVBncWRw8PAD5tpH4GiNN+K810CSaA/geHh9ulgrA7PZYqRyOZKBfgLBDuvaxx+jSp+YV0NpTSypha2IBenrFnakd/6SFPCboXDWtLBvsYne6jRdciZIrJzWx/ZlQML4ruAM5AWsCs20SDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0PCZ0wpBE6W8fu3oYqWw1p9hRSLx+tB5eRYSPWKzw0=;
 b=C0CvyKWt2BmqTGs+0HehIC9/ZAQ3e5mxBoCSgNgOI42QJbM0dUHTT2Ab73nsvlz1p/S5dkqooDvZlfz8NuUZC6YSpfc/tudDHrbFigt4MOqGs+h/MViRR4q4q5Rm4rbZ31f8f1VkJOcPB8mkYoH8YSDHc0yrbUErzuT31GRIRoSG8UPjlDnLu3zmFwwR6Jq/QXatHKhprDnMTAYmAOf7ldy1LqeU9IMbjUFaF47LpsogXJicA102PvWDsQK/GKHeuF7C9KOYNOriEsQo+8iXbjb5MANCBysyOjT7Ya77SFmXZ3CowNEqeAWYlZ6WWJXt0kzZHjV4wDMN0IP1Zexgnw==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 02:49:23 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 02:49:23 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <fourier.thomas@gmail.com>
CC: <stable@vger.kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<u.kleine-koenig@baylibre.com>, <ada@thorsis.com>, <bbrezillon@kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error() address
Thread-Topic: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error() address
Thread-Index: AQHb6x3oA8V75rnekEWEk7l9JpUSgrQfs+wA
Date: Thu, 3 Jul 2025 02:49:23 +0000
Message-ID: <e5e8262a-db33-4abd-b31d-fc476dfab0bf@microchip.com>
References: <20250702064515.18145-2-fourier.thomas@gmail.com>
In-Reply-To: <20250702064515.18145-2-fourier.thomas@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|SA2PR11MB5177:EE_
x-ms-office365-filtering-correlation-id: 80f008f9-feab-4a7b-3cd6-08ddb9dc37c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0ovWjFFWlRIdHhsRHhXZSs3SnpnZ2VyUWNVTlNTc1NNTDdneGU3MEZCRkl6?=
 =?utf-8?B?YjZGZnJaVUFvTmFtNERkK2IyYzArRHpxMGg3N2ZpbVZDUGJaWG5uU29LSjdr?=
 =?utf-8?B?Q282VStZR1YvbitUam9SYTlFckJDSXlmdjR2R2liNlRoVVJXYTNKOTlhQ1Y4?=
 =?utf-8?B?ZUhwckI2TlpnVmhoYUtzcm9rK3lQbkVPK1V5S3hxdSs0UlMvUHdzWDg3M1c0?=
 =?utf-8?B?czFRTzY1TmJuUnVoYWtVWXhQSUM1dmk4RUxSSEVYN29RY2pzMCtqQVliZ3dz?=
 =?utf-8?B?QlNkUmVIbE4wS0lvRkNQUmlVeGd1S1U1VEEvaEFHekUzZkpEMk5rbWtobTlE?=
 =?utf-8?B?bUNNRDJickhRUXVOQ2FwVjNYOHo4bjhOQUZaNzlTMlVwQVNjTk1wMkkzQnRo?=
 =?utf-8?B?WU0yV0pBcWV0dWRFMUV3WU8rM09jM3oxZDRQaWl4MHJmTVEzd3BjQndmVWxs?=
 =?utf-8?B?d2d6LytEcHh1cnhVTmI2YS9IVjZzY2FrWTYzM0h1eE9iQ0JaRHlabG40M0hB?=
 =?utf-8?B?Mlc0M09OQzNVWFBJQzh2eVg4YTJGQ0JRT3JuYWNYSmx1aUlLakFRa3gzSTEy?=
 =?utf-8?B?NzB2NUMwRWVabnp3OVZIamdQbDJtdVRDWkwxMjlzZHVDUFBFZWpmNWJYK3BO?=
 =?utf-8?B?YUIzYVNTRGhSa1JBM3ZEM1BXSW5ERnVEOUhqRkxwMXphaVpxTDZkZmpscEQ5?=
 =?utf-8?B?Rm9BdDVuZGJTSTRXZ1VGbDdFUCs3UEJLZk95TktXTU1hcnZBUzQyOTZBWERo?=
 =?utf-8?B?Rktlb2pKcHJhWGI0STN5cldqaHFoTzRRY1RIbjRkWkFBNFBGVmJjcGdTdElS?=
 =?utf-8?B?M2E5czUrRnhCSWxxSWFLQzRwa2hjZlBRMG1HMDBVWjBJK2M0UGpZUEEvZ2tN?=
 =?utf-8?B?LzNFTFFwcEI2SVdzdnpEem52TlFCUzFNSW1tSnJJejh2ZS90d2FrT0t6dTVF?=
 =?utf-8?B?ME1UZk9WM2VjZlQwQUxlWFd3MktiaDdtSHZ0bWFqTUp2VXhmeTlFQ1BmYnN1?=
 =?utf-8?B?cUtoVVRFRngvZFdZbmVqWDVFVU1rSWRBMmJWM243bzJ2Uy8rVVNmU1pzUE1i?=
 =?utf-8?B?V1RTMHNxbUp3bnpVWFNsNHpXZjNFL1NGQVZ6YjRHL083eWM5WTl6dklrUkQw?=
 =?utf-8?B?czV4cVNBazNPRWtDbXQyWXJSckZYTWZaeXRUMjNFLzZmSFRUTS90ZVZzTTlC?=
 =?utf-8?B?RVl5RFE2RmRPNkRma1NrMEtFV0phY0l5V21mNUx6a011UEgzZE55VnJjbWFT?=
 =?utf-8?B?d1FUcm5FZTZ2b1dBUWZyUVMyUDZFNmkxcXZ6OFdEVnhOZ0NTczFCWmc2Ujh3?=
 =?utf-8?B?TUl3SzBET1BRcFVkYzRKcmtnbmJYSVIwVVQ0ZHVWbUJMYlh6bk8xTHg4cXBt?=
 =?utf-8?B?NkovU3ZPQlYvYUNWMW5tNUYzQWloa3RBRkFBZWF6S1NZeXhqMGp1UCtFQXJz?=
 =?utf-8?B?SVNmM05nMG9GZVJWM1hXY2tLTFFoN1pwbWNNUng2eWVJRzhzYnRoSDg0THVN?=
 =?utf-8?B?NFZtdXhTNldLb2tDRVNQTDNlRTkrbnRFbGppVXg2cCtsZHdWQjhBTjdMNWtQ?=
 =?utf-8?B?aFRqWmJXcSsxOWx1VDZqYnIzVWM0T0hYQ2hzL1dJeDZzVElHZG9NeUFwQlc2?=
 =?utf-8?B?SnVQZmEzZTJDMC9SRmZGdlBEajM5Uy9sVGk1V1B6NFd0a0loZ2VmanBCMElt?=
 =?utf-8?B?cDVQdVBNUWl0dm8xRzdzUmFEY2VFSkJrWis2MDBOdXF1L0Y1b2RyU1pMQmt2?=
 =?utf-8?B?K2Y4OXlUK1F6ODA4YVZRR2hidVJUOXZyOUdQVkYxQkdTdVlkSG93Q2RXcEFr?=
 =?utf-8?B?dDRLcGRvTHE0RlN4My9RdHVKTFRuQXJKNWE0NHhYZkJyYXhuNm9kQjBSQTlL?=
 =?utf-8?B?TEYvSjkxQlFGRVBGd09MbHU1eXo2Z1BpUlkvT1J1YjNGNllybWdFZzZaYnJn?=
 =?utf-8?B?UTRJZk9yQU1DU25FWDBWQmVRcUk0S3hFUTFVaUNXa0tPV2VUUzhOTkhpUURi?=
 =?utf-8?Q?O8cic8t17mHu0XCLdmUBLz5Aw0o6iQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmF3VmtBMHFNRzRVbkd4a3VjUW1oVlpubDFyM3JBYU52dmVzcmlreVhwdkRR?=
 =?utf-8?B?UElBcFROSnJqSEcvekRCVXpXM3ZudGNaWUlGdEVjVUFscjJlQ1NnaDRWS05P?=
 =?utf-8?B?djRYWTY3ZTJ4cUxKYlYrQUFQS2dUYmE3bXVJNUVsTWFsUE03b2tsNzFIaVE1?=
 =?utf-8?B?cFdaVFB0S3JidVV4Z1c5OWxTejdFd2dsQU1acTFVV0w2NDhHeGllWTlRUDFa?=
 =?utf-8?B?V3RKQTQrU3RMTzJ0a1gyYXFmci9PYm84dmdvdVhLZ2VNR3Z0UDJad3RkdTY1?=
 =?utf-8?B?MjJ4N2NpMllYNUFhV2VtdURXNzVDTEF1dVFSNGpRS0wzVEw4TTN6VVFtSysx?=
 =?utf-8?B?YzBZV2hOUmFJNVF5cFIraW1VUGFoMmhyS015RVZlaUFobE9LZXZEZHZpSlAw?=
 =?utf-8?B?TTcxYzB4UHg1WVBLUnd6T2hGdVB1ZTZIZzNoRndCN3hrUklNaTR0d3htaHJS?=
 =?utf-8?B?L0V0SGVidTBDZXhPN3NObjNSNUVzNUkzbzZXakYwWExOWUYwa3ArK1JaK01B?=
 =?utf-8?B?RUt4VmFLYU9ZKzRSS0h0N2hKME5MbWxTbzdDUG9NQnpLeTdlNm5hZXFCL0Zz?=
 =?utf-8?B?c3NNbXNYZXBhbmNTdjlKM0JyQXRTK09HMDdkbUcwQStmUStmaEFxdE0rOHVa?=
 =?utf-8?B?VGR0dmxtbFVJRjNYWnlXejBCOFprS1VpQ3A3RjlLeTRkdmpJZkd0NnZSS2hp?=
 =?utf-8?B?VWZvNXRtSE4zUzhOMlRHVUNGaitWM0t0MzNRQitKc0hBc0hZS1VyV0MvSUhL?=
 =?utf-8?B?L0pXNmU1R3pObDl6U0VXcDdxWWRySndRaThDQWFMODQ3Zjljd1pnazd6SnFp?=
 =?utf-8?B?a1IvQUlNSnkydkNtK1VkWDkyaHZsU1BubUZlTjFQSC9jekovdTk0SlFlbmh0?=
 =?utf-8?B?WmRwc25hV1NGb1lCQUlPclYrS0N6N1gzZWRFa1dEVTB1TG0ycXJoU0t3dTB5?=
 =?utf-8?B?V3JVbWhNZ3Bja3gyU0xncm0rdHpOVTdpbTNHYU04NVBTQWJUNmhmSFhacVA3?=
 =?utf-8?B?OHFhb1JKNW5paUo4K1YvaUd6VXo0ZWlUanArdTZWaWNrM0ZBS0gwUjd5elpk?=
 =?utf-8?B?U1pXRTdHVGpuT1M2cis1cHo3dTIxdWRDNUk3cW83b3hRblNVYXJleXoyVTdq?=
 =?utf-8?B?Y2dWNWk0OE1Yd1drMHZEUW9qK2pTdUVBQW00Z2FadlJuTjUydCtBVzh3V2Vk?=
 =?utf-8?B?V2NnMG5EMWxaaFY3TE5xelpDamM0TU1jMFg2MkV3SmRGcEtLZ3o2R2N0dkVI?=
 =?utf-8?B?SFI2MU1tTzRIeVpRQmRJcmdYcldCQkwwYmFnOVRMSjFQdzIyTWRnMExXaHZB?=
 =?utf-8?B?OVRpSWxFakw4MTljRVpWU3YxQ0tEOHR6T0tSbldiOHlEY2hqRitqTkN6L1gw?=
 =?utf-8?B?cXIwT1BWcnluaHR5ajBwc09GTkxzNmtSQXcybVVFenNCSW5Oc3BlcVhmNVho?=
 =?utf-8?B?dU05dzRyL3ZZWUUyYkw3NlZEdERYM05GR1B0ZWlRWFdmdTRhMVAraElpNVll?=
 =?utf-8?B?akxWSmplQzJmQStWZ1I5VUlHaktJN2Z3V0ZtSHdzTFpxSjZZQmg2SkJLQ0t1?=
 =?utf-8?B?TmREVTJZcmdIbGJhZnBCSTRxcngyOGpVbFNrbmpyMmdEb1JtdTNuTEdGalA0?=
 =?utf-8?B?SkNCNXFEaHEvNEF6bjY0aTZFOElVRUZVSW1tbm15TjRhOTYwSFkvbE1VTmVZ?=
 =?utf-8?B?QnczTnVWS3BPQnBqcGFvRDZLUmxucWN0WWk1TjBMYjZ0YmlvT2J3Wm16dkFl?=
 =?utf-8?B?M1A2cmdPZVg2cFV1cHFRSzJoa2cyMUlkcUdGY0xURzJKcWFQYTMzTDQrWC9F?=
 =?utf-8?B?VXROQ1pjOW1reUhWT1h0ckI5TDU2am9HSXpVdlQxdkcwUllTTE14UkhUR043?=
 =?utf-8?B?cG1PY013YTRSV1E5SUJ2anUxSDEyYk5kbE02ZmF3L0hZZFpvbW9KSG83aysz?=
 =?utf-8?B?OXBEaXJ5WkFPdGJHWUdQOFNLL1JlYXduV0JENzNhSm0vL1ZDWHhqcEFDMHJp?=
 =?utf-8?B?bWNlRXp1bzdBSk82NUEyQUxoRGI3L3FuL25sc3NaNk8xOGFFZFphUXVjWFVR?=
 =?utf-8?B?SGc5eDlBN01IMDhpSkdOY3U0TkFWZHdQa0ZFNU41aUxTWUx2cHozL0Nxb21H?=
 =?utf-8?B?Q2twOFlicGE1WGUxRnd3UDFzVmpuZlZ3emVHb3dxdTFOKzM3QjhpQ2RMOERI?=
 =?utf-8?Q?ihVNeNPdVMYNwwjckh5lc1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E70739EACA3FF647987019A5027E1CF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f008f9-feab-4a7b-3cd6-08ddb9dc37c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 02:49:23.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmaJ7HzxqNUZn9U+H8UuktNx7t9K1dFJc2FrItCa7mx5wofbitj6/JF0ip+/beYqbRxtAWLDEy8zImT6RSPkU13R77LaCLWJeEEpT/+ahAOQHzwJ5FVyxQ8w4O3ogAG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177

UmV2aWV3ZWQtYnk6IEJhbGFtYW5pa2FuZGFuIEd1bmFzdW5kYXIgDQo8YmFsYW1hbmlrYW5kYW4u
Z3VuYXN1bmRhckBtaWNyb2NoaXAuY29tPg0KDQpPbiAwMi8wNy8yNSAxMjoxNSBwbSwgVGhvbWFz
IEZvdXJpZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gSXQgc2VlbXMgbGlrZSB3aGF0IHdhcyBpbnRlbmRlZCBpcyB0byB0ZXN0IGlmIHRoZSBkbWFf
bWFwIG9mIHRoZQ0KPiBwcmV2aW91cyBsaW5lIGZhaWxlZCBidXQgdGhlIHdyb25nIGRtYSBhZGRy
ZXNzIHdhcyBwYXNzZWQuDQo+IA0KPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBuYW5kOiBD
bGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBU
aG9tYXMgRm91cmllciA8Zm91cmllci50aG9tYXNAZ21haWwuY29tPg0KPiAtLS0NCj4gdjEgLT4g
djI6DQo+IC0gQWRkIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLSBGaXggc3ViamVjdCBwcmVm
aXgNCj4gDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250
cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0K
PiBpbmRleCBkZWRjY2E4N2RlZmMuLjg0YWI0YTgzY2JkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCj4gKysrIGIvZHJpdmVycy9t
dGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCj4gQEAgLTM3Myw3ICszNzMsNyBA
QCBzdGF0aWMgaW50IGF0bWVsX25hbmRfZG1hX3RyYW5zZmVyKHN0cnVjdCBhdG1lbF9uYW5kX2Nv
bnRyb2xsZXIgKm5jLA0KPiAgICAgICAgICBkbWFfY29va2llX3QgY29va2llOw0KPiANCj4gICAg
ICAgICAgYnVmX2RtYSA9IGRtYV9tYXBfc2luZ2xlKG5jLT5kZXYsIGJ1ZiwgbGVuLCBkaXIpOw0K
PiAtICAgICAgIGlmIChkbWFfbWFwcGluZ19lcnJvcihuYy0+ZGV2LCBkZXZfZG1hKSkgew0KPiAr
ICAgICAgIGlmIChkbWFfbWFwcGluZ19lcnJvcihuYy0+ZGV2LCBidWZfZG1hKSkgew0KPiAgICAg
ICAgICAgICAgICAgIGRldl9lcnIobmMtPmRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICJGYWlsZWQgdG8gcHJlcGFyZSBhIGJ1ZmZlciBmb3IgRE1BIGFjY2Vzc1xuIik7DQo+ICAgICAg
ICAgICAgICAgICAgZ290byBlcnI7DQo+IC0tDQo+IDIuNDMuMA0KPiANCj4gDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eCBN
VEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvDQoNCg==

