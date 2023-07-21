Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F275D32D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGUTH4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGUTHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7311BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1AB561D94
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09825C433C8;
        Fri, 21 Jul 2023 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966462;
        bh=bplSIesVC6c1/my+CG0DYK97gEFeQW7+z+itEd/VPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu6pOT7sfXcFhxVwpL1FuWjMeHoKRicCiEh+Hp1b2pz7tv77m23jBbLPI+5qh7L3i
         iqXBhdNRsuVQFRf9PZGK38u209OeGOqX0YDx1HN6WGbalceuRMA4QnNvpDyk0EBh8w
         ixGO5v4zlfURmcfXRG0Xz4bVWnjiOkI+ImSibcJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 314/532] drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times
Date:   Fri, 21 Jul 2023 18:03:38 +0200
Message-ID: <20230721160631.429031101@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 5311892a0ad1d301aafd53ca0154091b3eb407ea ]

Encoder compute config is changing hw.adjusted mode. Uapi.adjusted mode
doesn't get updated before psr compute config gets called. This causes io
and fast wake line calculation using adjusted mode containing values before
encoder adjustments. Fix this by using hw.adjusted mode instead of
uapi.adjusted mode.

Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8475
Fixes: cb42e8ede5b4 ("drm/i915/psr: Use calculated io and fast wake lines")
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230620111745.2870706-1-jouni.hogander@intel.com
(cherry picked from commit ef0af9db2a21257885116949f471fe5565b2f0ab)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index cf1e92486cbc9..93d2fd4cd16b7 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -862,9 +862,9 @@ static bool _compute_psr2_wake_times(struct intel_dp *intel_dp,
 	}
 
 	io_wake_lines = intel_usecs_to_scanlines(
-		&crtc_state->uapi.adjusted_mode, io_wake_time);
+		&crtc_state->hw.adjusted_mode, io_wake_time);
 	fast_wake_lines = intel_usecs_to_scanlines(
-		&crtc_state->uapi.adjusted_mode, fast_wake_time);
+		&crtc_state->hw.adjusted_mode, fast_wake_time);
 
 	if (io_wake_lines > max_wake_lines ||
 	    fast_wake_lines > max_wake_lines)
-- 
2.39.2



