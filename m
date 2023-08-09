Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB222775876
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHIKxE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjHIKva (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0381FD4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69EEC630F8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AE0C4339A;
        Wed,  9 Aug 2023 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578242;
        bh=kPceT0pqd6KXALsKV0Dwyqw2w1QmbD7SOQAMEJ1gv4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKPs4iah7nagvZwTv0p3f7om4qfcc96SwMEV9XACCALmbWbB0EcIWuiiQ68AHknsA
         sOh3LoOd1S+KNvJqlNoGmqIbTfoWF2FMCXFhaLl2T2XuEuzF4uLB3VMQYzwY5Fzrqt
         rV64sfuPKa1UgLeAlyCFaJFa8Y3zNvAe3b6t5B8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 155/165] drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning
Date:   Wed,  9 Aug 2023 12:41:26 +0200
Message-ID: <20230809103647.840438794@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit ee31742bf17636da1304af77b2cb1c29b5dda642 ]

When hactive is not aligned to 8 pixels, it is aligned accordingly and
hfront porch needs to be reduced the same amount. Unfortunately the front
porch is set to the difference rather than reducing it. There are some
Samsung TVs which can't cope with a front porch of instead of 70.

Fixes: 94dfec48fca7 ("drm/imx: Add 8 pixel alignment fix")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20230515072137.116211-1-alexander.stein@ew.tq-group.com
[p.zabel@pengutronix.de: Fixed subject]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230515072137.116211-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
index 5f26090b0c985..89585b31b985e 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
@@ -310,7 +310,7 @@ static void ipu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		dev_warn(ipu_crtc->dev, "8-pixel align hactive %d -> %d\n",
 			 sig_cfg.mode.hactive, new_hactive);
 
-		sig_cfg.mode.hfront_porch = new_hactive - sig_cfg.mode.hactive;
+		sig_cfg.mode.hfront_porch -= new_hactive - sig_cfg.mode.hactive;
 		sig_cfg.mode.hactive = new_hactive;
 	}
 
-- 
2.40.1



