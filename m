Return-Path: <stable+bounces-93890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9309D1DF4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C6A282A50
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732513A24D;
	Tue, 19 Nov 2024 02:05:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2228E3F
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981954; cv=fail; b=I9wuPtsfhZibbWZytkQsbY7A1HD/TnBLYzf1z8SBwHu+zRlClhiJrTwHFx9BkCZ/LGFMS4kCxlrOUIl/yceQdpZwFSyb5Wpaw2aK1o5YtmwUZcAkCMDHrCZbSfm2Pq5qAgjKWvPdPL81nm00hLMnLvB3Oq8r8iqvIoEFiXSFaK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981954; c=relaxed/simple;
	bh=sxA7nERnbPxw/br4vg8LEDNbjlA9uf718+CuuZG5PzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGOpxmGu0XZItzP1IVocRchG/aquoWTAJa4Ge40kvejzR0sJn/Xe3GxRZzt31hNdroSe4llqKBb95IhD90xd0qxhxwIMUrkY2GGio/aMmxmRmouloMI8a8gTTXUbvXvF2CTEsmE/2tLXTm07iikjjirkl2O8N0kxI89UqeBHZQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0LZrY017413;
	Tue, 19 Nov 2024 02:05:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0jkdd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 02:05:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVIiAFlya04hMR62i28SLyP6pCGlwHfDSKhvB9kQ0gYu61HT1VEVyO5Qz6y5G/nkMkZAHhhgJhzKatN4SwwwhKe83ELd3bY2TWzZjEBub0QBAHuNo8HFPFfoAvVocD05cPdbwezfURCMVG1wUaR+xkeMqqF83mQgq7lEmiavDSt8AZ2WQR+CbKmAIADWRta7lecPKsVJyVAgw8HNwogCxiZm6B4RexiUDIMmViDUTwwJsCoA64YGTtgLV5yGrSwc6l0jwu90ef4y0RPYDZpStlYDXNTd4lLGd5aL4ghUV7WFMaGxcrvhAK2NNU46ixlEj2Nm4twn3LHWavrGTZGitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7TeM5mg2OOYPbBbW13OQ8Zmn+o05PbZwow43wZxCW4=;
 b=xthyYfpy84ExNK+EzT/CYz73tbnU1TQq9jKvO3knSTHSfcwMShZKhpL+vtyP9eiHDNYGgQyZRp5dcgASpXu7aCyr69xmxeSZLi55lHAJqYur5e8Le+UriTc2U/aU4yvOQwIRD1zT90uItf7m+kjOJ6vXGIGIasedG4/B8KZ6y89sgnjdOkTdt82wN71ju0N70+LI90UyaWkO3Ok4czJ3REEINVEzrvC49hhiZt2v8S4GxkDyq7YfgW/6ba+yMlyRupkvj8+SZ2W6AK64VDZ6J2Jj0k3kSu6J3ml8EK/09n+4sz19dqN8EgdPr1MxAMHW7saBy4Z/NWwHHgNRM8bB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 02:05:39 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:05:39 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 2/2] nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
Date: Tue, 19 Nov 2024 10:05:37 +0800
Message-ID: <20241119020537.3050784-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119020537.3050784-1-xiangyu.chen@eng.windriver.com>
References: <20241119020537.3050784-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cab430a-0796-4e66-5b9f-08dd083eaa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rRSZjsHVb3lGI9uTwCDjm+ptCo17LvLPlprf6WYlx+DL+QNFzx34teqaDZ/n?=
 =?us-ascii?Q?McUN6mS2ji0VG01rTPkD/JwHU3rV80xnlFGmJp9eR/VwBy/j3vrf+ELdPvhm?=
 =?us-ascii?Q?s7jgcXicqe2X9e37AQ2lfU5USGyITN7igdMPfAfqnXn+/pWwWCnkkf+uSrN9?=
 =?us-ascii?Q?jeBFRvZZwFB+ePACN4QhAu6kaV1nAdtQ3BRJLODYElUQGjJwNq3DVaZatTXV?=
 =?us-ascii?Q?M8zhwwai34xmWAexVzhgJFOYUhBg0P3FjzaaiUMXIaV/7JOjOljVKa2kFEF/?=
 =?us-ascii?Q?aAVYc4cz33GEzLg1crnWdR/BqJo2i1caAHmgdrL7ALWsZStJjUw3sm3GjmxC?=
 =?us-ascii?Q?pBWkknNFawAjpDN5YyU6GjuUbvY4+WFKFDSj0In6+g45APU4/Zb+R1ZYF6tD?=
 =?us-ascii?Q?mfRmJKc28K0pPir7ovykwxNa9ZCDId6WRcbe7pGzOypoDeplUvcbtAi4b4qi?=
 =?us-ascii?Q?ukEeFK9VUYGoK8M0p60FkAYZYZqnzwWhzXcIrytkgOvtJlpc9JWBt48sRpAF?=
 =?us-ascii?Q?m/IU92gjvAQbUqbyIeTDhHYv0bFkXCvufFLkIVFY50Qd+Yxca2zo3j+6nlwE?=
 =?us-ascii?Q?hTkcOEeiwXmObDVg+zh/aRac3ohsSsNvomZKEPX4pFLkxmYWv0FMYLUakSK4?=
 =?us-ascii?Q?zQAtIAFqXciwja4AEnX4dGiwe087o9XLemsVpNWiI4icUC4IbJYxKcwnTAj/?=
 =?us-ascii?Q?mxGRlVUoYgSAmHSSohgNY11SZZYrIcryWBJg1P1AF7dXubqpMK8AmNAxi32e?=
 =?us-ascii?Q?hjq9SQX67VQckrD4BAdIXLdkHJ3wILuoRdVriwEmbaoDNYwx1EvfBx17yi8w?=
 =?us-ascii?Q?htXsFeljdmhPhbZeAhRqHTXTNrXMca361hXFPSbiDrBLiPlf404yIAAQuoHG?=
 =?us-ascii?Q?qgOwfCQ3ngciEuSU5rDfdgFG96NE9pQJYOqY1UpR7yqZDBo7cSjT1tFSQqWI?=
 =?us-ascii?Q?FNkNm3BGVD4msrFcWJYHq4pUhDQBKzveL9QRy1uAYgsa+rh12zNO8vqAD+7s?=
 =?us-ascii?Q?TdcRRpY8inAeeincApTtdjp2jgO6RsWyGq3Itt5QV2eKGd3sc/MbNL+P8QKH?=
 =?us-ascii?Q?vz68VZ61x4nXODWEfPyuPYw/Cxoha1FLZ9IHj+01mHwMMJQzNpFc2dTvO5h7?=
 =?us-ascii?Q?IiFbynh/VSv54QVIgy1qGgaUhkbuhahuxIKpf+JN2aNoPpvVNurVLNPoW1ie?=
 =?us-ascii?Q?8BrojpmGHa5kxHiK7CsnDl2ip4tw1gWTUZJi0veHahx2Gck0VjDn+1xS/EKa?=
 =?us-ascii?Q?4lKy05Pwr4sfQN+bEUp0yO5cKvI2GdFvCkCzr+pMLdRn2sr2dzOdsW0vYe9E?=
 =?us-ascii?Q?Bf4MQ4jviGmkxun/xNckcct6bFkF/CyXchiLlvlw7zkBpnplmofmzr8elxv5?=
 =?us-ascii?Q?ABUOmaMsPTRJjKB8eCSZdP9MW3Zk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNVW5nc5ku8Q1PjQMS8waYVybossvg1LWzX/AtMtA2HK7k7/Se2Ou0mksPBh?=
 =?us-ascii?Q?m65fq+CvaI37puLmLp1MMPffR2vwWoixJAJe63RS3ObL9Ld07Ao3YDRM+haX?=
 =?us-ascii?Q?u3DAA+upfxOCSdhnl/wG0fL+9TwTJCJXvYjaCX6tgJoaz7rez9zwc6CtHTym?=
 =?us-ascii?Q?HViy1HgyNqLRxPYMxxyg+UuGHkKHgYN30o2o/fuMHAtk8gIImzGW3p3n46qV?=
 =?us-ascii?Q?zjCkorIVMupFXhtjQ85WKIipl/q3o4AXz5juCDVUiOXJkkNU7k0N9GRGylsJ?=
 =?us-ascii?Q?fZqBcYrnkyrQxCr1/Q+oYLvPCES2uZC4R6qZw5w12UT3BkUA/w7ZILKQM8kO?=
 =?us-ascii?Q?i+mdl1oYeQBFJDG5qobdZCBcAn2+Qm6Em+aF6hdvmpKtKID30Xcuk0G+3S5/?=
 =?us-ascii?Q?sxRwQKNxTMs0muSrvxWC30vt9nu/bp7bfX4KbAbfjgoGmW2zl/FGuM7hbbvS?=
 =?us-ascii?Q?RG3A2mdCKHy5j6i5jG1Vtj5iFgqUmZ7nurPQt++JGqyex+BCECfy01LI4Q/F?=
 =?us-ascii?Q?LhshTpSJd2cNp+4DoP+cze6/BrL4igHKb7McBjDNmXyhq6icWUnD1RULj6N0?=
 =?us-ascii?Q?ZHEztCnwpR9Rr0ic798eBoknEvTjFsyRDv5P9EOs2ZmSL6YBcR2Juglb8m0B?=
 =?us-ascii?Q?gIotzZtuitrRngsp2JA1p1Z0cCrSz8Ko/2bVww5xLEgpO/WyDBJ7RM4wNeca?=
 =?us-ascii?Q?kGLgKwibMh1cIdqW+Z28trBuQCZD0cBapP1Sb6H78c9BduG3FqdXh8bX8qZU?=
 =?us-ascii?Q?3mLhohUxSbh127OQVX6GiYVY22HNab7ynZIsfGsK8i62So+ncuRToO7Jslwf?=
 =?us-ascii?Q?i+uC7poWrl0qLEhHefPt9O2fEnWO8w7JoMDGUYGC1gciGnPD7LCIeoeGqzaL?=
 =?us-ascii?Q?7Q/w35B0l9g8JUHzWUlyIqpC80T1Xngt72bjd+QnK7a6D0F5z9/inIHnuQuV?=
 =?us-ascii?Q?3ln7ekRj5jNKbyps0E9nGSDPDdZMTogad2UayxkvECzzyxzruN1UkimVL6KD?=
 =?us-ascii?Q?2FMO9r6yI5ikhSeGq0LO5GThpugwZeqmbqcRcFvboVpBcFb4Ojl4+qKFbXtq?=
 =?us-ascii?Q?ni/Hv0O005TdpjtXATMH7zKn7EbsbJLnC/S8435rLHyKn4vAc2awZohrpe6n?=
 =?us-ascii?Q?pnA3gSKsm158UGPdXQByK7nwqaZbzlZx9ymI7OJ34rklygaPWHgM/TVzgyTZ?=
 =?us-ascii?Q?dOwjj/cn0BHHcWKs3t8CkkOHY7Fp3xcJi6p2b1BSaOgcQe0EM4JLSXMYzZOP?=
 =?us-ascii?Q?UB5F8eWUejM6fGIZKCN+FP3X2AbCbRWH8labtmZ4wdq21q9hAU7rUOyUj+ph?=
 =?us-ascii?Q?eY1Z2iLsvxsFPZu54UUBb5u/5UTzhJBfuWjbIVB6iokjOcPjAiVGW91s3Ohf?=
 =?us-ascii?Q?mRbTEPzC37b9I6ek/XAc1Z+WEwAoLnDhdl8Wi0r3/ONHjKMYj03xxa0ZoUQR?=
 =?us-ascii?Q?7aeMnVdyP2ut+spwwCWYVZj0t8G006yl+a/mAGPbJPD05Nud8u7biC81OtCq?=
 =?us-ascii?Q?ngfQvvhCc94r2m20VkzhtLpSItwhGlmpz8IXLN6J6J2zNpR4pM62QYU+wath?=
 =?us-ascii?Q?z8C72teTAfoNqLkvCvlQQyM/Qe9Z7FE1K6HuQzBVdJxOpRdi7Lq1U2kyr1ie?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cab430a-0796-4e66-5b9f-08dd083eaa30
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:05:39.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9XEXRRTbzipme9VLTX2YFML5rhFkHNmkG1lF6n7l+PH86MopWv1l1icwBrMTafLNXgJk70yAiKq2eT5Dr8GnRZU2vgqkrk+jSxKQVBryWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-Proofpoint-ORIG-GUID: _nFu1oew3BDi6MFpQvXWSmPIxfrXur4k
X-Proofpoint-GUID: _nFu1oew3BDi6MFpQvXWSmPIxfrXur4k
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673bf276 cx=c_pps a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8 a=Gz7qLUFqPZwjRbxhgtEA:9 a=_sbA2Q-Kp09kWB8D3iXc:22 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190017

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7a87441c9651ba37842f4809224aca13a554a26f ]

syzbot reported unsafe calls to copy_from_sockptr() [1]

Use copy_safe_from_sockptr() instead.

[1]

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
Read of size 4 at addr ffff88801caa1ec3 by task syz-executor459/5078

CPU: 0 PID: 5078 Comm: syz-executor459 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
  do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7fac07fd89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff660eb788 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7fac07fd89
RDX: 0000000000000000 RSI: 0000000000000118 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020000a80 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240408082845.3957374-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/nfc/llcp_sock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..cd0fd26196b8 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -252,10 +252,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_RW) {
 			err = -EINVAL;
@@ -274,10 +274,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_MIUX) {
 			err = -EINVAL;
-- 
2.43.0


