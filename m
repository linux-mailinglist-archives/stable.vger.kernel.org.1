Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB6790A64
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjICAqC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjICAqC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 20:46:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D6CDD
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 17:45:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a4dab8172so41851b3a.0
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693701958; x=1694306758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJVuJTP447998afYfIxeIIQyR21Xt30g9e9f8Gg7jLM=;
        b=gbb7uXsUKZU6ZVXWuKxTa2Ej8Wl2lSDstFwjsByqfiDw09O8i2FJCEd3m59jlUXX1K
         VKdgIgac1ggwHUFQFm+H1iy/TFRkmOOrJibBvmksqfy7EcfnTVtVgP4SHp7hGVXdKRCV
         ryKbQ5aHVkyTM9qYglQQH2rzZqCB6zFXTu6bxbf1xmU9fo6RoW7IMKLvXg2EUb7H6+IU
         yBoNgSU0VxJEDgMsPRsV61Xv2gB4HuYKIdR3s+loZn2/Zwn9tA/pE9NDZRAE+SH03jD+
         N9HziNexr8mMDIRBJL99/uLgE/X83DzhWy07dD0acLq+8WbkieNsV69sZzd9mz8BevS3
         fhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693701958; x=1694306758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJVuJTP447998afYfIxeIIQyR21Xt30g9e9f8Gg7jLM=;
        b=GSCPSkgIYirP+YT7zxMtiiQ0vL+I3acWsMtqjmYVvHOz//mzOFUgb5NycZt1PCj0Do
         QfK6Q6gNvQdh9o83eb3FFdAmqJWiYQXlrc5y+HeSom6I7cbqkhqwAxUcEjQ3RXgJVDIr
         JcbrgyMWVEO6WwiD2wu/k2/kLzu/JAFWiCplWCJ57SMRt06H6vx2uwMkuu6Ivh/EWJ3I
         zIa58L9/tymf7QyLla77GYuNXGA/x6A2NaXqt4O9/abMtrdbnOEfdS/KSHCfnrVgHbYr
         4ui9+MaSvoBdip+E0jU5wBIfJQfGJJG0ailFrKTqUI8VfSJPZThs9grJKZLU0x6f6iul
         9opQ==
X-Gm-Message-State: AOJu0YzWJwnNvjWpH+Ydi+eLgpVjivme1+7sOJhH1HW4pDKczDBnXfKv
        tY6tUdy6T9U0F7zj31ZZtYMPnw==
X-Google-Smtp-Source: AGHT+IE24i4eKlsdImeFZe/QOV5ZGjuNKqJENxu94tgyGytPmT8ZJMGSXyoj4vQjYIAf4opoR2+CKg==
X-Received: by 2002:a05:6a00:1f0e:b0:68a:5954:fda4 with SMTP id be14-20020a056a001f0e00b0068a5954fda4mr7757241pfb.1.1693701958461;
        Sat, 02 Sep 2023 17:45:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm4988779pfi.38.2023.09.02.17.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 17:45:57 -0700 (PDT)
Message-ID: <d9ed50b2-dfef-4825-be42-beac7277c447@kernel.dk>
Date:   Sat, 2 Sep 2023 18:45:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [STABLE] stable backport request for 6.1 for io_uring
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org
Cc:     Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>
References: <ZO0X64s72JpFJnRM@p100>
 <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
 <8f6006a7-1819-a2fb-e928-7f26ba7df6ec@bell.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8f6006a7-1819-a2fb-e928-7f26ba7df6ec@bell.net>
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

On 9/2/23 5:04 PM, John David Anglin wrote:
> On 2023-08-30 12:17 p.m., Jens Axboe wrote:
>> On 8/28/23 3:55 PM, Helge Deller wrote:
>>> Hello Greg, Hello Jens, Hello stable team,
>>>
>>> would you please accept some backports to v6.1-stable for io_uring()?
>>> io_uring() fails on parisc because of some missing upstream patches.
>>> Since 6.1 is currently used in debian and gentoo as main kernel we
>>> face some build errors due to the missing patches.
>> Fine with me.
> This is probably not a problem with the backport but I see this fail in liburing tests:
> 
> Running test wq-aff.t open: No such file or directory
> test sqpoll failed
> Test wq-aff.t failed with ret 1
> Running test xattr.t 0 sec [0]
> Running test statx.t 0 sec [0]
> Running test sq-full-cpp.t 0 sec [0]
> Tests failed (1): <wq-aff.t>

That's because 6.1-stable is missing:

commit ebdfefc09c6de7897962769bd3e63a2ff443ebf5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sun Aug 13 11:05:36 2023 -0600

    io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used

which went in recently and hasn't been backported to stable yet.

-- 
Jens Axboe

