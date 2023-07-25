Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF567623B9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjGYUlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGYUls (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 16:41:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345032689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:41:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b78bf0423so235104a12.0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690317690; x=1690922490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xd197zsSg9byA+gtYY75PYv4PIpS4ScWUJr+SOEaPEM=;
        b=xl4dH5CGqhoV5/HN8hK6N+4etLpucHHq4G9VlaeKK8uvjul5Z/3LuFG1OD/Rfcz+sO
         uHf7afQUl1Tthg+k5cPu2YgUFebiZVCO/DxxnveJFa9AHFPfSAYF1fLM4PYI54/0GGo5
         VUE9hE7iKU16JNnoaNraeXZ6GOYSyXiM7GLdfKPn7ZCGF9KD9mVTh7iQpEM4VgnKqE7p
         vVNIw8+J0GHerrl222WKkLQ/mnZf3Gr4izxT5xb1ceNHdVnKrjfY8QFTv6Rbgf0fBaSU
         82taJJKewtqC6i9PxeYYzylgs6QAkLzJs01A+lKDtBTZxnx79bPI2jMSSwx/7kfcXKlS
         30/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317690; x=1690922490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd197zsSg9byA+gtYY75PYv4PIpS4ScWUJr+SOEaPEM=;
        b=lq5vbcDx6MwPkK+FjxS9a2WrQ5wlthTKiuxfpVU5CTnsjwpt5hFw7ZnIU8Nqm0mgWd
         oqaMH9C9UTWLHyHjpWVIWmRjt4LmFzHmRALCDPCgf4vl2F31okXCjjXyCUBUV9Twb7og
         oKyEqD0F7LK64DJ0o94OB1elwPUZXZJQkRYZpvF92UW3xwYQMfkRxbnf/inqx6nZbK42
         0EgRqhS4tXtfRfQs9zQhtGN8G55+X7rGsx5hf3ecBg6igL/NddqzIUharHGzbRLX8bMw
         hFpyQ7fsoK3gPwD0JoxwHApl0mb7MuEpzNFHycXOKboO0/I3QgYC5C1qI8l1KwlUszon
         tsNg==
X-Gm-Message-State: ABy/qLb8VujibXbVOKRDG4bnA3EBdmgpX4rxhI44xBlsAL7lH3ClmwNq
        oXuesGCz/mT+9Bp/CLsjPJ2g/g==
X-Google-Smtp-Source: APBJJlGPbdn55TJ/ACLjAXMuc5kiyNCY/o3ex3y0A9z/PF+QuLC9SNBb24UIyrxP9luq09vyJ55JlQ==
X-Received: by 2002:a17:902:e84f:b0:1b8:50a9:6874 with SMTP id t15-20020a170902e84f00b001b850a96874mr279130plg.5.1690317690440;
        Tue, 25 Jul 2023 13:41:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902700a00b001bbb598b8bbsm2796408plk.41.2023.07.25.13.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:41:29 -0700 (PDT)
Message-ID: <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
Date:   Tue, 25 Jul 2023 14:41:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] file: always lock position
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/25/23 12:30?PM, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 15:57, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/24/23 4:25?PM, Linus Torvalds wrote:
>>> This sentence still worries me.
>>>
>>> Those fixed files had better have their own refcounts from being
>>> fixed. So the rules really shouldn't change in any way what-so-ever.
>>> So what exactly are you alluding to?
>>
>> They do, but they only have a single reference, which is what fixes them
>> into the io_uring file table for fixed files. With the patch from the
>> top of this thread, that should then be fine as we don't need to
>> artificially elevator the ref count more than that.
> 
> No.
> 
> The patch from the top of this thread cannot *possibly* matter for a
> io_uring fixed file.
> 
> The fdget_pos() always gets the file pointer from the file table. But
> that means that it is guaranteed to have a refcount of at least one.
> 
> If io_uring fixed file holds a reference (and not holding a reference
> would be a huge bug), that in turn means that the minimum refcount is
> now two.

Right, but what if the original app closes the file descriptor? Now you
have the io_uring file table still holding a reference to it, but it'd
just be 1. Which is enough to keep it alive, but you can still have
multiple IOs inflight against this file.

Obviously using the file position is wonky with async IO to begin with,
exactly because you can have multiple IOs in flight to it at the same
time. You can make it work by specifying ordering constraints, but that
is obviously also totally messy and not really a valid use case. Just
don't use the file position at that point.

Some libraries are limited though and want to use file positions with
async IO, and they generally get to keep both pieces if they do and
don't treat it as sync IO (or serialized, at least) at that point.

> So the code in fdget_pos() is correct, with or without the patch.
> 
> The *only* problem is when something actually violates the refcounting
> rules. Sadly, that's exactly what pidfd_getfd() does, and can
> basically make a private file pointer be non-private without
> synchronizing with the original owner of the fd.
> 
> Now, io_uring may have had its own problems, if it tried to
> re-implement some io_uring-specific version of fdget_pos() for the
> fixed file case, and thought that it could use the file_count() == 1
> trick when it *wasn't* also a file table entry.
>
> But that would be an independent bug from copy-and-pasting code
> without taking the surrounding rules into account.

We never made any assumptions on the file_count() for the file, exactly
because the count of it means nothing to io_uring in terms of whether we
can have concurrent IO to it or not.

-- 
Jens Axboe

