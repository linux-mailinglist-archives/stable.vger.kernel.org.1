Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE787037F0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbjEORZg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbjEORZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA16132BD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21AC62C49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5465C433D2;
        Mon, 15 May 2023 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171448;
        bh=YcZJu+xEqBVbuXs9A7Hv1gAQC7Z4UgkSRCZdWBuTSWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gh+4y3kxodlaPrAX0N+VJ4UVoVfpQ9NMMxWjZdoZdZl0nB8l58pkTbf1Wzd1ACHNn
         Kyki00Gob/y1j3ZRzDbzPihjNIQChA8h4yf2prxNC90LOWV666L3TqWui+zD9ai3JM
         c/pvHna/vchocCzhmDUEwA+ucTTSse4CJZwUyNPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Animesh Manna <animesh.manna@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 213/242] drm/i915/mtl: update scaler source and destination limits for MTL
Date:   Mon, 15 May 2023 18:28:59 +0200
Message-Id: <20230515161728.319620707@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Animesh Manna <animesh.manna@intel.com>

[ Upstream commit f840834a8b60ffd305f03a53007605ba4dfbbc4b ]

The max source and destination limits for scalers in MTL have changed.
Use the new values accordingly.

Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20221223130509.43245-3-luciano.coelho@intel.com
Stable-dep-of: d944eafed618 ("drm/i915: Check pipe source size when using skl+ scalers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/skl_scaler.c | 40 ++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index d7390067b7d4c..01e8812936126 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -87,6 +87,10 @@ static u16 skl_scaler_calc_phase(int sub, int scale, bool chroma_cosited)
 #define ICL_MAX_SRC_H 4096
 #define ICL_MAX_DST_W 5120
 #define ICL_MAX_DST_H 4096
+#define MTL_MAX_SRC_W 4096
+#define MTL_MAX_SRC_H 8192
+#define MTL_MAX_DST_W 8192
+#define MTL_MAX_DST_H 8192
 #define SKL_MIN_YUV_420_SRC_W 16
 #define SKL_MIN_YUV_420_SRC_H 16
 
@@ -103,6 +107,8 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
+	int min_src_w, min_src_h, min_dst_w, min_dst_h;
+	int max_src_w, max_src_h, max_dst_w, max_dst_h;
 
 	/*
 	 * Src coordinates are already rotated by 270 degrees for
@@ -157,15 +163,33 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		return -EINVAL;
 	}
 
+	min_src_w = SKL_MIN_SRC_W;
+	min_src_h = SKL_MIN_SRC_H;
+	min_dst_w = SKL_MIN_DST_W;
+	min_dst_h = SKL_MIN_DST_H;
+
+	if (DISPLAY_VER(dev_priv) < 11) {
+		max_src_w = SKL_MAX_SRC_W;
+		max_src_h = SKL_MAX_SRC_H;
+		max_dst_w = SKL_MAX_DST_W;
+		max_dst_h = SKL_MAX_DST_H;
+	} else if (DISPLAY_VER(dev_priv) < 14) {
+		max_src_w = ICL_MAX_SRC_W;
+		max_src_h = ICL_MAX_SRC_H;
+		max_dst_w = ICL_MAX_DST_W;
+		max_dst_h = ICL_MAX_DST_H;
+	} else {
+		max_src_w = MTL_MAX_SRC_W;
+		max_src_h = MTL_MAX_SRC_H;
+		max_dst_w = MTL_MAX_DST_W;
+		max_dst_h = MTL_MAX_DST_H;
+	}
+
 	/* range checks */
-	if (src_w < SKL_MIN_SRC_W || src_h < SKL_MIN_SRC_H ||
-	    dst_w < SKL_MIN_DST_W || dst_h < SKL_MIN_DST_H ||
-	    (DISPLAY_VER(dev_priv) >= 11 &&
-	     (src_w > ICL_MAX_SRC_W || src_h > ICL_MAX_SRC_H ||
-	      dst_w > ICL_MAX_DST_W || dst_h > ICL_MAX_DST_H)) ||
-	    (DISPLAY_VER(dev_priv) < 11 &&
-	     (src_w > SKL_MAX_SRC_W || src_h > SKL_MAX_SRC_H ||
-	      dst_w > SKL_MAX_DST_W || dst_h > SKL_MAX_DST_H)))	{
+	if (src_w < min_src_w || src_h < min_src_h ||
+	    dst_w < min_dst_w || dst_h < min_dst_h ||
+	    src_w > max_src_w || src_h > max_src_h ||
+	    dst_w > max_dst_w || dst_h > max_dst_h) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "scaler_user index %u.%u: src %ux%u dst %ux%u "
 			    "size is out of scaler range\n",
-- 
2.39.2



