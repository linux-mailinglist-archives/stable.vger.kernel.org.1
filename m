Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4F7A3A02
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjIQT5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbjIQT5O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D0F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D5AC433C8;
        Sun, 17 Sep 2023 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980628;
        bh=2fCPe91cI1RkpWo5Ot0ZIaJLfi/YvpxZK5NMETJu4LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd8wR9q4BrtKuWrHO82on6PO8jpqPdtcIS90YamFUlkp/N1p009auuMcJm4ePTqLC
         48K7JhXPcd4qsJmoei71w7v+zVLVqdNchjopREwOs3vOtWJ3NyrmQ93ifKqDYxZllS
         5buf0vwb9sYpg6NC6ioXqXlNPht1V8z90W6pIrJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "kernelci.org bot" <bot@kernelci.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.5 230/285] MIPS: Only fiddle with CHECKFLAGS if `need-compiler
Date:   Sun, 17 Sep 2023 21:13:50 +0200
Message-ID: <20230917191059.403998388@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit 4fe4a6374c4db9ae2b849b61e84b58685dca565a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -341,7 +341,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwin
 
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
-ifdef CONFIG_MIPS
+ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')


