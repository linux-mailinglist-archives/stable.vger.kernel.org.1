Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C778337D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHUT4m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjHUT4l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C872FA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5A664613
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4FDC433C8;
        Mon, 21 Aug 2023 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647799;
        bh=vGIAahqBWZRipnGAlrVvpDTRq5qvD98ohLiD+RGI+5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZeVBd3zpV+U236CwuQPWs1R5OP0MHVkUnBRyFs/HTYfHpDn5xCE/o4+8hjJwr+tk
         2rEKmDJh0UnFo3JpMRjKqJALUKq8WVQK8zusoHxYElGAWCAqP4EDw4HdyJzLeCEa80
         JqAfNjafWmt14RFnQGd+ccJVC35xRZCwSRwQm8xI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/194] arm64: dts: imx93: Fix anatop node size
Date:   Mon, 21 Aug 2023 21:42:02 +0200
Message-ID: <20230821194128.984522917@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 78e869dd8b2ba19765ac9b05cdea3e432d1dc188 ]

Although the memory map of i.MX93 reference manual rev. 2 claims that
analog top has start address of 0x44480000 and end address of 0x4448ffff,
this overlaps with TMU memory area starting at 0x44482000, as stated in
section 73.6.1.
As PLL configuration registers start at addresses up to 0x44481400, as used
by clk-imx93, reduce the anatop size to 0x2000, so exclude the TMU area
but keep all PLL registers inside.

Fixes: ec8b5b5058ea ("arm64: dts: freescale: Add i.MX93 dtsi support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8ab9f8194702e..c2f60d41d6fd1 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -254,7 +254,7 @@
 
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
-				reg = <0x44480000 0x10000>;
+				reg = <0x44480000 0x2000>;
 			};
 		};
 
-- 
2.40.1



