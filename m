Return-Path: <stable+bounces-119630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF2A457F3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9331A3A529E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C41E1DEC;
	Wed, 26 Feb 2025 08:17:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F7189B94
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557842; cv=fail; b=pENAq1HRAKOqIsC7DMg1zh95QcpJO1xIURQbyH6dQIfpdOiCJZf/AhlElTQXa7RYh9FOtynzY8ioRVGdq7RQGsd1nkMrnESDR8w0PrLxM6TdLdmIoDGirDhspg9YIChMCk4s5zw+y+HO1Dfqz12Cx9pjh/rAtTmbbZH7LzUa55E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557842; c=relaxed/simple;
	bh=+t3Rfd7RDKON2yO5rZGB352FR4CspQ1WuQ+EKQFl03c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c58mwPro4DgNdriZ/eYbfR1yrwdyHo7Pw2vzcHvPWgbrJmIj+DZPNgmosOKsnAUgJiXKAek+9DJhRxifbZpInyT+Ot47y1MtkrsfTXdY063VIPmTRYnD5c+Y0d/3/Z4/R0h5w8oW9/CE4E+BlEDo2q/f/0bQlu8UaKruiPVpEmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5GIoY010894;
	Wed, 26 Feb 2025 00:17:01 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 451ptmgfan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 00:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZeEmTnSEOAjCuLjIp5Iv4LM2E7WgC0oBuhdcItv90W/DB9hySQJ9+nzZvx8dXVy2WaivckcCtkaVdqPzoGWgehkUDWaB+6eU8cih/ZaUYtp54DoBFmKjYKFBzZbyHHBPDWxl/4tobawUm2+DbEG80cPat25RebFeN3srLAWF+tKSzlhFik5EipLTmZmJQ4hY0h9oErB6aKodfVrjiG9xl+GNIckIaA6U0J9NsnThGZTmWimj1lxMH2++oLjThkSyZUbWx3KiAo5x1kJuvrQB947wuyl2b7ZMyj9zUYutW0dOreCnedkCIxLLe5W4eUK7skjzlgWaZHBqDSGFKbQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LUf7bR/3Z04An9bJptoRwOrCMq8HdcjBM25et5d9J0=;
 b=tAP++n6LXTp/HdgR3IR6pwALNoX5gkX8sp5XLnxaC985P6mWvgUhfXTAPLbNxqBcI6qR2TvAV5wVGKvL9WrAYrvdHGNVk4hpPJzJwQ6rvUu6whS/DgQQxnwNdXwgQMavmLqAgvLJHMoJsprtgQtf9tsibE67QliQ/QAreWFcXdX8Gvf6YW1pzvpYnnD7jdWxwCXJE+/6lZzoblg5jYsflL2USF7pXz7BgNnLRYGxUQvbvVWgDcDkWeKvTSNbU4VIQyByJcbqhk1rM7gD5NxPna0lvJbmg69lIc/oWT+5EAOOZk5b1FBxP1Kh5BSJETnNkqVeXbZbCrszY09EUOkn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.23; Wed, 26 Feb
 2025 08:16:57 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 08:16:57 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: phillip@squashfs.org.uk, akpm@linux-foundation.org
Cc: brauner@kernel.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 6.1] Squashfs: check the inode number is not the invalid value of zero
Date: Wed, 26 Feb 2025 16:16:46 +0800
Message-Id: <20250226081646.1983643-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d879a24-efdc-4a46-0096-08dd563df006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4gaTDqgM22tDj2AMTQPvjXhCtQ6hllFmubmGIisbdMWO25xltRVDl5v+5Gl?=
 =?us-ascii?Q?6nWoZsMUmwcJyGu8YWVtThFi8qW9Fg9JgR+w5a0CayE7jK5SVlMiCea7y4hR?=
 =?us-ascii?Q?dM9/OxwNiA/WSJUW71Mz5ZQRF7nWWPdPlgH3FiQdWNNBOYZqh9Lnnw5bgl7H?=
 =?us-ascii?Q?auu6WovtnRTTJCJI78vGQAJ1WUOouJdI6yGlLSa8nczYH6X5lO8zCEzt64jj?=
 =?us-ascii?Q?UE6zmWzoLvKlF4yOOKX+LhmohTQlBUuBzk+aOP2X5PfJ6mrCivRanACTlMu3?=
 =?us-ascii?Q?yLoR+kv0T3L9PPLyPlDk3BNjykoQdiRq+1I/2CJF4YJbq19OrOq/gw6ngBrW?=
 =?us-ascii?Q?H+jOb1dj9dMKp/2ABVLTTnQ2qEAhfuGsJSENkXX5ki10LY+k8d8RXUva+3Ap?=
 =?us-ascii?Q?OdK9b5fuCddjkHi5xEFbIZJHETI2rg9SQZOAsipCrGCvEiV6B8zOEEhrolKM?=
 =?us-ascii?Q?bhiM7ET7BIUUWD3X5cq94tWS2tEtuIcMEfyXScKR4AVVSlEgzGxJ6xgW+ZXs?=
 =?us-ascii?Q?sRSvA+2dsW1Y+9pQZgv1tp0ANf/29Kwa1HHauaIpTGAzoJbFAiCXoqLpZPtx?=
 =?us-ascii?Q?4u1KkuBsNX7cA40yuUG3F15qTWpXGzzl0u2SQvZe+x4hwD8lCOf8xtseU4Ch?=
 =?us-ascii?Q?lBAWlWIX3Tutz4kfP9rgteCSIuUWmxsn+fmStztd3zmrwXB392FAnj1cCzEQ?=
 =?us-ascii?Q?DSpVk00M/p96SI7i8piAtdXaINK7FSEkAqY9soPZDXMrXWFB+psTtRddQKM9?=
 =?us-ascii?Q?zbvdv+ZyWb1F/41EutVpLphagm//igIRFzroVDO6BMCt4U9Rf9nOB6e1cCdw?=
 =?us-ascii?Q?9nr/JgUY1h6EYiJyS4kiJU1p+8yuxeT4W9UkL3SiNqjLY429atX7GOlPfwe6?=
 =?us-ascii?Q?NvUokyWBYUXMkwgZ/mMMFYexZr7ownf7m2t7bkhT3Dnj8F0Wwr9Fd0lnuXY2?=
 =?us-ascii?Q?FPQq3LC806v4Sr21qgMGkjPduvtYJpzc34LyPbypjxfGhqD+W954qMWL82MV?=
 =?us-ascii?Q?WXw7iMzxBhRjCjTONV5XXfgGRVLzD/b3crVoqoeLcoxaWHRltW1dexgESW3I?=
 =?us-ascii?Q?HwQTArby5yWplfpoZ/fnMXgskTvOCU6d+0L7XGRaNVl6FeHJZLX/7E4VPTWc?=
 =?us-ascii?Q?eB1X6AY4Ngyh/Q/+n3NzHHZCWBHNtQRoUybnLWTDC3P0vcdhdWsS73oETxjJ?=
 =?us-ascii?Q?gaaodCzqPo02FMiG1V+Ly60wtinZbIg7PM3wsyY0PvaUwWCySEAFU4hHrVKu?=
 =?us-ascii?Q?D9GPOcvgXMqvt7Sw98kVETEnvXbhAdrfhMBVmOmHk3Y5gWIm/7O6hURE2S47?=
 =?us-ascii?Q?vIn/fcG6b1kaTSj9DYSsMhnv1YZiGK3LzaPHzGicGWw6vVgdLJj7xpM9sp5W?=
 =?us-ascii?Q?giXYy6AD3StkcRafZoU+ha4C3wcm9zJJzGBuYUqGUnDpfJoLuTC9O9laLfcw?=
 =?us-ascii?Q?8nMNgDtMdStkVY5wS6iZT7N54wANKGy3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?INwkDG1X16Oc/nxqflbX/ePyz/al4p9Vj+qNkpTXppNNk6/ztKjw/NbUhd2U?=
 =?us-ascii?Q?DPZtYX2ZUMr/7ap+Abew8Mp+Kog7CD6PBvKnBkjZEZd0BEqMoYI9T9opUR60?=
 =?us-ascii?Q?VVI2HFB/FFng/laC6plEyDgSLtvzkKmU3DzJf6Vgca5fXGBS4941UODtwU9Q?=
 =?us-ascii?Q?+Bq9zRZ29aXy0vomfWhT5q8fmp405ygfkBlNnYhFRI1XnZUi9GA2qxVV6OTr?=
 =?us-ascii?Q?rZAexxZ3sAmMITSLUV7v4brPA6S2+32XS7N+9VZMhEC9z7PR9s7FUIw5d+fy?=
 =?us-ascii?Q?gVPDoc+oA3OR7Hx+FX2whKWo8+bzq+z5NwKuP/ZcVnDutAwFxv6VJW/I26oH?=
 =?us-ascii?Q?7+Njhvlg1bl6hNGYCXceosrSe/ifTFkETKHAuP2CW8qRX3XtVYQ2FyJ4BSwT?=
 =?us-ascii?Q?Vs/RDI1tkYm0kaDRSwoSAYi6cGFnkCeFpSxtpFE7kt6/VvMLQOzJna5cyX4l?=
 =?us-ascii?Q?9z3Av4yb2ikPPu9dFSGBmmVuySzKwIDvK/k1vvQSDbl1Tcy3tkpljsyXUOKM?=
 =?us-ascii?Q?+zZTd4mbjbB7cxx3KxCS/yDtqvaCwN40qH14rjOjl4aZbdFMGzw1mgnCY8hK?=
 =?us-ascii?Q?Bup62NmT5qdZuvSI/3uDpjMwKYrmWXG0cpVhUqkG4FSaHl/CfeUA/EfPvKHj?=
 =?us-ascii?Q?oeUhrRJhBzD+cGTjXsjdaxkjmUfE1o8cDRvvRJkmQuQ4n0WfDd3ZsG4S+iTq?=
 =?us-ascii?Q?nrP0sFLPcEuhcuC3tMf9zdJzDhnsExQ258AZiFp3jJGWGxVX8uCJt7srqaim?=
 =?us-ascii?Q?VpNUZxdEmvVeuohuBwCfn2W/jiTZW73t8K0naZmiogQwU2CfgC0e/nHBlURD?=
 =?us-ascii?Q?PMbClZpf0ccxVMCYye/3igA9ozJtdn4FcNJL53cn/KFntjsvsx3p76nOIDzl?=
 =?us-ascii?Q?c3AGJaUNJoknvXgs5zkBrvqayp7LYQo7+NyDrmUFpURp3sH7Z+Uj0FJpaZSy?=
 =?us-ascii?Q?kySNCj6TX7KD/vTGYG2C3hgxswS7Qamg6OjYjPa0Fxegj8SJMqtbyL/3irSq?=
 =?us-ascii?Q?k2JC2xn16aySlO0iR0x//C6Q8q80vGb37CIo51edl1oIBNkqlD9UDFWlVBzj?=
 =?us-ascii?Q?vC9AEc0ivG3LvOy2ezjnhQGVI0v1rR1h3fCBygkkhjSNv0flsyt94a8M6H4C?=
 =?us-ascii?Q?jmV4Dw5KW9N9l9Fk33jWT1ywQPuTW4fHuOk5/vv1d5Ey8beZUNyA+iX90YNQ?=
 =?us-ascii?Q?nSI7pW/tCAUuXMNe4gop+f1dJ5mWfceFS0SzSOWm8b0fYUVqyR87+KFg+lNJ?=
 =?us-ascii?Q?fFN5Q5IyIDU1f1O3vzDF8i4gMnEIvtKR59SCC4gpf8fq3suq0bYoAeqo1A58?=
 =?us-ascii?Q?NFS4hkX1nuJKeSweTfQHELrVFC8KyBGYpWcw1SqfaKa1DwU2rExEjl90EBxh?=
 =?us-ascii?Q?RpL+XgvVxGdqc4O5qCiWB2GtIv7ZcVCchlXba+TvDO4SWEv0f3MJOCs5rl5P?=
 =?us-ascii?Q?jcYrZsoi6m9Cs/jDBgWrn8zP8w2PvHd1i4PToPnb8LkUgmQJJvQmZxjTNTC9?=
 =?us-ascii?Q?IcQ6wF3ofH/tilJ0GiuDdIGkhQp5xTMvn11nkbpscYBS0siSggT3Sk3mVr+P?=
 =?us-ascii?Q?NtY1LPj63wmobXI/abzhm0xwP+Hc6KXCLTWWJvuwrtHMlsYECXXiciehWLPQ?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d879a24-efdc-4a46-0096-08dd563df006
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:16:57.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0pXadc1kPr2UC2nY/GfGNXJTvXjGRH3sUZymLrDvTkSg3/bOMODjF5/1SLGjB4pA0J7hwX03fPvHjGWvusBZJm4uE+4aG8X/UUQHAoyDzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-Proofpoint-ORIG-GUID: wauQ-umKuzP9ZBnGDMKFkG8nSoIIUpLS
X-Authority-Analysis: v=2.4 cv=UK8nHDfy c=1 sm=1 tr=0 ts=67becdfd cx=c_pps a=yneE0G6ieORTwLKR6pgPXw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XJTnSpgKjpJfBdNX:21 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=FXvPX3liAAAA:8 a=1T6qrdwwAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=ec9I0riOweQitel0d58A:9 a=UObqyxdv-6Yh2QiB9mM_:22 a=pdM9UVT-CToajMN3hxJJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: wauQ-umKuzP9ZBnGDMKFkG8nSoIIUpLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502260065

From: Phillip Lougher <phillip@squashfs.org.uk>

[ upstream commit 9253c54e01b6505d348afbc02abaa4d9f8a01395 ]

Syskiller has produced an out of bounds access in fill_meta_index().

That out of bounds access is ultimately caused because the inode
has an inode number with the invalid value of zero, which was not checked.

The reason this causes the out of bounds access is due to following
sequence of events:

1. Fill_meta_index() is called to allocate (via empty_meta_index())
   and fill a metadata index.  It however suffers a data read error
   and aborts, invalidating the newly returned empty metadata index.
   It does this by setting the inode number of the index to zero,
   which means unused (zero is not a valid inode number).

2. When fill_meta_index() is subsequently called again on another
   read operation, locate_meta_index() returns the previous index
   because it matches the inode number of 0.  Because this index
   has been returned it is expected to have been filled, and because
   it hasn't been, an out of bounds access is performed.

This patch adds a sanity check which checks that the inode number
is not zero when the inode is created and returns -EINVAL if it is.

[phillip@squashfs.org.uk: whitespace fix]
  Link: https://lkml.kernel.org/r/20240409204723.446925-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20240408220206.435788-1-phillip@squashfs.org.uk
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Closes: https://lore.kernel.org/lkml/87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com/
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified on qemux86-64. 
The test code from https://lore.kernel.org/lkml/87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com/
Test code would trigger a kernel crash (crash point at read_blocklist) and the crash won't happen anymore after
applying this commit.
---
 fs/squashfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index f31649080a88..95a9ff9e2399 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if (inode->i_ino == 0)
+		return -EINVAL;
+
 	err = squashfs_get_id(sb, le16_to_cpu(sqsh_ino->uid), &i_uid);
 	if (err)
 		return err;
@@ -58,7 +62,6 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
-	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
 	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
-- 
2.25.1


