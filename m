Return-Path: <stable+bounces-96189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F49E1393
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C73B2329D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56B1862BD;
	Tue,  3 Dec 2024 06:53:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C374126C13
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208781; cv=fail; b=QQkMNhCvhzRL+DRTmloMFClJSezo1G3m1NhZB8SOrkya/LOfLTfLqzE6fwWknjJ6ZwE4tIijtOy9Bmkw7Rcv7TxL53JUs1nKHEZJ3Rar+Y/OXX7ILFXjv52A97STHQzUP3NT6qi1k+o/OVKj6EfXCLUPLf5Birx5la91gFzOAsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208781; c=relaxed/simple;
	bh=3abRmas5iT5Xkg0t84v1zX7NBeRUxP0Ew/elUIGnTu4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kbhKSgY4G9sFnEFfvG1u2Iwm/VlwuqxN/w5QTWDpdUwwa+OOcR391SE5GQzme/bmL0F29aMm3ooDIFnei+TKQzaFBQ/CBhgbvhEh4GzCURC5aWM2BYCwAQRJ+ks5wI1EM3dE2FF7YXEFY1wFqkEFl4zmnm7UyB/RW+TAQopdpJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B36O24i029680
	for <stable@vger.kernel.org>; Mon, 2 Dec 2024 22:52:52 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43833q2jjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Dec 2024 22:52:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMRmAU86jrsLKR23icODsOLN58pOqcwXF0RAA58C7ZndddjYYxZC9bplvdutlFl/jMgN4pbw8KAXMfE0Mdl5rWYZXu2685UF0llTEnfFXSiruAPKhuotI6HOkfY/yV1ORNKWlsnnZbRC+ZZAdbl4sW/6ywwMPLIjgSLqwSU/watlv0uef6IyaOh09INfkA4+XPuceACP9pn59Lfh/PcS5i2ZRFZ0yTEM+nshD+LAcrZgwVqfUFxZG+IaC1qjsRTCQoIRRuDMLP+LNma+IggjHVXE/5R+mfUkVxV/8t/kCOmcmxw2a8dUeYHHeenFPYkiX8PBVIaz2KOb711dK9vgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eLU3IX/V0bTZg4YTR/pxMr1fsJKzoHmez5+1GfapBQ=;
 b=UaCNxnucbcnfjnyDPVlQU6AYZ1kHiPvbXNY/IoCMaEz+7B5hFyt8co7YtaBqHyFoHzBnoL5KYAacs+2rOBL1t6IR6almOjYbR7qzly1czgXBAfrLzcLL5u7nSr26lTTGdbxdFPIwt1fdeoePLhkIYuI3pQEE8vn3JSiaYMTIatS8WfGR2TiAEpFyrPWMfQ18G6pqShbY5RIFp5Qj7bwMvgXEm3E/u0jLtKBvRn968GPoHnhUHbNsGJoue1JxA6lpfK3K98dBkJheQQd+p8bzZRw66Q0a2/4D2wD7TQZ24CIZOWbgw1eVpmM9EBmRHN+WMIr3ZPbtnO5wAYqSagnr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Tue, 3 Dec
 2024 06:52:47 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:52:46 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 6.6] crypto: starfive - Do not free stack buffer
Date: Tue,  3 Dec 2024 14:52:13 +0800
Message-Id: <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0886b583-3099-4836-72ba-08dd136717fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYpmiUk2ks/E6IvHIa1LHf1FFLIYRF/Ns1bZDbV4RJNr60ykfp4j61yA7r+d?=
 =?us-ascii?Q?YESH/ANIBiyVwG5g1gA1kychdLweX2VSnz7SBJWU57EGr7DT2P7QarZJFfzj?=
 =?us-ascii?Q?emLqvCDs/awND5s56WP6E4HAl26MblNWkDjWKGZuJWv0CpaeCTmdL64X7YLK?=
 =?us-ascii?Q?IU1SnURzTdmG2N3rBvfXCZy6d96biqKHwYsMAgJLwbKnQ4mg5AQ5asym8qYU?=
 =?us-ascii?Q?kvliH6KkFdIaJw+vmoyx/qcXw6lqmkYAKMFQfItx/I6HeogZCmsXDBfjSLn4?=
 =?us-ascii?Q?EXL4f0eTreR5kiMsn2HshgJWDkPQY6OKmqBiCAfjPmAOXWZKPSrR3jVwjQ5g?=
 =?us-ascii?Q?D64PFBxhV8bbakQESELlyvFsa+DuRpqdNw+cfqhjyuwGjnXHxBeTrHpkrTTm?=
 =?us-ascii?Q?RhPolE8mbvRaQ3zfsr/3WA5sTIP5BdJVOgeTQB3Vqi1cj7rPy3yigaYpwyHj?=
 =?us-ascii?Q?XmFvSaBDgTWaAXYqtKXeNUmdynsoBaqymt7xc3//JKmwJsYR20eNXcL4ozl1?=
 =?us-ascii?Q?NJIz2trs5Ma8fJXJOBAmwJ420e2hfBYrACPx2p5QCVj8e6DCmuPQzBe/AshJ?=
 =?us-ascii?Q?2DWpaC1Qrm+eYULzXzMcjd+60ZgLAbiShjWuh7jmIdxOY918N6bAf3ZaJJGH?=
 =?us-ascii?Q?oLHGzcm96sEp6Si3UQwYMo1z2K3NxBmmnWjPojXy/C3CmvhieL0vMoQc8N/Q?=
 =?us-ascii?Q?AWHRCA6Wj4Wj6pAxWKMJGItXcfGQrBySyrxVqPN8HHGkojJEJGGj/egmeRCy?=
 =?us-ascii?Q?sRG331Otthf++jqm87NAc5MYytex9/wRSPC0uJ95oKqqc06iDh5SHPd3jElh?=
 =?us-ascii?Q?k1RGqqZKXzLbyPeShbRwUEJG/YGWzQkkUc0dQhY8ckB99YSDxAxRyjoU/z9E?=
 =?us-ascii?Q?PIHtHwTRal7A46Yqy22jqGEKjTVjuwvqpqZwDX3piyoC+ftzLxHeoAKDKkZc?=
 =?us-ascii?Q?vlQxD9eXufhRzQsofxXb4aoTokymq60Ue4WCdphJtvHW7Hl3jGqba0mzCbq8?=
 =?us-ascii?Q?rJPFddK3219iPyITDgT3Ndfvzoj90vE8Z5gGAqyTBzm0mwT+CCgJq6J1Ol0J?=
 =?us-ascii?Q?d1ZxfU6u/bPV7K2S/PSBfYdwv2wc6YbAQPERLKcjywKG4WW3au1uJGqxQe/1?=
 =?us-ascii?Q?36rK9Ade9gZKhu5jWXuad6x357riPcT7yyPoRsNX8swBTwHmqHFlZgmFeebu?=
 =?us-ascii?Q?Uw+Vvd1ypKqGcS/6auNO8q1tG/tCdAxTOZx+bvtOqdeAh/NRR1oKjWpuQkUl?=
 =?us-ascii?Q?H4JifoM4qD42gefvGMWrI9Dn8nWss0h/r71hAwF8tls2oPhl9UVEWFuNfOJ+?=
 =?us-ascii?Q?T40qHJIOkrxe26x55r8LzEu3dIHAcgkxsgjtLZRXLVQHcmSad4XdksqwTFH/?=
 =?us-ascii?Q?wkW+6TMN3zNJXJjeiqC3LzPQ5Z9MP9g+1PBe4sUf5UH3ETnb4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DIv1HHQTal7x7+j/Dl9VePxWDCIYJy4ZgWxvIpFoU20aZK/yNGoSMQbHwacP?=
 =?us-ascii?Q?LimF9swLaRJZisuLK4bqxNIUKugoVKAhpOpsr2iYXIKPGqz87fkLKdwHxDQN?=
 =?us-ascii?Q?2DpDShecNtrcmcFznnKwzGQRLCjBJU0qo4s+Xh0LtnWPvmkTn5aBX45XlimL?=
 =?us-ascii?Q?Q9LYAk5vrTfjpLZQ7X8iQTqXMSOfyRG05VDh+6zwXuQlsIjV4En/Oc6Dml5y?=
 =?us-ascii?Q?2UQUbfp7fsUhMeoDNjdAoopKN8j/VWd6nIYaNK3xfph2l++MRI5dZM1bVvht?=
 =?us-ascii?Q?qH/Mb9pcsV/Kv6lrO8Xni5RDqE0O6UrGS2U7AnuYD5WX3DaWUk7xuHgp1nl8?=
 =?us-ascii?Q?wJ6l3vQ4LHIQHMmIOV87jIGoiADaYD9vHbtMoBJrmjMdNqIf1vsXd+YxMW0c?=
 =?us-ascii?Q?hPdRWIxfuwSrr5pVk2xkVlWRLtkQj3KLPQKc7HzX3y4LECVFTO5XO3WHpsrI?=
 =?us-ascii?Q?OB2+umd9Xq8cT2G00Tk1Fu324izkPq+eIlXmDDfLuN5npYVcGOgMTfdiRCEe?=
 =?us-ascii?Q?+0IC4s10jtJOwzfTJzcgOim0za89C/noJrxHJIqjAOqMMIyEV/h9cjyLQNpM?=
 =?us-ascii?Q?/AOQ8ZfrqsFck+6KvHxHowZTyKpfp5jFZ8zOJeMUpWTo0P3YcAi8D6h0KwzV?=
 =?us-ascii?Q?XbWTGHHki1L3DcHPufT6l9SQWg78YXFi6NQ8BRxqoz3up9I6iAjQHhzpBT/W?=
 =?us-ascii?Q?ODuQNOzxvgoQap2BkjCMKRdc81Ki16TzfkXI/I2K1nE/5urqiJOlzosOCgHk?=
 =?us-ascii?Q?bl5R0ydh7XXc+cDU+rz4Woiim1PRqjhHebRpbc9JiZnWdM7ClJgtK5TTLyyq?=
 =?us-ascii?Q?Se+FN+4kSxd9vFiyZ7CyfMYJ+Zq9SLDO2BgtTKntNMmda9SRmGMU5QZzdx4v?=
 =?us-ascii?Q?+Tkh+5/KRwW1YeMeY4xpP2WFf+qb/9GfQC/3xttoNefNNwYvzjYc1MrPN1ar?=
 =?us-ascii?Q?iLWYYA5nBVW64+X8wFEC6jN7Ukp7va2bTWEYKASf9FpK9g3nxJ3eymmmjwU/?=
 =?us-ascii?Q?YEjSjujtO+YnLB11f7CNuH4pw+czTDIEVbpZRa3lPiAgkTp5FTHMprw+pfer?=
 =?us-ascii?Q?qlwjMcoQ4GJ9eM9kM+aVxeqAogiTbyCSqtCb7xaorQXOmthThjrG1xKphW/m?=
 =?us-ascii?Q?NG4TttB1unJKBVsJvwxWDMIlRY3DJ1pPPa2EMi202D5qjYr+SjtsLqN1Eni7?=
 =?us-ascii?Q?dG8f32ZPJ8Da9fLmgwH9SAzCEAhKIbDouhC3beuuSKdoaBCHecuKCvMTh0Ga?=
 =?us-ascii?Q?8XRk8krpqMoFF/MRA0KSwldLDmflXl8n0zszHBhhGJy/XxIlBD88o94qJo7j?=
 =?us-ascii?Q?LduVUiJ4k0VsyJKn4VyvNpboXkPQJHKNacU+d0vo33+an0vjyk04G/1XVWWO?=
 =?us-ascii?Q?IfwJWzn6Wka6CHyyCoOrFJxAYm/JGvFLxZ6JL8Il4fDzoklSvHfarE+kdpz0?=
 =?us-ascii?Q?voLO6mwfbzjf3fUXehEtYV3Ky+uOINrL+jelcB7/45vogLd7h8hZ3iVB9ibm?=
 =?us-ascii?Q?rKgZ5jbV5fq+sJKknxr7tm4K5X9IXLZwmoUQTJCadl6NSX3akq2y/OOFB8SU?=
 =?us-ascii?Q?f9exQHA9rZHULbIbxLTzIUnb58BcEgepFYp4PMjvKXW5yTLKkc+ZjOcCrH7+?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0886b583-3099-4836-72ba-08dd136717fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 06:52:46.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taDMSf3K/4040zFz7YZ5AWSQKbHzsqYrEYzuUdQqcVXfb7veinYaDAKZRcIXXejImduK9OJ95CzTAh/Vl9BIaj4mXK7rCdfUSA4lM2Gys0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
X-Proofpoint-ORIG-GUID: NIgLE3qVReKUtZUEXEV-hdacGdabZNul
X-Authority-Analysis: v=2.4 cv=bqq2BFai c=1 sm=1 tr=0 ts=674eaac4 cx=c_pps a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=Bq6zwJu1AAAA:8
 a=VwQbUJbxAAAA:8 a=FNyBlpCuAAAA:8 a=t7CeM3EgAAAA:8 a=cgP0u2KHGnHXADnyA_cA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: NIgLE3qVReKUtZUEXEV-hdacGdabZNul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412030056

From: Jia Jie Ho <jiajie.ho@starfivetech.com>

[ Upstream commit d7f01649f4eaf1878472d3d3f480ae1e50d98f6c ]

RSA text data uses variable length buffer allocated in software stack.
Calling kfree on it causes undefined behaviour in subsequent operations.

Cc: <stable@vger.kernel.org> #6.7+
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/crypto/starfive/jh7110-rsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index 1db9a3d02848..3116828d60a0 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -303,7 +303,6 @@ static int starfive_rsa_enc_core(struct starfive_cryp_ctx *ctx, int enc)
 
 err_rsa_crypt:
 	writel(STARFIVE_RSA_RESET, cryp->base + STARFIVE_PKA_CACR_OFFSET);
-	kfree(rctx->rsa_data);
 	return ret;
 }
 
-- 
2.34.1


