Return-Path: <stable+bounces-132219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74104A85851
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D491BA4D72
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2549290BCB;
	Fri, 11 Apr 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mrUPLLuA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ioDT9Eoy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4871E5B72;
	Fri, 11 Apr 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364928; cv=fail; b=hfo/tx22u4iQZlrQ7JnwK/ft/xYLKSV5AnFbl7qd2YqLU/UrA41iKhSJS1blkNx2kRZY4oM4rBF7Ie/ap3N2zADgTdm8Vrd1OzLAl26eEA4IkRxq7YJNMXl52CYccP+XNkcV0JZupglGgXR2vSU2jPLRq34CNPODE+AATrbM5Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364928; c=relaxed/simple;
	bh=H0XnrNj4To2HrCMF4S666NOqwtTdVf6jIpP/b22utAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYoNcsv1771I4dUTME5xJ/Okb0OaGQFnRKgmBmv4ddoWnOEvlo6u0+a8D9QSJNR+LEI0bSGPWErpNvBvSvSR5VwE4XrNRrNEHgAJXlbbzGSrxVwefY1+YvtXgiPf38VYg6O3mDKMwlrxep52Him165JQwyDCHwgmJvZX62KhewU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=mrUPLLuA; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ioDT9Eoy; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8K3Z0002028;
	Fri, 11 Apr 2025 02:48:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=A3Pr2SXIuGldEL7Cq6VHqlDoDIewTOTS+eZqF9OU3FI=; b=mrUPLLuAFaRH
	zIpQdRahlNuJpKFyUsv/tcNgz08er0F5eWErh9dLqQju85DcR1sihgtidxFIkQrA
	Ecp6oyCVED2N0QHbe4IgHzcxs7asD7LqAAB/j7GR1AS4XQukXZWhNDO5TcCOQL0n
	St9pUJp0gGlcKfiVatkOxbrawa1qKjQPZtIkvgrNLx2TZ4Njl+R7blCi2IwdSe8q
	5fQhxFv/vg3ufyn33xZjbRrrwxW0dWZa0yM5QawjO3iYZBJUr3CFDWcaLJNDmgVV
	QfG7mQc40snL5e1Y0vUvtZZ2yO9HI8uhLjKMoB889gb/kddRAF9azkh41fBbROva
	/yemKXw7HA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2y7jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 02:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtkHlIcTJPPWaF2LipBl2lknT3tpOwKJRoj+/LCea0ZfYxpb0C3AfDoGDVDL5tOhjvx8Edft/eZFDcXBWBCODxJH/A1WZJkIHxZ700kicgQR2ps6poQd94G90pLtv5h0yXETcSAY/WwcWikuLuBDEbY9rC+l1D+ezq8JogzZnAMSqNmx0NRDW9SqpUUIoPXXAa0DhoLC60fbDUSZuJ37JjIVNXmN+UPKOjl0ikQWpnb12fuAZ5J3i8YytRsCcR3Urw8d7UpaOem4iurAYkyU7PrKUFpUXQyp8uLqhjRJZn3NA1jZSwwl7EVq+I/eORBRohrjFyaD9gbpeJXe/Ccjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Pr2SXIuGldEL7Cq6VHqlDoDIewTOTS+eZqF9OU3FI=;
 b=eloQib2ib6kRIyjSwnlnwMpn72o3vfrXHYl6w3tH6srPFDv+4Pad9oki4esB2MjMSaynVMuHm1ZmT/Hs8jdPVIVQe7/XYJ5eUkkd2ocqgEaj1VwpzkcSVsILPs6HNfJQaRett/ZQOTHEWkS+O9D7UQnu/nS6EKGw8OM7bzM3auMLXaA37UoZnF4twl4A3OJOwEmrtuZYNQRLE7R2YJQWbQu+XSvdj4om6+8vH4NeiUAHb6KfL4jyxptYVgCxrXOyEfmu6trEIH1k3Qtz1LJUWNiED9qtA0nXF4Fp+t+rhlermJjgg9j63T6zVlC5fVCijAcY4lgP0Pfkkuohok5rTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Pr2SXIuGldEL7Cq6VHqlDoDIewTOTS+eZqF9OU3FI=;
 b=ioDT9EoyfVLsfXuzc7PelR3YomHeXJw3Ianvg535ssM31+i9nhXfHk7FkiCDhnQE7f/LAuBmOhp4XKtDD87gqSCpkV+qJoiAgS/OUXJwIFyCQjour19YK2HlGElkgcJlfV1xzyuJNLcXUMt3e9aqlUqn5cCdbVPHZWzIvB1dtnM=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS0PR07MB10951.namprd07.prod.outlook.com (2603:10b6:8:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 09:48:41 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 09:48:40 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Index: AQHbqemXS6B5IuQjiUyJckm8ZGIk1bOcgYzQgAAf8gCAAZTOMIAAAwBg
Date: Fri, 11 Apr 2025 09:48:40 +0000
Message-ID:
 <PH7PR07MB9538B41AA7F38F515DD402F4DDB62@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250410072333.2100511-1-pawell@cadence.com>
 <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>
 <2025041050-condition-stout-8168@gregkh>
 <PH7PR07MB9538E0DE72D3A4C0B8A6DABFDDB62@PH7PR07MB9538.namprd07.prod.outlook.com>
In-Reply-To:
 <PH7PR07MB9538E0DE72D3A4C0B8A6DABFDDB62@PH7PR07MB9538.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS0PR07MB10951:EE_
x-ms-office365-filtering-correlation-id: 17646bbb-3e7a-46f6-03be-08dd78de0a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3JySIldv1R5gMczpH9Zxk/kdfIhQy1EvhHxr0V6RD5AvZOsefxdQlPBqSthN?=
 =?us-ascii?Q?F4AJ6ViQ0CO9kwJf7R+jSeb1fPjxah4oSwLU9cnV/wRKrTPT6CXh0uRmFh/r?=
 =?us-ascii?Q?IVsC6UZJHS3iy5SK0PnlXtMhP1HRkgNU5SYjW53MAwNInzD6y4ZhyiuqmwVV?=
 =?us-ascii?Q?rVgGHRV4wR33izW7hM2nJjE2lhKYlCIdTDIJhXp7YBNdAQhpq1jfmG/Dy9am?=
 =?us-ascii?Q?iPW/ysbR6Ja8b425cK+7RcFQV3HBznUcvQKmaFzEB3WVfjIxeeshYJGRALlI?=
 =?us-ascii?Q?DGVLpRHw64JE97RsIsLWO7kpTBqJoGwsrqbfiVVypWZRCR+pl8oaQ7dRtcts?=
 =?us-ascii?Q?Y2T/+Z5q+/pyLKX2xSlSBuXtRaIVVOlHRB6IcPiftm8xuRKVeuRWO/k4rMxe?=
 =?us-ascii?Q?eZtusShHyqebBN7zNfbjN6FqgeB3o12cR4l8txhaFhn6zmj+3FOXewbX0eq0?=
 =?us-ascii?Q?/uDSlkbNZLvD09LU8b32ibdTsk61Ap++QFfsm0tDhtFc2/OPPWJ5uKhYTtKX?=
 =?us-ascii?Q?BTsRx7rtvrnHR3hDxpbR3NHp90liH1wH/l7YF9OZyVUB0X+lQiYdo7vh/RP9?=
 =?us-ascii?Q?b5PCx7AuDIG61QfJri+BhILOqOxmPX7kAz258qFayj5fqHB0OCUEx+AD1cNe?=
 =?us-ascii?Q?MG4bjtAewCnce0Syakhtpom9MV8zQydfXFRf+9AUSIQ3g/CkLcnM0ywi45GS?=
 =?us-ascii?Q?sdGvXN1F2mnqcZpgTNDu6O+HcE7LfrgisfbBokh78RO9j+sVgbtA+dKd2lSa?=
 =?us-ascii?Q?srLmif2rz8iZjD4kaPQboDH8RZBtHDUBEpeK/yP4B27W9NVDMhfExZdNK36b?=
 =?us-ascii?Q?78Xzq7VLfFfeQPT5WTrwPTZukP0Xdin4UJv8XAnbTYo8FXWwBZ56JOZ0YLPA?=
 =?us-ascii?Q?KvTaotSlu9E2DJTBvD/4rF2glkn/NK0OsKS7ZReks5srCg/GNt20+n5Fu3Oe?=
 =?us-ascii?Q?ifQTCQVQRui+AOtGQPIA0+0TlwaAtajqywUNAkbhSOgHXibKVZR2GqHGkJKq?=
 =?us-ascii?Q?v26QKjHPNIslUp0521I3e3til5vdT3Yu3LPiWG/PZ3Qmbyp/yd+OIctockvL?=
 =?us-ascii?Q?RsdAbQvGaw2xFlrWeqRTW9zAF8jEngRZ69hZeq9Zx8gMkhRN4rF3pVWzLEm3?=
 =?us-ascii?Q?51SMVAtbss9tS9p+B+eWi1aEiP/mXedVXlv6DRWnccNbXxpTw0C9zheak4E1?=
 =?us-ascii?Q?/gtnixsGGKGjRWYV640a6lSTQtMRCwOE0nO1qguYy5P3nlj92k1FAnVc182a?=
 =?us-ascii?Q?LSrXAPmXhzZV6JKBGgnIlvgzNMeAfASPbi+BkzMXXGYciFpdZAiy5k83i9PK?=
 =?us-ascii?Q?AgYnABcJYUPrYISMlZIja+k8l3hJq1XE80Dp+Lh0OljPM1f4JAKidFmlioGX?=
 =?us-ascii?Q?gjyIB1QpRTEKQyE5oKD8S8GbhdpCW8TdZPeLne7QfC6dCCKknbPQIevhtWWz?=
 =?us-ascii?Q?rso9HvD9xosBh6Ui3p3M1XSZnQaScNcuWn/Uga26MBtrZ+XZa6zFsOpeeXbI?=
 =?us-ascii?Q?OL/qDInSRwK0kno=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kHITFaVzda5v1bYbsoT1YAQ09yrJx4JnmqKvPBN09U3aPwriQeXuLM1rFE+9?=
 =?us-ascii?Q?GtjC3u6gHONhufDjeAxMq9V4RqlYRXX0AwqMbkLyVzeASeBcsm6f5ntgq1U3?=
 =?us-ascii?Q?NVW6j2wIwzRzGtatgXZq9enWsUQQVZZLZtMNsZ7wQQPYSChScmt53eVNGMUw?=
 =?us-ascii?Q?FkmjmNO4+7blIKMlYPAfNcud2eql4gRBq94UaalIsEiPzc4AiBCmSBHEhAzw?=
 =?us-ascii?Q?pxsf3Hseod+TaW9sypojK/T4Y0cehgqirWma+8x6JA05xiID+hSJk5G9A48P?=
 =?us-ascii?Q?1AZPbtRBQ9uktYXMss4NCgArBepeDRKwSCuhvcW5WJZ6e7JyTU93dbrv7y2b?=
 =?us-ascii?Q?E2ss8Ed8h45FzPfmL/R/W3WcnASwxrLWUavxlo34aUehQsAf0hqpx24HZpXX?=
 =?us-ascii?Q?pLKNN+kA7oN2Ed9Oi7lPUY3W1OR26nVBovwGK8kRe9k2Tr43/9db3f33vPr/?=
 =?us-ascii?Q?S9EeUIMJxv1oTErdDW5+5myGkGoPOk68cxALktiamYz/a3LTMDoKASh2kmF8?=
 =?us-ascii?Q?HnNcDdRoIKnkLemFN61K6iW+fAoR1FKx8RCcu+mPhVBhYe2jTsP9Lw1riZif?=
 =?us-ascii?Q?1snBBy3VQvk8zdGSqalLtbW5D7QvtCpCkKQss50WoqvqIrS7F5S/Nwxs/+hd?=
 =?us-ascii?Q?2SHBXrbP9/WLxM4BzwSE6VFBwHQpRPbSETw8vQgUjzmVSotv+L9Jm7KoMVaB?=
 =?us-ascii?Q?gPRkZyBHeKtLGIUtlGrpUSn17QdZQYLREG99pRDjv7oyerlcplu2OOuJhlIV?=
 =?us-ascii?Q?zOUNkOMKH+C9KGzxd29gr0BM0relMVPNnOTkZXI/4sjoeXaiv1GZtg83ck3D?=
 =?us-ascii?Q?q252beWl1BtSJHHsBhoY3JNG2P2H/4loGY2YfZw8ZBWe9pb13BJ4g64vQLvI?=
 =?us-ascii?Q?qzc+g+A8X2mWvuClCC5M51WlbZXSgbRMvbuFkBd2r+24aMOgZPCbMOHaSIDJ?=
 =?us-ascii?Q?qrCxMiHMZ5JPInavWJ2Hw65Km6nvPjbKyorpTJ/dGwf0FQsAAfVXED80Pqom?=
 =?us-ascii?Q?IvjvV572EIhtTpyQv0jMv5F9IQXhKK9Q3RNCGt2smdgP0ec714VsAZXG2wMM?=
 =?us-ascii?Q?R0xhVLx+FxVcLi+D/W7eOw/sPjvt/EoMloCC5dv4uSBiMSE6yGv9WKkVYkJs?=
 =?us-ascii?Q?T+nl2MyAvgNVrM2O2bdbtqQJjJJ7Zbk8iM0lCs5fPR31B4+nHUII9sk9PLaE?=
 =?us-ascii?Q?0QcbcRLs4AIcx9IqRAowiwBayQaKnOaZ66siRPpnLHn2sAW7o8/YFgQasdNL?=
 =?us-ascii?Q?hXZ8g83jUdxzfmHUoB4dDfrsBKY3D4Nbhv4ZhoGnOcpfaPXsfyJsVOeeOCT0?=
 =?us-ascii?Q?E4vwTbSrsjNCixgnoHLRuQc61sVP1yHPi6l5VVOvkqqW/l3tm3A1P+yCU5vv?=
 =?us-ascii?Q?7TsRA1MdBVVAInRCnxHcK/BLiYB0M8ufoRZkwJUtBq4RcNjXfoCNMxfjr0Ga?=
 =?us-ascii?Q?HYHVDP0N3y20MbhUa4PwVlM/FAFABgXgGIr44pSisO9AP3sEgbhxL1qQyX7o?=
 =?us-ascii?Q?vByUhTSJKnYSVrHWKM4LG9zb5LnD9nuujI75IM8/CfAe0K0Z/Adk5KeCfQQ1?=
 =?us-ascii?Q?ewvgurF8CdT4UXVnui9qQUQBsUymtqCWw0j3KcG9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17646bbb-3e7a-46f6-03be-08dd78de0a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 09:48:40.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zoz7oV+WtSWnwSupEXghiJJ9py83TCRoXeWUzdF3uDWBBEmF7enyenL0SOVZN3lD+X0FVt9LwDqz7PwlIiSzKVGNDOZnG4G5WDZfQB6veL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB10951
X-Proofpoint-ORIG-GUID: UmX0OESaCUx0E5cF_DzGvpr31_9xbcm7
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f8e57b cx=c_pps a=6dLVn7RwcbTzQ1hpYGxp6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=qenp9_zV_eD-rfQxtnoA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: UmX0OESaCUx0E5cF_DzGvpr31_9xbcm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110060



>-----Original Message-----
>From: Pawel Laszczak
>Sent: Friday, April 11, 2025 11:40 AM
>To: gregkh@linuxfoundation.org
>Cc: peter.chen@kernel.org; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; stable@vger.kernel.org
>Subject: RE: [PATCH] usb: cdnsp: Fix issue with resuming from L1
>
>>
>>
>>On Thu, Apr 10, 2025 at 07:34:16AM +0000, Pawel Laszczak wrote:
>>> Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1
>>
>>Why is the subject line duplicated here?  Can you fix up your git
>>send-email process to not do that?
>>
>>> In very rare cases after resuming controller from L1 to L0 it reads
>>> registers before the clock has been enabled and as the result driver
>>> reads incorrect value.
>>> To fix this issue driver increases APB timeout value.
>>>
>>> Probably this issue occurs only on Cadence platform but fix should
>>> have no impact for other existing platforms.
>>
>>If this is the case, shouldn't you just handle this for
>>Cadence-specific hardware and add the check for that to this change?
>
>This fix will not have negative impact for other platforms, but I'm not su=
re
>whether other platforms are free from this issue.
>It is very hard to recreate and debug this issue.

Sorry, you have right should be platform specific. Other platform with Cade=
nce
USB controller may require this time even longer.

>
>Thanks,
>Pawel
>>
>>>
>>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>>> USBSSP DRD Driver")
>>> cc: stable@vger.kernel.org
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/cdns3/cdnsp-gadget.c | 22 ++++++++++++++++++++++
>>> drivers/usb/cdns3/cdnsp-gadget.h |  4 ++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>>> b/drivers/usb/cdns3/cdnsp-gadget.c
>>> index 87f310841735..b12581b94567 100644
>>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>>> @@ -139,6 +139,21 @@ static void cdnsp_clear_port_change_bit(struct
>>cdnsp_device *pdev,
>>>  	       (portsc & PORT_CHANGE_BITS), port_regs);  }
>>>
>>> +static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev) {
>>> +	__le32 __iomem *reg;
>>> +	void __iomem *base;
>>> +	u32 offset =3D 0;
>>> +	u32 val;
>>> +
>>> +	base =3D &pdev->cap_regs->hc_capbase;
>>> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
>>> +	reg =3D base + offset + REG_CHICKEN_BITS_3_OFFSET;
>>> +
>>> +	val  =3D le32_to_cpu(readl(reg));
>>> +	writel(cpu_to_le32(CHICKEN_APB_TIMEOUT_SET(val)), reg);
>>
>>Do you need to do a read to ensure that the write is flushed to the
>>device before continuing?
>>
>>> +}
>>> +
>>>  static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32
>>> bit)  {
>>>  	__le32 __iomem *reg;
>>> @@ -1798,6 +1813,13 @@ static int cdnsp_gen_setup(struct cdnsp_device
>>*pdev)
>>>  	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
>>>  	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
>>>
>>> +	/* In very rare cases after resuming controller from L1 to L0 it read=
s
>>> +	 * registers before the clock has been enabled and as the result driv=
er
>>> +	 * reads incorrect value.
>>> +	 * To fix this issue driver increases APB timeout value.
>>> +	 */
>>
>>Nit, please use the "normal" kernel comment style.
>>
>>thanks,
>>
>>greg k-h

