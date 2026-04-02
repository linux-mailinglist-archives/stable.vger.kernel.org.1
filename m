Return-Path: <stable+bounces-233125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GX4JVMDz2mLsQYAu9opvQ
	(envelope-from <stable+bounces-233125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4538F5E9
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3105C3047BE6
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C53BED7A;
	Thu,  2 Apr 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lHiHgl2D"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64513BED24;
	Thu,  2 Apr 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174369; cv=fail; b=LaS7XwsxkI3uunM+diIL6n4jUObfMR3kfswTzEbfBIceUqm0aiKUQ16caaiLPndAh4IeuneMtzSgmwOqy9nTC1/knRmuB7Hw/JR4uClkGB269dr2Dm7cYwBcCibEOiiYIAZweiKX3pMNie5LTYOLORjD9xTHVoKQgOIMyHJM72E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174369; c=relaxed/simple;
	bh=NF30B6n8xdo5n9FxDALWf+uF1VkkMct2HPGnBBzi/Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYYtPqN1y0jPMrae1QDpDaCfIuEqqZqf8txAr8sfqMklrobYsa5/wJ6yBJhZBF3JmXBnli+OWnJUU+h6TOnGaU8B/lu3Yp+0a4UXysfs/QtfaPUrL8OOmgP8fDP0A9Nws98aqphKuvCZatQLs0eYUjeGqcRsHaxrIONsBBCdMe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lHiHgl2D; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632KWbui3042183;
	Thu, 2 Apr 2026 23:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=lM
	oFBFzE0CzU6RItU0IMWkKCh5a0aQyBVWM9UZghxVE=; b=lHiHgl2D5yyFMHowdL
	Ik2jH+JfIAOE5ThFfgCBGJX17coDkKrwUBk8V31ooxU1bYTGEehauhXdjqm0sV6R
	301kkCw4zXCc7/Grow0lwEv3mEyoDg+WwAJd4Mil61T2z3tSG1QbAxuarsDR19yg
	KZjSsCyq05DsOn00bdzSJ01vU/xbvOBivvOjamTnLTO2805vh96OCZ29H5piU3B+
	SU9qSz9Qmu1RfV7hBXOVsk4oMkRkXsdD/hKWgQOsIO0qvfqOj5EAEzJPa4krxf0v
	ZmTB+LUlLsU1lXXWxqjWmxtGaTuG27xUv5sBu/vXPr10K7lEVjL28CCJswj22g77
	8xkQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4d9tjhnurh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 23:59:10 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id AAF7D801AD6;
	Thu,  2 Apr 2026 23:59:09 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 11:58:48 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 2 Apr 2026 11:58:48 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 11:58:48 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecmsSvAEnxEwCbaAfhv/OiVWUejmIXgoh6Yv0JwhKAChUbR1G+z3ZgFmDPahXaxYZcgFlOrSxUkjCuvPQWrWNtw2S+XumajwYMS9zvWQ0OVA4WjbbKPwChs461w2Cgu9j/zCzdSJk2ICr7hj8j//Uv/wTUdE3Vw4Gg/SUfrwp3Bci9mjcIaGOZeF00hcPdvzJe259r6C8mWCeqmnGM1sp0SDNmoNO2GC8qrVddDw/Mhhuy4ZWUuzp2u/ELuFlLO2V6P/8JmjCOAbmwP27LWTithsNr3TQJWT42qVLWOIhEOeyqxFohcS8jd6//zQlqkwwKQW5TVrqpZbYLIt34JOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMoFBFzE0CzU6RItU0IMWkKCh5a0aQyBVWM9UZghxVE=;
 b=KFadfdS8q1osM4VHgTwAHXZIgaqamfIEM2NVV4qQduIyJtQMoDhqTrdZZRndPO+RtLdgaOblSvDt/y7noP0rGIia/63pZDBguBxPi8/nn2+ighlhGmoxFv6tqmBQJZ2cTUPuvt1YH8nwmEVfLcCt9dXtDvKobiOrsRCyoY5b2lM9o9FyRVLhZjVjJa2HdQqWdFefjel8F5FBapwmFGNHExsncOKVpjPQ8rqGVTEmJFs1oJMRWzjZ7jkDum5Is4iROsik9eTBLrwLuuOK93baO6OBnKFX0poINLbZ3OJQYDJzjMh2HorevZOZvjy4uCvvf414Un4AfpfMWQcjW3m80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB2258.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:58:43 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 23:58:43 +0000
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
Subject: [PATCH 3/3] hwmon: (powerz) Fix potential use-after-free on USB
 disconnect
Thread-Topic: [PATCH 3/3] hwmon: (powerz) Fix potential use-after-free on USB
 disconnect
Thread-Index: AQHcwvyiYtIhg3IYZEuE/MdgjLqehg==
Date: Thu, 2 Apr 2026 23:58:43 +0000
Message-ID: <20260402235819.86456-4-sanman.pradhan@hpe.com>
References: <20260402235819.86456-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260402235819.86456-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB2258:EE_
x-ms-office365-filtering-correlation-id: 8304f9b8-aa70-4143-fad9-08de9113c536
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: CgqaQ8BWYEWJcbd9HYeg6BdGLm2UxSMD+PkV2GzL2kumtnqO2UXuCQeyQ4RZWhvfNpqvkRoJwLgJExkOj5CDdFEVY3sqxAs6n2XZaloIigxrr0hzDz2UKl3y+QM4k7zKgt3w+99YdQp+V3B88uMHENAXWQCNozLRgbilus69WrMIWAVrjiQ4aZFTyk2b47uVRfe90ZaAEph+UbYPd8p9k2GL2KBHr3dsdNKzQ00BRDR8Zz3MeFIV3eSwqcw5GbSxOvuzeSpzibzDqpQYiGQtaWX/x2QVrK9RgDF3xnB28iLBpOf0kPCUJ5GOuiEytJvJ37i40BGZD4ZdqHR1ZpjSf/oVy3Ws7/mpSCa90q1JPjbTSxn4/a+MS0kIeeKxw9X/DHWW8bkLwTLaL7UAT5mK7nCd5ZTOvs5mUCrmucZGZ8xc9McyL7Ln6zFD6CW+9SjApNy3BLeRhMQDL5t9LK03u9etB6/rspDYulcG003TrWhK/MCz7aTBYZRJmltWUL2pnK2oPWOTRROHciitiylQSPdkgaqDlfMtx8XqCWiglCGWjH5q0gedu6QTlGsBVBUFfIZogj9vXchIU7N7ycwzFC3EbQGGoMCyEqrr4KJSiVeMf/lotNEqJ2+P9WHWxe9lf8cMwrWJ1zyc6hlGRUm0FJwUIKi2G3xIBOi36MWNg03OkeOXoy8Bh9dPVN3AENnPR5M/4m9Fh/RJd0I3+3SuKe4CoDNhb6o20gZb475UbxJrK6bk9pH0s3bqfrZCTDVcMslt/L+RgeogghV9LnRZADoUylIywnZ//TvyYiJR8n0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M+L7xp3V/1lch4fItt63ai6zXauqcoWPXiepwcTIDJ9RpaEXHGZbc1EEww?=
 =?iso-8859-1?Q?l7BqupEAWgwFdJTxklHpgXg6uqwr/eCPS/mLSKiqLRIu3zD4W28vgQ2zrv?=
 =?iso-8859-1?Q?Y/kWwzL5JSUZdq843ijSP4g5eciMTNP69cXnSj4ua27d3B5hyLm8TE5ibu?=
 =?iso-8859-1?Q?HCPVlJHSGxI3nsCqQyPMereZ4P8zQ3EAISIYjCuAUUHrREGHIZDzSpiKuL?=
 =?iso-8859-1?Q?1kgpm+Crnh3qKZsl4vZ0Gm0sSgMcXGuAF6LAHCca4a6xDvCu3vDf2EKw0A?=
 =?iso-8859-1?Q?Z2mUrHOw5iK0c1eeptEqyCh4Q8z2a2LbbddncQYPXJcJrQDuW6T1NIF98+?=
 =?iso-8859-1?Q?1or2uzPo/GRysOsuMroHTANp/gMjK0D0uw55GubpwM2V7E5rpe0tiFMfvu?=
 =?iso-8859-1?Q?LV/CocOFT5gwY0ee1ZpZPoZi70VAnhFbpwtC/z7oBC/uTELrBBCq5fCvIx?=
 =?iso-8859-1?Q?66NTm/Z/OhvYuST5+yDONzZaJ9JydnSLmjhdGG25tmLtAVbguKfVj8uxjA?=
 =?iso-8859-1?Q?ssgqDPBIolwMVZ2em+gAmbTLyYVGHMGcNyDr7CGaIjiSymMnuEPaQpxry5?=
 =?iso-8859-1?Q?KwcYAr9Rh810Y3fdoPBY90NZdsZ4X8T+8sWnCYw4HKKvRSJcFiyd1Dq9S8?=
 =?iso-8859-1?Q?3nl300SEqptnY7XRT5v5rprVFDdVqw+rUXVVGvBRniZcf7jl8TxESnaH73?=
 =?iso-8859-1?Q?5XazhEVk2cBztPT1Bap+DkLiw0jy6sB4AnqczhoAQxPa7fLHFuRYx7ZJMt?=
 =?iso-8859-1?Q?6G1MYBZSofw7ysBTMmHMTDIiwWdOzOLk9XquCnVVY9fRmMBEyJjmdxTDkE?=
 =?iso-8859-1?Q?uK1zTfiFBtWTmPk5rGFWZYbWQT/YKu/Gg3ZKOqgyGlr/PbqyP61xHhIMlc?=
 =?iso-8859-1?Q?2Q5mSCuZQvTa+PRGiKlGxGFvgdHcnxCZ25dYnvKxNc6Yz671rzAFOZeD00?=
 =?iso-8859-1?Q?S7aUBXjiNQyFxPZxSPolMYZrjxGsP9sLdxSjPc28oH/mYeFEfQDG190J/T?=
 =?iso-8859-1?Q?EtYiYgv6BJip76vN5RKgW3T6u1CbrN0RrVGgY6oI1Xvc1l+gLczi7o6MBq?=
 =?iso-8859-1?Q?cWxJ9Kt6dBzzZSAkEYJgpP21zw5qBZS1AD9jmWIHkB0yRNEHujeaDgQlCK?=
 =?iso-8859-1?Q?S1AGm1ge1Oj8tqYHxakDwOA56q/8XOWXa8z8v9e8C6GXszDlO8kjMpi+xS?=
 =?iso-8859-1?Q?dumgb9K1SU1Mt9PsyEyQdbx8vL1E9z67GcNqFkDeeDxncxcwD5WWdEsew4?=
 =?iso-8859-1?Q?WpnkLvdZCC0pOKLENK3ft9JGJ5XiJZxm6IA35lD2qw8lROz0HJslfeg793?=
 =?iso-8859-1?Q?l7hL5183r6RyRFTHPRUTUhd6zLGfUfYkf+yNPWmgFwNG9PHST7sfIT6VIy?=
 =?iso-8859-1?Q?Uo0ddSKhv/uwQRd8l4CMMAsu9J2iNpQxCjIPRDZtkjRbFX9shT7+sbo+FX?=
 =?iso-8859-1?Q?aRc8/2QaCFMpnsjso4QZW0Hgu1NZm8utPtgx862a9X+86mWN1McCoR3NKD?=
 =?iso-8859-1?Q?ugKxTJDGAqpgB108ZxXUTT953ClUwWebNUoowrgLx0wfCwUnOjCQiACubb?=
 =?iso-8859-1?Q?jsLOwDVLOgQ3rf67HlINjM0AnWxsurFackanVjCeN80WpTi2REbyCZ44V4?=
 =?iso-8859-1?Q?iFwSM/hGf+ILPTjb/sKhBTVaF+vXCKkceM+Yesd+zTa6h8/5hGoRo2D5yF?=
 =?iso-8859-1?Q?+Kvwh1XmashPKIzNT+mBqZvuiu3CsFI2LeZhTT4IH8hOn4KsHjkpJ8YJf0?=
 =?iso-8859-1?Q?KuuskbIHWWep//XmEkx5o84biGbnb1ZsgHjayQB1KiWAiD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tfwTG2RSRSp/Cvecxp689P7vwnZ6IG0K1ORoxuNiwi4vmRPYm67bA8lw4aLxmz+KZQYYsJf1a8NXkFXjz8S0FdzZMa+G3Hv5s3C7crLpqn4HaX9r4fSUkZRBOAcFMoI2VZ2/m1hnXjYDFUDOKGmy7DKGDsyNStFOLyqP0v/Mic1Q0Sq3EYbm522X8clOtinBVP5WfF7PKjzU1GMvmHwB9usY16ZBC/Eq+bD6XGm9tTsllOHm64Kr4w6aNZ9AGn3JvcPveCPRyyX8s9mPfdxguAMk/G4zLbvJHAXgpciysidB/KuP8NE2NMvl//P3k3Y/OZvcrF/RS6uQPZLfEvB8Qw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8304f9b8-aa70-4143-fad9-08de9113c536
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:58:43.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qypOIZqQBdIaq/VIlHn3FQ5dKhPK0B4iysKow1y7UCXE8RtxPR8DPFDLuxsF/2lQDbZVk5F1eoN10INSQ9XUDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2258
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 5LZl0a5-yhIIhlHCtskyGmCZZKCQO89N
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=69cf02ce cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=sZCmHRT7lcuF82sXxaYA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxNCBTYWx0ZWRfX/D3lbaHQ7k1o
 rgAdERDxTs9YOQGMI8fZSIBMp3wlYKqXEZ3DGaxdKRxs/z6wQJqLnhA16mgfhUNSXVyLkB+U+ja
 M8AHA791cK9EJfDLpl3bEGCAAg2ji/YyMUxMhc7JrxulIhjcc60370DmxmUA6KBIZbP//QUxirg
 b4mNfdNULlYSN7NWuh1UvPzi3OdEun8bgjO2oD1J/ZP9eLAcWMBwEs7y0CLIVjFlA4MQbUHqR+G
 SXI+C9DoFrfJjqurP8xkmhttFPC3TshbDi4CIQF3wylIoPsqzu5V+YuYOpoDoXgSrIDoGpYnV/7
 u/o4Dohc0YX9xYKGA9hnwLLTRCRZyjtNkvN6yAhZGyrDBkxz76o9WRM8cRYeiLuokXucKCoIwIu
 oUjSdKKJG8Z6B/3Jy0AESpz94+fXrxeqZUXXWIiDGhpciE2rsafbDbl6E78oGpvebqvtSXCYfES
 +kQ6fEXMYYXypwe0EaQ==
X-Proofpoint-GUID: 5LZl0a5-yhIIhlHCtskyGmCZZKCQO89N
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020214
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233125-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1CD4538F5E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
powerz_disconnect() frees the URB but does not clear the interface=0A=
data pointer. The hwmon device registered via=0A=
devm_hwmon_device_register_with_info() is unregistered later during=0A=
devm cleanup, which runs after disconnect returns.=0A=
=0A=
Between usb_free_urb() in disconnect and devm teardown, the hwmon sysfs=0A=
files remain accessible. A concurrent read through powerz_read() can=0A=
reach powerz_read_data(), which calls usb_fill_bulk_urb() with the=0A=
freed URB pointer. The existing NULL check on the return value of=0A=
usb_get_intfdata() does not trigger because the interface data was=0A=
never cleared.=0A=
=0A=
Address this by:=0A=
1. Clearing usb_set_intfdata() in disconnect before taking the mutex,=0A=
   so concurrent powerz_read() callers observe a NULL pointer and=0A=
   return early.=0A=
2. Setting priv->urb to NULL after freeing it under the mutex, so any=0A=
   reader that obtained priv before the interface data was cleared=0A=
   sees the NULL URB pointer and returns -ENODEV.=0A=
3. Adding a NULL check on priv->urb in powerz_read_data().=0A=
4. Moving usb_set_intfdata() before the hwmon registration in probe()=0A=
   so that interface data is set before sysfs files become visible.=0A=
=0A=
Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/powerz.c | 11 +++++++++--=0A=
 1 file changed, 9 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c=0A=
index 4e663d5b4e330..add20b354f862 100644=0A=
--- a/drivers/hwmon/powerz.c=0A=
+++ b/drivers/hwmon/powerz.c=0A=
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, st=
ruct powerz_priv *priv)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
+	if (!priv->urb)=0A=
+		return -ENODEV;=0A=
+=0A=
 	priv->status =3D -ETIMEDOUT;=0A=
 	reinit_completion(&priv->completion);=0A=
 =0A=
@@ -224,16 +227,17 @@ static int powerz_probe(struct usb_interface *intf,=
=0A=
 	mutex_init(&priv->mutex);=0A=
 	init_completion(&priv->completion);=0A=
 =0A=
+	usb_set_intfdata(intf, priv);=0A=
+=0A=
 	hwmon_dev =3D=0A=
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,=0A=
 						 &powerz_chip_info, NULL);=0A=
 	if (IS_ERR(hwmon_dev)) {=0A=
 		usb_free_urb(priv->urb);=0A=
+		usb_set_intfdata(intf, NULL);=0A=
 		return PTR_ERR(hwmon_dev);=0A=
 	}=0A=
 =0A=
-	usb_set_intfdata(intf, priv);=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -241,9 +245,12 @@ static void powerz_disconnect(struct usb_interface *in=
tf)=0A=
 {=0A=
 	struct powerz_priv *priv =3D usb_get_intfdata(intf);=0A=
 =0A=
+	usb_set_intfdata(intf, NULL);=0A=
+=0A=
 	mutex_lock(&priv->mutex);=0A=
 	usb_kill_urb(priv->urb);=0A=
 	usb_free_urb(priv->urb);=0A=
+	priv->urb =3D NULL;=0A=
 	mutex_unlock(&priv->mutex);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

