Return-Path: <stable+bounces-124540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47CA635C4
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D12A188FE2F
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34E19E971;
	Sun, 16 Mar 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLzwzCSR"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE1C2E0
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131118; cv=fail; b=A56unoXr0o/H/Mv7ZETM8wac48WMdvxUDeOdTh3J05MMUe2mxqB4FPEcjTWGfnvFTH6J84QkNa1rrIvn2M6st6wo2UGNbHxQLJTBC7y4g2z/v+4bjSlRSGkGQUZhkQtq56V275rZ37PtivoixS5p2MkUO/GvpolEQK6dMehr77Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131118; c=relaxed/simple;
	bh=JmekajdgLU7mAAksGs6c9Rp3clnh9wXRPbaYkcwGXCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyeU1NMm1m+SaZxzt62yGMC74r0XBhkUEbPy7xv8ZBs6/5ljNZDiEjjEJvyzXmXxQwC2oiQHSpD7G2vp2IzXJV0b1Siru8kr1zg/DVQ79heIOKB+j1vsTFyCPKpVpl+JkjLKwmd21rG0U+CNpB6v/kGrVhEpinfRn12a49QXc2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLzwzCSR; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmjjgOA0sG1hntEFNKKxISayeZAZpVywVIoHUl5p7dzcXU/SDoO/Wd59YwNMoWh7wIVeXtoqTZPAmJSB4kgOKrmAXy17IK0zjeLWaCaIw9BoRdy81kyU5NyZ+Mcd6lXN7xmnsDIKQtKgpZGNejcZRRlBF8QgNkn1ES/OI9RunLZ2s93attsVTIPvsb8ATVWNmGdImS4hzZv1H78LPrI5Yepznp77FkcTSS7cg5w/uwOy93DBvGoYZnEevgedQEQLoJqplwzs1VnyfIZHATqEM69qvDEKjmdZTKKQtTYycMjKtK9SNBOLaDgpZYdIrRiA3EKXeVczNiGum6GlO6OpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SybdS9GplCJ/U1ISe6exIeEq438D9Vrdv2FE5YNEV1M=;
 b=omfnen2A/yVhbqz+VgP7SwYSJM5pUJCN85Mj1q2pmB68cQrwKjoPdswHmtkcOscWYYrkHxy0TleyLA29V9S7quinXjCtE+j9eMPTSc2QoZfmTaRU0DblxFjXspAjfZLFv/uR5a4GCY1OpVrfTwCwJNu/5Ve7ZGEC2BQU98yXsr1FTtSvJ1ku1rTfKRJ3xMvngkZM/M3i5C3IxBFroIctmea/uEw1d/Ngj92ksVV/GeDHOTGkIYxw3oxNgaLUbgvfHOVJ9yJbGs9c1gR2VA6poLf3uclatJQs0hZtpMGphLkuaFihVn10uYy0giUZ3XDfr2PxhBpd3jyDSoipKl3H4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SybdS9GplCJ/U1ISe6exIeEq438D9Vrdv2FE5YNEV1M=;
 b=hLzwzCSRDGNamfYdGqX3pq68KtPvXaW55/bVua6hPwAy9CxtQZxkq1u2QS6OqBQGueGaHuQtvhobj8VKicRVLDvg+McZvlMwSJC5gPu6atw5JBIrgcHQv4E04GR6bQOTT0KsCZ1r5eVajxwPkkY2sb4ERIpf7PMUD/tLcSZcRSVj/TDHnbB8ETtI/PXoszuO/+L0G8fODGYHJVi8FEyLl2AWAQp030xWwIHvCvm6rCCie2PMaY20jtcSk2br74qUPhYDO9fI+K9eM0Vipc5IkG8j3kO+t+xQ6J0IIughTuED5oigEUmiVfPhany7LqRzIVUfoVjG8PTdBL53xR50Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 13:18:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 13:18:33 +0000
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.13.y] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Sun, 16 Mar 2025 14:18:21 +0100
Message-ID: <20250316131821.44867-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031611-flatly-revolving-8c7b@gregkh>
References: <2025031611-flatly-revolving-8c7b@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 909a8ef2-aa4d-40d1-ff5b-08dd648d0d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6y4bfQWXZr7vrMRbxWp+E5bCPLA1HlpZorueZ7wMEZ+0ASS/O4xAiCgdj7Vw?=
 =?us-ascii?Q?bbr/V5E1s8RTHt6UxyAf91XqUuuu16nEv/K7SnZolNvvUqOTSHi9QgyzJmT3?=
 =?us-ascii?Q?nEZTDShrArGkclptBuvf8/+p0FUhTzAHhmwtUH6gh+RolTiPILygzL48q5Pt?=
 =?us-ascii?Q?Lh9iiXKi2k+bw/rm8GIGmcf7zWDCy2qG98Po4cxsJ8BdwQGvs1zg6mdI7aCL?=
 =?us-ascii?Q?XsSdFKm1NOpkAv822BhtxK5v2zpEXPmBEbNDaGza1KchBtGb3O8DQjfonkh/?=
 =?us-ascii?Q?A0gsWgjvopbyZmHEkasAk/om0PsjbydscJkZLMB2EZ+2qmsZTK1x3RAX9y2s?=
 =?us-ascii?Q?UwdAZlp/6vg4ScpKldqi5Y4yragj6S7YTMJfPDShTxl2MhLZNQkaQvt/pXg/?=
 =?us-ascii?Q?G503ludRUM3HTYNTLm8LnttFrD6er4N1MIAbo691THVq28IMV5MHInWjYwXZ?=
 =?us-ascii?Q?MKjAm9oKLbuT4sT/Q6orMoIfNu+qbmzW/sJ+LFg8ZZYdzAGT6fHbQhvNKx1O?=
 =?us-ascii?Q?XMYBi6twwQ4VHkTmFK/pce1Wt/zrNz/Nm4jOG18nL7SCgnYB2C+qqIvYHgon?=
 =?us-ascii?Q?OyVVBL3oP07wPvZPjpwY8diEEkK5OG/+toC+cpL8qfygXt78lShS1QJUcZoV?=
 =?us-ascii?Q?AC8wGbbg+1x2KDjoDORzTtDp7z1x23rX69HTe17iJt74FNdQJ2wTAXXKuhVF?=
 =?us-ascii?Q?9AGpbSoHMoVB3umULhVAmRw1SE05g3RMWONm32lz2oK0c6QSmtP1St2YQ4pq?=
 =?us-ascii?Q?+DbYFSQXzSEUeyfh+myMji0Uk9OPFIr/1LIak8QtFwvZUxGqr01zFpfF7JFu?=
 =?us-ascii?Q?ekW0ZmmJDn1GrpqdxZhIfdpP5AfBxaB8KJgfk98bVk2rn4QpgtfMvisNuEKZ?=
 =?us-ascii?Q?UJJ4m+oiOE6iRSELT5ykMb7v4kZ32KL+HgtiSPCnvD96jaovGbxfGpJJ0q2a?=
 =?us-ascii?Q?Ud6FDMEQdoj0VuNJkmrc03PtdpjN/cqGdQtUSf0VqOfdgPfRiofQ0aFcZLCu?=
 =?us-ascii?Q?avUGB82Mhb7rSNJU8I+X/5weuGG62vcfK9hLiHXC20ano+qFhZ92xdFUun5f?=
 =?us-ascii?Q?8T6O4aOGjQkJAH+f9aD6wNvG1fMgzUvyuHDbjPeHEDR3R67uu9TwHhuMTNoF?=
 =?us-ascii?Q?79XFd/2UPJF9mJxqZ3eBsXmhj0KpQV8lQpJLtz4neDqrJBgUdL3MKT6bkKdR?=
 =?us-ascii?Q?GcmNH17kv7+E1txUNZlgCQu3difalexS3lHm7jBfhVrVWpJju1J64BGazarT?=
 =?us-ascii?Q?qoseVucrKlz3k31CFxsJn5AwFKPuUn+5xIlXWOoJBKpGziOT/Hja3egmxM6T?=
 =?us-ascii?Q?Ti4ZBwQaUI3HbjUZQJG6C4K8s/CR1sreeTOrVKJXOGknzDI6Iawu3Zo3GqkM?=
 =?us-ascii?Q?2NOUjs2ass2cVwObV4vrQM/cZbEc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELRfQczcr898RM5nZkagp0C2fd4nePlQoE4fU9l37czQ0ZKyqG5+/eLqDcvq?=
 =?us-ascii?Q?mmj4r/d3R3nd+TF7cunTX5XaaLdeDxkvYKgI1TwEfP3qcoMeFRexWbbkJJah?=
 =?us-ascii?Q?pYy2nQg/sCb8OpSG04gIiqi73h1P96hDCUXNOAbhT36O2I/CehR49+wujywi?=
 =?us-ascii?Q?2Isr9VWK8eGGbfm5D6BV/7ycE/n5oM86F+L/Gbv60tfiIt6fpxFC9xdRremu?=
 =?us-ascii?Q?46xUaWWFWLmQbn7z4YLM1HnXY0hyssQmWYIRIDGWAfQraE1ua6ZO0MxMZDju?=
 =?us-ascii?Q?7PItPvCIDdAwoVIB+3rRdTQlgrcAGPsjxXI6yeC1KcF4iRldnMAglN3GexHo?=
 =?us-ascii?Q?Lg27BEUcU2GZMjuQhur0+9W6meyhlRI3FreGdNbFsDwQDgDcNgO/zhaL+CA8?=
 =?us-ascii?Q?n7FXoUuehnA0/ed5K9gMogIpAG5GJuK89OcQ5H9WWNcXpd8xR7kqrebyfbVk?=
 =?us-ascii?Q?ISoYZltGLT1RQS7YCh/25A/VVf0Sajn6hR5kDki3f8Xa0h/GfNaFiPMbi9Xt?=
 =?us-ascii?Q?iqoiYgYsrd4HgSWxmTHF99bSZoJaZPcPTlULfTt6d7ExTD4h+4nLbgfojJS5?=
 =?us-ascii?Q?oxLcscuGjw3dZjr6I1WPiFBKoNSkKUbUB0MMPGS6FTctWnjHvKFcki7T8+8t?=
 =?us-ascii?Q?KKe1Gy/MCpDo3Sl5kLIb16G5D7EWgiSuL4uwUwUyFJrC7pew2zhDHCNnqq1i?=
 =?us-ascii?Q?c2Zyy2x3t/wEq5POA3gaeg1l8oAz97laNUOJWeFLEV7o9rqyY0JsGY0cnIC9?=
 =?us-ascii?Q?d4OSOyfpaBBjEzfwQHvJV05sS3cedOUPc6copBEfGWE8SSgTJB+2S7HVwdrI?=
 =?us-ascii?Q?3Y0ua3eyvZ/otDkLvNcYKRNWrPBLm/byONXyZZQogYB8N/MJFnDSjfVjSaKn?=
 =?us-ascii?Q?y3fVlRPPebLbmVRPJRFSlzHZoNxBvnS3cbOv/WBc1/H2Vlj835ynJYx9Wlia?=
 =?us-ascii?Q?VfZh46si0lGC/9V9oxEaiviUrSxJyCYWH9C4Fl7aLtmHAd6xDmk7TFXsSvSO?=
 =?us-ascii?Q?la8vKIHOHSQxS8drY6gUT9VL+SQiH6efGO1+LligsmnlFhNOv3VCzy3zjCx4?=
 =?us-ascii?Q?9rR6Lb4KBjVhpeiGS90oEuwgzNZMV2NvFVgdJ6BInQmJ0WcoNbKu7bwALMBt?=
 =?us-ascii?Q?gK8vjZfPdxTwBS1Y2nRT4J3r/6sBK/k2QKCqU5hYXBRENvJGwJj03l0KFZRM?=
 =?us-ascii?Q?GPSwPfHcaxbxXVW0i4BTXLj+J+LsnQ59qEa4NUttMCcdpFdFegZs61dij3Kz?=
 =?us-ascii?Q?SU+N8vz1CXa/DI/2NJHEYLm7ylZRoSpFxDKIB0Kva5sTHqg97b1OCsBWdGww?=
 =?us-ascii?Q?gpTfklFTakWlhFCvqKcy/S57sZy1aKoa12lKwE3vM0ZEvkAPw+AXUWmRBY1J?=
 =?us-ascii?Q?hbMrKH6hDPsFqvKICwhYd/39THjjZDowXuX4TgHH4PfrVeM2ZOPmHnKwPSMZ?=
 =?us-ascii?Q?nseOI+mFYBfs7jzhFzfEe7g60SaHsv5JZVK/FZiMaWiXic/VJUpoAsat0I/h?=
 =?us-ascii?Q?g4RUC/V+XY+v2qSvHhp7lOvroe00+QN4oz4xGWRCW6hGy03LB/kcKQIqYSgg?=
 =?us-ascii?Q?Nm15/wFb9lYW6eo2bEzLuTi5JrPC3WEmCAwTbp7y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a8ef2-aa4d-40d1-ff5b-08dd648d0d3b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 13:18:33.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ui7VqRd6CuRQbbM1Anu/jy5zUIZje8uqQBd9AA/xt+nbyE+07dlcQgK+B+rYfOLP67scVN9hYfR6kDprBPwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
crash.

To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
trigger an scx error if an invalid CPU is specified.

Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 9360dfe4cbd62ff1eb8217b815964931523b75b3)
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5ccd46124ff07..b08d8691b26b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6376,6 +6376,9 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		goto prev_cpu;
+
 	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
 		scx_ops_error("built-in idle tracking is disabled");
 		goto prev_cpu;
-- 
2.48.1


