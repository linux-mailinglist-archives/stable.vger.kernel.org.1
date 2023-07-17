Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD60756E05
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGQUNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjGQUNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 16:13:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87021B3
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 13:13:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3463955e8c6so3080805ab.1
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689624829; x=1692216829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxWgsutT0vq4cDWY7Aj+M0AV8lYDyxPGz6T9PsKjSXQ=;
        b=MCbO16nbQiTJTISPvXr2Wuurr4XeXKV7rsht0E/TOO/1pQTctwM63LU9Vj22yIVyIU
         trydvVfDuVAkxfGwTsjcITcOlvK1KMSD1nJYth7QcWfZJGTTOf5YRF6Ru5DynZKwoSgK
         gDODqo0/SYXSVwRKyEocSOTN2ow5IxOmHIdy3gbQrArX8JqMmLcXotPF6xm0iL/N7hBJ
         VihfJlpT+izf7wyc3SRS1AdfINBRSdcHIkrEhL6DAwiQ134KuLX8OmhqRmurzDPyVqjq
         KnqoDl9JcYa+ICaKffKq/ipaLUxk9bcZX34Nq8mmidqyDAQhX40aj9r62XO2FAzbvL2n
         RRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624829; x=1692216829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxWgsutT0vq4cDWY7Aj+M0AV8lYDyxPGz6T9PsKjSXQ=;
        b=Oy8DxLLqwKXMwi7ZCxMbM3efrU2I4qautjhiSeH28f7ZgVVNUdmnQiTuIsF14TUkVm
         1SCVzDE2FA1eorBytA+5Jz7bqv7Og0yN0q+0enRBdnMGOcD2qiMbh+V3nM3ydZBI+vKD
         +Avp8DMrLewhwyzQiFtUmL1sYhOL/qZne9loZW10e2Xv+Y3oZQ4GZYL84RBVH/4V0uhh
         8dNYXOQNy6q/23dzYVJquK21Q17Cc2ElbBASc5diUVk/+52r1aSCMI+EALw+MG+3VvZv
         wmIYO1TEG0v4NVQe5I94CE57OGJzu+SZE+2nxekiCMXc6bg+VJD4o9gPwVqdVopf9hva
         yyAQ==
X-Gm-Message-State: ABy/qLa8PbJDH/td2K7YtI0pXD7mdVFyTxvfsaow221k0SJD/AB6V+yu
        4a2xaS22DiAQVzSMH5SBeA09tA==
X-Google-Smtp-Source: APBJJlGyU2k6HBW08yAGima7C22TgCzyYbJnT3s2Ue1GLMTjD9ca8FROSOZLrmDdvWCvOQMekjGwwg==
X-Received: by 2002:a6b:8d16:0:b0:787:1926:54ed with SMTP id p22-20020a6b8d16000000b00787192654edmr551911iod.1.1689624828956;
        Mon, 17 Jul 2023 13:13:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c050000000b0042b5423f021sm62521jam.54.2023.07.17.13.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:13:47 -0700 (PDT)
Message-ID: <f1be5d4e-fba6-8d34-69c0-fcac601ba098@kernel.dk>
Date:   Mon, 17 Jul 2023 14:13:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 6.1-stable tree
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andres@anarazel.de, asml.silence@gmail.com, stable@vger.kernel.org
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
 <2023071722-quirk-uncouple-9542@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023071722-quirk-uncouple-9542@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/17/23 2:12?PM, Greg KH wrote:
> On Mon, Jul 17, 2023 at 10:39:51AM -0600, Jens Axboe wrote:
>> On 7/16/23 12:13?PM, Jens Axboe wrote:
>>> On 7/16/23 2:41?AM, gregkh@linuxfoundation.org wrote:
>>>>
>>>> The patch below does not apply to the 6.1-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>>
>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
>>>> # <resolve conflicts, build, test, etc.>
>>>> git commit -s
>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071620-litigate-debunk-939a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>>>
>>> Here's one for 6.1-stable.
>>
>> And here's a corrected one for 6.1.
> 
> All now queued up, thanks.

Great, thanks Greg!

-- 
Jens Axboe

