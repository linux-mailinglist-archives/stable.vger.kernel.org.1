Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF2725642
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjFGHq4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjFGHp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 03:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C6272D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxZp9KdUKEgw6XPITnZ8rbdpOnJBleKSijZBJrFdz/4=;
        b=BAeajZ+1UH+eWyFAEdYDMWu2eircQm1lfJmOkkSSp3vvePZvRrI7aliNnpwXYubfH9YvnA
        1AD0wN6uPbz7IN1rf6SMSqfmfu8Pe0kvCuIQKUoxWuWn9ePsD+Yt6bwow+dH+T9xL3hHDa
        /BicDB4RUXmWy3OCj416KsfuvHlNKeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-DYHKxxVeONufCYprSw2bMg-1; Wed, 07 Jun 2023 03:43:17 -0400
X-MC-Unique: DYHKxxVeONufCYprSw2bMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so1583805e9.1
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 00:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123796; x=1688715796;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxZp9KdUKEgw6XPITnZ8rbdpOnJBleKSijZBJrFdz/4=;
        b=lE3DI4LnpHm3y2WGkK1rrhNKGic0eRtRzSwXIAIX1GQcFWLsBYconSJaOJAWSgN0k8
         k6FbOfQTZfuB3V4k8eP07+jVkZDGrBF83aK8dtc5+XOSsMt/1on6HzbUC9GpQeFQNZ1g
         gbVFgD83Dcdf76gOVgQwvIwaIELnQwThoBORlFVnOZ3S61Ax2GIKjG7mJ68q99++qNy2
         SbEJHoWp/TvfbhoiDEKTED8bpdvtra7bW5tGP1tRTThWm+PoC9nX122UnKTOVit+WPdt
         lT04JhBUJyKCg5iubV7PUpfjh7HgYbnimOHngisl3qLcktF4bn33RWo7dXnF31Mil+ig
         kz0A==
X-Gm-Message-State: AC+VfDyMM+bPHPK973e0fGJmTt5ZMchjtnrrkkKg0lN5+CGgcUdrxf9p
        TSz7cLNM+gCE3F5/Qfut5kFjS9b0meRS1vc9iMu8lR0z6BbWYMeucAoSNCjkIwo1Te1OoxOLfsJ
        8bniQN4GiZIftj//Ge2R0k84I
X-Received: by 2002:a05:600c:354f:b0:3f7:ec38:7b02 with SMTP id i15-20020a05600c354f00b003f7ec387b02mr2772837wmq.3.1686123796421;
        Wed, 07 Jun 2023 00:43:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z/oafmbbbdymBvFhysi9pZ7rB9/GzpxAwi7QXPZLn1SSiVpHCJ+hrMbTgXgCgV2HZ5oGlPA==
X-Received: by 2002:a05:600c:354f:b0:3f7:ec38:7b02 with SMTP id i15-20020a05600c354f00b003f7ec387b02mr2772818wmq.3.1686123796122;
        Wed, 07 Jun 2023 00:43:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003f6038faa19sm1178915wmr.19.2023.06.07.00.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:43:15 -0700 (PDT)
Message-ID: <1b27077f-d4e5-321c-f15e-b1309763806c@redhat.com>
Date:   Wed, 7 Jun 2023 09:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/mprotect: Fix do_mprotect_pkey() limit check
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jeff Xu <jeffxu@chromium.org>, stable@vger.kernel.org
References: <20230606182912.586576-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230606182912.586576-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.06.23 20:29, Liam R. Howlett wrote:
> The return of do_mprotect_pkey() can still be incorrectly returned as
> success if there is a gap that spans to or beyond the end address passed
> in.  Update the check to ensure that the end address has indeed been
> seen.
> 
> Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com/
> Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on error")
> Reported-by: Jeff Xu <jeffxu@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/mprotect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 92d3d3ca390a..c59e7561698c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -867,7 +867,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>   	}
>   	tlb_finish_mmu(&tlb);
>   
> -	if (!error && vma_iter_end(&vmi) < end)
> +	if (!error && tmp < end)
>   		error = -ENOMEM;
>   
>   out:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

