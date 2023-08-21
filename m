Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97C782A56
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjHUNTx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjHUNTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E77A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD71636BE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F70C433C7;
        Mon, 21 Aug 2023 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692623990;
        bh=b2umEYy46VIRWvk+etfJQIK18QovMRaSzNAadpCrThY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5vEHucb7ghsd9+lhvtkdRZZ77a06HyYymmYQH9Zq+P2eNcCKPtEb2xorcNJ60xZo
         VmapwWehUqCwx7eaE3r37xdqFURlkiPYEyHpJnKgzXe42rLfC0IKltxRo/XfJb/pZn
         rlSx8X8WSo8WdZa4SH1/YFWz7Wz2moW3vXmfsbgo=
Date:   Mon, 21 Aug 2023 15:19:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] hugetlb: do not clear hugetlb dtor until
 allocating vmemmap
Message-ID: <2023082138-bondless-plus-cdce@gregkh>
References: <2023081202-unloader-t-shirt-eb23@gregkh>
 <20230816231428.112294-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816231428.112294-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 16, 2023 at 04:14:28PM -0700, Mike Kravetz wrote:
> commit 32c877191e022b55fe3a374f3d7e9fb5741c514d upstream.
> 
> Patch series "Fix hugetlb free path race with memory errors".
> 
> In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
> HWPOISON hugepages" the race window was discovered.
> https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/
> 
> Freeing a hugetlb page back to low level memory allocators is performed
> in two steps.
> 1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
> 2) Outside lock, allocate vmemmap if necessary and call low level free
> Between these two steps, the hugetlb page will appear as a normal
> compound page.  However, vmemmap for tail pages could be missing.
> If a memory error occurs at this time, we could try to update page
> flags non-existant page structs.
> 
> A much more detailed description is in the first patch.
> 
> The first patch addresses the race window.  However, it adds a
> hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb page
> free operation.  This could lead to slowdowns if one is freeing a large
> number of hugetlb pages.
> 
> The second path optimizes the update_and_free_pages_bulk routine to only
> take the lock once in bulk operations.
> 
> The second patch is technically not a bug fix, but includes a Fixes tag
> and Cc stable to avoid a performance regression.  It can be combined with
> the first, but was done separately make reviewing easier.
> 
> This patch (of 2):
> 
> Freeing a hugetlb page and releasing base pages back to the underlying
> allocator such as buddy or cma is performed in two steps:
> - remove_hugetlb_folio() is called to remove the folio from hugetlb
>   lists, get a ref on the page and remove hugetlb destructor.  This
>   all must be done under the hugetlb lock.  After this call, the page
>   can be treated as a normal compound page or a collection of base
>   size pages.
> - update_and_free_hugetlb_folio() is called to allocate vmemmap if
>   needed and the free routine of the underlying allocator is called
>   on the resulting page.  We can not hold the hugetlb lock here.
> 
> One issue with this scheme is that a memory error could occur between
> these two steps.  In this case, the memory error handling code treats
> the old hugetlb page as a normal compound page or collection of base
> pages.  It will then try to SetPageHWPoison(page) on the page with an
> error.  If the page with error is a tail page without vmemmap, a write
> error will occur when trying to set the flag.
> 
> Address this issue by modifying remove_hugetlb_folio() and
> update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> cleared until after allocating vmemmap.  Since clearing the destructor
> requires holding the hugetlb lock, the clearing is done in
> remove_hugetlb_folio() if the vmemmap is present.  This saves a
> lock/unlock cycle.  Otherwise, destructor is cleared in
> update_and_free_hugetlb_folio() after allocating vmemmap.
> 
> Note that this will leave hugetlb pages in a state where they are marked
> free (by hugetlb specific page flag) and have a ref count.  This is not
> a normal state.  The only code that would notice is the memory error
> code, and it is set up to retry in such a case.
> 
> A subsequent patch will create a routine to do bulk processing of
> vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> hugetlb page in the case where we are freeing a large number of pages.
> 
> Link: https://lkml.kernel.org/r/20230711220942.43706-1-mike.kravetz@oracle.com
> Link: https://lkml.kernel.org/r/20230711220942.43706-2-mike.kravetz@oracle.com
> Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: James Houghton <jthoughton@google.com>
> Cc: Jiaqi Yan <jiaqiyan@google.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Ported upstream commit 32c877191e02 as it depends on folio based
> interfaces not present in v6.1.y.

Now queued up, thanks.

greg k-h
