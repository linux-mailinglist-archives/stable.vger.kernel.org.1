Return-Path: <stable+bounces-132913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE734A9153F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33061887603
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F121ABB3;
	Thu, 17 Apr 2025 07:31:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16019F133
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875089; cv=fail; b=AfsopNsJxRj6/OypfESiEJopDUqRgCHB0QDGhiBJJACfhOC1QUxSsUmSanaSbGQIJlXZiH4omIfg34wTA8dFS0bN7Y1KuDdF6PsjwyY0Sc4vYh6XjxpG3YTXEQsgfBiebSak/aTAOCZPfHUQBfqmjW4eOgaWLwQJtZAlflrza1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875089; c=relaxed/simple;
	bh=wHWZVvUOM+Ry0GgigpOJnZY3LQ9KOBpP1VT3erjhhz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XNSKLrCsWpAF6vtsnN+DTCgbaJjwfKnz8FiIFSbfkM6LMvn9jLEitxHZMi8ENmjy3Jq8fQNBBSU4kUoubTjZ1dkvsuXEIycacW5a2PcQqIRfc7l0iYbjJIComYhhTAC4LP+RWZpjCLuXmwOJcp1PcVs5IgRQMhk8xEHR5axUrYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H602pR019651;
	Thu, 17 Apr 2025 00:31:08 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpknngt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 00:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHiaFviQuh9n9cXY+jD1M0g2pWbgn6Mq1WjwBjmDEH50E441/RzfAmG8dTJuT88iCK7wmEou34JdQ3XnjjmLD8nBzCCx+hMrnzIgeH7WKoxmlwzJJcU5YqM1ZORcILSqlwVzz9EMDdmavfjBYV7PeFB838AWkE1Hbs9fNog8eY+yZt3yMWrPaNrnTMP7JmZUtDpilBAf8ito2OuC9yfra+CVs50Tyjs1KihvJmcNGUEW3KQm9jeVkLLMboLaBSQSea/W+6HRn3h6pI+lWdtJNCn1ZNdSz0JYzavt7GHl+DNi5EHIhetOKaq18bZm1Whn/Z35z5TBApgaLHyqZG73zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MimKOVChc3fkGUsOu3d7LUDaMsepXda6R0nX375SXYo=;
 b=wsQtjuEdZY3ql3dZUNtin+jCM0HI+JCkzi/0LkR8hEbEcf+KcNlKtR1Cq4KgUSG0gO/mWJYzZT9FGpDf4jIOHr2/FuxuM8Ds/6wy/GKBJgJtgh5SQBL5cVTKZ4o+n4RjuBiH0jm0tkX1qHoKxVUDccXhNvpTObeb/EgI1CgReivTZDI5Cj0B51atOZu0HVjHcxp9ctHVNWJ/hLjYXqjDgHYE+Nc40n4sNLC4CSFhuRan/E02kTTH/IeP3WIW1VxihuSmm2KFz7MlX8V/kbDB+fqv9u3kBEixtHK+pByeOTbMUA+Pm5GiRjDT5Ej49ybPyj/Cy7GJmBjxEI+K3Xzb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 07:31:03 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 07:31:02 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: hch@lst.de, tj@kernel.org, axboe@kernel.dk, bin.lan.cn@windriver.com,
        yukuai3@huawei.com
Subject: [PATCH 6.1.y 1/2] blk-cgroup: support to track if policy is online
Date: Thu, 17 Apr 2025 15:30:40 +0800
Message-Id: <20250417073041.2670459-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 2bf4beb8-e82e-470a-89ec-08dd7d81ce63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/gKD1oEn42inIfFMFJWCncfmdd/PGA2nIYq5e1kAmTPuyIn5Phn8C521cXc?=
 =?us-ascii?Q?x8YI7aAhEClwAvTD6Z6fTzltqUTAZUo3smQ93tTyYTDE/uSUzZs6AyLFHY+t?=
 =?us-ascii?Q?zjRrUbpCrDw4XqdWeSmQ1EtELWlqDlxfvRHsBB9eE3argAfwoEuDrUwVDcGM?=
 =?us-ascii?Q?pvxmbkMRoR92PIl8RTGdVp5nxHOw+KQJTyvL38naBCU0xZOP+CDcWI75CILl?=
 =?us-ascii?Q?FrJr+0AQm+AljA7u87cm54L6EUOtAMQPr6Wz4wPFZK7VnHqFkttAsNCSA+Nk?=
 =?us-ascii?Q?XDiuA/vlKheO7y8SaMEMhXOsy8hlRIvFctkNKer1SMlrGnN2JpJ6LE+PPT9+?=
 =?us-ascii?Q?hpqryEjPrpbP+/vuHF9bekwYq9xwQv6DGYQU1/4Uzbguq1YQtsll6VHmkagT?=
 =?us-ascii?Q?gKJvVL327lqQp2VzVAYqkH3VQE7q6EvBz6FJjKSqmA+HhFGhGcQSDIB4lio2?=
 =?us-ascii?Q?UJQamp/BdEqswj9VOiYLzu/dgByO08QGYtQbJrHLbiz3M1/0tbLPoWnhK+ZM?=
 =?us-ascii?Q?vLCDb83uF5iHwg2M1Ipjnsyi3BZAok+3uaHukXHDPqDi5Ez9fa/c8Q3JdFwy?=
 =?us-ascii?Q?+pBHwTDVwRHyBjNUhU++TWwPBqQN4r1Ai+yDi2OWd30xSXt+JQgz5NaBoNfN?=
 =?us-ascii?Q?y7X07QpbnJ29kytIIKtBIf0ZmBd6kb2xBZ5lupZDayDMvjT9E3iAjYvURIev?=
 =?us-ascii?Q?92i/Qd1PLWhKkLXiolMztl3xaSZDXOHOth+seCXIMiapinouLPVpPwffBO3Q?=
 =?us-ascii?Q?9eE6BYuT30jKtr8QgmFNSa5JRUdoQEZCGEZ9QKWCepglG0kLB6JCwcA73eLO?=
 =?us-ascii?Q?UPWN2MoMEl3DXsYuVqVeqJKWd73ldBtZxa7rJCCAEMrO2SxjEyDQF0LW5XgI?=
 =?us-ascii?Q?6qaz5vT5vLtkmZw+W/nc2YRkv5cZt6Cq3yCWSE7F6+w1yfFVXTsHNnYxrMf/?=
 =?us-ascii?Q?Mi4th+pKy5plAX2WRbG+spivCwrvEn9z5BmMZgmZjx9ys4G8+hWNu0tWDj9Q?=
 =?us-ascii?Q?DEDMbqm9l7POgOEorSci7byTGFy3+laObs/Y2Dl2q/psTZF1MqdmGCSqFrzs?=
 =?us-ascii?Q?DRMwqraxe/ygeSemgownGM5KbvqyybVk3ZxiS9wsAG6DEOovgrIyk23hgjIm?=
 =?us-ascii?Q?UpMr6MSIgC/tjh4aBTvU+IPQByq2YOesen0Bjfg7wXM6pLim7UnbS9Pw1JwM?=
 =?us-ascii?Q?XwvoVrR6ckgwD8rQzSNSdGFxA72T0vnkeDWtyTX6zjnP3xLZWXw/LSaW93NE?=
 =?us-ascii?Q?gOTj/ZaZmMr4ZhLliSLuP72Kfhs1YTN751sNOiyqlXXZRYjohGV8t1LgJ31A?=
 =?us-ascii?Q?bMW54FtEaE+qQ7SLA6DSmHrb//3fnBpw7JeW5D5/BB0dCYO71wzL4x3x0xcG?=
 =?us-ascii?Q?BM1Vry5xybEk7hz/lZS0XXcXd3uHXKtSWiQV1wWQXWHRU42lMXlI4iljnZsc?=
 =?us-ascii?Q?ME+k/XqqtxbsDSBtDtgXV+GuHkOHPT6QnyqeQgHiI6lx0mLJF7RmkoykLkAm?=
 =?us-ascii?Q?LNzY+WvOj4+6Pbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qeg0qTdmpEyur+uAg+rJGEr3KRafG3P/rtIWSrtfBsBNlb1nEtd7YS8NsMwu?=
 =?us-ascii?Q?i+oKJNj9Pl4/IplVCjG1h1aB1Q6eKHI2Hk4eZ4PuRucnlzYvVN5WjCWE+zgz?=
 =?us-ascii?Q?zBayxZttwdYdH6U40E6LwtUQTm4dAZ4WFKO9MhzEPHRA1+qynVQQpb27M4sI?=
 =?us-ascii?Q?djbNbV8tf04HN2lGcAHOs2qepPVXUmBgcVtaxmQgswnl3S9Lw99rgCTm9YqJ?=
 =?us-ascii?Q?fJorjyRX/fhBWOWvDa4Ba3uDB/Xlt78CKP7S1TIKcch/Rto41u5SrUhwedvN?=
 =?us-ascii?Q?TZh8qY6ut9BcEjJ1/kZaGcnHf5Wy93GHBn1Byv/mqqA5i9lEGsKrY4Utrq+9?=
 =?us-ascii?Q?6NKB2WRwX60fxJzvSB9fwMp3j8S1Noni7ThmZP7s3oTebBzDMloLjZX6Gu4r?=
 =?us-ascii?Q?hDX3ZLNJcPr7rHxrk0pAJvO92eY1xC6HFc1AEele/cXydqjNmpOyCP6q6dN/?=
 =?us-ascii?Q?Uavtv4Gp/VBX/hfY4xJc+FioWcr8DrNdsnuC302oAtSaBIATN1yqF8hL5IXM?=
 =?us-ascii?Q?DtjNNISVtSZMAEf5zpIwGSwwih/X8o85eiCqFkscdpCc+HDxEJsbG9ayJS2F?=
 =?us-ascii?Q?Qw9BlDtbIhaKswJ7JUm6yONVAekE6Z02oHsS3FLrUM1rEixwtzh2U/Rt6LMc?=
 =?us-ascii?Q?oqPcc882Rryt2MjPdKRx6xfrZjzVOqdzs0Lq1gFkGvdduGefg89+X/5wEklM?=
 =?us-ascii?Q?XolvBG4hTBwzjgmSAHjaiFn96KzUZGRPN8HTZ2mNrAyuWB1yjZwT7kVdayfB?=
 =?us-ascii?Q?Z1cxEug/p91z7mPXgOv1p7R5upXGFGEGAkqAq7EYdc7osnFn+K27NN9GlLho?=
 =?us-ascii?Q?T4p3jyYHHh8xEWK8kbMqMHd02sjuiU77UnHHhSbpjJ2PorrKyebwpiMW+mr1?=
 =?us-ascii?Q?t10oEI1Mo4QFzCq8DZPiRR2AoCOSGn7iVrDZbbWT2MfOMJVwPtlxbYLWhiFK?=
 =?us-ascii?Q?GzeNj/9zCBvk9MvE292ginr61z+yxzt8XGK4u+MHoX3s5PmJCHLg2DRltAy6?=
 =?us-ascii?Q?7CronnbYHOGdmuSS9LsNh6HvocISwOHj1ZGiASAvf9GI9ubjuigf0OtR+Qra?=
 =?us-ascii?Q?1cvQhnan8MByi+1p2x+jpJa9k58h6iIx97+uC6BOmfmAipwVb4xFLApZfBlb?=
 =?us-ascii?Q?xW+c6hucKBHnZX5Ngkwx9X2Vw1/jsVMnv6lIXne0xmfF9lvqVFN+lHrurPJt?=
 =?us-ascii?Q?zX6iLpLAqShP6PxZdaEtJSYCjjjjeGiE+eMdNW8Sgmtw0I792mKsQEeeFenE?=
 =?us-ascii?Q?Z6Zw0U7TKAWq7yadwjSOW4CisVhvo/nAUJU+XV6i+CkvYLOootZ/UmGXaEvn?=
 =?us-ascii?Q?k9+V+2IFxCxdPMJzQ+mAhlWyghju5D8HFfJecZGmgjNfm3184Oxfd02lYX4o?=
 =?us-ascii?Q?2aYJUtc1UC2kqD9Y6PQdCFpBdBPhtypfVs2uThZz8l3kJy9y5A8p/zW4OvcC?=
 =?us-ascii?Q?mgRdqDI9uaNCos31H27mMu4MwlycC52BrLolmnf1xUL2H3VLe9tcTWA5uEuX?=
 =?us-ascii?Q?XfW48HKUyDYlt3SEKfnzH3AXr8Y7cPGfEMOQTnkeZVf579Wny6gCT0SGjECT?=
 =?us-ascii?Q?3vXSV0sV8cVBr6pNxX7sxLuLgZ1ZGp8vh/UJzH1GjgS/6akhIvAv6NQle7IU?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4beb8-e82e-470a-89ec-08dd7d81ce63
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:31:02.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+7TrKNHUChhBPgeFf7DFbPHXnNyHegGafnp5k4wbjq494fbNQFNHlNmP54kvGlVwD6zxYWC2FecYzZ2twlYoztyAPmTpVmjH+iSCuRvF88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-Proofpoint-ORIG-GUID: S4j7dNUGvnXUNd9_G0oDDmnwxCkUBP2W
X-Proofpoint-GUID: S4j7dNUGvnXUNd9_G0oDDmnwxCkUBP2W
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6800ae3b cx=c_pps a=+kc2f53xTGsvuL7uaCOpcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=Y5FjT8Dtfh1lRl98P_QA:9 a=FdTzh2GWekK77mhwV6Dw:22
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit dfd6200a095440b663099d8d42f1efb0175a1ce3 ]

A new field 'online' is added to blkg_policy_data to fix following
2 problem:

1) In blkcg_activate_policy(), if pd_alloc_fn() with 'GFP_NOWAIT'
   failed, 'queue_lock' will be dropped and pd_alloc_fn() will try again
   without 'GFP_NOWAIT'. In the meantime, remove cgroup can race with
   it, and pd_offline_fn() will be called without pd_init_fn() and
   pd_online_fn(). This way null-ptr-deference can be triggered.

2) In order to synchronize pd_free_fn() from blkg_free_workfn() and
   blkcg_deactivate_policy(), 'list_del_init(&blkg->q_node)' will be
   delayed to blkg_free_workfn(), hence pd_offline_fn() can be called
   first in blkg_destroy(), and then blkcg_deactivate_policy() will
   call it again, we must prevent it.

The new field 'online' will be set after pd_online_fn() and will be
cleared after pd_offline_fn(), in the meantime pd_offline_fn() will only
be called if 'online' is set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230119110350.2287325-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 block/blk-cgroup.c | 24 +++++++++++++++++-------
 block/blk-cgroup.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cced5a2d5fb6..ef596fc10465 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -255,6 +255,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -326,8 +327,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i]) {
+				if (pol->pd_online_fn)
+					pol->pd_online_fn(blkg->pd[i]);
+				blkg->pd[i]->online = true;
+			}
 		}
 	}
 	blkg->online = true;
@@ -432,8 +436,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i] && blkg->pd[i]->online) {
+			if (pol->pd_offline_fn)
+				pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd[i]->online = false;
+		}
 	}
 
 	blkg->online = false;
@@ -1422,6 +1429,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1429,9 +1437,11 @@ int blkcg_activate_policy(struct request_queue *q,
 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	if (pol->pd_online_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid]->online = true;
+	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
@@ -1493,7 +1503,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index aa2b286bc825..59815b269a20 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -125,6 +125,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
-- 
2.34.1


