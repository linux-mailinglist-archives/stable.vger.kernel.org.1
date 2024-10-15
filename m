Return-Path: <stable+bounces-85181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799299E600
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAEF1F214DC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A01E32AF;
	Tue, 15 Oct 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qykX6XEn"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF11E6321
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992246; cv=fail; b=HBg14R8BfdXuDEtc5pfumip28n5ESjS2zrCiziYlZ0xx9f7PM2x1lTLERnUgtAaLHnQkNDfAhMlBZCtvle5g0gN8YiOFvRMfTWZmia/ZYYFmnKeL7pEp3h6G7fQVlzqAz54ubHXGVuQkTJLxwKzEP2p7zfpE0n3n4BRXQei6x2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992246; c=relaxed/simple;
	bh=BipHIXQ4Tq83oMj/2mtyoHeZjjcIxm+hVTN81YPODNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/rd5PKXmWbIeW/Dbg9a73cW2jSjI2EIhrQ2B1KnvuCfefCLFVys4wtx2+OgSIutpGiz+zvj/tOQwFKBx/pFGrMRY2urQ6Ss4GtUIICzRiXQDfYFViPMgaY+d2DxymxgYOb7Okoi4jSfGUFgibR96GdcHmYK3RTATWpRKLDCSYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qykX6XEn; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnP1qGoIavlhxGEheQiWHjcJvkpjFAF/vIpHA80WW2Knq6devRVW8HvsVbI/wJbGzg1U1kaar9siJMCICUClZhK5FtEwuaxPWL9IxLQrehWI/wjAp5tEv/xfs9dbqzl0Pz5ah6Fs85WCPRtR9AGALVk5vfH+gvETOo4IQZVb7NZj+rOrg3c539d7/lB/8ERmOZHjtxeKjtodlWDHQBvFq1uYvphP0qsO2bmQuUoO67DsScheWDGyoG2kEAoG3MM3KSLv+5i+VNubsUW5OKkLgGqKIYVqKQLQ3YJC7amtKX03/tYOKdb+u/qg9+00csTVsSbti/bR+1uUW5TbFrfE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jaz4k8O17Xb0st6tL2ukF0UlNjtzj8W/INnfR+hL+2A=;
 b=XHi37HvK+zb5FWh15uukofnV0pmkleF0Q7qaAPdtbITAyvhR9fHwHyhd/pmARhAyFTC1jB6eOhzN4jbTCRTWr6UzReXw9V+v01IyS7diycaeBjJrye2cXEx4e1MV/FRk7XSqppqF0625xrlK2oLg3CD63DldzPFtmQoTFoPqOM7ysdOxiQBYZD7QQh3lWcEs94clQRgUZPs1iJYKgXQ16/NEQ9GrREOiYpGBF2DRSsA6yZeosDGv9NL4wrZ35banJu0Htg5fyJmiZBnz+utWDq6SKShyeSi0wSkpceOy00hCZE6LE3aYiUqyyZoD7Sg8wd0ZXGIPdHFBwaQeazlUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jaz4k8O17Xb0st6tL2ukF0UlNjtzj8W/INnfR+hL+2A=;
 b=qykX6XEniF99mfrKZHt80O6fHD4YCDZauw12tuliV+UhC+x5zs+0EyxbBk1FKoeu1AWfyxsGCT9Us/Lkjx6bHxgdLDt3dyvymOqiUJV5zR6/fBIjhKDdzG/WGq2jy9z7GL1dRNp//SdPWEvhWBSos0uT0FcOieXTTKTkj3LSTB9ZX2m1iEkpLqNuGbvqEw0u0jCRmwUNaCFh8c8Bfe+p7iWTbEN3V4TwIHz0FYEH40o3zQYfn70rTrIpoc8p9ysQyBprLfNM3+luqnUlbhfQIHwvuOFPoNDDXDmT85E+lO9wcvQdzmv+w2JkbugrkP80YgqJRUfNtsOqMktFsPHbbw==
Received: from DS2PEPF0000455E.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50b) by SA1PR12MB8598.namprd12.prod.outlook.com
 (2603:10b6:806:253::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Tue, 15 Oct
 2024 11:37:21 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1001:0:9) by DS2PEPF0000455E.outlook.office365.com
 (2603:10b6:f:fc00::50b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.3 via Frontend
 Transport; Tue, 15 Oct 2024 11:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:37:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:10 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jiri@nvidia.com>, <jacob.e.keller@intel.com>,
	<gregkh@linuxfoundation.org>, <sashal@kernel.org>, <vkarri@nvidia.com>,
	<nogikh@google.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH stable 6.1 0/2] devlink: Fix RCU stall when unregistering a devlink instance
Date: Tue, 15 Oct 2024 14:36:23 +0300
Message-ID: <20241015113625.613416-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e179f9-c706-412e-85fa-08dced0dbb70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AxhHvsa9fGhV0kAUIUNAL8Ae3F5V11UBiJeaJ6NJdBnE9GQ1LoeeqW8lXNl?=
 =?us-ascii?Q?Edpo2lUUbpnJPZzWJP5nYpQdJSJEwgqMcB7gwAEP6LlxXIlVTTtnOw120ait?=
 =?us-ascii?Q?fsKZqb0zzz+onyLyWl07vltl2xEz8wivW3k+CEysYrb4P9LwwTiQaRCZT89p?=
 =?us-ascii?Q?G0TQMbu1JQf3+oj7dayr7h5bt2Ci9a1oOcYmcPSfr7ktqdk9anmFiIX938ol?=
 =?us-ascii?Q?d82onxBuYvOkTGRTkLauoKAm8BeVAwZ7wMlcQQioe2wGhY2UlAkKTcfxqJKw?=
 =?us-ascii?Q?xTuwDTZPGdrJTe3aVJtBneTqH7lQzQDNTYPBsUxT3B5dUVfCpjcM59G/aQyK?=
 =?us-ascii?Q?gfJXHRCbV0Fvltdr6INPMUipSt1lcvQ4w8cTBjtGvD1LauIsZf79fhSumW7Z?=
 =?us-ascii?Q?n2KrivlJHFBrxl/gjCH0LyPadutppBclnewnIu4DU+cA8fL14quZRUIk8wMr?=
 =?us-ascii?Q?Sca2rhsewBJPVkhAK+Rtb4UttZph3yYR9FQV2gJLrgAHCVzKKgD28E9UIl3C?=
 =?us-ascii?Q?xtPPfFNZokFuaM7YnZajSXr8KHYDNw2eNPKvqOBZqgULyTfW8PDnIv8sxA08?=
 =?us-ascii?Q?RSqEBZijdFkowPKy9ZEklx4CVD4Ax2/2lYwE41oWqjfwUebi6YEi2iFF8rHC?=
 =?us-ascii?Q?LhESGyzxXuKUv/XlqlNmLUWtpSbEZjbti0n8vvfk4OiaqovpePOntunDGXXJ?=
 =?us-ascii?Q?6b4+h0echE/pP8/gB/m8cx1VD8IDqBQTsN+jj+NYdv8HTZvMWw55IZiV43Ie?=
 =?us-ascii?Q?AYRCUnJSU6LEmUU9I2NPVk1QpPjLBPHd6NYowAE0k4/rcPLbkmVN/Bmc8W8M?=
 =?us-ascii?Q?QBCZqtFAcvX9eKT40/vs/CphWhnyyRVF4iC4kfrvk1ndnwy2yfEJk3RvoKCo?=
 =?us-ascii?Q?vXLuWdOQ+ngZBGFzWIqnDkJaZEaAWwPeg9OxSpfoEyCFmF6wFGwO4GeBqWZY?=
 =?us-ascii?Q?lwmbymL+cm7+Za4U+TGZJM3tx07nDIaRpt2PlIhn4fP1lXPmGTs3oyitr03X?=
 =?us-ascii?Q?VtZ5rQQIV1rmDbLFlUoyZ9VMqRRUYH/gu54elN8T1gXQzyzshkAptWD20bNJ?=
 =?us-ascii?Q?VRlMlc8KcDLDfUP2gGSyuIhBziT2RMwy6V9Z/BRMD0Z3+V17yynX+XPE+wx6?=
 =?us-ascii?Q?yleDRdSs0WhoVCIB038/An0iDhooCbt5CZ07LmH1ZUebAHfiA+oMXZWzQ4mw?=
 =?us-ascii?Q?tk4/5usFTWR0rQZep4TgupDWyHAb/Y9fgADPjspq6/adgE1gcU6vg5ukMYVO?=
 =?us-ascii?Q?Aodf6R32i5OAjyKfgjBu2iLDJG5MPm5VyVi2ANgHbRFghu+o982qbubmgDIN?=
 =?us-ascii?Q?jQZn4PPnLSwDgZFTxSBTjXEvNAvM8ed9VdZ6g1zbQS52Fn/Mnc7yCym4OJ3F?=
 =?us-ascii?Q?e0JcrLHtPyYDSnnjUUwuxAbrnHCf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:37:21.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e179f9-c706-412e-85fa-08dced0dbb70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

Upstream commit c2368b19807a ("net: devlink: introduce "unregistering"
mark and use it during devlinks iteration") in v6.0 introduced a race
when unregistering a devlink instance that can result in RCU stalls and
in the system completely locking up. Exact details and reproducer can be
found here [1]. The bug was inadvertently fixed in v6.3 by upstream
commit d77278196441 ("devlink: bump the instance index directly when
iterating").

This patchset fixes the bug by backporting the second commit and a
related dependency from v6.3 to v6.1.y while adjusting them to the
devlink file structure in v6.1.y (net/devlink/{core.c,devl_internal.h}
-> net/devlink/leftover.c).

Tested by running the devlink tests under
tools/testing/selftests/drivers/net/netdevsim/ and the reproducer
mentioned in [1].

[1] https://lore.kernel.org/stable/20241001112035.973187-1-idosch@nvidia.com/

Jakub Kicinski (2):
  devlink: drop the filter argument from devlinks_xa_find_get
  devlink: bump the instance index directly when iterating

 net/devlink/leftover.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

-- 
2.47.0


