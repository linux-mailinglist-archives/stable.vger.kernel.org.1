Return-Path: <stable+bounces-144725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11CABB2DE
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 03:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1491894461
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760919E99C;
	Mon, 19 May 2025 01:28:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B10199931
	for <stable@vger.kernel.org>; Mon, 19 May 2025 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747618130; cv=fail; b=HBv6eK4XG9LCOBHsGB8n6uezliJ8P8fepbF6wl8FUBxF593+tg+6+DqW9mxw+SdrrLaY65R4Qw0bDiHq5KuOshv7+AOKmhEEwf2gSmo1Qa7eaDiKxW8mMWOPHvJ6aVYcoQmf2v+EHsD8UqIpxi5CYUEJYieTIjoKjelSvoV7XQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747618130; c=relaxed/simple;
	bh=h3vvk3R6+2BmoEi/Feow3owqSMyRdZqP/5Nkky5aUG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0ZjljuSsnH4uj4SLwxjtEOa6gPKbIjxjuaTpIzmHYOcvi+jp1jfjHTy/GAaj5UgOz2FV8+9+nn2ozq2gnqC9fRa2QDHeHhngqbx36EUVglTCs3Bzi0GvL9mQ6Z9qu30Dyld/GvqEtwqodgPwMKC2cPeaPRKcQS+m/HJ5iR/NUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J0VOjV028277;
	Mon, 19 May 2025 01:28:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46pfp0sfr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 01:28:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxKr0ZMEEiAHCT4NYYM33fOqO8OwE1jC5PZEcxqrLyo4SGVHLmaEHrTowb3rScDmaES60g+lbSFxTZc4SQjUnay03zLDkCETZgpHLesyMKzZG8h++3dta/3prL7as94u45fNYV7WTt5Skesiz1WGUdP9pAGo3Rvu18qxRgAyRymh3BXzTaeXuAlozAXlPSrmp8fxP1dRR+3aAcM1zb1Xoum4ZwkWjYd74ugieLo3ZIMgUq5iKD1jvIK/V3/bzjqx1bq2IzQlCdNu2BDL3VGiIWH0FSQeq/r2i+kzT8eM9reUIVworAPDMgKdhcHxT3Qi1oQk3a2pZ775btQMK72cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0PI6IKHwpbIpKso9DM/lPK1dHrUuUoFFv1dgHKRJP8=;
 b=adrNTA1E3spt6QkGoNQNwgghr6/vQSpVHkGdYBdVLV7kJu10PpaiMxhb72IioB22yyTwgeiIrtA5NMz4PVyMWUBIlUhNMoBkBYOGDcqzchljE6sRwwv5yEqQIjCpv5CRqzyahjjcxLw+qHSxAGMdcbcqQPB6ymGbJwQZqwq7mr+LxLZPaPCUW39Ce7ASHyiCcZo6PRb9BWowJtL240ahMqq8M8jDeuZRmRfNU8jdZge+cgRFcMxKhamvAJ3PIjUtwqzhfvhRDspI+8N4O4TPnwLEvqEYfB1tI8L35PoQm4qaQ+hxKK4eEBnUoVGcrRK72U4z/SHQ8gLo90y1Q4oQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 01:28:30 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 01:28:30 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] powerpc/pseries: Fix scv instruction crash with kexec
Date: Mon, 19 May 2025 09:28:16 +0800
Message-Id: <20250519012816.3659046-2-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519012816.3659046-1-Feng.Liu3@windriver.com>
References: <20250519012816.3659046-1-Feng.Liu3@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0141.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::33) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e31afe-c233-4ce7-1e20-08dd96747683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9+fTCOcQOOhfeJoGF9CeUatE9hy5priRue+LlYCutwyAyUezxwL3dnVaFV4?=
 =?us-ascii?Q?0DPKusiHRgACn8hkKQfcVS+EnYYJ4E1DtnR9nvLCiJlGZL+keXDcrr5Khm6C?=
 =?us-ascii?Q?ZKAG9NBYCTa9vyNzA3ouBfxEB0/ycIn63Q0qKD8DK143My09JvVHxTM3on/Q?=
 =?us-ascii?Q?lEdHQXZUThai2oAFkdgBcd7f/goRdQRP6QrrhjRSsg6ZzRZqFxkFfzdZrVjO?=
 =?us-ascii?Q?q39lgLFAzvHsJSk47o/w4jtW2YMkOD9j/1mwzs4p9IwrodJWLK6hNOwLIMX6?=
 =?us-ascii?Q?KvviRfkLMgSW0Cn/LmNaYgDYj0N+A2hHxlhBhWGCwz2iFdZAzWvTJR6DJvg8?=
 =?us-ascii?Q?b+IPJcYbp9bpMr2XFFa0uWIpN72cKcYBggCH6jzDuAPVExXoqk/4bqH9bI7V?=
 =?us-ascii?Q?ROyr+myJZiiqB7YU26MzBxHlTjwxyYM7SzbRzURCtylox50nRkr8HKynZCRl?=
 =?us-ascii?Q?UAG3drTTHr8/3VdyNTLcxW1D9OScIj6p6DtIsvKFRE4m1Br91gLGtCuGXv4X?=
 =?us-ascii?Q?h6NNxhE5/eyTd8UFj6Xyw5+8n+v4jyvWFmYl2bpTqzXH/ial62kvqxniDwxV?=
 =?us-ascii?Q?EyYdeMwRHXQ89RVFX3MHyKP5gBvUccx85Oxeo45q/YJpQj9e5D79k3jFefE7?=
 =?us-ascii?Q?3Tkic8LVqBbgR/7cPYbs3InBWAYOCbbKdN+PEmeAfwFhmRbKS1dvifcJ9DKq?=
 =?us-ascii?Q?JwUd5J7eJIjjnKdOzo8OuwRVUOSTBPlIuZXS50CesmsF3l8eFWC8Tc6aMeTP?=
 =?us-ascii?Q?IbtaF0I8QrGrdTn73GD9V20VzXVgCg2GdD4IW4M8JFOTk5zHdG4/xe64p/4P?=
 =?us-ascii?Q?PcwhecRBXPsDhsr5kWcHqSONIDb+3UUlG/5fdoTq2ZkvZmTwS6Oy+yzSYNTU?=
 =?us-ascii?Q?dS47UnTR6tQt6Q2UxLOY/8dhebGlhvmBuSCbBM8nmK2GGJ/GkOXnBIEbkfC5?=
 =?us-ascii?Q?QEQ/c30PYDbYNNa9vyh50WMENY+V90Y9/xXn8gOjtOKjLkLrFmZn1GewUBF2?=
 =?us-ascii?Q?uq5r3h6SOpL/VKnWD2pthQpD2Y6ibl1jdABo+e0rrFp0zbPsebWwZGubBcLV?=
 =?us-ascii?Q?RhUmq7F5aMuZ3cWW/7vgXNgAKcHQPvbhc1KSMmEQVcnuERSYHHpE+8RuuaRm?=
 =?us-ascii?Q?HZ7aRqQZj6+eRCEpOsdKPY0f2T8JKfkq4TtZmYA/IT5MWgqqdoeUlk5yeOKW?=
 =?us-ascii?Q?HCJJkir2bcUnwWSwPgE3nmeRQ+Iod9Oy2l3gkAXAgLZFrXprvLTl9c6GW1cP?=
 =?us-ascii?Q?D4QWW9h/SEBQSUKwpDf0rnVPKkYjvOXn4lsleyy2hXOdoSNK44NHxuSP/AGz?=
 =?us-ascii?Q?Y0J3vv3LW6/ryXBRcIE2Urx5LMXQF3TVf35XjovdBlMFjWjQwm8H06wi+GLz?=
 =?us-ascii?Q?z0lGQd7dIuk2Ps41k4w+f9OaPjn1UKRlMmpzalW+hN4mp/jU+r0U7z8bCZ/U?=
 =?us-ascii?Q?PYxs1iH/s6q3huKjhpn9AaEaQ6N1YkAQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ndpnaD8+L1DmVPCnZblGLPzpk61Z4OsaQo52uY98EPih+9sY9GkiTb4eu6h?=
 =?us-ascii?Q?sfTxVGC49MQF42kAGjQNbAZzNpFobdqXo5Sm6gTPh0oNKvsiHTWNVs/RmG4c?=
 =?us-ascii?Q?Ksg1xuVaKLpoIgyXpasfghIrrm7AX3QK4GsiKoRpcsZdNv4qc0WoqaUxLuBz?=
 =?us-ascii?Q?TMdkgvzNbh5pgUkt7HDB0ZJjwMNNxBQ6QJnJ+ZY4S/A8TTXQC/SmKVszBSvZ?=
 =?us-ascii?Q?HM39NspdxPHXpZIj6PDZU9/QFBLMbM+nBwISJakJWkfpGIHmqEfNHFqA0lwI?=
 =?us-ascii?Q?q+nxlZ1ctSPZnP88nMdibNpiNhktUoBcN3ME1Ssvf5eWK4/3kWiPFLcRlYtm?=
 =?us-ascii?Q?qWlAbRPlVWVZgYyHUyDuyf5wwTelwHGOVZo6PeWjgpeZ8U06XsZwCn7/K+cQ?=
 =?us-ascii?Q?fkX+i+SbzmoFQ2r9k94IYwEkH87u9JCmvJfcgfGuGu6Y9ptKY7ykRHYEQwkq?=
 =?us-ascii?Q?tTxRy9WGF96HDbyr1xw12+ft9e00ThoX79D9wjFHPmtvgypBzx5sEZa5t9Bj?=
 =?us-ascii?Q?bZeaYlUVVm44+CmQ2mjJXfCD4666cy60Uh2yzEShfhAmkvcN2T7QfaLw7+mp?=
 =?us-ascii?Q?6h4bHSdXmullMew+P4y66kuhZuf8lLVyYJ9+XEPGRrOEEnc97tbkmpXunaac?=
 =?us-ascii?Q?Ka5tzogaMNnUZChkee5v5V8lzOYXR2wh7UdOSNXgVQ4S8bi1OrLI4Opyxrga?=
 =?us-ascii?Q?6SQOIpVujqP9GlmO7hi+MjTiORNZpJSyUQX3UN4C2kXkeGJQEwJb3tLwZm/c?=
 =?us-ascii?Q?HYe8h2/mrhkD01wc34In11ah35cGrw3XRlJALWLvHmqSyVbl3ihZF1UGA0Wx?=
 =?us-ascii?Q?8NHLG1hZ/hWTnb869nLGMoQf7iRiOGQW7xltc/tdoHG4l2ZeVaoezpdgXtT8?=
 =?us-ascii?Q?xjBp4+UjhgYHJ2e/TkSEC3vGa5ACHHmIQ1TXNrMEh+lGkBFyPDVa5bxAFqLX?=
 =?us-ascii?Q?4rhcDXpO1xNB4DpfUZy1fSYOYECwRJtYbLOEMLqlC6W+Ey33y0/N4744fyIS?=
 =?us-ascii?Q?ZvjGBTH5/Hm9qax2SSh0tGcMUHbUZEgFqjVRJPWYGYlZXOo1b3yli1KrgErX?=
 =?us-ascii?Q?sym54/eFNlamgmwGPJaG6cC2hKVs/5YNT2LTrQIjkWN+MjiRMH8bPWooPbRR?=
 =?us-ascii?Q?3ODGn5VxrgV5Bm8J2LsbTGLbaW1VXUxaDI7T8p8pgEQMysvAL7bvXVXUuK5N?=
 =?us-ascii?Q?EfcM/tHWVWglhQ4GOojyRg4tc7uFx2iCmDEnaMtnbjaXuu5ND5h/sp732EU/?=
 =?us-ascii?Q?n/H3Sb7CiESm9GtKC/102hK7H4bUEmVmBM0CQbsxH1dYjLriyjI/UnNycEZh?=
 =?us-ascii?Q?pwRZfmxe6cINgW6H/Aw10P2lrkEQL662NQTQdkOZ6VvKTCu5MQWtBXAIYCNs?=
 =?us-ascii?Q?VlipAN/IZAaRVz2vdarzGRsDsfUF5TFSiTbIuN0PrJBsjRYFKJxtwTSrZ127?=
 =?us-ascii?Q?w6Kr9PwfViDnK+wqZaNpYJbMosJ3n7TCz11t6qqHY11GIx29ZnEikoTb/XQo?=
 =?us-ascii?Q?KAiLE6OMJAsKY18FxgCPq6gqpBMi7PTgTEWDEJTrq+Hgt2BzgZbQBbzHMKv0?=
 =?us-ascii?Q?5YUXi5DKSSl3QNPYlsX8ExEo7eGmJ5+VScRrttEg/Qm/jSIgv/dljDaDbaQR?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e31afe-c233-4ce7-1e20-08dd96747683
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 01:28:30.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTO9Bg1UBToJAc13aru/fq+hqC3yLdGqrTN/7z9d8uwQQg7x3FgSWrsYVbuYGJd4iSjtB8kH8YA1ywx1Ja0zng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-Authority-Analysis: v=2.4 cv=F8pXdrhN c=1 sm=1 tr=0 ts=682a8941 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q_-QqQvvsW3-AdnsPqgA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Vwo0Rbx5V0rFzWN3DRoCuGPINZTxlbHO
X-Proofpoint-ORIG-GUID: Vwo0Rbx5V0rFzWN3DRoCuGPINZTxlbHO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAxMSBTYWx0ZWRfXzIuXbwt2jCmS LGE2mc/9eGMk0wTtvTAGTkq8m+EdUP9kyLgksYmrWAZSdN2BaL7S9rr1FjUXawgH1Bz9sVo1Njh 1TcpwbiEG4Maf+hwvHYgRlIMZYzLXYQckYyiYoV/2HH25CzgXN+HTQBv4Jjxc7H6T4yvxtZyPNP
 1UiuIvmltwCc/mQcMJt+2p2x4vx9/c+n7+VI87/lM50Ws9AHhpaEK6yxuZTNOKBKVTZCBmanCJg qCr1EUZDwMGsfRzPeABWVB7VGTfFEcFTfwqcI7fLaZn718iYH0FFEjne7AObFy0qtq0F5CwF+pP K52+VSTBRDSvDYz7X1O/SvL5iRViCVOELme/jYsi1JlE3lXc5ER3cZ5lOlu4mCRlBAcf2tgnd7n
 IbdIlaBN/suEwpwTvzGV3NbGyIgOj9RJhZACZsDSUszmOPciWxBtYp3rhG1houKOHtZSd9id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_12,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190011

From: Nicholas Piggin <npiggin@gmail.com>

[ commit 21a741eb75f80397e5f7d3739e24d7d75e619011 upstream ]

kexec on pseries disables AIL (reloc_on_exc), required for scv
instruction support, before other CPUs have been shut down. This means
they can execute scv instructions after AIL is disabled, which causes an
interrupt at an unexpected entry location that crashes the kernel.

Change the kexec sequence to disable AIL after other CPUs have been
brought down.

As a refresher, the real-mode scv interrupt vector is 0x17000, and the
fixed-location head code probably couldn't easily deal with implementing
such high addresses so it was just decided not to support that interrupt
at all.

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Cc: stable@vger.kernel.org # v5.9+
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/3b4b2943-49ad-4619-b195-bc416f1d1409@linux.ibm.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://msgid.link/20240625134047.298759-1-npiggin@gmail.com
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 arch/powerpc/kexec/core_64.c           | 11 +++++++++++
 arch/powerpc/platforms/pseries/setup.c | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 89c069d664a5..09d59628a499 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -26,6 +26,7 @@
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
@@ -317,6 +318,16 @@ void default_machine_kexec(struct kimage *image)
 	if (!kdump_in_progress())
 		kexec_prepare_cpus();
 
+#ifdef CONFIG_PPC_PSERIES
+	/*
+	 * This must be done after other CPUs have shut down, otherwise they
+	 * could execute the 'scv' instruction, which is not supported with
+	 * reloc disabled (see configure_exceptions()).
+	 */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE))
+		pseries_disable_reloc_on_exc();
+#endif
+
 	printk("kexec: Starting switchover sequence.\n");
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 309a72518ecc..95c9d1e38f4b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -411,16 +411,6 @@ void pseries_disable_reloc_on_exc(void)
 }
 EXPORT_SYMBOL(pseries_disable_reloc_on_exc);
 
-#ifdef CONFIG_KEXEC_CORE
-static void pSeries_machine_kexec(struct kimage *image)
-{
-	if (firmware_has_feature(FW_FEATURE_SET_MODE))
-		pseries_disable_reloc_on_exc();
-
-	default_machine_kexec(image);
-}
-#endif
-
 #ifdef __LITTLE_ENDIAN__
 void pseries_big_endian_exceptions(void)
 {
@@ -1088,7 +1078,6 @@ define_machine(pseries) {
 	.machine_check_early	= pseries_machine_check_realmode,
 	.machine_check_exception = pSeries_machine_check_exception,
 #ifdef CONFIG_KEXEC_CORE
-	.machine_kexec          = pSeries_machine_kexec,
 	.kexec_cpu_down         = pseries_kexec_cpu_down,
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-- 
2.34.1


