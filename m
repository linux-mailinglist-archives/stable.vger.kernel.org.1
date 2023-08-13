Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8925677AC23
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjHMV3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHMV3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E804710EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8593C62AE1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9666BC433C7;
        Sun, 13 Aug 2023 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962186;
        bh=KCfjDiy9JlZr33rQXbCL0g8uY3hRnj/kGHoyy111Mns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSwEvqMGKsFXBfqVNHrGgUBpaG6zE2JLpyd28JTpZe/yEQrmGXAHRlqCrnwEYBXtP
         H4LA27s3lfQtCWBTxs5uLpSh2AAFV+H0zr5EO28nWd7kBEGBU7zW2rSgmSWj98kOiM
         nIyKRlJIxCQBhIUewLXii2LG6LHQLesjFXCCF9uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pin-yen Lin <treapking@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.4 144/206] drm/bridge: it6505: Check power state with it6505->powered in IRQ handler
Date:   Sun, 13 Aug 2023 23:18:34 +0200
Message-ID: <20230813211729.158575272@linuxfoundation.org>
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

From: Pin-yen Lin <treapking@chromium.org>

commit e9d699af3f65d62cf195f0e7a039400093ab2af2 upstream.

On system resume, the driver might call it6505_poweron directly if the
runtime PM hasn't been enabled. In such case, pm_runtime_get_if_in_use
will always return 0 because dev->power.runtime_status stays at
RPM_SUSPENDED, and the IRQ will never be handled.

Use it6505->powered from the driver struct fixes this because it always
gets updated when it6505_poweron is called.

Fixes: 5eb9a4314053 ("drm/bridge: it6505: Guard bridge power in IRQ handler")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230727100131.2338127-1-treapking@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 504d51c42f79..aadb396508c5 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2517,9 +2517,11 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	};
 	int int_status[3], i;
 
-	if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
+	if (it6505->enable_drv_hold || !it6505->powered)
 		return IRQ_HANDLED;
 
+	pm_runtime_get_sync(dev);
+
 	int_status[0] = it6505_read(it6505, INT_STATUS_01);
 	int_status[1] = it6505_read(it6505, INT_STATUS_02);
 	int_status[2] = it6505_read(it6505, INT_STATUS_03);
-- 
2.41.0



