Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083B7034D2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbjEOQw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243196AbjEOQwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80155BB5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F243629A7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC27C433D2;
        Mon, 15 May 2023 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169534;
        bh=DUAofuEgBYri9/TaQeoogxL8Kixj5fbCL0lUumpKaHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQvzPpnFumId4WC+zONYaS60VoaDmbH9VWr4/qh5IwBFE9JyP7WtoAKteZLLhins0
         UNQiXKeg7NtMo15Nf148iFRDAvhdnperIdFz+wkCe/u9TB1G7j+q+b18FHfpxS8V2N
         wpJ9lwHIWJJPfjLSQ/4XJpK7oHkmbj7ygHa6gCyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Haridhar Kalvala <haridhar.kalvala@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 059/246] drm/i915/mtl: Add the missing CPU transcoder mask in intel_device_info
Date:   Mon, 15 May 2023 18:24:31 +0200
Message-Id: <20230515161724.351799326@linuxfoundation.org>
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

From: Radhakrishna Sripada <radhakrishna.sripada@intel.com>

[ Upstream commit 6ece90e3665a9b7fb2637fcca26cebd42991580b ]

CPU transcoder mask is used to iterate over the available
CPU transcoders in the macro for_each_cpu_transcoder().

The macro is broken on MTL and got highlighted when audio
state was being tracked for each transcoder added in [1].

Add the missing CPU transcoder mask which is similar to ADL-P
mask but without DSI transcoders.

[1]: https://patchwork.freedesktop.org/patch/523723/

Fixes: 7835303982d1 ("drm/i915/mtl: Add MeteorLake PCI IDs")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Acked-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230420221248.2511314-1-radhakrishna.sripada@intel.com
(cherry picked from commit bddc18913bd44adae5c828fd514d570f43ba1576)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index a8d942b16223f..125f7ef1252c3 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1135,6 +1135,8 @@ static const struct intel_gt_definition xelpmp_extra_gt[] = {
 static const struct intel_device_info mtl_info = {
 	XE_HP_FEATURES,
 	XE_LPDP_FEATURES,
+	.__runtime.cpu_transcoder_mask = BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |
+			       BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
 	/*
 	 * Real graphics IP version will be obtained from hardware GMD_ID
 	 * register.  Value provided here is just for sanity checking.
-- 
2.39.2



