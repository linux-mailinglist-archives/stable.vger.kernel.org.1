Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DA7489F3
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGERPC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGERO6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 13:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DC173F
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688577251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6fxBPBS9mNaQm6LSrIZd4vdKlGZL91VslAI6+By/As=;
        b=cEpVzpnIqlXaz7GZ9lHcTeVcpcDTTWQeVgiLgEyAzNeCSCQLrEpeYoO7qn6MtuTNsiStGY
        HhxNiNLpTYk1oxvMKX3/miUP5SFl7Cm3kLC+0xYQ4Jx3Q0MqL2ckxIQnZNpm8wyFjSGfRh
        1ZFBESZDAX3da8dp64dY29yqmNhFJcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-an2ZPUHOOKGQRNhvpSUgRA-1; Wed, 05 Jul 2023 13:14:10 -0400
X-MC-Unique: an2ZPUHOOKGQRNhvpSUgRA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fb40d90456so5042655e9.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 10:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577249; x=1691169249;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6fxBPBS9mNaQm6LSrIZd4vdKlGZL91VslAI6+By/As=;
        b=Z0znSGewJX3xlIowWbr6yPf/fXsTY78qnKAL5sWh/g/wbBIBTSpLzGDIdjE5MwdIkU
         SIVBTnqKMh7zVTsOc58e6kToGXc4KTLY8gmvBDLs3FWfmill+Vnk3C+3muuAV/lx5/4j
         c7Rf8gf0xxki6ZYjcMftLqDa/zDW3flnAEcPuCm8HU3DuAOR9N+yqwoIFjhQZ23djD0x
         fSy9p2PCxwCEgoILUzIbWJk8kvfN9VHajyDx58uSMChabeFegACYliypENCORBvWswBD
         Ef7Q/1VgN4Tr8BXFNl5+jHfqYD2LI3NgTqL6p5mwHAZsKvDPuOe4oIhR5gG4ahM9gOp9
         dVRA==
X-Gm-Message-State: ABy/qLaYfvTJlTw1xJCpNs/eHKjCpgh4Nq3jphUpNG8NelgqDn/fFI7y
        KA9KEvGssC9HnkEi47Y3ab7KhJIc8pei+vMmAKXoY3as2XMvrLBhEkHp3no3ZlsnZvGW1QnqoJr
        vY2uTPVkilytn75CW
X-Received: by 2002:a1c:790a:0:b0:3fb:af9a:bf30 with SMTP id l10-20020a1c790a000000b003fbaf9abf30mr2843838wme.2.1688577248747;
        Wed, 05 Jul 2023 10:14:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeCuf/W6MTtkOf7dX+nc3d9EnWYOlr9nA7OJpij/WlD4Ds+urw6/DQsIfBD5eA8hOzT3n4/A==
X-Received: by 2002:a1c:790a:0:b0:3fb:af9a:bf30 with SMTP id l10-20020a1c790a000000b003fbaf9abf30mr2843806wme.2.1688577248380;
        Wed, 05 Jul 2023 10:14:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000104800b003143ba62cf4sm6547606wrx.86.2023.07.05.10.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:14:07 -0700 (PDT)
Message-ID: <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com>
Date:   Wed, 5 Jul 2023 19:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-2-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230705171213.2843068-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 05.07.23 19:12, Suren Baghdasaryan wrote:
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
> shows ~5% regression. If such fork time regression is unacceptable,
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
> index b85814e614a5..403bc2b72301 100644
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
> +	vma_iter_init(&old_vmi, oldmm, 0);
> +#endif
>   	flush_cache_dup_mm(oldmm);
>   	uprobe_dup_mmap(oldmm, mm);
>   	/*

The old version was most probably fine as well, but this certainly looks 
even safer.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

