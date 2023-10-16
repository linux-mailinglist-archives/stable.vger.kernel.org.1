Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5F7CA2E6
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjJPI46 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjJPI45 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:56:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7232B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:56:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F3EC433C7;
        Mon, 16 Oct 2023 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446615;
        bh=/NSwK1Orh/KHe+dZQaWWpItwHqFwweYp/HNZKAHhIVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1Xwki5GnNuw92a7i+3+J5ePG1acinAe2qrLTqx2iwbJNZ7v6WDkIJCOBs4f1pijM
         1g16DqRViIa//HwLvHFFWPpeCCjh/9tm6cR9NnB5QDsL/RtwScvfYueGTVU+jogF/U
         aPiw7Gik7uJmpNusH/FqmC0KEnbiBaYqq47yEh94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/131] net/mlx5e: macsec: use update_pn flag instead of PN comparation
Date:   Mon, 16 Oct 2023 10:40:41 +0200
Message-ID: <20231016084001.511834177@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

[ Upstream commit fde2f2d7f23d39f2fc699ba6d91ac3f4a2e637ca ]

When updating the SA, use the new update_pn flags instead of comparing the
new PN with the initial one.

Comparing the initial PN value with the new value will allow the user
to update the SA using the initial PN value as a parameter like this:
$ ip macsec add macsec0 tx sa 0 pn 1 on key 00 \
ead3664f508eb06c40ac7104cdae4ce5
$ ip macsec set macsec0 tx sa 0 pn 1 off

Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
Fixes: aae3454e4d4c ("net/mlx5e: Add MACsec offload Rx command support")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 0f8f3ce35537d..a7832a0180ee6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -611,7 +611,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (tx_sa->next_pn != ctx_tx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(netdev, "MACsec offload: update TX sa %d PN isn't supported\n",
 			   assoc_num);
 		err = -EINVAL;
@@ -1016,7 +1016,7 @@ static int mlx5e_macsec_upd_rxsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	if (rx_sa->next_pn != ctx_rx_sa->next_pn_halves.lower) {
+	if (ctx->sa.update_pn) {
 		netdev_err(ctx->netdev,
 			   "MACsec offload update RX sa %d PN isn't supported\n",
 			   assoc_num);
-- 
2.40.1



