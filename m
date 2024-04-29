Return-Path: <stable+bounces-41630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874F8B5611
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3611C20A9A
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08533C482;
	Mon, 29 Apr 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kmkwmsoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B04BA2E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388987; cv=none; b=jCcX6oeq5Cu15DBFdXgsyFwzSuIQDyg7FebK7KEZ/9dPHfsqqoVWNTUzSwdSXfAOkNVprbDMs/0OkVFif1QF5kEhuFASqft0zDzvuUxXKH4VmBBkiSY1nLT/lVQeI+fRkIGdgvBkj4MaWMVDUHRI8KUNo6N8qvsQL6jhUFjklvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388987; c=relaxed/simple;
	bh=h2aeMN0iyXzmtfN6yWDrbtdGGBg3QrIpffjyle6X+5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXPNDTiZddIzY9vJq1ySBI0PDuE0xL2dk94PCG5UlXZu0CZKMKCkw3yFXjY1z8TlZhSTSUvMwwqnqXUDj/c+WH6UqJ2GDhvRNPNuthvN4hwA/snGpcHHrO1dsjCOTbvu3NZlMVb9/4NZ3TH7FbSx5qQSbJDBeN2GLuNAz+fRFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kmkwmsoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CFDC4AF17;
	Mon, 29 Apr 2024 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714388987;
	bh=h2aeMN0iyXzmtfN6yWDrbtdGGBg3QrIpffjyle6X+5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmkwmsoHESEipLVjNBnkg3uIbv46UK4Pt825O7a6LfEkakthIyOYhogCUwxN21/ke
	 xscp0Vy1P9ymYOHh3qf9Q5afjjPnZPnFANDN3UYdHyn0xnnoNjFJmT+mDbpfW6Fl9d
	 uKg6hIaRrH9/Qbo5Q8NypxB+gkrKNH6EGFc+Ld8E=
Date: Mon, 29 Apr 2024 13:09:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Thorvald Natvig <thorvald@google.com>,
	Jane Chu <jane.chu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] fork: defer linking file vma until vma is fully
 initialized
Message-ID: <2024042934-outline-shudder-2be9@gregkh>
References: <2024042320-angled-goldmine-2cd7@gregkh>
 <20240426085133.2677038-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426085133.2677038-1-linmiaohe@huawei.com>

On Fri, Apr 26, 2024 at 04:51:33PM +0800, Miaohe Lin wrote:
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
> (cherry picked from commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/fork.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Both now queued up, thanks.

greg k-h

