Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDF75FEF6
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGXSWM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGXSWL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 14:22:11 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7F10DE
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:22:09 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3463955e8c6so2933485ab.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690222928; x=1690827728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlGqwdb6bAoylkqLXqRNncq4LrSVbEkxLHu0eBS0UCo=;
        b=SbDqTYDYrGfwh+e6v+ZS5/BSB8MarGS6nvaJI+QlbYAw4Qhj0G4GRSrfEA51SabuqI
         4qyzgUnfiTSx5pVPmcKrI6NZQla58YVwtZYp5dBlDehg8aQbe92/u2zNzzHTrAiemJn7
         C0yWsFFzvZ8MWmAA/QgDuKf7th0nR81ICYUISmqDm4Yd3KwwfF1vIKIi3VLPvLZ627y7
         dag0yJM6fnek3ENIuSi9GTCkiTDdsLEBbpGc/ARu0IsY5PtBGK3QvEV26kxN5lm5BGIL
         BcgDZh3T5AH/3uCsGeROBYGnSzWDnV8WvZPq0z1u/gwLdBwhTA3CYtguTHCiJomGOcHH
         MZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690222928; x=1690827728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlGqwdb6bAoylkqLXqRNncq4LrSVbEkxLHu0eBS0UCo=;
        b=PZejkV0Bend8p+Lum2mAwIw/qcVOqMHfsD8GhqrlbZMbRoW589Y0NB9WLBwyUksR3y
         SOLhZeUUoxZeUyF+ZpXpeZ0/jldcpoSH1J1wy6q4buh394EPn60kwxtIAd+Q3FXNGhb4
         ER8U7hfPdJzIMJ77zfs/dxaoSWfdxhvI3uNZyKx0GkDDhfeghaZEUTxNgDUi9cNl/HOB
         mqvkQAFwNv9NbSQOL8WNl4P1L132dqEBNeSMCF/a/siwXKx5xtntT5JIERWztRoxSCF4
         vMytUr93+bAA482ozffFIJQTJwxngpNPJxtvqDwO92DwcMzcsan+ukCnb/Pcj2fkhHRc
         wkLg==
X-Gm-Message-State: ABy/qLaYimnTJ+53XhXnhW6e59+Oa8gTj3LvZNidOtn/j7mguxvIkpyo
        ujron/XnhYEzmauTc+SONMYH9A==
X-Google-Smtp-Source: APBJJlGOaq3eY9t8T7Eh1q/nPBtpvZXB+aZaoDKkzrXd7wpYNzUQxjZqSuSQRfhk2xfUsDEgn7j0cw==
X-Received: by 2002:a05:6602:3e87:b0:780:cb36:6f24 with SMTP id el7-20020a0566023e8700b00780cb366f24mr8633262iob.2.1690222928696;
        Mon, 24 Jul 2023 11:22:08 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c20-20020a5d9754000000b00760e7a343c1sm3521048ioo.30.2023.07.24.11.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:22:08 -0700 (PDT)
Message-ID: <fb2e6c9d-028c-3ed8-1068-0e654bdb63a4@kernel.dk>
Date:   Mon, 24 Jul 2023 12:22:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
Content-Language: en-US
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andres@anarazel.de,
        asml.silence@gmail.com, david@fromorbit.com, hch@lst.de,
        io-uring@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, stable <stable@vger.kernel.org>
References: <CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com>
 <2023072438-aftermath-fracture-3dff@gregkh>
 <140065e3-0368-0b5d-8a0d-afe49b741ad2@kernel.dk>
 <ecb821a2-e90a-fec1-d2ca-b355c16b7515@kernel.dk>
 <CAMEGJJ3SjWdJFwzB+sz79ojWqAAMULa2CFAas0tv+JJLJMwoGQ@mail.gmail.com>
 <0ae07b66-956a-bb62-e4e8-85fa5f72362f@kernel.dk>
 <CAMEGJJ0oNGBg=9jRogsstcYCBUVnDGpuijwXVZZQEJr=2awaqA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAMEGJJ0oNGBg=9jRogsstcYCBUVnDGpuijwXVZZQEJr=2awaqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/24/23 10:48 AM, Phil Elwell wrote:
> Hi Jens,
> 
> On Mon, 24 Jul 2023 at 17:08, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/24/23 10:07?AM, Phil Elwell wrote:
>>>> Even though I don't think this is an actual problem, it is a bit
>>>> confusing that you get 100% iowait while waiting without having IO
>>>> pending. So I do think the suggested patch is probably worthwhile
>>>> pursuing. I'll post it and hopefully have Andres test it too, if he's
>>>> available.
>>>
>>> If you CC me I'll happily test it for you.
>>
>> Here it is.
> 
> < snip >
> 
> Thanks, that works for me on top of 6.5-rc3. Going to 6.1 is a
> non-trivial (for me) back-port - the switch from "ret = 0" in 6.5 to
> "ret = 1" in 6.1 is surprising.

Great, thanks for testing. I'll take care of the stable backports
once the patch lands in upstream -git later this week.

-- 
Jens Axboe


