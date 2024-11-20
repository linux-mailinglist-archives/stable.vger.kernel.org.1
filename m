Return-Path: <stable+bounces-94088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434449D3289
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 04:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0057283EEA
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36276155A59;
	Wed, 20 Nov 2024 03:29:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92E40BE5
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073347; cv=fail; b=rE4PN3xD5rE42q3Z/Bg6LS2fBsb4ro+sJjWfUSG/XjWiOzRxK0gVjKtR+4q+qYE0yAQ+lafrDJMaryCr5enx3zaLVqm4vzRNFqRKFc1cQQMrt0KtDw2LMG3izCv4vs7eYmkCPgj4wChlKxEpuHV040+w8XRmEAht+Wuyoonsoho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073347; c=relaxed/simple;
	bh=fsj3lryRDYhBYNSmyLl9xOyRwVXZ/Xuh9RCsd2NjCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLvFuVn4oXmSbZZyaizhGod2qhbSAkCw38LZzxLQLeJ+g76g1wrtzVQAVsjhAjmdiGGLOs/NIlIVVcL2A4c++pOh0v/1VpXp3dbv9f7V8hH4q90DuUm+Z8kewGyZvFWxriDdzNy/G9nVgR7mHkhN8rEotwVyxhMyDQ744GvvhNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK1Fe1q006125;
	Wed, 20 Nov 2024 03:28:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8bshp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 03:28:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpFW7mNv0hPm5N9sO/Wjvfg+YMH/L0Z0TpDnvFhm5ioLVPrN3TtPv+Bx5pi7bVXYHanCZPTCLUoEO0J9F7+e3KK6ksCc2w+WKAv94M7Fe/CDVXpC4npehQYcXZXeM+hAQGzQXC8wtDC0ScrTEyS7D/0IabsLcW0kLZ0/OFK3Ci4gu3ZwAnDQqmYyQUth+9kMTr/bNWuFlmJQNap1zn+MyLH8kHXczaKAZAdjeveBdtJOryktMlxq6PedV2gN3BbESjYgnYalanBrdSrEJOpPvNpNMd9spvI89L3qMA+OUR5KHuqTrSh029nx/lQrBn2ELgNBhiDfCa0mIPNQOZChww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk4/x1jds7msLNLhccKAVXH0ao/3MBvFG0r/UQiaalg=;
 b=Mrd6nbitu8btIAsYN8vdIuRrVXUcJZtEb3+Obe4pRm5IGFhyvG/dRkPVt8NC7oI3iXl70Id6ER1h5BsVtV8eSSp+61HO0md8BamGYSl7OWSxFftqxhDfoA/AYrNGeBeBFr01Gy9iX61/nt/UEdAxY0HvJqBiT7P90JThJ9l07IIqfzofl9VyU3jXQ/oAEvVlAttz1ZdKtvoUk69MgJstsebYbcxRRU4tuDnlgtcIUAkT+9xOk0M4oP0yT4PWJma/08QdQgAQiIEbyzTEqsxoz21prFFk+VjgC3GWeAhLC02yCXv654EZxrMrUlkcEhKr8KkSsJeYqP3JvVQjdLj2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 03:28:45 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 03:28:44 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: yukuai1@huaweicloud.com, christophe.jaillet@wanadoo.fr, yukuai3@huawei.com,
        dlemoal@kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH v2 6.1.y 1/3] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Wed, 20 Nov 2024 11:28:39 +0800
Message-ID: <20241120032841.28236-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
References: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 022b94b0-d41e-4419-57cd-08dd09136fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mv1DeL8rwgC+BdOaSgHQ3jrkYUlgsc0KuNcG7GBpmF+2DzeuJ8PuK9yDlAYC?=
 =?us-ascii?Q?ghxkIY/Fezn3KdaULqiAwaunm/+5NTag1y9cpCPMOrt0ERp06KhooUru6awg?=
 =?us-ascii?Q?Ll7oXgd4RaBRoOEDJmtA/IgvEqz9aJ/tDaa8pAGBYso1j6cwzrOzAW3bFPIp?=
 =?us-ascii?Q?b9FQ/oODS5YfiqA/yG4VAy2ER9caiojglAJwkSm3B6SD2512rT7JAKlna9vJ?=
 =?us-ascii?Q?GrGn7+dQ5DfJsREGGAm/CAUfZAfhjfAfA1kiXCZyyDV1O+VDeII/5J6OrT7r?=
 =?us-ascii?Q?t1ZYGy8WGNs5EbanT9Q36ZnoYWTTaLmRzNOTXyGUTQjD0THL3rD/rX/u1vxa?=
 =?us-ascii?Q?61l1sF3anfPq54o1q0D9xZE1xOF4y/yBK4sOLR3PMmsGkExcdql/Uc+citLR?=
 =?us-ascii?Q?aYHcCQhlSByQaIuVmfoQ+7RhJgAOuHAO1AkFW9/1RRIU2G+qDF3FrzwXBmoQ?=
 =?us-ascii?Q?v+CtTUtILimcEY6yfu9Cb0w1FwLJY30GK4Ir3gNUXj5FWQm2qvQ9P0yWyD8z?=
 =?us-ascii?Q?Bpuy8PBNMC1i7H5uRaFklDr0OniHa/2cjRIEjw2b1a+kXkmorHcEjzl7hJEV?=
 =?us-ascii?Q?CJ6byAZKxRl/+Wley7Y+DNL6WBI+LP5f5W+7DXHxmo85dUjiNtUGXcUxPej1?=
 =?us-ascii?Q?NnD3jY1Cy3hD1QiKR22GTGBxF1U/++YTPXRmnu6U57XLUeTZAAkZ6mJrtw9B?=
 =?us-ascii?Q?dZ4b9P7b3LM6171hWehZWkM0Gl6ClFp8D9RYoG0F6ZB/GlDZY/EQT8Vo0GTk?=
 =?us-ascii?Q?O/PFA0FXIhMd4XsTueWYVkpiAbRDKmD8JsKcxXeyhKvdQvyAPStglJdkPPCK?=
 =?us-ascii?Q?OTIvwv/vwg/YGlhrejieJFgNzAknGv39AIMbg5usle1RLI1V9DEiDzJkIdmg?=
 =?us-ascii?Q?JOYFv8mBpDVj5aw4nmH4OLpojzJFWEFlW9OflC6ZiQ9y78nQa+/f+l3jwDWv?=
 =?us-ascii?Q?Mhp2r7J+koyfcL1ZJB9lmWGrpEcaRHMz0vM8cqKd/R9nfM5JlwULMWTwE91k?=
 =?us-ascii?Q?AnthplEDZdlDSa8P2WdugDoXwFM7+f/9EVkyepxfGcKrSqNqlbuCUzKoUt+L?=
 =?us-ascii?Q?xH8K4Og4FuSKq8jGkLMCMeRMSS8n0I5NBYmI5eD6U4kTxLbNARxvVJXh4j0F?=
 =?us-ascii?Q?W8QOeS8J4jh/s66V/y0VwtVwVP6OEoKB7rT4FRWK2JvUb3Buj/geqBRrc/ym?=
 =?us-ascii?Q?N3FACY+dl3sSMHmacrXkDZvh2G+3yHF8Cje4XrghyiMQGMKa5SoQUDe9jHbB?=
 =?us-ascii?Q?QTuogFJ8JJ04ob7TkEG9nE5ABT2R7pSIlNIrgMuAzH7claIYGBxP8p7ddQwq?=
 =?us-ascii?Q?9k4JQYxAaJ+5i6a1YhEdzuBUz2HwV32Clqavig2a1tR2jUMF8jbM6fk3nt0Z?=
 =?us-ascii?Q?jBMVRMge+ny2kndS6dxYMxlI1ZfI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hV43/B4hF2D8L3dtM18eO+XmKSkbZLrBwCBj9vn8CluenfwMbScPYhZHwFQg?=
 =?us-ascii?Q?UB5/sqFUiugvvskPfYXrNGbH1nlwkHoDNmxe86/ptDjobGBA9dpVSEgcoFcW?=
 =?us-ascii?Q?dXqGgBEzMGD/PK0xWBiyP3PYlCqCRUQO/nIsQHQFod+NpsaLS/uFM8Q4FI9u?=
 =?us-ascii?Q?ueYll2w/iUCnaNTHRXnJKBjL4Emsq2PkW4qam54+/SxbIYaG6v83fqJDTGen?=
 =?us-ascii?Q?Io23IchizbepCWMX8RhjOjyWp0TDkk+vE4Ly51umonVd066pOMb2YD0R5o5Z?=
 =?us-ascii?Q?HRt1iU0t3Ja29UYvAyjuU2gYhYe3aVuCXnuM8ShfWFtRBJ56/14xDQgcByTI?=
 =?us-ascii?Q?gvaOyLHk9kHEm57PtDyLSw5w4oZ4ynCYKDq2nVbvAL3cQ8WgVoIwMqy+Re6H?=
 =?us-ascii?Q?pBmWnX0dh1kv0Yw8SXw2gNDhWJjaHRVxpHuOv4qLjFoeFBChl+FaNGu4fT3J?=
 =?us-ascii?Q?/Cn7yuUQFv7lqa/UeTbQIP8SlwAfqO4xrVOuAA5nr5D4DVt3GauHZy5CVdYX?=
 =?us-ascii?Q?zmg2Cj/ZNzFO51mgLCvpNuDyWom/Nm+1I0GEaE8tboIvn2CHsnnwIuh9Tiak?=
 =?us-ascii?Q?ejm06ua7sSswlO1nal7Mx4u2Z5qFIFfDCtIL4kiuZLtBLXrZc/jEk49ymDfP?=
 =?us-ascii?Q?1c9zDDw6w5DcFzPfrss16q3MPQB482avQ+gJ0COh/vOm6Qzayblw8QOEhbWG?=
 =?us-ascii?Q?Uxnh3JLPyf92b/BEqrZ8xhCktmSaRD+etWhG+q7aHXt2aqprF7qsaHpMYOJn?=
 =?us-ascii?Q?DQutuXI/B/yVbXxGNKty7KOWnEIp+SeTmfCYsz0Q/aeGfxBiFil4n2xk0JKg?=
 =?us-ascii?Q?B3qKRUbrkE1rq0Jp7EOl/HXlLW6s03ZGfac7OszN44D27eG61OP1f4E2+Snz?=
 =?us-ascii?Q?SLQ0DMH0aVKiEmUMON5WLSXpKgg0utFpXguX88cTvK8zCAdWt5bCct09LZtC?=
 =?us-ascii?Q?APdD8gIpe45cmR9fLXYkgtEoG2sjAMWm6ZtY9YiyKHNPMFu6LDum9ZtA1LGS?=
 =?us-ascii?Q?rKYdDTP1MLHLfBQymiduzsaHIvtXN2vSLUjyboe3xnVUST620iEHtsyZri3C?=
 =?us-ascii?Q?6lUiNDeCXoN5auonp70ArK9sIvvkbFCeg/Dd+QsTc6cIkKsY8n/TOeJuBU6/?=
 =?us-ascii?Q?KWFpmdHR3ieaFNbVHVQ4DEUgy6J8g9vIco4KtJ1YgYYUOnY5mH3rY7zeYzRn?=
 =?us-ascii?Q?QVbtaZjexbNW2slzRnW/woesEmgzQewclJ5hB+4urCgme9fnI9uYqT4tusJ5?=
 =?us-ascii?Q?m4Zg3fCddDiZO0Ex3OttktQ1s+p3Pl4v/g5J9h2qhcu5udK4uWqcgpk0dtH7?=
 =?us-ascii?Q?xh4i/YNL0tYOl7kWuktiLc8HV5+NtxMWsXVYHDqvwjmdfSw5ptZUrY4cFlEf?=
 =?us-ascii?Q?2hUzknokxSEo+UgFnvvuUedQjLjgPJBwAGtiJg/IX1AojCorui82SGtygzDD?=
 =?us-ascii?Q?nohzh5Glw6jgarJg6eWdi2LQ/xAaBq+gL7g5nvSOeBOZJRn+eixBcqZm0gyS?=
 =?us-ascii?Q?MTt5YHO+q9iqIxwFzfwvO/N6YUSkHNEAG0AvVf0zqpN4FHoHxvdZMcS+P2ub?=
 =?us-ascii?Q?pbBIkhCL7eoCdLwB/3ED9BEWhgJyffaFwROCgqCu2IDjNr8SheyKd4MNKIb6?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022b94b0-d41e-4419-57cd-08dd09136fb6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:28:44.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeaB1HNdvZtzVPeoBUPc5jLGu+ZN/iiuNGIkmX++wFd3kvu1xxzfTt6xzKPCuTiuB0SNFTGDMnQPed7RHqBg8Rlm+d637dZo23tBDK34efw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-Proofpoint-GUID: zAtqFkk55IbDbqZwa-m21O6je9zGL6vf
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673d576f cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=WX6PLalKbiYTgt8n8iMA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: zAtqFkk55IbDbqZwa-m21O6je9zGL6vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411200026

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 95931a245b44ee04f3359ec432e73614d44d8b38 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4d78b5583dc6..f58778b57375 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1764,7 +1764,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2103,7 +2103,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	if (rv < 0) {
 		mutex_unlock(&lock);
 		goto out_cleanup_zone;
-- 
2.43.0


