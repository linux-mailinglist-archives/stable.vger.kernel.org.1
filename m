Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D86703638
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbjEORHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbjEORHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972827EED
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C4C62ACB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D180C4339B;
        Mon, 15 May 2023 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170362;
        bh=iSpMd1f7K/mMGCnGHlQWy4pEIOkqZMPjzap7Y9xNKSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbgqAuHdZynA2SzDEJt4cPlJbxAfTCv7pKUTxDL7Yfa6d8wpNgjVMxYNQ9LIAgMIQ
         Od2F5zhDWpoajk6NS8CCjPMbOa9k0ZqAj2UERrPwh7VF6nLWI4gJqCdd1dR4ZyfpYM
         GyxNU/WpNI+EUxyB9NpG+s+quzDR1JDjPN1luRD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Hofstaedtler <zeha@debian.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 107/239] RISC-V: fix taking the text_mutex twice during sifive errata patching
Date:   Mon, 15 May 2023 18:26:10 +0200
Message-Id: <20230515161724.910647840@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

commit bf89b7ee52af5a5944fa3539e86089f72475055b upstream.

Chris pointed out that some bonehead, *cough* me *cough*, added two
mutex_locks() to the SiFive errata patching. The second was meant to
have been a mutex_unlock().

This results in errors such as

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
Oops [#1]
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted
6.2.0-rc1-starlight-00079-g9493e6f3ce02 #229
Hardware name: BeagleV Starlight Beta (DT)
epc : __schedule+0x42/0x500
 ra : schedule+0x46/0xce
epc : ffffffff8065957c ra : ffffffff80659a80 sp : ffffffff81203c80
 gp : ffffffff812d50a0 tp : ffffffff8120db40 t0 : ffffffff81203d68
 t1 : 0000000000000001 t2 : 4c45203a76637369 s0 : ffffffff81203cf0
 s1 : ffffffff8120db40 a0 : 0000000000000000 a1 : ffffffff81213958
 a2 : ffffffff81213958 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : ffffffff80a1bd00 a6 : 0000000000000000 a7 : 0000000052464e43
 s2 : ffffffff8120db41 s3 : ffffffff80a1ad00 s4 : 0000000000000000
 s5 : 0000000000000002 s6 : ffffffff81213938 s7 : 0000000000000000
 s8 : 0000000000000000 s9 : 0000000000000001 s10: ffffffff812d7204
 s11: ffffffff80d3c920 t3 : 0000000000000001 t4 : ffffffff812e6dd7
 t5 : ffffffff812e6dd8 t6 : ffffffff81203bb8
status: 0000000200000100 badaddr: 0000000000000030 cause: 000000000000000d
[<ffffffff80659a80>] schedule+0x46/0xce
[<ffffffff80659dce>] schedule_preempt_disabled+0x16/0x28
[<ffffffff8065ae0c>] __mutex_lock.constprop.0+0x3fe/0x652
[<ffffffff8065b138>] __mutex_lock_slowpath+0xe/0x16
[<ffffffff8065b182>] mutex_lock+0x42/0x4c
[<ffffffff8000ad94>] sifive_errata_patch_func+0xf6/0x18c
[<ffffffff80002b92>] _apply_alternatives+0x74/0x76
[<ffffffff80802ee8>] apply_boot_alternatives+0x3c/0xfa
[<ffffffff80803cb0>] setup_arch+0x60c/0x640
[<ffffffff80800926>] start_kernel+0x8e/0x99c
---[ end trace 0000000000000000 ]---

Reported-by: Chris Hofstaedtler <zeha@debian.org>
Fixes: 9493e6f3ce02 ("RISC-V: take text_mutex during alternative patching")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230302174154.970746-1-conor@kernel.org
[Palmer: pick up Geert's bug report from the thread]
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/errata/sifive/errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 5b77d7310e391..c24a349dd026d 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -110,7 +110,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
 		if (cpu_req_errata & tmp) {
 			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
-			mutex_lock(&text_mutex);
+			mutex_unlock(&text_mutex);
 			cpu_apply_errata |= tmp;
 		}
 	}
-- 
2.39.2



