Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD37E24F6
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKFN1F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjKFN1C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49194D75
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:26:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8377CC433C9;
        Mon,  6 Nov 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277216;
        bh=d6/FvLc5okqEnf0b/KTxRMqC4lmacV//kf7L86MXQvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr3CkSANJem8ZfnwjNlaB8AsIc2ISv97+HPH+rliN34XMVeU77MdxNNX44MkbzCzV
         CVYRWvu/v15LjTH3/7MjW3BarfpUidywTWvgVXe1twmHDGwJlvJcj3fmSHIhSuaJ5B
         HCzPNNaPZ3fFuVrbbC71sNlex0cYjAg0ZF5WLtpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Catherine Sullivan <csully@google.com>,
        David Awogbemila <awogbemila@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/128] gve: Fix GFP flags when allocing pages
Date:   Mon,  6 Nov 2023 14:03:40 +0100
Message-ID: <20231106130311.816390951@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shailend Chand <shailend@google.com>

[ Upstream commit a92f7a6feeb3884c69c1c7c1f13bccecb2228ad0 ]

Use GFP_ATOMIC when allocating pages out of the hotpath,
continue to use GFP_KERNEL when allocating pages during setup.

GFP_KERNEL will allow blocking which allows it to succeed
more often in a low memory enviornment but in the hotpath we do
not want to allow the allocation to block.

Fixes: f5cedc84a30d2 ("gve: Add transmit and receive support")
Signed-off-by: Catherine Sullivan <csully@google.com>
Signed-off-by: David Awogbemila <awogbemila@google.com>
Link: https://lore.kernel.org/r/20220126003843.3584521-1-awogbemila@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7b18b4fd9e548..d947c2c334128 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -157,7 +157,7 @@ static int gve_alloc_page_dqo(struct gve_priv *priv,
 	int err;
 
 	err = gve_alloc_page(priv, &priv->pdev->dev, &buf_state->page_info.page,
-			     &buf_state->addr, DMA_FROM_DEVICE, GFP_KERNEL);
+			     &buf_state->addr, DMA_FROM_DEVICE, GFP_ATOMIC);
 	if (err)
 		return err;
 
-- 
2.42.0



