Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8875BF9B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGUHXw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGUHXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA4189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351876112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0EDC433C8;
        Fri, 21 Jul 2023 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924229;
        bh=WQ8DJBV523fzshw0Fq4k6mC/vfDGtsyCLwR9I4B3Kcc=;
        h=Subject:To:Cc:From:Date:From;
        b=IpIIlLsd8F++qsiLH/7hbySsQLnsiBmBmBRkYKTmIG+s/8hvUj1SkqqQHoBbitEsn
         7evqgRPPH3qruwrz8P8asLXYyD23W3at2o/l00z9d3+4xZslghT2IJdgrPOaibvBRh
         0AwXSP9kuoVIBLrviNYMpStRLDSUKkpUSxOPvS8g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Change default Z8 watermark values" failed to apply to 6.1-stable tree
To:     sancchen@amd.com, HaoPing.Liu@amd.com, Nicholas.Kazlauskas@amd.com,
        alexander.deucher@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:23:38 +0200
Message-ID: <2023072138-henchman-crusader-a6ce@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9749a42db74c3400e0526d9a39fa0324abfd0d66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072138-henchman-crusader-a6ce@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9749a42db74c ("drm/amd/display: Change default Z8 watermark values")
9b0f51e8449f ("drm/amd/display: Update Z8 SR exit/enter latencies")
fa24e116f1ce ("drm/amd/display: Update Z8 watermarks for DCN314")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9749a42db74c3400e0526d9a39fa0324abfd0d66 Mon Sep 17 00:00:00 2001
From: Leo Chen <sancchen@amd.com>
Date: Thu, 13 Apr 2023 17:34:24 -0400
Subject: [PATCH] drm/amd/display: Change default Z8 watermark values

[Why & How]
Previous Z8 watermark values were causing flickering and OTC underflow.
Updating Z8 watermark values based on the measurement.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 19370b872a91..1d00eb9e73c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -149,8 +149,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 210.0,
-	.sr_enter_plus_exit_z8_time_us = 310.0,
+	.sr_exit_z8_time_us = 268.0,
+	.sr_enter_plus_exit_z8_time_us = 393.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,

