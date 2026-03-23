Return-Path: <stable+bounces-230029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLScD2LOwWnhWwQAu9opvQ
	(envelope-from <stable+bounces-230029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:36:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D302FF032
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF2413047347
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9700358369;
	Mon, 23 Mar 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IG80FtIH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E00370D48;
	Mon, 23 Mar 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308865; cv=fail; b=pO0bsCoA3pwzRhx+9MiGT5TTMNrSKhE7pbbnn+aA/as/MGM6qG4vAE+2txP1nYhpLHRdtz4Jaf3ZmoGOVNwd5B7eixBWPIRu4A0SnpUkCTesATjbrmTSVea+8jck0ItPVFT4olq6bfxaLltUtMrQB7FVpnO0Wri7PLJ2ilt1byA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308865; c=relaxed/simple;
	bh=QeIeSkqG4X5+FXTzY66VgP1OSchW7vYm+xZ+8KFrohc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZyJDExG74T/zqTq8Ifokau3LsjnSRGcK45SFwJogQKNNNx4Ybi1ua6JMMpYuNCgR6nNjsnBNrMSBzUNswP3Sixx2FJWd/yUMhK4SqugKcFGM+0cI2PpxGw/IYwGDwIjcqRIaE22hlzeI/3bueC/JHcWLuLD5b19jBYnZGTef10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IG80FtIH; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKEOpC2791088;
	Mon, 23 Mar 2026 23:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=mR
	GWdUnyENfn6j6TIeLoAAKRmRXY7mEtuhoTQFXwjWE=; b=IG80FtIH3gpyHbQuUW
	i5UgZXboiQcUZ6WXllaxmk04RacUF9EPPi5WIZBg2cYfOxrHQZBGgfPHbBSfS7qJ
	drLXlVbC0klNqTanZsFlcJf/TF5EKjuRYOOvY5NI5EglJKqUP/TTrI+s3SO7aHLB
	HQw+cq2wGiL8v2KwVSupNYpeGHWTMv+9Ybyz4lSlab+uL0D58MqGOrnJHRgjghA+
	UUYX8UOpeTcuPni6g7Ro9ZmElNo14wCjCKSV0JHtv2PtVMFtUstAXXTI879cPgjC
	XIO80d8SR3nJd3nawiz0BDDwQa6/8iNj2ZUN5EHn+eDKFxbjXWZI9ZQIRjKkIiCg
	J1cg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d37nswgbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 23:34:09 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 88318D1E6;
	Mon, 23 Mar 2026 23:34:07 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:33:58 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 11:33:58 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:33:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHQKkZEvwDbnbhje1RNWnbap4tIELNC6EzLcSGqDwJjMdAU4nNizeeyqYpp1yJgcoY8WQ/a9sVBYogUvLo7VIIiGOAm31aTDOLeuRgEFUVunjLcilPl4kXpbAoYmdSOO3YIU5hYMKWvoljl61Ufxol7fM1z0b+bzWj5gSQ53POVnSjw+pD8jRCoFoBKJ4SJ9hzC7OAIfmKd26/z2EgdscfGKYTSfrgvl7khajCEhwnT/GDco9mf7L5o+K1f0dJZNcUaCWWXbYsOSKR+zT4AjceS1Cj9phF9ud8etE18QYtuegHwuS132+hsyoZJsrc1sOu1h/bffUWqaFFWMA5Jp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRGWdUnyENfn6j6TIeLoAAKRmRXY7mEtuhoTQFXwjWE=;
 b=zU1bx/FPPUbw1KF0j0ikiJ5P9qwFzQNi9kEshcHtVryll0yI0zUFHWAf2hqppaRQ/YQIPHReQk/bvLWgLgd/8rHgHIWhlSo3DaMaHKlZC1Sc49janpCp71mkcJFyBFx2l1+Byn3nPLEmk7acHBdygJ6sNOrlJudFGKLZsL80CX9pngE7MFcbJotx0LnAh8FOC5vLGJ6KONnIfhMB9R7z3CGjfwNBp0bzar+i4jaS0u43a7QMAFvdThq9p2Jiiu8axmVUsLMptdjQso0ZdcBnHfg6fBEtvmGFPXrm1hEMQyZUxpiZ3sAngW7My1rxCExcPB0rbWZYIxak8qhTKuLL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3989.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 23:33:57 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 23:33:57 +0000
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
Subject: [PATCH v2 3/5] hwmon: (pmbus/mp9945) Replace raw I2C calls with PMBus
 core API
Thread-Topic: [PATCH v2 3/5] hwmon: (pmbus/mp9945) Replace raw I2C calls with
 PMBus core API
Thread-Index: AQHcux2Ecz6wv6xwp0y1RDQes7kOfQ==
Date: Mon, 23 Mar 2026 23:33:57 +0000
Message-ID: <20260323233244.201294-4-sanman.pradhan@hpe.com>
References: <20260323233244.201294-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323233244.201294-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3989:EE_
x-ms-office365-filtering-correlation-id: 3d52caa9-99e2-4181-bd22-08de8934a746
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: //e5gCzbgSDm1UU56+/D/AEQrVHXcxozKOuY3p1oQ+al1yqRaRupDnpwd3iucyu9dJAEP13o9e+KWkokNOAEzyAQsqzcByxnhfL9nT1Mak4jK76EnHYW6EE7aLHTzziBJhHKhZ1gkX8CtMfYGYRzOb9CfEuApDXGiMf/PyDQMQwcnztI86zqxezkOkF0SrDNVRRR/mb2LQP+QmxmVPfFx4+XExuBgu8rTbXNvybBXJ0WDI2MZHhlp8TPx6lYkSyUaEWpyfI3eyIu9PqLvyqxoWX3otww7aJVFuFwf8zar8jawdHRxvAe8gMdFvG0hNMhhhnnePPCTOUNVbR4QLUW5nbQcv214doDlm/Kk2T0we2W5gqZfQnNtaeBzjtcTk3dR+1eL/7FhBZNv9Q9/PmEFXilXjMoQ+fCYc7T0xsxoMCt7QAzryuOwwMAqjLERyeOpLUekHtrvQl8JMxQTxHhfD+iXSy1FnPwTUJE1LbtFzH64J4Y2S2efsrOOV3Y7We9OcaIO34L2hJ86hDRKLQPZnkls1mLtsPsMe+AmuWEHEigXhDXoShMeWdPLPJF3UYC+dVEdXwbObvqT/zGvijmqDYIhr0D15gJc+HoBy6HMglQCem+cZqNaeCOOefBbdMv7YkCBjG6+nu3flT1EKPniiV+wc7t8jQIyZgtBN558z0twurf8u6P57s/v83SmUfn1w2NUo2kuuO7GWcdH5nJIh3TibLVlVxLe5wJRf7YsxGWc/XXC0Vq0v92Q99oV9OtXIvcOV3iNSRXvcO1P+Bnx2LUzdowGbWM4wzKBHtpAhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rFmquCAggYpPfXWiCaOcef36qwcxVP3CIShz5qzjDqpl5jb5Flh8ewEdSE?=
 =?iso-8859-1?Q?j2+zrP89b09slMpTRzv5cD0T80dfWKhNP/Joi8i4b3b1hOzlw2YKqW/bes?=
 =?iso-8859-1?Q?nkT6gvNblXrHEhUsnK4z/rgOBeynM3pg2hFyHz5qjcCX9jbAI3MplIk6Qm?=
 =?iso-8859-1?Q?XiG+CS4oe04cbEPcXNEepkbkTz8GTW6sNHPNDZpDXVza1fnxxiWP1o9J+G?=
 =?iso-8859-1?Q?mZGqJp3bQFTTJtopgi99igtpPuH8W7H5uYNFtkmOZ53D0y2zMVHCEvYftz?=
 =?iso-8859-1?Q?3kREDFmXVCOcXXfg1jhLL6GEiCDYrUEn0LwQVlq1L6b729qOm5LQyJN4zd?=
 =?iso-8859-1?Q?u2/dUP78SlpqoeNnP/Q4F2YC9O0k+e6hPtMUIOmeqB1ylp78mKOvH6tXOP?=
 =?iso-8859-1?Q?jvOgMcTYqnYHql21nc0+KNaTAZWB7gcXS3quunQhDpX6LUXLSfULvFkpWG?=
 =?iso-8859-1?Q?K9wrQI6uLIrIQ+K5xMvaSMDINZooGcstjNw3Kg/DCNg2WqRw3SrxFrzqLR?=
 =?iso-8859-1?Q?aDUH1wJVVBVn1cZpstKnBdL2Ay8JDjRdlh4qO28g0mC1Y/arT6t9vIk4Ad?=
 =?iso-8859-1?Q?24fDx75lXT+Gs2XxKvkxXguIphM1CZGYRFH0hD4buDbv1rjWdKGMRyA2iJ?=
 =?iso-8859-1?Q?Fcz1EprX1G8pIqpdqYKK/aoewaj3xxuS1+dTqp/bnaOB/hG543umqV4cww?=
 =?iso-8859-1?Q?bf6szSNl+FXR7LiUTgdG1UP12jMCAguJMlTZW6gmQKVH+2RxfjNdwPbuVS?=
 =?iso-8859-1?Q?mqHbWK+XB/vdQX2KMHeCM/+mkvUOux1+FKnRGDKpvOgJvN5+s/UXmfSptp?=
 =?iso-8859-1?Q?s8yU9BUlunAewtcUgW/lJDEHAUKovef0FWxZpIFgiQjRIpNPfTtvEctdoj?=
 =?iso-8859-1?Q?Fz9to6Ql0vGy5KarTrMAI6mhr03NTx225qjU69tEp4kFDVDzGdRHVNXmDU?=
 =?iso-8859-1?Q?aLaruRlymMlnNfCmgwPrD+3qdvCk0Ontbg25oftiofH/ApcgfhVdFoDqWY?=
 =?iso-8859-1?Q?l7xcxhtJL59T/resmRPCBzQ0m8Aebv+zw8OCMPerNLfDuN8FeGZljaTJxN?=
 =?iso-8859-1?Q?+zTES0WLnADsbyG0e6+PvhAoX0gaG8Ozc3Z9araZHlZDHyxtn1jAKZ6vi6?=
 =?iso-8859-1?Q?RPr4/zBzZY/ZjFqgTgLebLl3CdjwSHgYDot16bX+jGEzOwn/yk65fDX8He?=
 =?iso-8859-1?Q?qLWt/le2I5ZN5KmROw5XU2uwRABmDk9TYjOzNkTYAzsOQBj9d1k3kQ56ky?=
 =?iso-8859-1?Q?N/BG9zEwo59wxkTKDaULYiTFETzmj8KriFsOTIZSVfhSKK6olKy1bObgbt?=
 =?iso-8859-1?Q?7DjlqQ7+I4Hhy8ONqII9JZPIZ7jSMnyUmU9dGGJND/Lni1xQPn6h7Rbsm1?=
 =?iso-8859-1?Q?4m/36Yfg/6PfsQrHLAJl0nk/GXv6jL9IgRiZEL5vbUr9BMe8c3dBNy0K6E?=
 =?iso-8859-1?Q?mKm3PfeB8oIAmC49IxvnVHOoZkA25C2WuMI797QzdGS0lLsclnsS+KlgXn?=
 =?iso-8859-1?Q?CpEhbIZEFB0yPQwdgqgCKWUeDpyygJPweuqE5DY29oM4rnzTWfixx1SHJf?=
 =?iso-8859-1?Q?hbD1SKsXTPHByt7eTTGYZPryqEpT0OYK4JcjQz2IfRnwIH9ycqeLJLG0fn?=
 =?iso-8859-1?Q?Eiy/6GoE7Ox/RkgQFx689XQaJJS6LyFAsY+MpmE7c5PrsxBdT37jQZbHKE?=
 =?iso-8859-1?Q?qSD0pcy+bMx+BQ56gKySL5JWB/QVEKw3dhXp+c7y35CSUR+yl/g+xupZEp?=
 =?iso-8859-1?Q?q4IIe7RRpvV4bihghKQZ59da02+0ZH0bs7thhwfmxHLjas2sxN7wdM6y7Y?=
 =?iso-8859-1?Q?qDUZdYv+nw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X/ER5bvzzuj34Z1Smo0B8unnlp+mMRH4UoHCYD1i9G9hIP7FfCHHjSCv7cLTzYIFKz5U+pSMO0fnzQp3kALPsNSy7I4cC+XoowehA35CVIPj3GhM0D8xNz7wDehdGO01GzWDl2mTBqrRG3JATJlz/+fSZy8pU20wGfOapQKggndq85cWGRlunDmeJY8VQ4zRHOkRXE7xaCX3JVm38vTYdAmBGus+1CFv5X3O/U5E711I5WdzPZYK/lxLdRS242qsli4KVwDvJHaI7Jkn23BswXxIWrKe+WILCYBcspsw+CZgmGBi5B4j6X60DSCeh4wEd3/HnLgewJaVyQgkCnsYEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d52caa9-99e2-4181-bd22-08de8934a746
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:33:57.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT/JJ2miq4AlnZ2FLH/VXUry750IY8PP9FEsAVO4Ld2rp5JsF56rhWt7/OiwpQxgOAy0o5W+wptfX8oswqhcBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3989
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: JN3-TxKlmc-HGxRplqQDFguoIT225ZRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MyBTYWx0ZWRfXzXSFpHglW1yP
 g2xDShMFs9t8ZmWbHvBAPxonvAU2dKedHuN5YDFitq6CWyfSX4WUzxaUNqUbqbOEWg/9VcRar7F
 XzUKi6lSGb+7iv/OS5zX6EJwLqCDczXQwGY/9EHUQbNboClug01TpvaUfzBdytY2iI6cCMqaPQo
 E0YzIkDO0w/VqQI1LaJeTt4eiQdWIZmXz7+ZXSpCBR1Ai/DrpmrwtigCc+/bPz+X5EVzqP0jAku
 S56iNsT/HW/ud2IWSRDE1Fx9T6mFvPH13htyT+HnqkZy4Vl5LDwGUfB76Q3iTE6VrFaGyusFAQ7
 +hMHRR4nvTn7Sa1SO1NciUccZa3h+zim3oEqazZFqQ5yFsDNuVXNnYowJ6GCroNfzgimJnhQWJa
 yRzirNLTX3e4FwUKVu9ATmCDgvw4/z+RheahRmEbSwPIzUbY65D8qRqA/VL3jAqGyXH8Sq/PyWs
 NMHy99mSHYjm+qOU9Nw==
X-Authority-Analysis: v=2.4 cv=Q/DfIo2a c=1 sm=1 tr=0 ts=69c1cdf1 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=whyYXC9HAFXPZnEe4DQA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: JN3-TxKlmc-HGxRplqQDFguoIT225ZRn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230173
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230029-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A9D302FF032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The mp9945 read_byte_data, read_word_data, and mp9945_read_vout=0A=
callbacks use raw i2c_smbus_write_byte_data() to set PMBUS_PAGE and=0A=
raw i2c_smbus_read_word_data() to read registers. These raw page=0A=
writes desynchronize the PMBus core's internal page cache: after a raw=0A=
write to PMBUS_PAGE, the core still believes the previous page is=0A=
selected and may skip the page-select on the next pmbus_read_word_data()=0A=
call, causing reads from the wrong page. As a secondary benefit,=0A=
switching to the core helpers also routes all post-probe accesses=0A=
through the update_lock mutex, closing a potential race with concurrent=0A=
sysfs reads.=0A=
=0A=
Replace the raw I2C calls with pmbus_read_word_data(), which handles=0A=
page selection, page cache coherency, and locking internally. Remove=0A=
the now-unnecessary manual PMBUS_PAGE writes from read_byte_data and=0A=
read_word_data. The identify() function retains raw I2C because it=0A=
runs during probe before pmbus_do_probe() registers the device.=0A=
=0A=
Fixes: 6923e2827d58 ("hwmon: (pmbus) add driver for MPS MP9945")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
- No changes to this patch in this version.=0A=
---=0A=
 drivers/hwmon/pmbus/mp9945.c | 21 ++++++---------------=0A=
 1 file changed, 6 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp9945.c b/drivers/hwmon/pmbus/mp9945.c=0A=
index 34822e0de812..1723ef84eb0c 100644=0A=
--- a/drivers/hwmon/pmbus/mp9945.c=0A=
+++ b/drivers/hwmon/pmbus/mp9945.c=0A=
@@ -43,11 +43,12 @@ struct mp9945_data {=0A=
 =0A=
 #define to_mp9945_data(x) container_of(x, struct mp9945_data, info)=0A=
 =0A=
-static int mp9945_read_vout(struct i2c_client *client, struct mp9945_data =
*data)=0A=
+static int mp9945_read_vout(struct i2c_client *client, struct mp9945_data =
*data,=0A=
+			   int page, int phase)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_read_word_data(client, PMBUS_READ_VOUT);=0A=
+	ret =3D pmbus_read_word_data(client, page, phase, PMBUS_READ_VOUT);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
@@ -73,12 +74,6 @@ static int mp9945_read_vout(struct i2c_client *client, s=
truct mp9945_data *data)=0A=
 =0A=
 static int mp9945_read_byte_data(struct i2c_client *client, int page, int =
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
 		/*=0A=
@@ -98,17 +93,13 @@ static int mp9945_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 	struct mp9945_data *data =3D to_mp9945_data(info);=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_READ_VOUT:=0A=
-		ret =3D mp9945_read_vout(client, data);=0A=
+		ret =3D mp9945_read_vout(client, data, page, phase);=0A=
 		break;=0A=
 	case PMBUS_VOUT_OV_FAULT_LIMIT:=0A=
 	case PMBUS_VOUT_UV_FAULT_LIMIT:=0A=
-		ret =3D i2c_smbus_read_word_data(client, reg);=0A=
+		ret =3D pmbus_read_word_data(client, page, phase, reg);=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
@@ -116,7 +107,7 @@ static int mp9945_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 		ret =3D DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * 39, 20);=0A=
 		break;=0A=
 	case PMBUS_VOUT_UV_WARN_LIMIT:=0A=
-		ret =3D i2c_smbus_read_word_data(client, reg);=0A=
+		ret =3D pmbus_read_word_data(client, page, phase, reg);=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

