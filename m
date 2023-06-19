Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FC73521B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjFSKai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjFSKac (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1B0CC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61EBE60B3E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710EAC433C8;
        Mon, 19 Jun 2023 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170630;
        bh=YWgqQoB9YcYxt973V/BSWSpvnzGx4ljnsi+xNH+dHLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyv+6/EMqzqq8OWpFYGkDyfvfKdCVM03Kgif1r6qThLqwq9PN7JI0jXYx/7i7RdY0
         w3b6kFZJNbQGu/Bt6AXwWcNiS895/1SGhma2v7WvjOgwlIgSKRa01yvFeiYVrL/HC4
         yuU9Ldets+4oS3J0XR4gg8/hAa/TR1i2YhLwBZ2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Alyssa Ross <hi@alyssa.is>
Subject: [PATCH 4.14 31/32] powerpc: Fix defconfig choice logic when cross compiling
Date:   Mon, 19 Jun 2023 12:29:19 +0200
Message-ID: <20230619102129.192773653@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
References: <20230619102127.461443957@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit af5cd05de5dd38cf25d14ea4d30ae9b791d2420b upstream.

Our logic for choosing defconfig doesn't work well in some situations.

For example if you're on a ppc64le machine but you specify a non-empty
CROSS_COMPILE, in order to use a non-default toolchain, then defconfig
will give you ppc64_defconfig (big endian):

  $ make CROSS_COMPILE=~/toolchains/gcc-8/bin/powerpc-linux- defconfig
  *** Default configuration is based on 'ppc64_defconfig'

This is because we assume that CROSS_COMPILE being set means we
can't be on a ppc machine and rather than checking we just default to
ppc64_defconfig.

We should just ignore CROSS_COMPILE, instead check the machine with
uname and if it's one of ppc, ppc64 or ppc64le then use that
defconfig. If it's none of those then we fall back to ppc64_defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Makefile |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -29,11 +29,10 @@ endif
 
 export CROSS32CC CROSS32AR
 
-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-else
-KBUILD_DEFCONFIG := ppc64_defconfig
-endif
+# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
+# ppc64_defconfig because we have nothing better to go on.
+uname := $(shell uname -m)
+KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
 
 ifeq ($(CONFIG_PPC64),y)
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)


