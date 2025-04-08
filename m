Return-Path: <stable+bounces-131282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9100A8092A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52584E0E2C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772F270ECB;
	Tue,  8 Apr 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTaPTibY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7926B0A2;
	Tue,  8 Apr 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115975; cv=none; b=Sf1wLHMp2AofCLKumI+uc51mPs1/razt1aVy+MqGGBUaZ3iuwLfW/Aa7PoBEBONUvA+SYYQQA6xkl9bS/7D6TFR5t3Jb76EEthl5cxKzD5bbrerk1ggjLuaR/CjPh/pzAgFLQ2s/Tp0KoaYGoPdYbcLDSlEk1cd4Fjqji6tbZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115975; c=relaxed/simple;
	bh=8Rk5aRcGwz0DN88KK5hz+nDtM17Q+pnYqW7R4rG1zJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK0zQUaKfqXqzVAwMUrK8BS7lqdo1dMkdvwCowz+UpA08RkMx2c2Hketv9tdjuO4AIFUCd0BDYMd9hbexEf85PqFLhoYuZNnUIFTNu+Fe17gd9O3jQUdoy+EQ0QItppjXZVmnNiplukeGBMWIVSCn0vY8kpURfraKC5lyBVoed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTaPTibY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E21C4CEEB;
	Tue,  8 Apr 2025 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115975;
	bh=8Rk5aRcGwz0DN88KK5hz+nDtM17Q+pnYqW7R4rG1zJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTaPTibYvjvBrReQFJpfGWBeG62G5gJR7osGg+oeaAQe3zWOXGhDxDDcmM134dKyq
	 dDHEil5uw4fkhlu8FICpQFt8eyNDmMSQtfO82iRQ4vSZahBPq8U+rJQlwQQ8JwJkoh
	 zdUB2vQNKkXospmqHCb4P0XnBcZK5tLQoYQl43EQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Li <vincent.mc.li@gmail.com>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 175/204] LoongArch: BPF: Fix off-by-one error in build_prologue()
Date: Tue,  8 Apr 2025 12:51:45 +0200
Message-ID: <20250408104825.453878411@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hengqi Chen <hengqi.chen@gmail.com>

commit 7e2586991e36663c9bc48c828b83eab180ad30a9 upstream.

Vincent reported that running BPF progs with tailcalls on LoongArch
causes kernel hard lockup. Debugging the issues shows that the JITed
image missing a jirl instruction at the end of the epilogue.

There are two passes in JIT compiling, the first pass set the flags and
the second pass generates JIT code based on those flags. With BPF progs
mixing bpf2bpf and tailcalls, build_prologue() generates N insns in the
first pass and then generates N+1 insns in the second pass. This makes
epilogue_offset off by one and we will jump to some unexpected insn and
cause lockup. Fix this by inserting a nop insn.

Cc: stable@vger.kernel.org
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcalls")
Reported-by: Vincent Li <vincent.mc.li@gmail.com>
Tested-by: Vincent Li <vincent.mc.li@gmail.com>
Closes: https://lore.kernel.org/loongarch/CAK3+h2w6WESdBN3UCr3WKHByD7D6Q_Ve1EDAjotVrnx6Or_c8g@mail.gmail.com/
Closes: https://lore.kernel.org/bpf/CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com/
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/net/bpf_jit.c |    2 ++
 arch/loongarch/net/bpf_jit.h |    5 +++++
 2 files changed, 7 insertions(+)

--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -142,6 +142,8 @@ static void build_prologue(struct jit_ct
 	 */
 	if (seen_tail_call(ctx) && seen_call(ctx))
 		move_reg(ctx, TCC_SAVED, REG_TCC);
+	else
+		emit_insn(ctx, nop);
 
 	ctx->stack_size = stack_adjust;
 }
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -25,6 +25,11 @@ struct jit_data {
 	struct jit_ctx ctx;
 };
 
+static inline void emit_nop(union loongarch_instruction *insn)
+{
+	insn->word = INSN_NOP;
+}
+
 #define emit_insn(ctx, func, ...)						\
 do {										\
 	if (ctx->image != NULL) {						\



