Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF04779933
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHKVIw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjHKVIt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46CEE
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6e87/nB4FFCeQyZYuprXOL2m5k34xCgN4XtJpdaOXiJkaNS20KQZRavjrTiVMHZsc2oY3ry9MaZ0G9DxoNI7jgaCnPGd4o8ZLFXPZxyKkYokOC53ssO7gh2HyvNw3QfIIclEywjnL+TbcilV7mlPy/NQKqR4e9g9OG74qjb9HXcHzpp76DcPq/iPpe+kyYqATPvJMkgfr2MrCVaD8cEWrIwpixDYdTEh9PLZKBqgwVgSwyTxK72LxqqrnAydGFvcernRX5/Sif7AwmE7xUv1nlfBPoncqxafN3i1uMk48kEUPrafjpM2y2JPdaPf5msdJl4pLaKB+JHiOPCBMwENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StpE2CsKhJtwSRla2fMOWM6Y8Xf5LbtgC5L3Z9FxjVA=;
 b=lbdyhwdYsDdj03xW3jsntwI30lNvVtPfn8AAT8wMWBRHr+0lv4LCOPlklrKMLqo8jtFxnG4heTeTM49hOkOogm8vtHqvlqwoaHPETkYbxE0tZYgGfPneTOYleSYzy/mQ6bSfs3G15UOnzc1tAhGR/cElhafrL74nvNkawdEEEDksCFtn75mYGbhjx0OkYRMGvQe7rUHDSi3Q9inw+alATOEG44riowO/X0A+p8gjcq2sVfXbQKFpn2kF3RMR7Eu8GpSdd4Sln/5v/hysho5nbisvX0RtuUEixwF0wCrXxfGKADwiJmmEo7gAnBpEE9aOGzRwwVm6hnZGlgmwnS9oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StpE2CsKhJtwSRla2fMOWM6Y8Xf5LbtgC5L3Z9FxjVA=;
 b=bU2xUedSjsTjOxQpsJlNGxM/zVER21jvpFxu4AUP0E96WmXN8nfO/O2yDhVCFlglOsiCS5bXl5tj2lM/g0LFybg4gzy/XeBCMf9MLjYbu5NEXX8LIlu4wrtLUO+vNNGL120RyIevspRcUoc2WgrzH9MLtvsxJi4G5mGSYoKpmmA=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 21:08:46 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::a) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 02/10] drm/amd/display: Add function for validate and update new stream
Date:   Fri, 11 Aug 2023 16:07:00 -0500
Message-ID: <20230811210708.14512-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: b912dbfe-7067-4955-7cf8-08db9aaf2690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw9THs4z2j3oJkHj2Vx8UGhFKjQsWyciZjLXf+tHwTgZOxLZl6c+IBydm+HwMYTXULiwMqc020jOlbdIsoWkWK3FzlLPe8SDhH5EQ/8hrWX6cvuyCi6A3L/RbHXzH1slwKg+5OVRQ3NfZkvZaBZcvNTv0eox958dKtsihRuaGVOXJH9Dpob+7XfJrd5uA0ZP4iclscGN8F5xh/thOmIhpEHjV20gB6b87Y+RzaMg0BjoANxhWVNHqtn9FCB+CEpXOxUbMfYsawlT+9G7iHpdDG9TLCbSYZeNu/mWlcB/i9yJqwR/yEFmqaD1wy6o25EFW3Erwfws0RUia2rhbzvP1HZUTZsdPrN7DKKa9ts0asGdMX1GmSqEVd3H/OjVW1ai+l4ZFLfokSFsDJzAO6oj6U9Ocz8y7iHS82X1XhBqvbAJhY5GL6jHHXypWulC3Ds3FD0QcLnHk5IA9eFr2RnuxzY5dVjflWTKkn5PKBcFaj5Sq+QcEBch19a9xga+hoRR9LFcwIMF0+hR9Dh0eFdydrRq9X0YQkYLZBBbBQH+lmigLlcC09mxfztsOl1iaeLf00r8TDo+72Qt8U8hD3DwFGsZiCH/Ci5VrCJXiEjrorPf76od2DL1/XwgKN+eGyVrBzmWW36uP5Feibs8inX0ZChYWkdFasrg6a2Y9HOXBc2/Gh5OHcBIaY1n7MTHNtFIqH93QebHLgDrmuF0ujEMCJODiSv5TnZrbsAeTymuTO/d7TTUNioSrgiVPqddP/kB0R0A5RZDjjUe3jneJ1Tiww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(1800799006)(451199021)(186006)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(83380400001)(1076003)(26005)(16526019)(2616005)(36860700001)(47076005)(15650500001)(41300700001)(70206006)(70586007)(54906003)(2906002)(6916009)(5660300002)(316002)(44832011)(8676002)(4326008)(8936002)(478600001)(6666004)(7696005)(40480700001)(81166007)(82740400003)(356005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:45.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b912dbfe-7067-4955-7cf8-08db9aaf2690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

DC stream can be seen as a representation of the DCN backend or the data
struct that represents the center of the display pipeline. The front end
(i.e., planes) is connected to the DC stream, and in its turn, streams
are connected to the DC link. Due to this dynamic, DC must handle the
following scenarios:

1. A stream is removed;
2. A new stream is created;
3. An unchanged stream had some updates on its planes.

These combinations require that the new stream data struct become
updated and has a valid global state. For handling multiple corner cases
associated with stream operations, this commit introduces a function
dedicated to manipulating stream changes and invokes the state
validation function after that.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a5e39ae27c3a305c6aafc0e423b0cb2c677facde)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 219 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 3 files changed, 227 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9b7ddd0e10a5..753c07ab54ed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1987,21 +1987,17 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	dc_resource_state_copy_construct_current(dc, context);
 
-	/*
-	 * Previous validation was perfomred with fast_validation = true and
-	 * the full DML state required for hardware programming was skipped.
-	 *
-	 * Re-validate here to calculate these parameters / watermarks.
-	 */
-	res = dc_validate_global_state(dc, context, false);
+	res = dc_validate_with_context(dc, set, stream_count, context, false);
 	if (res != DC_OK) {
-		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
-			     dc_status_to_str(res), res);
-		return res;
+		BREAK_TO_DEBUGGER();
+		goto fail;
 	}
 
 	res = dc_commit_state_no_check(dc, context);
 
+fail:
+	dc_release_state(context);
+
 context_alloc_fail:
 
 	DC_LOG_DC("%s Finished.\n", __func__);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a26e52abc989..613db2da353a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2616,15 +2616,226 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 	return dc->res_pool->res_cap->num_dsc > 0;
 }
 
+static bool planes_changed_for_existing_stream(struct dc_state *context,
+					       struct dc_stream_state *stream,
+					       const struct dc_validation_set set[],
+					       int set_count)
+{
+	int i, j;
+	struct dc_stream_status *stream_status = NULL;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i] == stream) {
+			stream_status = &context->stream_status[i];
+			break;
+		}
+	}
+
+	if (!stream_status)
+		ASSERT(0);
+
+	for (i = 0; i < set_count; i++)
+		if (set[i].stream == stream)
+			break;
+
+	if (i == set_count)
+		ASSERT(0);
+
+	if (set[i].plane_count != stream_status->plane_count)
+		return true;
+
+	for (j = 0; j < set[i].plane_count; j++)
+		if (set[i].plane_states[j] != stream_status->plane_states[j])
+			return true;
+
+	return false;
+}
+
+/**
+ * dc_validate_with_context - Validate and update the potential new stream in the context object
+ *
+ * @dc: Used to get the current state status
+ * @set: An array of dc_validation_set with all the current streams reference
+ * @set_count: Total of streams
+ * @context: New context
+ * @fast_validate: Enable or disable fast validation
+ *
+ * This function updates the potential new stream in the context object. It
+ * creates multiple lists for the add, remove, and unchanged streams. In
+ * particular, if the unchanged streams have a plane that changed, it is
+ * necessary to remove all planes from the unchanged streams. In summary, this
+ * function is responsible for validating the new context.
+ *
+ * Return:
+ * In case of success, return DC_OK (1), otherwise, return a DC error.
+ */
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate)
+{
+	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
+	int old_stream_count = context->stream_count;
+	enum dc_status res = DC_ERROR_UNEXPECTED;
+	int unchanged_streams_count = 0;
+	int del_streams_count = 0;
+	int add_streams_count = 0;
+	bool found = false;
+	int i, j, k;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	/* First build a list of streams to be remove from current context */
+	for (i = 0; i < old_stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		for (j = 0; j < set_count; j++) {
+			if (stream == set[j].stream) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			del_streams[del_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Second, build a list of new streams */
+	for (i = 0; i < set_count; i++) {
+		struct dc_stream_state *stream = set[i].stream;
+
+		for (j = 0; j < old_stream_count; j++) {
+			if (stream == context->streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			add_streams[add_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Build a list of unchanged streams which is necessary for handling
+	 * planes change such as added, removed, and updated.
+	 */
+	for (i = 0; i < set_count; i++) {
+		/* Check if stream is part of the delete list */
+		for (j = 0; j < del_streams_count; j++) {
+			if (set[i].stream == del_streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			/* Check if stream is part of the add list */
+			for (j = 0; j < add_streams_count; j++) {
+				if (set[i].stream == add_streams[j]) {
+					found = true;
+					break;
+				}
+			}
+		}
+
+		if (!found)
+			unchanged_streams[unchanged_streams_count++] = set[i].stream;
+
+		found = false;
+	}
+
+	/* Remove all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!dc_rem_all_planes_for_stream(dc,
+							  unchanged_streams[i],
+							  context)) {
+				res = DC_FAIL_DETACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	/* Remove all planes for removed streams and then remove the streams */
+	for (i = 0; i < del_streams_count; i++) {
+		/* Need to cpy the dwb data from the old stream in order to efc to work */
+		if (del_streams[i]->num_wb_info > 0) {
+			for (j = 0; j < add_streams_count; j++) {
+				if (del_streams[i]->sink == add_streams[j]->sink) {
+					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
+					for (k = 0; k < del_streams[i]->num_wb_info; k++)
+						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
+				}
+			}
+		}
+
+		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
+			res = DC_FAIL_DETACH_SURFACES;
+			goto fail;
+		}
+
+		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+	}
+
+	/* Add new streams and then add all planes for the new stream */
+	for (i = 0; i < add_streams_count; i++) {
+		calculate_phy_pix_clks(add_streams[i]);
+		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+
+		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
+			res = DC_FAIL_ATTACH_SURFACES;
+			goto fail;
+		}
+	}
+
+	/* Add all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
+				res = DC_FAIL_ATTACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	res = dc_validate_global_state(dc, context, fast_validate);
+
+fail:
+	if (res != DC_OK)
+		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
+			       __func__,
+			       res);
+
+	return res;
+}
 
 /**
- * dc_validate_global_state() - Determine if HW can support a given state
- * Checks HW resource availability and bandwidth requirement.
+ * dc_validate_global_state() - Determine if hardware can support a given state
+ *
  * @dc: dc struct for this driver
  * @new_ctx: state to be validated
  * @fast_validate: set to true if only yes/no to support matters
  *
- * Return: DC_OK if the result can be programmed.  Otherwise, an error code.
+ * Checks hardware resource availability and bandwidth requirement.
+ *
+ * Return:
+ * DC_OK if the result can be programmed. Otherwise, an error code.
  */
 enum dc_status dc_validate_global_state(
 		struct dc *dc,
@@ -3757,4 +3968,4 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 	}
 
 	return true;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6409b8d8ff71..a4540f83aae5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1298,6 +1298,12 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
 
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate);
+
 bool dc_set_generic_gpio_for_stereo(bool enable,
 		struct gpio_service *gpio_service);
 
-- 
2.34.1

