Return-Path: <stable+bounces-227145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI4UOwQAu2mreAIAu9opvQ
	(envelope-from <stable+bounces-227145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:41:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AF2C218C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8925310B728
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3D3F23C3;
	Wed, 18 Mar 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nrJaLZOo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF13F23B5;
	Wed, 18 Mar 2026 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862870; cv=fail; b=iDYnm3K/1+BIYGs3ZweaPee1aCU4oZiX4ZESeggDTSEffBUxFVL1OughEjX3cNu7+4Dj4tqSmJzUxcCDiA3Xlq+1fgP07e/oksm7IutTHvXATPf//H1W0uW/JZx7OIeDfW9iV81fFnT2xEPfKPjijrAtysL+U+Om7DNMgfiBjqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862870; c=relaxed/simple;
	bh=1dQ3KKMO87KLF08T5k0UsyfGMPvsz3UTFM6vws9QDg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXiFR65nPxU5qjtjXxnD++AZzmUCo+B4HbUne1rf/WYSDJQzCo/GUOHI4lGys3ad2WPrATaHmtGcN96RCWSf1t59uT+vSJvyLkZpGLad9H3XPvMlicj+jH74luMNDuqTQakj5WQ5x6YsIAICqix2fItisr43fgks/ECXOLHfvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nrJaLZOo; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFWu3u3086384;
	Wed, 18 Mar 2026 19:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=4r
	YF1FB7aKVgnUClcwGYDq50i6WIuQFJqQ/vZ16iwJ8=; b=nrJaLZOomMfgqhozm+
	tJzSb8nl/kr97QzkmIWRAA1fDTotNnNQSX8+2oQBSbMDCoW17Py6fGrMdhpgjkqz
	NnBCpgkFNgqQaty16j4YosKMzzJOCDLolbY8G2Fu3Re0KGwQoulhb2pcyldWQiPb
	T12LRu8iClR1QElbM2qUYnKsWNypuclIvB4VNTji6hvI/TJA+tgzvRAGlW9PEUCN
	r1ZeZ+9y2TjGChgQnhIACIGU4uCAUH8xcNM/EnVhRLNjB37b2t/QBncqswiXdM6w
	hCWJri1YWO767EUtIKYSgyN88cPRgkaas44kaDFl/IetAgLFDhiD0Zg2iEw4641o
	E1Zw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4cyuftwqy4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 19:40:54 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 7381F802BB4;
	Wed, 18 Mar 2026 19:40:54 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 07:40:30 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 18 Mar 2026 07:40:30 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 07:40:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBkcQ4vAlR9xOptyyt79FZTCVvMZ+QrRkFBe6UHF80DprHg8Kgq1sJMTeRSniHJkZiB6x84U4HyxEQlSnPIPyAOChd3TFb07yiyKjLFXJrkxOv6SB5ibHRGHPrSVmv8JuBstaXhitu2bM6XUt9DWcn11GVtI/NwDgmgncwCGZteIgyzUxKscjNWKrm2JYF6OMSBAgU14ILIDRYGWCkG5WCvJImcjVBHDZ04vUjDKiyyydY6ECem30TB+4H0wSlfk24zXHWuRMvuH0bunsSFNxeR+L1K5f4vx3dBjl4Aa6DzzKmQzaAMwgtPW0S9IIehXRLX3ejAugf0MQVkbtnO7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rYF1FB7aKVgnUClcwGYDq50i6WIuQFJqQ/vZ16iwJ8=;
 b=bfejsU1b2+O7qnkwi0/Gf2xo3rDALHNEnqhnW6mHZx5O2/L60LxQIg9xoBCpkuHn8JnhC3QXxCrBKXJvJvJcR6+1fXwcsrCXE8dXs5C8+fd+EkpPxzo1h9fgVo2bndIt5T/PIkFxAHk5V93FKOBMdrWnNLPCP9CzLTyI/z455tEFU6r5EOX8LMobUb+Ant+g3dKlhNQXY/rQ4I8ke1388IHPUz7zP7H/MujtlxDDb19dzh0JYaybzzDtKaesvPaIz1uinfBdNBy5tqJw+ohf9rnGHHJ5aZpEr/cJpcUT6hSyFGEURp7aqN7A1oFLTuXcH7JjUyHV7ppd8Oe+agYYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DM3PR84MB3466.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 19:40:29 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 19:40:28 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] hwmon: (pmbus/ina233) Handle sign extension for
 negative shunt voltage
Thread-Topic: [PATCH v2 2/2] hwmon: (pmbus/ina233) Handle sign extension for
 negative shunt voltage
Thread-Index: AQHctw8T4sh7kufY8E+d6646+m0fPg==
Date: Wed, 18 Mar 2026 19:40:28 +0000
Message-ID: <20260318193952.47908-3-sanman.pradhan@hpe.com>
References: <20260318193952.47908-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260318193952.47908-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DM3PR84MB3466:EE_
x-ms-office365-filtering-correlation-id: 3ff0ce19-c717-4325-98d0-08de852635af
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: eQFEowcooCIuQoMSeL+tgNaF3QvUrEojVlryf2Tz6gLxtEQYPYYYnms8fyUmqqsvEEUMm6d2Nxq57mBQdhgYbBg/bJYcaIQbuCQw6mEgET/aGdN6z4s9KmdC7VC3t6VTfNvIMajkGDHNfzIAekV7pgMEBpl8SOZ/O7sXnaK74RdHd2xFocQPwxQxu5wn5GOxFlEWNz8xnkIsRdiedHgjJ0s/orF3BH6fTxnzSZM0CHR2T5DN9Q2sIpx/OM92CaKVjibhxDHxl50BDqBVRjqJ3l1+ahhQK2Ov/2X8THbG47M+Lmw4j7uHDiGbNpjx2XeU4op6K2AQseb8NtS9KRNv1Q+ee+IlUgeqgTSlQpL4fCumSneHVaUCXNtRM6fU/dkdbS2z8s3vAL4L6apGiO/xZwO9NRWdbJmuuwkz5FYT5oSWBb2rhotJX6xUNL40sq55ozzczOWqEouDVojt6fOO6doGY0ctASG3emlOenVvYVqaWnX4/7ywJBcfugOqdefk8fTj12VETpPRv+NF2eZBmS8yvuvSwx20+0N8ym6ehWozSr0VotrplOT1bufJVQQxsch9BFTvtz1kZEDmFGKQMK13AbKR/sG/+QUZOMS0BJE5jH1JNEEslH5doW4c9KPGYqiawtImEL61OeJw2PIo3HQ11mZ0GuUoRoxqxyved3dXuRbcBCsaKkKkwrtzBXgGAeAPTN5MUmTBVeXaCgCSC8T0oBeDQwlUCnOs1JTO7DXkR3Opx2c2bBtsT96hPJZlxiuUZhmw5TBxsvSERJ4IYHYkQY8NPXuvQn5IdNuH+ko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z7K0DjmJfpJaAzEubeeYh28SitwHqEql0CH4zzzloX/tTOAPFjjJjgbOOp?=
 =?iso-8859-1?Q?JlAnsxDc2NukPXi9P8G/z6aBsKd/jUrVGd3PkuCJEKuoBHexL4+34HEbQ+?=
 =?iso-8859-1?Q?QznU/BTRnZEvyaC5D22fq+UryM2T0Qg1k9VbA4qeKym8uYyrFDWfoL613w?=
 =?iso-8859-1?Q?3QA8z4jIxIiwWKS55CVpkFzMRDCX/bpTIJAm7mmKCLCyicuKkm3sylYIgj?=
 =?iso-8859-1?Q?4yKETWV0U2KrsZ6qmuSS8UklhRZrTlW90v6liDSVPyZzMwx3VwyAQFchw1?=
 =?iso-8859-1?Q?d8ohnn395SRx4Por3UfJ81+HNwuq5jOgAKo3YCtUPoLJIFY9lZMJ6JvfHV?=
 =?iso-8859-1?Q?lF2lEN3u5cCnMlVGVOdtLlWilxEeuWhZ2GeB+k38GzbHuBrDQw8SOIDKWD?=
 =?iso-8859-1?Q?pC2ZZSFHfr3aGlTIG3FDkoYCnHBpNxuHqsDq7bsK0vIqmCvTIWsL1vHr1w?=
 =?iso-8859-1?Q?b3XQ4PsIfoXscS3Z2MlHah7n34kiTYqzSfjk2Ip9oOJFNGohn74eYXyWqE?=
 =?iso-8859-1?Q?qkauJ9WkFJYLeuN3S3NUzs0W1BhbQTs4w436dNOB1SEudHGj2EAu7sL3CV?=
 =?iso-8859-1?Q?+3KHcwiPUaO6HTG2nOWC7j3h91wXhJVZngPK6iH91V2lvrhH/Yilrmv2Xh?=
 =?iso-8859-1?Q?DAGpOXfkrwbIBzFTpETarhbXtBE1DqdTNciDdpEoW7ltellWzgcmbLzfd0?=
 =?iso-8859-1?Q?dB6hLYUkD+RLNBfUh0gYHOKEXxMBgY1fqN3iZJ8I52E59e8q29IZ2wFfI6?=
 =?iso-8859-1?Q?EZvz5sUGOSXmU3jJNSo0eqclfWITUXhqCi1ExGMoGE6skKYGvtrIbWsQHU?=
 =?iso-8859-1?Q?o5pf2e4J3JN1NL47vX7ZBJzKB3b+EaF44Czlq15aWz58iAWpgrQBOZIV/2?=
 =?iso-8859-1?Q?9CxteAYcqSXyd/6GyophRTKOCorVpUzAhSj6cZL39FRDB+MrquVref50tk?=
 =?iso-8859-1?Q?Yil39CFCSCk0JThKFDNbFirBdCK/4gnn/oqPXjLXwFRW05YQlI0Z1a67LH?=
 =?iso-8859-1?Q?79OndSqZJqztu737PBY5Uk3i86BOMUpUXikj4arkh1Qybas3zFEPI/7OJK?=
 =?iso-8859-1?Q?0lEG6KzD2BOOIfdldYjxZa/o/MOB/AdB07JZIasoFt9NpZ81QN89lZT4ej?=
 =?iso-8859-1?Q?VGemy4pDJv3B0rqCzPZgvuHh2YmhWRuoU82PFQ9yRPcyoeBFsSj9u5as8r?=
 =?iso-8859-1?Q?FdH4zZhYxu3P+h7qMeiq0RELDnVMdx5bIuJUuGrkfFMp5TvKjbmHX2qMlD?=
 =?iso-8859-1?Q?WqHxalhF54nNQBqpb+atSeJXSioC19fFIP4CxWsmc/5sFnOp0iY97Pp8KZ?=
 =?iso-8859-1?Q?w7NgozWoVpefmf7Y5P/+xFhvWah3lBGkKS/fbQ2PhSz4EMqGcrHAVlpYEG?=
 =?iso-8859-1?Q?KtanpYZ0nOfln8RhAjMCcDj4fkC+AhA76MlecXnzMaWK0Pwr64IPdxcBiO?=
 =?iso-8859-1?Q?QAE3woDLU0K7On1KBMCKAGJTWeC3AlX6NDoocLqFCUt3HNE/ZmGvns1Vs3?=
 =?iso-8859-1?Q?ydTERiuw+Yrz3UzbQzo/FiQZPbc4dZHgc+/5i6rMzXV6zapC0jJrr3oD0y?=
 =?iso-8859-1?Q?6RYs1F/IsDmR0Bf+ylO+rWREdg5McE6b6cl526NiCxAm3HMIOY7c3QvS5J?=
 =?iso-8859-1?Q?7IiAxRXdriQNEgINcehpE9LrQ5nI3JLtxZ1mm+3hFLeooqF/oJj8fNk/6W?=
 =?iso-8859-1?Q?+WotlwzxJ2q9hzudixq/7CGYI/wPIgiL++DXliqxfqm2763iRZNGHEMBGn?=
 =?iso-8859-1?Q?ClOqkMT/nHkmKOmjGRej3midttEXIt4Mwu9edTGhvAaiCaaCox7mA29DUL?=
 =?iso-8859-1?Q?lRFcJJ/W5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nzvj7wSUff9pGmSF8+w35lY50DG4Gcez/3KxR4QmkcYJBBejDEWX/yp5QaFV0WSpvk48frbE6a4g3EdM8amLkuaOAKVhAAol982AbLoW64CUkNUaw6i7EjciUcUzMRf/Xyh+Jf4+xzbZr1S3yKWqiK+AMp5e1qrFOlY2v8hQIc/k3ME4PBhb2Q4cABtllgEBGUkEO1pScjOMXWIE+BygNy1ZQooqXyTmhFcZIyQJEhLUDHmxMe40KRFNiunCAIkbE7III92PECiF/YCUTuyKz9veMrcnHYqQD3fAfE+PiA2WtPj3/ryGN4XkZUAw9TDT/8fAACuxOAwqCrHhu+haiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff0ce19-c717-4325-98d0-08de852635af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 19:40:28.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zzoba1yoSWkZOP2MEHiJLQn5B+ZEOxhAq0DgloeTdAbakobZovE59EB3VaYUJ/FbqXhvHN7saPozI9PrxBdcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3466
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE2OSBTYWx0ZWRfXwlE1PMz8i5ny
 n+k8KIwv1ZCVoFwBQRQk4M/uiNirqnWosMY2VDJzMwZdri9xKRFL0xDKWVk1tGd4izTrT7QrrcO
 y5cXauNKJaZ1VAkb25SzltQ5kl6TJmpocj+b1ZJ91iKKkDd7PEfxgY0YCdSHqfPiOm8M9W16hGC
 xWvSbuEJj2SN8y0k/ktF4yDE8sjuTzwB47hCEBPJHMo7QO6YeUm1UdMoCdCnVZwIBnyh5GnLfWH
 BBE/Bul8f38lXkQ/OcN3HzpPwlt/IluwBVSoU01ak7Xm48qg6BRJRiwqfZW1Xo8f90cGHFsy/lo
 mP6Y5fB++g7zVU00X0gpcZK2e2dstWGl0kQQQMqKFzL77uB6QZ/opEnjoEhMtoXBQymWQ69r7aA
 x0iVcPd6tAfVUhHKRzapdjGLYN/zMThl6FM83l3/mOQ2WTZ542vYnmqmMq1CBDGVneAgfn/RTU9
 LlVXXt7bS9pZQSPo1FA==
X-Authority-Analysis: v=2.4 cv=Aby83nXG c=1 sm=1 tr=0 ts=69baffc6 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=0XDV0WT1qYpp_fJBR00A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: zUuZroR-jB3y2QQ1ICgRggbGzhTyyFVo
X-Proofpoint-ORIG-GUID: zUuZroR-jB3y2QQ1ICgRggbGzhTyyFVo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180169
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227145-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9C5AF2C218C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
ina233_read_word_data() reads MFR_READ_VSHUNT, which is a 16-bit=0A=
two's complement value. Because pmbus_read_word_data() returns an=0A=
integer, negative voltages (values > 32767) are currently treated as=0A=
large positive values, leading to incorrect scaling in DIV_ROUND_CLOSEST().=
=0A=
=0A=
Add a cast to (s16) to ensure negative shunt voltages are correctly=0A=
sign-extended before the scaling calculation is performed.=0A=
=0A=
Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Mo=
nitor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
  - Added (s16) cast to fix sign-extension for negative shunt voltages,=0A=
    complementing the error check fix applied in v1=0A=
---=0A=
 drivers/hwmon/pmbus/ina233.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c=0A=
index dde1e16783943..819f4e8aeab61 100644=0A=
--- a/drivers/hwmon/pmbus/ina233.c=0A=
+++ b/drivers/hwmon/pmbus/ina233.c=0A=
@@ -70,7 +70,7 @@ static int ina233_read_word_data(struct i2c_client *clien=
t, int page,=0A=
 =0A=
 		/* Adjust returned value to match VIN coefficients */=0A=
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */=0A=
-		ret =3D DIV_ROUND_CLOSEST(ret * 25, 12500);=0A=
+		ret =3D DIV_ROUND_CLOSEST((s16)ret * 25, 12500);=0A=
 		break;=0A=
 	default:=0A=
 		ret =3D -ENODATA;=0A=
-- =0A=
2.34.1=

