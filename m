Return-Path: <stable+bounces-232794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDU6LxgozWnTaQYAu9opvQ
	(envelope-from <stable+bounces-232794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC337BF27
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA83301AD30
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344F44B694;
	Wed,  1 Apr 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sh7rv5ZL"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7643E9DC;
	Wed,  1 Apr 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051881; cv=fail; b=m7xYTY9AIheGGh0qI7gz0L9eX1tEaayV4SAqjHNPF7Xztj+fY6gyqqdR/hpd2fxnlpFgcg2zEb2H1YcZfWhewVlwslBRYSTOkhHE/EXj93W2WzmckBwWsZArKbVLUwZLWKvJrJe7KEWSDkLvRigXpKbUxozsydX25mReYiJp96o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051881; c=relaxed/simple;
	bh=oRw9jvBGuPLazHJ2xihFeMB3zoXGBRwOlzcZcJBy3aM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AwwnciSr5p/DH7yuDjx4llNsJPtvsS07vLYWFGFG1AQ1dhG1VSaGO2OOltDfmBhjPLSpY0426fI6JAWc+soK5el04xBOpsOUbEd+4q6LbHAvzd5FdjEysV+y1aKUKojoeNbXkM2OrZRcnveysyC4klzo8QAfsWJJNZg71y23nPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sh7rv5ZL; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l955zDDRQwxjwFqe1908rciCY4MoMQfIT9H6rIDz0VsQdvaj75O+9RNZTI1SLuHLfypgW6hkd5fhbf6uwIWk4l2ff0oB76VScMCEW65naoezcjnUKtJN9kOaYX46NuSj1TorQ/DLRh/yWkUlMEM9Erm34cpP0U1oz2jFEI8uY9o8NtR2iktAkRCaI7iJhILbElrXHGSA8P5fH6FQGa6LDv32/AoAajfN1Y93aomhS5N9hdmV/ff6ZwZI83gAKxl5DeeD3ptg2Pk+Ts8zoQzwl8NTusA9VDapSiDmU/B7rgHMYAPdQLjtnfMvOe/ERS666CuRdNOv5n5g+9NT4+0huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10CUdlbAGV6Rnwg/S/TLG48/vXqrrLOUYdNzSEllSW0=;
 b=l0KxT5IDvnT1p/wJ00NgbZblBZ/iknJiulXXegQWKYcf7IwZ+UbTeEJzw4csEZUVlMBHJb0d0dZ0PfgAOTWvA9wyb0YE7wZaYVSpvG7sP3fHAS5yW+HsMEAmSiEI1owHUcfVmPO4VDCs0laQ9dhvEfoIfp8L+N+pOjXjIq7h3V/WlsFfiKw75FxF3QXgAaGFbUywOVMsZvP0BhhO4f3vT3RRDdkEoKLLgSQPvOjS06yRqrMqgYrRBmSy/W1gUm8RgjTT7hap5K1cOD0LcDB8ETQllJmsCqmsEUZ1lAskWq3a2v+PvlaBVqE0sK1dZPd7aERRkhPgbaWS46tyPWcq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10CUdlbAGV6Rnwg/S/TLG48/vXqrrLOUYdNzSEllSW0=;
 b=Sh7rv5ZLILCFHFSEGeSRVus9IHUuJ/Fyn5s2rb8SPrvtP4cRKA2uG1l1RWQ6ItJZIvzRyyXR92C9a1y7Z2en2JtXoHv7yHV7srMYKBevwFY+efGZSURn0emrmMXphu+g8asGknBZdJzQuSyZpUtwTYL3we8pIVG1dYagQdvlTyw=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:57:55 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:57:55 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: "Erim, Salih" <Salih.Erim@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, Christofer
 Jonason <christofer.jonason@guidelinegeo.com>, "O'Griofa, Conall"
	<conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "victor.jonsson@guidelinegeo.com"
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7dnEu4MVLVXG06oIZXnf3P2bbWjB/QAgARjkoCAIuly8IAABfbwgAALDKA=
Date: Wed, 1 Apr 2026 13:57:55 +0000
Message-ID:
 <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=ca8e4a71-3c93-45d8-8ffd-d61afaf2e605;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2026-04-01T13:52:28Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|DM6PR12MB4122:EE_
x-ms-office365-filtering-correlation-id: 074e620f-5969-420c-74d4-08de8ff6acda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 hOeER5+wj939gPVP8evTqgTDpA54jL1LWDLxxHBsRcOJfI5WaeiFM3qeArSCGEQakWY9LUax271XLHNyU994JNoG/KNlYtqYXzBm+LQFWzJLbS9mOZ9OgaDNK2y6fr5DS/u5qkvnOu/hVcEsOF0OynIrzJmn8lijReRVJMmuuU+juihFRZ/t5uDDpeh0PlhRzXzqZYwt+Z5PgFrDyZOHkjMQKgKM7U3jE0+cHKO7XLnhS7cdrW/91peKR2068tTLmoQYtiHosjCTyPqZEliuVQLYl/LGt8j5AB212jpPnVyG/6McK8NPbGo6VchpTihJCmFDzjn37ksR7ZeYBVIn4RGT+YrIbtHksUp+qxAYnZn+XJIRlUJSGe2N2zOD2tuUoa0G9nEhg6aGdvahhqjYNvI5Imn67STXpen8T9F5BrP1ggFzWXAmiaa0pId0TAEkS4ncpdcAfPyCSrWpx6gVb/o6tl/MQsQdI7jKuM1DXBXS+dcPfgmj2PrMCVgmuaOBQpQQpQKJAqZ07ordp1BvWTwYK33GoWa1qKUzuue8iVR6tdmZVmxScyr6vXFJYLIlQ8J/Oh39hzRaZSFZQTwXtS0XGTrUbolvYWIkp/lPj6msuxJv6bVu99VfsPIM/nARgI/GbBpeVGBZrgk2f8w5/CfB8qY5o1sK8jf5SlmQizFcxBKKRjnzZOWjdOxszI5ODFYHvlPRNvP2N/5VM1RY67dvwjkR28Ie0QEhu0xzaBQgGa8vYuE/HGp2J/1qXuu5P0R8/y8ytMeJZ8lksQgB691feObz2MBZp2SuqU1qK+k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c+r0M6/mMCl+e/Z8h5goCm4KosKF/OOUBmj/GDQq38d8lhr7WJYw4N+viem5?=
 =?us-ascii?Q?perQ+svqL6nWUjvFPd+i2Y62HgakKbP3tWEHrg/Bpts3mCGCpECf13LxvFS8?=
 =?us-ascii?Q?tPCyrdzdDk7GVIuRSsLrF3rV0/olZQcCmFxmDqRPhPSe4rjP4ZcWLyM2/Yj9?=
 =?us-ascii?Q?rSBUMjkdS/+FRsFdTymbwSWEKmJFJGjSg/ZUalRcRbEsJbvPv40hLV8j+GhH?=
 =?us-ascii?Q?30+fp1cIkD5GMXp7u8IcQ9qLFsE2L9zVCMiOIungZFv/5B4EV+raF5bpilIB?=
 =?us-ascii?Q?2pq4K3GhCB3gqcJmsdO7n+OnnjYTIXNTeNuAvCD2ZUFLAyEGAHPM9+UqBFtp?=
 =?us-ascii?Q?Jfv3mbm9lbCcoZTSxMo/x7oRxi+1paidgv6B8PixGve5DVwTKSmgmrdzD+tb?=
 =?us-ascii?Q?zzgsRFwjyjMChM4Rr5/t0mh1AEB2O3t11cK+Ns9dsHzjuVHKsTcnhetJpSW4?=
 =?us-ascii?Q?ihsR0JZpL+5htBmjb9b79VBInBN+w76qvldhUi1+SCCCSHsarwArXE5bRsHv?=
 =?us-ascii?Q?pCrdfUNtBaKQtw/vHXoRK25SyFpVRgHbFO6GKt67GlfS4Pu50L3WL9gzy2D4?=
 =?us-ascii?Q?OPqVdXg0+k4gbCsRj5mSZaYTva9sfREgxHsLVHGfFuZQzMHCEi6YARsIZDun?=
 =?us-ascii?Q?PVI280OPUiXKpwSY4kBqPN5lKlVvbOKFETmHj9BmIEAZoE5FMlAJYgjbd0l4?=
 =?us-ascii?Q?zDNb5wzl66sIKvbuNGPk5xCBy0dDqhEwzOL/2uVOlWUKa42vLy3K66nOgMYl?=
 =?us-ascii?Q?/8BgWdT3A7lSzd/2GYPbaIWDpiubI6EJcEGbWwX9R3tb3TZ5CJJPxDv6P6px?=
 =?us-ascii?Q?z1JDxywwP+htcy++OaV61jC6SGiZ8IOdKNV0gUr4wacsZEkHTiBlo5qeOww4?=
 =?us-ascii?Q?EBkY8DtynWGQSaCuyUhc0KEMT4DYFY3V0cW+Zl03K6mbUaKMx0jiWiQeB7sh?=
 =?us-ascii?Q?1fie0AYHMMSNuGY4cGpPl+DfaBB9VpzTdeELQxUReojUUO2fF0zb5x1ni1kd?=
 =?us-ascii?Q?UZxmB7T+9ACF5SpzdmZjPHke15fFhffTtoPFVmEu8ys4T47u1ilDkiek/BS3?=
 =?us-ascii?Q?HIs0UFPwU6wA0no+PQAR1NMC7rDsgus3YTRLxY8LFMmx+GoiRZaOcVoHfR/D?=
 =?us-ascii?Q?z3+nSPnwGwDjKe3LYTz7CVWPVg6Q7PXzYUyEIyn/MLG4rcU87sc73ctkOP2C?=
 =?us-ascii?Q?7VQ1ogfNui1tCFIA/Q2f5vQC8EW4FKoCcYJx4UgjYCT5OnKgKZUxOhp778X0?=
 =?us-ascii?Q?OUxuQqPcTARTcnZZ9z1YFTsd/Ds/F01kSdYUq3QkrTfoIQBeNOxy5FLPjoh2?=
 =?us-ascii?Q?0P+gFWJMTbgW8vq36jhJs4asv2d3ohz6t70KRvKuZuS53c/7A2Hbt4wBKMJe?=
 =?us-ascii?Q?VhexRcoT7b4mo/sMIwy+uUeB9TlKHbC3O1BywikVYd3I+5lX/ZUbp9cbvKju?=
 =?us-ascii?Q?38U699Jb5QOjRnjSzY++meJf3SXeTbl4O2cHh69P73XQsPLu0XTyVIQsKBFk?=
 =?us-ascii?Q?AuRg3ciskUAp7Fyr/VmmrPXnwwBUSo4ICAsPTn8NpAWYTndVsSQtNr6TtnuU?=
 =?us-ascii?Q?hWGvdwJObHr+/nVSaujIhdOkeVW6wYRhS7eDmPORwHfEUEaLjhar8OUTQ3lY?=
 =?us-ascii?Q?a+w6rZ7yiHAMSnrF5T+OVJtKEFMjDy7T65arXbDoQjykGCsn9+ECEK6uWr0P?=
 =?us-ascii?Q?wxkZzKx4MFtyDBzNOOCn4z0ptTIkVsJl/k0OOojnvD5lFxOb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e620f-5969-420c-74d4-08de8ff6acda
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:57:55.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pceztFl6813RXfZBojX5UnEkaq+xXfBsQdh9Er+KHopgd3QX0xAYzukkxVdA5Vuf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Salih.Erim@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EBEC337BF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,=20

> -----Original Message-----
> From: Erim, Salih <Salih.Erim@amd.com>
> Sent: Wednesday, April 1, 2026 2:13 PM
> To: Simek, Michal <michal.simek@amd.com>; Jonathan Cameron
> <jic23@kernel.org>; Christofer Jonason <christofer.jonason@guidelinegeo.c=
om>;
> O'Griofa, Conall <conall.ogriofa@amd.com>
> Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> andy@kernel.org; victor.jonsson@guidelinegeo.com; linux-iio@vger.kernel.o=
rg;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable
> for dual mux
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]

I am deeply sorry about these markings. Please try to ignore them, and I wi=
ll do my best to escape from them.

>=20
> Reviewed-by: Salih Erim <salih.erim@amd.com>
>=20
> > -----Original Message-----
> > From: Erim, Salih
> > Sent: Wednesday, April 1, 2026 2:12 PM
> > To: Simek, Michal <michal.simek@amd.com>; Jonathan Cameron
> > <jic23@kernel.org>; Christofer Jonason
> > <christofer.jonason@guidelinegeo.com>;
> > O'Griofa, Conall <conall.ogriofa@amd.com>
> > Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> > andy@kernel.org; victor.jonsson@guidelinegeo.com;
> > linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
> > postdisable for dual mux
> >
> > Hi Christofer,
> >
> > The code change looks correct to me - it aligns postdisable with
> > preenable by reusing xadc_get_seq_mode(), and the scope is limited to
> > dual external mux configurations.
> >
> > Since this is targeting stable, could you please share what
> > hardware/board this was tested on and how you verified that VAUX[8-15]
> > channels return correct data with the fix applied?
> >
> > Reviewed-by: Salih Emin <salih.emin@amd.com>
> >
> > Thanks,
> > Salih
> >
> >
> > > -----Original Message-----
> > > From: Simek, Michal <michal.simek@amd.com>
> > > Sent: Tuesday, March 10, 2026 7:43 AM
> > > To: Jonathan Cameron <jic23@kernel.org>; Christofer Jonason
> > > <christofer.jonason@guidelinegeo.com>; Erim, Salih
> > > <Salih.Erim@amd.com>; O'Griofa, Conall <conall.ogriofa@amd.com>
> > > Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> > > andy@kernel.org; victor.jonsson@guidelinegeo.com;
> > > linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > > Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
> > > postdisable for dual mux
> > >
> > > +Salih, Conall,
> > >
> > > On 3/7/26 13:41, Jonathan Cameron wrote:
> > > > On Wed,  4 Mar 2026 10:07:27 +0100 Christofer Jonason
> > > > <christofer.jonason@guidelinegeo.com> wrote:
> > > >
> > > >> xadc_postdisable() unconditionally sets the sequencer to
> > > >> continuous mode. For dual external multiplexer configurations this=
 is
> incorrect:
> > > >> simultaneous sampling mode is required so that ADC-A samples
> > > >> through the mux on VAUX[0-7] while ADC-B simultaneously samples
> > > >> through the mux on VAUX[8-15]. In continuous mode only ADC-A is
> > > >> active, so VAUX[8-15] channels return incorrect data.
> > > >>
> > > >> Since postdisable is also called from xadc_probe() to set the
> > > >> initial idle state, the wrong sequencer mode is active from the
> > > >> moment the driver loads.
> > > >>
> > > >> The preenable path already uses xadc_get_seq_mode() which returns
> > > >> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
> > > >>
> > > >> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> > > >> Cc: stable@vger.kernel.org
> > > >> Signed-off-by: Christofer Jonason
> > > >> <christofer.jonason@guidelinegeo.com>
> > > >
> > > > I'll leave this on list for a little longer as I'd really like a
> > > > confirmation of this one from the AMD Xilinx folk.
> > >
> > > Salih/Conall: Please look at this patch and provide your comment or t=
ag.
> > >
> > > Thanks,
> > > Michal

As I mentioned earlier, I have reviewed and it looks correct to me.=20
It would be good if Christopher could share testing environment and results=
.

Reviewed-by: Salih Emin <salih.emin@amd.com>

Thanks,=20
Salih.


