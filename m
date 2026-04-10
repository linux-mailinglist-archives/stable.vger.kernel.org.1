Return-Path: <stable+bounces-235523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE8aKLBD2GnfaggAu9opvQ
	(envelope-from <stable+bounces-235523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F83D0C4C
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7FDB3014562
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C92777FD;
	Fri, 10 Apr 2026 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="g4DavnQ4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EF2BB13;
	Fri, 10 Apr 2026 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780779; cv=fail; b=awu7cmJB8WwpM9yzJ8YbNGpXp6vKieM64wXDknu8LO4Dk4Wc+oAg1hkWVASH8xxS8Tma4FVI80YzSs11mrshXcC82b10Q+4L49mIxVeE1HdcD3dlDKnxGerlJuxsJbOnLUiadSMe+XxnI488H5udsyuQhpJXOhvutqITyn3A9ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780779; c=relaxed/simple;
	bh=WUf96XPh8Jgvy0g2XgzOzqm/NEuGerDzjsA9Dl1mTG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nnz3PCiUyAT2bqovlCO6IqkvMomgdaXyyc9rR9hft+31fWVGwHHXroVy09mWKEIeJgS+gaO3ltiuRPS2BOMVHyc0UZ/oTZrLL338OYJk6A7NdxUTjcqbre6F/frIDutVw/I9bAeM3iT6drU3iwNTEk8S0Gu5DbdaqlX91aKP1HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=g4DavnQ4; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NE3BN3168885;
	Fri, 10 Apr 2026 00:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=q+
	wc2aandRkX4BigosdIvhsu8XBcL2cEbVKhUNsYj+4=; b=g4DavnQ4s+tUWH6PWz
	f5TQA4Pjxtam2mBGtORgqAsCS1zizTrmdr5lz0HS0qFmEjwBgg2PMqZYcYKQ0xuz
	amksTejcZqN199yETibBDd8oQcwSGy7OJh3zN1hChSYLZqU+l7GtrOxFJMdKRjHf
	R5JQ/KOn+pGH2pjK1p1Zo6fK4LTjMYGC+/j/gmL9HkPAvioRV+gb5YlrrOUuMQ34
	RB+ag5m72tINLdaXjV4hQfWRwiz07MQezb3zt8VQFeuksHNiSetZ3zc+QsmNxe6a
	hZQxhRXLzYcr7iCjqhGvnSyO6d1Q7We4MAYtq5WH/mONudDPBndSQjRe8Ft8sRdS
	Oc7w==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dee6wp54h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 00:26:04 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E192D80171C;
	Fri, 10 Apr 2026 00:26:03 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:25:44 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:25:43 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 9 Apr 2026 12:25:43 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 12:25:43 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Em8mqB3jUIfABX0QdttpbWKq9sZho91FqBTZ0sBdh/6ap2JMLHq2yiFYjo6JXAyWqzWEKFuUDIRlvbCLwHkUfqKTNCKYKaZOGYAh60VJxZsNxXVkPpeKJWOCYzdnlphvdbp2HDiYcoDqi87dBkyKDSteM5GdQCZQmIWxycKaZgLdRzR2mCsZ+6UfFWKmow8uFICfG7MFCLRNUh26XxW3trv1ZoJ7wK/oD7OHILtp16Jar6a5fftQv3hehxW/st2yVtjOkpDbZwGj+oJHL+c6aZseFZgLqYvtTr47GfDfrO2x2R8fYSEb/LuMzSsmfhc6oLcu8N1BJjYv/Rufn3FroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+wc2aandRkX4BigosdIvhsu8XBcL2cEbVKhUNsYj+4=;
 b=V+xBNqNae+nuuY37Qy40CF3SC7gMo1lzByEsJdLL2h9vrYdLtCdxpcsTp553yTWV07f0tqtMUHBGVyci4YUklGwq5rkRRaam8kVcmkxL2PTpwYVtJeI82dPSRT+dCpwIKiS4nJT7Le3gJFwS6sN8TmQwiA/rGHhzHt1SN9IhMT7mfHgiOmZVTPlIP/JIqGW/hqYVxL6aB7OozpzHjAIXjdY265XG6lzhVLx9mmiUq+LUwPcb0YLsLbFiJkk64aHAC/iaFgsruvN1mA1e6W+fpAFnhMjKThHZll5CprL9kjMHGTZKJEzQ/+xZnBt56oDrXHE94hmdm2CRd0ZPyYyP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 00:25:41 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 00:25:41 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@weissschuh.net" <linux@weissschuh.net>,
        "linux@roeck-us.net"
	<linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4 2/2] hwmon: (powerz) Fix missing usb_kill_urb() on signal
 interrupt
Thread-Topic: [PATCH v4 2/2] hwmon: (powerz) Fix missing usb_kill_urb() on
 signal interrupt
Thread-Index: AQHcyICQ/XrWqYfMuE6+p/JzE+QxLQ==
Date: Fri, 10 Apr 2026 00:25:41 +0000
Message-ID: <20260410002521.422645-3-sanman.pradhan@hpe.com>
References: <20260410002521.422645-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260410002521.422645-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1706:EE_
x-ms-office365-filtering-correlation-id: e62551a9-587f-4ff0-5f48-08de9697b29d
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Z18PKEnIdts/U5ncx66P0ZdmNG6G9CP8fcA4ilT8eRYVtI0zs4/oGqLlTVNotDZ64FemHG5Bm9rCT97mjmUUh7n4epMprydqQhH+xWJLcy03XWNFjDkGZUqeJ35N2W/JGpXWU0mKtXjZAl6IJgyqoGA1wz59x00YbFoYNojWYjmKyOVIiOMW8tcgYninzQrOcCGTTqGcPLZHoLUF4UFPxyWfi4C9soXJrzjzXKM8jEZgXdc1nLfRM7Q0WimsLOEu4PeM5/9kDxNoa6mYOLUpobKrdEreLEFdaF7g0ul6Tl4A0zB4q3BMgAcYWLgSLSL1u8fzvEYi8HfWqzvXTXHzygMSoEfS8KDW+ivdNpzKb+96CWxVO5x5P+A9tsDO1fyX27c4cpvGQIsQbJEWuKoDqyaTVUVhyAluLpzFmNnEB3X+VoR3fV6rMpsI4K1oygoK95tpiKVLqbHgn/G/DPs0MJzLsRl2yxVFi7S8wxrses992JQ4kEVSjyA5uqjnALZXgQHV6bfLHES3XE0GCtAZkYl9VcdmsCNlEUrlQQzJF4wVdqmrrtSkGFxiKT8vhsdcfG0co4pcp7+JXUmxfp1Ft8HqJm8us0UqWUTtpYlGkZMCg4sObobFuJ01HnbQ+a8rKMiDrpThQe1h12Dj9hLA5N7UepampYUpGo3WKvZ3d7iTUTArrNdcuOoFAQtPuh+giiK3lqTbkD1Sy1HzRCoAN0oUuwnpv9FEBeZWi32XBtxMArQfyVb8uPTYeSgtNsupiU437+FeBdycWQb3el+d0FJw2JgAXPwbkhQwQ0cVnyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hyr5mnbH2wAV9y9N2znNeSEsqcMQ3TT5xN7shZq/hEBHQ3kj3T2PXhJmbS?=
 =?iso-8859-1?Q?Q81xWx2We6H5awzYAXvURw9K20q7/it8enPgn90dipRBeDEEde5CHcE7V+?=
 =?iso-8859-1?Q?e3084ypptUhXcDUbpFuF1sgp7Lm94Dwwzj/yzynkQbxeQ8VaN/+3KaB9PI?=
 =?iso-8859-1?Q?r9cwloX3AwNi0opSPM6jKCTNbZ3LHPKXVBdwoKpvPo9R3QavEQ5YEO4I7v?=
 =?iso-8859-1?Q?4TssFThzcVjCF5RtthV3HinGiEYP3pUJ+bLcnIiP1XY6UQbg9chzX/pCzu?=
 =?iso-8859-1?Q?c1ZnX+IQwI+fHJLqpHqUrgRi0pg5DBx0LAhecxiPur60UKsSXchiLSieIV?=
 =?iso-8859-1?Q?BUZ/ONOCS0Ein67EBqSrvLPHs4Qv3P9B8PpQ1bhONwL60YYw1FLxVL6E2A?=
 =?iso-8859-1?Q?JpA80Qn3wFMsf1WzF37LAuc40nsyvLtKCkq+4qvpSCE9Kjl16fmC0FO7SF?=
 =?iso-8859-1?Q?iImeCtMgDUKp4eu8mEy9rQG/p9mpWY6LCtfOawPpQYrK388w+WVHXGMhJU?=
 =?iso-8859-1?Q?rtXF543fBo2NYqA1RfzEfNnuvdDlli7sFPbDGXloL08KGteK/Yyxg1pWlC?=
 =?iso-8859-1?Q?Bjgb8eZko7tpVj5L745g2EQozsEFoOSXqFWotw1wlepwxH/jhuN0TwqZ0C?=
 =?iso-8859-1?Q?9AtYu+EsRpSrnC56VXFo4at513enZWQ1CHXW1QfsKxkfjaGxqTmh+Z0hTl?=
 =?iso-8859-1?Q?1dDh+K5HeecsrvHUxsDiMlW2ii/hXCVxbPDBJCL2rLPd7piPNb9HMiKtuv?=
 =?iso-8859-1?Q?UO/QYJf8+3q2Gm8htfq1v6QCtK8rA2YFJJE0qUqBPFk/vuv2WStuRHXKHV?=
 =?iso-8859-1?Q?4dzA2Q33O/dnRO43U0qse9t7/SUtkREf3P7gW0BW0elVcLVmyvJNM5EmeE?=
 =?iso-8859-1?Q?MWbMaUQXNheuMl4UJSRUpXBcH1YDNr3dqmaM+ODwBAhDFgPjed68Dwl746?=
 =?iso-8859-1?Q?tAvRAoGA+y3tldKdk9bM0UPsoKNtTKOgXqahatf+TcwWHEBUEc/JMU0eOI?=
 =?iso-8859-1?Q?0kmArI1tFq5tm3ZhNksnZg79Jvjp7rBZ2PGqQLj2ZEC6FNZ5x8buw4fHQn?=
 =?iso-8859-1?Q?3pzqUV5m14p+RHjrV8gQmdS96iFMXZDuudAFk1IYp8XJAz0g+3+OAcVfPs?=
 =?iso-8859-1?Q?986TrjiOND7lQ5daZ9nXZ9u22xzmZa6JVRYQh54VtN8XE9MIAcYyGDhgvM?=
 =?iso-8859-1?Q?ybSvld/ws9u2OMYMqQoHk2Q5h/TS/+INBiARXMhb6/e44wTWy8Xn5hNVO0?=
 =?iso-8859-1?Q?DJ8s7Az4K2UNYjkqQV+MtW0TfeCu5h0hzmGRNy+1EYxpAxz8+4YkCuWI5y?=
 =?iso-8859-1?Q?RA7YaQIdf/c7wcurXBtGREOFgf+mI6MukIFlgm624CHJ48QoXepcYk4X+m?=
 =?iso-8859-1?Q?WBL5W9RjXxCcGByXgkQdoUb/D1V+0SmLR8DvezWgmm5C2WVszvg9KBMWDN?=
 =?iso-8859-1?Q?yS6OW4Kk3gAA9dvPCwDwvKjn5eh+6I+0BnRJ3zhAp6sNQIMfkEo45X7nBA?=
 =?iso-8859-1?Q?oGbibVBd5gMtG0ykxoxpYoQ09UwI7zKLjMWRitfGYi4ZToj88yBU0bLTkA?=
 =?iso-8859-1?Q?oEYd45cHwlYTpBOW5TW8uKCveSC/pUa1HgguTjEf5C2/si44ucwziEA+pf?=
 =?iso-8859-1?Q?TCgTWFQKIWO3+wp7aSiXs90Hr7RH0tvsFJ7z6pB+lEUeEKo7Upb3q7oILe?=
 =?iso-8859-1?Q?mvRwEnKReorEg28DtIgLFKCeYRNdma/xqKVTGt+nfppfKeCiAMesXNL5C/?=
 =?iso-8859-1?Q?Klok9e34fQR5WIlhPMwgg2G+gicu9K6ge/YaFLMGDOIE0Y9ZznCnI+Uei7?=
 =?iso-8859-1?Q?L9OJIrRjkw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RT6FUzYgQuKVfn0YvL8Z6jmXWzLzPz4lmOKVp6Oqb9glwo3iA2M4kMCC+ATt/A7MfCjxV7ZnzzcKMbHnliUoOSX+Umljwj6rbJH/HHNUzOrXsAPGSU9U9kaualt1q1J3vej05d9TusYTfwvg6KyQmtxh8gEY3cMUZ/iFNNEoi5YMfL59xtQML9v3+vKkRYvD0KbDNxY72sFP8TDiNM1D8pFItIW0rizJvhFLW/diLky+8uGp7d/6gUWRxkHP0EjMC71OCICZJ1poFxRFh8drIJQY4PDeO9rHhjSfPT4KSR8M5bFpLlxHerW7YhD+UVzJMp7xLseHDBKLoagTh7PLGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e62551a9-587f-4ff0-5f48-08de9697b29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 00:25:41.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ytF5bXd4aA1HHmsTgSSQPgg/ANiNl+hDmJ6W9lZkGedS+zAfpc+hDCQCn/CL4uxKVnckmxqz6uujDZ8PbvEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1706
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: xLlHf5KCPw6eqcpBnmvoHmkMwK8egJ3m
X-Authority-Analysis: v=2.4 cv=T/28ifKQ c=1 sm=1 tr=0 ts=69d8439c cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=sZCmHRT7lcuF82sXxaYA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: xLlHf5KCPw6eqcpBnmvoHmkMwK8egJ3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAwMiBTYWx0ZWRfX+3KOi7hsLAMl
 HLo5w3ve59idtlnE25KVNJhvMogLhDucD5yrf6bMywV4ncUSXJuIju0CX/UQymNrGLodqd47Tjg
 HpCWlMayEWc56QB6JOFELLfkKVSMQjc3zAWdBsLVNajnhsOiyjskFTUO6gkYC/ZW1Wu2m1RDW+p
 PWcrzFTjpyo7ftxDxpOwXaNO62YWA23MkJw/L/R87I8DVhpibj/gcb9l90iXl0lg12yaI61YBHo
 97FR/pHYN9WABh1bIl5LDx9HNgtAL0amdy1ShnhlAaL4QrlxVyALXSx2uqmO9MI5iZon+Zf7m0Z
 BE+Qu4+FaKWnKbp+BDMnLdiu9qjd66ptdSwHoHVZfB/bKJ++0cW4RQC3sdgqcks4g0HJNK4QdIW
 GjA4AC4XRqhI3+8NjzURGNVNapnkvfWqh9Lnymx0xpLxymoJl3fI1PQidzycGBeNmRFcv6QqtpU
 0S1JrlVmRbD7niK+ozg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100002
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235523-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 081F83D0C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
wait_for_completion_interruptible_timeout() returns -ERESTARTSYS when=0A=
interrupted. This needs to abort the URB and return an error. No data=0A=
has been received from the device so any reads from the transfer=0A=
buffer are invalid.=0A=
=0A=
The original code tests !ret, which only catches the timeout case (0).=0A=
On signal delivery (-ERESTARTSYS), !ret is false so the function skips=0A=
usb_kill_urb() and falls through to read from the unfilled transfer=0A=
buffer.=0A=
=0A=
Fix by capturing the return value into a long (matching the function=0A=
return type) and handling signal (negative) and timeout (zero) cases=0A=
with separate checks that both call usb_kill_urb() before returning.=0A=
=0A=
Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v4:=0A=
 - Split from combined patch into standalone signal fix=0A=
 - Use long type for wait_for_completion return value=0A=
 - Split ret <=3D 0 check into separate if (ret < 0) and=0A=
   if (ret =3D=3D 0) blocks per review feedback=0A=
 - Reword commit message per review feedback=0A=
v1-v3:=0A=
 - Part of combined patch "Fix use-after-free and signal=0A=
   handling on USB disconnect"=0A=
=0A=
 drivers/hwmon/powerz.c | 11 +++++++++--=0A=
 1 file changed, 9 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c=0A=
index a75b941bd6e2..96438f5f05d4 100644=0A=
--- a/drivers/hwmon/powerz.c=0A=
+++ b/drivers/hwmon/powerz.c=0A=
@@ -106,6 +106,7 @@ static void powerz_usb_cmd_complete(struct urb *urb)=0A=
 =0A=
 static int powerz_read_data(struct usb_device *udev, struct powerz_priv *p=
riv)=0A=
 {=0A=
+	long rc;=0A=
 	int ret;=0A=
 =0A=
 	if (!priv->urb)=0A=
@@ -127,8 +128,14 @@ static int powerz_read_data(struct usb_device *udev, s=
truct powerz_priv *priv)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	if (!wait_for_completion_interruptible_timeout=0A=
-	    (&priv->completion, msecs_to_jiffies(5))) {=0A=
+	rc =3D wait_for_completion_interruptible_timeout(&priv->completion,=0A=
+						       msecs_to_jiffies(5));=0A=
+	if (rc < 0) {=0A=
+		usb_kill_urb(priv->urb);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (rc =3D=3D 0) {=0A=
 		usb_kill_urb(priv->urb);=0A=
 		return -EIO;=0A=
 	}=0A=
-- =0A=
2.34.1=0A=
=0A=

