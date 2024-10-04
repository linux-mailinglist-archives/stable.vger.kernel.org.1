Return-Path: <stable+bounces-80823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1BF990B78
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CDD280ECC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC91DF24A;
	Fri,  4 Oct 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mquDRSxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE71DF246;
	Fri,  4 Oct 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065991; cv=none; b=FRn7uuFeVMoZrzDai8K5aSe6FrzhazfLfP/KN1yAIsEzKJ7g+vJqEYdaBIoFwENjRVMfD0ksFyXBDdU3W5TTZftfPPNSJ8ukSUKcy5ZIDA+8swQfIfmy6mP8tMwtbCEOfnKTax+H8Vr+1HcPPXEhlu+xMvWv9HyQGGRYmZZwOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065991; c=relaxed/simple;
	bh=DTVQMn5qLMaxZLP5JEkomQkN+Rm1ujTymnl59WAJqOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GikxyBWAdoLx4APzO/befQ+DeGcDcD/YX0B1oWcO2F7QETaWWJUV7V/bUdCPML8HFNf3qB37WE2jERmHu93+KHcv62ZzBUKhfmO1dpfn70vLidh7XuCBlhK/vFVfnRtZ6LzDyCCwIRxgfMyMamzAo6WCAYo9WEPyggF6otU92cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mquDRSxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FCDC4CECC;
	Fri,  4 Oct 2024 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065990;
	bh=DTVQMn5qLMaxZLP5JEkomQkN+Rm1ujTymnl59WAJqOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mquDRSxRGs8cxl7do36SFdI4kGyJXhys+c/ALO5voWGkKABE/CwCbS0Z0AQjUL7DG
	 aslAF43fNn2iaT4Ek0dIRerUD4VhLyGaYR9ONBJMqgvjRHyrKqwtRGHcp5wzEXwO45
	 EdtkyDkr+0hpSn6qi6dXr7+J7NtxaRsSQHC6Lxi4ai2/Of4L5woBsl5Udn7WL9UNp0
	 UCVmv95Q3L6OWHavUDZJkYuVcdiiPO1uroDjxtevPZxKx9CwQVj9Nfg7nROqbfxBHR
	 xlUKWAfNm24p3b2T80iXWjgkXYFU9uzgu9Yae+9aE7moxZXp49PK6dJtVLKD+Gf9Ko
	 KDQdlldhtaFKQ==
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
	arnd@arndb.de,
	pasha.tatashin@soleen.com,
	surenb@google.com,
	kent.overstreet@linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 43/76] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown
Date: Fri,  4 Oct 2024 14:17:00 -0400
Message-ID: <20241004181828.3669209-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


