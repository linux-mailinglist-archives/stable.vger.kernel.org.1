Return-Path: <stable+bounces-104869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE29F5381
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513AA1885460
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8C1F76D5;
	Tue, 17 Dec 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4PzO1TI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B0140E38;
	Tue, 17 Dec 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456352; cv=none; b=uYW98drJcSBZ7EWuhhJygo+UMYeNRuYuD52GEgIEdCD6ieaktVVBziGy/G7nD2tUn1QA9p0rsyYFDnYy37z6u4zISaK8Ajqcgd6bjwfD8XpejJAsI+iAB6YT/Z17oRXnPJ3WTfAWkXsc7d/MFxryFUPCDcYoN4+5DgqzaaS6G4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456352; c=relaxed/simple;
	bh=yflmg/VCgXKErQ9RaER1xqEHTBqkLzd3t1OR5RrcFf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg5NhhwFYZUr8q2F4AEYYSGCl//L13g7uPzD61bxt0HjAnnpFFfgD3Utu7bSieyPDvAcTFspNUFD1mPcFnU94W3+5ec6s46aasT/uPMSJzLC40tp9lMpeIBuiqGYZBoeVVVyLwDogG85eFsFGs8aTfVMV/kQKOZ8JcQsTu78cYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4PzO1TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5BCC4CED3;
	Tue, 17 Dec 2024 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456351;
	bh=yflmg/VCgXKErQ9RaER1xqEHTBqkLzd3t1OR5RrcFf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4PzO1TIcYwKBLeIzX/JibVRVA5B8dINHH6QcTELsndsJm4a2BqdtNEoLpCBItrbK
	 0PS9pC+fFb4p3IdgTFzZFaF3isBxcjHNjxRZSrRL5CtfQs7wRiXMrIcD883rZvKtNd
	 jQWROobXO7cP+gcjxOQZZFtp6hjOUToyPujeqqMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.12 014/172] riscv: mm: Do not call pmd dtor on vmemmap page table teardown
Date: Tue, 17 Dec 2024 18:06:10 +0100
Message-ID: <20241217170546.841263160@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

commit 21f1b85c8912262adf51707e63614a114425eb10 upstream.

The vmemmap's, which is used for RV64 with SPARSEMEM_VMEMMAP, page
tables are populated using pmd (page middle directory) hugetables.
However, the pmd allocation is not using the generic mechanism used by
the VMA code (e.g. pmd_alloc()), or the RISC-V specific
create_pgd_mapping()/alloc_pmd_late(). Instead, the vmemmap page table
code allocates a page, and calls vmemmap_set_pmd(). This results in
that the pmd ctor is *not* called, nor would it make sense to do so.

Now, when tearing down a vmemmap page table pmd, the cleanup code
would unconditionally, and incorrectly call the pmd dtor, which
results in a crash (best case).

This issue was found when running the HMM selftests:

  | tools/testing/selftests/mm# ./test_hmm.sh smoke
  | ... # when unloading the test_hmm.ko module
  | page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10915b
  | flags: 0x1000000000000000(node=0|zone=1)
  | raw: 1000000000000000 0000000000000000 dead000000000122 0000000000000000
  | raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
  | page dumped because: VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte)
  | ------------[ cut here ]------------
  | kernel BUG at include/linux/mm.h:3080!
  | Kernel BUG [#1]
  | Modules linked in: test_hmm(-) sch_fq_codel fuse drm drm_panel_orientation_quirks backlight dm_mod
  | CPU: 1 UID: 0 PID: 514 Comm: modprobe Tainted: G        W          6.12.0-00982-gf2a4f1682d07 #2
  | Tainted: [W]=WARN
  | Hardware name: riscv-virtio qemu/qemu, BIOS 2024.10 10/01/2024
  | epc : remove_pgd_mapping+0xbec/0x1070
  |  ra : remove_pgd_mapping+0xbec/0x1070
  | epc : ffffffff80010a68 ra : ffffffff80010a68 sp : ff20000000a73940
  |  gp : ffffffff827b2d88 tp : ff6000008785da40 t0 : ffffffff80fbce04
  |  t1 : 0720072007200720 t2 : 706d756420656761 s0 : ff20000000a73a50
  |  s1 : ff6000008915cff8 a0 : 0000000000000039 a1 : 0000000000000008
  |  a2 : ff600003fff0de20 a3 : 0000000000000000 a4 : 0000000000000000
  |  a5 : 0000000000000000 a6 : c0000000ffffefff a7 : ffffffff824469b8
  |  s2 : ff1c0000022456c0 s3 : ff1ffffffdbfffff s4 : ff6000008915c000
  |  s5 : ff6000008915c000 s6 : ff6000008915c000 s7 : ff1ffffffdc00000
  |  s8 : 0000000000000001 s9 : ff1ffffffdc00000 s10: ffffffff819a31f0
  |  s11: ffffffffffffffff t3 : ffffffff8000c950 t4 : ff60000080244f00
  |  t5 : ff60000080244000 t6 : ff20000000a73708
  | status: 0000000200000120 badaddr: ffffffff80010a68 cause: 0000000000000003
  | [<ffffffff80010a68>] remove_pgd_mapping+0xbec/0x1070
  | [<ffffffff80fd238e>] vmemmap_free+0x14/0x1e
  | [<ffffffff8032e698>] section_deactivate+0x220/0x452
  | [<ffffffff8032ef7e>] sparse_remove_section+0x4a/0x58
  | [<ffffffff802f8700>] __remove_pages+0x7e/0xba
  | [<ffffffff803760d8>] memunmap_pages+0x2bc/0x3fe
  | [<ffffffff02a3ca28>] dmirror_device_remove_chunks+0x2ea/0x518 [test_hmm]
  | [<ffffffff02a3e026>] hmm_dmirror_exit+0x3e/0x1018 [test_hmm]
  | [<ffffffff80102c14>] __riscv_sys_delete_module+0x15a/0x2a6
  | [<ffffffff80fd020c>] do_trap_ecall_u+0x1f2/0x266
  | [<ffffffff80fde0a2>] _new_vmalloc_restore_context_a0+0xc6/0xd2
  | Code: bf51 7597 0184 8593 76a5 854a 4097 0029 80e7 2c00 (9002) 7597
  | ---[ end trace 0000000000000000 ]---
  | Kernel panic - not syncing: Fatal exception in interrupt

Add a check to avoid calling the pmd dtor, if the calling context is
vmemmap_free().

Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20241120131203.1859787-1-bjorn@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/mm/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..fc53ce748c80 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1566,7 +1566,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
 {
 	struct page *page = pud_page(*pud);
 	struct ptdesc *ptdesc = page_ptdesc(page);
@@ -1579,7 +1579,8 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	pagetable_pmd_dtor(ptdesc);
+	if (!is_vmemmap)
+		pagetable_pmd_dtor(ptdesc);
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
@@ -1703,7 +1704,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp);
+			free_pmd_table(pmd_base, pudp, is_vmemmap);
 	}
 }
 
-- 
2.47.1




