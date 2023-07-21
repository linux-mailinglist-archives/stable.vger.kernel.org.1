Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2AA75CDBB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGUQOB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGUQNk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD2423E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F8961D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29B2C433C7;
        Fri, 21 Jul 2023 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955993;
        bh=xWJ9ct+bmzXE89o+uGBBIBQa/JpylKUGUh54vI2hw/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5NbrICLiXR6B8fkpIYm0pHC6buBI2HkCSliqbF+mMbwscfgHXBltrL4Ab1gXbaph
         kejbR76z/Ai9AIQ3SVTi1/dSgrZ4v1G64OojvtBK5Uv4j8PO1Elt8XsUMyWxqQISyT
         jy59QkxG3ICYocxJ8wpJhzw9KqNEO3XOspAgAYEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Szabolcs Nagy <nsz@port70.net>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 079/292] openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI
Date:   Fri, 21 Jul 2023 18:03:08 +0200
Message-ID: <20230721160532.203451900@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit dceaafd668812115037fc13a1893d068b7b880f5 ]

With commit 27267655c531 ("openrisc: Support floating point user api") I
added an entry to the struct sigcontext which caused an unwanted change
to the userspace ABI.

To fix this we use the previously unused oldmask field space for the
floating point fpcsr state.  We do this with a union to restore the ABI
back to the pre kernel v6.4 ABI and keep API compatibility.

This does mean if there is some code somewhere that is setting oldmask
in an OpenRISC specific userspace sighandler it would end up setting the
floating point register status, but I think it's unlikely as oldmask was
never functional before.

Fixes: 27267655c531 ("openrisc: Support floating point user api")
Reported-by: Szabolcs Nagy <nsz@port70.net>
Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
 arch/openrisc/kernel/signal.c               | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
index ca585e4af6b8e..e7ffb58ff58fb 100644
--- a/arch/openrisc/include/uapi/asm/sigcontext.h
+++ b/arch/openrisc/include/uapi/asm/sigcontext.h
@@ -28,8 +28,10 @@
 
 struct sigcontext {
 	struct user_regs_struct regs;  /* needs to be first */
-	struct __or1k_fpu_state fpu;
-	unsigned long oldmask;
+	union {
+		unsigned long fpcsr;
+		unsigned long oldmask;	/* unused */
+	};
 };
 
 #endif /* __ASM_OPENRISC_SIGCONTEXT_H */
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4664a18f0787d..2e7257a433ff4 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -50,7 +50,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
-	err |= __copy_from_user(&regs->fpcsr, &sc->fpu.fpcsr, sizeof(unsigned long));
+	err |= __copy_from_user(&regs->fpcsr, &sc->fpcsr, sizeof(unsigned long));
 
 	/* make sure the SM-bit is cleared so user-mode cannot fool us */
 	regs->sr &= ~SPR_SR_SM;
@@ -113,7 +113,7 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	err |= __copy_to_user(sc->regs.gpr, regs, 32 * sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.pc, &regs->pc, sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.sr, &regs->sr, sizeof(unsigned long));
-	err |= __copy_to_user(&sc->fpu.fpcsr, &regs->fpcsr, sizeof(unsigned long));
+	err |= __copy_to_user(&sc->fpcsr, &regs->fpcsr, sizeof(unsigned long));
 
 	return err;
 }
-- 
2.39.2



