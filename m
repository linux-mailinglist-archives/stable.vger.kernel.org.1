Return-Path: <stable+bounces-56319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA291F051
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BFA1C21B8D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AE13D61A;
	Tue,  2 Jul 2024 07:36:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649274047
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905766; cv=none; b=irTZIunEj+BuooPwG2sjOX0ff7+YJvetjoF+Cdi6aP1x3bBMNFi6bPm1EuNyDgCp/b01oFtyFfSHDtJFXJi031hqrgUTERBN8SgpDiOuc/6AVHTLqXlyr9Dzztfuil0TSeuFFrUeklqUR8JDSu0jf8Tt2c1rYf6DvKp1o8HprvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905766; c=relaxed/simple;
	bh=Erb47PsTQcQJPbvv0daIhSjhyCzxZolPWjgN0ownyc0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A6q+ZwNkoCBfj6pr8lkV2vhmCXIMQI3YB+CGt1oyO92Vl2YxTx806tfY6u4dX6K1D3T2R1c3wH+9pgaYr30sGMIECzxLph56uXPhm5D6twJwnboOQtl2fXngQYh1EqxMV2tegJmmLOe9DleXI3I6aS9kx1XToFJ3Z+nAUyObhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCvmv6PwzzdZLV;
	Tue,  2 Jul 2024 15:34:23 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EBE518009B;
	Tue,  2 Jul 2024 15:36:00 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jul 2024 15:35:59 +0800
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully
 initialized
To: Leah Rumancik <leah.rumancik@gmail.com>
CC: Thorvald Natvig <thorvald@google.com>, Jane Chu <jane.chu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, Muchun Song <muchun.song@linux.dev>, Oleg Nesterov
	<oleg@redhat.com>, Peng Zhang <zhangpeng.00@bytedance.com>, Tycho Andersen
	<tandersen@netflix.com>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
References: <20240702042948.2629267-1-leah.rumancik@gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <70af466d-0d0b-b984-a4af-b60d3e11856e@huawei.com>
Date: Tue, 2 Jul 2024 15:35:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702042948.2629267-1-leah.rumancik@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/2 12:29, Leah Rumancik wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 upstream.
> 
> Thorvald reported a WARNING [1]. And the root cause is below race:
> 
>  CPU 1					CPU 2
>  fork					hugetlbfs_fallocate
>   dup_mmap				 hugetlbfs_punch_hole
>    i_mmap_lock_write(mapping);
>    vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
>    i_mmap_unlock_write(mapping);
>    hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
> 					 i_mmap_lock_write(mapping);
>    					 hugetlb_vmdelete_list
> 					  vma_interval_tree_foreach
> 					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
>    tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
> 					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
> 					 i_mmap_unlock_write(mapping);
> 
> hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
> i_mmap_rwsem lock while vma lock can be used in the same time.  Fix this
> by deferring linking file vma until vma is fully initialized.  Those vmas
> should be initialized first before they can be used.
> 
> Backport notes:
> 
> The first backport attempt (cec11fa2e) was reverted (dd782da4707). This is
> the new backport of the original fix (35e351780fa9).
> 
> 35e351780f ("fork: defer linking file vma until vma is fully initialized")
> fixed a hugetlb locking race by moving a bunch of intialization code to earlier
> in the function. The call to open() was included in the move but the call to
> copy_page_range was not, effectively inverting their relative ordering. This
> created an issue for the vfio code which assumes copy_page_range happens before
> the call to open() - vfio's open zaps the vma so that the fault handler is
> invoked later, but when we inverted the ordering, copy_page_range can set up
> mappings post-zap which would prevent the fault handler from being invoked
> later. This patch moves the call to copy_page_range to earlier than the call to
> open() to restore the original ordering of the two functions while keeping the
> fix for hugetlb intact.

Thanks for your update!

> 
> Commit aac6db75a9 made several changes to vfio_pci_core.c, including
> removing the vfio-pci custom open function. This resolves the issue on
> the main branch and so we only need to apply these changes when
> backporting to stable branches.
> 
> 35e351780f ("fork: defer linking file vma until vma is fully initialized")-> v6.9-rc5
> aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") -> v6.10-rc4
> 
> Link: https://lkml.kernel.org/r/20240410091441.3539905-1-linmiaohe@huawei.com
> Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reported-by: Thorvald Natvig <thorvald@google.com>
> Closes: https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/ [1]
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> Cc: Tycho Andersen <tandersen@netflix.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  kernel/fork.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 177ce7438db6..122d2cd124d5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -727,6 +727,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		} else if (anon_vma_fork(tmp, mpnt))
>  			goto fail_nomem_anon_vma_fork;
>  		vm_flags_clear(tmp, VM_LOCKED_MASK);
> +		/*
> +		 * Copy/update hugetlb private vma information.
> +		 */
> +		if (is_vm_hugetlb_page(tmp))
> +			hugetlb_dup_vma_private(tmp);
> +
> +		if (!(tmp->vm_flags & VM_WIPEONFORK) &&
> +				copy_page_range(tmp, mpnt))
> +			goto fail_nomem_vmi_store;
> +
> +		if (tmp->vm_ops && tmp->vm_ops->open)
> +			tmp->vm_ops->open(tmp);
> +
>  		file = tmp->vm_file;
>  		if (file) {
>  			struct address_space *mapping = file->f_mapping;
> @@ -743,25 +756,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			i_mmap_unlock_write(mapping);
>  		}
>  
> -		/*
> -		 * Copy/update hugetlb private vma information.
> -		 */
> -		if (is_vm_hugetlb_page(tmp))
> -			hugetlb_dup_vma_private(tmp);
> -
>  		/* Link the vma into the MT */
>  		if (vma_iter_bulk_store(&vmi, tmp))
>  			goto fail_nomem_vmi_store;
>  
>  		mm->map_count++;
> -		if (!(tmp->vm_flags & VM_WIPEONFORK))
> -			retval = copy_page_range(tmp, mpnt);

I have a vague memory that copy_page_range should be called after vma is inserted into the i_mmap tree.
Or there might be a problem:

dup_mmap			remove_migration_ptes
 copy_page_range -- Child process copys migration entry from parent
				 rmap_walk
				  rmap_walk_file
				   i_mmap_lock_read(mapping);
				   vma_interval_tree_foreach
				    remove_migration_pte -- The vma of child process is still invisible
				    So migration entry lefts in the child process's address space.
				   i_mmap_unlock_read(mapping);
 i_mmap_lock_write(mapping);
 vma_interval_tree_insert_after
  -- To late! Child process has stale migration entry left while migration is already done!
 i_mmap_unlock_write(mapping);
				
But I'm not really sure. I might miss something.
Thanks.
.


