Return-Path: <stable+bounces-191534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD03C1676E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA01334E276
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420D34DB49;
	Tue, 28 Oct 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHc/5Ub/"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500934A776
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675927; cv=fail; b=eQucrZuWvha6ZKO9jntxFnuSzfoPvivTIIPK1ycbPWVPAYp4CBkWzBgY3qLmTZ/+Yzla6MlxImEOp0VLLCRqoQuF9znvsleH3fTktOqrH39tL6a7BieWAphEimkcvkKX88MoZghKzV/WYDAZGOPh6cf9f70pnD4tQ7RiP5zR6T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675927; c=relaxed/simple;
	bh=+xKzP5Cg15mKOjA7vWFHihp0Nkem+1mOnrC3wwT2c4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyqVTao46a9wurNJlGARfIeQcNaqzNVf3YECvyOIOHxmlTPxQdWdzgYhcvx9FN1zwqQYk6C6Z33vTpoBvzsIiyu22k0FajkTT5PjgSqmEGqHHLJlnaWYoJRD0/WGmtGGldpwZt3RNjCTrl5lh7Q2kT2NwEqt1nbzkPFt6PJs5xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHc/5Ub/; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcKOnXqIaVfUfdIFSBxhEfOI52BgTEl4Hh/b2kiDMX74fyb7zMmTumWCClIcaKTrBIdkaydT9ePerEwEohYzqesHpwNMxe1OOOcsl8M7KPVeQylWQUs1oqxbYtH9U+SUPnoNxD2Xpg4qxl2NLPEjtmE76HYkkd2OebqRn6fayDV8R0mqtsxDAV+n5eXXcLJ/b5tdt0FukYFXqS80BoSPC5oLvyqRsa0tYBGFYx5Obu+vqd7M+YHxaruTcXF87jLay30L22oozuhbkJXZK3v6MHpLuNz5KxmCquDRJG+rHk8GA6m2cZDoO+YWHdzu6YPFzMjf5lg3AJS5PfNX5IKEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82sYNEp3w5mfaarhnWghSrBJnGDaT0trVrAM1l3jsto=;
 b=HXA+EF+S9Io7EzfxGDd8oG79QYe8BLi/ghtvQUr1SIMQZX7LKjQJXF641kYmTIHbv5B7AQBILPCJ/Fs6IHdCessJUlvahK9VP7er6Bto77qVmxja2fETQl4T7wCTVF5uMWVzbdwKPsbZlQ7i2ftFa9R836fTlmSfdBl8JwqX8ajPiMhSkAYIdWOU2v0RCBeemuU99gP3G6wQnVY9xBflSz16FGElnkGJWdP5Fc9LJq1A7fZ4Kq+Vw88U3puK82s4Dt7aUbCFubWWzJZGYE3RXfgGUI92ByVv3wXhPZKm0sMKH3ll5P/WfWE3bu10YbuJC2KmKK7JaCEBnDdLkIMGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82sYNEp3w5mfaarhnWghSrBJnGDaT0trVrAM1l3jsto=;
 b=aHc/5Ub/ZGwyfIlhqJJm+Yvp7/j9KE2Ywg+X0KXaZqjSx55rVueMEozi0RuKPOC4EzvAZGW5gxIT0j3zxWNFvQsTO9t98vpeafDRcmHlvgWqb8hl6psfaKSPbWPs7NsNFq/YQfda+lbzZZ4AJ6bfwBIvcQci2J+rDfPVpMyrwkc=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:25:21 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::a1) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 18:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 18:25:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 11:25:20 -0700
From: Babu Moger <babu.moger@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.10.y] x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID
Date: Tue, 28 Oct 2025 13:25:14 -0500
Message-ID: <20251028182514.210574-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102056-qualify-unopposed-be08@gregkh>
References: <2025102056-qualify-unopposed-be08@gregkh>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: c90ec6a8-d729-4e56-80f6-08de164f5a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1psg6vrLQSiLbH0Dzmj9ikqPQAWnjS8OOkHDh/319WM5BiZensD1utjhebTZ?=
 =?us-ascii?Q?iqdYjunG3+W6uowciR60i4gE8TJcpeMnb4mEfthRIbFbP/F+cQMd+DvWj15R?=
 =?us-ascii?Q?WXoRE8HTboZ6wIJoA91mG3xH6vfvwAzJiweXfm3kRa8Xx24vgVJ6oXSqaULt?=
 =?us-ascii?Q?3/BVcz+yaSGGt31CaI51Ffnn6tEYlwDZK1W1tXFPdYegmk5OO99dHlqOKRef?=
 =?us-ascii?Q?iebQE4R3WmhUDrAf0HuCLSa370lkkmgQLc1KSMd8brCfvI9evnopcn7LVT9m?=
 =?us-ascii?Q?admQxQoe4tigiJWXo2ms/WM0wmtBd+2gQAb2ANZ5Ri3VxJu3yFy30rYqQP+h?=
 =?us-ascii?Q?E36He0zFOKIy3Tz5AYBdpOEeIKRrwQKdPn7lZZAb8AZUjts2GrKEUwKaTx87?=
 =?us-ascii?Q?2wwFllHYqXyGdpuI69F3ewKpRzaWjGys/umwBS1EQIXQaO47UwppQl4AHzVN?=
 =?us-ascii?Q?WTdjCmvi4kjS0ihbFxC4CpctCtPwjzkzJhHdnxVnVCp7yOFJRDlQrDhHYgRH?=
 =?us-ascii?Q?cdKmMIFRdrTsmIrkfwYNjISdj/qO/4MIESR6pRJl94Bjon2XMwzLxdPFdiLi?=
 =?us-ascii?Q?Ys+/6g5PV2QaIV5DL1Zalxn7jxJ7+ymn0o3Nx2BRY0V4Up2Vpes4fLv1eB/a?=
 =?us-ascii?Q?NO/Gp/uPpHI7Vnhzfni3+GSbEu8qjXbSfuGowVf5OxkJtojb6LYRtRNJerOP?=
 =?us-ascii?Q?YdcklGPbiUFc5Lq85+IvXlSuroFSiVBTrbRXCPhXIsK3nox+tfFYMa9IkOGL?=
 =?us-ascii?Q?FF2mMC2lTCORpLhGRyti/PC0SaWltiGam/brkprrWC3ptI0L4OkfHw6D8Ri2?=
 =?us-ascii?Q?JsE0N77vm3mllrfOCkp9jdxrrW9rsrFc2gHJcHLEmYLjqKkozUFJppzuwHR3?=
 =?us-ascii?Q?whG4fL2D+gQI9f1Y+mHpHerGSqycw5FW1odWYVEH9wiDS3jWMHvAGUTU4ppA?=
 =?us-ascii?Q?Md021sSkL4HTnURvEn1PXOOAJZKfZBfHcuP/Ft7qp82jS+yrV61R2QErhUvw?=
 =?us-ascii?Q?qIoXiQ2lsUERm+CNPDnrKoWe4hn3xdycjVIsTRX5CVqvnn5inrWGpwrTAcep?=
 =?us-ascii?Q?i+mF6tnrdmQAKYS96PiNIZxjfTC2doZp7oHKDWDP3qmTCBSxQwwhvlDhEGJV?=
 =?us-ascii?Q?NjSR6GVcFV2mgDcudFuQcNhJ/c/6a3HolMnfvPoWLqL5vcFkRgdFF6Yw3LRW?=
 =?us-ascii?Q?OlGuYAYSQDHZyb+Phsk2+qiZrGMRPXZp8/Qz9L0KPeuLrbsmS3m+iwBS/+Cq?=
 =?us-ascii?Q?BunDNirBElwSfEp2DpGtxVoQLOluPLaAUaITNE4W822gjnK0VHoIO8FHDfFt?=
 =?us-ascii?Q?hMtTmP3e6ehbFWUksvRxgZh6Si4yvVxdXreMad+lm51l+7jIJX7O54ZFWC5i?=
 =?us-ascii?Q?QGJHabfaxUQZtrHw4DeSMy2hHWb2QgSAC5PbfpydKAnnW6RuGcKe7hvU2gMw?=
 =?us-ascii?Q?ZP9OIA6/n/iExaYuS2XuCckfryf0Tc4c0RXud5eblbHlvEY5EJyNf7h/r4zb?=
 =?us-ascii?Q?4ckBYcW9LFcg6J0c4gQtDoVh7TX3oQvKpMPIpQuleQfM1+iwaY7LgIrRItPU?=
 =?us-ascii?Q?kliMDZeW1wdYzHfwUpw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:25:21.0080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90ec6a8-d729-4e56-80f6-08de164f5a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

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
[babu.moger@amd.com: Needed backport for v5.10 stable]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 576f16a505e3..dd7aec026688 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -224,11 +224,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 
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


