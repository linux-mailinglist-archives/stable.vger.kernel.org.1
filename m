Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C147A3B37
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjIQUOb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjIQUOW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE22F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B266C433C8;
        Sun, 17 Sep 2023 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981657;
        bh=R9oCtdVxAPALNyxWSqY9pNAbKAx/hn0r78ZZM8lihu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlLLJzL+y/yQNEep4XP/k2LlkxsJROqZ1uP/GjVWUEr0W8wj0cjp7xCyYxNEXFV0D
         Szu7NaKZfGoB4Tck+AQzp9EjTOrP6DjTmsxwZmtuK8mfKHdCU4qK+KWIOoHovKrDLA
         Zw9lJ9b0u5ZrVfojUAlrGAKuB6mkfB7UBJaoCpjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 153/219] ata: pata_ftide010: Add missing MODULE_DESCRIPTION
Date:   Sun, 17 Sep 2023 21:14:40 +0200
Message-ID: <20230917191046.549025952@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 7274eef5729037300f29d14edeb334a47a098f65 upstream.

Add the missing MODULE_DESCRIPTION() to avoid warnings such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/pata_ftide010.o

when compiling with W=1.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_ftide010.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -567,6 +567,7 @@ static struct platform_driver pata_ftide
 };
 module_platform_driver(pata_ftide010_driver);
 
+MODULE_DESCRIPTION("low level driver for Faraday Technology FTIDE010");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);


