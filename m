Return-Path: <stable+bounces-147925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB03AC64E2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D764D7B0E45
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50096274642;
	Wed, 28 May 2025 08:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAF2741D4
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422522; cv=fail; b=YAQqcllbqPLTOzz8/nArcIJCMmuyGkLQbVlw3I0WSL/04i+x+Sr0njWDfCPrxPkeEPxb7QPnqJnShEZD0iWNNbUc0JOIb7bHOUYsv+kQd+Ekk2OzdceNDvdu0YfNDWtSdeXW4Cz9p3XZNjn4uEy76tBGR9VGoyMXCiBnr0qSj9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422522; c=relaxed/simple;
	bh=hlr7e9g42j0IRNoCPXACIka1tEX+j+1LgnrLxK20qHk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KoHrlyrhlzueKl9k8EzY9ehNoHc/LoL+KtAWe0ugk6e+8J+MyKxmGnTlsHDy+LU5saqvdXz0Rf2GAWrff3a8fqqGTRp5Q1D3Fib8D0oYtbadbb/hBCNDUwyFaqaPHtdOY/zuf9+q3aSVmAMdbINAU5exXq1/rn1tLC3+nbaCl94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5cqIq000823;
	Wed, 28 May 2025 08:55:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u5393uaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 08:55:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnZNFfKHmqvPAYvAz0GFuBnQTPUz9eiDXfWnJfErFpti0WcBruuK/yhEwlkT3XI6+uCBe5YhrrdhM38f7fWW6TPP9ear3hHkNOUFYo9U7GWqABuWyVCM73JJZQyASWOHHqp6TTlImzullzKCn3GYshgURavSIvMZ0F/poGtv7DRyz9ilXxrFcTHu+OY8sdjZlRfCrEM6KTCZ4+0xEXOQAp4tJ8cIymEzmaEgKwLUBsvzuHMaI7LtKZF1xyQ0ogrgVjKZHPtUtPz9rLHGON4XzCrK7m3QTGeBCQLws9slMP61KcriT0pVBdkOnKsE3CtYdz9qdKn9QKmWaeAG7Gv9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJpUKFBmVMwwVb8T/NmnaxQKLvCjRxTzEQe51BPeOY8=;
 b=C4YzKoiSKldGcfwozXGZi3mnIznOYLbVbl1LfnAqpWKqWnO8+rJ/6t2rb+BSGLOH/mJdfYS0iax4Qov2nIENR5AtHd/cz0K6ZmdM3flWNkoyifjQaWuJmyGlV2nF6IaJoSvKlyR2d+fBGP2jSJ00UhDtHd9xx+TYmkLzYNzZSiHn71feukNUzJTahBge+lupr2/SzDTx1f3tmj3fw2zi+nppU8Dc8NHmmTJnAzXkQQA4mBNA06EeGC03X9zJUpayKfKRRZpdweg4D+cR/vmSvZfdlm3737vwa2pmTf1DpSvJKVxM/5gEkrqls6/Rg+AIFygbXNkp9tHgjTFjVAHh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 08:55:05 +0000
Received: from CH3PR11MB8154.namprd11.prod.outlook.com
 ([fe80::6a64:c180:9621:3843]) by CH3PR11MB8154.namprd11.prod.outlook.com
 ([fe80::6a64:c180:9621:3843%5]) with mapi id 15.20.8746.029; Wed, 28 May 2025
 08:55:04 +0000
From: wndgwang4 <guangming.wang@windriver.com>
To: guangming.wang@windriver.com
Cc: stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] selftests/vm: fix split huge page tests
Date: Wed, 28 May 2025 16:54:40 +0800
Message-Id: <20250528085440.818430-1-guangming.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To CH3PR11MB8154.namprd11.prod.outlook.com
 (2603:10b6:610:15f::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8154:EE_|CH0PR11MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ee285b-c803-411b-bf66-08dd9dc5569e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3BkuFPWIzeUF/5O+jvXhCLIRr34LeTp3VPglV9rF/+PJlaJUvXK3xMqvHqzm?=
 =?us-ascii?Q?UKkGRe8smQA7eIhEic7DYSQ5sgfGQEegrqrqIiI2d6QZOZTXzBMva8gz9KOq?=
 =?us-ascii?Q?/CRSgb4aSl5HPReRV/L2vwGTNSNRRfwL42LyWqqM25bUQcbJ2Lq1kRWAIDZi?=
 =?us-ascii?Q?0MIWYUfQUHm+N/4GYDTJQLw3VxyFkLbl6PSxrV8vZBBDK/ZreDu+T/lNjanb?=
 =?us-ascii?Q?CerfKd7QcU5hJnL5SL7WuEFbYBzjCfz6cTMbcTsvFkM2A5Ky66N03+tvab8H?=
 =?us-ascii?Q?hPv27ciHOXzL34+FGHWdJ04xIJ12x4AbknLOcilAVzhc96RihUcZIYlZApUB?=
 =?us-ascii?Q?uoRsgFWFe4A0dgqZjWP8zbiEdG5Cqqdfeo0MJiDNFlUMSCOBnQ1KCAAyEUdv?=
 =?us-ascii?Q?mqCOvJ/18gUtDeggfGRaTeziRJXhUX7DnrdfS8/TMbOaZNjYMRTKBQBujQNO?=
 =?us-ascii?Q?+b+WnOjDegm1bQTATG1ImocyQYY9ViHAa+S4NqDO2Kr/2lJ8HBi41C0UUHqq?=
 =?us-ascii?Q?bCMMDHYFDuFstRQDdu++eYzx1P6VhW+6HPU3ebIQ/EP8UH1yCcftfkCYemTg?=
 =?us-ascii?Q?gd/YKn5tpyZk0M3fh2VgKrkSXE6/ItE6qOH35w0KZmbN7NAv3vXIfssnVgrk?=
 =?us-ascii?Q?f7GteIfwnTPejNKqviBMuKuQ5yPE2eC6k22qE4pBSbCtk3liqmAZj5K/pz80?=
 =?us-ascii?Q?peJx37qT6Ib/e3LnunQh8aAtbP+6+a7vg62RQUDUcCzeQI5IC/Pfkv7H+KR5?=
 =?us-ascii?Q?/2CZzRNL9nLynXZPHV7V3XS4Dzxkg2SOJiAnw9t1/NYjRbR4FM185LUvaTbr?=
 =?us-ascii?Q?vZjY2RonBdXUaiwAV0NfLRMU/3jIkvzieaq12qryPbFJ4oHHT7Im88TLP/lV?=
 =?us-ascii?Q?wbj1qgfjSz9SBRmrl8hPuSgl7XNXcNp1q7yOedy0frKpk5X2c6urhEiK4boN?=
 =?us-ascii?Q?/NS175BntJYrs6xw7HyMXxjnwWVcsm4ueCcAv49V1yBG1aoO5gq5V7CJ6a6t?=
 =?us-ascii?Q?R84vw96X0Yr33MDYiQMBXmXojtcuMlhoYADpMEg1lVNqSQIdG8zvkQRlRvvN?=
 =?us-ascii?Q?Gv7huswn5XlIrWL28GzgTNeFMNbI4g2ijLhaR3Uligebtdg84T2sjySk4yU1?=
 =?us-ascii?Q?wqQ1nP+K7M1ZuYbnWnbT/shFKsR3HE1er+uLdLBBKpkhZP77vRQ5FXzQXmtl?=
 =?us-ascii?Q?3vquzR+S8HT98e2ZQlS57rHXi8660lfcDkZMmTA8Vvy9/UmuwjZqZv8LBRwc?=
 =?us-ascii?Q?4+KOE0CpFTU+cHKqSHtemjUGNZT9cWDcAqbfR9CH1b31LzgMAiceW7BVv5ri?=
 =?us-ascii?Q?nwc90W9Na/3uoSVZOpCdXGnM8oIQwnybgd7po8ro47JlUzai7qpzTKNPU6mm?=
 =?us-ascii?Q?YbJiVLQqjaTAry3BsHb3ZOjFElkYh0+JO4i2tCo4mBZQZBApq8Q9oIP+H3HY?=
 =?us-ascii?Q?bsNdvNtndfWuY6SpVOMcGDus36ZWPHY+9dQu5X5XtAdvaSUP5xhaO5g3WZJE?=
 =?us-ascii?Q?2PmrLqWHrd+YNTlNkQxWlH1P9zFcu68Gihyp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycpkachRjzFhaZ8PqLdP1uTVT1bgNqkamxlFf96l2Iqt8ZcTmT2HhCUYsXe5?=
 =?us-ascii?Q?ax5d8Lj2TQjp4jOX6yWPSapWHyerbgI9Xcq0W+QU4rkk2wtinZJJS7AuV4yL?=
 =?us-ascii?Q?VhYCMOEvva2++aKiJoOS3eUuK7XHu0+fKRGWC1PJw++u5I7ulYZgLps3SAow?=
 =?us-ascii?Q?CJa64CheR9d7YpZNYTTp+tZIRIDfF7EeE5Vk7OOTGe5Xyj/WhfZUHBmklYdR?=
 =?us-ascii?Q?A59YHUKOWHVaN9JkNO7wqulajcBnkb0mNmSzek/wiKSx7X+ojtutRTF/okyZ?=
 =?us-ascii?Q?/iimn1gifXT3A5LeptX7uG2my3qwMyUA6pFyvOTw+vn37yOvEbYYt9e8hrZe?=
 =?us-ascii?Q?RVXRks1tH+l4gGzqDAXB2QW5AgxrcajLLtVc1FbmodRrG/QRh5z4B/9oPQMw?=
 =?us-ascii?Q?Vjc32lxeMhltOvt4zApwJ0UV6rdrQ7HS+y+Thr//0T22m6dgB8JOJi8vH7Mh?=
 =?us-ascii?Q?TnZA2BfDumaW2WVVfHyvT4iEBjHVaz9lCI9OrAToZ1Szci/I2UbRfsUS2+h/?=
 =?us-ascii?Q?Ho53a1/oVj0kA4vdNK6Sfo+69Vq0GxHSZgpIxrrteW0dAF5HIm0HRTqM697C?=
 =?us-ascii?Q?PY/+LFhox8XBey3xbwDLyZIz1eo6AeD8MfEsKJ9n1gXBAtq7iySOTE6cwuB6?=
 =?us-ascii?Q?tcUezlWVP9pz9bTv9RMEehZcXpDCEKEZU8Yzsm654xTQif2HANQv8kWMkTEk?=
 =?us-ascii?Q?+rSGmXMwgX2rG6ftZzgZKeFiDsCGx7f1GyfsnNXB3Pr3k493B08/kJe03KIn?=
 =?us-ascii?Q?t0t1kIKGuCJZM2AdEAPu1+gB1wlknM6zEfSUm8KFZCa6J0psRuIid53L7q0Z?=
 =?us-ascii?Q?r0wgVpTvistznIL7NyKsY/V6XXaNZEvaCA4Kxc52+wWedjlFWswZg9o/b9uM?=
 =?us-ascii?Q?ol161bsjC4Q7Omf58EcPGUHv1575BYrRVtRFHfv+ps30gtl4bELoHOH+1wDn?=
 =?us-ascii?Q?oGvKXiVWPTGzLonpV+9OA82l3yy8ihlb3RV+iZbnvi/a6B5NKXX9aL6mJMLd?=
 =?us-ascii?Q?7Pr405BQK+BSZKVgZT+LouA4nDKK+8XGNLgE3LKlbfCtXSn1kI0PT2Sw1CuU?=
 =?us-ascii?Q?h8XvB9WHy4uuY7weFBH5Q1ZGvCgRyb+mKoEMXQFH35ekeflklzq8HuT68N/y?=
 =?us-ascii?Q?EYTv25ScaZM8ewl7aJP8tDy4qy8IQH0Qtu+wsfngspWX3nmMfUuEfjQYvBOC?=
 =?us-ascii?Q?zjqMsN63VtT+APsQ6iyGXdI499N60ZRYy7NM2maXmGLxzE9RLDujcqMJ4nUc?=
 =?us-ascii?Q?IlqXfgNodHqyco32BL4S9e5oQgU7O7rnSgtdnNxVe95q7tvarn9EJMsV3w93?=
 =?us-ascii?Q?eKc9dCX4tu6mSnjhpEq4m66ZVmeuznG/9bBenwIX53W4M9BWeJyKp2Focc6N?=
 =?us-ascii?Q?/NExWDSCKt9D8NrTDkNzFvXU6h3YWg6TGcvK50DcdnQ0oqPPb4+6AzL6umBV?=
 =?us-ascii?Q?x2/ssP5TCuhvIjTu2NcO4h3KvRbsRkih/H6aBlIR+HHS84svw7WVvubZyur2?=
 =?us-ascii?Q?07OXPulx3Uy/n1FBUGuZbvIHEQKE641Hhxvl2TOCuXIyLrsWksZDbLGFO5pQ?=
 =?us-ascii?Q?WCM6+rX9FHo4nixpnoiQOV2UakN4joZeaQCd1cSXGDL/l2i2Kw5mZ/ekUruw?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ee285b-c803-411b-bf66-08dd9dc5569e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:55:04.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk+jQ29MMUJAfxE3vgMenXu5xlcIeioWbu/4QKqU91R8BWPknSqtE709Xm1xMFYI99s7wCq8d49UWZO/2kSxBe5pwqU6so/TX4RXp3E6X2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA3NiBTYWx0ZWRfX+dxk2fD0bRWO Iqx4V1gtrXSeaYf34A1G2D1Y+l8JpiyxAtuEen0nYGBYfvkesEJwGQkndsvGzykpApzv2vvM1aQ 9BYVRMdMKZloWjq0oj3n0YepZzLFb11P1wMzlU+xsgm+h+P0UZflU02FPVFiLL/HhiJOs9VN/Vd
 ZreVeozVxtcfUj41RrOpyyQ+RCijpZvXJaRYbFq48KtjIGSOsJXdOkBNlZBGzOcH9bbeQNaaL7W mvOjLw8VGYqySAAPC456Hs5hLNl7k0V2+tBQLOGP2CL1LDraYi9MaZvCzH9dInliFQq+TzrZUAj 5W0sHFJFGShcDcpTVTh09Mm2gMxP0/yYgpcgVm49bq7/+92IU3R8I96rsLOh4hmF76HRD8GvEPc
 MWkedjm2cHII1wYcDjmZfrvRfB0EicO+Pmpv6o4snbkYoD1K8dnkTsKG4EA+n8BPoFWEEMjR
X-Authority-Analysis: v=2.4 cv=NsDRc9dJ c=1 sm=1 tr=0 ts=6836cf6d cx=c_pps a=TmMIC04Ao4SyGwzX+1k7VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=UD7uQ7OiAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=VVKcLzq8wE9gult8eqUA:9 a=Zkq0o-JBKtHmMz2AGXNj:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: r8vDrF_S7S0cI3Ai5tp8cGMU-SN5DFoG
X-Proofpoint-GUID: r8vDrF_S7S0cI3Ai5tp8cGMU-SN5DFoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280076

From: Zi Yan <ziy@nvidia.com>

[ upstream commit dd63bd7df41a8f9393a2e3ff9157a441c08eb996  ]

Fix two inputs to check_anon_huge() and one if condition, so the tests
work as expected.

Steps to reproduce the issue.
make headers
make -C tools/testing/selftests/vm

Before patching:test fails with a non-zero exit code
~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test | echo 0
2
~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
No THP is allocated

After patching:
~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test | echo 0
0
~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
Split huge pages successful
...

Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Tested-by: Zach O'Keefe <zokeefe@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: wndgwang4 <guangming.wang@windriver.com>
---
 tools/testing/selftests/vm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 76e1c36dd..b8558c7f1 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -106,7 +106,7 @@ void split_pmd_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
@@ -122,7 +122,7 @@ void split_pmd_thp(void)
 		}
 
 
-	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
 		printf("Still AnonHugePages not split\n");
 		exit(EXIT_FAILURE);
 	}
@@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1


