Return-Path: <stable+bounces-1299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F667F7EFB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B3F282425
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D135F1D;
	Fri, 24 Nov 2023 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obhSwf1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954433CFD;
	Fri, 24 Nov 2023 18:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506AAC433C7;
	Fri, 24 Nov 2023 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851053;
	bh=GrxQOQsjI5hijo4KC9x3Fktvo9zcyi38XeQIUED2MZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obhSwf1eC4bZmT+oLq61iJVb6LETlMrGWaRdq0NjBztUTxzH1R0kwPjVIJY/h7rgR
	 oekFbpT7SzUxLGMn7kGpmGodzzHRNvIpFMIsjpVxcoTyrFpDFqDcNC5dEM8xPKlkox
	 zS0Kdglg4MdIkzb6XeaEFkshZ/DDxilTq1vpmhbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <keescook@chromium.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.5 294/491] clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider
Date: Fri, 24 Nov 2023 17:48:50 +0000
Message-ID: <20231124172033.404502210@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit 5ad1e217a2b23aa046b241183bd9452d259d70d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/visconti/pll.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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



