Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF42754DFC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGPJLe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGPJLd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:11:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773DDF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A97160959
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A27DC433C7;
        Sun, 16 Jul 2023 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498690;
        bh=cEcAG4OpUL1Y1fF9doz8hCEDFql0UclkGuQOPMxskdE=;
        h=Subject:To:Cc:From:Date:From;
        b=UXmAqJDwXZf3N60+pq/QkzOcD0MfcWlw5bp2KX+PtwNHDWCGR1HYfdDW3peiCHoqP
         +cWqy3LlaGRVJpG1o7T7oUDrAV0/CL1k8L5DFMesKaurdiNdeovbmpRbPZW+miPVI4
         li5RJ62ElDmjKAQz6kGMkFkuMGjM4R1QdjZ+PVko=
Subject: FAILED: patch "[PATCH] um: Use HOST_DIR for mrproper" failed to apply to 4.19-stable tree
To:     keescook@chromium.org, anton.ivanov@cambridgegreys.com,
        azeemshaikh38@gmail.com, johannes@sipsolutions.net, richard@nod.at
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:11:23 +0200
Message-ID: <2023071622-improving-scrambler-114b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x a5a319ec2c2236bb96d147c16196d2f1f3799301
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071622-improving-scrambler-114b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

a5a319ec2c22 ("um: Use HOST_DIR for mrproper")
0663c68c4d2d ("kbuild: remove {CLEAN,MRPROPER,DISTCLEAN}_DIRS")
610134b750bb ("kbuild: remove misleading stale FIXME comment")
63ec90f18204 ("um: ensure `make ARCH=um mrproper` removes arch/$(SUBARCH)/include/generated/")
8b41fc4454e3 ("kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf")
b1fbfcb4a209 ("kbuild: make single target builds even faster")
bbc55bded4aa ("modpost: dump missing namespaces into a single modules.nsdeps file")
0241ea8cae19 ("modpost: free ns_deps_buf.p after writing ns_deps files")
bff9c62b5d20 ("modpost: do not invoke extra modpost for nsdeps")
35e046a203ee ("kbuild: remove unneeded variable, single-all")
39808e451fdf ("kbuild: do not read $(KBUILD_EXTMOD)/Module.symvers")
1747269ab016 ("modpost: do not parse vmlinux for external module builds")
fab546e6cd7a ("kbuild: update comments in scripts/Makefile.modpost")
57baec7b1b04 ("scripts/nsdeps: make sure to pass all module source files to spatch")
09684950050b ("scripts/nsdeps: use alternative sed delimiter")
e0703556644a ("Merge tag 'modules-for-v5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5a319ec2c2236bb96d147c16196d2f1f3799301 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Jun 2023 15:24:45 -0700
Subject: [PATCH] um: Use HOST_DIR for mrproper

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230606222442.never.807-kees@kernel.org

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 8186d4761bda..da4d5256af2f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -149,7 +149,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \

