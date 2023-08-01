Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132E276AF59
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjHAJqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjHAJow (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918CE48
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A91614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C045C433C9;
        Tue,  1 Aug 2023 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882952;
        bh=pVBiHBp9KPGK6aJm1+lqMksAxpyJnbSdv2Kg5Ijs0aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qADJDgWsz8u9loboFeFYPc8rZpifwFE8CCbwzo6fA/ri1HAAl0QxNmCBxIv62EGQa
         UKriKysGDQnP6oGPO5urrJIMm02OC/2LV0kDzvh5eSQJDS4407FJqSI8ptlxIitJPK
         HCyoVI0qk1QmDXdsUQHaQI1hnqMtqvp9WEkAvprM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        George Shen <George.Shen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 033/239] drm/amd/display: Keep disable aux-i delay as 0
Date:   Tue,  1 Aug 2023 11:18:17 +0200
Message-ID: <20230801091926.804342923@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 5a096b73c8fed3a9987ba15378285df360e2284b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../link_dp_training_fixed_vs_pe_retimer.c       | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fb6c938c6dab1..15faaf645b145 100644
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
-- 
2.39.2



