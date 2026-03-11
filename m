Return-Path: <stable+bounces-224755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAoRHTjTsWkEFgAAu9opvQ
	(envelope-from <stable+bounces-224755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:40:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E1C26A0DB
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EFF324394F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BBE3815E1;
	Wed, 11 Mar 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="02HB2Q8v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="B1FefVR3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A1345CAF;
	Wed, 11 Mar 2026 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261377; cv=fail; b=Lsa9ObkmbP/WcskAppJTUACQM/Rljs0Q3wAz0sXvwqq8bWzhxXOvwCY4zjjQRz+PnYGDAl/VKE50CnIBoHKnmxGO7QJdcEFujny3U4r1QJSfi8V1QgjDz4oBCmcdUgeHJfLT5wrXoBgc65F5qc4Xfx7x4/YBu3yXQh/6rw21jgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261377; c=relaxed/simple;
	bh=AgH+Yb4ldY0ZOtjChGriaRIeslN1TE3wm9qOLWn2X0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SffVunhuqdYFmhbdr+difB0btZkxb+0H8sz7L0GBhkC28uyl7Y1xA4lDFyBcJnYg1foKxZ7JMAEyS5HDRpJjvNcXq+rDohBR0y5lDcHmth1+aQGhLyGpZpY291tJTPmKuwVpyF99QNMp9HEJOhmJHntYYr7jHSo/efRdY1qQnuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=02HB2Q8v; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=B1FefVR3 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BJn14P507984;
	Wed, 11 Mar 2026 13:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=AgH+Yb4ldY0ZOtjChGriaRIeslN1TE3wm9qOLWn2X0U=; b=02HB
	2Q8vZ2cNSdr4YwL63uBdVexeCx8yQMEZKz8VhiaJujBu/7JkV388wv1ONgA1moLc
	NRHdzkRbp7i/v0pQi6Tgisf3VsdTjM+0B/CRoJ0dw7OSt8uvlfJVcHFq/78saG/e
	M/SiPWS2ZKSajUeBt1RR6eCoihO5RhLnYb3c3+SAJfIEgPkAtzT6fxsufFme+R6L
	a2jBD4Zi6fwu4VOC9lsJRIayZbZJaKhCDcpdIUEEF2CfxCDvX6re08ODlClld+Lv
	K7sbyLNp7fK8LKZQYMG2alHc9tJloilkZpXRi+/mY1+5pyE2rm6YdUTTrD70M/Y3
	vLJLtZqzsLgsErOOzw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4ctpep6kps-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCKqd+iySnPEnCfJOHrZUopkOPRJqsJwKI9Tc6GwRh30AVcaNHIUbZ0c8uzYqMjnO54DF5xIM+/t822aJzlIiICfOO8p2NxnG9+lvGpj9FwTEhuXk+PmdI+vd9sP60OhVy+1ZLM8M6Ma7ycGAg1G+AnNzUPiqNzyedrYyPIuZ65IC/oGuC8zAUoqPm+xYpEMwpNwkrc6oFEdI1N4WpJqN+DaUdy5N8V5nRJe09XS5ZN1dLPOawbuli9HpZgawoOFuOtzSDoH32GWVCtc4QZ4diWi+kFSUyqVWNP59/JV6FKq2sKSlvlN+zOdJy8PZ8awHLBX+T3XNGZaG8yQb79IAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgH+Yb4ldY0ZOtjChGriaRIeslN1TE3wm9qOLWn2X0U=;
 b=X38M39GEIRrtPkHm+hEWf3AJ4SdvNySySDpaFJS4SxmmDnJrh2HOO5J5eV5ka65a8wyCvM/HkROITBoBUHdRzY/uN3DMqyf7nnGpcHjWsa9sk5FINUKnM+KwqLVZhhYQtpRITRpahXoYpolsHq+D41QxSAhzKAF//rpiiAMvxAABoSv+e1oTWg6SXyVF4EA6QA1AMaCIl81oUEIoIFlv9CteaChJMWlLacnn0XkAFMD3mA+AErxIYDkMqivdukZ2xLKTfreBhxsl5MIXfsjww94LugFfSLOSWdC5iWm0uGPqQVdCda03dJxW7McuD6qXNzxE4Bp5ED34jbp+ikSl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgH+Yb4ldY0ZOtjChGriaRIeslN1TE3wm9qOLWn2X0U=;
 b=B1FefVR3A3cIBU/avb1xceEaT+x6PWnfrH02nXATIiqu7AeiGj9Sth3dIDhwCS5lp7pOSIyZIRvdkD5zu8MqfTSKTTk9tF+CMFaB6T45eHM9StI4HHzZuS6VghLl71PUAsFTX7uZvZedIhArngZmy4SzcNY+GxQGwAvK8cbw0Mk=
Received: from PH0PR05MB9745.namprd05.prod.outlook.com (2603:10b6:510:283::11)
 by SJ0PR05MB7454.namprd05.prod.outlook.com (2603:10b6:a03:28f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 20:36:00 +0000
Received: from PH0PR05MB9745.namprd05.prod.outlook.com
 ([fe80::76d3:570:cbfb:f05c]) by PH0PR05MB9745.namprd05.prod.outlook.com
 ([fe80::76d3:570:cbfb:f05c%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 20:36:00 +0000
From: Brian Mak <makb@juniper.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is
 present
Thread-Topic: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is
 present
Thread-Index: AQHcsYmt1T4qUyLYIUWPAkgyL+yJyLWpx2mAgAACzoA=
Date: Wed, 11 Mar 2026 20:36:00 +0000
Message-ID: <5DAE3FEF-366E-4A48-A7E7-21E564DC6EA7@juniper.net>
References: <20260311190225.22426-1-makb@juniper.net>
 <abHPy8sQYWApqbmY@ashevche-desk.local>
In-Reply-To: <abHPy8sQYWApqbmY@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB9745:EE_|SJ0PR05MB7454:EE_
x-ms-office365-filtering-correlation-id: 2203228d-7ccd-47d8-69cf-08de7fadcead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 GTWlHO4ujfYeG9MIPZ9yllFTHZhgMNdKCIOyBXUd1kgxPy9FgYuc65HDTA/53IDOk+HzmqxvvmW79+ZKlXGr44pFBeDdUOrfiP3rfmazLv+Wyl01H1sJ8qJn7uHy//mgMHJ3tVBx00HwHhH7fHF8vJidsXxpryC1qNT0Fzd2p5Ll7XgptDgv3SpTuq3S4SjW2wkXmAZaIkDX2SCHhdzoH++u0FcQ1JdaklPlE5Re+gQpwRem3oDeLJsF5eGlt+m0jRfXDa/2gwcZCst7p5fHpAfjeha033sQe5ZiUXXGAWswkPQM7h/oD+AmftMD9RRTprh2F/E+GzZSiFjTfAmkBunHtEcyhSpHwZD5L1e/Q0AsH9zF2RoQx04cEzQGbVpid+w7E0R7AbmK7E2CfczzLQxAyVK7PA1Pr0U/zYwiZMYakDXGJt4hhJ1frCYM9buAF7enNkL4xbt6Ll9Cm/AgrmNkKrzaDHy4/GYq68N0fMLxhWui6pLQRiRhlI2+PhtotY4kUHVaybhlrUmylktMjSIBAzkIg4vBnrGPi89RU0sIOn/xMChl0Iy7HlzQqnGV0knH/aACz2ZPIxOrQ1ahjc5kEUOh66OzaNzdJmAnQiFiEQux2dtCNXoVTaRAVObHUxmCnGFRM6vMBrm7lhSRMT/jEit6b5fdzHVvLGQE9spZvXocEGyJ91Vj7M0DK0QWqs1e+FJqrjvciM2p0rCfwtlbiYBDh6jE1gD2tVq8xAQPjkv2reNV3EvXEMWg9uXqeKdhDFmuMWteKP7AlM3rLYZv+NY49qY9Wb/fd08jPOk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB9745.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OW+pQfbHJOAzPS253LCexEkbYxOEgJOcaZ1gK3mktUF81+7HbhLfq0kNNk9b?=
 =?us-ascii?Q?7vqBY7otKngkaHJSspJJXZnFMa3RBmrob9lMOXGlIKATtL33ckv0y3GfXyFH?=
 =?us-ascii?Q?XlTdAT0hcWevzBq5M/rWu6HpyvJXWi+ZuunoNHc+CKY5Ru34jZ/emvbHH5Ty?=
 =?us-ascii?Q?Z9jpNayvxMvQ73nHoFhzLX7YDopjAA75QF1qVKhiOi88eu7GQe2i8wTQG/cN?=
 =?us-ascii?Q?tKoqK/thDliU0p5d/7vp3D6ungLfmq5aIPcXUcEURjRnv77bndZlGAdUazPu?=
 =?us-ascii?Q?6d75GV5VZyKxDhBSKK4LnxUSxaIDC142uR6+elV1OkTAzDOcXez3knu4Q2HE?=
 =?us-ascii?Q?a+0K62JQy9zvyuxmOEDP0qfU1G6zQ00yBgoD3cU2zLBM26s+xmXVdhMtmS+9?=
 =?us-ascii?Q?8b44y2vGJinup16vSp6oJPZGy7XT7L5WRk/C+B0VNbyYFTcij5C+Kzg0oIuh?=
 =?us-ascii?Q?Zv5Yi/t7RertLaDeQCUMnqi+27OT8nA9v8VHmk7HOI+6bil6aHzxaJvOHigk?=
 =?us-ascii?Q?j0XwgP0mczw5Bs5iZgAonTbfnMvkyCprIwVBFTM+feIqK4UuyK9WH7wlEm/e?=
 =?us-ascii?Q?rXcZTaKckyd9zWFVpwDhwyDcA+HrzxmdA/i7lZ6eohXwSmRUsDJhR5uIBeD+?=
 =?us-ascii?Q?tdFNqR0VZnVtSBsXrU9NBV30gbLQKUnPF4fJWcYlum7XuidCVgHXMlSG/jN6?=
 =?us-ascii?Q?I4NIrMXB8vgld3ZiJH/AO4mXzgISHdoSAle7aChu+pvOzGoYPyKWAJbfbRkm?=
 =?us-ascii?Q?Xe24oFpMmLdFoRm7RK0wTE+HfnSrg9x/zZ8iToRElr2Xa1BCI1qk91PLeAhP?=
 =?us-ascii?Q?9XLayoEGMR7Yr8jX8adXgkgMwsO9719nsvYZkRuNnTWNUcCXLLi2p1XlbEJy?=
 =?us-ascii?Q?0PPhU5VuxHKatmVxYQvPd0hPZDrSjapDB8mo9afI2jP7dbgE7kzYcVdMO5vU?=
 =?us-ascii?Q?1wCU6KROqnJK7Rba7rvCtfFZY56vgDOwSEw2ag+GXi9lRQGKOC0wMPc6mBRV?=
 =?us-ascii?Q?xEbhyTBmf+oeeS2882lr3gBtxvDaYEaeC+KRlr2fOT/W1S+gfd4sPYhj7Yi6?=
 =?us-ascii?Q?av5uTFKpqGDekZhzdZiCk+PDTEt4d+SF14LGigwMg6QBZukuaG8lwW4daQqP?=
 =?us-ascii?Q?TA4Y6AuAq5Px++DuKmM5SmOmJNpDjLjK/7uF8cggpmT1W7nUZ7Cb2M/fcpgD?=
 =?us-ascii?Q?/ZDJ+KgwxqbIdOzwy+P7GIkGK4dJViqpNcYW2x2NEVsOKBpZeafPz8yjx0on?=
 =?us-ascii?Q?pAfTwHkzsgwqkPzvMer8KcMe6meNH2VelJdUumnwTRXdTyx+2u2i2Gp7C/Hd?=
 =?us-ascii?Q?dA6WGyKh28whSl4baE/nl9Vi4GLjk8Ehq4REQaJdljIWtMdqpFTAkcL7CU90?=
 =?us-ascii?Q?OkKtRuSIGemtt3SCqlS/OgKMstcjYelkERYb38qyNQIcVmTcWc1KN3qMyhJa?=
 =?us-ascii?Q?oyRT9mcRhEFakOZj8afdqvmnsmXAU6vxRhJi2Z52nMNezuMOKyQfahWfBkvP?=
 =?us-ascii?Q?hPZaDOIj/5n4ILy4Hgz4LtmerqvI1S5DuZ/dENYL5Z1abW0p6avABBF6aXmr?=
 =?us-ascii?Q?RS38AjqYMUVbeVr24CrRowywC+0g6e80ZEEsO1+tXELWFPUgIDsRYIea2ouI?=
 =?us-ascii?Q?gEPQzfrE6QgQF8hcvm5iti+vnulZ924O684AFtRNppj3STInDnWVvbq53k7d?=
 =?us-ascii?Q?vrgkFxzdmN1HmfkYSraFAR/OSFkCGny8Klm71MqiLPTkmyxcEWxbnF16OKYP?=
 =?us-ascii?Q?Da1gZ4R/Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6E202441B31504C894F20A2CDA22E7A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j9YCGKyLVIaUq7IQm5ejTtcUudZgK+p3qMYdelfjaFpE2oKdweyGXfDXkYEvB+ZTVeR0oyWc/OR8s2cKcLe0gNE63vdlCdkxdX77MuhlNzdhr025smL9PjqYxe6mdrT6OyH4m6eJtnKc50SNjTg0VDvTERGImoZ3Vh37H7f+Ev6fPzQbMmjPC5jZjYDSG/XiP4tgVTzzYYCo8DI9jHYkxuNyaUQrMdxmtK76GxnQpPmXeaVNFs2E5gFn5aGGtaGujKpxuzhg9JhiO0IHaWNp0om4khKL1a5Q5UgZsCExwgR1z3uwA6yDRejNu+St+od3pcSrjiXjcvLkWAg8Fb6u/A==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB9745.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2203228d-7ccd-47d8-69cf-08de7fadcead
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 20:36:00.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IixfS8bWM9pb0z4g0V9GG3EEw/t1TzNibG7DyG6e2fYqfkA8HUQaveEC4tkqNvsrzANQ4vNwoHOx/Nqyyo79kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3NCBTYWx0ZWRfX+b3/2JWlAM+g
 s42ih+nhTJs0WGi3brU2Xk2OrwoCIIE+oqt6Q8xqd+UL0JLHqYICfXHzc+ANEKveO+Sk6GmIucy
 jSQu5wFn4OQV+UZ8sxO/oGVmsoXqOaAgoQ28ztkZ8bDLuf94ZwXc44oR8RuSX8qwSujWhwTapXh
 CJgCc95bgDBh+WxrxU2KXLzIbK1rTomTelVA1lXDW24ZCmXEyd/0pENkxoQPXpcCcyFGZMqVPWw
 AtkQi0+GwhtTgdLmDFlMHtDHeC9IsOjWTkXdZ/PXfgSv4HRBiAsN+/cbdrVV5fqvBoGEs9BTI4B
 lr2eIKblr+mllhe8VRq4P7gL+AjFCYmQ1byuqfh+H1dipJVxoVkZ6DcypGdhjpkldyb2UUHnYaX
 cUraM+yjnjxM9/iVHZjt5PQGxdGCAwoERbQ7g1GZSYdUl2ZYjtG81Y8/inRXt+PCb26xnlnk5JV
 J4QTvC4xWmGPTfWyaKA==
X-Proofpoint-ORIG-GUID: X6SoFAa4WW-cE53yNByLnBSItA5ErWSF
X-Authority-Analysis: v=2.4 cv=L6oQguT8 c=1 sm=1 tr=0 ts=69b1d234 cx=c_pps
 a=55pr0gqEmxT9FJl44qZDsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7vL3O5uBSuztJ3xaqtyr:22 a=3yS7yMrOVflTMqpn9XM3:22 a=QyXUC8HyAAAA:8
 a=sbe7VqBZAcr2T0LRIRoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: X6SoFAa4WW-cE53yNByLnBSItA5ErWSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110174
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224755-lists,stable=lfdr.de];
	DKIM_MIXED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9E1C26A0DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 11, 2026, at 1:25 PM, Andy Shevchenko <andriy.shevchenko@linux.intel=
.com> wrote:

> On Wed, Mar 11, 2026 at 12:02:25PM -0700, Brian Mak wrote:
>> Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
>> does not overwrite the of_node with NULL.
>>=20
>> This allows MFD children with both OF nodes and ACPI handles to have OF
>> nodes again.
>=20
> Haven't I given a tag already?

Sorry, yes you did, I forgot to copy it over, my bad:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Best,
Brian=

