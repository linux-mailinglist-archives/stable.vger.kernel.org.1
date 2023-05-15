Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA670355E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbjEOQ6S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjEOQ6P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B80768E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F46D61E7F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BD0C433D2;
        Mon, 15 May 2023 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169893;
        bh=UFMDJh7KJWjZHQPcpfDQDnUz68/Uyt3gAUDuOqNaUAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIGCGnD2uOEJTmLVpW/WwikFLVOtrz4PT1G9DrDsbqBpeR1yImG0U6+NauyrnKr3a
         s/RLojX/m180YMVIyhGxAj/F2IwOjgyMSdkazSLEz0/FS/NuGFW0EYyTPTlDLVl9Ev
         KquIpaRZcyZdGMQtlah9ISDSB8G9A5LzNxHcBdjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.3 204/246] drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes
Date:   Mon, 15 May 2023 18:26:56 +0200
Message-Id: <20230515161728.727247271@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Alvin Lee <Alvin.Lee2@amd.com>

commit b504f99ccaa64da364443431e388ecf30b604e38 upstream.

[Description]
- Due to bandwidth / arbitration issues at 200Mhz DCFCLK,
  we want to enforce minimum 60us of prefetch to avoid
  intermittent underflow issues
- Since 60us prefetch is already enforced for UCLK DPM0,
  and many DCFCLK's > 200Mhz are mapped to UCLK DPM1, in
  theory there should not be any UCLK DPM regressions by
  enforcing greater prefetch

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c |    5 +++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -810,7 +810,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleep
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
-					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3309,7 +3310,7 @@ void dml32_ModeSupportAndSystemConfigura
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -53,6 +53,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
+#define MIN_DCFCLK_FREQ_MHZ 200
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;


