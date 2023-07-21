Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1C75BF97
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGUHXk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGUHXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B283189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1926112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1651C433C7;
        Fri, 21 Jul 2023 07:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924217;
        bh=/p05k/7YST9iQIT3zQ2lR7vd/xqgIig819P/isXmZ/I=;
        h=Subject:To:Cc:From:Date:From;
        b=G9eGDRmYgpWXwWxQXsatkDImTR8pzjfUQcgQ1j0W/9Q0AOJ7+Q6MYaRIATzqJ3eDu
         jQEDuIVB7Dvj/yc5V/0dq7tsXg4Yyl6bSI7CLbvFeADFLemKM6G18pklvH7R6pngRj
         bjzg5i/So8NtiKDl4Jjbpr5XOYZ8PVh5KHaj6RSg=
Subject: FAILED: patch "[PATCH] drm/amd/display: Keep disable aux-i delay as 0" failed to apply to 6.4-stable tree
To:     michael.strauss@amd.com, Aric.Cyr@amd.com, George.Shen@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:23:26 +0200
Message-ID: <2023072126-foil-stardust-93cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5a096b73c8fed3a9987ba15378285df360e2284b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072126-foil-stardust-93cf@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a096b73c8fed3a9987ba15378285df360e2284b Mon Sep 17 00:00:00 2001
From: Michael Strauss <michael.strauss@amd.com>
Date: Tue, 11 Apr 2023 12:44:54 -0400
Subject: [PATCH] drm/amd/display: Keep disable aux-i delay as 0

[WHY]
Current Aux-I sequence checks for local_sink which isn't populated on
MST links

[HOW]
Leave disable aux-i delay as 0 for MST cases

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fb6c938c6dab..15faaf645b14 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -233,8 +233,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
 	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
-	uint32_t pre_disable_intercept_delay_ms =
-			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
@@ -245,6 +244,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
+	if (link->local_sink)
+		pre_disable_intercept_delay_ms =
+				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
@@ -595,10 +598,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	const uint8_t vendor_lttpr_write_data_adicora_eq3[4] = {0x1, 0x55, 0x63, 0x68};
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
-	uint32_t pre_disable_intercept_delay_ms =
-			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
-
-
+	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
@@ -607,6 +607,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
+	if (link->local_sink)
+		pre_disable_intercept_delay_ms =
+				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);

