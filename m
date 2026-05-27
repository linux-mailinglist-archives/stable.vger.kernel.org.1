Return-Path: <stable+bounces-254487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDtVASd/Fmq7mwcAu9opvQ
	(envelope-from <stable+bounces-254487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:20:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AAF5DF64D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9461E3038F41
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BA2BE621;
	Wed, 27 May 2026 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NRxajEdr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1B48CFC;
	Wed, 27 May 2026 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859231; cv=fail; b=sokT/RE4rpCoMe88jdLjbUgUg4cY2RZ3iEVfrrZK+pMpy+lJEB+SPigdeogaJcgSQC9LSmVoJvDc996OscBVHUaclJC6qrQ5QRmGuHoXvFaw5qCmYxzrjXep4y2d02ohVVC7ZHnbEHHK/N+bJ5X+UOGd1cNdDGPanqOP1CK435o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859231; c=relaxed/simple;
	bh=1nfZDKKFjidgmfB1Hw8f6nJLgTPAZ2KH6zZEjYjeJwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=baK4I4pmDVvh+isww/sw5GlvwZlm8L+Kb8MbTUZM/SVutsbsfbDMQicRb5YbXkqKHinalBpK77na+vq54Z9f/ShgwA2H6IhM/VbJGzHvUdcCxu8+KAi0dO4YvYAEEgva8Zoni6K1ITGpoYbthgXC0E1Ug0SE1lt10k6KAGdp0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NRxajEdr; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QNRXlC1192056;
	Tue, 26 May 2026 22:20:16 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020098.outbound.protection.outlook.com [52.101.61.98])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4edd8njae4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 22:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0+SEfF+YuiDrj4uiNOhojhjQOi55qsMW9BBIp7gw6aE+wS5divpZu1JSz02iBAsXINJ08QPbIneogHc6gC5QPi8cMcIqMEh4fH4j3zYMRaXnT6UQmQdvHnwyfMGmB06mAOpbVoB3QAe4b0TVqZxTBxm6ANBBOD9JvkF+RKDqPUk1mECUIqla3WRKUrfruWAAPN+YzTjch+Q8PCMa74LsVJGmigCXjn1THLsZ5r5SejpU7RZndUpgPczFh1zlQXeQE56u60IlBRd5BslqdI0LDFWTnt3K+z7FgPQ7QpfZupeW253H7OB2YIH4bVyWZ4PMZyz3intQu0LOy6qH8GGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nfZDKKFjidgmfB1Hw8f6nJLgTPAZ2KH6zZEjYjeJwU=;
 b=n04jO5RUEUA2e3DcJCMUvhT2TvwP8MROQeKb4L5dbnUmbTxOaS47uTIJWxSz8AcBBMkd1gnZUjy5AFEffE9D2c2Bxa1SSNlbkX68yW9IEx2WJoAlPjxlpMzRQcGFGlnPvR/G7VC2O498445dwR8k2aCn2YuO77wMfqSFStdahU6QyjJY6PdYz3UhLmdNNwTBqSANp9SywB8O6ZEVDKxQ0M492me6VXHcOeNUgR0/bO13ubBplZNUu+pLE1fP8U8XOLewLQw9WzZWYj/ZC0YtmvU7EsfB0OH5UPgr8E6Y9bFHCKkyT1O28Z8XMkfn5iHd7mmHOb8uK3GrwtM1gM7WiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nfZDKKFjidgmfB1Hw8f6nJLgTPAZ2KH6zZEjYjeJwU=;
 b=NRxajEdrEdw1kPOnyVnDTFbNNVcZK1ozbiA3SdweInxA1qpdTORefmag+4qAlSfP8ks0wJdd/Jv3NJyHv7fc9Ln/qiTTtKK8Z2Z/0KydZ07dL6ZjlL/NhCteIY4vC7OyWExnLJvYmgR49raRFCop5u4KvYug775JrQqIsDkBAGU=
Received: from BL1PR18MB4342.namprd18.prod.outlook.com (2603:10b6:208:31e::16)
 by CO6PR18MB3809.namprd18.prod.outlook.com (2603:10b6:5:340::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 05:20:13 +0000
Received: from BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::5ee1:7005:c7e8:9665]) by BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::5ee1:7005:c7e8:9665%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 05:20:13 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
CC: Junrui Luo <moonafterrain@outlook.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Topic: [EXTERNAL] Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Index: AQHc7XSGt9cVlP9I10KXQeDr14yRUrYhGnEAgAABkwCAADTF0A==
Date: Wed, 27 May 2026 05:20:12 +0000
Message-ID:
 <BL1PR18MB4342FD927BAF986D33299F74CD082@BL1PR18MB4342.namprd18.prod.outlook.com>
References:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20260526180233.4323832d@kernel.org>
	<CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
 <20260526185224.0c65e38a@kernel.org>
In-Reply-To: <20260526185224.0c65e38a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4342:EE_|CO6PR18MB3809:EE_
x-ms-office365-filtering-correlation-id: 955b5679-c356-4a24-1f84-08debbafa11d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 AhQ2gJ9EN8UuNXzzhGxkOSqnuGMOxOyVoVjZsjqvWXUMbk1MkEL59SKWeOq0dbkyWwG4c27LP2xsMwwzTlSdusC9PTO7biM15Yt+hcH2n5t7zQIiPNIrT4rD8WETrSdO2/fdgF8VmUgiLduzHKInsrQ3oRAgP0Q6rpWNXkrePrM/mlSPbYovZCL5VkWN9ZFArmYGa9JLQH1Jhci25lHRDgUyeDqmmkELZmXUVEdWlCYHhtMw/+gDB73Qi/DZSR3yQCer/e1lcZ+C/2BcXfgrsk8ZYSS3te6aDo9G/vEcIVbYZY/cIFenigrAPSKMhbnWrumkGOmrq3jPdR7vsA78buxbYlVwVH0E+AI2H5cUSie+A2VBJQJU2pWX76tSRd+Kozcjgr6v5oN2dPvNNNXu7jstzxPTDegvk9Z1exbp/e5KJtNz5wp4Ag+9jWJ79Qa8Im9HX9eYv6ilVLOoF/Wx4IcvPAHqkjp6efxoMsmcRvXETf4fJjn1bzXaAAlzY4UOHKqhezMavRmTph0jCoxTj5vftxw9u8xuxffDzbeOiAnf6d6Pe//rUcGzM6rDg0UkeeMeYKmXCIpfJLwyblZREJduPdJhhSs3LSqJVhLxXqKQh/xyJDizWYM2roBytsJjSEEmH+Z++ZcvtH5zAfHDdGYDtbhvngjh9+LMBkf/A5zE/m0+O2uSemvfSlPe7rNr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4342.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUVKQlpQbUxsdW5QMExqT1N3RFV5WG5xbi9yeHVGK0JpMEpyQzBVekIyZWJh?=
 =?utf-8?B?Y0dTdURENUxNaW5vVWNseS9ycFEyMTR3SC81aXNoU2RBdlZGRmpVYmYrcEtW?=
 =?utf-8?B?VmZaNTFoZGtLZ1lneVYvcVZOUUdNVkJWaXhGRVY5VUdib09Zb3l3TFFUempt?=
 =?utf-8?B?dnMwREZ5K2V0WldJUDZlWnhzbjlRWTNSSHIvbDhSeVFiQ3ZQdzNxeUJvZDRW?=
 =?utf-8?B?RFlPYjRYeVgyeVdwV2crU2RXWEo3WkV4SUdha1hMdVQ4clVENFVld3JKdDh3?=
 =?utf-8?B?ckNCNnQ0cjIrUGJCRXVTTWhYa3A3cEZpMkFlV0tuVzFOcGdPYVBoT3BNem1k?=
 =?utf-8?B?MDlHdjNJU0VYNGpERGJ3bi9kNU9ZUVhnczJTL1N0OFd2R1lwWTlXRFFsNDkx?=
 =?utf-8?B?SWhrU1VCdUZUc3pST1FqQWxPSFBXWTRUVXc5c2plUmJ4aXpwbm8yYzl4cXl4?=
 =?utf-8?B?M2p2b0Y5ajdVRXErQUpSMXlWY3dkTFFQcVFNNkREMFlNVkFZaThVQVlkeUNt?=
 =?utf-8?B?SHJyMnJqWGJIOEZ1dktQNHNLMkFyVlp2b0tRVzBpdXlCSGNhaW0vOUxwajlU?=
 =?utf-8?B?SXhyTjgwS2VIL0ZreFZ5cWVYZ2JJRTFDVlhESmorU3Q1NEZQTHBXR1J5MUZF?=
 =?utf-8?B?dHo1WXVoUVR0R0g3VGhLK3Z5SkJuZnBxcXd6YTVVSzVQK2ExLzFWd0o0V1hY?=
 =?utf-8?B?Z1QrRlUwQ3RYS2VMeURGMTZvTmRrcytqVHp6U2hXbzBxY2IvWEFrU3dkdXo1?=
 =?utf-8?B?bmVvVVpjY2swckphRTNoQnRRRUpySjVPUXk5Mzg5MnpiVFpQcmFHajQrelM3?=
 =?utf-8?B?NXdnbnpuRmg0WkdVdlpML3pPNGZDMnVFT29LT0V0WXhkb2FXY2FuUFJkdDRV?=
 =?utf-8?B?ZnRKQjVLZEdTbkpOaTM5R05NbXdlZnJGMjZFQldzR1JVNkVGZHd6ckM2a3Bn?=
 =?utf-8?B?OWltOG11VjhLak5INkQwT05wblhGVnphbDNUa2xILzlwQkJnZ1BUU3ByWVJV?=
 =?utf-8?B?Y2RQelhtdmpDSWZsRkxZdTk3S0RGN0J4UGxpZlpVTHE0ai9pcW4wZFR2QzI3?=
 =?utf-8?B?cjBBSVdSaUtwMGRCZ1o3SUc2cTlxSFZQNEJUSzh0NE1VZThGS0d1cUlEYzJB?=
 =?utf-8?B?VEgxcnBkVkVKMzE5REhZaDNOMXE1NXNwZ1BFL1lGbzNabjYyQkVLN0paemdk?=
 =?utf-8?B?SVJXTmV4dHdFWWpxVlpoVEllcXZlckprdVFMbEFSbEMwRVZ2UjVVdHR3VEFx?=
 =?utf-8?B?VW1xOVczeHMxWU41R1dia1JTSllCRlUzRDRMM0NRSUZBZ0ZycGNvWXlQV3M1?=
 =?utf-8?B?SGVpd2Y1Vzl0NHA0S0IxVjBwdUtWdlF6RHdKOE9GZjU2OU1ScmpLQW9ZMXlC?=
 =?utf-8?B?M29wbDhSb3lpS0tXbEFkbXI5bEpBVWNWckR5NXM0VWJ2UXFVQzM0NERSV0Vw?=
 =?utf-8?B?U3FWRlNzNm5VclVwcm96dlNhaWpUNVZjMEJkS1NCWVg2SGU3enE2TUZydksr?=
 =?utf-8?B?QXJsNjY5OE12bUNLUVRLem0wZ1plNURPWC9sc1JZZHdneWJxaTJIMDZWdWtx?=
 =?utf-8?B?dGJoUFFDUjh1R3N0K2tOcXVOTVlQbzFXbE5QUWVLbEdmVUhNV2hVWDVKTnNQ?=
 =?utf-8?B?UllSODFKRjBidTRPNi9UVFl4VGIzUlJhMno1R3dBZzRsWVJuZFFlRmlid1Ry?=
 =?utf-8?B?Ui8xNDZOWG8yMDhtYUhucVJ5dVNLZFlNSUdsMmswUE9wY2hhaHFjdDFCTE9U?=
 =?utf-8?B?b0FRLzhDek9Dem8zNHBFYmQvVWlXb252WEVzYUVLVFJkZXdsUng2b3hGWm51?=
 =?utf-8?B?WXJhTFN5TGcyNU9DTlJwWEluNllhcnE3RnBmYWVYNWNVTXdsaXZrMldrYk1J?=
 =?utf-8?B?dkhyNGwxRW0yZFNiVGE4UHZ2cittMkJUTUhkU1Fwd09idDJuaU5pa09nelY5?=
 =?utf-8?B?K2syYTZuNm10QmdLV3IwbHJnOHc4MDlIeXhHaFZiSzdzNTB4b0M3bEo3ZGp2?=
 =?utf-8?B?d2VzSlRHOURnMVR4ZlRUSnFrWUVteDhyUDVSOGZxMEE1ZUxrZHhpNU1JZ2VV?=
 =?utf-8?B?Mys5QnVDdXV5YU1tM3VjOWdiZU9KdTdaVnByVWR3RDZkeklzeXB2QU84dVdo?=
 =?utf-8?B?SjIzcTVMTzJYS3RwWkdjc2lkSDZiOXdIdDU2NHU3Ny9aeHpJbmhnZ1Ewa3dl?=
 =?utf-8?B?YW1oVGN3OE9Nb3lrSm1LRWpUeGVLNnRwZGhIOGduZnlTcTFBVTVCdEczelJL?=
 =?utf-8?B?NEI3dml5MFhmYWdTMk9Va3UyTXQrVnpRak5uOVM0VWdEVEVEQnNuajJ1N053?=
 =?utf-8?Q?lQ0oAbtxvsr7rnkktx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kzjbWgiOqiZtA0ofcRSEIe3HPuCpZQ1pYC9xBX2vGerE9sXJxj1khNSAEVaY6I9xR8gXPm2IQD5w8k+MSjnfct/gTb+VfEwqRK87YqHKuI46JMHhhC0hJ/vCOYvRxJjVBaEbDtHspU/uoFozPJaU9b2353NPVHRS4qLj50VsIGigXw/Qaf4WZgVZzXS5Jo2rAXc+TW4kjVsxOotMaBsS961jBqMJxptljIsxMvC0+WywB4ebc0ergfmMclVV+yo15qlvqZE88lNzNBECeK53YogC1Fk3Xis4AkZ8173fnjC9xF7oizLPdEJaJcPE1Mi5t2lzaYpUBIhqO38f6sC+qA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4342.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b5679-c356-4a24-1f84-08debbafa11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 05:20:12.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHKX5NCVGS4pCm1anG0AJ0VmQ72bLhWxqhRLu8X4S/U/Tch4DTabfJaviSHskCFBD/OgYx9XRIhqvJ7RY+EhDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3809
X-Proofpoint-GUID: Ujd9uT55K3BCtNUkYkxSk_N8v4Vv_aBx
X-Authority-Analysis: v=2.4 cv=VZrH+lp9 c=1 sm=1 tr=0 ts=6a167f0f cx=c_pps
 a=Qm58cps4sUx16Q1OvPHhHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=tdwxMs9UAAAA:8
 a=9s4xohBGFrDdDRZ9ch4A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=n1ztNQlqc1GfrQYO-KzL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA0OSBTYWx0ZWRfXzohib9I2W8YZ
 a7o8EmHoS2rF/yeN+tuIhRy7Zso3pYF1Ob3kl92yWnti9RgeYoFDpWqNJiKQTUZv7J8zpiyqzNN
 Ch/5/UqwKD3bBvXoCJ+e3+Z2f1022Q73KmjLqclzJmrb3cvHmpCrqop/Gt4rwK06suDyXdveJIj
 s6INLJI/+UO6CPnAGYAHLTjGpVulyBUZFWpCoO51FvfkXe9tYQ7gbCCcaSmzpyAgLGZyik0PiV5
 OGLVVQiV0+xF4lHqVmeRQRI0J2FxQf5C1HFvjEBRb1xfw+GNefsaNuSyggh8xe4sOOzqSY1K3hV
 MPlZbwU9PHPEBCJc22V/w/rHhRQVCj5t/+cHylNS5VbtLuoX+FotANn5iNCgVxhX4NxMpRPKgzq
 BDYTrXcJxIx5HFnPSl2cXGnH3m0ZnHIAHhDnCwt6V7MKVsMwhZuR8Uu6E3jzuiqUDm0bFUMgk2M
 3wpHS/1c8lOeTh7OkMA==
X-Proofpoint-ORIG-GUID: Ujd9uT55K3BCtNUkYkxSk_N8v4Vv_aBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[outlook.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254487-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 93AAF5DF64D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+U2VudDogV2VkbmVzZGF5LCBNYXkgMjcsIDIwMjYgNzoyMiBBTQ0K
PlRvOiBZdWhhbyBKaWFuZyA8ZGFuaXNqaWFuZ0BnbWFpbC5jb20+DQo+Q2M6IEp1bnJ1aSBMdW8g
PG1vb25hZnRlcnJhaW5Ab3V0bG9vay5jb20+OyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj48c2dv
dXRoYW1AbWFydmVsbC5jb20+OyBMaW51IENoZXJpYW4gPGxjaGVyaWFuQG1hcnZlbGwuY29tPjsN
Cj5HZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgSGFyaXByYXNhZCBL
ZWxhbQ0KPjxoa2VsYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNi
aGF0dGFAbWFydmVsbC5jb20+Ow0KPkFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+
OyBEYXZpZCBTLiBNaWxsZXINCj48ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvDQo+QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsg
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBu
ZXRdIG9jdGVvbnR4Mi1hZjogY24xMGs6IHJlc3RyaWN0IExNVExJTkUNCj5zaGFyaW5nIHRvIHNh
bWUgUEYNCj5PbiBUdWUsIDI2IE1heSAyMDI2IDIwOjQ2OjQ2IC0wNTAwIFl1aGFvIEppYW5nIHdy
b3RlOg0KPj4gSGkgSmFrdWIsDQo+Pg0KPj4gSSB3b3JrZWQgd2l0aCBKdW5ydWkgb24gZGlzY292
ZXJpbmcgdGhpcyBidWcgYW5kIHByZXBhcmluZyB0aGUgcGF0Y2guDQo+PiBJIGZvdW5kIHRoZSBi
dWcgYW5kIHJlcG9ydGVkIGl0IHRvIEp1bnJ1aSwgYW5kIGhlIGhlbHBlZCB3cml0ZSB0aGUNCj4+
IHBhdGNoLiBUaGVyZSBtYXkgYmUgc29tZSBvdmVybGFwIHdpdGggb3RoZXIgd29yay4NCj4NCj5Q
bGVhc2UgZG9uJ3QgdG9wIHBvc3Qgb24gdGhlIGxpc3QuDQo+DQo+SnVucnVpLCBwbGVhc2UgZGVz
Y3JpYmUgeW91ciBkaXNjb3ZlcnkgcHJvY2Vzcy4NCj4NCj4+IE9uIFR1ZSwgTWF5IDI2LCAyMDI2
IGF0IDg6MDLigK9QTSBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiB3cm90ZToNCj4+
ID4NCj4+ID4gT24gU3VuLCAyNCBNYXkgMjAyNiAxNToyOToyOSArMDgwMCBKdW5ydWkgTHVvIHdy
b3RlOg0KPj4gPiA+IFJlcG9ydGVkLWJ5OiBZdWhhbyBKaWFuZyA8ZGFuaXNqaWFuZ0BnbWFpbC5j
b20+DQo+PiA+DQo+PiA+IFJlYWxseT8gSSB0aG91Z2h0IEkgc2F3IHRoaXMgcmVwb3J0ZWQgaW4g
U2FzaGlrby4uDQo+PiA+DQo+PiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92
Mi91cmw/dT1odHRwcy0zQV9fbmV0ZGV2LTJEYWkuYm90DQo+PiA+IHMubGludXguZGV2X3Nhc2hp
a29fLTIzX3BhdGNoc2V0XzIwMjYwNTIwMTU0MTU3LjE0MzkzMTktMkQxLQ0KPjJEbWljaGFlDQo+
PiA+IGwuYm9tbWFyaXRvLQ0KPjQwZ21haWwuY29tJmQ9RHdJRmFRJmM9bktqV2VjMmI2UjBtT3lQ
YXo3eHRmUSZyPVVpRXRfblVlDQo+PiA+DQo+WUZjdHU3SlZMWFZsWERoVG1xX0VBZm9vYVpFWUlu
Zkd1RVEmbT1FU3lXVXVDN2NPaFZSbW9iUGtDYTJ3WnANCj5VSmlsMUcNCj4+ID4ga21fZUpxcC1p
Qnp4MnNvY3pTY0psVXVwRHN0b0l6dFVJbyZzPUo4cDczYm9JZG5ua1ktDQo+dHpoRVhNWFhFNlcw
cXA1c0MNCj4+ID4gSEFaRlEwRmpFdWdFJmU9DQo+PiA+DQo+PiA+IEVpdGhlciB3YXksIE1hcnZl
bGwgZm9sa3MgLSBwbGVhc2UgcmV2aWV3Lg0KDQpIaSBKdW5ydWkgYW5kIEpha3ViLA0KDQpUaGlz
IHBhdGNoIGVuZm9yY2VzIHRoYXQgdGhlIHJlcXVlc3RlcuKAmXMgcGNpZnVuYyBhbmQgcmVxLT5i
YXNlX3BjaWZ1bmMgYmVsb25nIHRvIHRoZSBzYW1lIFBGLg0KSG93ZXZlciwgdGhpcyBhc3N1bXB0
aW9uIGlzIG5vdCBhbHdheXMgdmFsaWQuDQpXZSBoYXZlIHZhbGlkIHVzZSBjYXNlcyB3aGVyZSBM
TVRTVCBsaW5lcyBhcmUgaW50ZW50aW9uYWxseSBzaGFyZWQgYWNyb3NzIG11bHRpcGxlIFBGcy4g
SW4gc3VjaCBzY2VuYXJpb3MsIA0KdGhlIGJhc2VfcGNpZnVuYyBtYXkgbGVnaXRpbWF0ZWx5IGJl
bG9uZyB0byBhIGRpZmZlcmVudCBQRiwgYW5kIHJlc3RyaWN0aW5nIGFjY2VzcyB0byB0aGUgc2Ft
ZSBQRiB3b3VsZCANCmJyZWFrIHRoZXNlIGV4aXN0aW5nIHVzZSBjYXNlcy4NCiAgDQo=

