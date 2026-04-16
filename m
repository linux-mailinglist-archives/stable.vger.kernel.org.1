Return-Path: <stable+bounces-238371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAuPME1c4WkBsgAAu9opvQ
	(envelope-from <stable+bounces-238371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:01:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87941527A
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4423306B2CD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C938B15D;
	Thu, 16 Apr 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lBd7Vk4p"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257330C62D;
	Thu, 16 Apr 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376813; cv=fail; b=dpW1Qv64aF67qyJ3Eg5LADMCqxz6GAkha60WzU0fHxa4QxmfiIaOVBSgXLbYrHBor17FqZn3HwbyNrxmIESksBsMjIbRfiA7jYtu2L5O82D6BjoN+mdppjBBA5DYO+86MkOu/sLh6emfCabHwqwGRr2GfK7dKKN6g4812sDUPHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376813; c=relaxed/simple;
	bh=FOCpRWkNxZ4rn+C2iDchxa9qWRBoXjfApJAsS7tGSHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbWRycYTLHatlKAV5Sr79oh8F/rWkEASp7Ee3XJseVBPMEv6Dfpt+k1M0zy2Uy8FKDu+G4RXn4GBRaZmZy078omIJu5LmgXoXikvraeJF2jChn2cC/MOxen7mmfCdolP5EI/I+Dqnp46LcHcBv4WvKPWfyJH/BvPz+cSbJtkg1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lBd7Vk4p; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GHZCjp2323247;
	Thu, 16 Apr 2026 21:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=33
	LzMB4cGYPuTI7hXc+zGZJr5/yjJ7Q6bVomSonB4p4=; b=lBd7Vk4pxB0OcagB2g
	D38C8U/6HNY7khrBV5+2LbchnUOFxjMpNNQsTc5lp52vDaqHLDveluPsRg0UWFhb
	/OrpxqA0f59vQ0Egh0la95PBQT/bMOLMGzRr/d98O+Eb7DmK7OqjNfNxN3MhAUST
	zMqkBTcNpR/tuomTV+rL/eGW6Er/vdpXr68fl/YpyvnrGboFmyt8VG235+xlO/NR
	f9mWNKEhDawAaTBvHXHkrSo06kRC+I5Ne7OiVgJx1r3zfxNesG51sYX/j4HLnUnm
	3mFEGKU9r2xlp5C+ia06pW5OTDIadj6tAMxX3By3XR3nKc9ZPi5SzI46FSaIc/Bl
	yS3Q==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4djygq7207-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:59:56 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 09B5426E;
	Thu, 16 Apr 2026 21:59:56 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Apr 2026 09:59:43 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Apr 2026 09:59:42 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 16 Apr 2026 09:59:42 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 09:59:42 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xry+2m3mXuwhWeNrWyVtAI6e5F++cR00y9R3+riXTW3Hr3LcE9Y+KXF6w9XZ3MuhbUOkK4jrrZzcpaxJg2nDzxouy5uh3Hq2JCelvUT9bOa3RlHMDuMHUhcZmH7szs0ctXoS++Yf8CaKrMwTuz7djDHpXd/Ns1H/hFyvkC2kM2hxfVQiUNHf6hS2IU/3hKFw+ZkBUa954A21Sfi9vwuvvvpTPBaS/VK+JQnr5J0mzjYxoeG3P5Y1keMA0nH2x8AeSgQH74zk1f2Xu/rgvzjOfnwE9P3+N1iO01f6Z0iiubzx/AmREzdjT/Ff4ESumaKb9bJ5Vxd26L4Obf18qtNRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33LzMB4cGYPuTI7hXc+zGZJr5/yjJ7Q6bVomSonB4p4=;
 b=epdbELMQTTbb5E+R5kdjAjFxW2msvv5Q85WPUKYiAqSeigVHgPBOu+Fmg4KXw9TthRYk64HR+fvZG+P5BSLfWATe9WfeOg7qIN3bP6o4yYuWbG0OWueCYBh3OZmzlWhhVixDTtKxWfT6MqTuY0Uq4iuYNiODKP45/CfH62KXvEWFE2288rDv1eS6v97Y4KVicoO1rqoGs540ALn7ZPGsLbraB4eTMRrEI3bycLPVDjuv5sPkwVJQ+5eqwMy/xCMcKI9eixQ3nnikCSEFbHeJj6Z/2wNI2MOoWULoeO4uQCw01fUA16eaJzNbKL5t3Lwq4FUtI+c2tLvdnHi2PGsm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by PH7PR84MB3250.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 21:59:40 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 21:59:40 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "alexandru.tachici@analog.com"
	<alexandru.tachici@analog.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (ltc2992) Fix u32 overflow in power read path
Thread-Topic: [PATCH 2/2] hwmon: (ltc2992) Fix u32 overflow in power read path
Thread-Index: AQHczexTQGNop8XHY0aHaVXbw7AXtA==
Date: Thu, 16 Apr 2026 21:59:40 +0000
Message-ID: <20260416215904.101969-3-sanman.pradhan@hpe.com>
References: <20260416215904.101969-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260416215904.101969-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|PH7PR84MB3250:EE_
x-ms-office365-filtering-correlation-id: 9e35a260-660d-4de4-5779-08de9c0375a1
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: yx33yye5OGhh6UrnyERzci4FOCC8frA0azhOZ5EN68YpR3ugrb3+xOkFJW8ECY5AOQDqro3VfhUJOosgZciusOWNl7YA7NE1B/FkMJR9iavhiUeBO3loaHyS6BAFcAwylFDBznwn2SFh+w4LBcVrmy2ZtQlWbvoYDFhbkHOjUxbyavI4O+2M+8ttJ5fvkxWkkgFlB9R4HiC/DVAxNW4OMb63K+2dh90+qcbsj/y806UqsUcF4kV269ikJediI1f9XgsBEnpiGooMUeL/SJ3KkBj6TXGDi0sSIKBAYSZoty+aztgs7MN61EJI8wDL1i5qdyUNyz/3CZY5avZREyRHrZlSj0aV7kecuyuIK9kjuu1u29QAh1I7iqR2Q3SgJThFkTB5rhtNxbHx6DSy1885fqHDEJDrAANzU5gh9BhJUh8pIvpzb/FCdcx1PTJvouP+zSY2dm6kaTLu5ACkrU6A4uAib6XTi80xjSpV4e88kPME1qxxFgg16dZ5k/7d0Wj/SbnbIpd0g1Zz4HeHdVMedxtqVhOHxVa0Kt5mwp1J4CwHVbjxalGRltDziExaxm6xZ45h/FQfSCwhzE9oh8kOzg2iF9wV3SKqyU0rH3gtdtYrOw7NcTeqh1XhoHbtbe/mlREKKoBmzXh/KIs/DMhl4EYNbOhckfWRluInhPUmCQpzrFP5bm0MIZ1FewUWRuFpZdlZkbikmQizlmgqZXysf7WAcI8rD9Vnt4WaMgc4ge7QXbhOq/HUmbT+L1w3uDVCP65RsDvTR4dYCNLJHBrrHoZNOzht2oAlB2WbVtNpfXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LdSSKrELhRw7KHb3mF19fS3Z3GwH2KO+RwHkmhu3FlBDxDGiIFgOv0txA8?=
 =?iso-8859-1?Q?/YreFIAfTgYmtdZJqWyck/BRn9TsNJpHYAQ/jaiPkPCHDQguJFSQeM+jLL?=
 =?iso-8859-1?Q?qGyhW5q0zVFfaVApSCwpajIA4fjy7hKJ7hY0SZ+ceMLhZJlCoDQk7Qg8MD?=
 =?iso-8859-1?Q?027qqZdCs48JWJoEh3MQp9McGC3sh4bRCG5dCTvYavOXCRhTr5Q5npj5EZ?=
 =?iso-8859-1?Q?JO1n+oIG1NGe3ER/RpGsdDd+LbLIzj9QaYbqeEkV30JSlF5C6t00bORonB?=
 =?iso-8859-1?Q?SSvZ/XaUXgoAcogB3aSjUde37cdfybhYuTlwdWi5vqyL31TWEDpPZNZXO2?=
 =?iso-8859-1?Q?dl2s1Z8+8UlVRGQo3yge7a9DlCjb/yRVVYTN6Pc5RnaaBSxgu+qE5oIbPj?=
 =?iso-8859-1?Q?RM20v7HHbFSfOs6GH8GWIuDxR75ETC41o+fP6/sr52RQTGUWI/GeboCe4v?=
 =?iso-8859-1?Q?H+FZSEvJD9ecv0YEDlPvYgBtAG59llVLP1UNt9nvUIhkyA+q6jyxTc1z0k?=
 =?iso-8859-1?Q?Q5Qdr2Wzv8vBHrFF1rDILS2Q9Xb38oz9g0qzkJORR+T5nX3wfw3WjfMm3S?=
 =?iso-8859-1?Q?S5MYZ85Abm0I0XIMbI43UwGdo/isvD/G3CkBWYWT6Rk8oijfxcq87mZKcs?=
 =?iso-8859-1?Q?w1bx4qRwDtXu5CCRDnrraMycuzT15xFnFjzea4C7YcamChtOFLHtqgcBUb?=
 =?iso-8859-1?Q?ww0KKwxNaCWUU4eCWr859qwmQWysPbCmx9BrhY6Ain7s15YiPQJoE3nwcI?=
 =?iso-8859-1?Q?HEISFdn8s5uTN3vpMOfhtAweNl/8WZCtzQX1OiDtsuUWREcbsf0MszkpBj?=
 =?iso-8859-1?Q?8jwt8A7iuNge4fTRpIbrsMek3KCqso3rAGme0OX16AKS0FrhY70AVbFpmK?=
 =?iso-8859-1?Q?keRINEr4FgtMmC7Cjlt3xhgDeRdbcLNQF/lC0CYrNuUQsuScU8pH78Gp7I?=
 =?iso-8859-1?Q?6Oeo+l0ZPLYU2P2v35QruILAxTWoaVRaLdqHmybjICZ5Xi92qJRTl2wGfT?=
 =?iso-8859-1?Q?LL7PELO+xCwys9+yb7kbEMMWS1RHZI+Hk60Rl7s01miwxueBym4N2TVp9E?=
 =?iso-8859-1?Q?CUcSirSQUz1X8DHuVsy94bDdfoQGTmC+BirlPgOsDI6cVlHGY1MSUFntYt?=
 =?iso-8859-1?Q?cdhGiuiJCH5H09w0sVrNcxoSSlQf922TZfN7D7zlzjQlxwW7EUuXJdeTzj?=
 =?iso-8859-1?Q?Gi2EmP+r9mmCozNBC9R8yYjz1Y8k1Q6Fe6CbwSUuo3apeUFn7QJDMsGGlQ?=
 =?iso-8859-1?Q?Ul8jHxV5wYPHX8wHWTxYcBICJXQwcrM6OW2J6QZMvqfExc5QWPlFu3oSbh?=
 =?iso-8859-1?Q?kT4wlA10Tuu4LB/RDAJ5WCHvWtoiActh7y5oZi+MZViQOEKba5dowemi3u?=
 =?iso-8859-1?Q?MYfOhUSHOSCDH/AarMHxUFL57UinUmft9Ael1uvBK8uzVChRIb8D9AMqPG?=
 =?iso-8859-1?Q?h6NoBV1TggD2HtMmUuw0iWH6K2DcTQF0ZJXQoZ5zasJQp3bKs509/gqHEg?=
 =?iso-8859-1?Q?pIqqPSvYplLSDzW6zMDt3kRCwXAqlDoR+tL1vBlGU50E02yE/rC7/Tkrqk?=
 =?iso-8859-1?Q?gAAAlzdKwJT7FCc5/Eolmeu3PVZD3L49J8EgbnovwF8v15EBfjJ6tf/eeW?=
 =?iso-8859-1?Q?RKnsvfMWu9iPf3wIULQOihMdkYFDiyws21KRBbMnxH+XVDJjyaSF9yKXM0?=
 =?iso-8859-1?Q?s/dyPjQvatcdlQEMitmoFUttmaGekPLla05K21Cl5Owunbd6UyZ5N3e75M?=
 =?iso-8859-1?Q?oQIVau5OTbDQyo+LD8c1o9oB/P/DlshkPJkmd/YkXI40LP3k6WxIJ4fiIC?=
 =?iso-8859-1?Q?agazzc5Qcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fRfQ4N2SBlDRFvFM0YlBwoTy6TuuesSsgiTBrdOaG8Sy0MFSAl0AUzOcWYfpHcdOHQYNcmq5+SiOahNY0+m37NqXIfkvOfI5BRGuZg5f4Gh539d2SuAbIoxwvHhQdxq+i+22+3mu3SPrFD0UrmISMJymV2nR6F2KUzuPiMMqVCa83y5XMZ/+zVHFdV+CWysd4oz3Iwco7FQwLdlQXZJzrDiPbzJVIXxjqqsib/mtDwrrgM5ai7EVC/tFmw7ZRBh8BUWbMsZ0sOBCA8ZLLezgRj4z8h0a5trAPmI3gvuYfx2KKCQR9J/RGBLq91fxpcNhj/aDrP2Z3lAzgdETiRVFXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35a260-660d-4de4-5779-08de9c0375a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 21:59:40.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHf/vGa8r8SzHPmJ43gIt3GkHzZCMG96YmTZV9Xt25b8aDpM9lcXZsqLXf/fRYrYK21c0E/qjsDFUw2KXqdRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3250
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwOCBTYWx0ZWRfXy/k7m2X4fKcC
 EyS/SC6nBta8fd3yCepOx/9eRg7TAg/PSiWMh7q9P2WXWfmQlxzcXX7aYjgTeXwIplpvhkjQ4DG
 A41kM82Dd0xoJejv4DA1Ll99//xEO4+Uxx6ij0RhjDP+2o+1LxbdTd6ghzQpKfnejO+2e2YV87h
 kG7R49u94Yc4YaplsF4peiSsbMn4NJ4fX0+A9GXpqV6zOQnJ0uT7uaJqjBNvb7kEDQoZiQCWlaS
 n0NpEPYU813UZoy3joYOAvXFG+PQX5nEII/6RCQrJ4cNoMsT+f7UQsTRQ2aaZ0OR3e44tgpxCDy
 EyTznkKctJ2vF1BVy2Io6X0aIdM+YzEfYXFIUvWal8o5W1YXkzX5Lvf+U5MqrQvkAC4Tv0e+sQy
 nqrJBIHwhvG7peRFupaGnAksXb/IkvxDaoLpaXGQdZyoY19bxIBXBRshcV/K5mCm5/sAy2+GCH2
 YpaS3Y0OoBIBM9EzPWw==
X-Proofpoint-GUID: 6LnBHFvch82XgOIrVnNtdtDNhcRWVCLI
X-Authority-Analysis: v=2.4 cv=KJdqylFo c=1 sm=1 tr=0 ts=69e15bdc cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=mJ7ifGdTIGl7JtqJdpwA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: 6LnBHFvch82XgOIrVnNtdtDNhcRWVCLI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160208
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238371-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: 4C87941527A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
ltc2992_get_power() computes the divisor for mul_u64_u32_div() as=0A=
r_sense_uohm * 1000. This multiplication overflows u32 when=0A=
r_sense_uohm exceeds about 4.29 ohms (4294967 micro-ohms), producing=0A=
a truncated divisor and an incorrect power reading.=0A=
=0A=
Cancel the factor of 1000 from both the numerator=0A=
(VADC_UV_LSB * IADC_NANOV_LSB =3D 312500000) and the divisor=0A=
(r_sense_uohm * 1000), giving (VADC_UV_LSB / 1000) * IADC_NANOV_LSB=0A=
=3D 312500 as the numerator and plain r_sense_uohm as the divisor.=0A=
The cancellation is exact because LTC2992_VADC_UV_LSB (25000) is=0A=
divisible by 1000.=0A=
=0A=
This is the read-path counterpart of the write-path fix applied in=0A=
the preceding patch.=0A=
=0A=
Fixes: b0bd407e94b03 ("hwmon: (ltc2992) Add support")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/ltc2992.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c=0A=
index 1069736196763..2617c4538af91 100644=0A=
--- a/drivers/hwmon/ltc2992.c=0A=
+++ b/drivers/hwmon/ltc2992.c=0A=
@@ -637,8 +637,10 @@ static int ltc2992_get_power(struct ltc2992_state *st,=
 u32 reg, u32 channel, lon=0A=
 	if (reg_val < 0)=0A=
 		return reg_val;=0A=
 =0A=
-	*val =3D mul_u64_u32_div(reg_val, LTC2992_VADC_UV_LSB * LTC2992_IADC_NANO=
V_LSB,=0A=
-			       st->r_sense_uohm[channel] * 1000);=0A=
+	*val =3D mul_u64_u32_div(reg_val,=0A=
+			       LTC2992_VADC_UV_LSB / 1000 *=0A=
+			       LTC2992_IADC_NANOV_LSB,=0A=
+			       st->r_sense_uohm[channel]);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
-- =0A=
2.34.1=0A=
=0A=

