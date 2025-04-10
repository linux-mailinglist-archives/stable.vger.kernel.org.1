Return-Path: <stable+bounces-132053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B08A83A38
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7124D3AF48F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BDE1DFDE;
	Thu, 10 Apr 2025 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HILKqu47"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DC202F8F;
	Thu, 10 Apr 2025 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268594; cv=fail; b=GN55fMPZYxCXy4Ge0TM4H0DbRUHXB48x6OicB1EfgVp1jqeR11o7zF+xt3n9bNM1iCQXKT1VDsVqtGlJhBKlggzY2udBysUjzaiD6ExNueSb/6ZwniqybO/q80Z5eDJRnv/+yEYzjRFYjh6xZHSCluqzHXrOu9O5cSmrc8kPZCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268594; c=relaxed/simple;
	bh=8NjfElLkejDFR+hp27Su4WBMDdVIMU4Zb8uMMj6x89s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hyLFbdHUkrA3Za6X5G0eewCaMGHDbOJ3i8pFxUL1QzJSdD4hiJtxMj8KQGHFEfskVdBKg/NnX488wEqgF7zLEu10m2V9WXmNRIRb3LMtaLdxOSx/OTivB6cfYin+j7mxhxTrDFFEPq97Hfx0dwSErbQhDBMV8zYTZocnHS0fW+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HILKqu47; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmjZS70iebfJQwa2Cj3Y/eZpdpwD/a9jhyKahVe2QjyTwBHo8tp4f34DfM0pjKcTGXnceDtASaRgC7xX/0YQpDasnLMwgyP9+b59mmMxZ02evuJmCJMV+zpZm25qO0G1FlMJ2M76s56jpKrWS65bRHGQWLbZeS95ApreTY1MY/2p6PtcTbvcnU3BSQmBxn9UTc0WZK53bZq8whOhiXgmhdy50SOEIib9RxjtfqKTTLqH4+OCn0KAEpYp/K01jKldXzZSY2w+t6j+wFJ+fDicZi+RmmZaF+bSEqYHB73EOsJ2Bp+Qu7Acplg7VHxpjSoohKSmKEoEc9/frIwZirwc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7inkriHw8VD10qn0nfRiw6rOzEYpsSe2q/6ndYk0sA=;
 b=XIMzKuRZQUjceW0jBgrfAGoAG3EsM1JlBseh72dtfEBtAxcGL/FELYTj7H7GwnwbmCp952x+DTYgfkihFitvYiV/U873vrZbpUpE42pE2frd7nsYSS+y4z40zUqsIZwql/8e0vnaHJu1BYSwXK3pJZY3dp6dC52kIgp74Dq0c7SzAkAVXNEpRIw/D61LjPgni6wPfDdgifk8cQPwH9aD8dwUZDv5vZO7NLR7pDz2GOMUgWUgzdDsQRCedhdYfteDnnDxJxT2kDGaP3inGm9Wk+KIoesXl0ru73gcXSysa+hNn/8FIhTtGNJqJSk/6QW7I2sGF6lzNCyTNim/rj2OiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7inkriHw8VD10qn0nfRiw6rOzEYpsSe2q/6ndYk0sA=;
 b=HILKqu4715fECWxo68oIJ0gjXEHX0w5H64TeZe/MZ3EACgrse+gFJv1hrUV3ISuD/8eX2/8bdFFHTdZVr52hXKnL1W2NMEgHAiSgT6/tdtGgc9g+/yhtc8fBATiWAdkx7YgvrVvdJPCqq5dnsiqFtoLqmmm2ZqP6APbbeeq/35AWmIZtEtDxk+EBx+GmDC23mnaMj1jOPk6q8qDFFdkj6kZGObaiGjMQrPJmSpdCAg5KLoVCcDNMAKo4pzuPneJwXu7pcj0magWI2CLNYOSywSc9LCvSPypv2kgdmQvr6YHe/Qv5a6rQtXj8WM45pXNr+93bFsjv6dgowwmVFUNKrA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 07:03:03 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%7]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 07:03:02 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>,
	Mel Gorman <mgorman@techsingularity.net>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXT] [PATCH 1/2] mm: page_alloc: speed up fallbacks in
 rmqueue_bulk()
Thread-Topic: [EXT] [PATCH 1/2] mm: page_alloc: speed up fallbacks in
 rmqueue_bulk()
Thread-Index: AQHbp+cqJgEnSiMjBU6DO4eJQEZtrrOcfLkw
Date: Thu, 10 Apr 2025 07:03:02 +0000
Message-ID:
 <VI2PR04MB11147BF60BD14C843A1371611E8B72@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20250407180154.63348-1-hannes@cmpxchg.org>
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PAXPR04MB8958:EE_
x-ms-office365-filtering-correlation-id: e386f8e6-275f-4aa0-6b33-08dd77fdbc4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ImxpqBsW8+PyNtVdsOXfexMw7yDQbtsQUSo5xvxDgnN8CkkYvlej7EFKPX?=
 =?iso-8859-1?Q?S3GLkU9ZeC6W89QcNTBuIHQxfxoSwQTmkx4XhKIEr5CIG60R+4Hilq21ew?=
 =?iso-8859-1?Q?9xQpUSa/uFmzO8i14k+ue12Q3UWM1i+xf05gVNA0NojpS2Op45kllW21ib?=
 =?iso-8859-1?Q?sJp4CRfkCbIeOTPP8jtiWpsbKGQg1b1k0Sgs1Z+LzU7HyHXcaNPxNxDgD8?=
 =?iso-8859-1?Q?EwNXFhsn1fQUUNz1Lbok1vBxlbdY88BQeQ4r3i4I9gKH5Zc9PgOAmvIelc?=
 =?iso-8859-1?Q?KY7e9ZXv9/FGeTdazEfM+sXeSb1AJYTEyCm3BUiIF2Ryb1n/Ucttbq3p1b?=
 =?iso-8859-1?Q?meqziLKDp9eOLi3N4D7yqa2hayzaSC532TKvSecZOb2d1LO50EnblCimb/?=
 =?iso-8859-1?Q?bC8gx2Ayk61/hbyRuJUKsLC4/Xx9tDAjVlmNjMX6Kg+H93pZEKQDGYDGPb?=
 =?iso-8859-1?Q?J3xZt+ynZCndtzRliYQFuOQ4JJsqrINE65Yf4uap6EzOcdzBTMAzrI/PAi?=
 =?iso-8859-1?Q?WEE8XElvtvtP+PN+GIN8K2zDHkOcgrFlwYhfnfmTK0vnXELdeEoGfgVd33?=
 =?iso-8859-1?Q?5/IHMXJFgtcAWDysCjPwxDaL/s/VwGP7HjUEVlOIY1FwwMEMizoMBbbCeu?=
 =?iso-8859-1?Q?GdOejc+KXLUmWT2Kyfdm5uRSK5bZXYBsOjS+7ZyPfwo+droZ3IL5Ez597c?=
 =?iso-8859-1?Q?fG7cn4veFD0jUc69AfjV880SLIkvba2zT44Kq2mYnvsJngghmIGYv+9h1j?=
 =?iso-8859-1?Q?p1pMo/cLbtwqC/5WNywg20Vi3gPsJYFfBO+vlOxJnsKuGxxYgKk9w85crk?=
 =?iso-8859-1?Q?nRPN0QwXcMpnZYDvhhzt94IKEIquSU7aV417YCFB2MxgAC5XKtQNkYRwoZ?=
 =?iso-8859-1?Q?uYzMitSeK/7spPUfVuF+/nFRIcSy5KAyDxJ2MypqYSvCmroCKocy5l6SBF?=
 =?iso-8859-1?Q?5Xigo9wge0hZCHUADVASorsGguU83f4++MS5vv/Jpx2cdXnm5YVAt5tjGq?=
 =?iso-8859-1?Q?gjKBkZW8eHfXjDfDdJhGBG9k3EimJd4mTyTq94yDzM/NYe1hPgDdL2eK7T?=
 =?iso-8859-1?Q?iON3PD+NiuVPmopd9Vbyvbksk8aOHX1CkALOuwxNaUldrqYCMP7XYw0MT8?=
 =?iso-8859-1?Q?Qlo7GFcljI2PvQ4cTZEZiLFRltziLf9BpmdN832f+IluTJtaQDeW+PFk+O?=
 =?iso-8859-1?Q?l5zBFckou4miYPFc0WK5oZOF6hnubhHnnhvN1MpilCRRjadhv3eQtJhRF/?=
 =?iso-8859-1?Q?DuKnQMbBT8wCBOXZa1TImViTDOwVwFuk3zJO7YmObp8Lv0SKVi1A19whnP?=
 =?iso-8859-1?Q?COurnpgvoxcBEcqRVN8NFhr+LGMbCKnkLbH9R4ev6HTL60tNNYHV2rRSLB?=
 =?iso-8859-1?Q?jtu8ZcBVc2qik+Ud7wzZVsG6O2Hyb2aimJGsGNzp/wkR0WsKA6YYQgCkqf?=
 =?iso-8859-1?Q?6Cu+F50Ypl3pgxDaO33CVgPdeqfzG1lvpjOgBKhDfUuFWBPD0OGCecgzVG?=
 =?iso-8859-1?Q?8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VtfZweFAUwMw0Z87lIMDVGVP+uMLKb9W0TCm86exA00nq+AYwZoz5QhZWg?=
 =?iso-8859-1?Q?TDYz5+By08a0DeAqCqtt4qU49IE5V/yUEO5g8EVaZhE4zXddXWxqu3O8Gp?=
 =?iso-8859-1?Q?K79ry2iWJvo6llo8aYtMvGEmhm44qL1+MWr8hwKw9JeIzy0w31T05lm7Ae?=
 =?iso-8859-1?Q?GifvenhpqI+hAhzthXyfJIaVKqk8KtbewvPVG4UNJAZysVPmm8c98KCvsl?=
 =?iso-8859-1?Q?w4e2k3YAcVLRDVSTez9QMAiBv6cRnKCrjNSagTZcTGFlADE1d30Qlhm3s2?=
 =?iso-8859-1?Q?x1NDMMjAJ8/70ecWeQcT4U/Jh585qfCBT/gH0EjUMHESmuBjaHODZfLNRA?=
 =?iso-8859-1?Q?F/3Easn+TLAZJ0puZKbvpt3MaNAtrZKcBgxmFj9lvmR/8TuPOjCTLDhjeW?=
 =?iso-8859-1?Q?jtgQQhWyHQsxdJTIvsXA3xqw+oqyx419RGYDBjaCPg6JMYDi82JlhAbrnE?=
 =?iso-8859-1?Q?zKyTtB7xzqKyWnj+jtObp/FC+zKhv78zZIpuNZUTaMJ3KFkhvd4vi+5+HR?=
 =?iso-8859-1?Q?Ve44af2WOO8NF/I2DpkKW0/vcO5A0XkdRKfaypxmG6QlXCCxB1Qw0u29ia?=
 =?iso-8859-1?Q?hEIDuRgQLBbL8ja2r7xc/hk8qQXRg5BYOUAnNnmB59AfQAMBSn0a5t5ONe?=
 =?iso-8859-1?Q?hltzCUaXvuXya2vnbUvIy3s8m+C56oZn3sBEgTcT00/3eT+EA2JVvLWelJ?=
 =?iso-8859-1?Q?ZBvPelEY31r1WRgJs6U7qbgyqTqECYpTsFeaaKT5DgHaaHKA/Ha0Gz24Ot?=
 =?iso-8859-1?Q?hcjYtR+UjUyyy8Qv9rqMgmkO4GnZ6NxTEPPa5EKloPvBQcv7YjTsOhwQwa?=
 =?iso-8859-1?Q?p3FmGuXdkWSddL0HNvoTjjRgpeSvfAYB8fIDFI1q73xOlwQbOP9IbWRSbz?=
 =?iso-8859-1?Q?EzODHUoiKV7xta09m7lLHhfdDX+apBTYVttD1m7HNuLVeB7z20BAU7H+r+?=
 =?iso-8859-1?Q?SGNxU/3fwAXJgTn4Ox4Z/9bDHxOu1Bk0YJ8x3zdzAh/RsWpz+MA1BnS9CC?=
 =?iso-8859-1?Q?kCAjNMP5VUPqbcWqUhvHsziraZGuJCwJMavGkTK9vomIMJaiG3J856uUFX?=
 =?iso-8859-1?Q?qgmLH+UcIEe/4iXwGG+EXmP2dS2LeodNPwXbCdyUAEDQzEzXpmqeKdH/kN?=
 =?iso-8859-1?Q?iR9PkljbNhwC6hU25cvyThhir/jdX15M8jwZEcBA9Weazp3CiLHCdYlAWU?=
 =?iso-8859-1?Q?AmxRblHTsT2/ncX85VmFst3m7THV7/5DrDDPL5Ko1qtx/ScsJwTYjyO8qK?=
 =?iso-8859-1?Q?AMz5IFPK86LFSH/jsriJM0ULceMGBn2K0UOxEfBPTHGghvUPOkckqXk8wU?=
 =?iso-8859-1?Q?E3eUNvKxkX7fVJsonFFt8NE4hDIbWc1gDR3zRpqRpgrH9wCHBb/0hGk4Q4?=
 =?iso-8859-1?Q?q0cVfkBDKCeuyDianOFKoJqG20KfUA9+r2lyT1ElqixMcYXdGuUOQQShCx?=
 =?iso-8859-1?Q?uqC1tdi/taaWmMUA24yRGa2idmBJMq8YX79dv2OayHbWb7Y0nohCKsAItK?=
 =?iso-8859-1?Q?11bkL1gruaSHMiO0rtR/FFV5VRKGW9rPtpeF1pTsaYLK0ws+ICnR9a0vtE?=
 =?iso-8859-1?Q?ypD3FhG1p2eixrh60wy7IHQeI/xxVJ9DSUCvDUmL9xmTX4LhQtAhCtISSU?=
 =?iso-8859-1?Q?/RNwLOTtEgOrE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e386f8e6-275f-4aa0-6b33-08dd77fdbc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:03:02.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8OmaqMZilBePVwpecbnQkpxnox7DlhMGhMpD41znSlGd182yOMWQ6zNudLduNF6VCrWMFOwrWjUSKHL+wm+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958

Hi,

That is a nice fix! I test it at imx7d.

Tested-by: Carlos Song <carlos.song@nxp.com>


> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Tuesday, April 8, 2025 2:02 AM
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>; Brendan Jackman
> <jackmanb@google.com>; Mel Gorman <mgorman@techsingularity.net>;
> Carlos Song <carlos.song@nxp.com>; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; kernel test robot <oliver.sang@intel.com>;
> stable@vger.kernel.org
> Subject: [EXT] [PATCH 1/2] mm: page_alloc: speed up fallbacks in
> rmqueue_bulk()
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal sing=
le
> pages from biggest buddy") as the root cause of a 56.4% regression in
> vm-scalability::lru-file-mmap-read.
>
> Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix freel=
ist
> movement during block conversion"), as the root cause for a regression in
> worst-case zone->lock+irqoff hold times.
>
> Both of these patches modify the page allocator's fallback path to be les=
s greedy
> in an effort to stave off fragmentation. The flip side of this is that fa=
llbacks are
> also less productive each time around, which means the fallback search ca=
n run
> much more frequently.
>
> Carlos' traces point to rmqueue_bulk() specifically, which tries to refil=
l the
> percpu cache by allocating a large batch of pages in a loop. It highlight=
s how
> once the native freelists are exhausted, the fallback code first scans or=
ders
> top-down for whole blocks to claim, then falls back to a bottom-up search=
 for the
> smallest buddy to steal.
> For the next batch page, it goes through the same thing again.
>
> This can be made more efficient. Since rmqueue_bulk() holds the
> zone->lock over the entire batch, the freelists are not subject to
> outside changes; when the search for a block to claim has already failed,=
 there is
> no point in trying again for the next page.
>
> Modify __rmqueue() to remember the last successful fallback mode, and res=
tart
> directly from there on the next rmqueue_bulk() iteration.
>
> Oliver confirms that this improves beyond the regression that the test ro=
bot
> reported against c2f6ea38fc1b:
>
> commit:
>   f3b92176f4 ("tools/selftests: add guard region test for /proc/$pid/page=
map")
>   c2f6ea38fc ("mm: page_alloc: don't steal single pages from biggest budd=
y")
>   acc4d5ff0b ("Merge tag 'net-6.15-rc0' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>   2c847f27c3 ("mm: page_alloc: speed up fallbacks in rmqueue_bulk()")   <=
---
> your patch
>
> f3b92176f4f7100f c2f6ea38fc1b640aa7a2e155cc1
> acc4d5ff0b61eb1715c498b6536 2c847f27c37da65a93d23c237c5
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change
>  %stddev     %change         %stddev
>              \          |                \          |
> \          |                \
>   25525364 =B1  3%     -56.4%   11135467           -57.8%
> 10779336           +31.6%   33581409
> vm-scalability.throughput
>
> Carlos confirms that worst-case times are almost fully recovered compared=
 to
> before the earlier culprit patch:
>
>   2dd482ba627d (before freelist hygiene):    1ms
>   c0cd6f557b90  (after freelist hygiene):   90ms
>  next-20250319    (steal smallest buddy):  280ms
>     this patch                          :    8ms
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Carlos Song <carlos.song@nxp.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
> conversion")
> Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from bigge=
st
> buddy")
> Closes:
> https://lore.kern/
> el.org%2Foe-lkp%2F202503271547.fc08b188-lkp%40intel.com&data=3D05%7C02
> %7Ccarlos.song%40nxp.com%7C3325bfa02b7942cca36508dd75fe4a3d%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638796457225141027%7CUn
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCI
> sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3Dgl5xQ8OLJNIccLDsYgVejUC%2B9ZQrxmt%2FxkfQXsmDuNY%3D&reserved=3D0
> Cc: stable@vger.kernel.org      # 6.10+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 100 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 74 insertions(+), 26 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index
> f51aa6051a99..03b0d45ed45a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2194,11 +2194,11 @@ try_to_claim_block(struct zone *zone, struct page
> *page,
>   * The use of signed ints for order and current_order is a deliberate
>   * deviation from the rest of this file, to make the for loop
>   * condition simpler.
> - *
> - * Return the stolen page, or NULL if none can be found.
>   */
> +
> +/* Try to claim a whole foreign block, take a page, expand the
> +remainder */
>  static __always_inline struct page *
> -__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> +__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>                                                 unsigned int
> alloc_flags)  {
>         struct free_area *area;
> @@ -2236,14 +2236,26 @@ __rmqueue_fallback(struct zone *zone, int order,
> int start_migratetype,
>                 page =3D try_to_claim_block(zone, page, current_order, or=
der,
>                                           start_migratetype,
> fallback_mt,
>                                           alloc_flags);
> -               if (page)
> -                       goto got_one;
> +               if (page) {
> +                       trace_mm_page_alloc_extfrag(page, order,
> current_order,
> +
> start_migratetype, fallback_mt);
> +                       return page;
> +               }
>         }
>
> -       if (alloc_flags & ALLOC_NOFRAGMENT)
> -               return NULL;
> +       return NULL;
> +}
> +
> +/* Try to steal a single page from a foreign block */ static
> +__always_inline struct page * __rmqueue_steal(struct zone *zone, int
> +order, int start_migratetype) {
> +       struct free_area *area;
> +       int current_order;
> +       struct page *page;
> +       int fallback_mt;
> +       bool claim_block;
>
> -       /* No luck claiming pageblock. Find the smallest fallback page */
>         for (current_order =3D order; current_order < NR_PAGE_ORDERS;
> current_order++) {
>                 area =3D &(zone->free_area[current_order]);
>                 fallback_mt =3D find_suitable_fallback(area, current_orde=
r,
> @@ -2253,25 +2265,28 @@ __rmqueue_fallback(struct zone *zone, int order,
> int start_migratetype,
>
>                 page =3D get_page_from_free_area(area, fallback_mt);
>                 page_del_and_expand(zone, page, order, current_order,
> fallback_mt);
> -               goto got_one;
> +               trace_mm_page_alloc_extfrag(page, order, current_order,
> +                                           start_migratetype,
> fallback_mt);
> +               return page;
>         }
>
>         return NULL;
> -
> -got_one:
> -       trace_mm_page_alloc_extfrag(page, order, current_order,
> -               start_migratetype, fallback_mt);
> -
> -       return page;
>  }
>
> +enum rmqueue_mode {
> +       RMQUEUE_NORMAL,
> +       RMQUEUE_CMA,
> +       RMQUEUE_CLAIM,
> +       RMQUEUE_STEAL,
> +};
> +
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
>   */
>  static __always_inline struct page *
>  __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> -                                               unsigned int
> alloc_flags)
> +         unsigned int alloc_flags, enum rmqueue_mode *mode)
>  {
>         struct page *page;
>
> @@ -2290,16 +2305,47 @@ __rmqueue(struct zone *zone, unsigned int order,
> int migratetype,
>                 }
>         }
>
> -       page =3D __rmqueue_smallest(zone, order, migratetype);
> -       if (unlikely(!page)) {
> -               if (alloc_flags & ALLOC_CMA)
> +       /*
> +        * Try the different freelists, native then foreign.
> +        *
> +        * The fallback logic is expensive and rmqueue_bulk() calls in
> +        * a loop with the zone->lock held, meaning the freelists are
> +        * not subject to any outside changes. Remember in *mode where
> +        * we found pay dirt, to save us the search on the next call.
> +        */
> +       switch (*mode) {
> +       case RMQUEUE_NORMAL:
> +               page =3D __rmqueue_smallest(zone, order, migratetype);
> +               if (page)
> +                       return page;
> +               fallthrough;
> +       case RMQUEUE_CMA:
> +               if (alloc_flags & ALLOC_CMA) {
>                         page =3D __rmqueue_cma_fallback(zone, order);
> -
> -               if (!page)
> -                       page =3D __rmqueue_fallback(zone, order,
> migratetype,
> -                                                 alloc_flags);
> +                       if (page) {
> +                               *mode =3D RMQUEUE_CMA;
> +                               return page;
> +                       }
> +               }
> +               fallthrough;
> +       case RMQUEUE_CLAIM:
> +               page =3D __rmqueue_claim(zone, order, migratetype,
> alloc_flags);
> +               if (page) {
> +                       /* Replenished native freelist, back to normal
> mode */
> +                       *mode =3D RMQUEUE_NORMAL;
> +                       return page;
> +               }
> +               fallthrough;
> +       case RMQUEUE_STEAL:
> +               if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
> +                       page =3D __rmqueue_steal(zone, order,
> migratetype);
> +                       if (page) {
> +                               *mode =3D RMQUEUE_STEAL;
> +                               return page;
> +                       }
> +               }
>         }
> -       return page;
> +       return NULL;
>  }
>
>  /*
> @@ -2311,6 +2357,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned
> int order,
>                         unsigned long count, struct list_head *list,
>                         int migratetype, unsigned int alloc_flags)  {
> +       enum rmqueue_mode rmqm =3D RMQUEUE_NORMAL;
>         unsigned long flags;
>         int i;
>
> @@ -2321,7 +2368,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned
> int order,
>         }
>         for (i =3D 0; i < count; ++i) {
>                 struct page *page =3D __rmqueue(zone, order, migratetype,
> -
> alloc_flags);
> +                                             alloc_flags, &rmqm);
>                 if (unlikely(page =3D=3D NULL))
>                         break;
>
> @@ -2934,6 +2981,7 @@ struct page *rmqueue_buddy(struct zone
> *preferred_zone, struct zone *zone,  {
>         struct page *page;
>         unsigned long flags;
> +       enum rmqueue_mode rmqm =3D RMQUEUE_NORMAL;
>
>         do {
>                 page =3D NULL;
> @@ -2945,7 +2993,7 @@ struct page *rmqueue_buddy(struct zone
> *preferred_zone, struct zone *zone,
>                 if (alloc_flags & ALLOC_HIGHATOMIC)
>                         page =3D __rmqueue_smallest(zone, order,
> MIGRATE_HIGHATOMIC);
>                 if (!page) {
> -                       page =3D __rmqueue(zone, order, migratetype,
> alloc_flags);
> +                       page =3D __rmqueue(zone, order, migratetype,
> + alloc_flags, &rmqm);
>
>                         /*
>                          * If the allocation fails, allow OOM handling an=
d
> --
> 2.49.0


