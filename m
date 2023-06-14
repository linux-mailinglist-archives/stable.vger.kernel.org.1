Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63072C060
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjFLKwO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjFLKvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B828EE69
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE629623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A23C433D2;
        Mon, 12 Jun 2023 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566171;
        bh=w2A/qEAfvb7iSSu+UTNUBls59RnRMfDk/xhl4YG+dYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1N2lKGCznGiyF6i41bBmsOC+ljfDKd2QBDTc0C+wdQm+P7csJ1tjPCcBZ0ZGP4Ve
         mv+jrZy6jZpC9hd0Pb2lK3pvA9EQ/IKTZFFNhE66rDt+Ov1cwJGNntaOApB90g/8ZM
         Msdejk0COePOY1XvGuMWVbA9TSp2L9kKnttmCDvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 22/91] drm/i915: Explain the magic numbers for AUX SYNC/precharge length
Date:   Mon, 12 Jun 2023 12:26:11 +0200
Message-ID: <20230612101703.020209552@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

[ Upstream commit 26bfc3f36f2104c174dfc72415547d5c28ef3f1c ]

Replace the hardcoded final numbers in the AUX SYNC/precharge
setup, and derive those from numbers from the (e)DP specs.

The new functions can serve as the single point of truth for
the number of SYNC pulses we use.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230329172434.18744-2-ville.syrjala@linux.intel.com
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Stable-dep-of: 2d6f2f79e065 ("drm/i915: Use 18 fast wake AUX sync len")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp_aux.c | 32 +++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index fd7527a3087ff..f0485521e58ad 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -119,6 +119,32 @@ static u32 skl_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
 	return index ? 0 : 1;
 }
 
+static int intel_dp_aux_sync_len(void)
+{
+	int precharge = 16; /* 10-16 */
+	int preamble = 16;
+
+	return precharge + preamble;
+}
+
+static int intel_dp_aux_fw_sync_len(void)
+{
+	int precharge = 16; /* 10-16 */
+	int preamble = 8;
+
+	return precharge + preamble;
+}
+
+static int g4x_dp_aux_precharge_len(void)
+{
+	int precharge_min = 10;
+	int preamble = 16;
+
+	/* HW wants the length of the extra precharge in 2us units */
+	return (intel_dp_aux_sync_len() -
+		precharge_min - preamble) / 2;
+}
+
 static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 				int send_bytes,
 				u32 aux_clock_divider)
@@ -141,7 +167,7 @@ static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 	       timeout |
 	       DP_AUX_CH_CTL_RECEIVE_ERROR |
 	       (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	       (3 << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
+	       (g4x_dp_aux_precharge_len() << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
 	       (aux_clock_divider << DP_AUX_CH_CTL_BIT_CLOCK_2X_SHIFT);
 }
 
@@ -167,8 +193,8 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
 	      DP_AUX_CH_CTL_TIME_OUT_MAX |
 	      DP_AUX_CH_CTL_RECEIVE_ERROR |
 	      (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(24) |
-	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(32);
+	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(intel_dp_aux_fw_sync_len()) |
+	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(intel_dp_aux_sync_len());
 
 	if (intel_phy_is_tc(i915, phy) &&
 	    dig_port->tc_mode == TC_PORT_TBT_ALT)
-- 
2.39.2



