Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C20775B14
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjHILOJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjHILOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4E1724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A20962457
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8903AC433C7;
        Wed,  9 Aug 2023 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579646;
        bh=ahnYk5PkbDioxIac6Ms8ADvXbpGtLAaHuoak0y36azY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0cgFCBbXUfmi09jv4hZgUm6kj0DnMqhacMHLj9z7zqwbpKHhJVO3NohBY3qGc5He
         yxHi4u0EfL1RqjVhp3K/P/Epc90f5r3NwlGgkpbbyG/TjCK4dZDaZJ5XR4YVUfKd5b
         9E8jj3opWAo2EPF99VoWp2Se7AEGYL6+ZG1R7hkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/323] drm/radeon: fix possible division-by-zero errors
Date:   Wed,  9 Aug 2023 12:38:23 +0200
Message-ID: <20230809103701.136934896@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 1becc57cd1a905e2aa0e1eca60d2a37744525c4a ]

Function rv740_get_decoded_reference_divider() may return 0 due to
unpredictable reference divider value calculated in
radeon_atom_get_clock_dividers(). This will lead to
division-by-zero error once that value is used as a divider
in calculating 'clk_s'.
While unlikely, this issue should nonetheless be prevented so add a
sanity check for such cases by testing 'decoded_ref' value against 0.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

v2: minor coding style fixes (Alex)
In practice this should actually happen as the vbios should be
properly populated.

Fixes: 66229b200598 ("drm/radeon/kms: add dpm support for rv7xx (v4)")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/cypress_dpm.c | 8 ++++++--
 drivers/gpu/drm/radeon/ni_dpm.c      | 8 ++++++--
 drivers/gpu/drm/radeon/rv740_dpm.c   | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 3eb7899a4035b..2c637e04dfebc 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -558,8 +558,12 @@ static int cypress_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index a7273c01de34b..2a9d415400f79 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2239,8 +2239,12 @@ static int ni_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/rv740_dpm.c
index afd597ec50858..50290e93c79dc 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -251,8 +251,12 @@ int rv740_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = 0x40000 * ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = 0x40000 * ss.percentage *
 				(dividers.whole_fb_div + (dividers.frac_fb_div / 8)) / (clk_s * 10000);
 
 			mpll_ss1 &= ~CLKV_MASK;
-- 
2.39.2



