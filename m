Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21A7937B1
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbjIFJGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjIFJGp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 05:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B7E55
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693991150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chKQurrW+qzT3UcyeXlmBgiwn3xeP2j5rksyugxY5jY=;
        b=f7o82OXa4AUZoTUtv7HcOmSrGW0ufrF8LtN/YIgvXRjp/9trURoPlfLyCsA/xY2NL+ShPv
        lX3jXh+lZA5SyU0gtazRfrEoToOHOu2ByZ0tZf2Dz6KcUflz4lYcTTVN84G6bQJpZ1LbA2
        3sQdiqmU7f13CaI4AHzJafqhpbyIF28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-PSGcvtoVNpaK1XCFVjtwGg-1; Wed, 06 Sep 2023 05:05:49 -0400
X-MC-Unique: PSGcvtoVNpaK1XCFVjtwGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31aca0c0d63so1784035f8f.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 02:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693991148; x=1694595948;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chKQurrW+qzT3UcyeXlmBgiwn3xeP2j5rksyugxY5jY=;
        b=CYw+nQ41GpmJy3VYlzM4YriiSOWZ9DzaYif210kr26cAmOTcOKP96nGWlAIg7pIaQ7
         3NWSmjj4DtprbBlKtvgkT4NBOF5nG4k+T+vqbAFhNIrMPGtLZxs9rOidp9mGUj6Q+kOF
         NN+KkkbYqF3sRpK/Lk2DGR63sIdwUzYhfouy0pH8kN9QLl2bObSusVi883aJUvWAKt2T
         6/BVJVNTe+P9LCoXdO8pYr4gkv2xj+USZIU0S9ShwzCLL68nxRDhq3Bia2TN5UFGwq2u
         Pvz34QWpr7IerhOf5oZu9lQJ1BwCd2R5rBCqyrUSKVgKdp2/7O8KMubhsiFEzL4u8h7U
         nvCA==
X-Gm-Message-State: AOJu0YyBX7A7BiQXuXQ0H3tQLRW8KVyvlo2WMr5JT1b7f9I/52WE9FfY
        ALAcOzv17Oa/DBAScEwYHfUnWUMAjWSqH2JlwVS9jbY4QDA/eG5lx1KDUy2Schcsvz+g6v8Ah/C
        oRa8MuxybDl1fiZA8OY0g9qHp
X-Received: by 2002:a05:6000:1190:b0:313:f399:6cea with SMTP id g16-20020a056000119000b00313f3996ceamr1651719wrx.4.1693991148122;
        Wed, 06 Sep 2023 02:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsivuLrPX9pdJapfOw4A4xSX1nGHA3oFlyGfxe6iSFcqhu4RXjCrCd4jgpSExVnq7pJTDYg==
X-Received: by 2002:a05:6000:1190:b0:313:f399:6cea with SMTP id g16-20020a056000119000b00313f3996ceamr1651698wrx.4.1693991147639;
        Wed, 06 Sep 2023 02:05:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id p6-20020adfce06000000b0031ad2f9269dsm19985659wrn.40.2023.09.06.02.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:05:47 -0700 (PDT)
Message-ID: <a2e324f9-665b-d5ae-f6a5-fff138447e20@redhat.com>
Date:   Wed, 6 Sep 2023 11:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] LoongArch: add p?d_leaf() definitions
Content-Language: en-US
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230906084351.3533-1-zhanghongchen@loongson.cn>
 <f7ca2e61-825a-f6cb-09b0-3b12e2c308ac@redhat.com>
 <09c3b714-2325-feee-bf13-50ad844cf817@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <09c3b714-2325-feee-bf13-50ad844cf817@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.09.23 11:05, Hongchen Zhang wrote:
> On 2023/9/6 下午4:45, David Hildenbrand wrote:
>> On 06.09.23 10:43, Hongchen Zhang wrote:
>>> When I do LTP test, LTP test case ksm06 caused panic at
>>>      break_ksm_pmd_entry
>>>        -> pmd_leaf (Huge page table but False)
>>>        -> pte_present (panic)
>>>
>>> The reason is pmd_leaf is not defined, So like
>>> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
>>> add p?d_leaf() definition for LoongArch.
>>>
>>> v2: add Fixes: in commit message.
>>
>> This belongs under the "---". I assume whoever picks that up can fix it up.
>>
> OK, let me change it under the "---".
>>>
>>> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>> ---
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> We should CC stable. I assume whoever picks that up can fix it up.
> OK,let me add Cc: stable@ the commit message.

Probably no need to resend.

-- 
Cheers,

David / dhildenb

