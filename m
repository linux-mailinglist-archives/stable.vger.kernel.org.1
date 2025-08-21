Return-Path: <stable+bounces-172180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF0B2FF61
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3590C1D24F83
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCA285C8C;
	Thu, 21 Aug 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EsEfVSCp"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14128640B
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791238; cv=fail; b=F2Sy2+spmPegPD0wv8aZUXizUQsQj0TFGSpGb4u5WRi8XCMoittPKVAQc6ZtT0TJ5QWfk5Ga73+0VilAdiXpG+C41PkdjBBRAz2K/vRUl6M+7tfaCDFqfj6ZhGQluEO9gtNkva6sKlAeAR2osVg7co75CfeepOKI6FK9jq8lHNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791238; c=relaxed/simple;
	bh=ZwX27BK/qYiWzrkDXmFvXV7NJTYZwfjoIkqR+1X+zf8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aPn2Oj+rTk8c7YoqBm4z8E7+c50bxpzuQMVXhLONDU+YmNqMbBaprCblQzmQcOQN9SS8pjDadmQtymixNIrZU71lCoqfgBmcLyg5sXh9uyruHR4clTDPcURFS9+XN6WE3IT/TSGNj92SDYJLK+jltTfbVH/PpgvkjE9Nwo+6nBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EsEfVSCp; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNegi/xkRy/274X8osV0/JMSQ3QE1vsJkx7I71E9A4iL8VjLVezv0B+mJJtB52J8Oox+/dkbRh0N59b5Ver6AxAsBzodkj/Kt1nXupoUViH7ftUnZ14NqAyd33RlFlMMVl68LWMknot8Bf8GjyvI+0M4rmBN3ODWdlhNbD0s3lvFBZEOjzPr8G9tpIo/LwJYCPbgU8R2+y1xMyPF55mqSaEm3RDfG2wYKul3PrtecVuczNRK0i6CzcXhh3ihb2snmOl652J+L9tIsXtFeWJhAfImDiY7lxoFL46wfQRmcCHWKk5JeavuvxwY4gIsatJmRigcMSLUy4SduVka8PFaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvknfTvANFxdsodMrHy6JlU5y8USXV1/tg85WCXPVwo=;
 b=gjlLASgRzgTreOJMoY3J6b3DVoG/sJHBUA5/jvNxTj9cyQaug/mjd0001QELpMkpTuTZgVY9dXFCfwgp1kj5BLGonB/vhqaL6w0SmvAsG6lWtUAyNrsqSyWN01HPokle4N2fuRrUeCOHfkytL6zVCpt85dz/waDfZh5zqepB0Pr5dzyhBktB9mJDpOYOhnpPGVTmT6OB62FvP9PsnjZkNWglPVbehLv3cQGSqN1uOnAQE30jj3ilUn7Qsxo9sGQyJ4TFzsK7QF5aARzbBLD9LTaILsG23omLuRpWlMtLNxIeDcYWvT/QO0dmIWfIB1IFrEdmsPDicCX7lnHlcMoXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvknfTvANFxdsodMrHy6JlU5y8USXV1/tg85WCXPVwo=;
 b=EsEfVSCp/CNEKxzQt1HwbDl0yvePHGUn+q3ArdjGJkkkq6T3KMBxxORRfVz+0EGvSVb1N0vmCQwNM/GjUISWV7YStg/uk7yqqSKtDGxPtqycZSXz3e47HkPyno46eWv2vB0K0/VBluXbsrUss1y7LuCAHvErKr4MHONiJDnhWt8kQOSbtTQnrSMkCxFXHGjnmskjZ3gzeTlpUixXsCF8WAjaQSnQ+voVAD7BIoNf2+TndP5qa6x2eot23E5YxQ5GFHAqWz6CWWLb+aQfkwwOfPDA95PO4dj8nLCAsvb22+uaZCZLt33bnGPbr+MK4LTud5OIDcmiTGcken8cBxkvWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 15:47:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 15:47:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: initialize built-in idle state before ops.init()
Date: Thu, 21 Aug 2025 17:47:08 +0200
Message-ID: <20250821154708.37063-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 2308e577-38c4-4cb0-9102-08dde0c9feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQp1didGRhXQBlMucpj5H3qU8WWjeZtWVc3D3mjV4zGX/+2PH/BdxoRxp2kn?=
 =?us-ascii?Q?kcBhkLBiqSrBOWNGqr1akUUrmp9v2R9BsAiL+sDG4u0xU5LVBovd3JVPUMjI?=
 =?us-ascii?Q?Q8E7IyLq0/pawBaYrEPoloRsv5SA7hc7hXS8tLHd6/hCTSNFtOfUY8lqwxeK?=
 =?us-ascii?Q?C9uUp4VSfn37tr/KAlIBrkvZCGvZGPj0ZYtoaZG5NOv6yqOwuDhSAtBvmJaR?=
 =?us-ascii?Q?D4oMQPC1erK5UoxE+QTk9u8RujC8wcZKiuzLxYiXx8r5/XnaZDUltXB+/7KR?=
 =?us-ascii?Q?FOpQv0NuSfxCaSfp6VA4CVVfwNwOQ5RkQ0MiLcGqfkkrRCfPdjyQYRqiu5bK?=
 =?us-ascii?Q?PYTApcdjbGh7ZNnZIbAvsn9q47U5uLD7FXAMlwsZHUPYFkUqvk4f0l2PO1a6?=
 =?us-ascii?Q?1ib2Hohz5VqMsHpoBNfh8IY53dmbI+IhzDMdsxR+SIr9On1f9bg5rGq1Z1AN?=
 =?us-ascii?Q?XfoVBK+lWH7X4YDC3JFvsWtDAr76b5V9R+oub9vkSWldGszpvzkmCh5tLbl1?=
 =?us-ascii?Q?0F5T9LsMUDDlLzV/IrNPYSEmsiMmXaCjjKb4Vhj89QnJfEu5PyTT6c4uv/QX?=
 =?us-ascii?Q?E618hEXwtBL+6wJdpNXY9rmlkQul2bkiM7YO1sUNgRNmZAtWlVEdZx6jiRc3?=
 =?us-ascii?Q?zwvJq6oUTQ/RloyOLjMxwUi7+tdf0F07vehRp05BcCKJrlo7W6Z51OlvoaFS?=
 =?us-ascii?Q?KkfpeqDbllvtHDc5xrCtQLOquNhZ71bPvWV0XKxQdK/cK9pKAk7IUOnCstFA?=
 =?us-ascii?Q?FK1DS3BAPcNImj09z1+A26lWgwRtVLkhSrhcnVDchtqyl+uoYfCvvBjvCBzn?=
 =?us-ascii?Q?In6A6KI+F/rbLYbVkBPv/f2+JGUZ07fFwdDm/s8xzs5Ik9A7qDxsTgOO4Zyc?=
 =?us-ascii?Q?+9Wq6ng9KC1+oWeWxizTDDin/PQBqoa+BuaVT6s6fOdhYbe/VesfeO72oWGL?=
 =?us-ascii?Q?/xkjOcWHettLDSTJBdIL4g9Kp5bCs6QWw9zzTz1SkuWr5VJWuSy1inClvTle?=
 =?us-ascii?Q?B4qUMh4fI8oohMXtEVTaP5kX4y3wzkSHj4j47Ml/YX7HLokR8gZLBlurzzfP?=
 =?us-ascii?Q?vpJv2rXms+I9ipNQWlqy3IMSPPxhwGPltn2sc/O18zlQkZTebKB43d/nhkCr?=
 =?us-ascii?Q?nBevGcSTfQa+kN8z17rXn7NYMMGFwzzac+DECqSWXmQWsx/WFyVwn+NgB83W?=
 =?us-ascii?Q?rCGCfdPc76KBaPl2RoKtM/84KUBijnS5rPb359fXblffONn5xa1ci4bbmG5E?=
 =?us-ascii?Q?E27/AIUTOw0X5yA4qCz1O7mHb6FWLw+4nkkHMyEc3oi6+59+CGdyKbm11WbZ?=
 =?us-ascii?Q?vQ7SFTPA8UBSmqbFTajkfirMlDSpNkYuHmQcLAmJS0LdMjOMWWKEB3qQ5dC8?=
 =?us-ascii?Q?bVDhPkObq8ezcGcLLvrkmiLx3WYrozqw6pWjsrTEVyktqcJve25rcMGP7mRc?=
 =?us-ascii?Q?03/GcgV8Wvc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zNRHRDwcFR5LQ2aZrD+agQs8PSEmdm7Hy47fUhOqa8AQm2j8+wt1x7baTcS?=
 =?us-ascii?Q?RVyYKnaSaq42ue8+7PZJNiuxWNMVrmRUCQUygA+mwNQGc+A1VF/X2ftL79vJ?=
 =?us-ascii?Q?mqkUGeJbDrLr0D7emE6OgBtcAOGpW5ZZtlttrOPYo73WLyR7EQQVmYGUoxrT?=
 =?us-ascii?Q?0LnhhE7rFR3EEo70rIvPHXhbLgLG48GtcBvcnOpym7wfBXwqoC+yepu08Uba?=
 =?us-ascii?Q?hAsHKsmdv++PSx/qkFBWhrFtV8DNbwQ0f2KGIkw4T0GC/lL5fOCnFMPOXZns?=
 =?us-ascii?Q?kilAD8tjx4TBlUxXbRTQzo22+pR+tNZZ3808uCcdn2en2kk6Tr2VVEMWA9Bp?=
 =?us-ascii?Q?0TWyIZ8R1yL2y/xXID2OHa2RjDb/giWjI7/o73Bx2Z5NkiYvJS048F/+gJNZ?=
 =?us-ascii?Q?zIHnAgRefzwWoxws4PWvTRJLoxviItAplmQIuuvqyGz0Y2FnuCfdAZ48QsJO?=
 =?us-ascii?Q?M6QO4lRv9zTgHYJ2jNxWM/nmgiPPW3jgxIbp+bfkDc1L5BgD2I5z/vMC5UqN?=
 =?us-ascii?Q?VLWu+GOi8qE2qbHZLuTPc440cFGuphjF5KS6r76NP+ZZ62UGldJnmXH5f9jf?=
 =?us-ascii?Q?//Ec/HtfZzPL54Oc3kzNiBWRNRl4GuhqNuSAAjxLUeQ16aqwlkwL7kURj+Dl?=
 =?us-ascii?Q?U52kOmzWyIwUo1vYZIm8HSfaZyedo6TcwtnV3K43XC9uO+D6BBs/T1hI6JOc?=
 =?us-ascii?Q?cnJMXu6xmVmjgzYGtNRvukZF1GyOVHCTgj6sFYnHsfpsz0J9EiXM8B9yBP9I?=
 =?us-ascii?Q?UK7NUvRCJqzErG8/OBepRmpKWDeKQ0wPcdr/j8U3MyT+AaUO2zlAsvWdZJp7?=
 =?us-ascii?Q?+9kzZFJzakCkWb/1zjIkNhTNIZWrPLOPdE/PKeeTMh4rWaVFULi3LNi9YCJV?=
 =?us-ascii?Q?Y1kzP/cFiNE/1BgDWwdIHx9Y8GXWZxfvtabjOo2ZYo2SulUpvWZwszqZ+wZx?=
 =?us-ascii?Q?ysMtYgsrRDbjrSUD3wph37ZfTsUnUuk12f024sTOE72uKguVGwTsGbkbWPbH?=
 =?us-ascii?Q?fRv4qNMznzr0zNPPCDh5gC06FlqQCzeZY3HIivKm1a17RjfImcCz6K3Hwvtd?=
 =?us-ascii?Q?9zEhj4T6nzlIDz5x8jPa8qn5GBb/LG0irX5QTZWK6cTgDmh2d+fWdZOm9i5w?=
 =?us-ascii?Q?GxDpbr95yiU0QEKtb1lUMFs6rosFv6pUpAZiJjM1n/LAbsrsv+NtGMRPEoAV?=
 =?us-ascii?Q?Qw+HzrBbGgLmcxo0Lsi/mYmgPKITa+mBc14GIz4R3MvsUX7PFPzVTaUrwS7J?=
 =?us-ascii?Q?tbDOw/uGmXqqNIB96CRgBonn5NP7xrr50+VwhyOlxeNkAT14HoFg5FATkq8+?=
 =?us-ascii?Q?RCAF93GyBukDv5vkuxTtOgxo/deX35k2VLWnlkKoq/pcE3CrcwJ1/3kct/uc?=
 =?us-ascii?Q?u0x53ARefT+fTgYrfXHgkqi/W17QriPfo5HyenN0kHJpD8SKkCGQYQ7Xk4cC?=
 =?us-ascii?Q?QN7ZRLlzzYM1KIig8MQGfUaAP+2mzXrZJ0l2x6Zm6iLx6O7FNdobgJXbbg05?=
 =?us-ascii?Q?NtimdUgiPbk/fwiI1IrhqxjjdHHN4uRQdJNEF03NHQKa1Nb77cgChYvopUZa?=
 =?us-ascii?Q?Ttw4g5R6j7XDzltEYjl0QigLNGVBUTTFYLwQ/fXF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2308e577-38c4-4cb0-9102-08dde0c9feaa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:47:12.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvk7mbs4OYqrs1oS9gNLzZIvu6bOBAGES2GvBLeYhQnMiMfb4mMQwE+5mCBeKvPSYqBvj23QzogASDaxYScPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

commit f0c6eab5e45c529f449fbc595873719e00de6d79 upstream.

A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
before the scheduler is fully initialized, either directly or through a
BPF timer for example.

However, this would result in an error, since the idle state has not
been properly initialized yet.

This can be easily verified by modifying scx_simple to call
scx_bpf_get_idle_cpumask() in ops.init():

$ sudo scx_simple

DEBUG DUMP
===========================================================================

scx_simple[121] triggered exit kind 1024:
  runtime error (built-in idle tracking is disabled)
...

Fix this by properly initializing the idle state before ops.init() is
called. With this change applied:

$ sudo scx_simple
local=2 global=0
local=19 global=11
local=23 global=11
...

Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

[ Backport to 6.12:
  - Original commit doesn't apply cleanly to 6.12 since d73249f88743d is
    not present.
  - This backport applies the same logical fix to prevent BPF scheduler
    failures while accessing idle cpumasks from ops.init(). ]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c801dd20c63d9..7eae1c64f7348 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5220,6 +5220,13 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	for_each_possible_cpu(cpu)
 		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
 
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		reset_idle_masks();
+		static_branch_enable(&scx_builtin_idle_enabled);
+	} else {
+		static_branch_disable(&scx_builtin_idle_enabled);
+	}
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -5287,13 +5294,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
-		reset_idle_masks();
-		static_branch_enable(&scx_builtin_idle_enabled);
-	} else {
-		static_branch_disable(&scx_builtin_idle_enabled);
-	}
-
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
-- 
2.50.1


