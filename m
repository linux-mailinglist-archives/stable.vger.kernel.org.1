Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B8703BB1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbjEOSFj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbjEOSFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB51642E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B544D6308A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79CAC433EF;
        Mon, 15 May 2023 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173783;
        bh=8IRDboiAUfkN8eIP76QsBYpg74IQdeQDSZWWd6TMdgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pd6gKWF+vNxmwbhi2UcPHo3hbCIvrsMqV3Q01SUacZ3RcJR3VcDCzbElMppPy4mdw
         EIdBoLZToG+5WN9nLqJxZgJgG7Tjaw6/A81Es67afP3x/ZKNgIMijKmyF0cXoQ+/q9
         ARtsnlZNAQrKyF4gXuJbyvDyVBsWdYARe7Ipl1zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaoqian Lin <linmq006@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 174/282] Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe
Date:   Mon, 15 May 2023 18:29:12 +0200
Message-Id: <20230515161727.496327737@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 5bca3688bdbc3b58a2894b8671a8e2378efe28bd ]

rpi_firmware_get() take reference, we need to release it in error paths
as well. Use devm_rpi_firmware_get() helper to handling the resources.
Also remove the existing rpi_firmware_put().

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Fixes: 3b8ddff780b7 ("input: raspberrypi-ts: Release firmware handle when not needed")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Link: https://lore.kernel.org/r/20221223074657.810346-1-linmq006@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/raspberrypi-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index 4740a7c412364..8135a80226fd6 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -137,7 +137,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
@@ -164,7 +164,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-	rpi_firmware_put(fw);
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
-- 
2.39.2



