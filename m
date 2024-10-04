Return-Path: <stable+bounces-80961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52598990D43
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845E51C22CB2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D0207A1C;
	Fri,  4 Oct 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJcRTh7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6E207A19;
	Fri,  4 Oct 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066366; cv=none; b=lJu9L5SNV0YYtbdqrx4fksqvYtFalWFQ4h24+Ja34t/FRgXSUp+69s+M4d8XgReePSV3b4oQPTDVCBuGFjSkNiLSQHe8HHxgK8dRCnya0MTHxGzR+Ru7ualVXKDbncFl7dE6XdrtypUEulr5+4rtqUT1lWzcZljhHp51dILqnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066366; c=relaxed/simple;
	bh=tZXbtf8cxcUc3qmnQB62QU9cvNEJ2lM35QVK2NqbioA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBBOQOiU45s3LJaKYB3O4V8BmWub01ONfFQe7IN7l4nCXTiaQDiVbuk2dxN73ZmYJs0Ti24WviYayR3rIYMhlWge8cTn/u9h+t7thz83U9p9UcgWDgm7xa8rEn32jOhduc4tCu1pgD1wJADQlk0nZApq1bGlvWzkhY1IDHycDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJcRTh7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6191C4CECC;
	Fri,  4 Oct 2024 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066366;
	bh=tZXbtf8cxcUc3qmnQB62QU9cvNEJ2lM35QVK2NqbioA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJcRTh7fJ39j/xek7hCRJ6QnUYD/pSJ0xWv9MGf6Xyxco1Wr2+ThEGw8Fvclr9Pcf
	 DbcDdEBiEeXFef4UQRiaccMBvyMTl+tjobClMShZ2gwuiSdsT+a7N/GHU5XA+vcHzk
	 BHIGUc/x5IbYJOil8D4/AWiHOwFWS/4ZOjp8vZqdfS523hV53oZWdw+PFx5K4nOAnu
	 WUhb68J+zJhZGy/IJ1KpZTpOvovKOuoCAkUwaYLeoWnnGNMGe+g7jHtn1JmcRQTmh7
	 kx+t16GD4/9V8cSztCuNbQ4MV14pPMDoEW7iGHywLKckbPFMRFcDMBJqe+CU1kNbpz
	 JNJKSdEG+E+qg==
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
	kent.overstreet@linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 35/58] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown
Date: Fri,  4 Oct 2024 14:24:08 -0400
Message-ID: <20241004182503.3672477-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index e60fbd8660c4a..8c32bf1eedda0 100644
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


