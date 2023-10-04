Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03FE7B89B0
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbjJDS2N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244247AbjJDS2M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66926AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE56C433C7;
        Wed,  4 Oct 2023 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444089;
        bh=RB1rwaLlpfUho7DR4SYQnpYqxsxan+hs6sGvqpBPPhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UbY+zPXxXqvYmcv1EevG0z49sk/w1zjl7yuKFU+Ndv1SynSq7yZcbjJ2VKr/9+lB
         brw7QI1fm8sWceF9LiZ+a1AXQGxprd61yAuRXUj2w8z/rwBpF+5faHcKGutNlxDK1b
         HXQzvBW2BWvMMJcFZhWLuU13/QEZ+7J2gKYrWNIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 127/321] clk: si521xx: Use REGCACHE_FLAT instead of NONE
Date:   Wed,  4 Oct 2023 19:54:32 +0200
Message-ID: <20231004175235.136554602@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit f03a562450eef35b785a814005ed164a89dfb2db ]

In order to reload registers into the clock generator on resume using
regcache_sync(), it is necessary to select one of the regcache types
which are not NONE. Since this device has some 7 registers, use the
simplest one, FLAT. The regcache code complains about REGCACHE_NONE
being selected and generates a WARNING, this fixes that warning.

Fixes: edc12763a3a2 ("clk: si521xx: Clock driver for Skyworks Si521xx I2C PCIe clock generators")
Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230831181656.154750-1-marex@denx.de
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si521xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si521xx.c b/drivers/clk/clk-si521xx.c
index 4eaf1b53f06bd..0b9e2edbbe67c 100644
--- a/drivers/clk/clk-si521xx.c
+++ b/drivers/clk/clk-si521xx.c
@@ -146,7 +146,7 @@ static int si521xx_regmap_i2c_read(void *context, unsigned int reg,
 static const struct regmap_config si521xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_NONE,
+	.cache_type = REGCACHE_FLAT,
 	.max_register = SI521XX_REG_DA,
 	.rd_table = &si521xx_readable_table,
 	.wr_table = &si521xx_writeable_table,
-- 
2.40.1



