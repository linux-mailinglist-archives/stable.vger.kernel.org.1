Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673B770C1E
	for <lists+stable@lfdr.de>; Sat,  5 Aug 2023 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHDWuD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDWuB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 18:50:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B861BE
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 15:50:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so42958191fa.2
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691189399; x=1691794199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oufc1x89nwlrXRNKkHYYKDDdEzz4I9gpw2oNWdbuYSU=;
        b=WESz/UJcbkuC1/4tkTKKEXzXCsXzaK8bRDz8bYGONYVqkWQPmZCg3lbSQOXRxx7psd
         zmFCAmf4v7R+HOLobeRCONgy9ZJBtiauCjZiopL3HJDeWzDBxpmvWgNRq7AoX1bZKzzJ
         sWv/j/axjRsP7+oM72qqm8A7Qlt+MfZrKtJTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691189399; x=1691794199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oufc1x89nwlrXRNKkHYYKDDdEzz4I9gpw2oNWdbuYSU=;
        b=YIGceHgJIG1CIGziphrCuEAJIKuOmLWxkCwCBcY67tiZ+mMhUQ3UPv66nyj9Cbnb1L
         As6MODsOZv0X0ZF2ivzxCoiBxC2EoX5wTPrbW230ZoIZTe42H3pXVkdVs0kmfTFFEg14
         ZByXElkAQUqYnMSGPM/zXNTVNOSQi5NDQf9SAna0d4ozLWM7VdvMbnvtOHBLVOVKZElL
         FvmUkiO6My09mwIDnlooJrW0Uhwxx7Rf9EKbElOhv/asBRigQPIwDj0Q2VAFmHbxqu/l
         z11CWJb9w/lcFcyExfKPKGFO7qTH0cCoRZQlTZKR+fsyO0nilO0jGg2ZkkqYIf+2j39h
         HlWQ==
X-Gm-Message-State: AOJu0YwrbOnaPLP67bMy0AVUjkjI89oQBL+Yv3oOxrkZpaekcmxayEQF
        rYvIXOiIWg67V9sR9/cyQZFCEJCqvO3U6Ib4KVov+Q==
X-Google-Smtp-Source: AGHT+IEmIxdPwrhPTchlC+XZAsUnkmrQChWp6suxfexqLpE8VkHw/4Ff36GRmP9pILoS8VrK0UFT6g==
X-Received: by 2002:a2e:9f08:0:b0:2b8:67ce:4ad7 with SMTP id u8-20020a2e9f08000000b002b867ce4ad7mr2332208ljk.6.1691189398723;
        Fri, 04 Aug 2023 15:49:58 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id re15-20020a170906d8cf00b009886aaeb722sm1886177ejb.137.2023.08.04.15.49.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 15:49:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so3365818a12.0
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 15:49:57 -0700 (PDT)
X-Received: by 2002:a05:6402:514:b0:521:d75d:ef69 with SMTP id
 m20-20020a056402051400b00521d75def69mr2790287edv.31.1691189397521; Fri, 04
 Aug 2023 15:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f>
In-Reply-To: <20230804214620.btgwhsszsd7rh6nf@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Aug 2023 15:49:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
Message-ID: <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 4 Aug 2023 at 14:46, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't see it mentioned in the discussion, so at a risk of ruffling
> feathers or looking really bad I'm going to ask: is the locking of any
> use if the forking process is single-threaded? T

Sadly, we've always been able to access the mm from other processes,
so the locking is - I think - unavoidable.

And some of those "access from other processes" aren't even uncommon
or special. It's things like "ps" etc, that do it just to see the
process name and arguments.

            Linus
