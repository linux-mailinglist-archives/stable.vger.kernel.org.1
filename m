Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26F75FB52
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGXP6L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGXP6K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 11:58:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE4E57
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:58:07 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-785ccd731a7so46435839f.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690214287; x=1690819087;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nc5Iv/xsRmf5hAfbgU8yv54D1xcQtZAdWk9s6sldGXE=;
        b=ebylMz3k5ToLS/Z8ZYceyScEkn9gG4YQgH8ZTfSRVAMcWdJQDNgoSqRsP0SVtcOJQ5
         HtKkf7R+8mFFxQwA5CiqHkEwOs0fAoR2Q33ifon18NBzGOYsciWo7P3wMmFl9jzaGqGq
         6kEXSFL8i3oX2c0Ad6Zzh3LpDnoTbkyeMUKWpUyNCXzE1RLxEM/RTEEHRMlL2VUE6kFF
         H6wpacZ0bfgF5osjc0ZKwVxtA3BEAOyflyDi/zTJrY0b7liiWq5on2ct19G6Xwi6j3ZA
         SYyNjXIvWCaUSv1X05oIDHBpM3aU6x/i51yH0wNNWG5eeYqXLMvFgEskrgIC740F/eAA
         FvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214287; x=1690819087;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc5Iv/xsRmf5hAfbgU8yv54D1xcQtZAdWk9s6sldGXE=;
        b=BrpFLYkwjndTpcQBrYjYaCdNGlK9WSbLK4ki5cvDtAXnkr0o9Gfj+ZdRaqa8uOKj9P
         mO5ABtM3Vp9pVMFyQNEvyb5n34Q3+q8V1kDQCMQDde5qroO6gF2SvM2RXzAV5yWp1ywZ
         ZKSbhzfW+0vqcxbE0mhN7QBtiYvel5kLL78GgROkuSBFTmXOePE/hbn0oyFW7VmKD0xn
         kKRKTtic9bidGXENUxo9veGTQGIOIhNOVpIXGePGyZ5b5tWgtZ6yYSCh1yiUR01uxgKm
         5844YXk8UzZ9dMG7ZD0GYQZqTfYdyfX25+m6viTlFZombkMHc2qS98oO0bXDiGah7tFc
         k+6A==
X-Gm-Message-State: ABy/qLY2LhzHNe3YWeqj1FX66VPpH3GFt4cePihAWM/h3IPtLEGs8rtO
        NtcEh89d9kCnAASmAVUViRwnuQ==
X-Google-Smtp-Source: APBJJlEe0IRPrJxlaLkqDmmiJ0fOkVc2iIpbyXYTDSjWYUT1S+LC9tVUVEAGA6qMSqB0T6A5C1OMkQ==
X-Received: by 2002:a6b:6903:0:b0:780:d65c:d78f with SMTP id e3-20020a6b6903000000b00780d65cd78fmr7816729ioc.2.1690214287190;
        Mon, 24 Jul 2023 08:58:07 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d850d000000b0076c569c7a48sm3646010ion.39.2023.07.24.08.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:58:06 -0700 (PDT)
Message-ID: <ecb821a2-e90a-fec1-d2ca-b355c16b7515@kernel.dk>
Date:   Mon, 24 Jul 2023 09:58:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Phil Elwell <phil@raspberrypi.com>
Cc:     andres@anarazel.de, asml.silence@gmail.com, david@fromorbit.com,
        hch@lst.de, io-uring@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        stable <stable@vger.kernel.org>
References: <CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com>
 <2023072438-aftermath-fracture-3dff@gregkh>
 <140065e3-0368-0b5d-8a0d-afe49b741ad2@kernel.dk>
In-Reply-To: <140065e3-0368-0b5d-8a0d-afe49b741ad2@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/24/23 9:50?AM, Jens Axboe wrote:
> On 7/24/23 9:48?AM, Greg KH wrote:
>> On Mon, Jul 24, 2023 at 04:35:43PM +0100, Phil Elwell wrote:
>>> Hi Andres,
>>>
>>> With this commit applied to the 6.1 and later kernels (others not
>>> tested) the iowait time ("wa" field in top) in an ARM64 build running
>>> on a 4 core CPU (a Raspberry Pi 4 B) increases to 25%, as if one core
>>> is permanently blocked on I/O. The change can be observed after
>>> installing mariadb-server (no configuration or use is required). After
>>> reverting just this commit, "wa" drops to zero again.
>>
>> This has been discussed already:
>> 	https://lore.kernel.org/r/12251678.O9o76ZdvQC@natalenko.name
>>
>> It's not a bug, mariadb does have pending I/O, so the report is correct,
>> but the CPU isn't blocked at all.
> 
> Indeed - only thing I can think of is perhaps mariadb is having a
> separate thread waiting on the ring in perpetuity, regardless of whether
> or not it currently has IO.
> 
> But yes, this is very much ado about nothing...

Current -git and having mariadb idle:

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     all    0.00    0.00    0.04   12.47    0.04    0.00    0.00    0.00    0.00   87.44
Average:       0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
Average:       1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
Average:       2    0.00    0.00    0.00    0.00    0.33    0.00    0.00    0.00    0.00   99.67
Average:       3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
Average:       4    0.00    0.00    0.33    0.00    0.00    0.00    0.00    0.00    0.00   99.67
Average:       5    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
Average:       6    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00    0.00    0.00
Average:       7    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00

which is showing 100% iowait on one cpu, as mariadb has a thread waiting
on IO. That is obviously a valid use case, if you split submission and
completion into separate threads. Then you have the latter just always
waiting on something to process.

With the suggested patch, we do eliminate that case and the iowait on
that task is gone. Here's current -git with the patch and mariadb also
running:

09:53:49 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
09:53:50 AM  all    0.00    0.00    0.00    0.00    0.00    0.75    0.00    0.00    0.00   99.25
09:53:50 AM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
09:53:50 AM    1    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
09:53:50 AM    2    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
09:53:50 AM    3    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
09:53:50 AM    4    0.00    0.00    0.00    0.00    0.00    0.99    0.00    0.00    0.00   99.01
09:53:50 AM    5    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
09:53:50 AM    6    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
09:53:50 AM    7    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00


Even though I don't think this is an actual problem, it is a bit
confusing that you get 100% iowait while waiting without having IO
pending. So I do think the suggested patch is probably worthwhile
pursuing. I'll post it and hopefully have Andres test it too, if he's
available.

-- 
Jens Axboe

