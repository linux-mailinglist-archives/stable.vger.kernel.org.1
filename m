Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6A75540D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGPU0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGPU0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50196BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE7C660EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1105C433C8;
        Sun, 16 Jul 2023 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539159;
        bh=IXAQm7r1PimoJCWHcEqlJ2R4NqjE05PYXp3/QDvrqJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPZfMROxIqyKRmUUjPZ/onyLIStlZUbSqcY7Nl61aQ3SFHB17tv3meurlGmm7Lhjw
         7Yg3zMtuh6hdgXM/QJIHHY2JI2jK00LlyeHTujhGJp5JNFVCIzSioDXjdhYh39VYQV
         jycLpgquAVZV35Mke3R6/OCSGwZS23rt8N/0+zK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 708/800] risc-v: Fix order of IPI enablement vs RCU startup
Date:   Sun, 16 Jul 2023 21:49:21 +0200
Message-ID: <20230716195005.565481736@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 6259f3443c6a376aa077816ac92e9ddeb0817d09 ]

Conor reports that risc-v tries to enable IPIs before telling the
core code to enable RCU. With the introduction of the mapple tree
as a backing store for the irq descriptors, this results in
a very shouty boot sequence, as RCU is legitimately upset.

Restore some sanity by moving the risc_ipi_enable() call after
notify_cpu_starting(), which explicitly enables RCU on the calling
CPU.

Fixes: 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")
Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230703-dupe-frying-79ae2ccf94eb@spud
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230703183126.1567625-1-maz@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 445a4efee267d..6765f1ce79625 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -161,10 +161,11 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
-	riscv_ipi_enable();
-
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
+
+	riscv_ipi_enable();
+
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 	probe_vendor_features(curr_cpuid);
-- 
2.39.2



