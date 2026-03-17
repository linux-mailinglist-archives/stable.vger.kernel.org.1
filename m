Return-Path: <stable+bounces-226881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE1zGkOYuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:06:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B62B09D0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1B331EDAA0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6B37C0F0;
	Tue, 17 Mar 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QBTAWqS8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A4331A6D;
	Tue, 17 Mar 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769620; cv=fail; b=nox+IZpJgx6IJDZx5wsIU8aj41dPCTgv04QBh2vf3iihcAd4P9PswvEnhFq7UGe9E0beu+GNCUiwDxM8ilkhFuwGBwPm2aHKj+33HuUlqO80Gklq5tdrQRmosZGuXRNVSWHmI744GfYiSTy1xmEMmgWkAu1wtpDlv43IOwvXBkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769620; c=relaxed/simple;
	bh=oMNkmlK1M8+d3evIqeI0EQDtQEresOAnCi6i/eVkW9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=On4d+8Ln3Pt13HvAN4bwvxCaNBSYG9bIkcbgvaDgjA4EAjEIek/NUaK6sTqHSDhWTATg+X6Luy3RzN4PIIh6r4YcUPqoFNSSmC2Sag7fjkOgJstxuG9bjhw+f7E4XohUkFdIa1LMkd7scpEGbNBqLDvlZzEA4BeGxRlhQrTZ4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QBTAWqS8; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HGxFXt1919840;
	Tue, 17 Mar 2026 17:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=7E
	QD54JcVMN76t/A3GXQgV3rzaueCtNI/8B00KR26Jc=; b=QBTAWqS8929xsZhs1S
	ZSNxBmZLJY8hJ9oOmiBMnkMxrNjWM7PylTxoYZnpizRa4TGOx9mZ2QXuKOzVtQc0
	TaXim6MBSlzm+YpLuPY2wlJNwI+dp/nf5KhHBKCbhDRulX4QwpVwmSiPjqUHnPz6
	XcbrfFh5hyVJ+PVQ64GcOAB+d4Ah0BRb4+zVNHGLzU4dDOZDiXxbydZIC18L9lIn
	mNdAsQeAVFfzOPKeSPy12dnfvH4+j42IqozwvnS3edn8xnQ/hrOArCS7ymRHslCc
	sroxf984FQxuFCRcG0dDWqBbqUQsqVjvsaAtSIYBnbWJKEGkgWBah+Z6URhLADpy
	WDSg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy85yk7u2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:46:41 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7E05CD1F3;
	Tue, 17 Mar 2026 17:46:39 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:46:34 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 05:46:34 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:46:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCjrbyLf/To0mdJ55GQJIP7KI18tW5PBS1M5C0Fzy5qo4zh43FAGnmksJVpDkKOOkBGS69Myy746hnx+SlrKnaXMpymucCNMZnVs27gpjKRldZceWU0+wqE4zNuuFQU/bv/1DmXDwH9HwTHU+r59LEmKVBoYzm7bq5COOp9pvLr7nYQQAggRiftmE5qvQPxFCegQpI9y0HQ9tZEPpG3EwfXbwt3z0F6eaET4as/QtZ8Fj8js67uh3bZpzAPMuL0VH84OEvJheZTioYILvKpHofkN4KWlCGrAvNor1jnWZpkDOKVQr7ExCiIQPS0ezaRDkcHiqVpRr9DO/w9E/nXYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EQD54JcVMN76t/A3GXQgV3rzaueCtNI/8B00KR26Jc=;
 b=bPhrEOcCJYoA5xIdhTvLkfjuAMXnuabkhZz615vV3OYO0x6wFLBQ95eC8aXEWdn6lnSO67sUHI6zmpzYKlQbJ5BMxaGFcOzRx+F978W0CqY1nJwk0wff1h3BSZ3NHSaDIXeNO4NiWrMEb1Nzk7bKt401zjLt4IoHRiNPP2epyOKILtbecWKXCmiTAKm88Tw9WsboSfGdXCQbZ8Xdp/es8v9D5HrP7CxdzyrM4kSvBn4sVdvTsJpeAeUZBIufSZLoIEG1v8K2T3fT90FdZ/q5xfiQwGmQ3xo8xGJEaLjf6BdjE2KtTjN0PsqrReAkNy78qhV8JS8qOIFM6Obap7V8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH0PR84MB2028.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 17:46:32 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:46:32 +0000
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
Subject: [PATCH 4/5] hwmon: (pmbus/ina233) Add error check for
 pmbus_read_word_data() return value
Thread-Topic: [PATCH 4/5] hwmon: (pmbus/ina233) Add error check for
 pmbus_read_word_data() return value
Thread-Index: AQHctjX9Y2ZyKrbX6kOeCTO+AhGMVA==
Date: Tue, 17 Mar 2026 17:46:31 +0000
Message-ID: <20260317174553.385567-1-sanman.pradhan@hpe.com>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260317173308.382545-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH0PR84MB2028:EE_
x-ms-office365-filtering-correlation-id: 8badc760-7b90-4a9d-de95-08de844d2025
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 93PJ0WFVNk35fZzGecN3QpTRgINfWJYiXD4dvzAgq9+1dfjYVIQEbLn2QQbK1kUAz2CyuTcuBK8W7sBjrqQ5f6+1/BP8KtjDuZ2tCColleI/DlZ+0ItPTBk7rkZQOUd/A041AnRrxe4Vecj31WMW/ma/m8dEmB1ETuxdUO/1qRaxu5jqYAiRhitvgxbd2m4y3GkvBPvPVkU5RAvrsFT8EDvrGUmW6h+7/xLzjCkggwpFaDJvrXYti6Z6WfNL7qVvO8bHnZYRlP1kKNnnHExQwR6X6TsRCu0rrTBIoyZSjBP1Rxpg+irMXsi+mY1aQvVXFvZc0b08pJwUJPzY1AqHexwMYgtJBI9yJULk68QP8FY7gKIoheLoVd14rwWCR5ba3UuAaB/F9sm30m5P/TBteC+ddCBzTjKphFgZOtBjLlIC8+SlfzlNoh0P0q2Cmc5cANOMpeUd9vi2erk06FT5RCBSoFDAAsEpzQCQzVFic9+stsAj6W78iRiyZZ46eSXmatNdC1kHGOBOvsMU4+SN7x90SWNEuK5hvJyd27VaD6TCLkdJBSFSCiY3UUXEtd+2r+7QWNbvpe5gNsbnvaRtezR2NvZu73xZ7/c2fVAaiDJoVYYkVFVWkHbDNxjflKqf0Qk1mGwlCZ8bh5geWJGJ4HczKyea/coy77E9XE78UG1GRI965n64IN4xkbMbp4QAnT/FhK6EQpzEFBXVSgkaYR3FkQOr5ifwiuypFZpPlmNnNbzVJx8Wu3JrqEtdRI16O/dEYhIvjfEJ+27eP5bPp3ikbgIBr87X0JEV/uHSvJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F0sGHjN3wE5gDEDfN5Ty2KbmkGe/nqjuIflqCw3eLjglG5n/PfuHdmiGkT?=
 =?iso-8859-1?Q?aTvnfaDKuOWrgf7WRu1sNAsES9B78s3nvTrQSmzsk19SS0tA1naP3C0i32?=
 =?iso-8859-1?Q?D9hkLHkafXBcD1/gi7L/e7Oj8LIX8WmYUtvevXOyW2rDXmEuxIaRRNLWH2?=
 =?iso-8859-1?Q?g6gM5jNMkMPbdwnxh4icGQhHlY6wfobfnMMaVkMzFah3xHP01ecT897a59?=
 =?iso-8859-1?Q?8oXDvgAFVoBYjO7oNPdVx/OxQBB3ek6yAPBvc/pJrQSAI7ZkLENM+7i+io?=
 =?iso-8859-1?Q?H2rUdiCTBU9byvK1N1wlyhKY5hZiou4nuRypbEo/T7MAC30+qtMHxj+1Qa?=
 =?iso-8859-1?Q?nuOSj0B1eBW2UB7xcwBm2CUuRsI6Mcky8BbTaR130DxShB3d7I3vErJqu7?=
 =?iso-8859-1?Q?n4kebbHfoGqa8LAL+qOlDTq+KcgMgEeE4l5AOmAkn3i4D7ESrGiArlxQkj?=
 =?iso-8859-1?Q?zhfCaUqz4UDreKW53UF04zs5ijIzEpF+6kwu5oFvZ1ARU0c1oc2W9VBMGp?=
 =?iso-8859-1?Q?sH/z7E6nL+83eF8yPNuvhvQa2C45RFdd98QPe63U91j90oizXG3+dXOtTV?=
 =?iso-8859-1?Q?mjIwd3rfyo8VGiU7eX2pBut9GBy+34fv4eA8X+WrIeXwvw1UqGCjMMLzma?=
 =?iso-8859-1?Q?pCgCejnY9kiOgxowABiVQ+HnbaYaBG3iOQbzfnHFFidrBXExibKG+xgKQW?=
 =?iso-8859-1?Q?5Y5eifr2s63ugBdS21tyPxhluAFYeIMMrb0gap56CSB5bFyCPguYDBtQaG?=
 =?iso-8859-1?Q?LxCmAurXHZQdtQf+IGd3bq1pZImUQmpqa15SoruG9XN65hxy9ZK1mxjyVL?=
 =?iso-8859-1?Q?YrwGc1HHdnNvK6ZQtpQGwI1ceGGT3xRCG6BAQeGaTYLpoPU/Edl0LF+L56?=
 =?iso-8859-1?Q?XKkDd5EkqjCvY5cOr51Fb8Hxg//VXy3vf28axbf8B4i4ZmhPhg2ClMO7kw?=
 =?iso-8859-1?Q?YpsMcXbxV77rQBX15hNNQWf7Vez3aUxnEx6c4r4f4WgQtT7VxnOYGNjWPk?=
 =?iso-8859-1?Q?Uab5y9xZMBqDWZN2FVQo1GCleWtOUfRPxdcM13ehMaOG85CDBucsbNPNhW?=
 =?iso-8859-1?Q?P2rrK9KOUwfcNO8FOwCCVERc68RBe+dxjY6w5Vq/eTmc9ABWqnqV31ELE+?=
 =?iso-8859-1?Q?S2CzS2wsC+Ss0DkkzEXUEOii7sCFb6Z5nAXFjCj01t4wPol5f+0ZWvcYzR?=
 =?iso-8859-1?Q?jBn9wnRYMdED/4JEmXt2E0jOqureZUG9y3FORst48pY0+lZU0BYXZQZxGC?=
 =?iso-8859-1?Q?0XRJDeMToxYlPPoYeh0I4+qQak2fj5N0UXqKJijKRiD6pw9c80i/uNEL8a?=
 =?iso-8859-1?Q?Cuno8XeGUxv5kwxwmIHzT2WkroMmYjMjefe+a2mWUtPclvHZNfnQCWyYPH?=
 =?iso-8859-1?Q?8E9l99kXL0MNj1U0FPd1lbL+pp0Y/rIn+A0WeCCdfyU3fC4kEMRt9TzeHA?=
 =?iso-8859-1?Q?AZGtq4Q6s0w4naM6/6IiUXvx4YVBt21AAo60COG672s4r0vo5Y7i/UIUPp?=
 =?iso-8859-1?Q?9zkTBqdIEXeKuSoPxDtaRM3KJ4ufAq0z44NJHzvgFXEiOROkia55oUhc87?=
 =?iso-8859-1?Q?D7l7GN5TWyKMFPlEfTtmQP9UNLsC97pItEegPIGewwJ1b58TsAN43I9lO+?=
 =?iso-8859-1?Q?uN80wIzWLppjfhyiatZ12WpJi+fH20ThyOjwAfa+zUltR6PdWUGJ8CcgkC?=
 =?iso-8859-1?Q?xkNP3C66nwAlm+mrx8WZnXsFOD5rYCyIuZK/M/J65bHWVnk/KQPGUz9asU?=
 =?iso-8859-1?Q?0qj43orTcyjXMy9y/brumcMFd88XLz8r853A/SVH9C2DRFGK/KgqaFra1x?=
 =?iso-8859-1?Q?fJQgExhQfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R8jOFpwn48ccRh7xF+vtDl70Cok3PW8dieFrIiTGw+5nt9Z9NtqH8+5fsdlbgVPNcVubv6eYLzWByg6PdlQDbPUGMqwImWHYSXZ8zWqIRK7T7dV6sh1/fxaDsjvxFRCdwboisEgkJZmVpEl1A4WKGD8Srf5QYlQBxFDGB3GAQCidEytatqAz0aMU2gLdYFR3PXK1EBQczY7BR8m9UT9Wqas4zVA03OjJo/4xnPHhg3s4NO6LrNkcfmJYp4+13C/GBcw5J5wqTqFosAYzjuAJClHVKsP950/Q7gK4wSJ+AxII1VT6AtAif4nPbhCeEE8gH3SXoHbBJOXI1JQ3SiyLOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8badc760-7b90-4a9d-de95-08de844d2025
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:46:31.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5PcqAsw77rAUqCmlqwFQg6oOMmG6PP7aNgwq6RtLvFsNpzzyRpQpWIiZNCcj77I1EQ5yDQblnznPe7OKPnajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB2028
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: mmh61enJYY-Vvhff-ZgYKbjGQS0VD_bw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NiBTYWx0ZWRfX+X4iads60cbT
 crxQh3VQ1UuMCJvkaAJTeuGng7LMWvUeIB903/f7kmH/wTdJChTKtCANH+tj2ggbA0vrE7rFGM/
 pZnr5L9fNLdNlGvafxhTZpyk6/DjzB8XNhQM2XL3nJHSTEieUlYizYZtj/bO0OaaU6nagPQpc18
 gPkPk5ku47Zve+E6EkchqY6WPKQ5DkImSsoXkWhBhxKrdHDlQC9HVjMcpHGEIfgD8TmvWXQvuNS
 MzNeHvaS/Bt2trtw2IMV3HEfqdAv3ZfzDtIp2NrAbEwBQbyKOa9Vtr85P+jZ31ygBwFgtvay3zP
 dOyzCvTcDTv1JEMLC2ZnYxiBJMHPcC0ZzZfhK7vn3HPrW8hEAEDpedlDtEs1tYRuvQn5n8dSCck
 vDmcThYrZTrH/72ecZl6ea95U5wEnylZOFKTBb/TvUn5Ozh7Fq+eMH6JZD6SgyL11ELC6L9dE0o
 nd+dhUgZ2/ckKIJnOQQ==
X-Proofpoint-GUID: mmh61enJYY-Vvhff-ZgYKbjGQS0VD_bw
X-Authority-Analysis: v=2.4 cv=cPPtc1eN c=1 sm=1 tr=0 ts=69b99382 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=IJ2L_Y_MG6GnUvDkRnsA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170156
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,cern.ch,gmail.com,yeah.net,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226881-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C27B62B09D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
ina233_read_word_data() uses the return value of pmbus_read_word_data()=0A=
directly in a DIV_ROUND_CLOSEST() computation without first checking for=0A=
errors. If the underlying I2C transaction fails, a negative error code is=
=0A=
used in the arithmetic, producing a garbage sensor value instead of=0A=
propagating the error.=0A=
=0A=
Add the missing error check before using the return value.=0A=
=0A=
Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Mo=
nitor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/ina233.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c=0A=
index dde1e16783943..2d8b5a5347edc 100644=0A=
--- a/drivers/hwmon/pmbus/ina233.c=0A=
+++ b/drivers/hwmon/pmbus/ina233.c=0A=
@@ -67,6 +67,8 @@ static int ina233_read_word_data(struct i2c_client *clien=
t, int page,=0A=
 	switch (reg) {=0A=
 	case PMBUS_VIRT_READ_VMON:=0A=
 		ret =3D pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);=0A=
+		if (ret < 0)=0A=
+			return ret;=0A=
 =0A=
 		/* Adjust returned value to match VIN coefficients */=0A=
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */=0A=
-- =0A=
2.34.1=0A=
=0A=

