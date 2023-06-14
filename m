Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D67301D4
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjFNO1U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbjFNO1T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:27:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C81BEC
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:27:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 134895C0086;
        Wed, 14 Jun 2023 10:27:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Jun 2023 10:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686752838; x=1686839238; bh=r5XH7DCC+q
        aBgPy3Zwv6APzKkMHw3vYJ1U2D1SHtu1Q=; b=fkdm+rQ+pARDv5xPvHnVX667IV
        Mjm8O9vDNBs0j5b2gF6OXC8jYYoBUHG4PT4Pwdfzx8SlbpILwI1YzM+E64kmxTAz
        twZrsZkZ+0jAWYq/8yW0lmEHICh44TFLU12qRFYlXMOIwjY3pJSxoJnhuB5TfIKr
        Qb/mUqIhQEmw0cdA0l11UX05nzKPgzC5fhEd3a+1FwztOVk5y9zE5ZID/09gyfm8
        GdUOk9MzIuoOE4XHeKUpDpMjIXHFnHmB3jHYY8mw2OTQU+OtkHdOb7hrwxF7sJEI
        UrH/asU+ypg9rNhiQo/nY7WV5tvTM79tp2G6NAdtpCPT4eSCOX4JlrtVHkuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686752838; x=1686839238; bh=r5XH7DCC+qaBg
        Py3Zwv6APzKkMHw3vYJ1U2D1SHtu1Q=; b=AlZ4eeYaT5OAcHZ8JbG05jAnhGnh2
        oPbEk3lpQo5W4x3oyDG9Oa9+JoMM4tZlbscRiRnqi8LEk5Mm1j6W7szO2yktCpry
        lGhmoFHDFr3LHEr/TgCm2IfHQJ4y6Vs5ZhMXMu+cECsaszFZm4mxdtv1ZwPEJ7M8
        flrK+XReYRkyaDutwMv/QO9O7KlaXTTQt28wfYh92i0sTz4hj+rlHI1IZDd9yxos
        VR62QTf/Y7auNVcDDOkTa7lEwDqn3g48Nv0QmgExKEGk62k5jE7jOmjpUEdC9tnT
        MVNiVTGk0hBlAoCptTROCtm3+JjDNE4XZvV7TZLe0Muo/uU66tgWC+iew==
X-ME-Sender: <xms:Rc6JZDUyU5iZ8GmvYNlVg3OwpaqViqXa0pCvla3KxQXHJkv4c7i7WQ>
    <xme:Rc6JZLkaWiHNdtz1u0L1PR1vD6PRgnERDmEPR82_BRqd4KSDDrOpaHf6mzlmtgQJg
    rA53WoseSHqOWdYhg>
X-ME-Received: <xmr:Rc6JZPbuSy995tcUzNKCzlco97p0ISUSvGhNG-ezRuVYsClpgvfhMH06gyI5jSmVdaPIv4V6qULIOOFzU8EXIHLMWRiCRHia_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucggtffrrghtthgvrhhnpeehkefgtdevtedtkeduudeguefgudejheeugfelgeettd
    fhffduhfehudfhudeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:Rc6JZOUusT-POVYrW06QJvbep22xZQx6JuYl8Fb0pyCdz9HD2cOrHg>
    <xmx:Rc6JZNl58ltkG361Zl4H3KlU14inf0DeyRz4P7qf3cr8qbGQkTMGdw>
    <xmx:Rc6JZLdzqQK6J503V0TZ1ZQZLyN-IZ31maUPqCrdGVQj1r2S8hirKg>
    <xmx:Rs6JZMu0D77N0-1K4AbzjeNpvMzMAjEaQorFU0_3tEYAtspShge3sg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 10:27:17 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 16EE86430; Wed, 14 Jun 2023 14:27:16 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH 4.19.y] powerpc: Fix defconfig choice logic when cross compiling
Date:   Wed, 14 Jun 2023 14:26:23 +0000
Message-Id: <20230614142622.1364815-1-hi@alyssa.is>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

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
(cherry picked from commit af5cd05de5dd38cf25d14ea4d30ae9b791d2420b)
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 arch/powerpc/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9b33cd4e0e17..b2e0fd873562 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,11 +30,10 @@ endif
 endif
 endif
 
-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-else
-KBUILD_DEFCONFIG := ppc64_defconfig
-endif
+# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
+# ppc64_defconfig because we have nothing better to go on.
+uname := $(shell uname -m)
+KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
 
 ifdef CONFIG_PPC64
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)

base-commit: 7625843c7c86dd2d5d4bcbbc06da8cba49d09a5b
-- 
2.37.1

