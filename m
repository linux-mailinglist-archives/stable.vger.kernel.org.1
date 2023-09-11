Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB579B038
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378685AbjIKWge (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbjIKPN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9731FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:13:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13844C433C8;
        Mon, 11 Sep 2023 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445201;
        bh=X5MRMzSXMT/ubcH6D/AGt4Ve0GFgt1WIlAb/NrqGUps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRvqKjsQvxtP3XSc2/0BOaEH/BelkIE7SukgrKuu89ne/ogT8BNpdV6ygm28Yf37c
         ZyqR0J8F7/AAK8MIO0Nn44GCHzdvRIYw6/I4uLrYF0o6eW1CcDAQXO4YRW8dt3/hOv
         A2JF2UmOmVbiKkESuIwEsMWUvUN/zqOr1EeWxg2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>, Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 264/600] drm/bridge: anx7625: Use common macros for DP power sequencing commands
Date:   Mon, 11 Sep 2023 15:44:57 +0200
Message-ID: <20230911134641.400526251@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 2ba776f903cb7157e80b5f314fb0b4faf6ea6958 ]

The DRM DP code has macros for the DP power sequencing commands. Use
them in the anx7625 driver instead of raw numbers.

Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to downstream")
Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into normal status")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230710090929.1873646-1-wenst@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 213263ad6a064..36ec9dedadfe1 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -933,8 +933,8 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "set downstream sink into normal\n");
 	/* Downstream sink enter into normal mode */
-	data = 1;
-	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D0;
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		dev_err(dev, "IO error : set sink into normal mode fail\n");
 
@@ -973,8 +973,8 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "notify downstream enter into standby\n");
 	/* Downstream monitor enter into standby mode */
-	data = 2;
-	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D3;
+	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "IO error : mute video fail\n");
 
-- 
2.40.1



