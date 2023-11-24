Return-Path: <stable+bounces-154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D57F73F8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE64B21234
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C815AEB;
	Fri, 24 Nov 2023 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V91EDKPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF628380
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13024C433C7;
	Fri, 24 Nov 2023 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700829711;
	bh=bALfqK9af1MHje9yC/nHp2CyYbUyq29g/KX4rIB0kQY=;
	h=Subject:To:Cc:From:Date:From;
	b=V91EDKPO2AX1IIZlcwnTCN51AeB8clo8RimXf0NSqx0coWfWLfbZBgEtOmr6avNGQ
	 JUrIXhcv9jBGDNxeT5wMx+B88xvxKf4/RtycfrXXgNDtXbEwdNPyLRz9s2G6ERMBSC
	 V+ORDsokBBgIC3uLJaZjL1+3J+t/wbtpAzMMrPJA=
Subject: FAILED: patch "[PATCH] MIPS: KVM: Fix a build warning about variable set but not" failed to apply to 6.5-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn,lkp@intel.com,philmd@linaro.org,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:41:29 +0000
Message-ID: <2023112429-closable-pardon-b0c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 83767a67e7b6a0291cde5681ec7e3708f3f8f877
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112429-closable-pardon-b0c4@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

83767a67e7b6 ("MIPS: KVM: Fix a build warning about variable set but not used")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83767a67e7b6a0291cde5681ec7e3708f3f8f877 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Oct 2023 16:54:34 +0800
Subject: [PATCH] MIPS: KVM: Fix a build warning about variable set but not
 used
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 7b2ac1319d70..467ee6b95ae1 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -592,7 +592,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -664,7 +664,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;


