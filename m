Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE277A023
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHLNdC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 09:33:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9E12E
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:33:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f74a8992so498642b3a.1
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691847185; x=1692451985;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqE+9aoV6V4VjgtXicZgHd0mMFp8p7wyc3JsRe8n/sQ=;
        b=kLlAbJY3bzYioQasGongi9BeveAQgHcKKC7pYQ6rrswMW4GEW3gTS9c86EPZnrqYoq
         7jUEyxbQ2frRn8TJokisuC7DgeUXX5j8G8U/2Ptw9b6xdQx4rD2/aJ3/faEkcvtwcZ4v
         rFNQ5RaPBUDYc5TUpxEslcGWCHXzFgWjnX1GUtsjka8tTgsIwh/cTLliLZlyVzIBr5eC
         kdsMb6EmWTu/CVI3Dm8NmC46NDqlhrmOqq/2jLvmnXvom9OyGSYaCGnLMWm6SjYHuCGF
         SHRr8F6gm3qo1Bh5iFRXwiWlLk3WrUPDHSC/uMQjdcA2z9F2MWRca3gaEr0Aj4nQtOjo
         t2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691847185; x=1692451985;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqE+9aoV6V4VjgtXicZgHd0mMFp8p7wyc3JsRe8n/sQ=;
        b=TM/RCwJOseCbTbZv78oSZw2HwKiWbkoRNKawHU/gRUYbma6k+rQEatA2VTSpeBVw67
         g5Jz5SaTYIk0Jvu5DbZmf62Rzmg5qGUapSUAtDCkoBxvZu8/RYVwBbJHQeZ3xnUs8dF8
         0b9HvGA/HfB01I+1mV9+6yeQgxLTFqe5XH8jqro4QU5MX7P6Yi75EBCDi+Zn8hiLGy8Y
         9ZggI5wZ+bjCEvVORq3b8dkhnyoJ4FXJktymZgD+yplsWUYpADgErXvFaVKJGw4IArEJ
         MXSZ6FepNNMYs1VSRvIoOiQpYey8i5Wg4uljV6nNdz6ASih2wnQCRozIT/rXH7aMKcJj
         x/Nw==
X-Gm-Message-State: AOJu0YzGsSoz9J4n/Kc3w9p99+RVi3TPD5RUO6ZM2vvZ9kgmI7zLvVXN
        y3qifqCC3TM/cFjTuvpAFEX0lIuZk1q9+7bzE04=
X-Google-Smtp-Source: AGHT+IEh+1MPP5hHFuUIRz7ayWznvhKdJk0TFVjgvxAWeW3FEJkbLl8wOmg4gyvsF/7waZ+Fe0+7SQ==
X-Received: by 2002:a17:902:db03:b0:1b8:ac61:ffcd with SMTP id m3-20020a170902db0300b001b8ac61ffcdmr5770743plx.3.1691847184826;
        Sat, 12 Aug 2023 06:33:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b9de39905asm5803360plg.59.2023.08.12.06.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 06:33:04 -0700 (PDT)
Message-ID: <b2efb91d-6b4b-40fa-bbc9-9511d0a70f27@kernel.dk>
Date:   Sat, 12 Aug 2023 07:33:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE"
 failed to apply to 5.15-stable tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     gregkh@linuxfoundation.org, cyphar@cyphar.com
Cc:     stable@vger.kernel.org
References: <2023081258-sturdy-retying-2572@gregkh>
 <ec4f5e8f-d1db-4278-a144-ddedca0ae5ca@kernel.dk>
In-Reply-To: <ec4f5e8f-d1db-4278-a144-ddedca0ae5ca@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/12/23 7:20 AM, Jens Axboe wrote:
> On 8/12/23 12:02 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 5.15-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081258-sturdy-retying-2572@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's one for 5.15-stable.

Oh, and the 5.15-stable one also applies to 5.10-stable. 5.10-stable
needs it as well, would be great if you could queue it up there as well.
Thanks!

-- 
Jens Axboe

