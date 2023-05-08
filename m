Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D602E6FA97D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjEHKvz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjEHKvg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018427F10
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBA26292F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E2BC433EF;
        Mon,  8 May 2023 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543059;
        bh=Jhab4T1IZVUorMxITNTHoSKD2GLUOVE9BUlEJWAVXhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNOeO/6zKG95gGH31Zc1qioqW+TaoL9w0WBHxozFg42IzoOgwu74P31YsswpAQ6K3
         v3U6fEA51vPsDaBIX295njGiU6Vxx55dkSqi20SpJSbby7kU5E0PJiER9Qo/mKmzr7
         5Qf8OH/6rtIGS9RhJ3pTOIPqrs8kVO7SaJ7XSnzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.2 638/663] clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent
Date:   Mon,  8 May 2023 11:47:44 +0200
Message-Id: <20230508094450.648893867@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

commit 933bf364e152cd60902cf9585c2ba310d593e69f upstream.

clk_cifout is derived from clk_cifout_src through an integer divider
limited to 32. clk_cifout_src is a child of either cpll, gpll or npll
without any possibility of a divider of any sort. The default clock
parent is cpll.

Let's allow clk_cifout to ask its parent clk_cifout_src to reparent in
order to find the real closest possible rate for clk_cifout and not one
derived from cpll only.

Cc: stable@vger.kernel.org # 4.10+
Fixes: fd8bc829336a ("clk: rockchip: fix the rk3399 cifout clock")
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20221117-rk3399-cifout-set-rate-parent-v1-0-432548d04081@theobroma-systems.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-rk3399.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1263,7 +1263,7 @@ static struct rockchip_clk_branch rk3399
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */


