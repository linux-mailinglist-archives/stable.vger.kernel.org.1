Return-Path: <stable+bounces-121346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26153A562D7
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5150916FB83
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D541AA7BA;
	Fri,  7 Mar 2025 08:44:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B331C861C
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337073; cv=fail; b=jce1aqag8WCu2tEq2eBEsPs2NLIohzgEV4VXyEyeGtGY37PZpsCd9HVJuedQAvBxSNDyY2Y/7SAJd+a6jJXdW0V+MvUwJA31mvC2pbByLpL+3jIrjIsU5VkRIa87fSZKWRPEh7Q87oOeOHa1+/+FNbj3s12i7GRbolFWdQz4Vio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337073; c=relaxed/simple;
	bh=zRcN+rqYq96RVJYSqDU/jBBnR1Kon811OjypkIVm0A0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L2KtfUckKVvysXs4ycQfmrCkaat154hD+reIkc9SVeJTnVM10ez0n0kr+CYh9jLbP4Q62TwIjzXspvwr6Z4IC9cc2B3Dvt75a5qHBoE9kJlV3JzH7Rq6H0C4S3eIrkGc7WrUsnCbNfcxPcephzOJrH47lpArP13d4ChM5h3oMO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5274o2GJ025705;
	Fri, 7 Mar 2025 00:43:02 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 456cs7u2d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 00:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxgEpqCICZLi07MN32U/eG3+ixPU38h77ac56d9tpNoZOrsaS7wteU0dtFLXAbyzbo2ZJ8DbCGAWED2Mvc26YiMDXQExF/WTMK6/PMRmkiQHGa8zmKBv5ivlG4eAkXcBsYrxxpLv4HH5tn25h95Q31NFnYYPXRvFnfqR+A+lUbo2sotYKO498NIHwUT0fxVpSbK/2gN85Aj+4GXiVqp7PLL/uo0bMl3qwH+M3IsXEBX6/qthFqiOgOOiNSJNakmtuHNkdMU2vwG3wNTebZP4umbSdwJhqjUtsuBXkGfsJ+wipR5t8ZSPngU1Z7NW1HOPvULdYl2qh+QXg6lajOfH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ree1CFAFwP+zes3KKedzabPFc0jlk/Lxfjq3RHYNVDs=;
 b=PMJMTS7GoMWY20cbfNOOb6KCbPT0ZKSnAn2AZ6WAuILCvFStivO+ORZd/x2j9zKMbnabkz+5vmYvwKJBXslw2KkeyQ3uONcBmuaYXv+jUFRMGQ/jvC92vg8+IKcj9kQSlTBJ68nw3KCqhucLQIlgvTss8FaDTA0TU69KkOiel0k22Qw0XrllP2a15xwHyIhCz//UNton+4OV6MtWVbUMfOVdWZetdnzWLxfw2/0T3+M52VI1TDVHQ/VyP/j+u0kbxK5h+8NBlDORBKPtwa7/Ms+Oi0r43e1Y6LC67baWG4HhQZWL+3QBtRTQZfhUwOcq4AzgbmcuhE2ByafscfGEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 08:42:59 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:42:59 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: qianweili@huawei.com, herbert@gondor.apana.org.au
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 5.10] crypto: hisilicon/qm - inject error before stopping queue
Date: Fri,  7 Mar 2025 16:42:49 +0800
Message-Id: <20250307084249.710957-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d640b5-9111-4787-fa7d-08dd5d54107a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jpwx2w9yXbcZHaMHJ+FgCj3jibTcm9BtdwRnf5ZuT6rBkacNC/il3Bl7mUC/?=
 =?us-ascii?Q?h049wqH+O7SB4ih5MqXoqLKLFthAIYJIOOeOn3FXq41g3Ysin8yEOXmQ0UNn?=
 =?us-ascii?Q?IoEDrm4rouo0kp+gLmwPpB/ObZvOeF5x21has16Ci3NJjN0aQjWymUQ9MLSB?=
 =?us-ascii?Q?ttNeqH5JAGx4bhIOLykGGgn81QqV94BptIDLX0vRktWFDuLqTtBO9LEXc34B?=
 =?us-ascii?Q?dlkBHZ77XvFjz3ePKoNau1IUNzuX/tIzig6S7IgTvXL+TGAG6BQDCmWP7sX2?=
 =?us-ascii?Q?1a760flaUfnJ9fdMiywIH3OWuEsmVG80+d5d5mspDq8RUkqnM2zHe2aDO/2d?=
 =?us-ascii?Q?sof9/9vjwxTO9g5lH65QwpP19uXg3c4dzs6ieMw1ovG650nPyZlWOX5X7fgy?=
 =?us-ascii?Q?tNLnsei80jtMoveZXUoX8k93mTL5Wgki3SW77HnvFTq0ZrAC5HtE0mvDQRSx?=
 =?us-ascii?Q?xnGcQLyzFpkYlbbFcofGvs9h59zG8jj7IO4ALGnL9azLaDI+6Y8R3t3L9T9z?=
 =?us-ascii?Q?a7B6P7ABItWvamVYofugvJXsiJQRzXT3RzC/dcj8O8s4nA9ZvPR3eGp6xtWq?=
 =?us-ascii?Q?Tt0QwBSiKDr2nImt0tJC/ZDMNTcRbV3+pOVMRW7Gf3fEFxep3wMbHNCkVQmc?=
 =?us-ascii?Q?LXvQ7YxUqda9RLYjclXtB0v4Rdg17y2y7/MhpzPe38vfYHDFTGs5VzBg11R1?=
 =?us-ascii?Q?O46DLH/i/peFWBz2xYi0IK0iHAZiJEYEoTQm8IhOm+TOyMuhUzxm/hROI0Hu?=
 =?us-ascii?Q?JH2G9pMKTPJQlZwD7AnVGsiUR7x49hxoc5ECjZwA/OT3vrgjKFka2Y5xUJEj?=
 =?us-ascii?Q?iN6cyydzizBE9guu6Bbj0LTQkuHAH7op4/pVV1EtUuan5meh7jdChpfVdNDW?=
 =?us-ascii?Q?o37fq3FaIb9HOW8DAaJH3cQRLI7LPC8XQzK62/doYd2IL5LkXAQGQPUn7lut?=
 =?us-ascii?Q?gBAw8fCVGeTUDhb8Bqs3S00IiXXa7fffEwFpt8u51/kQ6UANB9+TUnAiEPBe?=
 =?us-ascii?Q?jodYDR32FC9jKT0k454vLqoDLwZihnqW5fr4JYNxxLQve52MjzUg8/HtF2Z6?=
 =?us-ascii?Q?nxQcuR8DNNn+e7oqIz63nUjjtBWeUf8V4LrpwTzZLuj9bqdRhOCSysnG/eog?=
 =?us-ascii?Q?f0u/uXlCdUYTZBDTis5LiCH/fqfyZo/S2bARi5cr/Puu7SxWWrNuwf3wxYSI?=
 =?us-ascii?Q?lggUoJ46+8I3SSJWTJqeSoP97GLdX0hi9VDOhXL2OjE5sVpdRs1Oh29+Acwk?=
 =?us-ascii?Q?kCGCesy0cLiceqxwxL3uPS+Q5VBAsbaVS0yU5v7b4/51E61YFwg6mFYHmTyP?=
 =?us-ascii?Q?oqeqT3D5L4/DpYWyrOf7hXNOwWPK081hgbcrfv+4Xqgrlnkebn8WOiNaiSn6?=
 =?us-ascii?Q?hyf0qrrpjoAkLVhzFt0R+K5C5Rvee6BdPaX6jh9B7ZK1RToevXJRGTEXmwqm?=
 =?us-ascii?Q?uwskIb2XZdmObxBo+g2V3s/d/rt0GwDc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+jWH5x9VAVXKrgNXDyqjkZYXqFDwe3+hyZBfDbqT08PqY5ofUZWCbfCY1uV?=
 =?us-ascii?Q?UpwtkyX/Mo5Mvh0UNW3h5bQ8EbxjBDtlgftSOXB2F0W3Cks7Nqebs0+4st3e?=
 =?us-ascii?Q?1GwA3tBd0JHmNiEqAli91XgvcGTB801lIuURQz3lgbig3WPOevyCMtOKBuLF?=
 =?us-ascii?Q?CX1MNGONNA3hMfsFltkHo+9aPmu6mEY7o2Kd98sQi9BDL9mx0tXPZDJlvIZE?=
 =?us-ascii?Q?PUnd0Ocd0kNnBTGTqm7au0TyC7V+AP4AJ9WKyAPk3BTeSzRz9ilV5jgy65cP?=
 =?us-ascii?Q?EgrShzMYFaCV1PsFYQHa+fXgCp3sVm6dGSfpSmiJqqECOUVsoFX6uYfbb1XU?=
 =?us-ascii?Q?J3ZX2laSXOhLh61FOVdQh1CfG2q1Tc2VdQRtEPzvgU8uKUEdzzWpHk40gHnj?=
 =?us-ascii?Q?srRiauLEZKTjPC1rEmg4lyChktlg7PltgnJbkWiSWhIcPh5i6qxcGZUFJYeg?=
 =?us-ascii?Q?Mf3VQNB/wdbB8/LrfizmGBZERPv5/+49S5oGqrCS1okUafXRFH/r4F4EuV4K?=
 =?us-ascii?Q?K7F/4zvJGPgcEa26UQizVsrsMBP/hCHmb80s2hz1vwGrJJX8vlLwbvkCBeUX?=
 =?us-ascii?Q?IcmpF9JpMmWSQLzhH/TN2iqK6LBLKTR2CeyLhYxSTFIjunaCowR3P3BpH1BG?=
 =?us-ascii?Q?KtCwyaEnavB9f7VZrj73UKF/AkTC3Ua6Wl4iUw80S3pgPYwBE+oz4aRvBUWn?=
 =?us-ascii?Q?nOE4wFlKBhQpzpQjvBxm2q1Jlv5DbcXsl0XFUh/Hn6iXheueXZlxBrKM5ve/?=
 =?us-ascii?Q?kBQAYCZGwLkG/Wtl8Y+GoqIo5SZw+7yqejSJENvXTPIMXpviHdD0BNvmqj+o?=
 =?us-ascii?Q?eIgfu1wPrccDPF3dOUtF4SkM/IaiZrvrbIoAdZjJrXZt/1JB7yx9GyxlKg24?=
 =?us-ascii?Q?b530yAsTjvyAy9MQrz0uI1FsouGW7+BaGaoTgUDPn3KAfteXgCRxzwu0zlcI?=
 =?us-ascii?Q?KyGf82YeF4vswcqdM+02YzpANiKdH70bWOyl7n2GWCBOpJTGCuau7TqBVT/r?=
 =?us-ascii?Q?CD3+9kj6hsvnZghnb6ALnni2ejGQhFHs5/WNF/NZTsj7vFGFmdLmpub+Izu3?=
 =?us-ascii?Q?dfv5FFx7kQ6mInBTHekT9QBp190VscpkEMaDbUWOVp2Nt/KFEl1r7sAcSngs?=
 =?us-ascii?Q?6TZpwikkg4FBr6yxLFOQtVN5ebjxXoMNZwLLc0lNDC001OpD0BhsRuVXcFwQ?=
 =?us-ascii?Q?irlG8cCsRoFvCeYaLCP81WpjbdFtvYbL1JbQs+dWX2G/igoHaNfjhJIhCqaE?=
 =?us-ascii?Q?M7RQ2/ofIxsbjFLnEFdZkOgrCtF3gSanH8zTGsefHYe8DMZoHZa3g+4MLG7R?=
 =?us-ascii?Q?iSBT4/Qzm/baR1o6ffGYKiIFlxZeXr8VGL9km+XPYFgbCP975Y7TPB2ZSXqU?=
 =?us-ascii?Q?mNHqgW0arbBe4WGy+r7FHIZD9dvM3nJX5KzsRZTq63JCFBeqFglioEB9lvd5?=
 =?us-ascii?Q?7/G5zpt5mUpPTWIgw7jPbw/nlYbuHWb6HVLigQ65rGZmE2fssdIuu+MR8mQ1?=
 =?us-ascii?Q?gwn2jKGJS8gM2/hh+hYIVvoZAeM3HKfqRS1slg8/BGI8GmdlN7evRfLmkFYw?=
 =?us-ascii?Q?4i0NfKEpaBm4eqNibp8k2cEMrhS7mdgtJexYkJcc9lnsJH9uKmr2y0zwOtqD?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d640b5-9111-4787-fa7d-08dd5d54107a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:42:59.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM8NjUapWMpkcoXTYsLM/QlxIzJ9xg2pbqMxNniNIB/ya16MZQUERYwVuITRImgjVstSdUBA91nKEbLREdTfqBz8XwtAM+6HR1/tG2GAf5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-Authority-Analysis: v=2.4 cv=DfbtqutW c=1 sm=1 tr=0 ts=67cab196 cx=c_pps a=Syk5hotmcjzKYaivvMT4gg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=i0EeH86SAAAA:8 a=FNyBlpCuAAAA:8 a=t7CeM3EgAAAA:8 a=mzVGTZs34JFsiwU4K9gA:9 a=RlW-AWeGUCXs_Nkyno-6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: qOTPk3PFtBw4TMa3g45nDEQc_fwTyi8k
X-Proofpoint-ORIG-GUID: qOTPk3PFtBw4TMa3g45nDEQc_fwTyi8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_03,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503070062

From: Weili Qian <qianweili@huawei.com>

commit b04f06fc0243600665b3b50253869533b7938468 upstream.

The master ooo cannot be completely closed when the
accelerator core reports memory error. Therefore, the driver
needs to inject the qm error to close the master ooo. Currently,
the qm error is injected after stopping queue, memory may be
released immediately after stopping queue, causing the device to
access the released memory. Therefore, error is injected to close master
ooo before stopping queue to ensure that the device does not access
the released memory.

Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the code compile on arm64 toolchain
---
 drivers/crypto/hisilicon/qm.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 530f23116d7c..8988ee714ce1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3354,6 +3354,27 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
 	return -ETIMEDOUT;
 }
 
+static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+{
+	u32 nfe_enb = 0;
+
+	if (!qm->err_status.is_dev_ecc_mbit &&
+	    qm->err_status.is_qm_ecc_mbit &&
+	    qm->err_ini->close_axi_master_ooo) {
+
+		qm->err_ini->close_axi_master_ooo(qm);
+
+	} else if (qm->err_status.is_dev_ecc_mbit &&
+		   !qm->err_status.is_qm_ecc_mbit &&
+		   !qm->err_ini->close_axi_master_ooo) {
+
+		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
+		       qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
+	}
+}
+
 static int qm_set_msi(struct hisi_qm *qm, bool set)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3433,6 +3454,8 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	qm_dev_ecc_mbit_handle(qm);
+
 	if (qm->vfs_num) {
 		ret = qm_vf_reset_prepare(qm, QM_SOFT_RESET);
 		if (ret) {
@@ -3450,27 +3473,6 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
-{
-	u32 nfe_enb = 0;
-
-	if (!qm->err_status.is_dev_ecc_mbit &&
-	    qm->err_status.is_qm_ecc_mbit &&
-	    qm->err_ini->close_axi_master_ooo) {
-
-		qm->err_ini->close_axi_master_ooo(qm);
-
-	} else if (qm->err_status.is_dev_ecc_mbit &&
-		   !qm->err_status.is_qm_ecc_mbit &&
-		   !qm->err_ini->close_axi_master_ooo) {
-
-		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
-		       qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
-	}
-}
-
 static int qm_soft_reset(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -3496,8 +3498,6 @@ static int qm_soft_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
-	qm_dev_ecc_mbit_handle(qm);
-
 	/* OOO register set and check */
 	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
 	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-- 
2.25.1


