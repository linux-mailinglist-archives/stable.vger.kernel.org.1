Return-Path: <stable+bounces-127398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63478A789D2
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556D1894156
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D523535F;
	Wed,  2 Apr 2025 08:28:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D7234977
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582521; cv=fail; b=nc5UDdWyP4Ft49I10FGIjbIJ33jD5JOFl9y0apzRWXmC4KHpsQrWc1udtY8hOZIDu//paztAwBOm84ptIRpbKZioSLpo5ZS2FK2pvrzhmqmfa9Wb6p3p5mV0/GK8D/wsHBNB0UQ30E7fJqIwAcmVYS2fqi9H86owm0PaAK3jrUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582521; c=relaxed/simple;
	bh=ZuJGnTWWpG09pu/yK6a1Cdb9wqoqDC3QqrCgEZ0tzVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+jsUouSaHdbH38g9s1tK7N59L18EqqFqA+rwhMqCiB2rn7vn6j29VFEUsCayF0g3JsKF4IN/Wmesis/omW82jS3fpG4EnpgYj65YWqJUpp/rA6I3wI3rYLOHZWiN2q6xTT5vTmGucaamlt0tbAm9cSRea2zDqp14dMHiy9wujU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53246w6N028242;
	Wed, 2 Apr 2025 01:28:35 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9rh88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlPFZMmyBSs7MI9mr8ZQ/oWTkuhuRYi94gum1bWtEaTnZdulsBsFHAGmT/0bjnV71m78MddWiLG7t/3H1IFpwThnmzPqEevo6nIP5FPOefo5juUmJCTmVSI8pCHaWIJxHCYatGVZPdOC1asV7Fn2Z3IP/Pyd7FCgoevZHwYwcaPghyBZpA8yzz/mpf9JM1uT19MLtSfEjYWnllNadCuEuIBQ4krcmmGxjJ8RwszDTAnDkFcAuY1xO0eL6h30UFiBxNgEarZTDwc40vqwwEEtXNeIXigpzzDLTGg3YGau8PiqcktJJwmcOnqojiDRVKBVJAd8R9pMEQ0oovG9NHkp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63zoD9iSTWHxTU5xeL3o27hv4BhfkrOsKDhPUqheTjU=;
 b=K3gguG5cOPlCJ7oTL7eXrgYEBj3+wgoOwvyoQFnV2TOtu27NV10oqablSKAQGESaWFaGDTjzmsHdLYJls2/kMumVEidOXtp9Dlb4CLnowbgo8meSt9V8t0zxbp11ft5Tkr4mx8GuHqYbRZCY5N7C2HkPGu6ZJXawCNlgV+lNi2Gx3h6zglw1nd4b3EEH5XjqHl6eb72G0H06y7erE6hEUjJp5LIabs51bKobTHmCr0j9+5Di6lW1thhSh9jK5fGHX/M13+v+Lgpzt73k4+WgTf6VDUXliuhd4FF5f9VZfSW6dU1hWE7P2JIZtE1iFfsTW7rcn9s+MLXxRoRmV7C6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:33 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:33 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 5/6] binfmt_elf: Only report padzero() errors when PROT_WRITE
Date: Wed,  2 Apr 2025 16:26:55 +0800
Message-Id: <20250402082656.4177277-6-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5deb52-c6d1-4abb-86bd-08dd71c05b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SB6rOl6issXWK/9Ha58KxLtV7zMTVawNTcFgj+8p/JN/z4uQyOe4Kpk4kwXP?=
 =?us-ascii?Q?PQoS42uyT/l4Jq1VRcrSTVpGQ19uDUKRwweUMZSE7+XM1F5fq1h1sevD98F1?=
 =?us-ascii?Q?w9yQhhQqY15yEi1rZJsD6hfDK7q/mw+h0Csfb9J0qaOn8/J9rlmfNXPAgQPo?=
 =?us-ascii?Q?NTYuc+PCgpo9r9avtSg8NrLa1T40AVMtD1rdtJfJ97xlw0ccFgdl3hlRblWz?=
 =?us-ascii?Q?oOFLYhjVI+slknjrScCW6neSUVTWUk7ONlavHtaT2ShA5tSXdtCIH8vrDY+p?=
 =?us-ascii?Q?iqoz+G+h2Eut0UnmIm8ApVYAnUXm7dsSv93U0PPuOvDLQu2znJNx7cQvd85M?=
 =?us-ascii?Q?qZ72+dPzvevVg1yjJQfg7amTMvteBspyFavgie8q84UpO8wdZ/c5rwbaZ7mL?=
 =?us-ascii?Q?X/YBv+NrFze4ANqRgbkn5y85pUyKH6HyYl3LjEYK2KIHe3m4lZcr2J5xBLkp?=
 =?us-ascii?Q?Qme5Ybw2W3DuNyzpm09Oy+dNl0sDrgpMy8MloEWumRyb2pn+R0mzGJ9r0sk5?=
 =?us-ascii?Q?hq1Cvu2UkBgoZ00wjSQFvqRWT31MwrcwqP+kJolG0pw5juE9aEaAdXh1VyDi?=
 =?us-ascii?Q?HUwFZ4wyBYDj0nsbF4ahqEFn2LSp3I8gTFpnYZvdOQtdQ70I438vgOl4gG1p?=
 =?us-ascii?Q?muJn6lZ1PG5Ku6VSARPxk9HaPwXLJ1xSCvVPVsw1XVCdHs7KRCt6VY9dTlDA?=
 =?us-ascii?Q?elTqhh/X1p4YkLK9MwSkWZQ/DW1Br3msWDU9Bf6QN5Jg92qsLW6gL2YZ5aEa?=
 =?us-ascii?Q?qvyuMtcesIjuOO4JIYaaDE06R5XT3yiwlkfhO1hP+9zA5IM7mUpO0okWe4x7?=
 =?us-ascii?Q?Nim77fTIfrcgRU0Sv/3VYiB9E4bHuQ2ntDRS2BED6XjWjncKJd/rxFU0LK2z?=
 =?us-ascii?Q?tvATZ8NbTaqkvgr7/UmDYgHieEvJhTIDWh4X+bGHrq80MpBrGVmoLuMxGWQi?=
 =?us-ascii?Q?x+Q2ipcWXOGa2h9+95juCVFr/krzP9QEugCkpb155YUviARwq23uyql/7cfY?=
 =?us-ascii?Q?Ch3yOyBhnqYI9aRRyLQAWplkwt/5xpcHMW3dD0343sYNxSVFuXXEmyRJOlE3?=
 =?us-ascii?Q?EFw6NHtAgrrS3Yt7LGeoy/hrSkAHbD4hIAKVQVzhxbe1ZKjs+LijGYNxkb1O?=
 =?us-ascii?Q?7jXsC8AhCOiV8Pm6gTafdDY1QcxnYHGp3IHiSEDu3qtA6WaD+s7P+Fu5X3y2?=
 =?us-ascii?Q?refUYumIWGSQkVXmBIREGyQuKjp4QYLsZ8eAoUnHIQS1kR2oZrqBQFE8rOJq?=
 =?us-ascii?Q?PgGe6UfOxSghCJUF3KyTfr4gUAeHnoSlY/rAqKxD65BYrtKTAKG7ZDOMhkNk?=
 =?us-ascii?Q?IL4g0YEr6NxrezDguBs1e7o+JoGCaF7681ORBs6N3GL8LnbybnSDBqbw9xlT?=
 =?us-ascii?Q?KBvuFzp18wFbWUv4C/HKo5VKIjeXQJ4PKmLFJw1NeytGmpkTY5qbmRi/Zgu1?=
 =?us-ascii?Q?wJ1zOViQImNmTFZ9QY8R5sQWF2tzYDlGGQVJ2bF4APyUBzCjdbEPSIaqbl9z?=
 =?us-ascii?Q?s5uTwsSfRTYsw14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h71fEbotlbDMUEM/Z4rvEcXtKPtlumJfECBCmEU7zd814zSlBl7ZL/C7dCZw?=
 =?us-ascii?Q?0oby2t1R28Qw6nDzFvWVwu2RilIfxZDcSEs39yTyIdg2PgpswZjgsicpGSTM?=
 =?us-ascii?Q?ce+v5c6/RijMQUlJS+lky1+Lk4ij/NzphjLyVJCeKcR6URo8/aRNP1LMKXPE?=
 =?us-ascii?Q?eX/0xVia0X3SoHnc5lFwN2KwQgLpPEKc84q8Slhkl1EjX4q2LKqNlQsBA5LY?=
 =?us-ascii?Q?yp/S8mFaPQGFYKn8NSzdYk/h0gU0hsqyhOQUbZwspUlp8qFJQq3T8LxZweYE?=
 =?us-ascii?Q?Ya9gspTSDMYYfPEJr9T2CWGh3UbU1lC/4i9bazmVZ+MkFYbRd+TMKkBDsIpE?=
 =?us-ascii?Q?UHHqOTqQQxLJ+G5X4HCMnhkqpDddAsk2Xvx8kvcbu8Nvy0hMpw+OqdI4H/JF?=
 =?us-ascii?Q?AqSnBemGGREsgTs1VVGnn9jMgG+jgU4goB4oEBoomDu7hD/CvH7KXlt1qWOm?=
 =?us-ascii?Q?xoyIKtZoQuivdLFcOewPe+MUmEkLJpQX8BdhaNSpVJZ2FqN/jlGBelkxkmAw?=
 =?us-ascii?Q?LO2gjnMAT+DFcSV46zujDSKLch2cJ/zbQLbm2efbgYGNYRrmMN4ye7og0MZi?=
 =?us-ascii?Q?d+JzB5YcUiY7pTc1gbwNeAleomdf/RcyplhWci50cQvC7YxUAahCaioGPaCB?=
 =?us-ascii?Q?5tl3dQCdvjWGM4K80pi2e2lVyivtEsizkUYPO6+/jdEmcYZ34+NJ+VLyV3n/?=
 =?us-ascii?Q?BG5M2XivzfJ09YKLeTCElsszixTpTx5GyWnDiUA7J9zqO9SnG15FhFYGQaeD?=
 =?us-ascii?Q?BoKNuIVxb5R+KijFdOCYhDZz2gytUDiYxe3Uranm6Q6B3TcBrmXmUuBjo5YK?=
 =?us-ascii?Q?HAuLcySQuI7EKrPXQtrtOG5bTH6QKTAmK4tXcf3XXcuG2g2wFRwKz8yFvojh?=
 =?us-ascii?Q?C8p6p29Keoxql08ledVYHZsh/eNyg2dBlL9m/Xvg2WCceKeB6wNpCNhcmQXC?=
 =?us-ascii?Q?FxOkyw8P6nIEvsRgePq3n480iffjORjMH4D0dBlY9lum4zG23paS8CdvBSRy?=
 =?us-ascii?Q?nGVuAqO630y/nNYvm1gOFc5vdQymVfZbwE77ajw6G/R7G8usHHQWQWYxF39e?=
 =?us-ascii?Q?NbbYNW03KqprRrdlHuE7k/vINXdymTyXReNdjiXIGlrgnCbHOtjDW6VTlV1J?=
 =?us-ascii?Q?IGTojFyaed4IguWuKVEeNVDgy0K79tBD92zrmGiB0Xmvv+9pLjDdAC6nJhHe?=
 =?us-ascii?Q?1ejJdLdOFVe4bmgY2GJvmx3LC5GIb+iowHyAqZqMOqGjtTe5zZ7EYs4hdiQs?=
 =?us-ascii?Q?ik4OQChd1Oo0phPeT+sk4lcdso/hZpIKT7iTvCc7SWe9U06+CXjHaApKrIAO?=
 =?us-ascii?Q?w297BMfRmr2ud2Q4J+7O+aKvVe4ZEIQXkjhnv8VyJCN0psIhMqHxDPgSnTPT?=
 =?us-ascii?Q?VKKUPnDMr8JTHbFErzhwWYPviydL3tNdklORZQnMiy/y65aaEGxejLzsqGKX?=
 =?us-ascii?Q?GGuDmMW4XmmjCzwieMsej5B1HhxVOPqvqhX8pFXDeP1xrSaSFS83U8AFBwAe?=
 =?us-ascii?Q?nBKoxGdbGKnOiwer46deAEA3MeCzvBkvM4RQPf3AWICX54uYxkJVMc+nJc9e?=
 =?us-ascii?Q?NM+yzbg6J3x7NoB3COUqmuzdJfefwdAqpw5LM1iwhfcLCb7FKtnVqYPvBSeD?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5deb52-c6d1-4abb-86bd-08dd71c05b0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:33.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0ryOF3oE2zQRbjDNAe5kf2+dpFM/qatTGbsbz4UN/zPOVST8FbaukIOrufDm0TICNVFg0Nlv90sHj919P5ZGMVTxoEmGxxEMJT3N2mDpm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: ai0r5wuG0jQupBDIBY1rb4hX2TS2QXRX
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67ecf533 cx=c_pps a=ynuEE1Gfdg78pLiovR0MAg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=EtZhav-2TRoc92nNA6AA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ai0r5wuG0jQupBDIBY1rb4hX2TS2QXRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: Kees Cook <keescook@chromium.org>

commit f9c0a39d95301a36baacfd3495374c6128d662fa upstream

Errors with padzero() should be caught unless we're expecting a
pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
is present.

Additionally add some more documentation to padzero(), elf_map(), and
elf_load().

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-5-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a6508c56f418..09f9c5ad0fc1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,19 +110,19 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-/* We need to explicitly zero any fractional pages
-   after the data section (i.e. bss).  This would
-   contain the junk from the file that should not
-   be in memory
+/*
+ * We need to explicitly zero any trailing portion of the page that follows
+ * p_filesz when it ends before the page ends (e.g. bss), otherwise this
+ * memory will contain the junk from the file that should not be present.
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long address)
 {
 	unsigned long nbyte;
 
-	nbyte = ELF_PAGEOFFSET(elf_bss);
+	nbyte = ELF_PAGEOFFSET(address);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		if (clear_user((void __user *) elf_bss, nbyte))
+		if (clear_user((void __user *)address, nbyte))
 			return -EFAULT;
 	}
 	return 0;
@@ -348,6 +348,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". (Note that p_filesz is rounded up to the
+ * next page, so any extra bytes from the file must be wiped.)
+ */
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -387,6 +392,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". Memory from "p_filesz" through "p_memsz"
+ * rounded up to the next page is zeroed.
+ */
 static unsigned long elf_load(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -404,8 +414,12 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
 			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
 				eppnt->p_memsz;
 
-			/* Zero the end of the last mapped page */
-			padzero(zero_start);
+			/*
+			 * Zero the end of the last mapped page but ignore
+			 * any errors if the segment isn't writable.
+			 */
+			if (padzero(zero_start) && (prot & PROT_WRITE))
+				return -EFAULT;
 		}
 	} else {
 		map_addr = zero_start = ELF_PAGESTART(addr);
-- 
2.43.0


