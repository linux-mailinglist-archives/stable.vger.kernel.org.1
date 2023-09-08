Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD0798269
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjIHGeK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjIHGeK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 02:34:10 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E319AE
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 23:34:06 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4018af1038cso18456375e9.0
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 23:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154845; x=1694759645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ATHOBy3VUOK0ymvL9cdRrxqeOvpmpKkjY6GO8sO8C8=;
        b=IRzNmth2qdcJjzHXTA0Sl1g8ahOkgF4Je23072pOFWmztcSnI0pAil02l7cvEcvvSM
         mpJT5tC/b30KEYp6SXFFP/zzMN1jV4m8s6tbydOCkWHXBK6tdbJ1X07v4wSyPdAZWeGQ
         o793UagSy0Zsr+TM9llJlU5ncV87l1+Z51XgPk63bugaEjsRgXALU1D1Cz5RtJv7Pbt1
         uCoab5YAPHEZito6t4eNUwi9gzkeZuMTlOomGZP1dhL/o7vNRgppgHyt+mF3IrvV4L+M
         3akeaLCwSOleyVpNLuVMJo95yYBqU8ibtd/12yE6/AoJQ95WZwa6e1GFf9KcuRz1gOor
         Bidw==
X-Gm-Message-State: AOJu0YyasD1Lc1yvRW5SXFK6rPH4frs5ssig/I2UWY2yKh25CsBWj8k2
        InDgcND5QKQPQ1uzU5VQnH4=
X-Google-Smtp-Source: AGHT+IGbDvg9mgF5nPHbyPNmL1QvS0OTFzQpIxyaQn8wJLGgWvy6QsDUAglk3s16qpT9V2Qs9JT/8g==
X-Received: by 2002:a5d:58c8:0:b0:319:6327:6adb with SMTP id o8-20020a5d58c8000000b0031963276adbmr1124927wrf.70.1694154844533;
        Thu, 07 Sep 2023 23:34:04 -0700 (PDT)
Received: from [192.168.70.5] ([94.204.198.68])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c7508000000b003fe29dc0ff2sm1122049wmc.21.2023.09.07.23.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 23:34:04 -0700 (PDT)
Message-ID: <1070130b-9373-d22f-a0e2-02ba90b0e41f@linux.com>
Date:   Fri, 8 Sep 2023 10:34:01 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Reply-To: efremov@linux.com
Subject: Re: [PATCH] Input: cyttsp4_core - change del_timer_sync() to
 timer_shutdown_sync()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20230908014144.61151-1-efremov@linux.com>
 <2023090835-playroom-plastic-494c@gregkh>
Content-Language: en-US, ru-RU
From:   "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <2023090835-playroom-plastic-494c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/8/23 10:15, Greg KH wrote:
> On Fri, Sep 08, 2023 at 05:41:35AM +0400, Denis Efremov (Oracle) wrote:
>> From: Duoming Zhou <duoming@zju.edu.cn>
>>
>> The watchdog_timer can schedule tx_timeout_task and watchdog_work
>> can also arm watchdog_timer. The process is shown below:
>>
>> ----------- timer schedules work ------------
>> cyttsp4_watchdog_timer() //timer handler
>>   schedule_work(&cd->watchdog_work)
>>
>> ----------- work arms timer ------------
>> cyttsp4_watchdog_work() //workqueue callback function
>>   cyttsp4_start_wd_timer()
>>     mod_timer(&cd->watchdog_timer, ...)
>>
>> Although del_timer_sync() and cancel_work_sync() are called in
>> cyttsp4_remove(), the timer and workqueue could still be rearmed.
>> As a result, the possible use after free bugs could happen. The
>> process is shown below:
>>
>>   (cleanup routine)           |  (timer and workqueue routine)
>> cyttsp4_remove()              | cyttsp4_watchdog_timer() //timer
>>   cyttsp4_stop_wd_timer()     |   schedule_work()
>>     del_timer_sync()          |
>>                               | cyttsp4_watchdog_work() //worker
>>                               |   cyttsp4_start_wd_timer()
>>                               |     mod_timer()
>>     cancel_work_sync()        |
>>                               | cyttsp4_watchdog_timer() //timer
>>                               |   schedule_work()
>>     del_timer_sync()          |
>>   kfree(cd) //FREE            |
>>                               | cyttsp4_watchdog_work() // reschedule!
>>                               |   cd-> //USE
>>
>> This patch changes del_timer_sync() to timer_shutdown_sync(),
>> which could prevent rearming of the timer from the workqueue.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: CVE-2023-4134
> 
> "CVE" is not a valid Fixes tag :(
> 
>> Fixes: 17fb1563d69b ("Input: cyttsp4 - add core driver for Cypress TMA4XX touchscreen devices")
>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>> Link: https://lore.kernel.org/r/20230421082919.8471-1-duoming@zju.edu.cn
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
>> ---
>>
>> I've only added Cc: stable and Fixes tag.
> 

Please, don't take this patch. It breaks the build. Sorry, I forgot to check it this time.
I'll resend a correct backport with the upstream commit info.

Best Regards,
Denis


