Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9A70C70A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjEVTZO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjEVTZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF8119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D56762884
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22838C433D2;
        Mon, 22 May 2023 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783509;
        bh=lZ22TH6DDbeQuKhi9D1A598/5BopvKaYtD271lXTmmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEKZR7zY/xKvHwkpkEBH3H01XTgVaVLI1tlcnh2toycqy/tB4CEMtkP74MdSl6Ih4
         oiuYxyKN7wRYTDXacm38X7HmmTV6PlYwar1MCx93dtdmJYBFQMv+Zhsxkt77qqq4Nv
         B6hX63bHr10Zprj3trrcA97pGK65RrCFObMw5ad4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Paul Hsieh <Paul.Hsieh@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/292] drm/amd/display: Correct DML calculation to follow HW SPEC
Date:   Mon, 22 May 2023 20:07:05 +0100
Message-Id: <20230522190407.659770570@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul Hsieh <Paul.Hsieh@amd.com>

[ Upstream commit 385c3e4c29e1d4ce8f68687a8c84621e4c0e0416 ]

[Why]
In 2560x1600@240p eDP panel, driver use lowest voltage level
to play 1080p video cause underflow. According to HW SPEC,
the senario should use high voltage level.

[How]
ChromaPre value is zero when bandwidth validation.
Correct ChromaPre calculation.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 49da8119b28e9..861f32b3248e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4866,7 +4866,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NoUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 77094035a26af..cf8f3d690fa66 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5189,7 +5189,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 69516cfdbc64a..4998b211ccac7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5286,7 +5286,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e02e9d4b04a95..2bb768413c92a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3333,7 +3333,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							/* Output */
 							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
-							&mode_lib->vba.UrgentBurstFactorChroma[k],
+							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
 				}
 
-- 
2.39.2



