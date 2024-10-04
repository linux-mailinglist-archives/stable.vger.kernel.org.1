Return-Path: <stable+bounces-81009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F9990DC9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907E21F221B1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349A212D23;
	Fri,  4 Oct 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRhi7HWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BD212D20;
	Fri,  4 Oct 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066484; cv=none; b=ln9TVFMc+YalXJguFkrbcdZBSh8fXX8w904p8U/iB3D4mbv3DMpItYqiJZ31B/5kST6A/aDDKNskUpHth2OqkSDie0phOzK9goP//0E8S4tocPcaCjUDfZC+Esen6wI4BSjDFiBwN/cnjo66dr6wgMUCWXQseLHtNyu53sdFa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066484; c=relaxed/simple;
	bh=7DJvnD7AOna+uDixrJmrJNsS9vYCmkYC8XHt1twYYLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgPDh5D/ZzW3hd2tDsvtdBrymTOWqGD7+0dAYHNdeBlAR536ZgzKrWbytGK9YMs6uxeRns2NTh3J5Hn/V2e9WOBzfa0jgfqGLvMLjkjDkm6fv3f6vi5Wd7UOZqG8cxwNBSB05BKgh314g8EGhze3b5FCgCEJuOvG0B4wzxDhnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRhi7HWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC8C4CEC6;
	Fri,  4 Oct 2024 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066484;
	bh=7DJvnD7AOna+uDixrJmrJNsS9vYCmkYC8XHt1twYYLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRhi7HWn7yIZ767Ybt/OdjDxmM3TMFUKRX3CvEwH5iV+hlDB9g+/EGQODYi7Qkdww
	 +HnHH72+hdJHxdicqlG5syYsKyhX4S5pr6vnRF+1P3aWtMfTgVld0TZkC0qHTzdmpw
	 NEQCaETl4k9CVp2SVxOZSYG57wb2kEP0muVPeI3OA2PJwbl1uqLA3mXcOBMPeh+C8V
	 WpDPGW5ec5tAZMXwPAZtw4vAiTRpExfKjWMeakL+cmjz40oM8rIezsEiSRQYIVbs76
	 1S+uz1a29KV2X0ROHg9M//NdsoFBFXK345LDK8rqzDEDa9B0m+p5Koy0SczQGnz7K2
	 isaz5ecj9blAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ying Sun <sunying@isrc.iscas.ac.cn>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	arnd@arndb.de,
	surenb@google.com,
	kent.overstreet@linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 25/42] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown
Date: Fri,  4 Oct 2024 14:26:36 -0400
Message-ID: <20241004182718.3673735-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Ying Sun <sunying@isrc.iscas.ac.cn>

[ Upstream commit c6ebf2c528470a09be77d0d9df2c6617ea037ac5 ]

Runs on the kernel with CONFIG_RISCV_ALTERNATIVE enabled:
  kexec -sl vmlinux

Error:
  kexec_image: Unknown rela relocation: 34
  kexec_image: Error loading purgatory ret=-8
and
  kexec_image: Unknown rela relocation: 38
  kexec_image: Error loading purgatory ret=-8

The purgatory code uses the 16-bit addition and subtraction relocation
type, but not handled, resulting in kexec_file_load failure.
So add handle to arch_kexec_apply_relocations_add().

Tested on RISC-V64 Qemu-virt, issue fixed.

Co-developed-by: Petr Tesarik <petr@tesarici.cz>
Signed-off-by: Petr Tesarik <petr@tesarici.cz>
Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20240711083236.2859632-1-sunying@isrc.iscas.ac.cn
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/elf_kexec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index b3b96ff46d193..88721bea81fcd 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -444,6 +444,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 			*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
 				 ENCODE_CJTYPE_IMM(val - addr);
 			break;
+		case R_RISCV_ADD16:
+			*(u16 *)loc += val;
+			break;
+		case R_RISCV_SUB16:
+			*(u16 *)loc -= val;
+			break;
 		case R_RISCV_ADD32:
 			*(u32 *)loc += val;
 			break;
-- 
2.43.0


