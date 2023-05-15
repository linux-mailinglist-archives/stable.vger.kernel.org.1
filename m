Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF65703609
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbjEORFo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbjEORFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B668A7C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F41D662A99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA87DC433A1;
        Mon, 15 May 2023 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170218;
        bh=u2ZgtOrU/K0L+xo5x66dqKqo6u0TaJmw6QguNrgyeDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=10FXvXse6rMp2Glhw3rGTU/acd6K/0vJzxUiiEnqNXAlNMDkZdzwMEcOXHFc6l9w9
         WFt49woIyfxXMR/FhopaTj/skE1k9nJCrNG8fPGzioViCYhgCfoRx0HAqr5erCwEQ/
         qp5UZ2+OIpoyuGaDJ6llKhvruLO2x7/eUeV5NnvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/239] riscv: compat_syscall_table: Fixup compile warning
Date:   Mon, 15 May 2023 18:25:25 +0200
Message-Id: <20230515161723.559672973@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit f9c4bbddece7eff1155c70d48e3c9c2a01b9d778 ]

../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
field overwritten [-Woverride-init]
   12 | #define __SYSCALL(nr, call)      [nr] = (call),
      |                                         ^
../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
'__SYSCALL'
  567 | __SYSCALL(__NR_semget, sys_semget)

Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Link: https://lore.kernel.org/r/20230501223353.2833899-1-dfustini@baylibre.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index db6e4b1294ba3..ab333cb792fd9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
-- 
2.39.2



