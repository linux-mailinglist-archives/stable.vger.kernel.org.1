Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D897014A9
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEMGhl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEMGhl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA032D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC0660A4C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DDC433D2;
        Sat, 13 May 2023 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683959858;
        bh=wV1HnU0GtzR+k9HyWl6uTSEbbBXCMWI1P4DT+XBSp+s=;
        h=Subject:To:Cc:From:Date:From;
        b=PieYVo5mgK0T52V9AxKKhAZ0nSTsooiiWF7K5JxG6i0pHmYcsvWPF0FWXNHS8ZvNC
         gDVHun1VJKWmxKFWsg95Q/ow204fk+7dV9Ae6gucEgtGZEEuORuQPaidF2QIcuR1ax
         19eZiTUNikpplkNrtysHEWrz3YfDfOta8q7gHQVs=
Subject: FAILED: patch "[PATCH] sh: mcount.S: fix build error when PRINTK is not enabled" failed to apply to 5.4-stable tree
To:     rdunlap@infradead.org, dalias@libc.org, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, ysato@users.sourceforge.jp
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:37:27 +0900
Message-ID: <2023051327-diligence-reshuffle-6a74@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c2bd1e18c6f85c0027da2e5e7753b9bfd9f8e6dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051327-diligence-reshuffle-6a74@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

c2bd1e18c6f8 ("sh: mcount.S: fix build error when PRINTK is not enabled")
37744feebc08 ("sh: remove sh5 support")
62d0fd591db1 ("arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>")
630f289b7114 ("asm-generic: make more kernel-space headers mandatory")
a8222fd5b80c ("Merge tag 'microblaze-v5.7-rc1' of git://git.monstr.eu/linux-2.6-microblaze")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2bd1e18c6f85c0027da2e5e7753b9bfd9f8e6dc Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 5 Mar 2023 20:00:37 -0800
Subject: [PATCH] sh: mcount.S: fix build error when PRINTK is not enabled

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

diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 10290e5c1f43..c449e7c1b20f 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -15,7 +15,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to

