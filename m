Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938477CD73
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjHONmm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjHONmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 09:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46AE1987
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692106891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMyH+V5f7erV6J8zylTxk3b5SVUBFgCYhMVhPcFeR54=;
        b=cxpOEeaR7QL4S2bta4Q1ovAcAHGuM+f9nZ1xyvcKIkHuDGjsgeBtC7gjBhDDfWwafQcMqM
        hPoSSExpOwQ5pDNT/Sa00yZrkBVOogyP/gKm5sQE6japKPO3V/mTOM0QXA5hEWcQVJtIgE
        /WFNQDmDlYNmqjwaHPXkRNpDifO5wuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-uLNv53ybOyuWQQEQOfbIkg-1; Tue, 15 Aug 2023 09:41:29 -0400
X-MC-Unique: uLNv53ybOyuWQQEQOfbIkg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe1bef4223so34255115e9.0
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 06:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692106888; x=1692711688;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMyH+V5f7erV6J8zylTxk3b5SVUBFgCYhMVhPcFeR54=;
        b=P7DuD9LkifGTXSrrKDBGPpq1QYHs7g8KhgjzoIPJTKnK6oX7eMoKvb1TE2DZszvJMI
         9xcURJIGeEyTv5VYjevvWoQDtfPJDfIKQE7qQ+uQNf8YdLibiKXUTsPfg7zCf+UycCn4
         eiCxSP1dCYYdsFc7QyPGdYoT1eBNMFmArqPA9OYhPstggVIM85lUAbwwhGuxGEXa5xia
         27Gw5RBPFUMvv8abnq6EppsEZ3mH6F3Cww/H8NMnlDh9c125gD49hl1MVaTCjY3sVtu0
         C0iGhBFE5qLi4g+pvFxl2Z5KOlsvHJVCZWwtGoZWDUavNnQN8M30KgYAZbc8789/O/on
         T4IQ==
X-Gm-Message-State: AOJu0YxzoRJWpBzeXWJFgDYDRIIEVxLigmqmEMMfc52qSpvEG3fT8AAg
        0nLx5WEdRQ0bErAng0ARYO6sWCm8r8kgPcVjC2qlVSnxqPzu5zpT/XGc3haaNUFz7h0lQ1kSGVB
        5kuGiMnt/Sis0sYds
X-Received: by 2002:a1c:7703:0:b0:3fe:159d:422b with SMTP id t3-20020a1c7703000000b003fe159d422bmr9555543wmi.32.1692106888413;
        Tue, 15 Aug 2023 06:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEohMgclqjLk6u/tJ5HN7LY7eEaXKoQw8K3cOI+vkgVvaQG0WQtFBe8lnw+0331qIMdGjV0lg==
X-Received: by 2002:a1c:7703:0:b0:3fe:159d:422b with SMTP id t3-20020a1c7703000000b003fe159d422bmr9555519wmi.32.1692106888039;
        Tue, 15 Aug 2023 06:41:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm18174992wrq.74.2023.08.15.06.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 06:41:27 -0700 (PDT)
Message-ID: <ea478fa8-655b-90cc-0cd3-5f127e7e68b7@redhat.com>
Date:   Tue, 15 Aug 2023 15:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
 <20230808020917.2230692-4-fengwei.yin@intel.com>
 <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
 <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
In-Reply-To: <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 15.08.23 15:25, Daniel Gomez wrote:
> Hi Yin,
> On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
>> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
>> folio") replaced the page_mapcount() with folio_mapcount() to check
>> whether the folio is shared by other mapping.
>>
>> It's not correct for large folios. folio_mapcount() returns the total
>> mapcount of large folio which is not suitable to detect whether the folio
>> is shared.
>>
>> Use folio_estimated_sharers() which returns a estimated number of shares.
>> That means it's not 100% correct. It should be OK for madvise case here.
> 
> I'm trying to understand why it should be ok for madvise this change, so
> I hope it's okay to ask you few questions.
> 
> folio_mapcount() calculates the total maps for all the subpages of a
> folio. However, the folio_estimated_sharers does it only for the first
> subpage making it not true for large folios. Then, wouldn't this change
> drop support for large folios?

It's all a mess right now.

1) page_mapcount(page): how often it this page mapped

For a THP: entire mapcount of the THP (PMD-mapping) + mapcount of *this 
very subpage* (PTE-mapping) only


2) folio_mapcount(): how often is this folio mapped

For a THP: entire mapcount of the THP (PMD-mapping) + mapcount of *all* 
subpages (PTE-mapping) of the folio


3) folio_estimated_sharers(): how often is the first page mapped

For a THP: entire mapcount of the THP (PMD-mapping) + mapcount of *the 
first subpage* (PTE-mapping) only


For the time being, folio_estimated_sharers() is better then 
folio_mapcount(), because for a PTE-mapped THP folio_mapcount() > 1.

I'm looking into a replacement for folio_estimated_sharers() that is 
more precise ("folio_mapped_shared()"), but it's all a bit tricky. :)

-- 
Cheers,

David / dhildenb

