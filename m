Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFB79382D
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjIFJ1Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjIFJ1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 05:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7016C19A5
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693992347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgEkHsGdpRqcvYX0da/cy0loLUWa6HLebB2lSTpxdrI=;
        b=gRzSS7jSESFH9mpz44gsD+D7Anc0BOcmwgbNep4dZW/5iKvYxGOTfC3ysN4hJwmOv7z0vL
        xRKWkQiVu7/ldglGoBhqDWXajxnBeglDh7Of6Or8d2KIhMt/xxMANd7N2X6h/GbQFv8mrU
        wMHCE/JDyxrrdwza/ve/Hg6nJpCS2iQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-VCSsCySjM3yMsJr82ckn0Q-1; Wed, 06 Sep 2023 05:25:45 -0400
X-MC-Unique: VCSsCySjM3yMsJr82ckn0Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401d8873904so22075125e9.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 02:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992345; x=1694597145;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgEkHsGdpRqcvYX0da/cy0loLUWa6HLebB2lSTpxdrI=;
        b=AsfLSHrAc1KiubbPGAPKai1tX9S2OMtmt81NGKInoXtl4k3DsoB+hM/gyV3xZ6IlbK
         kIBdeGnXbaRrc38UURtziNGcPwZjU1BtfczC1ZM1bJygbndgu/DjYCfafDIDn/BNWXjC
         x404jbgnkZQaGUCZ4CZ7t2AbGNrxHxGmr0JUnIKFWJXhFe4AcvSa1gLxFrdIrwUUFU5S
         2Y8FcQ9qQhM1kDKZKWldEy0/QtMEWtU0bfP6m22LciUXdJzJIG4MH85dvX5SlQyLG/6G
         PerAemD4Ns8LAzQUhRopjEGFmDClRt0TiiYyI/G6+j8VqVjj005ZOjFlOBBEApwGiBpA
         JlOQ==
X-Gm-Message-State: AOJu0YxsIlh42htuMKDp4LBR7ZS+QxMX8UrCR48Btz/YeKtwqlmfgFrZ
        l9taYOoGTD8T9CcNMQKqUC6MPQXQsVsDwlEazldRKelU994hj0gER5bm0ojP2BHMsuTxsTO1+GA
        pVuK0KRoC2XgEM6V+nBrQaVGF
X-Received: by 2002:a05:600c:20b:b0:401:b654:e8e7 with SMTP id 11-20020a05600c020b00b00401b654e8e7mr1697287wmi.28.1693992344782;
        Wed, 06 Sep 2023 02:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomZgZd0CazilTNSjLAWduPHkfO6+U+EB7X92VBI/6sXL99+eZBUtSMQQJxN9YHJ7qrGE8PQ==
X-Received: by 2002:a05:600c:20b:b0:401:b654:e8e7 with SMTP id 11-20020a05600c020b00b00401b654e8e7mr1697276wmi.28.1693992344363;
        Wed, 06 Sep 2023 02:25:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c029100b004013797efb6sm22604068wmk.9.2023.09.06.02.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:25:43 -0700 (PDT)
Message-ID: <4268e128-ce8b-b7da-464e-eda585aeacd6@redhat.com>
Date:   Wed, 6 Sep 2023 11:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] LoongArch: add p?d_leaf() definitions
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
References: <20230906092019.4681-1-zhanghongchen@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230906092019.4681-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.09.23 11:20, Hongchen Zhang wrote:
> When I do LTP test, LTP test case ksm06 caused panic at
> 	break_ksm_pmd_entry
> 	  -> pmd_leaf (Huge page table but False)
> 	  -> pte_present (panic)
> 
> The reason is pmd_leaf is not defined, So like
> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
> add p?d_leaf() definition for LoongArch.
> 
> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
> v2->v3: add Cc: stable@vger.kernel.org
> v1->v2: add Fixes in commit message
> ---
>   arch/loongarch/include/asm/pgtable.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index 370c6568ceb8..ea54653b7aab 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
>   
>   #define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
>   
> +#define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
> +#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
> +
>   #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>   #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

