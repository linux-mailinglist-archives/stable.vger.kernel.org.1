Return-Path: <stable+bounces-237937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIdOEB953mkHEwAAu9opvQ
	(envelope-from <stable+bounces-237937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:27:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA873FD13F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24320302B168
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E73EE1EF;
	Tue, 14 Apr 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BRhpgztd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F33EE1D7;
	Tue, 14 Apr 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187550; cv=fail; b=LeFeUN9v1AWfxC7y4y2ZjmwzkCrcMlGBFDYLjEleC8gPXxwSDA/+6xIaSZjzch2Bzufpno/6CuXBJUxQjI5K1Sn0pxlOt2Sk/bZhatwXTcvIej+spvfo0FgRwzrgeHW1yyMtavmgKgAzg7l8Xy8lZAaRGAU9wmRw0asJjAyArWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187550; c=relaxed/simple;
	bh=jI2yn+F00fqpWiVQpQ7mONPesnxrs9sXLqSnYuBVYmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNly8IyP9BxIV6ehgDB0htHYcN5UpQjpwt4C6ULRmHEtMrfG366L9eIasRF3a4GAd71ZY0rEL1aO+66kRm7aBapq9AgULJ+r3bEnMdQspgKcBrIzV6rEfowtFltFJNDhd/yPDTJ07iP//tnlESzwXgLy5uaZnXUx7kEFKBrxJg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BRhpgztd; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGWZra2396768;
	Tue, 14 Apr 2026 17:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=8A
	jgN4V3e8qSuV4FUuVvNvUFeBAogH5tpOABxhMZIL8=; b=BRhpgztdHst/d7ITZJ
	x3iDR/nxtWIZyLDD8L5CYfK6pdM0+kW59gYmMAqzOq9CQuX3kheZrO2Yw1VfzUmb
	C4He83ZaQ6Hdvfb8RMq4F2LArNKKC1ueKh9zlQtAx/CHcbBxPytNJKLK8lChAXsk
	phx4TcGWf1gouoxfla74ZVNu+KGYXSTyZcgYXKJV4+kqzBXy1iZsLH5IRnA2yqo1
	NLyxv+kPG/f1jPZg3nM9IgXfFd2SfLMEZvnIjFbXu/vzKXcN3ipTtLhLuyqeGejo
	oWgk/DTHBWQkVgKJb88aCwX48Fe+df3p+pTQATbhga5le87lu+OU0P+BFWQg9hZC
	Fh7w==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dhnacuyvn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 17:25:32 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 71B90801720;
	Tue, 14 Apr 2026 17:25:32 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 05:25:25 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 14 Apr 2026 05:25:25 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 05:25:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8JgXleOrz675nIbWvPFnBRPrI8scLzqzKybU10pbqs09l7Iu1GbgL/NtMmA4ULr3ij1CRnHJ1aRxrut7vEWMRNCbo5vGzZZrEDOsgZzJvgkbWIoH9jY8u86j0eYn4n+mKr3y1acHNMQUwpP39xxvFnQin6PFZVwA26NxyYmn4uiPTVMLmLUrqb/zj9btGVkClK/xcfdRCGtxmvZ1nHBoL/LuM1Q/+vTfQR8a+zJF4iEfBHWbfzFM8NpFbbWGsHGSF5uvIR4gK0YbW4hGaVvDI71K1zXtbvmSFUYnh2lmgPxE16IWrJYy9Iyzb826N58o0byc3p8Idq5xqA5ryzIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AjgN4V3e8qSuV4FUuVvNvUFeBAogH5tpOABxhMZIL8=;
 b=tCqpvOZJEfXIfeJnD3sZvqXuWGsQ+ygb17XBTzN71gpAdyeSSKTKksng/zSUcrR97SwAnTFaefsBv81GMbw4O/Xr9COOi/vmQGn/V+IChK6/mMjo3hK0wC/gKNdmhreoczlC197VxpuBsSiZXiBXu0APOqIYZuZ4irsyjhEKf0687csiBMvGZRJ7CO3tRuheIwODZha9BQHrthK8EF0ORBqdym2nwQkscydbslFJFFEqnTu4S6Sz32CH0VmDmsm65QkWFVgD/wTh5QGh9YJz32dleuwcJkRwBMB0V6yMlucL8wyKIOsUkUoLODwnojNIAQus2akFOz/0wNtbntTsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by IA1PR84MB3034.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 17:25:22 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:25:22 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>,
        Sanman Pradhan <psanman@juniper.net>
Subject: [PATCH v2 2/2] hwtracing: hisi_ptt: Remove unnecessary trace buffer
 zeroing in trace_start()
Thread-Topic: [PATCH v2 2/2] hwtracing: hisi_ptt: Remove unnecessary trace
 buffer zeroing in trace_start()
Thread-Index: AQHczDOsc8QORcQvQkurlTgq37WDiw==
Date: Tue, 14 Apr 2026 17:25:22 +0000
Message-ID: <20260414172451.14331-3-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260414172451.14331-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|IA1PR84MB3034:EE_
x-ms-office365-filtering-correlation-id: d7b74a2c-65bb-4396-e097-08de9a4acf09
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: WLn7t8+XQ2X+bzH084UbhO6ipuIWA1xZ+1Cfr8hFFYPvoi/CzRnPaqzadDePDZ/Ovrw97C9ZzRm8VXZG91OzJtvbzP4fjCVRPsjF82G7KEtYGQx7xqqwx/CJlCcn8yUKH6e3jAeYSHczvQCWw4cSeBN4QLxk0cXVuOlD1+oVKucFKZEfz/UkLMTEu6KtyB/ecYk2wDlsq2X/C2aJJi6cPDSQ4FS9KFpnsZIo7mJVUIehQdxNHNSnnZdY0uPNxUYlb6AHjgAtEDbwWJQ4fo/bbKbG4E/2wKUNq0b63CiKcNnLENdCjGdfJBOCHy098D2HBCxwUDrAFFW6tUPQoee+9DjAgCqHQcxhUTho4fXBqvW0axo9THueSJN7TjibRQ9YDy7H2eS9n9yAf1z25y6UaaT3BOjy+9KJVO7C5ReBWMOdaBuC5e+ozmMxEYDp/zCCJx/ptpk6USstCOTNNfHMS4MrG1GyAJwu+YPCOuV6UPdRsPGzNQo1udOdu/ClQmBMttLL5o3jv731VGVteIThuMWzIKqvqLNU0e/P0vjXrNa3TQ38YMBeGnR9s2be+D+lG1+5Jsf4IruUfcrSbe5mb9ienvKLRKogKT8h1QuJRhFtixSisIlucaJtFQG+IT9yDEsBN8K3QDTue4lfqQWgaLmEZPt1wX6DaQP8j4eofy+yRn6YJW6AJ6LEAmW8KaS1z9zhLinVli4nQ4JACYEeAxexHJLFjuw1kNZz8jDeM7sGdLDW9qQ2evFheYXhPbA9UpUFFWHtAfXsYCVGLFxXGSKQ58wSqbBinjS9oQo/FYc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jKxjie0/k5SwkJS2t0rj+U7GPv/jAkA5YN1y8T2i92K7xKHr5acJMr2BEQ?=
 =?iso-8859-1?Q?EY93yHzjFfFN4qfM96mrgmhVWIltprfbVfaM3WvthYyzxh04GPLAsNYKLP?=
 =?iso-8859-1?Q?iWGcgbXMfXmF3YXnGl6O/WWtN0D1EmJgYpyE7Jb+/sJTrriPk/+15DmDBP?=
 =?iso-8859-1?Q?tlV1P5ujNipahEntIdCoXygFhLwyol6tFjEH4pLxQQuC1BpRB8y3WgDzet?=
 =?iso-8859-1?Q?zbsIWIxktShdThsiPfiFVcsvnZvhvglhZdFarQoI37oknoxi2KZg166B0G?=
 =?iso-8859-1?Q?JLMVqeITME7GkWpaPfN6bnss0LJyGMgkb4n4enOW1/AUwOdArgtLTpEB0A?=
 =?iso-8859-1?Q?qec4OnIdEUpOhV1nYL/2qVKKEzlzyZsGV3EJJC4P9DQBbiy20EooyIEFZX?=
 =?iso-8859-1?Q?2h9y0HAKO2rHAaVEehFvNN7Yhj0ad0YHVJf2WKWvaCTYJA4n0CGa1ffQd7?=
 =?iso-8859-1?Q?dyhvErexvk453rFdU1Z8J55ny1VJha9PRJRrfyAkOHQ/7IiPK90WrHO8l3?=
 =?iso-8859-1?Q?AnuVbxkbweKc9bID2diqUlWYR0qoDIJwuDgjyQ2lieumJHTCsTMU1h8mMn?=
 =?iso-8859-1?Q?fUTkJLpitgAXQtjkqMlg7cXQCedEW09cDdxKggmK6k092zG12W/z1WqsU1?=
 =?iso-8859-1?Q?bC9Zo2/QCyQwovrx6KQd2ACw7mse4/IIgVHNI5SfIbSYbJfwyzSyW/P9X6?=
 =?iso-8859-1?Q?hH0MiV5uhITB2FH+ZIhmc5atlMgIyXdm0DRpgtnl2RG6yk2uhUWQWYPfNx?=
 =?iso-8859-1?Q?RLZ7dT18OCBkUok2rkl2CElvL73wvnseLoscaFkY+W9CVuMCSmMDkybcfh?=
 =?iso-8859-1?Q?BfmtT+tf5ATBPQDTV14YK18kZa7SC7Ks8SH8zNtojquB3J3o3IyGWWl9lY?=
 =?iso-8859-1?Q?aj9D7V1pHaf0YY7C9MkNHiXZInIl2QBvzYmD9EQ1d+D89Y8fjqF1x3L2y2?=
 =?iso-8859-1?Q?avnHnHAYz3byCPVPo6bmb24qW7Iv4RmZ+H/elzaMF3ONxugbSghigsCXtq?=
 =?iso-8859-1?Q?nuJgRgGW1GWwZ8rlL4GaMef0IjxyGzB8dVCVwcJEAYZJUFBU++HQze+RvA?=
 =?iso-8859-1?Q?T64g2NvYneEvnJp6QUk0T2SW/lKWRDVcAHL9Epwcjx2sT1Q+awaippUwNp?=
 =?iso-8859-1?Q?nAd7+dfBgcog1bEQKbyo3aMv40eyVLO8bEAhR1rkBiUxStxlsTPXVTejxZ?=
 =?iso-8859-1?Q?pWSL76CaRhR/Z9gC9p++brbE9cc3DfO1Z3B57917AT5XagCkk19z/IskSS?=
 =?iso-8859-1?Q?AEsagUxo4qpWTOGarGHiU3v6Mv58ibTHQXyKnaQA78uP9cxDVJ5F5A5vsD?=
 =?iso-8859-1?Q?GF1612VsQTxwBUN2JakBijWQfCDOmZYOv+bvUu9hk65lCfw1pcsfrkdh67?=
 =?iso-8859-1?Q?p0usmOhEpL9gNXOhJIygxc51V735+3QbO1uSDyloUWtvxOC3WLfNhhKWNC?=
 =?iso-8859-1?Q?uYOj09NieXn1j0Epu03g6pQPrsstEexRvVnrGTg0fQ9zC1+xEzCMhRxI5U?=
 =?iso-8859-1?Q?x7a5njRGzQA9C0Z66QoyZUK2S6Zak2NVNJ1tPutb1bweebKF7Gm7GqTS2v?=
 =?iso-8859-1?Q?KmVXFlwcV1Faj5BBJYVkCn/5yPdzdqqIV54i1rxCiu9cPz7pdCa3nqoswV?=
 =?iso-8859-1?Q?Ki07X5wAGQcNos7bwCe6D2cXh0cb/cWqMl0CutCesT3Lh+mK+kyHsRVA35?=
 =?iso-8859-1?Q?VxgTNrLoC/f2rfIfsk+XeahGkjrUjrPvRoTu9VpnP/4USe/RD5/ktR1xvS?=
 =?iso-8859-1?Q?n4Wwy7i7AWBRy3ZSAc0AM9+NtaldT6Ppr1O30z0J5UK3wbkdvvxjkkdIwk?=
 =?iso-8859-1?Q?KMyFpwLuQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UcSn9zLm7gerU/t4Bm93RIink6B91h4EzNs3N9XxcgSo10bPtF7zYRl5cN863J4It9i+irwegU/dgapr51Yo4Mn9ByhBsOBExS6J7qsO14WIGJEBiUXUo7VcNPUgxbOv5b5fM/9Ukg8wi0HmgomvqNC9+OWbS233IJULG3rykbSCJNEkbL0J48ECgwZl79TKR128fr+FE92aOlBB+M1GgfHm2M6zZ3qVS8vggXeIt8slBy8cMjCTw/RCRuAxLpYKU3dyttQ1itKr9s9OFvOxeUkPk1ZTFa12Azd0E4WghVbugDAu70Eskap4efk3iYxPvP1RW1wO72+vl9NTbs9Leg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b74a2c-65bb-4396-e097-08de9a4acf09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:25:22.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoOacKul8wtmcNNZHRwhweh65QKPR2WNwDaH6I3OV+R1OxmQgurK9+EDXqNwP7wD3TIDL1+b43a0B2Wh0NqbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3034
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: CCHoTfuFCBb9nwIWV6nlg6Loc8Ne6Uhx
X-Authority-Analysis: v=2.4 cv=f+R4wuyM c=1 sm=1 tr=0 ts=69de788c cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=pGLkceISAAAA:8 a=gzvE_2QqEpEWtzhWCywA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: CCHoTfuFCBb9nwIWV6nlg6Loc8Ne6Uhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MiBTYWx0ZWRfX93pnmUEnCh+O
 qdYSAVQvA/nxMVhtiQns8BewHvcwV/UB4208UHFvoj/kJ5lo4/ouE5hFzKZqwMOuyKwdMhhITAx
 YGHtyCWXncmbjlX+cATF1YZdH+miCpSeLbGhs0vRf1JTfZDCAdCKPAf91lprU8h8uEHZ5lWZyp6
 QOMxJE/puXG9Wr9zb4Q97/bRDd4LNQO6ykrH5zMTDQDLQao+R/mJcHC7S4FoCEWX7fhSa0nLtnV
 kJ8+S7ZtNzkYmxFsMmVijqLRZVXVT3a0wLCXXFU1hSo03LugB7nFgZP/icwUIY9lk0qrxKdvLQx
 pj0HGxBvrWYwE/dqtkcCuLxuHFh3I4FGuWkezIpEGk1W8LJeBXP5bOqCjPOhG0OY9EHm8ScL5BI
 ueE8cjF3JIQ/0dMbO5pllzIdknP8OtpoHWESMWDmNKQblHRwq8sJRe5f0HOmKkR+o7tKF/bejJJ
 RYTlbZDnukQ60yhS1DQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140162
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,gmail.com,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237937-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4EA873FD13F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
hisi_ptt_trace_start() clears all four trace buffers before enabling=0A=
tracing.=0A=
=0A=
This is unnecessary. On trace stop, hisi_ptt_update_aux() copies only=0A=
the number of bytes reported in HISI_PTT_TRACE_WR_STS. On buffer-full=0A=
interrupts, it copies a full completed buffer. In both cases the driver=0A=
only consumes data written by hardware.=0A=
=0A=
Remove the buffer clearing from the trace start path.=0A=
=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
Reviewed-by: Yicong Yang <yangyccccc@gmail.com>=0A=
---=0A=
v2:=0A=
  - No changes=0A=
=0A=
 drivers/hwtracing/ptt/hisi_ptt.c | 5 -----=0A=
 1 file changed, 5 deletions(-)=0A=
=0A=
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_=
ptt.c=0A=
index b5d851281fbf0..a8f6986c8e1f7 100644=0A=
--- a/drivers/hwtracing/ptt/hisi_ptt.c=0A=
+++ b/drivers/hwtracing/ptt/hisi_ptt.c=0A=
@@ -194,7 +194,6 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_p=
tt)=0A=
 {=0A=
 	struct hisi_ptt_trace_ctrl *ctrl =3D &hisi_ptt->trace_ctrl;=0A=
 	u32 val;=0A=
-	int i;=0A=
 =0A=
 	/* Check device idle before start trace */=0A=
 	if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {=0A=
@@ -222,10 +221,6 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_=
ptt)=0A=
 	/* Reset the index of current buffer */=0A=
 	hisi_ptt->trace_ctrl.buf_index =3D 0;=0A=
 =0A=
-	/* Zero the trace buffers */=0A=
-	for (i =3D 0; i < HISI_PTT_TRACE_BUF_CNT; i++)=0A=
-		memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);=0A=
-=0A=
 	/* Clear the interrupt status */=0A=
 	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_IN=
T_STAT);=0A=
 	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);=0A=
-- =0A=
2.34.1=0A=
=0A=

