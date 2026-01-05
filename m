Return-Path: <stable+bounces-204764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CFECF3B59
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3B3303D322
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB6335070;
	Mon,  5 Jan 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whd8Y0FZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4833468F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617991; cv=none; b=brW88pq2q/tUQ9jyLYS0YYDX5g9FhaN6U+pz0fvU9wJe+huXv+K3KtoY4lEPODnVfG82ZwlxbINmWbAw4UT6L+BOpD32HfU3J/5MFdTXKlnef5uaY6QNI1oL25tetLgRtlEejFP0uM24iJmzRPV0CO7mYbJpxXLBLwWmbJLkry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617991; c=relaxed/simple;
	bh=zcmyZdP9kh0fjqpjPGMy/kEZjKt824X5TVrrXSlpqtQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IbVUBYHAizc5fdSuFUQrXtAlpMZkvTroRGTccI77g5aEmM0ZKrB0Rw4VJVbRgmWHhqWvsMQ369N9Md85NaQ0R9DEGSKTJokokew0JJlqklqgkaGdDIsj4jTvsuhd3pDUbwkvqJ/J/koDPNsLag2/3bIg8atHr6ES5pe0JOfK/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whd8Y0FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22E7C116D0;
	Mon,  5 Jan 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767617991;
	bh=zcmyZdP9kh0fjqpjPGMy/kEZjKt824X5TVrrXSlpqtQ=;
	h=Subject:To:Cc:From:Date:From;
	b=whd8Y0FZaLgC86z+Yc+O+OKUPtY30bnezxToEtpU+4yE3Ff0ptoPl3cDYN5qYiTK6
	 WhVbJ3JWOAHejBK4oLtOBt+x+PehTfzPvt5u01w4cj9B/YHZvEoATUeV7cnA9tQ6Gq
	 hSxpRyVyo/9RdP5VaIAc0O/UVK+9ZyADfF8WQEdI=
Subject: FAILED: patch "[PATCH] LoongArch: BPF: Enhance the bpf_arch_text_poke() function" failed to apply to 6.18-stable tree
To: duanchenghao@kylinos.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:59:48 +0100
Message-ID: <2026010547-passenger-getting-5dde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 73721d8676771c6c7b06d4e636cc053fc76afefd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010547-passenger-getting-5dde@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73721d8676771c6c7b06d4e636cc053fc76afefd Mon Sep 17 00:00:00 2001
From: Chenghao Duan <duanchenghao@kylinos.cn>
Date: Wed, 31 Dec 2025 15:19:21 +0800
Subject: [PATCH] LoongArch: BPF: Enhance the bpf_arch_text_poke() function

Enhance the bpf_arch_text_poke() function to enable accurate location
of BPF program entry points.

When modifying the entry point of a BPF program, skip the "move t0, ra"
instruction to ensure the correct logic and copy of the jump address.

Cc: stable@vger.kernel.org
Fixes: 677e6123e3d2 ("LoongArch: BPF: Disable trampoline for kernel module function trace")
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9f6e93343b6e..d1d5a65308b9 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1309,15 +1309,30 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 {
 	int ret;
 	bool is_call;
+	unsigned long size = 0;
+	unsigned long offset = 0;
+	void *image = NULL;
+	char namebuf[KSYM_NAME_LEN];
 	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 
 	/* Only poking bpf text is supported. Since kernel function entry
 	 * is set up by ftrace, we rely on ftrace to poke kernel functions.
 	 */
-	if (!is_bpf_text_address((unsigned long)ip))
+	if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
 		return -ENOTSUPP;
 
+	image = ip - offset;
+
+	/* zero offset means we're poking bpf prog entry */
+	if (offset == 0) {
+		/* skip to the nop instruction in bpf prog entry:
+		 * move t0, ra
+		 * nop
+		 */
+		ip = image + LOONGARCH_INSN_SIZE;
+	}
+
 	is_call = old_t == BPF_MOD_CALL;
 	ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)


