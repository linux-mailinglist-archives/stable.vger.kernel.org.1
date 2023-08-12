Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC1B77A323
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 23:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHLVwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHLVwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 17:52:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F91706
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 14:52:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-265c94064b8so456735a91.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691877156; x=1692481956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbQ5BLlwEqyBk3vbhBlzOEbp0419jpD++3voZZ5I4Xc=;
        b=ZuZBflRMH7GulbZmmKLTokfPh9+T6dEvWSxsj89a2B4o9LXyETdmbUHMI216zJr1xo
         3jUaYQOwYdwM7OF+DJCQVfwkMvGNkRuplOjaJma8fTkCh8C4jIbA57k3BLnU8xSmryK6
         uGKw6jYBVgkqWkpo53L2+QU86zdlLwfgA+bb5NTgyMbHWRIaUQHFpiF8r00Y7X/JVJYf
         2TVC5FfzBnb1gGQHfSwbawCn+3lGdf8Nr5gtgF7WV+ekWplw9d/1BH7cE3lHte78ZuWK
         AVRtGsl5oLF9LCijydB7w7tuY29q/mH+wYIW1N6C1mpzxh5twiWd0mA4lLvWSGIvfyiL
         6kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691877156; x=1692481956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbQ5BLlwEqyBk3vbhBlzOEbp0419jpD++3voZZ5I4Xc=;
        b=atbAqgnpJPvKVgo/1JTQTZ3wkZJUnpEHUNYcD8YZJUI4rHc/y7FXlSp20azcD4iVI/
         kc6g9R+9qhpXUYL/J+1ZabaEPnHECwm01PXRizLyEB4dcc/2cuJ9lbV4MiwVJ3vg8yUA
         f9mRnNwq7KDCrHyk1e1ukD5tiKXdvkcXxM9aupx9d35tuLpFh/aTmcRWh9B1UJ1LPQ4l
         uCjUdrNnHwVucW2cOMhrpxPctLf5ZUgklCtYdPMMqE7wnu15FMXqhEkMOtzyTrh5Louy
         AMNdBFPlk3K1SovRl+bu7nsjJxUO4AJgpyVD5CBr3YPRSAwU0/18QkswzbgEei6NiFSV
         Hf0Q==
X-Gm-Message-State: AOJu0YwdHmWFkuPJlhdujtU0UJ5NZ/FxgCaXFdc6RNxRroTXBsEos6Ud
        idd/l+YRi6rv3gtuGCCGG3+x1wHMLy1a2C017MU=
X-Google-Smtp-Source: AGHT+IHEsgmwtMcTy+Kz4863Kp2t7b5zGZSK/y9FKmAp6fbY3uD4ec7Nl+SbAgtyBSdjBObVHCoH6Q==
X-Received: by 2002:a05:6a00:1ca9:b0:668:834d:4bd with SMTP id y41-20020a056a001ca900b00668834d04bdmr5754985pfw.0.1691877156052;
        Sat, 12 Aug 2023 14:52:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b00686940bfb77sm5320306pfm.71.2023.08.12.14.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 14:52:34 -0700 (PDT)
Message-ID: <c1b115bd-298c-4319-9018-aef17b03b34f@kernel.dk>
Date:   Sat, 12 Aug 2023 15:52:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE"
 failed to apply to 5.15-stable tree
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cyphar@cyphar.com, stable@vger.kernel.org
References: <2023081258-sturdy-retying-2572@gregkh>
 <ec4f5e8f-d1db-4278-a144-ddedca0ae5ca@kernel.dk>
 <b2efb91d-6b4b-40fa-bbc9-9511d0a70f27@kernel.dk>
 <2023081246-pledge-record-7c35@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023081246-pledge-record-7c35@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/12/23 10:28 AM, Greg KH wrote:
> On Sat, Aug 12, 2023 at 07:33:03AM -0600, Jens Axboe wrote:
>> On 8/12/23 7:20 AM, Jens Axboe wrote:
>>> On 8/12/23 12:02 AM, gregkh@linuxfoundation.org wrote:
>>>>
>>>> The patch below does not apply to the 5.15-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>>
>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
>>>> # <resolve conflicts, build, test, etc.>
>>>> git commit -s
>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081258-sturdy-retying-2572@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>>
>>> Here's one for 5.15-stable.
>>
>> Oh, and the 5.15-stable one also applies to 5.10-stable. 5.10-stable
>> needs it as well, would be great if you could queue it up there as well.
> 
> All now queued up, thanks!

Perfect, thanks Greg!

-- 
Jens Axboe

