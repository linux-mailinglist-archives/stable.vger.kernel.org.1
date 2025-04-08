Return-Path: <stable+bounces-131043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801EAA8077B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D134A5D76
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD5269D15;
	Tue,  8 Apr 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqLe5ZkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17332063FD;
	Tue,  8 Apr 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115335; cv=none; b=k3LXvgED/QGuMp/HnH75Kc64c4lq58r5isQefSXsEvPXCB6umJlyUjZ6P+vxOiR1bUTHDPC3D7clIJnJfh7Hx+XFedjLuGGt1AF0tWYQ/8mSswSMOJSclq8iF/Co+/rjPe76R59i0vDkrrLi7aPGeU5xMfJlLrFmsPkVgDjMqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115335; c=relaxed/simple;
	bh=ovLb0FbzqAD5ottyPckptA+PgG6iYYK5jwH/jFeaGJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuPoRu6lKyL7Ri97mKg2hHCs+DVuC7EOwxrsoXEDkzV+u3JcqzS/b8XqkS9H6K8kV/0UPHn94Pu5fsWjkt8G9hquLXz0hDLhO+vBaMADry3kHD/NEkW+t5EvcOulHIvMZSqaguf8gtj+P37UBECIje7dasPpSFrQDOQlbBO962Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqLe5ZkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A0EC4CEE5;
	Tue,  8 Apr 2025 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115335;
	bh=ovLb0FbzqAD5ottyPckptA+PgG6iYYK5jwH/jFeaGJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqLe5ZkQnlQaXzqgggjn4PD0eTIzHaOBC+c5iElTglqLsA2GjnXjbhXD9NMO2NckL
	 z8iynXNZkcfeR8b1n3RVo6b2kjmhjnyKI8PGTtV0s5TtIF4u2pw4Vlf/ggV7QIWrSA
	 iIb2uVialFVCCStTfvrXyD+bmNfKEWO+pFOEEnWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Li <vincent.mc.li@gmail.com>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.13 437/499] LoongArch: BPF: Fix off-by-one error in build_prologue()
Date: Tue,  8 Apr 2025 12:50:49 +0200
Message-ID: <20250408104902.128686717@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,6 +27,11 @@ struct jit_data {
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



