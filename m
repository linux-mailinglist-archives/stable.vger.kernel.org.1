Return-Path: <stable+bounces-188190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C40BF261D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12D63A42B1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235A2773F9;
	Mon, 20 Oct 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQv+c/yP"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB81D6187
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977333; cv=fail; b=o8qCE0gsg3nfQr7q0tAemvH2Me5WmVe8G8gcpdAp1a9kJFP/6dAv/8AlR7ubX6qPPiR6FpMnRlJatn89imLePlT0uRvigcsmkyt0m3QlXUKUCDyTUN2/4HLzLnxo3RFzo/ipvT4ek4Gqr0vvZCxTrz9m2e5h5r5O+9/ZgdwTvpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977333; c=relaxed/simple;
	bh=Jz3QBLhzUagf7AhgdUvlLevSu6v8xMG6fTGXvg2GZsw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA00VRiUffSrbBOhnvcgRKcDo6JYKZXWbF598Bw5wqk3r9fN0ujFS4ET4PeglNc3lnOW2xPZZH77RyiUHqQWI+g5nOMNk67YfSsOWT86O7/9zHN6nLt8EEJsV8KkjlkhWC8Q2R5pvCbNhX6DfcIei4VgpyyZ2Qyolto1Zll0Yjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQv+c/yP; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJfndjsJ6q4IYdaF/TK5KX6AIQUiIJi1e74WTZFJ2RPhwlKyhWnDcE1SBJkeK1jkNXYaN6MbasPL7CiWiZHeJmpeYrSxaJEy8Onb+04RI9X7q2hRG8UabnRszRcZRcYyUSgd0HnLYSWf3tPV4v+Azm4zCZgq2OP4KDfLKoLeYZtiAAmcm4u6zhQ5QBeWhtKuHlBVhS7zQLR5ic5xcbAoEagxqU75oo9UjKsky+oYHRuTQVUQbc9AiC8En6oNlTiuse/Zp1/hPZpkXsOVA2Asi4QtJUIh8lwUjMTsdKSksVXj7BAMdZGjSs17WhDtjA9080C2HOciQCHTbfmm5IO8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT17VV+w4hYYomynB0RLqsCXIJkxiuhPnLqvSBAER2U=;
 b=P1awmYdlmbCt2BnK0m+X5wIZSd+gSmDTz9RoFpjXKPhDwpVJzZ/QQKyeDvU77zQsuArNwJFG8LItng0tK5a7OVBvaDqPbs841Acs5DEqrhIBPUeFpAtcrTmhhosxycxZqNFqYDq5sicDD3pfPlfpf1dtzfJPqUq0yKJuGaHiaVswEPZNUeeh23gMIu6uIIQ4E6eWrJt5es2UE4xctIBZQF2fdQTnzy8S9yHNVhs4SC18FIGjT/skfVn+0r89clNLmdhSS2OBNx7HPiLBbgaPgUrXaoMG/MgKPLPPgrzzPkjPHJ+A5qqFvwhrOxLqUl8dUlZvXDuclMySdWS1zNT65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT17VV+w4hYYomynB0RLqsCXIJkxiuhPnLqvSBAER2U=;
 b=pQv+c/yPTBNsprgz3U8DoCQjSISFuTniQuTYcjWls9o9zysTSLIkwVN0+kNq7k4c570meAETkRiZkzx3/Mee+o4Md2dnv2GViGHwrI83AR8aJ2JYhqms9nVzW2lPSClCoFwEyCH51IYZYHx06Rh0gNEUZ/4WwazzkD24qX4iPGs=
Received: from SA0PR12CA0010.namprd12.prod.outlook.com (2603:10b6:806:6f::15)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:22:08 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::38) by SA0PR12CA0010.outlook.office365.com
 (2603:10b6:806:6f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:22:07 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 09:22:04 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.17.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Mon, 20 Oct 2025 11:21:21 -0500
Message-ID: <20251020162121.43543-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102047-tissue-surplus-ff35@gregkh>
References: <2025102047-tissue-surplus-ff35@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: c69c146f-e8d2-4772-eef6-08de0ff4d0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eDF3ZY48wLtT0JBdREs7Z1g/atAdPM55LjbnElBcM285S4mlsl4F9lKfLSkJ?=
 =?us-ascii?Q?YTFiew1WRBkbUpTvcsxgaXA6/vMTaolBwCWhB2Bud/qa30/2ClffigroBLsr?=
 =?us-ascii?Q?hUJ5nSk1tQ2Fe5uJru/sGVHJH46r3PXIqEBGxNV3IFxz4DqV072cMzEYJ/ja?=
 =?us-ascii?Q?j393j4bn0ODRAdX0N1AH56yoXMiEdUT2vP36ApApe4Tf3ZfkuPhk2S3k7ky0?=
 =?us-ascii?Q?jegZOULVePJICrOeyyTb+v/mciwAVND3UiYMgHrVVXO2EtLHRnIsnOSgCjtZ?=
 =?us-ascii?Q?wWU/XFSHpUU5IQI2fFFroAMpBno0ApWuJ/W7h2hrm55aDZ27TGBQoF2polku?=
 =?us-ascii?Q?GM8JEvnzOF+0IjsJaZjvw0oL57UAwqv46KbR/xhJTANt0Qd2XGdK+1e2AZZj?=
 =?us-ascii?Q?W0ATiEvF/h7kaabfFuWSx+WWBtheBV8s5zTKSWCfrh4dA0VMapaz9q2wu5qo?=
 =?us-ascii?Q?Y9R4tioUMZPV9KvDYJf+wkThhAnFf8HvlbLJMJG8XkAz2RasDSdTqyjt4A52?=
 =?us-ascii?Q?j9/zFpoF67aFCYQ//OAqmne7GrDiUF3dBiGjdFXxRadF7CkVTBXz/vh+w8Uf?=
 =?us-ascii?Q?ixMDAPI/oN53LuBQR6J6AhgFK+0MdWspVRuSAks8U/I4iUeRN9bWXovxyjKV?=
 =?us-ascii?Q?OJCz39jn4o7tbbeonRbzlCLRULOfJWs5iHSQ2fOtE0glAP+lb+fEDalQXMuM?=
 =?us-ascii?Q?pl3bw++jxdZN5Scz6WYAkGPaAPq3lbHkC4Y+G1aqBWOu5O/G0Vlbu7CCN5yw?=
 =?us-ascii?Q?0RvD/Ax5yT4LmrZoMLKNrXb8vRIlrUmp5xLlS2F1YwxvBQ2NzCOdaRhbRJJq?=
 =?us-ascii?Q?9oIFqvuC3DYUT/S9gTXRk3R3lk41zQ4kHmpY1bw0UU/U0i4SBw8SeXU6AyKO?=
 =?us-ascii?Q?CkgNFCsotOklU5uph7vn1mLqAP5NXU9LSy1e1seO2H9b/+Vvt2csrVOAZdz3?=
 =?us-ascii?Q?LOfhuX0W+lQ6NNCHxkSQHanSNV8S37EteNEJhNlHIyy6C9S4F/u2Icea/7rs?=
 =?us-ascii?Q?9FZdSfsCnxh5zCFpaELwug1PwdCDe3oUx03IeZ8TrzEDLeY5zZQ4VSecR9eK?=
 =?us-ascii?Q?K+jPHFQXV/7PClyxJqbUMN+P7fMwaFs4y72VjsUSbT4990bOjbOk2in+Anr+?=
 =?us-ascii?Q?FqlziKx9dpVTRkcqgkyr3UikFcc+jCT8Xrctx1C61goQ+BHqGTKnvRulg1G3?=
 =?us-ascii?Q?WfOkoNJJju8dPtPmKgnq5gLnG/PWDZvpKuGVJJW2OXTXOyYAOiZHbjDbc4ts?=
 =?us-ascii?Q?1ZBV3kjDWD9hK0GKHu9fB5Ap7daIZ4FtslQB+6ASPnJKuO6PEC/BBsbrLJxr?=
 =?us-ascii?Q?SvrYln474Elk+Hh2EjATBE6W5ZZUwKosgoi9qm+CoQiOkR2pIU/eMZ+sJc0c?=
 =?us-ascii?Q?4tvhbPl1IAwoxYL2XE3yWgiCyO7fhJrLiH2e/2HxaBPjVWMdeHHWCGWGgtiE?=
 =?us-ascii?Q?LP5qBeiaMjyFGxXkeQomeVNCDLdGZxpHJtnk5y28Exxcb8h4u5HflyTx5zp2?=
 =?us-ascii?Q?Wmtyy+J7BNTyTBTgkE2spOozxRNu2aUEbpKfwUFDqnnEcsO8kLko18m75K1t?=
 =?us-ascii?Q?OfLi/S0lfQX2nIBxdXs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:22:07.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c146f-e8d2-4772-eef6-08de0ff4d0a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

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
[babu.moger@amd.com: Fix conflict for v6.17 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..8e0c28b34528 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -238,12 +238,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	resctrl_arch_rmid_read_context_check();
 
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
+	if (ret) {
+		if (am && (ret == -EINVAL))
+			am->prev_msr = 0;
 		return ret;
+	}
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
-- 
2.34.1


