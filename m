Return-Path: <stable+bounces-80896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8E990C77
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00981F21A36
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BC1B4F29;
	Fri,  4 Oct 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+r3nt8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE941B4F21;
	Fri,  4 Oct 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066201; cv=none; b=cREXXPfqbRkEMiMgWLUbrgq6Q9hsEquV4c7sF/ewvfRRcc4mTpt1XN7XGH+4B0y7bKnziwjNGvuJuA3ys7ROejWKUHA8TKtjmrfhNu0EBaMIrTMiBCla9nZ77E4bdVquv7eBo//E94mKiXpZenkRP5KPQ6OvkJSiKf/D3FgYr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066201; c=relaxed/simple;
	bh=DTVQMn5qLMaxZLP5JEkomQkN+Rm1ujTymnl59WAJqOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJUIA8cOJf6Av22wluZKcKoBgjAOFnsYXH4WMlCXEOBvnQ4jq1mIFE4n6ICfPkjSOHsNgilslKBt/Y+jnUIihik5EQdfKWpetr+KVsJs3ckE7NncjBBsW4NkjHsZdg3s6lcICkGT6nRUK6DN5WdIu2XTYcULEdpmZii3EVu1RfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+r3nt8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D24C4CECD;
	Fri,  4 Oct 2024 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066199;
	bh=DTVQMn5qLMaxZLP5JEkomQkN+Rm1ujTymnl59WAJqOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+r3nt8elslt7mqEsBuERN1jnrmQ7U/rqp69uUGDiTley/sa1Q3rw02Eyb67OKomd
	 udzVkKWSKeudybvRW9x931yc+LNLrdetI8mX4IxPtohAOEllB3N5dBVUgxovKMThMH
	 zdgQadZKPE2nSHOYDQQ7CLYUXOKb+kRDVrmuLX8X+u9iJCw92s6ho6tFTn7P+MBCrD
	 RrBuk34ADpuro15HGZ92dCjN8HTqTFt//Fwtg40QTEbC5PROOFsVC+VniE7RAKvCQX
	 gEhx/CLmllycKPj5pbxXw0R7obGT7QV/0n5q8ss1ysXvhcpg6pWhF6vKWA+ULXVh7O
	 f4qNdoa40Iq2g==
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
	kent.overstreet@linux.dev,
	pasha.tatashin@soleen.com,
	surenb@google.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 40/70] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown
Date: Fri,  4 Oct 2024 14:20:38 -0400
Message-ID: <20241004182200.3670903-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 11c0d2e0becfe..3c37661801f95 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -451,6 +451,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
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


