Return-Path: <stable+bounces-61616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1C93C52D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9554282D6E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E627473;
	Thu, 25 Jul 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCq1Eiow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C11E895;
	Thu, 25 Jul 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918886; cv=none; b=heJC4ZUCei+uEP/F0zwZt4/BNZbNo0WZs8L9uBiuG9q3joe76KCvTfOH12iKYkF3OeuR5mJ7TcLF+paaW8ICF1HJHsMn9LKeSHqarfHbBjwQbNNevDlyy7cL3WKb/8SBOAb4LfdjYT32IroQ78eTl0UjKMqdqSDtgd+AnRcGTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918886; c=relaxed/simple;
	bh=e0kijenlXyR2PoG2QRJaThN9nQxbVMoAKrkl4akH7Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaXt+WM2NsTkjmVRVjiC2Xqesfgg+vzkxr+iBgb+pjuzXvzDagCqFS+QieMzdRK7/jxdQuWKhyMseXV6NAuXwO6t6hff5HKv32QEuhH2iFzA++nSfgwyxMJ9kHBQGOLmePwY+zrmK1hsHl+t5Fkcy8XSygwCLyjHESa0bRp83bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tCq1Eiow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0631C116B1;
	Thu, 25 Jul 2024 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918886;
	bh=e0kijenlXyR2PoG2QRJaThN9nQxbVMoAKrkl4akH7Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCq1EiowJAX/hsI62jLIQFTtueSsExrIDNK6ditX2KYYjeBF0k0TuyHc78y5ZD5kD
	 D44P2t7pWBbB4XQlRHOK2YsElpXo6kpNLyGxRjyyiSbo8NP/SyXQV255cHI5itfmW/
	 fwjI4Ymln+ZzzkgkR5o7Bxj5jgLp8K0fYI3sWL+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 19/59] KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()
Date: Thu, 25 Jul 2024 16:37:09 +0200
Message-ID: <20240725142733.988967432@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142733.262322603@linuxfoundation.org>
References: <20240725142733.262322603@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit a986fa57fd81a1430e00b3c6cf8a325d6f894a63 ]

Al reported a possible use-after-free (UAF) in kvm_spapr_tce_attach_iommu_group().

It looks up `stt` from tablefd, but then continues to use it after doing
fdput() on the returned fd. After the fdput() the tablefd is free to be
closed by another thread. The close calls kvm_spapr_tce_release() and
then release_spapr_tce_table() (via call_rcu()) which frees `stt`.

Although there are calls to rcu_read_lock() in
kvm_spapr_tce_attach_iommu_group() they are not sufficient to prevent
the UAF, because `stt` is used outside the locked regions.

With an artifcial delay after the fdput() and a userspace program which
triggers the race, KASAN detects the UAF:

  BUG: KASAN: slab-use-after-free in kvm_spapr_tce_attach_iommu_group+0x298/0x720 [kvm]
  Read of size 4 at addr c000200027552c30 by task kvm-vfio/2505
  CPU: 54 PID: 2505 Comm: kvm-vfio Not tainted 6.10.0-rc3-next-20240612-dirty #1
  Hardware name: 8335-GTH POWER9 0x4e1202 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
  Call Trace:
    dump_stack_lvl+0xb4/0x108 (unreliable)
    print_report+0x2b4/0x6ec
    kasan_report+0x118/0x2b0
    __asan_load4+0xb8/0xd0
    kvm_spapr_tce_attach_iommu_group+0x298/0x720 [kvm]
    kvm_vfio_set_attr+0x524/0xac0 [kvm]
    kvm_device_ioctl+0x144/0x240 [kvm]
    sys_ioctl+0x62c/0x1810
    system_call_exception+0x190/0x440
    system_call_vectored_common+0x15c/0x2ec
  ...
  Freed by task 0:
   ...
   kfree+0xec/0x3e0
   release_spapr_tce_table+0xd4/0x11c [kvm]
   rcu_core+0x568/0x16a0
   handle_softirqs+0x23c/0x920
   do_softirq_own_stack+0x6c/0x90
   do_softirq_own_stack+0x58/0x90
   __irq_exit_rcu+0x218/0x2d0
   irq_exit+0x30/0x80
   arch_local_irq_restore+0x128/0x230
   arch_local_irq_enable+0x1c/0x30
   cpuidle_enter_state+0x134/0x5cc
   cpuidle_enter+0x6c/0xb0
   call_cpuidle+0x7c/0x100
   do_idle+0x394/0x410
   cpu_startup_entry+0x60/0x70
   start_secondary+0x3fc/0x410
   start_secondary_prolog+0x10/0x14

Fix it by delaying the fdput() until `stt` is no longer in use, which
is effectively the entire function. To keep the patch minimal add a call
to fdput() at each of the existing return paths. Future work can convert
the function to goto or __cleanup style cleanup.

With the fix in place the test case no longer triggers the UAF.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/all/20240610024437.GA1464458@ZenIV/
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240614122910.3499489-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c640053ab03f2..2686ba59873dd 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -117,14 +117,16 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 	rcu_read_unlock();
 
-	fdput(f);
-
-	if (!found)
+	if (!found) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	table_group = iommu_group_get_iommudata(grp);
-	if (WARN_ON(!table_group))
+	if (WARN_ON(!table_group)) {
+		fdput(f);
 		return -EFAULT;
+	}
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
 		struct iommu_table *tbltmp = table_group->tables[i];
@@ -145,8 +147,10 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			break;
 		}
 	}
-	if (!tbl)
+	if (!tbl) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -157,6 +161,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			/* stit is being destroyed */
 			iommu_tce_table_put(tbl);
 			rcu_read_unlock();
+			fdput(f);
 			return -ENOTTY;
 		}
 		/*
@@ -164,6 +169,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 		 * its KVM reference counter and can return.
 		 */
 		rcu_read_unlock();
+		fdput(f);
 		return 0;
 	}
 	rcu_read_unlock();
@@ -171,6 +177,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
 	if (!stit) {
 		iommu_tce_table_put(tbl);
+		fdput(f);
 		return -ENOMEM;
 	}
 
@@ -179,6 +186,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 
 	list_add_rcu(&stit->next, &stt->iommu_tables);
 
+	fdput(f);
 	return 0;
 }
 
-- 
2.43.0




