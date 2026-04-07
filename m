Return-Path: <stable+bounces-233723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB6FF6x21WlC6gcAu9opvQ
	(envelope-from <stable+bounces-233723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B23B506E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4761306A92D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44F36212F;
	Tue,  7 Apr 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WwTSoHCi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A337C901;
	Tue,  7 Apr 2026 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596963; cv=fail; b=GXikYQE7zwRbVHBfAN/pbkex6CnT3m/un3X2LnfNeKpz0Pc40wQeIjuQCASYnYmEM8mTmSnxk9ZbQ0+uc/fRE2hcX6wIXeDRjHabAEvVgQYmWtvtkKGPpGhcBER3ouMuy5f46UJlefWbCtX02gR2aqFC18gfiqUIC9hR0uc+Ssk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596963; c=relaxed/simple;
	bh=WV3Lgnv6zp+PNJrVPRJGDRs+6Jn+NaJUuDBte67TxXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZVLrz8aqzTgHWUyYt/xzOmZgFBVDHOqI5NwvPKCgVlGvAew4cqw7/9p7B1MY0rAW1m07L5odONjMZfSGlxkLWsGd8WwAGMiwQgVCSl9ZTKyYWp6TXwqIAwgg/mzPVfyZYsSd2zf7hom8RliFXJ8jMmKlWOBAQSJDhX0pR9fIGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WwTSoHCi; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637JfWio1671397;
	Tue, 7 Apr 2026 21:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=WV
	3Lgnv6zp+PNJrVPRJGDRs+6Jn+NaJUuDBte67TxXM=; b=WwTSoHCinKsxKJYCYD
	/MxEH18+hILy1arj9osHKCLAfNKILGeBiQX7k8eK5T/1YBZpdRS0Qg334iip2VJa
	OmVuA3t7VTtexU/kpErG3me80oXzysts28xEUj9Nqrv77vpmlDpuYO8gwFm9WDrr
	0nekTvmphUFm3FL73x2FCbDAdazFxeQl+dMC65iOL3BSObLcwCxsJ9ygSC1hhgAh
	7Tco8RA4JJODmiB06kFbAhUjgCBJBGC4ng8TGLdnC3XaprlYpq0Yoex8xhCi+YYS
	7Ki2wbjdVPtaGojpXZDo6G/3XtezAIMF9WXls1tc83hCGzFNon0YKFiikEZ89ZJR
	1q1w==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dcym78ffg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 21:22:19 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id EDA392BADE;
	Tue,  7 Apr 2026 21:22:17 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 09:22:17 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 7 Apr 2026 09:22:17 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 09:22:17 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIm5QiwXuHF/LyVwlMFVxZ0LCUIBuTB+gQb93Vl44nEoZQG4aqY0cwZGRoVc/hFqkZEpYPS4GkdwltTfbamnjGlY4IBNiCmisQK4APvP9oln6nLXNKs6J4jb3X6K0m4HVolRlvf16nDB0N/PHErHZXiuAYbpE1BVWtqD/SGZiTBw0zWAuwI68tKVnSF01Nn53+dlbng5KlIp9InALZDg+I8WA5Jbl6A6l3eWx9eDjhl2XpTXveKu7aiYSfievbHSHb90joxvTeT/QCE9+91wpCsdhxZiCLvo+iJcO4q2nkObtDNhxp2l3xBaBpEtmaYqVMyd/xoCw09aP//VQcBPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV3Lgnv6zp+PNJrVPRJGDRs+6Jn+NaJUuDBte67TxXM=;
 b=oB9PMnqK/hyrWwHKpgtrpE9iTdYf7cw7IKFHi1Y7EvEyjHMpDhqxTmhQAqdC/7XMf54RjnbZTNJdJ630iy+ZMWCm+XAaSpsHjRmIXEOmxGb1F3RUyPSbFo1FUrn0OtRyWAqECuqFCjLXiGuKifUr8vPNlExcfcBDSDDeccDI08uJbJhcK0H53QEXy8gEeW/DVi6OQwRbaHM+0f3F0eP6cnodp4cu5gP5vvbj+YWRLwTHPYvFPJaeKguVtEFt88yfpsnVjnlkVasUzWX9mpXqR/87HpQ9wvqItPyEB766D28veL768lJMX4Va9pcL7VMTCKAi7HOw/Sn9QfAHIYfsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV8PR84MB3787.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 21:22:15 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 21:22:15 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH v2 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Topic: [PATCH v2 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Index: AQHcxrVWLd/rOXZi8kyE8kQP654q7LXUG8UA
Date: Tue, 7 Apr 2026 21:22:15 +0000
Message-ID: <20260407212210.280128-1-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
 <20260407173624.247803-4-sanman.pradhan@hpe.com>
In-Reply-To: <20260407173624.247803-4-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV8PR84MB3787:EE_
x-ms-office365-filtering-correlation-id: ef2b1960-e1ff-49d1-ecdd-08de94ebbdf1
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xmrNcITAjenhynpMo7Tz4MGsBdsJ0aGwd/v4pu0h/iy2Qmx/VoaZT+w3jo4Xse5qtUyqLaGkr8CoePYJ2yfabWUDB1OB6jLXaDclZsxyNtMx0RDiGQUZoti5BiUeKFQSCrF8fjuljhERNtbAKhm49MAGoKYBU5WGYVcT/PDj/N/FRWw4rdN9qKYfiDS3fugY1wtc4qFc1cRVKj01XL3pV4u3EZ7jrDwy6AHTgsCEv96EnmBpxOIGXYm6ouYaQN3rfgq1kDbXaRuvxpHnuT55OjdLnPl7lmOomrIC4NyCPUfNEjGLWQShEfqg0R4bUzFOyvYoowA7hv3xCDDKiV9vFyYjwRlD5dNh431JzJTI2lj/dUkut1SV1HdugicMfPEn2GrdvihZ7iMBp84jfJo4fIDtzACC56FHIsbIBbsJgKSOSuE3vMJzaE7T/mGOZs/6aoGgS33k/AW9UfRt8Tog/kexIx7q0qZBs4/3If+SdcteRAflmU06CmS54Vo0/xI3FaLnXiBRhtLzCt47sObnPgJ89uG3uUU4nDlHqZ3U9aq120ytO/lUm+wMf+P6r8VG3Af/6tpdz3R32oET795sbevQ06DITZbIW9qWIR5897ZbFgycB/lYu14l3WSZaXHIcyK5iBbt9RT07NLseDp+fV7iI0fGQHhM1xc9rgwclBWK1WGBQ1S7G0xq49bpXdiinEx/9O5bk4kc1VlU9ftdtRbgRhPcZHI9yC7YEoW2PtRfDsI9T92/h1YQ9J7OBG1CuaAhgeXe9CWDc3s/A1lGRKMe6Ck0A6polxvwSlcqYfc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5YZvw0emXdk0pOo5jHGPL8NTCs+cD1KCGpeVwgutaoS1dXg0HedRSRNm8u?=
 =?iso-8859-1?Q?BzZT6m8LX8ZEOOYeWK6+qpYK9EOE4WvpO00s7ihPgBz0o9OBLI1Fgz5aww?=
 =?iso-8859-1?Q?UbWqi7L9I5XSx8CrGNqH7ZHvDDU5+xKP/PYjJGHcTu/Pgel7VOzyoMTHPZ?=
 =?iso-8859-1?Q?HY8Vhuuc81V9EM5FqB8pEGD84yZOaGMbPKvMTS7Wv+XIjWVnuZtorVGtCb?=
 =?iso-8859-1?Q?PNCkFd4/SHSWyMjBO5CzG3LTt9y7IL558rcHGZX7TUdC8FwCuCKJGq+8b5?=
 =?iso-8859-1?Q?Y9Rc52cPJkaUPPFOi0PxpwSLdtZE6YZituRB2h0yECjPLWPMep3celu4Ur?=
 =?iso-8859-1?Q?JgqNKJEzjvNrkUUbJVn18bU0vUufEidYm/cdRvgZ5xSP4EFxA2xX0KEEyg?=
 =?iso-8859-1?Q?wFv34X8xifhoLk0VEHyTHqDwvI74KnzUJRcLRXAKIDXvD+omlHC1Gf3fiV?=
 =?iso-8859-1?Q?poMYqZfkMXBOTxh0nmoNls8WEFIl2YrY1cwp2pnFp/DZ4iTfRhmdhKt53P?=
 =?iso-8859-1?Q?6yWSIft7klPBgpuYJ3tD8dulqyhlQGZWhvs578MxINfqGcK+hwIr05CL3U?=
 =?iso-8859-1?Q?6I0Y62yrJR4L9WA6QSZGT1NVP/0WWke9/AbsWRrRVduaWGBpS1qVxoq8Fd?=
 =?iso-8859-1?Q?c8+aXjBAkk3nDEfGkXUUHCRUCfTL3b0zUOr0NiUnmn77sGBPumehySbZRZ?=
 =?iso-8859-1?Q?UTsvLJHiJUCqFKyTvip8z71hq3tcdaodLiOsMX+hlvEBeW9rKLJnoGurOd?=
 =?iso-8859-1?Q?O5khJB9VP2orfJc7uRhW3bBNEInqXDb9KUuCyzKLvvwQYbajQOW5OBahLt?=
 =?iso-8859-1?Q?yXpZrAGOzKhP7bSrgkYWdHwU04U1zJ9OEgUFQKzXwPK134Lb+nJ+sH26VX?=
 =?iso-8859-1?Q?3y1ZcWVCrwKiyOqULfLhFOHF0KwqBh6HSR/jQCVNFByyw4+ksnDIT+RmKQ?=
 =?iso-8859-1?Q?zBzhbksdr1lh+VmG9qI6uil40HDAqBvJ+4UQp0FGUsvkPGrnzSPLrtz76a?=
 =?iso-8859-1?Q?gVG8TbMGWcpw3rPH91L4y7i8nyxHJI3tP9K3PZ15TLWPGgNCd56u29zWk+?=
 =?iso-8859-1?Q?n1f7MEojHoWcV7x3t73PbSUrTZWV4ZzyJNws6mg+3yf3XrPl6pU1YHz553?=
 =?iso-8859-1?Q?StY1DEM16xNjPHy0PpXPxIgGnPldg2bBplLbIJDsXXe2dF3ABItRhMZwlo?=
 =?iso-8859-1?Q?hik1qhpOlWzIXzR41t2elhavVQdZ2EkO3A1EHSAyspAySpxw+bxuWFa0er?=
 =?iso-8859-1?Q?QlDkcoj08aZOEYEmaRaNEcGOgqkQI1uCoLRiT2hFubuwEWNib5tmNG1Ds7?=
 =?iso-8859-1?Q?xAl9O4e9eRx9kFqPhaixDd4+ogP2Y8xi7Ob5VAiUndoV4C775U6FM2QdvR?=
 =?iso-8859-1?Q?Bw89MB31rUIzTU8gekOg0B7AFWKkABPO2HaLAtCvfxaw7FHFFUDrTWlAjr?=
 =?iso-8859-1?Q?wI5zdkfCAD5/WhSqIwqzSdEA5eUOQ1ygSIG2RoPYLMvJhuq2xyYoYLnoIH?=
 =?iso-8859-1?Q?3WBRkRT2Q8nI7JNR9fnXrEe0NqNRrw/JcSjpL/iugxPtUS4GvYSQkvwCwf?=
 =?iso-8859-1?Q?LuUZgJPvSEfApsaXnusWIlJjLW/8a5e/qlkusn1UWWfbbj3SSxMoNQ1bu7?=
 =?iso-8859-1?Q?ow+LxilLayQm6kJG/mOGIRAiVE0dWyvOjNVR0rF49ld31vW61fVxESvBIM?=
 =?iso-8859-1?Q?kHalSfM1JvrT9ZcJIOb8Egj3f1zrUOCg/Od5Ol+QvUE4ix6iToAlQAMg4j?=
 =?iso-8859-1?Q?A+hFsPvGUBEs5HGTLUCsNzYuuie1UlOBb61dWXWnYEeq+AkNVPgNiGrKgw?=
 =?iso-8859-1?Q?cA80oZLrzA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A1M5RDP0sjWKjcr9HeYioElbc+r5rK3hPMcqGgCmUfyLKPT7Wy7a1uHBLafJOlXoOz6MTWNofUBWxBu6jkKsYaPLwybCOmBh868nrostWWDWsl8q52PiOqYTXapSlrxOPBIhxJqlAKsrxX+O5o7HnrwpSrG8zDruPYFkHlmETnQHIfL1F3tzovpyOe7+ZAJdaH6qp4n8o/HhJrhX1wNOzCMB5ya/cPi1pF4J/lcMFP7C/Iq0IDehaSKr3Nxs4R58N49TjXNEgCun1vS3ApCvxa2PoNIWSf2yDCAk+vkKDgAFk28k9OPGfvg/asEsihqJgMxoEBWZ0iMP17jqiiaVcQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2b1960-e1ff-49d1-ecdd-08de94ebbdf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 21:22:15.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im35z/rzxsS1tLGA8FEEPTmxPMYvkqb/wVdJ1qf/tUQgUjvQC3JaBd5I77kR+aVI3K0eYRjXREA/E8O8fZfNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3787
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5NCBTYWx0ZWRfX1RNf4uZMDnu3
 cx+BjXwxtWbTADJJckSzGaSycoVfN66vVshXCir03C4NSdDiR+m6gFsxx9a+LZ/y4JueN1lsW9t
 af4UWaeckjrxa+1jD2wWGbfzjx/u5Zw5Q24VqFJdd45a0ILgC4XVbaO19yeANKMuN5vYg4FWOO0
 axVR+SW4VNca8mbSw4JKgmvCUvpt2F9JZewY3sH7j1zA6XOYpqwqB0N9DquCykRUQcH6UPhyPsb
 6h9kjeiapzRLVO8ddCRGYa5ucvpTuZRLovrUSBa0vtST90hfTCMFfV4FE1L1lgMeGp6q1NmQ6s5
 AWZ6+AbBrZmbJMXVgv0zqKQv/tFoE9L/3Lia+pxRCfFRR6R05McNYftG1OIFx9uBuicualeQf0Y
 vNRMBAUaWaH/tGiot0Ew8PntFkWCTFoPcUGWl54ZpJi7e52Jrpk9o86TKmenGXi7Jd++gKJ724N
 9wMPdrKBeAhIxviwQtw==
X-Authority-Analysis: v=2.4 cv=BOODalQG c=1 sm=1 tr=0 ts=69d5758b cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=BgA_JnIsNrVrcKxUYJUA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: UuUsvnqUIhD26M-2dLQzaUnKNtf-CAC6
X-Proofpoint-ORIG-GUID: UuUsvnqUIhD26M-2dLQzaUnKNtf-CAC6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070194
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233723-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 041B23B506E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Good observation in the AI feedback, this would be a pre-existing issue=0A=
in the driver, as this patch does not change the struct layout or DMA=0A=
buffer usage.=0A=
=0A=
I would prefer to keep this patch focused on the disconnect lifetime and=0A=
signal-handling fixes. Addressing potential cacheline sharing for the DMA=
=0A=
buffer likely requires a more deliberate change to the struct layout or=0A=
allocation strategy, so it would be better handled in a separate follow-up.=
=0A=
=0A=
Happy to take a look at that separately if needed.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=

