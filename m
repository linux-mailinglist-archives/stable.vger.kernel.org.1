Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F432755418
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjGPU0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGPU0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A4E4F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C962760EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93CFC433C8;
        Sun, 16 Jul 2023 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539190;
        bh=8R0PrA9qErlW8QwzAjAUWE0x8v9ZipQ2Rjmzxjgu8Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmXRUg3+rzu3YhmIVkxMwWVO5FJsA81YOTJwDeWVxIxH/gtA3t3mOxPNmgqxeMhtZ
         v0jPwX2G1RnY4XagPQPBegzSOhq8IL9qcA/SyxsaWaLaD/rQaBTxrJ0FeIlxBNVYj1
         WPz3SdYdFEEmYuGy9HBXQv1j9obZy5DBYMvUqNbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 718/800] arm64/signal: Restore TPIDR2 register rather than memory state
Date:   Sun, 16 Jul 2023 21:49:31 +0200
Message-ID: <20230716195005.795837369@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 616cb2f4b141852cac3dfffe8354c8bf19e9999d upstream.

Currently when restoring the TPIDR2 signal context we set the new value
from the signal frame in the thread data structure but not the register,
following the pattern for the rest of the data we are restoring. This does
not work in the case of TPIDR2, the register always has the value for the
current task. This means that either we return to userspace and ignore the
new value or we context switch and save the register value on top of the
newly restored value.

Load the value from the signal context into the register instead.

Fixes: 39e54499280f ("arm64/signal: Include TPIDR2 in the signal context")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 6.3.x
Link: https://lore.kernel.org/r/20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -398,7 +398,7 @@ static int restore_tpidr2_context(struct
 
 	__get_user_error(tpidr2_el0, &user->tpidr2->tpidr2, err);
 	if (!err)
-		current->thread.tpidr2_el0 = tpidr2_el0;
+		write_sysreg_s(tpidr2_el0, SYS_TPIDR2_EL0);
 
 	return err;
 }


