Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015075BFA1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGUHYa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGUHYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6758FC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1A46112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C09C433C8;
        Fri, 21 Jul 2023 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924267;
        bh=jPsXsu2jIasJ/O6ScjS7dGATVMBy8YaRRHh1jjtoah0=;
        h=Subject:To:Cc:From:Date:From;
        b=ZBoAIgMxaZCFcL2jiGHMAseLwnol+aaauIU4Q11RI1SKt/lDQ3BNTU48827VRq+lm
         RqKYxSqmKW7rOrNlHr4/EQ3rsG6Ggo9ysnEIncf6DTMrzkplzifV9Fu5lWdbOOkFDt
         94Mk56zokHVoQ9T0guVnbDoYD/SnoDHq5U0zG7yQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK" failed to apply to 6.4-stable tree
To:     Alvin.Lee2@amd.com, Jun.Lei@amd.com, Nevenko.Stupar@amd.com,
        alex.hung@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:24:17 +0200
Message-ID: <2023072117-racism-pacifist-57c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 84f14428b1e0d1f61776c5fcfdef181129533e0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072117-racism-pacifist-57c8@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84f14428b1e0d1f61776c5fcfdef181129533e0b Mon Sep 17 00:00:00 2001
From: Alvin Lee <Alvin.Lee2@amd.com>
Date: Thu, 27 Apr 2023 15:10:13 -0400
Subject: [PATCH] drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK
 modes

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

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 66f44a013fe5..958d27224f64 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -810,7 +810,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
-					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3314,7 +3315,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index 500b3dd6052d..d98e36a9a09c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -53,6 +53,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
+#define MIN_DCFCLK_FREQ_MHZ 200
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;

