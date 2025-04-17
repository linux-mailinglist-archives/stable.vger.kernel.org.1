Return-Path: <stable+bounces-132916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B885A9155B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA764189C225
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE31F55E0;
	Thu, 17 Apr 2025 07:34:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62B23AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875268; cv=fail; b=KoMfsNyLE6JtSsCEb4vIKd3GHgfM5NB7oxKtngxwh3O9CgSekL3lWYzvl+kuXv88fhtIudrM/B29EEML+lZqEwgKC1+ZzOUZjOLK2xm/TJh5PYvHRSgjaTcXYoensZai0BedinvpofCYtfinQUKhoYTMZf+wuTfzn1ZfChq9hDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875268; c=relaxed/simple;
	bh=iJhB/eDkPj0ZsQ0LLiQOKIgAOKREaagMczzwjdKzM/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzkfuVxTeAu+uVSbPflzr4zxAPh0F7Cz6jgUqCMp5jtC55m+zMO2XiBeYxuuwSD49gFlW6+RX46aUSbsaZA7uuxQWZNBNDLyWT5DUcl+4Pe+N7QfYKFTztGv/nKNdFgopaQNsmX3RpQUIYiXjhgwW/U2ckHrTphwdIOwn38Zx6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6oQmZ029260;
	Thu, 17 Apr 2025 00:34:17 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpknnm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 00:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF4+g7roBRDgpnWWdb27JvL0XDy81THO58Nm1G+fs/nP2qyxx+fmt1tnej5K7vwhyOj9lIdnwo1+g0DRXt5kDv38jqDG6jLpsOCt/h/MPGDSI/lc91+HM4Q4Vs57U0PYIWekcC6DHmG6xZf2iI6WnsYh2xqPpbSg1zD9wPtwG8Z2+I54Q9fL4k/RGnRyNQGOyiSudixoH/MDW5NYAnCyUH4yHeFAzqne+Apx8N9i60R7zyAAujedPkyongrtIb403Y0nRefKPrvkort582i9LrYxY7sEq517eY7DnxmOnKLtWz6UjX9ZGXwdlZdmGzlOr4S3j5NljGT80wqrG8SmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMuue4O9U8y9qXZKED5yJ0IBZzTx9ead8zCr98yLeZM=;
 b=Fa7N9N/cmExaRUuFhN7CrRHN5lW+kRX3Q8pncvAIdRKkvWjEyaHhhtdW7wML6AcaVQtQDz0sDxbuaVteHlG1DUzy/e/Nap476MdMYnKKuLUCIknITI5xKjTUA0rXjVeGNvl4QhW/l/j+1ndC4OkvLBVjinu6kWjCx4aE25RME1PNIxBABjvnmeCQ+TjZVM9HX+7ekMEhH/MNZRi6aV6WO48/8A4qXRdbFzvYMqpDHk5a+atp4W0jyIdo13gy4MPrcFeCsDrDEnxEs/v79NAXs3S3g9gqc/tUqndg9yfUaRiAS1U6+xF8u9/mm878KT3C8oMKOmNH4kJUKJzmrcjbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 07:34:14 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 07:34:14 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: hch@lst.de, yukuai3@huawei.com, tj@kernel.org, bin.lan.cn@windriver.com,
        axboe@kernel.dk
Subject: [PATCH 5.15/5.10 2/2] blk-iocost: do not WARN if iocg was already offlined
Date: Thu, 17 Apr 2025 15:33:52 +0800
Message-Id: <20250417073352.2675645-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417073352.2675645-1-bin.lan.cn@windriver.com>
References: <20250417073352.2675645-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 437b55f9-ac9d-49c7-6b55-08dd7d824092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5qpDL/lWMvUaT9rg1zrtfuxR2TxCe/pCoiHW8X//Sz38BzoJJ5d/NovCOYJ?=
 =?us-ascii?Q?48/cM8eU3QrbbavjUnZIxMI1ArR/a2wmYITCPSEw25CE1S3+wdRvlCh8GpE1?=
 =?us-ascii?Q?Jd9OQtULWMjnwZDZ7LKkHwMcbuBaTAPu44A0Ta1RZM+E0AZIXmuuSByX640V?=
 =?us-ascii?Q?5YduDZIKBArFCG1r77Ps7Bg7CscJ9QdoQ6VyqT3RhwJMmshqD/CP36vxnfOc?=
 =?us-ascii?Q?UXQG37BWuBW1Zc1r4BtjE/YA4Aap7s068P24891v/ZJrfoKHtAfrvOj3M++1?=
 =?us-ascii?Q?ooMV4bXvzcZRrv5jiSeV9QCMnoNXrlhnoTVyCiQ/OND3v0PcMJiHzkSAQra0?=
 =?us-ascii?Q?5GKWMIeDxCPerADvN5BN+iT6yu9CVFBKeauJEzUp4cgLsEIj+ELwkEf/WtWm?=
 =?us-ascii?Q?GILlpvzv3mCsQxIOwX2o5xPBi115GlyEa2y8xLMRtzXBq57oYqqA16Sh55bw?=
 =?us-ascii?Q?RF19ZglTdrVpftr9SyjwPE6+37ACSIcpEjpXTam+357vIMLZy8cvJ7aBp6mM?=
 =?us-ascii?Q?tuJs0kECsy7F4MqcwQrdasYw2lUKvr+Gwl0cnGP14lLn7v8XEeaXHrLLpto2?=
 =?us-ascii?Q?YDCPFBfFh6r/tAP7Smnn7M6QKdWfifE9zm1pHsuTfvLuB8uurwJpDuRYRe59?=
 =?us-ascii?Q?ZcDpVD62SkmC4XTsD1K0Pn49MRS5qkEueYZwp16o+2GGqGx+oLChVkTpdAD5?=
 =?us-ascii?Q?+FEl08ii3HZll8aOFvkC9FIxNGlSGpRNApu20TthqgR2kTIQUpeVTUiAzMt5?=
 =?us-ascii?Q?GtMJL2gLyamBKRnSCXKw+CFeY5TIw3Eza8e8k62Thja2qPtwGnPE264xqxDE?=
 =?us-ascii?Q?zZQJGEx18USooikZ8NK7HKWYbX0xbIliPMsvA424q3Z92M4+Wuh6W8u+9TN/?=
 =?us-ascii?Q?Z1j1QSxhSBen1rUfd+KkDJKyHGgXvljp5Lz/mWqs/mB3zkTuZkdHu30nHjEP?=
 =?us-ascii?Q?yB9rCMXovie4Cm1XWyTI+m5lvTooAvEL5EJxn7bbh5m4vU3GNb7HjOclzwMl?=
 =?us-ascii?Q?NIZ1usAs3GI2byMO/3B1fD5PJ88Y7OcGudBFZby9VYDIDNbJvkcUkZyved+7?=
 =?us-ascii?Q?Noqeys8BNXW++xpLbZatCQxahVcSv1SFV9VfRVnf7YxG3H6Ii9ny+W0oAY/s?=
 =?us-ascii?Q?B7S0M4zAVk8GxE77WaLtoJFO1B3EJzpG1RkqBt/TX2W1Ih6z2QtQUtm4AOLw?=
 =?us-ascii?Q?qo6FVkkJZDc5j+DYSX6ycnHifXupBk3QMxn48vUd+3fCe1k+MKV/A2Q++TQR?=
 =?us-ascii?Q?6IROZLyXl9w6tBVwmKMQ4qeRT+U3yMiRsEx0EfxYN5c8qFdacO7A9kdO0IP4?=
 =?us-ascii?Q?U5Gq/no73WUd/dP+ppObUeGhWvU6rIOEpVqTmuqPN8qw/KVN+V3k4o2nA8hd?=
 =?us-ascii?Q?dVtAZ92dhA7fMDOY8/9EcENEBAhCi1yJ7cPTBTe2Xec9LpWhMdbpuz9t1JTx?=
 =?us-ascii?Q?fWaAs+uK+MRGtSHqifRKrvI1LzjsUZw1WqUyQ20EJpslMD98m57yfwyReA4a?=
 =?us-ascii?Q?biH6DITX5qnXKL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2fyZDXddDxYnB70vl4CRa23IiCbZPkJaXqOz2xhbV4FLYlMei7rH5PBKJnk?=
 =?us-ascii?Q?BWq0hHu6xFsLE4tvDUtC0vvPt0v2nypPPl/BUkuT3gjEFhbOQtrweikoUKLA?=
 =?us-ascii?Q?n3UcimhB7rD57L79ny8jVC54t0KG0V6ihM8aXO6+hiaXhiMbKVBQZLGQ2bHQ?=
 =?us-ascii?Q?SIVoZuTpS817uaV3XAYlDzsZ6UNqaugQeE+zJdJsPrR3WmKXjZQ5M5H5zdMw?=
 =?us-ascii?Q?5p7mFxTFiCQD+EmmHP9zAexq6HnXs5Nkn2m5zIVwiT6VOKJBRc8Rgd8d/I6D?=
 =?us-ascii?Q?iF4aDqkA5O4ne0WQPXseKenvtbJjpCMYqMvs4WcUdAtBOjfuX+iX6Kc1EEbX?=
 =?us-ascii?Q?B6WGv2TW7xixw3MtH8s4Ahj5c1oV4sgdEiVeJ5X2U/cWqEUKKcVwiTW/xJ9+?=
 =?us-ascii?Q?qXKzmm8noTmxuWxXSvKrs/6DxIm8rEG7VklYRkSuWt9cx+vs/k8R17+7pYxT?=
 =?us-ascii?Q?J6rr5bdLGLKBCvCY6z6n24KOpzKZ/OqMBYAl75q1WLY3T6WTBUBT7D82qRT6?=
 =?us-ascii?Q?ov/0xdanIZ8pVICPyqAlkil60o5O5zIJ5W4bhdH4PjwyOx4qtbvr1llvk9n/?=
 =?us-ascii?Q?wiwvC1A3UPa2lj+oT0Urc5tNYwcAtDv3baWr1gPClL5yp2vMKun2IrE0muYf?=
 =?us-ascii?Q?37SkVGl4yRYBSFI5m5Z/4+0x4w7QAwPcBoBITTJaMinZrwRhGKatsIaVZEOn?=
 =?us-ascii?Q?UymqmPXJBqqxgRfcuLRB3YEfh4QYONmunLRO1jwopI0gHoPdEuQReliOfaUu?=
 =?us-ascii?Q?8YIbA7VwYi7+XDaEWlTOJzKdkDDh5A+1nBa4l+F2GLpaAjsSaD0b/1BhmZ03?=
 =?us-ascii?Q?q6Rxqbbnj6zzjxasXem3NQxO1lE/bNIbdZuyXLnGBkc2l1uIxT2jqLILXe36?=
 =?us-ascii?Q?gkohE7/PQ097r6teSWEic9Lz7kYR89aPjqdseFG5jqWtJZ0nQ02csqOuWQWH?=
 =?us-ascii?Q?C+Qcil0Xcy5edQxOwjn6eDaMFjhza6KsUM0Os+bJuYQUQPl++6WkFUsjUMEa?=
 =?us-ascii?Q?YjdEodwvWgitNYU2eZ74RdYSkVFyQlmmTUU/Hh7kdYldbDB3P82KJhOV8ogn?=
 =?us-ascii?Q?cHJemFWUi7DSxtlLSnQFGLcRoSK5rIZ7+b9sHHyz2MUGJgo56MJZ2e3OC6TE?=
 =?us-ascii?Q?z+T5ffgHAo1WaMImfVgbNKkvVnGHPNzLq5uwUBlEn/kvDOTn5TZ7+7LjWgs4?=
 =?us-ascii?Q?nxaXtY/9WYfjYXxMUBvG1V3UePSbxsDzOZKbojwrXGIzqDFm2bci+b7/8Tj5?=
 =?us-ascii?Q?5Nh1wPV9uT+NB9M0YSsGrsKGVxRnVBQLt+LhwkMgFX1fP20h5j6oCZ3RVCpq?=
 =?us-ascii?Q?Vkw46dPVPurqKCc48W2roGjThaGD5MReE5S9vPH77TcBlCTfHVa6uKNObDrJ?=
 =?us-ascii?Q?BsEdeHSGlzavEBUNBMV93zYCyP9xO/6P2i6L/DI8SLud65nIwZifLFqjDINV?=
 =?us-ascii?Q?cW8IY2z2fOGnFRvqhqfEq7fQYy5h4AXeqfDyCEFMI5puwvOZFwk31C+z4GWB?=
 =?us-ascii?Q?hd49Jro3VdDp/Du86ACvgNmgvnqG+XpMY7tp71OC74LooWFZDIL3eDchacAk?=
 =?us-ascii?Q?CbE/jTYbsyMg+TeF0hZCKT6nLn8HsMZuE82nx9hX2da4Y22HS3e4fI1tLBrD?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437b55f9-ac9d-49c7-6b55-08dd7d824092
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:34:14.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvNITU5pi5ytL26Z3jrbfxgNNpmigkGvLrGg2FnD4MEllAnQZipta7xT8lo17kggQey41V36SohPDGUoh9bIbt79f3nuv49su3HLfKDoRM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-Proofpoint-ORIG-GUID: Gqd1dWjqlkTYHQbP4N9ncPxBPW-B8JNu
X-Proofpoint-GUID: Gqd1dWjqlkTYHQbP4N9ncPxBPW-B8JNu
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6800aef8 cx=c_pps a=Syk5hotmcjzKYaivvMT4gg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
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
index ba23562abc80..08d397f063f3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1435,8 +1435,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
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


