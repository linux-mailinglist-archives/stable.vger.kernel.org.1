Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46A57ED065
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjKOTyo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjKOTyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8998D19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00596C433C7;
        Wed, 15 Nov 2023 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078080;
        bh=ZBOdaqUNVFnKXLuSg9YLjwlHG7u4g/7CgRYSV+v0Q0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqJeQm+nZf1gsDJSKEEwQ9++dYpEzfmqmTT6z/02PMQmVpmmGGIy/Q2HOttEczv37
         deSePxRzVlNKZ5A+rZaRC6bHaIBiEyGJvhe0MtQcMkGilHR0vFwRySDVKZS735jHAt
         w1uQDbVsTp2qrsRgIINKM3o9NNoQqYEa18V6d/LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 098/379] clk: npcm7xx: Fix incorrect kfree
Date:   Wed, 15 Nov 2023 14:22:53 -0500
Message-ID: <20231115192650.936322514@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

[ Upstream commit bbc5080bef4a245106aa8e8d424ba8847ca7c0ca ]

The corresponding allocation is:

> npcm7xx_clk_data = kzalloc(struct_size(npcm7xx_clk_data, hws,
> 			     NPCM7XX_NUM_CLOCKS), GFP_KERNEL);

... so, kfree should be applied to npcm7xx_clk_data, not
npcm7xx_clk_data->hws.

Fixes: fcfd14369856 ("clk: npcm7xx: add clock controller")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Link: https://lore.kernel.org/r/20230923133127.1815621-1-j.neuschaefer@gmx.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index e319cfa51a8a3..030186def9c69 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -510,7 +510,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	return;
 
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
-- 
2.42.0



