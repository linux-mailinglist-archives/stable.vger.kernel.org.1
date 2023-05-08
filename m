Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1076FAB1F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEHLKN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEHLJt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE033179
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E5FB62B21
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217B3C433D2;
        Mon,  8 May 2023 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544160;
        bh=W4SvYe4rKZkIlVlw5Ner+meN9XLyf8/ABcPjE9u0W1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg7vh49dHebaoJTDB5YZRqgSpmEEQuT5iATQzlaOl1iusdS63Qxpj+GkzcHt0UXZl
         Cs+tOdk0xXHGTS7qhh3BG6D2XwfUCwyu4GdE9O4FTO1Q3n8kGWeKNSQmoPknXz/aT3
         tjBa1bncDn4fKfYpt0p7kcvlahb57pOpaxhvMRvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 313/694] drm/i915: Make intel_get_crtc_new_encoder() less oopsy
Date:   Mon,  8 May 2023 11:42:28 +0200
Message-Id: <20230508094442.463887281@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 631420b06597a33c72b6dcef78d1c2dea17f452d ]

The point of the WARN was to print something, not oops
straight up. Currently that is precisely what happens
if we can't find the connector for the crtc in the atomic
state. Get the dev pointer from the atomic state instead
of the potentially NULL encoder to avoid that.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230413200602.6037-2-ville.syrjala@linux.intel.com
Fixes: 3a47ae201e07 ("drm/i915/display: Make WARN* drm specific where encoder ptr is available")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 3b6692357f70498f617ea1b31a0378070a0acf1c)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 63b4b73f47c6a..2bef50ab0ad19 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1053,7 +1053,7 @@ intel_get_crtc_new_encoder(const struct intel_atomic_state *state,
 		num_encoders++;
 	}
 
-	drm_WARN(encoder->base.dev, num_encoders != 1,
+	drm_WARN(state->base.dev, num_encoders != 1,
 		 "%d encoders for pipe %c\n",
 		 num_encoders, pipe_name(master_crtc->pipe));
 
-- 
2.39.2



