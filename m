Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5B7B80CA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbjJDNZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjJDNZW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 09:25:22 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DCAB
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 06:25:16 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3233799e7b8so381068f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 06:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425915; x=1697030715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x94YbsbSTLVHjbOsIERIQoPyFZlZNAwxCbQQ5f6DtmQ=;
        b=MqCCl+R2dT5wxrUyllzggk1iyteZZWlzfzW5lFpJCSzkrvXOxKKEZ3JFqGR/tqlsIl
         UWr16ofyS2uESuHNlGhBF0BI9IdGx1XWuhosgsdU+hczmu0+E9FeidEFWq45yeOx4KOQ
         jMa8k/k2yBqEj7A+Go0sx7qhUgGQFA+NjVS859a3TNaMwu0BmGohV+vtFZa3yQ1ZXcLB
         xPJtTS9Ja2yhZVYfK6z0gjLU/LruhnKt0Su126f//9JslZzh0/7k8aDZAQWNKZx6LP7p
         LBEH1Xv/EvIlFmTjXZ7I5jZp4hDalNK0lVp9Ck/zgJBUybOr162QJUKnOndCSGwx+kfR
         ZSKw==
X-Gm-Message-State: AOJu0YyE2pwm3B5mjtp1NuOc+WflSqY8syWNCYbsbjfw6tHFwAuZPoQ5
        iPjJPnknXtllBzhCngATF04=
X-Google-Smtp-Source: AGHT+IHFQkJDxGFmCudeiB5949yF1YnKz6QMHwMKy7Qj+AJ3Ffn2NifH2gChfI7c3pJrgqyfqXRp7g==
X-Received: by 2002:adf:f14e:0:b0:320:b1e:7e6c with SMTP id y14-20020adff14e000000b003200b1e7e6cmr2070349wro.3.1696425915101;
        Wed, 04 Oct 2023 06:25:15 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d6a09000000b003232380ffd5sm4009545wru.106.2023.10.04.06.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:25:14 -0700 (PDT)
Message-ID: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
Date:   Wed, 4 Oct 2023 16:25:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sj@kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
 <2023100445-twisted-everyone-be72@gregkh>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2023100445-twisted-everyone-be72@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>>> Hello,
>>>
>>> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>>>
>>>>   From Alon:
>>>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>>>> a malicious user can cause a UAF and a double free, which may lead to
>>>> RCE (may also lead to an LPE in case the attacker already has local
>>>> privileges)."
>>>>
>>>> Hence, when a queue initialization fails after the ahash requests are
>>>> allocated, it is guaranteed that the queue removal async work will be
>>>> called, hence leave the deallocation to the queue removal.
>>>>
>>>> Also, be extra careful not to continue processing the socket, so set
>>>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>>>
>>>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>
>>> Would it be better to add Fixes: and Cc: stable lines?
>>
>> This issue existed since the introduction of the driver, I am not sure
>> it applies cleanly that far back...
>>
>> I figured that the description and Reported-by tag will trigger stable
>> kernel pick up...
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

I could have sworn to have seen patches that did not have stable CCd
nor a Fixes tag and was picked up for stable kernels :)
But I guess those were either hallucinations or someone sending patches
to stable...

I can resend with CC to stable.

Thanks.
