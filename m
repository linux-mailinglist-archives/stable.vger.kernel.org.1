Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505D8734C7C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjFSHmF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjFSHmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D872B1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687160481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqswxOYBmgCx1H0OtTMAtQLEByiEVXOzTtZ2FdWBrdg=;
        b=eRYUz2FpKloWff17jRJhaagrP1nKer+Xu2D3T44EWAFKgiTeX80wIOeQwMLzdpKpgK7d5j
        jqKA69GplQSYg/SLZ+J9Lk1gfOvZceMRevmeL9BlPtg/cKfp5aUsxUNtONyqXWcPoiI9ph
        /ma7VrR5Dwadivu+MM9gQbha/E0ho9A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-BAcRU9z-Nqi2yWV_b6_HaA-1; Mon, 19 Jun 2023 03:41:19 -0400
X-MC-Unique: BAcRU9z-Nqi2yWV_b6_HaA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4edb90ccaadso1977984e87.3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687160478; x=1689752478;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqswxOYBmgCx1H0OtTMAtQLEByiEVXOzTtZ2FdWBrdg=;
        b=kX1fl/zFM/UC7K43RlqwmtIhbtzTKngKYhswdZ5L+Y0G7bhBIeVKdr4x6nTJ/I+83E
         U2oMTO7jaAttn12YemwPttHzkrGdJUesooYF0ONLNEIt8UBewIX19eBHoj3Rimxwzaev
         xJl6B+lvFwohRsr2f4ajCbfv+yzJcq9Zt4TfosQbTOOwXkNiNyGizAqYcaWn3vpqvg4b
         GEx1zSh3pe2Tz1kvBaDdjF7nEQe7sNTpVMg00Tz6IY82GmXGCIVfkjPcvhYCQ41IHwaR
         DEuwPwZD4pIf5uqa7/NCw3bApaPxTZQfUml9uRm1MA/wK5G/8tg25TsTtGlSgLgM57yd
         pycQ==
X-Gm-Message-State: AC+VfDwd4ux4R32EcTVy0KvPAc+10PSZFeMb3KIeDe8f5i31uV7UgfhC
        u+FKS/oNUO7jF/PdrLRrHuez3kQqtxmCGPc0TEJGqr7DGgMbwWA0q/JHEFe5Jzhn/yDOo4zcdQO
        I6ug0PEpnt0OHJK+CIbSyuCKI
X-Received: by 2002:a19:6909:0:b0:4f8:6d54:72fb with SMTP id e9-20020a196909000000b004f86d5472fbmr1049631lfc.62.1687160478474;
        Mon, 19 Jun 2023 00:41:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HNHZ8/JvZilW7FHs81e5kgKVsECuxDLsfEiF7YmZueXU3jXNGQCNTjN77BhxFyBFc35X8sA==
X-Received: by 2002:a19:6909:0:b0:4f8:6d54:72fb with SMTP id e9-20020a196909000000b004f86d5472fbmr1049624lfc.62.1687160477940;
        Mon, 19 Jun 2023 00:41:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:7100:cede:6433:a77b:41e9? (p200300cbc72f7100cede6433a77b41e9.dip0.t-ipconnect.de. [2003:cb:c72f:7100:cede:6433:a77b:41e9])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0030fbf253c82sm22235978wru.104.2023.06.19.00.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 00:41:17 -0700 (PDT)
Message-ID: <cc1c2973-493a-6e21-048e-148ed55e653b@redhat.com>
Date:   Mon, 19 Jun 2023 09:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH stable 5.10] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Content-Language: en-US
To:     mawupeng <mawupeng1@huawei.com>, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        richard.weiyang@linux.alibaba.com, mst@redhat.com,
        jasowang@redhat.com, pankaj.gupta.linux@gmail.com,
        mhocko@kernel.org, osalvador@suse.de
References: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
 <20230619065121.1720912-1-mawupeng1@huawei.com>
 <2023061926-monoxide-pastor-fa3b@gregkh>
 <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a7d39606-cc85-42c3-c882-fa217954bf00@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 19.06.23 09:22, mawupeng wrote:
> 
> 
> On 2023/6/19 15:16, Greg KH wrote:
>> On Mon, Jun 19, 2023 at 02:51:21PM +0800, Wupeng Ma wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.
>>>
>>> virtio-mem soon wants to use offline_and_remove_memory() memory that
>>> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
>>> remove that restriction.
>>>
>>> Let's remember the old state and try to restore that if anything goes
>>> wrong. While re-onlining can, in general, fail, it's highly unlikely to
>>> happen (usually only when a notifier fails to allocate memory, and these
>>> are rather rare).
>>>
>>> This will be used by virtio-mem to offline+remove memory ranges that are
>>> bigger than a single memory block - for example, with a device block
>>> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
>>> block size of 128MB.
>>>
>>> While we could compress the state into 2 bit, using 8 bit is much
>>> easier.
>>>
>>> This handling is similar, but different to acpi_scan_try_to_offline():
>>>
>>> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
>>> optimization is still relevant - it should only apply to ZONE_NORMAL
>>> (where we have no guarantees). If relevant, we can always add it.
>>>
>>> b) acpi_scan_try_to_offline() simply onlines all memory in case
>>> something goes wrong. It doesn't restore previous online type. Let's do
>>> that, so we won't overwrite what e.g., user space configured.
>>>
>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Link: https://lore.kernel.org/r/20201112133815.13332-28-david@redhat.com
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> ---
>>>   mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
>>>   1 file changed, 89 insertions(+), 16 deletions(-)
>>>
>>
>> Why is this needed in 5.10.y?  Looks like a new feature to me, what
>> problem does it solve there?
>>
>> thanks,
>>
>> greg k-h
> 
> It do introduce a new feature. But at the same time, it fix a memleak introduced
> in Commit 08b3acd7a68f ("mm/memory_hotplug: Introduce offline_and_remove_memory()"
> 
> Our test find a memleak in init_memory_block, it is clear that mem is never
> been released due to wrong refcount. Commit 08b3acd7a68f ("mm/memory_hotplug:
> Introduce offline_and_remove_memory()") failed to dec refcount after
> find_memory_block which fail to dec refcount to zero in remove memory
> causing the leak.
> 
> Commit 8dc4bb58a146 ("mm/memory_hotplug: extend offline_and_remove_memory()
> to handle more than one memory block") introduce walk_memory_blocks to
> replace find_memory_block which dec refcount by calling put_device after
> find_memory_block_by_id. In the way, the memleak is fixed.
> 
> Here is the simplified calltrace:
> 
>    kmem_cache_alloc_trace+0x664/0xed0
>    init_memory_block+0x8c/0x170
>    create_memory_block_devices+0xa4/0x150
>    add_memory_resource+0x188/0x530
>    __add_memory+0x78/0x104
>    add_memory+0x6c/0xb0
> 

Makes sense to me. Of course, we could think about a simplified stable 
fix that only drops the ref.

-- 
Cheers,

David / dhildenb

