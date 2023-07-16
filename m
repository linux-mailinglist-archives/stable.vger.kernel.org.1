Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC0C75572A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjGPU6D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjGPU5v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D212E5C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962D860E71
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0323C433C7;
        Sun, 16 Jul 2023 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541067;
        bh=sh4PXW6Kr5AyDSqId6FLNtnbTfJmyStQpAWxwk6vm+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SncEjLA6uVqHqghue0GE7LplsPX439EGFv3q1K6azqcbuO4rhxQBRE1bJAQMZdLhe
         meaDAMqSkPg/M18Ahyhs8HnYdiPTBiOXCj88H1tG8DqeV8rgJa5GMBWkEMop0LqL2+
         IWkxGIKW/DYypxcgjCx3xbAmWTNLXSeOPClmF7PU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 580/591] mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908
Date:   Sun, 16 Jul 2023 21:51:59 +0200
Message-ID: <20230716194938.863751271@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

commit 085679b15b5af65f9610f619afde41da0f966194 upstream.

Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.

Probably due to concurrent development, commit 002181f5b150 ("mtd: parsers:
add Broadcom's U-Boot parser") introduces 'Broadcom's U-Boot partition
parser' that depends on ARCH_BCM4908, but this use was not visible during
the config refactoring from the commit above. Hence, these two changes
create a reference to a non-existing config symbol.

Adjust the MTD_BRCM_U_BOOT definition to refer to ARCH_BCMBCA instead of
ARCH_BCM4908 to remove the reference to the non-existing config symbol
ARCH_BCM4908.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20221116124932.4748-1-lukas.bulwahn@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/parsers/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -22,7 +22,7 @@ config MTD_BCM63XX_PARTS
 
 config MTD_BRCM_U_BOOT
 	tristate "Broadcom's U-Boot partition parser"
-	depends on ARCH_BCM4908 || COMPILE_TEST
+	depends on ARCH_BCMBCA || COMPILE_TEST
 	help
 	  Broadcom uses a custom way of storing U-Boot environment variables.
 	  They are placed inside U-Boot partition itself at unspecified offset.


