Return-Path: <stable+bounces-226880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLycOLWSuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:43:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A32112B00A3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69B3030A3745
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE837C10A;
	Tue, 17 Mar 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="TE5xCSmm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B237CD25;
	Tue, 17 Mar 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769107; cv=fail; b=nhl92ewKIGvQ0Suc1nvqnFm+aVzeitLrLHxmkclAaKgXs724NEUh7mH2R/Nd4awgwnLLyWaAVEUIk6bkjcMQfcmRKbxzqn7bdctMEwI4EekFm2NtXIf/9PXiZba+fDC4uBEMLvv9Ntzc+WmJEyay0jM/JODu/ERVNdCk9wSoro4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769107; c=relaxed/simple;
	bh=MPSS77YAlvqqswnclZmlGw6/NX/eUl3xdSw45i8l5a8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMztd3G93KmsHI0srBo/H7s1++WlUYc4ZZjkCweTLZQ3HDomv/zSufH2q3zSYBdzHvNWDRrsYmb26l3iVrQ46RK3pe4q5WCX7aR73HyJocIg36pvd5ceKypGIP84wFyMd9BalWS9X9t+nyymxS+LdPOwMwxRBEQsOfYJ+RgO7mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=TE5xCSmm; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HHS3LP3316201;
	Tue, 17 Mar 2026 17:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=VR
	W5Bid4bZm096FNdu9pdZmarW51wMO6c/SraV0WHmg=; b=TE5xCSmm5K15orOOgX
	L2qfvffyj6AZKeruugTeEFzUcl+XN+nDi1YA9Rj4SozlyWlzDc4RJBPzgND5Zarx
	7YedOxLi4hOYNHi5JQEaLE4+FxVvDutKrSb8AQAT6XbwqpMUkhM12O7TBfxeiyZk
	S+HHzmTQG5vic6vZO2iCJnCl2Zo/C+F1lG50VQ6qq/VhS/R0rkxsV6r0NEB50w0L
	MCyBnLLcOosHM3YzgphanRSp55O+JA0KNv6niO/7Stc8o92sWdDJDqmzDxnB9X7a
	rHeUWBN32toL1f7RCy/wikhFbKPFgTJk7LjDm2eM3MxB+Ro6/ophbqtvIfnkXks9
	K0OQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy8w02e3v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:37:55 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1A557295C1;
	Tue, 17 Mar 2026 17:37:55 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:37:44 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 05:37:44 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 05:37:44 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8mCL/wAu8RB9Qfh0DIdU9YhZLRvO+CI7dem60SsT24d8icTHYGGPd+pAT6aWtpC35cPIdQDVI7hLH5GKm+NBCYmlmEEEEnKeyR1LxQXE0oWhf69V49/QN0/akgys10owsiB7ZpWN+laLyim8M1hDVBTR7cSrZ42M8uXrpYRDGUTHy+1J/jd3Li6uzfNf8N9mn7mlDRgqGz35kEgxe/jj5JAjSo4jublW6CLBWfuAlTjQ39goMJWFDbURC6b3qE4tbYs6ER7awGKzh605dNpauoirmKc9MeL5cRDJYXGGkA53bVNCO9kctn/dlTmSxQIxIB+zvOfSSc1lPX3+xUoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRW5Bid4bZm096FNdu9pdZmarW51wMO6c/SraV0WHmg=;
 b=ecS+pSf2eKd3NRPT7zrkwhFnXPN6Le/TBb3AFaVFX5ai7sAg3dB2S+rPOr4XMamwNWCiroIaLN7w2lIezzOmpTSZohynRqxb4FAXA6xPM25ufabnJ4d7TfOuzgatoeXpZ/l/icHkDIBzpMyeQBx6vk2U1urcSO5l4lbilkOgqSHeoprPAVdUhBSegjuNx8joyrFzT4G1IinH/1jPoxkaLSHvihV5nj9ecVZtfXEP2aBxFSRRQCyAwJc4HmpBNB2SabqkJ0TZrabHlhAFsark8vwGg0z/6+UT8GLptVVkkUFegkcNvxlsdVsrk2nekOU7zfWmDqOaWGccv7+Dnt+d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SJ0PR84MB1579.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 17:37:42 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:37:41 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "vasileios.amoiridis@cern.ch"
	<vasileios.amoiridis@cern.ch>,
        "leo.yang.sy0@gmail.com"
	<leo.yang.sy0@gmail.com>,
        "wensheng@yeah.net" <wensheng@yeah.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 3/5] hwmon: (pmbus/mp2869) Check pmbus_read_byte_data() before
 using its return value
Thread-Topic: [PATCH 3/5] hwmon: (pmbus/mp2869) Check pmbus_read_byte_data()
 before using its return value
Thread-Index: AQHctjTBrk28lJYlmEixd7aWW8UM9A==
Date: Tue, 17 Mar 2026 17:37:41 +0000
Message-ID: <20260317173308.382545-4-sanman.pradhan@hpe.com>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260317173308.382545-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SJ0PR84MB1579:EE_
x-ms-office365-filtering-correlation-id: e5809ad9-c3f9-43b0-925b-08de844be430
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: JbPh5x+tK2ImiNioEXCnjVn6/dfd6TyMp1WTL+/S/udnYFix94sCZbJVPsgJamBSCzR1WyAzkMq7xrE5oYkJBeAXWYbC+Xysy19w8vA7R4hZhWD3+dvVSQUtjNgM/68I8dcAW4EUSt4YFXZgXgTInx9KnD99Q2Mzeox68l1qOmHQrtWwfTvTj55J7nQtCbmrdGdBZ0d26xIuoTDMXAj00PZ2ahnHl6gwldsD+YOOsFrV9WwMdv0P7aJRarMG/0o/x7JODf7XBZ+/+ZgV3hVv1nUOFTs20vumYWRfLoN99qgTD+jx7QW5vq7w5P+/iSFLlP2Gk2CN9XBZPqTsC3keDMpv8rxJr+Tz9uq+OivUGRHz9X0OrOUq/jY4tHYHqz+fnrR+ezaTHcKeR4/3Lb0Vr6TFN9LxdbrY6JOggkzgMNo93Ku+vqaN/LS5w8BCN8p/VO39rbY4RhDA44UEFhJGgXNdvMZcK15hTju06zZjvaKYWwsTF8TGbWZULkvVloCwtEGEGx9qo5gYja1+4mC0XPhwUXdn7lnp9wMCrb5TEPhtBO0IHOTL6HEcAmkTX9DQjHYvhbX2gvfPGbesgt4psTNNpsmmN1/OXIDR7f2NNznbBP/9Gxbcxuf3rREOQijpk1xMtB6m/vyciLSnb7CAG76gNP5NL/z5fW0uoPDiKO+UFcKcEpdaN3YCQAl9Z2h+PyajnUqmah4P3PJQA7KwsVRSqpSqsCvuwjbTQbPiY66ckeUr2H2JriOerleyCFO8papavDm7/nCQDHGO7/n2iZ+stIU9DZmzjSi7dNWB4lc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5eHwNBrpFOHR/vmjwotVo2f9jl6FMRKfH9C9HZN+qIWQxIr9EbcINfqjCd?=
 =?iso-8859-1?Q?GxCUy9CzDjbxb5azWn7lOELOXFvuL/b/UmT/UBQ/kjYSKMhNU+U+viL2xg?=
 =?iso-8859-1?Q?YzNLIU6mvZSeawqXiHDYcVI1C0BfOVDEWa8Yk/XzMubFjvV26DooJeNGhZ?=
 =?iso-8859-1?Q?yzEZBDeK7N4wo2/T6dr5XBx3W9q+exqLeESaltJBlK2kh2H3iPyR+y8yaJ?=
 =?iso-8859-1?Q?D6SW/eAfwyroM/loFj71gcxSkEA4nucLEnk+kwgYU/JWU0fpBeKPk5snMa?=
 =?iso-8859-1?Q?p6ImEkaAjeHtb+XXJauEdU2rfDkPpGWaWvdA8HuVD0llYFh8R7fqaULATe?=
 =?iso-8859-1?Q?OlOCdFulIccHSBg40acwYf2mkmVlWmxrJH95UzI9wieMp4EO54t7s0Vmw8?=
 =?iso-8859-1?Q?jcD4D7KU9fUCGUD3zACKDeoGHDPlDYO2uGZcgvHVqpPIPiSb5F8+PL2Db1?=
 =?iso-8859-1?Q?SHZZxR6TF8nlOyvnO+MUgcL8XYr9NfquZfMQkMgA0c5BI4xY27kBfYHyOm?=
 =?iso-8859-1?Q?eZS8QzH4brxm9pf1tibBovY5PI4m8JkzN/yoOBN7Q2QVTWFLNnaCHFu0xW?=
 =?iso-8859-1?Q?dY+sUpzhc//6XbPsqXKBD7UzomTJJGody645Zi88wxa8UiA9Zh0IIIaVwn?=
 =?iso-8859-1?Q?+odNiPXqp83lp/DocClv44EzeylL3UiN51HS5dHdMc5BNk+S2EPBhqAUvA?=
 =?iso-8859-1?Q?9Zj7QHEXzao7650zhky9P6Ko/cma3PCBjGsqFlL4CrFS8SxYK/5WyXLdsR?=
 =?iso-8859-1?Q?W4uQrvPUIjVpKRfGt9xlywCtAW/OfyZssO/Qr7H1pGG3mhNiFV5O18/GhT?=
 =?iso-8859-1?Q?je4Sr5qv1TY2wtIkgRxPPDtrSVuomIm5/M8mwS1fHaKlcqFd8sQyCjtnhB?=
 =?iso-8859-1?Q?MLwrK9ioXyAN2dNQeNxxY8es6jKL/AI4lPP6tsPlyrKupEe7st0ayd/8ir?=
 =?iso-8859-1?Q?AViuyNeZ9xbFVYeDRD5tEyl8hbn+O/mAEcGqg/2U6wReHOY5rCFkvkbGRs?=
 =?iso-8859-1?Q?PcOkA6sPsC3FOFR1PNUqkwTVsYCW2GJ/LyJ706FBJGMDbfQLg8j5JRRKIE?=
 =?iso-8859-1?Q?xhJ+u6a0vnp3wcU/WpgiodMD9SEub6/nN2vcQN2ZG5L9mFROL2V5z/q495?=
 =?iso-8859-1?Q?HmdXiSJOnqglJKt8XjbsonDiXNX2nhWFDQg0VeJB2bU29clpgnALQMUW2E?=
 =?iso-8859-1?Q?L3+Uhzr4218BMMjbFflTaHzWNKUbD11k0zgmsNA8s8H6PyUr7/ItjYRsZm?=
 =?iso-8859-1?Q?Ba3Gdc/kknMcByp4oQzamUclBB+cwVe5SHZLg5xG6B+bXFv5HPyvu0gnTU?=
 =?iso-8859-1?Q?7u1bAZ611FxTA/uLRaj9J5Gcc5dJrHRf6NsivGBmnCNo1p5LAMK/Dh5CHd?=
 =?iso-8859-1?Q?Shiaz4CvpjYJxMrQTv/At7AOdF4z+dy+3lfVzG0XhBscK+LhInqhYb1AhM?=
 =?iso-8859-1?Q?CMwBV7YTyzsISHV/uAqGWDRHcRrabJQXeWPVldMtZBNkIXYlLsDxOg4BP6?=
 =?iso-8859-1?Q?AgL+9o/jRppWFwTFLcgNRCVDZ6rgG92rq6Qjyalc12//pCDbcLnZPLWlXp?=
 =?iso-8859-1?Q?cPA7iIlOeZhbgiftX3hwgr5wmJdnMKafw7E3RG0R+zCKOphJC/MEFDZQfG?=
 =?iso-8859-1?Q?8h23wN9ESV3s4GYoI1RNwekkXQ5skJDm/1kkbobRF+vOt0yhqRl06VkaCC?=
 =?iso-8859-1?Q?6m01fiLI6L7GJrg4aZWapE9FJau9kq+5pPinH7x0SA1F9XWiSqzJu+T+Zi?=
 =?iso-8859-1?Q?7u7iLOWhhPJdHJM5xh2uAuajzWeb6GUDP70T1MPcmglZy1X7jiriFZVacA?=
 =?iso-8859-1?Q?ielGqRDRuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rXz5umLRZGTjtTMuM5D/chtoedyiwLVj9+hCMOaXaeAX//Xwv2AZ4e/tw3uesBnw2ypzF+jzWa4h5Wgp/IDcgucWT45Zj1Iw+rcPRr5A6h4d/WSEEXZ3B2D5LZ6wTCGQWPrg9N2Kn7Ef6MZk8BV0eygcUCvbx5QHdGCFBwO1zAgO1sb79OaRiDLdbGclTqHVI/llFx816QTfbuphBqa3sFobTEeXOP9wPTeVKM9q5bQ7elFzz9Cism0KJ11TgAAIAN3YjtdEQ6U8Z7wBvZUs/8XMMGqw2EG86EzfGfPDbq3jwIlVwxpsugYQxxj1lYCx7TVLxijMcKaQN5xZJW/KHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5809ad9-c3f9-43b0-925b-08de844be430
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:37:41.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPzWGhpcU1UpVjXQH+qlFxM9c1PYxkDxVOfAN63xBxNxHrOnB4F2aqPPEAz5TK0VhpWy5w/XJmJ7IlVZRHJk1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1579
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 7TYXVbhRte-ludLIMjGP-BGVG-lOOiF-
X-Proofpoint-GUID: 7TYXVbhRte-ludLIMjGP-BGVG-lOOiF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NSBTYWx0ZWRfX8nCtZns71vgp
 5V93vdHXbpNm5LaSOJEbxpEf7B0W1PIUEbs3vmWGcmYsPEliQuuVvqjmBTQnTNvSkcyVKYtHQQN
 7y5qUfCV6J6GMrN65VFBxRhgTpc/BbGlmXXRw0UpiCK54arNDZHdin8Am61BhuWOKDBpWpTYyKn
 z68mrrrmSHvT6FDL++T8Ip1Qd+ScGk9VmyM5Excv2pXdm802cxM3WRvdqCBFISsVn1VISZFRKEW
 91ahA1Fp/dEBEpY54HVzyUU/SDlN/Fc150tDZTWnXuE77TlXllZVPQSnaGcaX2hKzVa3SJWAeds
 O4KKQZf4LsDp8aYCOlFmCG9MO66R2W/2GZZQfaYGXpbIxE482Ab61fpkLQhJSNS2WWzJue8fZ9V
 RsDZ6PfLAuqG6p6+QHGBgVJXDt2K1yEWZrYuH3UzqADY6dIkTXTBcqHSJuy4oh7UfI2KrZuLfLe
 aZ/UYZRmJNyeM8IxYDg==
X-Authority-Analysis: v=2.4 cv=XOI9iAhE c=1 sm=1 tr=0 ts=69b99173 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=EPlLE5ChSBWFTWdH95AA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=wPNLvfGTeEIA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170155
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,cern.ch,gmail.com,yeah.net,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226880-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A32112B00A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
In mp2869_read_byte_data() and mp2869_read_word_data(), the return value=0A=
of pmbus_read_byte_data() for PMBUS_STATUS_MFR_SPECIFIC is used directly=0A=
inside FIELD_GET() macro arguments without error checking. If the I2C=0A=
transaction fails, a negative error code is passed to FIELD_GET() and=0A=
FIELD_PREP(), silently corrupting the status register bits being=0A=
constructed.=0A=
=0A=
Extract the nested pmbus_read_byte_data() calls into a separate variable=0A=
and check for errors before use. This also eliminates a redundant duplicate=
=0A=
read of the same register in the PMBUS_STATUS_TEMPERATURE case.=0A=
=0A=
Fixes: a3a2923aaf7f2 ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series=
 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp2869.c | 35 +++++++++++++++++++++--------------=0A=
 1 file changed, 21 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c=0A=
index cc69a1e91dfe8..4647892e51121 100644=0A=
--- a/drivers/hwmon/pmbus/mp2869.c=0A=
+++ b/drivers/hwmon/pmbus/mp2869.c=0A=
@@ -165,7 +165,7 @@ static int mp2869_read_byte_data(struct i2c_client *cli=
ent, int page, int reg)=0A=
 {=0A=
 	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client);=
=0A=
 	struct mp2869_data *data =3D to_mp2869_data(info);=0A=
-	int ret;=0A=
+	int ret, mfr;=0A=
 =0A=
 	switch (reg) {=0A=
 	case PMBUS_VOUT_MODE:=0A=
@@ -188,11 +188,14 @@ static int mp2869_read_byte_data(struct i2c_client *c=
lient, int page, int reg)=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
+		mfr =3D pmbus_read_byte_data(client, page,=0A=
+					   PMBUS_STATUS_MFR_SPECIFIC);=0A=
+		if (mfr < 0)=0A=
+			return mfr;=0A=
+=0A=
 		ret =3D (ret & ~GENMASK(2, 2)) |=0A=
 			FIELD_PREP(GENMASK(2, 2),=0A=
-				   FIELD_GET(GENMASK(1, 1),=0A=
-					     pmbus_read_byte_data(client, page,=0A=
-								  PMBUS_STATUS_MFR_SPECIFIC)));=0A=
+				   FIELD_GET(GENMASK(1, 1), mfr));=0A=
 		break;=0A=
 	case PMBUS_STATUS_TEMPERATURE:=0A=
 		/*=0A=
@@ -207,15 +210,16 @@ static int mp2869_read_byte_data(struct i2c_client *c=
lient, int page, int reg)=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
+		mfr =3D pmbus_read_byte_data(client, page,=0A=
+					   PMBUS_STATUS_MFR_SPECIFIC);=0A=
+		if (mfr < 0)=0A=
+			return mfr;=0A=
+=0A=
 		ret =3D (ret & ~GENMASK(7, 6)) |=0A=
 			FIELD_PREP(GENMASK(6, 6),=0A=
-				   FIELD_GET(GENMASK(1, 1),=0A=
-					     pmbus_read_byte_data(client, page,=0A=
-								  PMBUS_STATUS_MFR_SPECIFIC))) |=0A=
+				   FIELD_GET(GENMASK(1, 1), mfr)) |=0A=
 			 FIELD_PREP(GENMASK(7, 7),=0A=
-				    FIELD_GET(GENMASK(1, 1),=0A=
-					      pmbus_read_byte_data(client, page,=0A=
-								   PMBUS_STATUS_MFR_SPECIFIC)));=0A=
+				    FIELD_GET(GENMASK(1, 1), mfr));=0A=
 		break;=0A=
 	default:=0A=
 		ret =3D -ENODATA;=0A=
@@ -230,7 +234,7 @@ static int mp2869_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 {=0A=
 	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client);=
=0A=
 	struct mp2869_data *data =3D to_mp2869_data(info);=0A=
-	int ret;=0A=
+	int ret, mfr;=0A=
 =0A=
 	switch (reg) {=0A=
 	case PMBUS_STATUS_WORD:=0A=
@@ -246,11 +250,14 @@ static int mp2869_read_word_data(struct i2c_client *c=
lient, int page, int phase,=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
+		mfr =3D pmbus_read_byte_data(client, page,=0A=
+					   PMBUS_STATUS_MFR_SPECIFIC);=0A=
+		if (mfr < 0)=0A=
+			return mfr;=0A=
+=0A=
 		ret =3D (ret & ~GENMASK(2, 2)) |=0A=
 			 FIELD_PREP(GENMASK(2, 2),=0A=
-				    FIELD_GET(GENMASK(1, 1),=0A=
-					      pmbus_read_byte_data(client, page,=0A=
-								   PMBUS_STATUS_MFR_SPECIFIC)));=0A=
+				    FIELD_GET(GENMASK(1, 1), mfr));=0A=
 		break;=0A=
 	case PMBUS_READ_VIN:=0A=
 		/*=0A=
-- =0A=
2.34.1=0A=
=0A=

