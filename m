Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1327675D22A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGUS4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGUS4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A930E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A194361D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4346C433C7;
        Fri, 21 Jul 2023 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965797;
        bh=NJsHLQ8WHt1l7Os+Gm91mKNxRA3JWqTwzNZq+fjwbfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6jGYqiSgODrN+IIFWIU4PFKBne+hSCHRv4HllNBxk1yD9yMoZyKWRvOm18qELddF
         BR05UK/wO9swKcD/tzeWpgY6VU9mh/+4NqwDlaQUwwtoI6biIkjxLswg19jOO30EuR
         2QOLAUgt74s0SrKplR1iqVo5MP/w45FO2hdSekh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 100/532] drm/bridge: tc358768: fix PLL parameters computation
Date:   Fri, 21 Jul 2023 18:00:04 +0200
Message-ID: <20230721160619.990926063@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 6a4020b4c63911977aaf8047f904a300d15de739 ]

According to Toshiba documentation the PLL input clock after the divider
should be not less than 4MHz, fix the PLL parameters computation
accordingly.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-3-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8de7d9764ba88..e09e007a2749c 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -329,13 +329,17 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 		u32 fbd;
 
 		for (fbd = 0; fbd < 512; ++fbd) {
-			u32 pll, diff;
+			u32 pll, diff, pll_in;
 
 			pll = (u32)div_u64((u64)refclk * (fbd + 1), divisor);
 
 			if (pll >= max_pll || pll < min_pll)
 				continue;
 
+			pll_in = (u32)div_u64((u64)refclk, prd + 1);
+			if (pll_in < 4000000)
+				continue;
+
 			diff = max(pll, target_pll) - min(pll, target_pll);
 
 			if (diff < best_diff) {
-- 
2.39.2



