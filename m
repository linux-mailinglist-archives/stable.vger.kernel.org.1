Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC874D410
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGJLB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGJLB0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 07:01:26 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8DB1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 04:01:23 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso5488465e9.1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 04:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986882; x=1691578882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/8Cp2LKOxEnOhplNaNGG/Ckc9tJgRB9yfMo4YldCZM=;
        b=UgwL+yHgOgpSlUb+TcG7EXf+xmiGppMYzAqz9hg3Lxgk3DDrYAQPOQKAswO5mVNyhT
         OApST8mSR28/Y7mQvoMKHGRhiixwFrYLH2XeRPOVxhWFdaykonTDAz0KeBPydoJmIdxi
         skEC9iCyuEL29gd8RePLBRK7ZroiX6gZQKNGgcnr7lKl5nVNSB+ErYpfqet3PMHts+lR
         GBGz+8EauPus+B/xrLcn+jPfiuM3l0dnuJp646Q2PgnrMefaPo2Zc2qx1kwmXMem+CcW
         gV+3e56vO6wxnvgxYiqBnbga/dOqOFyTNs06OV7Sneu5n10TLW3tZMgUapVWo0YmONM+
         IhbQ==
X-Gm-Message-State: ABy/qLa8SkFJPfNzGst95s/oqtMXWCzJv7ISikHeToAEuqcDYpFDRWoe
        G9xh8pd0LJpDouoPyww2yJQiNzwLUtw=
X-Google-Smtp-Source: APBJJlFpEEu2lBDj2f8kzLvrdALdGTnxlGgrDO1CEksYTXuEOWIlb3jf713ghnxx8stoxZG7vAvwvg==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr11357372wmn.1.1688986880493;
        Mon, 10 Jul 2023 04:01:20 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c021900b003fbc30825fbsm9986594wmi.39.2023.07.10.04.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:01:19 -0700 (PDT)
Message-ID: <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
Date:   Mon, 10 Jul 2023 14:01:18 +0300
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
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
 <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 7/10/23 12:50, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 12:27:31PM +0300, Sagi Grimberg wrote:
>>
>>>>>>> I still want your patches for tcp/rdma that move the freeze.
>>>>>>> If you are not planning to send them, I swear I will :)
>>>>>>
>>>>>> Ming, can you please send the tcp/rdma patches that move the
>>>>>> freeze? As I said before, it addresses an existing issue with
>>>>>> requests unnecessarily blocked on a frozen queue instead of
>>>>>> failing over.
>>>>>
>>>>> Any chance to fix the current issue in one easy(backportable) way[1] first?
>>>>
>>>> There is, you suggested one. And I'm requesting you to send a patch for
>>>> it.
>>>
>>> The patch is the one pointed by link [1], and it still can be applied on current
>>> linus tree.
>>>
>>> https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
>>
>> This is separate from what I am talking about.
>>
>>>>> All previous discussions on delay freeze[2] are generic, which apply on all
>>>>> nvme drivers, not mention this error handling difference causes extra maintain
>>>>> burden. I still suggest to convert all drivers in same way, and will work
>>>>> along the approach[1] aiming for v6.6.
>>>>
>>>> But we obviously hit a difference in expectations from different
>>>> drivers. In tcp/rdma there is currently an _existing_ bug, where
>>>> we freeze the queue on error recovery, and unfreeze only after we
>>>> reconnect. In the meantime, requests can be blocked on the frozen
>>>> request queue and not failover like they should.
>>>>
>>>> In fabrics the delta between error recovery and reconnect can (and
>>>> often will be) minutes or more. Hence I request that we solve _this_
>>>> issue which is addressed by moving the freeze to the reconnect path.
>>>>
>>>> I personally think that pci should do this as well, and at least
>>>> dual-ported multipath pci devices would prefer instant failover
>>>> than after a full reset cycle. But Keith disagrees and I am not going to
>>>> push for it.
>>>>
>>>> Regardless of anything we do in pci, the tcp/rdma transport
>>>> freeze-blocking-failover _must_ be addressed.
>>>
>>> It is one generic issue, freeze/unfreeze has to be paired strictly
>>> for every driver.
>>>
>>> For any nvme driver, the inbalance can happen when error handling
>>> is involved, that is why I suggest to fix the issue in one generic
>>> way.
>>
>> Ming, you are ignoring what I'm saying. I don't care if the
>> freeze/unfreeze is 100% balanced or not (for the sake of this
>> discussion).
>>
>> I'm talking about a _separate_ issue where a queue
>> is frozen for potentially many minutes blocking requests that
>> could otherwise failover.
>>
>>>> So can you please submit a patch for each? Please phrase it as what
>>>> it is, a bug fix, so stable kernels can pick it up. And try to keep
>>>> it isolated to _only_ the freeze change so that it is easily
>>>> backportable.
>>>
>>> The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
>>> recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.
>>
>> Ming, this is completely separate from what I'm talking about. This one
>> is addressing when the controller is removed, while I'm talking about
>> the error-recovery and failover, which is ages before the controller is
>> removed.
>>
>>> But as we discussed, we still want to call freeze/unfreeze in pair, and
>>> I also suggest the following approach[2], which isn't good to backport:
>>>
>>> 	1) moving freeze into reset
>>> 	
>>> 	2) during resetting
>>> 	
>>> 	- freeze NS queues
>>> 	- unquiesce NS queues
>>> 	- nvme_wait_freeze()
>>> 	- update_nr_hw_queues
>>> 	- unfreeze NS queues
>>> 	
>>> 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
>>> 	
>>> 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
>>> 	
>>> 	- otherwise, fail the request
>>>
>>>
>>> [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc
>>
>> Ming, please read again what my concern is. I'm talking about error recovery
>> freezing a queue, and unfreezing only after we reconnect,
>> blocking requests that should failover.
> 
>  From my understanding, nothing is special for tcp/rdma compared with
> nvme-pci.

But there is... The expectations are different.

> All take two stage error recovery: teardown & [reset(nvme-pci) | reconnect(tcp/rdma)]
> 
> Queues are frozen during teardown, and unfreeze in reset or reconnect.
> 
> If the 2nd stage is failed or bypassed, queues could be left as frozen
> & unquisced, and requests can't be handled, and io hang.
> 
> When tcp reconnect failed, nvme_delete_ctrl() is called for failing
> requests & removing controller.
> 
> Then the patch of "nvme: mark ctrl as DEAD if removing from error recovery"
> can avoid this issue by calling blk_mark_disk_dead() which can fail any
> request pending in bio_queue_enter().
> 
> If that isn't tcp/rdma's issue, can you explain it in details?

Yes I can. The expectation in pci is that a reset lifetime will be a few
seconds. By lifetime I mean it starts and either succeeds or fails.

in fabrics the lifetime is many minutes. i.e. it starts when error
recovery kicks in, and either succeeds (reconnected) or fails (deleted
due to ctrl_loss_tmo). This can take a long period of time (if for
example the controller is down for maintenance/reboot).

Hence, while it may be acceptable that requests are blocked on
a frozen queue for the duration of a reset in pci, it is _not_
acceptable in fabrics. I/O should failover far sooner than that
and must _not_ be dependent on the success/failure or the reset.

Hence I requested that this is addressed specifically for fabrics
(tcp/rdma).

Now, I did mention that I think that pci should behave similar to this,
but that is arguable and is only my opinion, and should be separate from
fixing the issue noted above for tcp/rdma.
