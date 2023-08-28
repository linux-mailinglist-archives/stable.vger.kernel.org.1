Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9358478A381
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 01:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjH0XgI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 19:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjH0Xfs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 19:35:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900F195
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 16:35:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so24100365e9.1
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179326; x=1693784126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5y6/ZTjfXJEZbiKUq7WiVLqlVma4fac9mBsqpVtToc=;
        b=Y+xN6CskKFlhmnznfmJANIYNZI/rBGg0IytL+b7I6Prqr2/PZa9zDAeilCxz5UEzhC
         uKpkDYhdrtEzqLfGSZevY+E2VbxaQ3wraLYdFmGP7peBfJYA6jRXniMSUheCvixmXF4m
         XwKUtu6Nm4PxjGHpu03M2e5C+ZO+30RwBDmnVJPBrQLz+Z9jj2jEhlmuIdQ6QhiXBGvh
         Z2tnwLaYO1SupFQGAqQLgieByrPF9QyKHtG9zkv+UwwX0TNwYDmZTpc8PiLqRhisVkew
         e729/B2D9V/fUPjsEcZUNFqJ49LI6svji101PpBPMv7ytDmxQZhBOEcADJmjZLP/Bd8w
         lgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179326; x=1693784126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5y6/ZTjfXJEZbiKUq7WiVLqlVma4fac9mBsqpVtToc=;
        b=aXXOkKTtatvpjBZWMNLSjHU1f60pUlbjOuiJPBmGsHT1i9UZZUyeStIGtZUtaAeyY3
         sxPRF93LbATmqgtLq6JQ2CIyrdi9RKj8EIb4OkwPOAujTw4z93ofjDqwcCjJcEbvr+om
         vgUp+m87m9pbDWLiDzRWkMI6L4oiuJuzKrRsNke2EE1g07uSw9hQj7wTCtkcC9xk6Gie
         1riUOOYhI8419zB9uRe833cpo2ndFIVOOBm6DQawxN6MQuqeOXH0CaQuaZMxNyttvRPN
         NQ75epT+k0OVXw/N5dSI8rjR7TkMnS1slNuNrJX0pfQU/+IRAaMvajGO45UcPX4Omtl5
         4Hsg==
X-Gm-Message-State: AOJu0YzulwphVKZE5zxtSxyG5EHvY58ubhru1npuOVsZ28qNK3wOYdsv
        LPZgbl9Nby1IxKT3xiXKw1bYkg==
X-Google-Smtp-Source: AGHT+IGx8pXa4uGgS+za3PgW3mU2GQ0Sq4+vpbherXwwFbaV+ELmK+8aQ44JoxJym3E9cwbahi0oBA==
X-Received: by 2002:a1c:7510:0:b0:3fb:c9f4:150e with SMTP id o16-20020a1c7510000000b003fbc9f4150emr19786178wmc.14.1693179326021;
        Sun, 27 Aug 2023 16:35:26 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003fefca26c72sm9061716wmm.23.2023.08.27.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:35:25 -0700 (PDT)
Date:   Mon, 28 Aug 2023 00:35:24 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 6.4.y
Message-ID: <20230827233524.7anzxffj4v7srxzd@airbuntu>
References: <20230821221956.698117-1-qyousef@layalina.io>
 <2023082742-dad-henna-cb35@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023082742-dad-henna-cb35@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08/27/23 10:34, Greg KH wrote:
> On Mon, Aug 21, 2023 at 11:19:50PM +0100, Qais Yousef wrote:
> > This is a backport of the series that fixes the way deadline bandwidth
> > restoration is done which is causing noticeable delay on resume path. It also
> > converts the cpuset lock back into a mutex which some users on Android too.
> > I lack the details but AFAIU the read/write semaphore was slower on high
> > contention.
> > 
> > Compile tested against some randconfig for different archs. Only boot tested on
> > x86 qemu.
> > 
> > Based on v6.4.11
> > 
> > Original series:
> > 
> > 	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/
> > 
> > Thanks!
> 
> All backports now queued up, thanks for doing this work!

And thanks for your patience!

--
Qais Yousef
