Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAF74C172
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGIHid (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGIHic (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 03:38:32 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C16E46
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 00:38:30 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3159709a705so79000f8f.1
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 00:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688888309; x=1691480309;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZT4OUEE+oia2xz8fV8wtOdivzl53DHGkdnBjhas2HQ=;
        b=iamtyWe1Xdv5m1oszi0RZClB+Fw9eQ+e8XNQdlxg8eM6PC7WCdGyr5DX9r8cPPuWaA
         Z2v+PDT6vpGeybCClu5Do2s6/yjwiH2UQsognz1nGFqyaMk5MiG1UnNgmVXv3pTUETL9
         RU82nYK1Vg33NpCZiotYT6A7tcqppzBR2497DwhUxHeBwpfgPllsNz+Rjhr4UI2C6xFM
         6N1P1DDbLb/LETpDNC2TD0a/vOSKCQUWxI8oMtp7c5awj90atxO6romkii6eC+mAlSCk
         X0LIPYyyBlZLtz1RARP3iHxU52qcVdJ9+Jtd6vgOGQPSvGHJldOsQkZwrbmYNz+mBKLy
         D7aw==
X-Gm-Message-State: ABy/qLY85LPsj3EbiFH7He1AvJ5LOLd/N8a4VuOaEKfeQ/uSW8pf8XwL
        Jdh/QM3b3zKtVskHJIt/JlwLFwqaoow=
X-Google-Smtp-Source: APBJJlHPHKnmZpXdI8znJWdCmOoUhYkBUGALeHldxOsv49qxj+ziafD945e+N0G6WiZhxUx82BW1kw==
X-Received: by 2002:a05:600c:4f56:b0:3fb:f025:9372 with SMTP id m22-20020a05600c4f5600b003fbf0259372mr9065197wmq.4.1688888308860;
        Sun, 09 Jul 2023 00:38:28 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fbca05faa9sm6966822wmk.24.2023.07.09.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 00:38:28 -0700 (PDT)
Message-ID: <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
Date:   Sun, 9 Jul 2023 10:38:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
In-Reply-To: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
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


>> namespace's request queue is frozen and quiesced during error recovering,
>> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- 
>> del_gendisk()
>> can't move on, and causes IO hang. Removal could be from sysfs, hard
>> unplug or error handling.
>>
>> Fix this kind of issue by marking controller as DEAD if removal breaks
>> error recovery.
>>
>> This ways is reasonable too, because controller can't be recovered any
>> more after being removed.
> 
> This looks fine to me Ming,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> 
> I still want your patches for tcp/rdma that move the freeze.
> If you are not planning to send them, I swear I will :)

Ming, can you please send the tcp/rdma patches that move the
freeze? As I said before, it addresses an existing issue with
requests unnecessarily blocked on a frozen queue instead of
failing over.
