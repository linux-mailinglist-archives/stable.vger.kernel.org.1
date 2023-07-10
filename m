Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723F74CFDA
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 10:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjGJIYO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjGJIYA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 04:24:00 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45CE1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 01:23:48 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso5181625e9.1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 01:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977426; x=1691569426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94JwxtFLN3WnFOVWsRjqf+GWsT36hiQtk9qcpxUhQjQ=;
        b=Swp9A/eazUcyf8fTxi0FMu/fSWn98YNPb6eimbg4qOOSKy5r34i21NpjvFGpz7fDhj
         g0cvZj/3d88WuSlljnGgPE7d8PzMUBZ8Q0kXRDZSySqUkyPE3GOP5cUZ0biErVkFAwK2
         pOGbo2HXNxFt5LE5jz1BATYh1UcitIU3taISw046XydE6rk4UTNGOTj60sUpAIYExiIu
         0DyojoUaqxGTPYjUFos9V5fTb6M59WZXkprDtXjXjKhW5K3IVuwqyChT/4IXJsxzve+L
         AwSn1o9FlJWDHPOFE6K3eU2cKYVcOKygbhGF1jS7Ujdg6rJc+5MeZAHBhWS2VOWHh8Rl
         B64Q==
X-Gm-Message-State: ABy/qLbh5Cd5VC6G9thZsLjpvO3aeGjxkIoRcfqblbuo0wuMvRQxSl9P
        gUyhXbV0IBl0ZmOwbpqRPsU=
X-Google-Smtp-Source: APBJJlHVH2Ob+BwdBbZ2GgJjym2J/v5gNpyZn7gOEHxyw8ZyJ2lxZ5qJhodLk0UMzMxxJo1MVHrtug==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr10991986wmn.1.1688977426206;
        Mon, 10 Jul 2023 01:23:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k15-20020adff5cf000000b00314398e4dd4sm11070753wrp.54.2023.07.10.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:23:45 -0700 (PDT)
Message-ID: <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
Date:   Mon, 10 Jul 2023 11:23:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


>>>> namespace's request queue is frozen and quiesced during error recovering,
>>>> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <-
>>>> del_gendisk()
>>>> can't move on, and causes IO hang. Removal could be from sysfs, hard
>>>> unplug or error handling.
>>>>
>>>> Fix this kind of issue by marking controller as DEAD if removal breaks
>>>> error recovery.
>>>>
>>>> This ways is reasonable too, because controller can't be recovered any
>>>> more after being removed.
>>>
>>> This looks fine to me Ming,
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>>
>>>
>>> I still want your patches for tcp/rdma that move the freeze.
>>> If you are not planning to send them, I swear I will :)
>>
>> Ming, can you please send the tcp/rdma patches that move the
>> freeze? As I said before, it addresses an existing issue with
>> requests unnecessarily blocked on a frozen queue instead of
>> failing over.
> 
> Any chance to fix the current issue in one easy(backportable) way[1] first?

There is, you suggested one. And I'm requesting you to send a patch for
it.

> 
> All previous discussions on delay freeze[2] are generic, which apply on all
> nvme drivers, not mention this error handling difference causes extra maintain
> burden. I still suggest to convert all drivers in same way, and will work
> along the approach[1] aiming for v6.6.

But we obviously hit a difference in expectations from different
drivers. In tcp/rdma there is currently an _existing_ bug, where
we freeze the queue on error recovery, and unfreeze only after we
reconnect. In the meantime, requests can be blocked on the frozen
request queue and not failover like they should.

In fabrics the delta between error recovery and reconnect can (and
often will be) minutes or more. Hence I request that we solve _this_
issue which is addressed by moving the freeze to the reconnect path.

I personally think that pci should do this as well, and at least
dual-ported multipath pci devices would prefer instant failover
than after a full reset cycle. But Keith disagrees and I am not going to
push for it.

Regardless of anything we do in pci, the tcp/rdma transport 
freeze-blocking-failover _must_ be addressed.

So can you please submit a patch for each? Please phrase it as what
it is, a bug fix, so stable kernels can pick it up. And try to keep
it isolated to _only_ the freeze change so that it is easily
backportable.

Thanks.
