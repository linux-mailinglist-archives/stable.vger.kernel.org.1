Return-Path: <stable+bounces-172281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010BB30D71
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9591C2443B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 04:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CD19D88F;
	Fri, 22 Aug 2025 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6RmuPoK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22F14A09C;
	Fri, 22 Aug 2025 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836134; cv=none; b=TQFIL1Mll0SIdQkQnSgNVhYmTt+biExZtN43DV/j3rwjeK1LnxCcsVvrvDDGCrUXyIlu7k5wAOB9ubt6TpZHcw3EiR5O+2HLM0dRX87Ko9VRtxOtRLq8ZwI64xEuoj3s0juspE+FP4ge84wjUSCyanB9iK4VngT6kqrCo3WtEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836134; c=relaxed/simple;
	bh=A0GL3Vdq+WZd6o1+ddSu+zVjBJnzZZwNj3g5IAqTNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kL89bgvu2zbjlnNGMGSXhgbEOMo0wfaLn5YdTFj3vtHytWGE89hc8p34qGmPMd4jkU4oAqQHTCvGf9RIG3Jim7BVc5BriqBzg80kswbP00q1hrebYYQnj6Du938CGAvBNeAkP6hwsrpy92imIwZCnremNvf1F+/MtHIyrdGKJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6RmuPoK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49c0c5f4dfso167589a12.1;
        Thu, 21 Aug 2025 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836131; x=1756440931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9PgfzlZAvSWVRluzRE+sTTXFHsSdjHEV58R22WBfMQ=;
        b=B6RmuPoKVerRdq4tLMQA8YvsJgaDRc9oGd84xGPfpg3xTayIBax5lIVf684RInMDXf
         OLKPqvQOGQjSFoZWwiVFWxCkJjT3EgDFkXYW+dond1vigGUsMGJpgVt5EmWQIsWMvtMb
         5hIWrhn88cXjIQ3RaMd5NUO2dV+Aa0G+vSbkx/p2ptgx7FymZJy0QWUIiOKUEtoWxVfi
         XPU9DwxUJIPLRAG6bo4HUEuf7uBHtMtSP1g/dwGRM41J0qotp1BEvA4YA87hykBuwVSy
         yJKu2Z3iywgEeK4CzHO1J7KjRFiIFzWBZqUIuUbHOZ5vszcwUHsBKkmI15ri6tUHMjYL
         n23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836131; x=1756440931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9PgfzlZAvSWVRluzRE+sTTXFHsSdjHEV58R22WBfMQ=;
        b=nOq5yPTPcJkZErmJrg6wnVxK9IbCfL3MgnqPyylPhNgCUBfKWbF+JcY0SBX3F862ZB
         LlMOLJ6KSwAKzljuvFeSMOcrsJihbOjl9T71SxEe7NJ1S26ran/h7hoQc3iashs2O8Qv
         MQ23TtKc/5zhPWLhulSR3RElXLgJg841OduB4k8QLLNZ24QLW15s54dAHSiTBobTzea+
         VwBrnWytqLzq594Dg/MyakPJzNUEimpoVf8EWR1+8n2LjbxVAL8aVAAWxeiiPYZ2pPnQ
         Kg2UwW4e6E66W8JvOdg8ABoNRjf17U90qwVAP5f89C2kTzEdKzdSSMv0FJTJr3fBiF23
         t0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD62tD/W22IRkFN8t5LclvT3c6x1i8/DC/MaSjS9oXY7uydg8gcUxXQ7gdnQejtKHaJrj73b01xIUuaFE=@vger.kernel.org, AJvYcCWK6pMqnkAdMlS29/OQBs8cy0JYnggvE10i+qCr9gMxke50RjoP1ialNL1xxdBLWAOKfWOKjZou@vger.kernel.org
X-Gm-Message-State: AOJu0YwPozgYIrKXqJbFBZe6Tjb8OafPqNHlz2rN6ig3nUAj6/T9E4aT
	Kk8UDiB0LNXIpo1NjdEbZDTLbacpbfoTVTB6MYUqjKyhqvvnJsdyWnDLvxqC3R7KkK0=
X-Gm-Gg: ASbGncv/QbTo6FBog2WIEE4cm4o52Kjpfgq4kNuEzP3zu7MiVnMoyUgkyB1oC2R2SU2
	Oz9SjDFiVA686f+F8oh8nwpwmrdnSiBWtl4NQMMMgcLcPY38tbThqm3WfyviCPKog34yXQ+svx2
	8UcK68nsDJxGGGZFZrFvX5Kkz/HhP5fcs14J20EdOWH8P7Med8XW5pWpcEdTuzuIph5w8JkHLdv
	h9IGCbsTrJB1j6Kx+ZZ5tbuh0IuEyLdNM7XnA5Vi71LbGsJpJsGXTeFf8pl/TZU+NxeHzDltggw
	Lfw87BZFMy3Aa/TC0LYQkrpPavP5GRDJipk0+tu0KtDa2cuGZvcUMdlyMuaP3WIfFkU1DiHqVXK
	LrH5ee+wuiNQhAAEeP5V6G+9PaZ7PgJ2BiHn0h+R0CG+2jvYu4uuXmFQJgi5resM8BClQnfOc
X-Google-Smtp-Source: AGHT+IF2iOxGEWh6lnAwzbIYm3vEYhNMhGnrxwiHW2mktl6Jf+S+uzXvJvANfSUHzslgaQzZWAH6DQ==
X-Received: by 2002:a17:903:2282:b0:242:abc2:7f1e with SMTP id d9443c01a7336-2462ee02c31mr22915745ad.22.1755836130612;
        Thu, 21 Aug 2025 21:15:30 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:ba38:b533:dcf5:1e7a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325123e4751sm1189587a91.1.2025.08.21.21.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:15:30 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
Date: Thu, 21 Aug 2025 21:15:26 -0700
Message-ID: <20250822041526.467434-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In early boot, Linux creates identity virtual->physical address mappings
so that it can enable the MMU before full memory management is ready.
To ensure some available physical memory to back these structures,
vmlinux.lds reserves some space (and defines marker symbols) in the
middle of the kernel image. However, because they are defined outside of
PROGBITS sections, they aren't pre-initialized -- at least as far as ELF
is concerned.

In the typical case, this isn't actually a problem: the boot image is
prepared with objcopy, which zero-fills the gaps, so these structures
are incidentally zero-initialized (an all-zeroes entry is considered
absent, so zero-initialization is appropriate).

However, that is just a happy accident: the `vmlinux` ELF output
authoritatively represents the state of memory at entry. If the ELF
says a region of memory isn't initialized, we must treat it as
uninitialized. Indeed, certain bootloaders (e.g. Broadcom CFE) ingest
the ELF directly -- sidestepping the objcopy-produced image entirely --
and therefore do not initialize the gaps. This results in the early boot
code crashing when it attempts to create identity mappings.

Therefore, add boot-time zero-initialization for the following:
- __pi_init_idmap_pg_dir..__pi_init_idmap_pg_end
- idmap_pg_dir
- reserved_pg_dir
- tramp_pg_dir # Already done, but this patch corrects the size

Note, swapper_pg_dir is already initialized (by copy from idmap_pg_dir)
before use, so this patch does not need to address it.

Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/kernel/head.S | 12 ++++++++++++
 arch/arm64/mm/mmu.c      |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ca04b338cb0d..0c3be11d0006 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -86,6 +86,18 @@ SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
 
+	adrp	x0, reserved_pg_dir
+	add	x1, x0, #PAGE_SIZE
+0:	str	xzr, [x0], 8
+	cmp	x0, x1
+	b.lo	0b
+
+	adrp	x0, __pi_init_idmap_pg_dir
+	adrp	x1, __pi_init_idmap_pg_end
+1:	str	xzr, [x0], 8
+	cmp	x0, x1
+	b.lo	1b
+
 	adrp	x1, early_init_stack
 	mov	sp, x1
 	mov	x29, xzr
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..aaf823565a65 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -761,7 +761,7 @@ static int __init map_entry_trampoline(void)
 	pgprot_val(prot) &= ~PTE_NG;
 
 	/* Map only the text into the trampoline page table */
-	memset(tramp_pg_dir, 0, PGD_SIZE);
+	memset(tramp_pg_dir, 0, PAGE_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
 			     entry_tramp_text_size(), prot,
 			     pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPINGS);
@@ -806,6 +806,7 @@ static void __init create_idmap(void)
 	u64 end   = __pa_symbol(__idmap_text_end);
 	u64 ptep  = __pa_symbol(idmap_ptes);
 
+	memset(idmap_pg_dir, 0, PAGE_SIZE);
 	__pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
 		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
 		       __phys_to_virt(ptep) - ptep);
-- 
2.49.1


