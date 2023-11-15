Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F167ED4C4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbjKOU7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbjKOU5z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FD1BD5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F77CC116CA;
        Wed, 15 Nov 2023 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081300;
        bh=Y3IN/4cL+Hj1Rs0iVo0dYaD9oj4P0EipabBYRIpiGiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGERqmQqGIqOP6TZntunRT5q4pDXS3nuiyPbz+bYlX4IOX7eEy9PHVaRhRA0GVOuP
         HILukaFjO20xXm84bkx4VGr/v094aLaRdssXQjRzJWBhEh0hVfy3txXvfTZyIJptyz
         JtUCokkLLPdOEv3TTrbZQ1hL3FO6QnKtdOx63aJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 070/244] clk: npcm7xx: Fix incorrect kfree
Date:   Wed, 15 Nov 2023 15:34:22 -0500
Message-ID: <20231115203552.578443647@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index e677bb5a784b9..c10f04f9070a5 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -539,7 +539,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	return;
 
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
-- 
2.42.0



