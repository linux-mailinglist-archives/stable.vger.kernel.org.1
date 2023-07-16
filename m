Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6617755362
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGPUS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGPUS0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892C90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A271160EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FFBC433C8;
        Sun, 16 Jul 2023 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538705;
        bh=RfDKITa1nnaMTcN1oWHI+85uzkvt0OTMZkTTBKyetrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0sXwrhBmNATNKDFV4wvHi/wwjxb4xK2r1Kp8fbB0/AR5yy8xIhZLZP9HGIh404St
         YjQMfz0yyKHkFqs1yNiAR0IgxQYgl/5T3bqc9GF5pYFnNBAMZN7rXTJfVrPhLzjPGx
         rnMVfjv4g+n0UPPcLfyfufjVcvt/wTQvK9BHmVuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Nikl=C4=81vs=20Ko=C4=BCes=C5=86ikovs?= 
        <pinkflames.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 547/800] x86/efi: Make efi_set_virtual_address_map IBT safe
Date:   Sun, 16 Jul 2023 21:46:40 +0200
Message-ID: <20230716195001.797319057@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 0303c9729afc4094ef53e552b7b8cff7436028d6 ]

Niklāvs reported a boot regression on an Alderlake machine and bisected it
to commit 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier").

By moving the invocation of arch_cpu_finalize_init() further down he
identified that efi_enter_virtual_mode() is the function which causes the
boot hang.

The main difference of the earlier invocation is that the boot CPU is
already fully initialized and mitigations and alternatives are applied.

But the only really interesting change turned out to be IBT, which is now
enabled before efi_enter_virtual_mode(). "ibt=off" on the kernel command
line cured the problem.

Inspection of the involved calls in efi_enter_virtual_mode() unearthed that
efi_set_virtual_address_map() is the only place in the kernel which invokes
an EFI call without the IBT safe wrapper. This went obviously unnoticed so
far as IBT was enabled later.

Use arch_efi_call_virt() instead of efi_call() to cure that.

Fixes: fe379fa4d199 ("x86/ibt: Disable IBT around firmware")
Fixes: 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier")
Reported-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217602
Link: https://lore.kernel.org/r/87jzvm12q0.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 232acf418cfbe..77f7ac3668cb4 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -853,9 +853,9 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call(efi.runtime->set_virtual_address_map,
-			  memory_map_size, descriptor_size,
-			  descriptor_version, virtual_map);
+	status = arch_efi_call_virt(efi.runtime, set_virtual_address_map,
+				    memory_map_size, descriptor_size,
+				    descriptor_version, virtual_map);
 	local_irq_restore(flags);
 
 	efi_fpu_end();
-- 
2.39.2



