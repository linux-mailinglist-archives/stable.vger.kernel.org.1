Return-Path: <stable+bounces-4572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146480480C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B2C1C20E5C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB728C03;
	Tue,  5 Dec 2023 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KdXZSZFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE946FB0;
	Tue,  5 Dec 2023 03:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DBAC433C8;
	Tue,  5 Dec 2023 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747917;
	bh=n8CstkhU6HB2EGidkZxyCVMWm8Bf21DmYKaCH1dh95g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdXZSZFCr4lIQqaVcWMCS5EOAfcCFecDnB37F7kEsGS8vU4tqeaMFOhEpZJirsghe
	 b6lUL/ue+5KOEgU9E+CSbRnA1jm8dBxRTI9rfysrLfWfcs+xQ8Gkq3QL4xch2yxtCg
	 hwVl4Zd5E3W8mdQD7eACpfFvhZ0NTn2fndEDXp9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 22/94] MIPS: KVM: Fix a build warning about variable set but not used
Date: Tue,  5 Dec 2023 12:16:50 +0900
Message-ID: <20231205031524.159179849@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 83767a67e7b6a0291cde5681ec7e3708f3f8f877 ]

After commit 411740f5422a ("KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU")
old_pte is no longer used in kvm_mips_map_page(). So remove it to fix a
build warning about variable set but not used:

   arch/mips/kvm/mmu.c: In function 'kvm_mips_map_page':
>> arch/mips/kvm/mmu.c:701:29: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
     701 |         pte_t *ptep, entry, old_pte;
         |                             ^~~~~~~

Cc: stable@vger.kernel.org
Fixes: 411740f5422a960 ("KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310070530.aARZCSfh-lkp@intel.com/
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kvm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97f63a84aa51f..8a5f666d34c81 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -693,7 +693,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -766,7 +766,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;
-- 
2.42.0




