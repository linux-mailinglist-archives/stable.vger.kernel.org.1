Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B078ABEA
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjH1Kfd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjH1KfC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165DA6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E4663E31
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8CC433C9;
        Mon, 28 Aug 2023 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218897;
        bh=tjzUFQMql9rsgz5aQ0LNvo1gRYhw8HXgEkoyp4W5X9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlVwGojwCgUk+x6Oy8Ds5SYGadgW+zjKR67jU0reCbL1r0U5n+Bu1fBKkij6GoYq9
         tFKri3CBakiN7cXOVmmNcAyAKYwYO0p4DrI3pwSb2Derjzvfie8UpLNdvFEEl60nW+
         +5FPtUF0wQqGFiZjejGRNCOQLAwKTAi2N4O1jXR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/122] clk: Fix undefined reference to `clk_rate_exclusive_{get,put}
Date:   Mon, 28 Aug 2023 12:13:48 +0200
Message-ID: <20230828101200.183148904@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2746f13f6f1df7999001d6595b16f789ecc28ad1 ]

The COMMON_CLK config is not enabled in some of the architectures.
This causes below build issues:

pwm-rz-mtu3.c:(.text+0x114):
undefined reference to `clk_rate_exclusive_put'
pwm-rz-mtu3.c:(.text+0x32c):
undefined reference to `clk_rate_exclusive_get'

Fix these issues by moving clk_rate_exclusive_{get,put} inside COMMON_CLK
code block, as clk.c is enabled by COMMON_CLK.

Fixes: 55e9b8b7b806 ("clk: add clk_rate_exclusive api")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202307251752.vLfmmhYm-lkp@intel.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230725175140.361479-1-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/clk.h | 80 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1ef0133242374..06f1b292f8a00 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -183,6 +183,39 @@ int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+/**
+ * clk_rate_exclusive_get - get exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to get exclusive control over the rate of a
+ * provider. It prevents any other consumer to execute, even indirectly,
+ * opereation which could alter the rate of the provider or cause glitches
+ *
+ * If exlusivity is claimed more than once on clock, even by the same driver,
+ * the rate effectively gets locked as exclusivity can't be preempted.
+ *
+ * Must not be called from within atomic context.
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_rate_exclusive_get(struct clk *clk);
+
+/**
+ * clk_rate_exclusive_put - release exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to release the exclusivity it previously got
+ * from clk_rate_exclusive_get()
+ *
+ * The caller must balance the number of clk_rate_exclusive_get() and
+ * clk_rate_exclusive_put() calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_rate_exclusive_put(struct clk *clk);
+
 #else
 
 static inline int clk_notifier_register(struct clk *clk,
@@ -236,6 +269,13 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 	return p == q;
 }
 
+static inline int clk_rate_exclusive_get(struct clk *clk)
+{
+	return 0;
+}
+
+static inline void clk_rate_exclusive_put(struct clk *clk) {}
+
 #endif
 
 #ifdef CONFIG_HAVE_CLK_PREPARE
@@ -583,38 +623,6 @@ struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
  */
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id);
-/**
- * clk_rate_exclusive_get - get exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to get exclusive control over the rate of a
- * provider. It prevents any other consumer to execute, even indirectly,
- * opereation which could alter the rate of the provider or cause glitches
- *
- * If exlusivity is claimed more than once on clock, even by the same driver,
- * the rate effectively gets locked as exclusivity can't be preempted.
- *
- * Must not be called from within atomic context.
- *
- * Returns success (0) or negative errno.
- */
-int clk_rate_exclusive_get(struct clk *clk);
-
-/**
- * clk_rate_exclusive_put - release exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to release the exclusivity it previously got
- * from clk_rate_exclusive_get()
- *
- * The caller must balance the number of clk_rate_exclusive_get() and
- * clk_rate_exclusive_put() calls.
- *
- * Must not be called from within atomic context.
- */
-void clk_rate_exclusive_put(struct clk *clk);
 
 /**
  * clk_enable - inform the system when the clock source should be running.
@@ -974,14 +982,6 @@ static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
-
-static inline int clk_rate_exclusive_get(struct clk *clk)
-{
-	return 0;
-}
-
-static inline void clk_rate_exclusive_put(struct clk *clk) {}
-
 static inline int clk_enable(struct clk *clk)
 {
 	return 0;
-- 
2.40.1



