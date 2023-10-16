Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43B7CAC41
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjJPOwD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOwC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911EB9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF048C433C9;
        Mon, 16 Oct 2023 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467920;
        bh=9z7wpK3dsblAi5FDC1AxiMBy06yFNjb8FT9ZRNkhO0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGMJnZicyKbR607IDfOyd/9x7aHG/LQGqagn65Cb5c5fRDWMFgGc1X29gOG7I+dbY
         PTsWRdAVrow2ycpdVEmNzVbUxAe5emgnTB0K5NcUlknUx+0NtmSz3B2iSWZh41uy89
         /ksjd97xlwGGtuDb2Pxe9Qvc0y5VuIQXpV0ZkXKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Prashanth Swaminathan <prashanthsw@google.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.5 092/191] riscv: signal: fix sigaltstack frame size checking
Date:   Mon, 16 Oct 2023 10:41:17 +0200
Message-ID: <20231016084017.542847711@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Chiu <andy.chiu@sifive.com>

commit 14a270bfab7ab1c4b605c01eeca5557447ad5a2b upstream.

The alternative stack checking in get_sigframe introduced by the Vector
support is not needed and has a problem. It is not needed as we have
already validate it at the beginning of the function if we are already
on an altstack. If not, the size of an altstack is always validated at
its allocation stage with sigaltstack_size_valid().

Besides, we must only regard the size of an altstack if the handler of a
signal is registered with SA_ONSTACK. So, blindly checking overflow of
an altstack if sas_ss_size not equals to zero will check against wrong
signal handlers if only a subset of signals are registered with
SA_ONSTACK.

Fixes: 8ee0b41898fa ("riscv: signal: Add sigcontext save/restore for vector")
Reported-by: Prashanth Swaminathan <prashanthsw@google.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Link: https://lore.kernel.org/r/20230822164904.21660-1-andy.chiu@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/signal.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -311,13 +311,6 @@ static inline void __user *get_sigframe(
 	/* Align the stack frame. */
 	sp &= ~0xfUL;
 
-	/*
-	 * Fail if the size of the altstack is not large enough for the
-	 * sigframe construction.
-	 */
-	if (current->sas_ss_size && sp < current->sas_ss_sp)
-		return (void __user __force *)-1UL;
-
 	return (void __user *)sp;
 }
 


