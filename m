Return-Path: <stable+bounces-49926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48E8FF5A3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F61C25B1E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2E61FE2;
	Thu,  6 Jun 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JcMVRIJO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45247F6C
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704298; cv=fail; b=jTaweWSxTUzQ4ljJkqMeHUGS2idho4+/6WHe9JIZneb38uG6aELQnc4LSSwzKJXibo2oqd6UiiLA+FFHpTPtn7Cq1Gs+pKJ/QGEr1+8hkmbsF+3LWPmr3LWCAHpEabvhSJzwmsysYaAlAuZOYWjytRSOK+oAJ1pRzKcXA8kr9IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704298; c=relaxed/simple;
	bh=qz4zG4EE+6InCv22luJENkc+/KHeR56NdbDYCXyTrAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+rxzM5HyqdlVMNLrdHVPxN2RU4uVxjw0VrOeXLEEL46V4so3P6cKNy4MnvqkW1z3sUVMx0uqooP82bKLIoUZo9BbBdhgJX2hDkRlxEtRmnHLWEBLgTqMhxwGvqHq4gWSZidB6Bj2NsfnlY46Dz6ci5Z9tqnqePP+Y54op7SAOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JcMVRIJO; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsi60/f7PCZNDmg2MNBltVP3UT5aTPVKRb1CCb2THhg9n1q2VEALiiyE2Gur57btK+nD0qitx9JXgOh0+QJgTu75MPGhezVVnX1rsTJY15XLeogU8LAoDwbn4AifAm9C4plKmRJbxiz4uF3zn5JYXLcO/tSgdVX5aaXRGBZb0CtvH9mDy3eWdFzZJ+wfSvAxnBcnhnHsm0xdcLApx0mJ70Gfst8KXlu6YtpxGWNMfa7ndQAp5CYx9pA6LhXHqVHq9arAZj8F1JGxUxhNDK41LFo207N4r6mYrzKwoIgLu5ThnjBpwqqEK25h+OfB2+NBxwF6hMVhZV+tyOGEh1cuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McFw02l5qLC9btpyAnwHdb4aVYapHSrmhuYViYNThkU=;
 b=jG6SZwsNCkYq+9S5iHZObhWk3LmB24fDuFV6c5BepHSSAYLQkuINCkVP8pLAzoCRlnPaHAVnCG16B8fmfkX2+8PXz/YHVhaG1rb5vzMhpOCPUREtIMBnVdVjNyr51VZtMh/qN9qgqqUaF+QhJuMCqC/8djVq6soJx7OZMQUI/LPfQ7jvJGSatc7QKjUPLNiDDDE+hXeUfOFsW3sfnTZJ8LI6a23aO1W8P02vDWUyz7WrCijJ1JC8FJ6x3fb6ttCI/o5w4VJLTHYMSkSP5CRhLaGJojc/XdSQjbeNVUplnDfBLIej6bheTLD2H4/gja5ZyOpXEb3ivseG6IxKoTu3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McFw02l5qLC9btpyAnwHdb4aVYapHSrmhuYViYNThkU=;
 b=JcMVRIJOkWY6N9GfJlxSoDOW9lKEPMWrUbi1eh86fag5MQ5p2dNt+U8fLW1XFqBZCFY+af/wf1HdrMO0Wpdt6fBAfoNNClIkepGbL6V05bh4bqeamwYl0MBnM/0kvscptuUBbiIDzPKidroBhxdrm97qARZ5RDUusPQ8uqJ+jYE=
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 20:04:52 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::1e) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 20:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:04:52 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 15:04:49 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
	<mario.limonciello@amd.com>, <tvrtko.ursulin@igalia.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu: Fix the BO release clear memory warning
Date: Fri, 7 Jun 2024 01:34:25 +0530
Message-ID: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: a29632eb-42cc-4df1-d3a9-08dc8663ed52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGRtdG9kUkJEM1lwZU50ODhZTFBIeEVaUHpEWjl2a3NFNHM2UTMxYU5aM21u?=
 =?utf-8?B?V0pyOVZTM00vWTE2alpIQ1diVXZwUHI1REpJZ1pOQUYxUkdNZFU0eTkreFh3?=
 =?utf-8?B?enpqajlqM3pOUXpSdGdUbUkzZDhIMU5wV2dtZitDSTVPNUh3VENiK1JaOTlZ?=
 =?utf-8?B?SzUwZzNYTjk5STk3d3FXUktOS2hGZzROVXNqMElqQTdGbkpiMTVPb2ZUS0Zs?=
 =?utf-8?B?cFZBMGxpRi9FSVVJQWhGY0ZNMHFkZGRXejMyZ0wwN01oMEdzTkxMYW93MG1j?=
 =?utf-8?B?VUl2dGxISTJzRHQxY2cxWUpWcDlEWGxzT2YrcUNhRjlaaUF4RjliMjFBbnRy?=
 =?utf-8?B?L2E0Tkg4eFVrVFNMZDVvTEhGbWliSU83U1VWMmpvUWtObDBzTVBwMEtiNmZ2?=
 =?utf-8?B?dEI0VTVaZzN0Skh1Q1YxVnZpMm9tRVFib3F5T0Z6NW1SVUU1eWF6R0krRWk3?=
 =?utf-8?B?UHNrdmxFTDJ0cWFHQlRDblJHRWxieThjemFqU0VTR0RxM2ZyRjlUSXBzbU81?=
 =?utf-8?B?anhwc2FlM3ptZG9XTm5GS0dDV1IvRFNkMThlSmtJWlI4QkVRT1dDTjRhbFp0?=
 =?utf-8?B?d2c0Z1NCbGgwMTVIWk93VnlvaERwNUxMdVpraXFRemorbWcwNlFuMjNNTkMx?=
 =?utf-8?B?blJlK2pra21qYkJxNzhzc2VaUVQxNXNxVHBBYTZKZU52M3hZRkNDZGNFcDJP?=
 =?utf-8?B?Qm16Wkx4T3dLQVdWQWZvRHgrWjQybDBjZ0xJclNESytXS2NaZnU2VTFhOHM3?=
 =?utf-8?B?RXRZNjI2aWFseFFKZUZDYkFaWWlSdUpXbHpmdUpDWGtBd2Y2Q2JLaUQ4ei9Y?=
 =?utf-8?B?MG8xZXByVWN2cTRJYVNwR083bVhGa1ZESTZZSTF2djgvSkFuRTN3THJQRUkz?=
 =?utf-8?B?ckFSSldNY3ZvbEkwaEpDZEhqVGhPb2dWNzJwWFh3d0RrQ1JWeFVyZ3d2aHFt?=
 =?utf-8?B?eURoeUVmbEVxNGJzaW9XWW4xNTI3K1NvZ2hWazFvOWVkcXo2K1lONFNVcmtQ?=
 =?utf-8?B?a2YyaUh5azRTSEZBeTRTcXAvUUsxT3Z3MndJVExnNVloL01NMXg0c3orS2FU?=
 =?utf-8?B?MG1FVzFaSW82RHhQVVl3TitoOGpLMkJYODNqamw5Z2NHKzV4QTZRN29sZDFB?=
 =?utf-8?B?SVN4cVRFNlNMbDFFVTVNQVdLQzFBR0EvMUExeW9yZ20yNDBPbFFQeFpBMlVP?=
 =?utf-8?B?eG1CeVBKYjg2ak9wcENOankvY05qVDcxOEhaNlI5SG90bTQxZUVDMGpKdk1l?=
 =?utf-8?B?UzIvL1dwWVYzV1hUQVNubGdRc1RVRHc3aElvOHNEenJRNFBPNHBWZ2U4UVRT?=
 =?utf-8?B?TGJNMXQyczRCU09FL2NjdC9OOWtVbXpERlBZN2k0SjJmNmtBa3pSdGpTNkpz?=
 =?utf-8?B?cVUyUXRQL013b0dFTEsyNEx2cGR5emZUWi95UVNlUE0vV3d4TkJpME1KYUpY?=
 =?utf-8?B?dURxYXFNdjNzd2FyQ3duR1MxclpPeldKNXMxL3NJZC9LUEtDeURpeGk5Wnlh?=
 =?utf-8?B?ZU0xVDVESi9oQjR3cTYybzBqMGRiSDJubTJRazFYTUxXWVFhZ0JPZVFzSmhu?=
 =?utf-8?B?cU8rRXJlWmYwbG5Nd3NOTGU0V2RKSW41b2g1dWpzZ0VNdzN6VXNaT2JxVUtS?=
 =?utf-8?B?eUVVSXBzLzZFWVl2RkREa3lLQXJLMUprc3JJMTBNWWtrejUvRmVKejdWYVk0?=
 =?utf-8?B?bkUrblgzM3FIbFd4NGF4cjNLRmF0UmFDaGV2WlkzZjZMOTZNRmhGMWtiRnAr?=
 =?utf-8?B?a294a05Nb0ZuNzhzeWR5d0UrbE9aeWpQbTVBZjVkMFRneFBpLy9XQ1pVNjF4?=
 =?utf-8?B?b2RJeHNCN0tkZDVrbllmVjJxekFYK3c0NDBuK25jK01FNjVpZUF1M2NQQ25L?=
 =?utf-8?B?ZVozQ2FrRGFrZ3E2c3BiSW44dUdxR1BSa2syYkM3MCtyWUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:04:52.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29632eb-42cc-4df1-d3a9-08dc8663ed52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

This happens when the amdgpu_bo_release_notify running
before amdgpu_ttm_set_buffer_funcs_status set the buffer
funcs to enabled.

check the buffer funcs enablement before calling the fill
buffer memory.

v2:(Christian)
  - Apply it only for GEM buffers and since GEM buffers are only
    allocated/freed while the driver is loaded we never run into
    the issue to clear with buffer funcs disabled.

Log snip:
[    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[    6.036667] ------------[ cut here ]------------
[    6.036668] WARNING: CPU: 3 PID: 370 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common usb_common video wmi gpio_amdpt gpio_generic button
[    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 6.8.7-dirty #1
[    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 2.10 03/26/2024
[    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d ad d8 66
[    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
[    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: ffff90dabde38c28
[    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
[    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: ffffbbe140d1f3c0
[    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: ffff90cba9e4e800
[    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 0000000000000258
[    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) knlGS:0000000000000000
[    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 0000000000750ef0
[    6.036901] PKRU: 55555554
[    6.036901] Call Trace:
[    6.036903]  <TASK>
[    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036998]  ? __warn+0x81/0x130
[    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.037095]  ? report_bug+0x171/0x1a0
[    6.037099]  ? handle_bug+0x3c/0x80
[    6.037101]  ? exc_invalid_op+0x17/0x70
[    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
[    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
[    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
[    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
[    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
[    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
[    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
[    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
[    6.037826]  dc_create+0x28a/0x650 [amdgpu]
[    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
[    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038087]  ? prb_read_valid+0x1b/0x30
[    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038090]  ? console_unlock+0x78/0x120
[    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038094]  ? vprintk_emit+0x175/0x2c0
[    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038098]  ? dev_printk_emit+0xa5/0xd0
[    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
[    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
[    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
[    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
[    6.038505]  local_pci_probe+0x42/0xa0
[    6.038508]  pci_device_probe+0xc7/0x240
[    6.038510]  really_probe+0x19b/0x3e0
[    6.038513]  ? __pfx___driver_attach+0x10/0x10
[    6.038514]  __driver_probe_device+0x78/0x160
[    6.038516]  driver_probe_device+0x1f/0x90
[    6.038517]  __driver_attach+0xd2/0x1c0
[    6.038519]  bus_for_each_dev+0x85/0xd0
[    6.038521]  bus_add_driver+0x116/0x220
[    6.038523]  driver_register+0x59/0x100
[    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[    6.038618]  do_one_initcall+0x58/0x320
[    6.038621]  do_init_module+0x60/0x230
[    6.038624]  init_module_from_file+0x89/0xe0
[    6.038628]  idempotent_init_module+0x120/0x2b0
[    6.038630]  __x64_sys_finit_module+0x5e/0xb0
[    6.038632]  do_syscall_64+0x84/0x1a0
[    6.038634]  ? do_syscall_64+0x90/0x1a0
[    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038637]  ? do_syscall_64+0x90/0x1a0
[    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038639]  ? do_syscall_64+0x90/0x1a0
[    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[    6.038645] RIP: 0033:0x7f2bd1e9d059
[    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 00007f2bd1e9d059
[    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 0000000000000024
[    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 000055a9b23000a0
[    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 00007f2bd1fd0509
[    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 0000000000000000
[    6.038655]  </TASK>
[    6.038656] ---[ end trace 0000000000000000 ]---

Cc: <stable@vger.kernel.org> # 6.10+
Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 67c234bcf89f..3adaa4670103 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 
 	memset(&bp, 0, sizeof(bp));
 	*obj = NULL;
+	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 
 	bp.size = size;
 	bp.byte_align = alignment;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8d8c39be6129..c556c8b653fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
-	bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
-
 	bo->tbo.bdev = &adev->mman.bdev;
 	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
 			  AMDGPU_GEM_DOMAIN_GDS))
-- 
2.25.1


