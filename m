Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A49726C18
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjFGUaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjFGUaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92971FDB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EB56644B1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4A1C433EF;
        Wed,  7 Jun 2023 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169815;
        bh=qJYWbFs031S9YRto7y5Vk//A1evh4fxskVfSmDMNcpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cE2troqqrP5eFHgU4B2R/JVeYEpjFu0wHMkBoFFyBMrxE6V5d8b2b4+N06cvzWiss
         ESGgrCmK7mIw07VJ7thJnrav3achRSRngt3lQcvykk0EvFl98H+VEZoT67fX2yqBXo
         fi02cw2pzoMtKU1ylveW+thQuBk6RUobDPi2IgQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Huang <Tim.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 223/286] drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp
Date:   Wed,  7 Jun 2023 22:15:22 +0200
Message-ID: <20230607200930.558087004@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Huang <Tim.Huang@amd.com>

commit f1373a97a41f429e0095d4be388092ffa3c1a157 upstream.

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels that from
the DFPstateTable are given the reversed orders by PMFW. Like the
memory DPM clocks that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1000,7 +1000,7 @@ out:
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -1033,7 +1033,8 @@ static int yellow_carp_print_clk_levels(
 			goto print_clk_out;
 
 		for (i = 0; i < count; i++) {
-			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				goto print_clk_out;
 


