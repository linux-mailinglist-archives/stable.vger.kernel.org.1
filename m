Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FE70CA03
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjEVTyG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjEVTyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9819C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A8562B61
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09042C433EF;
        Mon, 22 May 2023 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785243;
        bh=hqbdq5DzK1IR7+vph6TzSqO91AWrFm5V62T6wml/ukQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFNJPY217I8ugPxiP8G2gX9XYhuwtwaPyx958GNfDkc1KIB9k5GQh4q8NIq8TbtRd
         +5zXL/YPeiJEOmXyuysS1lh0b54xkwMNKDmzMQ2ut9ikVhGPc5ayN385TKtKg+dmlQ
         iUL/bmmZBKdb9suTgMGllJoPwKWD9rQiy/YZHRSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ze Gao <zegao@tencent.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.3 358/364] rethook, fprobe: do not trace rethook related functions
Date:   Mon, 22 May 2023 20:11:03 +0100
Message-Id: <20230522190421.724959555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Ze Gao <zegao2021@gmail.com>

commit 571a2a50a8fc546145ffd3bf673547e9fe128ed2 upstream.

These functions are already marked as NOKPROBE to prevent recursion and
we have the same reason to blacklist them if rethook is used with fprobe,
since they are beyond the recursion-free region ftrace can guard.

Link: https://lore.kernel.org/all/20230517034510.15639-5-zegao@tencent.com/

Fixes: f3a112c0c40d ("x86,rethook,kprobes: Replace kretprobe with rethook on x86")
Signed-off-by: Ze Gao <zegao@tencent.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/probes/Makefile |    2 ++
 arch/s390/kernel/Makefile         |    1 +
 arch/x86/kernel/Makefile          |    1 +
 3 files changed, 4 insertions(+)

--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_RETHOOK)		+= rethook.o reth
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -10,6 +10,7 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTR
 
 # Do not trace early setup code
 CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
 
 endif
 
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
+CFLAGS_REMOVE_rethook.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n


