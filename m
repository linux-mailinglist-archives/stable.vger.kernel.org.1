Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93907B89AF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbjJDS2K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbjJDS2K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B3BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E050BC433CA;
        Wed,  4 Oct 2023 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444086;
        bh=3AzEj1xDRT/wG16i9mVpb8V47tw7Tbwl8y4/jRh5bJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El25d7yulyovHn36mjZpz9H+a/lgKLvIAwp0R45gi+mMqNjFuMnRyIarLsQklsFoD
         Emzw+yfZEoJn/BWbFix5jRHFjMb9aGA32ojoC0F21cS5LMWXiHGcKMbw3QQLqcKYJ5
         hfNkWxctB24nU3HFKWO4ji4tWpOjoPP1tHDuI5wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhifeng Tang <zhifeng.tang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 126/321] clk: sprd: Fix thm_parents incorrect configuration
Date:   Wed,  4 Oct 2023 19:54:31 +0200
Message-ID: <20231004175235.083947012@linuxfoundation.org>
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

From: Zhifeng Tang <zhifeng.tang@unisoc.com>

[ Upstream commit b7b20cfe6f849c2682c5f7d3f50ede6321a5d04c ]

The thm*_clk have two clock sources 32k and 250k,excluding 32m.

Fixes: af3bd36573e3 ("clk: sprd: Add clocks support for UMS512")
Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230824092624.20020-1-zhifeng.tang@unisoc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sprd/ums512-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
index fc25bdd85e4ea..f43bb10bd5ae2 100644
--- a/drivers/clk/sprd/ums512-clk.c
+++ b/drivers/clk/sprd/ums512-clk.c
@@ -800,7 +800,7 @@ static SPRD_MUX_CLK_DATA(uart1_clk, "uart1-clk", uart_parents,
 			 0x250, 0, 3, UMS512_MUX_FLAG);
 
 static const struct clk_parent_data thm_parents[] = {
-	{ .fw_name = "ext-32m" },
+	{ .fw_name = "ext-32k" },
 	{ .hw = &clk_250k.hw  },
 };
 static SPRD_MUX_CLK_DATA(thm0_clk, "thm0-clk", thm_parents,
-- 
2.40.1



