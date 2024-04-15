Return-Path: <stable+bounces-39502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CE8A51E3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EC4285420
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA576033;
	Mon, 15 Apr 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMz9AXXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FC1C69D
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188319; cv=none; b=tUiY7Usw+lgeq/ZLCpMjhpnKmyHIdNSGsD/pj8m7jkWPxvJwHaVQLVqjFOXtad1pYBSs/T3bZs7jOWu8RH/5yEBA2n1pjDS1vR4BO1uOxR29HGjNt6JmHnr4Pki1NnzgbxZvw7dA7w+G8dt3VH3wXgQX0wiiZez4XcI8+Gi2deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188319; c=relaxed/simple;
	bh=GiEjcePh12cU+sOL3/Sz2lJ/zz/7uOW09gBcjy8GUgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0yd1yzx4fjTCb0krojUkqYUYS7vLDwBgrsfY4DGoRGzpyJHaWTT3IKE3EuLAYXiJAS8mxSMN9x4/AiyWQ/JqTzaPzKRIDnxcmglTspeLtew8qt51Vf48yyZjA1UpN1rBRGKY2x/EMn6Th2jGOyxLf0QCMGaHBDbGUVAyvFChs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMz9AXXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD73C3277B;
	Mon, 15 Apr 2024 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188318;
	bh=GiEjcePh12cU+sOL3/Sz2lJ/zz/7uOW09gBcjy8GUgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMz9AXXP+TVUd3KPlKzMhNrKU360Gw/8EdpppPlttt2wwLjn11jjiooJUC6m6b7Tm
	 gBd59jUViYnSc9z723XMpNePO/6cxhKMVO3mIXTF5GsQjgBC4O0RAaFJShhA4ee1oa
	 ypzH5ludpaeIyrpSbBLQhM6kxgbeQeP8BmXFe+BQ23v0hVKV9R3IhpBHku6VMotByy
	 i1Qyj4Nz/F3WqZRgolOkdN/Fl3Zl4HMM+jM28flQF3Z1Vk5Z8RYwEOpJiamdnoUyRY
	 RKgp3hMjU3urHVsdW131y5LYHPo1dlotCb/UP7psCP0nJncjrPq1cUJEyRGZlI8FXV
	 0DqVyf4SYoEBA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 021/190] MIPS: KVM: Fix a build warning about variable set but not used
Date: Mon, 15 Apr 2024 06:49:11 -0400
Message-ID: <20240415105208.3137874-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index ee64db0327933..0ed17805dfe4c 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -701,7 +701,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -774,7 +774,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;
-- 
2.43.0


