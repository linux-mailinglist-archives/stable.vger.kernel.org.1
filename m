Return-Path: <stable+bounces-128824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FFA7F55F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A1189707A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FA25F998;
	Tue,  8 Apr 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpYacs6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB801FECD2
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095622; cv=none; b=ZFtXIPxjMqzeOAGtH1uCgMDhqnAFVnlfV+C2Jr5s1+PFonxRBhonckWemFJ/GYcn8tpncRUVctlxqsSxJlgQ4kLi9PIw28qeCY9/4G5ZhNasdlqAvBNJtJbanI7AVXrkjWiseqRR1pBvixp96bxuwhRwREeY/QbYv8GoifcakX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095622; c=relaxed/simple;
	bh=LWLHtwTE4z8UEzuJbWJAT4B+g7MBWoXcGgJ6OWL/GXw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OGoFPytuyOYDfWxLMQtE5K+2mHSIoDn+69B9O9SGfY7P3HNi9bCRqAmlhyjrP0A58SwOZmLchM7jb9d2wCDqRW/BFfgWtfcCNOF/I0GCoSVXrcR9R0s0igoFDVrmiEh34Yjckf/p0kpuDfoUU5gaPT5yyQcVjVXMps8dEppNCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpYacs6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C28C4CEE9;
	Tue,  8 Apr 2025 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095618;
	bh=LWLHtwTE4z8UEzuJbWJAT4B+g7MBWoXcGgJ6OWL/GXw=;
	h=Subject:To:Cc:From:Date:From;
	b=NpYacs6Mau+DPt23BzjI1NSjMLqTavRoX91cuVyo0h8A0UXwjk4tvE+FatYvbMsH2
	 sG4HpsYJ161G6UMxjwdTMIRWh4zLYr0lnIsn02cuG/wGWkLu4Kmu1J7DeXEZyPOL+w
	 l0WCfkY9P5iobkUYfeqVcHc30EtEhKvlKwPmYgPg=
Subject: FAILED: patch "[PATCH] LoongArch: BPF: Don't override subprog's return value" failed to apply to 6.1-stable tree
To: hengqi.chen@gmail.com,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 08:58:45 +0200
Message-ID: <2025040845-repeater-uninvited-9d3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 60f3caff1492e5b8616b9578c4bedb5c0a88ed14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040845-repeater-uninvited-9d3b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60f3caff1492e5b8616b9578c4bedb5c0a88ed14 Mon Sep 17 00:00:00 2001
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 30 Mar 2025 16:31:09 +0800
Subject: [PATCH] LoongArch: BPF: Don't override subprog's return value

The verifier test `calls: div by 0 in subprog` triggers a panic at the
ld.bu instruction. The ld.bu insn is trying to load byte from memory
address returned by the subprog. The subprog actually set the correct
address at the a5 register (dedicated register for BPF return values).
But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
we also sign extended a5 to the a0 register (return value in LoongArch).
For function call insn, we later propagate the a0 register back to a5
register. This is right for native calls but wrong for bpf2bpf calls
which expect zero-extended return value in a5 register. So only move a0
to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).

Cc: stable@vger.kernel.org
Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a06bf89fed67..fa1500d4aa3e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -907,7 +907,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
-		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
 		break;
 
 	/* tail call */


