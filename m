Return-Path: <stable+bounces-191509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F8C15AA5
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5444FB828
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8E332EC9;
	Tue, 28 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZkrhVzkY"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF441862A
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667025; cv=fail; b=b6VgxkhEOSixegXavo+J2IEYaqqTYnA0452eoq5TUMs9sCmyr8ZldLjitMXlUPu452g0tVE39QKVSUZiv9QbmkpdvoLwielUenqm2Q34WEFRf/18vh5HQonQ/gVupnJNelhL0hGh01OBrbwiLVmenlNVzRFv3QMnpyjnmSQ/sQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667025; c=relaxed/simple;
	bh=J7gZPtw5ZFnYTlsEaL4P8vhdfP/xMpm6ui4DrHXwT6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qabhj5QS/D3erdDACNLy1TNkiUY5IW+BycUxwCndTaro+s0N2nLmfrqv1KuR2nKBJc6M8LS2Lq03OcUNLJEFMBWkOag/G0MvlCDxpQLMiCKL/a528AOzlBvLxc4HcBPBImjqe697hIBwg/aT2e7URooHAJOj/fMiPM1BLHXu+O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZkrhVzkY; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRf/EsK7Pv2J7KmEEC3EVSj4on//xthEN/wRDv8AZdILH0AD3W9VX4oLHM2/Hx/5FMAqrHQVk9/hFK9ZiHyOQSYJX9Kj8JN4N9lVlPqNR34egzoR6NXjA0BLnD0je+Ogm5haaXdu5wvncQaghNRwL3hKky3AEHp9wszlyJGwtBSxpgdUzNsmnyAlkbcyEIdDKN1Dtsima4PzLJRvUDNg7kQ9HsgVuvyf14+plmwe0mthWj+bwIkfhPl2fsYwtSWYTJuoK3FkUdJzTdSB9WUq95dNZbndKVK/5m5Udp+87/5GErJmwRGOxMT/b8FC/cwFpF6jxZC4j9W8hphfyjISjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd/nBLJM6k3tc77WpeB5BLekpGI9/yaBZZmeaQ+7iCM=;
 b=IxMDXGrT1/8Ca0sWSk9r1Zetgdd0YpgCT78R5GP6/B7o756tekYVrwaBTJGDI12Tx2PGkf+C7eDh6LWLIEYJu0nkVGnku+fTTaIy1r0vOtj9kz5zP6ExnlajVIvYwH10H7HZKwIfnJFTQ98gehA94dWc/VCWXUZviQhGZcs89lABZgxUb87oZC0cPMGluz4Zv87eaWKK+2W02zanf9/b9TqBsDLOHiRlA/3xVWH88Qsvhj6C+mH6BhXDGv6xxNcUAUA4LmEhqdbWtPuxCSPuXJiAzYIEQOSfIMoAcpWmZnpQvUedUvY6yijFHM2ZLZCog8kgnXW8GwhQeZxgqVmmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd/nBLJM6k3tc77WpeB5BLekpGI9/yaBZZmeaQ+7iCM=;
 b=ZkrhVzkY50WFYqWCuYL2AzGy2v0EgFN6vNdW3IWLR2umN6lLWCvT9H/EkwCwkIsWcXotGNpDeA32v35etbrAV6bObS/hq5XjD/2XM1UZP7C8hzP+5Mq2rKooHtVxhdv+QkRycxKV38k901Fa+1rPXKq3sKtNrYIc4rfVoFpht+U=
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:56:59 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3c) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 15:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 15:56:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 08:56:55 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.15.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Tue, 28 Oct 2025 10:56:50 -0500
Message-ID: <20251028155650.159936-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102054-slacks-ambush-f774@gregkh>
References: <2025102054-slacks-ambush-f774@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7a1696-991d-48df-6eba-08de163a9f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFrmhttZhbpfeKyX7G8HpsaQOURg61Q/ZTKPccUW9J+5kwBCBt/xg4nATq/+?=
 =?us-ascii?Q?/3rF3xjvxYk1vEUcwDMC2sckZ4F3g8ytPIF92T16xtXXrd5C7fQe/Vqjou0p?=
 =?us-ascii?Q?ePaq6AFZaGpzIq+SoV2ZicemhdrjSOAJg8GtQ208Ev7MEs+GARc1d8qE2F0S?=
 =?us-ascii?Q?8Sl+0Kw8xqLrtY9M8pC+BUf0LWny0HXpg/BnqN+MFLNOc9qnvpxsqxQNSY09?=
 =?us-ascii?Q?fbSFt2Zp61gVmCYDgSif33uHzR0tFyjP2dVUjMfYV/S3wrMf19VKjSJ9mN9z?=
 =?us-ascii?Q?z2lMXlFq7CoMpYMSetkow8bWJTDKbQP7qotyEI3W+VyLYBsIXocbeiT7wX5p?=
 =?us-ascii?Q?DZBy5ScWi/0rv+CUo1kkTAPDRC83WN33JYdF9+vlBy9oPTnF3KvpuAZJaUFA?=
 =?us-ascii?Q?8pBoddnO3pwGyZkYdqyZynay1GnJ2i1173Gv18+ABKqHKHwQluJjVXcE0+tX?=
 =?us-ascii?Q?L2+tgf8n7FFveI9t8L93RE4YX9KqrGWu7F0iR2FdBAfeCSFvzaZ5D2qM86G8?=
 =?us-ascii?Q?Sk8iAIsTPDzBnkD5wIuEk0y3JyQpRi9R9lqNfZqPeevZRYQAu/G+C9QUqHG8?=
 =?us-ascii?Q?aJWRxJ+wqJDvNfFmeqDNfb9UklrQPQTSvIABLr7QyyxiT6xXlo5wzgJn8jj4?=
 =?us-ascii?Q?J5RHKSqgy4KXzca7c40lmjHJbvLU82TGtcRQEhSe+DTpCp+OY48YubOvOWH/?=
 =?us-ascii?Q?AB483H8wzDrqZOmtXcYmuL+u8OC2nUrp59bmzHhhcv8kUJGsggvyfjB6So+P?=
 =?us-ascii?Q?+Bn9OmwkGZRmgnfo7+zJDvcULKBbWGMs6K1TieFQxOpbpD1nqSLVLEiyNz/R?=
 =?us-ascii?Q?432SVlDyUOgOpTEZ71BcxLk1TB6NNkKatTj6HFHFa3EspWT3k/yTKQieSynw?=
 =?us-ascii?Q?QV+LEGaq3MRRu8w4PHgIiEzD9ZyMK8XB1OcMT4gWyWwTyM8RHNLsLt7B05GW?=
 =?us-ascii?Q?4uOZve6OhNfSbJ+V/o8pKJQd8Vw8j3Pnk6VO2GU3AVpaOUiqGk7GMxvIST/I?=
 =?us-ascii?Q?0J51YLXADvmUMjQYW+vTxhktwKCOw2ea4YSHs1gtjZvNFxw0wB/jVbhQFZZR?=
 =?us-ascii?Q?dNdncIyX8JGFO6bMUo+i305IABPRHlPRspkJq7LH6b06ab/EtfM47NHeMdkj?=
 =?us-ascii?Q?fFdSmNXLulHL83TdXS+aG6igxgMvXiCQYXQOQrywpbbQnyMvVlGMU8ClQnqB?=
 =?us-ascii?Q?6f64CEL7+iAu9ts2rNMxqroUsU+ueEWy3TcO6g9S3Q7fp82IZoHhCe3fzJRs?=
 =?us-ascii?Q?yWqXI6qXSiVjeGXq9Sc/KIWE5vy9MGf8KTXIBedk4lOfGDoSblFQlGzRVGGD?=
 =?us-ascii?Q?LsGDpERmv1R9b7itQ0m0n81sC0fHUmmCb/SlCDjEWgMo1r7KAU3Wk5J0FlOC?=
 =?us-ascii?Q?IIhSA5zFCdVkR5hDfKrCdvRq0dGhUQQDl43RN5VgBD3DH7DQhs3/EkXvpZ+5?=
 =?us-ascii?Q?CS2yzjncHA3dOBP53aHjWXot3kIb6EAbark9L5Ql9tJpgv//eTvg3EN4aNrR?=
 =?us-ascii?Q?JAiKCKUHvSH5W7TIK/g8ow687PybYhachBmjkGklqNdftB2BEvqT+rRo4arL?=
 =?us-ascii?Q?FAmgY7oE8cFPDozTlPY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:56:56.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7a1696-991d-48df-6eba-08de163a9f2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

[ Upstream commit 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92 ]

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state.

When a bandwidth counter is read for such an RMID, the hardware sets
MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
remains set on first read after tracking re-starts and is clear on all
subsequent reads as long as the RMID is tracked.

resctrl miscounts the bandwidth events after an RMID transitions from the
"Unavailable" state back to being tracked. This happens because when the
hardware starts counting again after resetting the counter to zero, resctrl
in turn compares the new count against the counter value stored from the
previous time the RMID was tracked.

This results in resctrl computing an event value that is either undercounting
(when new counter is more than stored counter) or a mistaken overflow (when
new counter is less than stored counter).

Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
zero whenever the RMID is in the "Unavailable" state to ensure accurate
counting after the RMID resets to zero when it starts to be tracked again.

Example scenario that results in mistaken overflow
==================================================
1. The resctrl filesystem is mounted, and a task is assigned to a
   monitoring group.

   $mount -t resctrl resctrl /sys/fs/resctrl
   $mkdir /sys/fs/resctrl/mon_groups/test1/
   $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   21323            <- Total bytes on domain 0
   "Unavailable"    <- Total bytes on domain 1

   Task is running on domain 0. Counter on domain 1 is "Unavailable".

2. The task runs on domain 0 for a while and then moves to domain 1. The
   counter starts incrementing on domain 1.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   7345357          <- Total bytes on domain 0
   4545             <- Total bytes on domain 1

3. At some point, the RMID in domain 0 transitions to the "Unavailable"
   state because the task is no longer executing in that domain.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   "Unavailable"    <- Total bytes on domain 0
   434341           <- Total bytes on domain 1

4.  Since the task continues to migrate between domains, it may eventually
    return to domain 0.

    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
    17592178699059  <- Overflow on domain 0
    3232332         <- Total bytes on domain 1

In this case, the RMID on domain 0 transitions from "Unavailable" state to
active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
the counter is read and begins tracking the RMID counting from 0.

Subsequent reads succeed but return a value smaller than the previously
saved MSR value (7345357). Consequently, the resctrl's overflow logic is
triggered, it compares the previous value (7345357) with the new, smaller
value and incorrectly interprets this as a counter overflow, adding a large
delta.

In reality, this is a false positive: the counter did not overflow but was
simply reset when the RMID transitioned from "Unavailable" back to active
state.

Here is the text from APM [1] available from [2].

"In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
first QM_CTR read when it begins tracking an RMID that it was not
previously tracking. The U bit will be zero for all subsequent reads from
that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
read with the U bit set when that RMID is in use by a processor can be
considered 0 when calculating the difference with a subsequent read."

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
    Bandwidth (MBM).

  [ bp: Split commit message into smaller paragraph chunks for better
    consumption. ]

Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
(cherry picked from commit 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92)
[babu.moger@amd.com: Fix conflict in monitor.c for v5.15 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c9f0f3d63f75..743a3fe47621 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -288,11 +288,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
-	struct mbm_state *m;
+	struct mbm_state *m = NULL;
 	u64 chunks, tval;
 
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
+		if (tval & RMID_VAL_UNAVAIL) {
+			if (rr->evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+				m = &rr->d->mbm_total[rmid];
+			else if (rr->evtid == QOS_L3_MBM_LOCAL_EVENT_ID)
+				m = &rr->d->mbm_local[rmid];
+			if (m)
+				m->prev_msr = 0;
+		}
 		return tval;
 	}
 	switch (rr->evtid) {
-- 
2.34.1


