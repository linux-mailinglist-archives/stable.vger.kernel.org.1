Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF07DD3FD
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjJaRGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjJaRGW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF201719
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:04:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84742C433C9;
        Tue, 31 Oct 2023 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771854;
        bh=Bev+ZGCK09Bjg20im2KL4/On+77LlwwRFx8ry6HmW20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0UbSpA06Ro3b3mj6DAE8HUfvx0aBSJUtrRCwvGQJtqv3v/8BbNRHhG2q0g/bAps6
         RoSQztAczKOUolS7NJ3/DbiVUHUoyTKl+cLaS0BXOdlL5v7PybR7M+yCQiGvDP15Li
         8HODE2LntOiYrZ79e2ImFGvnJq0RKRiMIhIjItQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dell Jin <dell.jin.code@outlook.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 43/86] net: ethernet: adi: adin1110: Fix uninitialized variable
Date:   Tue, 31 Oct 2023 18:01:08 +0100
Message-ID: <20231031165919.954603888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dell Jin <dell.jin.code@outlook.com>

[ Upstream commit 965f9b8c0c1b37fa2a0e3ef56e40d5666d4cbb5c ]

The spi_transfer struct has to have all it's fields initialized to 0 in
this case, since not all of them are set before starting the transfer.
Otherwise, spi_sync_transfer() will sometimes return an error.

Fixes: a526a3cc9c8d ("net: ethernet: adi: adin1110: Fix SPI transfers")
Signed-off-by: Dell Jin <dell.jin.code@outlook.com>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index ed2863ed6a5bb..7474afc0e8e73 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -294,7 +294,7 @@ static int adin1110_read_fifo(struct adin1110_port_priv *port_priv)
 {
 	struct adin1110_priv *priv = port_priv->priv;
 	u32 header_len = ADIN1110_RD_HEADER_LEN;
-	struct spi_transfer t;
+	struct spi_transfer t = {0};
 	u32 frame_size_no_fcs;
 	struct sk_buff *rxb;
 	u32 frame_size;
-- 
2.42.0



