Return-Path: <stable+bounces-229967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MjvHilvwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A62F8DEB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBF5930D3777
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E493BF68E;
	Mon, 23 Mar 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="F7vGSkeN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E53AF650;
	Mon, 23 Mar 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283708; cv=fail; b=clH2ZERF12hb4DeT+SiKIsMUZUtLSg4P3l1EgFfVDC1jpiTE+NTdRhNKzUNZaxrEk7Ga2wkZjKpBcnPaCW4asGqRY7Zcxw0MYJRUtNFXvzyXR6xTf0vegzeP0afWrIVaF9Le6+oPLD+O+Fd/SZDYd+FjziUM+5l4rTUnShff76c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283708; c=relaxed/simple;
	bh=xAICgJ8ScQU12oX/dXgj3mjfqHr4DsG2WrGuJMN/H6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GVDfbHyXkWqE1R3znRxHBXZhSKKVgbBifDmYpTtif0JqXyD4Fji6E1ZLXN9r4uO6LNtgZZgu6UfcT9GI3tTV62vKEcmAJNLqpvIx1FrMlFtUSiRzDl1TLWJyTlwmi5bfqsynstDJ0HNRRxCABkLFJhNkoSV1OFpRFeiRRPgpjYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=F7vGSkeN; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NEqrtD2097874;
	Mon, 23 Mar 2026 16:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=g+
	8Nav8lHF9jBYyAeCPc2OVUxgxjm2Uo00o9oFilux4=; b=F7vGSkeN9I17fMdMna
	1VQq3Ja8L0tAxIXf5gQwZVWQHvxE4c1g72e6qvFg+hBcOmIpR+hFOYhgBXG/CEoU
	5eimb2+PzpTRn/bzyDYztfFHtsuNm0qRxhqH4Kun05I7CbSisRRcaW8u//lw3pMN
	DTPVLS37429pzMybnEUBdGLhSUlOWSyozZnho+ztxgff40sajvqHRD8q94T7K1qX
	IupRZpKxuziq7SMPr3VrxGjNa9KCNMKcaBR8X81GhjtLS7dME2Fn2U2BZl+UqoZE
	AiOBFK0hUvWm4v4ncu8E1QLUwuRZZGGQJxyNkczLAv5/KKnu3QPbRY9VJFgR303R
	P8hw==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d37nth9ve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:34:49 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id AA8E8D270;
	Mon, 23 Mar 2026 16:34:48 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:34:48 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:34:47 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 04:34:47 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:34:47 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNCOhWCHD+QbQx1cYE0f4B6Y1Jnh/xMXiyd+u8xr5qQoq0lvqar2lagxIQXujjJeBDSpRNJk6qIMNCcHWsMcbdU/lgXBJtTlaEp9Pf/pGpc3jKrKbRjqmeX7dFlj0N6cT7RUWcE8tb9A6wXntwCghr+NXjQobd1wkyOu7l1NKI84AM9GfwdneUXl+07xC4Y9vX4w8EDeOALjoGo93iNFXiEE7FJpscQJQAvCH6DeR2zqDTLFyZEGqDiZz7rnVtZLo3mRhAY/lfeuK0IJH03XWxeLu/538gu1OhdvYrsINxYrm39JoSesfD/rFHXe0qjfpH5lqwx2ijJpYxYsw7Pv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+8Nav8lHF9jBYyAeCPc2OVUxgxjm2Uo00o9oFilux4=;
 b=RQkYyOLZ4DGxtK/BxS5GeyeM9z3n2RGNDykFEnmroGzUKKwJwX5Ge1+CzfzG6LN8VZT1N3Z+eshUTPNugSh3zE56LiN6LIHXdZajMP+Qj982J6UdYZeQWedDIzKVK9rvX80wnpanGvDfD54xz5Nl1Y24mmfRDwXOhIpBcrLbPdNWfFGj4hhnkWtyTwr2oEPcJIVhaHfdfxq8gwJYuS+QzPx4fnHUrVDX96st7dlcGnh8hFPCE1JDuR0wgAHvbt7jUkXLRylYAJF5diGfvZ26Dp9tWfY0Ir0AkrCbiGWswqj5ISd9NkmKgzobslnk6llPjFlkpPlelz3JwuGVCRQfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:34:45 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:34:45 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "wenswang@yeah.net"
	<wenswang@yeah.net>,
        "chou.cosmo@gmail.com" <chou.cosmo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/5] hwmon: (pmbus) Fix return type truncation in MPS
 reg2data_linear11()
Thread-Topic: [PATCH 2/5] hwmon: (pmbus) Fix return type truncation in MPS
 reg2data_linear11()
Thread-Index: AQHcuuL1lqWIQ+/K0kWiUQgF7nHDqA==
Date: Mon, 23 Mar 2026 16:34:45 +0000
Message-ID: <20260323163343.183186-3-sanman.pradhan@hpe.com>
References: <20260323163343.183186-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323163343.183186-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3819:EE_
x-ms-office365-filtering-correlation-id: 0a4f5428-bb8e-4015-149b-08de88fa17ae
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: pzdBEnAoep8dhyiLiAeV1AQV65T47ZWUi2RzgwwWhWUZ8f47fU8G4JEByPshNh/pkBZZhVXgEEMcvRWHjgLzsLUqA7aLGJGY+sGQRFH/RvlNeQor0vt1ACi8fGDZ4xcveYYojxFto2hxt3Bf1C9Rc6R3jmmkbb2yiLXvQM639cMANjoGFRK9edFByAAPfwT6RE55xh2iTJbQNWtaK/DNE/EsWOObPNZ9yJc3RGluPcxkDSWCf9qZEMyemOJbAFPPIemVMA326jegXhTvGi5JVGV60WbEQQEz0xhSmPPD9g/8rBKxwq1fZQ4UloYk0YSq0EXvMT92OubIaFiaK0ib1+1U674QRILSzmz7qQOboPBk/IeBsQSkcql18+qDPgoPjsVFZTWT5TqY82zpmmOWXH8veMp8Gnvz3a/xijcGFY9qYcHtwliVFzpNS/dywn6UmJTR1RYU72Pp80ElEP23Vto19Z5In8KZNroC5ftUTvGTFmJoqUVO2nfU4YixQxmWSBwLc3dPISZRjx2LHqjPr5BTEnoMbRuI+iTokEXNF5Ufc0Ovh+NdIsemtuC9B9+DHG4tD7/ZkM1ONrJAdRfIeq9mhRLZZJSTPjYhkQgT+7wCVS7QAMJXQ+wvt9RgPCRTGFlFWQ8PDN2yYEZXRu+CvI6qzBBCWGo15jZH9i9J6pTqX76bQlM2IaWPtKoM/KQdBcBRqYzdcFQGQiJwkt5sIeibUlvLa18LFxiZLNlf3gKK7G6ZEGd+LGjY8OmyVJzQDkYTHvjI0MRjFx9qAb8BLPbO/a1qnLi4S6duxylh4w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+8UzE0x4cG8856wBzPDhyz00gtPChZj5Npt473dByExx/g5MyhKv27M69g?=
 =?iso-8859-1?Q?rafZSXIU05Dil+PAqD0FrOIVmLBYHuNGHHiitaSoCSS+mJhrGQqGeIilsH?=
 =?iso-8859-1?Q?NXmfIgyulwFEDvJTjWVtcNrkL4yo9EtO5SO9FJ6hhh5vqG9o1oSD0xzb1V?=
 =?iso-8859-1?Q?GjQOjdcutw3w6k7N7suFC6nU+ereZKOW7IWz3Aj0CSE90yTThHeljqglz/?=
 =?iso-8859-1?Q?2fzkHMQvqe5rDNUnxUQUFj2/zmS2QHIue8pizmPvljXlvwEfeq90inBw8f?=
 =?iso-8859-1?Q?q5noe5GSKVPKJSRW7Ue9i/nGg7Lhj9WOA3GUcSuLOQdRwUJPOL/k1rHcEB?=
 =?iso-8859-1?Q?Ilv3k4vpTyImvGI1DyRbtf1V9UZ2sF6lZFmD1YX24yqEsM50xdxfCc/jrC?=
 =?iso-8859-1?Q?5jlVNKdP53ZfMTcBg0mbFgsSCNFwRXODE4KmcxbKmkrS/5DOdoB/jSt3fE?=
 =?iso-8859-1?Q?Rm7V/nCMkYE5GIKdHX6Vf3MVMCcowJLF7b1yU/+pbPcsXQrfVTA6p4HZ+X?=
 =?iso-8859-1?Q?yE4eXn2/ESsHhvzvegi8OYZF9KKZAJdXZ+gLuMrQm7sv25zdVvC2AmBuc+?=
 =?iso-8859-1?Q?JXCjJiwZiIstUmIxUEO1a0p/+OysVXt4Tpgs/rat6hh00w8oaUSa6e0thw?=
 =?iso-8859-1?Q?r0wVjCHdG95LHPZjJDMTE8Ofpl3cakNZs3hI0adDvuC5RKEzmF30XeqyrN?=
 =?iso-8859-1?Q?/uqpsUR3q0c67FWxGrWAUjDLIFlDGCc4RUdLEDVaixads7sCw3sHjz74sA?=
 =?iso-8859-1?Q?kVzNECWnWw6BuC509S3R7qqybWLFCgr9VEV6PLy9zqtvEy5ZTkzlI0Oa5/?=
 =?iso-8859-1?Q?uIkk7aDIbiXvHR1RE3ISQYQ55Lv6ixjjcSFhd4Epwv/4RLoiBzF/HZj/9T?=
 =?iso-8859-1?Q?aCgTMpM5ef1vJLaPHKjf62XvMEn4dSoG1Gd5h+0i4i/RojFuYTkSKcKQlq?=
 =?iso-8859-1?Q?ylUngBtVjvq5XlUSTNrndP4BeZdDjIwrAiUMlxjNLJwm3ZymDfcIfDdmab?=
 =?iso-8859-1?Q?4aXxlSq0F+/60A0QE8fVw/TjfNxhytOrI46Eg8+xOaoLDI8cv0v5oM1N1v?=
 =?iso-8859-1?Q?T/gJ0I7Ir7MG/oqOuEUUSbbvwRFaBBPTqmd+7aFhOmzZUswkGgprvzNtR5?=
 =?iso-8859-1?Q?RnBqgUzVfM+L9iF7BL9Rz9PeSTgFY4LJY719jVIhzGRXvqS4TigWq1MHao?=
 =?iso-8859-1?Q?KqvXXUDZDSsF/CyCoHSygICqqMIl5XOdqNvhhqd9YunCP7KQPTJao2332H?=
 =?iso-8859-1?Q?XzwG7LKpLvbdTQoqqmiAaRFj6qA8+pZKpQYopP9t+/zUmpw/Vr5CAg1IWl?=
 =?iso-8859-1?Q?RYq1giiNfDu3q3YN559LfbcELuiBuJb+7ufAC8snL5nfbSKaZOjrYjZA4Y?=
 =?iso-8859-1?Q?3rtc7UDzHFkTN4Z6cyQQVKFYsDlVHqzroNTse4tEgf8hBe8DULmCY16kiI?=
 =?iso-8859-1?Q?7ois2PhM8n+OQBBSDwAmqVROwA3SmsUuxXfRppB0P1XFOqlPER8NwRQ2eO?=
 =?iso-8859-1?Q?0TOLXD6bC3cUhY6q95oX9ZXVC7fjVPWgfKAnenGswG1+F8sTfVOgFjZ+y9?=
 =?iso-8859-1?Q?tMpIhPJpiCf3hTzFF4SI+UXpw3R/l5COVIFAQcKWFPqUf5NrBw0FRkO1lZ?=
 =?iso-8859-1?Q?etUniyESSY+8INmr2OJu2qKffzs2FfqkO2X2JgKPQR9Rjl8aiW4oNUcIAv?=
 =?iso-8859-1?Q?bkZclwyFP44yDSIEsnkBOtQkEszVjxMqlNH2KBfSnef8M641l+mkpxWo+1?=
 =?iso-8859-1?Q?JutZlJDMhh8DaHhZ8ostyeAHB4DJ63kj1Ves4BrHVzlEdL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qPowWYOTTbR9I6xrIjU6DeCZpsLLKDQU9+jHmjDT2BoXLL8K69PSZYru7qj47LithsFGKR0bNbdzPqpILtnfGfqaqmZNgMN1Ra1/htGCn5urE3Xo+DlqFgdqkJIocxpFylxouZJNUgE5mVdNtqMRVkkgfWjswkuNSv9q1KMN/Ly3z0BxTa5L0dXyuhe6mcHgoS0vn5q7w3N55aDVN3XqpOgcL+icpDIIIa6BEkDWX+ts+Y0/hbbzXSO7qW+2G3oknDghA4lNaW1jpbxVg1KoeHtjnqL0cJUQiYaqdt4LJF4b7BC+6IN4voqPEnhYEWAZ1NrIXDL4zpNw6sKgmRVtxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4f5428-bb8e-4015-149b-08de88fa17ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:34:45.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwKFdVPgkebXfF1IYaQngwK/vQgrN+CulssanUCQd9KQiND6SAhxO/EhYPhK4BmgpQ07zyBQX6vCaGsbJZrXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3819
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: l6bVSnSOp_HxX0J2I4dRN2kCHm_IFKFe
X-Proofpoint-ORIG-GUID: l6bVSnSOp_HxX0J2I4dRN2kCHm_IFKFe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNCBTYWx0ZWRfX+xEM2gIyxTj4
 FsDUgeP06wfvxENn9mZPOnZLfVD2oiMUUDG3yzPj+wEo5LByjtCqwMh4zbj8q6xz3P/SH55Dxez
 6Gd3GEB/jvWqkAy/bZES8Nj+OmlidbkzJmhxckaKlACpemLqD4JvWcRw6c0zvpPyO1c7bZXLPVg
 GqNAW1ihU0lr16jpVlMerto7s8pS5W56CdBBOok2jGhJe/DQpdGDRwzA7svHXVf3XGg5jJZyz9o
 Rhpis/wERA//43KJOO1YeUn9jAx03TjTRuumul38R8IPWK70HbNBEA0Bm+wSA1Myzyr583pHOzZ
 4whANVj56ji4OwuAJhfdz7DjDIry2s+LBTGpMwsYczMtIm98UkM54BWBdwBJ+VYSV/UgzusCEXb
 bmXbOeIxdnB/bbEMUx3Fg4L0udX2DG5Hx4QkZY68cXsanRz8KevjTuWqQrEJWIn/f+eDCHtY8/Z
 DdApBHBQpTJBaJfc7zg==
X-Authority-Analysis: v=2.4 cv=ddKNHHXe c=1 sm=1 tr=0 ts=69c16ba9 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=Knx6zecuWxaYfDB9Tz0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230124
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-229967-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9E6A62F8DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
mp2869_reg2data_linear11() and mp29502_reg2data_linear11() decode=0A=
a Linear11 PMBus value using signed intermediates but return u16.=0A=
This silently truncates negative or oversized results.=0A=
=0A=
Those helpers feed values later returned through the driver=0A=
read_word_data() callback path. In that path, negative integers are=0A=
reserved for errors, so successful decoded values must remain in a=0A=
non-negative bounded range.=0A=
=0A=
Change the helper return type to int and clamp the result to=0A=
[0, 0xffff]. This makes the saturation explicit instead of relying on=0A=
implicit truncation to u16, and keeps the conversion semantics local=0A=
to the helper for all callers.=0A=
=0A=
Fixes: a3a2923aaf7f ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series =
driver")=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp2869.c  | 4 ++--=0A=
 drivers/hwmon/pmbus/mp29502.c | 4 ++--=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c=0A=
index 4f8543801298..fc4ce854c9c3 100644=0A=
--- a/drivers/hwmon/pmbus/mp2869.c=0A=
+++ b/drivers/hwmon/pmbus/mp2869.c=0A=
@@ -65,7 +65,7 @@ static const int mp2869_iout_sacle[8] =3D {32, 1, 2, 4, 8=
, 16, 32, 64};=0A=
 =0A=
 #define to_mp2869_data(x)	container_of(x, struct mp2869_data, info)=0A=
 =0A=
-static u16 mp2869_reg2data_linear11(u16 word)=0A=
+static int mp2869_reg2data_linear11(u16 word)=0A=
 {=0A=
 	s16 exponent;=0A=
 	s32 mantissa;=0A=
@@ -80,7 +80,7 @@ static u16 mp2869_reg2data_linear11(u16 word)=0A=
 	else=0A=
 		val >>=3D -exponent;=0A=
 =0A=
-	return val;=0A=
+	return clamp_val(val, 0, 0xffff);=0A=
 }=0A=
 =0A=
 static int=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 4556bc8350ae..1457809aa7e4 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -52,7 +52,7 @@ struct mp29502_data {=0A=
 =0A=
 #define to_mp29502_data(x)	container_of(x, struct mp29502_data, info)=0A=
 =0A=
-static u16 mp29502_reg2data_linear11(u16 word)=0A=
+static int mp29502_reg2data_linear11(u16 word)=0A=
 {=0A=
 	s16 exponent;=0A=
 	s32 mantissa;=0A=
@@ -67,7 +67,7 @@ static u16 mp29502_reg2data_linear11(u16 word)=0A=
 	else=0A=
 		val >>=3D -exponent;=0A=
 =0A=
-	return val;=0A=
+	return clamp_val(val, 0, 0xffff);=0A=
 }=0A=
 =0A=
 static int=0A=
-- =0A=
2.34.1=0A=
=0A=

