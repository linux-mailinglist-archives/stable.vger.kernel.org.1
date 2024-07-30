Return-Path: <stable+bounces-62642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21243940980
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF855281ADB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D20186289;
	Tue, 30 Jul 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C2tiIeJh"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC316A921
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324123; cv=fail; b=ZMiIkvgeuI1QH8vXjnXN0uJvz2jy1Ap/l/HWBM46+KWOaA2tl3N++XnjqnPytYcqi1xWU7ailBB0S7DcMvlUawzVkYXBQB7BRsvwbQt8VaX0BtJtWr4NvcyQQ1u5/6kcRTKQhxpHFOC6dADx55yPVJHSDrUK7hfYlVAevYjKM58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324123; c=relaxed/simple;
	bh=fCCbefHHI3Tf0L2F3s4TBQVynwufkaRq18PinX8OoRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SryC5rC0rbuLl4sGrGFOZF4NRzNvkfI+oK1cSSEhMZCaFPZSgFyhZKEZyRDR0DQt4YRJOEd/KcEmGMJfSAo5dqh3YXvTwOrtNpl5sv6hyWiSFiQM62ZlCrlsS8ymhFcghEZsUiTx2RepUeCGb47XGcHlbDfGX3c3XUBeC8BWFow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C2tiIeJh; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cubtctfmBF3FG6nQYPD7xG9iOmsw+ecLU4AM38WFUWPhBWdpCR85dP+B32xBQoqhGPVYWV8zssSs/SiFNRqK6qtoH8CvJKxonYkvGB0cUe6FTLz5HvBN+H8bja6beiQggR5tc79fsJ/l0kAgjtgkuZhQ6DV00lJWpA5CqOJVWydlcpyxJ1+eYPLpYUn+vvv+UzaJOgdwShp/aiCX7NvqY7kH7pem8km3bESpYjaz0c5ysM9i8KIi74sphfJ10wF5LtyVE3txRcnA6ztPBopOs/RB3fzVlobSmtf8Y0dmJ3PMs4UOzhmax54txDk70p9UcsMCCL7hi/rOMw4dI7CiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Anj/oMQCcV6gzlWSIUdSoY+0XT151LfIw+qf09S8nY=;
 b=H2E6zXXm3hRG/Z/eFOkv46HV8hbrPj4O1nJaESqR4MVxWqZVBulcydjEWXL396WNCRBmyDHcgMRdpMgTNzUkzptWpEmtUlSbX3byATQXC5ZFcekwOxas+zRZXVsU6UPCDU3+Vrmlb2YJgpePm5gEMpNlM5R4qu+NLcQvUAz50r7DjsEpGrIye9/755I7JPo4Fqv6zqPZXgnwtoPMR6sy5MbUBAPtaCFMCF+mBGmOogwbrBqm57fEkdm1i6YgCXggsc4OJEJQ73o6x78dA7ELv7gUPW0F0vAQVxoomAmtySwm+xlskV8EsT02v0oAGkvYck36Z55SgXMLG6bDbAjGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Anj/oMQCcV6gzlWSIUdSoY+0XT151LfIw+qf09S8nY=;
 b=C2tiIeJhmRUphddwsEpAUouiyXhJRKjo8QGeB9GjP1VdKAvIVq6yDNcewkKejYtXTPx2O+BhI1KUvCrQ6V2KBDmA8tXXd1euJw9EONpEzk8k4w29mkRDKMSZslc4HoiKI5wtiZCToqyYKVsP1FJ4JOlX0ADJYi31vaXYI335wmE=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:21:58 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::e6) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:57 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fangzhi Zuo
	<Jerry.Zuo@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Skip Recompute DSC Params if no Stream on Link
Date: Tue, 30 Jul 2024 15:18:38 +0800
Message-ID: <20240730071843.880430-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e23b96-ae9f-4faa-f8d3-08dcb0684c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uyyRg1CECBq2ylap1wb5p05WQtfjeovIFLIrGW/bzSR1leuFLKWUPRK81Ma7?=
 =?us-ascii?Q?9zSe6EbdoGt1ZFwwOpjE9lovGxfbyUvwqmXJvM3YjcNOKa5JA4CkbepC8Hgc?=
 =?us-ascii?Q?BWBv92YwJb/KB1l9dJMTzxZZi6u8nYALiWKPW1tj4Ea0cj2BVZEZAQ1nrGvE?=
 =?us-ascii?Q?AQ3EQ2HLSvqhhbT/vD7tsjYG6WXEynYPGPs6GpoWP6OYb0j0x1+8sBG52sme?=
 =?us-ascii?Q?TQdSMWdKb7xWdRvZIfg82QcorHny0acIylCH0PQALVwU6lqovo2n65voqt2h?=
 =?us-ascii?Q?dYCrgUa7acaEd+9KLd12qaEz0nUQOek/FO9kGtBhhzVt2I9h52BFefrzYdgL?=
 =?us-ascii?Q?PSfLc6W4jMLEBgzRN+x9rTUVyNMjVdX/s7MtLEuLQ8Brwij4IJ0lVCiNoPuZ?=
 =?us-ascii?Q?LZDr0RuI5Dc795iPEtIStHSKYsnzm2qHR9SX8Qa8cpanxmDClkE2z3Jka298?=
 =?us-ascii?Q?FmBVajokWAJSlmsnuxF/ikYwWOL/GoPvd9C3qwQ0ARif7Ijzba7KPybzQ2Ca?=
 =?us-ascii?Q?Qlj42vbKI4ddTU54L2fM9f2lX5KydAvvjHNcGRbppHtjnW1055B8BkCcYak6?=
 =?us-ascii?Q?UrLidyPASecZLjo47F31x0mFpX6F2RXO57HntGMad3RIN4di2O6ayzU+L+1Z?=
 =?us-ascii?Q?RxXRd/SawUD1qVFbVN9sfYc9Q8NM+jyqZSsD7aHxc/2fevOp2wU2ICMeCNn3?=
 =?us-ascii?Q?CwcZnZ84/IaXblp4KN2iXS4Jh1aOmqxnMgCZ14t2Mb/uC8frCr1JxqoWgk0S?=
 =?us-ascii?Q?3iASlkRrfNBDuYPpZQFk0wn0UIowmU5sCh1+eiG8zljEq1jTNO0TNwa1rlW8?=
 =?us-ascii?Q?R23EsHyykTb3DhISpsk7Kw0N2UgSu8vlCwlIs6XWP28WrpaGm9vhJ6A4mdlc?=
 =?us-ascii?Q?s7SUPL3n/B5vu6hBkiVAD/l6TkMiXhWmXKfxLta7N1fkiEf/WAk0uSA4jNJa?=
 =?us-ascii?Q?9AM7zem/UiaIBIKXrb7dnuEg33Wf7/lKp1iATxjpuk+ViphKmjkRwGfhiY6m?=
 =?us-ascii?Q?pk9npFvwlFUPH8STb9qSwx2xPBjLSskgZw3ajyEKdBGyeu/VEbwXN3hIJoo/?=
 =?us-ascii?Q?J7GRnACZELlV6TG/iJTSaYK3mo15lReZgmsAkUKJJZgB7Rb5Fk6jbOfLabcq?=
 =?us-ascii?Q?W1AGkyqLnohxsUb8kjQd9xUHdlbzBJ/gxQeGcxjMXws2frVQ9E8eoQTI564R?=
 =?us-ascii?Q?tk06EW8u7OluPtL/4ZL54pnL66DxbgUGjrOsGNYFNi+HGMOk9y6w+acy1wIi?=
 =?us-ascii?Q?guBaH8AHl4XScP9Jcp14AREGJnS7+2kwnekfT8YsuM5oFzjFnbAj25OlQLlQ?=
 =?us-ascii?Q?ocrm1SvP4whPWrXALCQF47tq8MqkV22MKkjtCRCY5AbntYKXP+zxiMLc4VKe?=
 =?us-ascii?Q?8+zKqPKRvz7mQ0YS/+mkidI6r51QOMk6qTOptsXLG856xRsinamcbr3IiOgV?=
 =?us-ascii?Q?unOZ1W5TlNi0vN/cXis7Q9DmQLTH/GTe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:58.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e23b96-ae9f-4faa-f8d3-08dcb0684c51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[why]
Encounter NULL pointer dereference uner mst + dsc setup.

BUG: kernel NULL pointer dereference, address: 0000000000000008
    PGD 0 P4D 0
    Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 4 PID: 917 Comm: sway Not tainted 6.3.9-arch1-1 #1 124dc55df4f5272ccb409f39ef4872fc2b3376a2
    Hardware name: LENOVO 20NKS01Y00/20NKS01Y00, BIOS R12ET61W(1.31 ) 07/28/2022
    RIP: 0010:drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper]
    Code: 01 00 00 48 8b 85 60 05 00 00 48 63 80 88 00 00 00 3b 43 28 0f 8d 2e 01 00 00 48 8b 53 30 48 8d 04 80 48 8d 04 c2 48 8b 40 18 <48> 8>
    RSP: 0018:ffff960cc2df77d8 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: ffff8afb87e81280 RCX: 0000000000000224
    RDX: ffff8afb9ee37c00 RSI: ffff8afb8da1a578 RDI: ffff8afb87e81280
    RBP: ffff8afb83d67000 R08: 0000000000000001 R09: ffff8afb9652f850
    R10: ffff960cc2df7908 R11: 0000000000000002 R12: 0000000000000000
    R13: ffff8afb8d7688a0 R14: ffff8afb8da1a578 R15: 0000000000000224
    FS:  00007f4dac35ce00(0000) GS:ffff8afe30b00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000008 CR3: 000000010ddc6000 CR4: 00000000003506e0
    Call Trace:
<TASK>
     ? __die+0x23/0x70
     ? page_fault_oops+0x171/0x4e0
     ? plist_add+0xbe/0x100
     ? exc_page_fault+0x7c/0x180
     ? asm_exc_page_fault+0x26/0x30
     ? drm_dp_atomic_find_time_slots+0x5e/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
     ? drm_dp_atomic_find_time_slots+0x28/0x260 [drm_display_helper 0e67723696438d8e02b741593dd50d80b44c2026]
     compute_mst_dsc_configs_for_link+0x2ff/0xa40 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
     ? fill_plane_buffer_attributes+0x419/0x510 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
     compute_mst_dsc_configs_for_state+0x1e1/0x250 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
     amdgpu_dm_atomic_check+0xecd/0x1190 [amdgpu 62e600d2a75e9158e1cd0a243bdc8e6da040c054]
     drm_atomic_check_only+0x5c5/0xa40
     drm_mode_atomic_ioctl+0x76e/0xbc0

[how]
dsc recompute should be skipped if no mode change detected on the new
request. If detected, keep checking whether the stream is already on
current state or not.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 080c1d5f7412..53b5d79112da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1269,6 +1269,9 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
+	if (new_stream_on_link_num == 0)
+		return false;
+
 	/* check current_state if there stream on link but it is not in
 	 * new request state
 	 */
-- 
2.37.3


