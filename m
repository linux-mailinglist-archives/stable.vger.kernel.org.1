Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D0755457
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGPU3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGPU3W (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42579F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 399D460EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4549AC433C8;
        Sun, 16 Jul 2023 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539360;
        bh=UTLRIIIlxCl0192Lt7NHXqh+QM9MOdK93SORPVv2VJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLlJdIybJ5RspflMKHYfVuu1qz2P6fuHNQeiHwO4mbGuoiWgbno6Duk6SPs7lAikU
         bmGglgdRJWVKQOTzRn8NsMGdsnR8LklNh9JmSFtRMIzsQer4G12e3KmvB+fXYnofR7
         icuRTscwSYpvkFXvbjERW009jzGXu4AWcaOpnBBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.4 780/800] kbuild: Add CLANG_FLAGS to as-instr
Date:   Sun, 16 Jul 2023 21:50:33 +0200
Message-ID: <20230716195007.265216068@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Nathan Chancellor <nathan@kernel.org>

commit cff6e7f50bd315e5b39c4e46c704ac587ceb965f upstream.

A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
When that occurs, the following errors appear multiple times when
building ARCH=powerpc powernv_defconfig:

  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717520 is not in [-2147483648, 2147483647]; references '__start___soft_mask_table'
  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717392 is not in [-2147483648, 2147483647]; references '__stop___soft_mask_table'

Diffing the .o.cmd files reveals that -DHAVE_AS_ATHIGH=1 is not present
anymore, because as-instr only uses KBUILD_AFLAGS, which will no longer
contain '--target'.

Mirror Kconfig's as-instr and add CLANG_FLAGS explicitly to the
invocation to ensure the target information is always present.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.compiler |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -38,7 +38,7 @@ as-option = $(call try-run,\
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)


