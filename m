Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CB7ECB54
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjKOTVm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjKOTVc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C37D75
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD5DC433C9;
        Wed, 15 Nov 2023 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076088;
        bh=47P3N13Ft6ZDIyEnwqWcSbazrQGB5I5yCZhUMLDXoA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+3GoJif1qvv1iU8VwqGjZN4h3Bj7dSGiwn2nbhQM2uyY2gYK8rIrRL2TwyaQkpTr
         fAJA2qfk6CFYO5LYhm5sbzcWLTYO4xvYYA45VjN6Hb7iYnD1FYk1xJjxe+p3q9GVZR
         X7pcMqTlPj8Yw9DLqbA38DZbvgXzQDv6J/7pDhN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 069/550] gve: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 14:10:53 -0500
Message-ID: <20231115191605.472697619@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit d692873cbe861a870cdc9cbfb120eefd113c3dfd ]

If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
protection that struct_size() adds against potential integer overflows
is defeated. Fix this by hardening call to struct_size() with size_add().

Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e6f1711d9be04..465a6db5a40a8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -191,7 +191,7 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
 		       priv->rx_cfg.num_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
-					     tx_stats_num + rx_stats_num);
+					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
 		dma_alloc_coherent(&priv->pdev->dev, priv->stats_report_len,
 				   &priv->stats_report_bus, GFP_KERNEL);
-- 
2.42.0



