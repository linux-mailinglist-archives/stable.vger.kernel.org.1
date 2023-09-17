Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245A97A39AB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbjIQTxG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbjIQTws (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFC5CE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B3CC433CC;
        Sun, 17 Sep 2023 19:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980316;
        bh=pVfnzpF0V6cgcOhe/k6yemAvLztH2I+mWebS/YDwZwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7L0zziNGcmBvhVh4SIiZop4KMA3towRc3j8OLWFAoYE9sFzsXsWYCDp2V9NRYiGl
         g4h6rHSLDN17jneoKDHI8yeKT296mLY6QBt7e4qUFLyKn1tV3LjG4owZVjtMX9ARqJ
         +ghDmV5qwTLW3eXcHROGlhLFmzhSRPYF6aG04tY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 156/285] net: phylink: fix sphinx complaint about invalid literal
Date:   Sun, 17 Sep 2023 21:12:36 +0200
Message-ID: <20230917191057.080629903@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 1a961e74d5abbea049588a3d74b759955b4ed9d5 ]

sphinx complains about the use of "%PHYLINK_PCS_NEG_*":

Documentation/networking/kapi:144: ./include/linux/phylink.h:601: WARNING: Inline literal start-string without end-string.
Documentation/networking/kapi:144: ./include/linux/phylink.h:633: WARNING: Inline literal start-string without end-string.

These are not valid symbols so drop the '%' prefix.

Alternatively we could use %PHYLINK_PCS_NEG_\* (escape the *)
or use normal literal ``PHYLINK_PCS_NEG_*`` but there is already
a handful of un-adorned DEFINE_* in this file.

Fixes: f99d471afa03 ("net: phylink: add PCS negotiation mode")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20230626162908.2f149f98@canb.auug.org.au/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/phylink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1817940a3418e..4dff1eba425ba 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -615,7 +615,7 @@ void pcs_get_state(struct phylink_pcs *pcs,
  *
  * The %neg_mode argument should be tested via the phylink_mode_*() family of
  * functions, or for PCS that set pcs->neg_mode true, should be tested
- * against the %PHYLINK_PCS_NEG_* definitions.
+ * against the PHYLINK_PCS_NEG_* definitions.
  */
 int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	       phy_interface_t interface, const unsigned long *advertising,
@@ -645,7 +645,7 @@ void pcs_an_restart(struct phylink_pcs *pcs);
  *
  * The %mode argument should be tested via the phylink_mode_*() family of
  * functions, or for PCS that set pcs->neg_mode true, should be tested
- * against the %PHYLINK_PCS_NEG_* definitions.
+ * against the PHYLINK_PCS_NEG_* definitions.
  */
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
-- 
2.40.1



