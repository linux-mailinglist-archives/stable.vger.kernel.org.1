Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33A777C3A
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjHJPcD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjHJPcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 11:32:02 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4815410F3
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 08:31:59 -0700 (PDT)
Received: from localhost.localdomain (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CF86C3F16F;
        Thu, 10 Aug 2023 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691681517;
        bh=gGqfsd30PlPyCv4HGotmPSOPFFtwKjwFLIUg3yKRzZo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cNKSKsca9XuUX6in31O28UH4t/ZOXNvJqMQ0aAwOImDAuCVdlq4EmZwCodEqtyWBP
         eTXWmQuTa63TGbvyeticMLxgrTcVqdCONSVOjiPZYhFnREQRnnpODLfFOk2yacHRYr
         WbetHjHfRWiDOWOfFw2j4S0C7DPdrMuzZOfQ7ilcvQHNRlcMj8t/dvtbxzEKvPPfUG
         C9Oi6WcYDo4ndfDj7skOAsavC0NsKTImfyw5N3pBvl7eUIUH3pYWx+CoqAaNY5U/gi
         HmhtEl5XBVE2Lu0lTQeHciwAvJG6iuV45j9lSr17hylLIhibp0KHfj9reFtqKmJYlc
         fUQT1kPNJc33Q==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     stable@vger.kernel.org
Cc:     RAJESH DASARI <raajeshdasari@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 5.4,5.10] x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU value to init_fpstate")
Date:   Thu, 10 Aug 2023 12:31:06 -0300
Message-Id: <20230810153106.172292-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
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

From: Thomas Gleixner <tglx@linutronix.de>

Commit b3607269ff57fd3c9690cb25962c5e4b91a0fd3b upstream.

This cannot work and it's unclear how that ever made a difference.

init_fpstate.xsave.header.xfeatures is always 0 so get_xsave_addr() will
always return a NULL pointer, which will prevent storing the default PKRU
value in init_fpstate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121451.451391598@linutronix.de
Reported-by: RAJESH DASARI <raajeshdasari@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---

This has been reported to cause a WARNing since the backport of b81fac906a8f
("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()").

a5eff7259790 was part of 5.2 and no older LTS kernels carry it, so not
necessary on 4.19 or 4.14.

---
 arch/x86/kernel/cpu/common.c | 5 -----
 arch/x86/mm/pkeys.c          | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fcfe891c1e8e..0c0c2cb038ad 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -450,8 +450,6 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	struct pkru_state *pk;
-
 	/* check the boot processor, plus compile options for PKU: */
 	if (!cpu_feature_enabled(X86_FEATURE_PKU))
 		return;
@@ -462,9 +460,6 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 		return;
 
 	cr4_set_bits(X86_CR4_PKE);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (pk)
-		pk->pkru = init_pkru_value;
 	/*
 	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index c6f84c0b5d7a..ca77af96033b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,7 +10,6 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
-#include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -154,7 +153,6 @@ static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -177,10 +175,6 @@ static ssize_t init_pkru_write_file(struct file *file,
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (!pk)
-		return -EINVAL;
-	pk->pkru = new_init_pkru;
 	return count;
 }
 
-- 
2.34.1

