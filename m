Return-Path: <stable+bounces-208023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5407D0F974
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A76D23016EC0
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F634BA33;
	Sun, 11 Jan 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YenZ6Cj+"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F61862
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156825; cv=fail; b=BNhS2ZWZCgK681P54Ylo0Scn8QdRrpsUuvGaBSZbGpUyRRaQmQhcucSZQoaIkXzsYS+Sf7mpLmXfnGSghDZqBrSrVHBuQ+5Z9DzMRcHDx6YLm0Mr4YVc3TBLqU0rRwJ3HWL/nSn4ezplv4Q/KNCGQSyAass/W41GiLSGUQYXlA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156825; c=relaxed/simple;
	bh=zmz/bUAX4HaKQUVbTgQ+HAAwXiuoMs/s5S71/l/KWjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaVeySSJ/FMUbY6RgoV6f3UEGlYwh0Ee++81KXHxoiqBdNsa2J+PmYoqAu2+j7iY/OPujndq4iHfDDsUNYOQWbk4U3Iv2ZWjDYmtzqHVZv2gSNZGDrDK1sp23roxo4Md6zfBaCkDlV5kdXK0waruTW4DaMSemi7V+iJoQADxxSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YenZ6Cj+; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX7uXwtMaUdcU3b1z6Zr20LUSe1/NLE8jUDYvxi8K4joXPP0zZ2dacSGAYACL9Q73Q9x4POukP5pGfXeyALE6x6usRXvJYpQ9rkuNlc/tMvSZ8ZH3ZPYnAOJMP0anqa6OKOKAZP3PdAhoqdOorw5LPrau5RVUv2O0fLRANZ1MVycO5O4IFXU2tH3J3EcOy6qOzG0oKTn8n2QUa/UlkGsE+NmFuc0/3Q2goUl/3QJFetJ8pDVEv0D61QI7c8al1vkV0OPYY5160C5xnqMlPxVnagrKFAnNp3YWyG2wOZOve9RI32KhfM6ohKwa7HI2zzAbOHQjaBNTf07a2OxKOygtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVfkVGWTVyqZvn1QvJtIBcHwhGO6JR+01y093AlJhOE=;
 b=EDeB2XrGeupgl3x0XzPcXxf42h/O9v1DzNLZDWQ01es595SDyCrcFIFLS2mOWINWNBZpMrdqJ/i0stXF/P7twlk1fPZdhW4U0jkaBLINThpYEpyvYsiD8k0rRGwbJW1XE1wPaab6RSGByHUrIVHjTQn5fIVmFlG35uPvgl2Kv9Mlm9AEVlDEhh8I9h2+sTETuv9uPnI8La1iWjEpFm3BdvbuxQaVtf4G0bbB9ehr76CIZRtZTLdt3pQ4CkqC+/hP5uh70j9HwFp8asaGx3dpUZKywfZoP0e4ewYn702GxwO3QHnwpF0aeevrtdPxgXI1LTBWd1VgMI90tqZYZUEnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.ubuntu.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVfkVGWTVyqZvn1QvJtIBcHwhGO6JR+01y093AlJhOE=;
 b=YenZ6Cj+/mnOJRen+SV627OqNoqAQWc65IJTdInxLB8QSz/2CM1Q0tl+5sBP45HefzZhGUr0MQI6XhRszE8TdRwPJLnXJDufIURkjU/qZt2ODBNtmVlw5OpGAYJQDh2cK6fp5bYWz6JrI85gJN0BxLdoZIOvfyXTd+J6ji5N4xc=
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 18:40:21 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::3a) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Sun,
 11 Jan 2026 18:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 18:40:21 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 11 Jan 2026 12:40:19 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <kernel-team@lists.ubuntu.com>
CC: Mario Limonciello <mario.limonciello@amd.com>, Kent Russell
	<kent.russell@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [SRU][Q][PATCH 2/2] drm/amdkfd: Export the cwsr_size and ctl_stack_size to userspace
Date: Sun, 11 Jan 2026 12:40:01 -0600
Message-ID: <20260111184001.23241-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111184001.23241-1-mario.limonciello@amd.com>
References: <20260111184001.23241-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbcc81a-ab0f-4268-aa69-08de5140dfff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RthAdIT75Q1f4fHJSB92bR1qGttaSibSohbs0Muab5KTgnL3raOP3LEp9QJq?=
 =?us-ascii?Q?kdFujDLX5Y9zsXBB8/LZaBpZbjWVlGZQhwxJw19PImyTJGelrnJBswWifBlG?=
 =?us-ascii?Q?igoWYSr8kGMfd02soTDsxMAum0VFYfitmTuR0xeZMK7dtchnhAOblAPpzAfn?=
 =?us-ascii?Q?ePrUk/SFttScQ93hc99hZTDLTkzq4s0W0eW+K47PN8oXHqhTuWfL9+krcVCt?=
 =?us-ascii?Q?IZwuwELdVH5Vl1kqLku1JQ3Vkek+AaqdOQ7O2wbbXG1jY3BHPqCSzhOUNwBf?=
 =?us-ascii?Q?FfI2cg+FHfWkgT5Uvmd16fGBFSBlRw7XAbk8OTo9wBNILjjdJ1fY2ImnAzG2?=
 =?us-ascii?Q?2D3MO0OBWPgdzeC9bCGtHsv+M/k/Hkn2wLMMyWv4WPtqQv/UX79NtWWFE96V?=
 =?us-ascii?Q?NFfQenBZKrmW8Dn1JlmfpgBog0RBbtWRrQII0bkHNAVEKp/QX0WZask5vbrb?=
 =?us-ascii?Q?mcg8WPnYCJa6khZrhoBZX+uzSUSpfLREz/nfqvNz9IZIsMwPQ8dzMC6PkY17?=
 =?us-ascii?Q?rBcaD36XN69pO8JI9l10KR6HS6Drx8FjmySDZW/JAImCu3byJQkJTQ6uglmH?=
 =?us-ascii?Q?l+JODzXb8SH3fkRH4u7fCEFxo3hX95tnIN0P0JrL14CTOFRjzqr3UCXgsKCO?=
 =?us-ascii?Q?OGaITzbfIvkIcNVIq/6WWCRtl5AYES0arw5Q9l47T1dK8ad5J5zMaecjAImN?=
 =?us-ascii?Q?fVGsRWHgAXKwSYnsWkgVIEltDGcbS2wuc93mfcxPlnoSkC/qBaQQHVzEkHOf?=
 =?us-ascii?Q?ZBFQlvzVqLvbNM68byh73Utqg3NXqgtl5aUwTltJ5I6eQiAZhYcU6ovJNafu?=
 =?us-ascii?Q?mzLlb94tb+GO8nweZhf61lE/1NjZ1cI3cizUi1KVpocueVrZXb+k4/hBQG4U?=
 =?us-ascii?Q?7zJZfMHcFd14u7RftR9Ae2dX1+yvu2p4ooDyzeB6w2Q+PB37hOjHdmItDNLP?=
 =?us-ascii?Q?Mh0wmzedLK47epHwT2bVMpLx4Z6zxtXoSxhnAhyWsG//CldGW+qenIQNsZG1?=
 =?us-ascii?Q?GA/f7YoA/QfZ+DD4ZxZQKeRyYGA//8WzVZvrTwPQ+LpXPKA62+PAolNjJhoV?=
 =?us-ascii?Q?GbqsCxcK7Xn3yAPSzVgApP8EIPoqSzlDjf7QecllAkfNdupqX/hZCAW2m7Da?=
 =?us-ascii?Q?aEkj8CViA2fEtshEQrQf0OC0Ug/60SYriGcMgGGMbYpRahIlKQJ02ql8tLS0?=
 =?us-ascii?Q?/2WInU4JGyPEwtkGKVsScBt2C3NiL8JoCKlmtjMYWyTB5IM9Bbe4s4wovxif?=
 =?us-ascii?Q?fkm7MKmiImili9OuqyQMn1tsuYKatYOS3N3oAYP3aLfFsegaG1fKWNHwfTMW?=
 =?us-ascii?Q?+kKHC/DH/kbI7D83M5duGMkUL7vz4ZLHOek5i0ssLBoDXAwz0Nyj8oLbb8k3?=
 =?us-ascii?Q?yHF9kvH58dERSGuNBsoi/QU0Lw8NeREk5eenN6IvyVC6X+Q9YSW4BExncgTb?=
 =?us-ascii?Q?wzPXvS58gPVTm3Wsbd2/eSBWVcs0PHvlHl0p58QIbru4BYYLd/Hh23U9ohYS?=
 =?us-ascii?Q?NB1FdkAJ7BfzJgK9K57JhJLaD8r0QGNhSYdv7SjjeoBJIiIDnbvcD6QjpdG8?=
 =?us-ascii?Q?ht9UgaHLX9D7u/bsDpA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 18:40:21.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbcc81a-ab0f-4268-aa69-08de5140dfff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

This is important for userspace to avoid hardcoding VGPR size.

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2134491
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 71776e0965f9f730af19c5f548827f2a7c91f5a8)
Cc: stable@vger.kernel.org
(cherry picked from commit 8fc2796dea6f1210e1a01573961d5836a7ce531e)
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 720b20e842ba4..af704f8731c5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -491,6 +491,10 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
+	sysfs_show_32bit_prop(buffer, offs, "cwsr_size",
+			      dev->node_props.cwsr_size);
+	sysfs_show_32bit_prop(buffer, offs, "ctl_stack_size",
+			      dev->node_props.ctl_stack_size);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
-- 
2.43.0


