Return-Path: <stable+bounces-132816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22205A8ADAD
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2182817DEF8
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302C20E6F3;
	Wed, 16 Apr 2025 01:51:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CA30100;
	Wed, 16 Apr 2025 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768288; cv=fail; b=GNYLbWmOWG20R94CJH2i+feOfsZPaTl9QjzPNKQ6V6Q1odRxVy5CRTXH4q7Cyeb6GO/SAZBH9g9WjYkMwonuINcRUSyA9KQFXlLod036438SxLn8c/xCYrd+YjpnKw6/EsLSSLsBkVUNFAtuUA7+FNGpcWktrf4zhTcUvL9JjVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768288; c=relaxed/simple;
	bh=6bFG08P+r434+SpbgxvCjBpgNOWynXem1uKkczj+pwc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bK42mhEbQhIHMExeOwJvP/unGKcDrj87frEFfeGrnUcmI+J4BQAGrdPUa0QMqTJDu7TYLeX8PokXobV0xMcG9PNFu0NXgkusNfqY3DENwQsesDr7EQhjfhAXdC2YmNHoDH3ILtg8eSeXu4Eh5GXRyTOijWOmAbrrCrNXg6m6bNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FMgT12025731;
	Tue, 15 Apr 2025 18:51:23 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkkwve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 18:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn3aLM3ZGtcMMHIsh3IEhbErz+enIbajjx2mqGXrxwDlTsVXB2YBphNE1WoMAapYiEaU1z40jT9ul+ABD5TeIHIF5DZf/NHzUJ6s6LtW6+WlaIPYBpD4aBnjDPcarrymSmBgx60jfJxcvJh7j9aVvC7eXkNrAHZts8ySd4fHx3qrOdc2gLRYm6zCDbhoK8irugpsl7ikddJbVnQu+yYcaJE7CNnov5xpncyVftILGKpC1UCZPim6jGJUTqLIiKG+0y3UU3xCW+x/qT+faxjGRztd8iKdykGyg4ISKjZfI2Hu44dkQ6jx8RM8881BBK3/XeqL0E1K+XIdbGHFhVc4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeyfpWqfB3y5lQXPsZ9cN6EZkl3eDUWbKCJMy4I3nNE=;
 b=GKHn+6Qbp87L2hEKA6p+4bynkfBV+QjKaAusq+u5QaG9Zh3gJxJwY3T1W1KlCKHMJtbj6M+AuGlSn2MNN6Hd7y6V3G5XH8L2u5GtJRrHzUTuV9xAhCIdvE4NsnpUy4BsUR1qXHBqmZhaCIUaxaqnB0Apbfl+KufJTsWOh0h28Y7iajNbPcue8gNDcLucmzp0Ona8vEuauy9X83hcVNu/mVRdi9eD502HyGQh5w5L0rQnIXdzYzuiXTot3JDcs65ysUzpe1ES/zAhKCmamg3qGbg7W9G3gaA1eXO9X6SO1LSrZ21dwNCfQA1e1RkeVBrJF+69NkmwY6q32jZQp+cUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from DM6PR11MB3324.namprd11.prod.outlook.com (2603:10b6:5:59::15) by
 BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 01:51:20 +0000
Received: from DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039]) by DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039%4]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 01:51:20 +0000
From: Zhi Yang <Zhi.Yang@eng.windriver.com>
To: stable@vger.kernel.org, peili.dev@gmail.com
Cc: xiangyu.chen@windriver.com, zhe.he@windriver.com, shaggy@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Wed, 16 Apr 2025 09:51:06 +0800
Message-Id: <20250416015106.1714709-1-Zhi.Yang@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::11) To DM6PR11MB3324.namprd11.prod.outlook.com
 (2603:10b6:5:59::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3324:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c56236e-63c8-4fdc-be18-08dd7c892f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntKXFfqGo3Hj+z0fj8mXttQKQ6+FcJNom9qNeqZkvtKAQItI4/myRaA/JpjT?=
 =?us-ascii?Q?/2sh+hp/oSsHhhB6XTN/biAM0MurAQgtnDOvE1ZIVqXvYGzPfoh92YdYrNVa?=
 =?us-ascii?Q?tM0bUY2QDcdUj9iXhlzZ0s+vdSjMJKhwvIrZzLMwsugnCYaRSEgDvXC1CPDm?=
 =?us-ascii?Q?VeA6M3CSqpfvjjRr5wg2jFsqm4zQH00zd13bV0xaZCQ21uURZE/NO71TmTVp?=
 =?us-ascii?Q?4oK61bFG+tDb3VMUuYtAo+I+g417dDH70meWwNYJjmP2uS/oupZdaiMuu0oM?=
 =?us-ascii?Q?28PNI9lTH3+thoJpYhU3yQOhR7ggVo7+WDyyP6/o9fDOHHcxu2Ob2xbDb6lN?=
 =?us-ascii?Q?rpYRj/p1o47eUJaqvNbOkyrKpe8XjjPtyulAx1kTaRmqvdzGGAQjmhUhEt3T?=
 =?us-ascii?Q?rCjvOJb9nc5d6SUQsP4q46/WSvrqrCQFwSNm75Pxa3IM6JU5yTiU1528v5G3?=
 =?us-ascii?Q?oJS2UGau+sE0s+g9UByQHs2rUpfvwVtebc2s1XBBfjBEo1GmOvfKKPSGbQz4?=
 =?us-ascii?Q?7oakjwsEs1sd4IgRq2AVMJH5I7o5YMR98A6280wGQteyZt0F6EzV9gWjjm30?=
 =?us-ascii?Q?uathRqMIDmBTXuS537Sc3/fpjCfQ+2vHwfkmt5jh9IOojssdP+IYCkCM3D9R?=
 =?us-ascii?Q?kVJ8eklBcXRo28zgQJNxSeCyq8Jpou+sKkk6T6ptGAMlM4bWgTjHRgYYUSLB?=
 =?us-ascii?Q?Ai60boTRyIfPqNo4/iuQte1nArI7SYGhOdeu9aIn9MyoBMCYRU3eIBozquMq?=
 =?us-ascii?Q?cLQlfqcDDH3lK0oeButSyPU+g36uwUyZaWBnYHURRGIXjZkwC4GxkMskiLe8?=
 =?us-ascii?Q?Ym4UHGV5pD8ngsV1bo7QyeE82sMNHpi6N9Hs/oWMpvRInKhbY2siDPB+4uPZ?=
 =?us-ascii?Q?c85Lrc1+c7U8rTqTpP1Qr8Zf5+W0meTyhyuPzIW/zPVap0vIF88ObYEWAHvo?=
 =?us-ascii?Q?CVCQLmlQ4Ze6Smd+QEv74/NDDbQQ+e48oATwFtoGDScfUGwbUFadh/ZrPbWW?=
 =?us-ascii?Q?u5kQf3A7qZWWWtACFTt9Zq4l7gTE3yJ4qfcXSh0LlkL7yKyp/upVxSeYpUDX?=
 =?us-ascii?Q?+WgdDLu0aThI4SM4JHP90XoMVmS2sTdsCsIQOCmV6K+UViA3MmA1jxQUhSjX?=
 =?us-ascii?Q?FP7C1bBIwOLArCZNWOZueWVIGTg+Vj0XATsX1Lyf3E61Mi9wjmtINMhaM3sn?=
 =?us-ascii?Q?kG84nqQDZmkMDLyMG85CCDWU8zxVa5thcpB0xgIbPz9gyfJp0zyQPGYfS2Va?=
 =?us-ascii?Q?J6BCXUN6ok52VR//lA3j9/H4MUo573WDeMm8OBkr6XUG+nfQj5FtOiS8uHgm?=
 =?us-ascii?Q?7QxQlk9O3svXYFP0SXoM/pVLZ0LeAMszZ1C+3wqFk1AnyxVvJ3gPTtbKps+6?=
 =?us-ascii?Q?7ImlkLgMQkyB1AGHXQTGOoyRVgPZ+madpfI4o0j9M62GJS8ViCvqoSKpnE/I?=
 =?us-ascii?Q?udJbrfnN5B0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3324.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4YIHCwKHcDmeooawlumQZ8t8tqoZAEWJn9KBsbu4YQJ0C+8e1lZxvXbVZ3s?=
 =?us-ascii?Q?tGKOApXvRXdsg/4pA7gIYPcl9vEf487RJmjcA3dzUhyOpEOj9nPzaAIGw4OJ?=
 =?us-ascii?Q?oz6wyC72DKshpwgRXqALmQQSbaGI8bVb8NAA96BUX6K5KRHZ8n8BikZdaFHt?=
 =?us-ascii?Q?GitJskoLftFrKLj64aPpjHi1r4VuTMl0d+w3l2EbiXUJ00FNRhBZm9ALr9X8?=
 =?us-ascii?Q?zvrPgy6dSEjtlmLWW8qhMqseOGFdzkBZZVMVGJF/Jlr2PHJXxNgDKCvB57f1?=
 =?us-ascii?Q?auA1ymD5LWt8oxkqc9tKH3PtpGGlUNT+lJxhY4y2MMTTqTGemDA8m/2DmVCW?=
 =?us-ascii?Q?ZGnQXqKROHsBAaUBmtJfmQaKPTQ8uI8xq3DuE+aMk2gF0HxsGf8rrFKTKXvC?=
 =?us-ascii?Q?Tiq9o8zTb8/sdYGQgZFL945trhZdigXfwtgLXYVE/DKkL465ATtOFWMpgPOs?=
 =?us-ascii?Q?Ii0iv7rH2Wm+ek11wLSC8Ro3EZzJFglfK4NAVwbbTVVprkfp3odtLWKs3fOP?=
 =?us-ascii?Q?qC37nURiOjf5GhXsZAMo+joBQQ12I0jz31T7pADq7zKwqjYmsRuUi1hqs93e?=
 =?us-ascii?Q?i+YmxPzrqIxyNXpn8ynujA/++gqsOFrqJ3s4GJ7wAFt2sYYWjhKi/5NBMGoU?=
 =?us-ascii?Q?7SW/nKjJCMkkQ4GzgBnX4RuJvi1xn8Go84gDA2BZ9t6hgqg/Ubizh/V2RPxD?=
 =?us-ascii?Q?3LChTonHPudLijSPfOQt4oX/8T1QLxsxUa5hueX7Z2NoZJK6pDBTg3ZxS7UZ?=
 =?us-ascii?Q?7upgwHT3JcFtx5erlurQna7bSXOJMmKU7wOXeM6Qx9oD5pbGsjALWIIyltlv?=
 =?us-ascii?Q?oLl9tSmGkEIXWyXbaJc9adFmyxORP/5ILwwxB78EKYDWlEXgX53rLiwQbb9R?=
 =?us-ascii?Q?/MGbmAN5DUY/GB8iG4ZWRqiBRHUExyc178j7YXes/8tWpNQHT1d8jQM4YDJR?=
 =?us-ascii?Q?cOGdacf4Z9R6SxBEpyvaGi1L/chOCA0nFi3OkjorP/pDmhw0tqUy5u9/kWBI?=
 =?us-ascii?Q?i3kJEqpJjWYkoYUoAISlEp8OL1JoYTS71XXPhtSBN9x3ii5bCBYm8ugW09Sy?=
 =?us-ascii?Q?JOlQbMlIwfoJ3nBTaSMQKZBX+jhkAGRsbtpdw/2s7pin3M/V+5w2WoXALKNR?=
 =?us-ascii?Q?JPDfjddr7fAPnfyHZt9nN94L7NGxR+epjuUleqcqbKiGEggbpKa/oztx+9wi?=
 =?us-ascii?Q?LNuJGtRqoKbM7vLTig3AiMBRCwFtTU5hxD0Gk15xmMm1aUJmZSNdnyEa8HYe?=
 =?us-ascii?Q?AaCfTzL3TNIJG6U6oOnJrH6kN/rBJoGD6htT6JDtCg5xm35IpqqvNg9garwe?=
 =?us-ascii?Q?KgDVCfo581rZpi/aCeZvQlnUoSpHFtbgfMENPSIrf1AGUFQtpqGapnkQjQK+?=
 =?us-ascii?Q?kYScjgE7RfEHkbD4cp92VgX/2fTBYv/yA5UxjydbZatc/hL3buMEcRbam8Mc?=
 =?us-ascii?Q?wd3NYxN60AxA1SFz4fNLG8kPHFC5BlWLjbRT188q/DiqOaRifPnwuXQe+WGP?=
 =?us-ascii?Q?DQCeKR2YdVxwXJtXcrynvvi3foCqFUUz0wGodyWoCCty9xec6hV/QB1afeEV?=
 =?us-ascii?Q?ATi7s9wLCmSVGiq3xPnB1/9AWAWwuB0qR55aQMJ3?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c56236e-63c8-4fdc-be18-08dd7c892f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3324.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 01:51:20.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of5l1p6PeWbTMCWYKvTkPO57ySnVaKYlxy0JBiT2X5KgCvDUsQ5lt/whm2XLLwABDuDTlGs8k95ylKii5+IbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-Proofpoint-ORIG-GUID: XMmWu3CskkMVwHNepCRf0IpOOPlXsGEb
X-Proofpoint-GUID: XMmWu3CskkMVwHNepCRf0IpOOPlXsGEb
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=67ff0d1a cx=c_pps a=2TzYObwzRp/N0knVItohZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=03eq-TzXFGS1sWTFOaYA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160013

From: Pei Li <peili.dev@gmail.com>

commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 upstream.

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index ef220709c7f5..ce2b18337a20 100644
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


