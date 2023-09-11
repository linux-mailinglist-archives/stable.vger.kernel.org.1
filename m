Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35179BFCC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377699AbjIKW2M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjIKO2V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB904E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C097C433C8;
        Mon, 11 Sep 2023 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442496;
        bh=/7Xf7XiS22OOIWgkQEI41Hi9ttUwHKlUu5PzKw64xJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlNE/TKam9OuDA/G5o2ZNS8I5ZE7e8i91BNKbaPqLt3g3uBfxRQIl7Gd1C7FtOhNM
         +UqIJbnakUR4REwUGBAjMmbqGc5IpSzqcCzok7fZ6Kq1KlxZCeCVXw2HL+D+dUlBA1
         Jew4x/yUPz6PNjDvaFktSShnm6wc88WQeJolS8PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 045/737] LoongArch: Only fiddle with CHECKFLAGS if `need-compiler
Date:   Mon, 11 Sep 2023 15:38:24 +0200
Message-ID: <20230911134651.703858988@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 54c2c9df083fe1d4a9df54d9876f32582ce6d77a ]

This is a port of commit 4fe4a6374c4db9ae2b ("MIPS: Only fiddle with
CHECKFLAGS if `need-compiler'") to LoongArch.

We have originally guarded fiddling with CHECKFLAGS in our arch Makefile
by checking for the CONFIG_LOONGARCH variable, not set for targets such
as `distclean', etc. that neither include `.config' nor use the compiler.

Starting from commit 805b2e1d427aab4 ("kbuild: include Makefile.compiler
only when compiler is needed") we have had a generic `need-compiler'
variable explicitly telling us if the compiler will be used and thus its
capabilities need to be checked and expressed in the form of compilation
flags.  If this variable is not set, then `make' functions such as
`cc-option' are undefined, causing all kinds of weirdness to happen if
we expect specific results to be returned.

It doesn't cause problems on LoongArch now. But as a guard we replace
the check for CONFIG_LOONGARCH with one for `need-compiler' instead, so
as to prevent the compiler from being ever called for CHECKFLAGS when
not needed.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 63a637fdf6c28..95629322241f5 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -106,7 +106,7 @@ KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
 
 KBUILD_LDFLAGS	+= -m $(ld-emul)
 
-ifdef CONFIG_LOONGARCH
+ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
-- 
2.40.1



