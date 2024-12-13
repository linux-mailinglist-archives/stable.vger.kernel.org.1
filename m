Return-Path: <stable+bounces-103966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD629F0448
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 06:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5675B1883254
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 05:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513C154BE3;
	Fri, 13 Dec 2024 05:45:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AB18A6B7
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068722; cv=fail; b=H6BVyFId7vdHdHmgeftU7QQVZQpbGn12NX3CAY/vQtms5+vUpVL13yLRXEKSRVXml1m+gDqtT303qAEVwEsxs+R8sNF51YMFFphwkdofdMV4ElQqTPtKcxvxyBRse442QMQXXLwv/hNab9rgdhfMo+uUIYHGco1GK/M9ZmCXFZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068722; c=relaxed/simple;
	bh=kykV+ZK8wIp7GVVfb5FTnuGpgEZsx7Cn/ehpmQbL2Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tw6LgkzuGmuiIHTSFt3gUp+XImmVm4FlM70FxbF2MXoQczjm4XsNhKtktVxyyNPFKRET+cLaXHOqApC1zqQBfMKk9lAbicHeMD8EKZaQk8HUr8NO4VscghSR6OdgPhgdQwuPYI/1c6yBJ7jbKwuTlDiuAT7Ntwox5DRv9RyqhTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD5hvtF002292;
	Fri, 13 Dec 2024 05:45:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xeqf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 05:45:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMgpVbr4XhX7JovWoPlqgfj04JFOv5Nf2LgVxnQwSO3eR48fxOBfDJAxkoz16pKTewyOkAH8uHONgdExdkQyJKkE4jSEY5gQNWHTyglm3HEYx2eJbDZIye7gtzSrqtTtx26Zx1vdlh4TIrlCNfy8JvOGn/D4FF4AF23dTHU7wZqbv7sL3DyQVjtdxUXCywhCYirjhQpIbHepvRYlCTc+OELuBzXxU7MP/g/nhFvtQA5dnUydZaxh1FyczC3bo9/aJfH1LLb/fJaBvqq/VP+qXw2f4LwXP10n/lrgwpN5tFAptCGf9iQRcETXEn8FYFd4ltB0gccAmQIBnJR6l6Ip9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeMxMibuJp5QxQupE2hYxaBsSMXqNDm1Uxnojc9EfqI=;
 b=XZrN2ExQWmAmtdsLYqpkHieeuw1lYPoGcqPuQb8+KNvbrgnrZ+0eJ1aYTtBVLGiXUvyPBMyxV12teClmrtXXrJy70airCXwnGByWp5B2Fo9Yo8D6OR2ZU+pd1064hC8h1yseDHHecAPYc5N8X4isLk494j0ON+lkXyjGu8+OJqdN6UWV5m5dzInYcmQDjSKro5V+iKPCJ4dp2jO7WeSjpPsJ5Gk46RYVOJEMxA24L2j5k9g/N1zERfU1g2lpeain73fEztSonn3Fx9XzH8Zipk+0yweTBCPgcn6sFK8wuTaJUUt0UXTmCzL2lFlFuMCkdj54xzx5hfPptJObq/pIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 05:45:13 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 05:45:13 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: peili.dev@gmail.com, dave.kleikamp@oracle.com
Subject: [PATCH 5.15] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Fri, 13 Dec 2024 13:43:50 +0800
Message-Id: <20241213054350.3113655-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 714c8272-f42b-47e7-d9e3-08dd1b395051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMmnaeeD+FMCuJDjNFTuaYz64s7T1CDiPaHhCAs6J42X9EgWkLqPQ8u0WGfH?=
 =?us-ascii?Q?KloBx9SnWrypTRLLNsMd0fYBokIJE4eEwx/Uvg4IfoFf9RWbVKYgCXacFznA?=
 =?us-ascii?Q?fH0otlnNpicdBuua7w0jMRLjmvBEMUw1bFaIi7fyCD23VR/umDc8PqEcpesd?=
 =?us-ascii?Q?1/FANJdiCsomsZM6HTvG1MoF1DaIsvonDKWzQUuaeXlePVu+PFV6WbBd71Yk?=
 =?us-ascii?Q?YCA/DXB2Fyk7OXhGHSBRIWtURQ30WLrPJ+gfA5wjEuRPEJi10D59iCLC70ys?=
 =?us-ascii?Q?u2LKDp+YwhxbB77FezXeTXuq4I74YRZas5dlgm13t164PBdeg1va8EkittaY?=
 =?us-ascii?Q?UFC5gTSy46PYbTcv1aMmhSQJoFvSjDgoB3JBg3SYopIKdMTvV6a1lZi3eY1R?=
 =?us-ascii?Q?1AKmeilOK7eMdcHqXMt0SKINnw/Kv/Ejknpt6G83pDDexCxnTi7jFL2XRK89?=
 =?us-ascii?Q?A5Eg1zYht3T+h6bB1gXFDUguxwf8tVEDFWEiWSzdheWh7PRPlH/7pSi72s4t?=
 =?us-ascii?Q?qgPOMisV65c355hh17FJE4JFQYadpOwSNEzn82Uv5n2ak9eg4s+WYtt/ggNl?=
 =?us-ascii?Q?G9DREPMgx52KkU5Z/MaVSsFH0VjR69mjyw0PvttuThWbzsPnc7NY58xsJ092?=
 =?us-ascii?Q?NNELlnn1smqthkY8mGR2TCWJhOafFJFwNkvW4ddYt2OFgkm1tUY+Q5ra/TPz?=
 =?us-ascii?Q?SXcv/ApddIjpXsF1NTS1DpIkZfLGWqXt01D6dDhvSF9CX0mI87/caibmwbtT?=
 =?us-ascii?Q?Hudyp86WLWsNqYUC4tdSP7Emu0HwdM7YvFugg+LCNfNkAqaqKuEaD17M2mWz?=
 =?us-ascii?Q?OIWmE90NbmJV9XWMLtv29pWWNQHMGtDxeXneWtAQ3dGJbqTS3Zrel5UfxPgK?=
 =?us-ascii?Q?+MEn2Z84d7BwfXN8MKNDR21yjjqjmj29pYcFsbYJCh270bL3pQQ19GUw9flz?=
 =?us-ascii?Q?4LOxDK452DqdH16AOYPiItA+nbD9jsItXhPjQFEVYZv6sZxb6NMm8cr9OtTF?=
 =?us-ascii?Q?6VWDbZjlLyJPuRIr8T2eCAza1z5ZwoOf9x7XzIH72Z8Tn08IEnm67kmhizHy?=
 =?us-ascii?Q?zVpDHrZeDmHsvJu7eRiJMePLkAnbvw11bnuz7FeMAwIOG946c5hDjPEY8wPe?=
 =?us-ascii?Q?jCuvgIXGDHB+rxcydG6c7Oi58NThyYiJ/JOeye1MLvPH2tqXkn7v4NTGhtIg?=
 =?us-ascii?Q?O1kdBd19SH71EhpORuyICLDi9rFi/ylpsUVGVWcXRVPECHYj2LaO8eFTbLBo?=
 =?us-ascii?Q?Nop/6PA2K0mHJfikiohLAQrih1nOGN1p5IQ8q+FWnUWyEkLqlFhoVw34nG3D?=
 =?us-ascii?Q?kXG7S5A/6BL0qZddkwWvE0Z8HW/r33tqb7n5YKcU/MdvJRYvDaPveCQxAyBl?=
 =?us-ascii?Q?aUQaU3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B6qcV5G4gqtL35U/pIVB4vtZVbiF1r14MdDIkbtuvjodxzZC6ebtggjjajau?=
 =?us-ascii?Q?v1vOSufQtJ+Xo8gn7LZKf/G6Krv/+0rzZVoKYxZpjQt3tshfdfZSlFGEjLEv?=
 =?us-ascii?Q?NAFqBIpdmWgmzK9W4Mow7OaFd81Xm5ateqxcrkBgWEEPP5zoXHTi8YITtap8?=
 =?us-ascii?Q?PMPsKqwqh9xlNd2mcYjSYM7p+z/K8kN1hXwRRGaO/KJf3srEksstnnz/+p7U?=
 =?us-ascii?Q?UCB+CFYioF3IFTymFaWNEr46qCKHjVj9exzyZdodyBMzo1tt27xyaTgn1x0r?=
 =?us-ascii?Q?I0f8rAwPkpwENtdRc/HgmzzpquEz6+npxskltysT9jny3nHfzSB7l4j9uqzD?=
 =?us-ascii?Q?ESsM3Kj7ldxcE/DNEDMJ5rXLEUG3IfHuGmx7h7imKaN4T0X3ypHDDM/fjEjr?=
 =?us-ascii?Q?o6sGz20U7Yg3HHM3bMVPG+ccs0pqEPc7e1yCDmTMkbzOuaIh+vV8r9VeMDUQ?=
 =?us-ascii?Q?vZIdW7Y9f0tzRjtq0JbFPZjteZE2X6VJrY3eOAPbfx9xVlxJJ6DOfEW34Agz?=
 =?us-ascii?Q?diPfXzPlDMxKCGiReKS/y/Lg3tMl4nhZINK9ju3Q+wjmX/2yrPkSYRtxKeWT?=
 =?us-ascii?Q?F59EKC2YJBgBgSVKz/nq6NVgSZb/hvVLFgXTe5tzCY222BpVMcdEpkx9P6NM?=
 =?us-ascii?Q?/IFsewC5FKCsB5VxVzu14S2zK3SH2OeI1r8KJUGGsxod/4TcyMZkqbUCfuws?=
 =?us-ascii?Q?tk2xVG1RWyXVA1Uq4LC08SPz9iqssDmoPrZKYpOjSVEA0mTeOV/ciI8Wig7e?=
 =?us-ascii?Q?tBhqCVBTqdHeYtG6/6NgVO8FH2g+a9ZqC3ChbmXTKrmHe2EormJDsgG3aZOD?=
 =?us-ascii?Q?XGmTQ4aYo1bTV/N6AM4KNho+65IJggjaLvEhnAq57kuMUHTvHIvmfa/BmN2x?=
 =?us-ascii?Q?nswIjPYVxyI+olprw7jd4YNiZthEE2bHZ69keaIozck/6MULd8wWGcm2705n?=
 =?us-ascii?Q?vtyK+d3k5QQxKx4HradZ1makWUFhImR8GE4SVKuyvFtzUHBu9Zx9zOGWN4qA?=
 =?us-ascii?Q?J4P5VRVgUufDb+DgAKRZR9Bq8NJcCi9syF1YQFJvdaDRWtyAD25D2s3/X5g2?=
 =?us-ascii?Q?4dixIQSlN4oTHP0zWFsVimuC2UVnmzY8luDjgGAOk7MLtuU6JY/zZV1Sw1Hl?=
 =?us-ascii?Q?asGoyaTVECI/ZpDKkiXwAMyKGdxTxMenStcd/jbg2lELMQtT/gl8auFdEfmG?=
 =?us-ascii?Q?47S4Q3GxWXGxoUkpvIlU0t+d5ipRcWKZ9+zYJWzZYsbr+pkjCX/Plr8kI8V6?=
 =?us-ascii?Q?iMtjSGRxBhNU3+1jXgchEvHWbb4YNa3zdEE/M9Q+uK6B7RhlJ5WrUTBVT5wl?=
 =?us-ascii?Q?Yojtju6n+nzO6Zr7f60UOcSyuKNAfkueh15MBxKRo67oR+4xHeXcw3jevgAk?=
 =?us-ascii?Q?cs799FqmizXPRvC69aCqfuZIymRsjZtXmqGwjbfOUD8agZSwiXD8mJu2lVSe?=
 =?us-ascii?Q?KWG4mGKYxv7anXD7IGkn2U7h48x7k4DPz8/0Pz2pJdCVwzT1tc7RVnDn271S?=
 =?us-ascii?Q?lUlwjabGzr4QxZW4lJY3EPLy+rGsAEqmuvzOyW/37EnxbD53hSNruJsxzQvz?=
 =?us-ascii?Q?N124d50kSiUYsI9eit2rDSWnoQs2jWZkDWqB7l9fQ8Keqe6rR8hM0rOfpSPb?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714c8272-f42b-47e7-d9e3-08dd1b395051
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 05:45:13.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPyW/IrX+hPRbam4AgE2Rd0jnkKSQNyHkxN/IZWFgHxuJ63s0cKnafvRgKLvNaByLaZnKrFpsO5A8QeKD832fqB5rizLu7QLsHww/gWxrV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-Proofpoint-GUID: p6d7yu8agKiGHjRtG3JPKOJZuHYv_IC_
X-Proofpoint-ORIG-GUID: p6d7yu8agKiGHjRtG3JPKOJZuHYv_IC_
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675bc9ec cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=03eq-TzXFGS1sWTFOaYA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_02,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=965 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412130041

From: Pei Li <peili.dev@gmail.com>

[ Upstream commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 ]

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 3fa78e5f9b21..2906c95e837a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1694,6 +1694,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
-- 
2.34.1


