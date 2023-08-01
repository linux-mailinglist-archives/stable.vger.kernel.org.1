Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6E76B80B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjHAOyD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHAOyD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:54:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158DD122
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:54:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso23939195e9.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690901640; x=1691506440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAM2i784Ag5/a0I9MwqQtWw/8QQB5KhXPqtvHEZg5d0=;
        b=ayz/jUtkG7tTGe9lLq17dIsKTK0NSuJS5eqo25pZEacnbr2FOUoIcZFIU8Glp7+VSj
         OPYrRZydRuRRSxcA387uNmLZ4xwAyyPVpSw55PINpmxwTI3JrpJ2Hll48WUZ48TX5QiG
         1aMhrKINq9mciWjk3+HFnR9vPk8JQORUoJ1nOHpmNL4ilOTQ8XADk8XsFNuUXsEYiuA4
         9JpLK07/wJYz/0VnGMfAdjlzvoTcrTB02Sb6IQEFdYmLRFzozrRskQ+dPyjBFkCH5z6c
         8zRNxkdb8kE6mSC6x7Wb8HuodU1Cp5Vv0WUoRgDVbfoFtxk7ko1fI4facuHRnz5jDwtl
         /h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901640; x=1691506440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAM2i784Ag5/a0I9MwqQtWw/8QQB5KhXPqtvHEZg5d0=;
        b=QMzkXTYEgevaCBEBW4tueTkD7ehJi8qg8s9o/1W6RO7jLH9Uv77OBsmliwzyvWIXB6
         T1IT3ChJvNjvbzz5QMYPbUdApYmLx8M5FQk7+h6NTfC3ktiLb7YNBQf2HcQB4S0qTA9l
         daIYzgaYgPYNCySVUM50B39GeFG+Gg8zdiS885fJGBwT+MnX4BmkHae/yzJYQR9RtdRo
         j3yrCUWj9lxQciPj0awgkD1BIaYkOAWd4z0/wC14okFxfvKxdBen+yXYyJ+w+iGdsVNz
         XgRr1I08tZafHmbmv47NdwKVYoQTXI2QoF4r2F9CyLRr7Nn3TswRJ1zIUdW7S1di/uJ+
         H2xg==
X-Gm-Message-State: ABy/qLYhgsIeK+wWeJyQyCdQA3nmp9oAns9mNZSfNCQJ6VScExJHB4+N
        /tXzzrGaw4vf4NTiC7JK4KelccbO4CI=
X-Google-Smtp-Source: APBJJlFnio1lPmhjsZNqYpKa2bEQtw6X/WGooO6Ka/kJ0q2bDqn36OKu8y9C12ZU0NsftD8XsAfTXA==
X-Received: by 2002:a7b:c314:0:b0:3f6:1474:905 with SMTP id k20-20020a7bc314000000b003f614740905mr2788351wmj.29.1690901640261;
        Tue, 01 Aug 2023 07:54:00 -0700 (PDT)
Received: from EliteBook.fritz.box ([2a00:e180:154d:2800:48db:3ae1:ae48:4cb6])
        by smtp.gmail.com with ESMTPSA id w3-20020a1cf603000000b003fa973e6612sm16758500wmc.44.2023.08.01.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:53:59 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     stable@vger.kernel.org
Cc:     juan.hao@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning
Date:   Tue,  1 Aug 2023 16:53:53 +0200
Message-Id: <20230801145353.515136-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

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
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
index 5f26090b0c98..89585b31b985 100644
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
2.34.1

