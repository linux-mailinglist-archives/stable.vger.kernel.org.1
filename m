Return-Path: <stable+bounces-119124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83212A424B6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92526174FD1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3323BCED;
	Mon, 24 Feb 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WJEv1+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB2148850;
	Mon, 24 Feb 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408398; cv=none; b=cgmJTjxe6R3OYfQPhkH2lsffRO3N3bl7pDT91crSuBPE1f79dc0h91PMtBmY4tV3j3rjF67qpr0RfNArD8me4Y7s2tYmf2kl0JfznNTUD2w36l5KYzo+x8uEUHljgO+5UqCY8Lxne3E80xw06ajv0uuGEJh5N1QGACpkGHkfBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408398; c=relaxed/simple;
	bh=erY7zdWtqQR2ZSQrNiLJfUFk9r9k6huLjKK1hFPmCNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXSZxawL9z2Q1kn4uWvz5+Zl1N2oV3D+qL99zjFJ9rhxxPaN6lQRB7Mx2cCGw70I+3bYDXR5zsis031UiWAwoy4geII33el4pLixP/DRIHXgkazcs7mLPUNgAIUXD0tpahTDTj8dfxxKra3zF8Myp2aiwWeHBvmbakm/NrJx7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WJEv1+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8988BC4CED6;
	Mon, 24 Feb 2025 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408398;
	bh=erY7zdWtqQR2ZSQrNiLJfUFk9r9k6huLjKK1hFPmCNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0WJEv1+1aPn0ME/QSiQnddGijL5sZX5koh4fEMFgdzwjr3Oob86dSV4voS+4Dhc8g
	 IqCgOAPy6Iiw/isXEmeDWo37dCQokXUhnB8xqQjUDdgdipXOtL1pc5W4jkNdLPHFSB
	 EqexGuH7OEXG9lR+MJpFaPnylpsGwnNW1YDaUJvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erhard Furtner <erhard_f@mailbox.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/154] powerpc/code-patching: Disable KASAN report during patching via temporary mm
Date: Mon, 24 Feb 2025 15:34:05 +0100
Message-ID: <20250224142608.898674920@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit dc9c5166c3cb044f8a001e397195242fd6796eee ]

Erhard reports the following KASAN hit on Talos II (power9) with kernel 6.13:

[   12.028126] ==================================================================
[   12.028198] BUG: KASAN: user-memory-access in copy_to_kernel_nofault+0x8c/0x1a0
[   12.028260] Write of size 8 at addr 0000187e458f2000 by task systemd/1

[   12.028346] CPU: 87 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.13.0-P9-dirty #3
[   12.028408] Tainted: [T]=RANDSTRUCT
[   12.028446] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[   12.028500] Call Trace:
[   12.028536] [c000000008dbf3b0] [c000000001656a48] dump_stack_lvl+0xbc/0x110 (unreliable)
[   12.028609] [c000000008dbf3f0] [c0000000006e2fc8] print_report+0x6b0/0x708
[   12.028666] [c000000008dbf4e0] [c0000000006e2454] kasan_report+0x164/0x300
[   12.028725] [c000000008dbf600] [c0000000006e54d4] kasan_check_range+0x314/0x370
[   12.028784] [c000000008dbf640] [c0000000006e6310] __kasan_check_write+0x20/0x40
[   12.028842] [c000000008dbf660] [c000000000578e8c] copy_to_kernel_nofault+0x8c/0x1a0
[   12.028902] [c000000008dbf6a0] [c0000000000acfe4] __patch_instructions+0x194/0x210
[   12.028965] [c000000008dbf6e0] [c0000000000ade80] patch_instructions+0x150/0x590
[   12.029026] [c000000008dbf7c0] [c0000000001159bc] bpf_arch_text_copy+0x6c/0xe0
[   12.029085] [c000000008dbf800] [c000000000424250] bpf_jit_binary_pack_finalize+0x40/0xc0
[   12.029147] [c000000008dbf830] [c000000000115dec] bpf_int_jit_compile+0x3bc/0x930
[   12.029206] [c000000008dbf990] [c000000000423720] bpf_prog_select_runtime+0x1f0/0x280
[   12.029266] [c000000008dbfa00] [c000000000434b18] bpf_prog_load+0xbb8/0x1370
[   12.029324] [c000000008dbfb70] [c000000000436ebc] __sys_bpf+0x5ac/0x2e00
[   12.029379] [c000000008dbfd00] [c00000000043a228] sys_bpf+0x28/0x40
[   12.029435] [c000000008dbfd20] [c000000000038eb4] system_call_exception+0x334/0x610
[   12.029497] [c000000008dbfe50] [c00000000000c270] system_call_vectored_common+0xf0/0x280
[   12.029561] --- interrupt: 3000 at 0x3fff82f5cfa8
[   12.029608] NIP:  00003fff82f5cfa8 LR: 00003fff82f5cfa8 CTR: 0000000000000000
[   12.029660] REGS: c000000008dbfe80 TRAP: 3000   Tainted: G                T   (6.13.0-P9-dirty)
[   12.029735] MSR:  900000000280f032 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI>  CR: 42004848  XER: 00000000
[   12.029855] IRQMASK: 0
               GPR00: 0000000000000169 00003fffdcf789a0 00003fff83067100 0000000000000005
               GPR04: 00003fffdcf78a98 0000000000000090 0000000000000000 0000000000000008
               GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR12: 0000000000000000 00003fff836ff7e0 c000000000010678 0000000000000000
               GPR16: 0000000000000000 0000000000000000 00003fffdcf78f28 00003fffdcf78f90
               GPR20: 0000000000000000 0000000000000000 0000000000000000 00003fffdcf78f80
               GPR24: 00003fffdcf78f70 00003fffdcf78d10 00003fff835c7239 00003fffdcf78bd8
               GPR28: 00003fffdcf78a98 0000000000000000 0000000000000000 000000011f547580
[   12.030316] NIP [00003fff82f5cfa8] 0x3fff82f5cfa8
[   12.030361] LR [00003fff82f5cfa8] 0x3fff82f5cfa8
[   12.030405] --- interrupt: 3000
[   12.030444] ==================================================================

Commit c28c15b6d28a ("powerpc/code-patching: Use temporary mm for
Radix MMU") is inspired from x86 but unlike x86 is doesn't disable
KASAN reports during patching. This wasn't a problem at the begining
because __patch_mem() is not instrumented.

Commit 465cabc97b42 ("powerpc/code-patching: introduce
patch_instructions()") use copy_to_kernel_nofault() to copy several
instructions at once. But when using temporary mm the destination is
not regular kernel memory but a kind of kernel-like memory located
in user address space. Because it is not in kernel address space it is
not covered by KASAN shadow memory. Since commit e4137f08816b ("mm,
kasan, kmsan: instrument copy_from/to_kernel_nofault") KASAN reports
bad accesses from copy_to_kernel_nofault(). Here a bad access to user
memory is reported because KASAN detects the lack of shadow memory and
the address is below TASK_SIZE.

Do like x86 in commit b3fd8e83ada0 ("x86/alternatives: Use temporary
mm for text poking") and disable KASAN reports during patching when
using temporary mm.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Close: https://lore.kernel.org/all/20250201151435.48400261@yea/
Fixes: 465cabc97b42 ("powerpc/code-patching: introduce patch_instructions()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/1c05b2a1b02ad75b981cfc45927e0b4a90441046.1738577687.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/lib/code-patching.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index acdab294b340a..2685d7efea511 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -493,7 +493,9 @@ static int __do_patch_instructions_mm(u32 *addr, u32 *code, size_t len, bool rep
 
 	orig_mm = start_using_temp_mm(patching_mm);
 
+	kasan_disable_current();
 	err = __patch_instructions(patch_addr, code, len, repeat_instr);
+	kasan_enable_current();
 
 	/* context synchronisation performed by __patch_instructions */
 	stop_using_temp_mm(patching_mm, orig_mm);
-- 
2.39.5




