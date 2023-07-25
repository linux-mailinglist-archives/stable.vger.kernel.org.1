Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC37616D7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjGYLnq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjGYLnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA01FD0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C5B616C2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E3C433C8;
        Tue, 25 Jul 2023 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285355;
        bh=AHAfLPUTCUUHRsnA2xM2PyG6fmI/bjg4m342f+s8WGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifvGH5PRYeJMRAedL8kJO8Jt4C8Rzp+alC3g95zj2h5Gvh6S6raZpo0VpKSzWcp0h
         robnv717452T9MiWvD0xwLPTDAOBXR3oLZBjpAYCBAIdk2NL+eiIfcy0jD27o+G8Pg
         UiP9zKf8hoioDTLCtddiPv/BRiOMLUTzMYe5d+6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.4 175/313] ARM: orion5x: fix d2net gpio initialization
Date:   Tue, 25 Jul 2023 12:45:28 +0200
Message-ID: <20230725104528.516969103@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
@@ -63,6 +63,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
+	if (of_machine_is_compatible("lacie,d2-network"))
+		d2net_init();
+
 	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -75,6 +75,12 @@ extern void mss2_init(void);
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


