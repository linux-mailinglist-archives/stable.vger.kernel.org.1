Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C585477AC22
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjHMV3m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjHMV3m (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2868C10E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC02962ADF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34B8C433C8;
        Sun, 13 Aug 2023 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962183;
        bh=1r+USbZpRoTQdVCPL6SBVDZviZdJRuvBfdZVNV48bPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D50JM3OocpIhahtlq5jb/UAm1J28tRZnFmpEObfTDcZjMqB6UhU2CvUlifJJfsBkT
         DDYFNz4woRPM+M1YK8OHZC3jbkcnNDofJR4M6khNU/TCItoBF9Mlm/w8hDWGbPBU/z
         uZEUEB2R88xENNjsd/mgdgIvk2WDWePqAxuMoyyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Mastan.Katragadda@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 143/206] drm/amd/display: Dont show stack trace for missing eDP
Date:   Sun, 13 Aug 2023 23:18:33 +0200
Message-ID: <20230813211729.127429766@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 7ad1dfc144cbf62702fd07838da8fd8a77921083 upstream.

Some systems are only connected by HDMI or DP, so warning related to
missing eDP is unnecessary.  Downgrade to debug instead.

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Fixes: 6d9b6dceaa51 ("drm/amd/display: only warn once in dce110_edp_wait_for_hpd_ready()")
Reported-by: Mastan.Katragadda@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -780,7 +780,8 @@ void dce110_edp_wait_for_hpd_ready(
 	dal_gpio_destroy_irq(&hpd);
 
 	/* ensure that the panel is detected */
-	ASSERT(edp_hpd_high);
+	if (!edp_hpd_high)
+		DC_LOG_DC("%s: wait timed out!\n", __func__);
 }
 
 void dce110_edp_power_control(


