Return-Path: <stable+bounces-233948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBOQN/qK1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8B3BF43C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0D33063D78
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB93BAD8F;
	Wed,  8 Apr 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="sknJ0rYl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8C35C1B2
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667715; cv=fail; b=kNQszDOLKMklFTmxeK5/BwGDHdxkvkVAG8kMh81PJGHU42APeizQXp+v2ve8a1sw0y60QX4oBMpNWDn1piuJU4pwi4kC6J+2PdSrC94zY6FFtdkqKvcCEu943brMueZ6A2PerEDtcFZz6eSaW7+HHRvulvyeZhB3ty1cFwTMIKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667715; c=relaxed/simple;
	bh=+NpD2MQtPbADobU8Jmdr3IuTfAtmAm7spvhNQyPaAt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JuOdHpO5ifO/Ckz44ykeoSZOQgMtSI37Dm16N9AJWypM0yJ5PPY+LVYJPN82cfUcL9gHep2zTz/dPEGmWVDfDSUJWPjNnxKO+MSWK4X3D0VyHLlT3Yu5qQMRf6x/kV6eCmAsh/HtjdWvrlxgAKYn21t0TZ8IfhZe/6DnUXvFHOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=sknJ0rYl; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638GmWpn3661953;
	Wed, 8 Apr 2026 10:01:37 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022127.outbound.protection.outlook.com [40.107.200.127])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ddtb304js-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 10:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8xFf9R8GjRvmPscRR8CzxKcnhNtCdEUcf85cagAiZmts30NSP8MQIUiwEqslXHoao2oej3VJ/3sKqRVSmziGPNZ37IjQ5PGvD7LM0GHDjSJE7Dmx7uCILkE4ecHjUteUsESocwppzxfxU3fscnn5VZ8o+NNR/qFSVoZ/y7DKzeTsBoTFRLSBPrxvNveE77OTyAcTfY/2JmGo7TOgMh3SUMy/8aOkeVUIIwtuU6pgxa5AG6CPcVHlIHElUmHHBRYHMtsmm1KdP8JGm2dyyFb3RuS83nuVSNhWkLe6nuWNIErZqooHjAVAuk6SSddzO5FTzBg5OYRFuBv9fQalTMYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NpD2MQtPbADobU8Jmdr3IuTfAtmAm7spvhNQyPaAt8=;
 b=emQqTzEo0BL8ykdhQfDy+gS8YHULx1aeuqnl4EQWUNm/YBBIHUEkpKhVe4Xlmf7t/GF6uo3/pzoRghF31P1EvrNUDCYUzytcOLUDzla0SxdUiGfLcmy1hOVsK/xzTuaWyZGU4SgycB5IWY7ivPP9TL0jV1P66knFEGjIBZ3RLn46Q7IjAJzJ08kW7JtwMNCx77RhLTLIAlAvZRIEMVLfeLNZDZdJKBWjbmH93cQNsW09PCWBzyVTbBg0SVarWoscTy5ImrrzK5pLztML3gkbSNQojokBh+BEPx438gfARdnfPQUqrE/GGEH0C8Ypay9hxWvrdb92eqmBvw8PP4WFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NpD2MQtPbADobU8Jmdr3IuTfAtmAm7spvhNQyPaAt8=;
 b=sknJ0rYlt6X8uPi3mIgvpu3WOzLW2Jtgr+YmG8TbmF02rZ/vwPhKJR6gbO3JgBPEAuTxfYaw0gRtF+dpE1A1ZSBDUwDBMloITGgSw2sXVHNXhPMP7flL6HChDjfFR21nTeer2DGTiTHsyOt/49C/0qHiYlkqbKbV2th60Zr72Vg=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by DM3PPF478114BD3.namprd18.prod.outlook.com (2603:10b6:f:fc00::69f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 17:01:30 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685%4]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 17:01:30 +0000
From: Srujana Challa <schalla@marvell.com>
To: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>
Subject: RE: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Thread-Index: AQHcx1pMd1gRFKwGY0u+n6js7eOv8LXVLDLwgAASwYCAAAIlAIAAHxGQ
Date: Wed, 8 Apr 2026 17:01:30 +0000
Message-ID:
 <CH3PR18MB63797F6A0E4164BEDF3A53C9A05B2@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260408104825-mutt-send-email-mst@kernel.org> <adZspiOMwT6nsVIf@laps>
In-Reply-To: <adZspiOMwT6nsVIf@laps>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|DM3PPF478114BD3:EE_
x-ms-office365-filtering-correlation-id: 4c9d5305-b1c5-4122-70cf-08de95907b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 XVBI9GmMya+zhlUWRZm1gqrQkG9J0KQdNzBZ8LPRQqtUjJoRc5Qia35QOwo9W1Icot8D0+N8rM17Go1PT+eTY+k9ICdxiHPF3QSalXiwZho1rvbSEc+/ez3Qke/24jkMSrW8rlyJQLrxy624u2pqLCl4mfsWAQWqlGwi8eoyhi2BvjK15M6giyCJ2agcevlmC/ZGZZnUfCvt3UTdp2hhNOQ5U0aOrfU84Hw2lLPR54hYqpUYnMaDjl+HIxcPwA04/iY4qItxjf6hGFBR3Sl1VzTThmXOwT3ZsCgzP1wxj14/Jmk8iKUShCFbmBIb0wcZVS3mnMuNLTgyJtL30eRvCdreEybDcq0aaFi8aSx1ao5P29/lexiNTUXxi9U0RGjqDZxSxEiEtVZPTNo/hWSjlOP2LGkHlPC347twOXEMrPJ72lRxDe1fVfLPr5JEizjAGBek3yPr3ryQxC0F76iYYoKTr46h+2bNstXJvzqSKFN/joVa1+3VLZNAdj7bFkI6o+TKLH3MkH8f/rgw4sUxjD45+veJ5FtsJcX7kMJHxx+XrtK1sgH0I4UpsywaSO8aOfbSMySYkfKLOBMv5g/N2d0Ncx6LEHaPdN5+JGW8HMAosKxql701+ZTrb3upY4cOToxMgyyM3BlId1iHzkbKAGG5MHwHoDlR/AYiG/aqVuUEiwQPcdAgYRbNJOUXRnQ/fHFB4l4FG8rRBLaj5xifxKuuUfr5UZQUgykj1bpUQtZ/auYNh52QJMynUdA5Vc6GHnyV9I85E+QQPZZmxWei0lTiPFgdY1SIUm9qwaehggU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0NXZ2V4dFpUM3RCZ25wL0N5V3BsR3F1S0tGaXVSdTA3L2tFM3N5ZGFCcjht?=
 =?utf-8?B?MExPWUY5NzJOcktlbzVISHBSSjR2L0hlTm5La2RYN2lYdnBtakw4Y0l1eTNz?=
 =?utf-8?B?NUZVZE52aHczWVdoYmtQcVJtNEppTUZNY3JFOHEwS3BpanpmYlRQTmVndE0w?=
 =?utf-8?B?UkRvZ0UzLzJUSnUxcENFVkVWMnlUSUVSaUc3S2dpeXhrZ2g1Wk5lVFZ3WTB0?=
 =?utf-8?B?WmF3eG03VzdCenpDdWFPWjdmbkxkd1Z2RWx3WTd0cGNKdU5LSU5EcEJreFpu?=
 =?utf-8?B?bEtyRGduZVlqWEdFUnBFK1dQelQraTAzNEtOS0kwMGFKdVJaU2djY0pXUUMz?=
 =?utf-8?B?RnNDY0h3OVhqQm9NcVZjdGQ2dUF4ZlpsNXNnZCtER08rLzM5aGgvSG1BS0hY?=
 =?utf-8?B?dytuaHo3VWY5cG0wMkNJRTJuWTBqNlRFVEtZRHVoZmM2Zm1pazA0OVc1c05H?=
 =?utf-8?B?NHhiSyszRGJZT1FTbXJOby9oS21hZ0FzR3U4VFZxR3VPb1UwdDdIeXpvcUtx?=
 =?utf-8?B?NTRPd3hyTlYxNXVvNGJ1QzBQYmtQVkcwb3M1OWNZMFRKN0NSeDdzcXlZN1J2?=
 =?utf-8?B?dE1XeUczT01LNEk4U3R5QWIxb3BBdVlVQ094TW8wSnlud25lMGZqdWhWVFd3?=
 =?utf-8?B?d0VvUkV5L1FFc0ZZUkExYTNsUlYzS1Nicnd1Y3FLam1yenZCRmpBNytWUVpk?=
 =?utf-8?B?R0w1S3hLczNWNXhKQTV0M24yTGhQc3RjZ0h4cDkrSC9GSVY0ODlJOWNaNnZ6?=
 =?utf-8?B?YUsxUjJQaEFPZWFTNFhjdW05VmMwWUJmbXJJLzhES3M1RWtjQ01IMlBiR1gr?=
 =?utf-8?B?NmRHRldYWmJMNGR0eTNPcWFWZ3hoaGVTNVFlVTFRbnEydXdYN2NwSldhTExz?=
 =?utf-8?B?MjFEODVodlRhWXRrcHhFVGN3RGVHTEFFMnRiL2lHMExJUVRxLzhoMkRKa1dj?=
 =?utf-8?B?Wkt6MDdTVGFCVXRSc1ZMbEdud3ptTEpVNUhaNnl2VFgxMnZqV3J1bG1JUXFU?=
 =?utf-8?B?Rzl1a1FLa3pXZTM3OXRZYjNxTVZFWHdzS05XaS9EYTgyYlVJZjdyRUE0Q2FD?=
 =?utf-8?B?bTRqUXFKZ0FpYVRVWEdGbTl2VC9zRXRJTXVBZUdENUJQeUMzcFpFQWRHTThE?=
 =?utf-8?B?ZHVZeUc3dnhRRy9wWDJ4RnBCSE5wUVNla2NETVcvSFFseUlnTmwxalVGV29j?=
 =?utf-8?B?SUtSS2ZvR0Y1aXRscjN3WldSb0JGSW0va0EwRXhjdDRQM0xoZ01LRHl4UXY2?=
 =?utf-8?B?NlNiazhPcjhkb1k3MUxyVnI2bmplNGcvY0pxclRDNDRvUGtpUW1MUmE5eTJG?=
 =?utf-8?B?ajQvRG1qcWNZU1JuTWd5bjdhbG1XRnlPa0w3TmF5RlA4L0laOFBmWHFxZ0VX?=
 =?utf-8?B?TEdvdldMNUg4ZG9zZnkyVmtLQngrbnpPRGx1QVNubXh3Rnhha3I4aHE5alBN?=
 =?utf-8?B?UFhnMmk3VjAyaS9RVEVwMEc4MjRUalZ2bVhGUVAzd2ZkeHlwcTZ3bHI2emZp?=
 =?utf-8?B?ZG9TM0xLUjdVaXZmU00va04rQm4zaVZZMTJFRkJ4TFo2c3BReTJ1MzNmckJC?=
 =?utf-8?B?dnhpOUp6aERNMEdYaXBFN1dSTGZ5SzRWcEZvWWd4WVNENitKMTlVUmt4QXRr?=
 =?utf-8?B?UG15Z2dKVThDaDlCSnBINmZNZCtTbGhkVTBnSmpzd3lubXNESk9sV1psOGlM?=
 =?utf-8?B?MkRPeHYyVUlzdHJMbnZPZzRBVkFnMnpVMExlMFhGWENNdlpyanljMGZvTFpH?=
 =?utf-8?B?YjlEeis0Z09jMFZhUlZJSDFYRkNzWUMwSlh0R25nSFppWmVlRlNuZTMvRm9F?=
 =?utf-8?B?RU5uZHI1MTIyTmhwbVhKa24zWSs0blBaVldwYkdNazBndXJVTXFhaHhkUERy?=
 =?utf-8?B?RWlKRHlnbXhKZUhhbGxKcHc4VnpHOGJ6VGErV1dQRTduQXhQL01lNFc3Z2M1?=
 =?utf-8?B?eXNUbE1tZ1hDaWdkc0FkdW1yOGR5TUNpRUFwUWhwV2U1Tlk4Q0RDcUF6WFox?=
 =?utf-8?B?a1BXVUp2cVRzcFhZSEsya3dVd3pBc1dzMXRBUHRzR05KTkJUWVNrU3h2Q3Nz?=
 =?utf-8?B?R2ZYZVduclp5Q1VjcmlubFBlS0xGUEdVSkZ0c0xhaXloWElXTXhNdmRrcDA2?=
 =?utf-8?B?U1J1aWJoMXZOVmlISm5uNEMva21MVVdQV1phNVcxN2Q0UXE3NjNyWTVnS1lO?=
 =?utf-8?B?OEIvWFlFRW40VXJvb2RzYnJMSmNZay9pT0ZaUFM0SlRCNWtDbVhPdkdhazBM?=
 =?utf-8?B?Z0dXeWt6cFkwenJ1TTQzR2lKODZvM2wwTiszOXZLd20xcDBQazE4OTZOM25a?=
 =?utf-8?Q?0GOVk+5XmMmllmiPyn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nhnfWYVHKYuNz3ouNmWqtBcaGgyazRKgKPfOCRfw+AQnJTwZSkiX0cFa97OGl69gLQ6NxejiRsqRvnYwYTB97idBHjzhY7zfsHQrAcCMjNrx9LJCJ0WZOkZ3Uuh48cMAM6yRj6MGqMVjioFMw+L1M1I7t2CaRuQzlNNUtkzKbB1Q/D5PQrAEOYoF2L4yL5HG3Kx7p3X1c4WFjKA9Y4/8M18KTO4iOT9q+lUdLxNuvaQ9KJVt0nJ28DvcJe7C7T/0K3wYA+PN01JcivmSaM9b2AZAlTY79pr2sjfRUS9dpWaqLyk42UR0RnsKV4xqb8uqUDkEpLHlH3RLRWgEjjEl+w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9d5305-b1c5-4122-70cf-08de95907b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 17:01:30.5518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7slmLxr1lPit2h/FE1xW6eMN1Jslu1vJLnmOp/LDtyGu1ExtG0hFw9vAjQ9yBi4uf2nBrd0fBvaVoUbnULWNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF478114BD3
X-Authority-Analysis: v=2.4 cv=K7wS2SWI c=1 sm=1 tr=0 ts=69d689f0 cx=c_pps
 a=JUmpB3/3x7NHV7iXOe9JbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=sloUFiSQh_kGd8rleSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1OCBTYWx0ZWRfX3ue59bAko9o4
 z99Aowd1VFCEktAvThIqZg5HYOLGTO4squdcJEbs3fW6ur7EXHEH0dUIkWu81vGLjvHtddVp0WC
 tBke0tQ644pAk0NnUHaLyXGEd3k6eVLxaVVnovoNvkMGXS6eRZJ0Qr7pTxyn8fGvvdXNM22DjzX
 e7McI9zPGoSGbPGC0lKachD21sF4kUen9jvuf5Nzjfb3LNKMhyJb+PJM6OlyEun3f1nSo7q3xm3
 mSscTdJhm6g47rEiAS7qUUSWnrnLtFic2pvdD3y5Kn6BHv89KfYKb7C3dY0ZZe3ZDu7BHmGI6+D
 bUeYBBFV/F6UmxPUUF/W0fsXjOZNr05ZaSAQEt5kC62W0hKED0EqXVZ0eI1m1gmlsYsHv4QH8OH
 J5nWzhuk7NQtk1xCkV17aJHc6yEY9O3iGBQnu2DjlgHVU7055wl7ngKjSYnPSqYwI4BiY10aO9g
 c2QiLFRHH+agUN2Y1dg==
X-Proofpoint-GUID: Dx6JQVXMOfwjFiUoVmJ04NRzXi4Xz5zz
X-Proofpoint-ORIG-GUID: Dx6JQVXMOfwjFiUoVmJ04NRzXi4Xz5zz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233948-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 67A8B3BF43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBXZWQsIEFwciAwOCwgMjAyNiBhdCAxMDo0ODo1N0FNIC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6DQo+ID5TcnVqYW5hLA0KPiA+DQo+ID4NCj4gPmRvIHlvdSB3YW50IHRvIGRv
IHRoZSBzdGFibGUgYmFja3BvcnQgeW91cnNlbGY/DQo+IA0KPiBQbGVhc2UgZmVlbCBmcmVlIHRv
IGlnbm9yZSBteSBiYWNrcG9ydCwgSSB3YXMganVzdCB0cnlpbmcgdG8ga2VlcCBpdCBtaW5pbWFs
Lg0KPg0KVGhhbmtzIGZvciBleHBsYWluaW5nIHRoZSByYXRpb25hbGUuIFBsZWFzZSBwcm9jZWVk
IHdpdGggeW91ciB2ZXJzaW9uLg0KSeKAmW0gbm90IHBsYW5uaW5nIHRvIHNlbmQgYW4gYWRkaXRp
b25hbCBzdGFibGUgYmFja3BvcnQgb24gbXkgZW5kLg0KSWYgZmVhc2libGUsIHBsZWFzZSBtZW50
aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSB0aGF0IHRoZSBiYWNrcG9ydA0KY2xhbXBzIHRvIGBW
SVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkVgIHNpbmNlIHRoZSBidWZmZXINCmV4cGFuc2lvbiB0
byBgTkVUREVWX1JTU19LRVlfTEVOYCBpcyBub3QgcHJlc2VudCBpbiB0aGlzIHN0YWJsZSB0cmVl
Lg0KDQo+IC0tDQo+IFRoYW5rcywNCj4gU2FzaGENCg==

