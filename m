Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A306FA622
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjEHKQm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjEHKQj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5A4BBE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08ED2624A0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D2DC4339B;
        Mon,  8 May 2023 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540995;
        bh=PtxQm6ebCP86wI7a0NbfcbRQJZlJ/6yGIi6c0zjSYzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcGW7NIOHlR2idy2hyEfpkYLM7KVXts8T1Bj+tfdhM8urVy74U9Z+z142cK6Bs1Nd
         ERjSDjmWuu3gF+hANeBRQoftkvF8XY/YKlARJdaVuMllie9m3y2VciGb/arylYD2Tw
         eLzE3jJ37M/8C6xRbpFF0ZviACeOTjDCHXu+C+rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 6.1 576/611] mtd: spi-nor: core: Update flashs current address mode when changing address mode
Date:   Mon,  8 May 2023 11:46:58 +0200
Message-Id: <20230508094440.667124175@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
@@ -2696,6 +2696,7 @@ static int spi_nor_quad_enable(struct sp
 
 static int spi_nor_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	int err;
 
 	err = spi_nor_octal_dtr_enable(nor, true);
@@ -2737,9 +2738,10 @@ static int spi_nor_init(struct spi_nor *
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


