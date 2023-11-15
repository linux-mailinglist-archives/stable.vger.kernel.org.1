Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF97ED587
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjKOVHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjKOVHZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6D196
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EE8C4E74B;
        Wed, 15 Nov 2023 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081485;
        bh=ss2lifuWG+UAjIlduAH2wIWTLyYl5Z25kObBsdZ0/Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X42SkkAMcye5vXUbrTbpMEMMcb9+fPQkm0TWn8tmC4vXWS3dJ+6FVj2ZsUat8wCwc
         E+zWiEd4eE8FSDXeYtwR9t1aRO0JmtJ6Ztz5ge9Td+hBfS/udRp9k12Eo6ViGVWFZ7
         ShT29Kwn+QyR8SXEWKy2t9JGK5BsCMgY7XPLXmVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 182/244] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
Date:   Wed, 15 Nov 2023 15:36:14 -0500
Message-ID: <20231115203559.302199612@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index e613ace79ea83..2731dc27f9d71 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -722,7 +722,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
-- 
2.42.0



