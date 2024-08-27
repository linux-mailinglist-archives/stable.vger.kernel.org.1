Return-Path: <stable+bounces-70371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C3960D38
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727E41F22F28
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249B1C4601;
	Tue, 27 Aug 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eW7jW+ca"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6C1BFDFF
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767845; cv=fail; b=V9bsSmjPk8eopXefxAEfJfsNxDgJPAmAG2myHMcucaQym91vte8FJI/0kT/b9xWS3ySX9J3UiCYq+WdFPo3tIODl8SZ5w+HttljUZJB8gU/IwjHXfmazqlrKWMEjWmi34/A8RmGWveU48R+Ov4RaWxpkR5c4Vp6yByiGAgyYIG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767845; c=relaxed/simple;
	bh=dycKns8cQMFvB39V/bwjO4eJQHc5GfpSHRI4CqVE41s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WReNW4kT27ABFSn50AIRQCprEOQ//nh96xbw4joRVy1J5FncYGi7xDuci+MpQJYxLo1PXBceCYkFukCnhawPEB+4alTM8bl6FJC4eLoYXp1tzHiG6TXra0aiGsS4LF9yFKqyXUUm2aCFzKWbPD3i4UhkPs1s0tw5RlTDqKAz5hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eW7jW+ca; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeGrwmXIhfsYg8WHpdd834niJLlEHbs/YM+Rllz92t/t8o5FhqcJLid8AMOce2glGg0RQAguiFHFusaiNZuABMKnAvWLZ47DDiPDnM93l6EXi2pHsLyQFJ2e0hUAGob/0xBBMb9CuxJXNC7+UabjaCKqb0W9GxBO+dQiqpZp4O3ZfDOU3biF7pem7OpDacKkpwm/b9ILYBY6NuBFKDPKxw41kU+xtEgDr+sa0vgApjXfePEzPAw/zqdpLwpXoD912xy0eQmFGBevD2/D1PrYFi6JtkKdnqGByYVoMVFLFMh5b254Ejjzp9fpBZrmYXtjLuYAdSeu1ql2OplvvzbwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1OzyBcMo/0SgZAWd0gtdv7McC0E1mflKGl1sOOTSvI=;
 b=adoGZ5dD42ZM7IbBvgd2uVxalW46YxyziIGpaD0HrxEw9Qk267KAjzlKKAWfZUXRWcBAyotf5u9jUAzoXKkgvenU+SW3mDhKTw45W0eveS6ISUX4yJ6Nim2o4mzMWwRVAd3zGazQpAQHl835z+e9YlQoNRE3LoewXHZ496Zz5t8yV+IPaPyttgGIxsxptMPDub3nZf0yNmg/0MebEffWOFh6JaSG57ftZrTy2bWW64aiWsCp9eUOF0RL+IJCZLYIhbDQ1salp7vrQUo75/DQfj6awdyHV43kTwJ/TYpr9PZQF8FW5RTGglC60R7e7fiuTlR10pIynn1PcIPeXC/w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1OzyBcMo/0SgZAWd0gtdv7McC0E1mflKGl1sOOTSvI=;
 b=eW7jW+camnmRAUTiLKdRZdk/+eW66cZBEvkKDBo3SaA+iYpgv/Hg9OYPtk+fOYxbNIMr2HwzaEHSWTIgfp5Uwt4GnWe5oqWAhw3gUpbw/Up4vV8dYVaPil7NbRe85BDJ9B7Lr1T2WeVWZJ8HtAD+e4rSAOyzjXZ7xn1Nmi+P86M=
Received: from SJ0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:a03:33e::19)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:10:41 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::25) by SJ0PR03CA0044.outlook.office365.com
 (2603:10b6:a03:33e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 14:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 14:10:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 09:10:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Date: Tue, 27 Aug 2024 10:10:25 -0400
Message-ID: <20240827141025.1329567-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: a07991b1-1959-47eb-d29b-08dcc6a208ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XaWTMzCkFjf31LqUyAdNIQyEG86ro9E8hOJ8gggLVacWo+UKHZ8uoSwVSrM5?=
 =?us-ascii?Q?eJXoUMf+qmEhqAMPXL+WXpqM5zLZJ6dRRgZ0Hx5tGLJM2tqkOm1mxtvg9R46?=
 =?us-ascii?Q?OTv4GeqoEZCxcXthQAHpAc/ua8vOZMV6RfODlfrKNkhirlYoWbaV2LQMIuaw?=
 =?us-ascii?Q?MxNLBTEjZ19JhPwY646lzvwA3nRUJerIjvwxOd2uyKqWk0RMXrwhB+mawKm1?=
 =?us-ascii?Q?ssAtxo916lyoyvuLoJdOVbPkoGTQmgydh5JhQftuv+9ENOFHV2yCVi6W7oKa?=
 =?us-ascii?Q?F5k1JBBJqTWIQfSOxka5p4caELM7AK+ZO49LYsFlVg3oOrTWBKXl9/JmJT3p?=
 =?us-ascii?Q?META3kY9r3Z876pwQ+549V63L/Ubi3XF81veGJrzBmgvlijR8nLNlQlAUhZ2?=
 =?us-ascii?Q?WNvC2ezO6YgrQlyHClHj8E73kL2fjAgn+HgusFdr2a3pTRFOsIkXJxkuUSM0?=
 =?us-ascii?Q?JFoO8YZxoUNjj+Wtx9MTIb0MvgzeE9jVo1dxLj9JmdZcDDZ49MSTLMQqKqdD?=
 =?us-ascii?Q?3JiVYF4jBIXprCx+aE2neoOXzMj+tgFeL+evLO7sK7ETzQFbHwedbi7RYt/t?=
 =?us-ascii?Q?YtIhMFcgO4jxZsxlB98NC2oIEymWYHVx7A1HpDPBXOQztOvjQHHn6r/dZQWk?=
 =?us-ascii?Q?IeNZR8j3QmQqhcdvDc85adwWkt/7lsi+WdbxblyFiUxsyk8059c2+V4uenNO?=
 =?us-ascii?Q?i7IbJ9f7CVFux2XsTGiclOgHtYW78PbUNN/6P8G+LM+26kNhNakBlnj9PITa?=
 =?us-ascii?Q?JY3kwUlETMHjpUbYXOGn3JGbaaLgfr/mHVh9KatgdAmvPmheT9d/NvBf+3pe?=
 =?us-ascii?Q?rULwV/Ke+tsNS1leJHCuGZRMwiYDwqdxx5Gbm2LTcvlgYCFfaurnpBYIHTJL?=
 =?us-ascii?Q?x19B22mqXmibOKRzuM3kGlkmtw7RVX6t3qlYthkZ2f5p2KRKe6Hxy6jG8mxE?=
 =?us-ascii?Q?r7UUXtz5hk/+bSwyp5xBxwWzoInWV/f9W49wVqVQxhsRnSvV2+Ok+xA6CMYd?=
 =?us-ascii?Q?CAIQSAHVzagNLoSRt8vCcJULpkVuMCUwkgKo4BjjFDuJraSd6moFbnj7a7qf?=
 =?us-ascii?Q?gJpEIKOHMPFBekGmA/hrX65eASos1Div3iP4URhmf8IR2XCjvRMkAPHdhtnt?=
 =?us-ascii?Q?OPy4W9PTTaN1wUy8G6vJR3FDPnSZuPB38BmTwtjc6RG6ecNHLwnHuncYwOyB?=
 =?us-ascii?Q?lmWKuYp1QloDT+CeMB6v7Rx/k7hzhl2k81cSmwrRZaJdn52yizo/mEX2CRm4?=
 =?us-ascii?Q?GriXbDuYKqFzc9/ag9fHoFj23P8YAApLKB/Z2JjXDUILgkFOQIS41PlcX1Lo?=
 =?us-ascii?Q?rW0dq6ztTcphSd6GKxRSre/VquuRzoll0lu/FBFCHLT8DZQ0mMo6iy32WJOJ?=
 =?us-ascii?Q?Exfep50b3yKxj3x8r4X1+p3PK/gH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:10:41.4607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07991b1-1959-47eb-d29b-08dcc6a208ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

From: Jack Xiao <Jack.Xiao@amd.com>

wait memory room until enough before writing mes packets
to avoid ring buffer overflow.

v2: squash in sched_hw_submission fix

Backport from 6.11.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3571
Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 34e087e8920e635c62e2ed6a758b0cd27f836d13)
Cc: stable@vger.kernel.org # 6.10.x
(cherry picked from commit 11752c013f562a1124088a35bd314aa0e9f0e88f)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..88ffb15e25cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	 */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		sched_hw_submission = max(sched_hw_submission, 256);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_MES)
+		sched_hw_submission = 8;
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 32d4519541c6..e1a66d585f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -163,7 +163,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	const char *op_str, *misc_op_str;
 	unsigned long flags;
 	u64 status_gpu_addr;
-	u32 status_offset;
+	u32 seq, status_offset;
 	u64 *status_ptr;
 	signed long r;
 	int ret;
@@ -191,6 +191,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r)
 		goto error_unlock_free;
 
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
@@ -203,8 +210,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_status_pkt.api_status.api_completion_fence_addr =
 		ring->fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++ring->fence_drv.sync_seq;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
 
 	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
 				   sizeof(mes_status_pkt) / 4);
@@ -224,7 +230,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
 			x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
@@ -247,6 +253,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
 
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
 error_unlock_free:
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-- 
2.46.0


