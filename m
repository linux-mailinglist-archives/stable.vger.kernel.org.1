Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108872EA3F
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFMRv6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRv5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 13:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CBA6
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686678670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juXhP8h8oDmvEUGxpUcem9DQ8p6SNtDcHFetvbuMc3c=;
        b=B7+Et1Cp6np2W40v23Ml1UC4Mqo7BMHb9E8BPwXJYV7M6tMVUYSeKx5+slSvnb8epOezly
        3xm/hkafiVLsRu2WFBz/s0nQc610xgm3j9IXIrj5ImbCE/gCgySHGPw/slLxnpGWffpplm
        PBEk/PVF1nYVH8AMlhFwxEbfB0kuvmM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-x9ypDjVdPA-qED4UDWkD-g-1; Tue, 13 Jun 2023 13:51:09 -0400
X-MC-Unique: x9ypDjVdPA-qED4UDWkD-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30fd136ccb7so289748f8f.3
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 10:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678668; x=1689270668;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juXhP8h8oDmvEUGxpUcem9DQ8p6SNtDcHFetvbuMc3c=;
        b=mIEXOUSVhEVfaSu60DdUX/COn1D4zA1XEiLxfrv6cnjdLEKxKTXsnW6Bv/mlueQt34
         qfvzfz+OFFhEQIoo++D9EUWJYwuzOyyHVhuhkIFxxjg57VHJHUA75Zkq8GzXNgblYrJ6
         ny/RXVwMcCSmLi6WNI/nApZYIQquixtz3T20wUPmPEblycBezb/fggK4CUtNM3UcrgUY
         +zN1QO8a0ZcGUGvLPx8jruDBpJhykPPCeQNxmTnBeca9bquKBo4BKxiv7UKsIzYUR06R
         vr/ALm5IGi96u4H5Xeg2XX5Kdo/uA11NZCZsvCmg63fdrXazd2orNKvLdHYmk84EmcKK
         bX5A==
X-Gm-Message-State: AC+VfDzQbHIApA5HtBc1YfTtZkIC7JWTd4vSfPM7lOlMceXoYgtYS3so
        /uKQRpQY3Rj4qOUHBGfWiwOUxFfdFq7fcQaPWWNDab39ps5jbka5zlA48G8KSsTwUka9MzCwWhn
        PuGlenUFKY5yvDEDX
X-Received: by 2002:a5d:550f:0:b0:30f:d2a2:4789 with SMTP id b15-20020a5d550f000000b0030fd2a24789mr555644wrv.15.1686678667877;
        Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lyYhUT4jenaM6rLsrwexVg0v9nokG/WYAFV8FGI+Et386/Ww0vCErRFY7lVfu35C1ypzfbg==
X-Received: by 2002:a5d:550f:0:b0:30f:d2a2:4789 with SMTP id b15-20020a5d550f000000b0030fd2a24789mr555631wrv.15.1686678667516;
        Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id h4-20020adffa84000000b0030647d1f34bsm15965105wrr.1.2023.06.13.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
Message-ID: <676ee47d-8ca0-94c4-7454-46e9915ea36a@redhat.com>
Date:   Tue, 13 Jun 2023 19:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kim, Dongwon" <dongwon.kim@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmarchan@redhat.com" <jmarchan@redhat.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 13.06.23 10:26, Kasireddy, Vivek wrote:
> Hi David,
> 
>>
>> On 12.06.23 09:10, Kasireddy, Vivek wrote:
>>> Hi Mike,
>>
>> Hi Vivek,
>>
>>>
>>> Sorry for the late reply; I just got back from vacation.
>>> If it is unsafe to directly use the subpages of a hugetlb page, then reverting
>>> this patch seems like the only option for addressing this issue immediately.
>>> So, this patch is
>>> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>
>>> As far as the use-case is concerned, there are two main users of the
>> udmabuf
>>> driver: Qemu and CrosVM VMMs. However, it appears Qemu is the only
>> one
>>> that uses hugetlb pages (when hugetlb=on is set) as the backing store for
>>> Guest (Linux, Android and Windows) system memory. The main goal is to
>>> share the pages associated with the Guest allocated framebuffer (FB) with
>>> the Host GPU driver and other components in a zero-copy way. To that
>> end,
>>> the guest GPU driver (virtio-gpu) allocates 4k size pages (associated with
>>> the FB) and pins them before sharing the (guest) physical (or dma)
>> addresses
>>> (and lengths) with Qemu. Qemu then translates the addresses into file
>>> offsets and shares these offsets with udmabuf.
>>
>> Is my understanding correct, that we can effectively long-term pin
>> (worse than mlock) 64 MiB per UDMABUF_CREATE, allowing eventually !root
> The 64 MiB limit is the theoretical upper bound that we have not seen hit in
> practice. Typically, for a 1920x1080 resolution (commonly used in Guests),
> the size of the FB is ~8 MB (1920x1080x4). And, most modern Graphics
> compositors flip between two FBs.
> 

Okay, but users with privileges to open that file can just create as 
many as they want? I think I'll have to play with it.

>> users
>>
>> ll /dev/udmabuf
>> crw-rw---- 1 root kvm 10, 125 12. Jun 08:12 /dev/udmabuf
>>
>> to bypass there effective MEMLOCK limit, fragmenting physical memory and
>> breaking swap?
> Right, it does not look like the mlock limits are honored.
> 

That should be added.

>>
>> Regarding the udmabuf_vm_fault(), I assume we're mapping pages we
>> obtained from the memfd ourselves into a special VMA (mmap() of the
> mmap operation is really needed only if any component on the Host needs
> CPU access to the buffer. But in most scenarios, we try to ensure direct GPU
> access (h/w acceleration via gl) to these pages.
> 
>> udmabuf). I'm not sure how well shmem pages are prepared for getting
>> mapped by someone else into an arbitrary VMA (page->index?).
> Most drm/gpu drivers use shmem pages as the backing store for FBs and
> other buffers and also provide mmap capability. What concerns do you see
> with this approach?

Are these mmaping the pages the way udmabuf maps these pages (IOW, 
on-demand fault where we core-mm will adjust the mapcount etc)?

Skimming over at shmem_read_mapping_page() users, I assume most of them 
use a VM_PFNMAP mapping (or don't mmap them at all), where we won't be 
messing with the struct page at all.

(That might even allow you to mmap hugetlb sub-pages, because the struct 
page -- and mapcount -- will be ignored completely and not touched.)

> 
>>
>> ... also, just imagine someone doing FALLOC_FL_PUNCH_HOLE / ftruncate()
>> on the memfd. What's mapped into the memfd no longer corresponds to
>> what's pinned / mapped into the VMA.
> IIUC, making use of the DMA_BUF_IOCTL_SYNC ioctl would help with any
> coherency issues:
> https://www.kernel.org/doc/html/v6.2/driver-api/dma-buf.html#c.dma_buf_sync
> 

Would it as of now? udmabuf_create() pulls the shmem pages out of the 
memfd, not sure how DMA_BUF_IOCTL_SYNC would help to update that 
whenever the pages inside the memfd would change (e.g., 
FALLOC_FL_PUNCH_HOLE + realloc).

But that's most probably simply "not supported".

>>
>>
>> Was linux-mm (and especially shmem maintainers, ccing Hugh) involved in
>> the upstreaming of udmabuf?
> It does not appear so from the link below although other key lists were cc'd:
> https://patchwork.freedesktop.org/patch/246100/?series=39879&rev=7

That's unfortunate :(

-- 
Cheers,

David / dhildenb

