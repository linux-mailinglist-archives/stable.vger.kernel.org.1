Return-Path: <stable+bounces-134501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C5A92CD8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 23:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754A51B654D7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074842063C2;
	Thu, 17 Apr 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YVwQrfG1"
X-Original-To: Stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706018D63E
	for <Stable@vger.kernel.org>; Thu, 17 Apr 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926627; cv=fail; b=WlZSFjIxmBuAXF31HuzLbXX1l7ymVKOqZChNLTFNsNKErzPqF/FHuw0G9y9YJ+LP+OsOAtCFxQFTxmnDa56OrOP+87HX1rrSxXjz5USfCR3LbvxItK1M3HMAep6AoRd0rsRAufD39QJr/LCu2ZV/0rygtLuyGyGY3tAkbK7JruA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926627; c=relaxed/simple;
	bh=KgTl86sFYaWJaRLlgGEzlITgOVr5EEA1FHuAtfLt10A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fzwc39vguOHVaw3Wm5NxQsFuIOiSkufvzodH22pa3kymQIWBcFs+z9jf6zLlmppIysSpHYIJFC/58fqORXybrPqLiMsbqIxz9lo3IWPhj6s/MypXM2QF6LqEQIqN4QgbMSLS2QhgxoLvWLnmUd5bvNYVWptTvz8hMwp/BxtY2bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YVwQrfG1; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkJ+GHJI/Ly9cGOn3LvmOyRJLKsu5KiFE4G5rRU2FOHpSNfAYY7CHWC3vNI9U7EIn3exJ4HyKNrGODgrq4mSXXdKJ62sRLKxQHBtDwqqhN7cGhCvxPKhwHw7cpBQEbrm5SgNfqqRJ10ZLYKMRyUPUux6Vla3cX3wP6QWkgbH83HyM2dJe2xgUvRicG96B2ppYCAdPf3ST1d2pDKjrflRtMEGba6X/eL9BdirfW/1SqKMsYjrEFfkgfQNVGhf1912bPA6rMZ+vl9LHZRfHitQV5DhWpvIhi04xnAtzqxUTKLBxBLB9v/7q+mz0TVGaCe7zzxUFsHtVKafY1Rf4oqCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jxjiWoMRdCVP0lP9XyPOWgzRRMGXi0bTHsqi6SVurU=;
 b=xWFKHXqTV0JgoL2L5l21UyJCYizs1jfMBCn26zmRykbQ4Ou+23OhfUIiKnov+OSxAwOCBQj+qTdofZx9zk5vNS/g4h8DicyOqaGv7gysQak/8N0J7gNaFOcXG/H99/JOVGkIvn3tMhNNTMyhmHtQWXm3Ve1j9nnI+vcNxUcNUoX4VVrCCSzCB14Lcy23koEhy9E6GaR90xu6gmpnQjgrXZA+LINrWuxXfQIQC2HglY5zhBfvKplElfdNbYvBbLaJ5yqEjE1R2jYOMcAXsEWITAwMLhngFFPUpJfXJSApYrsUZfmDIIfRZwH9aqJZbArQ2g1YEACcyGrXZzMyu7GisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jxjiWoMRdCVP0lP9XyPOWgzRRMGXi0bTHsqi6SVurU=;
 b=YVwQrfG1q5Ve+yWh36QOjwe3b9L8yRzBaBXzt39svxIIqcZc2nROSyebx1FYEx3pCcRyWt2hpMcM3wTqorgZVuA9Ums6T7LJkXAKJEPHf79wkcsNI6pit591mqsodxZvlrORi9FLfl5/J016QgYZPxJ5GoU4+QFso1zRoIL8hXc=
Received: from BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 21:50:23 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b8) by BYAPR07CA0106.outlook.office365.com
 (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Thu,
 17 Apr 2025 21:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:50:22 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:50:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
CC: Alex Hung <alex.hung@amd.com>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, <Stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Fix slab-use-after-free in hdcp
Date: Thu, 17 Apr 2025 16:50:05 -0500
Message-ID: <20250417215005.37964-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c0ef99-f776-4810-22d4-08dd7df9db00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeB/s3cfYYnyyeMRaIQbb0+ecgCSd9AQnXWDeOD/WbLmHuOTpuOR5JwZooWy?=
 =?us-ascii?Q?+r850GhBs/BT/Vig0+ZClUMxVM3TLDz/eSjIXmNuZNbjKxxqJ1yDSYo1Ffyp?=
 =?us-ascii?Q?P3qst3zVTrxwVl0gN9vx9yQBhPUQ+Z5kt3AIy5Prgz/qhyg6wTKENdYF6dUW?=
 =?us-ascii?Q?pqhvh6HHeAdssoXIP26mR9y8ePFG9/dxFwLXQlJ67eMko1yRBdYGQ1ocGksl?=
 =?us-ascii?Q?P56DwueWA/44cm+4Rr4XO1Mro12EufGSqdj02bZBNvedDEEijOwtr0CV31rn?=
 =?us-ascii?Q?4GaIWlFbwStdTXhiQEbR23cI8fdxwkLfViAqF44hqvTtcjyYDkWJok4XwK0T?=
 =?us-ascii?Q?m07Vm/nKhrQuNa44W35QnGMEJ1rCxuWKS7+V6Ek9MVt5gGxk5EByyRX4K2cj?=
 =?us-ascii?Q?Rhgz9dG7DzyMCk7WX714n7o0IU/91pqQgMTvp2z+k6z0tj12tQYRZCACh34O?=
 =?us-ascii?Q?VThyU9H8GJeifxEjyevBqRbVI/OtE2XgWJ7R5RkE2Bn3xaN7FBN1y0ZRgj0O?=
 =?us-ascii?Q?ScMNEKXD0oHZ0BnRabsC07W44XBu/6qOCNxIsw0B3nFoYcuioFhE0fQgsMXs?=
 =?us-ascii?Q?Ej135nV8VQMikddrN2FR6G121KBQ33YpAyhLtql0lxSpCcd+i5C84hZo1Xyj?=
 =?us-ascii?Q?jZJvqAWbWLfABn35JL67UfZdMOIMU9QUgovjKDCdKMofmII+W2cOlKO6sBYN?=
 =?us-ascii?Q?uO1HK7NaO0g9TK5AcLc5KIjaPG1EXEKyjpqScJrXZSGcFr7lEbEvY1C5603j?=
 =?us-ascii?Q?G3ZauTjcZXrEg++PudVFW0MojjbGA/inLpORP9/WX2Wk6xM+4MY6QzkDkqPh?=
 =?us-ascii?Q?nrGfz6AsZAQiMAxJsv2AKYSPiwFa6swRWWqQyt4xMIrphfylQDIRdedK4jYV?=
 =?us-ascii?Q?esrlJ+ivpN43720QHFa1KqzsBpSLTZBHDyxdFlwnBNsqxrr4nlUcPLHq+Ebj?=
 =?us-ascii?Q?XZx3XYOC9wMuT85L7HWC/Qp+Ki9BnAfKDmDhrWc8frS9ZlTmwF6734U3AkEK?=
 =?us-ascii?Q?axrJdM8dPGfF+sE5hL7ECQxD5O17twrJiZRtoZPBvpNmCl2glBjmbksSlS9J?=
 =?us-ascii?Q?VcVPKz1VKh35sdzKsoU+vZC7CYVxRED/xZvIxbN/SJNDnKBExegli7dT13o5?=
 =?us-ascii?Q?nfUed6pRGtdefRbWtnbtbC5ZAcuXTKmR2rpep9JlKv6ydMRFt2IvAG8nEUPf?=
 =?us-ascii?Q?xayaN8N33lUM2aRRphd4zMPOlVM0wtjn/rY1E8oeaK3sS82tmchB2ftTSruk?=
 =?us-ascii?Q?AcdpXZ1SAO3MbYHE6Ror/z5yYijjvYRS0aqtWso2bhCPa35DoD1kp4aR3ONI?=
 =?us-ascii?Q?mPeWBi8R0IYZbViVxd7NOy4EWexR+rASfE//eR39m5gOOMMv1A3crIcjxJLy?=
 =?us-ascii?Q?ECT9LfHCm5YrOS/lBq9FLhaE1DTnqJGVk782OJV96bvVSSF1s+tMlAL9WU8x?=
 =?us-ascii?Q?+Uh7eT9kKW/9iRIkJTZPQI/tFznsOZ2nvR9sJ8gseKBMlkuecMlmng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:50:22.9620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0ef99-f776-4810-22d4-08dd7df9db00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

From: Chris Bainbridge <chris.bainbridge@gmail.com>

The HDCP code in amdgpu_dm_hdcp.c copies pointers to amdgpu_dm_connector
objects without incrementing the kref reference counts. When using a
USB-C dock, and the dock is unplugged, the corresponding
amdgpu_dm_connector objects are freed, creating dangling pointers in the
HDCP code. When the dock is plugged back, the dangling pointers are
dereferenced, resulting in a slab-use-after-free:

[   66.775837] BUG: KASAN: slab-use-after-free in event_property_validate+0x42f/0x6c0 [amdgpu]
[   66.776171] Read of size 4 at addr ffff888127804120 by task kworker/0:1/10

[   66.776179] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.14.0-rc7-00180-g54505f727a38-dirty #233
[   66.776183] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
[   66.776186] Workqueue: events event_property_validate [amdgpu]
[   66.776494] Call Trace:
[   66.776496]  <TASK>
[   66.776497]  dump_stack_lvl+0x70/0xa0
[   66.776504]  print_report+0x175/0x555
[   66.776507]  ? __virt_addr_valid+0x243/0x450
[   66.776510]  ? kasan_complete_mode_report_info+0x66/0x1c0
[   66.776515]  kasan_report+0xeb/0x1c0
[   66.776518]  ? event_property_validate+0x42f/0x6c0 [amdgpu]
[   66.776819]  ? event_property_validate+0x42f/0x6c0 [amdgpu]
[   66.777121]  __asan_report_load4_noabort+0x14/0x20
[   66.777124]  event_property_validate+0x42f/0x6c0 [amdgpu]
[   66.777342]  ? __lock_acquire+0x6b40/0x6b40
[   66.777347]  ? enable_assr+0x250/0x250 [amdgpu]
[   66.777571]  process_one_work+0x86b/0x1510
[   66.777575]  ? pwq_dec_nr_in_flight+0xcf0/0xcf0
[   66.777578]  ? assign_work+0x16b/0x280
[   66.777580]  ? lock_is_held_type+0xa3/0x130
[   66.777583]  worker_thread+0x5c0/0xfa0
[   66.777587]  ? process_one_work+0x1510/0x1510
[   66.777588]  kthread+0x3a2/0x840
[   66.777591]  ? kthread_is_per_cpu+0xd0/0xd0
[   66.777594]  ? trace_hardirqs_on+0x4f/0x60
[   66.777597]  ? _raw_spin_unlock_irq+0x27/0x60
[   66.777599]  ? calculate_sigpending+0x77/0xa0
[   66.777602]  ? kthread_is_per_cpu+0xd0/0xd0
[   66.777605]  ret_from_fork+0x40/0x90
[   66.777607]  ? kthread_is_per_cpu+0xd0/0xd0
[   66.777609]  ret_from_fork_asm+0x11/0x20
[   66.777614]  </TASK>

[   66.777643] Allocated by task 10:
[   66.777646]  kasan_save_stack+0x39/0x60
[   66.777649]  kasan_save_track+0x14/0x40
[   66.777652]  kasan_save_alloc_info+0x37/0x50
[   66.777655]  __kasan_kmalloc+0xbb/0xc0
[   66.777658]  __kmalloc_cache_noprof+0x1c8/0x4b0
[   66.777661]  dm_dp_add_mst_connector+0xdd/0x5c0 [amdgpu]
[   66.777880]  drm_dp_mst_port_add_connector+0x47e/0x770 [drm_display_helper]
[   66.777892]  drm_dp_send_link_address+0x1554/0x2bf0 [drm_display_helper]
[   66.777901]  drm_dp_check_and_send_link_address+0x187/0x1f0 [drm_display_helper]
[   66.777909]  drm_dp_mst_link_probe_work+0x2b8/0x410 [drm_display_helper]
[   66.777917]  process_one_work+0x86b/0x1510
[   66.777919]  worker_thread+0x5c0/0xfa0
[   66.777922]  kthread+0x3a2/0x840
[   66.777925]  ret_from_fork+0x40/0x90
[   66.777927]  ret_from_fork_asm+0x11/0x20

[   66.777932] Freed by task 1713:
[   66.777935]  kasan_save_stack+0x39/0x60
[   66.777938]  kasan_save_track+0x14/0x40
[   66.777940]  kasan_save_free_info+0x3b/0x60
[   66.777944]  __kasan_slab_free+0x52/0x70
[   66.777946]  kfree+0x13f/0x4b0
[   66.777949]  dm_dp_mst_connector_destroy+0xfa/0x150 [amdgpu]
[   66.778179]  drm_connector_free+0x7d/0xb0
[   66.778184]  drm_mode_object_put.part.0+0xee/0x160
[   66.778188]  drm_mode_object_put+0x37/0x50
[   66.778191]  drm_atomic_state_default_clear+0x220/0xd60
[   66.778194]  __drm_atomic_state_free+0x16e/0x2a0
[   66.778197]  drm_mode_atomic_ioctl+0x15ed/0x2ba0
[   66.778200]  drm_ioctl_kernel+0x17a/0x310
[   66.778203]  drm_ioctl+0x584/0xd10
[   66.778206]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
[   66.778375]  __x64_sys_ioctl+0x139/0x1a0
[   66.778378]  x64_sys_call+0xee7/0xfb0
[   66.778381]  do_syscall_64+0x87/0x140
[   66.778385]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fix this by properly incrementing and decrementing the reference counts
when making and deleting copies of the amdgpu_dm_connector pointers.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4006
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: <Stable@vger.kernel.org>
Fixes: da3fd7ac0bcf3 ("drm/amd/display: Update CP property based on HW query")
(Mario: rebase on current code and update fixes tag)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 2bd8dee1b7c2..26922d870b89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -202,6 +202,9 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	unsigned int conn_index = aconnector->base.index;
 
 	guard(mutex)(&hdcp_w->mutex);
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
 	memset(&link_adjust, 0, sizeof(link_adjust));
@@ -249,7 +252,6 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	unsigned int conn_index = aconnector->base.index;
 
 	guard(mutex)(&hdcp_w->mutex);
-	hdcp_w->aconnector[conn_index] = aconnector;
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
 	 * we'd expect the Content Protection (CP) property changed back to
@@ -265,7 +267,10 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	}
 
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
-
+	if (hdcp_w->aconnector[conn_index]) {
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+		hdcp_w->aconnector[conn_index] = NULL;
+	}
 	process_output(hdcp_w);
 }
 
@@ -283,6 +288,10 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
 		hdcp_w->encryption_status[conn_index] =
 			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		if (hdcp_w->aconnector[conn_index]) {
+			drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+			hdcp_w->aconnector[conn_index] = NULL;
+		}
 	}
 
 	process_output(hdcp_w);
@@ -517,6 +526,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct amdgpu_dm_connector *aconnector = config->dm_stream_ctx;
 	int link_index = aconnector->dc_link->link_index;
+	unsigned int conn_index = aconnector->base.index;
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
@@ -573,7 +583,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
-
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+	hdcp_w->aconnector[conn_index] = aconnector;
 	process_output(hdcp_w);
 }
 
-- 
2.49.0


