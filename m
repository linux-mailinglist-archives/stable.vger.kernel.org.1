Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A248749EF9
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjGFO3J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjGFO3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 10:29:09 -0400
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 07:29:04 PDT
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D31BDB
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 07:29:04 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7b2c.dip0.t-ipconnect.de [93.221.123.44])
        by mail.itouring.de (Postfix) with ESMTPSA id 8B772C556;
        Thu,  6 Jul 2023 16:19:57 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 4781BF01600;
        Thu,  6 Jul 2023 16:19:57 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230706011400.2949242-1-surenb@google.com>
 <20230706011400.2949242-2-surenb@google.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <e11c2ef7-770f-0c29-5b41-97f924351cf1@applied-asynchrony.com>
Date:   Thu, 6 Jul 2023 16:19:57 +0200
MIME-Version: 1.0
In-Reply-To: <20230706011400.2949242-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-07-06 03:13, Suren Baghdasaryan wrote:
> When forking a child process, parent write-protects an anonymous page
> and COW-shares it with the child being forked using copy_present_pte().
> Parent's TLB is flushed right before we drop the parent's mmap_lock in
> dup_mmap(). If we get a write-fault before that TLB flush in the parent,
> and we end up replacing that anonymous page in the parent process in
> do_wp_page() (because, COW-shared with the child), this might lead to
> some stale writable TLB entries targeting the wrong (old) page.
> Similar issue happened in the past with userfaultfd (see flush_tlb_page()
> call inside do_wp_page()).
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~7% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-asynchrony.com/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   kernel/fork.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b85814e614a5..2ba918f83bde 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>   		retval = -EINTR;
>   		goto fail_uprobe_end;
>   	}
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Disallow any page faults before calling flush_cache_dup_mm */
> +	for_each_vma(old_vmi, mpnt)
> +		vma_start_write(mpnt);
> +	vma_iter_set(&old_vmi, 0);
> +#endif
>   	flush_cache_dup_mm(oldmm);
>   	uprobe_dup_mmap(oldmm, mm);
>   	/*
> 

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thanks!
