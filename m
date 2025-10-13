Return-Path: <stable+bounces-184850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E2BD4330
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07D7134F591
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B420279DB3;
	Mon, 13 Oct 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOkjTsnL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780210942;
	Mon, 13 Oct 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368615; cv=none; b=IApUvosBd3erhJ/DHp6LdTU4n3HikF9zX892Bvgmzn393+cGfhEit8qsPfABBMP+pToaQ/4pW02wEBhOTsQFZ8UTXDBhWdII4T8asucK0WMjM6G2cMFxmpy+vYDUI7ZNau5RnECZeVrAtL0lcj+WVSrweP+BRZjPLCgRszY91b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368615; c=relaxed/simple;
	bh=SfbFCdwXFHxdhFEzD+/sg7mjc538JQ8D+gb1ufsBS5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fef7D3GfXUtsklKvW1fmRIoMnzyFLHeztmkWKYit2QyraYvImC31d/brY/nu1V+q3UzJUU7ULDRqleifpwPgo8AZSgmFdTPpfTMXaOzOpLSE6WzQQ054IJ/Is0udFPdDUcv/PSUgHvq//gdrcKEfu2sxPpc2jeU/qFVJVoVD/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uOkjTsnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86A9C4CEE7;
	Mon, 13 Oct 2025 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368615;
	bh=SfbFCdwXFHxdhFEzD+/sg7mjc538JQ8D+gb1ufsBS5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOkjTsnLE1zVsxPaPqJyrJbL+m9bSDBRnyvgyEif5JTUx1HDQErVF8+1XWr+4mJQZ
	 1EGqrKnWJ1FSFSEVzXvDMOrhcN/oL0C824gp6regWZWrKIamn+kQhTDNqdvNySMKk9
	 hxtIe7nifnn9wtIcJevAVfI4Uw1T5ijq8NtmfZQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shenghao Yuan <shenghaoyuan0928@163.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 223/262] bpf: Reject negative offsets for ALU ops
Date: Mon, 13 Oct 2025 16:46:05 +0200
Message-ID: <20251013144334.273455057@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazhou Tang <tangyazhou518@outlook.com>

[ Upstream commit 55c0ced59fe17dee34e9dfd5f7be63cbab207758 ]

When verifying BPF programs, the check_alu_op() function validates
instructions with ALU operations. The 'offset' field in these
instructions is a signed 16-bit integer.

The existing check 'insn->off > 1' was intended to ensure the offset is
either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
signed, this check incorrectly accepts all negative values (e.g., -1).

This commit tightens the validation by changing the condition to
'(insn->off != 0 && insn->off != 1)'. This ensures that any value
other than the explicitly permitted 0 and 1 is rejected, hardening the
verifier against malformed BPF programs.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Link: https://lore.kernel.org/r/tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1829f62a74a9e..96640a80fd9c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14545,7 +14545,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || insn->off > 1 ||
+			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
@@ -14555,7 +14555,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off > 1 ||
+			if (insn->src_reg != BPF_REG_0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
-- 
2.51.0




