Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306607CA258
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjJPItE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjJPItC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:49:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599AF5
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7CCC433C8;
        Mon, 16 Oct 2023 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446139;
        bh=NzOtwo/i2nhwP5zMqPGkren+/YdDjKqB+rwYImBwJws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxZyQ41BsE3SUm61DtdrU8c5meanwJiZ4pY8v3FZ+2I5X9TRzillMWWgAWMcbYSS8
         r1pPGVA2u2adbVnGc40MtLUA+HvzCR44tSv1VawtAjPEDU3xNPzT0fdfTKVTE0PAAG
         bgjxSjZ69GHa40fYukoOjPmMCmfVKA4/UTdroUc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dharma Balasubiramani <dharma.b@microchip.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 5.15 076/102] counter: microchip-tcb-capture: Fix the use of internal GCLK logic
Date:   Mon, 16 Oct 2023 10:41:15 +0200
Message-ID: <20231016083955.723339543@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dharma Balasubiramani <dharma.b@microchip.com>

commit df8fdd01c98b99d04915c04f3a5ce73f55456b7c upstream.

As per the datasheet, the clock selection Bits 2:0 – TCCLKS[2:0] should
be set to 0 while using the internal GCLK (TIMER_CLOCK1).

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Link: https://lore.kernel.org/r/20230905100835.315024-1-dharma.b@microchip.com
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/counter/microchip-tcb-capture.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -99,7 +99,7 @@ static int mchp_tc_count_function_write(
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
-		if (priv->tc_cfg->has_gclk)
+		if (!priv->tc_cfg->has_gclk)
 			cmr |= ATMEL_TC_TIMER_CLOCK2;
 		else
 			cmr |= ATMEL_TC_TIMER_CLOCK1;


