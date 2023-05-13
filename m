Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE29701431
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 05:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEMDat (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 23:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEMDar (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 23:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3946B8
        for <stable@vger.kernel.org>; Fri, 12 May 2023 20:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683948598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjyiA8CSsNyrBFAulIeEup4nb5qDAbNqRQ7zOVhw7pM=;
        b=KQm3+J/Om6RWUKD1XLYNX4g3Hy9oZ7ce6Jg9L6czOdjEVEVWFcjDyMIuK0goOogndl2yKB
        DUMXy5EluS7KqzrjJCxVDkxw1slMShSX08GwLm7Iq6uR8bhhE4W9uvKsCqz32ZOFTjqBZR
        cKz3qqf3sgVyKsSOGaHzy0+hUrmQrrE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-989f5g-jM6iYk2D70yCZSQ-1; Fri, 12 May 2023 23:29:56 -0400
X-MC-Unique: 989f5g-jM6iYk2D70yCZSQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f39abae298so34074091cf.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 20:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683948596; x=1686540596;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjyiA8CSsNyrBFAulIeEup4nb5qDAbNqRQ7zOVhw7pM=;
        b=R+t6oAsrWI1iYns2D8JviUboV7uRE5+AUCISVygzDRz86fm62bg8JvZoaRot43r/Yc
         t2Jla58mX6laj1Mj0Z8xC6X06bbdVuPSN0BC6886cdMnUGbZHD8lMlp0jL4n5T9FnkV+
         2+iownj5IvaOsYqRLrzHf/nLD3Ew01vLjmFtEvywv3cTnGrmpdEvpMFrb+zj3fEPnn6S
         v+Zi6u35R/fdLCL7nmkt8lGR4defwaGwzEYmWgFdcmNB25ZuOVOoktLwDwoLv1SuadL/
         u7TZnbQtpHAK6qhGsVYMFvhUNiOaT/7+5zWU3sQ+B5YuhrBSDDMlcn1zttWy+XgUnWJx
         HExA==
X-Gm-Message-State: AC+VfDwa683VOWQn9Yg41W9MgbC/AkSTorhjIZBuoxp/6625PQC3kMQb
        DVwO7TvHr9euWeJ5KEjpbqdlPQMJDiZZFSj5BUxPW7DtGpB3LX7vuriceXPqj19y/JrRbXxYyzC
        XS4DpCNFAZeHziAHy
X-Received: by 2002:ac8:580e:0:b0:3ef:52ac:10d2 with SMTP id g14-20020ac8580e000000b003ef52ac10d2mr43450057qtg.43.1683948596191;
        Fri, 12 May 2023 20:29:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uKjxFXSk2VXZahSFRKvmzrBM3NShgEQwno70kldYsCKVJwIg1m82AD+GP0jDRamMLZ8k86w==
X-Received: by 2002:ac8:580e:0:b0:3ef:52ac:10d2 with SMTP id g14-20020ac8580e000000b003ef52ac10d2mr43450038qtg.43.1683948595851;
        Fri, 12 May 2023 20:29:55 -0700 (PDT)
Received: from ?IPV6:2603:7000:3d00:1816::1772? (2603-7000-3d00-1816-0000-0000-0000-1772.res6.spectrum.com. [2603:7000:3d00:1816::1772])
        by smtp.gmail.com with ESMTPSA id l20-20020ae9f014000000b00755951e48desm5710604qkg.135.2023.05.12.20.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 20:29:55 -0700 (PDT)
Message-ID: <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
Date:   Sat, 13 May 2023 05:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
In-Reply-To: <20230512235755.1589034-2-pcc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 13.05.23 01:57, Peter Collingbourne wrote:
> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> the call to swap_free() before the call to set_pte_at(), which meant that
> the MTE tags could end up being freed before set_pte_at() had a chance
> to restore them. One other possibility was to hook arch_do_swap_page(),
> but this had a number of problems:
> 
> - The call to the hook was also after swap_free().
> 
> - The call to the hook was after the call to set_pte_at(), so there was a
>    racy window where uninitialized metadata may be exposed to userspace.
>    This likely also affects SPARC ADI, which implements this hook to
>    restore tags.
> 
> - As a result of commit 1eba86c096e3 ("mm: change page type prior to
>    adding page table entry"), we were also passing the new PTE as the
>    oldpte argument, preventing the hook from knowing the swap index.
> 
> Fix all of these problems by moving the arch_do_swap_page() call before
> the call to free_page(), and ensuring that we do not set orig_pte until
> after the call.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> Cc: <stable@vger.kernel.org> # 6.1
> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
> Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table entry")

I'm confused. You say c145e0b47c77 changed something (which was after 
above commits), indicate that it fixes two other commits, and indicate 
"6.1" as stable which does not apply to any of these commits.

> ---
>   mm/memory.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01a23ad48a04..83268d287ff1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		}
>   	}
>   
> -	/*
> -	 * Remove the swap entry and conditionally try to free up the swapcache.
> -	 * We're already holding a reference on the page but haven't mapped it
> -	 * yet.
> -	 */
> -	swap_free(entry);
> -	if (should_try_to_free_swap(folio, vma, vmf->flags))
> -		folio_free_swap(folio);
> -
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>   	pte = mk_pte(page, vma->vm_page_prot);
> -
>   	/*
>   	 * Same logic as in do_wp_page(); however, optimize for pages that are
>   	 * certainly not shared either because we just allocated them without
> @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		pte = pte_mksoft_dirty(pte);
>   	if (pte_swp_uffd_wp(vmf->orig_pte))
>   		pte = pte_mkuffd_wp(pte);
> +	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>   	vmf->orig_pte = pte;
>   
> +	/*
> +	 * Remove the swap entry and conditionally try to free up the swapcache.
> +	 * We're already holding a reference on the page but haven't mapped it
> +	 * yet.
> +	 */
> +	swap_free(entry);
> +	if (should_try_to_free_swap(folio, vma, vmf->flags))
> +		folio_free_swap(folio);
> +
> +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +
>   	/* ksm created a completely new copy */
>   	if (unlikely(folio != swapcache && swapcache)) {
>   		page_add_new_anon_rmap(page, vma, vmf->address);
> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	VM_BUG_ON(!folio_test_anon(folio) ||
>   			(pte_write(pte) && !PageAnonExclusive(page)));
>   	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>   
>   	folio_unlock(folio);
>   	if (folio != swapcache && swapcache) {


You are moving the folio_free_swap() call after the 
folio_ref_count(folio) == 1 check, which means that such (previously) 
swapped pages that are exclusive cannot be detected as exclusive.

There must be a better way to handle MTE here.

Where are the tags stored, how is the location identified, and when are 
they effectively restored right now?

-- 
Thanks,

David / dhildenb

