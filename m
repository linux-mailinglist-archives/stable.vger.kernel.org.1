Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68CF7A3BF1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbjIQUYe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbjIQUYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AAF10B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72979C433C9;
        Sun, 17 Sep 2023 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982246;
        bh=SKvm3Tu/Z24JKImr+Jckh5/jjyDQQhsg1G7hdbc/5tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URw6Ejf5h9ROzx6l72vWF1QJgdsCIlMf7oQqV0w5Gt/RSwa+c0yt7yEzFw4CEEgKH
         hyfjyuLoz0Q4sQxv+kC+aKUXpAYtAFG/5AHGYiIvrSMoUJ3ya1CsAqw/XrKTDZpSEN
         DFeBxqBGUu3nACWYAHE0hbfUSzdy+4zSlat5Y2KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 195/511] drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
Date:   Sun, 17 Sep 2023 21:10:22 +0200
Message-ID: <20230917191118.528802997@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index d59a7621bb204..ee5c72369334f 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -209,7 +209,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	clk = clk_register_pll(NULL, node->name, parent_name, pll_data);
-	if (clk) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		return;
 	}
-- 
2.40.1



