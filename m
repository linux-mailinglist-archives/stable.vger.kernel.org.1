Return-Path: <stable+bounces-229966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGBrAPJ3wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:27:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF12F9E78
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E79F31E97C6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73B3BADB3;
	Mon, 23 Mar 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="fEquCwhd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E753AA4ED;
	Mon, 23 Mar 2026 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283699; cv=fail; b=n8lASIDGl9cn+r227RbDKEvb37lugmqZG/c86keT6uikm+jcP3Lf8pVilF/fdbfu1PbWMotV6CxOczbb3nXeghqOhLqz3IQZ8GdggmIrZJEU8HdB/52Fev1lFMyv/5EtpKdOdaFNGAZkUfTQB4MggIC3hszafS0IZYYTkF1CyjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283699; c=relaxed/simple;
	bh=YAentU53EDdARwPr8RNSuQqwawHIQOLUZl1vxxH9JNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEPifLF+QSEdptR3ODQ7+/JbCrMgD9SVRer8cgzphbpTW92KjRob7U4SyBe4ElK+Rq0bFX8vt1k77ncYWVzyterN5sILHy9yM6XO4ImCL5qaCPvP5ApxXbGl+r9dD/xtJ4blpSwARu27SWSn3MTUxCzMRfixvj+e+9+A4xx2SME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=fEquCwhd; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NEd2fj3152836;
	Mon, 23 Mar 2026 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Fz
	7URvk5GFT0yaTorSbqF7LpByxzXGhl4ZyXxy8rW6U=; b=fEquCwhdQkN0TM9jBB
	yNKrZVLlE7j5TgDHveqDRXet5G0yRoafmeZ57Yy4GUZz1QYkJT0OGiWgdaRvUrEi
	qwzASKOVyVas7/9L8yL6Y1JB8XvnnWOzr5kpKC0kQW+Pnjsyl+o7lgXKSNAJdlmJ
	t7wkTGYZbRWY3UDBdHidDGZFQkOWe9UeH769ZMqKEVxH86sTxMrV0kAlxDJxwrOb
	nuAJ88uqK//NTLHPJbC9Gah+BvTjjjJSCifrDXXnOz1n3EJivbjC8W8sLYn1pOw4
	0fsOC3NzcCXDRdf11ifvfOHlOpK0Q+QHuB2EV+UPL1tCZ2akF5GhQwWpRSnK6Vgr
	rHSg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d37f6hf0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:34:39 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DA95BD26E;
	Mon, 23 Mar 2026 16:34:38 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:34:38 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 04:34:38 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:34:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x55FaFAFCZiTFDqpv1CDcGFER1Zgiwwrz5ZGyr+uGBhFfEZb9wwfuslg1l8lZtP3lozgu+O0Rje+wOROAgBH1h3fxPr2j6r/hGgBn1qfMOn36MHRULZj/HekbCpnq8phu3fKQrjAslLL+aqXeLyb2BymLYNXt33NZ5Mu54sPuQ6XFuHLn8/92CqM3fmRymoBBqulH5yaZanOIfdCcyA+mtM8jWm28oQMwj2lfH4S4bMZzVhESkhz+OoeIcRJXl9Ex84NdiVRvj2h0TQeFbycY+/qsbSW4CAEeGh8afhM9LmUyz6r0z63MyM0/s2lJp1IMkK/+KPr0iGZvAa7DClLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz7URvk5GFT0yaTorSbqF7LpByxzXGhl4ZyXxy8rW6U=;
 b=lmRMlbmPW6re1SW6VXS7QVCN5y2dSE3L2zNYQ9/FhHOsqhBm9nteYq4yL+3qGWxVM58g6K7wv/PIk97JqNF2/SusiJX0joci6rZqkni+kThYLk5/A35hCqtCiWkQaAdEoJN/iYHF4JsjTWsua2GCzxHYAonrGmSK/4r8XSj+ZuBluxrqjInn+IeMQUPC+txRwPNjsL8dhQerQ8z46JPGE5np9KKiXwBu0iWssR86xlAIgU5j2wI1a+2zHHJ4h9UXABf88mpGthMj0BssPp/Jaz/ynf+ce062NDhAkELEUJyTvuH/Q+Wr2q0kdCx/ACZ079LZn7MKjq16wtRH0iwu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1899.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:34:35 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:34:35 +0000
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
Subject: [PATCH 1/5] hwmon: (pmbus) Use -ENODATA for unhandled registers in
 MPS drivers
Thread-Topic: [PATCH 1/5] hwmon: (pmbus) Use -ENODATA for unhandled registers
 in MPS drivers
Thread-Index: AQHcuuLvNpBjS1uimUWr/HcfQZ3cyQ==
Date: Mon, 23 Mar 2026 16:34:34 +0000
Message-ID: <20260323163343.183186-2-sanman.pradhan@hpe.com>
References: <20260323163343.183186-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323163343.183186-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1899:EE_
x-ms-office365-filtering-correlation-id: f7eb0094-0578-4980-6ce5-08de88fa1183
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DitywImhFi0PqxhpaXvlx6lmmyEeFRQgSSk+P953t0bvcs0N+wsWIV/zzHJ0D0wSMiaIKrBv7mVj+nHfJPG9QsxDcX7OGXSn1P7+tJxJMJTjRN4TLwPU7FdyT01O4U1yHQzg8m5meZzv61zbFjEy0audv+AHeHlAIhK5Kqra/XRRyHBmJIEX6/xH+9YLMpc9SUzYLE4DLjgsWCzaa5FXR5vgSypp95eYYcjmhU5vy6we/lpfv2Lcc1eBEBdpCeEFynGcXBaHQ7HVPJYSP8b+OMo0sPfORa4B6/bIbjghIbILgieTnb6HatjqfpGqXAIECB//u77ARgy6HkMseGeheJQRYyWJgjUwJQcnQe5bNyKrtEthpI7kSfyL522Q+TYbWYvoG1ZiXxH2Be+CccXcHV8SlAL12jU9JBtlkelWUJH6B/zrWrQLTtK3RJ+t/ZKnG2duolw9FI2Rw91bRT8a3EXRTOFsfq6wVM1CGhVCXB1neXTG5WHFhk+UJ2wM4xMmd/15dDzyCFJBpmGPp+8QURbfgFMQyKvGfj6a+Md4ZwE9IpjdJ/aefCoubmw3OIEmo/ift3R4i/WLDo22Xxxrd94mwVWKvY6fvuSgPYSMGtQrC1962f+DqVG2ko9A7FYDlOIhE3n1pIxtfm8jQN6VqsNMMX9BljdEYRiHBuYUHF446uy5KcWdmLKRZ/CXrzvypfRCQ2vGpzvXEnz+rda0YrHDjNd27UBO2B+uCJYWkbtWbgp/Y+A8hAc+jJfSiU+ANYos2fROAnc4yKsK9V+Y5VW++bNImH07DkrB9fNqLJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bXOc+WHNhSAmL8SyB/ztnKjenSOOUJIU7vCuTR+dAc/aPJSlcjNbktrW8?=
 =?iso-8859-1?Q?jHGgR63mmT4JAk/iaxmHIf0dTH1eweAFHUR4cOD+lNPcyR7O5uHaQFcWkW?=
 =?iso-8859-1?Q?j832Ju4sAMdzOSMEgUhVkuRto/6zsqXzrm0ipu1TCxDB+2L+Q72JZlCZAo?=
 =?iso-8859-1?Q?zODQDWPQTEMZCbLq2+LmNp28KwKIul2Z/uHHZghNigxX6aPB9A5GR99fui?=
 =?iso-8859-1?Q?esIY0JybK97v4h2DFT5iM9wkloTny13J4o3wIYPTQGghbLF5q+SVPIryFL?=
 =?iso-8859-1?Q?oSMWK9ElUACdY8tgx0qWcJi42SC+ZMXOaCp+1NdXHW4TZBXKnaicK5k6lk?=
 =?iso-8859-1?Q?5iRzdekcFiM1dp9xsYlks/ohlx0Ah+LUJchwI0GbEYGPLN4BX7DqNVm/MH?=
 =?iso-8859-1?Q?Nx+IvW/qWajUq7LP5zD/wPWPlaXE9SYnqK3pApO0SQ97ZAEzhpukoD+p16?=
 =?iso-8859-1?Q?J+YwGFx0fmxnpGnskhK/v8joTW/6hSS1Bwuk7hUvHMYzabMfM1PVSBb/QY?=
 =?iso-8859-1?Q?IXMnZZdNI4JE0qblZEDcZIAbFqEfC5AE019n1tBdcQt/l87c0JbqXrqjzR?=
 =?iso-8859-1?Q?MPG+3s4fS7mqKpfkDaZy3DwmVWxQ8U08cBIRZSntw3/kR854LA2bYFQt9y?=
 =?iso-8859-1?Q?4Gvc74si/P1AyZ52C7uNmQCJwawNIu5stBJnR5FIvOJZaKqDCG2CW6T4vU?=
 =?iso-8859-1?Q?3ZTKFFvJgyACillgov/R+0MgHgp8gBPydHwVBZXAB2u0u3ByxZpgdkVnEE?=
 =?iso-8859-1?Q?nhZmRR/3RLC6z4tnkV7iVG6s5KBpDROtui39QfFAwPmN2mTPd2sII8bwzC?=
 =?iso-8859-1?Q?jyLH6Zj2v7Yuge+mnlcbhMgQTvdmFbimkhur1HyYah1wZWwssfZ251Z0PK?=
 =?iso-8859-1?Q?/23msZYTtOFmGdJuovvyG+oxQzB4F57JSvS2uxj3OAFc4t/U3qWR8apuDc?=
 =?iso-8859-1?Q?YkGLrDF9M1ZSwvHm3v5K6y1/AZORPahS1rp97Eu7SqMNkF4VumxO8pR1YM?=
 =?iso-8859-1?Q?OQfefy6gUUw6HvpM/aoSQgUp5mHvKMiGMqXAPYsEWYuDwKgie8WP9U7Ifo?=
 =?iso-8859-1?Q?yUJ0PnHhu864iwu4LIzu4q7o/M+okLYjH2rnvugjktyvKdK7Sti7rCnqBq?=
 =?iso-8859-1?Q?qkf8e7c0wCTfeGyFs7lDr8nEgl1eBaCa2l43CmQKQeBvIRTU+ekVDdKowR?=
 =?iso-8859-1?Q?18Fuhd/wvvZhIPdtpQBsjTnwEIg2n1idqizZWONWDEgIHYFa36Pm9XdWtn?=
 =?iso-8859-1?Q?2Al9JFcDvm7mXroLL23/zZLSP0m7u8Ye+3GOhq6uVTimuLKagechvNjxC8?=
 =?iso-8859-1?Q?2lYLUXGojSLBVnriEBf4wfYGNYldNiNl73+OUpIpuPiSfphKPoUuClvWSX?=
 =?iso-8859-1?Q?8QDWNJUTxpFgf+3N1Xr+fQMMsUoHkpmuLbL3sKiH0sGNj6AZNd8c2egTkk?=
 =?iso-8859-1?Q?snOWiv7fpiXUXxc4KIxCC8VPQaoauEics9c1yeI+xWx6UZSgTejXCX8clU?=
 =?iso-8859-1?Q?erYxS0EbT4edg41OKhb6m4LR77FNBb0IffTV5QOrSlLtUl9is+5jWI+TzB?=
 =?iso-8859-1?Q?H5SUMvcFDLcAqSu+roKn9iVcQqzNrG9vDPYAkcXgpe29+7/HwCupLkFfxu?=
 =?iso-8859-1?Q?cEZgNKDWrucSLGHfwTTaSqKoPSIYoWH//wlXa21lW1QtY//rj7e39s9ggU?=
 =?iso-8859-1?Q?lxPZxjE43Z1XqizlYfZN/bnWDmSWWT9cj9kkfuxtqKYZHZnQ6kH7JGraTz?=
 =?iso-8859-1?Q?swBcheN3zFoX1pKzriPnCdKgx2kRHWsDaaUq27ybmKG4qI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qberfeIYOAMC1Qj/dqSQGW2+Yh/dZgdYJ9UVg3kQ8BWWjCXrSnuKNpNRM6IHwJ5XHCdMNRzzVOd34M76JMiGBTPLgvRNLdiLjsfPU5clGELQxX/b6L9Fo+E9y5RLfebcuZXUpFVdYjQdLjukEZu0RsGI4GO/b55Gyur6Dc8HR6qUp/tUtXkG1cH2eGr1nRw4qwEn2A1RgevXiHVymab6Cafqs5oYOljEEd+qXoi3fNVRpexrmFwjHtm5fIi5+SotJdR1Mt0p/6fClBYiCFKZQBAvlFE6FZ/GlnM53aFfw3z9W10QC4a+oA7yUxVXUIlzJsLcJG2hoAtcVrjHWYV6Fg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eb0094-0578-4980-6ce5-08de88fa1183
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:34:34.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ustuz8m61yrFnJqrmCIi6Pmfde7A2rZV56o01C2A5POuJgUBDMyKGnJhHMTNIdn95s8mWXVD1mk1jKgDLVIUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1899
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: QtO8L5E_EaYjktVp13ofY44oQyRg_a8y
X-Authority-Analysis: v=2.4 cv=d8P4CBjE c=1 sm=1 tr=0 ts=69c16b9f cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=mbBNgdjj5DS2MrdysacA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNCBTYWx0ZWRfXwjKiKDbvOLNB
 n8r7a1n0snTdLXl9Yuab5TY/wvBEQmFaPIRb/PCrDMC/e2QVat0pS84EWsSwEuhmyBmrO2aIKSl
 nOFabmBtUNSPEs4Wjw7GWGWwb2vLUiatWWpZXeNNhqFT82QtpB+vn9/fgnboy0St/1wRZ8BRoT6
 +p1cR3ql+jnThstxSCc8mGCKdfuYUZdeISDAoM0J4CzZpfqMs63e54GejjYZDveNDe8ueGcEuKZ
 Lkpv0G+7mt6uXDLC5LdBjJp0YYZilEC/KnvUxkEMmXg/benXnzTU0Y8a+am3tpBMEvOkGIaVWjp
 0xSnmKMGMVP5ibz/EcudB9zPOqi7fz7bl5fDunqNpHRGUm5ckM5N7RPZL//bolu1+Aw45E1i1k9
 gdoSFSCsv/14kirfAqbEEtP3bPC9p329Phjblb7kWBTdVOIXQzefnjic1oxVaqoHqrCcPoDdbVY
 psmMNdyyPcCn/wUUx7Q==
X-Proofpoint-ORIG-GUID: QtO8L5E_EaYjktVp13ofY44oQyRg_a8y
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230124
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229966-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 08EF12F9E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The read_word_data and write_word_data callbacks in mp2869, mp29502, and=0A=
mp2925 return -EINVAL for unhandled register addresses. In the PMBus core,=
=0A=
-ENODATA has a special meaning: it tells the core to fall through to the=0A=
standard PMBus register read/write path. Any other negative value (such=0A=
as -EINVAL) tells the core the register does not exist, causing valid=0A=
PMBus standard registers to be silently hidden.=0A=
=0A=
Replace -EINVAL with -ENODATA in the default case of all affected=0A=
read_word_data and write_word_data callbacks so that standard PMBus=0A=
registers not handled by the driver are properly served by the core.=0A=
=0A=
Fixes: a3a2923aaf7f ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series =
driver")=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Fixes: a79472e30be4 ("hwmon: Add MP2925 and MP2929 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp2869.c  | 4 ++--=0A=
 drivers/hwmon/pmbus/mp2925.c  | 4 ++--=0A=
 drivers/hwmon/pmbus/mp29502.c | 4 ++--=0A=
 3 files changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c=0A=
index cc69a1e91dfe..4f8543801298 100644=0A=
--- a/drivers/hwmon/pmbus/mp2869.c=0A=
+++ b/drivers/hwmon/pmbus/mp2869.c=0A=
@@ -391,7 +391,7 @@ static int mp2869_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 		ret =3D (ret & GENMASK(7, 0)) * MP2869_POUT_OP_GAIN;=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -536,7 +536,7 @@ static int mp2869_write_word_data(struct i2c_client *cl=
ient, int page, int reg,=0A=
 								     MP2869_POUT_OP_GAIN)));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
diff --git a/drivers/hwmon/pmbus/mp2925.c b/drivers/hwmon/pmbus/mp2925.c=0A=
index ad094842cf2d..a62f6c644bb5 100644=0A=
--- a/drivers/hwmon/pmbus/mp2925.c=0A=
+++ b/drivers/hwmon/pmbus/mp2925.c=0A=
@@ -132,7 +132,7 @@ static int mp2925_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 		ret =3D -ENODATA;=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -203,7 +203,7 @@ static int mp2925_write_word_data(struct i2c_client *cl=
ient, int page, int reg,=0A=
 										 ret)));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 7241373f1557..4556bc8350ae 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -456,7 +456,7 @@ static int mp29502_read_word_data(struct i2c_client *cl=
ient, int page,=0A=
 		ret =3D (ret & GENMASK(7, 0)) - MP29502_TEMP_LIMIT_OFFSET;=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -555,7 +555,7 @@ static int mp29502_write_word_data(struct i2c_client *c=
lient, int page, int reg,=0A=
 						   word + MP29502_TEMP_LIMIT_OFFSET));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

