Return-Path: <stable+bounces-124541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00925A635CB
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2AF18905BA
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA31A707A;
	Sun, 16 Mar 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5aZzj2h"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2B1A5B9B
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131601; cv=fail; b=IMRiXizDAT49AuHvuA1zNNrOycGJdiytBM77RGNkRnO0JToDz5X8Je+l5g/f4IMwBqR4RuG0YSuJuP5Wk3TdhnmKNQtre0+GeE/V9nOBRfFWjXbYDhYhI9Ww/UAPZnHhbgEHtBEK8zzFedQ8GZEE/SVmVDH/SW7O3HG7i+b9fD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131601; c=relaxed/simple;
	bh=+/7ONnfpin97KCfIu7hLKiy+7tpwD5Lg5iK59RbPv7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVKvZl1EOllPmMeCgckbRS38nT5f1T6YWfS67bHcPq+FhzcjhLAS5dAbv3udbmq1p67yzBzew90GF2ECqEGo4unnDbxuubyWJiaUGjJjqDuRAMWnfb3H5PpkQpvRWgJsC42cNBp0mkwP8KmKriQy7CS8Xwn1ui8f9+oxol2+6pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5aZzj2h; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOPMy23znQf6vQiSXXnFx9GDcrZN22LB+4wKFeDmnz1h+i9ITxaciq9owQlcpEvnP9/ivL4CgfhL4fCjPzDwyQglY2iKc/4h8wXTR2SZkQghvg8MhLxXzmyEik/bKgfAzsYUR/nuIIa0ARzrHoDhevOjI8ov10z3NWT71q6n33OaqjkrjQwEszQN25ZFJ/20+dBKQSZ3NNRnzIx3HnqpNB5MIM1f+bO03Rv+zLNZuwnqLwogKI1+YOa6ytKvBHTWtNcBU8eEF4o4+qkqhnrh0/URPZLnKgEayx3PD+USAlmPGn2m+7L9n1/swNV0oaeGLFbJUNQE1I6Cc3l1h8z/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thH5qzrtVb8svDyIf0rPP2CyRQzTqEZRQRnmB+Q3pC4=;
 b=eRNWjiGHfJ8Fox9f0oNC6YZSVBybwMvg9aerpLXNQVZOBotoJaHEyv6eyEoyGqh7bGb1zhxlzDBKiV8PkL6kYcvmJRSmoZPdTaOleaJFFIyC53BP3vLDgdHaUmFc23AjOuxwapaX3YS+D1oo90tomXdR9gsNxErSnsALykxFmCmfKODtxSNEENgYpk5yAHQidkX9leUpG+fOwMpFSItGIwubIP3Ucs4ZnIYT0Bky5cecY1XpEl9eUfZoMXbjOcgPHqqyOd3xux4edQ8aoYtye641sTtGzVs6aJdRzUGA1JT9AjIANSAXLUuMP8SNoLavaacjBXTDfiiJm5IaImGWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thH5qzrtVb8svDyIf0rPP2CyRQzTqEZRQRnmB+Q3pC4=;
 b=A5aZzj2heeEPzeOaL6I+u4222jFeWgBZR0SV0MHWYjNk5jkJ8kdM8b6iY9Use5PnsbpnBbAQn7K6OoA9jOQDjNTx/qrJi2lV/ZLUeQJNqwHv9AXkzTQywDWULgJIpJzACftV0sKkmW2DHiWrE+fbIATBj5BiEqmXFYUbzuMnkRrjX8rI/egYPujNbZpxYN/8Mj1Mee4tnomNexRWlZ52i/0I3wFMoCO+eXyEVXEEZnZPdUsloFokDmyf5hzdEUs2GBvAcHHkTCUTF1ff/XoA+4UAsd9AHE/kq8rgR20/Yu9ENHTKoUJDb9P5o5b2+HNYXAV1eclxizfEnnswR01oUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 13:26:34 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 13:26:34 +0000
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Sun, 16 Mar 2025 14:26:26 +0100
Message-ID: <20250316132626.48526-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031614-broiler-overgrown-4bd4@gregkh>
References: <2025031614-broiler-overgrown-4bd4@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4afcc5-465a-4dc9-8a3f-08dd648e2bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjoSw2WWxp1Nc8cPPOueq5Q67z7u2/FmW6DeY0X5RSGjrTXV47IVH3xTOSbW?=
 =?us-ascii?Q?gJj1t2kehf2gLCkFIgYBYno7IsjfUEF9ykpxm2HgsJmHf/r0M3+FKcKGgyl1?=
 =?us-ascii?Q?gM3q4CWAu9nHoIDEs5rztu/ahsGy0dDu27U5miYwlQJETw/Kt5dsn65MAbeB?=
 =?us-ascii?Q?b1p5EMNEzqNLqJ7ERZBARaCYpDm1+Sdigf+nMy4bzBxMmH8dB5QucnxCOY1n?=
 =?us-ascii?Q?6LoG72v4zdzsGYd9XHAsLgaBpMpIIAHwzOd8Ebxx9bBgha9dhnCk46Lkc76X?=
 =?us-ascii?Q?tTh0WQmqtdyMdO4rBRUL+W92eVnWTBjmtG1gSL4MVxJ7C/9hJ+pN2X8W+sql?=
 =?us-ascii?Q?YV+HdalPKdXDQiwyTGZcssCVq4Mw7V5EdeBXszYPI4T0NUAI2Csqi1571f8+?=
 =?us-ascii?Q?fCV4ecV/267bJjiFGuVYAlgAIwwq4XDnNQX4rmTHE1TAJTsyZ3f5VJlevqQQ?=
 =?us-ascii?Q?r2C1aE4MSaUve1XddU7j7/FkWN27bVajn+L2NtjIU8gxfVVSGZi0sqISdPOZ?=
 =?us-ascii?Q?ahz+EyHcfk6AKnVItP4jB4QclCCOFcD/5iaQ4AhUhdnw+3g70dzWNuvL6And?=
 =?us-ascii?Q?rQwoTHurioVq1yQpQPH+SW7eNuC0oQ31jCvJoSsRA0bgrSISvOpOhbvWQJks?=
 =?us-ascii?Q?yexT8BupnBXrxJ2rJl07IiIpr6apqS/EJz1VTams6a2/V7HeQ0GClLGyJMY5?=
 =?us-ascii?Q?F5+aqtR8WZp88qFbjtw2yXXQxGdTRKmtRAnKm/eVuC/SPCY3djO/k9TpJK8x?=
 =?us-ascii?Q?wqKFZmflDleJoj4AKKTfh4LWBipNlUDvnCJfiW7RhVs66S0VAYF9qQ1bEsoJ?=
 =?us-ascii?Q?wpI493B7hz+EUfR8InNBuTjT7V+fTGYGkJfRm4lWk0b5Yr7viAjtsgWlVYzt?=
 =?us-ascii?Q?jZ2peVWmKGpuo6nKV9wbh5ThzAUPJz8U5fN/n4BFR+zXtmWfwgo9HqMH97AS?=
 =?us-ascii?Q?clPAWhYcmIPtJEXOuVgcD9UkAt1ZKiOnuMmSC0OxaI3MFDdrMeyz7yOC9ZxV?=
 =?us-ascii?Q?d6w7WlELjSEbdoYUNAasNo20r+KzD0iDBdQgC6JvEoLIypcUYRKNIMvk/hY8?=
 =?us-ascii?Q?K0FJE28IlW+CQTHBVpkwTAsn+/mzuS4CqMeAkD15oMJFX7uydBqTHeqk53Ey?=
 =?us-ascii?Q?dMJAsoxt8pJVYh8qSbAbv3ZIKxGeSjE+LIrrZVNDV3tS5V4RRfS84oS6J7Lb?=
 =?us-ascii?Q?sIS3bxRND7SBo9SuHQGEnkdoauWK8sXPyby0z7T69tbxxv+nEBftszVPZ/kA?=
 =?us-ascii?Q?mGVwaE/LJjqzyLii5njU+WA50FtriTeDvZ02QtG1R7dpx/W1UezDq7fuxJnN?=
 =?us-ascii?Q?eB4NZcDpj7amWpDctgC1Ib5riEnLCC9hx3MEpnYkuU5yNYHCZkFoSthNS3bb?=
 =?us-ascii?Q?o4kXpml2yfAPB5YMoyIzUH4HOGtF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/bRGcDOS4YHwrK2giv5c3sDGAscaeSClLc8l7NYLyVGXCZGISAX2clo3NzH?=
 =?us-ascii?Q?oXgL+vbIo/Ol7qV1paX7A9nx8kqW8QKN/aBPxYwAmQZzYooa/ei8MekCzmpQ?=
 =?us-ascii?Q?ty1tkfMpBt3r+9aLSrfdGO8uNVAlUhsQImZIOy2cFpAXWIjwa1rGtw22shAA?=
 =?us-ascii?Q?xKj+O4uKNOaR1nC8jYwEOYy4LjJ2NG9wq6f3R2IaQE1MC7XNguHLchJqF0iq?=
 =?us-ascii?Q?B0In7k5zSLtlP6nyXPkF72vYKwPErmVN27G02PnXbdkm04ek/Pv/Hr7OXaK2?=
 =?us-ascii?Q?My7/7xMVS/3GBpgbXqETteRltTtlcGud60vnulxLK2W/NhpbpsY/+h8HviZv?=
 =?us-ascii?Q?pn7zbIZb2u174LB+fRJTMxVED099FAE4ByshTjUgF6qtevQeBiWXkyJmkOXX?=
 =?us-ascii?Q?jVMoklJSJwi3l1+EpCkoH8l/Rn/JOUn2RWiDSEEZP5FA0UfokbSMmIbMYuT7?=
 =?us-ascii?Q?yZAQX7r2xIWmh5rGPc/idt83YBHzRm7nXk3cukpiz+ZK1MtC92I081IB/xnQ?=
 =?us-ascii?Q?ShP8YXltDyI4zIzbw1XLYo4c5DKfR3X9xStvGLBxDYEbaYkmrr3lDtAI5Tgz?=
 =?us-ascii?Q?e8STdLUiTXjVkFMMkNRKdU+EkENpn+OwnuUumkzJrSa2UBXfS/iKo6jGOKkX?=
 =?us-ascii?Q?oplygK76SSHdVksQZvgo0ozgUdfuQIdWPNZY9JwHO1PJzA2aLS6Obh5xjti5?=
 =?us-ascii?Q?3dTLQ4iexJZjHJrmueixVUNt2aZNQJSHddro3X1G4P6D894nH0V2QF6omQEe?=
 =?us-ascii?Q?p77JJdvXIGrW8NHfVVmL28KqcJxQJWnuNpU6nc6hYIxHiPiw5JZtliOJb84M?=
 =?us-ascii?Q?0CA0gldOwTbUFAFr2s7jcy37Vu0SaM8ikaxY82Qf4QTacWevURk0ujERBnU4?=
 =?us-ascii?Q?DYQCcilAUroSk+0GlzTD2rWhYeTkDdmKOd9LpmckVnS9pbvmSDoIJsjTdkIS?=
 =?us-ascii?Q?8IdE39FbaRu2BjAI1jDkQyNJHWk+ZmnERycDP7AL9VOxfB5m6jihwlYFriZG?=
 =?us-ascii?Q?o2Frc2ICtVTq/qYZ58jOKrPQBUPhEhZA/L37numf/IJuXE8LBXq39xZ4jnG1?=
 =?us-ascii?Q?Tf2Jyr9xfKTPnnD1Qtu3ukG3H2DLB0OLD3cMuzjGhfzFRbnji6HCkgDDHSM/?=
 =?us-ascii?Q?loDyZx5IAoMK16obvk7abTBnalWIwZ0D2VC4QnKt7tM+82nX+HtgwnyMi35C?=
 =?us-ascii?Q?bwy3t9lDyBPWC/XEN4uPkVPMF4Igf5FMzdWCSAB+q+DmcJ7X0J+gGVfSDrnq?=
 =?us-ascii?Q?CaLvth2kYklIyhdsJqm/wfoG1CuK5BU5l8mHQA8Bt4kLp9KjVLhNbNgSy3j4?=
 =?us-ascii?Q?OaBtZa0jW2/vw1TsjR+03rRwbmrMxkxp9FIWA75ZJYaJtAf+VBz8OTDP1Tyv?=
 =?us-ascii?Q?CdFODNu7/DNyhPYY2N/Iu+wz6hiyUNON1lxuSNo7ax8qKdA1lTyM0sL4sXVD?=
 =?us-ascii?Q?ki0ApJWpe4z1+OH8iasLLEpR+xIB5XvSXJT/DNNDjlQKw7T1L4kFrf5Cma9S?=
 =?us-ascii?Q?iWrENzYh2UeYqt+yLFpPOd9WEaJP5DKi6OOQv8MHJweH+oOC58wQm8Nbve8X?=
 =?us-ascii?Q?N+zmuiwR1as84wXKC56g4IJ+AWN14WGBdDRwFglq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4afcc5-465a-4dc9-8a3f-08dd648e2bed
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 13:26:34.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2NSdt0LOaHF8WahmZLeoFGTAgE8nZphq8AQEULSQlWIukdVNsNtydOwkd2XvJl70yDhGDgVGAr8gDA/ar8AAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

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
index 325fd5b9d4715..e5cab54dfdd14 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6052,6 +6052,9 @@ __bpf_kfunc_start_defs();
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


