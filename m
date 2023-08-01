Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32CE76AF87
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjHAJsd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHAJsR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C1B35A9
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C515614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CADC433C7;
        Tue,  1 Aug 2023 09:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883199;
        bh=d6EulDygj8rJMQLCktFMZbCy/cY2VFdd/lQ/qxV5oRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neE1DMw/buX4oAASV5wYuUdKN7DvnrCfdjFwHtLWWHf5vF3n9cudM6W3thFmR99Gi
         CNzspalcJV6LkruizS8TGwBj0Q3mbC7L5a7/Nrn8g2FbkBDAdhGIcHiaXOMyRfgBOZ
         KJmC5K7xwN7j/28/I9yOaZaMQiX74ACe3jLP/4i4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.4 150/239] tty: serial: sh-sci: Fix sleeping in atomic context
Date:   Tue,  1 Aug 2023 11:20:14 +0200
Message-ID: <20230801091931.073219207@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 57c984f6fe20ebb9306d6e8c09b4f67fe63298c6 upstream.

Fix sleeping in atomic context warning as reported by the Smatch static
checker tool by replacing disable_irq->disable_irq_nosync.

Reported by: Dan Carpenter <dan.carpenter@linaro.org>

Fixes: 8749061be196 ("tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230704154818.406913-1-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7c9457962a3d..8b7a42e05d6d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -590,7 +590,7 @@ static void sci_start_tx(struct uart_port *port)
 	    dma_submit_error(s->cookie_tx)) {
 		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			/* Switch irq from SCIF to DMA */
-			disable_irq(s->irqs[SCIx_TXI_IRQ]);
+			disable_irq_nosync(s->irqs[SCIx_TXI_IRQ]);
 
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
-- 
2.41.0



