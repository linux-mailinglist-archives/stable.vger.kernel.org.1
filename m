Return-Path: <stable+bounces-27575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4809A87A60E
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799C71C21829
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28463D386;
	Wed, 13 Mar 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q6cBH+OD"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC50EAC8
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326608; cv=none; b=mdE3z13OFuAxFmhNri6TnguvAYZA6NLizb7Xy/BGIHUTRdGcPKpTTQIzWwKhjtQQAS0rjNWH8PwRY33F+3dxSqhG8CS/xfjvjQ7vmvlrhe9OQEtu5Sf3ZsI/8toLus5cVAf0KNQEMSe0VTWLwOUtcn2i1vzPe/pzIDv4WpbK75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326608; c=relaxed/simple;
	bh=XdTByhI3NfPTzTlPrEE9Lr5dHeP+cYuRQYHbAQep2MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YFzht907apzY1z1ESSosV2umRJ7ia4MUW1KbM02V0DD9Si/QsWMHHMSX5nPQVwIH7zjaCo6wR2tWqAI1+mABUKOj4EQNPJFukfrLkl5ndHqYK7h/s2fYEhqiSc1SNVXZPY5Frq+hb2xatlzQdyxPi5+WCs24HsZTH71Gp7x3fck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q6cBH+OD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sHbjWnJOJpxSt07N9ix9ycpLnUCtLU5joDjm2AxXvGI=; b=Q6cBH+ODliVUHjOPfdXR4NcssO
	cDdyMn6wVRgfJ3aJgnaT7b8O782PhiBjINm3jGK2/JAsJAmnlnB/N2JHFxOT2TV+i4JSdIujyVl79
	4Wf++oabsGpNPDyfl8Ydj9gd7tJyJinsgQvYp5LUY+CGuVUWdR35K1CONj6PBFAEXLsF+R/DdSJLw
	cali0W3/ss/zF+Ae4Yu4Dl7tV8zoH5+CH1YgPlW8LVpP3MSXV0mPR3Xl1qdrce4OuDMcG+LBSWRB5
	veR7doEqD3Pl1/++fcrpUPGq0T1DRezSFjy4mgp1MG7ZcANExpY77knA4eg3t0HzZGfNQ0I/W06zY
	VY2rL+Og==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkM4q-009uZG-C8; Wed, 13 Mar 2024 11:43:16 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Date: Wed, 13 Mar 2024 07:42:50 -0300
Message-Id: <20240313104255.1083365-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise, we see warnings like this:

[    0.000000][    T0] ------------[ cut here ]------------
[    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
[    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
[    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02 e8 b0 b8
[    0.000000][    T0] RSP: 0000:ffffffff82e03e70 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
[    0.000000][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[    0.000000][    T0] RDX: 0000000000000000 RSI: ffffffff82e03ce0 RDI: 0000000000000001
[    0.000000][    T0] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffffffff82eaab70
[    0.000000][    T0] R10: ffffffff82e2e900 R11: 205d305420202020 R12: ffffffff82e51960
[    0.000000][    T0] R13: ffffffff81038987 R14: ffffffff81038987 R15: 0000000000000001
[    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff83726000(0000) knlGS:0000000000000000
[    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000][    T0] CR2: ffff888000014be8 CR3: 00000000037b2000 CR4: 00000000000000a0
[    0.000000][    T0] Call Trace:
[    0.000000][    T0]  <TASK>
[    0.000000][    T0]  ? __warn+0x75/0xe0
[    0.000000][    T0]  ? report_bug+0x81/0xe0
[    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
[    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
[    0.000000][    T0]  ? early_fixup_exception+0x44/0xa0
[    0.000000][    T0]  ? early_idt_handler_common+0x2f/0x40
[    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
[    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
[    0.000000][    T0]  ? __static_call_validate+0x68/0x70
[    0.000000][    T0]  ? arch_static_call_transform+0x5c/0x90
[    0.000000][    T0]  ? __static_call_init+0x1ec/0x230
[    0.000000][    T0]  ? static_call_init+0x32/0x70
[    0.000000][    T0]  ? setup_arch+0x36/0x4f0
[    0.000000][    T0]  ? start_kernel+0x67/0x400
[    0.000000][    T0]  ? secondary_startup_64_no_verify+0xb1/0xbb
[    0.000000][    T0]  </TASK>
[    0.000000][    T0] ---[ end trace 8c8589c01f370686 ]---


Peter Zijlstra (4):
  arch: Introduce CONFIG_FUNCTION_ALIGNMENT
  x86/alternatives: Introduce int3_emulate_jcc()
  x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
  x86/static_call: Add support for Jcc tail-calls

Thomas Gleixner (1):
  x86/asm: Differentiate between code and function alignment

 Makefile                             |  4 +-
 arch/Kconfig                         | 24 ++++++++++++
 arch/ia64/Kconfig                    |  1 +
 arch/ia64/Makefile                   |  2 +-
 arch/x86/Kconfig                     |  2 +
 arch/x86/boot/compressed/head_64.S   |  8 ++++
 arch/x86/include/asm/linkage.h       | 12 +++---
 arch/x86/include/asm/text-patching.h | 31 +++++++++++++++
 arch/x86/kernel/alternative.c        | 56 +++++++++++++++++++++++-----
 arch/x86/kernel/kprobes/core.c       | 38 ++++---------------
 arch/x86/kernel/static_call.c        | 50 +++++++++++++++++++++++--
 include/asm-generic/vmlinux.lds.h    |  4 +-
 include/linux/linkage.h              |  4 +-
 lib/Kconfig.debug                    |  1 +
 14 files changed, 183 insertions(+), 54 deletions(-)

-- 
2.34.1


