Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ADE7A7D12
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjITMGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjITMGS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E2E4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:06:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CE6C433CA;
        Wed, 20 Sep 2023 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211571;
        bh=kTqqnU1/in/vpj4X+DdDXq0kQFAoooWwWXk3Hs1U8H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4tuF+6wTNTXcRyUpvkv5zW/Q1bvLsyGAGCSlxS8cmGg5lKMompAMSzn+diT/D8fZ
         7sChRDFXZy+M2WKjTGDTC+WqMYFQE7H7x7e1BpeXK0adrooep4ZTnFrQev3c/cydvo
         3ZbaeLLYIqbrpDGObv2Gtq1Il9w8KoL6ULYjGFmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 143/186] ata: pata_ftide010: Add missing MODULE_DESCRIPTION
Date:   Wed, 20 Sep 2023 13:30:46 +0200
Message-ID: <20230920112842.146910658@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -569,6 +569,7 @@ static struct platform_driver pata_ftide
 };
 module_platform_driver(pata_ftide010_driver);
 
+MODULE_DESCRIPTION("low level driver for Faraday Technology FTIDE010");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);


