Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CA75D23F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGUS5s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGUS5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A23AB6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62ADB61D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74360C433C7;
        Fri, 21 Jul 2023 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965844;
        bh=JfXTk1QX8Ci7HBLYUWkpgHmnnNjdWupp4/9w8/qgNf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuNEgByai+MRSzOJ5LmsPZzyyjB7Yh5dUFfdYejD+US4n0ZD1CcojlmHUcsU1+eZ1
         PE2g9O7l1emU/QqPAR/3581c+dgPsYcYr2Nmd3s3QAEv8jBvh3hYM15/fWOU3u+1t8
         /gCpQUL3sqAoH5x/9clzTl1kXQfj4JdWKkUsO5rE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/532] drm/bridge: tc358768: fix TXTAGOCNT computation
Date:   Fri, 21 Jul 2023 18:00:10 +0200
Message-ID: <20230721160620.327031681@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 3666aad8185af8d0ce164fd3c4974235417d6d0b ]

Correct computation of TXTAGOCNT register.

This register must be set to a value that ensure that the
TTA-GO period = (4 x TLPX)

with the actual value of TTA-GO being

4 x (TXTAGOCNT + 1) x (HSByteClk cycle)

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-8-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 151eecbf6027d..c9c2e15c6f4a2 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -779,7 +779,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
 	val |= val2 << 16;
-- 
2.39.2



