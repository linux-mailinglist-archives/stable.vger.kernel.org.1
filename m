Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE47B7C70
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjJDJlj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbjJDJli (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:41:38 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CADB8
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 02:41:34 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so4039165e9.0
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 02:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412493; x=1697017293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMada/Ec0wG4fmWRFeePI5fo54s5fxBvPZqeUNAEsQ=;
        b=vroSNr+OW2OSmzlsVTWvDAWBB3w1GhSpB2InyVM6zr0VQC4NFhAEM90dS9tWUC2WY3
         kQVEW/AOwUW2d/ubPkcXHnYot8dRBQyNEUCiA00Dod4GPyO+jnmHDkWBCNYaSwzmSD6f
         hxQ+rcslAhFca/0K0V4lrz3Xg0mmYTqYB1UcFBFR6TH7G9oU2LzDWlacs8gvpSV5A3uB
         yQp5MpKmtkIA2mGMdINmljbO9ReA1rtOS3IPb7Ox0k65zc9U/4MFpOfZn1rimCcrpqkY
         trZ78rrb0aumKSYLKPui0FOA2jWBbjT0RHHjyztAgN2cTJOOubd4BpSOyE/O+S+39alw
         aDHQ==
X-Gm-Message-State: AOJu0YxKfMFUx07WhGH20MqTXqxE5i8Bcz/Cl2MtgIXFToS/KbkYdmEV
        xS/WNozx3IBsjVslW1s8xoHt1UgPmpY=
X-Google-Smtp-Source: AGHT+IH3qG8Om251uKRLbUeetK66chKfQ2k0y45RvwLUdJVPnRg/N2oAEEd7YFcUyATWhHpskEOdiw==
X-Received: by 2002:a05:600c:3b9a:b0:3fe:21a6:a18 with SMTP id n26-20020a05600c3b9a00b003fe21a60a18mr1737804wms.3.1696412492367;
        Wed, 04 Oct 2023 02:41:32 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b00405391f485fsm1043839wmb.41.2023.10.04.02.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:41:31 -0700 (PDT)
Message-ID: <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
Date:   Wed, 4 Oct 2023 12:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Content-Language: en-US
To:     sj@kernel.org
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
References: <20231003164638.2526-1-sj@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231003164638.2526-1-sj@kernel.org>
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


> Hello,
> 
> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>>  From Alon:
>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>> a malicious user can cause a UAF and a double free, which may lead to
>> RCE (may also lead to an LPE in case the attacker already has local
>> privileges)."
>>
>> Hence, when a queue initialization fails after the ahash requests are
>> allocated, it is guaranteed that the queue removal async work will be
>> called, hence leave the deallocation to the queue removal.
>>
>> Also, be extra careful not to continue processing the socket, so set
>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>
>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Would it be better to add Fixes: and Cc: stable lines?

This issue existed since the introduction of the driver, I am not sure
it applies cleanly that far back...

I figured that the description and Reported-by tag will trigger stable
kernel pick up...
