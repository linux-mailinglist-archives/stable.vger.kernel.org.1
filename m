Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041072C038
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjFLKun (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjFLKuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085383CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93862614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799BC433D2;
        Mon, 12 Jun 2023 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566083;
        bh=RPXAC4Lelcc4Sea6c6i2iBwEgOdEE2D29P4NRByblag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPsSEeDsvVomtrQv08y+7faI4t5sRXpzZNxexxKKfFCU3Btrhj0DR2OANsja1vHQ1
         LiiKv+y4GUcPcaNIpLBocOhrrwzbrwncv+jb4+JD31099XICdWQNV9BmviZZsaDU9g
         NVMpZ5X7r831I5DWlU4O8sQFlQrocYIgAja+X9Ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 58/68] riscv: fix kprobe __user string arg print fault issue
Date:   Mon, 12 Jun 2023 12:26:50 +0200
Message-ID: <20230612101700.851442257@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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
index c192bd7305dc6..b28fabfc91bf7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -22,6 +22,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
-- 
2.39.2



