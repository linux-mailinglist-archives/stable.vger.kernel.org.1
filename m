Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256FB7A38EC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjIQTm4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbjIQTm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E421A6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:41:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C65C433C9;
        Sun, 17 Sep 2023 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979718;
        bh=7KhXmb7msdYGw1OJyfK791yUSYcWnPVAKulh5E6IpYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRzNxC140VfNACylTOP7yjV7bdzSMgSwZfzGsWaAUbzyC+izhz6IFIHJ/iaHf/QK2
         fALhWpxVXS3mGfEomq3EkKfDdomIjpDuP+ahhbrsA1G9YBVlh6TIBmVruRGQAQnJ+g
         hm7dRyPMEjzO3SeudJG8V2D75DXrNa+sl6wONlMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.10 369/406] ata: sata_gemini: Add missing MODULE_DESCRIPTION
Date:   Sun, 17 Sep 2023 21:13:43 +0200
Message-ID: <20230917191111.010246569@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 8566572bf3b4d6e416a4bf2110dbb4817d11ba59 upstream.

Add the missing MODULE_DESCRIPTION() to avoid warnings such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/sata_gemini.o

when compiling with W=1.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/sata_gemini.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -435,6 +435,7 @@ static struct platform_driver gemini_sat
 };
 module_platform_driver(gemini_sata_driver);
 
+MODULE_DESCRIPTION("low level driver for Cortina Systems Gemini SATA bridge");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);


