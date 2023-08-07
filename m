Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6B771842
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjHGCVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHGCVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21B1709
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjwW/Uxefj1bsHL8MeKs9b9VdHRMHU7lhZ6WrRWEmm82rLbuPk1flmaVerHvKjykvYKlIxKknbGCcD+2rljM/kVrR3YT8iczDm+TH5f1B7YUuZdMpWABJB+IQYFq0SVUa1sUFPy+wpozq4mXReMhKANi2MSIHxF+BOuZm4tn00rfQfp6o8419LcFHWj/ySjrwbYY74WHBvjwo7HtnrNBcGUW8mMhPiNlW+IhvR9EooKu0nq/0SZaxqGfhZRGwDGw6EIu1ZLevhsHb1AsQmJHuUmKZg4XiOP0wN+yEP7tWUW5rghcGEIRLHa9XFCpOMGJRe/mGY63y6OqNizzTg+m5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRZ5/fA4RXIGBCSLwoUyz9yNA2YVsE0wgu9xNOgnXhA=;
 b=Pbd702ycYjADxhsMtMjs4ZdJfbtbJtsWdHXt+QikrZjlbstLkj8tr0MZ0rWDDoJsTkri4WHOWRoaQnz18hMb2UZxnX6UowMUo+3vn3wFUMjEQmfJtAQJDR+MM/kaxtWZLlBCoehfe5NfccrFK7G9DzFQAwIxqnVKMvqXgfvelEcKeA9g2vohPQulIrfGZNbtWnG1vvVn9obDCccvsf6raNtWCTYPyCJ1CUI6scOOO9gCAamHA4RUBvoyjq5JLaXfMhax91bzZOCYBFITsWw4egTSjOBtKDFFHnuE9Ib6ZOCeeXSKVvT2/Id3VdBZmSYCe9GJRpYc8opFfd47K9gfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRZ5/fA4RXIGBCSLwoUyz9yNA2YVsE0wgu9xNOgnXhA=;
 b=BqDYOSBrXIOMq1hEKutgpA2CxdNbxP9DqDV3R5FY6F1qwmoZ2zVpVqjI2bHhsGoujVD5i/18E6SJHQhExNqt1RknQJeTFOSqR+lkI7KrxN/3j8seD3dcJIMkhyauQp45xydXiRNZOZqC6YBk1DCp5sT1m1/pFmPyW8eE4moIYjo=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:33 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9c) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Mon, 7 Aug 2023 02:21:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 19:21:07 -0700
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:05 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 02/10] drm/amd/display: Add function for validate and update new stream
Date:   Mon, 7 Aug 2023 10:20:47 +0800
Message-ID: <20230807022055.2798020-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7e7d8c-2f99-44c3-5825-08db96ed05d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvKdS+OeooE+cAxyLHWn6XaQuUPjZVOi4OtzV/cPhfBCJFhtQC5b+9fRkYhZx9sjCIzAXcr20nafZPT9BGn4dlaz1LP9MbCEi52a8vgUo09u/lbv7VJ0q/CX5PnBLVIY4YAGu9pQsKKgWxw4RFiQRQyUi2JvxTeHNb2+GwoiUtDoi4211XC3h5RA+jvoUgXZQAc5H3EnG+h3Ag5GQo07Y4rJqmZzdoB+zMGBbv57zA1O6bM2FQQ/JaeZN3xH5Pl8FWetFVz3SxJlcS6occ7YoXAP49I3bDbUd8cowAZY/m8Jo0l6U0xK/P6KnF/IWilrovdIzInWbJpkzUgQ1M1/TpelcsEt76IHs2cBDz1GaUJVP/lFsAiQMY6+z13gz767kkDAwqAhmVUDCxgSMq4aCtLiCmA1roQnfCvXLVXb0VrtX+kv2oE8a/BUH5U8ju7zr5SBJ6kxKZNR94Aa9kUgzSJYeY5XMFw8zNhEHeqHISshG+8Fi2MdYKrHpuL7dk0JgPodgc5tdR4mzLF63J1AfaH0pLOsTPn7QBgJf06kyqAhSDnGpwF8AwxePxJfQlVt5GuellK23/3FRv4Wbv+j0EhbN6uhdVCx1lcnIV2DmJVC8MCYIcVdfIjNNFHvQQT76JlbWtABXOzUQZAPKRLMsjNeQNcO7TWr8LvVqfgem3UwJ7B72PuXVLplojCxKqfqhOtfS0Fj3xwo0m2aGzKSDJW1RdSRP023gBqoyix+7ev+1bqcou4MreyDBwMiNMA5ZtS7B9e0xUXHhE2IudteBujwyI5sMiZBU9IoEE0ywNg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(1800799003)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(54906003)(2906002)(6916009)(4326008)(5660300002)(316002)(8936002)(8676002)(336012)(70586007)(70206006)(86362001)(478600001)(81166007)(82740400003)(6666004)(7696005)(41300700001)(356005)(15650500001)(36756003)(1076003)(26005)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:35.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7e7d8c-2f99-44c3-5825-08db96ed05d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

