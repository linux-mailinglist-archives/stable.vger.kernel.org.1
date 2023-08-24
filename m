Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177B78728B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbjHXOyk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbjHXOya (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3810D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB0166F14
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D002FC433C7;
        Thu, 24 Aug 2023 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888868;
        bh=FCr8xMNc3eqSURdYKbyAEF5ViIltiMt6rSCPyUt2Dgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFvPaZx59QwQ3Bpdblh2cadz/hMTk34RLo/rPQtnKg3ho7a3FVlJSE8RVZPDvTKQc
         F9ktHa3ncul9E3YQ/mVi6ubj3Rs8rhiQAzu8RwaHBHXYSs5rVk/pWVfKHwfMLyMpP9
         tKwlfKwK5q9iuhDyDo6C3+K9FxStjqdVjoZJl1q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.15 070/139] i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue
Date:   Thu, 24 Aug 2023 16:49:53 +0200
Message-ID: <20230824145026.706664452@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chengfeng Ye <dg573847474@gmail.com>

commit 4caf4cb1eaed469742ef719f2cc024b1ec3fa9e6 upstream.

iproc_i2c_rd_reg() and iproc_i2c_wr_reg() are called from both
interrupt context (e.g. bcm_iproc_i2c_isr) and process context
(e.g. bcm_iproc_i2c_suspend). Therefore, interrupts should be
disabled to avoid potential deadlock. To prevent this scenario,
use spin_lock_irqsave().

Fixes: 9a1038728037 ("i2c: iproc: add NIC I2C support")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Acked-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-bcm-iproc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -243,13 +243,14 @@ static inline u32 iproc_i2c_rd_reg(struc
 				   u32 offset)
 {
 	u32 val;
+	unsigned long flags;
 
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		val = readl(iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		val = readl(iproc_i2c->base + offset);
 	}
@@ -260,12 +261,14 @@ static inline u32 iproc_i2c_rd_reg(struc
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
+	unsigned long flags;
+
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		writel(val, iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		writel(val, iproc_i2c->base + offset);
 	}


