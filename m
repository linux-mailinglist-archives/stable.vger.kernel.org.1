Return-Path: <stable+bounces-81300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C519992D3F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504281C2274C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185A1D4358;
	Mon,  7 Oct 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChKbEfOD"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B01D417D;
	Mon,  7 Oct 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307733; cv=fail; b=j9nS62Fdd/U/426ciK4lscztgx30Kr1pLCZV7XqgWYxLDLhoSNddf+84nQUhau6duJziLopoEZqfzXz44fG006YkOg7DLRpz+H3oMY6iTNVrVPumQXN6TdvtdN7USEUogE58816wZHTj8GzRoZPzs5t8bhy8Zk7odGJWHP6G2O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307733; c=relaxed/simple;
	bh=lEEok8uukENPoRQuV50wz7ssGEcWCOWW/xd/p8pFrAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrYSBnBWCYO1/wCL3GF0TvTE6MXqs+yJ4qFu36ec71a1SLytCjR0j7v4X8htLhek3mzTuQ3K3rBRDhO3ULYsQ8ryppbC/ZGZ13oHktREOHo/QlHxLyRX1HBNhIEiGWD+u6LiEZA+T3x7RhexvSYWbQ7j0n67Szuyxp/2ivKvk0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChKbEfOD; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc5Iij4Tw7cStvJ0lwXyQzaobA+wXR441Ut9+FWrbzBV0o6bPCKX2U+rxba8U4UAUZp/Rc+bksmCaO9+QuUfvonU+QnneUKLmh0Bv1wdqAtUDFd0AAQhuHped9eE9orXJRWCr6qK5i9iQk0Pe5JgknrE1INuzXHi3P2EcgXe/uWuBkRd1WAFbQviGvNpFmzGVVtxb1osZiTEwxVxal1SVX4QHu6LXCe+byRzJAYduDiaRwIMlsg9MRFJnEzV5nefCAS5K6yeFDdCLK9ETR0PahIjP2k+QKVE3HDr+CeXfTyGBdkKTy21x2yTwdLFlcvA+rNCrzN1wmytYbz80btZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfFbYUgQaLC2eLhsTkxb0rcsfX9WdXzWD8D9aIKPsaI=;
 b=QeJUl0GQm+kNSIgYRO1oIZCQQm3flY5VAN03IBrJSUn2qybCnl9cfZhYn1lRozSdBfAza3FRdQ8VCnLU2PAnU9t2BTECqY4VmXUpEl0W1kdyAIjIfFpilsbROMhzmnUoh3dc6BMbw8r4zUTsBgWO/ZQodSGyainqWPrbg+ZsOf9tR3r2T/tssnU0yHS6HwIb/AvfFx+YCh7qaRmoPv+abNjYRfNWRTRVNp5tz8ZI5hS0FhB2gX0bSRFKpgAqypZNNc4T6Idd69zFrU6oGO5q9fZx5EPpxn5Wz5b7FHnN9RQr1b688CsYLBaepxYcZwyDHC9vzIFBdoV4W4DVnHHdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfFbYUgQaLC2eLhsTkxb0rcsfX9WdXzWD8D9aIKPsaI=;
 b=ChKbEfOD7Mmcq3d7hpjg07haWDXH7AKOIFgaefYdSqfvJUemALBzsY3FnhQ4ziTYfIkQKc7eQQu8yqwvMXIYhskPedDcDqoUMLvaTBvvCe8TXddpRb6A3km7C+ebO8AZ0fIKMD1uQ5fDyVpctWtuMFDJ95P5OGNtkeyV4gJ+1HdhTf4MG4Y7s8+TOMfrSJA0zflbBpGSOPBzHkX3hCB2llWQjnnrvBgprCJa7MT/6cz+VufBsghfkZeMMo+TLZqZgFREzn04fVWhyt8zg8RRPrnwcP0xokjsPJrE9w8MikOyCnD46Jqd2sVf1TrLnfZ5yvdCykwmlElT4UkfiOwQtQ==
Received: from PH8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:510:2d2::27)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 13:28:48 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::21) by PH8PR15CA0008.outlook.office365.com
 (2603:10b6:510:2d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 13:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 13:28:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 06:28:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Oct 2024 06:28:38 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 7 Oct
 2024 06:28:36 -0700
From: Yonatan Maman <ymaman@nvidia.com>
To: <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <bskeggs@nvidia.com>,
	<jglisse@redhat.com>, <dri-devel@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>
CC: Yonatan Maman <Ymaman@Nvidia.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject:
Date: Mon, 7 Oct 2024 16:26:58 +0300
Message-ID: <20241007132700.982800-1-ymaman@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c175d8-2ceb-4e02-41b9-08dce6d3f94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egPscBrw/0QXRCScki1GBKlbVSQiicJkKkjHvTEbblF5ZJrjDbRJ9E+wWgeQ?=
 =?us-ascii?Q?BmzDI2D4u8UAHsIqPWcwjK1gujAaXejtRgvST7bOWeN2zZv8qVsRlaj8EGBG?=
 =?us-ascii?Q?j9T6p9KoiiMg3FJgvKYLv4zta17nnrLH+7c6RAr+YcgRiR0dF4dnS8hBSL9J?=
 =?us-ascii?Q?r+MBo9mrXD/GDo/yFmW6jdwkvlKKRsRvbrw98UbcgL3iz7KImdb7ermBQoDE?=
 =?us-ascii?Q?VD53VtxpDgFzVgZqUgCKk9ZG4yMNI0GLB4d1CyzNSUB2V6l9zAVB7Qtq8P70?=
 =?us-ascii?Q?03S5JYXgflQLOjERuvtN1HAurCKJOWWWUpZjhi8vzK0WLnGirkBb+otLJ2Bm?=
 =?us-ascii?Q?Af1ivp8/QRdLuMDkJCuAgUfyal+BVevgJU+S7LWtGJ4MQine5HrDDfDA9lLh?=
 =?us-ascii?Q?7mCXdPna1uxXU6xZchIrn+wAdMjMg1cLH31G5REzOubbEWP74ObToC98qusZ?=
 =?us-ascii?Q?xbjiPAC9InHjZ0JcGwoBk8t1TfEyc8cyfXRFakS3/4nccFysma2JgMfzf+I7?=
 =?us-ascii?Q?kmEePkvCFTAaSBciRGMBPUp2hgRo3tj2ZCqaZLMaH6ytT++JOtNvXqSlIpVR?=
 =?us-ascii?Q?bC4IYdJYzPRrimKiiISgFaL7Q1NYxsL7ZVoko/IT+26TcAT+1HzfWfzonwD7?=
 =?us-ascii?Q?uc0+drYP3UmDhLhTint80eHO8psRhD7B3qJ33N8qfYAfeCy1Ti8+zq1l9lwO?=
 =?us-ascii?Q?U9dGjIFUKB0ycd8KcrciB0TyW6hwmMKFg2gqNvCRMulMTyp6IH25v8k/44hK?=
 =?us-ascii?Q?u8eC9zKNamVvmpiK1FkpR3lM6bT8VKnx+WhXgSGf8L1DcU6JkQSaRnXlZ7FE?=
 =?us-ascii?Q?tUVMLargmTHCQw443hUFynrj/A/9Apd4+Mvl++eIKQNk0m4GEJNXhjoNh/ec?=
 =?us-ascii?Q?zN4XtIjyATRYts3/OY3QlodQskaO3d4fUj3xYDxPmU2l4+4jylUlcJX8eYDT?=
 =?us-ascii?Q?DxMdLfOkFA8guEwnXCkPpNncgJ74RgE2h/hN7HDYSInVyrW7pQUnQO3vZaLB?=
 =?us-ascii?Q?Oh3oH0GafZakv+kHtFzotu1QSb518jZ2EFQL2jcj/bsv4ffzXrXspu0K1pEO?=
 =?us-ascii?Q?sheTZZeZByuuUm4QD0YlOO8kAC9NBNDtm+pul9xkMr9gfBcD1+CWNaAv7z+t?=
 =?us-ascii?Q?c0xxswBR+nUncI1bg9ixx8WAg3vSuct5MTt3nOuz0s2h6WK+u6w7tX0/2zXL?=
 =?us-ascii?Q?78CGKLMc7nGMlgdqvITYam2ZOKYKHgxLcVlhcrgq8o1yM6ZPCjoUkfEpseHJ?=
 =?us-ascii?Q?+u1Ir/xjtZ7kDRjIFUXBjd9x4f5uz/1YY9s7P8JfKdJXShvmK/7SNQRffzvA?=
 =?us-ascii?Q?ErHHr3fEtg7OstcxCFhgQnaIDAViYWAQT8lP2gzSC1uZmsDDTz/vIbQlKr6t?=
 =?us-ascii?Q?0pqn/oQA4r6NiZrM7vXwLisSv1IV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:28:47.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c175d8-2ceb-4e02-41b9-08dce6d3f94f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

From: Yonatan Maman <Ymaman@Nvidia.com>

Date: Mon, 7 Oct 2024 14:48:26 +0300
Subject: [PATCH v2 0/2] drm/nouveau/dmem: Fix Memory Leaking and Device Channels configuration

This patch series addresses two critical issues in the Nouveau driver
related to device channels, error handling, and memory leaks.

- Memory Leak in migrate_to_ram: The migrate_to_ram function was
  identified as leaking memory when a copy push command fails. This
  results in the function returning a dirty HIGH_USER page, which can
  expose sensitive information and pose a security risk. To mitigate
  this vulnerability, the patch ensures that a zero page is allocated for
  the destination page, thereby preventing memory leaks and enhancing
  driver security in case of failure.

- Privileged Error in Copy Engine Channel: An error was observed when
  the nouveau_dmem_copy_one function is executed, leading to a Host Copy
  Engine Privileged error on channel 1. The patch resolves this by
  adjusting the Copy Engine channel configuration to permit privileged
  push commands, resolving the error.

Changes since V1:
- Fixed version according to Danilo Krummrich's comments.

Yonatan Maman (2):
  nouveau/dmem: Fix privileged error in copy engine channel
  nouveau/dmem: Fix memory leak in `migrate_to_ram` upon copy error

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


