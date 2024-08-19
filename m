Return-Path: <stable+bounces-69451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97F9563BF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623F81F22126
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20115383C;
	Mon, 19 Aug 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LCnmlUj8";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YTVu8OfY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922415278E;
	Mon, 19 Aug 2024 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048787; cv=fail; b=QuHRvh6jwqWpqntcwm7vHdzS+C4QL1DWKK5GdJWf+f8zxsszjJPr7rPUitTgvmSI6cXELw57Hd2/slvxhQXw7EzUUA1s5KKkDnAaLEqLb9j1Up7rHlhzgCfkm0EMgUN1+Z1Db54A0F2D5/EizphxSaL0LHZ1IxO7ZYliHRBZQdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048787; c=relaxed/simple;
	bh=GhzHuHI7I86FfYWzywRsqfwXtQ4g4FnH4nE5c0LEFqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kinTAk84uPUhei2IlQdU4wUdjMMX+lvGVvesXb4RLTGX3QJLayN9H9Rxmr2bo8nlm0xK9DsP+VhaeHWlZdiQWU+LUzhPEbYPZ/zGBo9v3u2gWEvleusnE90C3yUnCmlrW/ADxS6/n/IJDd4l105kKtCDla2/0M+Y0r++Pi2G4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=LCnmlUj8; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=YTVu8OfY; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J4vcbw023748;
	Sun, 18 Aug 2024 21:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=gUNqYBn0VGFb5MWTMFhRvifJDOESQgcNuSRbMRSKAU0=; b=LCnmlUj8jELl
	IfPZZ2pyXBPdAWU1NBEU4YnDEDbV84A/Zf0YNeDyqo3I9Pa+8jbgciRSVujY/ySC
	L/dJetXmMVHsdH8SFKr77UjtBPG3XuQGQJ+m1Qeikx22RnQasOnW5IlNko5tUrI+
	u/kGHdP/kLObjXqiDEitjHCNPmB2v+Pooz7nlPZ+t3qpj7qUTEcPejTUQDW3zzf4
	0WDxKT0yKFLeZnxhmaR0giO33LLPBF/lpgylbQf/k+7m+f+AyQxaDS98D/xazJA3
	cNhvyDxwkfNVgbm375h8XY1XBaP3H5+jcw5xMjIg/Dq4nNIIQ2B0GOu1qw+mVQV3
	dBL6Zu9T4g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 412rdtnu39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 21:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHjkleL/BngquXUBhTXE8u1tWjSCkQe0M12KVOnJwMV1MHR+iP9tnBoXz6wEPFEWkj5QVhWSdcmxzX0GC7wiZdecAQwOPtqEnfn+LjCgkv5svSLAvztxHI0jkpLSD9pdj4fqLh9FyYhwYKyds/DUaeYv65IWbZZTrKzTr7o0S2jPb0KXIh9TyhCCv9uNukxjI8dD0CoAwc2DvoUg8kRsfNvgWv9au2++ah2h6Cfh4ymrvBJ211aOgfzIqBqw92tK4zueNUY/JyidTWfhgESVQuSXLofZNJf2dcZxXJkzngTF7JgOYif5tRoHo65fr7UzlRWhjm6/YWatBY/TNilehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUNqYBn0VGFb5MWTMFhRvifJDOESQgcNuSRbMRSKAU0=;
 b=od5c15Sb4YX/B/GFoZ3yzoxpz1JuXzI0r2VAgC28hn/uDo9Kpa2BBnU7Rl73hO6uFwaXAwlAwm0Impu8ZhDztPwVaKHjQS0zdzke3zo9sWL4hVlDI5QAA+GUY0m8cf9cSX2VJqhmytlYRjdGjPSOziBnmFtEYNQtICwPPPQ6fwXCT8Lq+Z2rFz13+JZE2Ao7D6K+Uadyoy3Vx70wLYzoNtd/rhzO+Q6hFAehwoyvjA1R8AUaXf4Vl5/A9grcuY3p+CekzCpDqEokQE2eS5EyoWkjwjz/GZUcNmzrLIxOgRZMmSB9ZDbEB3dz5UcAXSg+85FORXRJSZ7G26CcwHByyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUNqYBn0VGFb5MWTMFhRvifJDOESQgcNuSRbMRSKAU0=;
 b=YTVu8OfYzQxwU10tAOboj5f7PlqDJXaky84tkc0t55ZGslsD6FDvgh0kQnyCeHxexyyYsGJA5sNnZ4iYfmNP5Qkir/2fzDAwCIndgUftYbKHDRZ7VOGqZUvkgRZoVUfIjNyKNfIEoAriff9frjPF/wgrb0ZGUy9hxPYuNMW3Rnk=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by LV3PR07MB10017.namprd07.prod.outlook.com (2603:10b6:408:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 04:58:45 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 04:58:44 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] usb: xhci: fixes lost of data for xHCI Cadence Controllers
Thread-Topic: [PATCH] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Index: AQHa8fQPQBbEkmW6/0qefp5BtM/qt7IuBGuw
Date: Mon, 19 Aug 2024 04:58:44 +0000
Message-ID:
 <PH7PR07MB9538B91A187B4EB8654BB2EBDD8C2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240819045449.41237-1-pawell@cadence.com>
In-Reply-To: <20240819045449.41237-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWI0NGMxZGUxLTVkZTctMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFxiNDRjMWRlMy01ZGU3LTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjYwMjAiIHQ9IjEzMzY4NTE3MTIyNTU5MDY3NCIgaD0iMlFlcmdUcWh2djVjZVYwUmdpN2NjUGg4cllZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|LV3PR07MB10017:EE_
x-ms-office365-filtering-correlation-id: d7370846-d527-4f3c-878c-08dcc00b9a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hSIIStAO7a9OSGtCBlG+N/dD2g6cXeL1jVqdSAcnInPYJDeCPYwWLFR6GnYT?=
 =?us-ascii?Q?DRaEROmIQULfPjC83nC7Q1JRzX8C52aXiuNPfEl1unKYWA7z8iwvG8HtEvwR?=
 =?us-ascii?Q?K6zZ/Hj/ZvGG0pa82CKoKHpICv6xDrRooFebNWveAoR9yW8pfmy04OpSD3xy?=
 =?us-ascii?Q?jI61P/C2hOhuAuJEfbNVfDscgLMlfEZaJ6wZeXcAWPEm2bp/qoTxi7o/sIOn?=
 =?us-ascii?Q?lcm7UghqQpf1yHkOPeNxbfkK+ktLp88MNC/uVRRpmA7S8aykwGmiEblmxpic?=
 =?us-ascii?Q?tgxREq/NrWT5EyTJLEuslEzTmP/auIy9TyA1+Rvd0B7lBNPCqXOfPZvvdFde?=
 =?us-ascii?Q?meMDYqIdJ/Wl1eDo/GMsEnSFnoBlFxoicLNHkCe7kYrzp6zd9Qo43ClH5zo9?=
 =?us-ascii?Q?qTpFLUkLzydQNRIlaUh2khO7tX/aTVqraBvZhu61N8Tw6jfLOoUXgiR0fGum?=
 =?us-ascii?Q?8QGBIZ6JoiZ7KlceGPnK2RSD13pv03XlACd4GqU/9BjzNWW6oP9ZVGcBOPrA?=
 =?us-ascii?Q?roynEdDO64OKmH+I1cZKWC0QnbHZEaDzOdAcG9cGbT7apsnvuDlwfrIWpExy?=
 =?us-ascii?Q?yQGn/Ntkf8fAiMT3oK56uhcxQjRhglYwsxFPw3ALysqG2e82LYr+UoGwZTpw?=
 =?us-ascii?Q?s+J2cieMWNR9DUFaVetNKUWcXkN40B7tKajnd5xXZyLgrH2EMDk19UkhlTri?=
 =?us-ascii?Q?gdOpdVWjhunejmo7YYNDmIBOpIZOfLvzk7hbbcSP0uImnEKB+u5UHCOggxtb?=
 =?us-ascii?Q?v5J0+FcQfVdhJyZmuDqaLZYM9R3FRbY8AG7A3EmKcTgY3ZlF3No7paJg19u5?=
 =?us-ascii?Q?RqQg5kyZQtisFTiOOagedRR9iJRqGL9tlIFl/MWPAShXDulrs4a4G/IlnBqB?=
 =?us-ascii?Q?pXdjcpS4dK9RNbzkPFXwouz7wZChM0597RbhwC+ul45+bpqDdj7PSxRCz+56?=
 =?us-ascii?Q?Y8Pox9okNgvfsrx7rbq4nN01/Yjooo1jzWuMhT94Y5UZxAIB4huonIgNbC+E?=
 =?us-ascii?Q?/vViwl/8z2evv+3URWZN981CScJXWg4ylJPm7PXHMyaS0mIsF4ZzVWHSBfoB?=
 =?us-ascii?Q?/InZPLZnrEc8b0jXzhrGtgx5iWPd6CfTR7ozAUHRrtcDTNV/YBEwgtD48gfN?=
 =?us-ascii?Q?+EIgxsxoJ9LQMgagW5cmOM6ad3zVQHvTvAu0ubPmZxYjvxeNzrpKReUOX8HW?=
 =?us-ascii?Q?zCNZD0QGyjx3K7pcJvJ/OSWNx/N8+JbKXS2H0tPBGxxsq7avbp+KVPOcCVlU?=
 =?us-ascii?Q?I41EhNyOyOgF4qvVED7WvZY5JSC83VtxgKGTxdak1Ws8wOL5g7xerNbHLgqR?=
 =?us-ascii?Q?U3hvqw8kCPVhoyBAM32Y+kmAv8jO1mm5E3kOWQTgG5i0GnliSFAC7UOdw3nh?=
 =?us-ascii?Q?CPe2SpPzKGe8B/SMlwV+JsqJdyXoAu4SKofoTrhnrtEFLDsaeQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zlw2zknyfZAeFx4WUI/o/uca5XWskFGHB1PAavI2ZyL0m5Y1nfjtSZKKTTpC?=
 =?us-ascii?Q?t4IM70W5B2hw9FRQ6oOXrUqEUmAwaD/MOVRjOov47N557fOkjKeZ85U9JYLN?=
 =?us-ascii?Q?383w3CplGAMR+La+0HQbADPZ3iuh3/zTh9YJ4Q0yc1hi/v0tywzF7bmpLgiz?=
 =?us-ascii?Q?Fb16QUiFFc1NnhFfhDHS/Z7bjbxwwHfx8R16vaEmA6791J/e7RI4OP231GVJ?=
 =?us-ascii?Q?hebffky6SbNS2Lvr0oBwVFRLYecElYadSOw/uxPMG7iEKvyGKUqGKQsd0pZI?=
 =?us-ascii?Q?y9M+FUuaN+SGw8QtIPbAcoc/1fsu2k9Z4sTgupSQa/WQdBsSlfGhQvDoBx8Q?=
 =?us-ascii?Q?QOMq7zRN5jhHO+5iN6rgNuJ+PELdcV3LjmI4T4t+Iuzedl22Vr9QK/aw6LlP?=
 =?us-ascii?Q?UcNC2IzM13dGqInmuyDidVMUlAStrVh05ez7QJVGVl1L1H9pWR9Hri4NiFwP?=
 =?us-ascii?Q?usuN5wi7fAs7MaQKNbClFIQOOt/bza028tYoCMLf3vws0B1JepGsOFQ8xaeI?=
 =?us-ascii?Q?DfuG5Tt/aWTbtqIpHwIQ/w/9S/XOyl9/9BRc4vNQzWI3rldLKvdWoEqr+y0U?=
 =?us-ascii?Q?ZyGU1/5faYsNNsJc5sl2iMrO+Rgn66doWZCRq29+b1drquPbymRHLqwlDu04?=
 =?us-ascii?Q?5w9TP+cfU19NSQUlYfK9HY0DWes6AWLro4+feluZP0f4x76WzDp1ahpl5k7d?=
 =?us-ascii?Q?l6uqs+4TixbAjEOhHqL2QSIoJyrTO0CFb0wCfaPtU8myTLT0HV5LUVc8fjeo?=
 =?us-ascii?Q?lLyJ0KInKjIiN+49OmWya/JIpxwT6pm3qe2KZSi/SQL8m7MNhGJ3frt4D5VV?=
 =?us-ascii?Q?JfBdnPMRY8a3sFa1QK+1yfUTG1R2JWwpTKahr53G2pggObGFjWh6CPF9tlpJ?=
 =?us-ascii?Q?5cHPhfDNW8hFYe40qn3dwk2d4RhCTeCNM6RMB/QwWFfHVO7muTDsu9KrD/uM?=
 =?us-ascii?Q?hHHzNcO3GzmWKhiY2W54Hk+Ddbg47isA3AVQ9Orp3AZtN0oyzlaU4Jy5Fm2F?=
 =?us-ascii?Q?8d+7cN8WcKVc0TtQw36ESn3dAI0nloRI1C6lnz8Zvkc1qFDWlfScq3+ck1fi?=
 =?us-ascii?Q?oK/GXYfQsCEPtR3a3Ol9U8MypQhxmm16+zdHJ2solE2UMgeKbAdpOh8F+tZx?=
 =?us-ascii?Q?UqRfFiM0RkO3HHcfOUsV8rZgddPdaGtOsuDerGody/rfHdIY9PltbCN2m7Iz?=
 =?us-ascii?Q?69EZ+5vAezUPMOvGECXT5X3/NDlbH7OogyDfXFnuvPzYn/LP8Vf1043xsjey?=
 =?us-ascii?Q?hcioRndMQUHHQq4XIYU5kF02fF/XWmkCgKHRxFCwOlPSalzKf2Dq5xVqjvcr?=
 =?us-ascii?Q?7YTSeWD9thVBU8eoSFbwi5x3JV40DmmqnXgOEzcW/RJhQjPiBQeqTllOxEY/?=
 =?us-ascii?Q?Kx3MIvgS2bIxIqL55GrZ4cHexFfL1SS8Q6e6AMLiLbXUfGpIER4X9WYde4dY?=
 =?us-ascii?Q?nU6k6APPXvwcgQ4ilRiOnIqhccoMimG50I97MMlH9pFaL9ir2DE9JgvA2taQ?=
 =?us-ascii?Q?obJt3LJYfClzfcvlHgVHLKwws2s4lXjzkoxrVUsFZkuUue8JEEo4CAUjRDDn?=
 =?us-ascii?Q?yeT7Ch4kCXJc2AvlMz+ob+GHh5vyVjbtfrnFAptS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7370846-d527-4f3c-878c-08dcc00b9a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 04:58:44.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nvuPbEdL/BRKUYX8WQY0zBFuCh6NHoUvlwUUQongh/8PwZcvaQdYKKxq91gGrqSGPBZQs5OBWTVT+/YV1OxncEJb0TbF6qpHNAx9Iz9Miw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR07MB10017
X-Proofpoint-GUID: 9sUD5E52hflpqOhfcxhcNqYI4sxVX8tz
X-Proofpoint-ORIG-GUID: 9sUD5E52hflpqOhfcxhcNqYI4sxVX8tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=973 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190035

Stream endpoint can skip part of TD during next transfer initialization
after beginning stopped during active stream data transfer.
The Set TR Dequeue Pointer command does not clear all internal
transfer-related variables that position stream endpoint on transfer ring.

USB Controller stores all endpoint state information within RsvdO fields
inside endpoint context structure. For stream endpoints, all relevant
information regarding particular StreamID is stored within corresponding
Stream Endpoint context.
Whenever driver wants to stop stream endpoint traffic, it invokes
Stop Endpoint command which forces the controller to dump all endpoint
state-related variables into RsvdO spaces into endpoint context and stream
endpoint context. Whenever driver wants to reinitialize endpoint starting
point on Transfer Ring, it uses the Set TR Dequeue Pointer command
to update dequeue pointer for particular stream in Stream Endpoint
Context. When stream endpoint is forced to stop active transfer in the
middle of TD, it dumps an information about TRB bytes left in RsvdO fields
in Stream Endpoint Context which will be used in next transfer
initialization to designate starting point for XDMA. This field is not
cleared during Set TR Dequeue Pointer command which causes XDMA to skip
over transfer ring and leads to data loss on stream pipe.

Patch fixes this by clearing out all RsvdO fields before initializing new
transfer via that StreamID.

Field Rsvd0 is reserved field, so patch should not have impact for other
xHCI controllers.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/host/xhci-ring.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..7fc1c4efcae2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1385,7 +1385,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd =
*xhci, int slot_id,
 		if (ep->ep_state & EP_HAS_STREAMS) {
 			struct xhci_stream_ctx *ctx =3D
 				&ep->stream_info->stream_ctx_array[stream_id];
+			u32 edtl;
+
 			deq =3D le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+			edtl =3D EVENT_TRB_LEN(le32_to_cpu(ctx->reserved[1]));
+
+			/*
+			 * Existing Cadence xHCI controllers store some endpoint state informat=
ion
+			 * within Rsvd0 fields of Stream Endpoint context. This field is not
+			 * cleared during Set TR Dequeue Pointer command which causes XDMA to s=
kip
+			 * over transfer ring and leads to data loss on stream pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			ctx->reserved[1] =3D 0;
+			ctx->reserved[0] =3D cpu_to_le32(edtl);
 		} else {
 			deq =3D le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
--=20
2.43.0


