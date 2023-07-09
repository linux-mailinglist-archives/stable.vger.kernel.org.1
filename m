Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F212F74C2C7
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGILYi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjGILYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4784130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE9260C01
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E72AC433C8;
        Sun,  9 Jul 2023 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901875;
        bh=K4cFRuLE+MyvbssmghWVqUZv1XOr+FVrs8SFrxcOrEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGai9PQkSVZriOIXTrfriMx518Vjz2L5PcxjDfRmlZyMeKNyhqWjnPt/BGzs0sfPs
         iaUeUG8phh88RJIyGInCTC3KkmFxw3mFCvATx9rxCP0iE8dbP4HKq8otbpBFvrbQsM
         ELa1My+WsQsscqyD9eLU/ovn9NGQ1wp2H76hUSeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 175/431] drm/bridge: tc358768: fix TXTAGOCNT computation
Date:   Sun,  9 Jul 2023 13:12:03 +0200
Message-ID: <20230709111455.273523050@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index e3f456bfb90c1..d8209433d5f43 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -796,7 +796,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
 	val = val << 16 | val2;
-- 
2.39.2



