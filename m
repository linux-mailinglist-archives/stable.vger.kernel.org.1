Return-Path: <stable+bounces-233124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EOdEBkDz2mLsQYAu9opvQ
	(envelope-from <stable+bounces-233124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:00:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6638F5D3
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E1473045E38
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CB3BD22C;
	Thu,  2 Apr 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZP79Rsqd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E83B895B;
	Thu,  2 Apr 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174365; cv=fail; b=DgOQ9aKBfgfRjEP6EMLGoej+sU6802SQRHTFIpEpRQb+8tswWxJk8BfyocF+BjvfILB0pYR/MKBjlU/WFM+vqdIxL6t9ROICcL/zcW+b9vt9LcX3AbVFFUAvkxqoZKpoMEd+p1kGyZp1GyQfNhlbybjmWlH9PGHOrIC/tiSqujE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174365; c=relaxed/simple;
	bh=M9TGPwijrHORIBKSB+z4KblUxEv0/U/CBZFKcAjY4KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCnWU2C6v+7HE0ys3dhxdrRQTcaPzUa6vpX3EFA1lw6TIKh30X2CusXyOP0yKe4DrMEjGj/5Wm4lGvI5dvHahhx4Dbr+Xkt6dKmNyVocU5b0z+FYbrOnxNDGz6WPfr4dxdmFH0trHliPqyINgh4tYcxUDDVNmucvKKpJnMtbVEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZP79Rsqd; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632LW7iv2214621;
	Thu, 2 Apr 2026 23:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=fy
	qTldiIbUN/1zoH776sOdKowX/EmpgfZ+AzWPnWBJQ=; b=ZP79RsqdFDaQAxZIrk
	EbIVS71FKiLAeYzuFXqU0Zn68JNfRUVl/jT0JbXXR0kkXfu8EjA0gXPHaykpmrid
	litdJV9xaJw30l59XEbVOEmiU5HNl95iN10byun/Wl+UgsBsrTOoDoIbR4QwTtn8
	fKeoHNmbY1WdTYlHKffiO5L974eGOC/ckM1eLZd/B0WD6C1BWICWRSz0lvfhl5Y7
	ZZjrVx/ySYv/4hYZEK8scl8Mj2CNGUIIa4VolqtOVbK8otDtRenMyZmWGacq5OwV
	CDbuNAAI8srpp48vkNOIDiNc+gVxXZV+rPpcNe/r3CCtURF3psVi53xk4auHO1II
	lqlQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d9snxpj46-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 23:58:59 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BA61E248;
	Thu,  2 Apr 2026 23:58:58 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 11:58:40 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 2 Apr 2026 11:58:40 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 11:58:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWgY9ZeqYkrb6rWt+F9Q/VWhGbYjWccdese9DiBZ1OArm2M54VqwgJlJRGzTr/RvoKo0crTNUgYcIiowUkCu7OHhqq/cf6e98UWHuoI+si5l3Vt3iJPUx6hlna6PMI/w2UQ698At0pxsMUrRG3SNMbppzEdbhuAzkYbO4vqZ2CUl35AbHMrep/b2e3BrcpVS9+p8ZjDjoTWkqlEJJ2PrjVOXiZ5p7JVX96AZheQXZwEwng8W58tC+8Q6o5coof4YTZdbWLWcHSL5vvZkOWpM/2DrW1ifaYVf14nbmO2d6TbaE7vomqdJzkGKkSN4EU2xNBLotEyyWEbNhA+0f9KMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyqTldiIbUN/1zoH776sOdKowX/EmpgfZ+AzWPnWBJQ=;
 b=LlhKCIJZaYr+SG5gWNx4epBiIubPWzkIkaPCNbo+e0UgS0ZPJjpsnZs5UZSj6at0FW5Nuw8f4JcgutR/JaHnwsg9Stqpt6HlAM2kemlWqGL+DC4OFAzv5BXRSj8QkocMKCyCIc8wXzLu+wM6wIOyFflpqoAc+D3YqMzZYTKl1n7wiiaaunnAnXFa/M05fCcwq3Fxkhk4AQ8cOQ57ZtBffkkBbfdmDipmOPkTVCpoUuAW1Os+Uq/N6cdoj6BjLpAQ/fqY2u8n578l0rbMkKAGHoilCSeKUli/O+gHnrKOlZJfH3bHujKh1XBIBFJUi38LtvofqVLeSqyaSNR1KTCFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB2258.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:58:38 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 23:58:38 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Topic: [PATCH 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Index: AQHcwvyfAyNxZAeCYkKubaBWqkT9TQ==
Date: Thu, 2 Apr 2026 23:58:38 +0000
Message-ID: <20260402235819.86456-3-sanman.pradhan@hpe.com>
References: <20260402235819.86456-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260402235819.86456-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB2258:EE_
x-ms-office365-filtering-correlation-id: 2fa05e1d-11c2-4cf9-3122-08de9113c248
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: a/wSkY/XH0RHo+eFFILaAK29PYxljXb5/14oSAbYjCuom8pyTJjZmR5TaPmkb5HmRnHErk23hxzdTPocV5HzmFZyKfvbQ05KXkNmO25OPUvnyisTFaKcgaI3JXcjkOnNk04mdxnBzNirFB2cY7AADu4eybbY9TOQo+inY7n5m+2hRt6jL8nuwd/a/oKZ0993VCx8aSXsrQJR9DcLKcYSzAKs7mM9qepcgFJeozehpAPHi40WfAYCdVL1LxASk/IDKf2tKUBY37j9q6XxvrUYDDzV2vIgV30auBlbwbReWjBurC1cbsCGT6RI2JhaLJvMEOfK3JS3w+/8qSlg+T5NKPmWToj3/Mm2NmuifxR3kKg7xgBJlZt7vYTDc39ZurVww7/BOb+noVAKAoNTnx/qzTyWQ7ObuvCOUVWFOf1CnGJZKbFCz2GT+ER7wUudXAN+SS6xXRFFHYP8x0+s+6j6ueyk+vlQRy1FDNapoA3OX3YTU7OIX0CtY1EK1CsgpKgCj1XUZ5UVRzzO+YqlalVliIfVIsh50VxiO3nGI9YgntfbC1ef4or0zqdOBwlXux5FciFCzor7vwu/mKEQzgO5c1AL0qrPbe28uaKvd02J9iy+bOiIlDrqiOyuUEjoMCaEhm/6+kaESTyQ+rWkepaygVn0EtsD1dr2MIIrcR0a3QDAM9Vo/Rx2752FhbphgzGXmj8TdEczHr88y4P+AfFnaRxEFLehziDjseBQktnwA4NV70u5N3OAnFcWLcvi+iyedr4KdfArWVZT+ly4OKnevQC7TttAZoVZwwOHG6BMk2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jVQtaPyxO38i6OUw1XNLaR9Sdm5zqSbtO8M5/zguOnOfPaLQ9NmUNfc2B/?=
 =?iso-8859-1?Q?xIbgTB6VO9hQDtaaTbTEp+9+PMth806GQAjzn/Nqa1Pox1h5zNejSAwQGM?=
 =?iso-8859-1?Q?TFZbZfq/2VFLoNTxyRU9ESJbSsNKZ1Tdn1GyjRDh1rmobBVNOunqxWagCt?=
 =?iso-8859-1?Q?jlVqg8+55HpNmcrlHxkHxuGjBLFnkzRXS7bm7Qxwo8uXzt469RwOUIxwT3?=
 =?iso-8859-1?Q?DbbQzQqeUYVN3C0R8Zej0stbWyi/JqRfb6VuczNhKPmv5AuXSLDtjbmKSb?=
 =?iso-8859-1?Q?fjCGGg+5D7f+D7YHNP7wQc6bfh6uvHXpbxQjYyyYYL2a98oaFBabdwYOi1?=
 =?iso-8859-1?Q?sBrcewIFyXIDiRrnBPXej/cPAKg5Hkqghyptn1TXXhYQq9CXHx2G9+7Lmw?=
 =?iso-8859-1?Q?Hf4Gq0J5NIWQGUt7RHqEOcdP7mxtvv1yhhvX4D4HAt7oVhPVDmSU5yobn8?=
 =?iso-8859-1?Q?goRPdDz6k5AgV/xsik6Zik9/VP3ovO3zbaLgpnIp2Q8+HMtVzlKoYA/sVN?=
 =?iso-8859-1?Q?Xn1SvAaxTcudiP7DFt4CQh+BjkZELJEDGYeCyiSKTynjDfIRfo06ezIg26?=
 =?iso-8859-1?Q?H2H7u0KZY8uMjtYCA2EcTdyvv10+NX0BOI/yHKAghP8SOxsFHU2qHJCfMB?=
 =?iso-8859-1?Q?FyJU9nA0E3NvpeD8LVRDMy9jbccQii8iVu50VB/VrnqAKfn72noaAJsU56?=
 =?iso-8859-1?Q?QsfrIPEXQekLpQCwI8yMdpfJB4vm4yFQy5RKXw7FdAestcCj7448OWHloA?=
 =?iso-8859-1?Q?+Eq6FCTDBDzo6KpPLAgNzPmHA1oC0BxQJXr2WyspdaXhwaGCOPWYd/RXNE?=
 =?iso-8859-1?Q?M8Knz74bDkLX4GlWUXjK4to/PR4W0NGZGz7Z7HW0Vu/fzC19JqPKsbOxu6?=
 =?iso-8859-1?Q?XOTXtp9MMsH09UeDCDelCaVZntP9AyYV6atU+EGZ+97H/YbDuHGEkYlE1e?=
 =?iso-8859-1?Q?I6yaghlpN8A8TBQzHfOawk94CYprMGBNG0p0aJs76aGeZsJtspUR6xAXja?=
 =?iso-8859-1?Q?6vQmywnRZgTtgH9kqKa1cG6VzY3iln2/xd6rabv7nITagKNgtgJ9iDHyae?=
 =?iso-8859-1?Q?y6bJNJ+pnRnIJW3y2e4ILUsCh1vxlcYTlxmJnBrYuoWTh3Xiw6HTlTCLcl?=
 =?iso-8859-1?Q?B8d/a1C+Og/Dx/oro8kJyxFYuE5C0xAW7eAzhCmmhy7fELxJ64V2pNGI6/?=
 =?iso-8859-1?Q?7G9M3il9hiCO/2ko6tgBTrWggCCER4qVK/6hfnXI8j1IIwKlGLpFqziJ7/?=
 =?iso-8859-1?Q?qs31BiDZr32wN9Fq6Kr1sE0FMpvvM9J1sOXmGV1Sq4uewwvnY2imodJF5y?=
 =?iso-8859-1?Q?BC6JRrNkOjkLC70ENANJBMLbKXZqNGIN0x8ZXR0tsB6k2O+P1NKg4vk9qZ?=
 =?iso-8859-1?Q?iSLHEXqDp8rS51yM23gXyr9nBZbHab7JdBjQj3NIdjCbICSVNDoDa/X928?=
 =?iso-8859-1?Q?uNAZDVEqAf2eia7vQlqEn79KNtegqPVpSZH08pDWlUr3Q14qyafThT68qF?=
 =?iso-8859-1?Q?SeJZX4Xwwvw8ekVVYFHOdAb57I/k1AK56IvRNH+PYoiflLJA3N2dIS2EDb?=
 =?iso-8859-1?Q?hNP3JX6UPWDrlIv5U3pCqcoXJXLgnyp4v8V+BuGeRu1yJhpiXWhLY/e0hn?=
 =?iso-8859-1?Q?T5qPSFjDipM7PGBFMBfescBKKcNN4jFR/1E3K/FUF/jO8S79xzyqv+/HMy?=
 =?iso-8859-1?Q?1uuxYcPfQ40ay58OCXZTyh1fcEluPpFbZGFPTUOK5woixDW4XaJ7CGtPuI?=
 =?iso-8859-1?Q?Cl6WSkTaX9AJIHAYbvDMw+FIE5u07Kyyx/4grcPu54Nde8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hRyG5J9JguQJM04VsQSfIJaHI8GehfebI9BcziLIqxJm+t0GtA5Dt+gy8Ekn0I4oSPN19cCAxBKebeI8RWbsk/dN2feCRZoxv7BsdMXtUftDHnRHT7MyeMcESeiWzTSuUoLxmkL3aHgh8JlB8znENF6rRCoTtGpMwPfCUBhmritaljRCz1uOAW/csAUPlTEDzyyyTVFJrhOLTtKRhZ8jxpPxx8fduMdUIJ2xF1aSKGo/bArTiRuvE8a4ci93U/0lnkgfl3Ve1sfhLxXsQK6NzN9jiCdNV8wGFQuLQCs6pR8wM/p6uSNEOfX5GHEGfzTbtiUM2aSZx87SPfxxLj/LFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa05e1d-11c2-4cf9-3122-08de9113c248
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:58:38.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNAs5D2R43/nGSyMcW5YJSusodLn7AqjbIZ91vnv6m4rQLYPwWohjv+yMcOmVtdAzJEHJBkeH39jxuNf8ciUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2258
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=dLSrWeZb c=1 sm=1 tr=0 ts=69cf02c3 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=kT2SCdrF01qjGp29COUA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxNCBTYWx0ZWRfX+1UTFAO8B24M
 uTclRzIWrKFFkqxFVk06LqcpxmrouTfwiYlwrI8timeIRQS4mR+qTGOHru9Pq62VHtEONF7AmRD
 wDc+xmOqfxxTMwqoSPepinDZy52CaM9BXgLBO0GQu0K6xAZ75pY4WoeKPqrIup94NKQzsCafkIt
 rm3YMsAPEGfyUa9xU2aZ5l0kBOeqE9/s2qZBCnMON4eTeLMst7crfEAShjFtikThDHZcIpkqOTx
 cNVIOlwc5yuXRy6pwFSLE9ciMbegf1Z+VO61atmFqtYULJ4ckPr9I1JBkKkq9anmwh0+wy51/12
 h7FkKTAXMZfBw/FjHN774EvLZuK8qjOr/CKgm1JnFtpZP1i5Z3ooZM76BIUtyD96Kk5MH0hyU+3
 Ynlwug322s0G3pYnBpZ9i3/zJVIecK7iP5RQm8eSxiiNSZN936zmoZ6xdfux+mRTXTNh1yHWKO7
 E3cnWxfA5CslvyTt/3A==
X-Proofpoint-GUID: J-gEFi9ML7_zZFbuYec7SgnmZhYXKTNN
X-Proofpoint-ORIG-GUID: J-gEFi9ML7_zZFbuYec7SgnmZhYXKTNN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020214
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233124-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hpe.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B3E6638F5D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
isl28022_read_power() computes:=0A=
=0A=
  *val =3D ((51200000L * ((long)data->gain)) /=0A=
          (long)data->shunt) * (long)regval;=0A=
=0A=
On 32-bit platforms, 'long' is 32 bits. With gain=3D8 and shunt=3D10000=0A=
(the default configuration):=0A=
=0A=
  (51200000 * 8) / 10000 =3D 40960=0A=
  40960 * 65535 =3D 2,684,313,600=0A=
=0A=
This exceeds LONG_MAX (2,147,483,647), resulting in signed integer=0A=
overflow.=0A=
=0A=
Additionally, dividing before multiplying by regval loses precision=0A=
unnecessarily, and division on s64 requires the math64 helper on=0A=
32-bit platforms.=0A=
=0A=
Use s64 intermediates with div_s64() and multiply before dividing to=0A=
retain precision. Clamp the result to LONG_MAX before returning it=0A=
through the hwmon callback, following the pattern used by ina238.=0A=
=0A=
Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power moni=
tor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/isl28022.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c=0A=
index c2e559dde63f6..5d4ca1f5c5839 100644=0A=
--- a/drivers/hwmon/isl28022.c=0A=
+++ b/drivers/hwmon/isl28022.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include <linux/err.h>=0A=
 #include <linux/hwmon.h>=0A=
 #include <linux/i2c.h>=0A=
+#include <linux/math64.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/regmap.h>=0A=
 =0A=
@@ -178,6 +179,7 @@ static int isl28022_read_power(struct device *dev, u32 =
attr, long *val)=0A=
 	struct isl28022_data *data =3D dev_get_drvdata(dev);=0A=
 	unsigned int regval;=0A=
 	int err;=0A=
+	s64 tmp;=0A=
 =0A=
 	switch (attr) {=0A=
 	case hwmon_power_input:=0A=
@@ -185,8 +187,9 @@ static int isl28022_read_power(struct device *dev, u32 =
attr, long *val)=0A=
 				  ISL28022_REG_POWER, &regval);=0A=
 		if (err < 0)=0A=
 			return err;=0A=
-		*val =3D ((51200000L * ((long)data->gain)) /=0A=
-			(long)data->shunt) * (long)regval;=0A=
+		tmp =3D (s64)51200000 * data->gain * regval;=0A=
+		tmp =3D div_s64(tmp, data->shunt);=0A=
+		*val =3D clamp_val(tmp, 0, LONG_MAX);=0A=
 		break;=0A=
 	default:=0A=
 		return -EOPNOTSUPP;=0A=
-- =0A=
2.34.1=0A=
=0A=

