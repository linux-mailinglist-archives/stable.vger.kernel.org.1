Return-Path: <stable+bounces-93889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C79D1DF5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297C9B2117E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C813777F;
	Tue, 19 Nov 2024 02:05:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCFE56A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981954; cv=fail; b=oqoxc+1AQc21wy9Ixjevszg8MGGPFAMr6R2GuL4JAmdsSmHPB2mMGOtG8UgSJwOYjBwkC3+FHYty+d1/j7TggZwRa1f1lwVjO9TXpFIMOkr98yhIiYcl17yyz9u9Byfp/EiVGxKpedtdM8i5FYYIkaNJIAFgxzztJHVydglilpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981954; c=relaxed/simple;
	bh=6jLf5KYsHJrnBnyBKb4ETx3wPwSnoephwr+tQcWPOUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PP7pb4qf/a5dX9zdY3dnB4Hpp2h9vAXpbAZxy3/56UduTWYKC2MZYy7aDKV18wrFMwM2dbPn9wxWEi5SYeNXsuJRjs5Al+sRN1gV/5e/4GcVZJiYR2HJi2gWmjOOb3gqd/KPxNsJoZQ81d0pihVZwEG1/n2mII9mazcAcQggVx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0LZrX017413;
	Tue, 19 Nov 2024 02:05:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0jkdd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 02:05:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA9p9PkNiThgaWR5KUoXO/ZZG9VIx61CA1TPgTVOLHBmrSvJ+Tckd6iOF9Y9ggzcu/ZnPoNSx6MGiWLL4REDBu4rVEvfOlBUrgr8ga2YmWjfWd7Pfxzw0bbtoPLCKx5RVUhzKgQzI/t+idpp45Jf0kTqA3qioyuz0OmOPFxesuYqXkE3Z6mL0FOcUj6TFI7mnfGirIT2aTV8K6MHT8JJrUorDTYQVbXTxbq3k1CyjBDkxquew42Ab7HVuFU6sdyAeFmSthdTiYkIZdj0KRlxrpn+0YR+v992A+a4Odu/5Ys3djtVXX4clK9GyIMdHIxq59CUnwG/NjBFeW7MzbdgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahSt5XwrYyek7f2LqFDxXfLpkpsRMMVO3KlPsFvg1E8=;
 b=bAyIDN35vCs/3LvyFaW8k5UykFEe/ApGbUW6A3Xg5UoFg0/5mWq/kpUSfH/UJekNhM7T1CXF3ioEr/3s6iCMTqD2bDZZFRebpSDplZdev1KHfr/eqJSR3NY/v5V+kYy8IGSCjhbflN5uDpbCTHPG6Js7XEot4T9iruY/ZL+YeT4e3yK6ABTgq3B3cIg3aP8bgrrODAMyCjZ7tl5UOyUD5UhjpsYEs9jh2G1C5a6pdyFM+qI9NIjd6rzCVr7/G+t3QNtgqXFdaP8TQ0Y1dNnN/JNjWox/Q7MFWe8kJMaaXm3m7bqcEksjo0ljHvvcRcD5V/YIH53PkpE8tS66fGPIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 02:05:37 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:05:37 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 1/2] net: add copy_safe_from_sockptr() helper
Date: Tue, 19 Nov 2024 10:05:36 +0800
Message-ID: <20241119020537.3050784-2-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e2f35ad-5811-4a9a-11b2-08dd083ea946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27c8D9UsBWc5uH74GbmRgJmMPkpFiJpS3r7NT4+yLlK9u8pdpRswtBZckjZx?=
 =?us-ascii?Q?uxJefdx3R927Bjcfh2s6cu/MyBQvrBdNUPOHZzhrieJLMJGoE6pQclVH8QxG?=
 =?us-ascii?Q?jSUxXmFtJIqoyR+Zr3b8EcKbY7J3g1Uq5FH5PL26a7S9wIqrXtr9Ne43MUyf?=
 =?us-ascii?Q?A5pMy5Ul+KolySA9Uf5fmaGSLRCgxpG5Ve529pgjWLyRjDCsZQdkmNLqY5OF?=
 =?us-ascii?Q?3Gs22c/lIB7d3yuSweIB3nrZhcKTw/QLSh2Dch2qfdHC3Ow5vLoCmlOO7d9U?=
 =?us-ascii?Q?kTtcCXsqMvzYIshaOkRCKhaWOHUgZgbz9a4KFB3y8eYaJ2YwhR/NQd3IksnD?=
 =?us-ascii?Q?00VXJ9YlMc1qc3iH0SMnyUW9xPldIaIFWm2BWn+Lcv15QOGkPNy+msCU4+L2?=
 =?us-ascii?Q?wWasfcM8wgl7iYv4HA1y8o9wlQGHLLPpET/hxYG947vEes2iHu76t/F+tYgi?=
 =?us-ascii?Q?H6fNQW6ntXkx4326XQdYrLxnkU65OJLCKcRrlr5D6SjXw7btHJusn0SbhWf5?=
 =?us-ascii?Q?xn5WgI+h7rFqczlLIWctUcN7nwB9nHOK7yVbaQjls1pECHAgpynmpalkfwkw?=
 =?us-ascii?Q?yE2ELFW5+R6OAHgV0sspYR3aZWzTJDKBsetuyCpNe2X1U77JkCbgBqmGAiqn?=
 =?us-ascii?Q?jr64oMKtW8YWyBFNOuxWWobRWYkajyBUIWeWnR4+Cvk6orL278pa6zrdcskr?=
 =?us-ascii?Q?HQ6j/xLdl29ZU/U7ySyiST07QUCoYqYYFcNBLz8o3xwoyGLoKguKQeuQ2waC?=
 =?us-ascii?Q?usgptumOTlqayFFI4vIuJRdTERWQazBv1XsfrJxZz0ZYwUJ7JftGKFxLVXXL?=
 =?us-ascii?Q?VV86TcaeAZQCUKg837c5kmAzcyc4zHkFuT5ZiU3C94w/IgFBOmp66j1YPqYZ?=
 =?us-ascii?Q?f+xvv9aeZsdHxsTSjY+z1UIDNERX5IdQ3NYMfNy4G28l/m//PpZ6cZz+Pq1B?=
 =?us-ascii?Q?0fDLejgIzG5cc3JaDmxEiwvBMumo798akGqcimlGdE/bSELEBayfmqWtrOsn?=
 =?us-ascii?Q?WcmNE1klnu4lpIrtUlrnMxOFJNGHi+MhEDDLLIqmcPlUwcro9bzF3MClLND9?=
 =?us-ascii?Q?P6UdotdR1jvilRPzP7p9n6waxvj37wdA5C8gfTMN6SCo0f0BFRT+vi+gA1ua?=
 =?us-ascii?Q?2SThMuQNnR0qzSP1xOE4DFr58BxGmJoqsUY8k15TSB1tmTu5DEily2jsg0NC?=
 =?us-ascii?Q?Wq6aPqcXAM1ZbNomSnIhxiwkjrNnqnFmG9Z9LVqyaivcviNrosOGucj/WwNW?=
 =?us-ascii?Q?SbzQxMQEygoncR7DLKRABmQzDwadn8JHWU8Q1huBlD3MlhOtWKAoeGuhOr4K?=
 =?us-ascii?Q?v6GhFUcQAjAO3WSHMO73bR6rQWMYuYiPaXM+bs2Hqb/f4lE1ghQVY+3rHQXn?=
 =?us-ascii?Q?CMYWtSmrbEMA2lZaq46PnryUERjQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lx8abvUSp584lSM1axoVONuuR0gd6qvjUUb4AfnLUMyrAUIkxBVtusTxwsa+?=
 =?us-ascii?Q?MOLPJXzpHVqbkN8xlYJWk54oCZhLZCkGwBT10RxIoKywa/vP98cfOvutnt9T?=
 =?us-ascii?Q?0hUqhtsOrTBTtnlvF+kY1e0O5mu5hsYCml6I+tAkrljXHqvMwBZtZ+aIq1rq?=
 =?us-ascii?Q?yj2SprfM3DkXAbEo9o4mbX/Exl+AJLmlVjW2BB6YWebxQygLiayicsfcu0WE?=
 =?us-ascii?Q?4dg1onxFRp1fI9pMM4vMaduiuE3c9fdUbo3fMj65yGDvZgs5yRyrHbpOAXxn?=
 =?us-ascii?Q?dNpm5/nk2ejeD7+U7BXkikRudBk8YZnylJlNgUAX2Pgh2ZLOyif0f0bkadPa?=
 =?us-ascii?Q?yXE/bsbympWKMqiwf5LSjwQIG9NhbLruAdYjYdCRFvFG2RtP9tza/yJRxoCK?=
 =?us-ascii?Q?Z2eHBonvF2BuR2AGIAesFlerOQvB9Azg/pDYt1yeRVc5bWvEpSQqc03KMKBu?=
 =?us-ascii?Q?Oe1n3wQJWxU7UY7zbRHl6+86jXKXZMwXscL5mV/j7sA7wAGlcN70hgsUGNIH?=
 =?us-ascii?Q?pWL83DWbkYA+0PvivSGxxZIqMNjbN++epQ8m+zYHnRig8vIn8tQSq/hCCijd?=
 =?us-ascii?Q?Yse2KZTBnUxxBPa9fNmqwCeig7wMhX+kyeAB1dDVSxtUaqlqcbRVHxLi7xs5?=
 =?us-ascii?Q?6/CvGr2cVAcijpUi5ZC2t6Q2W+FRsTEg2H/Qo9uTX3rmAe8aTxIMSsHL2wP/?=
 =?us-ascii?Q?HDMGnsDIR5li39r5pwc/FlFvoe0XBV+J0O24QhZbJrl6UhE6Xxs44lVmEIpR?=
 =?us-ascii?Q?JnncUGG/NSkQ2o3saYwTYoKQvQrWmhz9u/Hkj8WIzOtukZlM+DF3VN0bFfed?=
 =?us-ascii?Q?G3pHiN5br6c0f2ngmJY+SoNxvnDwUCnVyNoap2z1D0RsNgYfapHtwYONsS1H?=
 =?us-ascii?Q?LmBPQdqtcNsNolod/uMiuBCQDduRc+46YxgZFatzKiVE7tUxYo4jIm0kb2tY?=
 =?us-ascii?Q?uC3TSm2mVCdBlle5SxJY/0dPP8ZXmllYAJbPjV41QsvlO6Q3dONn+07GCVxe?=
 =?us-ascii?Q?lI7WhTpmYdnnlnnlIZvxEGHpYYuYMEfL/lUlm4/DU37mb0Od+NErNRdQiNW5?=
 =?us-ascii?Q?gjKbKp5PzjNkFyNpzeQqw2IXyjYnrLOafEE9/p7tRh0g3fXbTCjX7/ahd7js?=
 =?us-ascii?Q?D7rx+7uX7LsMeHHnFaxmya8IEhnDvy2O/mtZR/w4YHwoGNIzxzqipszMNDGK?=
 =?us-ascii?Q?vlShHko0hOGP1uBbtthi7xmaOQXPKv0NWM+ZioGvqTFZlmlAEoUM+v4OS28S?=
 =?us-ascii?Q?m9GylNPsNKEmo8dMM+v2HwHDE/7LNVjyh4toXqsxsLUoB9bAdQhZ+FjSbBTF?=
 =?us-ascii?Q?H0Rs3lmVR9kxJOO4bTJ1vhJ1CR2njALVhOhhA+4Y/1DceCrfzjARUzfP8ivz?=
 =?us-ascii?Q?igL0aqO758XGt+CXjvpVHe8YS/7+G6RiGh4vO6I3t7yw9GRwlI0qxXdQLgAd?=
 =?us-ascii?Q?C1hAFjeboTKr8KmH3R75UaHCnc5wBTMjm4I3jZCVkp+OD5biAnQSSbsl6fDo?=
 =?us-ascii?Q?xWzoxNJgNg839VeMw7JWAxdhsjjwhZzkomiTA2mQBJd/UsoaDDEcEyIhmPho?=
 =?us-ascii?Q?EUI3YPOzGcVR52WCLLbsZsfEY5J2Q5whWgmKvZ3F4fKHx92qmiBGy1QXc1W3?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2f35ad-5811-4a9a-11b2-08dd083ea946
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:05:37.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TvBW0x/awX7AzxSmGnwyup5VRlzKzVwuyWD4t+9ZWMjpwZ6dXeeIDDqtISg0nzVKHbkxeCkPdPGIExqkVRro/gu0JqQmacYL7kdOzAbudk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-Proofpoint-ORIG-GUID: jOhp-uJgY65Yxm4X45c1_ztQLiihDYMG
X-Proofpoint-GUID: jOhp-uJgY65Yxm4X45c1_ztQLiihDYMG
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673bf275 cx=c_pps a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=kjuled4u2VdfXmnRf2QA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190017

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6309863b31dd80317cd7d6824820b44e254e2a9c ]

copy_from_sockptr() helper is unsafe, unless callers
did the prior check against user provided optlen.

Too many callers get this wrong, lets add a helper to
fix them and avoid future copy/paste bugs.

Instead of :

   if (optlen < sizeof(opt)) {
       err = -EINVAL;
       break;
   }
   if (copy_from_sockptr(&opt, optval, sizeof(opt)) {
       err = -EFAULT;
       break;
   }

Use :

   err = copy_safe_from_sockptr(&opt, sizeof(opt),
                                optval, optlen);
   if (err)
       break;

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240408082845.3957374-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7a87441c9651 ("nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 include/linux/sockptr.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index bae5e2369b4f..1c1a5d926b17 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -50,11 +50,36 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 	return 0;
 }
 
+/* Deprecated.
+ * This is unsafe, unless caller checked user provided optlen.
+ * Prefer copy_safe_from_sockptr() instead.
+ */
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
 {
 	return copy_from_sockptr_offset(dst, src, 0, size);
 }
 
+/**
+ * copy_safe_from_sockptr: copy a struct from sockptr
+ * @dst:   Destination address, in kernel space. This buffer must be @ksize
+ *         bytes long.
+ * @ksize: Size of @dst struct.
+ * @optval: Source address. (in user or kernel space)
+ * @optlen: Size of @optval data.
+ *
+ * Returns:
+ *  * -EINVAL: @optlen < @ksize
+ *  * -EFAULT: access to userspace failed.
+ *  * 0 : @ksize bytes were copied
+ */
+static inline int copy_safe_from_sockptr(void *dst, size_t ksize,
+					 sockptr_t optval, unsigned int optlen)
+{
+	if (optlen < ksize)
+		return -EINVAL;
+	return copy_from_sockptr(dst, optval, ksize);
+}
+
 static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
 		const void *src, size_t size)
 {
-- 
2.43.0


