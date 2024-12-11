Return-Path: <stable+bounces-100566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8409EC72D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D912D167BF9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4E1D88D3;
	Wed, 11 Dec 2024 08:29:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A062451FC
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905747; cv=fail; b=EJN1c7xR8qhCyad7aHgcfP0kSKIExY9eiEbLXcPQQB1327+u/fdb82f6ZpMS9GoamNrO8LNNfcNGCFxVYJcUZ4nbpv3wHdFxLTedPSrVSAe6pyjXegkU7BDxCpOVxt5wVSlJEAyWJLGVDaomD9kBayPPIPjgevOdB9szHXc5XVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905747; c=relaxed/simple;
	bh=7E5ykwjS72gzTrNmVIoQB7KLF08+kpwvwC3ehdCsVY8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hmyP6e9OUF9lP73lvhrLCBGM0djyiTwuiySU8BxvhGZWe9Wf8eXkrCYlJF1xqBxDDlr0fvQE6RA+WPYF857gVsaBRz25HtuYzN1Y3YChVcFaQ8Fg5HNIX6G0499QUpONR93+OHUs8xV/i8NcyUBg7P5g+6SB/u0Nfb6MJ7T6c6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB50s9v027438;
	Wed, 11 Dec 2024 08:28:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3kxj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:28:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJti5hl0BgLo8dY1P9N8c/3WjV2nXGf/8Qv7DNqeJimPFMS9R8DV2nidbywjaQRc7sHkKV0whi7/vPC1sKfNwG+x2d200SZXIBTglXRLXX2M6auWy6hfYkO2rpSK+9WQitZE44MQ0rYoG4hps+mj7Gh04dMj+dBz9U6D4ZW3pZMpVfWuzLM5Jx8ceAc8kHoG9ypQlvlT+JsDcSuO3iWXaYhxAZHFyInTRoeQhc10Y+wQ/mNd5AVDXlTNN7SPB7Ba73rDiRMqxRzdhd4ZMA3EYuEdfJDzddaz927jQ27ArOLf7XittQ8FA4qf4u9pmNotO4Rp3GWZPvKAPv8x+76wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E7HrpWVzmb7RjwFrsySjYL91Y7hEGEtIsb2DiNu0Q0=;
 b=ZNbh53Pi3giMNnEbf12Wo25kWV2mShRM+i9iMlWwcP5TdV0pBCvHm1fBtBu1Ebcq2PxGGE4YVE36zYv2Ga3mYwcaKl68h52r2ZCTdSUQwjFlGLBJsmrh9dMJmOy75Pkrtb7ktSvS5keyU99YGIpyQ9GtZkusJkkcSH09qeI+TRdvee/nHoQ5rNk85/6TqmwQ+s2eK707TCVOZEeJEzrOlhvXBaja1lhV3aFLJYqB7ZNxz/LeaQRLF0aQG6uY9esA3sxkF1EY/RBWRKyVjp4nF0C5A3Q1WMYYSsC+dJUIeOHuL3F6+Un+qUKPt4mNKVCtarH25k0jZPLtL/Ch7h2Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:28:51 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:28:51 +0000
From: libo.chen.cn@eng.windriver.com
To: stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, stefanb@linux.ibm.com, zohar@linux.ibm.com,
        sashal@kernel.org
Subject: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
Date: Wed, 11 Dec 2024 16:28:24 +0800
Message-Id: <20241211082824.228766-1-libo.chen.cn@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0375.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::11) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|CH3PR11MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: a90e3062-2b3c-4a87-a213-08dd19bdd77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u+zeJLO29BmLsLkc1YqaS5kafqC2roXcqgM6ITQguTiWGBTeefv/egleKeO/?=
 =?us-ascii?Q?l6T6wXc3TcbZgmLcLKrrceHtFz5QC51FXQYk6Da0lpW6tIA455gYQD9jKEp2?=
 =?us-ascii?Q?HSgdhhAy+LVmzyhDTkXsWPImayqSWUdDdQOWQdxpuFZdMSjxyDVtTTd20I0O?=
 =?us-ascii?Q?BE0jG6of2MccQ0/mWEbd1usQFJtYRPWwuf+6U3rUDm+Olq61Rza9/vEj83Oe?=
 =?us-ascii?Q?bNZ4vWys8eBSGtx+oY28bx5jLh49dWAr5+McD+nsuQL2Yl0fgAWMzB7FuSRP?=
 =?us-ascii?Q?YilDTXjhDelsqtWtNS8kGLzl/SNDP8XZwMST6Mpz3bkfa9+L7HXKuSeLZU5+?=
 =?us-ascii?Q?2VaZcw5NfFXAvHxv33CBVnGRoJlVQYILdWNp6+rO2TEaljWISQE8gotby6hc?=
 =?us-ascii?Q?B9yrmvdAHXM/nEYzE6Ud7K+5K/+mvUYRn/sSWS1Ru+SYlN3X7hDW8eo0vA0L?=
 =?us-ascii?Q?9MlWDJqr8ofXSKC3+4Rw1ifXet8ixhu5IRNXwj+56NOMpXWlXr6415WFWU9q?=
 =?us-ascii?Q?DM58uew4WVvmbWTnwt5mKxk+laNKtvNu4TAx8zYwfi6XllBb0rRkZWZQW0Ij?=
 =?us-ascii?Q?vXfIyaY6pkGsfzgHGgAM8thM1zv7pZ4MbmN3bMB7qoK7EavU/FQPm7FMfOHu?=
 =?us-ascii?Q?Mu/8hmLCovZdml/6xMMxVxM/3OWxEzat5DUSxRvatjPRC7WhBbq6kP7a1jTI?=
 =?us-ascii?Q?AuJ161NZteG8v1seOniYxqQir4rKfY9LeJzC05vn9erP95GbuP80J+XGEjF3?=
 =?us-ascii?Q?632dGid0CVfWAb3oV1iJ7+3EC01hFhNyY+kEmAPLK2DWhvxMphKMPNWKWQEQ?=
 =?us-ascii?Q?5RnEQk5Z+3C1zQcZq4XUZNSqO7f9y6WFFlHhzOmz8uuxrIesmNbdUrbF5eRG?=
 =?us-ascii?Q?VKHD/Mn1Pqg6I0GulDDziByVKj09McSRJbwQ5c+TIby7NOv8YJawT8DnJlki?=
 =?us-ascii?Q?6b5mgtjo2sZxKOpwWXMQPbNGRG1PN+BQ8tsW8jLpn8Md+bFXfV/fCzAcdKD8?=
 =?us-ascii?Q?VmXsYq+H6NB6nAD2XhRQP5yWxUo3eKaAe5+p5akwqsPYS3+1P4Vjlw+Dd2jw?=
 =?us-ascii?Q?YVGIq9xgIaywhlhzcYpP5GU5MZ/6YFB8s2Gx6FxNblXmpXv1LPwuhfYyGFxo?=
 =?us-ascii?Q?oTbMau87Jd1HxlrJvtkPD6/K5sjUSUM2kQanDGYNWg+DnHKXpnzG35XspFLw?=
 =?us-ascii?Q?0Bdp79iSx2l6wd0xRMCGEp55s5d0U6b9L8xHKrHkaPQ7rj9UyzZEcxrK0PLU?=
 =?us-ascii?Q?TI5FgeOI6mcMWb/lMoDgkGAfDADWfk1uszR5ZKSwTbpUWRcLKSXKrktgcClg?=
 =?us-ascii?Q?Bm63xCs98nwVhAb6zDFNbuv+xDMBIh621C/6Zle8/cGx8c5jQOGlo7KVSuns?=
 =?us-ascii?Q?CNI6O5DtPeJrMRQnPubOeeyDrGVUuGI8m+t9pi8yvGVz/LxKeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZt7kCeSWCj/zJXcBAn4osPWER8trM429pUQTfzSridhjQmDZxV4ylHAte5k?=
 =?us-ascii?Q?VTu8Y25XklJgJFieJHmkWIHifjg+vfmlG2nR3PWyArR25fn3ZxhFZCfYJar/?=
 =?us-ascii?Q?oeCbAc3fhEE8SdbVj1hWqEIHwVAl/xc2RFV/k8BysQ4InlmbX/qfA4ZJCE4X?=
 =?us-ascii?Q?eX04HhyMMk602XfPSxM7btbs48LL5MKDeSa9abvGb/sAcQCIrFRdQkMNQwuP?=
 =?us-ascii?Q?5AAUNR4QPU08aDMLJvkucVYVfn1QWwbLVyBRn40qLGaKCOW/t4I+wuW7TW81?=
 =?us-ascii?Q?ICIrFw4Y5z+Lj/n4lWRbxG2e8ZMbrmUJfr3k6GamYUL/jIbzNjF+qF5Rjg8y?=
 =?us-ascii?Q?MNl4RJX5k8fpAQvgcRw44PefFCXg7qixjNrrg3cfKvgOFoCQDNlW8Q3+jIHG?=
 =?us-ascii?Q?gERV2t4zAChZJ/PWJdKqFOSBT0mPlAMVZL77uQ2vBK/TdLDwF3F6fNd0Yu4w?=
 =?us-ascii?Q?zrqJy+AQ2j1dP2CWzTlbmR14CEzjhqDjR1/WqIq+73xDuZaooSL3Jori0yYh?=
 =?us-ascii?Q?vx2U3MK4MQSXe4rqRvz6wu/Zlso5bto5PUeDYBxfFtyJyLbV7ZGAWDn9TbxJ?=
 =?us-ascii?Q?+1w3f/63hvdpJ1ZT/kSCZQHx89ImBM22EGNK+WR6YLi63NKw+GuAjYI0Obik?=
 =?us-ascii?Q?YIyzL+IDtw3aJltQDaCVXnPnErJUSsL6RT+Vr1hm9eEyaDl3Gm2IeTzE8u5g?=
 =?us-ascii?Q?xrWCaD9zqASXiDT5D5gE3uQzLKmvSQHjhHyq+Rot0ZB1qnbIJRoGp+aU7hLJ?=
 =?us-ascii?Q?NmlqLgrCsjVZh+AoqmlqqRhb5uILyTxBmTCwma4lw1uPoJdFg4be9XrHCYyi?=
 =?us-ascii?Q?r9c5o0fOC9NIQLColq4WU0oTHq80S/yTIONXXSj5BiS20PrNhwA1bIbdQhQT?=
 =?us-ascii?Q?W5hL6QuRRdjewvoqe1k5w8CiATnvOVZ3yJPxYh/3ceIu3WGL2tIDnKGWoxDT?=
 =?us-ascii?Q?ZtoH4+KQ2s30ZGKpe8jA1h1skyJKnudwE66ZUmf0wwhQezj8Oe78lIakHMDn?=
 =?us-ascii?Q?4TdHBIpxgrAatSpgOQBYgnCgWgj6sVlk2Rv914kofYfa6R+XyyFblyhl3TZ2?=
 =?us-ascii?Q?qOtKTdrOwXtVpE4GiwGt3Ufd9IuXvmAjRkJt+Ay+68CTqY5tRfiTZDE+rf0K?=
 =?us-ascii?Q?g/souV9mK7CnAQRD9qo+WLH3OzgWxT4W4fKyZqjI3uvWHZ+ke7Z+u55N5Pne?=
 =?us-ascii?Q?3fQb4yc54mVDajhK1WZqK9DCNv/l8yzW27jXqPF6pB1uHtgQDylhHFnl4yUR?=
 =?us-ascii?Q?MtlpJ9RvIIxK3bkMZx03INXcNVMCuz3oISwp/OpxQ/7oh7SL+MBgPKVMxBxA?=
 =?us-ascii?Q?QZejsJVp1T1qPQBFoz/LXap/K6Kj3i1Ql8SDJtFtGUVSghSLViknX9ZmEFIm?=
 =?us-ascii?Q?Xy9xCnI0eFaALdFMY4NYXYDraYJWOWrBtTlXf9MID91U7OIiy6BjBfVfYnxL?=
 =?us-ascii?Q?qorPR1Fna+os9AmmJyQ4b9aQT/ZsFNI8rIIqqStzyrHKNH7oHwWMefDv0e6a?=
 =?us-ascii?Q?DSzLyOAWUfu1oZwVYv0uS9YQusRHFxLT0E0JzITK8gmSSBWV7Zm/pbE1aw2a?=
 =?us-ascii?Q?YKf75ILjL0S69fR8JRUgvFQlb/cEq88thOAQcqt+5XiVpjFiAhQfVPVoXUyq?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e3062-2b3c-4a87-a213-08dd19bdd77d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:28:51.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iwJxwEiZDLSI3v0W/pM/l2TuCPD6srU+OITQwvZdQLP4VwFMePWWBbKa2bqQjBvS18rON2QNz07nXh85Ikg/OLfnPh2iu+NYqwZ0FAEWmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
X-Proofpoint-GUID: Gn_DEhJ7i8B05ZacDUUIjxqNKYmZMt9a
X-Proofpoint-ORIG-GUID: Gn_DEhJ7i8B05ZacDUUIjxqNKYmZMt9a
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=67594d48 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=drOt6m5kAAAA:8 a=t7CeM3EgAAAA:8 a=Ln24RqLUxJUgtsCh-VwA:9 a=RMMjzBEyIzXRtoq5n5K6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110063

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]

->d_name.name can change on rename and the earlier value can be freed;
there are conditions sufficient to stabilize it (->d_lock on dentry,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met at any of the sites. Take a stable
snapshot of the name instead.

Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 security/integrity/ima/ima_api.c          | 16 ++++++++++++----
 security/integrity/ima/ima_template_lib.c | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 04b9e465463b..fa7abe4bde61 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -217,7 +217,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
+	struct name_snapshot filename;
 	int result = 0;
 	int length;
 	void *tmpbuf;
@@ -280,9 +280,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -395,6 +399,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -408,7 +413,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index ca017cae73eb..dd7beaa0e787 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -426,7 +426,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -439,7 +442,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -448,8 +454,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
-- 
2.25.1


