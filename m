Return-Path: <stable+bounces-42383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F3A8B72BC
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98A31C23133
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37DD12D1E8;
	Tue, 30 Apr 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PChNFFQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1F8801;
	Tue, 30 Apr 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475490; cv=none; b=qCETvDiWncTDwVRSF8Nqk29AWbK2AMVR7aYKfiIlJntexvhlmf4EIXUhkuYXZRGRl+sUZxBwBYTon/BGxHiE5fJI7I/DnOvnOXl552iqCVHfs2fbFpIWXDHnQTyftGXzATNkQmltYCytWVCg8kfG0dH1P7FG8no/GviYRNiPKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475490; c=relaxed/simple;
	bh=Ak2rZDxDOqze2OA7sGtfRJ1rQuuYPdFxNl/68+UAGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q77WoZC0+naH/pknMpSPUN+nB8ZtlKzAU1f3NVvFe4pNbNIM4taoQgbjS45ODF4/JDqlLcHfVU4LKrumr7fqIN1pb35hws4ymxROjUNYXrO3hvh76hrcb2pkgW9LhIvyXD2okQBzTc5CO5gnDyDN+PW3lngXz6GARloMiJ/8u6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PChNFFQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A482CC4AF19;
	Tue, 30 Apr 2024 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475490;
	bh=Ak2rZDxDOqze2OA7sGtfRJ1rQuuYPdFxNl/68+UAGb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PChNFFQf+raGh0E6qfMr9V+ImtUbQ0e9B5+QvJx4rvgKID7PSkNI73V+D/8VsE5BR
	 bxbsWRTiQHj2xmUFwd0IOCpSXXjFin+x+bN7Jv5busbu/xMHiE05a2PvK8fP6z7MrP
	 532yEc6kq+N/cwmTGTUyvphCCNTRKPmFIt2heTj8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thorvald Natvig <thorvald@google.com>,
	Jane Chu <jane.chu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 110/186] fork: defer linking file vma until vma is fully initialized
Date: Tue, 30 Apr 2024 12:39:22 +0200
Message-ID: <20240430103101.226378191@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

From: Miaohe Lin <linmiaohe@huawei.com>

commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 upstream.

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
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fork.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -727,6 +727,15 @@ static __latent_entropy int dup_mmap(str
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
@@ -743,12 +752,6 @@ static __latent_entropy int dup_mmap(str
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
@@ -757,9 +760,6 @@ static __latent_entropy int dup_mmap(str
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		if (retval)
 			goto loop_out;
 	}



