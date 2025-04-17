Return-Path: <stable+bounces-132914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A74A91545
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD116189EE65
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D921ABCB;
	Thu, 17 Apr 2025 07:31:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2A2192FE
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875091; cv=fail; b=ECd+ZRbX8ZYmyntz9YR/zTy+fX1ItlmAhjF+iTkcAExQx3khso5UTuivseCDnldBEdBc62SSW9aDBtXjjIutOX8Ghf1CpzDckFInj3gRXaD1A2RfMyQuQUSa48Pva2sMEQhtcivkKKNYoZDgiObwRAyAhhL2fUhY9cR1j7fPaFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875091; c=relaxed/simple;
	bh=bjOIk0ZUYD/kWVIwNz819lCt7EV3tWQ7So8oEoLtNUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyEZ9g8VE/TLRjQhcZB0XIBo9GQLpE5C1DjE/dNcXw2BmHGEd1lprTimzvk4agjFxSiEtGgR+6KsQL4cKPP0KL/4xu8hLVQy5itblOw5QcLO02vZF+cviSDdgmaWGPlPKFYiJpvThdd1PKjtZxbdluknGANYX6muay8d48vhySE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H602pS019651;
	Thu, 17 Apr 2025 00:31:08 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpknngt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 00:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Kxxodv1eBdSiJ0JGAM186pm8IgxnT9HfIU3ccCMtBAOtQP6tCHKGVv7MzkQ2guImBqRsRXf6Kphigsw12/Ksr8Lf0eHTQlFOz+YqToS1be5bGQ4rh6zOMuGQo5hKqUPjs4hGVo5LvNincIKs7CMbGUWQUOlYLSD4WvsT3GVVA10zE6US2dWa8auFxNbaHa7qOyqoXHdUUCPppKVhu5pn7KzN0FPvzsl4x5A/8vUrJUQiU3IfISubRLdJTsUhkMLRaLhuA2dGTWaoZddm1O8uh5WE5ITzfKiPTMTo6iD/WfmRjxPD9sqLF+1jwH5Hgptnoblr9htLVHTCmqz9Ebzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2jg/J5LWLYEvB9maolgPjZ8djdIqEb2nDpjAPP9adQ=;
 b=Cho6+mtCELKt7F4Vpqp23BNi3Ed60rLLZHeV4UEHujUNc5o3l/I8MFQF8KerDfsNIcdUEu5zo1qaxYMOMFtsciXqPUzqusYsdeB0HxMK4OOTHgl5O2Osy7h/vaSou5Yk0xet4nBccHePgw4c+CsxX22diig+n3J8UchSP4EG2n14wnJpnGd5OXyTOb28XtmX5Ilo3rv3ZqBomVDKQb2fZJxFhxb80UOgT5eka5fLHGBWHzfh4Tbi9ip1skmo2DeVIFBneWKnNzJEycSkIQ/n4TLQgFz+R8WgiSfQChNJkD8YtvzSKu5UXKGUbkwx3E63crXSww5ygIoxEjTHmzpGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 07:31:06 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 07:31:05 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: hch@lst.de, tj@kernel.org, axboe@kernel.dk, bin.lan.cn@windriver.com,
        yukuai3@huawei.com
Subject: [PATCH 6.1.y 2/2] blk-iocost: do not WARN if iocg was already offlined
Date: Thu, 17 Apr 2025 15:30:41 +0800
Message-Id: <20250417073041.2670459-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417073041.2670459-1-bin.lan.cn@windriver.com>
References: <20250417073041.2670459-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: b09094b3-8713-49f4-a125-08dd7d81d05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8FurDhmz3hGAa8ywKT6+mCTSBc0U91/LKODISNIgkoqIkD2eGc19tJYo/cd?=
 =?us-ascii?Q?5ZVNhwzfcPbRnVi/IgFjiQXKEYum8wNAqFvk4Xj+/NvYUq/dgVUa8fseNzEf?=
 =?us-ascii?Q?HltEK214GcObKmrQKXc60QyPCT3WH2ynMTp25MepCZePzv09wcmNXn2HQHEi?=
 =?us-ascii?Q?XUadTqTdQKCdu5NIdwpoeQ+LWRM4hFon8hEuFUDKxUvxlTfv9zcw2KbkaHud?=
 =?us-ascii?Q?VC1urJuwNk4AYLhadU5tYwdZnHtImiu0jGi7m3Pr1iTWiFPLeJEpAFjsNHYk?=
 =?us-ascii?Q?5G1lnfnL7625MyRkZge731QdIh1lMovmflG6T8/Ff0b6AUGIXPzmOqNHi2VY?=
 =?us-ascii?Q?xtBGZGcjF7jLkkrDUIk1kGHs55UcFpquQHF+HMFiv9Uiud5jMVrepVuOAd/O?=
 =?us-ascii?Q?SZt9v237bT5HUGIgUmA/OGW9xX085k59+Q6fAy0SBn/NiGH+fBo8lS/s2wGU?=
 =?us-ascii?Q?j5jEtgGBlW0Sq4Ci3vbpd5z78m+tHxoUvdS9TndF5ZgGnzQlqzG16lPfSA2o?=
 =?us-ascii?Q?yG1CI4/AchFXTFMbntj/u5v/THqnIjpSE2fdPMVPQ5LaHc9t3cEEvtRYdumW?=
 =?us-ascii?Q?m5aqnZRj012k5tSB2IS1D1gkeI10vUx+KQxBEHnKV8QcGGirXDtyfuTKx2mY?=
 =?us-ascii?Q?1k96PLuCQ/jsf1YYGAbIabXSEzmbBzKeoCJ4SOWA8hJ8lQ2sUU2cphKFehg1?=
 =?us-ascii?Q?tgMWWokdkVlfo6Rr6MeNwhOhyotsBbzihb3YLIcSMz+2nVvgaOltUEVZHbZ8?=
 =?us-ascii?Q?UYj75FMR2qvOmJYq6ad0fOWr6Hvd7TWRH1kOQT4N0BkHIzBTtUR3oTmqIST4?=
 =?us-ascii?Q?VgfLTUohGVKGzJQsQY+uTYfgNstsyxL3R7a9o/Rmyb3KG+HwBfQhuz80dKW0?=
 =?us-ascii?Q?GjRqNd1L6r5ZCVrHaMqABVBSk5BN45qfJXONQ2+dNP1vUjp8gMZYlHRJnq/t?=
 =?us-ascii?Q?3eAm5mdke4YLvcXvdewQF6uzoQWsXO7Np3dJRja4VUcCwNmaIMfsD3cLMIt7?=
 =?us-ascii?Q?+TSUtmkXstmizL8vQX3+EeBYOHNCONM57en0kq+G35TWo7bScmJG2BFCdasH?=
 =?us-ascii?Q?laGn36D7BS2OFVej/kydrW0tlPJVKpzjmYO6yRB6Mc8sNHz8xAwibiHBLrXh?=
 =?us-ascii?Q?zQHnQw5PdY0w6tUuHTGbL0Nid7PCGGBJyWj1C71LtMNaer9Rudg8qcY+4Bq1?=
 =?us-ascii?Q?ABzAk/TWYRP/HD5q2vUl2YjeGMFYEMbDRcRHwKbmsNSr3vAJkIOMpPZQg3hM?=
 =?us-ascii?Q?tGXYbwtsmFi8BGaaHruhzDMixfXcNdG338b1nvWsw6ME57cP60tRnkJz4YlO?=
 =?us-ascii?Q?eRt1Aq40z7IbaRfLnxegubaZNyXROJ/5QeoZKN959IPQMXOIWBiMAek6tgJZ?=
 =?us-ascii?Q?RdtwDPeFyaIdAIWJ7jWJIagrJ0XzrNu74Fzn5mE7C8zcHIOAaFZ7HXpDCV1E?=
 =?us-ascii?Q?vjx5EwVpfcw4UaUlbTzfxLndlCxD7Zk7ryKkhteAVCb/vWOy3ZjuGe1hyPsn?=
 =?us-ascii?Q?MpjJ5hqAn/UXURA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RCz2wMrF984FHjm9E8vgGfEhkjZzALhuoqqD8uI3M85LIAqYy505P9Wyk1k?=
 =?us-ascii?Q?rgxIuuWtKQykW0FyOnMFezQf/C4PJiVH6uo6zzVWQFtxJR7wMO8s8qNpE5OE?=
 =?us-ascii?Q?WdOlP/9EVJSaTif5fUH6DSNm74Xx0vAsjCQREQMGufUDAgbmoCTjMHs4xq7l?=
 =?us-ascii?Q?Zk/j1aCIB+bk6rK1JtY1O1v4E9U+h3FAO2CbnY15l//KFPC9e/x+RqduKYCz?=
 =?us-ascii?Q?hss0b8jSDMGjuETL592TN9gMH43ymiLgkQuBknsPlRAC+0cQTyqBZIxF8PlP?=
 =?us-ascii?Q?EeLUgJPgwkSWvoUQolWyrgoYbfdy8RYVP6zITNR/D9o1N33xXc6A31t9j+ht?=
 =?us-ascii?Q?IXazo2vzxAni8HDIaP+n2W//vTZ9nl0g9GyCrOfeHxB1un2t9qEvrGRVWXWU?=
 =?us-ascii?Q?hhzjEEkQBBehnrzkpfHquJdGuLRrFi0CtKfL/+WIWmQS4jCxXuxq+fGi991K?=
 =?us-ascii?Q?nCtOe9WRyHEFs300/JmYAoJdkyc0AqxzC9QMgfsoDr0rY3ctJvVWakZ0VeUU?=
 =?us-ascii?Q?IanYAnRykAq7xIDk9IDKc3M1uJoIL7cXIBVFZgAxmrdy+DLfhJBg1bHKBmE+?=
 =?us-ascii?Q?8qUue2uqRo61fNCTaZSNbU1v9M2F2UbC0gBUDSBH56/oA5eZY3T4DvF8avBI?=
 =?us-ascii?Q?gQr1M+pFiQYM4AoFMrDtu7vRZYZI25PK+pI5G86wZP86/m9gvSyvrW3y/hRC?=
 =?us-ascii?Q?V45S5dF7EDIMiZtgXW/7Bd2E/bDITTsw8xRF7+pE0V844BiTxbs4WIa+4YpK?=
 =?us-ascii?Q?Yyxs/Z2HKM+jikujSYeq4y6yzBvyPBaDEYLNcnq47/B1XzAcZ2w6ZKANHez6?=
 =?us-ascii?Q?I2PpsZsEtzgvDwChab2LbUL4XU7xTeZaOUyvnU0N+ADyEpHdfqIwymrPnWcr?=
 =?us-ascii?Q?eOa2zCQApSkSNbtsGa6ekrBfGVMbf3iKqy519KVsLwz4HUBElvBEg0odaBV7?=
 =?us-ascii?Q?M7kWIPu9AzIZkjM5Uai6uhXN4TUfai/fyBjgy5pVWLQ+9uavpKkASN8Zj0kw?=
 =?us-ascii?Q?NlNjM4SRv0CxZGASbA+ufhk8MY7AMu+2YTSzd6BdolAtcM/jRgDKAjtU9BtT?=
 =?us-ascii?Q?9pK9AJQIFYvW37K63kErKDKlwMaAAjhelabykH3J+OBgheZ8UNiMNo+2QdmX?=
 =?us-ascii?Q?y0dz8aH2PpOa9I0hLPccGrlYhb0MEzo8RpbWWvRPvprUVSwFxFbOh43Ko6am?=
 =?us-ascii?Q?hANxgWUq/UFE/EYPUNXxyjzENTtZkLy6VjlCJMQvM+ctOzFq/QsRXzg5DPtf?=
 =?us-ascii?Q?6N02AZwUXsKTqvi9tomlhiFEdv+w+U3EIHx2yiG3j+Q7JtDHOsuzZ1dPkvCg?=
 =?us-ascii?Q?o/gOF+CPNHVQlC21hzXIyIhXFQLue+0EKSztKAK58kmA6bih0SDfxPk2m1tQ?=
 =?us-ascii?Q?6h/frdbqQdzNJ3g9IjaqadvI4BWS6RPU1oddYotdY1qQaaiNzteHdGkexix1?=
 =?us-ascii?Q?zBQow1D1CP78GlzhQrZl1mw5XDix/v8Blx2+QYrgQqRqw5myAhPIQHaDehzM?=
 =?us-ascii?Q?KMWyOiPHL9oi7qtoB2x0BjFHSbnWQmbc8u5+fjeYK0AtXnZTUPVAx8BGsSkN?=
 =?us-ascii?Q?KT4N0qNBIUbo88IeETAYyaOqkEp7mrVTyUeHz2bEKsZFckiZgcXnzvurm3tM?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09094b3-8713-49f4-a125-08dd7d81d05e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:31:05.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMz4ViWN1B2Uk0ZEunn4YgaOJs+/pFRu9h3aZvl7Z2fgIvtVoQ9z0HcuEBibbVrgqgXNMBQEm26Xz/qWSNMGKS4s3rCcXanzCu9U5kfvZcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-Proofpoint-ORIG-GUID: gp3kt7rFxEPfMWmyc-z0Vz1vRgW4gvtb
X-Proofpoint-GUID: gp3kt7rFxEPfMWmyc-z0Vz1vRgW4gvtb
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6800ae3c cx=c_pps a=+kc2f53xTGsvuL7uaCOpcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=XQwRP9gPe-XL7FU9EZ0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170057

From: Li Nan <linan122@huawei.com>

[ Upstream commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6 ]

In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
is intended to confirm iocg is active when it has debt. However, warn
can be triggered during a blkcg or disk removal, if iocg_waitq_timer_fn()
is run at that time:

  WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
  Call trace:
  iocg_pay_debt+0x14c/0x190
  iocg_kick_waitq+0x438/0x4c0
  iocg_waitq_timer_fn+0xd8/0x130
  __run_hrtimer+0x144/0x45c
  __hrtimer_run_queues+0x16c/0x244
  hrtimer_interrupt+0x2cc/0x7b0

The warn in this situation is meaningless. Since this iocg is being
removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
is canceled after removing 'active_list' in ioc_pd_free(), which ensures
iocg is freed after iocg_waitq_timer_fn() returns.

Therefore, add the check if iocg was already offlined to avoid warn
when removing a blkcg or disk.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240419093257.3004211-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 block/blk-iocost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e270e64ba342..20993d79d5cc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1430,8 +1430,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->ioc->lock);
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	/*
+	 * make sure that nobody messed with @iocg. Check iocg->pd.online
+	 * to avoid warn when removing blkcg or disk.
+	 */
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
-- 
2.34.1


