Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4957C9AC9
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJOS3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOS3Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:29:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F9DB7
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:29:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C4C433C7;
        Sun, 15 Oct 2023 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394563;
        bh=9qeTSU9er+SCncg52z55siqswEbPuRn8sUmuGZlEinw=;
        h=Subject:To:Cc:From:Date:From;
        b=ne3I5Z4pTNp5RLmRzctBPLHQcZQCf30az4OZdRzUDyM+ffhME2yTL6MflNu+8bjUk
         xuqVgIVOpp3KWEchPYYoxk4Iq3HtzFOmKTUZcKlyIbBqIKrjQodaFeeFxRnBShFzUX
         FwBI3fXX9mTNGGZT4bGpE7wOBqI61+6vH2xv8LIk=
Subject: FAILED: patch "[PATCH] riscv: Remove duplicate objcopy flag" failed to apply to 5.4-stable tree
To:     songshuaishuai@tinylab.org, palmer@rivosinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:29:12 +0200
Message-ID: <2023101512-outrank-nastiness-5b8e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 505b02957e74f0c5c4655647ccb04bdc945d18f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101512-outrank-nastiness-5b8e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

505b02957e74 ("riscv: Remove duplicate objcopy flag")
26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
559d1e45a16d ("riscv: Use --emit-relocs in order to move .rela.dyn in init")
c2dea0bc5339 ("riscv: Check relocations at compile time")
39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
69a90d2fe107 ("riscv: Move .rela.dyn outside of init to avoid empty relocations")
f3af3b0039fe ("Merge patch series "riscv: improve link and support ARCH_WANT_LD_ORPHAN_WARN"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 505b02957e74f0c5c4655647ccb04bdc945d18f6 Mon Sep 17 00:00:00 2001
From: Song Shuai <songshuaishuai@tinylab.org>
Date: Thu, 14 Sep 2023 17:13:34 +0800
Subject: [PATCH] riscv: Remove duplicate objcopy flag

There are two duplicate `-O binary` flags when objcopying from vmlinux
to Image/xipImage.

RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
in Kbuild would join them together.

The `-O binary` flag is only needed for objcopying Image, so remove the
OBJCOPYFLAGS in the top-level riscv Makefile.

Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230914091334.1458542-1-songshuaishuai@tinylab.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 1329e060c548..b43a6bb7e4dc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -6,7 +6,6 @@
 # for more details.
 #
 
-OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_RELOCATABLE),y)
 	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs

