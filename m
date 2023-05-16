Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED11704E1D
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjEPMug (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjEPMu1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 08:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC0BA
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684241383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6ENP1TOkkkwTyntwJbblY7IR/X8Hu2k3+7/H7vMwQQ=;
        b=GlT6ImjpRu0ViHm4NA823p6DWYBzuTQKHtfLAix5/1KfTw8uK8MXb+Wzg9LAuIKJA5pT3p
        cbmXJTpl0hQU+2onuJ85wSHU+sNiQi6UAPd3JWLTB3MoY62/Y2oGL6ZNsSgXKo/jfZXj2p
        mAX6VvbtvGDpV0hMukRLpQFY8uq8Jag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-R3pANYF_NSO2I-hSfXRxag-1; Tue, 16 May 2023 08:49:41 -0400
X-MC-Unique: R3pANYF_NSO2I-hSfXRxag-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so38484065e9.3
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241381; x=1686833381;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6ENP1TOkkkwTyntwJbblY7IR/X8Hu2k3+7/H7vMwQQ=;
        b=OENnmrVr2NzCjkGIpNg3VwMa5Lg0n+R+yBwbhGCHAwXBPzlTn1jxCOAfPbWefxRkCx
         awfeLdjYT9anbMui1b7qt4KkPrvOF0fDjaBeD0rMRMJNmkB8Tir4iDTdnfjwWhTum59O
         MqmDaWDNgI3YKV3UaMMo/hmE0xDOjBBaQoWi6tESqVSRkf/o7sdjKgq8h36vXhMCowdZ
         IBbJ6aed5FWXPe3oOl9w1Ki71SJdjZl8QICtoHxmh05SJtDrtAg6jNc3NNXis01aQIb1
         Tjo3PcsiXmvh8+uyaNNzWQoy4Lb6EhLag3Z+WUns5+tV+8TuhNSCHTxitlcYnuLe5B+C
         QP/Q==
X-Gm-Message-State: AC+VfDwo2E4rRfm1R2lo8sEf7+eM5kx8vyadsqpdneDNE9ohSsfcYMYX
        tgVkU9pPdL2KXf7kPIBcclZKI7/VDqdICldf2nepSb1lIAIdvxvH1ecMH3JI05nZsjlBUHc5uNh
        W++slbk4rZ0zl84tk
X-Received: by 2002:a7b:c419:0:b0:3f4:a09f:1877 with SMTP id k25-20020a7bc419000000b003f4a09f1877mr14616493wmi.23.1684241380831;
        Tue, 16 May 2023 05:49:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ivgr8TxNk6sB2ueojEGiFrdWqV+8bm0pJXqlqC+5ftnqODua46zAlXniDLp2NJ1jyPgJ+8A==
X-Received: by 2002:a7b:c419:0:b0:3f4:a09f:1877 with SMTP id k25-20020a7bc419000000b003f4a09f1877mr14616472wmi.23.1684241380418;
        Tue, 16 May 2023 05:49:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f4f8cc4285sm2236830wmj.17.2023.05.16.05.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:49:39 -0700 (PDT)
Message-ID: <342d76b0-a94f-902a-c701-04a1e477b748@redhat.com>
Date:   Tue, 16 May 2023 14:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] mm: Call arch_swap_restore() from do_swap_page()
Content-Language: en-US
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
References: <20230516023514.2643054-1-pcc@google.com>
 <20230516023514.2643054-2-pcc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230516023514.2643054-2-pcc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 16.05.23 04:35, Peter Collingbourne wrote:
> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
> the call to swap_free() before the call to set_pte_at(), which meant that
> the MTE tags could end up being freed before set_pte_at() had a chance
> to restore them. Fix it by adding a call to the arch_swap_restore() hook
> before the call to swap_free().
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
> Cc: <stable@vger.kernel.org> # 6.1
> Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> Reported-by: Qun-wei Lin (林群崴) <Qun-wei.Lin@mediatek.com>
> Link: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/
> ---
> v2:
> - Call arch_swap_restore() directly instead of via arch_do_swap_page()
> 
>   mm/memory.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01a23ad48a04..a2d9e6952d31 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3914,6 +3914,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		}
>   	}
>   
> +	/*
> +	 * Some architectures may have to restore extra metadata to the page
> +	 * when reading from swap. This metadata may be indexed by swap entry
> +	 * so this must be called before swap_free().
> +	 */
> +	arch_swap_restore(entry, folio);
> +
>   	/*
>   	 * Remove the swap entry and conditionally try to free up the swapcache.
>   	 * We're already holding a reference on the page but haven't mapped it

Looks much better to me, thanks :)

... staring at unuse_pte(), I suspect it also doesn't take care of MTE 
tags and needs fixing?

-- 
Thanks,

David / dhildenb

