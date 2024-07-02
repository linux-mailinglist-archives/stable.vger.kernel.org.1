Return-Path: <stable+bounces-56360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959859241F2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414021F26089
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFA21BA09A;
	Tue,  2 Jul 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFS1GXUb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBC1DFFC
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933038; cv=none; b=YXvTfQ7Zt72OCkFeYIj5Stb1jIB8BW3bITV3z+hOFhL66GAxwkflqhNk9zmakI1YIA6W37085lU8zXCkhkJWrc86oHc7nsOa6QLL6mF7Hf2dkOLhDOuSZha2EqTasfum7OBzUuSu4gzZu1KWtXSQjRBvzvv+vr24Ks6MvBFi6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933038; c=relaxed/simple;
	bh=2b7kI+EycdeLeYghcz0n6WauNPD7YPqvOdzaSE3IhiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlToSk07Y9+iI1CumQWWb1U87nTqmLjAV9XP66Vt+mXGoP0U2u8lUuLtsRqGbENNjzKkGB0Aa5iJ2Zb0SLgelQdzi+ZFUAGO55yeyo+3PfsFbkVQi2nW1Y5AbIhUNQhrkQ15jzFAxfPEip0YtXk7xCEJf9MiVGYv/fXxm/XY7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFS1GXUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2144AC116B1;
	Tue,  2 Jul 2024 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933038;
	bh=2b7kI+EycdeLeYghcz0n6WauNPD7YPqvOdzaSE3IhiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFS1GXUbG5KOPV5ImC9gymf0yA5nXKdJFED5oQO/krrowvxpCV+BLurenkNdd2lPU
	 d4lo0RgsB5yx1sUYkhAyFENpanDgaRPgz2Iu08J7zqFDcae7bQCiAM2n3YwRyiDr8F
	 wZECUqPIK+ULQdAAO+7tPYFgwVdFJRcW18mYj+UvOUoKKpWQU1L6cZA9rkGD181Vft
	 C5O+tmrK9cuknn5FIymXpJj9+hwWU/ELh/LpTJAa/VN6zV2NYc5jP9jp+tTn5NZQv7
	 77Cc+FHSygMG/9sIrR7C7Y5jd3yxw7XXZdj0g0V9HfRL3OJaN3ahnFqW/yD+RyJKYW
	 ei9fML9yojoLw==
Date: Tue, 2 Jul 2024 08:27:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Thorvald Natvig <thorvald@google.com>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully
 initialized
Message-ID: <ZoPyReRlZ6ViNH-6@sashalap>
References: <20240702042948.2629267-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240702042948.2629267-1-leah.rumancik@gmail.com>

On Mon, Jul 01, 2024 at 09:29:48PM -0700, Leah Rumancik wrote:
>From: Miaohe Lin <linmiaohe@huawei.com>
>
>commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 upstream.
>
>Thorvald reported a WARNING [1]. And the root cause is below race:
>
> CPU 1					CPU 2
> fork					hugetlbfs_fallocate
>  dup_mmap				 hugetlbfs_punch_hole
>   i_mmap_lock_write(mapping);
>   vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
>   i_mmap_unlock_write(mapping);
>   hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
>					 i_mmap_lock_write(mapping);
>   					 hugetlb_vmdelete_list
>					  vma_interval_tree_foreach
>					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
>   tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
>					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
>					 i_mmap_unlock_write(mapping);
>
>hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
>i_mmap_rwsem lock while vma lock can be used in the same time.  Fix this
>by deferring linking file vma until vma is fully initialized.  Those vmas
>should be initialized first before they can be used.
>
>Backport notes:
>
>The first backport attempt (cec11fa2e) was reverted (dd782da4707). This is
>the new backport of the original fix (35e351780fa9).
>
>35e351780f ("fork: defer linking file vma until vma is fully initialized")
>fixed a hugetlb locking race by moving a bunch of intialization code to earlier
>in the function. The call to open() was included in the move but the call to
>copy_page_range was not, effectively inverting their relative ordering. This
>created an issue for the vfio code which assumes copy_page_range happens before
>the call to open() - vfio's open zaps the vma so that the fault handler is
>invoked later, but when we inverted the ordering, copy_page_range can set up
>mappings post-zap which would prevent the fault handler from being invoked
>later. This patch moves the call to copy_page_range to earlier than the call to
>open() to restore the original ordering of the two functions while keeping the
>fix for hugetlb intact.
>
>Commit aac6db75a9 made several changes to vfio_pci_core.c, including
>removing the vfio-pci custom open function. This resolves the issue on
>the main branch and so we only need to apply these changes when
>backporting to stable branches.
>
>35e351780f ("fork: defer linking file vma until vma is fully initialized")-> v6.9-rc5
>aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") -> v6.10-rc4

Is there a strong reason not to take the commit above instead? That way:

a. We stay aligned with upstream, not needed a custom backport.
b. We avoid similar issues in the future.

-- 
Thanks,
Sasha

