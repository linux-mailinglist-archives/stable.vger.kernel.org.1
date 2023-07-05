Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C157489FF
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGERRP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjGERQz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 13:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DA19AC
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688577365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T35piQgq4+7zJ5KZwE9xl6DoVBjgPCYheAfovtVFOD4=;
        b=itHRMICnkB7pLN9/Pu5vpN+XrSTGcjTYyImdDtP8wVqPSI2aKwSIg53XCcjLLlYN/z4hY1
        6vMlN7OFW3N9pG93I/UuYjzM539cpOTW0xecg9rtJ/GnL0fP+tbL4jHE996H/CciwxovbT
        Lmv/H8uZeSWd6c7oOn18RY+rsIxhlqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-d-FGsx8gO-upUN1F54VMfw-1; Wed, 05 Jul 2023 13:16:04 -0400
X-MC-Unique: d-FGsx8gO-upUN1F54VMfw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso47367665e9.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 10:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577363; x=1691169363;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T35piQgq4+7zJ5KZwE9xl6DoVBjgPCYheAfovtVFOD4=;
        b=hOfKwhKM3B2kaNjjxWykigblRP6NOOVxdWKFyurmZETJHPWxfYyW7fsOHVOZNqHr6b
         80WxQXfTGhxtZb/pUqL5W01GLsQBV7hRhX4/1adgKFdi5xDa55XgunQh8+dvIy26tM4n
         3U6X7MNylMUBKwGSvOuv7XR9MzgwJseQ9mfuEmyj//t6qXdV8aBHN6xLxLcuCmeNrM7C
         aDmwX4J4Da6+FBN5s9RQ/6eSouyS431+HmkmDX4y5cFbxYUm8lRMJ0uhI23SiIz6QV1d
         bLXwrFsuFH8z+7Engfv/YmnIN0AWCNRnTutLe0YrDUnIQyXPZXdZJ0wdWij82atuYLAZ
         fU8A==
X-Gm-Message-State: ABy/qLYBR5S/C9JWtqpmOC5RiRDMu1v8TFrWLOdC+LJQQVx9sqHPmubJ
        x2QMRvAobEUDolz/vIuSjUcsNXGam6bMBQu5Am0JwqfxXZQNVq0xFLVUnL51JF4+TQsUgNZfuvI
        Es/f1EqWxrAWZA+Tv
X-Received: by 2002:a5d:55d1:0:b0:314:3b9c:f02f with SMTP id i17-20020a5d55d1000000b003143b9cf02fmr6981139wrw.49.1688577363536;
        Wed, 05 Jul 2023 10:16:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUfAcMRX29HqJCQ1c1CH56suwm4NfOCQ9BPaxEr09A1xPnlHPvpu8OfU/EAZeHFIGE5k7pgw==
X-Received: by 2002:a5d:55d1:0:b0:314:3b9c:f02f with SMTP id i17-20020a5d55d1000000b003143b9cf02fmr6981094wrw.49.1688577363129;
        Wed, 05 Jul 2023 10:16:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c294a00b003fbaade0735sm2682596wmd.19.2023.07.05.10.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:16:02 -0700 (PDT)
Message-ID: <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
Date:   Wed, 5 Jul 2023 19:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
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
 <20230705171213.2843068-3-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230705171213.2843068-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> A memory corruption was reported in [1] with bisection pointing to the
> patch [2] enabling per-VMA locks for x86.
> Disable per-VMA locks config to prevent this issue while the problem is
> being investigated. This is expected to be a temporary measure.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
> [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
> 
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   mm/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..0abc6c71dd89 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
>          def_bool n
>   
>   config PER_VMA_LOCK
> -	def_bool y
> +	bool "Enable per-vma locking during page fault handling."
>   	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> +	depends on BROKEN
>   	help
>   	  Allow per-vma locking during page fault handling.
>   
Do we have any testing results (that don't reveal other issues :) ) for 
patch #1? Not sure if we really want to mark it broken if patch #1 fixes 
the issue.

-- 
Cheers,

David / dhildenb

