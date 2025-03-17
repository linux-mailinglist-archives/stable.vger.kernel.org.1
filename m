Return-Path: <stable+bounces-124602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F0BA64239
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FFB1890B4C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3B2185A8;
	Mon, 17 Mar 2025 06:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890E219A67
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194501; cv=fail; b=EzAJdLto0pKzxOLFxHZN/GrK48rrqbjuUBfmiyVE6+U1TKMXAFcQSsr8Xryg3DHHxQ+T+9D6lV6K4Zt3HWNU9+XqQiHRkers36GvLgamwOs1L/a9J8zOMeGwftj6s06pwBvYwrSgrI1xPcMZorYIdTD+7Z5uDY3+sNV/gh5jSEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194501; c=relaxed/simple;
	bh=XjHf6h6t4rzshEoLSmGOyne+u41Lw3SuhUEq1hxoxnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Du70sXovfhJC2dkh86CzaR9+F8BfGkr62sMWj+sBIelxjTU5QaLUX8EL2PFgVomDF+QjD01v58ZS99/qNSalbDMaeUTYmnabRahkEF48xHOT6qq0iIhDiv9QocpLRimvn1d2y2AoffUoDLG+5ncnP9C9Snm9d9YZw7hgIXBAxWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H5fJKZ031432;
	Sun, 16 Mar 2025 23:54:49 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d4u41j8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Mar 2025 23:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMcfQ7bb1elpjoV9v644Tsoo0TGmN8IG/RFuO/EE0tWKcyH4jljjfQuLoSaT3v7eEaC2T9KKhGiB2Afe6vlRo0OiK1hPQLGBhphMtZZ8ANXCg75e9rSC5PkV9bVRIeEog+xWf8ziEyx6lBP8aah34o0I9mRKy49XzO+1Wqc71esee68zJnG0IdMXMzAtlm7T1MlHoK11Bh/1lnFFgea0HeFN6JUR0oV26AkRvqcFGU3NI5KRqTAJXeG21GbSLssMj2tWYhZd1jQm2iKiCpRWf4oLtj9CjZwZU9uYaCerWihjofOgVkGmOKk2JIB900ikZ5sie/b7VzMQUV+rNxmKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/24sg9Zx3TiZg3IVKB3N+W26m1x9u+AYrmskSsl6lg=;
 b=WljcZSOTN1wC8ynB7h1GCU9uW4JVxqtCW8oErMaDWdtVoy5y5qrp8dH3PH+H7kmV2Hyco/o7k1YrA6rIWxnVViMRV0hIx299EAsWRWse7Fp5noFNtSLFrZs8DCr1pQEpBAmPa2WedeG/OWGzluDWeOKXf+TN1YE4zQYOLK2YHvxvDY9kXe2vHSkx0gueRHDroz811rktRrz61inaFVaW7rIrOZM29lrwLI9ZE+ZwIMGtV8ySVcPIReOk07snxGBYqp4/doRz72KMMsJ9WHKoUigma8v+ZedSm/3K9D8yiSwb4rdVJJRNkv2dJzEm3CrlfUdGUE29zYiXefQYdUXIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7406.namprd11.prod.outlook.com (2603:10b6:8:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:54:45 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:54:44 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: mqaio@linux.alibaba.com, mhiramat@kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, zhe.he@windriver.com
Subject: [RFC PATCH 5.15/5.10] uprobe: avoid out-of-bounds memory access of fetching args
Date: Mon, 17 Mar 2025 14:54:29 +0800
Message-Id: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 342a4e9a-54e6-43ef-be65-08dd65209989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnbY3a+mHU9CqzImPfmKbmPbdsmOucFQGKs7KE8/rsWlr5KHC25sgQdiWyYl?=
 =?us-ascii?Q?+MHwhmjjLJoXWWDErQ7+fnh6meDZPLEdqjOMoX8Z23H103Z97HA7KpdvyeQH?=
 =?us-ascii?Q?9IUe1SCgmxDzOdHBDg2W0XK/gSQxji3pR6VonljP2mng7t9qmT+7btMcigjs?=
 =?us-ascii?Q?0RUkKNSpriEEI7IfoJA7HV8nNBzkUEs4GvWzB6M46tlHULt0s82Ix+iJWUpA?=
 =?us-ascii?Q?EQBOqVY0CNto+3FXywbWeVMkLj+Ghk/O/aV6tMZHzFZp0maiRSdSThyu5DFm?=
 =?us-ascii?Q?2xVf9rkKO8hqHitbJEUef55o3OeqPdaWzh58oloOD7hOyXrz/R7HtkmrBCXJ?=
 =?us-ascii?Q?7wzC4RD1VmBl0hpffzgKUS5CA5B+M6xRk5XRgQIFMFWMwP6Tu1tKCmM7p2a3?=
 =?us-ascii?Q?UAgcae6n/ozq9iVATuycat6UPQssjzZ787gKPRCpLW9WTM+d32Tbf6WYOyu7?=
 =?us-ascii?Q?LLOMmMVLwSpsx0I2EUI4vqmtDjvWvWy6Bp7GKI7r34NCq/pSYXWfgqSSaItZ?=
 =?us-ascii?Q?9Ho4ZKjwEOcTEN/ng2YM44pP6KUSaQP+0/4fDSw8lSgOoDDvSfoGAbsh6nKz?=
 =?us-ascii?Q?ezQzJ32Nh8hLTDkUsxlH1wK5HInMnSMj51kxIjmIhd5g6dgLMqh6Wi9mTAAE?=
 =?us-ascii?Q?RhPNshSHPORsvId9QzsfH1X4ZvFj+HRIYJsOJ1p9nRd/KnyZW1eseh8i2Ad1?=
 =?us-ascii?Q?4SxEUUtml7Td7DNmpDCVabALZIyEN7s7Hpzzrot4nrmriNoJBjEcbPil9RBm?=
 =?us-ascii?Q?SeeBaP1SLMIySQXE52I6PX5ELNoHAIEnH+Ejec6vSJFYrMy/XVLk7SddVRGH?=
 =?us-ascii?Q?h91BozDle1oFD/VhYAAB1My5u2jBzjWs5boqL74yzX/+vhVI4QTo2YPP5GFG?=
 =?us-ascii?Q?6++y2l8NUZPootRNuKtXGLOhnm58OS7kx8eFPtNDEeifA6A2pS2OpsXlmI+H?=
 =?us-ascii?Q?/KqozrxXXgDNfivxzLWDmcMS9d8sMs+rL8n+iy/0L6rl1j2gLi+B5H0Cj/Sp?=
 =?us-ascii?Q?106I6O3xTl0a0nrpg4Rfje8/sqJSm/uUTGQ+38zXyxat5WkGsp6+fOWR4p/V?=
 =?us-ascii?Q?mReuDa2LAgv4see0sBzHx1CRNMbCuqY1ItVqB3Ppeysq7cSyc7K+/X3Ermqs?=
 =?us-ascii?Q?NyG068Bg1ZTrNavV0MiwFwJstDF/d4P7RpcUsLyWm3ijrogsC9t5zEZEHX4v?=
 =?us-ascii?Q?q1JgYfgvUJMpsKEc8Mej0qaF9fJjWctDCohA1DX8gq+aZVgQ2VqBaXk+05+L?=
 =?us-ascii?Q?KGkNKxwyMIY0JwqT1CftzSAW0d/KegaXb/vBc2jfePbMzNW04rFwQmybD3Iu?=
 =?us-ascii?Q?mng6rlKqUtznxiLzrqcHfNXJu6i3556Nz81EoRkMeZidWV2OhIdYtUsJUPQ1?=
 =?us-ascii?Q?Rqm3jZPaU0bTkx8+jk0RkT4W+EOPgk+Agr81AQiqLX6UVObiX6oKqWziM6dc?=
 =?us-ascii?Q?fPjAFWuRvuYono2nnkXlX8Ib0/yJ5exN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHPPbt2Zyl2B/9Ax7XfducJcwZj94QrmAcaMNkGmwqlgq9U+f9nZmP3VELRd?=
 =?us-ascii?Q?yjU3X7j1pNAeC5UbL1FgmH6az5hgDss85g+Dtsy1gJVpn1frfRNKTuIVgjrR?=
 =?us-ascii?Q?crCqkygw8skJxFAitLGxRRA4DFOVzOMzBJHAwFjo/8tf7SyjXy70leuBendk?=
 =?us-ascii?Q?T84lQ3wCDtsb84KTzDe3RSCb0qqTGRDXN6KkWLtXkos9WCC4PNlyQqCLka5j?=
 =?us-ascii?Q?Zypx2FL6NTy8nl/MsPx3KZrg+fBFzahZFSWwC4xYiaWAGT0jtrJeq5Slo82x?=
 =?us-ascii?Q?IhaCErGgrjQsQF7xj7S3LjZW+97jDGPR689KycD6k/xtSwPlSQe75u+gdETj?=
 =?us-ascii?Q?jZPnuD1vmzx/xxJClrk9g9X5sfbgxo7GMugqdiPJaLMmt1XOmiWl2ie55MIp?=
 =?us-ascii?Q?QlYU80g0hAAcN27pWWovFhgVNXjqGMcCyAIJ63b9wbKADBh4xy2PYJhdoenV?=
 =?us-ascii?Q?jSIiH10L/hmmOF+0dQprvsZW/A+oAsiTqJov2knVjam9EVqH4yKEJ8/D7JtX?=
 =?us-ascii?Q?c6SaE8/as5dOayMiHZMB37OWzY9y9w2R2bbCRLDgQWa1UaP36WFIDUzFnkPE?=
 =?us-ascii?Q?Ci/382xZmOsHb3+ob9GZXIyriHkAFZ59tKVXMsdnDD6SCld2WJ/UYb1dhHv/?=
 =?us-ascii?Q?hBebGz0pFj4jZQzzRVUF9u7VISHUJNXlNvhD/yb2TX6OUl9Nzh6GRJPl4hma?=
 =?us-ascii?Q?wOREcl/r790oedVqVP+GSHx7vqtKUh+STqDxOuoV7+9bzy419zsU7b0hk23F?=
 =?us-ascii?Q?ozU1kLbTZFIJLh4kTRqEUa+9ovipwIgGoc/e3TXtLPaZrgJuFppMSt4wuJZX?=
 =?us-ascii?Q?k13/kveLWa2eTfxGehXl+0N+VbMxKWY+v/GpH1MKVgJyFrmtiYH+C99Q0w81?=
 =?us-ascii?Q?RESCvTHeLAtnUl6hq4SergbHk0qJJVFZExHeTUVNwZiXnbw/4VcNwaoQAOn+?=
 =?us-ascii?Q?OLMsGE5qll/yDHSd/aHiJEHtzEe6Ftdx27ToDJGizncNBt5Z+oT88kfePwhr?=
 =?us-ascii?Q?lTkVylIS8PYUD6MRVPm9MRc7//FbRFjH86wgQRdaWGrSyDlbOLqKn/jxloo6?=
 =?us-ascii?Q?WftEVbz5dOQxQ1R9HjrIIJICrWjuQGAnObT/q0MBC5ecF0NuSFDDsZgdVsa6?=
 =?us-ascii?Q?i7p6aIuAcsr+0xh6TQdcSJwiQD2hEw9BWhLCjgbozOan3p7jbAVnBTkun3qC?=
 =?us-ascii?Q?AK4p8GygJA5kqNWg87WT2C+YfK4b99LFqmW17NQ9aUuwJOuJ41i5JVwmgkH7?=
 =?us-ascii?Q?H7BZhVM1IpAjhtZu3NM1Qi9ExNj5vMgULcH/Mim5D6aWhuZeIcsQgbJC5ACR?=
 =?us-ascii?Q?MMuEpqFtjlMs3QzWhVstMKdAnsOeHlLbjDid2mFawZId6uJ2pOxJp1Ecz6XF?=
 =?us-ascii?Q?IcKRIvCPJv1e4kYOb2VOELf9KB0qUsFuFN+2Ow5/VFF90vB/sL5XsUIh2q9c?=
 =?us-ascii?Q?lFG0mNNIcMdL45YIt6lZzht6MjpWU3ijg/FjDeJHEnDJ9zVAQarbYLPPrcch?=
 =?us-ascii?Q?AslQPswLRuIC5AD6Ou8kRWZZwdHTR/ukigvzd3Us/Wx9wacofKTQUy8eChW4?=
 =?us-ascii?Q?F2w+ncYCJyoamHz4jia72iYjWwawA8Y5ec5MwsQdXcrSq9Ec/hKI4K3/QXzs?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342a4e9a-54e6-43ef-be65-08dd65209989
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 06:54:44.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNXRUQNFMB2AcJTktqg4dA8jLVccyz4Xg7HUrZGMdoaF8riFZHeqlk0GAe5Qc4LXVyzFkVqL0c5lFwWUw/J8QVnl/kvI8A+no7M4mG4dwAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406
X-Proofpoint-ORIG-GUID: ra9zsXtZ2d0HeuqBh8TqMXDmq1glDdUq
X-Proofpoint-GUID: ra9zsXtZ2d0HeuqBh8TqMXDmq1glDdUq
X-Authority-Analysis: v=2.4 cv=UIfdHDfy c=1 sm=1 tr=0 ts=67d7c738 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=t7CeM3EgAAAA:8 a=oIR1aHlt1UUSXsDI6G4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503170049

From: Qiao Ma <mqaio@linux.alibaba.com>

[ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]

Uprobe needs to fetch args into a percpu buffer, and then copy to ring
buffer to avoid non-atomic context problem.

Sometimes user-space strings, arrays can be very large, but the size of
percpu buffer is only page size. And store_trace_args() won't check
whether these data exceeds a single page or not, caused out-of-bounds
memory access.

It could be reproduced by following steps:
1. build kernel with CONFIG_KASAN enabled
2. save follow program as test.c

```
\#include <stdio.h>
\#include <stdlib.h>
\#include <string.h>

// If string length large than MAX_STRING_SIZE, the fetch_store_strlen()
// will return 0, cause __get_data_size() return shorter size, and
// store_trace_args() will not trigger out-of-bounds access.
// So make string length less than 4096.
\#define STRLEN 4093

void generate_string(char *str, int n)
{
    int i;
    for (i = 0; i < n; ++i)
    {
        char c = i % 26 + 'a';
        str[i] = c;
    }
    str[n-1] = '\0';
}

void print_string(char *str)
{
    printf("%s\n", str);
}

int main()
{
    char tmp[STRLEN];

    generate_string(tmp, STRLEN);
    print_string(tmp);

    return 0;
}
```
3. compile program
`gcc -o test test.c`

4. get the offset of `print_string()`
```
objdump -t test | grep -w print_string
0000000000401199 g     F .text  000000000000001b              print_string
```

5. configure uprobe with offset 0x1199
```
off=0x1199

cd /sys/kernel/debug/tracing/
echo "p /root/test:${off} arg1=+0(%di):ustring arg2=\$comm arg3=+0(%di):ustring"
 > uprobe_events
echo 1 > events/uprobes/enable
echo 1 > tracing_on
```

6. run `test`, and kasan will report error.
==================================================================
BUG: KASAN: use-after-free in strncpy_from_user+0x1d6/0x1f0
Write of size 8 at addr ffff88812311c004 by task test/499CPU: 0 UID: 0 PID: 499 Comm: test Not tainted 6.12.0-rc3+ #18
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x55/0x70
 print_address_description.constprop.0+0x27/0x310
 kasan_report+0x10f/0x120
 ? strncpy_from_user+0x1d6/0x1f0
 strncpy_from_user+0x1d6/0x1f0
 ? rmqueue.constprop.0+0x70d/0x2ad0
 process_fetch_insn+0xb26/0x1470
 ? __pfx_process_fetch_insn+0x10/0x10
 ? _raw_spin_lock+0x85/0xe0
 ? __pfx__raw_spin_lock+0x10/0x10
 ? __pte_offset_map+0x1f/0x2d0
 ? unwind_next_frame+0xc5f/0x1f80
 ? arch_stack_walk+0x68/0xf0
 ? is_bpf_text_address+0x23/0x30
 ? kernel_text_address.part.0+0xbb/0xd0
 ? __kernel_text_address+0x66/0xb0
 ? unwind_get_return_address+0x5e/0xa0
 ? __pfx_stack_trace_consume_entry+0x10/0x10
 ? arch_stack_walk+0xa2/0xf0
 ? _raw_spin_lock_irqsave+0x8b/0xf0
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? depot_alloc_stack+0x4c/0x1f0
 ? _raw_spin_unlock_irqrestore+0xe/0x30
 ? stack_depot_save_flags+0x35d/0x4f0
 ? kasan_save_stack+0x34/0x50
 ? kasan_save_stack+0x24/0x50
 ? mutex_lock+0x91/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 prepare_uprobe_buffer.part.0+0x2cd/0x500
 uprobe_dispatcher+0x2c3/0x6a0
 ? __pfx_uprobe_dispatcher+0x10/0x10
 ? __kasan_slab_alloc+0x4d/0x90
 handler_chain+0xdd/0x3e0
 handle_swbp+0x26e/0x3d0
 ? __pfx_handle_swbp+0x10/0x10
 ? uprobe_pre_sstep_notifier+0x151/0x1b0
 irqentry_exit_to_user_mode+0xe2/0x1b0
 asm_exc_int3+0x39/0x40
RIP: 0033:0x401199
Code: 01 c2 0f b6 45 fb 88 02 83 45 fc 01 8b 45 fc 3b 45 e4 7c b7 8b 45 e4 48 98 48 8d 50 ff 48 8b 45 e8 48 01 d0 ce
RSP: 002b:00007ffdf00576a8 EFLAGS: 00000206
RAX: 00007ffdf00576b0 RBX: 0000000000000000 RCX: 0000000000000ff2
RDX: 0000000000000ffc RSI: 0000000000000ffd RDI: 00007ffdf00576b0
RBP: 00007ffdf00586b0 R08: 00007feb2f9c0d20 R09: 00007feb2f9c0d20
R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000401040
R13: 00007ffdf0058780 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

This commit enforces the buffer's maxlen less than a page-size to avoid
store_trace_args() out-of-memory access.

Link: https://lore.kernel.org/all/20241015060148.1108331-1-mqaio@linux.alibaba.com/

Fixes: dcad1a204f72 ("tracing/uprobes: Fetch args before reserving a ring buffer")
Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ the prepare_uprobe_buffer() function was introduced by commit 3eaea21b4d27 
("uprobes: encapsulate preparation of uprobe args buffer"). So the fix on 5.10/15
need to modify the code in uprobe_dispatcher() and uretprobe_dispatcher() before
calling the store_trace_args. ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Try to backport the fix to 5.10/5.15.
Verified the build test.
Verified the changes with test code in comment, with the fix, the KASAN crash won't
happen anymore.
---
 kernel/trace/trace_uprobe.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 720b46b34ab9..9f8c95b9b30d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -858,6 +858,7 @@ struct uprobe_cpu_buffer {
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
+#define MAX_UCB_BUFFER_SIZE PAGE_SIZE
 
 static int uprobe_buffer_init(void)
 {
@@ -958,9 +959,6 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	WARN_ON(call != trace_file->event_call);
 
-	if (WARN_ON_ONCE(tu->tp.size + dsize > PAGE_SIZE))
-		return;
-
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
@@ -1503,6 +1501,10 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
+
+	if (WARN_ON_ONCE(tu->tp.size + dsize > MAX_UCB_BUFFER_SIZE))
+		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
+
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
@@ -1538,6 +1540,10 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
+
+	if (WARN_ON_ONCE(tu->tp.size + dsize > MAX_UCB_BUFFER_SIZE))
+		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
+
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-- 
2.25.1


