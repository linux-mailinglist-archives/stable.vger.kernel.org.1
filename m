Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779AE75544D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjGPU2z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjGPU2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD5F126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3EE60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F07EC433C7;
        Sun, 16 Jul 2023 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539332;
        bh=XKwpodVx4pE0wG/xfjochq/EXojhxjcsfoMdwl0hzKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecK2TZmHBzRm0FHR/iUdRVNuQP9keHUEt8ktfLghEUpGUPtQ/wFd5kx9tQ9fnVdPp
         kefUlo6ii2Wm79yIzUFb0aiik0wWDOlTpBkkEuE92nPjaFzVS13PvOBk2H9ZfBAiwT
         fkeiewpPSW6J+I9lnCC6dkNhVHPLyfYFgcZqGCDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.4 771/800] ARM: orion5x: fix d2net gpio initialization
Date:   Sun, 16 Jul 2023 21:50:24 +0200
Message-ID: <20230716195007.056984393@linuxfoundation.org>
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

commit f8ef1233939495c405a9faa4bd1ae7d3f581bae4 upstream.

The DT version of this board has a custom file with the gpio
device. However, it does nothing because the d2net_init()
has no caller or prototype:

arch/arm/mach-orion5x/board-d2net.c:101:13: error: no previous prototype for 'd2net_init'

Call it from the board-dt file as intended.

Fixes: 94b0bd366e36 ("ARM: orion5x: convert d2net to Device Tree")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230516153109.514251-10-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-orion5x/board-dt.c |    3 +++
 arch/arm/mach-orion5x/common.h   |    6 ++++++
 2 files changed, 9 insertions(+)

--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -60,6 +60,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
+	if (of_machine_is_compatible("lacie,d2-network"))
+		d2net_init();
+
 	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -73,6 +73,12 @@ extern void mss2_init(void);
 static inline void mss2_init(void) {}
 #endif
 
+#ifdef CONFIG_MACH_D2NET_DT
+void d2net_init(void);
+#else
+static inline void d2net_init(void) {}
+#endif
+
 /*****************************************************************************
  * Helpers to access Orion registers
  ****************************************************************************/


