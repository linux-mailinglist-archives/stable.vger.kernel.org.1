Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9A76CD57
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 14:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjHBMpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjHBMpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 08:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D02722
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690980231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOzUrt7muFZfH5D+b0L7Q8SCbDEFvQqhKmACrqvdGts=;
        b=Zh0ReP6Vux7O9jKxJ+j1Hkt7KAc56paAHpPqDea5uhzcXkJiLeyMwHkAHmiL/u8RklB/U/
        y/T0D/qaH4BCTb6FKzKEw3QvassirA+kkeOMVSpLuXoua0CzabhKzorb/T1u6ZnjrD9bI8
        HZPAOuOdRcYLEUejB9rhQkGCTs9tk+k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-1vFriIXNPIqZ0pBkF6PjoQ-1; Wed, 02 Aug 2023 08:43:50 -0400
X-MC-Unique: 1vFriIXNPIqZ0pBkF6PjoQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fd2dec82a6so42768945e9.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 05:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980229; x=1691585029;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOzUrt7muFZfH5D+b0L7Q8SCbDEFvQqhKmACrqvdGts=;
        b=Od4fFhR3aAT7D6rzkxMLiZQMi9V0Me3ETUy2H/JDDLCnMK1aooegz2vmd59DJOvvdC
         OSIpvyWSjfn24AhztIqYSfiIHrZXpPcPgghkgNyVdE6Xgmviv8ze4h+HHZ/T1iarmcqr
         U8mqUV77qoordCaGJTt+ZlxQRnRzLCGWElY+ndXnN4C1PqEd2fbooaoavWeOApqdI/Q1
         /1DvpKFgPk0Klhlpgz4GmhgqX5AvQJ4jsY1eDmgYL20bMkH7cF3kihq8aE0MDZVq2UuJ
         oaoQGlVI/+zCk8OdMZRqlkV5n2YQNRrDS93VCxiYXhfX3YjHktPEolc6vqwXmrJ3S5Ae
         DNLg==
X-Gm-Message-State: ABy/qLZcyQVz9z3TOsvItl8sFkUF33mDD7F1eShdf1/bSdb2Ziw625X4
        fw9HJ2huMdHIld6JB7ZJxqF/36IoPpQCDpCFnguJnmvjZk1z7ZT5ILHFTuQxp4Nj93VB5WJaFax
        atJtyHPu2dO9UL1kB4LfHSz9a
X-Received: by 2002:a7b:c04d:0:b0:3fd:129d:b721 with SMTP id u13-20020a7bc04d000000b003fd129db721mr4607746wmc.16.1690980229241;
        Wed, 02 Aug 2023 05:43:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGzcgncVNOJgDZsqA1DBdhJGe9Z4qiLmCg4fj5jktc5aWfKR91E0F0weNz2j8tDecBGhdGORA==
X-Received: by 2002:a7b:c04d:0:b0:3fd:129d:b721 with SMTP id u13-20020a7bc04d000000b003fd129db721mr4607725wmc.16.1690980228865;
        Wed, 02 Aug 2023 05:43:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fe215e4492sm1643900wmj.4.2023.08.02.05.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:43:48 -0700 (PDT)
Message-ID: <ee48a65f-b384-b90f-09c5-7dddeaf8eb7e@redhat.com>
Date:   Wed, 2 Aug 2023 14:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, shy828301@gmail.com
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 02.08.23 14:40, Ryan Roberts wrote:
> On 02/08/2023 13:35, Yin, Fengwei wrote:
>>
>>
>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>
>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>
>>>> Yin Fengwei (2):
>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>    madvise: don't use mapcount() against large folio for sharing check
>>>>
>>>>   mm/huge_memory.c | 2 +-
>>>>   mm/madvise.c     | 6 +++---
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>
>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>
>>> Reviewed-By: Ryan Roberts
>> Thanks.
>>
>>>
>>>
>>> But I have a couple of comments around further improvements;
>>>
>>> Once we have the scheme that David is working on to be able to provide precise
>>> exclusive vs shared info, we will probably want to move to that. Although that
>>> scheme will need access to the mm_struct of a process known to be mapping the
>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>> call sites again.
>> Yes. This could be extra work. Maybe should delay till David's work is done.
> 
> What you have is definitely an improvement over what was there before. And is
> probably the best we can do without David's scheme. So I wouldn't delay this.
> Just pointing out that we will be able to make it even better later on (if
> David's stuff goes in).

Agreed, we just should be careful and clearly spell out the implications 
and that this is eventually also not what we 100% want.

That MADV_PAGEOUT now fails on a PTE-mapped THP -- as can be seen when 
executing the cow selftest where MADV_PAGEOUT will essentially fail -- 
is certainly undesired and should be fixed IMHO.

-- 
Cheers,

David / dhildenb

