Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE167703411
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjEOQoX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbjEOQoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00E4698
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBDCE627C4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDB3C433D2;
        Mon, 15 May 2023 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169061;
        bh=ONVAui3caU3CRk2auBsLG5HVBTu4nkCT1go6w6RA0iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYIXXkhxShEwk8ipWwTJmKjOdDKhM2BEFm2GnFAAYbjVct31BvDjhQ/w7O/kST9Vw
         SmMA8xpV7t7W3dxfsOeb4hT8qycXwwZTSC8WppV1TMEaFuW5r6/UdZcqg4CIxhO9El
         deOLQxS/MR54PkpH7Rm3biMfTbTJZEs98ObTLQPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 130/191] clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent
Date:   Mon, 15 May 2023 18:26:07 +0200
Message-Id: <20230515161712.085429725@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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
@@ -1267,7 +1267,7 @@ static struct rockchip_clk_branch rk3399
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */


