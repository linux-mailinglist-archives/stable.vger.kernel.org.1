Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF79070150A
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEMHkf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjEMHke (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46AD65B8
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C52E61AC0
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2F9C433D2;
        Sat, 13 May 2023 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963631;
        bh=CpIs35yh8rdATvyxpE4Ov2NfBnnQ6JEiUqcgH2zLle4=;
        h=Subject:To:Cc:From:Date:From;
        b=r3qJSDAiQGqtDdCeEHW59KDiyv32RETpcWbFCNkwDTE+/dNfSvQwOi/3vop4BoDnI
         NfInJCFLnxoO9y4UUMC5Xjg+8GZSAvlDU/hMlQxSJi7rKJzO/59YnvLK7/6SMDpDaP
         OOZaalL+F3EUwz1I/RJ3q5HAFdrTFxGtkhwUdIbo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix DP MST sinks removal issue" failed to apply to 6.3-stable tree
To:     Cruise.Hung@amd.com, Wenjing.Liu@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:21:01 +0900
Message-ID: <2023051301-handgrip-critter-a2d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x deaccddaf4921faa5dfc71e8936dd8daa98ba33d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051301-handgrip-critter-a2d2@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

deaccddaf492 ("drm/amd/display: Fix DP MST sinks removal issue")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From deaccddaf4921faa5dfc71e8936dd8daa98ba33d Mon Sep 17 00:00:00 2001
From: Cruise Hung <Cruise.Hung@amd.com>
Date: Thu, 2 Mar 2023 10:33:51 +0800
Subject: [PATCH] drm/amd/display: Fix DP MST sinks removal issue

[Why]
In USB4 DP tunneling, it's possible to have this scenario that
the path becomes unavailable and CM tears down the path a little bit late.
So, in this case, the HPD is high but fails to read any DPCD register.
That causes the link connection type to be set to sst.
And not all sinks are removed behind the MST branch.

[How]
Restore the link connection type if it fails to read DPCD register.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 13e5222249ec..fee71ebdfc73 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -853,6 +853,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	struct dc_sink *prev_sink = NULL;
 	struct dpcd_caps prev_dpcd_caps;
 	enum dc_connection_type new_connection_type = dc_connection_none;
+	enum dc_connection_type pre_connection_type = link->type;
 	const uint32_t post_oui_delay = 30; // 30ms
 
 	DC_LOGGER_INIT(link->ctx->logger);
@@ -955,6 +956,8 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			}
 
 			if (!detect_dp(link, &sink_caps, reason)) {
+				link->type = pre_connection_type;
+
 				if (prev_sink)
 					dc_sink_release(prev_sink);
 				return false;
@@ -1236,11 +1239,16 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 	bool is_delegated_to_mst_top_mgr = false;
 	enum dc_connection_type pre_link_type = link->type;
 
+	DC_LOGGER_INIT(link->ctx->logger);
+
 	is_local_sink_detect_success = detect_link_and_local_sink(link, reason);
 
 	if (is_local_sink_detect_success && link->local_sink)
 		verify_link_capability(link, link->local_sink, reason);
 
+	DC_LOG_DC("%s: link_index=%d is_local_sink_detect_success=%d pre_link_type=%d link_type=%d\n", __func__,
+				link->link_index, is_local_sink_detect_success, pre_link_type, link->type);
+
 	if (is_local_sink_detect_success && link->local_sink &&
 			dc_is_dp_signal(link->local_sink->sink_signal) &&
 			link->dpcd_caps.is_mst_capable)

