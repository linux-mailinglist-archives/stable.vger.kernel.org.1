Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7047036D1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbjEOROZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbjEOROK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A3100DE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24FDF62B83
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9B4C433EF;
        Mon, 15 May 2023 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170746;
        bh=TWL+qJQugE93zVVjjl/DucUP3g1jjUx+LRRUZuSZzDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wwwi80CWxehsdAWcuVEsCDCvxL6xAg+1jOrTxfCSW8/sbjWnLFwonZFZ6nms3hoip
         EXaRFpgCwwsOppAdlJ6kaYhstqK8AzuGQ962UHUc6yJY9GNs1fnnQT1yMycdgFhI9f
         27ikXe8PgkbbWIS95pGFmEK/otCDWRlwLieZeN4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>, Leo Chen <sancchen@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 211/239] drm/amd/display: Change default Z8 watermark values
Date:   Mon, 15 May 2023 18:27:54 +0200
Message-Id: <20230515161728.057662301@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Leo Chen <sancchen@amd.com>

[ Upstream commit 8f586cc16c1fc3c2202c9d54563db8c7ed365f82 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 2c99193b63fa6..4f91e64754239 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -148,8 +148,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
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
-- 
2.39.2



