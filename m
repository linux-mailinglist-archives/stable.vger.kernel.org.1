Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFB77AB6C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHMVVs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHMVVs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0710D0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0DE627C7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A71C433C8;
        Sun, 13 Aug 2023 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961709;
        bh=+Jmxty0KlW7/uvSP6JHa4TnP+hiUxGVi+uMll3ZTEOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VymHrVj6ktbEmPrlfq9b6Ux+zGS65+aP5VU4u4/+E25R1i5M0ALgXZu2vONYeewtP
         qmeNqfAuQRC0N+QZWusIk4ZRhTPJw4rR0uHlPtRlehM0oj7oOSTbQ6+tehqaMBVxTh
         0RMOIrevds2bcQcPPQ8oBMkyR6yMX0UHWg1IcJmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 01/26] sparc: fix up arch_cpu_finalize_init() build breakage.
Date:   Sun, 13 Aug 2023 23:18:54 +0200
Message-ID: <20230813211703.032783700@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In commit 39f0e159b8e8 ("sparc/cpu: Switch to arch_cpu_finalize_init()") the
check for ARCH_HAS_CPU_FINALIZE_INIT was backported incorrectly to the SPARC
config option, not SPARC32.  This causes build problems for the sparc64 arch:

	sparc64-linux-ld: init/main.o: in function `start_kernel':
	main.c:(.init.text+0x77c): undefined reference to `arch_cpu_finalize_init'

Fix this up by putting the option in the correct place.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/252c7673-53ee-4c4b-e5ef-5bb2c0416154@roeck-us.net
Fixes: 39f0e159b8e8 ("sparc/cpu: Switch to arch_cpu_finalize_init()")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,7 +12,6 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
@@ -48,6 +47,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16


