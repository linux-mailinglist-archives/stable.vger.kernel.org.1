Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1B7A3D65
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbjIQUmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbjIQUl5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:41:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218910F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:41:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037EEC433C8;
        Sun, 17 Sep 2023 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983311;
        bh=ebMbN/xwSpPHOUl3EL+rJRF0wtCLmSAXwETay895pjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOpC6aFukgDMPVeSK5vr9RFrOta+oqxDwgdZeKFdRlIUL2o3wcDjoKjPF9ZwmV+8k
         Q1V7RZxfJCKFd2S8/NzTcfOjRRWVDpefrITLOHHYQZvocUBQUwq8VgTYJNlMo8y/6S
         XK7MLUZGLn0lBDqzAdgC2zZppvFffVF9UUV7MJqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 465/511] dmaengine: sh: rz-dmac: Fix destination and source data size setting
Date:   Sun, 17 Sep 2023 21:14:52 +0200
Message-ID: <20230917191124.980095911@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hien Huynh <hien.huynh.px@renesas.com>

commit c6ec8c83a29fb3aec3efa6fabbf5344498f57c7f upstream.

Before setting DDS and SDS values, we need to clear its value first
otherwise, we get incorrect results when we change/update the DMA bus
width several times due to the 'OR' expression.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@kernel.org
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230706112150.198941-3-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rz-dmac.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -9,6 +9,7 @@
  * Copyright 2012 Javier Martin, Vista Silicon <javier.martin@vista-silicon.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -143,8 +144,8 @@ struct rz_dmac {
 #define CHCFG_REQD			BIT(3)
 #define CHCFG_SEL(bits)			((bits) & 0x07)
 #define CHCFG_MEM_COPY			(0x80400008)
-#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
-#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
+#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
+#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
 #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
 #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
 #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
@@ -607,13 +608,15 @@ static int rz_dmac_config(struct dma_cha
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_DDS(val);
+	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
 
 	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_SDS(val);
+	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
 
 	return 0;
 }


