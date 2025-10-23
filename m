Return-Path: <stable+bounces-189053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17EBFF0E8
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 06:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232A43A7A81
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAA2472A6;
	Thu, 23 Oct 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U7l97oNF"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817D2222C0;
	Thu, 23 Oct 2025 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761192269; cv=fail; b=tb70tJ7pvlnF1aCpXBaDmDQSbO5uAfdgAl19ZeZh5fj2xPbfeEgQ9l6gbY8IRA7tXnns/EDcmwuwfV813SA1ZmHSceOs8Dh2eLAyS7N0wOPFv4hJT9zP016SyiOOXAj9Nmno8tCOjcMOQMwK95nq+LAnkxwhOjHc2Mv4k/pRu8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761192269; c=relaxed/simple;
	bh=l+ErySWbEK6ke2Gefw/Bfddm0nEMrAUxpGMlgMWFMEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY//i89V/zKNfAic68ZXt4BxNBm/dJEuo0MRMhlR8M6rkRoXrfdkpc96CG1rIw993YJuU+cImeMY7zFQhBW29qznHqJ73746W1HyYtNVelkD4tCxo2829W7APiDuA+FzszbTnhGHDOmrXQeTD6GxtuvWaQz8FGYKuADnSoOSAWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U7l97oNF; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMymxcNyI0tId8udSj5zzIwxsWQSbvgK1Z1zLOIbx71/kNs7tbXHK6OHawUkdERK6SgLT/Vug7svg/8i8YtNfcIC7cyktPRBjl+KTdgePXuaawU2lSUoG/Fy3DrZh6NlHuw+enjO7PjRjCDt+BV7E67JO0XB9TTLCbdOIE0gZOnehJf6ff63AAdds+3uc8oxQG9Orvq8MTIm1sLH677oMT6Xw4hm4yjiaqBcyQUJWqMtP2BK4XHDKKVSH3IigL4cCPzYMsiNgq2JbPiRIg2dYMkrIZKEwUUZcw8VSp9LkYGWARgVz3agxQteiHx0NPEVaR6uKTL1HkNQd8XeRAEAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY2l+lOUNDjlNb73tP4+8WaqW9YymWX9lwcrnq0qYWo=;
 b=xpQKNwpy/hSDPy29yt8BccEXiathb1JB2oTeS8puhiZUUmIaPbd443AewtHFIgq3dnNSMYcr3dYQPTCZGi1nvhkLIihapQoi12EjJKaX6KgVXIoeenOPiMbxHD0CzgC8wCh8HTUSMzlzxDUj7ECVmRj7OeX7GVHWVCZBXT6rJxGLSaL9e420emWVKhYJyGcJKJUcg2C3Vesv55i3MCCu2MemttSKgAeBEM3UOC58R96Pi9TiR49gdOfdo8BbsgOCX2A0+t5xZEihVDXqrHWJy/t1DYBPWkEOlu9uNJRvjMbS/Aukfw2o8ekYUJLeb2QTogYINQ7li7J9Aixo/PQfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY2l+lOUNDjlNb73tP4+8WaqW9YymWX9lwcrnq0qYWo=;
 b=U7l97oNFkgz2ilk1Hu2TEKGuu0IgcwlUjn+kNRHkq8zvbW8YVN6bCsr4ly1DieDg6FmZ3mft4eGl6dx9SRJmDq7+LM1xQcEEmsKSsitYMp4S66LvuNMHugCSL3rNbCtLDY/bCF4zI5SyUj6zeH7ceak6ylKOAPKfusaJTecL1bY=
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 04:04:23 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ce) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 04:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 04:04:21 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 21:04:15 -0700
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
	<carges@cloudflare.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH 6.17] sched/fair: Block delayed tasks on throttled hierarchy during dequeue
Date: Thu, 23 Oct 2025 04:03:59 +0000
Message-ID: <20251023040359.39021-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: fce6b99c-1c2f-4c85-2241-08de11e93f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wd8UqThP8S8vvgExHA0gJaVuMEX2RyE/i8yJsi4xmY/7yMnJJy/baB+ZttD?=
 =?us-ascii?Q?1xR4nuOIrj2wLZJTnTisBFi6arV5Wclm0p8gby0BfoBRi/RxnmQmSqSAFYzE?=
 =?us-ascii?Q?7ZeSsfIWzHGOaKUyRFurXtjg1/8M5Jmfom/So7S/ZoLQA3Nh+YIOJD5/v0aU?=
 =?us-ascii?Q?diJV85JhnaQkSEfEnNXZ2hguXB6If7hAk6XpQnAlNkTmPT38hDA7yR+fd58u?=
 =?us-ascii?Q?kGnnfaoXBhI4a9EGS5KCjk4osl4lOD1ON62GSDOgVP/SFqZsiWzTv87lKyMW?=
 =?us-ascii?Q?lFPP6H00iK/lBLomgNSnY7I5V3/fLYKB4CjEVwCWqRJpY+et/VBmKarASqYw?=
 =?us-ascii?Q?iM7zIy07opXq7pC+zVCAmW7wgqe5YWaR8Hh2rgGLTqCjyPfr2HIf/ZJ8RvAN?=
 =?us-ascii?Q?sraFiJs5uSglbtpn/AQuji0vK0eLBSdsHPF52iisd0XhFpfTbVZSLXgZLxmB?=
 =?us-ascii?Q?7WgHU9ZpPjZYCzmRpBpZhEp/nqtpqDnoCxi+6VOReEdtzIHG8Ph7XVQXNATL?=
 =?us-ascii?Q?AZPYKFob0qkajZi8mqZnkAltR4t6rdD7+ROZfxiMzi/x5b1DObEtzN17Gi7N?=
 =?us-ascii?Q?0vIwetT6pCm4+u7sbuWKCv/EHlIxqGJl6qPdS/vIuISt5cXbXQM+Ayg7cEy6?=
 =?us-ascii?Q?QaOhA09TROXWAe8aw4dvnmabzVFK2Whj5xE44BmcZKCs+miI8Oq5oINJ+zuY?=
 =?us-ascii?Q?NT0eov+tsPPw1lTIyNlHvXl4/37U3M6v12znQhF1EL4iU6hMyakXkhBrcPWA?=
 =?us-ascii?Q?wSyWOy8LUHoXcuH8rPMTM919x5qJPANlqQZCZ/ozwqKMaFEVEH6yobPK3gO+?=
 =?us-ascii?Q?vV/DQqXCRfCqaRwy872bTZ/mY54oJenYJzb2stTq/OsiHVIfnGftjMbCtMS4?=
 =?us-ascii?Q?OVzO0h4JSB4x2l9JgkoNZlyWyq9daz9iZCVvnN/vFZplaXc8/7KXsalOnXR0?=
 =?us-ascii?Q?mp67/HJmEJaptLGb5ZwnNYSNUS7BfCLRqg+Pl3XDXHm9qeRY6G3L69b4AqpV?=
 =?us-ascii?Q?KR9IvMoYv8dfA73Zaaxcrpf84/KQ/i0LbbJq7Egqvxp89lGo5Sq4NMAoPdjD?=
 =?us-ascii?Q?u6QAyfawoDn1Y1cbFKeIJtKqldH8uCThEL+0O3Vt1qFNxJ/Kr56Zq3AeeRub?=
 =?us-ascii?Q?p97tQPFwMCddMCqkS/WmiaYYBy0oWZ3GAWvfVQpOnknjSHWGqGzQ9sHo0EdX?=
 =?us-ascii?Q?G49QHfCDiVORpb5xvq52KwTsMHL3/XWGavt5ZT46hdT2w29c28iB5/uAbFlq?=
 =?us-ascii?Q?Yghx/GdKWtdENlJl1VYoAF+x1ST3I5/TXkUElLG2u3B/xvme36E+aJQrB6cO?=
 =?us-ascii?Q?0lGLYMhVhVl/iSzvxj6FvUyIOdEHyUfhbAc7GXUnDEK1sEi7E1O/5Jud29Su?=
 =?us-ascii?Q?baivUDGMB8dGyE4aLoTxQtpspvsHdngg7Tx559cCCKFUK1prD/gErJ/CsFR+?=
 =?us-ascii?Q?6/BH2UueG0ctFkaSR0cugg74XeIS4QSaOkdmoIywrAc9mS4jFbrW08MVljMg?=
 =?us-ascii?Q?MsueN2Z5NMNGcU7QeOex8/cMK1zbyok+GsJkhfxe5gzn8Y1uZhrSmiFxyAEL?=
 =?us-ascii?Q?oJnC9BcnRSAYn+0WiPxWFgK/ONmycMGgSDct2jw2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 04:04:21.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce6b99c-1c2f-4c85-2241-08de11e93f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

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
Hello Greg, Sasha,

Please consider the same fix for the v6.17 stable kernel too since there
is a report of a similar issue on v6.17.1 based RT kernel at
https://lore.kernel.org/lkml/aPN7XBJbGhdWJDb2@uudg.org/ and Luis
confirmed that this fix solves the issue for him in
https://lore.kernel.org/lkml/aPgm6KvDx5Os2oJS@uudg.org/
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce56a8d507f..f0a4d9d7424d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6969,6 +6969,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
+	int ret = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -6998,7 +6999,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -7039,7 +7040,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7048,6 +7049,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	ret = 1;
+out:
 	if (p && task_delayed) {
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq != 1);
@@ -7063,7 +7066,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return ret;
 }
 
 /*

base-commit: 6c7871823908a4330e145d635371582f76ce1407
-- 
2.34.1


