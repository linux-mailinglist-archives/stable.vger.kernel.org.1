Return-Path: <stable+bounces-71400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6C96252C
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FBA1C20C4C
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20816F0C3;
	Wed, 28 Aug 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKc2QH8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFB16C859;
	Wed, 28 Aug 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841921; cv=none; b=lciWMAmmyZ9kk1hqx3YxXNegAFVgEMtOEsfw8uKomDZuBYKQPv/VfE2o/CPF9Y6jTeLbz80hXQxQNdyNxLRl0sgUgc7lbGqFqtIcrfNzlAFmtzrZIWC5iSZMM4CtD1aVDLWs54/eKogmzyxAYfOhmS9tNQQoCWuOdCPKjcaaNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841921; c=relaxed/simple;
	bh=zVVq8lGMMYi3w7cMOevAtDEAmpoH4K/bNxcygdGy8Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ6iVBmde1pPJaN+joWaalIIrzBWwV4me5xL+vmeAC/KR/Gm6fyGzi6eaW/zgZ0VVg10dUOWApM12BItJJG/e5NOPn6crxs6CEkM6L62Djr2Wsszp/di2zIjHqcAwYkjGZAlgE+amZhY8ebD8UJ50ZspAMgBmSNRIc8U1I1OTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKc2QH8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B45C98EC0;
	Wed, 28 Aug 2024 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841920;
	bh=zVVq8lGMMYi3w7cMOevAtDEAmpoH4K/bNxcygdGy8Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKc2QH8Icg1ORgy8TgXgcJmbcm2BTDYNMRf/MfQurVqwqb/trVYNxBCQf2oke2AFX
	 PmbBSWyZPkmhhDs8WeeO3w2N7hCBnGAf+7wDqHSEfhCQvN8xv/cNb+vSiaVhwMCBuI
	 vK0R9IOG9o6jx8gIGNasNjVaWD1FASssvk3yDdkd0aaVLuOQb0eyar+KsiWnfAPSO1
	 d3ub5vlGo1PgNN50UiNQDimSzR5M9xzkOsRiXTWANlrfhPtAKtF7x4XMywKysNmx2C
	 b1lbfHf7ZW9tUysc8C8GevhL4qv0skYvaOtSzwX4TGmvv5go/DC8Ss6fXw3VKIoT0l
	 FluUTLecTZFUw==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 4/6] x86/tdx: Add a restriction on access to MMIO address
Date: Wed, 28 Aug 2024 12:44:34 +0200
Message-ID: <b9b120f5615776d3f557c96e244e57c97ac7d9d4.1724837158.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724837158.git.legion@kernel.org>
References: <cover.1724248680.git.legion@kernel.org> <cover.1724837158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

For security reasons, access from kernel space to MMIO addresses in
userspace should be restricted. All MMIO operations from kernel space
are considered trusted and are not validated.

For instance, if in response to a syscall, kernel does put_user() and
the target address is MMIO mapping in userspace, current #VE handler
threat this access as kernel MMIO which is wrong and have security
implications.

Cc: stable@vger.kernel.org
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5d2d07aa08ce..65f65015238a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -411,6 +411,11 @@ static inline bool is_private_gpa(u64 gpa)
 	return gpa == cc_mkenc(gpa);
 }
 
+static inline bool is_kernel_addr(unsigned long addr)
+{
+	return (long)addr < 0;
+}
+
 static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
 {
 	unsigned int level;
@@ -606,6 +611,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
 	if (user_mode(regs)) {
-- 
2.46.0


