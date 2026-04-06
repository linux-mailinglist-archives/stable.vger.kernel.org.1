Return-Path: <stable+bounces-233418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELzACR3002nToQcAu9opvQ
	(envelope-from <stable+bounces-233418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:57:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450D3A5F20
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6330B3011C6B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83077392C55;
	Mon,  6 Apr 2026 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mupLc1kR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B627603F;
	Mon,  6 Apr 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498264; cv=fail; b=bK90CnBkqteDl8OLv8+Mn942VDMAmceh8vf3CK4DuLpJEND+j/oPprbbByld8ADBMGSuUQLBZXYPIPYnqhDsKl0YGwnXQylSp9UtLk3+W1XetMK3vS8LSq1tHGVNrZTV3QHzqehSEDESuEhdQR4a2gbmMm8MR0RjYMMDBItbv7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498264; c=relaxed/simple;
	bh=frzYqgab4gCgMfvsANuHQ/XMkgfzFR4GS0LWVmsp1oQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uwTr9Sr78V7l31dtLL3NVtf1dF5NPBr8rRv8LQ8mZeFO1ghxnWkWBbrhHf1drz85hxJgG1vwh2DjVzlKMnlxOt/7ZVSXMSQtHvzTuCxdqZeTq+Ml2kK60kVDxBHQdCccLd78ycTAVWVNhzhbJDupAaNWfANttK8RzFbrfOxDepM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mupLc1kR; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636FvLcT1052925;
	Mon, 6 Apr 2026 17:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=1cAdSS7VokU4k9hDOz4FVSMZ
	UP0fEcnZlo3JNbHn4aM=; b=mupLc1kR3P0CYcohMcn/w6mmWZRrF71BJ8WfLbzY
	8iMjzyzGzPote9EFod7BXhyBG8B4Y9Z23YsugInrGWX3a7dzWXN001yIKBT4zY0l
	qRfbQAD7YyLvFBGG2AwShM3rxHB+MmOohYY+xLfzp0JeVFGwZCFAfxgZmRkhltCX
	Nqm17NfGTLtnVF6cFyRvhdeCJJcG+4b2RrfvvGtw4VkdDWxGdzd9gqvBn9PGtXHB
	g3ZbZ3zca0iHEoHlltgz1oH0besj6WGaGEpFV4/nv0kzIwfEfpD0htqGOMMNXKBx
	iI0VT79VajMaMFHR0wTuIkDWPpAUbcuYNf3MKWNkRI7oFg==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dcebyjedc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 17:57:29 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B72908014D4;
	Mon,  6 Apr 2026 17:57:28 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Apr 2026 05:57:28 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Apr 2026 05:57:28 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 17:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qx+whgjYW2RgU+pamZWezpGSOpuY8W3buv5uDMUycT7r3gSGkIyiwzIzuhOoClLuHt2+XUD7BI4mB+q8uYMzz1e+s/7hRk3fDQYch0zdBdGHGqJN0UgoHwmjr6ICmKDhcYVtlVLlk1M/f8YjRLwZa3oF+hnm7Na5UhNNQlgNr1RPn93xMvgA+g0ytcpr1HGRa+051UMQ+LIpydTJ8MdppUPajq5d42cV6riQn4GVj+IfSLWAnsNzp4Rq3TU5EahLHUiCoRYkqikdDL++2H1JMzhhbRTOm0lqUJgY6W/Y20bKf6xI2CfnePe1nFcNYGXU979FcrCaUmpZMO99uPMyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cAdSS7VokU4k9hDOz4FVSMZUP0fEcnZlo3JNbHn4aM=;
 b=gW6i/Jiep5w7+DNHCAXho9VROoQkGefjW/wA1tJPKhlRjLOTM4bKlGchX8oYXFUiOo0KQ+02zWiaXaN3FwscrJ37M47cBD0U88lOdCH2ncFRWNmiAD5j5XNWVhiSHj7kvM3i3yAHzUeXyQqrV1vvAgbZMbGMMgxa27bNL3Q1jEmIehjBPBGW4Vnj+OJRnwpfNGcnuMlcOMgenONjbMQPyv89wPVVL2175sH5DwJ1yWkaNbTrPqmKlYcf8yuOa0Siof7Iyo03J2Ue1qARnSQxM6nV5FP+iT+XhckLzyTaJhOfBtrdhLL6CWJcQUc2WzndzCaQ9VWLOlCgCZDfKgG2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1969.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 6 Apr
 2026 17:57:26 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Mon, 6 Apr 2026
 17:57:26 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sanman
 Pradhan" <psanman@juniper.net>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] intel_th: msu-sink: Fix coherent buffer leak on partial
 allocation failure
Thread-Topic: [PATCH] intel_th: msu-sink: Fix coherent buffer leak on partial
 allocation failure
Thread-Index: AQHcxe7Ti8Oqvr5I6UyUHvvGnHl8gA==
Date: Mon, 6 Apr 2026 17:57:26 +0000
Message-ID: <20260406175714.208227-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1969:EE_
x-ms-office365-filtering-correlation-id: 6efdc5af-bdfc-4d4b-41b5-08de9405f666
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: STiOifwJtP4iAJad65nP3o41SjCH0jnokCUphMclwUPkxQa1ZNQmbthm7aP7hmxm/5hQNkC7YfFUSZ78vDsEGNN/sVzDoh1A4DmfyeougwlRu145TGKRUyeqzLgNY/smmZycpUfP75g3To8akPO9CE5Ow/e1lRWcRFLuX8S9c5XAXa7CsUZNZE/BbIhrBQiZ5na9DoR5sHTr4CFLlOaHjA7TKpzZ0mTnsmT3zhyUJEWIUVZBEqrk8EuOFtOxZC+zi2vrSvb5Vah2mUzulfVzGTIsilNEisl5Av9T/oExsLrHfHxCY0pAxiZKv7PdP7rW14UjaAwUA4dF8MwHq0N6FlEkWl98i0V8VYSkB8qhA+prIrhWfvvaqPUVIQNSJY1Upmy2oH15B1tvzev0xQLQOmUuz7EM/ttCdrLvtA6ne3iDl8VxolhDyCDIzFH0RcQ9vcG+bhPDUfbDJX/pR8Zrchpu/+Ua8tUTak2pXeYSpx57OBtGsmlJN/X1q0jEYW5K0NVzvxTcf9qaPnDJjAlequsb1SIQ1baCW2/hDXzx81OmPjPxFhiRJ5r2NoBTadkRG2cPhuCYHi6zMa322C/cAeRBUgI5Fx+xo5kIw/LPQYQ855uvNSxkAmd5jHN0ZP8Y4uSBfyzia6j5qGXT8iTApDKDzAeJhgwNtHTZjZ0/UGuguIPg2HeiYN2aHfEfrNyshVQspHb4xbNhymYmSvF0NkoOlKrTv44BGW5zaNeWF577M6dkpciwscyomWog2RZj59BmqccL8+518/uA2OWorgNdgCrpCHfG0i/Bs0qaHak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Z8DIEW0pXr1kPaK4fvSKAIpp1VaUncudwKklYFWJ36BPWpNmRpbJKJ+Sf?=
 =?iso-8859-1?Q?oRPCvAhO4XYpkdVEA8HQGxPsKyOLB8XOJyIZhITw0ujN+1zfSSuye9OnSB?=
 =?iso-8859-1?Q?yZuirpXpaA1DS1mTaAc3DYbT3KpxdhlF1D2rPUUcuZqqJ90Sl0vtLP/qyi?=
 =?iso-8859-1?Q?0oEhTdUIiNEhl7ImJ6/UXLnNNq1ZqoRLgJqBtAWXG5j/1M5OLxBNpXGEM/?=
 =?iso-8859-1?Q?erZFzUbLsFaEvPEbG3XbLGLWbiIRg2lRExT63PrBqQ9IQ3jKRkl7W4ar76?=
 =?iso-8859-1?Q?sx+lb+En1Hq0jHSrfq1Bty6+z1x7IJheFvURlbqvVgViLGGSPoqx/6JkLF?=
 =?iso-8859-1?Q?F6Lc0Wds+AmeRZYMyTTUBGJl1dEzWX5ak2uD7IClS8SlveMoXAMDD3a+Kg?=
 =?iso-8859-1?Q?edarQ4akgQn4DhfBcTH+TetPz4GwY4AzV3C9PBWBoGPIU/LH8k2g3JGvzF?=
 =?iso-8859-1?Q?AJj04ymw2gva6DSBfm0Vf7Zu2ZQ+8O+q17MC9Flf+b00rjkF2OhBeyqisJ?=
 =?iso-8859-1?Q?/ycHKiN5q2rwxHg6MV7mUGhcHkut5VgOagoKX7Pn+CpgbE/klw9hWW74cy?=
 =?iso-8859-1?Q?l1YiKM04035AC91UoX+lV1aFjR12GfD1RjAdeIVb27vvx+GGa8tDEvSm5J?=
 =?iso-8859-1?Q?hwKCmBoU6xp7CIa9+/22VJnlOIDkMyRF/ITEfEWLdcvqrwIyiux+SbAso8?=
 =?iso-8859-1?Q?aRCd1C8KerSsC4bDc5VFFwGJy76H60Xo0rCPk++OqACYUDuQ0N5a2LhjB2?=
 =?iso-8859-1?Q?NWz+ZFKTzM8jdrEG4sq2QR5jUR9IMvy2QGEj1L38rPDh+2phUJ/gTYI7dV?=
 =?iso-8859-1?Q?YHrCyYT8Y0hdS/y5mIbCQ0DL48pJsiGTSLjrUkKOttoDMmpxQHMyztmf4t?=
 =?iso-8859-1?Q?owQMzL2cGwBAxDMXrB3tWUTABd9djrGxlvOA4PmmVSE4aBoyDrxG/Q07mO?=
 =?iso-8859-1?Q?EZS8QfM5QGDIrdGx3uf2klhOUW8m0anA9SsbF2dJMIS7G20X0fqJPnnwp8?=
 =?iso-8859-1?Q?fQlojOqjhgjbld6IwL3kmUP8SSI1Kd9fV95USbuUYH3QgxjqYsz5xahvwk?=
 =?iso-8859-1?Q?rUV4itN7UUFlryj824q27nOYi8j4A1WkDGbTJeEE2MCrBStwf190oRfsiz?=
 =?iso-8859-1?Q?HdZDFvMJt/n1Hyo62/jGftxh3lxEN6yaeYig1wb1NS3mnbfpdsxLcBrrhN?=
 =?iso-8859-1?Q?wX/XBkhOQ2IFWGhR94/TW8jMgkTmhlqWKyaAydij6qqKO+6yzavKB75GKZ?=
 =?iso-8859-1?Q?kONrWk1FBNSDEJyv5tAALN39vyko+76cBZCWtXCWwmFcY+9okWEsXebKv4?=
 =?iso-8859-1?Q?f2qgYWKfUpapasZSeML1XWRgCRTnF5M48ZFx2NYTLj9LkpMdzVeNqbKKwR?=
 =?iso-8859-1?Q?6zmPlk3ee1y2oZoDIcyCfvZOr7AnY+KGqjdeXngltVG9DxGY9jqylEiFAf?=
 =?iso-8859-1?Q?agbqvX2ktV4URNYAhbQy3QRbdiocNG4NsLhscoJIpD3QSRXQiMGg7DAmBK?=
 =?iso-8859-1?Q?OudtvUHYBjU6V0auu/qE5tk+5AOTk7baw96iCB9UNbErdmBM1/YfBDweTo?=
 =?iso-8859-1?Q?Z83+SpQum2+4Uxzat/TCOEn3Gb2VyNVCMK5xVEyG8jzqgkxsromoNh4JgK?=
 =?iso-8859-1?Q?a2MrTqB52mL2opgR/2BoqH2wN81almvlfXZRn/tvv8ay061JVGTZdTTY8D?=
 =?iso-8859-1?Q?/6qJMmDJpJ32l+w5P/CNox/Wxc0munqwCDe53bA+xvi2oOT34YvCO6WzZf?=
 =?iso-8859-1?Q?uS6poQZAzfzK8Uz/ndgwkOi0Q43wBnLK5seGb+0MPNGYgGk6xg1Ebt7KJi?=
 =?iso-8859-1?Q?wIcrEPirgw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JufhBuVM42r9mUQvd0jXg2VptAP2IvIwRpDsOscNqp3CtlMzz6udy6xpMenJevuwI6ytpyJEuXcN6NMLaZF047aBUl9YxO36IcxJJ70GqRnoqppwCpuY1lbmxlo5cJ4inJYDyq0gG2HnGMz9u4/yZc4immXrXUPvf1p1iIeiFVuQenk8xHzsbn5q/bd4DfQK7Jn+zkkAm0n55Z8JyTd8hKl9s50xOGZMxyzpIuVeJiWOA8vflDVKi3g5dilQXTpOwtlTHOh9xTCB0TEAfdQclLYoTfHVLb7ntV+Tfz6AhuGw0yYeAo9ncI6v71byn0woLiXq2VLxWsEMQxEMXs/5WA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efdc5af-bdfc-4d4b-41b5-08de9405f666
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 17:57:26.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyBddua1ghxtF66nlMyB8lXMTqtIT52aKVpOuPINsVKTriNLcxTTMXBMNiqF3GYBHOKR9/onSq0q/tCBv74Wuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1969
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: s0GbyBky1ONnaoNsjv4Bj1YkSI37OKw0
X-Authority-Analysis: v=2.4 cv=QsFTHFyd c=1 sm=1 tr=0 ts=69d3f409 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=wM2EGvfZby7J2zf4Ja4A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3NiBTYWx0ZWRfX9trs5tB9G9K7
 NEHU5oUDPS8EK98j1QdIKFZJqhc3HPx3QJrst8EmIRmn/yJc6v5ihYwHmOYOIkzs880j5RGJIFe
 NYzOaOyUhEWUW628rMDFLWCLppZGO75Q7iFORt0ctE9ewhqCt/DZre06uRkL6MQLlEnZPawBF4A
 5bQVeTVFHZK7MhRyCIZJMniI46nrlChw1C2FJK4vnrR4SRBZ5lD0pCTW19dhIvTwKp49IlWq1V5
 fOX5YyzXOrwGYQqxQpZUaWzgJKBqfstlLAztD2PP6uKJ+/iCj1lMEXJv7M2cpdyae5GXmbEOI+J
 RoqLyxYtON+iQOuV6QEgr0lCfGfZ3mxJeOw6UoxsLVte6DG+Kf+zvlfBRwBnTSk1zSKzXrk/ZOK
 XF3S7R7kNLVQ15JYU+p6OjcVVl79r3wlN+edZ0EDtj7hsKvspXUcWksBmTbmXSNd5UwL7g2yVqd
 EdDxvxandporPIh4xIQ==
X-Proofpoint-GUID: s0GbyBky1ONnaoNsjv4Bj1YkSI37OKw0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060176
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233418-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1450D3A5F20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
When dma_alloc_coherent() fails part-way through=0A=
msu_sink_alloc_window(), pages allocated in earlier iterations are not=0A=
freed and the sg_table is left allocated.=0A=
=0A=
The core does not recover this allocation failure.  On error,=0A=
msc_buffer_win_alloc() frees only the msc_window object and does not=0A=
call the sink's ->free_window() callback, because the window was never=0A=
successfully added to the buffer's window list.=0A=
=0A=
Also, msu_sink_alloc_window() increments priv->nr_sgts before the page=0A=
allocation loop completes.  If the loop fails, nr_sgts remains elevated=0A=
for a window that was never fully allocated, which can eventually cause=0A=
false MAX_SGTS exhaustion.=0A=
=0A=
Fix this by:=0A=
- deferring the sgts[]/nr_sgts update until after the allocation loop=0A=
  succeeds; and=0A=
- unwinding all previously allocated DMA-coherent pages and freeing the=0A=
  sg_table on allocation failure.=0A=
=0A=
Fixes: f220df66f676 ("intel_th: msu-sink: An example msu buffer "sink"")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwtracing/intel_th/msu-sink.c | 15 ++++++++++++---=0A=
 1 file changed, 12 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/inte=
l_th/msu-sink.c=0A=
index b809a7f805a9..ea3ff8415b90 100644=0A=
--- a/drivers/hwtracing/intel_th/msu-sink.c=0A=
+++ b/drivers/hwtracing/intel_th/msu-sink.c=0A=
@@ -65,19 +65,28 @@ static int msu_sink_alloc_window(void *data, struct sg_=
table **sgt, size_t size)=0A=
 	if (ret)=0A=
 		return -ENOMEM;=0A=
 =0A=
-	priv->sgts[priv->nr_sgts++] =3D *sgt;=0A=
-=0A=
 	for_each_sg((*sgt)->sgl, sg_ptr, nents, i) {=0A=
 		block =3D dma_alloc_coherent(priv->dev->parent->parent,=0A=
 					   PAGE_SIZE, &sg_dma_address(sg_ptr),=0A=
 					   GFP_KERNEL);=0A=
 		if (!block)=0A=
-			return -ENOMEM;=0A=
+			goto err_free_pages;=0A=
 =0A=
 		sg_set_buf(sg_ptr, block, PAGE_SIZE);=0A=
 	}=0A=
 =0A=
+	priv->sgts[priv->nr_sgts++] =3D *sgt;=0A=
+=0A=
 	return nents;=0A=
+=0A=
+err_free_pages:=0A=
+	for_each_sg((*sgt)->sgl, sg_ptr, i, ret)=0A=
+		dma_free_coherent(priv->dev->parent->parent, PAGE_SIZE,=0A=
+				  sg_virt(sg_ptr), sg_dma_address(sg_ptr));=0A=
+=0A=
+	sg_free_table(*sgt);=0A=
+=0A=
+	return -ENOMEM;=0A=
 }=0A=
 =0A=
 /* See also: msc.c: __msc_buffer_win_free() */=0A=
-- =0A=
2.34.1=0A=
=0A=

