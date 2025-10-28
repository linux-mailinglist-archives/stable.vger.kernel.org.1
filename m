Return-Path: <stable+bounces-191546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D81C16B33
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE191C22B1F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E3332EB5;
	Tue, 28 Oct 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DlaKkglJ"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183C27B353
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681558; cv=fail; b=qc+E9uIw+CW2mpArmZ4DTox4HTHhKCOh3iB9Ucd40btiMZyF+USFa7NCXkN8pZZYNdz1VQlsNsAWT6l5d9T9IBoBHuEnhdsvLWXLsre95L2OU60DNMMjVlbteA3NPNBEgYk2IFg+SfJ1wQoyaJ2OEzZfB4lDRiekfqmCIJmtcAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681558; c=relaxed/simple;
	bh=AgbB6SdhOf0EwqC6zilkFlFAhzBLqyVcsh+gYHTtIXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlWF+9d+DqFKsxQcbGwOVflbkYb1E1VhpKrSZHPVjTj3zZQ6OVjnmBMuiLlvsYG54tMRWF5sv0usli7Wkp31q2XYOAAZjV+syIsxFxiq4gD90JKuYZAg3gaUlBvfM2yqpHoktKUFbK6T0WspbORC3TPmqQPHy3WaLQjg8EFcIVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DlaKkglJ; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHIHtzHxiJkrM5OJ5SJP6arMiYVeoja+G993z7+FG2Nz8cNkBQYV6c7LPMDUwQbrCaCGBAEc8caNurS/HMZzM5xbw74LeHgrVT3Nmfbaa52FJM6ufYxQxT05Tetpd5BvzrCuNqBlVRiI9LW6SzWXio92nbWjlNjFu5w1FM90tCF3rZJ51GdTAlGClpqIPRRsy+X0Wk4SSuTkMZXUyTqy5ECHo88lvguFHuC0/anwXK33lrm+Ot131X1sELTnmg/3lvrSPWO8xSqxWQxSxbUmXHMVAeG7B9YUzwO0FyxwaaXPIfy+JZ34DF1OJ3jU6LnrLSzFrEY/c/futli3eovxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85nB/3TL//nmNxWJU/bWulCLKrs8kuIcEH3IEPvJnrM=;
 b=iVX30RKurwCj/9BDywA1vI0sy93+1oPS3kftLepiNPH9jqMwEEjng2ujwTsbYf1ID29z2GYI2zvzxd/sT5m8TmVPPn7qgn+xZHkLqtOinJoXR8vMRP6J1QL95iY+1spFDYETq4wa5Ed3MaP8lIsq0wfhyKQL6S8Kse/pRE+0z+HP5ZlOwhekFOmE1Z7Y1fwzU0Svm/64RiNpKFA+rDfJA9jNlpV56f7vFK9KPEtrbh2Ed5Ce6VWh1HnQBiKCegpvShMhRpvumVc77117RXBWRlYXANPYk4Bz7+gv76Fp14q0uhS72H0srzOg5fSzeLKXhkUQXqjsdvtqpheeM9hryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85nB/3TL//nmNxWJU/bWulCLKrs8kuIcEH3IEPvJnrM=;
 b=DlaKkglJ9Yv6J3IVUp37kzcEypfv3po2vSRc5S+DfHfjfchGyRKDeJGqcQpfajU0KPo0tflFjBOrupPN9wVT9vluTsj5P/sctuwS1u4Sa5Pg4/a2GEjuLfvMUb6BjVayZdxlwwgsw2xSr7ptXhoEwx+xSrewqdJTlxz+Wuf5WQs=
Received: from CH5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610:1f0::10)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 19:59:12 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::15) by CH5PR05CA0012.outlook.office365.com
 (2603:10b6:610:1f0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 19:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 19:59:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 12:59:10 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.4.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Tue, 28 Oct 2025 14:59:04 -0500
Message-ID: <20251028195904.222814-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102058-citadel-crinkly-125f@gregkh>
References: <2025102058-citadel-crinkly-125f@gregkh>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c21201c-6a3e-436a-3301-08de165c76d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADT9yGle7EVn/6+PLtn0XzIvwZGiAtWTGbdLNvycTMmTMo5x9YgSV1LPBMj1?=
 =?us-ascii?Q?zsWOkgDeYIwcLne2ehJPIWRlPHysJfRkGbYMGs4ZQfdITd/CTTHNFSlga6/s?=
 =?us-ascii?Q?hL2raLacFSBfmreCIi+unJci14u4EsikHmG6L/zQ9STMs+Iw565O6QJWvmVz?=
 =?us-ascii?Q?Y9ImUTUs3m7P4AW/QPsb+bckkx7BXNI4SBkDFfWIWA8jBOc4j/bDi8pviln1?=
 =?us-ascii?Q?VR8LZGkRIWN0LPouyA51yjw3PfEcJZCNDvREIA1XxK/ggwNZBHkeK/kvTqeZ?=
 =?us-ascii?Q?kXlAtzM/58/eoVpk+P65qbYdgIYLYfMORj3Q7J8YZXdLniqFWBWIgyU8jl7u?=
 =?us-ascii?Q?nvUJjksYZVTBURDc49wX3OqdDe7u2UVs3nKt4h3krAOdQPS5ZaCMUSYB1ULm?=
 =?us-ascii?Q?8nzizu8MayferDEjw167lwBlJvD+1hDvLe/NNQ0fKHMIHKGuXkFfZn/NaTAa?=
 =?us-ascii?Q?7QA+FLvSJVE3EVZSXPTW1lksDQitf1zYX4T3df7kNEJXifvfi3zPTv/x6d4b?=
 =?us-ascii?Q?iRVPGfututy6atsrIfrgvwgMUFCv1f1sgLD1J9omORVZA6sV79jyo1pu13N7?=
 =?us-ascii?Q?iRhQ+WU3iT7ty6C8O2m/BlYyuwdRnOOm20pIZ3Z6J9zWVfS8suCK1KQmDME4?=
 =?us-ascii?Q?c6U+53G/HfOWVun3pmNpoiRaRErBFw9y23w0DU+tbxvVM/IV3SucfPT9jnG/?=
 =?us-ascii?Q?uxExLx/VbEI0Tpc50BmghzbcRUbYwrJJlR8xHMF4bpZPYOhGFbk7nSt2179a?=
 =?us-ascii?Q?Pmv3m/tP2dG/VJBA9xL1tU3LmyPEZ/UqgWnZfUhIBtN0nwegDOzPegrrSTrG?=
 =?us-ascii?Q?zxag5H44K96n1wdi+rkb8feosATxrfHvinErkYPtMhJ7orxjLxTiXjOXTWyr?=
 =?us-ascii?Q?tgVVRdIhd/KJc24NxnpWG6LlUobHhUQJNEKHVikE3PrI2/TKv5OouWGt0qqh?=
 =?us-ascii?Q?/qSgdoMazlKxn2wtb0GeCUC/DVibefAp65/kakvA9TFKux9CcmjefqZbGfKT?=
 =?us-ascii?Q?6jpWCOvNYxgS2umchWeK6BO05QN7lNBsr7ONw1hPS9z3MHG2GFhMb5ZpHMMg?=
 =?us-ascii?Q?i7jUnYGHbpMy+sSImz9VHiT6p8NADGeGJnp/881ypelpOp2y9ikbXSU2li/X?=
 =?us-ascii?Q?oYVCXfG1ZlLTB52ulL3oEdBndMSrm+NSYupWsz3iv8IIUA6g2j1Awz7fWuGq?=
 =?us-ascii?Q?fB5presHUHjUipGgJD7tinbx2+LM6wb5qvTFnwhNBIspY0e+WhLVPDnqzxOe?=
 =?us-ascii?Q?+sOCfizMDwu+Cj4tPZ3+gAlYg3GKoCmIUgPmO44lMg5UZ2fAkNCankaK+mrj?=
 =?us-ascii?Q?CJ0AigZqfZIIF5k9QcroQ8h49JtmklXLQW+UgX74aYR70/jwhGkAClcT7bCt?=
 =?us-ascii?Q?WcmKDi3bggA129Ouo35H3AxhsmcFQ806Vjo4lw4bGdRRi0SG2REDfgA8Me/m?=
 =?us-ascii?Q?RZn8o1LdgaIOiNU97sVMv9Vq7CplwWGSBuj0dKuGgfC8mE5Y/J86Ov+y5NeU?=
 =?us-ascii?Q?t2kpZsmzFi0BqsiY6ovZhQX5BK7QWF7QffhnsqoPfPNKzir9IdDhh2G8R1ap?=
 =?us-ascii?Q?Eik9rZJzFjQquesGE8o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 19:59:11.9150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c21201c-6a3e-436a-3301-08de165c76d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

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
[babu.moger@amd.com: Backport for v5.4 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 008bcb15fe96..85d275573af8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -225,11 +225,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr)
 
 static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
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


