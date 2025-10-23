Return-Path: <stable+bounces-189148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583AC025C1
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7DB3A7043
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E92299A8C;
	Thu, 23 Oct 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQj3ZwRx"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A51F8724
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235971; cv=fail; b=KJMQKpDd3eoX/liaNa3fSUMF47YndfIEcoYav3Pmu1NmsmwxsMAP/tVbUf2mlGNio4xREJ03Z3Be7Y/3CDlVSXeVMtregyGuUKQ25uTkl2GwvAFAbR5fTptd/prFsWTwXnLJ05zc4+eD1SVlkS8M+rMdWpx8q3j5YvyHZwxkEzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235971; c=relaxed/simple;
	bh=aHVMBybRXEAXo+Fou5dU3ui/QvCO07VfO3qgeD9yXJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBesuye862tNgskJBSQG8Sskw6amFrziP4uvyPG8q6It4Jr4zIlRayDIC3Yne1pdkBPLSXmMGqjQjnMxw00ZK5dnhEo1+BHART6jDU2k1vqP248088j5jdpeI5y89CHzzG7Gxbzvo8uYDGJRGCTTJ5EwlT9L1Y8Hq+aVPtaRcoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQj3ZwRx; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcbLJxcldVqvwIhdP2mhp4R4UW50FhNJhezs1aeJmetMd3Pxar/pXk3b3Gm3RoQSoyimf+sdvozKiBKddUvocm9C+tWmGEkH2lz+vfo5lmMP/jvQUVxSh9HHsfPVcWiYcYXKqh/UO4Nrf08B7Pqzkk1w6gAchzJJlcbN/2S8quhWOaedFTi/QuZzWzRV7MPveWa4R1wHghGQJR5x38ZM9UIbFCb/iUAQeM/ReWS9E48NwRRbuHYuvHT5L/6jLUsSNdm500ZTlH7pKDPmaWFR2QhEs3riclE+1ewQcapr3qKxkPeX8tjZfrzPY9UpWa3QTn/orabbMwQDw6+uBj3oKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mgKBHE5r1HJdeUd2WzgzxY5hWD03dxs9j9g5ooIrS0=;
 b=F45GzJLzPELZdqkKKB8phjlG+RZKIkobr1n0pWKa5CkI6e0yxQN3T2GBWMdGtttR0s2m5w9YKuXsAdti2NsHFTUxP7W3kvYjDbX3iqLJgXR5CKR+y3GJRnDDOFZDnaLI6TY+GUDwXMvr9Y6LXymf1G0d6hjQ6IEgStVH9WpSLfpVAUDR7uEGZIAMIpEJzI/NrbPZ2ZKDZInLi5td5xQBV73RMjpoeKDxrpTiY5Mt4zkVlUlhEepOlR/QwipRwFny9hSifa2s/8xyU/TiXYh6VmUBjch/8tpyBZTaSPKtCX9uV93TScSS3eEhW4FiyMh+6OPekYaDlsDSZ4idVXHW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mgKBHE5r1HJdeUd2WzgzxY5hWD03dxs9j9g5ooIrS0=;
 b=nQj3ZwRxKlbxgPSX5062dHTt+1pwI+rCA8kUYKbirUVTbr2iBSV+TaZ5ntFPqk84LMIuKjtFynzBt2RHHNdpU4Rx2jLYaE9Fr2r94poN0wviFTgk3NLHGHDU1B6hwrTHdsuO9TeT7iVgq68zW4uPwaS7szgL/zA7HbJybQT3H9s=
Received: from CH0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:610:b2::13)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:12:47 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::86) by CH0PR13CA0038.outlook.office365.com
 (2603:10b6:610:b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.9 via Frontend Transport; Thu,
 23 Oct 2025 16:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 16:12:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 09:12:46 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.6.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Thu, 23 Oct 2025 11:12:40 -0500
Message-ID: <20251023161240.75240-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102051-foe-trunks-268f@gregkh>
References: <2025102051-foe-trunks-268f@gregkh>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: af66aa28-4651-4fa7-97bd-08de124f01f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ep9/z6XkaUBFGslFvXMdlsMIpC6v7IGcaHuEBcBu1tTsBFXlPPxgpMhmEaen?=
 =?us-ascii?Q?Ufmw4cRITEPstKWJ93W2uAez5A0azHJD8yTWEe81Ij4aAdNq6uV+nchzN9GW?=
 =?us-ascii?Q?b2oNkAQ+JOf1B67laN/sH3ei78/66cXDvR3NvK1eZGNIE9XZ33/zkNBp8x8G?=
 =?us-ascii?Q?SDDEE9dCksW7y67H8JBdQPoIA9j7/gFjWfrokRwGELKdzZt6Po+1quvZnfxM?=
 =?us-ascii?Q?X286/ir2MgfVo3TgwG6gAN/UTmhY+iEKJjP65uSI9cnTKROAYPDc82gbIFPv?=
 =?us-ascii?Q?1qfzw5gJHefQw/hJb+Vl9EaqwYIXpDqFHMGmG/oXRkF5S+GxvB/LhHW8Ogac?=
 =?us-ascii?Q?j9xvHOV8NTvsNHtwfjjUQwvA1uBIaSFEUC81HwCD1p2ZM231WlIiVCARmZyF?=
 =?us-ascii?Q?cocdq9gulEO4NTrNmx7J0lgcmanbr45309raOuBJoM1jaNIhwlG1SzMfEQNm?=
 =?us-ascii?Q?p0IKc7ki3h0eDKyKWfmtY6d7HwVIdJmTfuYhKB/ZDVTTkZpXgArkGpElDIZm?=
 =?us-ascii?Q?vOMhVUsiB8S2e0Lf0LC18siyspsx+GQBTDtUyGilfXNqB4wGfIe7KzdaKyVO?=
 =?us-ascii?Q?vpCjRJGkAbuEMyzJcrxlYAkCSEFbCrFJKUOsxrAYqKBZsSF640GBHrdqDeCf?=
 =?us-ascii?Q?RfWBfb3CtYdSrW/1Sylcc11r1V4DBs3i5tw1c7HRt/vUwOlJ/GNQB3jb8UXL?=
 =?us-ascii?Q?9Ul0k1ZRQaCHeUDBjHS8VnALBKSMgYYBXmldDPiKcHKOibEWzWMitXX2krWU?=
 =?us-ascii?Q?ifzm0AWE4D59VBDTHCmNYiO40y+fe6ZXshAB29uVcUH6ttEungVdzMY8UYv0?=
 =?us-ascii?Q?//wLpdj2Pwgs+F7Do3UckBI2gaVFTbkZ46++nFxsP4x+akROXxk3RAm6Hmlb?=
 =?us-ascii?Q?m5tKz7OxquLg1NnWovUIJ+mnWp7HuB6A9OOryaRetcXTDg3NFZY3vhF3pM8q?=
 =?us-ascii?Q?uSjfp3RpnuQmpA3NIuOi7pC0cmAnnq+4/gUQQ3KU9jbMIl9Cs+ZCHXkQVQ9e?=
 =?us-ascii?Q?3lMw3c3pE/1+IhQXppk1T39bJkCuY3rDWJOCJbYFTX9QN/Ko04B+jWZQZO19?=
 =?us-ascii?Q?q6j1WEgbmCp5p3UybG/QDQe6VSy0nZP95BsBtzXsSupB3xggZdvBjOrSd8d7?=
 =?us-ascii?Q?oYa3wRHxTpa3nwtYsRsuaPxhTxF6K7GFo+SMLs249sSYQN/teSjy4CvG4c4A?=
 =?us-ascii?Q?jvueDM6Ldm3ACaGuef4vfjXdMA+QLv4qR8qe4n1kdldbUUYtwLPZAOb5J8En?=
 =?us-ascii?Q?H464SQRXI8QQNh9O0pQlwHYvUEsIXNPPhIemEFY8aVKN1893VMJEgri4vOnM?=
 =?us-ascii?Q?5GiFZDflk4Pl3Hf4VOCYHFrVIajxUUi1gCX0RB31zWQ7y+OJmGtiw4fLuY6K?=
 =?us-ascii?Q?LvdvC4mO+XrwyoqIFdEDCnMTZr6fJbAcdLNrH0MsWnDP3HXWLkURxOg+8uKV?=
 =?us-ascii?Q?ZbZheX0e1tOA7bECMhXGUoQZBsY44ABDnKlfcfH7jjeodFfEDXAQYOwrB1tm?=
 =?us-ascii?Q?63zM8JHyXOEznteWAeiwcUYWoeFDAS5tvUQhiVINHHc0nT2F/gW2ocBKwKpp?=
 =?us-ascii?Q?FzmI0veJXun5dePGpIc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:12:47.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af66aa28-4651-4fa7-97bd-08de124f01f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

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
[babu.moger@amd.com: Fix conflict for v6.6 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3a6c069614eb..976bdf15be22 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -241,11 +241,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
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


