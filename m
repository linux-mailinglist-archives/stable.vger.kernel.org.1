Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272557D31C1
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjJWLMw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjJWLMs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC0D7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D2AC433C7;
        Mon, 23 Oct 2023 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059566;
        bh=ZkYvoKq+U8k43LB/RgYrVAyUCXPT2wb786C62elUsf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWAizt8J5ZTls1xMlRgflFPYTJKdI2TlEfHSCjJ014I5puYgc/bsA5+S5afDUDWKl
         yH5p6fUOoBnUOEBExuPPIEuA6B3kM55Gm2RQWqMOxaAcUuWeaVg3AmbdXY6q08VbD+
         CW4ZnEmoH07IlHJuvE8P9aTeyLGgh6QKIC76mah4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mika Kahola <mika.kahola@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 220/241] drm/i915/cx0: Only clear/set the Pipe Reset bit of the PHY Lanes Owned
Date:   Mon, 23 Oct 2023 12:56:46 +0200
Message-ID: <20231023104839.215621628@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khaled Almahallawy <khaled.almahallawy@intel.com>

[ Upstream commit 5e4c16fe08c8b894b258f4110349dc9b642669f9 ]

Currently, with MFD/pin assignment D, the driver clears the pipe reset bit
of lane 1 which is not owned by display. This causes the display
to block S0iX.

By not clearing this bit for lane 1 and keeping whatever default, S0ix
started to work. This is already what the driver does at the end
of the phy lane reset sequence (Step#8)

Bspec: 65451
Fixes: 619a06dba6fa ("drm/i915/mtl: Reset only one lane in case of MFD")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231005001310.154396-1-khaled.almahallawy@intel.com
(cherry picked from commit 4a07f063d20c46524f00976f4537de72d9f31c4e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 719447ce86e70..974dd52e720c1 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2554,8 +2554,7 @@ static void intel_cx0_phy_lane_reset(struct drm_i915_private *i915,
 		drm_warn(&i915->drm, "PHY %c failed to bring out of SOC reset after %dus.\n",
 			 phy_name(phy), XELPDP_PORT_BUF_SOC_READY_TIMEOUT_US);
 
-	intel_de_rmw(i915, XELPDP_PORT_BUF_CTL2(port),
-		     XELPDP_LANE_PIPE_RESET(0) | XELPDP_LANE_PIPE_RESET(1),
+	intel_de_rmw(i915, XELPDP_PORT_BUF_CTL2(port), lane_pipe_reset,
 		     lane_pipe_reset);
 
 	if (__intel_de_wait_for_register(i915, XELPDP_PORT_BUF_CTL2(port),
-- 
2.42.0



