Return-Path: <stable+bounces-233708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFAGISFC1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:42:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676B3B27F9
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D48309680C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CE344DA4;
	Tue,  7 Apr 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KPdVNiOc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CF2BE641;
	Tue,  7 Apr 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583527; cv=fail; b=rNRwqpuP5xTYViwX0IrFPXcGKpuOhIuGdp63EPY1Nbmv9geepeA4bt9RFC4uh7YUY5HbUd4kqNrQsx5gaAKafPNHwecwR6p8OIa5MgCR/8ZubiIiKIyCRx3j31luV8N4mzliVYOOpvDB46zM7j34d67bVRIR4NuKsl/PNjSx64I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583527; c=relaxed/simple;
	bh=HFrLt45J1UQp8h8ZrqGelFsxHOyM2rtfX2unLq+Y0a4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3Q+vJDaQGB8O/96wfaC1mLVhtLtu4bk/TPPqvBzwns1qBi8FVquqMCjNUmsojF6o2uvVzsmduH4MCpRo3FQjKm1em15DDMnvr5HuiC7qrSpEXGMII6pF1NnVDiBynMRzE3VXMGjezx3cvlqbeRNg2SYpXiEApndL4c/vKjxo4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KPdVNiOc; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637H0ttI2551180;
	Tue, 7 Apr 2026 17:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=zp
	IwRPk4BQ6djUBerbiFOdc06K4jQoo7d/LaTFVO/6w=; b=KPdVNiOcsfp948A9YI
	bxr/P03Ppf0PF19q4s9QF6n/A0k/wZlusLtuDzSydpcGT7AHgcjuBFj5KWI7m/0W
	FC1naiDKM43QXKZ9Le+8Bb5+/MC9lEEAuAZXy/poxroVagCD+0PYY40J+gAU9hpk
	GyuyQ2h+pjucWUDSTUZktChMbA/9h1yO/U4XbOvbQjJeEzBcl5EBJSbofnr6+gcb
	vC4iYo6X9ujClmKv4FKrngwmXdyLDGnRBljFxuGQL7b4iDpUyt+nF6JthyvVixyZ
	R1aLDt0B0+L/K+DkgNpvhsloA2uAGazQDspQoyfRg5wMWmPpvY4FcWz5sqzPUyYY
	64Fw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dd58t12y0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 17:38:27 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 60451801712;
	Tue,  7 Apr 2026 17:38:22 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 05:38:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 7 Apr 2026 05:38:02 -1200
Received: from DS2PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:38:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO+/4yv9gls84f3QGCfZyZnW/W0DODFZus9Za9M3CaYPBlWzVJOU7pzqlmpXgRhG3Rm44GWW6NooXn82QifVAw8YSf89nDxYvnpBuNQVk2tcMn7xy9ynswD09NYzfFkz+SWUvWKaNaa9EDauOrF9VRVpCgYXIgtq3v4trBBW1UNi9wy83g7kQuphMKAY1xBuHPrW3jvUrOR6qhzUac2+WGQtEfQxbjauw+8i5g/xaTA/Af7YdgSaPoN2yQWucJKb2KAAEKeiM69t7AaVTqxGpaenv0y1hh8D5/bvVuNm4qyO096B+AUsk/8T86tw+/hWe9UZIUdlPCpe8u0pyXb3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpIwRPk4BQ6djUBerbiFOdc06K4jQoo7d/LaTFVO/6w=;
 b=u0PlQMC7bJTu68bWn80+xTPfgUiMVvQue+xNL50op4G4l3wca4WgaTmzUJ8sX+veNOidSJ9FLwx29I5P+Ep0V1rTzT11uQGKpzbT4W3QKRyj534o6NDhTt4h+kAb0RC1mrrsxlAp9Y8ljdi8XEqdR9hORJEbK9V4riEODU1H39BT3aKw1alrztwHSf0cT88fJEEmJhvZSMELfvwNsS55U2CWFSMtRwloaNE6LSFZ4cP8fAoPCOJRmebxYuYgS43BdEeknAI8dDfaaJwXPKCSsFdmkzxo/0PoU5II3/wGsylUE6EoQqjBmGKeK2cG+dgOQkJZbfCYTYmNwUvguzlYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DS4PR84MB4043.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:38:01 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 17:38:01 +0000
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
Subject: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Topic: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Thread-Index: AQHcxrVHoCgEpn0KpUWpNGAfFRFIfw==
Date: Tue, 7 Apr 2026 17:38:01 +0000
Message-ID: <20260407173624.247803-3-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260407173624.247803-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DS4PR84MB4043:EE_
x-ms-office365-filtering-correlation-id: 454e7814-6be0-48ab-0c8e-08de94cc6a57
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: +N+IeAQr9oZuhoHTWTCYTK8y39Ob6gxiMSBIsjRDP2e18QlwoB9fnVv4E8kV3RpedhMIBlzfpO8vNt/WRiHUt6N/9yg9us/7PdmpNut90lSecy2jyxsaFyO8YqiAQCkDz+HmLOVcFejfg6lJjBHq74UskmxaZG+HYLPFnNzr6w2o7GP/xheys6F6enCTzQbvF+3DWhj17tFon9JX0M2K/udxkomEoBI/OmymNctt7lkPfaWlIv2JsfYLO9Bv/0lA+QWpOCafGZnC/vhhyovfs3+qWDuNixM7g/SNRRgjeDjso9mwl3YKQx4sQd/qIZeQYGsxrm51A38LOncWuoNaCF4/mXBNHz09qfvW51nuZPQPoQUV3yo4zB63TN6ODxHMWlJBun1xWS8wTwWBRn2CqNTuJatMwzCvk5lZ5jlEoUIqR5lyZVStLGLTRcP1uRFMYIVfWxgXzyd12Il1/xi4mnjotao5LChd50KHd4nh2aIEv3NAAC4Oi9mgOwmosxbNi5l1C4aMriie9Yf99k6rqrPb/olxXoAA4/N14RbZiyBnVR2jlKMcmVYc9IGzRfV7np+OEjxZWQfgQBJTO+sxk9pscXY5f8WQeVAbXXCujHXEe/EIp+F/048B3P4hzmk7NpXAWsBkOpleandogBd8m+pvAtVEeXaYRgafvA/hui9LdiNZNFwV92u0tclt2LPt9Tlq2j2SongbEYZjVvz0FOAJghQ+7Ni2cktMJ3/3qPhcsKSc7UCNU761n/KbMfd/wRyIEC6rfIFvkDLpHdO9GcsqUUyZNBv7XnyAYxP4kzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cAILaHk+cHI1RH0SMZ+5EMWS+Xx1FwxIsvMPUh0sl2tz47vUJ8MPK4YLf0?=
 =?iso-8859-1?Q?7S/w0I7jIosuI8BH+jBSiDx+TRM26sQuC9BSqjlhcT6D4jdITXWFd9E6UF?=
 =?iso-8859-1?Q?SaNZIiAmmgbJ0pA3zRQRedyniaXvK6nzLpfgOZvxlRZ+cIDj80wPxWabVf?=
 =?iso-8859-1?Q?QLvsXKjdbbuNKonjaSJRYuZTzdoWQHFs0LDh0oD5Sv2BsTPXJTGTxey2X+?=
 =?iso-8859-1?Q?+3wEP23FL9kMxCw+XqRZtcnNDRSqYPOgwSo5u6Tjzz7cm1pvMcng3PRDKH?=
 =?iso-8859-1?Q?pC1CvqAXjjQ9zmsrduchPFM2b0PHHK9Pb6IX9kNFtvaTS5oWGBFuhRDbxL?=
 =?iso-8859-1?Q?Clohgd73klg3mknXgqv6yc4c5dig3b1YXKYcZPnbj3O0/GOzmclFxkyB7l?=
 =?iso-8859-1?Q?tM8eW+BbUsWSuk9gN6QP/Z4YESWYcMbp1qAiOCMWkPX9R5w8mMME9E5etA?=
 =?iso-8859-1?Q?2fdMa/WrN+FWL+K1cyhLCrPhzoVQ+x7N+eYVEsyHmxRqYrp0QI9pCU7ZVn?=
 =?iso-8859-1?Q?qf1nu5+HfxmSt82ewT+ZSubu4XMvTxN3P1YLvd/o8I37dYr3G30Pwzshp4?=
 =?iso-8859-1?Q?GXFOlffRUuQJVXZieCjW86I2PHFO+m5iYVQlVOSeCP3fIMp0EB9nemyLHh?=
 =?iso-8859-1?Q?2tsgv8vQQX7ml+eKOTlMPZqfFZfu75rCuNI8sYCrFZP7UtE1Z9KGN1txMP?=
 =?iso-8859-1?Q?VYAb9NLfiz0Xxfy9HhKTEckmLGyny7bcMjioCyzCsmH083ajjT5CFxG58H?=
 =?iso-8859-1?Q?eSqasmdGl5ex5Y9/sDa5U6THOC+l0XfzhFpGYyM7iKHaFiIgXAR1Bv3VVC?=
 =?iso-8859-1?Q?buPj5h5P/K/1nlhLOW6theMadt5PJ93PCZCU0YveuIue56UkV9XiX7Vucx?=
 =?iso-8859-1?Q?4QE4q2FNVd8KBmf9dOTb0hnekzswuW8e8xl1QC7WHB+BCjao+9LtvTMp6K?=
 =?iso-8859-1?Q?f7UQ6RZ7VhZYSEVjokDyWynoYoLl1mv64LoqNew1pB5aTTdFkX07KjIS6z?=
 =?iso-8859-1?Q?omA9Uxxlz8Taeel32BVGux5jodVUyUEEswpURfroyx743NNa8hY41vhYyN?=
 =?iso-8859-1?Q?N4oVCpCg2hlAxytbnuBkASWSNk1MUg72zPoPjBOCuFWEjHQT2H+X6Mdqin?=
 =?iso-8859-1?Q?YJR8Y4W4wy2HZvr7h6g+fW1VdV99bXrWcSyM6GyF7fWvBNK+AKpg8It5C0?=
 =?iso-8859-1?Q?pcVTKYJ3dHfSl45HmMhgdtWkr3v5jU1yFwEqaYz9QAMaJ5wdF6VV6cKOir?=
 =?iso-8859-1?Q?mqjodbBiXNenU3J44bAtO6R9YyIJV4xw/1Sch2dLiFEvTQFvZoHRYDOM0c?=
 =?iso-8859-1?Q?yvfrv2aDRviybE61Q+A2KYu4Zw0cixqWGZ+zkWBTplqmrtIa+ZLfqMpBi3?=
 =?iso-8859-1?Q?IEySBabAuVTbf5c5g8bMGoK+Wzbr2R3VKgMVNNDqaYlkQgvfiVcWJTeAkD?=
 =?iso-8859-1?Q?/WXdzkU7k3h2rxEp+TOk+5lQRqutuL0yGhGtYZTPE6kmMIzym33m10/JDJ?=
 =?iso-8859-1?Q?F+R7QDy9ypABFIMwqwwK8nyc/VFJFRW5NJRCrGfCtU/+7ZaL2Jx/w6Sowb?=
 =?iso-8859-1?Q?Uo3IuDqQwAuhA7RJuc/p/5CQbSeRwngR5WxLAt6WOvsf/PI/hHa3nRkMNI?=
 =?iso-8859-1?Q?z4SW5MC14lZ8TZD7B/OOTXexIGmWBsvu06zKrbBIU5B/yFqVL8ygt7l+Hq?=
 =?iso-8859-1?Q?J6b5guMEyT5dAGEetz6qs9WzGkGSM35YUPEQjvQ/Rnbz39daxrBH7xHAmo?=
 =?iso-8859-1?Q?uk+cRJypEeuf8JFtzEXOZZFWj3xVlAkF+l+qTmMZs/qchUSZnfOLB1E6Z5?=
 =?iso-8859-1?Q?acG8ZtTMdA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Td3CQGK+jJhw5wPHPZx+lW1KoYXJ9MxmcHrpPoX1qvDEo02KeSaQsA2Aidqn5IIW2v9u557mtyxb96gmotZ85zy/SpVAXK1HWmva0+VMLnScDDdtfhCmmvnGowaI7r2TT9w/awWopcLj8GXGYvXji7kRCdbK72M/pW8k65tUjfg2GB4by/o8qyU3T/ISByMBOiMoA1OZldtSokv9ujqR8CY9cKacT8LZ23kXdznR3QanXhA1AELv35/BWZU7rRVAW+c1PUbu649j222CGnJNSdNI8mHEtief3dy5Qcj/iXEacssxVzLy9g1D7frBPDAW5Ae1n1qZwp6amc2QbqdhPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 454e7814-6be0-48ab-0c8e-08de94cc6a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 17:38:01.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKg2gcxpof72jlk0vPxUlslJ0OLhUSmqo6u5ov9krZALsXoBhMFhN4Lw33FMStLtaY0pEkF6RxU7KGqbdvyH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR84MB4043
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NiBTYWx0ZWRfX9XvAApaWFQdH
 wUssvXM9lFZ8sXAVQOnCfHYoKn2qZkyeAAlJ/usUu85jxMOszLIWcU5wBOnjBZsjAeKut0NoJx5
 Nb5/Xo9sh6lawQQ3hEdCIWdQNLzwOcmhy+aHB8eitf1hQcFy84x/s4APyOjgKQ9+VZvAhDUTY3K
 wpkte14DRLqL0dmLc5NvXVyPX82VGmHmpOKKpop3N44ybinCziotyzPtUVbqDbr26nJlY6mtJum
 lT1tGUGIKg0dfHKvC01fX/gSn4c6XNSVDXghw6NqsC/MPYikcEU3Ep1IwaCP7qwdZOo7WIRTjL+
 HcEMVUqDRpBOWCmJDq/1Hy9vuVP1iACE4Mcym8Zx8w422HDttOEo7VyBW67deziKkHTLTIOgVaf
 qmoSPN0/xWQEq4VV2bYoEKRByHyz5ri2ULkcd/94dPyGxeaI9HuVwmeMCQc9qTWTCSZ2kfiikuF
 GyFl/mDX+bUeVhzjudQ==
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=69d54113 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=kT2SCdrF01qjGp29COUA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: QPO30WnwNOdzP5OJ9Uurnfw9dW9dADym
X-Proofpoint-GUID: QPO30WnwNOdzP5OJ9Uurnfw9dW9dADym
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070156
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233708-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 2676B3B27F9
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
unnecessarily.=0A=
=0A=
Use u64 intermediates with div_u64() and multiply before dividing=0A=
to retain precision. Power is inherently non-negative, so unsigned=0A=
types are the natural fit. Clamp the result to LONG_MAX before=0A=
returning it through the hwmon callback, following the pattern used=0A=
by ina238.=0A=
=0A=
Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power moni=
tor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
 - Switch from s64/div_s64() to u64/div_u64() since power is=0A=
   inherently non-negative, avoiding implicit u32-to-s32 narrowing=0A=
   of the shunt divisor=0A=
=0A=
 drivers/hwmon/isl28022.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c=0A=
index c2e559dde63f..d233a7b3f327 100644=0A=
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
+	u64 tmp;=0A=
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
+		tmp =3D (u64)51200000 * data->gain * regval;=0A=
+		tmp =3D div_u64(tmp, data->shunt);=0A=
+		*val =3D clamp_val(tmp, 0, LONG_MAX);=0A=
 		break;=0A=
 	default:=0A=
 		return -EOPNOTSUPP;=0A=
-- =0A=
2.34.1=0A=
=0A=

