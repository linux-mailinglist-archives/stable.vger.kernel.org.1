Return-Path: <stable+bounces-49097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BF8FEBD8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D76EB26E0F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D31ABE35;
	Thu,  6 Jun 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxHfxpfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940941ABE34;
	Thu,  6 Jun 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683300; cv=none; b=b21LUp7Eg1aCAVUbsvpXPW4A94mWG+pXQgOFYv6I/WNwF5TddbITnrc0FyA/0xLC237X44fUFQZ+3ns4eQC72vJOprlT5fHr/0BHWO5qs11SndGvrd2roLZrc0YRt6/hSOAH3YYSixPHvDyPOcWc6mCZa70GMKp6iOX5FGTAvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683300; c=relaxed/simple;
	bh=GHfzVBhwh5I0WTGPBa1PAbiq5OJqcM9Cak9KKBntHTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDQrPyCqBQsJ/iHaKnsGmcqOTi7xncGEa9D79r46XAlVTB5WP1wQ/cBlRpGa7agNVsAlLz1qfoUjAMlOxYPljfy59xXEhq+UHiwmvQxAnl2gf/1MOQPtv24bNl7LunZCz7m7cD79u2I1ZOnCo8nmC8ZoMULnj9acIe0MVsYVm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxHfxpfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A9C2BD10;
	Thu,  6 Jun 2024 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683300;
	bh=GHfzVBhwh5I0WTGPBa1PAbiq5OJqcM9Cak9KKBntHTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zxHfxpfojExPAQxi3rDRHBN7LnTA8PuowAu5OmuSNu6AWQEQOcRGiFsXo8v/V1D1w
	 7aUUHDmWAouUfOA9S4rWYTGQWh86V6Loh7yGfnaKALtz7rGIFWR64xsdupoiJajPVH
	 M0ohYgUXO3IHjahyHJLx0wDt6BoBBZqfCKsq3kvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/473] riscv, bpf: make some atomic operations fully ordered
Date: Thu,  6 Jun 2024 16:01:50 +0200
Message-ID: <20240606131705.913605275@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 20a759df3bba35bf5c3ddec0c02ad69b603b584c ]

The BPF atomic operations with the BPF_FETCH modifier along with
BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
all atomic operations except BPF_CMPXCHG with relaxed ordering.

Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
Unprivileged ISA" [1], titled, "Specifying Ordering of Atomic
Instructions" says:

| To provide more efficient support for release consistency [5], each
| atomic instruction has two bits, aq and rl, used to specify additional
| memory ordering constraints as viewed by other RISC-V harts.

and

| If only the aq bit is set, the atomic memory operation is treated as
| an acquire access.
| If only the rl bit is set, the atomic memory operation is treated as a
| release access.
|
| If both the aq and rl bits are set, the atomic memory operation is
| sequentially consistent.

Fix this by setting both aq and rl bits as 1 for operations with
BPF_FETCH and BPF_XCHG.

[1] https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

Fixes: dd642ccb45ec ("riscv, bpf: Implement more atomic operations for RV64")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Link: https://lore.kernel.org/r/20240505201633.123115-1-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8f5d3c57d58ad..4c4ac563326b5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -503,33 +503,33 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		break;
 	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
 	case BPF_ADD | BPF_FETCH:
-		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
-		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
+		     rv_amoadd_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_AND | BPF_FETCH:
-		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
-		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoand_d(rs, rs, rd, 1, 1) :
+		     rv_amoand_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_OR | BPF_FETCH:
-		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
-		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoor_d(rs, rs, rd, 1, 1) :
+		     rv_amoor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_XOR | BPF_FETCH:
-		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
-		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoxor_d(rs, rs, rd, 1, 1) :
+		     rv_amoxor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
 	case BPF_XCHG:
-		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
-		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
+		     rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
-- 
2.43.0




