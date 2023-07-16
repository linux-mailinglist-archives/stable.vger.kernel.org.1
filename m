Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEC7551C1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGPT7w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjGPT7v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D31B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D8560EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6DEC433CB;
        Sun, 16 Jul 2023 19:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537588;
        bh=P5n6vrhK8gYC0Go8G7Ou+8N9VkeXprPXCA1VtA/QWXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPbgJWkK0i7YiJkArXnUrAfnDvqAy2MqVakhcD9PpfsM/VqNXwPScTQ6ONb1muYlT
         QvZI4HBSkonEMl9j4+KjnuXtKyBeGLMbi92u3Lbzsm90cP8Tb7dmmwIW9RNQq8Rr8a
         QZ2Z2fhuQokF2tCDvnrOz6wntsaRgsfjJkI+G0Ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 120/800] sfc: release encap match in efx_tc_flow_free()
Date:   Sun, 16 Jul 2023 21:39:33 +0200
Message-ID: <20230716194951.894731334@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit 28fa3ac487c6d30aaa10570481c27b6adfc492b3 ]

When force-freeing leftover entries from our match_action_ht, call
 efx_tc_delete_rule(), which releases all the rule's resources, rather
 than open-coding it.  The open-coded version was missing a call to
 release the rule's encap match (if any).
It probably doesn't matter as everything's being torn down anyway, but
 it's cleaner this way and prevents further error messages potentially
 being logged by efx_tc_encap_match_free() later on.
Move efx_tc_flow_free() further down the file to avoid introducing a
 forward declaration of efx_tc_delete_rule().

Fixes: 17654d84b47c ("sfc: add offloading of 'foreign' TC (decap) rules")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/tc.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index c004443c1d58c..d7827ab3761f9 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -132,23 +132,6 @@ static void efx_tc_free_action_set_list(struct efx_nic *efx,
 	/* Don't kfree, as acts is embedded inside a struct efx_tc_flow_rule */
 }
 
-static void efx_tc_flow_free(void *ptr, void *arg)
-{
-	struct efx_tc_flow_rule *rule = ptr;
-	struct efx_nic *efx = arg;
-
-	netif_err(efx, drv, efx->net_dev,
-		  "tc rule %lx still present at teardown, removing\n",
-		  rule->cookie);
-
-	efx_mae_delete_rule(efx, rule->fw_id);
-
-	/* Release entries in subsidiary tables */
-	efx_tc_free_action_set_list(efx, &rule->acts, true);
-
-	kfree(rule);
-}
-
 /* Boilerplate for the simple 'copy a field' cases */
 #define _MAP_KEY_AND_MASK(_name, _type, _tcget, _tcfield, _field)	\
 if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_##_name)) {		\
@@ -1451,6 +1434,21 @@ static void efx_tc_encap_match_free(void *ptr, void *__unused)
 	kfree(encap);
 }
 
+static void efx_tc_flow_free(void *ptr, void *arg)
+{
+	struct efx_tc_flow_rule *rule = ptr;
+	struct efx_nic *efx = arg;
+
+	netif_err(efx, drv, efx->net_dev,
+		  "tc rule %lx still present at teardown, removing\n",
+		  rule->cookie);
+
+	/* Also releases entries in subsidiary tables */
+	efx_tc_delete_rule(efx, rule);
+
+	kfree(rule);
+}
+
 int efx_init_struct_tc(struct efx_nic *efx)
 {
 	int rc;
-- 
2.39.2



