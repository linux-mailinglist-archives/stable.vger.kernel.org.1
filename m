Return-Path: <stable+bounces-134520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96124A93093
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 05:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E307B5336
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8141C831A;
	Fri, 18 Apr 2025 03:03:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8424B26;
	Fri, 18 Apr 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945438; cv=fail; b=rndMFO26/BWwfwPDGA0aH4L4sOgck/VGXc9+c8mZhwOgBAYHRzfgFEM9P/6nmaGJsgwyTxVyinFqL1zbR5FgGRcyev1lNGi+xIUz+PDhgaGZ1IFKIGanpB9kuTo3hpnF+0ZigJEI1mlti5U1b16anMJqNre6EcsQ3X8MnVmlky8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945438; c=relaxed/simple;
	bh=h5TMMCOwlzDct4zV9NQbCQIo4oaA5pMcS8XoOgWL+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZFHMXXUlIoTqXi06EKZuVMmLegalWEXINbA+sTunEDmOtWWkqG/dzlDkIkMcsyLLUsK9yovHcUNfhezz1I90hlWKcxaYfF51n5bBvdgDSJJEVdyVNEnfd6Zhe2w3FSjfoFpaunxFU9Y1TgzbygNwFT/0fnFTikkEOT1WZna/f3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I0s1wi003157;
	Thu, 17 Apr 2025 20:03:34 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkq0f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 20:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwWzhXNkcYuBA4d31s/V2GA1gqW8muqEnwZI/E74K7DwelWbjxfcllU7rziVj5AOXWqpzRPN4b8OxZTK8hbRRJIDNbqyeEOwvl1Hnj8l0Fc4MfDwpjWtta/ekN5d8gWvkpKDWf/EAne3Y1KktfIkL+Lf+Lm4rbWE59w8T7oqtF5xZlnsaFBMG+2YWcZI3y/+LwYxsSHkXCF5hBokHqIxCvHSvkTziqcxixLdcLDWRHuMwHg2A8huGZybkCOG32VsRea2/FuL6bvr+0yAP59dhd5oJBNgAdYLl85+eBuue7MesaKLFr9gVlWNYNTnYtsqA4NVE44bRBaf5Bo5RnDATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNWqektjEE1wGebSwUcscK996+gE5XC/qUPpRNAgibE=;
 b=Db4IQKXiiTxIKCR6TrHOyU5wF7pMKhFov3W+8aua2pn/ZNRKHvFjMk4F72ePwbYL593yKYheZ3YaUniLsAbrlF74F7++KsSJUIj/v4lrXh/4YgqjTIK4YKOUmO47KxqQUjQUyPceKDM88p5DjH8iLKIlAiDczk4zj9bVRgQM41F+xMQDi27DkuW3kSDS8PUdS9G3QUT7zc4vxQFvbXXowXyIZjVCfdvvncDOkfReqr7J+3ASn6TopMB644qROo8BffRFXiwQYHdGFmZuK04W2q97P8T2tXk+dSOfNUHFYADDm8uFhuWpr235s95WHFtVVbl9FtyibtTamfl9YO5FGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from DM6PR11MB3324.namprd11.prod.outlook.com (2603:10b6:5:59::15) by
 SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 03:03:30 +0000
Received: from DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039]) by DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039%4]) with mapi id 15.20.8632.036; Fri, 18 Apr 2025
 03:03:30 +0000
From: Zhi Yang <Zhi.Yang@eng.windriver.com>
To: stable@vger.kernel.org, qun-wei.lin@mediatek.com
Cc: matthias.bgg@gmail.com, akpm@linux-foundation.org, zhe.he@windriver.com,
        xiangyu.chen@windriver.com, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, andrew.yang@mediatek.com,
        casper.li@mediatek.com, catalin.marinas@arm.com,
        chinwen.chang@mediatek.com, kent.overstreet@linux.dev,
        pasha.tatashin@soleen.com, shakeel.butt@linux.dev
Subject: [PATCH 5.15.y] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Fri, 18 Apr 2025 11:03:14 +0800
Message-Id: <20250418030314.1404446-1-Zhi.Yang@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::17) To DM6PR11MB3324.namprd11.prod.outlook.com
 (2603:10b6:5:59::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3324:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4411bb-2252-4eda-c990-08dd7e2598c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFIC4JPcxUVSpen53ty9IpdZHqMM1VAzm+cT6PgYyM8w6ZXSjG7FU0dgp9sv?=
 =?us-ascii?Q?sePklLWNitnYvel8DnjTTWYjBqSm/Wb6x7a6DW2bt4fp3iT4rLEbfi1nHRgB?=
 =?us-ascii?Q?UI4tKp1HSYBe72lh5CxQQlfdYkFiXhRbGaslgU+9/C2nmWvCA6IeEIcD9nf0?=
 =?us-ascii?Q?L1V68rBihYVbevnoZ26Y5bXiOdvQhEv85DL011i76HpKllWXuE6uQn2PzUxc?=
 =?us-ascii?Q?Q9M6AOg9BBeH+e3bN9MeJTN6aV3CiQ0gQYvDg2qEtm5YS4/InMJJDgWN3L6c?=
 =?us-ascii?Q?zbvD/0sC2x8m+5o+PNOzNHB/Sf9Vrw3XUnAXPFBTwq6XB51RLa/MkCi+vlM5?=
 =?us-ascii?Q?/4x1LQXE1kMRAkrLD/FNQAHD5srL0v3jz2QepkyNSz0MHJmYT43eJMAUiXft?=
 =?us-ascii?Q?7ELcTrc40FnuHhq2BjtpwmIyXTlNkEKQstwZ9wJjEUxckWvQhaCjWJ+EHCSP?=
 =?us-ascii?Q?QMHa05qwljDO7Z84YsvuUw3cMKC8erH8UzBIqfIexMKvBRTwCtmvj1hSb+ug?=
 =?us-ascii?Q?b3xjPqEps8oVSP29a88l4+ovv2gVy77Vgk6t1ajyJYKBfQ0GrgzvIZ58KvZ7?=
 =?us-ascii?Q?KZ5/rbR0Emy5IDaBbcWa+xNz/EfccCUbNR5y1CCA2eHgCjeb7OEPidnb3aCE?=
 =?us-ascii?Q?drdiiMVYsD68+Ixr5LEKMmlWibKQiqMoahtmhyspoId95ipZifzZ5Ft6qV2x?=
 =?us-ascii?Q?8pCqqSQQS2F6kK4w8K7SImznvNPB/S4NqYLKmJVy9tiSjLSSLkZrR8xAenqa?=
 =?us-ascii?Q?hAuVXrhqa7Ayp/6K3Jd35kd0JbgD4Qxdy7PZE+gJzMxqA+uAmaWnHm21givf?=
 =?us-ascii?Q?scNPj70imhOvAa4cuToF2l6VVPdN0XeKIo/Gz93sl6BerIU+gC9xHdG3bx2n?=
 =?us-ascii?Q?dqhOFWp2fFpzbO03rJBwt8GHEqvf85CguxfRV5fc2g7V29VrRuzysL7XL6LW?=
 =?us-ascii?Q?v7xSbY83y4LdkkqnGTzeEoUp0Q9/8zSBGCW0ED8ue+kzrZ92Dk6+WtjSUpeG?=
 =?us-ascii?Q?yxr1MMQNDeFST56qvETwBuoSd3fqw6np/bqLlGdEn4WHsRb47ql5n0YG2Hr4?=
 =?us-ascii?Q?FAE2eoNgP5PkvZwzbk5QnmMTxVU3RLzb925o/9G07SCSIZevF3QeHTfhp2vu?=
 =?us-ascii?Q?7fX+wUTjFvNWNeRDI0sN3aiI4gQ82oRvxQ0U0vBXWftAYlGeF4L2h3XLUpVU?=
 =?us-ascii?Q?WacS19pCt6QKfuKk2OLfs6xIfMJybTv/tCwOp6Aa9nVpqMXXiPaYhOf9Ind6?=
 =?us-ascii?Q?Xh3GWfb7NfXl/ZATAyj2kAPsKrWL3v7aFvhX5ChDoMqtJrs3aljAFPYT8pBv?=
 =?us-ascii?Q?ZTAErPJBxyuhGXkluzc5+4WexdyKEAA+YUnI6kDqkBUOuEIOT44385jBbmco?=
 =?us-ascii?Q?W5n++KFNlH0Rp8wpEFydxUWbgVuA5lv4WRzuspCxXUZv3yZaQw4h9cFd2feq?=
 =?us-ascii?Q?fFsBfX1rkBzFCyZMHPds+t78SNqog/mX/jF/3zDpv/oEfJSJjSmHhcSubCCJ?=
 =?us-ascii?Q?QV+7Gqx4Qkaghng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3324.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxtCwUQNX+9lZg0QbXT7b1uBjyzStUNJTixbNuD2ugYpXaSY6xI5TyUELWfL?=
 =?us-ascii?Q?vYTqPeinaZieaf8JAUvAJQXBluKgm68JdbYUicsVXDyuksaRfEDg/hwd2elx?=
 =?us-ascii?Q?qJcs/2HvpTOVVanaDnhKfII3ejUmlirXBCd9Kzas3JA8my5gsaf4TVJiunvs?=
 =?us-ascii?Q?903JIcTWlWxinSp5YNNbfDUMNzhaBhhYnDMUGE0bGepR+hUB3p7FqZwSWGoV?=
 =?us-ascii?Q?X4ZSI6t/zG3NByv5uO5OvnLYh4aWhmi9cSKfO99RPdLwexRxoMOLqYrEWgHk?=
 =?us-ascii?Q?ulvPDPgbPealHifaXQFlCNFz6mv2WsHcK+R12WCmkdDjTo73lhfyCn5ukj1T?=
 =?us-ascii?Q?3XrNJU1N93CCwZx1hWCOuSSmwrik+AMQAb9m2nMD9BgcmrU/baUMABPH09N/?=
 =?us-ascii?Q?t9Dr0FC+rnLo55Bsok4s9lDIFnzZ0JoTsi1yW9JYmiTYTQvimvQPh2MT7u/1?=
 =?us-ascii?Q?I1VGzNC8Qvr5vbn4OEYXVWDoH7SCMS4IEEUKMNVBOazafPouCNx5fSA2NM3z?=
 =?us-ascii?Q?TKHHMgpAgjxg/M1eH3khBh2kNNDfOJuhmf3au0EdowycnJlJW46GHPOXeqI7?=
 =?us-ascii?Q?1CDb6RQQedMUZDys+x1YbqYWbHfVkizmyw4GXQrSUIJ+SSrNiIlSjVRsYS0w?=
 =?us-ascii?Q?JiX6ZXbQGXBHjPeJJ+jnfKM0YUawm/ebXytRbV1DiDNdf7jg+NqazHb1KN9K?=
 =?us-ascii?Q?eGM07TPr2rkr/XVtNdfvttwaDJRM6xhEfc3JtAZyxg6SUWmJ62+abOmJrh2d?=
 =?us-ascii?Q?rxlMfAoG+juGi9Dx0o58O0qz9aWITWKYJfD86L/XkxfkN3ShaK9GIe1NDvwu?=
 =?us-ascii?Q?KyJvGqJ11eZOkzwx49aNNZ7zQMsJGQ1ityQ0aHvgug+c+uEBKrg2nMn74aba?=
 =?us-ascii?Q?/lYRxK8EFlbD2keHPKDhWwo5JUm2sDMEeHfTYs/dvuYJ2rbai0WSfhztq+xG?=
 =?us-ascii?Q?T89K8Ca3e2Snp1OlWFCj4M9ZoTmhaN+7c6eG44iW4B+Q6Sr4PiZ1q5SER7aZ?=
 =?us-ascii?Q?M+C+XWcNGeU1kPbVjDRxIg4qeT6H6WRyi7AmhKUQD+QNIq0E2fKL+sB3gA9m?=
 =?us-ascii?Q?S7MrTw6B0Q9S5s8Kr5ZSHHdvUYASY6ZErzJPRLo+UbA0LJBCKMN4Hh9MTvGr?=
 =?us-ascii?Q?8wFeUAJBcMQr5ybEqMSQgpZ2nVW2EtpoOLFpOj4+SQTt7OWcBvwGL1oK2SpY?=
 =?us-ascii?Q?X2i4VMipVkE4XvUFc3Gv7zsELmZgl8a38c8hS+KRbUbxWWIVfTBY5q+cScGo?=
 =?us-ascii?Q?blkick6ROt8UVI06YOY/9AQLH0JP3MlsWDhiG+fT0rBTFlnK/I/m2vQa6hvO?=
 =?us-ascii?Q?uFRQjgeYwMMmPpbmu3oOI7rWTekP4ZGMiPgbthDjk7C+D6Ve9sIDcOd7P0hw?=
 =?us-ascii?Q?WKVcNUOR04sneCYsWyToiacIQXuJ955J25umBPw8beky1p5OdsoJ1Jf2EttY?=
 =?us-ascii?Q?w1/nSmQB6vHoxOBghGXJrhqB/3BT+JVereRYi4qzf4IqRHPX9GAPZefKMHuD?=
 =?us-ascii?Q?NAAoTf3F/KN98+YExKR0OeMIv9CdptHIz3flvH9LbPWKJT7blld4u9gOzRoy?=
 =?us-ascii?Q?4e1FP2ae0NXdatP4mZNyho15hL9C6jJp+N4K9E1G?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4411bb-2252-4eda-c990-08dd7e2598c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3324.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:03:30.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUNBoZy4W07Rx1buG3NcKyEVpxWicbNFl8kuWmhDlF8OIYuNS1lyUdfNxXhylgngdTZ9CPLibho8zDLM+YDBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-Proofpoint-ORIG-GUID: F72L8iksFC6we68UlaRW_V6dXLBHNkan
X-Proofpoint-GUID: F72L8iksFC6we68UlaRW_V6dXLBHNkan
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6801c106 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=CPUegwAG-kHykAvzoiUA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180020

From: Qun-Wei Lin <qun-wei.lin@mediatek.com>

commit fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58 upstream.

When CONFIG_KASAN_SW_TAGS and CONFIG_KASAN_STACK are enabled, the
object_is_on_stack() function may produce incorrect results due to the
presence of tags in the obj pointer, while the stack pointer does not have
tags.  This discrepancy can lead to incorrect stack object detection and
subsequently trigger warnings if CONFIG_DEBUG_OBJECTS is also enabled.

Example of the warning:

ODEBUG: object 3eff800082ea7bb0 is NOT on stack ffff800082ea0000, but annotated.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:557 __debug_object_init+0x330/0x364
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5 #4
Hardware name: linux,dummy-virt (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __debug_object_init+0x330/0x364
lr : __debug_object_init+0x330/0x364
sp : ffff800082ea7b40
x29: ffff800082ea7b40 x28: 98ff0000c0164518 x27: 98ff0000c0164534
x26: ffff800082d93ec8 x25: 0000000000000001 x24: 1cff0000c00172a0
x23: 0000000000000000 x22: ffff800082d93ed0 x21: ffff800081a24418
x20: 3eff800082ea7bb0 x19: efff800000000000 x18: 0000000000000000
x17: 00000000000000ff x16: 0000000000000047 x15: 206b63617473206e
x14: 0000000000000018 x13: ffff800082ea7780 x12: 0ffff800082ea78e
x11: 0ffff800082ea790 x10: 0ffff800082ea79d x9 : 34d77febe173e800
x8 : 34d77febe173e800 x7 : 0000000000000001 x6 : 0000000000000001
x5 : feff800082ea74b8 x4 : ffff800082870a90 x3 : ffff80008018d3c4
x2 : 0000000000000001 x1 : ffff800082858810 x0 : 0000000000000050
Call trace:
 __debug_object_init+0x330/0x364
 debug_object_init_on_stack+0x30/0x3c
 schedule_hrtimeout_range_clock+0xac/0x26c
 schedule_hrtimeout+0x1c/0x30
 wait_task_inactive+0x1d4/0x25c
 kthread_bind_mask+0x28/0x98
 init_rescuer+0x1e8/0x280
 workqueue_init+0x1a0/0x3cc
 kernel_init_freeable+0x118/0x200
 kernel_init+0x28/0x1f0
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
ODEBUG: object 3eff800082ea7bb0 is NOT on stack ffff800082ea0000, but annotated.
------------[ cut here ]------------

Link: https://lkml.kernel.org/r/20241113042544.19095-1-qun-wei.lin@mediatek.com
Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Andrew Yang <andrew.yang@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Casper Li <casper.li@mediatek.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[Minor context change fixed]
Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 include/linux/sched/task_stack.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 879a5c8f930b..547d7cc9097e 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/magic.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -86,6 +87,7 @@ static inline int object_is_on_stack(const void *obj)
 {
 	void *stack = task_stack_page(current);
 
+	obj = kasan_reset_tag(obj);
 	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
 }
 
-- 
2.34.1


