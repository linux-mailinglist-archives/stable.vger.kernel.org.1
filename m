Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2A703AAA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjEORxz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjEORxe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C145183C2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD5E62F4D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A9C433EF;
        Mon, 15 May 2023 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173021;
        bh=MSzEmfhV34/Qm08lf+S6uzObVmbAM0f4IvMleLVFik8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AG+RfBT2NNpS0Xalx5HsCZSnIUXUIce/HuH1xH5xjR99cgB5378POwZOIiJUcCitA
         AOcL7ywbdH7UNj/if1OQ4z9a6ILqwEF7v72AFmOfTOdfkRDi6lDYP36jFQcHVRTIRV
         4dOjCORf6ThUcIr+V8xUcDKVHWgbA+SL/XZ11nAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5.10 342/381] sh: mcount.S: fix build error when PRINTK is not enabled
Date:   Mon, 15 May 2023 18:29:53 +0200
Message-Id: <20230515161752.310148076@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

commit c2bd1e18c6f85c0027da2e5e7753b9bfd9f8e6dc upstream.

Fix a build error in mcount.S when CONFIG_PRINTK is not enabled.
Fixes this build error:

sh2-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
(.text+0xec): undefined reference to `dump_stack'

Fixes: e460ab27b6c3 ("sh: Fix up stack overflow check with ftrace disabled.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230306040037.20350-8-rdunlap@infradead.org
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -18,7 +18,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to


