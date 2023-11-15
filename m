Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87AD7ED473
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjKOU6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbjKOU5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90C1735
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B01C116B6;
        Wed, 15 Nov 2023 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081289;
        bh=qKVVKGNvKBYcAkWWcT9sisYjCqfTMcoWqcysSsv/dsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Djbkv9lGqnbOPK7STAPJB1U9EyGM4zk1L+DnDXwxVLWiM3+YZEvMzpHY5Nmxksl8x
         uj6uAzhGx3lKlTgovDzq4XwkZx6FwwCMCtDPfjiGIh8EbyhFwYjmP3UUYGFLcNAbSf
         pq/4eUolKRC9TtN1Z1IaDQ7e1WQQIKx5lgPCcGik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 065/244] clk: ti: Add ti_dt_clk_name() helper to use clock-output-names
Date:   Wed, 15 Nov 2023 15:34:17 -0500
Message-ID: <20231115203552.252741561@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2c1593328d7f02fe49de5ad6b42c36296c9d6922 ]

Let's create the clock alias based on the clock-output-names property if
available. Also the component clock drivers can use ti_dt_clk_name() in
the following patches.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220204071449.16762-7-tony@atomide.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 7af5b9eadd64 ("clk: ti: fix double free in of_ti_divider_clk_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk.c   | 20 +++++++++++++++++++-
 drivers/clk/ti/clock.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 29eafab4353ef..b941ce0f3c394 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -402,6 +402,24 @@ static const struct of_device_id simple_clk_match_table[] __initconst = {
 	{ }
 };
 
+/**
+ * ti_dt_clk_name - init clock name from first output name or node name
+ * @np: device node
+ *
+ * Use the first clock-output-name for the clock name if found. Fall back
+ * to legacy naming based on node name.
+ */
+const char *ti_dt_clk_name(struct device_node *np)
+{
+	const char *name;
+
+	if (!of_property_read_string_index(np, "clock-output-names", 0,
+					   &name))
+		return name;
+
+	return np->name;
+}
+
 /**
  * ti_clk_add_aliases - setup clock aliases
  *
@@ -418,7 +436,7 @@ void __init ti_clk_add_aliases(void)
 		clkspec.np = np;
 		clk = of_clk_get_from_provider(&clkspec);
 
-		ti_clk_add_alias(NULL, clk, np->name);
+		ti_clk_add_alias(NULL, clk, ti_dt_clk_name(np));
 	}
 }
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index f1dd62de2bfcb..938f34e290ed2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -214,6 +214,7 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 			    const char *con);
 struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
 				    const char *con);
+const char *ti_dt_clk_name(struct device_node *np);
 int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
-- 
2.42.0



