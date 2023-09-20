Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843E7A7CA3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjITMDB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjITMCq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:02:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D22C6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:02:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF3DC43395;
        Wed, 20 Sep 2023 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211358;
        bh=wmuHDijgqag1AiZfH1xztBNkDeKQsht+n7mLhQ10Ct8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnhVeoRUgfl4b5GThLjOFRg9q9dbP1a4opjCIld7Ri9Le0r3RFdNREPXD6oZHIiMC
         3gAiFOzGGA3QAnFUKqvpkwmv76SDPimSzflteBH8qoOE/fNvm11uhWZMJSl9km+Hkx
         pgP8t7uh+wAYKbLL+ATR5Zefdr6B/3sMvGJGVS/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/186] drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
Date:   Wed, 20 Sep 2023 13:29:26 +0200
Message-ID: <20230920112839.164960397@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minjie Du <duminjie@vivo.com>

[ Upstream commit a995c50db887ef97f3160775aef7d772635a6f6e ]

The function clk_register_pll() may return NULL or an ERR_PTR. Don't
treat an ERR_PTR as valid.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Link: https://lore.kernel.org/r/20230712102246.10348-1-duminjie@vivo.com
Fixes: b9e0d40c0d83 ("clk: keystone: add Keystone PLL clock driver")
[sboyd@kernel.org: Reword commit text]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/keystone/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index e7e840fb74eaf..526694c2a6c97 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -213,7 +213,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	clk = clk_register_pll(NULL, node->name, parent_name, pll_data);
-	if (clk) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		return;
 	}
-- 
2.40.1



