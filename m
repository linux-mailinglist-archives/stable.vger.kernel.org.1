Return-Path: <stable+bounces-238167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB2TAyTH32kmYwAAu9opvQ
	(envelope-from <stable+bounces-238167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:13:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A1406AEE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E81D730FBA2E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52103E51DE;
	Wed, 15 Apr 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Lq1TSMxT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387621D3E4;
	Wed, 15 Apr 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272356; cv=fail; b=W2hEcj3UQbrPhmx1XEEVyFO0FH52jYL+mGKrU70lXoMEv/XVyJbMPx8XiyUb0Z3Aub6ap16G3F1hXy/RjaKhKeicUN4qCHrWDIC7z7iYYyCkFd119JVzsFL2ldz5dpBZC6Iw7mjO3P9agczyMWeJ2mscDdB4hlIupwM2YAr7/3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272356; c=relaxed/simple;
	bh=omiKJttkr2g77KieX+qwZJJpA2/YKzIUCAviuCVpHhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=igBJ17BhqR9ooqQS2FeuwFP+sZnek6f4//Dm9yAOVXs3WRR/eha9X0gsSaC53ZkXWkfNHQxGimKn5jbQUOmBqmc0oY16MLb69t4+c0PubVTiIBGCvUVlBQPeVD6/lShKbS0B93aHTsJIldCRQVp7LijyU+dU0DE6s+of+kWnCio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Lq1TSMxT; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FEsRgJ312764;
	Wed, 15 Apr 2026 16:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=5E
	KOQWCE/G9+zXrJicou1o4L6DvV/nvdsRTA4XRyXZI=; b=Lq1TSMxT+osGV8mINK
	wINrV9lGXxvKHsdPfLRzOuym2esfP4lK+rbTJ8v75yKJn9byY3XPhuM3dNrzXzZI
	SxweekEZ25WvRcGoiPax2+LtN9igJ/MsLCO+umJOtSBnqjjrSNM4t4r+FpJN/yl1
	uGGqaMDfmvvMDxxdlLEj5g6UxJHU+YFyL4NxTo6gwcSKU5GGrg3F8r+TI9WJT36g
	RnxX1GSP1IHDqW00WIDIgMiZezoALmmvrXF9m+x3R5GIAE9g7E8giDXFslTIS6st
	vPAm7v9dS+tEnOhdZ6/R1TULtHBRibsw6AmOPZZTYzEM2ncNfgoV1NeiJZxsG6pA
	limg==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dj81kngg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:59:03 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 73032801AD6;
	Wed, 15 Apr 2026 16:59:02 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:02 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:01 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 15 Apr 2026 04:59:01 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 04:59:01 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddjJ1Mquw4SHEE9FORuI9y/GtQtI1+NKq6oPOTh2buBTTXuJrsZFuAerXlN1aoZbqvfrLROztCBBXJwg6/8XgknjaWgW7M80PEBKXCbdLEHaX54gnhYqF2rm4pzgCMM+1QNFUfwPi6gKiC7RMVXQsMFUTgMef7681E6LJsXxGpqWnRt8jsNszF2gUSGh2/cUWveBabjuJsENfobCpbZl/fYwrRKH7APSysN10YfklZYc+hi2Fw13ZImgmaEHf0cURGK2Cg6sBdyPtgCmrBR+ugazBOx0g2WdZDIeqbPhAWDrYNQb+NpoDBZG6YtPNQBcHfM426KaQTaQC56RK6Qh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EKOQWCE/G9+zXrJicou1o4L6DvV/nvdsRTA4XRyXZI=;
 b=U8utileUtkpZzlTJ4GMIuzU7vGLUbT7ncuxto+4dS82Z4fMLCeRw4rAyxXwxG9XYwtZyJtSFDlKIa0Nsf5s+HRgKm1BOF2ZOEgysFAFLvzKJQVHJcZOCRw/qTdVDIwZuCYdE+6Ev8EXWu9yjOFEqvE/J5bLCrsSaL21vqdrDLkWdKO534BhLjSQWqp6BbDvnxcURHCoqJZFm4S5QXZqJNU8RBLohgvBHUDUDWN4tDwjnDfzhpOs/O5CbBPy4mWAqem3r37KnvgvF6IvVZtwIAcdruDB9YpMRKthUVZOYhlKAGQ+CuXv5OFx/DP3kzoZalBeMRyHIPMLS5c6t1+hDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3514.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 16:58:59 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:58:59 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/4] i2c: muxes: pca954x: fix cleanup ordering in
 pca954x_cleanup()
Thread-Topic: [PATCH 1/4] i2c: muxes: pca954x: fix cleanup ordering in
 pca954x_cleanup()
Thread-Index: AQHczPknbqOJqwV5akuwjzwBUaNVaQ==
Date: Wed, 15 Apr 2026 16:58:59 +0000
Message-ID: <20260415165846.43926-2-sanman.pradhan@hpe.com>
References: <20260415165846.43926-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3514:EE_
x-ms-office365-filtering-correlation-id: a5e1f232-24e6-485e-2c8b-08de9b1049de
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Jeg40mFuH0Hk42hkB7n3ZE7ccLxdSSszaFD6H20xQeyGT8JyMEhalI6fLQpEm7hdTd7LsWfKonalribvhmxi20VFkhraKjXgww8YGdLO2w0O6Ed/UwPTIeEWwZQE/9x2U92VZD5FwqOEOq2qc0tez0hQyA+gPujtUhmDwOxnlVBC+bhgMlRo/HEtf0JCdnw7M2nbfn4g4FiCe6E7pKUzvdFNHqEyfTIx+/LOX4tpduBKVjaDiYHDFgphKzIH6NqMw8+OVn3670AXgW/s84Sc2jEwEufkR5Sj40k1RczbEUqXr7/jyrFYlgZRvQTKVaxriBTTq7vdGvNb+gQRd+KUrw7IpqCuxP2l46B6fS35k+/nqcUpBz12si2Vmg0qKyTwGyujsjVfMXjw99QI2+qxjl/GbAvKjoQZbmWN28hV/L4k360IcNEPXVa49hyUXRmdy9q18gAgWdCZg+t2GvdsG3I8xAvmihgW75VHIHkLIqA1fR6SIA4KPss2PzAYCvtJlPkfMZJRtbnDd2+02a6gQXrzTI++H31vtQO8EbXZLxoNaytQbfI+ymy5oePmsUFo6Ohnj5YB8vSuyWWk98xj4zcNRfj2ByCnyk+dD51A3W4o54mkEmyLOFI/aW/LXqa20nkaMY0yFhPilJgmpPDnBRi7eeV9CTEAEkOc+0FD7qsN11CeciSufEVJq6OiDrvpzB+/Gf+DYYn3+27H64UWxAGEzcLD+yK7WC/1SHuK31FFKEm42snaxtkWSDFggSh/VCqbMMpW0wIKYosYgDmcm8bbZsa3PDa5AZLe0vCdbRk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BsCZ7oxSwxGtSrwobooNxrk51jff7AeZXguVkzPh2OTTSazVfqHsPP18EJ?=
 =?iso-8859-1?Q?BiB+eZmVnqPESEkq3c9D/5Z+WROx1vDisp6WBs5/uFvijCmIhGzymHHDEz?=
 =?iso-8859-1?Q?PHIbCDOzpvRtk1jbpQXi1vpqyTGUIwz/QXnMk6BQLNjq2DQagfRCloZ1nW?=
 =?iso-8859-1?Q?v/uVhvHLtyMPd0+wqQCYt2ieXDem2ePimihWe701MQji2X0SuVH7uwvwpN?=
 =?iso-8859-1?Q?xqHPAgy7PJRKo64opSmjZF0yDEI5xOn0/0XxyLVnjOsonh8uGHWckgAm+s?=
 =?iso-8859-1?Q?ExURXxJca7Rd1QWJIdFxP1oxFHkdAT7hym+WF4O6+sTmo22FuxZCp7AHt/?=
 =?iso-8859-1?Q?fPdF6Ux75bJpqPPeRu7flmdRHymGZCVqQhV2OwiGzemv4LabEz9UH6s4HX?=
 =?iso-8859-1?Q?t3JCvfKi8zVpQUaGX+W+DjzAnyEY6GugRo77XWiOMdFK+1bWqk9DcLqft0?=
 =?iso-8859-1?Q?IuSpRBDHgZF7Bx7+E+dTBTJdH167FPngtYEBseer98F5wrmDioPVuCfEng?=
 =?iso-8859-1?Q?tKqa3AJ903d4bPMvK8LMVkW/zMjA0vOQTFLyjTPPX2x5Zxiyilbi+xxzA+?=
 =?iso-8859-1?Q?BIzgkA9h4IC4KbS6+yhjKhyDcYZLu6qK6hVIko6PtTjqwz9+eh37iCso8Z?=
 =?iso-8859-1?Q?gqaeigeqMSVQpRXWRZOJioeh4lyS4HXr17pMRXfhSt3eSP90ZKVqoSdCzE?=
 =?iso-8859-1?Q?8nlnKaApQUQKcYhkVj4r7hkGLvzXMDcscnMPgPk00qYJ+xRApNZwkjT7k5?=
 =?iso-8859-1?Q?t+dcdkmCDHKJHyxOZBsYarRnSeemas7gl0vZZgj1NbpFTzkuwJ8NESjdSX?=
 =?iso-8859-1?Q?mS+5OC3F3iiLzOlno14aIeym4P2/t/dxI9H9ibUM997s5tAc3pMKclUXYv?=
 =?iso-8859-1?Q?Ck/1uzsAJKCuECT51EXJfZG5SGaLi90b5cHAb8VkiO+ZtJg5r/1DVayWSb?=
 =?iso-8859-1?Q?1oLdoBujNewaxXTeMoWHihbXvJA0b9OnpGd9LKVj83q6tdHxPelmKEHma0?=
 =?iso-8859-1?Q?tGrQi9czxF+lDvN1B2z2/FEeQyrkrKYXx26rlCbcKqCwl8VeH8AL05yQad?=
 =?iso-8859-1?Q?8FgM5DhcNHtwXimDssFf8XxPB02xoEzWG2llP+c3Hn8F6IaTLRWvo9JALf?=
 =?iso-8859-1?Q?8f73AC7TLRJUUyfNwYQbgMVIqYDZy/Zx2yZJmPaK5WQzf7LwBYIdgniEjs?=
 =?iso-8859-1?Q?KUl/xjAYJVodKiw17czo8LQuzvLO0/F4OVilkXW4uIE54NAD7Wbd/eZxoS?=
 =?iso-8859-1?Q?yzj8ZjUN3OnZb2Uc1naHGiJ5lsHzR2HVlVtt5+J3Aa0AG7yT/HUCNL9INE?=
 =?iso-8859-1?Q?P2jUpCEyl3tvQ0KnVWtQ9sYMdi3iyH61Qz58AZEAcB/IXLRwPi6wOSnRmx?=
 =?iso-8859-1?Q?2iKKK1e9I2Mvlyx0zMNEu0gd8PppIqu6V4tvnfmg3ePZJVuRZw8fgxS5SH?=
 =?iso-8859-1?Q?UF9ScNm4xtmBdLEjFtCVgRu7X81FP+p9JeHdmZZQ4Y9HxOftXNuvewiApj?=
 =?iso-8859-1?Q?25NKJoNsxeE4ucaNXSyqx1LQ3nEeh/qPkQWojvAbutkZMFsNo+daqGmoii?=
 =?iso-8859-1?Q?+rV/u5bTh8kzvwELvvPrVExj0VecIJMrcDci6ou9PoMQBxTPleDNvGGgoo?=
 =?iso-8859-1?Q?FnqAvqgv4qGLrNNWRuzgUrFANPM8RgNTQUGpvSSiWmOYLN/HlvXvSxzgG4?=
 =?iso-8859-1?Q?chQZJdmsnrPwjA6iZVGCeHr8fZ/zA39oXbGlfUTXotWSsZ7NxJCT8c3Sbu?=
 =?iso-8859-1?Q?Tu+HG1ZjuBLiTlfSQ2Ey3IV0oCJ/u9I65tCzVqhO9NLExkk0e9SSdpx8R5?=
 =?iso-8859-1?Q?Iv4otykqYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FRAvDd1/+QOPcIHpw4YXgpZlVypbASboj8c07p1NyRGrAvjSPR6FUK+8xHiDWM4E7Ttojv7Igq0qBqTPYTcgJPD+JRMHknbUaxG4GwxV1zUGfflTn4w2x0BLVyX8ajUdB9AiaC6R2yIdE4LK0MCPNOkpK9WuCgqr2agYtgFD4kn7JE2OG+FYgDWYaPV5oIcdd+WSJ3y6eogcdk6I0J82c7PSDpUtpkiG2JHL7rP+gyHBH74wS5iT/4Z8b0AGImEzgkGKYMB0uxWCMXl0zeDZ9b8dbjGfm1QW2rcBkQ1BlN7vLgvu9Aa9esWPYSkvRXVxs1lF8SYsL/bUFj+yZDVmIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e1f232-24e6-485e-2c8b-08de9b1049de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:58:59.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrZnkR1BnzpzDcNAxGkDvK/eeEphDXxDnUkZ/7bP02oQ65KqT5UQVTh28p37skEooly5F/WLWSP8a+FcRyyU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3514
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: NjyrnzJLGYrUzUlZQ4_Z8Wrk8GAObtWN
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=69dfc3d7 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=hlGQ8jtkdgq3GKTAoccA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: NjyrnzJLGYrUzUlZQ4_Z8Wrk8GAObtWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1OCBTYWx0ZWRfX3IjY4gZlMF0B
 sRSGDlxYwqATp0ukyhX012Gm82SwRu2MLNw5mF6/fYSRkvUKCIZL0cPOO/qMASX9OylStTVAHHn
 EaWFGST+PWQ9qGkteZJyDN043kY1S7iwdjjubgOOzITLXgi4WzPJyEXZXM8Uc1toh4RcyBAAxxe
 ygYAadLr7OYsNohvK2r0u0T+S+jEPEEf7OJBTeGF13bvm5WdUQ/cDQTnxxqI+DbNnGYs+aXA7qA
 YhsfboMKAve+caDHV/JmDHf/f7nEih9KOXLOYw35ifvsRM1Uv7JX8MK9HAiW4LbcQvm38e4yqVL
 0nDBFeJR3b3SOxmkob/5HCZszuH433AtSa49B2ohWRYyExtHYm3UHmzgtkhVPNL9RS5qk7uooYX
 bqWMuHqhj60yRuHM3VXB3a/1mjdgAXEFYeFvaOKhofDRWDZfgmFdE9zK4CP2TuOm0B1Ucqg0gdx
 Lz1d+jJTJIEKS3aRGZA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150158
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238167-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 142A1406AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
pca954x_cleanup() disables the regulator before removing child=0A=
adapters via i2c_mux_del_adapters().  Child adapter teardown may still=0A=
need the mux to be powered, so the regulator must remain enabled until=0A=
all child adapters have been removed.=0A=
=0A=
Reorder the cleanup to remove adapters first, then tear down the IRQ=0A=
domain, then disable the regulator.=0A=
=0A=
Fixes: 6c30ac917a46 ("i2c: muxes: pca954x: Add regulator support")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/i2c/muxes/i2c-mux-pca954x.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mu=
x-pca954x.c=0A=
index b9f370c9f018..f0b8879ae5fa 100644=0A=
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
@@ -466,7 +466,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)=
=0A=
 	struct pca954x *data =3D i2c_mux_priv(muxc);=0A=
 	int c, irq;=0A=
 =0A=
-	regulator_disable(data->supply);=0A=
+	i2c_mux_del_adapters(muxc);=0A=
 =0A=
 	if (data->irq) {=0A=
 		for (c =3D 0; c < data->chip->nchans; c++) {=0A=
@@ -475,7 +475,8 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)=
=0A=
 		}=0A=
 		irq_domain_remove(data->irq);=0A=
 	}=0A=
-	i2c_mux_del_adapters(muxc);=0A=
+=0A=
+	regulator_disable(data->supply);=0A=
 }=0A=
 =0A=
 static int pca954x_init(struct i2c_client *client, struct pca954x *data)=
=0A=
-- =0A=
2.34.1=0A=
=0A=

