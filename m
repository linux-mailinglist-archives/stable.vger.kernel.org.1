Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C017092E5
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjESJWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjESJWX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 05:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA3E47
        for <stable@vger.kernel.org>; Fri, 19 May 2023 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684488100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWFb7su+l+wO5tmP1uJaxoMrwLD0GIgYT9evuWTAj54=;
        b=W1CH98enTEKi0X4/rQPxKTROeFhJJYHmjKScmE2p1eV+I5neulShL2oQ8TVbM2oPkLtlbO
        IW7/SL1sCq6MDsXlnh+ANWjj9iI0VC83HYChyLkJGFpdcDxKCyr4B5mO5YV341Zig4jNvF
        2T/xjXhlGIHq8R2LH2F9iwV1v0KE4UI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5ZiQNMvYMouxYLRQEp29Qw-1; Fri, 19 May 2023 05:21:38 -0400
X-MC-Unique: 5ZiQNMvYMouxYLRQEp29Qw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so5343625e9.3
        for <stable@vger.kernel.org>; Fri, 19 May 2023 02:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684488097; x=1687080097;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWFb7su+l+wO5tmP1uJaxoMrwLD0GIgYT9evuWTAj54=;
        b=BqyTGQEGrVoKDGQWXsuX6RI+mvGWJeSR4jlSwAfojPO+DM2379wFnw9a3Sn+yBMUkS
         G8lgTPUmmUOspyhxufMYMZujTA6ZjZ1hll+baz1J/rT6KYG1eU+sZJDmZC4hlgBRuPI8
         3b4oU7OprjFTth9m0lAEaAki7Qbn7o4SW54Ir3knVPaybsEtNEtd0DM3UjUJUxH7MRLS
         ekMKg4WqcPnmITCdYHy7nn2CZJm0TrelvcYcaitCCw9aowEAQRZntAlGjk0lwybtXo7F
         z8L8tr1ZCxRpDtovuemmwYvB5MipO8WB9dvWF5FVH0MJcMbQwuDc0jPdwjcYkibAZa8/
         joZA==
X-Gm-Message-State: AC+VfDx9rVDrPlid1EJCIKJPunfAJu9+8/kGFgejY8BzsPDx2bPOB4PN
        0zWqMbRLJG0Y9t51lh0YJxvB22wYGCqnHbcpi7s/XOC/eaOkAWzWOQ/1DTcS3OEppwDYD3nziNE
        PoPB1fC+zpxvERPVM
X-Received: by 2002:a1c:f20b:0:b0:3f4:16bc:bd1b with SMTP id s11-20020a1cf20b000000b003f416bcbd1bmr778346wmc.39.1684488097707;
        Fri, 19 May 2023 02:21:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dz0PcxB7344vGoAWPy4CcML6krGk716U287/gC5ZmUcy5HC+h9blZEghWa25ztRBkBdRg8Q==
X-Received: by 2002:a1c:f20b:0:b0:3f4:16bc:bd1b with SMTP id s11-20020a1cf20b000000b003f416bcbd1bmr778313wmc.39.1684488097347;
        Fri, 19 May 2023 02:21:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:9d00:7421:54d8:9227:a3e8? (p200300cbc7229d00742154d89227a3e8.dip0.t-ipconnect.de. [2003:cb:c722:9d00:7421:54d8:9227:a3e8])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bce10000000b003f435652aaesm1753343wmc.11.2023.05.19.02.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:21:36 -0700 (PDT)
Message-ID: <80f45fec-3e91-c7b3-7fb4-1aa9355c627a@redhat.com>
Date:   Fri, 19 May 2023 11:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
 <ZGLC0T32sgVkG5kX@google.com>
 <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
 <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com>
 <c9f1fc7c-62a2-4768-7992-52e34ec36d0f@redhat.com>
 <CAMn1gO7t0S7CmeU=59Lq10N0WvrKebM=W91W7sa+SQoG13Uppw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
In-Reply-To: <CAMn1gO7t0S7CmeU=59Lq10N0WvrKebM=W91W7sa+SQoG13Uppw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

>> Sorry, I meant actual anonymous memory pages, not shmem. Like, anonymous
>> pages that are COW-shared due to fork() or KSM.
>>
>> How does MTE, in general, interact with that? Assume one process ends up
>> modifying the tags ... and the page is COW-shared with a different
>> process that should not observe these tag modifications.
> 
> Tag modifications cause write faults if the page is read-only, so for
> COW shared pages we would end up copying the page in the usual way,
> which on arm64 would copy the tags as well via the copy_highpage hook
> (see arch/arm64/mm/copypage.c).

Oh, that makes sense, thanks for pointing that out!

... and I can spot that KSM also checks the tag when de-duplicating: 
pages_identical() ends up calling memcmp_pages(), which knows how to 
deal with tags.

Interestingly, calc_checksum() does not seem to care about tags. But 
that simply implies that pages with the same content have same checksum, 
independent of the tag. And pages_identical() is the single source of truth.

-- 
Thanks,

David / dhildenb

