Return-Path: <stable+bounces-121124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E488A53F9F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4403AE863
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56178F35;
	Thu,  6 Mar 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEzSLfbH"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F62487BF;
	Thu,  6 Mar 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223433; cv=fail; b=uaf6nia6ETvXtzta+Wep7tAHV1OJCtXy9U74jSqEWKYxepU4x8DyqPLbiy62rvrKwqpkKA9sLT82EeZr3hiP2f2Dxdl7plb7wJ+ZmT8K/97EGuYmxwA0etcQug2bJiIpYHgEO6DkFzE1WUjdjo5HpRYvKKkcadO4SPl31VrXLXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223433; c=relaxed/simple;
	bh=WtKrDnpPVhjv3a0BddHDc6dy+pY195ftIWqeXwj7HtA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cs8ywBxLPosNdx6paoiJRYYJ3qpCgklJaIQno8fw+tkBUjWySIG/e+3mY14Z1S8F6yIQx1qbEOtFB9XHo3YSocI8Ztr3wgMQEgCGYkCMD3R5s3lxUBWS4Abzcc4M6mhmFiG5YPSrvJ8/7Kk+XEHNJj9Nx9lnQEHifURMqUWamrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEzSLfbH; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f49xz+5U3pDBNOKq1Li/YgElP+EwHodNw8kJhKSGbIHF4Ltxe8yVJERTDRE7IfV+tB1LDYy5EZLaDqyR2T5WSWz2RI6dY3B4WcSZSi+JmeyRjXDWhVtg0GXygD2IA/G79XFCBzKcm9RkJvjHmVweqtxhCO9v5WuBjaQU+Wikb5XxqVvQXOqZv4uxbURRJnl2nOaphSHP6FrQBCyNLt/F27YkQDqPO59mxW5HieT28reqdddeHvlqXcaoV+iIIqCiVANeTqu/r7fD4uU4yBr27HJTOW3BAFDdxuavpVrHo37ffaKQspsqIbwBnyGn37Y7PrxxWh8l4hejOpUlSMoD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FElhXFq0IZOgXCujhfjnBdifyWph5hVKBsNNWKUP1Ec=;
 b=UrNkNRtTL4MPByYtpyXFbHHF0xtignqjEUqSeO9Q+JznBFjLrXNhI62YQ8UoWeY0DEP0W4ZSmihzJ6q7A3M6S1Fkf6znPijSTHTQyTXoFZqL1LZ21emYr5qQY0FsdpXaq8sQ/7NKmXHw/tPK57IEJJwqRAdGsQwEZTmtJTMM2REqKmynU7bPDJucoBOab39mE6A2XU/+oBGX5CQOjrPVXsgrfkz/oy7n4u3SXcMTgJFh6EaWSxBxFWoQNNlNUqB3FyKL7dNBBeTiOgJy8cKAAuFLkcRXRwJFRXCi8lMX6eO/OrYBynya5GRHeGiMZgDsEKAdRMx/SiFyEhBkwKw7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FElhXFq0IZOgXCujhfjnBdifyWph5hVKBsNNWKUP1Ec=;
 b=VEzSLfbH6VQzFHWO6eMc+SE1W9HpQSNer5SqAJhTew61KNAbQSF2h9cYb77gsXRE0VxbMuyDQ2LIDtpy4h0JFOl9xASE8Az0bdHI8EK2TrvOD4c4MdIx/hAiQwktyWrr3bvNmgA1lfOQip/alJZMjDrRFZswTKa6hOfCF8E3n9x0qi2Z3Rf8DKALbtLqsuVxTjNYVkVu9b+Yb4Bqmu4YHKulHjGQ/eZX/SDclao/jlZnyJ32rxcyYnKfuFkXtkhPGlJ0hajgPRSgGyGBjcenprY0BnfO5+qbLd0c/SvOktDQ32aOKpFDIpCqa5vmW5uvmC6iS8iZUzwgr9XyizFaUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 6 Mar
 2025 01:10:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 01:10:29 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	stable@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Disable DL server on rcu_torture_disable_rt_throttle()
Date: Wed,  5 Mar 2025 20:10:13 -0500
Message-ID: <20250306011014.2926917-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 84aecd7b-4ffe-48be-0e2e-08dd5c4baf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URTk5CeCnl+lmroktCUvki9SqQw0/wj2pNc141EKBGOPaRsYkyTz0xik3CA7?=
 =?us-ascii?Q?h+Rpebq85fopV3LFNawn9tyHybNGx9gOizj4q+usNiv81X8QqSpuHhevS6kX?=
 =?us-ascii?Q?zrcfdUYlyFxI7fz8BkAVCLRI4y9PNucWi8Q95RlsZKhNHBVInphkqWX39iAN?=
 =?us-ascii?Q?QdDpYCVVhHe6kJg1OEzub1dYpi1TLZg9JWJamVWcV07KiK5Vnm7k77rkkjpd?=
 =?us-ascii?Q?K6CzcZH/h0V6SEgIJ1FzLig15DXUNwpCeTlFXtCSjqIPelq8Y3NHyLE7zeQ9?=
 =?us-ascii?Q?wYT9UcFX4/+RhdmP5nYfj8xLlbMN1cbNLSGdDNZAhDHhSrzbzuJH3tvXtuIN?=
 =?us-ascii?Q?d8htkiNUo4DbBrfJwntWjycCMd8aeqUGOOn04fs0y0YoJh57Llo93TZwoH2N?=
 =?us-ascii?Q?24JgYtX1lKQJatb0chCHccTqKb1KTSilSLnCYuAIdeY02m0wgRNU/Lo5eS6g?=
 =?us-ascii?Q?FyQ9Cb4Xk6plG1SVWKJA4gDeAqAw/XeQt8Sg/zy0rVp6WvhsX9grAnGa/fCx?=
 =?us-ascii?Q?vAZhcD9mrkAbFsqFsao2a3MnOLt59AFHxedbmnrkXFw4tHwuy9zEoWRmUtuL?=
 =?us-ascii?Q?LIheXy0/LKkRg2TO10U5f9Bl2HB4nCgLmfeeS13BTTL6pEn0bY1QyDBG4pep?=
 =?us-ascii?Q?gJBaoOKZ2/YCbgrHpPae4Qmu0zVg+DwOPw4eZm1DwN/ecRojB2pjAg08Qf3e?=
 =?us-ascii?Q?C4UPBNVsQkcI4tvDcTF7j1En5wvSSU4OZpeJiu3SlZpugc3fbZaiskDrpkNH?=
 =?us-ascii?Q?7LcNRvZKlc9YjDp2sqAzCZ8w+E3Kd2UJKGXM4T7huNSsSIyOCiTN9JbQpjls?=
 =?us-ascii?Q?Kj1F2YSTFHTX6Lbp7cq4IeguZggJ2nfv0Z0MWI/JT7Ypb0zFv964qrXE4l1f?=
 =?us-ascii?Q?VDG+Tdm+9YSiO7V+ZCB0FufuGpiZjBHwAQNhOJ9skJ0cOKkm9/uQkKqCD9ba?=
 =?us-ascii?Q?k/D4gJ8Hpmn+3n6y0duQrxisFonBg40Iw6hThzi9of6AgimEisYeb63x/oSu?=
 =?us-ascii?Q?g6BvYOBeaUnYsUAkEgV6LXfPRLmgtMhDo5Wws7JUtsq5tcU/DzXkqHsHttR8?=
 =?us-ascii?Q?IdNFnvSCP1UwPzf/duEmrNggarjW73gVFeGYpl69AwbiYRzGirzrkd4v/KYB?=
 =?us-ascii?Q?omPBiiCE33P6szf1bamMAyd8lFHCujSw2U3bMgcffNUylDX+sutBnyC70v3P?=
 =?us-ascii?Q?fYK8l8ycYBqhXZHqhwymBsY6Nc69HqlXgriP/Zd1REwjIjOe9m0tBQHUSrA4?=
 =?us-ascii?Q?Ky5GZr2BSAcR8C8uNGSY2RROM+zKafr1ORgWGlZDKQuHYLMfPCHeiFSx39Bd?=
 =?us-ascii?Q?KbQ0Vy9Ldd/hQVHp7tu6Vl5N5WXHemzoZuaXbSLM8sU0dC/sosC6CGio8qQe?=
 =?us-ascii?Q?p1PbbzGNZnoVViHzn1Z44uswtscF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TuwcsYyUVaZV6qBK+ycMnuyYrCvyvb+omaqZKKikGk5knkrG3TjPJYkFK6Fj?=
 =?us-ascii?Q?uJjWVy2dgXCnjSMWdkjT/w9XfQzTO9eykdR/US/kjatgQYgO6NlMtqFKfRjO?=
 =?us-ascii?Q?bp7JOflBf6JedcWM1Psju799jKeVryeHfW+6bGBQRyCxybmbZNORGMuNHI4u?=
 =?us-ascii?Q?7OUT40pMcfap+82Ya4BuefpIarSxJvC5OnIA4VCfQZjNZ1Xi4bwj9GVTTt6u?=
 =?us-ascii?Q?rSVz/emR9pL4+jweYE+CPNbOKVs4VJQBrkPjQ40ngU2i2dEO9c8HyNEna11m?=
 =?us-ascii?Q?y5dX1DAUmQZXTaPHXTVbViA7WofXMyugfTupTVn87jN3WPe4D4UCCzRSaiBR?=
 =?us-ascii?Q?Lc4zrYpELQ1PC48dXoEogwAeTwc16CSzhcuGOT70ZFzM6zIzmPHgHSVkZcFZ?=
 =?us-ascii?Q?poyzO7n3rcMOYtjcuwE5IUNCgfx9cwE9SnEy9qKO06PqkUlJ7NfUud3hry5o?=
 =?us-ascii?Q?f+w34UdQPgHi4eU5NkH1/Gk6Zo2DLh/jH6IcKtWRQy9NgSPnOulzwqNtKE3r?=
 =?us-ascii?Q?nyxNZV6siaXooODVv9GmJBjYv1kkf30Vt9Ga8JCpVxd50VUfz+e5+qGcCst4?=
 =?us-ascii?Q?f159RDw702g160khTTNsUgUHD/7S18iHjtJx+3qJOlvjmYjqR3Lqw0NHv/Mo?=
 =?us-ascii?Q?dLrr8vRojirPN4mTiBMDcwI2OBo89fK4t59+ps5Kz29EtUr4cGyC/SiADd2q?=
 =?us-ascii?Q?LzW4k/MN3SDMp4gaMOYA71fo/9dA8Hr6VcRNA4uWrpKFx/9bQw0AnQyjp9Ie?=
 =?us-ascii?Q?GT5Oc0YGRylha+iSkeWHj8iRVfkplcBW4WxQ0od0TN/XA9kioyIQp9vXixDx?=
 =?us-ascii?Q?oSZFuGMYv89iB6JQRZfWd6EHuGE8XhveSMkKLVG0Mf3rO5rawSXHuEdTCAfg?=
 =?us-ascii?Q?qwkDMDDLDc448tjiGZDMC9KEE7hJrBvsvXxtAquCbrSblogpYQ+692Ro7xVC?=
 =?us-ascii?Q?UAXVv7WCEeGuWE5OZq83AbsTi+dxf4R7sgKc9APFfUq7H+F0uylaC8hEQr4A?=
 =?us-ascii?Q?EJShetBJ9S7L+MqavtYEmfkzWqWVxPU6I1U4kuE5DpHT7h8o40iufY9gTmUN?=
 =?us-ascii?Q?7C8DuBZ9H4IHclh0n4NP33/pbHjmvPMdcNw8q8JCo2wleDTgfDFgHE5ELPfF?=
 =?us-ascii?Q?yZ0+ppCrQHXZXJX9Mq7RrqZCGLZDmbajLZNgedOGfB2AuEqQ0r7XXRqSu1n0?=
 =?us-ascii?Q?Wniq9FEr/WNs9s8UG2e13+/pKQewlBaJgltMBv04+5ni/lQJaH412KkePr4w?=
 =?us-ascii?Q?2/0q3/OrlEkffPUqQqTRBCX2dgDABriHkKB3Mvv/r/u0Dvd6jbD6PLG2f6ZG?=
 =?us-ascii?Q?+j1a1oLObkmpWAIvwTagi7q/3jrme3MDARnGcNchUHf0DsoUYDOdCb5n9yM8?=
 =?us-ascii?Q?kGCy9eg/k4tExKDbezDkksl6jqrfjXa244VddQSyT6RECs/5rLsQsoqPlwv6?=
 =?us-ascii?Q?R0fkUrNCYQqdH9TRP57zUjcYhSIKq8MbNtYReoWM2Zak2woqzDFXv7Vr/uDI?=
 =?us-ascii?Q?SrsuPmKZOB3R39CBIrHg7hEBP0QV91ipmlKj2QpxiJ281wUGO5doFMCsL3ib?=
 =?us-ascii?Q?ZhmHAdqLWPr1JPbcdzd4YMRez8QuDjYFPrMQsTLj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aecd7b-4ffe-48be-0e2e-08dd5c4baf49
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:10:29.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfteCdTXMVwsCKOvDo1umXwY1uHFO6A83sf5j0w/h3ksvGcLsDgQF6Pd0SURH593mSB2xObvo86mL+WkCyrwSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

Currently, RCU boost testing in rcutorture is broken because it relies on
having RT throttling disabled. This means the test will always pass (or
rarely fail). This occurs because recently, RT throttling was replaced
by DL server which boosts CFS tasks even when rcutorture tried to
disable throttling (see rcu_torture_disable_rt_throttle()). However, the
systctl_sched_rt_runtime variable is not considered thus still allowing
RT tasks to be preempted by CFS tasks.

Therefore this patch prevents DL server from starting when RCU torture
sets the sysctl_sched_rt_runtime to -1.

With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.

Steven also mentioned that this could fix RT usecases where users do not
want DL server to be interfering.

Cc: stable@vger.kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
v1->v2:
	Updated Fixes tag (Steven)
	Moved the stoppage of DL server to fair (Juri)

 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..d7ba333393f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1242,7 +1242,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
+		if (dl_server_active(&rq->fair_server) && rt_bandwidth_enabled())
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 
@@ -5957,7 +5957,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, queued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6056,7 +6056,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued && rt_bandwidth_enabled())
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
@@ -7005,9 +7005,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
-		if (!rq->nr_running)
+		if (!rq->nr_running && rt_bandwidth_enabled())
 			dl_server_update_idle_time(rq, rq->curr);
-		dl_server_start(&rq->fair_server);
+
+		if (rt_bandwidth_enabled())
+			dl_server_start(&rq->fair_server);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -7134,7 +7136,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
-- 
2.43.0


