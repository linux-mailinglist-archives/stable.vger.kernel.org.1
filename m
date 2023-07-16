Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952F7555E3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjGPUpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjGPUpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24443E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE0F960EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC64DC433C8;
        Sun, 16 Jul 2023 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540333;
        bh=6aA1n+PwuxV39DByCKJBPk8LXhWjNlUOrF11QTq1ccc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkPrHZqRXU5NRyTPUzYkqxYMJCghau6wDrc37xRHc1Dp0LGVvNaPeVtrY0oReKa7p
         fiHNcPaXdC6fqEy74y0R4WQwuXIu27VlGICaeIlDIht1rCYXBPdoYB5SJfSAsaymJ1
         0sf3T/Xe9YuPjN7JfqAYkEnPDXTUcauWCvopPItk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 326/591] riscv: uprobes: Restore thread.bad_cause
Date:   Sun, 16 Jul 2023 21:47:45 +0200
Message-ID: <20230716194932.324637680@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 58b1294dd1d65bb62f08dddbf418f954210c2057 ]

thread.bad_cause is saved in arch_uprobe_pre_xol(), it should be restored
in arch_uprobe_{post,abort}_xol() accordingly, otherwise the save operation
is meaningless, this change is similar with x86 and powerpc.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Link: https://lore.kernel.org/r/1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/probes/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index c976a21cd4bd5..194f166b2cc40 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -67,6 +67,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	struct uprobe_task *utask = current->utask;
 
 	WARN_ON_ONCE(current->thread.bad_cause != UPROBE_TRAP_NR);
+	current->thread.bad_cause = utask->autask.saved_cause;
 
 	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
 
@@ -102,6 +103,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
+	current->thread.bad_cause = utask->autask.saved_cause;
 	/*
 	 * Task has received a fatal signal, so reset back to probbed
 	 * address.
-- 
2.39.2



