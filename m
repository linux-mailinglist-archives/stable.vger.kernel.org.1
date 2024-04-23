Return-Path: <stable+bounces-40700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC08AE7A0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE7A1C23512
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD10126F10;
	Tue, 23 Apr 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQuyq/01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD2134427
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877829; cv=none; b=hJX5ajghs0SNySWiGvZZ4jdY7XRoFXzzwe7kALZw21ONKtI5oaoSRnUeroYP7lBwldUdRUEnKCVJHukDH8tEo6oCjIDeah7ERH7IDtyFNut/VmLSO5TbFgDiNKYJLBzQQoYn989P9+SSK4NgCIhY0rmvcR8kJFLZFW0qxWdXFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877829; c=relaxed/simple;
	bh=fmrz6UDnel8j05vui1cQvEaAnu3YYxQM59P6HYl8DiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sJXyI1gyxMckBU0iudK8mWiOT+asVWr/94mcEWsPFiAHqk9/N+6kx9gNpA8CHNWTWHF/b2ujFULimbsOkLmheInnPV4eAWIDDw8RJl/9FGDkqyCgw3sICQ4kUcCIKk4yec13jb3fEdfWpaU2WDnvX2oOzBIqoPnHMYFQ2bRCRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQuyq/01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E2DC116B1;
	Tue, 23 Apr 2024 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877829;
	bh=fmrz6UDnel8j05vui1cQvEaAnu3YYxQM59P6HYl8DiQ=;
	h=Subject:To:Cc:From:Date:From;
	b=RQuyq/01KK3hjejlGG8StW6vBzKjlMYVgj/CvrMAsyZ/KtnaaoqdAfxrUK8UAPbL1
	 oYDOigNdbwEd1gvJ9axG+D3rkEwPJACaYcvJnOy52UVtOAr8vyAHlk2p+VnqYWKFik
	 Chcy3t63IARPDfEXlSDTKOOyrxS5aBOH7cfv490o=
Subject: FAILED: patch "[PATCH] fork: defer linking file vma until vma is fully initialized" failed to apply to 6.6-stable tree
To: linmiaohe@huawei.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,brauner@kernel.org,hca@linux.ibm.com,jane.chu@oracle.com,kent.overstreet@linux.dev,mjguzik@gmail.com,muchun.song@linux.dev,oleg@redhat.com,stable@vger.kernel.org,tandersen@netflix.com,thorvald@google.com,willy@infradead.org,zhangpeng.00@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:10:19 -0700
Message-ID: <2024042319-freeing-degree-ca0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 35e351780fa9d8240dd6f7e4f245f9ea37e96c19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042319-freeing-degree-ca0d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Wed, 10 Apr 2024 17:14:41 +0800
Subject: [PATCH] fork: defer linking file vma until vma is fully initialized

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

diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..aebb3e6c96dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -714,6 +714,23 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
+
+		mm->map_count++;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -730,25 +747,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		/*
-		 * Link the vma into the MT. After using __mt_dup(), memory
-		 * allocation is not necessary here, so it cannot fail.
-		 */
-		vma_iter_bulk_store(&vmi, tmp);
-
-		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		if (retval) {
 			mpnt = vma_next(&vmi);
 			goto loop_out;


