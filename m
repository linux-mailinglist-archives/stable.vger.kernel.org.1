Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3283C7876B6
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbjHXRTD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbjHXRSo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC210D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9735674D8
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B00C433C9;
        Thu, 24 Aug 2023 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897521;
        bh=l9IWkMJy0fR6oiY38YCyOcn2AhgIZEdqtKPj1PQh/ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujaud2OmOEr8mJDnPxCdr6sNuInAVldTuah/ArNZ2NTgg1eOqCUZV0DHuswbK1k2N
         DYlw8K+apRNUZVEHOcx0tCinL+ysi+GGPSTV52Ih+FOPKu32zPN6a7h0O6uuQfgwpT
         olGTrBFUQ0I71NFPWQtyabtIMm8Hl4Q2y9Ji3kLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.10 069/135] i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue
Date:   Thu, 24 Aug 2023 19:09:01 +0200
Message-ID: <20230824170620.191560823@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -242,13 +242,14 @@ static inline u32 iproc_i2c_rd_reg(struc
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
@@ -259,12 +260,14 @@ static inline u32 iproc_i2c_rd_reg(struc
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


