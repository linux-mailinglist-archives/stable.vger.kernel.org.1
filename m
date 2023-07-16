Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE5755454
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGPU3O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGPU3N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C949F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B0360EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7846C433C8;
        Sun, 16 Jul 2023 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539352;
        bh=gIZYEkEaFs16W+lz+gz10R4SOe88xnJ0rJVtdSOq2jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQbkvyNBaThfppfqXPMgCFpUNk4945NfMo6dBS75yQLNohCX4JbdeBFA566ZeQ/It
         GLQWBqBRE5SeXqSo5PvYHvj4gDRX6z2pzbJ+LHyEdjgaNMYpncRqjn5MAX1OkPEP5G
         X5nL42NxXArGlV4yS5WUpzyklN3GWRq+GITPLeoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.4 777/800] Input: ads7846 - fix pointer cast warning
Date:   Sun, 16 Jul 2023 21:50:30 +0200
Message-ID: <20230716195007.196633296@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 11ca605653480b2ddc70ec142a0a686796a7fc87 upstream.

The previous bugfix caused a warning on 64-bit builds:

drivers/input/touchscreen/ads7846.c:1126:17: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]

Change the cast back to something that works on both 32-bit and 64-bit
kernels.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306100442.jStknDT1-lkp@intel.com/
Fixes: 8f7913c04f6a7 ("Input: ads7846 - Fix usage of match data")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/ads7846.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1123,7 +1123,7 @@ static const struct ads7846_platform_dat
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->model = (u32)device_get_match_data(dev);
+	pdata->model = (uintptr_t)device_get_match_data(dev);
 
 	device_property_read_u16(dev, "ti,vref-delay-usecs",
 				 &pdata->vref_delay_usecs);


