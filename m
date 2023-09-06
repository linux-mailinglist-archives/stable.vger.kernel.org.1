Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67427793756
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjIFIqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjIFIqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 04:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64CE9
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693989959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiO4dpO0VY1hu4txDNG3Nh8hvwZDWTPnz7X+5XzDdqw=;
        b=Wd+1C1ofL9t1wQ2EFqW+/TEbAKBA35lk14YN6tuHJBh7AzQ7TEau5qUcMvNokJx1ladDJb
        JiqGYAvmzfT4DRtj0NTaaiqh00opWQrCxe9WZt3bUbt7+9S63e1b8YBOcMcr8HCFOXQYJW
        40UW5lx0+qZYLvxCs8aD5odZ0GgXMvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-hvm5EoZiO_aT1TLl6c8blA-1; Wed, 06 Sep 2023 04:45:58 -0400
X-MC-Unique: hvm5EoZiO_aT1TLl6c8blA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315af0252c2so1930680f8f.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989957; x=1694594757;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiO4dpO0VY1hu4txDNG3Nh8hvwZDWTPnz7X+5XzDdqw=;
        b=fMCbyxgFgG4N50/h7qbOSk9B73LtzPS8zqOtFLsDWr1kY5BZtC10sedzjapLtBeCWy
         MLB/vafel4pd4HPzeHPrsmLU4JkYblWmFNvkELmBpABGDsL4p0jFD7x3eXLwAme7UFOz
         g/RkOp2+VgAgxS0eiGaOPTFmfwCV8ekVmStr3wLbZDzh8anLxaNJFFl61UquCRnnkt7E
         Y6upZo7roz75O5ki93SI0x7oB4aiH+MqPrGxRlt4RRbpYeEhMGSgHjE/4221yyT8/P0K
         8sZ+srVr3ktciF3Gh3k+4Mh0aGxMhE7g3fAbLlTH9s3quBtXaUTr1kVQ/eyyKrE+vRcQ
         a+/Q==
X-Gm-Message-State: AOJu0YzcFPvwYaq7I1Z+ZdEApV5Acz1ts683edU0c6IZlGSVcxeVafdH
        Ix1T7IaH17K9dpVEsUqqhGmjvifrTSBL8qS7sgGDDMZv6CQrnn/M8bmCBNiqCz4hxweWbP42rBu
        htVGhDzyGGgq5DUIs
X-Received: by 2002:a5d:464a:0:b0:314:3a3d:5d1f with SMTP id j10-20020a5d464a000000b003143a3d5d1fmr1841535wrs.19.1693989957074;
        Wed, 06 Sep 2023 01:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQmR4iZGBEiYiY4s675XAQ+S5BoOwlY5W6/yYJfzgEBy039rqvKU8y1+dEwqdV6Ytm0AzESA==
X-Received: by 2002:a5d:464a:0:b0:314:3a3d:5d1f with SMTP id j10-20020a5d464a000000b003143a3d5d1fmr1841522wrs.19.1693989956711;
        Wed, 06 Sep 2023 01:45:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000180f00b003142ea7a661sm19636219wrh.21.2023.09.06.01.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:45:55 -0700 (PDT)
Message-ID: <f7ca2e61-825a-f6cb-09b0-3b12e2c308ac@redhat.com>
Date:   Wed, 6 Sep 2023 10:45:54 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230906084351.3533-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.09.23 10:43, Hongchen Zhang wrote:
> When I do LTP test, LTP test case ksm06 caused panic at
> 	break_ksm_pmd_entry
> 	  -> pmd_leaf (Huge page table but False)
> 	  -> pte_present (panic)
> 
> The reason is pmd_leaf is not defined, So like
> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
> add p?d_leaf() definition for LoongArch.
> 
> v2: add Fixes: in commit message.

This belongs under the "---". I assume whoever picks that up can fix it up.

> 
> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

We should CC stable. I assume whoever picks that up can fix it up.

-- 
Cheers,

David / dhildenb

