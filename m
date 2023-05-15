Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455E703333
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbjEOQe1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbjEOQeY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB45213D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E6E627D4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C61C433D2;
        Mon, 15 May 2023 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168454;
        bh=ufqFlv+I9tCin+KtiMY6Y3gmHisBpvYSxrl/qB3IAjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7qGeC7OJWe/4zwGc5cBjfbc+hznVhTDclQpVByfoz2feL5f3MoNRlYrZ5cQUVVEN
         rocpXCsxzZQQ0M12UjONSNe8BAdvLIjA0xYNy1Zg/cBtaxKTWFvhecx0ZQH/cotOdT
         Z2ljRyzM/+lmS7UJPIE9i1JD9hOGkSUBpkIoz3O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/116] tty: serial: fsl_lpuart: adjust buffer length to the intended size
Date:   Mon, 15 May 2023 18:25:50 +0200
Message-Id: <20230515161700.031734357@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shenwei Wang <shenwei.wang@nxp.com>

[ Upstream commit f73fd750552524b06b5d77ebfdd106ccc8fcac61 ]

Based on the fls function definition provided below, we should not
subtract 1 to obtain the correct buffer length:

fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.

Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Link: https://lore.kernel.org/r/20230410195555.1003900-1-shenwei.wang@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 20dd476e4d1a1..e7ab8ec032cfe 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -998,7 +998,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
-- 
2.39.2



