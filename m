Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2D7062F4
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEQId3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjEQIc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 04:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37055AE
        for <stable@vger.kernel.org>; Wed, 17 May 2023 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+87hwHfuK6j4i/fuLrmFREP9Nl0u0nKS6+0RzbNzN84=;
        b=O6PMMZZ9/gwFw0XRtwBY0K5AXmr1h3tMjG6AhBCDjQ1ps6ot/s6qEwJ7RcI/w0948OXmAq
        JFWi6wHVQKz44cfm4+FubutqbNBbv/nUixuNYSjU8DQSMZZvy/FhmTG2gWLaIsyPEVlix8
        h91sSe0U7XrwfP5m2Jax4/QyTwWL/iA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-gK92faqeOz22_2DjsP7L0A-1; Wed, 17 May 2023 04:31:17 -0400
X-MC-Unique: gK92faqeOz22_2DjsP7L0A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3093b0cf714so178384f8f.2
        for <stable@vger.kernel.org>; Wed, 17 May 2023 01:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312276; x=1686904276;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+87hwHfuK6j4i/fuLrmFREP9Nl0u0nKS6+0RzbNzN84=;
        b=VEYgBW7VfZtRah9OmclaqROjjv1KP+098Q1VwaglnTI6SwnZVvxNLd7YSdDzCCK0fv
         9ewgVSPPtuDapDrvzOcN6LwsjM6b7BIK3H8oODNlbiBdcpsau+45QCluhMUHhqUgt3oY
         hE8o3VPaKLs+Pcd15zLxJqcEnfWggDnaoOSjJ1vVv+/mOzHUNB4yJa7jzPMV51OqKa62
         JxSkwhDI+B9EguWhBDp0uporS6ndXhIKrXgw1hUSHcZdbm6sDcjf0uNGEytGF4nXt9/8
         OOjPP5e15doFRCo+d0+15s2qJhlR7N/uFvXGLS6rfDycjZHoIa3skoGuY8qYm4481jU9
         5uqQ==
X-Gm-Message-State: AC+VfDzMvA/GMqSJW62W/wICh2SRC+p6SiU+eQGMcGRMnOAKlDYS0Cum
        xo6YDEN0aNKpo1icPZfyZyqQ6Tlue4CJqWzaVfwc8jp2C+jw7NutlNXMG9AJS1/7QyCN31AcqyU
        PgAyWxGkZ/skBMg2F
X-Received: by 2002:a5d:5221:0:b0:2fb:703d:1915 with SMTP id i1-20020a5d5221000000b002fb703d1915mr26788405wra.43.1684312276040;
        Wed, 17 May 2023 01:31:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QaVKwS34M34vksP3fcVTyCM0DHux/DI1V9/o+0472vKaGysoi00ZT1X872bnMVy2FbYiUrw==
X-Received: by 2002:a5d:5221:0:b0:2fb:703d:1915 with SMTP id i1-20020a5d5221000000b002fb703d1915mr26788385wra.43.1684312275770;
        Wed, 17 May 2023 01:31:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b003078bb639bdsm1934194wrz.68.2023.05.17.01.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:31:15 -0700 (PDT)
Message-ID: <86142559-f15c-938a-a0eb-1ea590cb5e91@redhat.com>
Date:   Wed, 17 May 2023 10:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
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
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com>
 <91246137-a3d2-689f-8ff6-eccc0e61c8fe@redhat.com>
 <CAMn1gO4cbEmpDzkdN10DyaGe=2Wg4Y19-v8gHRqgQoD4Bxd+cw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMn1gO4cbEmpDzkdN10DyaGe=2Wg4Y19-v8gHRqgQoD4Bxd+cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>>> Is there any other way of handling this? E.g. not release the metadata
>>> in arch_swap_invalidate_page() but later in set_pte_at() once it was
>>> restored. But then we may leak this metadata if there's no set_pte_at()
>>> (the process mapping the swap entry died).
>>
>> That was my immediate thought: do we really have to hook into
>> swap_range_free() at all?
> 
> As I alluded to in another reply, without the hook in
> swap_range_free() I think we would either end up with a race or an
> effective memory leak in the arch code that maintains the metadata for
> swapped out pages, as there would be no way for the arch-specific code
> to know when it is safe to free it after swapin.

Agreed, hooking swap_range_free() is actually cleaner (also considering 
COW-shared pages).

> 
>> And I also wondered why we have to do this
>> from set_pte_at() and not do this explicitly (maybe that's the other
>> arch_* callback on the swapin path).
> 
> I don't think it's necessary, as the set_pte_at() call sites for
> swapped in pages are known. I'd much rather do this via an explicit
> hook at those call sites, as the existing approach of implicit
> restoring seems too subtle and easy to be overlooked when refactoring,
> as we have seen with this bug. In the end we only have 3 call sites
> for the hook and hopefully the comments that I'm adding are sufficient
> to ensure that any new swapin code should end up with a call to the
> hook in the right place.


Agreed, much cleaner, thanks!

-- 
Thanks,

David / dhildenb

