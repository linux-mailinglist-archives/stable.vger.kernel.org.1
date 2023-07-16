Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E0755321
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGPUPn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGPUPm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7051B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0617C60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17308C433C8;
        Sun, 16 Jul 2023 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538540;
        bh=3oFi179g+ZxZVreJ5Aqi4NgEacGvnSOGcqeM/j0xf0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgErQDphMkdqFyEiufosLeP0FZ2H1x8bu7haElonZHMfWE8ChcVRiLbHbFxOH6sbc
         PiwNsw5yDpZu8uzuXzHEvzn+vaYtil7A8HgJhTUZtuNqSS8Kyxg29tgtIJ7+NWf61Q
         qCysNwJCRDFbvzcnr0EV5I6PQMr4OU+2PTj460Ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 486/800] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
Date:   Sun, 16 Jul 2023 21:45:39 +0200
Message-ID: <20230716195000.368880265@linuxfoundation.org>
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

From: Song Shuai <songshuaishuai@tinylab.org>

[ Upstream commit c6399b893043a5bb634de8677362f96684f1c0c8 ]

The suspend_restore_csrs is called in both __hibernate_cpu_resume
and the `else` of subsequent swsusp_arch_suspend.

Removing the first call makes both suspend_{save,restore}_csrs
left in swsusp_arch_suspend for clean code.

Fixes: c0317210012e ("RISC-V: Add arch functions to support hibernation/suspend-to-disk")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
Link: https://lore.kernel.org/r/20230522025020.285042-1-songshuaishuai@tinylab.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/hibernate-asm.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
index effaf5ca5da0e..f3e62e766cb29 100644
--- a/arch/riscv/kernel/hibernate-asm.S
+++ b/arch/riscv/kernel/hibernate-asm.S
@@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
 
 	REG_L	a0, hibernate_cpu_context
 
-	suspend_restore_csrs
 	suspend_restore_regs
 
 	/* Return zero value. */
-- 
2.39.2



