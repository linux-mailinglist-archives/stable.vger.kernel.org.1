Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5415E7832BF
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHUUI3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHUUI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B846E4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93EB864A16
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6C7C433C7;
        Mon, 21 Aug 2023 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648506;
        bh=7GGK7IRq82SBo4ZQw2yxJoW78BVywWtAdDasAcc2YFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlJpKd7RXoebNCeszmdx15GXTp1dRV63vAvgZwcKmqpxsZP/5kHtB4oAfcUplizXY
         0NE2dSFykstk8lXdCZrfdvXb5uq2l0jmRg4w3e0g1pFoCEl1MQtg/7kbtbAx7MANtF
         qIMHxQhwoWfSqV40QrYfV6flZl3mc1VUT9Ceu0IQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bo YU <tsu.yubo@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 200/234] riscv: uaccess: Return the number of bytes effectively not copied
Date:   Mon, 21 Aug 2023 21:42:43 +0200
Message-ID: <20230821194137.686181692@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 4b05b993900dd3eba0fc83ef5c5ddc7d65d786c6 ]

It was reported that the riscv kernel hangs while executing the test
in [1].

Indeed, the test hangs when trying to write a buffer to a file. The
problem is that the riscv implementation of raw_copy_from_user() does not
return the correct number of bytes not written when an exception happens
and is fixed up, instead it always returns the initial size to copy,
even if some bytes were actually copied.

generic_perform_write() pre-faults the user pages and bails out if nothing
can be written, otherwise it will access the userspace buffer: here the
riscv implementation keeps returning it was not able to copy any byte
though the pre-faulting indicates otherwise. So generic_perform_write()
keeps retrying to access the user memory and ends up in an infinite
loop.

Note that before the commit mentioned in [1] that introduced this
regression, it worked because generic_perform_write() would bail out if
only one byte could not be written.

So fix this by returning the number of bytes effectively not written in
__asm_copy_[to|from]_user() and __clear_user(), as it is expected.

Link: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/ [1]
Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
Reported-by: Bo YU <tsu.yubo@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/#t
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Closes: https://lore.kernel.org/linux-riscv/ZNOnCakhwIeue3yr@aurel32.net/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Link: https://lore.kernel.org/r/20230811150604.1621784-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/lib/uaccess.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index ec486e5369d9b..09b47ebacf2e8 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -17,8 +17,11 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
-	/* Save for return value */
-	mv	t5, a2
+	/*
+	 * Save the terminal address which will be used to compute the number
+	 * of bytes copied in case of a fixup exception.
+	 */
+	add	t5, a0, a2
 
 	/*
 	 * Register allocation for code below:
@@ -176,7 +179,7 @@ ENTRY(__asm_copy_from_user)
 10:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, t5
+	sub a0, t5, a0
 	ret
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
@@ -228,7 +231,7 @@ ENTRY(__clear_user)
 11:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, a1
+	sub a0, a3, a0
 	ret
 ENDPROC(__clear_user)
 EXPORT_SYMBOL(__clear_user)
-- 
2.40.1



