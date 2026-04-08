Return-Path: <stable+bounces-233914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cClgLqBd1mmNEggAu9opvQ
	(envelope-from <stable+bounces-233914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41E3BD357
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3190300D448
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103153BC691;
	Wed,  8 Apr 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="U0XRZuUA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735033CEA8
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656210; cv=fail; b=QDWJNTLoiT++DzsOFVRvya1P0ehj9tXDtHWkiywcNVE4aZbCbMrEkeIEERjm4S7OyrRQgX82CTiDs/8UIiYmWoW2fVeu6srNIx6qbUyVJT/KyA6WxIbZz6Od7fkoPeWXt4f+YOY7M2IL21nKydxeLZW5ZHtJ6luxWjkTip1b3tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656210; c=relaxed/simple;
	bh=hY8zuxZwqKmsx5GciQKOsHFR+oOgBRnaQ7UCLMMoTEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8Q5OAEbjWR8oH2e+ovsu6P+ST2lPwDy6JHCGZSxFLhgcxLD9e+Tv3KngYGee36uQ6bV9ZDc+tnUfxAHQJnubY2utnO5gmgXGELv4MuCA8zDppN2NC9WfZm8oJ5Mh//T4uOeZ1eV8esnBtWoB6rUyG4teFI2rI4w7IurGIe3rt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=U0XRZuUA; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638404ww1416057;
	Wed, 8 Apr 2026 06:49:54 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021112.outbound.protection.outlook.com [52.101.52.112])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dcmrwmus7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsHT9ylc1C6GyA4z89cC+ZsJF0nWB8vj1P/0C6LwU8Hi8GpcztgRHDb+Z77oGeVQzzRfwhNS6xkef/XupZZuHZjFQ51telPnkWHlu/kFwbHUdO3BoO2Joy85Y5R9jWJ49CltIXbeQZmUE2aKn65iWM/arnO1zxb6OebNJRlygjXNBZZ/yIy8hJaEYUDr6mJow6NJrvio2nCFd2UcM3+BdTr/Kviu5UVrHYllFag5js0XpjwFURAlob4ykBViZUTFidhz8WV085JoMVsGhdAVSK+xweMYOtWTO8pA6lx9xTL6a8Lhsqhuo8fZdy1aZcCHviwd9TPdIFhQFQrH5K05/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY8zuxZwqKmsx5GciQKOsHFR+oOgBRnaQ7UCLMMoTEY=;
 b=b7qWiD1G7S6hH0TLTApq+oNzTb2Q3Q3qXDzuqvCSxAHyMM9KqgfJ9Y1kUH5Yt+PI1SdhMc08flmjQ4rNZFgsVfrFBqHk1cRi4soomDDa+X8xFgZ7wjPznk7HUo/4Jneb0GtLQ1/rcIJHi6hZ5Cc1+RO32WH2ZquAWD/fBXLXDir2WlmsqXkfRf8+C871TaCR85jyCWJfMZjXCxACtEbp1vm6+vps00VFIlwqjF+kIas/gGHGJW3Io+Wm9iokQQ6JngmX2O64kGGW/+FKYrYcZOu/3VrGJkU1bPmBKbFeve6yUBMDCGGjMuc3398HAf0UxZIGMLcSHBGoBkYGcU45vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY8zuxZwqKmsx5GciQKOsHFR+oOgBRnaQ7UCLMMoTEY=;
 b=U0XRZuUAdY//OPsygpyIbl4f/wxfUyOlmUEtQnnoMw7gcMlJ91wIcK3fi/y4z2P91JML7OnqTvxScswjKdXiW1GH5SA83XtQqXa8xStFYHPzCCnA6w4h9dGawhfYNI90PYYyTNyx+vkgX+3yJU9+4l5FkzfRqjT5eUFuEItXsHU=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by CO6PR18MB4498.namprd18.prod.outlook.com (2603:10b6:5:358::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:49:48 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685%4]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:49:48 +0000
From: Srujana Challa <schalla@marvell.com>
To: Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Thread-Index: AQHcx1pMd1gRFKwGY0u+n6js7eOv8LXVLDLw
Date: Wed, 8 Apr 2026 13:49:48 +0000
Message-ID:
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
In-Reply-To: <20260408131906.1087303-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|CO6PR18MB4498:EE_
x-ms-office365-filtering-correlation-id: cfe38ed4-c838-4538-2f6c-08de9575b34b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 sWEx+Qcai10nB83VX2aIrXdL/yZXqAKk1nkRwoAXP1y/TlP5fs0TW0xU446KHFxgz2gyGyTWNvvT2XV7dTNaHmMOYBgI4W6cXKHiKQblRrJP7anOX9G3lIqZoxzTF84107h33aF8N17VQnjM82BZxiG1Btc02fy85maOkzAqUdBjkc+Ov3aST+5ntUZbSeDsn3pYTzR8RYOrvQ6nISjusHepEqKuOPGHRZxB3/SDk+pcpc7pAAWwR74KqisFmxPoeMCtow/0QbZlknV+gcbe3XQh15tU4jzBpRuS6Fo/70gh0/40nyOx9JAzJb1EvbkRBQZIbFZHyq0iaj6fQMb4yrGPoBYZgemiIzT2uw83jyTHyePkXz2dLNDUpDAhkLSlXWjI2K3GnxZEU1cLQV18X2/KSZcBGyglABY8kLo4wYoHj/pOZ0gWzlYwiqiJ9IGyW64VsSaN87nF1pxouHb2hBlyHs6RhFgZw8ytNOWOKi3Hzd70EkEFb4JYdHWsPReB4dejMfXUV3GyGlzmDtdnqSiVrPUz5u0WFpOoT3bKmXNxZBcprQGHmnmE1P/vF6OU1i+MdbjhTuT/pfk4vSL5thoMBxcncSt7LWprDzaeRZajvZVvYh7mDSMfz11Etq0ouUrqnWfffQ3SwN6f2Qf8Ap7rQNvYvefI86xjioavgR7rZz6VEwp6yHQsTIlXi03S/+a4wqnT3oRRUikmtqYK1q25/1YwS1dheE0fexYrcNioB3iI7BV8nAXBalalUfZa9JQ5+9ewLipmykuiot/tjLlaZR1sR9c+tMHnP5a8/CE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFlBL2dUK0FRY3VtQmx6WXVCSHRlVUhpTTZkK3ZzV0loRVhvS3JSR2wwREh5?=
 =?utf-8?B?MlpXcDJ6cTY3UHhxRzlOaDBPRTREdVI4WFE3UWRVUE50RExuNmZKalBpS0Nt?=
 =?utf-8?B?d1VMNlNvZnozVVlXbW1EeEFZNWc0S3JmTjRLQmVHM1R2bGxTZnhLaUhabTRl?=
 =?utf-8?B?R0IzM0hiYU1zKzZneTNqUEFtR0tmQnRpcHdrWWRPMkVhZ0doSENQalh0bHJH?=
 =?utf-8?B?R3hMdXpzZHQrQmV3dDcwUEJXdEhDRE95UlMrdDRyTUpTYWY2aGJKL0pCbWpp?=
 =?utf-8?B?U3RXZko3R0dRRENicDNMTzZ2d3JKb3hPRnRRODlRdWVTS05Cam5Jejh6RjFy?=
 =?utf-8?B?UUNlVDc2ZnYwNXJBS3NmSmcrQ1pSaXAxdlpLbXJmYmZCOHhkRnIyamVrZXVI?=
 =?utf-8?B?OTkvV243YWxVV1Z4SlFjek5OT2JtMXl1OERmdzU2MmYrS1FIbGlUT1VJcXM5?=
 =?utf-8?B?YUNIb1cxVi9FTGNQSEJJbzVGZFY5eXZHcFUyamRkencrcWtCYzgwWWpwcDlk?=
 =?utf-8?B?VW0yZDZ0YlQreHA1V2VyYi9STUJwUE0xRDRMYXBIVjV2TnV6bXZlQWFpYSti?=
 =?utf-8?B?NWNrQXpxYThnY0VxNDltejZBOW43MGkvUitjVDR4dUNZTUFZaDBWL0lNaWRu?=
 =?utf-8?B?b1BGVEh1anlrQmIvSHBJRHo1SmFRVE5JaEkreFM0WEJqd3hmd2JGNWFhaUZ3?=
 =?utf-8?B?eWxVQ3BoMWN4NlQrNkpxUlNEQzhTMXFaYmtZcWhXVXNrVHFiRFpSZC9GT3lm?=
 =?utf-8?B?MHJGZ3c3NUxvL1UzL1dMeGViVDZ2ZUZVMUtIUzNYc3pSU3N1emxhQlNyeXEv?=
 =?utf-8?B?NUJzTkl6ajkxR1V4d0JXb2JrZG5WZVE5bDBvMjhqZDdWeW1DRS9NTERobXNa?=
 =?utf-8?B?ekd3c0gxdWNuQ2xTNmJrdCtzb3RLZmlJK25BVmdCbElvc0RhWW1GcldTSk9j?=
 =?utf-8?B?ZDBzUitxa0kzRzNKSEk4bjMwQnBGdm5UZ3VaSGFFRGtEUnd3d3BhK1VhSXAv?=
 =?utf-8?B?dlBITi9CTExEM3FPdGNhczZJVUlMeUJ2eHNNV2lvNGVZQzdhVFFXamlDa2Qv?=
 =?utf-8?B?MU5CQmhJc0hLSkJLL0sxRkxkYS8zY0JYRVZubU15M0RycjJMUWNxTmoxbDZT?=
 =?utf-8?B?Q0ZHZFJGcnk5c2ZUWVZPT3JrZ2xsSkF2VjBXbGtwU2R0NFUrcGpLcHJjdWxy?=
 =?utf-8?B?S2cwT0xXeld0cGlwZzhlakgwZmxlMjg5R3dUZVpUVzFMRU5ZVWRwSlJIQzYr?=
 =?utf-8?B?NldjTnp3RU53dmlKYkFyakFiYmY0UWd0Wms2SDMwRkdzeFdDUzBrTGhJM1A0?=
 =?utf-8?B?K09ENVN4MjN0ZVphYXBSVHQwM21LaFc4UGRJb2NPMWhsWHBaOUlFWWpzZERI?=
 =?utf-8?B?UkR5SDZUR1QzVWNxOTFOWWptS2N1eU1hMnZDSVRReXRkc1FHaDlwbWFuUk1x?=
 =?utf-8?B?Zkk2S0VSOFR2Y0pSMXdnYzdEc0psZ1B1MDRYRVhwYXNWTUFocVRTN2Era0Vk?=
 =?utf-8?B?YmJOWmtvUllqOEpUTG5UNk1SU2FZY3o3aUZ5QkxHTE5VbDVRb1RKdW9MN1NU?=
 =?utf-8?B?S0U3dUwybU9KckFEOG5DajVJeEt4dDM1L2VwVkcwVCthaGdUWU9QZlVTaGxt?=
 =?utf-8?B?U3VwblhES0IrMnBqQWIyZ2JBdi9pMnF0QmtZYmxGYnVnV2FwZzBkMkJXbXI0?=
 =?utf-8?B?OVJHbjdtMXpiN3NJdENWdmVtdml4Z1NyT2lxRzMxK09hL25yclozUDlwTWU1?=
 =?utf-8?B?cE9CTlZlNzdaMzYzdk5aNnN0S29OaEN1clBEVHcyQVFObnQ2aTg1TXdydnk3?=
 =?utf-8?B?eGpyejRCeVFBVWFDb3J1R3lDb0Z6L1ZXTENwREJ6dmt5SS9BdEdHSXdIY2l2?=
 =?utf-8?B?S0swUTBMMndXUXdGellTd0dpd0s3S3h6R3ROakhvcnVibjF5SG5BeUNUQkFP?=
 =?utf-8?B?SmF2U3dTdlhsUEVJdjhlWWVCZ1BMQlZLa2tzbFd2NndjMEZCcklwazJHTUtB?=
 =?utf-8?B?V2VYaFZjaFBKMm5aS1RuNWl6RjFuVzZyTzkrVzNRR2drUjVHT2ZDeEtNWnJ4?=
 =?utf-8?B?cmhZMW1zeERQTlFCK1paMW9rZDZweHBLNk1MWUhUK2UzemsyRDlaUmthRXo5?=
 =?utf-8?B?STVrVUw0S2c3MTMvY3ZyMmpBVTRGU01BZFBoaXF5Vk1wQ01waWNkWm5uTkgr?=
 =?utf-8?B?cDhpRnFVenNQdnVhTUM0dzhGQjNkRDdmbEZ4SGxBa2xDamgxUEFBbWxpK0dJ?=
 =?utf-8?B?WCsvdWpWMmdXT1BGRnhRS1RKNll2NzBWNkdSK1RFWmgwWTNqYSsvYzkyMTdL?=
 =?utf-8?B?eFZoZzdldTJMeFd5bjVnenpCSGJwUHBTTFNRMFk2YlQxN2QxcG1NdWF1dW5h?=
 =?utf-8?Q?+syGRixk+E9QADU8cZjNL7dodsULB52Ks1H9A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Eq3IgEi5D6ibdUzwMQFsoa82gdrKud7Uf5WzfmKxe7sYISpPybylKA1H5SF1HVp7kNTemjdcJjpu1lJja/P0hcHkkbAA/Ha+hYwZL0YJl7jsNyRtVSnd+H7KbHnw+D31RyK/79E++Z1v3Cb5KgJebBWwwVbdQ9GHbmuyDybbDD2HuaMUlmFIUB9W+6Fg/yOGRKgYvU7rqPD+p2CJxIpppOUH/Q0vr/GiGXGFB/OHnkzgSPKVpF7kVzBYN/Kow/VUmaWrnY8+fYwp0+tFetKz2qV6+fHbnCwYvsd4ccnLOjsZluj/mCcucn9x5FNtPp9vAUH7WnqHlHHbEjQ03GRtKg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe38ed4-c838-4538-2f6c-08de9575b34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:49:48.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CDp7OTlDtALmCarsliXWGMautokrPYnLGvPpevwLIBiJvr3S8IWr3w90eOYhMy6XekiBNysB/h88IA/NN1kRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4498
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=69d65d02 cx=c_pps
 a=mSR/hpqHDdeL9wXJcf1Q7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=RpNjiQI2AAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=elLWZlKbAAAA:8
 a=Wks6vg83pPNDIPBbmxQA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YXs7sxRoaa14xkmg_1jM:22
X-Proofpoint-GUID: NI2yd39gqfgv7O7gEUCKFlUJtKATJ_pB
X-Proofpoint-ORIG-GUID: NI2yd39gqfgv7O7gEUCKFlUJtKATJ_pB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEyNyBTYWx0ZWRfX2QYjcDk3SkZ9
 y1+Rke5tp8ahKqRR5pAddzJAMnQzeIKMXdSzy/t8fs/hOL5P3f/w487p9MRhF/DcAV8FC4PkPJM
 hzHwRCZ1gmmqKgxTdkiRcjUtUQLrPhjvG+SVpfnpJ15LzTpShB1zcYWKVmOFHjI2Fh+zpqGMvRx
 aRlfLzQC8JpJWMTogSt5GJGLk1dpGiVppjD5O6sl6IMUUO0o8Zgro3tdAIDcteTfw71hiktsfxr
 QT/jIaMUn7qFnQDYQhL58wySma/NVC8zqOqK4OZHl16eY/qIQ5R3NusqEDeQEm/gIIFdYdqzalI
 DWyO9bxWUTckRHLEaHfQFws9gMcM3JbTSZUeykFLbvPltdirFNo+yf1wKKY3ZPJWP+yd1DTDc5x
 5FQ8QmvMd7PVDbQ1rCsQzaDtnImi5i9I27/A2Lih6vyazJEJy/WUSl0Ubg3IDWz6sFEynNACIaD
 IeyGIViUZvWCBQxNqPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233914-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,proofpoint.com:url,CH3PR18MB6379.namprd18.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E41E3BD357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBGcm9tOiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gDQo+IFsgVXBz
dHJlYW0gY29tbWl0IGI0ZTVmMDRjNThhMjljNDk5ZmFhODVkMTI5NTJjYTlhNGZhZjFjYjkgXQ0K
PiANCj4gcnNzX21heF9rZXlfc2l6ZSBpbiB0aGUgdmlydGlvIHNwZWMgaXMgdGhlIG1heGltdW0g
a2V5IHNpemUgc3VwcG9ydGVkIGJ5IHRoZQ0KPiBkZXZpY2UsIG5vdCBhIG1hbmRhdG9yeSBzaXpl
IHRoZSBkcml2ZXIgbXVzdCB1c2UuIEFsc28gdGhlIHZhbHVlIDQwIGlzIGEgc3BlYw0KPiBtaW5p
bXVtLCBub3QgYSBzcGVjIG1heGltdW0uDQo+IA0KPiBUaGUgY3VycmVudCBjb2RlIHJlamVjdHMg
UlNTIGFuZCBjYW4gZmFpbCBwcm9iZSB3aGVuIHRoZSBkZXZpY2UgcmVwb3J0cyBhDQo+IGxhcmdl
ciByc3NfbWF4X2tleV9zaXplIHRoYW4gdGhlIGRyaXZlciBidWZmZXIgbGltaXQuIEluc3RlYWQs
IGNsYW1wIHRoZQ0KPiBlZmZlY3RpdmUga2V5IGxlbmd0aCB0byBtaW4oZGV2aWNlIHJzc19tYXhf
a2V5X3NpemUsIE5FVERFVl9SU1NfS0VZX0xFTikNCj4gYW5kIGtlZXAgUlNTIGVuYWJsZWQuDQo+
IA0KPiBUaGlzIGtlZXBzIHByb2JlIHdvcmtpbmcgb24gZGV2aWNlcyB0aGF0IGFkdmVydGlzZSBs
YXJnZXIgbWF4aW11bSBrZXkgc2l6ZXMNCj4gd2hpbGUgcmVzcGVjdGluZyB0aGUgbmV0ZGV2IFJT
UyBrZXkgYnVmZmVyIHNpemUgbGltaXQuDQo+IA0KPiBGaXhlczogM2Y3ZDljMTk2NGZjICgidmly
dGlvX25ldDogQWRkIGhhc2hfa2V5X2xlbmd0aCBjaGVjayIpDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZl
bGwuY29tPg0KPiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4N
Cj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LQ0KPiAzQV9fcGF0Y2gubXNnaWQubGlua18yMDI2MDMyNjE0MjM0NC4xMTcxMzE3LTJEMS0yRHNj
aGFsbGEtDQo+IDQwbWFydmVsbC5jb20mZD1Ed0lEQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZR
JnI9Rmo0T29ENWhjS0ZwDQo+IEFOaFRXZHdRempUMUpwZjd2ZUM1MjYzVDQ3SlZwbmMmbT0wWHVL
VlhnazlfMUxVSVpIZXFMMHpuR2hBaA0KPiB4NUt2QU9MdnJDbC1vclZlUVN0X180bzZEanItNzly
d0NsNktOcCZzPWNmUXBBY1pUVEU3blRZa3UtDQo+IE1Wa2ZpcDB4VUpvQkJ3NGlrcW05aUVkZ2Nj
JmU9DQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IFsg
Y2hhbmdlZCBjbGFtcCB0YXJnZXQgZnJvbQ0KPiBORVRERVZfUlNTX0tFWV9MRU4gdG8gVklSVElP
X05FVF9SU1NfTUFYX0tFWV9TSVpFIF0NCj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNh
c2hhbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDE2
ICsrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGluZGV4DQo+IDVjODM5ODNmMGViM2YuLjVhMzFj
Y2RhZTJlMjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gQEAgLTY1MDIsNiArNjUwMiw3IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gIAlzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aTsNCj4gIAl1MTYgbWF4X3F1ZXVlX3BhaXJzOw0KPiAgCWludCBt
dHUgPSAwOw0KPiArCXUxNiBrZXlfc3o7DQo+IA0KPiAgCS8qIEZpbmQgaWYgaG9zdCBzdXBwb3J0
cyBtdWx0aXF1ZXVlL3JzcyB2aXJ0aW9fbmV0IGRldmljZSAqLw0KPiAgCW1heF9xdWV1ZV9wYWly
cyA9IDE7DQo+IEBAIC02NjI0LDE0ICs2NjI1LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9i
ZShzdHJ1Y3QgdmlydGlvX2RldmljZQ0KPiAqdmRldikNCj4gIAkJZ290byBmcmVlOw0KPiANCj4g
IAlpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpIHsNCj4gLQkJdmkt
PnJzc19rZXlfc2l6ZSA9DQo+IC0JCQl2aXJ0aW9fY3JlYWQ4KHZkZXYsIG9mZnNldG9mKHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZywNCj4gcnNzX21heF9rZXlfc2l6ZSkpOw0KPiAtCQlpZiAodmkt
PnJzc19rZXlfc2l6ZSA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkgew0KPiAtCQkJZGV2
X2VycigmdmRldi0+ZGV2LCAicnNzX21heF9rZXlfc2l6ZT0ldSBleGNlZWRzDQo+IHRoZSBsaW1p
dCAldS5cbiIsDQo+IC0JCQkJdmktPnJzc19rZXlfc2l6ZSwNCj4gVklSVElPX05FVF9SU1NfTUFY
X0tFWV9TSVpFKTsNCj4gLQkJCWVyciA9IC1FSU5WQUw7DQo+IC0JCQlnb3RvIGZyZWU7DQo+IC0J
CX0NCj4gKwkJa2V5X3N6ID0gdmlydGlvX2NyZWFkOCh2ZGV2LCBvZmZzZXRvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcsDQo+ICtyc3NfbWF4X2tleV9zaXplKSk7DQo+ICsNCj4gKwkJdmktPnJz
c19rZXlfc2l6ZSA9IG1pbl90KHUxNiwga2V5X3N6LA0KPiBWSVJUSU9fTkVUX1JTU19NQVhfS0VZ
X1NJWkUpOw0KPiArCQlpZiAoa2V5X3N6ID4gdmktPnJzc19rZXlfc2l6ZSkNCj4gKwkJCWRldl93
YXJuKCZ2ZGV2LT5kZXYsDQo+ICsJCQkJICJyc3NfbWF4X2tleV9zaXplPSV1IGV4Y2VlZHMgZHJp
dmVyIGxpbWl0DQo+ICV1LCBjbGFtcGluZ1xuIiwNCj4gKwkJCQkga2V5X3N6LCB2aS0+cnNzX2tl
eV9zaXplKTsNCj4gDQo+ICAJCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0ZWQgPQ0KPiAgCQkg
ICAgdmlydGlvX2NyZWFkMzIodmRldiwgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmln
LA0KPiBzdXBwb3J0ZWRfaGFzaF90eXBlcykpOw0KPiAtLQ0KPiAyLjUzLjANCg0KV2UgdXNlZCBg
TkVUREVWX1JTU19LRVlfTEVOYCBpbnRlbnRpb25hbGx5IGZvciBjbGFtcGluZy4gIA0KYHJzc19t
YXhfa2V5X3NpemVgIGlzIHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlLA0Kd2hp
bGUgYDQwYCBpcyBhIHNwZWMgbWluaW11bSwgbm90IGEgbWF4aW11bS4NCkNsYW1waW5nIHRvIGBW
SVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkVgIHdvdWxkIHVubmVjZXNzYXJpbHkNCmxpbWl0IHZh
bGlkIGRldmljZXMoZm9yIGV4YW1wbGUgZGV2aWNlcyBhZHZlcnRpc2luZyA0OC81MiBieXRlcykg
YW5kDQpjb3VsZCByZWludHJvZHVjZSB0aGUgb3JpZ2luYWwgaXNzdWUuDQoNCkNvdWxkIHlvdSBw
bGVhc2Ugc2hhcmUgdGhlIHJlYXNvbiBmb3IgY2hhbmdpbmcgdGhlIGNsYW1wIHRhcmdldA0KZnJv
bSBgTkVUREVWX1JTU19LRVlfTEVOYCB0byBgVklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFYD8N
Cg0KVGhhbmtzIQ0K

