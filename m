Return-Path: <stable+bounces-17526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C584487E
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414D22855C0
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2B3EA93;
	Wed, 31 Jan 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KcVniVKR"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13673FB10
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731968; cv=fail; b=h0a5yaDU8KKAke80mjwVeoJVYzacdNFVDZ9AwzLKREPJaFTHDWAIeQYVOOO9KfXJTPinFDZI2pXxiBqyd2e09pw9K5KaZWH2TxT3W3O2/xCCKdVFdqnybGaT04njvLMcEvvnjKqfaGG9jJ9+v0Ga4zTqwJRvgO44k4+5QJPWnzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731968; c=relaxed/simple;
	bh=hzE1aKbPOR/jtPVhzOUKZsyNIqpWDie/yA7C/wADBrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppTn62WqT5UowzCooUTIKi9RXgQK5G2UUDPSJcOO6uB25FxmyNCENY9Yv/CBw3b/mpQzuephPvZLsFRgin8Z1hfk7kmiWOUmmma/qQh1xHGfV4JI3U5KZBDoDfLMMkDcHYT3TPF6IOZ2RVEEPuDeeGKvFdb+JSV+mbHXdxvpSaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KcVniVKR; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHQhCgJpOx/72DJy1RsSFpI+Ssn3t6DYo41xb4+BFWQCKYSvfd02o+ksjBRiqbS2/LTJ3bdT3hIEG8PeKsO/D2j4Mbk9+jVY5lUnWRhABc8W1j953745EjGCwVY2NjPQpMZisjDSBmKRvblMoo04YCKUltWUxunc0XDvcfVyB5oVwDpMWUMSNdD3Xdv6AUZqqX45X5jc8UaJQHC1oYx1J8rOBTAfjQzjGTHM76F3HqUQb6MaGp2pvN+N/xJhbc3brlEdYVv1i9l+LO/R1fXkW8QdyIMOY/5+d0xfZploaPqkYwwzKBfFB2T4Pfxv487OLCNViPOT8C9xpRGTOCh/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao4vEfuUss+wruNsMoteLxmONX6/0zv8ugfa0l4RD/E=;
 b=JzRy47buqlGOcPAidzA8N9g353DbYi4eD3/1rYPdXAoDmhNCpmZmMhBsBLBHE122mFh2VPfbCgNpo8r8K4l1ibrfeBIS5u9OFG0AMA0kzVbYsD6LGw3DPcglyHnkAaFfZH89nC59nEpw/QpGru1dzjBnJUuZ0zTVisz6uaUhP2CQsSpH7260l67qk7A+OENz523q6Jjyo+hRlmD6rZQ2PFLqLuLCTnTdvHpNfw3YfhcAaZch6vxsRBETa/x927zkQoguAoMgshid3KyfHZrKtthBt4kPkBjMRC4Pjun7ofRthTg69goeASm6NRVq0RveXPqsg/uNgReeespSgHrAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao4vEfuUss+wruNsMoteLxmONX6/0zv8ugfa0l4RD/E=;
 b=KcVniVKR8fksWCOFjP6OTQjpNl/x7ZROLL/AOIamBnBRwfWz2Nl/OiP1qr/oykQ6Y+pKL9+5GqoLOu4Sxf1i/LaIQU3Yz+VvjxgumYpwz8Quazix99jV8UfSO0w2C8tg+2m/GbJd2SXQZ3WbX/btaj6gApKZbrkYCAszfOgc0Wg=
Received: from SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Wed, 31 Jan
 2024 20:12:42 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::6c) by SA0PR11CA0102.outlook.office365.com
 (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:12:41 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:12:39 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, <stable@vger.kernel.org>, Chaitanya Dhere
	<chaitanya.dhere@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>
Subject: [PATCH 03/21] drm/amd/display: set odm_combine_policy based on context in dcn32 resource
Date: Wed, 31 Jan 2024 15:11:09 -0500
Message-ID: <20240131201220.19106-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: b03c5ccb-603e-4978-7024-08dc2298faa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ngvdsYSZY5ShlwoXAU/6w8ASFOVZUD7ZK7QfY2Jbpx7CiLYebehel3QvO2Ytyzc4v0u6rXAUU5BP9iCtXAk07XBhzZXOAcaPan8+Ni0ri5zm83xCLGClf+5vS+GI8oHezURAfN6YA1AodBsvXkmrTiebTRlTJ/SMsmbmVjhxqPfB/fvKCGZ3Eb9GAVrSTBzcGIjLkDZOMW7jDbGQw5XSCSiRu5lBFnCpTYStOwEi2Rp9Dh8+lQY7oy1Vn1aRB97X2gajn/MsQw2XN3EKaRjpUMz9i+fiC/IQaPxtE6BjgnFUg4FrN1/THY4pVYkOK/OUiKYJYiGULZ1W8F4YckMwd1hmoKeiQjcs2HKV/owu23TM/C3XBqsCqs+K0uH//PqOgoBP5ZhvyOGux4CkKrwpF0WFCxyiFg75ZpvrTXg8x0vXXeiFVOSbZZ9QhEVyvRutX1hjtBO7jYyEH93M3Zhb0NOq3NY+CMc2IKgCDeE9yggYjlbroYTaFwBj+ADbTvAyzSzhBwou8H70++6EowN+gUyxHGhscPQdsyS4+9NiiO1tln2ALACDh+UBOhIsU1aa/4BqxbtzV2DtbM9PfDvWBvfOb9bqGW/ut2vW8I51HfK/81EpG7DT0dGdI18z2fP/lU1cBOH/cBF6LiEisDaP0tGs9Czf+ndduK0RVYyTiHYIgLPt3kqQOD1LhUG19pFNaTZnpfGCH6dnv7UAibph7IiZnB553Nq+oDsjhk0Xdm1z46oNmJtO2dso8NhJj9vqGdVg3NDyxDENex5k1mkJ0FLjHj1JdORt22VnmzNRisegFD3SKvvL3e7646AAYIDj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(44832011)(316002)(6916009)(356005)(2906002)(40460700003)(40480700001)(54906003)(4326008)(8676002)(8936002)(36756003)(36860700001)(47076005)(86362001)(5660300002)(70206006)(70586007)(82740400003)(81166007)(83380400001)(26005)(336012)(426003)(16526019)(1076003)(2616005)(6666004)(41300700001)(478600001)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:12:41.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03c5ccb-603e-4978-7024-08dc2298faa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When populating dml pipes, odm combine policy should be assigned based
on the pipe topology of the context passed in. DML pipes could be
repopulated multiple times during single validate bandwidth attempt. We
need to make sure that whenever we repopulate the dml pipes it is always
aligned with the updated context. There is a case where DML pipes get
repopulated during FPO optimization after ODM combine policy is changed.
Since in the current code we reinitlaize ODM combine policy, even though
the current context has ODM combine enabled, we overwrite it despite the
pipes are already split. This causes DML to think that MPC combine is
used so we mistakenly enable MPC combine because we apply pipe split
with ODM combine policy reset. This issue doesn't impact non windowed
MPO with ODM case because the legacy policy has restricted use cases. We
don't encounter the case where both ODM and FPO optimizations are
enabled together. So we decide to leave it as is because it is about to
be replaced anyway.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 15 ++++++++++----
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 20 ++++++++-----------
 .../dc/resource/dcn32/dcn32_resource.c        | 16 ++++++++++++++-
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a7981a0c4158..4edf7df4c6aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1289,7 +1289,7 @@ static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *contex
 	return updated;
 }
 
-static bool should_allow_odm_power_optimization(struct dc *dc,
+static bool should_apply_odm_power_optimization(struct dc *dc,
 		struct dc_state *context, struct vba_vars_st *v, int *split,
 		bool *merge)
 {
@@ -1393,9 +1393,12 @@ static void try_odm_power_optimization_and_revalidate(
 {
 	int i;
 	unsigned int new_vlevel;
+	unsigned int cur_policy[MAX_PIPES];
 
-	for (i = 0; i < pipe_cnt; i++)
+	for (i = 0; i < pipe_cnt; i++) {
+		cur_policy[i] = pipes[i].pipe.dest.odm_combine_policy;
 		pipes[i].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+	}
 
 	new_vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
@@ -1404,6 +1407,9 @@ static void try_odm_power_optimization_and_revalidate(
 		memset(merge, 0, MAX_PIPES * sizeof(bool));
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, new_vlevel, split, merge);
 		context->bw_ctx.dml.vba.VoltageLevel = *vlevel;
+	} else {
+		for (i = 0; i < pipe_cnt; i++)
+			pipes[i].pipe.dest.odm_combine_policy = cur_policy[i];
 	}
 }
 
@@ -1581,7 +1587,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		}
 	}
 
-	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
+	if (should_apply_odm_power_optimization(dc, context, vba, split, merge))
 		try_odm_power_optimization_and_revalidate(
 				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
 
@@ -2210,7 +2216,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		int i;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
-		dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
+		if (!dc->config.enable_windowed_mpo_odm)
+			dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
 
 		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
 		 * we have to re-calculate the DET allocation and run through DML once more to
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 1d51fed12e20..2eae2f3e846d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -427,22 +427,18 @@ struct pipe_ctx *resource_get_primary_dpp_pipe(const struct pipe_ctx *dpp_pipe);
 int resource_get_mpc_slice_index(const struct pipe_ctx *dpp_pipe);
 
 /*
- * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
- * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
- * the number of MPC "cuts" for the plane.
+ * Get the number of MPC slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an MPC combine
+ * pipe topology.
  */
-int resource_get_mpc_slice_count(const struct pipe_ctx *opp_head);
+int resource_get_mpc_slice_count(const struct pipe_ctx *pipe);
 
 /*
- * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
- * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for ODM combine. otherwise
- * the number of ODM "cuts" for the timing.
+ * Get the number of ODM slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an ODM combine
+ * pipe topology.
  */
-int resource_get_odm_slice_count(const struct pipe_ctx *otg_master);
+int resource_get_odm_slice_count(const struct pipe_ctx *pipe);
 
 /* Get the ODM slice index counting from 0 from left most slice */
 int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ac04a9c9a3d8..71cd20618bfe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1829,7 +1829,21 @@ int dcn32_populate_dml_pipes_from_context(
 		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
 		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		if (dc->config.enable_windowed_mpo_odm &&
+				dc->debug.enable_single_display_2to1_odm_policy) {
+			switch (resource_get_odm_slice_count(pipe)) {
+			case 2:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+				break;
+			case 4:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+				break;
+			default:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+			}
+		} else {
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		}
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;
-- 
2.43.0


