Return-Path: <stable+bounces-189245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFFC07AB0
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536AA1C43EDC
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05342346E70;
	Fri, 24 Oct 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEdx0NzG"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915E33EB16
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329604; cv=fail; b=Le8s2yMGQpXaWGY43v6n+4+EnLRpn/icK04G6iacjY6ByNdwyXq+aH5yO8nawcUW14sXlX0SxABI+fv5zF0Wr7A3Zl+eOFnm7vJiHDUAODqd8d6MEDUz7iC3Ormpoz/BXqKEtcmAr2Wub2unCo9QVK8nFJyqlZpcGln+1wX2TW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329604; c=relaxed/simple;
	bh=Z1b5UjQOzZsy9gg8iluCj6ohtZ1JlLt/ErjifTX1S1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdNVUDSet7aygSZ7NdAJ19ZFjTCujiV0UbJVibgCzSW6M4kppxlkBuXyWwDMgXQCWlQHj0IwPrkdbar9mLgLYJlh0PUyS4DVIQ92UYrGnQWgcB/BaG71+KUum4EaN/XmKpZ+YyelG6BgHXkE/PCykS52T8xvMZE5V01kQBz9POM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEdx0NzG; arc=fail smtp.client-ip=52.101.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz25+N/ZvgFGjlkxao6m1I/Hc3rgYOnoP7r2vlVyf/U01gr74U+1J1xR/C1ouN+LAJpo8wy5SYRukpWVZMKS5ZU3iR2ubHtLI0xoYiJ8t6hg/35KhR67K3y91sA3rZ69QqDTYBW/w2iTni5sSwWJd9d+sTJCFC0RUHnBYY3/TiSvwx0tTdNdlnL/tVEXQHuAWEXkMucikcc1++pu8QdQv0BQUsl8rh5qASxFe739TuiNaKddXkiYeatsSzfdSOgOxNs9Ku5s2dxxwEESsOn5XytMk/KeU2cYlEHTp89EdG/8iOTsLuCaRxWQc+9nAuVq7lJESQ70lgGLvQW3CJELZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5fyPFgJz0hn0YwvVMZH3MhLv3BSAS0lnKBE95BETYk=;
 b=TJQWT/Wh0/VW1QHyA63+tnWBnc+A59Pb7wYqkj4PCeen/1Yi27/FeI4+o8jZWvn1BwtIYEcobfwwAYGPI7Rt1uuqDajA5dzZGHtVnw5J2MXBGHd7rpo7hutgb5/9O5YGL09hGN2Z5x244nCIjVId/akR6/L2UpVOvOZ3Et2bneN6qnRTGIKudfb8uCIrVHwZH+N2/VvVQ/+h5jN5C3VKKzSnoiLEBIumoZ4bHXirC3FuvWf8EM5fIbGmafcIrhK9ojnLPnKMJosKshrsbCX4EuVB3PpB/+qdSMH8Qu00O9GKTTdUA+CiVBTqmaYn27GLmb0B/pSkzpAyDtrivOhzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5fyPFgJz0hn0YwvVMZH3MhLv3BSAS0lnKBE95BETYk=;
 b=CEdx0NzG3fUTTjvhxuSSsyiNPZWW728ZqAkbXy/96q+weSF83rSCf9n9XpPyEkT1rEizzuXn46rFz4bj4L38PJiY4sSHEFccqm8HA7JyRovN9De5/wryo6yH2MVh7NNGSZXf8t8rkHUdrCju/2mhZxJBqdRkNRBUq4iX2fuJ3aY=
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:13:18 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::6c) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 18:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 18:13:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 11:13:17 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Fri, 24 Oct 2025 13:13:11 -0500
Message-ID: <20251024181311.146536-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102053-condone-sprout-77c6@gregkh>
References: <2025102053-condone-sprout-77c6@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f217c7-11a9-4bde-79ef-08de13290206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FvjHig+WdCJSTFroFj8uK7nNw+p951n+0bJQl6IUjofL4Lt9XfXZy78fcxCu?=
 =?us-ascii?Q?2sIINAAVQJDDp2AVlLXllZrraowcohIlAaZvU5LDPNE41bCDWmCcKaMvh+/1?=
 =?us-ascii?Q?1ox0P+raoy0KOkcLOPJsYMa2vUZMv9LYTX289aYz0NeFdTWhjAgshIikTZQ5?=
 =?us-ascii?Q?M5tIZiLrqwBeigpay2pljk0eLQ2S4u8AVyxNzAH5HcWQiD+fhQ8M/h93ogaI?=
 =?us-ascii?Q?eXLWHrDfZVY6v9HVhctJYWQOMZaE4HfngKfw5io5cTLFMPFHHvRgFkp8Z9Ol?=
 =?us-ascii?Q?NsCXXyqqB5hVlhNoHJkNwER6SKbkNA+x5XvA7eCWy27UBqdApe4RiwoSR7ZT?=
 =?us-ascii?Q?ZoJEDd85Iueypvk9XF2S6tYmPPuuygwZ0rQy4/XV+Vqw8vKB1fwMgquclxv4?=
 =?us-ascii?Q?kIC5hzR41p9pw/9TmyECitRIOQVpW0Bsva2iW9sThvPcvGvgR3uuipPL1vmi?=
 =?us-ascii?Q?CFI5XIoHot5kqNOk1zDxnERJidncmP1CqgbujYPKMcRh+0BwbZcmtBXqVjj3?=
 =?us-ascii?Q?vv19mYIGv0MYz/UYCH4JAVihn4ATOYAgsjbzzhNKwtD+re9XlfppBamfwsv2?=
 =?us-ascii?Q?jOqjCFY/IuLHMRlG9zt7erMLdd5zBSdJckmGq9YdZibByoDHLWm4yhRX+BVs?=
 =?us-ascii?Q?8oao9N8PZWsw/GOkiutI5lcnXpOq9H6ws0UfRj7fgexAX5ROX+F91pUeHy7N?=
 =?us-ascii?Q?n0Qu6yHSF9jIUaiG4StWb5vmhmRGobw5rlBNyQaOvCATT+Jsw3dJUpbMQn5s?=
 =?us-ascii?Q?d0RXyw8Eq1MSh0qd+EgzLC/QaVlfZDaPmWX8UhLxWGamnkC9EqDW+5Yj5vHj?=
 =?us-ascii?Q?SkEhgA2FKonqBjU1nFzPzvzEXhOQgpafEKdbkSCI+UytsZLmn5ee1tjxPaVu?=
 =?us-ascii?Q?Dr6T7fOBLb8WaRtoVHjSSfB1r627ywuJw/xG7ugxUAZay6YwEBYC5livgQJm?=
 =?us-ascii?Q?RytlwrwjbWAFx+gS+CcpnGoamKCf0oxT8RXIbtlo3l417F6DiXnfH9fhgoDN?=
 =?us-ascii?Q?2E7jRoVp/xhK8vj99tOkNxPb9KNAD9jKKVZj+e7o/UbhcaN29TLwT/FbUb7V?=
 =?us-ascii?Q?HhsBN17yu8Knb8vtr38btnkXOl3hThAbox7mwy6nG1R48prQw7doCq0jLPI1?=
 =?us-ascii?Q?bXihQlMqJCH2/tSJ+MGxRYfAY5SLdKnWsz/a1pp2j/q7XUd7lhxVlaG3Oahy?=
 =?us-ascii?Q?I5fwLhX1gyPSF180bmQvmBiCeDI4fRxL2U3FaIpNtY0nyPiNhEwN/gZzh3k+?=
 =?us-ascii?Q?NBQ+eqG1L4A3Cp+PI4Cl7FbuPXFEr8k62OYzxqegvDYfnO4/XtRR8l0ocvHA?=
 =?us-ascii?Q?pHssG5XUQnPxvPAX2XNkGJRVvIPgohEcu4q0k5FzCqGNNY5nPtvh02iJ4XK6?=
 =?us-ascii?Q?vT8J7J32gad9r9dbZPQ2ip863hJkoXntsU7Xzl5pf3KlpSakYH9UDeMKkMsG?=
 =?us-ascii?Q?nisuscHWibRZAewmWcxsyWsskXFe7RKdVf7d03bnvtuGg5/JrppMY1CfdOqV?=
 =?us-ascii?Q?XESEgiJda8MF4cl45w96yZXJ4WKt4JmQOQ4V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:13:18.1146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f217c7-11a9-4bde-79ef-08de13290206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

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
[babu.moger@amd.com: Fix conflict for v6.1 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b9adb707750c..19a27a0f2a93 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -224,11 +224,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+
 	ret = __rmid_read(rmid, eventid, &msr_val);
-	if (ret)
+	if (ret) {
+		if (am && ret == -EINVAL)
+			am->prev_msr = 0;
 		return ret;
+	}
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
-- 
2.34.1


