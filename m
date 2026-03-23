Return-Path: <stable+bounces-229969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEUUNcNwwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:56:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A802F926A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27F6032170A1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61E3BFE4D;
	Mon, 23 Mar 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ciJY14T6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC483BED40;
	Mon, 23 Mar 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283766; cv=fail; b=IO+b9w3tKu2CaiHQ/ph6Wvd9wSnyCv7+OGsB0krdsooQsVcADaVmKv03ICPiSHPjLlgaefrXDQ/TIOwEAq6d8AFHnTTfbW+tCNEYTkdBx4ObdkNSeE+CcA9H3meHziX3JGUaYvXR9xyaGJkDSMc+z0PrKGFXdpXEqNKu9j2EOI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283766; c=relaxed/simple;
	bh=OrB4ExPVkLJcoBa2CX5ktTf6ib7+kHjZiZFjEkFgtdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARVHogzbn4n+86rhTB8eczPNkrn0Wxr3VHOlw2G4z0ENCKvxJCryOkHsJ7bGI9nFyXjWjRIiv1lLcRnRI05a3N2NVA2fuRbgH397bOm2+0Iw7bsl6xFvAJWxavRMwuZk0qfqw2II4Y3wDnnwf05YVIV2u1QkD0WmBJ/l8IBlrPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ciJY14T6; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NDu4bv1613260;
	Mon, 23 Mar 2026 16:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=5z
	Ain0sLZhMun8yp1zh+o/N0LPF0qMWLcSmB/l6MztI=; b=ciJY14T63mFxVUGnR8
	+2jTLTyc33f2cNuiKdSnaCCyQqsyEF1G7/1ciK5ojowXwaxhvuxkFXOwRlnoXiS3
	IXjoznP0YPQYieo09mPpv2mY9D4l3q6dWphfhawENtmm+VO1KCxz9goQTAyAAkqE
	zhATgPr62kApmBEunOIDlLfkokKc0r3/ArB567ulsJuySquz/h6Q52q6SyUdCpuJ
	URoonUWVfCS8D7iVaBOlzfwoKrFQAhYRxpSTJULfwAB2xTpXki+q9c11fIywB5pr
	zwrNJmQ7VoU0Lx4OvjgSDT86js36WUkBti/OGVW1I0IhwmRmhMspLzfw3b6H/jk+
	9HPA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d36uca2jh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:35:50 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 781AB295D8;
	Mon, 23 Mar 2026 16:35:49 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:35:29 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 04:35:29 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:35:28 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrfYZCSN+VrEmsqS1bnRDjDwgVmK7AXMlYdWb0s2ExM8YZv5LV3RlcZ3lFreN64ogvVMd+27mh2wulCHrOYAk538GrneKNKNfx4Hmsdu9YXbNW4pqwD8XMJIsjQWWiVGadwXI3Jlml9mXTAn5WhcrFfBtifFBgje/BgSVuWqdvD/KrHLGcEOggKH4OXmV5N3QgIXgkwLHzYiqQ4/sDbhxRTIkdSFoXaxTNwLJ0qs1dSD6xcG5VZsjDl2IFuT4m4lzeTMfgIddIkBONjC5z+H1I/NFtlHVaDbvWly4x553QFrhx5tlwPrv7nxEFzgSV0DeAUNm4xKY+x1nbrDOc2ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zAin0sLZhMun8yp1zh+o/N0LPF0qMWLcSmB/l6MztI=;
 b=b3qd4u1MP1syQcm/pCJrQDmhwOOp77JO2sciGLQ+MShP0avjkDgM3hSnPZ0IJHDRyOgF+Sq8jGWqeS0f5Wp+x9pDCLxww3i1RA1moPBPwF+/HFqL8+ddsaJFfSfGH9n2NZSlecdSnKyBIz/IsgAHJ64qBvLBrW0uP0v+vmMlXA2aEFXqbiM6BhIzkKiiNEvVycMrVrCxUErznwz6f6aB8CHLAq1BLEM93v3VvkSF5Gjon98fn4FPkTwChmNKzMspkou3URQkVi4ZkMiJCHWTsRS6tRDmnxNbTCtvZREqJcoeIKOyjD/wSfr0DrjGRuRJqRjgeBJdIKQy+zVFl/MVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:35:24 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:35:24 +0000
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
Subject: [PATCH 4/5] hwmon: (pmbus/mp29502) Replace raw I2C calls with PMBus
 core API
Thread-Topic: [PATCH 4/5] hwmon: (pmbus/mp29502) Replace raw I2C calls with
 PMBus core API
Thread-Index: AQHcuuMMbjq6Jwugnk2MmLLWEpoV+g==
Date: Mon, 23 Mar 2026 16:35:24 +0000
Message-ID: <20260323163343.183186-5-sanman.pradhan@hpe.com>
References: <20260323163343.183186-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323163343.183186-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3819:EE_
x-ms-office365-filtering-correlation-id: 0abfc746-a78b-42df-4181-08de88fa2ef4
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 0mVI5ISujf5DIAp3HHgtIRt+vLPcp6r8AXTiC+WoJN9f9xMraboJ2YOZvsds1fGuorsPgz1cqpyI5MKWzh6O+b9WEDSkd4FN95iZblyWJGjQ23ozcq5KQjpWkCY+mEmZ5H8uJOUSYBllcTr2Vaxhy2fJb8M3FAiWlfnhF0I1f8IKWaFDVDgF2b67rOLiZxGSzTTf5ArDHPjDgzdwPPiMrGTHd7f36lAw2eojJA1q9dZyN9VZQFSSwURlfNtPYAXEorez4i+FhkuNaq5h1YTsMwyT9B+5y0JWR4YRYsmlGhxfq3jpbeRBuBJykSIUjF80GgrvAHLWEviGebW3w+mKsVl5vbFEJvCr4JkttaRojYgNXJ5khQNvzRQr0zNn7Kv+id1HMyVg6qzZb7HN5lq9PmJkTi+TvGlWR/Lx9T9TJtLTq8CCmdaCFsDZc4Wwyj8kBO/4mwwu0f8vPlQVGHvzmI3wUeppv/fNqsIz3X5+AFOGabPNbfQlhsjd2ZJLJgca+rC5Gfp6oOaU2N7Ajzl8cqfidlOqk1ACkv/eKh053oNqpmZyFqdNiHyzraighPIMr2Fm8qZ0Sj0U6B2XybbP9TIwulrokCR2+wwk62n8EmwlntZBDBpYiEEY9vMDAPcBHyC4lJ2GtF9onxIB5oKC6m6DQ4cM5ATgV3Bk/Fq5Rat3W5a++tE3EKtajqIDOu031a5k1YoPEM29EsOMjj1dEt5WQHhrmkSPp5q/onSv0ZUl9+dXxQO6T+EL7SaoPpceMdhZTXT+jTiDKOnj4GMgFOREZtKjEMYZQTyeI0h+WPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E4e+ktxPfHk8YWoud9oXdTHdktvRhkDW6hsWxbS+93i8xXxt38abUgBjKu?=
 =?iso-8859-1?Q?m3z/mno+iY7j6BWEPuqOc576GNoqvg//EjVkcUwXVzC+EhIvIqJU/1rF/8?=
 =?iso-8859-1?Q?hr+reWDhV4MIvZWv00lqFxBWTJu3r18hDgeAWtDyQIXw3EBaWFm461JP4J?=
 =?iso-8859-1?Q?nKsnmp9yO1jrBiGAFFPYuEVsjOZGhr2qkH+pZvEskeMVHIihrY3OYM/g/e?=
 =?iso-8859-1?Q?HyPdBFRbaXfwDMCwqHMPZcYbr2u+M1VRflEf873QNGWCH/f9qEZCSOoJyQ?=
 =?iso-8859-1?Q?DQJgXM/8OA6GATZTjWtYUWRoo3LgtFCbeK3NOc075BTSdvcPzRX2i9zlx5?=
 =?iso-8859-1?Q?HBIHuUkbrC3WzdiLmhrnenqoY40HDYwTYKu8NJltVIa40iXnOJQUwD3rQo?=
 =?iso-8859-1?Q?7G2loMzqN3z9dL0/unwb2cWGCt04Nbk8bzFDt4Zx6k15wiPSnQ8Khyk9cC?=
 =?iso-8859-1?Q?X/RbxDfQwMbn1EpcZL7uqWVZwDsxixloWv5yJz6eGbfbHrXU8Y86zpwHRM?=
 =?iso-8859-1?Q?rVP0DnLP30OXNMOk+WVQxI3sPKXAY5GDo2n7nAClkFIoNVzVOFstHYST97?=
 =?iso-8859-1?Q?kPOojd22epz/UGJGCuJtqw+KPR5r/L5T6018yySsACHveOxjFI4RfUg209?=
 =?iso-8859-1?Q?ln7HwP6doBcAVDv0E098YA90+1jbVXjxkdpeK2SavdVzpHfTTnr+aZj9Hh?=
 =?iso-8859-1?Q?j6Bjt3blhPm2PDak+afoYSBBKd7kDgpZbyaw8/bI1c3jhrbVp5D29uWFbe?=
 =?iso-8859-1?Q?YdobivTQbVYhhLr7sfRYZHXyfuNb0khb9pLBGhQT3+j6itQwBqkqTCe0fM?=
 =?iso-8859-1?Q?m999gHaF35ykTVun+JXNkg48GfS62YoYpaXuu1OOONn3sSa07rvvSlPq1g?=
 =?iso-8859-1?Q?wl804zQzi/3GLAAsYRSg+aoOiTJ+SGYltiTLA3iVa1KIKTKa+u1EzH6PRk?=
 =?iso-8859-1?Q?rOuGAKOnYHxuK4iNiZuPTgPik2Z8Lzg6eY3l9dIGFQW7dpValiOjrDdXyC?=
 =?iso-8859-1?Q?48jXGJHaPylG4nF8pdLUVh22+ArRKrgUruZW3QoyA9W6GjD/F2lFg35yuC?=
 =?iso-8859-1?Q?oii7Ixsc558wdCoh+XgBKt4lnSBLqMWSFEbA8HSaOS047iqBszLua0HBcg?=
 =?iso-8859-1?Q?vzXf9/CcTlGERhyGPK4rRtTMu7jl6IY6RNLLCTu1LJR/D6AGdMwBGKDI6w?=
 =?iso-8859-1?Q?y/1+xOklqwhOv9a3gT4W/h5Gw3iSDzbpgy5/OsBVXvdBk+IoSTbjuAT/VT?=
 =?iso-8859-1?Q?6rDEAdr9SqUtGMcPeTAjxZkumdk8BilrNTTL7u0495mp/FLSxBh5+XEfR7?=
 =?iso-8859-1?Q?2OzDZRDKyzbjTMXAdbr7LYFV0Mil6Vjr8Y51jcBORwyHxrAJca6dbt/pXF?=
 =?iso-8859-1?Q?3R5x4BaUNMbjfTTBEeCOdgRyeVptUu/lBw5G3JRqNk1iyODOT3lcsIQTfS?=
 =?iso-8859-1?Q?Fb1X4lYEjQUzQ7+71OU0/UqYdZgLr5zbbhbTcM3fUbjGZ6Pv8FxhU3aKM0?=
 =?iso-8859-1?Q?vab6lbDHYp31Mb8xNdG/0tsVKxPioamPFC1FD2QpY/On7XN+pxHPHqELsP?=
 =?iso-8859-1?Q?yzCsNU4ykUE6CU8vbHv1o75m0DscHiZbNd+vA294bdV8mXx4iyMR41a/g5?=
 =?iso-8859-1?Q?t/S39+Rm40JNMb/hL9zUNI8YcI7fMWfQnkZV0L3UPVogPpk3NwAUBDtEdJ?=
 =?iso-8859-1?Q?mFBpximZmj4+3FvDwzdu/Y4FroEBb4bqbArmoixx7fxzbuU8HLN+I94PNc?=
 =?iso-8859-1?Q?2K4OArx5rgHSySIl/JQL/YwwiJPjQxKh6oj1Yw0Q0EokFY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hiyPit2swqXxsqLdpYxgNllTMowJOGb/ZnhMMAm/AD82Q8AAPXduRmiGiAuT+W1cD3Lj4VRdYxTtJmrsw9y/Jn/9rbP7viFnW73ss7nUYtWKwcqgzrMLBLQ16Us7YPH4Z5w9wt99YQHKqkgWTsEKBzBJDlC7XSdEZknx5PsQ35ZxPgrYJB7YmwUpjioFolga+QWKYxcQfB+20TY1oIbFH4ATraHiT8fjrSURZYkAMXu7U8Yl4IoQXyT/ZZUtLgM0RXOU8y8fQz3tmVvzfKy/d5OCX1g1K/qXcUbXojLsGmO5BOF7O7BPA5xe4npL9VUOT23T3t6nAIHPcwfLyhhYgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abfc746-a78b-42df-4181-08de88fa2ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:35:24.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysZLO1HcBvw0TJ86w4xaTSFNHXENDw5MJhBMShZqEJTMiDcRGz0DbOrT1B3YJSA76LoAu7f4e6OcmWOICDnj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3819
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNCBTYWx0ZWRfX2RIzxcGPnNqd
 29+WyPpnBd8164kpZ+1t3wpMaDOGS1xkIzDc7Gzwi6qkKA01KqfPek5WvlQvxVeY3SIWLsi9iZT
 I0XYsyYhlXpYpoBBUvHtVztRD9x0ML/tp7uD6BVF6R0Dbq1z2bBD/TDc3WwFtGl5t1QgI3stdyl
 ZgomcAkdC8sjp9Mg/ep7x/6HS7Nx4zbgdB9BE3xG2PgzdHFlBs0crq9ZTVvSHwKpSoz1lxh1AQ1
 ZjW4wVQP53H/cpWvnxabHMswLgRckd4ig/VtA5hmQbQJy6pyjch52JVn1B6HgtrZlqkr7J5bgIP
 b1vjNW3f1OVpKyBWJWTHf9xUlIqF9wCPdDj0Myi6PtXrCC7X7nMK5wtnC1e9EEG2rbM1nvWSQdL
 KfbFFSsXafq++suGRewk/yY6P8DNpR72KyjEdHBaEKPy1lf/RL4Sz7DziQGiXpuQA/0rrsGDt8O
 2cph2gZnfyFOjwx46Vg==
X-Proofpoint-ORIG-GUID: 8VOyk9GucQqWQGClqcGAbn5ghZ3SVWrk
X-Proofpoint-GUID: 8VOyk9GucQqWQGClqcGAbn5ghZ3SVWrk
X-Authority-Analysis: v=2.4 cv=KpdAGGWN c=1 sm=1 tr=0 ts=69c16be6 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=0ch_ZG7wXMlDUe8ALHQA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230124
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-229969-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 79A802F926A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The mp29502 read_byte_data, read_vout_ov_limit, write_vout_ov_limit,=0A=
and write_word_data callbacks use raw i2c_smbus_write_byte_data() to=0A=
set PMBUS_PAGE and raw i2c_smbus_read/write_word_data() for register=0A=
access. These raw page writes desynchronize the PMBus core's internal=0A=
page cache: after a raw write to PMBUS_PAGE, the core still believes=0A=
the previous page is selected and may skip the page-select on the=0A=
next pmbus_read_word_data() call, reading from the wrong page. As a=0A=
secondary benefit, switching to the core helpers also routes all=0A=
post-probe accesses through the update_lock mutex, closing a potential=0A=
race with concurrent sysfs reads.=0A=
=0A=
Replace the raw I2C calls in read_vout_ov_limit and write_vout_ov_limit=0A=
with pmbus_read_word_data(client, 1, 0xff, reg) and=0A=
pmbus_write_word_data(client, 1, reg, word), which handle page=0A=
selection, page cache coherency, and locking internally. Page 1 is=0A=
selected explicitly as the OV limit registers reside on page 1 per the=0A=
datasheet; the phase argument 0xff indicates phase is not applicable.=0A=
Remove the manual PMBUS_PAGE writes from read_byte_data and=0A=
write_word_data, and simplify read_byte_data to use direct returns.=0A=
=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp29502.c | 68 +++++++++--------------------------=0A=
 1 file changed, 17 insertions(+), 51 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 1457809aa7e4..aef9d957bdf1 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -210,31 +210,18 @@ mp29502_identify_iout_scale(struct i2c_client *client=
, struct pmbus_driver_info=0A=
 static int mp29502_read_vout_ov_limit(struct i2c_client *client, struct mp=
29502_data *data)=0A=
 {=0A=
 	int ret;=0A=
-	int ov_value;=0A=
 =0A=
 	/*=0A=
-	 * This is because the vout ov fault limit value comes from=0A=
-	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit=0A=
-	 * value comes from page0 reg. So the page should be set to=0A=
-	 * 0 after the reading of vout ov limit.=0A=
+	 * The vout ov fault limit value comes from page 1=0A=
+	 * MFR_TSNS_FLT_SET register.=0A=
 	 */=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);=0A=
+	ret =3D pmbus_read_word_data(client, 1, 0xff, MFR_TSNS_FLT_SET);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
-	ret =3D i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	ov_value =3D DIV_ROUND_CLOSEST(FIELD_GET(GENMASK(12, 7), ret) *=0A=
-						   MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE,=0A=
-						   data->ovp_div);=0A=
-=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	return ov_value;=0A=
+	return DIV_ROUND_CLOSEST(FIELD_GET(GENMASK(12, 7), ret) *=0A=
+				 MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE,=0A=
+				 data->ovp_div);=0A=
 }=0A=
 =0A=
 static int mp29502_write_vout_ov_limit(struct i2c_client *client, u16 word=
,=0A=
@@ -243,46 +230,29 @@ static int mp29502_write_vout_ov_limit(struct i2c_cli=
ent *client, u16 word,=0A=
 	int ret;=0A=
 =0A=
 	/*=0A=
-	 * This is because the vout ov fault limit value comes from=0A=
-	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit=0A=
-	 * value comes from page0 reg. So the page should be set to=0A=
-	 * 0 after the writing of vout ov limit.=0A=
+	 * The vout ov fault limit value is in page 1=0A=
+	 * MFR_TSNS_FLT_SET register.=0A=
 	 */=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	ret =3D i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);=0A=
+	ret =3D pmbus_read_word_data(client, 1, 0xff, MFR_TSNS_FLT_SET);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_word_data(client, MFR_TSNS_FLT_SET,=0A=
-					(ret & ~GENMASK(12, 7)) |=0A=
-		FIELD_PREP(GENMASK(12, 7),=0A=
-			   DIV_ROUND_CLOSEST(word * data->ovp_div,=0A=
-					     MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE)));=0A=
-=0A=
-	return i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
+	return pmbus_write_word_data(client, 1, MFR_TSNS_FLT_SET,=0A=
+				    (ret & ~GENMASK(12, 7)) |=0A=
+				FIELD_PREP(GENMASK(12, 7),=0A=
+					   DIV_ROUND_CLOSEST(word * data->ovp_div,=0A=
+							     MP28502_VOUT_OV_GAIN *=0A=
+							     MP28502_VOUT_OV_SCALE)));=0A=
 }=0A=
 =0A=
 static int mp29502_read_byte_data(struct i2c_client *client, int page, int=
 reg)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_VOUT_MODE:=0A=
-		ret =3D PB_VOUT_MODE_DIRECT;=0A=
-		break;=0A=
+		return PB_VOUT_MODE_DIRECT;=0A=
 	default:=0A=
-		ret =3D -ENODATA;=0A=
-		break;=0A=
+		return -ENODATA;=0A=
 	}=0A=
-=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 static int mp29502_read_word_data(struct i2c_client *client, int page,=0A=
@@ -470,10 +440,6 @@ static int mp29502_write_word_data(struct i2c_client *=
client, int page, int reg,=0A=
 	struct mp29502_data *data =3D to_mp29502_data(info);=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_VIN_OV_FAULT_LIMIT:=0A=
 		/*=0A=
-- =0A=
2.34.1=0A=
=0A=

