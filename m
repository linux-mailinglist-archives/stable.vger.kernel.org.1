Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011837ED6FD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjKOWEs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjKOWEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0819D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF5C433C8;
        Wed, 15 Nov 2023 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085884;
        bh=xDvpzxGMFAZOXwW3B8WymlPVrtuoq4yXCN1gNrsAq5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFl856qgbmGatsp/KSLFKtlp67dWUvQxpVqlYt+FIp/30eDg+1KIb41xMWnxFEMZS
         wW5WB0X2+9/ssV46VSKDsi7qpnZqeWP7RIN3QSwOTUb+YNO28XXsdK0kw+ojhloFsh
         jyLVlWitmga1iwQlUd3EV2DRsnzVqBPJeGrAmEfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/119] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
Date:   Wed, 15 Nov 2023 17:01:10 -0500
Message-ID: <20231115220135.128781603@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 83c761f568733277ce1f7eb9dc9e890649c29a8c ]

If pxad_alloc_desc() fails on the first dma_pool_alloc() call, then
sw_desc->nb_desc is zero.
In such a case pxad_free_desc() is called and it will BUG_ON().

Remove this erroneous BUG_ON().

It is also useless, because if "sw_desc->nb_desc == 0", then, on the first
iteration of the for loop, i is -1 and the loop will not be executed.
(both i and sw_desc->nb_desc are 'int')

Fixes: a57e16cf0333 ("dmaengine: pxa: add pxa dmaengine driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pxa_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 68d9d60c051d9..9ce75ff9fa1cc 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -723,7 +723,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
-- 
2.42.0



