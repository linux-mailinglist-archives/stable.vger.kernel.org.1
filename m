Return-Path: <stable+bounces-188130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD4BF1FC7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88DBC4F61B9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FD229B2A;
	Mon, 20 Oct 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U59VCuNz"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358D223DD0
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972664; cv=fail; b=AFghsd6VptvY/OJy0VBm8Khh2pVS6q6q9qbPBLXgCzIazyQB1vHTNL/lzdLhSvLmT5ii3tc9b2/5RRsuO6OYQZ2y8yCNdwecHlC9Wq3EkvRB7tZBpJPkKKzHTvDYzbqOT3EKTv+0fePl29xZJFzi/7wErERR7rY0PBANXQ31G68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972664; c=relaxed/simple;
	bh=NA8aYuO/01+o5m4LSk5v92bbGW6XQUzNi3SlVmhAKOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaiAsN/TR2Aw377JHB9juT7zgerl6grN2oHm+BFFksOCg1wZvlYr1N4HchFbnRCd/eAdy24QyNgj/kzr257hEP4YDnzueqzagVZ+LrwSBDjWkm/cssGHlcIRRGLyP0221A2Zlu1IB4JjQYu9jVO5K2W5S0yQCAB3uBw8/nmxDWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U59VCuNz; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8mC59xYV7ld75w4HZpKd/ELVG0RWsD+YtvEsKgiXR4yNUthiyy14lohbHsTljlceScc+aSkdgiixZygGwfRFaeZQrIIU10xgqkAbq3EtZ+qA3Nn9mo8ZrZj5cYRMjfu/fOGNkHHrmuxT35DP0ohHjLcTk2G7PYo8+3fcdkVzjq40Ohyu2yNNEDq9OPGgbAY5ebILGHjy6gBcCltZRTUv0X1VXwtpwCi7W05nQbc76pp77WtjSeTyxH5YtlGAfmjcbu6iz/ATq/Y4lATIhd+m3czdjuCY8bvqgf0SUpw9B4dEx+ibLpzu1xr2UGFeCLK73uQh+fGjdha/twN3nTA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+mj+0WwcgkYa3NIwe3LooS4H2lIb048GHjmSo2ny0g=;
 b=HIqqs6cQHFmqK8s5yAIToMhqSOm1gJUaFQLIU1IbhvLzZTct09JNuHhwNfbe/jZ8qFJkbEyRDKooMDEjTY9h2bwKONdFiVyBcGxKm/kiTFS7ZpkgE207heUnn7q5UapQZ05r70TR0L6ObatwV/Lxe7rWV7SkeC+ZaOSBzvp0twXZCbatjJMsFPeSDjMfSXO2xGNMhITnyoxMIg1B/uSfphYHSsUSV7uRk5+2/0wZP8HagMt2XKTGYR3SRgmpnk91obdhl7nR5H7bzf2Gk4Q9XtB/ou3Fwm59raZPJNXKm42koO+bvalWiTL72UUfLSQdc9nu3E0Izyaq1E29wtT8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+mj+0WwcgkYa3NIwe3LooS4H2lIb048GHjmSo2ny0g=;
 b=U59VCuNzYr77q36J2UGWYIkVXKgO+kOrN0TVELsXZ8F8B9ITDJET4RJOSn8ori8mu46cJsYbj2HPsbhRwcKKHp4Pw8OmYLkShuq3j5fDc29VbR6+D0z0FxGzEHxtigrbxzdvA9Ga6ps+e8qTKG7SiN/EVdKwjmdS6bDuIxIJp0g=
Received: from BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::15)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:04:18 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::d) by BL1P221CA0040.outlook.office365.com
 (2603:10b6:208:5b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 15:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 15:04:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:04:16 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.17.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Mon, 20 Oct 2025 10:04:05 -0500
Message-ID: <20251020150405.24259-1-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e34d0d-321d-4626-5ffc-08de0fe9f0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sPDwXqQZjxH3nKZ7LwrBXrzMzxhmOl0sRM9pt/RTlmT3iADjlma7h1DCsmWX?=
 =?us-ascii?Q?erptdSeOerN9JRDSYZOFJH+cKuy/ilhmwL2FF31rGFOkd2syy5HqKxuCsAkr?=
 =?us-ascii?Q?duTcd6SPhN/9QTnC+FpPea86prQ9c667rAyTbRepGMDh8ym1oGIunx/b1eB2?=
 =?us-ascii?Q?mJhmb2fmddi86upVIXawwL8qumrQPE7aRUBxrpNG6ocqCodlneXMeU+BXVCd?=
 =?us-ascii?Q?ncuDJ4cP/eFLyax6WGydicciaqj43iy0jSeN2bZ3mI5St0BuWvQux2NrcBe5?=
 =?us-ascii?Q?hAsCgQqzyXbNHDZvadrDPXOzY05FTIgpqfAfECtSpdQcUv9JokA5XXVKwuGC?=
 =?us-ascii?Q?96lJUs6ANCBNNoByZLxYDFczI4uWS/HQqi0dCoAIUkSdIBLkZg++50HoUseq?=
 =?us-ascii?Q?4+4Oh5sPi7kskrMR+y+LSeBoOKKQifVNcJJvzp/s+jTp8i2EjCN1XCKkeqiq?=
 =?us-ascii?Q?wkfphy8MwBc3oUC/tqkPkE+6ZskU0Ja7umhdjxxpwYyxUHmcxiFk+4iUWl4b?=
 =?us-ascii?Q?AaDsJ0hLBGdosschq7+Q7UGzjh8iwGG4SW/5VYj4YkOhh36/FJYyrpXp3amo?=
 =?us-ascii?Q?UWal0mppa8NM1qaq1xa4T5iUPcJ0QaQIbU04nMUMY7KYxUtUVweNwSSg+JZs?=
 =?us-ascii?Q?jdLYwCn1c2Ba+WBk+5/N3FLYahuAuV8X7nL7Dlt01kXr6U+UGBwcYw1Z9sv3?=
 =?us-ascii?Q?2Dm7A/CdWEW7akui4FEzl/TI6J9FyqIJS22J2U18weU/OcuDVJD4PObgl9ad?=
 =?us-ascii?Q?jkGVv6aY3kFaFfIKLwevJejUtrbbN3yzyP8XqDJAa8qT8NGu/bp/IMrR4OpE?=
 =?us-ascii?Q?HAf8icCk16gTVUjpcw8c5+HKLyUNB6HIHK0RQnY7hu0nx9FmVgXUCYZ0eMUf?=
 =?us-ascii?Q?2LkA3LiBiO7miDwpYKR+Bs2gBhY3rkvSD4gCKEwPx46Q6HOvA6n9F5gBq3Re?=
 =?us-ascii?Q?MYb+Xs/69YcAK5HNy5JqkHezrubVrfcGudJXS2UEPbFJlOzP7tnhT0C6R4lc?=
 =?us-ascii?Q?0AbCYZTs4qjCs7zp/wHbhM4BBhs2o/gHfYp+hptbtRBLj13ODU/f7vEa479D?=
 =?us-ascii?Q?jP6ak6IP4WsY8a6/fHHBUmsxk2Uh4GZvdghsuBHmrPI6b0ixYyd+WqlxwTpi?=
 =?us-ascii?Q?Mk3qnmbG13D74bPdFvIYS753zawNq1nEaYRX4bU+Fpe3jsRtItqDc5Ab0/Tf?=
 =?us-ascii?Q?ql9itjqpJ0dnMXr1cqXVcvWH8NLRHNvI2/Y+vy4RzZqEQRiOrsW9f9AmEiC2?=
 =?us-ascii?Q?0Wugsvfkwjm9WsGsLsWh9vXUnyJWNMfIEq5VpTyg4rKJUzj2gwat4l7GDW6F?=
 =?us-ascii?Q?+zSNiN38BnqZ/v2D07vp6fFy/4LNtf5TQ33l6onI7f2kczkaQZf370JkeS/e?=
 =?us-ascii?Q?ukMw90VQRGjwNCOm7HKj1BdzP9ElL5IV4c+5hwIDnNM1Q1XohYFvtF1cq8Id?=
 =?us-ascii?Q?LRpNxh21XOVjeDqulYtmB1oZR7REVtG0x/r7pUyXua27/0QYYdmLxvucTAH6?=
 =?us-ascii?Q?TqHdbxA1h1CfbNGWDa2GG+eJHMP9C8jcJ7l//EJIkavX/1jXZx2nm7QVlIdN?=
 =?us-ascii?Q?EBFXikY3T7qAawSW+ss=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:04:17.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e34d0d-321d-4626-5ffc-08de0fe9f0f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

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


