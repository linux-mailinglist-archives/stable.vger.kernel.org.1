Return-Path: <stable+bounces-185753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F888BDCA71
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45711422E48
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24A2FD7BC;
	Wed, 15 Oct 2025 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ABT7EKdQ"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19468302CAB;
	Wed, 15 Oct 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508270; cv=fail; b=a2WOdZ7VNP7s/t0NHCPswnJM3K8lxr49NYYG86dlk9zaNuksGS2nnEHoEbDD+yR4YzkrTvsgjzLX2p7++LQIDuitRWVcIIzZcmvhUfXG80+XQqcXAuagcB7lqawoPkXWyHlyUPnDoDJ1MzNXPyC7WfNZxqGoZzL1vfqtdb8FL9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508270; c=relaxed/simple;
	bh=yF+jrNh8qsYdSD4rwfl2HvmCvL6cY6DMOtITNUnlhYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL1a6qKlhoMms1y+aB7y9q8V05iI2bpYOszMl18BBEBIGqQYVFoGkCE1zm/y4nopa2mNaU0iJ0+gh9g0Kzr8bcv2IM5nrnrIe9B9U8FCb7f6GpAJ8FvWzXYTz7QueQ08sOYNjEUybevE4ALsO5NCPzG914MZkGaKSxSGYuSnHmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ABT7EKdQ; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/H+GYDHVLJ67QVphdGPihKqRfJwoxA5AgUhwML+CvON5P/Ywkbp5KnhpVeagXl1/QWuF+j/FsML/dqHUpqY4G5/bybifkpI5xlJf8CU0mAon51A9TZ7bWZMIcgCoqhrGcM9tzfKR/hea8E8pONvDQdocB8sQlFL/5DMOQt4EzNoffWhR/SO41qRfHEITZ0ZGRdlu6xiJd3FwyhHaX//dmIa34ye/DJ22qh3ZLLw5yMOoEgRj3XFMoJuYZonOyzfXT+RWrRbnKYAq2k+wwWDRVr62lsQrYuIX3Q7ucGDnJ3PbRCUH8wYVCi1nC8ikjCv6k6bk37iUX5VpuiYh6HBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0i7Ve+HTWX8x6nrk/4YJpexBSZZh8Q+QP1vFTi1Ooo=;
 b=RfxTm+x5ymeH7Ht32aiuD5e2bNHu0u954FiW4/krDT5uLCPkIEXTx9176ulrnt1lrvq896H9P/2TG79rdAz9uvLKD/nK2kzEBS1Oeot43zChDq+6UNeZcnLS2ui//qLbhY3dg8Ni/sOr9tKvOLm3rtJ9Lzld27k09fAdZUEpIm+k88hxkTcljaDKCBb2Ig3GfCRp7YWh7f7GOtP/nxNOkUQ/1fP3gvpkOOeNQ4N6m7xg6HgkiTOV1Zzty4s1CfdQYXGCVwrwmypdWee4HyxreSENc1/G1APOXUQE7MLwb93Xxc7ehWLquN1kwe1R/F0kps5zwv2SXpTbtAC52BUx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0i7Ve+HTWX8x6nrk/4YJpexBSZZh8Q+QP1vFTi1Ooo=;
 b=ABT7EKdQd9GI9KGRPoydKerOKMCFOIRhloYOTQgsnt39prBzgNNfyFT9pIMU0K6u1tjv+ATJCuMXE7QVSpEF4OFr3cyttoBUoqYWtv27WYmPo7qLEoo3PA5PVlJzHn0s0uaYPd4UNQ+VxEYrAqmapAg0YHWoP9QI/clELubCRic=
Received: from CH0PR03CA0389.namprd03.prod.outlook.com (2603:10b6:610:119::28)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 06:04:24 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::91) by CH0PR03CA0389.outlook.office365.com
 (2603:10b6:610:119::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 06:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 06:04:23 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 23:04:17 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>, Matt Fleming
	<matt@readmodwrite.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>, "Oleg
 Nesterov" <oleg@redhat.com>, John Stultz <jstultz@google.com>, Chris Arges
	<carges@cloudflare.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v6.12] sched/fair: Block delayed tasks on throttled hierarchy during dequeue
Date: Wed, 15 Oct 2025 06:03:59 +0000
Message-ID: <20251015060359.34722-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
References: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efce576-e6a9-4d71-813f-08de0bb0b07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EUpnTRceCZbc8fCKSq951KqhC7A7S1gglzdespAqC2K0bXCn4Hjcsy36s0ih?=
 =?us-ascii?Q?YWo1VsJZiinsNwQi1n5wNAIWrFyBL6T+M8FIZFL6FL30cSeqdMZcTXp8goGq?=
 =?us-ascii?Q?tTliCrByCC43TBVOS7DcyfFycWtTFvebEXjf85tyz+goPC7nMgALYDUHiIvF?=
 =?us-ascii?Q?CkPi0bJu3GF4fSpfqHyLxNaCqfi8GRZSEAlfGvcS2ck5WV6snyqE0w9gxXeQ?=
 =?us-ascii?Q?QC+U5eZxhuDJj8xEklxqvrhEvfV7pMBbrY+ph5XBkLFnfpF8M41cxQPbPn6l?=
 =?us-ascii?Q?/STRzo/WtZI3n7DPzDmV7YeYjAs6SG6J+1bv1OTlrMLyvFixDrc5UMwVbuun?=
 =?us-ascii?Q?ehm8IPMGExUCfHzVgSjfJ5z5ur4vKMEL5nreooreLh9+JHTUdmyA6TXgvNxD?=
 =?us-ascii?Q?SNfleKl/5b6uWPxXHsbFbBsmXY/xHGCz0guaCtePDxl49JfePKgHaIJ6Geey?=
 =?us-ascii?Q?4ei8nTXD5yio5abyVqNG/ok/ZPB1dC6f6K72rquNmQXrcPcwQckO9sJ1Uk44?=
 =?us-ascii?Q?71AyVrkTF1fBLDe/LRxwVQKqqFKDS8zCx3dgwCD7cdfDXYDH8YSnhjO2BL+M?=
 =?us-ascii?Q?aw/rY9KwslKoSRMcW9QnUsDoOlVSBhlXTDheBzG3DJKxtl0IZBqfEI3pE+ZX?=
 =?us-ascii?Q?uifUG37HzV3mYgGCKq8UnTWMzgt4V17cySoW0LJ253m+kMQuSvTND/HHFxOs?=
 =?us-ascii?Q?nBeyZpUluswu3Cnjg8QJEGfrnHXPmA7bJw3wDE4BDVt6Swe+hBAa5c3R/sXO?=
 =?us-ascii?Q?4tz3N45CvcCf3c3hjhOgwFiGVxxbStEG8D2ZCL2Gij4DBbrdqsQP01UbKgEr?=
 =?us-ascii?Q?Itkn3SaZQ0pTQI/WfItpkVTjzyzYNovfLC76TW7MfuQg79DZGw0QBqNapR4S?=
 =?us-ascii?Q?QDOymTkLXy7iXy1xcpX2mMvL4VSiqntMh1mWmN2QXUUiioFNCBl008wGU7+u?=
 =?us-ascii?Q?MtvK47gIcvnNCJ6SIpUhwQurCyD97dxmY3KEVkFCymfUBwHPCDXth8B+vm/y?=
 =?us-ascii?Q?m2/cp1fwt5Y1/RfEJo1o+iFwDUK8t4NvRRnok9lJZ03rZFmLgUssGtV7+Ri2?=
 =?us-ascii?Q?P5TKLgWiEZ71KX+LAg7RZauX1uV6wa/WBWgdUbpAm/RXirdpxl3oubCc00at?=
 =?us-ascii?Q?QbTGkAaaEMTGt0uatRbU3vWB3QNikGuVoPyhBR3RfNX7v3+MTMsKOI8Y65Zo?=
 =?us-ascii?Q?9pD7CExleod6Yt2IcXFxIxR3eR8mTKLpE+z0yVkEZGtddv0aNPWT1jQWSkev?=
 =?us-ascii?Q?HRvepCgGoEvgrnfYTLDcRtMo542NmuEkq+JUnnG3POq6JGW4c/fr7vq/gwJK?=
 =?us-ascii?Q?7rwMzV6r+QfBnQX8iErsULPoNlpeG9yejTd8qDp+uwlVHuQj7RHr5myzko8N?=
 =?us-ascii?Q?OZ8JvRm5KIWvtwUbfjEC+UdYcKVk4TlhRzmkg5Jtme+ojHKAkUXkaCJXMnfI?=
 =?us-ascii?Q?rb7WPJ0WO5YjRB4/faYTpfzQADFb7fBho3uZaDe1W14pWn9/PFtm3ufrq5xx?=
 =?us-ascii?Q?2QmtV0xgbXccVgy6FZvj+PglMNCulHO9HlrfEKPtM/s81B5gfuIBrjbNzupM?=
 =?us-ascii?Q?jicQzfPAH4T+79vZYkA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 06:04:23.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efce576-e6a9-4d71-813f-08de0bb0b07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

Dequeuing a fair task on a throttled hierarchy returns early on
encountering a throttled cfs_rq since the throttle path has already
dequeued the hierarchy above and has adjusted the h_nr_* accounting till
the root cfs_rq.

dequeue_entities() crucially misses calling __block_task() for delayed
tasks being dequeued on the throttled hierarchies, but this was mostly
harmless until commit b7ca5743a260 ("sched/core: Tweak
wait_task_inactive() to force dequeue sched_delayed tasks") since all
existing cases would re-enqueue the task if task_on_rq_queued() returned
true and the task would eventually be blocked at pick after the
hierarchy was unthrottled.

wait_task_inactive() is special as it expects the delayed task on
throttled hierarchy to reach the blocked state on dequeue but since
__block_task() is never called, task_on_rq_queued() continues to return
true. Furthermore, since the task is now off the hierarchy, the pick
never reaches it to fully block the task even after unthrottle leading
to wait_task_inactive() looping endlessly.

Remedy this by calling __block_task() if a delayed task is being
dequeued on a throttled hierarchy.

This fix is only required for stabled kernels implementing delay dequeue
(>= v6.12) before v6.18 since upstream commit e1fad12dcb66 ("sched/fair:
Switch to task based throttle model") indirectly fixes this by removing
the early return conditions in dequeue_entities() as part of the per-task
throttle feature.

Cc: stable@vger.kernel.org
Reported-by: Matt Fleming <matt@readmodwrite.com>
Closes: https://lore.kernel.org/all/20250925133310.1843863-1-matt@readmodwrite.com/
Fixes: b7ca5743a260 ("sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks")
Tested-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Greg, Sasha,

This fix cleanly applies on top of v6.16.y and v6.17.y stable kernels
too when cherry-picked from v6.12.y branch (or with 'git am -3'). Let me
know if you would like me to send a seperate patch for each.

As mentioned above, the upstream fixes this as a part of larger feature
and we would only like these bits backported. If there are any future
conflicts in this area during backporting, I would be more than happy to
help out resolve them.
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af61769b1d50..b3d9826e25b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7187,6 +7187,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
+	int ret = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -7218,7 +7219,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -7261,7 +7262,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7273,6 +7274,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	ret = 1;
+out:
 	if (p && task_delayed) {
 		SCHED_WARN_ON(!task_sleep);
 		SCHED_WARN_ON(p->on_rq != 1);
@@ -7288,7 +7291,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return ret;
 }
 
 /*
-- 
2.34.1


