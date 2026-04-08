Return-Path: <stable+bounces-233943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP+MOmOD1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B873BEDF5
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4808B301E6D2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBE1448E0;
	Wed,  8 Apr 2026 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="P6nz9ni4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23539EF22;
	Wed,  8 Apr 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665920; cv=fail; b=CvwWVaQvmVyzAjP9/J0ZebmBDqHe+lFsWAjfGubjZN//73gh9csGq74re12gd/bkSaS+BA4Z58i9A9M1c2BE4taGk7o1XWB/Pmfm3I8nn6AftyLwSKnq9pBVNxIoo0OWkzS2PnOLWdNHTg1haOAXsNuAnfvg9Y+K6nCeAFaoOD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665920; c=relaxed/simple;
	bh=3n/C9FGHYEyzOu92vqv9fd5xWyhnRn05dO0HH3Pgnxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGirOt8M8Ou0OK1tQ6cGw0fd5U2dl/uauBwDyHfBSzqNWJjxUHq8TDyvWMSYNHycZqpLIZUwQrkYPfg2Ilpr1XRqeAEeVzUNHPcqPFfNec75fzHkFtoT3CTxPFnPyGhEbumBqMJCQuXYxwS8cLcexLgFC81d3RCk497nUDYU2ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=P6nz9ni4; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Dtvwk1224631;
	Wed, 8 Apr 2026 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=qo
	6xKbvtqLI2i6ruNRHXNC6J0gsCGk/R9bSrhKJX3u0=; b=P6nz9ni4bICnbh3iRJ
	E5i6CnaAAp/7qTdjUNguhcKpWHHBleD/n0ulzPR2kiy61M66umdh4rF1HLwgq9E/
	MP1RKunq6SRPjXzMze6/e5vIj3m487fM0IaevoHBMa7nnfNrfJ1E9G80o8UpvKiO
	MTdJkaqJYIrzbrUMZmSkSovRpv7jIyzI7xzPwRVB4Dqc+yuaadi+UAHI/eiL31oz
	gRpfcey1t0Y9zgsgvtRog9eTIpMgMyQP5e5VbSqY+L2qSoyLoQWnoO+sNl4e6laa
	+a9tGTd5DwyYLd4+MpfbG6CRCzSk1f2b1gJadRCOvkBShrt2+NZX71qyBv3n7bKB
	DHUA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddrb6t1jm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 16:31:38 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 65D6C2BAEE;
	Wed,  8 Apr 2026 16:31:37 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:31 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 8 Apr 2026 04:31:31 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 04:31:31 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGxbp34sxSZ6pcfuPHMKIGTZIQao9wBVth5CtomQ8KobrE7mu2+ElzbpjQ71LG2in38O049gw2muxx9gKQKAlQsXook7QrPd/TU9qIvh8jwx2/hUayl4YlBrswQadR+7Cii10qbSJJdZ7le4l59YPH1dEjy/FzyupM8/a6Rbc+yIDWqmb9LQTSP1uHEcGc+oaKqTejTO71pfl6H66BwbV1aP/L0EWhSOgchdF64J8CUnem1HEVY407RR90Scvwsk9WhG2mPXryCZSovSj54o0xXSnkL2A8KjMiCNzhNMkQzbELZi43jj9X9FkD04RPtoZFcpYRViGPr2k4e/a2HTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo6xKbvtqLI2i6ruNRHXNC6J0gsCGk/R9bSrhKJX3u0=;
 b=AOQNP0SMwPbhKDToMCRMhJ1IFwqZXy9E4P8edtSyt9s8LsCOqp+fzphpY53CwYbM0ZhVuytphzC3PHCy9R7JFI7sMsQomFCxl4cqi2X1bqbtJT5uKNj7tPfRgSl2H/WaQatoml6WODanuqS2gaPPiFTCxEpB60wSsB6I0nMPx//nPFIDg+vVcIbP9c2R8N8WEHpoLE9KvPpBlh0yUNewmmdeqI/xlpKGVICCxDJd+EYXL8N6CotABg6Ld7DKMoQA/RsIsp9+0Xv/c0Cs84XvjZJYa395P0rtKj7Lm3gtL5L8t/ccMDpLl3qnOTXwjH+aM1eqaGoz8lONMjsLK0g16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3528.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:218::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:31:29 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 16:31:29 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 3/3] hwmon: (powerz) Fix use-after-free and signal handling
 on USB disconnect
Thread-Topic: [PATCH v3 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Index: AQHcx3UnU57j69vQ5Ue3LSgtWHKflw==
Date: Wed, 8 Apr 2026 16:31:29 +0000
Message-ID: <20260408163029.353777-4-sanman.pradhan@hpe.com>
References: <20260408163029.353777-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260408163029.353777-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3528:EE_
x-ms-office365-filtering-correlation-id: dba92dd8-50b4-44bd-a278-08de958c4996
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: g+NpqxGlScsCXlztUr2wPfPQ5wy8mdq5JK20SR7DFN2yORrd7BNLzrW+SUM/biPTY6nAbvpPKvUscqbv0tKnJ8hfXQT3dKLn7h++NneD37PkyXDtynRvXR93X1mSA3j2jdtZj/YEBhldxqarhvP1FMIatx3xr7gvfzNF0KyBZJ+QkHbghbvOoUXOHZvIJqFfFGhfZpE2tifY50qZv+xvOqMJbCk23MUuTd4BwHiwhFKeIFcbzcmuLe0NgOYoMepKjm6kKaZDhcjiMXUltL+d1rffg4+TLFKBfyLi9sDzCr9tyD9Z3lS+2hHMpFug50KMzX9tH41tc/gFbw2fP65x3FS1vwYPh7ruH9McL4c5eYx0C+rStoPuO4YfxFQUugMv2pru0jr9cRBSs+dOuRt2dO+lwdEupC8r+clFqnlAkGQouUMexxyZlLoxhsFL543uuRIyMSax9u/6kBHmcp82H5yRYFKKRc5/uQZ0RSGkf14l4p3LJnc3iNIEAh0+x8fd2KOBSpoiAJ6sBiKGupr5vg7fidGY1ClzFg7LoGjNR09PKkDvh+DYaQQK13JqAbeCkIOTFy+1qX+KHKlsmwtWxvHyG40L7BA3TdvGkJJmOCkXh/z+7bKo+ptDdxFUj3c8AEtrkJRSBnhlBRFwlEmkBkbh/UnW7UHRmHc4yaNjAmrGI49YnC8D198Ya3n+e8CqA/OGvgLZFl+i0lQ9blWKH3p1IWK+EK2x+zfHjhN7JmHNP/FLIKNPXtKYb5LWQ2CB6kiugx9umsLatpKim3SStNJ19Qs4Y5/daYwxjzkEBrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nrx0ySBqsAZVHoBVYLe8AeUhwRujRCuztazVt1TNYG9HP1txPSsUq0jKjj?=
 =?iso-8859-1?Q?me2ccjaC2b+KL7c9e8TOzWG2JYk3Fq2htKx16/URlbVIwTh9Bie/Z5M3W+?=
 =?iso-8859-1?Q?FEcM/L5GhKl2gTztVIs5fAbC6DYSkgTlxXa9TKg7WTTJSxL7XRSKiRp3Ag?=
 =?iso-8859-1?Q?iEzeLLYREOT7HssjMvIEf+kBaIDL4hgiSKpuGyfbbwDmAzosQTMD72fMg2?=
 =?iso-8859-1?Q?+RPxhg5fMfXCgpx0Pb6wl7eFS6BUUCSlxLsIZg1/gGSxlyZvvIn9Nhn9W4?=
 =?iso-8859-1?Q?FGx+LL8o7IwAQWO+4rlGVKnEQvskSLDGKNCziFFOOjkZv6roFuYyPB3He8?=
 =?iso-8859-1?Q?y9dlRwfFwFuiel30SRabIPhXwLtk4f2Ppavl6bXeNhw8GeCJ4DeMOybYzq?=
 =?iso-8859-1?Q?Ulk+ryB9oxXJ4m4CUVL7rA6FDKLGrkmiP0Nd38p9NT00kVs1WtBefPoQR1?=
 =?iso-8859-1?Q?mXDcbD3hEbLyUD6mPWIZR03phpc+JinXNT14C0zakrcBwtAu9s13qy1n4l?=
 =?iso-8859-1?Q?z9qqsHRoVy7+UKVj8hjIX/1ta7PthILInWG15vtYl2C+CZjbkASjKVhhbf?=
 =?iso-8859-1?Q?wAokgck7VYnjr/J25KG2pCHbNmvO4qsa2QmgYO7Fy8tgK3aFG1O2ySp5hI?=
 =?iso-8859-1?Q?STEWl2C1I9dMMt1dLRdy5r04W4keRKsNgmvuSc9SCir13ocp/GBzzqOrGC?=
 =?iso-8859-1?Q?r7DG15fIyY0MzG+Uo9786VsmqUj1lxUid3u6mOBtRmC4rWhFMFyOriqAou?=
 =?iso-8859-1?Q?i1anjag2Nmw3A9QCqvCF3pPwL0ydNm7pbTtfQ60sMJDolIzRh7Kwl4OX93?=
 =?iso-8859-1?Q?iKewqTzlJk1UL/c4N8e7uPlBwhVLGRQpxS9FZeP5rmdJnm7QVGeDa4jR4n?=
 =?iso-8859-1?Q?EALjuLPOO+fSItzVpQo90u1zg+4DRMw6pbG0Cn7bzgL3FRw4cpv3lCmefe?=
 =?iso-8859-1?Q?G2rtCV0pqcEOeFjN5E7VYU16ylJWOvRvblCQPEujteyEhJgOiIg5ApEveY?=
 =?iso-8859-1?Q?eiwzDzcR2O1lrvcuFwzg3Ti9XGqA89035BbKGljC3b9AXqndS/vQn0wjvc?=
 =?iso-8859-1?Q?hm8Fx4vJd6SZgr0QKJAsWqNXlyilRzHrOSMR1/agZzfkydEBhiyTyHe66H?=
 =?iso-8859-1?Q?wfP7aOm0kp7mbUqKK0sEasx7uxZFeUC6XDSoAXbnAwdEBIxOxaHuLYnriY?=
 =?iso-8859-1?Q?UDjtzjfHznFbDYLOCv61Ir9JaBitfsVneJGTZbBN8SbicCPvUUAF7Rr8MJ?=
 =?iso-8859-1?Q?xiT64I/hVd/2mB8HU/5xO3G6EqXcvAidvEqBy+UFsQnoqwxSvriG1spDzj?=
 =?iso-8859-1?Q?xoiPzaYdG21rpUWQ7tBc5IYmrY0BU2bEhe6RJ4mPqB1x12uuxBptVs8U3y?=
 =?iso-8859-1?Q?s3tyBgjWfWKogCdvVa3sEDLfRskIIWcyd7/wjcX0I355fIK3mQszK0aJu+?=
 =?iso-8859-1?Q?s0dmzCS+Paf0WixFFqH3wL8pvgtE1erBpHKzPX9hYDAkcQXoECkDYP2khS?=
 =?iso-8859-1?Q?Fq36BLbFWzzAl/NMohLIPp7ppd2+bjPmY9RpJcEsVeH3b6PY7UqAmjlWW3?=
 =?iso-8859-1?Q?kYkBFSDstH134yhqtM6I/l5fYQ2iUktzbtsDbaJY27kWgIFX+Cjk7a/bMM?=
 =?iso-8859-1?Q?gCLKN/aPJ1aYJedEsMNs2728aPYCRNiTdSOhEZrGlJ3RP+rzB1yGH218zW?=
 =?iso-8859-1?Q?tmiFN8++bjaUVW7uHQ2ep7hgx2z3zCiQlQQ52ocMEYSC3yteGNyDz2Jncm?=
 =?iso-8859-1?Q?qgZFqXH1YSomw438pF2RAyNu6lM+bqQBPDpHE2XX/FTeesMwyUYSCUFBSa?=
 =?iso-8859-1?Q?fdL+8x3fmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mQTLqJzgxDPf464EsaEEISyCD5DVECSXLrJLc2/yh2FDi5ZLrL3+YJp+Ov/R5L7Ch5QtTxMXkq9o2kKRRCcinJQVMKqzQyoEBSIHWWiNtE9PXfJlYQRbGSpSKfBe2aDrBE16vH6IqSiRpFbx4YnJnHEnn/NVIUL7mEPapg0zemOjcXqr+p9ArnQ/4OUoRvqwlx0SJ4KqKFMxW9v35So3uJiFnOoXaVoozZpufDC7kGU11qjW+SwGJbUwN2g3pXxmt19vyaRURLENp/XyxhELSWdgNcfyoobt4I9T0skdyv+eD3Xs3SzA1Q/25dhOVGhN4d1bW3DxW0MXYt+StSYTGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dba92dd8-50b4-44bd-a278-08de958c4996
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 16:31:29.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFalrsRubcrQ7k2L8V2L/l77PDKolr1Nt/ZWZlh7ADJcCsb539Y7DFo2MkqL/CHAUEkimC6NYZd6V7GBTwMwjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3528
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=UMLt2ify c=1 sm=1 tr=0 ts=69d682eb cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=BpGXxSgqvIGdrXJJSgAA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 6g6qkVVLouPVTmwHUHubS4IXTntlQEYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1MyBTYWx0ZWRfXxNliPQbWV5DR
 UTmfvhK/9nAkVgtzGQzlhWqT47zrUvqAoGXNDz/4GAs+tUgcD/OIKdoxAYpZ7f8j1xoRc5zRnzY
 MIy1SfLbGU0h1VnqKToGZkrwmfKeb8hltS23uheMfjrYs3nW9Dpb5qW4qhovzyCEWce1xiMe2hp
 fGIAReInxjS8UApl5PNuQdNwD83k/tdPFty3nlNxPeemf9e63w+VvhDD5JC7xqDYFoPIjHx9oXF
 RLABekldXcW1tdLv5lI0as7WJdNUrrEPv51Upfaj+bAGi+4i11wKwTm0nUWL/HOZFaC5AWxL3Oj
 haSVX6y8kMf0j3zOpyuti6GOG8SEVRt7NKTgIGwtcgDntnR+cumGHrratvBULxEU7JgBk9AKN0t
 j+H9c/TxSjqvMFZTTVEh19strYgGeBGuaHPSw/M6iFJUQts7M/ot9+9p8XU0+kKhHCOna2ajH1D
 SBS3NODU+wMuy9h/oMA==
X-Proofpoint-ORIG-GUID: 6g6qkVVLouPVTmwHUHubS4IXTntlQEYE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080153
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
	FREEMAIL_CC(0.00)[roeck-us.net,weissschuh.net,quantatw.com,carsten-spiess.de,vger.kernel.org,gmail.com,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233943-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 75B873BEDF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Fix several issues in the powerz driver related to USB disconnect=0A=
races and signal handling:=0A=
=0A=
1. Use-after-free: When hwmon sysfs attributes are read concurrently=0A=
   with USB disconnect, powerz_read() obtains a pointer to the=0A=
   private data via usb_get_intfdata(), then powerz_disconnect() runs=0A=
   and frees the URB while powerz_read_data() may still reference it.=0A=
   Fix by:=0A=
   - Moving usb_set_intfdata() before hwmon registration so the=0A=
     disconnect handler can always find the priv pointer.=0A=
   - Clearing intfdata before taking the mutex and NULLing the=0A=
     URB pointer in disconnect.=0A=
   - Guarding powerz_read_data() with a !priv->urb check.=0A=
=0A=
2. Signal handling: wait_for_completion_interruptible_timeout()=0A=
   returns -ERESTARTSYS on signal, 0 on timeout, or positive on=0A=
   completion. The original code tests !ret, which only catches=0A=
   timeout. On signal delivery (-ERESTARTSYS), !ret is false so the=0A=
   function skips usb_kill_urb() and falls through, accessing=0A=
   potentially stale URB data. Capture the return value and handle=0A=
   both the signal (negative) and timeout (zero) cases explicitly.=0A=
=0A=
Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v3:=0A=
 - No changes=0A=
v2:=0A=
 - Also fix signal handling in=0A=
   wait_for_completion_interruptible_timeout()=0A=
 - Return -ENODEV instead of -EIO on disconnected device=0A=
=0A=
 drivers/hwmon/powerz.c | 18 +++++++++++++-----=0A=
 1 file changed, 13 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c=0A=
index 4e663d5b4e33..0b38fdf42ddb 100644=0A=
--- a/drivers/hwmon/powerz.c=0A=
+++ b/drivers/hwmon/powerz.c=0A=
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, st=
ruct powerz_priv *priv)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
+	if (!priv->urb)=0A=
+		return -ENODEV;=0A=
+=0A=
 	priv->status =3D -ETIMEDOUT;=0A=
 	reinit_completion(&priv->completion);=0A=
 =0A=
@@ -124,10 +127,11 @@ static int powerz_read_data(struct usb_device *udev, =
struct powerz_priv *priv)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	if (!wait_for_completion_interruptible_timeout=0A=
-	    (&priv->completion, msecs_to_jiffies(5))) {=0A=
+	ret =3D wait_for_completion_interruptible_timeout(&priv->completion,=0A=
+							msecs_to_jiffies(5));=0A=
+	if (ret <=3D 0) {=0A=
 		usb_kill_urb(priv->urb);=0A=
-		return -EIO;=0A=
+		return ret ? ret : -EIO;=0A=
 	}=0A=
 =0A=
 	if (priv->urb->actual_length < sizeof(struct powerz_sensor_data))=0A=
@@ -224,16 +228,17 @@ static int powerz_probe(struct usb_interface *intf,=
=0A=
 	mutex_init(&priv->mutex);=0A=
 	init_completion(&priv->completion);=0A=
 =0A=
+	usb_set_intfdata(intf, priv);=0A=
+=0A=
 	hwmon_dev =3D=0A=
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,=0A=
 						 &powerz_chip_info, NULL);=0A=
 	if (IS_ERR(hwmon_dev)) {=0A=
+		usb_set_intfdata(intf, NULL);=0A=
 		usb_free_urb(priv->urb);=0A=
 		return PTR_ERR(hwmon_dev);=0A=
 	}=0A=
 =0A=
-	usb_set_intfdata(intf, priv);=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -241,9 +246,12 @@ static void powerz_disconnect(struct usb_interface *in=
tf)=0A=
 {=0A=
 	struct powerz_priv *priv =3D usb_get_intfdata(intf);=0A=
 =0A=
+	usb_set_intfdata(intf, NULL);=0A=
+=0A=
 	mutex_lock(&priv->mutex);=0A=
 	usb_kill_urb(priv->urb);=0A=
 	usb_free_urb(priv->urb);=0A=
+	priv->urb =3D NULL;=0A=
 	mutex_unlock(&priv->mutex);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

