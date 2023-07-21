Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904F75D403
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGUTQx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGUTQw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86230E8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275F261D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3A0C433C7;
        Fri, 21 Jul 2023 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967009;
        bh=KhKVUp/PMjUyc1PDHVa/c/a+uFm73de/M+jpXghe7hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUxve8SnL9gN4h9KPjl8MTxXCfBsudIrw7akWQKLkDTw8jxZd7oA44sWsVukPYKZK
         MVCX/kp+FnI2x4wPlj/KK8QU45i0yc5J0Ja2QzQHPK0xN0b40DHmSanQcxnwcsHnM2
         +wQNRTYsnL29Dn9F0yL5fgJ6O9HLroqF2C8JsfWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/223] drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags
Date:   Fri, 21 Jul 2023 18:04:26 +0200
Message-ID: <20230721160521.441393477@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 1c519980aced3da1fae37c1339cf43b24eccdee7 ]

Add missing drm_display_mode DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC
flags. Those are used by various bridges in the pipeline to correctly
configure its sync signals polarity.

Fixes: d69de69f2be1 ("drm/panel: simple: Add Powertip PH800480T013 panel")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230615201602.565948-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e49d352339ff8..f851aaf2c5917 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3110,6 +3110,7 @@ static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
 	.vsync_start = 480 + 49,
 	.vsync_end = 480 + 49 + 2,
 	.vtotal = 480 + 49 + 2 + 22,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 
 static const struct panel_desc powertip_ph800480t013_idf02  = {
-- 
2.39.2



