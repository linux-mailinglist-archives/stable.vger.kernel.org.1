Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9597A300B
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbjIPM1A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjIPM0a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE69CEF
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B48C433C7;
        Sat, 16 Sep 2023 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867185;
        bh=Edv9kD6rqqfJtgOU0cBT2JQJsk7d4ZMkJHkvHK4uaqk=;
        h=Subject:To:Cc:From:Date:From;
        b=skh3DGGfR9+qJa6RwlbBa8gkyATPxQHiatj4tUuN3+JZhcTtX/coKa8ZMbIm6bemc
         abOCyqzINQOgzkFAxXLTfu2tPmJY00vAIc/b/E/qlE6tPkt8qZOc4RAgGXPmEFjufH
         NbjDh920LfGufeSvG9OQz/U2cFNCZ2TzToQzbdfA=
Subject: FAILED: patch "[PATCH] MIPS: Only fiddle with CHECKFLAGS if `need-compiler'" failed to apply to 5.15-stable tree
To:     macro@orcam.me.uk, bot@kernelci.org,
        guillaume.tucker@collabora.com, tsbogend@alpha.franken.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:26:15 +0200
Message-ID: <2023091615-punctured-obnoxious-ab62@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4fe4a6374c4db9ae2b849b61e84b58685dca565a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091615-punctured-obnoxious-ab62@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4fe4a6374c4d ("MIPS: Only fiddle with CHECKFLAGS if `need-compiler'")
08f6554ff90e ("mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation")
d42f0c6ad502 ("MIPS: Use "grep -E" instead of "egrep"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fe4a6374c4db9ae2b849b61e84b58685dca565a Mon Sep 17 00:00:00 2001
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Tue, 18 Jul 2023 15:37:23 +0100
Subject: [PATCH] MIPS: Only fiddle with CHECKFLAGS if `need-compiler'

We have originally guarded fiddling with CHECKFLAGS in our arch Makefile
by checking for the CONFIG_MIPS variable, not set for targets such as
`distclean', etc. that neither include `.config' nor use the compiler.

Starting from commit 805b2e1d427a ("kbuild: include Makefile.compiler
only when compiler is needed") we have had a generic `need-compiler'
variable explicitly telling us if the compiler will be used and thus its
capabilities need to be checked and expressed in the form of compilation
flags.  If this variable is not set, then `make' functions such as
`cc-option' are undefined, causing all kinds of weirdness to happen if
we expect specific results to be returned, most recently:

cc1: error: '-mloongson-mmi' must be used with '-mhard-float'

messages with configurations such as `fuloong2e_defconfig' and the
`modules_install' target, which does include `.config' and yet does not
use the compiler.

Replace the check for CONFIG_MIPS with one for `need-compiler' instead,
so as to prevent the compiler from being ever called for CHECKFLAGS when
not needed.

Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Closes: https://lore.kernel.org/r/85031c0c-d981-031e-8a50-bc4fad2ddcd8@collabora.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 805b2e1d427a ("kbuild: include Makefile.compiler only when compiler is needed")
Cc: stable@vger.kernel.org # v5.13+
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 69c18074d817..d624b87c150d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -341,7 +341,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
-ifdef CONFIG_MIPS
+ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')

