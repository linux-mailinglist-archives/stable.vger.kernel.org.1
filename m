Return-Path: <stable+bounces-70418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239DC960E01
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2AA1F22784
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F61C579D;
	Tue, 27 Aug 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ei8ce8fE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25119EEA2;
	Tue, 27 Aug 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769835; cv=none; b=ju1kP8oi+KgKEr3A9W2V6ZkG9/a80hLiN8O5k9OpxqWlRZtcQkemsONfNt5LzCthxnAjA0xWJ2TzBNYEvngIeEC/uPF+/PEndohf6pPlV5oZ+Nz3/HPHG82stW7L6UoFawh0jBXeEGDMzqVKKt4SKqScawoHB5HfEqQ+wx0bKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769835; c=relaxed/simple;
	bh=VQKeQjGJ39gt29xD3hT00OxW/ZsQ5TEVMF5hZPU7FBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkDmE91ozldTGxDq9KRZJwMWIf9cG7kAFvFZamuvdFwubnnNdDMCsS0qScyoTg2HW8nmwD6cdmFfhW73Q28V/wzEE/iFPM3YaCYi+ob8dW+6VFETf6Z9pcL8wByhxvRc2+yy5Ey6EypCbngqds2RtB/jlulncRI8TABJqpNvfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ei8ce8fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9593AC61053;
	Tue, 27 Aug 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769835;
	bh=VQKeQjGJ39gt29xD3hT00OxW/ZsQ5TEVMF5hZPU7FBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ei8ce8fEmUDhNlrlL55QmF3vW2hdpsb8DvXEuZy6GPP7oW/mgUoL9V292dfVwXV7+
	 /oCNwu47BpmKMXXN+dgpFiqPXjFEDaza+sI0Axa1zS7bPciZ4sptFX4ntu6QoZUDo7
	 GYSW6XIwFI0lBpKU5QQkCN0kJ6eVi6j/9CY1dlTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.6 018/341] riscv: change XIPs kernel_map.size to be size of the entire kernel
Date: Tue, 27 Aug 2024 16:34:09 +0200
Message-ID: <20240827143844.098458235@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Nam Cao <namcao@linutronix.de>

commit 57d76bc51fd80824bcc0c84a5b5ec944f1b51edd upstream.

With XIP kernel, kernel_map.size is set to be only the size of data part of
the kernel. This is inconsistent with "normal" kernel, who sets it to be
the size of the entire kernel.

More importantly, XIP kernel fails to boot if CONFIG_DEBUG_VIRTUAL is
enabled, because there are checks on virtual addresses with the assumption
that kernel_map.size is the size of the entire kernel (these checks are in
arch/riscv/mm/physaddr.c).

Change XIP's kernel_map.size to be the size of the entire kernel.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org> # v6.1+
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240508191917.2892064-1-namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/mm/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -912,7 +912,7 @@ static void __init create_kernel_page_ta
 				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
-	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
+	end_va = kernel_map.virt_addr + kernel_map.size;
 	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
@@ -1081,7 +1081,7 @@ asmlinkage void __init setup_vm(uintptr_
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
-	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
+	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else



