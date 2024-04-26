Return-Path: <stable+bounces-41500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F348B323C
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112EAB23E15
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11713AD04;
	Fri, 26 Apr 2024 08:22:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884E32182
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119731; cv=none; b=UhA5kYuzTNb+C/n7/pynX187VR4YEzmXhRbnVsA3sugvfHZ0avXnrPhUy2CfIvag70u4c0fXnXETZnMDNPuENE9SdhWu1ezu8XqCSfbDwOOzYPwQ64Ky/vw6l8X2E6MxPki//rskzw505UKfhOeM0NpT+qOWTUkZ4IpcmOiMq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119731; c=relaxed/simple;
	bh=ezA1pcFRSLj9tQL2+cnMG7fjnB09VXTRHT4cRLlJH7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBDs2SqHTNHPt5Feo0nC1bFa610M/yiuGimWHgt5vqyaMJCqPVh+vjM5on+xCWs+RrJYnAOklGbWErxAVRpjbtqWDlt3ny51gHZS4mvnw0S2Q1FT1SIqQ9Rk711ZlyhqNUnO6aTMBmYX/DkTazY8pknlCB/93xvhSOPh4tfmJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VQlzW6jrnz1HBjN;
	Fri, 26 Apr 2024 16:20:55 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 662F61400DD;
	Fri, 26 Apr 2024 16:21:59 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 16:21:58 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, Thorvald Natvig <thorvald@google.com>,
	Jane Chu <jane.chu@oracle.com>, Christian Brauner <brauner@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Mateusz Guzik
	<mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Muchun Song
	<muchun.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, Peng Zhang
	<zhangpeng.00@bytedance.com>, Tycho Andersen <tandersen@netflix.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] fork: defer linking file vma until vma is fully initialized
Date: Fri, 26 Apr 2024 16:18:30 +0800
Message-ID: <20240426081830.2416341-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024042319-freeing-degree-ca0d@gregkh>
References: <2024042319-freeing-degree-ca0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

Thorvald reported a WARNING [1]. And the root cause is below race:

 CPU 1					CPU 2
 fork					hugetlbfs_fallocate
  dup_mmap				 hugetlbfs_punch_hole
   i_mmap_lock_write(mapping);
   vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
   i_mmap_unlock_write(mapping);
   hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
					 i_mmap_lock_write(mapping);
   					 hugetlb_vmdelete_list
					  vma_interval_tree_foreach
					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
   tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
					 i_mmap_unlock_write(mapping);

hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
i_mmap_rwsem lock while vma lock can be used in the same time.  Fix this
by deferring linking file vma until vma is fully initialized.  Those vmas
should be initialized first before they can be used.

Link: https://lkml.kernel.org/r/20240410091441.3539905-1-linmiaohe@huawei.com
Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reported-by: Thorvald Natvig <thorvald@google.com>
Closes: https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/ [1]
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Tycho Andersen <tandersen@netflix.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/fork.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 177ce7438db6..2eab916b504b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -727,6 +727,15 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -743,12 +752,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
 		/* Link the vma into the MT */
 		if (vma_iter_bulk_store(&vmi, tmp))
 			goto fail_nomem_vmi_store;
@@ -757,9 +760,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		if (retval)
 			goto loop_out;
 	}
-- 
2.33.0


