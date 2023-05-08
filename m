Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD06FAA55
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjEHLCX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjEHLBU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F732BCD3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A7D62A0B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4CEC433D2;
        Mon,  8 May 2023 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543622;
        bh=TcG9egfCML5p5qHU9oBwGFlNahDoqoIMbUNpE41ESlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGdCFO4Mg+C0LyNNQFAy9iVFnr4XdDBDc7+34uHFrc12ui+T0pnWxXcYhCu5s51DW
         aUcxAth3VtgqOrjKDW2dkueOgAVsUl8+PKL4x1Yxt1B7CwLyN3NbIacc+uWubVcIXq
         FuZ17MmTo7Y3mIbDCJFk85Xkrd2XC6GyH+zWi9z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 6.3 118/694] mtd: spi-nor: core: Update flashs current address mode when changing address mode
Date:   Mon,  8 May 2023 11:39:13 +0200
Message-Id: <20230508094436.309120810@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Tudor Ambarus <tudor.ambarus@linaro.org>

commit 37513c56139b79dd43c1774513c28f8ab2b05224 upstream.

The bug was obswerved while reading code. There are not many users of
addr_mode_nbytes. Anyway, we should update the flash's current address
mode when changing the address mode, fix it. We don't care for now about
the set_4byte_addr_mode(nor, false) from spi_nor_restore(), as it is
used at driver remove and shutdown.

Fixes: d7931a215063 ("mtd: spi-nor: core: Track flash's internal address mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230331074606.3559258-9-tudor.ambarus@linaro.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2732,6 +2732,7 @@ static int spi_nor_quad_enable(struct sp
 
 static int spi_nor_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	int err;
 
 	err = spi_nor_octal_dtr_enable(nor, true);
@@ -2773,9 +2774,10 @@ static int spi_nor_init(struct spi_nor *
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		err = nor->params->set_4byte_addr_mode(nor, true);
+		err = params->set_4byte_addr_mode(nor, true);
 		if (err && err != -ENOTSUPP)
 			return err;
+		params->addr_mode_nbytes = 4;
 	}
 
 	return 0;


