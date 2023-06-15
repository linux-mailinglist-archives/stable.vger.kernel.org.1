Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0890A731472
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbjFOJta (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbjFOJt2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 05:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E1199D
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686822520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFas5ce2A1vgl/Pd1KLK4gSYDaGRoYeIBhP4kavIodY=;
        b=Rkva/9+cC8pNRv5Jh/EQ/fOlV15WLFgoiRfFrXsHvBX9gNFfG5nMHPar2DksxMtWek1nqL
        5TXeAdxLvnO24Klk8Zfi3Mwx6rMRbRh5yBVA5lmI95bPpeBy8R2AwbsxGTAQQ/jzOnvKFI
        IXvmI5XgUeEAJa749YxWhwqo0BQg0H4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-LFHtV0FlNKyTlWssaeTMhQ-1; Thu, 15 Jun 2023 05:48:38 -0400
X-MC-Unique: LFHtV0FlNKyTlWssaeTMhQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f62cf0bb78so6548591e87.1
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686822517; x=1689414517;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFas5ce2A1vgl/Pd1KLK4gSYDaGRoYeIBhP4kavIodY=;
        b=LXVTm+5qfPl7vfT85YQdjzxC0yaJC+UfZhYords9G6Gk7R9IXo1hGuzHgyP1I9W+G4
         G+u15MaS1NlYf7hI4BrLvC8VMyeUbjcN9p3Ad4IPwzZMGPWdBg1nIJFgkPha7v72wC/u
         XNTs9wiwpgvCUOsfmQk62xh/y4dtbXyqPrv1MbA5jEGMcjvzsGL4HRlsbHcd6ygVXcQ5
         1QhLDRYsprLLt+w2aX0MgYCjubMuK39TcITSKd4h/2HHHozmY2BLg63uVJ85b8Yv+846
         B3bW7FqPFvJ2rmewmG/pcOILad7dT+p2GhK+nsHVMI+tgE3yNl18WSGIfRQvcmuyocy1
         JqWg==
X-Gm-Message-State: AC+VfDyoU4dOlHWylBYgLo+i0j/GYxzqpmIMAMqLNn0ImHzIZnz+RKbu
        jr2Q4hAedzUf7OHi4U/h2oq+YnD+Gm/HG2hDYJPQfHT8AXd1OFmwHqOwQ8CN+Q6gC+463DN/FAI
        KlKUkW7gQ21cfDd3G
X-Received: by 2002:a19:f205:0:b0:4dd:ce0b:7692 with SMTP id q5-20020a19f205000000b004ddce0b7692mr9513522lfh.46.1686822517133;
        Thu, 15 Jun 2023 02:48:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46ndnLtQ+lzJHNZ0kHKuZExuBXAwZ8nLK7yynFFKnsFo1JVRKjQW7nWIYv41TgUUl1IrX0NA==
X-Received: by 2002:a19:f205:0:b0:4dd:ce0b:7692 with SMTP id q5-20020a19f205000000b004ddce0b7692mr9513496lfh.46.1686822516710;
        Thu, 15 Jun 2023 02:48:36 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z15-20020a7bc7cf000000b003f6129d2e30sm20115269wmk.1.2023.06.15.02.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 02:48:36 -0700 (PDT)
Message-ID: <015062b6-2d4a-7b91-8f64-1695f526f794@redhat.com>
Date:   Thu, 15 Jun 2023 11:48:34 +0200
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
Cc:     "Hocko, Michal" <mhocko@suse.com>,
        "jmarchan@redhat.com" <jmarchan@redhat.com>,
        "Kim, Dongwon" <dongwon.kim@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <676ee47d-8ca0-94c4-7454-46e9915ea36a@redhat.com>
 <IA0PR11MB71850D8A446FE1342B428EA1F85AA@IA0PR11MB7185.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71850D8A446FE1342B428EA1F85AA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>> Skimming over at shmem_read_mapping_page() users, I assume most of
>> them
>> use a VM_PFNMAP mapping (or don't mmap them at all), where we won't be
>> messing with the struct page at all.
>>
>> (That might even allow you to mmap hugetlb sub-pages, because the struct
>> page -- and mapcount -- will be ignored completely and not touched.)
> Oh, are you suggesting that if we do vma->vm_flags |= VM_PFNMAP
> in the mmap handler (mmap_udmabuf) and also do
> vmf_insert_pfn(vma, vmf->address, page_to_pfn(page))
> instead of
> vmf->page = ubuf->pages[pgoff];
> get_page(vmf->page);
> 
> in the vma fault handler (udmabuf_vm_fault), we can avoid most of the
> pitfalls you have identified -- including with the usage of hugetlb subpages?

Yes, that's my thinking, but I have to do my homework first to see if 
that would really work for hugetlb.

The thing is, I kind-of consider what udmabuf does a layer violation: we 
have a filesystem (shmem/hugetlb) that should handle mappings to user 
space. Yet, a driver decides to bypass that and simply map the pages 
ordinarily to user space. (revealed by the fact that hugetlb does never 
map sub-pages but udmabuf decides to do so)

In an ideal world everybody would simply mmap() the original memfd, but 
thinking about offset+size configuration within the memfd that might not 
always be desirable. As a workaround, we could mmap() only the PFNs, 
leaving the struct page unaffected.

I'll have to look closer into that.

-- 
Cheers,

David / dhildenb

