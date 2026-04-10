Return-Path: <stable+bounces-235524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DDkK8pD2GnfaggAu9opvQ
	(envelope-from <stable+bounces-235524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:26:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF33D0C66
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A468430247E4
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353B27BF7C;
	Fri, 10 Apr 2026 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="FRS3IrDe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2B27A123;
	Fri, 10 Apr 2026 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780784; cv=fail; b=U3pFu1xhvjegwpJye72hSaEn9znI5UBLSbhBPMIRqgmksX8YCH7efe2JLnBO4YM0zs7BF61IMPq1yIxBUYyCV7/zF4hzcLIgnJ2s+/skWuPNqWYOn7rnOU3n4ca0SQ8JDwPG84NZ5v8nWiqEwz6e5butrNNcrD2u/J9vQevVhYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780784; c=relaxed/simple;
	bh=1IRoogkDHryvygIyCVSiYDW+UiJxtdpkLk3JfVjH0W4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BUMfVAVCFxiQxP4YESOo44xVQD9GB0FSdB5RdY4r0VhcOBlPjYq6rdiDCKoF4v7/5r55QAarR3H3FZUTpYFBM4lVcn53q3c7LNCBkwwm8JB+FlqZNkjoNPZQqdvGCk27r3b7lDbGT+8tGxV6qttJ7lmW1piDC385Sto8FrkbGjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=FRS3IrDe; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NDvgO3116492;
	Fri, 10 Apr 2026 00:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=dvRmfbohwjkFOKWNSzS7Z8/3
	OcC2Tb5uRLhdKBrJL30=; b=FRS3IrDeMa4VEF0Dl8xOQ/TgfxUOzkCH0hROCF4P
	v6w1TZtgWpfpON17Bdl+q2okNMIvnSFnkykpCsgnnQqxshfZSlNt70KFEQ+03i6+
	t2mhvSIUVYVxGfHL2wAW1witG7gXEbcUWx33xwZVxqA/gOzC2o/vrtzwrJhnsl4Z
	ukE7b9kDl5K2I2XWfcNTa7Kb0t8syyN3VET6CowCUGVpe5bp884kcDlcXCfwy70W
	GO3QHMDaLJ6mm7Rb5zRjSkt8OtFG49xJfmlk4FAA7Bj2cs4vePDKvACnQxI7tADd
	IQ1t7nyuzLswaYfflB7/pE4tlg3St/q1G5Bceu+B7DkcEA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dejkh2hmq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 00:26:05 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 3162A801705;
	Fri, 10 Apr 2026 00:26:04 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:25:58 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:25:58 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 9 Apr 2026 12:25:58 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 12:25:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvpCnbXYZzAde8hqiTOxkEw/cEjNQeDyaELlai0ZX6zosSvW05fgU6CTRNyk5aLtolUEp5+Xrx+T3G+41vyZGHhTmy/mshSeQ5UgnyOi/9ZDLOALgryV0SdY9+vbvp+KHC3aNIs9C7aSWZ+YqBZ/XcKTdvJ1WGOqsPOi5DJnMkQvOoz6vgxmSvqIM+17Qr9n4dfKpfo2UnDX1Jj/LC4rDW9T81ewNhBwds3678gwiljR0R1TR6UTS2hthWzk+CU+2P/TkFZX2nA6z/+VDJ6ezT0SXrh+iTQkVWgFpgiFgBdY1qtTZb+GfpXZBtslVIyc1boBLJxJBYFNXaTsfgF+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvRmfbohwjkFOKWNSzS7Z8/3OcC2Tb5uRLhdKBrJL30=;
 b=zTKFWoWcAVHgwNfpUQzf4Lab6XPM5iS2FxY9TCAyUSq3iHT7H0XvI4K9OKlpE8Mn5S5E8XXphDMb3Z3Hq7OkvmjYo6tMBnzZcaIL20buhHMU8hSQnpA0EmyspuDLgbM1nFM3t/cB6GRr5pgeOIrhd3317lFElOL2gyAHsVF310pDGYT5LG1koeXzI8CKlUsQz3EHAEu7kT30ZglwBnJ3iVWsQwpXTnRSjbfD9t0n7DH41ATEmllXTt0AHVzNY5znorMNI6hHJKkAOBVqzHEgLkg1q33mlmvfKOszpRNew2UhsOQ8+yFFRVqN//VTrGc0rnOAsr35YjEZaQvGcY+Rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 00:25:56 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 00:25:55 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "cosmo.chou@quantatw.com"
	<cosmo.chou@quantatw.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Thread-Topic: [PATCH v4] hwmon: (pt5161l) Fix bugs in
 pt5161l_read_block_data()
Thread-Index: AQHcyICYLgf3zyKldEWtFo1hZdnLBQ==
Date: Fri, 10 Apr 2026 00:25:55 +0000
Message-ID: <20260410002549.424162-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1706:EE_
x-ms-office365-filtering-correlation-id: fa7e108e-3685-4770-8c52-08de9697bb32
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: JOvD6KXVKKPmXok5no3+0ZMkaM3D13m4JIBs71cbJrkVoBTItj/Y2GJzdIjLN5OdAYnCFPKfiXijSABNhG9744yqpvZYz8cdmvePAdUk1CCoBSkdM3957maKzxV21eco9HRQ+uGhc8VxveA6YoHqqzI+qd71Ht4n+sMCjqhqc3EaHHfKf9+AqKT8FDt9Ernt5sHBYDfOeletYkY+UgbhQ6e+RkkfFbbI/G2IB4nVPrlj1/wg02MHBMAA3xgD0mHoxiEFD1SdtjtqEz/LrS8XeK1AIfMSCsNs9pM4hKZSvCxNQek0MFj1kRdBhEjFGN1AuDHor2XuXZ0xatl1UPPYwS2fLzgg75B6mvR2Jt47EnH5yDQMZ8iuPNc5lVarSZ6JZujXUa8JhO5rDct8NAaw6Zy6h+VRarvfZd2QgAYrSsAvK41pj5IRFS67FTzvoWigKYQ23lnWTxfoPMzFsXlAomd7+bNXR598G2k15AXkievv0aXhzx+Yf9u5NHyw+18MNxnG4A36x5KLAnCKOHllx93Hs3CDccLonlxcvRXm+S0OIteob6M8elvISNJyuIGXmQiz1LwonS+HEXbueSoGplgu0Pn3dNCDrRPoOyA80182qFCakvoC+zHsBePanWVb5bPW+0N5Wxh8VvJ1o3fSeBbl8a+Isq9euAdcPwOOMOViMxVT1MonMT1EtS9rxrNq2Qqi/cLNgyNz6dvOQqt69RZami1sqawSmrcEzVbZGdnn6Y5VRZEzpX94Szcu644GJoPFfXr4WmolNZv5tYz2N/n6WuyYAOpMDEPFdaN7g30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H/VToBoqKAZZETHSavOFxrmyU4cyvwJotEsGSiKR/JNmwCNcD7RRiYNZXH?=
 =?iso-8859-1?Q?lupuDf6Qi1BdhYWUTlkgIiCfpNZyMCYUHRAJQ0Qab6Zqxu+swZNEoEFnSz?=
 =?iso-8859-1?Q?kf/9dTJYlu70Oe2zvgPDHW9rsqqCNLNv3eKWBkIlkfkI8c/vVnnwgjCqQJ?=
 =?iso-8859-1?Q?fHJjUeU5pGqxm07KLVkDM4iu3ANrl1tnQUc4QGVYYYY/89jPDPW4+cJGlF?=
 =?iso-8859-1?Q?pMT2Z26JeENvvyjSYsDD/nu8W3l02P4HUvKidPPmwE7H0kfBEbw6yz0vJr?=
 =?iso-8859-1?Q?LnAKKPpuwevemW+PIphuGzllPTzqwamjHbxjIOqi0LYRJ+h5qrG7mW0BwT?=
 =?iso-8859-1?Q?KKZNYLADvUnsL9ZD4NkHLfcne9O5VLtmeNqD3bI9fRcdRmm8u1Vqm+BFGp?=
 =?iso-8859-1?Q?M11gM7jWmRBaIk9L7Xc9ibP6ylqZraMvkA8Qu0M7FCvM4lyELrwKzhgh6w?=
 =?iso-8859-1?Q?t7w8oC+03XiXlmpFzvXW1niTT0/91AXoVpgQptjRFBKEsZUWypxvCYbcav?=
 =?iso-8859-1?Q?urLu+v36Z+1TaeH47QcXG/YncjNAy0gEhWqwHjruFCyuOWTFBZV+ziejdm?=
 =?iso-8859-1?Q?6ttwnkrCdYsGIVrNC+yOYBv6x0ye3dFvulG0ukqzF/R126Y7VmZdV2z/uZ?=
 =?iso-8859-1?Q?ojty9lp0SghyhTrRgeZOk004bVbG5qsm+o4LQcme/Te4OZAmrzdrMs3t2Q?=
 =?iso-8859-1?Q?wzl57+cvnIj9krJq3RLrt4TGcMl1hCFIsLxPrFP3dvD76wDCF5eu5hUTPz?=
 =?iso-8859-1?Q?KSdixts5okxHx+3MkYLvdicQPlf23uXdBWzhNpHM9VcdiaUAAtVzIPQpzc?=
 =?iso-8859-1?Q?Jg4RsBI1MqE9euh82EEWZKuL9DUF2UYIE2Pj1eNKHXOxN/xw6yfdGwvoiM?=
 =?iso-8859-1?Q?3JDnIi0xmukpspuG3wWq15yaSiy9FW8KOThROsuTK2019O2kiy2WmabZ9M?=
 =?iso-8859-1?Q?ymNczSjeNcyU+A1t1CG5HRf5pSARTI26FBojPs6iuhhunx+BO8S/6JUtju?=
 =?iso-8859-1?Q?jJJw4utqK6QMhu0N20Sa0NKVn3NI5UwVLMQu85ya/efP0Fk1cw52Ga4q5X?=
 =?iso-8859-1?Q?cdq7TVIlMZbw0zrk37csWprKmZWoT5MdawMRa418o0F9E2KQ56p9EzyNpS?=
 =?iso-8859-1?Q?hTkuWY+HPICVpZ9H2GuW751OI4mVd0quDJOQBKe0I7tIiq+mSrkfqHoXhV?=
 =?iso-8859-1?Q?x3HQXV1WZOmO3wCceGLyJXmQWKEheQGllAmYw7j0P50WbQ6xvI/RdyGTa8?=
 =?iso-8859-1?Q?lR6KcdcKh3LiepaFojodgLI6NBI4SDVHPtCPcMrXWUCTJMQQavqGk4HSrJ?=
 =?iso-8859-1?Q?PPsWCskGgUwOqe2j5/Z/+UTwUnhxWH/6C8wXF1+ADit5waVHfFQBaBp3fQ?=
 =?iso-8859-1?Q?/G7+F1013q5mVsQXhtinNQnjTg2Y2A15Sfve6nM7YryECbIOG0aLe6BlMr?=
 =?iso-8859-1?Q?jsATbI3W2i7wYJAUj+B97NIWzqzIVlz017W8ueyP2nF3/J4xXZVInlSyNX?=
 =?iso-8859-1?Q?ZjoyWtgegiKPABS2FmaB4LrEXcIa5AtmRIX7iaazUNdTHSLAilr6wPn7zd?=
 =?iso-8859-1?Q?j+dHK6aEfDcEq6yK+u8mfrf01mPJGev8BJ509dqEgRD7qDUVZ6CwIhoGGB?=
 =?iso-8859-1?Q?xocj/pwTO6y6nggvJWItMWlbdRI0BTWFkOswv/osDn2kTkyyqrpYkGNxPR?=
 =?iso-8859-1?Q?L+o96S0YlfLKfWbeDaJFNLus/QtM30j1uSykLw1KX3xDSxftCs2Ew3Za+n?=
 =?iso-8859-1?Q?9oZNpS/Xq+1mNsUD/oFJT1Eoy39cVSMDxbZUAk3hc9tUOZkVC+JOh7cbIY?=
 =?iso-8859-1?Q?o3dNhY5kYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ff1lZS+fuSM1q5izhTJepUkezljxtMATQHUImWtY5o2gpn6hutCXcTPrS/eFKJZZKoVOKGRhdD9x6mfZwGjbPltfk6bWw7SOcyFzT0qqU8I8MUmUjilj7wH58Q/jOibuVe0q2jrBBJV/7Y9B9IkFfKI1p6mKVO9gJjGVbkDiaOwIqFtCmLpDKnO3MDGCa8ramNOY2eoPO28YtRhXilStnsveHVt2MD4OfWLnpmzKhpfsGwYfjcFz9sgehRhMzGdNAZRagwGLQmJ2LNvJfPmVvwvJsQIRRQu8wHPvkSIY6DhiUVMHhvfLIxWZRBD/wfRYoUk0AMGPZOBoqIsAfhP9qA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e108e-3685-4770-8c52-08de9697bb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 00:25:55.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: No7RW2mcF9MxV6gu++e4yKz99nbn/zy4BQjP7nxqSdEb12bHWdGz78nwIg+aNuyCacgDB5DKsTcv9bEhgxQHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1706
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=d53FDxjE c=1 sm=1 tr=0 ts=69d8439d cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=2miM9txUn0MiwXLCYL0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: TGGOZbF8iE0vhyrtbzq17eCkPOm-0Rl-
X-Proofpoint-GUID: TGGOZbF8iE0vhyrtbzq17eCkPOm-0Rl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAwMiBTYWx0ZWRfX1ZwSCAJXugHi
 jL+JTn7UKM8T4TKX5duT+ZIP6qOrbe95JWleMHeetPiTuMYY17/n++arv+RDkXCzdS/2cjBDgQ8
 AhiS7wkx0EKUlWvNa8tPXg53OxrVuYRYrrj0mR6SDAyc0XGdRMQM1P1OegXtjcJkY5TRWhw6S2E
 zfXfBrR/Q4eCct72hlmjTrw00YFT334I+wAbyKL0Dyp3I5Jj/u2uTkcRo+i+ypuYoswbgK/8XBJ
 o1v3aMOglt+Fxc5TG85rAMppjarPw6V4QJy6xYu4SdBk+iHPx2ac0R99inrQKL09ousG8rBxEz0
 0mkGrwiTWmeK5JX2gU4e5xTFIPYupmQF0g/0ycOQuhaB2lJSBG+N2dSayoNZ0X3XNBmFrMoP10i
 9xsV5KjhmqEEKOeFQccSJw+cNxuOLwGmbJSTNFktJUPVW7dJn+4GCzkmXsvu9opRAFrQq+RFw0l
 5c2PHnpTvsYZgRt/Leg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100002
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235524-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 43FF33D0C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Fix two bugs in pt5161l_read_block_data():=0A=
=0A=
1. Buffer overrun: The local buffer rbuf is declared as u8 rbuf[24],=0A=
   but i2c_smbus_read_block_data() can return up to=0A=
   I2C_SMBUS_BLOCK_MAX (32) bytes. The i2c-core copies the data into=0A=
   the caller's buffer before the return value can be checked, so=0A=
   the post-read length validation does not prevent a stack overrun=0A=
   if a device returns more than 24 bytes. Resize the buffer to=0A=
   I2C_SMBUS_BLOCK_MAX.=0A=
=0A=
2. Unexpected positive return on length mismatch: When all three=0A=
   retries are exhausted because the device returns data with an=0A=
   unexpected length, i2c_smbus_read_block_data() returns a positive=0A=
   byte count. The function returns this directly, and callers treat=0A=
   any non-negative return as success, processing stale or incomplete=0A=
   buffer contents. Return -EIO when retries are exhausted with a=0A=
   positive return value, preserving the negative error code on I2C=0A=
   failure.=0A=
=0A=
Fixes: 1b2ca93cd0592 ("hwmon: Add driver for Astera Labs PT5161L retimer")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v4:=0A=
 - Submit as standalone patch, no code changes=0A=
v3:=0A=
 - No changes=0A=
v2:=0A=
 - Also fix unexpected positive return when retries are=0A=
   exhausted due to length mismatch=0A=
=0A=
 drivers/hwmon/pt5161l.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c=0A=
index 20e3cfa625f1..89d4da8aa4c0 100644=0A=
--- a/drivers/hwmon/pt5161l.c=0A=
+++ b/drivers/hwmon/pt5161l.c=0A=
@@ -121,7 +121,7 @@ static int pt5161l_read_block_data(struct pt5161l_data =
*data, u32 address,=0A=
 	int ret, tries;=0A=
 	u8 remain_len =3D len;=0A=
 	u8 curr_len;=0A=
-	u8 wbuf[16], rbuf[24];=0A=
+	u8 wbuf[16], rbuf[I2C_SMBUS_BLOCK_MAX];=0A=
 	u8 cmd =3D 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */=0A=
 	u8 config =3D 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 *=
/=0A=
 =0A=
@@ -151,7 +151,7 @@ static int pt5161l_read_block_data(struct pt5161l_data =
*data, u32 address,=0A=
 				break;=0A=
 		}=0A=
 		if (tries >=3D 3)=0A=
-			return ret;=0A=
+			return ret < 0 ? ret : -EIO;=0A=
 =0A=
 		memcpy(val, rbuf, curr_len);=0A=
 		val +=3D curr_len;=0A=
-- =0A=
2.34.1=0A=
=0A=

