Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C00749108
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGEWiv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 18:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGEWiu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 18:38:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071B19A1
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 15:38:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7e0904a3aso9220915ad.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688596719; x=1691188719;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbFeP74uNwYS9C8He02R7fVdGtkt29IL2kE5/0PKLtM=;
        b=JEQ2uimAlY7C1uSeX8NWLxS4ceLh2dHCo2uqPDa0aiC59sIG5Y94rlcR1Ujue9VNw+
         9EEwkW/RtPrYQPBMWdAzmzDBoHOfjZpwvOgO89XB+ICFoNqSP+wxJj042vaLpymfDtnt
         7KXpphb2Bt7Ccy7wPioUQk79K5oclP+QSnpm/AOvthGHHxq49aMmMdU8h/rt64gVaCoP
         zVY+Fr/tuqPoVP0kNWQ33n0Q2nUg9yQYcY0f2kA/TX8gFrk/bFURzI0rQflgdB0Ugi2i
         TE7WFIgdR/N6rmrNc5ZqqNRM59rJdZadx4+Ws3uOgtbiRr7tAHeBXgEN/IAY2xUVrDLx
         Xt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596719; x=1691188719;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbFeP74uNwYS9C8He02R7fVdGtkt29IL2kE5/0PKLtM=;
        b=SCLF40G2nGsB+ufC2HNp/grvt7Vwp3GaSqSX9kT5vhpBv7pXrqhUGyHmkNTR1PDpOM
         qd7552ABkg92u766fjd45y03hWmHHkRkVx4U1GqQQmJwfry9Qo9TATri8i/YFA8QaCo9
         Eoi+f3e8qyn5w+DXGMThfdNtAn1JVNw2K88rviZl/SPgF5wP/mCzVzs+ZLAgDybjotAq
         WPxIx9YaPlgg+/mddhaAf4gf7osGDW0yBDYsOtBmbKCKZunM8MbMpCVe1gvLUn+IizYQ
         NDANWeR9dPRSI6PUq9DQnZhCJ1HwvHFp1+pea48dccUJMTXLiypyhyQi8e0HYxoyKJcG
         2snw==
X-Gm-Message-State: ABy/qLZlPBrvVDQeDadZlznFKro7FJ3ZDzeznqkv0H/KozDtOisVU2Je
        MshMLXsedN4i3EMPDQjyK0610g==
X-Google-Smtp-Source: APBJJlEmKFgrYjabDLXMZkLeT6DLzozaRuX0VKeBvCo579Xt2/wQV/e2Azeu2Aa3Ja+u8EzQT9qD7A==
X-Received: by 2002:a17:902:ea0a:b0:1b3:ec39:f42c with SMTP id s10-20020a170902ea0a00b001b3ec39f42cmr349371plg.5.1688596718689;
        Wed, 05 Jul 2023 15:38:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b001b80b428d4bsm4093ple.67.2023.07.05.15.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 15:38:38 -0700 (PDT)
Message-ID: <c9bcd3ca-8260-3f29-26d1-0c00e2b098a3@kernel.dk>
Date:   Wed, 5 Jul 2023 16:38:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
 <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
 <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
 <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
 <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
 <481c0e2a-320c-e53d-2a0e-ba5fa6ea4049@kernel.dk>
In-Reply-To: <481c0e2a-320c-e53d-2a0e-ba5fa6ea4049@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/5/23 4:34?PM, Jens Axboe wrote:
> On 7/5/23 4:25?PM, Michael Schmitz wrote:
>> Hi Jens,
>>
>> On 6/07/23 10:13, Jens Axboe wrote:
>>>>> should be enough for it to go into stable from 5.2 and onwards.
>>>> OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>>>>>> (Greg didn't seem to object to the Fixes: as such, just to the
>>>>>> incorrect version prereq)
>>>>> I think it's really confusing... A patch should only have a Fixes tag if
>>>>> it's fixing a specific bug in that patch. Either it is, in which case
>>>>> you would not need Cc stable at all since it's only in 6.5-rc, or it
>>>> It is fixing a bug in b6f3f28f60. I should have checked whether the
>>>> patch series had already gone to release, not just -rc, instead of
>>>> just adding the stable tag out of caution.
>>> But this is the confusion - if it's fixing a bug in b6f3f28f60, then why
>>> is it marked as needing to get backported much further back, predating
>>> that commit?
>>
>> I see - it doesn't need to be backported that far back _alone_. It
>> only needs to be applied after  b6f3f28f60 once that one has been
>> backported.
> 
> OK I see - I think there's some serious misunderstandings here then :-)
> 
> It sounds like it fixes a bug in b6f3f28f60 alone, and it has no
> business going into stable. The commit should _just_ be marked with it
> fixing that. If someone were to backport that previous series, then
> their tooling or diligence should notice this dependency and this
> current commit should be picked as well.
> 
> There should be no Cc: stable on this patch at all, I'll fix it up.

Here's what I have:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=7eb1e47696aa231b1a567846bbe3a1e1befe1854

which has the following manual edits:

1) Change the title/subject line of the patch. "bugfix for Amiga
partition overflow check patch" means very little. The fact that this
patch is a bug fix for a previous commit is explicit with the Fixes
line.

2) Break lines at 72-74 chars, yours were very short.

3) Drop message-id

4) Drop cc stable tag

5) Drop the revision history. This should be behind three '---' lines
and then it's dropped automatically.

Let's hope this is it for Amiga partition handling!

-- 
Jens Axboe

