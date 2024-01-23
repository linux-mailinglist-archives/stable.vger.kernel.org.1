Return-Path: <stable+bounces-15437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD383853B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C688291B7F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46701FD1;
	Tue, 23 Jan 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvJ3W+0y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84752290B;
	Tue, 23 Jan 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975774; cv=none; b=LIRRkAgQPWqckmBMuzm1nRW0yOtI5u1gYgfnfgMEfsrjMea52Oeq3C7k/EEANhBOG+MZg2xj6CqsR2Vp/jvh7oymNn1KDV9gaQQ8NHp87eb7SdezI1/xhmp6UHT8T1YCZCuPy8+oPl3mi2z1S8XBzsNi7wknpTW/xgIAR4EMLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975774; c=relaxed/simple;
	bh=XMM8Yh9zT0jYbQCBgYHg6epnNZiMh+cRuGhYsJF3Js8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R29cYPTqiQEzcJYV2aPlCPgBks/KJoy5P0ngepqzACg9qSB6zXQ/W6A6I0ibXOmLkMKgrBoYqOQsgCSurAmzHq2oJAkHcU37xNM8lLQbiq40yOKzPvj8JFRo6+4Lrbf70CqPzdRGMXM0iO0CjQKxfr8u4xtnvY53iWP1NBkltT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvJ3W+0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B026C433F1;
	Tue, 23 Jan 2024 02:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975774;
	bh=XMM8Yh9zT0jYbQCBgYHg6epnNZiMh+cRuGhYsJF3Js8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvJ3W+0yPjsg0VnvLaM5f3Y1ODCJY0s0p1NYD3sMLHCAizO2rnLeFEYxF+Ep9+OUE
	 ynJUtXY/JNEnXXUFZET/Lij6yBLx6faLob7sXfCJGwnajog9B5t8ahUt0XPpMt4e0B
	 SoVHj4tpgbOD05ipX3ySWJ8+PtOIz638pldRxA0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 557/583] LoongArch: BPF: Prevent out-of-bounds memory access
Date: Mon, 22 Jan 2024 16:00:08 -0800
Message-ID: <20240122235829.197833692@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hengqi Chen <hengqi.chen@gmail.com>

[ Upstream commit 36a87385e31c9343af9a4756598e704741250a67 ]

The test_tag test triggers an unhandled page fault:

  # ./test_tag
  [  130.640218] CPU 0 Unable to handle kernel paging request at virtual address ffff80001b898004, era == 9000000003137f7c, ra == 9000000003139e70
  [  130.640501] Oops[#3]:
  [  130.640553] CPU: 0 PID: 1326 Comm: test_tag Tainted: G      D    O       6.7.0-rc4-loong-devel-gb62ab1a397cf #47 61985c1d94084daa2432f771daa45b56b10d8d2a
  [  130.640764] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
  [  130.640874] pc 9000000003137f7c ra 9000000003139e70 tp 9000000104cb4000 sp 9000000104cb7a40
  [  130.641001] a0 ffff80001b894000 a1 ffff80001b897ff8 a2 000000006ba210be a3 0000000000000000
  [  130.641128] a4 000000006ba210be a5 00000000000000f1 a6 00000000000000b3 a7 0000000000000000
  [  130.641256] t0 0000000000000000 t1 00000000000007f6 t2 0000000000000000 t3 9000000004091b70
  [  130.641387] t4 000000006ba210be t5 0000000000000004 t6 fffffffffffffff0 t7 90000000040913e0
  [  130.641512] t8 0000000000000005 u0 0000000000000dc0 s9 0000000000000009 s0 9000000104cb7ae0
  [  130.641641] s1 00000000000007f6 s2 0000000000000009 s3 0000000000000095 s4 0000000000000000
  [  130.641771] s5 ffff80001b894000 s6 ffff80001b897fb0 s7 9000000004090c50 s8 0000000000000000
  [  130.641900]    ra: 9000000003139e70 build_body+0x1fcc/0x4988
  [  130.642007]   ERA: 9000000003137f7c build_body+0xd8/0x4988
  [  130.642112]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
  [  130.642261]  PRMD: 00000004 (PPLV0 +PIE -PWE)
  [  130.642353]  EUEN: 00000003 (+FPE +SXE -ASXE -BTE)
  [  130.642458]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
  [  130.642554] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
  [  130.642658]  BADV: ffff80001b898004
  [  130.642719]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
  [  130.642815] Modules linked in: [last unloaded: bpf_testmod(O)]
  [  130.642924] Process test_tag (pid: 1326, threadinfo=00000000f7f4015f, task=000000006499f9fd)
  [  130.643062] Stack : 0000000000000000 9000000003380724 0000000000000000 0000000104cb7be8
  [  130.643213]         0000000000000000 25af8d9b6e600558 9000000106250ea0 9000000104cb7ae0
  [  130.643378]         0000000000000000 0000000000000000 9000000104cb7be8 90000000049f6000
  [  130.643538]         0000000000000090 9000000106250ea0 ffff80001b894000 ffff80001b894000
  [  130.643685]         00007ffffb917790 900000000313ca94 0000000000000000 0000000000000000
  [  130.643831]         ffff80001b894000 0000000000000ff7 0000000000000000 9000000100468000
  [  130.643983]         0000000000000000 0000000000000000 0000000000000040 25af8d9b6e600558
  [  130.644131]         0000000000000bb7 ffff80001b894048 0000000000000000 0000000000000000
  [  130.644276]         9000000104cb7be8 90000000049f6000 0000000000000090 9000000104cb7bdc
  [  130.644423]         ffff80001b894000 0000000000000000 00007ffffb917790 90000000032acfb0
  [  130.644572]         ...
  [  130.644629] Call Trace:
  [  130.644641] [<9000000003137f7c>] build_body+0xd8/0x4988
  [  130.644785] [<900000000313ca94>] bpf_int_jit_compile+0x228/0x4ec
  [  130.644891] [<90000000032acfb0>] bpf_prog_select_runtime+0x158/0x1b0
  [  130.645003] [<90000000032b3504>] bpf_prog_load+0x760/0xb44
  [  130.645089] [<90000000032b6744>] __sys_bpf+0xbb8/0x2588
  [  130.645175] [<90000000032b8388>] sys_bpf+0x20/0x2c
  [  130.645259] [<9000000003f6ab38>] do_syscall+0x7c/0x94
  [  130.645369] [<9000000003121c5c>] handle_syscall+0xbc/0x158
  [  130.645507]
  [  130.645539] Code: 380839f6  380831f9  28412bae <24000ca6> 004081ad  0014cb50  004083e8  02bff34c  58008e91
  [  130.645729]
  [  130.646418] ---[ end trace 0000000000000000 ]---

On my machine, which has CONFIG_PAGE_SIZE_16KB=y, the test failed at
loading a BPF prog with 2039 instructions:

  prog = (struct bpf_prog *)ffff80001b894000
  insn = (struct bpf_insn *)(prog->insnsi)ffff80001b894048
  insn + 2039 = (struct bpf_insn *)ffff80001b898000 <- end of the page

In the build_insn() function, we are trying to access next instruction
unconditionally, i.e. `(insn + 1)->imm`. The address lies in the next
page and can be not owned by the current process, thus an page fault is
inevitable and then segfault.

So, let's access next instruction only under `dst = imm64` context.

With this fix, we have:

  # ./test_tag
  test_tag: OK (40945 tests)

Fixes: bbfddb904df6f82 ("LoongArch: BPF: Avoid declare variables in switch-case")
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/net/bpf_jit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 00915fb3cb82..9eb7753d117d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -461,7 +461,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const u8 dst = regmap[insn->dst_reg];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
-	const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
 
 	switch (code) {
@@ -865,8 +864,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* dst = imm64 */
 	case BPF_LD | BPF_IMM | BPF_DW:
+	{
+		const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
+
 		move_imm(ctx, dst, imm64, is32);
 		return 1;
+	}
 
 	/* dst = *(size *)(src + off) */
 	case BPF_LDX | BPF_MEM | BPF_B:
-- 
2.43.0




