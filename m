Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEB6FAEB7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjEHLq7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbjEHLqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA63CD98
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D3763900
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA7CC433D2;
        Mon,  8 May 2023 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546405;
        bh=Olm/0fAL/5r/H152NekgGKXzc6/Vqe3sbvhMyTHN0/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjHkrxEuREgWD1sfdF5+Q8+8M2ZK686u35wRRVsDgYf2Z08kV4f5vPuY2W5BtnmiI
         MxCVLch+/fw8qZznYSzmglCJuz0UhA4KVGLWmxvO2u+WXvu0C+VAaiGJsVEHuLT99k
         SvSR7AZHMvrXGJgyMBnryxkS8uvacLvcnbNQcPLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hai Pham <hai.pham.ud@renesas.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 327/371] pinctrl: renesas: r8a779a0: Remove incorrect AVB[01] pinmux configuration
Date:   Mon,  8 May 2023 11:48:48 +0200
Message-Id: <20230508094825.063962341@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Hai Pham <hai.pham.ud@renesas.com>

[ Upstream commit a145c9a8674ac8fbfa1595276e1b6cbfc5139038 ]

AVB[01]_{MAGIC,MDC,MDIO,TXCREFCLK} are registered as both
PINMUX_SINGLE(fn) and PINMUX_IPSR_GPSR(fn) in the pinmux_data array.

The latter are correct, hence remove the former.
Without this fix, the Ethernet PHY is not operational on the MDIO bus.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: LUU HOAI <hoai.luu.ub@renesas.com>
Fixes: 741a7370fc3b8b54 ("pinctrl: renesas: Initial R8A779A0 (V3U) PFC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/6fd217b71e83ba9a8157513ed671a1fa218b23b6.1674824958.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index a480677dd03d1..aa4fd56e0250d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -710,16 +710,8 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(PCIE0_CLKREQ_N),
 
 	PINMUX_SINGLE(AVB0_PHY_INT),
-	PINMUX_SINGLE(AVB0_MAGIC),
-	PINMUX_SINGLE(AVB0_MDC),
-	PINMUX_SINGLE(AVB0_MDIO),
-	PINMUX_SINGLE(AVB0_TXCREFCLK),
 
 	PINMUX_SINGLE(AVB1_PHY_INT),
-	PINMUX_SINGLE(AVB1_MAGIC),
-	PINMUX_SINGLE(AVB1_MDC),
-	PINMUX_SINGLE(AVB1_MDIO),
-	PINMUX_SINGLE(AVB1_TXCREFCLK),
 
 	PINMUX_SINGLE(AVB2_AVTP_PPS),
 	PINMUX_SINGLE(AVB2_AVTP_CAPTURE),
-- 
2.39.2



