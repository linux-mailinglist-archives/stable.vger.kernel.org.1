Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5BA74D855
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGJOAs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGJOAr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 10:00:47 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220FDF
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 07:00:46 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3159acfc48cso263582f8f.1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688997645; x=1691589645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJErA4qd0WElNqdpCU9r0IqbOD1q4SGivoPWezaKt4c=;
        b=cPeyXwtePGXOJZOy5e3LDNluVRFwbGE7wpUXyhb9orw2Ca/9I9GX0B/bVEZgbP36rx
         4NKcds3tbuGAGA6df2nRjZGVnPzWh5TFLgbLcpp+0IYtdXZYQ10dhBeKOuFqNahCXzTB
         AFNo0tChwsFzdmK7vLgVSR8U8FzScaslkiQdzxdRg2qutfX3zGBFLkddMuSvLAAAzg4s
         4boG81+E1IJ9r4X/b/kGn+njVa0yRAbr0wqYGD8xJvFV83KIXgsixNTCAlkd+8Yjmg9V
         acvEGLu3dtm8ef8e7dP+ZiZg2USbvoWwwXrX7+vyDVHD3IQ7D/N0H5sm6ManKIgf7J6Z
         bBJg==
X-Gm-Message-State: ABy/qLYEILxj8e7apLexEr2blD+7hxD7Pwh5exf509otwbvNdtl1SF81
        GxnpyrLnuGwpXOK5dR+Kab4=
X-Google-Smtp-Source: APBJJlF73m+d9scSG+8ojwGGRP7yqIeKpmYFj2IXxvl71h2CAMXT77QemBG3NAIpqjmMCn+LlZozpA==
X-Received: by 2002:adf:cd86:0:b0:314:1af1:4ea6 with SMTP id q6-20020adfcd86000000b003141af14ea6mr12094698wrj.5.1688997644245;
        Mon, 10 Jul 2023 07:00:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0030fb828511csm11729959wrt.100.2023.07.10.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:00:43 -0700 (PDT)
Message-ID: <4f9a578c-8aa6-5a87-884f-77271b5946f3@grimberg.me>
Date:   Mon, 10 Jul 2023 17:00:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
 <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
 <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
 <ZKvsGuYrf+tJTy41@ovpn-8-33.pek2.redhat.com>
 <725f5e57-7900-3836-6232-ce862ae9971e@grimberg.me>
 <ZKwHPqi21HUNUyaY@ovpn-8-33.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKwHPqi21HUNUyaY@ovpn-8-33.pek2.redhat.com>
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


>>> OK, I got your idea now, but which is basically not doable from current
>>> nvme error recovery approach.
>>>
>>> Even though starting freeze is moved to reconnect stage, queue is still
>>> quiesced, then request is kept in block layer's internal queue, and can't
>>> enter nvme fabric .queue_rq().
>>
>> See error-recovery in nvme_[tcp|rdma]_error_recovery(), the queue is
>> unquiesced for fast-failover.
> 
> OK, sorry for missing the nvme_unquiesce_io_queues() called in
> nvme_tcp_error_recovery_work().
> 
> After moving start_freeze to nvme_tcp_reconnect_ctrl_work, new request
> can enter queue quickly, and all these requests may not be handled
> after reconnection is done because queue topo may change. It looks not
> an issue for mpath, but could be one trouble for !mpath, just like
> nvme-pci. I guess you don't care !mpath?

First, !mpath is less of a concern for fabrics, although it should still
work.

In the !mpath case, if the cpu topology changes, then this needs to be
addressed specifically, and it is a secondary issue, far less important
than not failing over quickly.

> nvme_tcp_queue_rq() highly depends on ctrl state for handling request
> during error recovery, and this way is actually fragile, such as:
> 
> 1) nvme_unquiesce_io_queues() has to be done after ctrl state is changed
> to NVME_CTRL_CONNECTING, in nvme_tcp_error_recovery_work().
> 
> At least we should be careful for this change.

queue_rq() depends on ctrl->state but also queue state, and the latter
is guaranteed to be stable across quiesce/unquiesce. This is already
the case today.
