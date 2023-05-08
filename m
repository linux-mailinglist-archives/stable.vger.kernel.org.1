Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB66FA963
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjEHKuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjEHKtz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E062D783
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF47862917
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CDBC4339B;
        Mon,  8 May 2023 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542979;
        bh=X1dtmDWEm4Nd5V1IEVsVN+iACf3EdFZTQkSMs30r5yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpcr6FcoAI/r0lQFgPmYOwLlxLj5nbgqJyP37/lE40o/md+cVzxmSM+GJVvokrC5J
         Jw5NKNSXgLFYZIxi4lvL4lDjX+IvtjwKjAWJFPriAMlurdrOVpHytSpeEjblCPF5VP
         78laE5rqc1VywSoV9vWGLQd/XXi/nrH0JSVnB4eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.2 611/663] parisc: Fix argument pointer in real64_call_asm()
Date:   Mon,  8 May 2023 11:47:17 +0200
Message-Id: <20230508094449.502997078@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit 6e3220ba3323a2c24be834aebf5d6e9f89d0993f upstream.

Fix the argument pointer (ap) to point to real-mode memory
instead of virtual memory.

It's interesting that this issue hasn't shown up earlier, as this could
have happened with any 64-bit PDC ROM code.

I just noticed it because I suddenly faced a HPMC while trying to execute
the 64-bit STI ROM code of an Visualize-FXe graphics card for the STI
text console.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/real2.S |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/parisc/kernel/real2.S
+++ b/arch/parisc/kernel/real2.S
@@ -235,9 +235,6 @@ ENTRY_CFI(real64_call_asm)
 	/* save fn */
 	copy	%arg2, %r31
 
-	/* set up the new ap */
-	ldo	64(%arg1), %r29
-
 	/* load up the arg registers from the saved arg area */
 	/* 32-bit calling convention passes first 4 args in registers */
 	ldd	0*REG_SZ(%arg1), %arg0		/* note overwriting arg0 */
@@ -249,7 +246,9 @@ ENTRY_CFI(real64_call_asm)
 	ldd	7*REG_SZ(%arg1), %r19
 	ldd	1*REG_SZ(%arg1), %arg1		/* do this one last! */
 
+	/* set up real-mode stack and real-mode ap */
 	tophys_r1 %sp
+	ldo	-16(%sp), %r29			/* Reference param save area */
 
 	b,l	rfi_virt2real,%r2
 	nop


