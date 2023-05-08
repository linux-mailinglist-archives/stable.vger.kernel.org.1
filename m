Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC56FA954
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjEHKuE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjEHKta (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25441A12A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A148C61DA2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B578C433EF;
        Mon,  8 May 2023 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542936;
        bh=8E8uH+tayCkP/JNoEemaa8uU+tXfPd3bERWLmW8TZIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBQHLWOnXNSSlEzDVTJOgGEsCqUZyhplxiY7gsnV36S3AaGBmD3gxGzP7x0WPYnws
         mSoY7WYWDc8aE86RtEHAVeuR635O77n6bDpZnM5noxOi08gGlyz1IjwC/ko6c9P4+d
         u1aplP+esl9L6gkl6rVz/F+pBmenRPv8YO01yoG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaoqian Lin <linmq006@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 561/663] Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe
Date:   Mon,  8 May 2023 11:46:27 +0200
Message-Id: <20230508094447.361005677@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index 5000f5fd9ec38..45c575df994e0 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
@@ -160,7 +160,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-	rpi_firmware_put(fw);
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
-- 
2.39.2



