Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135F879B5BF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbjIKVNk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjIKO2R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C6F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC8C433C7;
        Mon, 11 Sep 2023 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442493;
        bh=NZZ0YkFvvhsnlUdYyKDXfPiwC9Ex2Z9QGIdlDCASoL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNkpUvh2Yl5ZvXyib+77PDno4kWy7tQxf8aAYj/FQjYfVEiz5aAH3WhDYTTwKY0ZB
         ApAbIRsXfiM8xS2jynEN/pHU689Xwo3ScpwvlWaZC5vAflqMbZT9pDQAjGfIIrEss9
         dKEwsp7SMz89y9xG3R8/Zc97E1IZaAav92z19xPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 044/737] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Mon, 11 Sep 2023 15:38:23 +0200
Message-ID: <20230911134651.673870461@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raphael Gallais-Pou <rgallaispou@gmail.com>

[ Upstream commit 4912649e1cf0317bf563f91655e04a303cacaf8d ]

Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
ultimately causes a warning when the module probes. Fixes it.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Link: https://lore.kernel.org/r/20230718172024.67488-1-rgallaispou@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/fbtft/fb_ili9341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index 9ccd0823c3ab3..47e72b87d76d9 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -145,7 +145,7 @@ static struct fbtft_display display = {
 	},
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9341", &display);
+FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "ilitek", "ili9341", &display);
 
 MODULE_ALIAS("spi:" DRVNAME);
 MODULE_ALIAS("platform:" DRVNAME);
-- 
2.40.1



