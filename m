Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA07F50A7
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjKVTeh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjKVTeh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:34:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42A1A8
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:34:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF67C433C9;
        Wed, 22 Nov 2023 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700681673;
        bh=sUOkpeVStIpkb0nCMt0Dt9ZKCxNjIGoC5ZfTJ6O/vCM=;
        h=Subject:To:Cc:From:Date:From;
        b=cBpdtacfzJ7FrJ+DirdjoSGc94C30B13fRxIwe+sluTUj3xSsrBs2OPp8M/Ckc7ty
         zrXcPGXg5/aCI1HscyDkT/yk3y1liSI1p0onbAeWBcA5QSASwFR0fgxeewwykXYnLH
         7hHWagAo0qSkijB/EFKL3fgN1k3ck3UUtwQH9KuU=
Subject: FAILED: patch "[PATCH] clk: visconti: Fix undefined behavior bug in struct" failed to apply to 6.1-stable tree
To:     gustavoars@kernel.org, keescook@chromium.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, sboyd@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:34:31 +0000
Message-ID: <2023112230-baggage-playback-8fc5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5ad1e217a2b23aa046b241183bd9452d259d70d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112230-baggage-playback-8fc5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5ad1e217a2b2 ("clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider")
7e626a080bb2 ("clk: visconti: remove unused visconti_pll_provider::regmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ad1e217a2b23aa046b241183bd9452d259d70d0 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Mon, 16 Oct 2023 16:05:27 -0600
Subject: [PATCH] clk: visconti: Fix undefined behavior bug in struct
 visconti_pll_provider

`struct clk_hw_onecell_data` is a flexible structure, which means that
it contains flexible-array member at the bottom, in this case array
`hws`:

include/linux/clk-provider.h:
1380 struct clk_hw_onecell_data {
1381         unsigned int num;
1382         struct clk_hw *hws[] __counted_by(num);
1383 };

This could potentially lead to an overwrite of the objects following
`clk_data` in `struct visconti_pll_provider`, in this case
`struct device_node *node;`, at run-time:

drivers/clk/visconti/pll.h:
 16 struct visconti_pll_provider {
 17         void __iomem *reg_base;
 18         struct clk_hw_onecell_data clk_data;
 19         struct device_node *node;
 20 };

Notice that a total of 56 bytes are allocated for flexible-array `hws`
at line 328. See below:

include/dt-bindings/clock/toshiba,tmpv770x.h:
 14 #define TMPV770X_NR_PLL		7

drivers/clk/visconti/pll-tmpv770x.c:
 69 ctx = visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);

drivers/clk/visconti/pll.c:
321 struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
322                                                         void __iomem *base,
323                                                         unsigned long nr_plls)
324 {
325         struct visconti_pll_provider *ctx;
...
328         ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_plls), GFP_KERNEL);

`struct_size(ctx, clk_data.hws, nr_plls)` above translates to
sizeof(struct visconti_pll_provider) + sizeof(struct clk_hw *) * 7 ==
24 + 8 * 7 == 24 + 56
		  ^^^^
		   |
	allocated bytes for flex array `hws`

$ pahole -C visconti_pll_provider drivers/clk/visconti/pll.o
struct visconti_pll_provider {
	void *                     reg_base;             /*     0     8 */
	struct clk_hw_onecell_data clk_data;             /*     8     8 */
	struct device_node *       node;                 /*    16     8 */

	/* size: 24, cachelines: 1, members: 3 */
	/* last cacheline: 24 bytes */
};

And then, after the allocation, some data is written into all members
of `struct visconti_pll_provider`:

332         for (i = 0; i < nr_plls; ++i)
333                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
334
335         ctx->node = np;
336         ctx->reg_base = base;
337         ctx->clk_data.num = nr_plls;

Fix all these by placing the declaration of object `clk_data` at the
end of `struct visconti_pll_provider`. Also, add a comment to make it
clear that this object must always be last in the structure, and
prevent this bug from being introduced again in the future.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Cc: stable@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
index 01d07f1bf01b..c4bd40676da4 100644
--- a/drivers/clk/visconti/pll.h
+++ b/drivers/clk/visconti/pll.h
@@ -15,8 +15,10 @@
 
 struct visconti_pll_provider {
 	void __iomem *reg_base;
-	struct clk_hw_onecell_data clk_data;
 	struct device_node *node;
+
+	/* Must be last */
+	struct clk_hw_onecell_data clk_data;
 };
 
 #define VISCONTI_PLL_RATE(_rate, _dacen, _dsmen, \

