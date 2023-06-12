Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4819B72C13C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjFLK5i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjFLK5Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26F6A61
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1834F615B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FACC433EF;
        Mon, 12 Jun 2023 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566708;
        bh=gAVA0X3ZxOMh/8sz7qPRsLRdJGgufkUvZDsAAn6A2YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pZIQzr7RDGYCNMwZaVD8xw2PtIJBSJ7d4+ETXWt8tsLEu/X9HvXnWkDfQZ/y7ZHD
         bJEsReJFjcdmCLiTXb8kjcm9YlPt5ewBWXHHvhqa5qAuh02PIqChoyLP6OmumuN8t+
         yp63+Qfp5B1DEXjve4BtHLRaGrTJcA9Nl+SgyVAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 121/132] riscv: fix kprobe __user string arg print fault issue
Date:   Mon, 12 Jun 2023 12:27:35 +0200
Message-ID: <20230612101715.740190947@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit 99a670b2069c725a7b50318aa681d9cae8f89325 ]

On riscv qemu platform, when add kprobe event on do_sys_open() to show
filename string arg, it just print fault as follow:

echo 'p:myprobe do_sys_open dfd=$arg1 filename=+0($arg2):string flags=$arg3
mode=$arg4' > kprobe_events

bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6

bash-166     [000] ...1.   360.219369: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6

bash-191     [000] ...1.   360.378827: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename=(fault) flags=0x98800 mode=0x0

As riscv do not select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
the +0($arg2) addr is processed as a kernel address though it is a
userspace address, cause the above filename=(fault) print. So select
ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to avoid the issue, after that the
kprobe trace is ok as below:

bash-166     [000] ...1.    96.767641: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6

bash-166     [000] ...1.    96.793751: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/dev/null" flags=0x8241 mode=0x1b6

bash-177     [000] ...1.    96.962354: myprobe: (do_sys_open+0x0/0x84)
dfd=0xffffffffffffff9c filename="/sys/kernel/debug/tracing/events/kprobes/"
flags=0x98800 mode=0x0

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
Link: https://lore.kernel.org/r/20230504072910.3742842-1-ruanjinjie@huawei.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 06b9b2f60b9fb..a85bbe28dcf46 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
-- 
2.39.2



