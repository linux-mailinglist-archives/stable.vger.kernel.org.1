Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4DC7043E9
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjEPDVk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPDVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 23:21:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D33A9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:21:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so2450700b3a.0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684207297; x=1686799297;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4CR7r9P0D+uaqkaIx6fapzx2kuozxDM9DaNLSDKImc=;
        b=NfDF2HdM33dCyNp577phUzF0k8Zz9/1SugNKca6vLHVyuSLeNIOnrFfS5RZwmAFv/1
         UmrfPZ88TaNxXCihhq1oqe1K+GJz9lACCxl4IleUcTcNyFoCoOnItZ7HAV9NazWcM7ZV
         4lD8kseGGvtcGozm4NO/ZyJ6LotIrxsg6numCRwgxUOH0DMTyxQsnL7rDGWCItwXp4i4
         9XmmfysKfwfb42qQuiSUVpv6pdSbv9NNiVWZmjsyJJlevKR2xTZ6/QIqbI5T9PrQRZSo
         QzuubPR8VuecZAi2cBL6x8dufti6dOfuXWLFkaOuP/87L9euDWEGdThC9lRBN3Twq6Pg
         cIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684207297; x=1686799297;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4CR7r9P0D+uaqkaIx6fapzx2kuozxDM9DaNLSDKImc=;
        b=YdyPmWFvVk2eWGm67Gv1u9FzBa0JU0ERgzunWVxMxD2vesacl6IPGUbzEzeoofOg8R
         onaX6r40K9A7XuYULsRkcnAQkCb/XINtE6NhF5iuipasKp0tLt3If2OVJ63bt5Wyd+1U
         hKyZDXA2B93pm35F+LZ+QghIPAcH4wrkd1sZRauYMZ6Wi+dU0lurT0sv+8CAA/ZQP1yv
         33i8m2zbyhsc5OgLoL3P6nFCx9EC4fTkPZw8/dv3cowvlB+QkG0spYliMpa+Z3SPVr64
         M5rVR9HDlpAZUje456FDf6cStkYnTk74m7ZUmfKoI4i5W5RHAPhoow27z2NMOrp3OO4x
         eqPw==
X-Gm-Message-State: AC+VfDwX8BIzR1pRtyAUHx7HCvCvUSWB0ssssgPEZGnk+4mRY9vObanr
        EhvI1NtHB4FS6HYSDEaIHAs=
X-Google-Smtp-Source: ACHHUZ7e5tDKANNTWZtP3qzSy47X2RAGAE9iRS9Qv2Fy40LqfsmqrnIzZX0NLeji4yc5/fNiUjwmww==
X-Received: by 2002:a05:6a21:6d8e:b0:105:66d3:8572 with SMTP id wl14-20020a056a216d8e00b0010566d38572mr10305852pzb.24.1684207297497;
        Mon, 15 May 2023 20:21:37 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78d55000000b00640f01e130fsm12416325pfe.124.2023.05.15.20.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:21:36 -0700 (PDT)
Message-ID: <0b0a5c4c-fa1e-f2c4-d350-fccc3f2eb3c5@gmail.com>
Date:   Mon, 15 May 2023 20:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.4 151/282] serial: 8250: Add missing wakeup event
 reporting
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
References: <20230515161722.146344674@linuxfoundation.org>
 <20230515161726.751095012@linuxfoundation.org>
 <e6f7f148-4bbe-c3c0-6c1f-1637e9999811@gmail.com>
In-Reply-To: <e6f7f148-4bbe-c3c0-6c1f-1637e9999811@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 5/15/2023 8:11 PM, Florian Fainelli wrote:
> 
> 
> On 5/15/2023 9:28 AM, Greg Kroah-Hartman wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> [ Upstream commit 0ba9e3a13c6adfa99e32b2576d20820ab10ad48a ]
>>
>> An 8250 UART configured as a wake-up source would not have reported
>> itself through sysfs as being the source of wake-up, correct that.
>>
>> Fixes: b3b708fa2780 ("wake up from a serial port")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Link: 
>> https://lore.kernel.org/r/20230414170241.2016255-1-f.fainelli@gmail.com
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c 
>> b/drivers/tty/serial/8250/8250_port.c
>> index 907130244e1f5..3d369481d4db1 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/moduleparam.h>
>>   #include <linux/ioport.h>
>>   #include <linux/init.h>
>> +#include <linux/irq.h>
>>   #include <linux/console.h>
>>   #include <linux/sysrq.h>
>>   #include <linux/delay.h>
>> @@ -1840,6 +1841,7 @@ int serial8250_handle_irq(struct uart_port 
>> *port, unsigned int iir)
>>       unsigned char status;
>>       unsigned long flags;
>>       struct uart_8250_port *up = up_to_u8250p(port);
>> +    struct tty_port *tport = &port->state->port;
> 
> Looks like we need to drop this second declaration since we have the 
> same one a few lines above. It did not show in the patch context, but it 
> is there and it will cause:
> 
> drivers/tty/serial/8250/8250_port.c: In function 'serial8250_handle_irq':
> drivers/tty/serial/8250/8250_port.c:1845:19: error: redefinition of 'tport'
>    struct tty_port *tport = &port->state->port;
>                     ^~~~~
> drivers/tty/serial/8250/8250_port.c:1841:19: note: previous definition 
> of 'tport' was here
>    struct tty_port *tport = &port->state->port;

Sorry this was a result of a bad merge on my side as I had already 
applied the patch locally, this is fine!
-- 
Florian
