Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0B6FAA31
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjEHLAd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjEHLAP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF512E049
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9AF61F39
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F994C433D2;
        Mon,  8 May 2023 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543520;
        bh=vaDW+pMskZ06wVM0nSA+WW0HTIbPuEn+CC9mZ315wMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECfYZHkJmH7IOQ/AsohVeffMnCRaIxPW515e58Jsvee7A51gEGomRORzk/LDFRgBz
         HGhXBH5ikCxUO7YLGlrSdqr2H18hVhEEMa+NNN0aAy9XJrYMkUesTLxQNmlHNANgdj
         yrAil4tgKuGItAnRk61ypIqGUiIQuPh++K/8ELxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Reid Tonking <reidt@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.3 078/694] i2c: omap: Fix standard mode false ACK readings
Date:   Mon,  8 May 2023 11:38:33 +0200
Message-Id: <20230508094435.068507067@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Reid Tonking <reidt@ti.com>

commit c770657bd2611b077ec1e7b1fe6aa92f249399bd upstream.

Using standard mode, rare false ACK responses were appearing with
i2cdetect tool. This was happening due to NACK interrupt triggering
ISR thread before register access interrupt was ready. Removing the
NACK interrupt's ability to trigger ISR thread lets register access
ready interrupt do this instead.

Cc: <stable@vger.kernel.org> # v3.7+
Fixes: 3b2f8f82dad7 ("i2c: omap: switch to threaded IRQ support")
Signed-off-by: Reid Tonking <reidt@ti.com>
Acked-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1058,7 +1058,7 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 stat;
 
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;


