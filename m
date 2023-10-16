Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE77CA38A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjJPJHx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjJPIqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F0E6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50885C433C8;
        Mon, 16 Oct 2023 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445969;
        bh=MkPz1B069qjXTm/hyglTzJIa2QgTx/F+loJiRKzOBhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLVgQh++535TfYGQfNdHadqP5DvEiOQE2O5zpQNQpsOrwIpUfyOoThEKVQydQbQJV
         OA4qEVkJkBLGAsDub34L13Sig/UFNqqV+k5K8Qlyr+FnP4N/Pt9XNl0kzNuxaOxigd
         JjId5IB2GOA8C3dR14y892c1OH07lw800rlhHuQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 047/102] dmaengine: stm32-mdma: abort resume if no ongoing transfer
Date:   Mon, 16 Oct 2023 10:40:46 +0200
Message-ID: <20231016083954.951857406@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

commit 81337b9a72dc58a5fa0ae8a042e8cb59f9bdec4a upstream.

chan->desc can be null, if transfer is terminated when resume is called,
leading to a NULL pointer when retrieving the hwdesc.
To avoid this case, check that chan->desc is not null and channel is
disabled (transfer previously paused or terminated).

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231004163531.2864160-1-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-mdma.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1206,6 +1206,10 @@ static int stm32_mdma_resume(struct dma_
 	unsigned long flags;
 	u32 status, reg;
 
+	/* Transfer can be terminated */
+	if (!chan->desc || (stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & STM32_MDMA_CCR_EN))
+		return -EPERM;
+
 	hwdesc = chan->desc->node[chan->curr_hwdesc].hwdesc;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);


