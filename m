Return-Path: <stable+bounces-233941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD62OiaD1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 919953BEDCF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55593033AB6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAF3B19A3;
	Wed,  8 Apr 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UI+RFxTk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1573B19A8;
	Wed,  8 Apr 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665897; cv=fail; b=ma5ZBtJfABp/GzmGZwj1+mwZkGGFP5d3VB5vJ5EDBz5qUtvoVx7UYg8UFPs0mVwOOkwvUTD2XFwJh+IT0V9iYYAeLckLHjBfdcfE7Vp/eFcTqsnR1l1Fw/vF8HoerL4kZlvXGXqQb6Eai5ZeMYowg4kvNIaEC1lHZ4Ou5tqNM9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665897; c=relaxed/simple;
	bh=4qRCZLxo6jwXv2fJHR0nPcB5tRsMNlHtk6VPITQr2ME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOP2Y4KeAjEhKYy3vcDyfeIKmzO1ZKWnD5PthKxeclBZH+XnRkJ51Mtiiyes3kT8I1rx5HmqSE5QKYFBOFU974oX3wj0JoCMixvX+btEbkT4CXKeO2TMGB7T3OzyuKW8XV7tn6FHJM5NSmv7C0JdbRFWzZt4qNI2yLE4DWt/ZPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UI+RFxTk; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638G6JdX4025229;
	Wed, 8 Apr 2026 16:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=g2
	j2fm/v79ZECaagvcZYh+ZbDTH/2WUE6tdwI+2tz68=; b=UI+RFxTkSY91QVOcLA
	1O+KwuJCsHXtDGQUaLrGGYzOPtdbKJRQKZOel/9y9yaH5xyG+erIxRCs/1FEbn+W
	+hZfQSSSzsXJyurM2Oo/m1nl5pOriuTEIERwYLHrCsSqLUWPAFtLWp2cLhd7Oia7
	v354phe89e+fDEmK6H2lSbwU7/5/D4ElHvcJtVINB9Lh8mT4MNDWw5wGiLgEwRSr
	czkXYyZdsoYyl0ql+dJRgsCyVifAasb0OYcmC5JZpPrLyxf/qxhYfgsPm2kiEIAa
	rsQB0Q+2tC2BaYIIw3UIT8f5xhWI/1r6hiImIx/j/XpaTeEZ9lPbuOvK2V1fVXFR
	ywuQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddnv2c12r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 16:31:10 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 6D35880170D;
	Wed,  8 Apr 2026 16:31:09 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:05 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 8 Apr 2026 04:31:05 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 16:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEBye1PjoPLkdGHaMRgz0qWpIDBoSJarT82GfIk8/u6J07ZrjebQBMvHEwNA20x/MmC/tJxQAdzR2gLjjun1CzzxxwTXTuM7aKldVUDW87kyqi1LcLB2AQ8qn1h3vr6ZTMyWbcu3C7gbYnEEcTJuyGQ4/k4PQps//0AW82dZUwi1wMGnThPrtHUSbzjYaKDZt93Vz/mJE0M6XlAkNVAI6KIumId0TeWJ+Ko79L+X+CPP1jgcqEP/lNM52FYEwG0+ZxhzDflST3ES2dsrm9OvWr7YZR0GR4n0Y5fNVM88eDW3NqUjDG1ZfHwWZ+bKynaHRK0kc8s4GHC6KBbgSxZCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2j2fm/v79ZECaagvcZYh+ZbDTH/2WUE6tdwI+2tz68=;
 b=Sur9wqcrgpZJhMrlZNucSJMY9xq8BgPRdrmuW0Hr2cNj0SvQk85A5H3qyR507mQgIfWDHY2SSBuJzM1jHMtxaVMusWA8pzgvSCm3xWJJWXqsQ3cIbMy5LjSujPJ+gnQmfJXur/4vXCYkA1Su5kc9nFsdOQr+jg+3GM4OAJqkoVE5KmxZ0tFMmlAlnhHpRmKJKFx6eWPYRnlySpEB7kG5bGTo7Gfs19lhTBEwkM3AFeMp6n55EeisdQqWaKHw7Vns5F8H6ca1iRUVJTxuxbOdS5k8sVeBH90b596qQUPByfv69ATD+zHJH46gSLdzODW8ZNN2mDlL0nRvi/qQUw9dAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3528.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:218::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:31:03 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 16:31:03 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 1/3] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Thread-Topic: [PATCH v3 1/3] hwmon: (pt5161l) Fix bugs in
 pt5161l_read_block_data()
Thread-Index: AQHcx3UXpqFH/jPqO0CU/2nuRJrWLg==
Date: Wed, 8 Apr 2026 16:31:03 +0000
Message-ID: <20260408163029.353777-2-sanman.pradhan@hpe.com>
References: <20260408163029.353777-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260408163029.353777-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3528:EE_
x-ms-office365-filtering-correlation-id: 7052cd61-948e-4685-6c42-08de958c3a16
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: owbtoyReQtDz0VsUBsnHaY2cMffajkpL7dx2tE+oH5G+7QkqiZBcllcbC6C8+BeglnJ66RvkwYvhZsKtXusJJYNX7GOAeYZTZRfUVYdeozXCOytVpOm0EaQm0HSco7Ufi7M+P+30npGy+kOtqGYBsW4ooFTbJwKaG3JV1WQeVqu49HJw7llIt+C6b5wVNN80kUiE7CPELiu4Jy0wUHmnzwHqbHf+GX+0Hdw8g1m8aLfP7SwrbLTXoGZESMoqRAcT+A7rGiDij9WrSMpCyTusGnEh/01f5fRGOEeeIkNuH9g+JDLl7uO6mqxEErQ7hOPe+N9imyX0kdTM52lUgY+vWej9l7P43/JEmasoRkyjfhgrhzfRkPweddsLxfW41VaRsixkEYDkaJl6d5bnqaREyMYlGtaFHdIKxxqhKNU/k/YHLUatg3gC2FN7LiHIWy3r4kUCl0ygr5DEypeVyTjfmgmDHG5Y5cENByJwXcAQ1J9LxpbbXoehuWtyKFItXB2xwBmhx2sSalooXMQTSnR1Ws7E+OO6lbKCJSyonKX/VIDXRfsjuKpOP8SaIFyduFK3eLnkOxX1qQE4Ofuz/oDNyOBK71rmM1DaSQKLxF2xd+Kx0PnHw7HgoZ6zeZ4bjQxahLFy1caprNdin6MOk4jRvj/Fr3RA8+D3QRtuO7K42zI+p3mriCEEuJ3Chcbyp7mIHR1LadveG/ObfrKiMlz7jVDwTNP758BQX6oI70O1IbtXATEJeqvWW7GON51EDtwrXSwZkDx4491KV2TWpPaU01h/+L71EzjQKf4mIbwRf+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KA4GuUS6ERInc4XdDR3QVoRaUAxSvQJLLjk9wlfMmNr9Oqrbi6g/Ixb22k?=
 =?iso-8859-1?Q?6NWZq9KZIrvoR0Gnx25FIFiC85AsE9qfqb6S6/9bhb3o4+CfHMEKPaRbcf?=
 =?iso-8859-1?Q?SCspnqzl2KDNmRHi3SupLPoeXAYV4w4QpaqLZ7B61fhIRmGqR3IsXHVZGZ?=
 =?iso-8859-1?Q?8+ZB1L0CPsyMCy+sJK9d4mlRB1xHzx84ZQoIRwaK7RnOCAxADwwRcgzsEQ?=
 =?iso-8859-1?Q?Af7Vrfe23EiJ3wsNK/Mispp5J+6eLEl94lQ/alYBLgvYgUwbr6wU5p0p78?=
 =?iso-8859-1?Q?DSincRCbS7PlYWva+vzpvq+4xtEHaBHQY7P3OjXlkpQQvKL3xNmALkpZGJ?=
 =?iso-8859-1?Q?6xlM2+5qas993hryxaJYKuPaYCkp2X7Lz3DOQc1WhlXrZGEnUQ0x1SfvXa?=
 =?iso-8859-1?Q?YaxBsi4OsU3Gfq1/xpVantqC0F/yYmIzdQqWT9m4YY2gtnTicunTSJecRx?=
 =?iso-8859-1?Q?GJHyU5cFRxwIEJbjwz48SXoRvJAFuiZIW+rMSZrsnfI52L+N8/w1LdKYW+?=
 =?iso-8859-1?Q?LhrifA0/jBOpPZXgCgdKNMv9feSxTIMQFs70s3wYbHxZ4m9+TQClWxafz1?=
 =?iso-8859-1?Q?X3tLUFK4s0DVAcQRAwYdtsi7YOY3mcRi7vTNhX2JyqLZqOxHl93EvTKgDx?=
 =?iso-8859-1?Q?5sSQAPQ2MsgGmGdLKPC0i1VPyHAj7/T/eIr1o9qOnRXQVaj61Noz3u+bpJ?=
 =?iso-8859-1?Q?aB2cP/gnjWFURu3dPOBijxR3/Wirl0rMuFYofiYMDO8cRg7if6gsXa+/ok?=
 =?iso-8859-1?Q?TVuVOPFO0v/dyKe+QqwghatB1y90oN9VJOwMmzrbmYtCaY0oih1kqge7Yd?=
 =?iso-8859-1?Q?Lh13GP8wspeHm59ySvq/fOhhq/xxYd4v0P2dTEQtDtK8EHhGbG3wuvSd89?=
 =?iso-8859-1?Q?8o14l41Hp4M2KBGZwlk9ygANVQc3f3iUJ9gm3+z1crhxQ0oIs6J3UOiGRf?=
 =?iso-8859-1?Q?yOQZVoMbQYsEfnTSOG1YNP5SiNlkvnR/0CsovDok/oTmGFtv/v9xVfqfy+?=
 =?iso-8859-1?Q?zZPG6OPQv2bwz+BcclLEowwYomydRFpHzlNCl72ZjSMSNj8wAeMHaeyBYw?=
 =?iso-8859-1?Q?M/i8dSwVWw+M94BC2ChE0QMKkpXoleZyAyguF3SLqhdboXs3pmdHasy2oO?=
 =?iso-8859-1?Q?/gYPjhaTW4Hqvvpk1ILaDavEPNCCR+VMy7GB7bw0eLrDEZ9ONxHBPc5YTS?=
 =?iso-8859-1?Q?e8sxJ8YDFn2vgPpn1r1ca2d+vDCBvtXqDY++zvQ9JJpdQ09vY/OqJYdN1w?=
 =?iso-8859-1?Q?FvPQHuB8XD4u32QIFEPlAcbCY1qPm1+3+5shimpaoLC0AxBWmXkbuw9AIN?=
 =?iso-8859-1?Q?xke4bMfhEfpudgjoRbwKiUjICxzWGG/OQ9EmXdFD88149UTvw24jLFcSzx?=
 =?iso-8859-1?Q?QC83jnfulv0KeBfYKp95C3ZUrM/u7ubz0fzH2Sctj0lkjk6FnvhE4zYIrO?=
 =?iso-8859-1?Q?HNRP3ammvYztQF16YsgaNHs0TbqVr1qpQPjhgRQVNmrySWR72YCxPM0XKd?=
 =?iso-8859-1?Q?a8A3J7J1AMc5mx3rrhlYVFW6gJRoLPXTCmqzBao/sNDNRCBEydBbtXzyoV?=
 =?iso-8859-1?Q?/CBgHEzfTDXWYPwG1OgvcFgTEry0hRjD9r7aHW6GjmDu4J2bejbcAranEA?=
 =?iso-8859-1?Q?0k1lvg5UrFCGEiPacy0SUn9sFA3ULSavjEs6SP7FhJF/Kjk8eYqcHs6Jus?=
 =?iso-8859-1?Q?EJ5vLy4ixlnRqli1NNgITriSSMxunKoENwXLZ59tWh89vCZr+6koW0WSkJ?=
 =?iso-8859-1?Q?Ve2vm7c8tIxo+0vJfb5p6avAPWKeBrE5aQLlKRqhNn6TZu9fmBmMBhd/JS?=
 =?iso-8859-1?Q?kdr67cX9rQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YIaSsBb8UovuEknrZi7yfj0F3IpNXX/Xkpd6WsPOJ9bGjGAC+Hftihkx3kwbmGXptQAPdb0uMcklVJ83TMUiNHf/l3eJB0cdveASj2w1rrXToQK1C6zkp/rhuC1OdwGAj+Swv4Krj/FcO0rxWipT/iL7XBXMWnUT0RlDbbVcJP/VOlR0OuVmK1ZZ6GUNqYGI3DtgPZazs5M1op5eb/MLbKx8hTDITcIAX7QEZQOsDRgHBwP8eWkD+zNVNipqYtU2PlC4QJe9Ts7JdtW8UjPsc1NJSo/7/1fHnQVCw6e7lvSp/fuyZnIypAfEMn3dybBQYjDbFqtbsJzt223kSd0vdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7052cd61-948e-4685-6c42-08de958c3a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 16:31:03.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eoJBzkgJam1WmoW0mCUsJkSoC0RCv1RHTglPfhc39E3CboswQYFA4PTMWrW2VBPvG/qRmyjonF2cjoCvm/m/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3528
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=bIsm5v+Z c=1 sm=1 tr=0 ts=69d682ce cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=2miM9txUn0MiwXLCYL0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: 1I9hD9reyJFMqi7w7sobkYyE1jG0HJqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1MyBTYWx0ZWRfX2ULlZL2xkZNh
 fIf0/nPSmu2CyYUbkNT/HgiBhvYHnc0hnk0pSXKiTjlJRM4QY/MOeFMSXg1oYlI0cmCqX34NwoP
 UfTNdT8sFaqzjAF+w9OwmN2vbU3iSJrK+dWIOurfhRGvEAHMuLblcVcLeqzXxGMluuQS0/BO5H/
 akQwS3XU87jzMkfeIQ8L16J8royjgTZpVXLmIUQuVwepFAksj2r18djAa9RobYADq/QZ0VZ9PKX
 L7kbYz99Hgkr1WpXZ6Sr2Ec0DdTjwEgiSHS6XQwz7U+gGWHodyX5AHH1Tl2yW/NEoCnSkG8EBJs
 rb3yNfdeQh+JEwXCvSNpFqPD9Og/bT/uqpUhmu4czwqSInscVoF0lwfG/SkH+ziQg/8z2yY6hCX
 J01t/Oqs6WLQm+JvHXYcW8hayzjpUFMUHPA730hRs3IM0l2/v3RD8DQCKceBefIiATnUSbFFMlb
 rGoj6LCE+CYoottlHKw==
X-Proofpoint-GUID: 1I9hD9reyJFMqi7w7sobkYyE1jG0HJqA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080153
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,weissschuh.net,quantatw.com,carsten-spiess.de,vger.kernel.org,gmail.com,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233941-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 919953BEDCF
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

